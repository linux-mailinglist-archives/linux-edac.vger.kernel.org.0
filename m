Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806E974024D
	for <lists+linux-edac@lfdr.de>; Tue, 27 Jun 2023 19:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjF0Rgi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Jun 2023 13:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjF0Rgh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Jun 2023 13:36:37 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AEB296C
        for <linux-edac@vger.kernel.org>; Tue, 27 Jun 2023 10:36:35 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id D974853150; Tue, 27 Jun 2023 13:36:34 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 95122527BB;
        Tue, 27 Jun 2023 13:36:13 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id B404E220032; Tue, 27 Jun 2023 13:36:12 -0400 (EDT)
Date:   Tue, 27 Jun 2023 13:36:12 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "aris@redhat.com" <aris@redhat.com>
Subject: [PATCH v3] mce: prevent concurrent polling of MCE events
Message-ID: <20230627173612.GZ4090740@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Intel microarchitectures that support CMCI but have it disabled (BIOS,
kernel option or CMCI storm code) the kernel will resort to polling for MCEs.
In these microarchitectures the IMC registers are shared by all CPUs in the
same package and despite the fact that the polling is set up in the kernel to
prevent all CPUs to poll at the same time, it's still possible they'll overlap
and report the same MCE multiple times.

This patch fixes this by introducing synchronization during polling only for
the affected microarchitectures.

v3: add {,un}serialize_mc_bank_access() as intermediate functions as requested by Tony Luck

Signed-off-by: Aristeu Rozanski <aris@ruivo.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Aristeu Rozanski <aris@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org

---
 arch/x86/kernel/cpu/mce/core.c     |   18 ++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c    |   47 +++++++++++++++++++++++++++++++------
 arch/x86/kernel/cpu/mce/internal.h |    4 +++
 3 files changed, 62 insertions(+), 7 deletions(-)

--- linus-2.6.orig/arch/x86/kernel/cpu/mce/core.c	2023-06-26 12:37:12.972386600 -0400
+++ linus-2.6/arch/x86/kernel/cpu/mce/core.c	2023-06-27 12:10:49.763713559 -0400
@@ -1578,6 +1578,22 @@ return 0;
 }
 #endif
 
+static bool serialize_mc_bank_access(void)
+{
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return false;
+
+	return intel_cmci_poll_lock();
+}
+
+static void unserialize_mc_bank_access(bool locked)
+{
+	if (!locked || boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return;
+
+	intel_cmci_poll_unlock(locked);
+}
+
 /*
  * Periodic polling timer for "silent" machine check errors.  If the
  * poller finds an MCE, poll 2x faster.  When the poller finds no more
@@ -1618,7 +1634,9 @@ static void mce_timer_fn(struct timer_li
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
+		bool locked = serialize_mc_bank_access();
 		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		unserialize_mc_bank_access(locked);
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);
--- linus-2.6.orig/arch/x86/kernel/cpu/mce/intel.c	2023-06-26 12:37:12.972386600 -0400
+++ linus-2.6/arch/x86/kernel/cpu/mce/intel.c	2023-06-26 13:10:41.436942020 -0400
@@ -73,13 +73,8 @@ enum {
 
 static atomic_t cmci_storm_on_cpus;
 
-static int cmci_supported(int *banks)
+static bool cmci_supported_hw(void)
 {
-	u64 cap;
-
-	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
-		return 0;
-
 	/*
 	 * Vendor check is not strictly needed, but the initial
 	 * initialization is vendor keyed and this
@@ -87,10 +82,24 @@ return 0;
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
 	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
-		return 0;
+		return false;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
+		return false;
+
+	return true;
+}
+
+static int cmci_supported(int *banks)
+{
+	u64 cap;
+
+	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
 		return 0;
+
+	if (!cmci_supported_hw())
+		return 0;
+
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
 	*banks = min_t(unsigned, MAX_NR_BANKS, cap & 0xff);
 	return !!(cap & MCG_CMCI_P);
@@ -519,3 +528,27 @@ ((m->status & 0xa0000000ffffffff) == 0x8
 
 	return false;
 }
+
+/*
+ * On systems that do support CMCI but it's disabled, polling for MCEs can
+ * cause the same event to be reported multiple times because IA32_MCi_STATUS
+ * is shared by the same package.
+ */
+static DEFINE_SPINLOCK(cmci_poll_lock);
+bool intel_cmci_poll_lock(void)
+{
+	if (!cmci_supported_hw())
+		return false;
+
+	spin_lock(&cmci_poll_lock);
+
+	return true;
+}
+
+void intel_cmci_poll_unlock(bool locked)
+{
+	if (!locked)
+		return;
+
+	spin_unlock(&cmci_poll_lock);
+}
--- linus-2.6.orig/arch/x86/kernel/cpu/mce/internal.h	2023-06-26 12:37:12.972386600 -0400
+++ linus-2.6/arch/x86/kernel/cpu/mce/internal.h	2023-06-26 12:47:21.896072039 -0400
@@ -49,6 +49,8 @@ void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
+bool intel_cmci_poll_lock(void);
+void intel_cmci_poll_unlock(bool locked);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
@@ -58,6 +60,8 @@ static inline void intel_init_cmci(void)
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
+static inline bool intel_cmci_poll_lock(void) { return false; }
+static inline void intel_cmci_poll_unlock(bool locked) { }
 #endif
 
 void mce_timer_kick(unsigned long interval);

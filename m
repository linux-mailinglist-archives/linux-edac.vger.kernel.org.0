Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E2729F75
	for <lists+linux-edac@lfdr.de>; Fri,  9 Jun 2023 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242102AbjFIQAH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Jun 2023 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242025AbjFIP7v (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Jun 2023 11:59:51 -0400
Received: from lobo.ruivo.org (lobo.ruivo.org [173.14.175.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE90359D
        for <linux-edac@vger.kernel.org>; Fri,  9 Jun 2023 08:59:49 -0700 (PDT)
Received: by lobo.ruivo.org (Postfix, from userid 1011)
        id EC20C52C78; Fri,  9 Jun 2023 11:59:47 -0400 (EDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from jake.ruivo.org (bob.qemu.ruivo [192.168.72.19])
        by lobo.ruivo.org (Postfix) with ESMTPA id 1C21652993;
        Fri,  9 Jun 2023 11:59:29 -0400 (EDT)
Received: by jake.ruivo.org (Postfix, from userid 1000)
        id 0A0AF22010F; Fri,  9 Jun 2023 11:59:29 -0400 (EDT)
Date:   Fri, 9 Jun 2023 11:59:29 -0400
From:   Aristeu Rozanski <aris@ruivo.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Aristeu Rozanski <aris@redhat.com>
Subject: Re: [PATCH] mce: prevent concurrent polling of MCE events
Message-ID: <20230609155929.GV4090740@cathedrallabs.org>
References: <SJ1PR11MB6083726809001C8E29D65F15FC4DA@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20230605193000.GDZH43uFhBmQfSO+9D@fat_crate.local>
 <20230605203315.GR4090740@cathedrallabs.org>
 <20230605205658.GFZH5MGg2QizffZRte@fat_crate.local>
 <20230605210108.GS4090740@cathedrallabs.org>
 <20230605210610.GGZH5OQkeWMXGZzxhR@fat_crate.local>
 <20230605215839.GT4090740@cathedrallabs.org>
 <20230606082541.GAZH7thXcj7SatSNtO@fat_crate.local>
 <20230606140011.GU4090740@cathedrallabs.org>
 <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606140848.GCZH898MYjw6+b2yux@fat_crate.local>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Borislav,

On Tue, Jun 06, 2023 at 04:08:48PM +0200, Borislav Petkov wrote:
> Independent of that, yes, we will try not to pollute it with duplicates
> once we know what the issue exactly is which makes people disable CMCI.

how about this (untested, with possibly a short comment on
intel_cmci_poll_lock()):

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1618,7 +1618,9 @@ static void mce_timer_fn(struct timer_list *t)
 	iv = __this_cpu_read(mce_next_interval);
 
 	if (mce_available(this_cpu_ptr(&cpu_info))) {
+		bool locked = intel_cmci_poll_lock();
 		machine_check_poll(0, this_cpu_ptr(&mce_poll_banks));
+		intel_cmci_poll_unlock(locked);
 
 		if (mce_intel_cmci_poll()) {
 			iv = mce_adjust_timer(iv);
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..c688c088f5cf 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -73,13 +73,10 @@ enum {
 
 static atomic_t cmci_storm_on_cpus;
 
-static int cmci_supported(int *banks)
+static int cmci_supported_hw(int *banks)
 {
 	u64 cap;
 
-	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
-		return 0;
-
 	/*
 	 * Vendor check is not strictly needed, but the initial
 	 * initialization is vendor keyed and this
@@ -96,6 +93,14 @@ static int cmci_supported(int *banks)
 	return !!(cap & MCG_CMCI_P);
 }
 
+static int cmci_supported(int *banks)
+{
+	if (mca_cfg.cmci_disabled || mca_cfg.ignore_ce)
+		return 0;
+
+	return cmci_supported_hw(banks);
+}
+
 static bool lmce_supported(void)
 {
 	u64 tmp;
@@ -519,3 +524,25 @@ bool intel_filter_mce(struct mce *m)
 
 	return false;
 }
+
+static DEFINE_SPINLOCK(cmci_poll_lock);
+bool intel_cmci_poll_lock(void)
+{
+	int banks;
+
+	if (!cmci_supported_hw(&banks))
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
+
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index d2412ce2d312..25bcc4a13e8c 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -49,6 +49,8 @@ void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
+bool intel_cmci_poll_lock(void);
+void intel_cmci_poll_unlock(bool locked);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
@@ -58,6 +60,8 @@ static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
+static inline bool intel_cmci_poll_lock(void) { return false; }
+static inline void intel_cmci_poll_unlock(bool locked) { }
 #endif
 
 void mce_timer_kick(unsigned long interval);
-- 
Aristeu


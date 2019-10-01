Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C4C324F
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 13:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731317AbfJALVu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 07:21:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54938 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJALVt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Oct 2019 07:21:49 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFGDr-0000H4-Rg; Tue, 01 Oct 2019 13:21:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7184C1C03AB;
        Tue,  1 Oct 2019 13:21:39 +0200 (CEST)
Date:   Tue, 01 Oct 2019 11:21:39 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add Zhaoxin LMCE support
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, CooperYan@zhaoxin.com,
        DavidWang@zhaoxin.com, HerryYang@zhaoxin.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-edac" <linux-edac@vger.kernel.org>, QiyuanWang@zhaoxin.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568787573-1297-5-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-5-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <156992889928.9978.12753504403920052831.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     70f0c230031dfef3c9b3e37b2a8c18d3f7186fb2
Gitweb:        https://git.kernel.org/tip/70f0c230031dfef3c9b3e37b2a8c18d3f7186fb2
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Wed, 18 Sep 2019 14:19:33 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 12:33:33 +02:00

x86/mce: Add Zhaoxin LMCE support

Newer Zhaoxin CPUs support LMCE compatible with Intel. Add support for
that.

 [ bp: Export functions and massage. ]

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: CooperYan@zhaoxin.com
Cc: DavidWang@zhaoxin.com
Cc: HerryYang@zhaoxin.com
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: QiyuanWang@zhaoxin.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1568787573-1297-5-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/mce/core.c     | 22 ++++++++++++++++++++--
 arch/x86/kernel/cpu/mce/intel.c    |  4 ++--
 arch/x86/kernel/cpu/mce/internal.h |  4 ++++
 3 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1e6b8a4..5f42f25 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1132,6 +1132,12 @@ static bool __mc_check_crashing_cpu(int cpu)
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
+			if (mcgstatus & MCG_STATUS_LMCES)
+				return false;
+		}
+
 		if (mcgstatus & MCG_STATUS_RIPV) {
 			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 			return true;
@@ -1282,9 +1288,10 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 
 	/*
 	 * Check if this MCE is signaled to only this logical processor,
-	 * on Intel only.
+	 * on Intel, Zhaoxin only.
 	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL)
+	if (m.cpuvendor == X86_VENDOR_INTEL ||
+	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
 		lmce = m.mcgstatus & MCG_STATUS_LMCES;
 
 	/*
@@ -1797,9 +1804,15 @@ static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
 	}
 
 	intel_init_cmci();
+	intel_init_lmce();
 	mce_adjust_timer = cmci_intel_adjust_timer;
 }
 
+static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
+{
+	intel_clear_lmce();
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1836,6 +1849,11 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_clear(c);
 		break;
+
+	case X86_VENDOR_ZHAOXIN:
+		mce_zhaoxin_feature_clear(c);
+		break;
+
 	default:
 		break;
 	}
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index fb6e990..68a1d25 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -444,7 +444,7 @@ void intel_init_cmci(void)
 	cmci_recheck();
 }
 
-static void intel_init_lmce(void)
+void intel_init_lmce(void)
 {
 	u64 val;
 
@@ -457,7 +457,7 @@ static void intel_init_lmce(void)
 		wrmsrl(MSR_IA32_MCG_EXT_CTL, val | MCG_EXT_CTL_LMCE_EN);
 }
 
-static void intel_clear_lmce(void)
+void intel_clear_lmce(void)
 {
 	u64 val;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index a7ee230..842b273 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -46,12 +46,16 @@ bool mce_intel_cmci_poll(void);
 void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
 void intel_init_cmci(void);
+void intel_init_lmce(void);
+void intel_clear_lmce(void);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
 static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
 static inline void intel_init_cmci(void) { }
+static inline void intel_init_lmce(void) { }
+static inline void intel_clear_lmce(void) { }
 #endif
 
 void mce_timer_kick(unsigned long interval);

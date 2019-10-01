Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53961C3252
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2019 13:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731705AbfJALVw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Oct 2019 07:21:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54946 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbfJALVw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 1 Oct 2019 07:21:52 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iFGDr-0000H5-Tt; Tue, 01 Oct 2019 13:21:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 91EB51C070D;
        Tue,  1 Oct 2019 13:21:39 +0200 (CEST)
Date:   Tue, 01 Oct 2019 11:21:39 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add Zhaoxin CMCI support
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Borislav Petkov <bp@suse.de>, CooperYan@zhaoxin.com,
        DavidWang@zhaoxin.com, HerryYang@zhaoxin.com,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-edac" <linux-edac@vger.kernel.org>, QiyuanWang@zhaoxin.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, "x86-ml" <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1568787573-1297-4-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-4-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <156992889955.9978.11127376798004332178.tip-bot2@tip-bot2>
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

Commit-ID:     5a3d56a034be9e8e87a6cb9ed3f2928184db1417
Gitweb:        https://git.kernel.org/tip/5a3d56a034be9e8e87a6cb9ed3f2928184db1417
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Wed, 18 Sep 2019 14:19:32 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 01 Oct 2019 12:33:09 +02:00

x86/mce: Add Zhaoxin CMCI support

All newer Zhaoxin CPUs support CMCI and are compatible with Intel's
Machine-Check Architecture. Add that support for Zhaoxin CPUs.

 [ bp: Massage comments and export intel_init_cmci(). ]

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
Link: https://lkml.kernel.org/r/1568787573-1297-4-git-send-email-TonyWWang-oc@zhaoxin.com
---
 arch/x86/kernel/cpu/mce/core.c     | 27 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c    |  6 ++++--
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a780fe0..1e6b8a4 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1777,6 +1777,29 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 	}
 }
 
+static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+
+	/*
+	 * These CPUs have MCA bank 8 which reports only one error type called
+	 * SVAD (System View Address Decoder). The reporting of that error is
+	 * controlled by IA32_MC8.CTL.0.
+	 *
+	 * If enabled, prefetching on these CPUs will cause SVAD MCE when
+	 * virtual machines start and result in a system  panic. Always disable
+	 * bank 8 SVAD error by default.
+	 */
+	if ((c->x86 == 7 && c->x86_model == 0x1b) ||
+	    (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
+		if (this_cpu_read(mce_num_banks) > 8)
+			mce_banks[8].ctl = 0;
+	}
+
+	intel_init_cmci();
+	mce_adjust_timer = cmci_intel_adjust_timer;
+}
+
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1798,6 +1821,10 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_centaur_feature_init(c);
 		break;
 
+	case X86_VENDOR_ZHAOXIN:
+		mce_zhaoxin_feature_init(c);
+		break;
+
 	default:
 		break;
 	}
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 88cd959..fb6e990 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -85,8 +85,10 @@ static int cmci_supported(int *banks)
 	 * initialization is vendor keyed and this
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 0;
+
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
@@ -423,7 +425,7 @@ void cmci_disable_bank(int bank)
 	raw_spin_unlock_irqrestore(&cmci_discover_lock, flags);
 }
 
-static void intel_init_cmci(void)
+void intel_init_cmci(void)
 {
 	int banks;
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 43031db..a7ee230 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -45,11 +45,13 @@ unsigned long cmci_intel_adjust_timer(unsigned long interval);
 bool mce_intel_cmci_poll(void);
 void mce_intel_hcpu_update(unsigned long cpu);
 void cmci_disable_bank(int bank);
+void intel_init_cmci(void);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
 static inline void mce_intel_hcpu_update(unsigned long cpu) { }
 static inline void cmci_disable_bank(int bank) { }
+static inline void intel_init_cmci(void) { }
 #endif
 
 void mce_timer_kick(unsigned long interval);

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1176B725BC8
	for <lists+linux-edac@lfdr.de>; Wed,  7 Jun 2023 12:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238087AbjFGKpr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Jun 2023 06:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjFGKp3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Jun 2023 06:45:29 -0400
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB3310EC
        for <linux-edac@vger.kernel.org>; Wed,  7 Jun 2023 03:45:27 -0700 (PDT)
X-ASG-Debug-ID: 1686134724-1eb14e2b4909f00001-QCVQLf
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx2.zhaoxin.com with ESMTP id JwSC10RSH0V5rtst (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 07 Jun 2023 18:45:24 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 7 Jun
 2023 18:45:23 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 7 Jun
 2023 18:45:21 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <tony.luck@intel.com>, <youquan.song@intel.com>,
        <qiuxu.zhuo@intel.com>, <arnd@arndb.de>,
        <aleksander.lobakin@intel.com>, <linux-edac@vger.kernel.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <TonyWWang-oc@zhaoxin.com>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <LeoLiu-oc@zhaoxin.com>
Subject: [PATCH 1/3] x86/mce: Move Zhaoxin MCE functions to the separate file
Date:   Wed, 7 Jun 2023 18:45:25 +0800
X-ASG-Orig-Subj: [PATCH 1/3] x86/mce: Move Zhaoxin MCE functions to the separate file
Message-ID: <20230607104527.3298-1-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1686134724
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 5418
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.109718
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Right now the functions of Zhaoxin MCE are in the MCE core.c file.
Create a separate zhaoxin.c to make MCE core.c more clearly.
Functions not change.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/Kconfig                  |  8 +++++
 arch/x86/include/asm/mce.h        |  8 +++++
 arch/x86/kernel/cpu/mce/Makefile  |  1 +
 arch/x86/kernel/cpu/mce/core.c    | 49 ++++++++++++-------------------
 arch/x86/kernel/cpu/mce/zhaoxin.c | 15 ++++++++++
 5 files changed, 50 insertions(+), 31 deletions(-)
 create mode 100644 arch/x86/kernel/cpu/mce/zhaoxin.c

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index a98c5f82be48..79db47afd752 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1182,6 +1182,14 @@ config X86_MCE_INJECT
 	  If you don't know what a machine check is and you don't do kernel
 	  QA it is safe to say n.
 
+config X86_MCE_ZHAOXIN
+	def_bool y
+	prompt "Zhaoxin MCE features"
+	depends on X86_MCE && X86_LOCAL_APIC && X86_MCE_INTEL
+	help
+	  Additional support for Zhaoxin specific MCE features such as
+	  the DRAM error threshold.
+
 source "arch/x86/events/Kconfig"
 
 config X86_LEGACY_VM86
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cbfcc4e..c4776421518e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -353,4 +353,12 @@ static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_am
 
 unsigned long copy_mc_fragile_handle_tail(char *to, char *from, unsigned len);
 
+#ifdef CONFIG_X86_MCE_ZHAOXIN
+void mce_zhaoxin_feature_init(void);
+void mce_zhaoxin_feature_clear(void);
+#else
+static inline void mce_zhaoxin_feature_init(void) { }
+static inline void mce_zhaoxin_feature_clear(void) { }
+#endif
+
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 015856abdbb1..ff0b67f643d4 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
 obj-$(CONFIG_X86_MCE_INTEL)	+= intel.o
 obj-$(CONFIG_X86_MCE_AMD)	+= amd.o
 obj-$(CONFIG_X86_MCE_THRESHOLD) += threshold.o
+obj-$(CONFIG_X86_MCE_ZHAOXIN)	+= zhaoxin.o
 
 mce-inject-y			:= inject.o
 obj-$(CONFIG_X86_MCE_INJECT)	+= mce-inject.o
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 22dfcb2adcd7..6ae68749383c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1884,6 +1884,21 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 	}
 
 	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * These CPUs have MCA bank 8 which reports only one error type called
+		 * SVAD (System View Address Decoder). The reporting of that error is
+		 * controlled by IA32_MC8.CTL.0.
+		 *
+		 * If enabled, prefetching on these CPUs will cause SVAD MCE when
+		 * virtual machines start and result in a system  panic. Always disable
+		 * bank 8 SVAD error by default.
+		 */
+		if ((c->x86 == 7 && c->x86_model == 0x1b) ||
+		    (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
+			if (this_cpu_read(mce_num_banks) > 8)
+				mce_banks[8].ctl = 0;
+		}
+
 		/*
 		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
 		 * synchronization with a one second timeout.
@@ -1951,35 +1966,6 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 	}
 }
 
-static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
-{
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-
-	/*
-	 * These CPUs have MCA bank 8 which reports only one error type called
-	 * SVAD (System View Address Decoder). The reporting of that error is
-	 * controlled by IA32_MC8.CTL.0.
-	 *
-	 * If enabled, prefetching on these CPUs will cause SVAD MCE when
-	 * virtual machines start and result in a system  panic. Always disable
-	 * bank 8 SVAD error by default.
-	 */
-	if ((c->x86 == 7 && c->x86_model == 0x1b) ||
-	    (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
-		if (this_cpu_read(mce_num_banks) > 8)
-			mce_banks[8].ctl = 0;
-	}
-
-	intel_init_cmci();
-	intel_init_lmce();
-	mce_adjust_timer = cmci_intel_adjust_timer;
-}
-
-static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
-{
-	intel_clear_lmce();
-}
-
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -2002,7 +1988,8 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		break;
 
 	case X86_VENDOR_ZHAOXIN:
-		mce_zhaoxin_feature_init(c);
+		mce_zhaoxin_feature_init();
+		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
 
 	default:
@@ -2018,7 +2005,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
 		break;
 
 	case X86_VENDOR_ZHAOXIN:
-		mce_zhaoxin_feature_clear(c);
+		mce_zhaoxin_feature_clear();
 		break;
 
 	default:
diff --git a/arch/x86/kernel/cpu/mce/zhaoxin.c b/arch/x86/kernel/cpu/mce/zhaoxin.c
new file mode 100644
index 000000000000..f4e90ec99267
--- /dev/null
+++ b/arch/x86/kernel/cpu/mce/zhaoxin.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/mce.h>
+
+#include "internal.h"
+
+void mce_zhaoxin_feature_init(void)
+{
+	intel_init_cmci();
+	intel_init_lmce();
+}
+
+void mce_zhaoxin_feature_clear(void)
+{
+	intel_clear_lmce();
+}
-- 
2.17.1


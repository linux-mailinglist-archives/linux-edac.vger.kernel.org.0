Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757A6725BCB
	for <lists+linux-edac@lfdr.de>; Wed,  7 Jun 2023 12:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbjFGKpv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Jun 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239237AbjFGKpp (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Jun 2023 06:45:45 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6E41BDC
        for <linux-edac@vger.kernel.org>; Wed,  7 Jun 2023 03:45:36 -0700 (PDT)
X-ASG-Debug-ID: 1686134727-086e2331360ea40001-QCVQLf
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx1.zhaoxin.com with ESMTP id LnX0CAUL1HqirAtV (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 07 Jun 2023 18:45:27 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 7 Jun
 2023 18:45:27 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 7 Jun
 2023 18:45:25 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
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
Subject: [PATCH 3/3] x86/mce: add Zhaoxin another CPU Vendor ID support
Date:   Wed, 7 Jun 2023 18:45:27 +0800
X-ASG-Orig-Subj: [PATCH 3/3] x86/mce: add Zhaoxin another CPU Vendor ID support
Message-ID: <20230607104527.3298-3-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607104527.3298-1-TonyWWang-oc@zhaoxin.com>
References: <20230607104527.3298-1-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1686134727
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 3335
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

Add Zhaoxin CPUs with Vendor ID "CentaurHauls" support for CMCI/LMCE.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c  | 15 +++++++++++----
 arch/x86/kernel/cpu/mce/intel.c |  3 ++-
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index f919fa3ab69d..38228021fe99 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -466,7 +466,8 @@ int mce_usable_address(struct mce *m)
 
 	/* Checks after this one are Intel/Zhaoxin-specific: */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR)
 		return 1;
 
 	if (!(m->status & MCI_STATUS_MISCV))
@@ -491,6 +492,7 @@ bool mce_is_memory_error(struct mce *m)
 
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -1192,7 +1194,8 @@ static noinstr bool mce_check_crashing_cpu(void)
 
 		mcgstatus = __rdmsr(MSR_IA32_MCG_STATUS);
 
-		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN ||
+			boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR) {
 			if (mcgstatus & MCG_STATUS_LMCES)
 				return false;
 		}
@@ -1466,7 +1469,8 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * on Intel, Zhaoxin only.
 	 */
 	if (m.cpuvendor == X86_VENDOR_INTEL ||
-	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
+	    m.cpuvendor == X86_VENDOR_ZHAOXIN ||
+	    m.cpuvendor == X86_VENDOR_CENTAUR)
 		lmce = m.mcgstatus & MCG_STATUS_LMCES;
 
 	/*
@@ -1981,6 +1985,7 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		break;
 
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		mce_zhaoxin_feature_init();
 		mce_adjust_timer = cmci_intel_adjust_timer;
 		break;
@@ -1998,6 +2003,7 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
 		break;
 
 	case X86_VENDOR_ZHAOXIN:
+	case X86_VENDOR_CENTAUR:
 		mce_zhaoxin_feature_clear();
 		break;
 
@@ -2282,7 +2288,8 @@ static void vendor_disable_error_reporting(void)
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
+	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR)
 		return;
 
 	mce_disable_error_reporting();
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..92f7104c86ad 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -86,7 +86,8 @@ static int cmci_supported(int *banks)
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR)
 		return 0;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
-- 
2.17.1


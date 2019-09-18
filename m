Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6A8B5BC9
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2019 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbfIRGTr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Sep 2019 02:19:47 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:45789 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727208AbfIRGTq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Sep 2019 02:19:46 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:42 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.46) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:40 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yazen.ghannam@amd.com>, <vishal.l.verma@intel.com>,
        <qiuxu.zhuo@intel.com>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v4 3/4] x86/mce: Add Zhaoxin CMCI support
Date:   Wed, 18 Sep 2019 14:19:32 +0800
Message-ID: <1568787573-1297-4-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568787573-1297-3-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
 <1568787573-1297-3-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.46]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

All Zhaoxin newer CPUs support CMCI that compatible with Intel's
"Machine-Check Architecture", so add support for Zhaoxin CMCI in
mce/core.c and mce/intel.c.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c  | 25 +++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c |  5 ++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7bcd8c1..65c5a1f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1777,6 +1777,27 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 	}
 }
 
+static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+
+	/*
+	 * These CPUs have MCA bank 8, that only has one error called SVAD
+	 * (System View Address Decoder) which be controlled by IA32_MC8.CTL.0
+	 * If enabled, the prefetch on these CPUs will cause SVAD machine
+	 * check exception when virtual machine startup and cause system
+	 * panic. Always disable bank 8 SVAD error by default.
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
@@ -1798,6 +1819,10 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
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
index 70799a5..87c473f 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -84,9 +84,12 @@ static int cmci_supported(int *banks)
 	 * Vendor check is not strictly needed, but the initial
 	 * initialization is vendor keyed and this
 	 * makes sure none of the backdoors are entered otherwise.
+	 * Checks the vendor are Intel/Zhaoxin-specific:
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 0;
+
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
-- 
2.7.4


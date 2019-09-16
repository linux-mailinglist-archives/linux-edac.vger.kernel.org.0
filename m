Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 224BFB3982
	for <lists+linux-edac@lfdr.de>; Mon, 16 Sep 2019 13:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731258AbfIPLgw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 16 Sep 2019 07:36:52 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:23515 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729535AbfIPLgw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 16 Sep 2019 07:36:52 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 16 Sep
 2019 19:36:50 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 16 Sep
 2019 19:36:49 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Mon, 16 Sep 2019 19:36:49 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     "tony.luck@intel.com" <tony.luck@intel.com>,
        "Borislav Petkov (bp@alien8.de)" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "qiuxu.zhuo@intel.com" <qiuxu.zhuo@intel.com>
CC:     David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: [PATCH v3 3/4]  x86/mce: Add Zhaoxin CMCI support
Thread-Topic: [PATCH v3 3/4]  x86/mce: Add Zhaoxin CMCI support
Thread-Index: AdVsgcsB5k4nXJqUR7WnEmO+O6tKsw==
Date:   Mon, 16 Sep 2019 11:36:49 +0000
Message-ID: <d7e189b63c354a26b895bbd27bc856b3@zhaoxin.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.64.75]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
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

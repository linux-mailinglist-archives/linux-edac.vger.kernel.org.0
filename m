Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6C6AD6EF
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2019 12:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfIIKg3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 9 Sep 2019 06:36:29 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:6752 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728945AbfIIKg2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Sep 2019 06:36:28 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Sep 2019 06:36:28 EDT
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Sep
 2019 18:21:23 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Sep
 2019 18:21:23 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Mon, 9 Sep 2019 18:21:23 +0800
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
Subject: [PATCH v1 3/4] x86/mce: Add Zhaoxin CMCI support
Thread-Topic: [PATCH v1 3/4] x86/mce: Add Zhaoxin CMCI support
Thread-Index: AdVm9rhzHHwSHU0OR4CG5KfkCNKupA==
Date:   Mon, 9 Sep 2019 10:21:22 +0000
Message-ID: <29e895912c2f4989937fa33d59e55dd9@zhaoxin.com>
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
 arch/x86/include/asm/mce.h      |  6 ++++++
 arch/x86/kernel/cpu/mce/core.c  | 25 +++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c |  3 ++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index dc2d4b2..0986a11 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -350,4 +350,10 @@ umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)	{ return
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
 
+#ifdef CONFIG_CPU_SUP_ZHAOXIN
+void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c);
+#else
+static inline void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c) { }
+#endif
+
 #endif /* _ASM_X86_MCE_H */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 3f878f6..a3b07ca 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1777,6 +1777,27 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 	}
 }
 
+void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+
+	/*
+	 * These CPUs bank8 SVAD error may be triggered unexpected when
+	 * bringup virtual machine. it is not hardware bug. Always disable
+	 * bank8 SVAD error by default.
+	 */
+	if ((c->x86 == 6 && c->x86_model == 0x19 &&
+		(c->x86_stepping > 3 && c->x86_stepping < 8)) ||
+	    (c->x86 == 6 && c->x86_model == 0x1f) ||
+	    (c->x86 == 7 && c->x86_model == 0x1b)) {
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
index eee4b12..b49cba7 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -85,7 +85,8 @@ static int cmci_supported(int *banks)
 	 * initialization is vendor keyed and this
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 0;
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
 		return 0;
-- 
2.7.4

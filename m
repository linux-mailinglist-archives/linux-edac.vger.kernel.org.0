Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54412AE549
	for <lists+linux-edac@lfdr.de>; Tue, 10 Sep 2019 10:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfIJITr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 10 Sep 2019 04:19:47 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:15685 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731155AbfIJITr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 10 Sep 2019 04:19:47 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 10 Sep
 2019 16:19:45 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx3.zhaoxin.com
 (10.29.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Tue, 10 Sep
 2019 16:19:44 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Tue, 10 Sep 2019 16:19:44 +0800
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
Subject: [PATCH v2 3/4] x86/mce: Add Zhaoxin CMCI support
Thread-Topic: [PATCH v2 3/4] x86/mce: Add Zhaoxin CMCI support
Thread-Index: AdVnqRp9Tf3+t+7iRiGrtZWDTW0/HQ==
Date:   Tue, 10 Sep 2019 08:19:44 +0000
Message-ID: <e8d11f3ce0f64a9f9a4cefcc8059747b@zhaoxin.com>
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
v1->v2:
 - Fix redefinition of "mce_zhaoxin_feature_init"

 arch/x86/include/asm/mce.h      |  6 ++++++
 arch/x86/kernel/cpu/mce/core.c  | 27 +++++++++++++++++++++++++++
 arch/x86/kernel/cpu/mce/intel.c |  3 ++-
 3 files changed, 35 insertions(+), 1 deletion(-)

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
index 3f878f6..8a36833 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1777,6 +1777,29 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 	}
 }
 
+#ifdef CONFIG_CPU_SUP_ZHAOXIN
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
+#endif
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

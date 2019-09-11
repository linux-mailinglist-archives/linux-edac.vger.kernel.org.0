Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3AD7AFC16
	for <lists+linux-edac@lfdr.de>; Wed, 11 Sep 2019 14:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfIKMDP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Wed, 11 Sep 2019 08:03:15 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:9782 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726696AbfIKMDP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Sep 2019 08:03:15 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 20:03:13 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 11 Sep
 2019 20:03:12 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Wed, 11 Sep 2019 20:03:12 +0800
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
Subject: [PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support
Thread-Topic: [PATCH v3 4/4] x86/mce: Add Zhaoxin LMCE support
Thread-Index: AdVojTN9ECaYqtW9SnmHQaatPU1IJQ==
Date:   Wed, 11 Sep 2019 12:03:12 +0000
Message-ID: <e87b45eeee3142dca457f9d7ae41e959@zhaoxin.com>
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

Zhaoxin newer CPUs support LMCE that compatible with Intel's
"Machine-Check Architecture", so add support for Zhaoxin LMCE
in mce/core.c.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
v2->v3:
 - Rework mce_zhaoxin_feature_clear() as static
 - Add comment and change coding style

v1->v2:
 - Fix redefinition of "mce_zhaoxin_feature_clear"

 arch/x86/kernel/cpu/mce/core.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 65c5a1f..acdd76b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1132,6 +1132,27 @@ static bool __mc_check_crashing_cpu(int cpu)
 		u64 mcgstatus;
 
 		mcgstatus = mce_rdmsrl(MSR_IA32_MCG_STATUS);
+
+		if (boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN) {
+			if (mcgstatus & MCG_STATUS_LMCES)
+				return false;
+
+			if (!(mcgstatus & MCG_STATUS_LMCES)) {
+				/*
+				 * Clear the MCG_STATUS_RIPV valid status
+				 * bit so that a second MCE won't cause a
+				 * shutdown.
+				 */
+				if (mcgstatus & MCG_STATUS_RIPV)
+					mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
+				/*
+				 * On this CPU, skip synchronize regardless
+				 * of MCG_STATUS_RIPV status.
+				 */
+				return true;
+			}
+		}
+
 		if (mcgstatus & MCG_STATUS_RIPV) {
 			mce_wrmsrl(MSR_IA32_MCG_STATUS, 0);
 			return true;
@@ -1282,9 +1303,10 @@ void do_machine_check(struct pt_regs *regs, long error_code)
 
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
@@ -1795,9 +1817,15 @@ static void mce_zhaoxin_feature_init(struct cpuinfo_x86 *c)
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
@@ -1834,6 +1862,9 @@ static void __mcheck_cpu_clear_vendor(struct cpuinfo_x86 *c)
 	case X86_VENDOR_INTEL:
 		mce_intel_feature_clear(c);
 		break;
+	case X86_VENDOR_ZHAOXIN:
+		mce_zhaoxin_feature_clear(c);
+		break;
 	default:
 		break;
 	}
-- 
2.7.4


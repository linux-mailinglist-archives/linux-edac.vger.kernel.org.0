Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE69AD6F1
	for <lists+linux-edac@lfdr.de>; Mon,  9 Sep 2019 12:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbfIIKgb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 9 Sep 2019 06:36:31 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:59195 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728964AbfIIKga (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Sep 2019 06:36:30 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Sep
 2019 18:21:00 +0800
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Mon, 9 Sep
 2019 18:21:00 +0800
Received: from zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d]) by
 zxbjmbx1.zhaoxin.com ([fe80::b41a:737:a784:b70d%16]) with mapi id
 15.01.1261.035; Mon, 9 Sep 2019 18:21:00 +0800
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
Subject: [PATCH v1 1/4] x86/mce: Add Zhaoxin MCE support
Thread-Topic: [PATCH v1 1/4] x86/mce: Add Zhaoxin MCE support
Thread-Index: AdVm9wIO3kejlR5fSyK15L215x15mg==
Date:   Mon, 9 Sep 2019 10:21:00 +0000
Message-ID: <9ab728a082834a29abb26f6e7bc6263d@zhaoxin.com>
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

All Zhaoxin newer CPUs support MCE that compatible with Intel's
"Machine-Check Architecture", so add support for Zhaoxin MCE in
mce/core.c.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370e..3f878f6 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -488,8 +488,9 @@ int mce_usable_address(struct mce *m)
 	if (!(m->status & MCI_STATUS_ADDRV))
 		return 0;
 
-	/* Checks after this one are Intel-specific: */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+	/* Checks after this one are Intel/Zhaoxin-specific: */
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
 		return 1;
 
 	if (!(m->status & MCI_STATUS_MISCV))
@@ -510,7 +511,8 @@ bool mce_is_memory_error(struct mce *m)
 	if (m->cpuvendor == X86_VENDOR_AMD ||
 	    m->cpuvendor == X86_VENDOR_HYGON) {
 		return amd_mce_is_memory_error(m);
-	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
+	} else if (m->cpuvendor == X86_VENDOR_INTEL ||
+		   m->cpuvendor == X86_VENDOR_ZHAOXIN) {
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -1697,6 +1699,21 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model == 45)
 			quirk_no_way_out = quirk_sandybridge_ifu;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
+		 * synchronization with a one second timeout.
+		 */
+		if ((c->x86 == 6 && c->x86_model == 0x19 &&
+			(c->x86_stepping > 3 && c->x86_stepping < 8)) ||
+		    (c->x86 == 6 && c->x86_model == 0x1f) ||
+		     c->x86 > 6) {
+			if (cfg->monarch_timeout < 0)
+				cfg->monarch_timeout = USEC_PER_SEC;
+		}
+	}
+
 	if (cfg->monarch_timeout < 0)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
@@ -2014,15 +2031,16 @@ static void mce_disable_error_reporting(void)
 static void vendor_disable_error_reporting(void)
 {
 	/*
-	 * Don't clear on Intel or AMD or Hygon CPUs. Some of these MSRs
-	 * are socket-wide.
+	 * Don't clear on Intel or AMD or Hygon or Zhaoxin CPUs. Some of these
+	 * MSRs are socket-wide.
 	 * Disabling them for just a single offlined CPU is bad, since it will
 	 * inhibit reporting for all shared resources on the socket like the
 	 * last level cache (LLC), the integrated memory controller (iMC), etc.
 	 */
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
 	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
 		return;
 
 	mce_disable_error_reporting();
-- 
2.7.4

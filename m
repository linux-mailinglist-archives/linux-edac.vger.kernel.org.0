Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF390B5BCA
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2019 08:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfIRGTr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Sep 2019 02:19:47 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:45789 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725842AbfIRGTo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 18 Sep 2019 02:19:44 -0400
Received: from zxbjmbx2.zhaoxin.com (10.29.252.164) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:39 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.46) by zxbjmbx2.zhaoxin.com
 (10.29.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 18 Sep
 2019 14:19:38 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yazen.ghannam@amd.com>, <vishal.l.verma@intel.com>,
        <qiuxu.zhuo@intel.com>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v4 1/4] x86/mce: Add Zhaoxin MCE support
Date:   Wed, 18 Sep 2019 14:19:30 +0800
Message-ID: <1568787573-1297-2-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1568787573-1297-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.46]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx2.zhaoxin.com (10.29.252.164)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

All Zhaoxin newer CPUs support MCE that compatible with Intel's
"Machine-Check Architecture", so add support for Zhaoxin MCE in
mce/core.c.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 743370e..7bcd8c1 100644
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
@@ -507,10 +508,13 @@ EXPORT_SYMBOL_GPL(mce_usable_address);
 
 bool mce_is_memory_error(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD ||
-	    m->cpuvendor == X86_VENDOR_HYGON) {
+	switch (m->cpuvendor) {
+	case X86_VENDOR_AMD:
+	case X86_VENDOR_HYGON:
 		return amd_mce_is_memory_error(m);
-	} else if (m->cpuvendor == X86_VENDOR_INTEL) {
+
+	case X86_VENDOR_INTEL:
+	case X86_VENDOR_ZHAOXIN:
 		/*
 		 * Intel SDM Volume 3B - 15.9.2 Compound Error Codes
 		 *
@@ -527,9 +531,10 @@ bool mce_is_memory_error(struct mce *m)
 		return (m->status & 0xef80) == BIT(7) ||
 		       (m->status & 0xef00) == BIT(8) ||
 		       (m->status & 0xeffc) == 0xc;
-	}
 
-	return false;
+	default:
+		return false;
+	}
 }
 EXPORT_SYMBOL_GPL(mce_is_memory_error);
 
@@ -1697,6 +1702,18 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		if (c->x86 == 6 && c->x86_model == 45)
 			quirk_no_way_out = quirk_sandybridge_ifu;
 	}
+
+	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
+		/*
+		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
+		 * synchronization with a one second timeout.
+		 */
+		if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
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


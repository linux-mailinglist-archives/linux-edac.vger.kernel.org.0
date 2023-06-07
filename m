Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CCB725BCA
	for <lists+linux-edac@lfdr.de>; Wed,  7 Jun 2023 12:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjFGKpv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Jun 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjFGKpm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 7 Jun 2023 06:45:42 -0400
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82041BE2
        for <linux-edac@vger.kernel.org>; Wed,  7 Jun 2023 03:45:35 -0700 (PDT)
X-ASG-Debug-ID: 1686134725-086e2331330ea30001-QCVQLf
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx1.zhaoxin.com with ESMTP id uzZDneJ6fJW7g13y (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Wed, 07 Jun 2023 18:45:25 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 7 Jun
 2023 18:45:25 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.16; Wed, 7 Jun
 2023 18:45:23 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
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
Subject: [PATCH 2/3] x86/mce: Set Zhaoxin CPUs MCE monarch_timeout correctly
Date:   Wed, 7 Jun 2023 18:45:26 +0800
X-ASG-Orig-Subj: [PATCH 2/3] x86/mce: Set Zhaoxin CPUs MCE monarch_timeout correctly
Message-ID: <20230607104527.3298-2-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230607104527.3298-1-TonyWWang-oc@zhaoxin.com>
References: <20230607104527.3298-1-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.65.162]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1686134725
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2225
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.109718
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Because __mcheck_cpu_apply_quirks will setting monarch_timeout = 0
before to call the function mce_centaur_feature_init.

So the if case below will not be executed:
if (cfg->monarch_timeout < 0)
	cfg->monarch_timeout = USEC_PER_SEC;

Move monarch_timeout setup for these Zhaoxin CPUs to the function
__mcheck_cpu_apply_quirks to solve this problem.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/mce/core.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ae68749383c..f919fa3ab69d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1909,6 +1909,18 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		}
 	}
 
+	if (c->x86_vendor == X86_VENDOR_CENTAUR) {
+		/*
+		 * All newer Centaur CPUs support MCE broadcasting. Enable
+		 * synchronization with a one second timeout.
+		 */
+		if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
+		    c->x86 > 6) {
+			if (cfg->monarch_timeout < 0)
+				cfg->monarch_timeout = USEC_PER_SEC;
+		}
+	}
+
 	if (cfg->monarch_timeout < 0)
 		cfg->monarch_timeout = 0;
 	if (cfg->bootlog != 0)
@@ -1951,21 +1963,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 	}
 }
 
-static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
-{
-	struct mca_config *cfg = &mca_cfg;
-
-	 /*
-	  * All newer Centaur CPUs support MCE broadcasting. Enable
-	  * synchronization with a one second timeout.
-	  */
-	if ((c->x86 == 6 && c->x86_model == 0xf && c->x86_stepping >= 0xe) ||
-	     c->x86 > 6) {
-		if (cfg->monarch_timeout < 0)
-			cfg->monarch_timeout = USEC_PER_SEC;
-	}
-}
-
 static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 {
 	switch (c->x86_vendor) {
@@ -1983,10 +1980,6 @@ static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
 		mce_hygon_feature_init(c);
 		break;
 
-	case X86_VENDOR_CENTAUR:
-		mce_centaur_feature_init(c);
-		break;
-
 	case X86_VENDOR_ZHAOXIN:
 		mce_zhaoxin_feature_init();
 		mce_adjust_timer = cmci_intel_adjust_timer;
-- 
2.17.1


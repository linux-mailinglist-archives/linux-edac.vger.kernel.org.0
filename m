Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0482A27DB4
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfEWNIe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 09:08:34 -0400
Received: from spam01.hygon.cn ([110.188.70.11]:23615 "EHLO spam1.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726310AbfEWNIe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 09:08:34 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam1.hygon.cn with ESMTP id x4ND0ueA097536;
        Thu, 23 May 2019 21:00:56 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id x4NCxxOI084791;
        Thu, 23 May 2019 20:59:59 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from pw-vbox.hygon.cn (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Thu, 23 May
 2019 21:00:54 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <mchehab@infradead.org>
CC:     <linux-edac@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Subject: [PATCH] ras-mce-handler: Add support for Hygon Dhyana family 18h processor
Date:   Thu, 23 May 2019 21:00:22 +0800
Message-ID: <1558616422-22997-1-git-send-email-puwen@hygon.cn>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam1.hygon.cn x4ND0ueA097536
X-DNSRBL: 
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Hygon Dhyana family 18h processor is derived from AMD family 17h.
The Hygon Dhyana support to Linux is already accepted upstream[1].

Add Hygon Dhyana support to mce handler of rasdaemon in order to handle
MCE events on Hygon Dhyana platforms.

Reference:
[1] https://git.kernel.org/tip/fec98069fb72fb656304a3e52265e0c2fc9adf87

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 ras-mce-handler.c | 9 ++++++++-
 ras-mce-handler.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/ras-mce-handler.c b/ras-mce-handler.c
index c11d489..eb548c6 100644
--- a/ras-mce-handler.c
+++ b/ras-mce-handler.c
@@ -55,7 +55,8 @@ static char *cputype_name[] = {
 	[CPU_KNIGHTS_LANDING] = "Knights Landing",
 	[CPU_KNIGHTS_MILL] = "Knights Mill",
 	[CPU_SKYLAKE_XEON] = "Skylake server",
-	[CPU_NAPLES] = "AMD Family 17h Zen1"
+	[CPU_NAPLES] = "AMD Family 17h Zen1",
+	[CPU_DHYANA] = "Hygon Family 18h Moksha"
 };
 
 static enum cputype select_intel_cputype(struct ras_events *ras)
@@ -200,6 +201,11 @@ static int detect_cpu(struct ras_events *ras)
 			ret = EINVAL;
 		}
 		goto ret;
+	} else if (!strcmp(mce->vendor,"HygonGenuine")) {
+		if (mce->family == 24) {
+			mce->cputype = CPU_DHYANA;
+		}
+		goto ret;
 	} else if (!strcmp(mce->vendor,"GenuineIntel")) {
 		mce->cputype = select_intel_cputype(ras);
 	} else {
@@ -436,6 +442,7 @@ int ras_mce_event_handler(struct trace_seq *s,
 		rc = parse_amd_k8_event(ras, &e);
 		break;
 	case CPU_NAPLES:
+	case CPU_DHYANA:
 		rc = parse_amd_smca_event(ras, &e);
 		break;
 	default:			/* All other CPU types are Intel */
diff --git a/ras-mce-handler.h b/ras-mce-handler.h
index 8aaecd1..94395eb 100644
--- a/ras-mce-handler.h
+++ b/ras-mce-handler.h
@@ -51,6 +51,7 @@ enum cputype {
 	CPU_KNIGHTS_MILL,
 	CPU_SKYLAKE_XEON,
 	CPU_NAPLES,
+	CPU_DHYANA,
 };
 
 struct mce_event {
-- 
2.7.4


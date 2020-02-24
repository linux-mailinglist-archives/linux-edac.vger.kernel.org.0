Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A77B16A062
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 09:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBXItu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 03:49:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgBXItu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 24 Feb 2020 03:49:50 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ECE8B76D5C02F1743E43;
        Mon, 24 Feb 2020 16:49:46 +0800 (CST)
Received: from huawei.com (10.175.104.242) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 16:49:40 +0800
From:   lvying <lvying6@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <guanyalong@huawei.com>
Subject: [PATCH] rasdaemon: decode AER error according to PCIe specifications
Date:   Mon, 24 Feb 2020 12:09:29 +0800
Message-ID: <1582517369-25825-1-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.242]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Corrected/Uncorrected AER error should be decoded according to PCIe
specification: "Correctable/Uncorrectable Error severity Register",
kernel has already followed this specification.

lspci uses abbreviated naming for AER error strings.  Adopt the same naming
convention for the AER printing so they match.

Signed-off-by: lvying <lvying6@huawei.com>
---
 ras-aer-handler.c | 39 ++++++++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/ras-aer-handler.c b/ras-aer-handler.c
index 8ddd439..42a7218 100644
--- a/ras-aer-handler.c
+++ b/ras-aer-handler.c
@@ -29,27 +29,36 @@
 /* bit field meaning for correctable error */
 static const char *aer_cor_errors[32] = {
 	/* Correctable errors */
-	[0]  = "Receiver Error",
-	[6]  = "Bad TLP",
-	[7]  = "Bad DLLP",
-	[8]  = "RELAY_NUM Rollover",
-	[12] = "Replay Timer Timeout",
-	[13] = "Advisory Non-Fatal",
+	[0]  = "RxErr",
+	[6]  = "BadTLP",
+	[7]  = "BadDLLP",
+	[8]  = "Rollover",
+	[12] = "Timeout",
+	[13] = "NonFatalErr",
+	[14] = "CorrIntErr",
+	[15] = "HeaderOF",
 };
 
 /* bit field meaning for uncorrectable error */
 static const char *aer_uncor_errors[32] = {
 	/* Uncorrectable errors */
-	[4]  = "Data Link Protocol",
-	[12] = "Poisoned TLP",
-	[13] = "Flow Control Protocol",
-	[14] = "Completion Timeout",
-	[15] = "Completer Abort",
-	[16] = "Unexpected Completion",
-	[17] = "Receiver Overflow",
-	[18] = "Malformed TLP",
+	[0] = "Undefined",
+	[4] = "DLP",
+	[5] = "SDES",
+	[12] = "TLP",
+	[13] = "FCP",
+	[14] = "CmpltTO",
+	[15] = "CmpltAbrt",
+	[16] = "UnxCmplt",
+	[17] = "RxOF",
+	[18] = "MalfTLP",
 	[19] = "ECRC",
-	[20] = "Unsupported Request",
+	[20] = "UnsupReq",
+	[21] = "ACSViol",
+	[22] = "UncorrIntErr",
+	[23] = "BlockedTLP",
+	[24] = "AtomicOpBlocked",
+	[25] = "TLPBlockedErr",
 };
 
 #define BUF_LEN	1024
-- 
1.8.3.1


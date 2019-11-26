Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14AAA109DAC
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfKZMQB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727630AbfKZMQB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:01 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D443F3E9A34C1C088605;
        Tue, 26 Nov 2019 20:15:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:47 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 2/9] rasdaemon: fix sub module name of HHA and DDRC for hip08
Date:   Tue, 26 Nov 2019 20:12:29 +0800
Message-ID: <1574770356-129510-3-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
References: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix sub module name of HHA and DDRC for hip08, and add const to the
pointer parameter 'name' of step_vendor_data_tab().

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 6fff21a..421e03c 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -347,21 +347,21 @@ static const char *hllc_submodule_name[] = {
 };
 
 static const char *hha_submodule_name[] = {
-	"TA_HHA0",
-	"TA_HHA1",
 	"TB_HHA0",
-	"TB_HHA1"
+	"TB_HHA1",
+	"TA_HHA0",
+	"TA_HHA1"
 };
 
 static const char *ddrc_submodule_name[] = {
-	"TA_DDRC0",
-	"TA_DDRC1",
-	"TA_DDRC2",
-	"TA_DDRC3",
 	"TB_DDRC0",
 	"TB_DDRC1",
 	"TB_DDRC2",
 	"TB_DDRC3",
+	"TA_DDRC0",
+	"TA_DDRC1",
+	"TA_DDRC2",
+	"TA_DDRC3",
 };
 
 static const struct hisi_module_info hisi_oem_type2_module[] = {
@@ -526,7 +526,8 @@ static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
 	}
 }
 
-static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
+static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab,
+				const char *name)
 {
 	int rc;
 
-- 
2.8.1


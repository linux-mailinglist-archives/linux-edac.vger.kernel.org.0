Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BE77186FF
	for <lists+linux-edac@lfdr.de>; Wed, 31 May 2023 18:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEaQGz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 31 May 2023 12:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEaQGy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 31 May 2023 12:06:54 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811CBE2
        for <linux-edac@vger.kernel.org>; Wed, 31 May 2023 09:06:50 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QWYxt6Rzjz6D8WW;
        Thu,  1 Jun 2023 00:05:06 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 31 May 2023 17:06:48 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <lvying6@huawei.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH V2 2/3] rasdaemon: fix issue of signed and unsigned integer comparison and remove redundant header file
Date:   Thu, 1 Jun 2023 00:06:25 +0800
Message-ID: <20230531160627.1506-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230531160627.1506-1-shiju.jose@huawei.com>
References: <20230531160627.1506-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

1. The return value of ARRAY_SIZE() is unsigned integer. It isn't right to
compare it with a signed integer. This patch fix them.

2. Remove redundant header file and adjust the header files sequence.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c    | 2 +-
 non-standard-hisilicon.c     | 8 ++++----
 ras-diskerror-handler.c      | 2 +-
 ras-memory-failure-handler.c | 7 +++----
 4 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 4ef47ea..61f12eb 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -1029,7 +1029,7 @@ static struct ras_ns_ev_decoder hip08_ns_ev_decoder[] = {
 
 static void __attribute__((constructor)) hip08_init(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(hip08_ns_ev_decoder); i++)
 		register_ns_ev_decoder(&hip08_ns_ev_decoder[i]);
diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index 2b00ed6..721821e 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -366,13 +366,13 @@ static int decode_hisi_common_section(struct ras_events *ras,
 	trace_seq_printf(s, "%s\n", hevent.error_msg);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_REG_ARRAY_SIZE) && err->reg_array_size > 0) {
-		int i;
+		unsigned int i;
 
 		trace_seq_printf(s, "Register Dump:\n");
 		for (i = 0; i < err->reg_array_size / sizeof(uint32_t); i++) {
-			trace_seq_printf(s, "reg%02d=0x%08x\n", i,
+			trace_seq_printf(s, "reg%02u=0x%08x\n", i,
 					 err->reg_array[i]);
-			HISI_SNPRINTF(hevent.reg_msg, "reg%02d=0x%08x",
+			HISI_SNPRINTF(hevent.reg_msg, "reg%02u=0x%08x",
 				      i, err->reg_array[i]);
 		}
 	}
@@ -398,7 +398,7 @@ static struct ras_ns_ev_decoder hisi_section_ns_ev_decoder[]  = {
 
 static void __attribute__((constructor)) hisi_ns_init(void)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(hisi_section_ns_ev_decoder); i++)
 		register_ns_ev_decoder(&hisi_section_ns_ev_decoder[i]);
diff --git a/ras-diskerror-handler.c b/ras-diskerror-handler.c
index 38d0a36..638cb4d 100644
--- a/ras-diskerror-handler.c
+++ b/ras-diskerror-handler.c
@@ -52,7 +52,7 @@ static const struct {
 
 static const char *get_blk_error(int err)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(blk_errors); i++)
 		if (blk_errors[i].error == err)
diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
index 72c65de..c74541f 100644
--- a/ras-memory-failure-handler.c
+++ b/ras-memory-failure-handler.c
@@ -15,11 +15,10 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <traceevent/kbuffer.h>
-#include "ras-memory-failure-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-report.h"
+#include "ras-memory-failure-handler.h"
 
 /* Memory failure - various types of pages */
 enum mf_action_page_type {
@@ -99,7 +98,7 @@ static const struct {
 
 static const char *get_page_type(int page_type)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(mf_page_type); i++)
 		if (mf_page_type[i].type == page_type)
@@ -110,7 +109,7 @@ static const char *get_page_type(int page_type)
 
 static const char *get_action_result(int result)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(mf_action_result); i++)
 		if (mf_action_result[i].result == result)
-- 
2.25.1


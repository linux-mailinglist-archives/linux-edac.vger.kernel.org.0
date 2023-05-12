Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C230700426
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbjELJn2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 May 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjELJmr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 May 2023 05:42:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB44124BA
        for <linux-edac@vger.kernel.org>; Fri, 12 May 2023 02:42:03 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHkJT1CsNz67jfb;
        Fri, 12 May 2023 17:40:09 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 12 May 2023 10:41:50 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <fenglei47@h-partners.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH 2/4] rasdaemon: fix issue of signed and unsigned integer comparison
Date:   Fri, 12 May 2023 17:41:27 +0800
Message-ID: <20230512094129.1468-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230512094129.1468-1-shiju.jose@huawei.com>
References: <20230512094129.1468-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Xiaofei Tan <tanxiaofei@huawei.com>

The return value of ARRAY_SIZE() is unsigned integer. It isn't right to
compare it with a signed integer. This patch fix them.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c    | 2 +-
 non-standard-hisilicon.c     | 4 ++--
 ras-diskerror-handler.c      | 2 +-
 ras-memory-failure-handler.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

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
index 2b00ed6..9873919 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -366,7 +366,7 @@ static int decode_hisi_common_section(struct ras_events *ras,
 	trace_seq_printf(s, "%s\n", hevent.error_msg);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_REG_ARRAY_SIZE) && err->reg_array_size > 0) {
-		int i;
+		unsigned int i;
 
 		trace_seq_printf(s, "Register Dump:\n");
 		for (i = 0; i < err->reg_array_size / sizeof(uint32_t); i++) {
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
index 72c65de..85a8633 100644
--- a/ras-memory-failure-handler.c
+++ b/ras-memory-failure-handler.c
@@ -99,7 +99,7 @@ static const struct {
 
 static const char *get_page_type(int page_type)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(mf_page_type); i++)
 		if (mf_page_type[i].type == page_type)
@@ -110,7 +110,7 @@ static const char *get_page_type(int page_type)
 
 static const char *get_action_result(int result)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(mf_action_result); i++)
 		if (mf_action_result[i].result == result)
-- 
2.25.1


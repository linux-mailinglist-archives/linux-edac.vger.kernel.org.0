Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEA700424
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 11:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240285AbjELJn1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 May 2023 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbjELJmr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 May 2023 05:42:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53257124BE
        for <linux-edac@vger.kernel.org>; Fri, 12 May 2023 02:42:04 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHkJT6JM6z67nQw;
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
Subject: [PATCH 3/4] rasdaemon: remove redundant header file and do some cleaup
Date:   Fri, 12 May 2023 17:41:28 +0800
Message-ID: <20230512094129.1468-4-shiju.jose@huawei.com>
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

1.Remove redundant header file and adjust the header files sequence.
2.Use right character format for printf.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisilicon.c     | 4 ++--
 ras-memory-failure-handler.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index 9873919..721821e 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -370,9 +370,9 @@ static int decode_hisi_common_section(struct ras_events *ras,
 
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
diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
index 85a8633..c74541f 100644
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
-- 
2.25.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C73679F49
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jan 2023 17:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjAXQ6F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 24 Jan 2023 11:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjAXQ6D (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 24 Jan 2023 11:58:03 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1B3D918;
        Tue, 24 Jan 2023 08:58:01 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P1Y2p0xyFz6J6gp;
        Wed, 25 Jan 2023 00:53:54 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.158.45) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 24 Jan 2023 16:57:58 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V2 1/4] rasdaemon: Move definition for BIT and BIT_ULL to a common file
Date:   Tue, 24 Jan 2023 16:57:30 +0000
Message-ID: <20230124165733.1452-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20230124165733.1452-1-shiju.jose@huawei.com>
References: <20230124165733.1452-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.158.45]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Move definition for BIT() and BIT_ULL() to the
common file ras-record.h

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ras-non-standard-handler.h | 3 ---
 ras-record.h               | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index 4d9f938..c360eaf 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -17,9 +17,6 @@
 #include "ras-events.h"
 #include <traceevent/event-parse.h>
 
-#define BIT(nr)                 (1UL << (nr))
-#define BIT_ULL(nr)             (1ULL << (nr))
-
 struct ras_ns_ev_decoder {
 	struct ras_ns_ev_decoder *next;
 	const char *sec_type;
diff --git a/ras-record.h b/ras-record.h
index d9f7733..219f10b 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -25,6 +25,9 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
 
+#define BIT(nr)                 (1UL << (nr))
+#define BIT_ULL(nr)             (1ULL << (nr))
+
 extern long user_hz;
 
 struct ras_events;
-- 
2.25.1


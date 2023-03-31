Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91516D219A
	for <lists+linux-edac@lfdr.de>; Fri, 31 Mar 2023 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCaNoh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 Mar 2023 09:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCaNof (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 31 Mar 2023 09:44:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AC15B88;
        Fri, 31 Mar 2023 06:44:33 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pp1dS33n3z67lVj;
        Fri, 31 Mar 2023 21:40:44 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 14:44:31 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V6 1/4] rasdaemon: Move definition for BIT and BIT_ULL to a common file
Date:   Fri, 31 Mar 2023 21:44:01 +0800
Message-ID: <20230331134404.1315-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230331134404.1315-1-shiju.jose@huawei.com>
References: <20230331134404.1315-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


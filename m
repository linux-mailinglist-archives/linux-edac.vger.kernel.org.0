Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7578B6DF037
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 11:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjDLJX2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 05:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjDLJX0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 05:23:26 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA04F61B5;
        Wed, 12 Apr 2023 02:23:25 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGBt2lVVz6J7Dj;
        Wed, 12 Apr 2023 16:31:18 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 09:33:40 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/7] rasdaemon: Add common function to convert timestamp in the CXL event records to the broken-down time format
Date:   Wed, 12 Apr 2023 16:33:05 +0800
Message-ID: <20230412083312.1384-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230412083312.1384-1-shiju.jose@huawei.com>
References: <20230412083312.1384-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

Add common function to convert the timestamp in the CXL event records
in nanoseconds to the broken-down time format.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index adc2fa3..ad93558 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -23,6 +23,25 @@
 #include "ras-report.h"
 #include <endian.h>
 
+/* Common Functions */
+static void convert_timestamp(unsigned long long ts, char *ts_ptr, uint16_t size)
+{
+	/* CXL Specification 3.0
+	 * Overflow timestamp - The number of unsigned nanoseconds
+	 * that have elapsed since midnight, 01-Jan-1970 UTC
+	 */
+	time_t ts_secs = ts / 1000000000ULL;
+	struct tm *tm;
+
+	tm = localtime(&ts_secs);
+	if (tm)
+		strftime(ts_ptr, size, "%Y-%m-%d %H:%M:%S %z", tm);
+
+	if (!ts || !tm)
+		strncpy(ts_ptr, "1970-01-01 00:00:00 +0000",
+			size);
+}
+
 /* Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
 #define CXL_POISON_FLAG_OVERFLOW        BIT(1)
@@ -160,22 +179,7 @@ int ras_cxl_poison_event_handler(struct trace_seq *s,
 	if (ev.flags & CXL_POISON_FLAG_OVERFLOW) {
 		if (tep_get_field_val(s,  event, "overflow_t", record, &val, 1) < 0)
 			return -1;
-		if (val) {
-			/* CXL Specification 3.0
-			 * Overflow timestamp - The number of unsigned nanoseconds
-			 * that have elapsed since midnight, 01-Jan-1970 UTC
-			 */
-			time_t ovf_ts_secs = val / 1000000000ULL;
-
-			tm = localtime(&ovf_ts_secs);
-			if (tm) {
-				strftime(ev.overflow_ts, sizeof(ev.overflow_ts),
-					 "%Y-%m-%d %H:%M:%S %z", tm);
-			}
-		}
-		if (!val || !tm)
-			strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000",
-				sizeof(ev.overflow_ts));
+		convert_timestamp(val, ev.overflow_ts, sizeof(ev.overflow_ts));
 	} else
 		strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000", sizeof(ev.overflow_ts));
 	if (trace_seq_printf(s, "overflow timestamp:%s\n", ev.overflow_ts) <= 0)
-- 
2.25.1


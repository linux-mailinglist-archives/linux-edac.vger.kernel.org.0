Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970A6DEFDC
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 10:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjDLIyn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjDLIyi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 04:54:38 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DE9A5C4;
        Wed, 12 Apr 2023 01:54:16 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGBt3fksz6J7DV;
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
Subject: [RFC PATCH 2/7] rasdaemon: Add common function to get timestamp for the event
Date:   Wed, 12 Apr 2023 16:33:06 +0800
Message-ID: <20230412083312.1384-3-shiju.jose@huawei.com>
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

Add common function to get the timestamp for the event
reported.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index ad93558..025e582 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -42,6 +42,20 @@ static void convert_timestamp(unsigned long long ts, char *ts_ptr, uint16_t size
 			size);
 }
 
+static void get_timestamp(struct trace_seq *s, struct tep_record *record,
+			  struct ras_events *ras, char *ts_ptr, uint16_t size)
+{
+	time_t now;
+	struct tm *tm;
+
+	now = record->ts / user_hz + ras->uptime_diff;
+	tm = localtime(&now);
+	if (tm)
+		strftime(ts_ptr, size, "%Y-%m-%d %H:%M:%S %z", tm);
+	else
+		strncpy(ts_ptr, "1970-01-01 00:00:00 +0000", size);
+}
+
 /* Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
 #define CXL_POISON_FLAG_OVERFLOW        BIT(1)
@@ -68,17 +82,9 @@ int ras_cxl_poison_event_handler(struct trace_seq *s,
 	int len;
 	unsigned long long val;
 	struct ras_events *ras = context;
-	time_t now;
-	struct tm *tm;
 	struct ras_cxl_poison_event ev;
 
-	now = record->ts / user_hz + ras->uptime_diff;
-	tm = localtime(&now);
-	if (tm)
-		strftime(ev.timestamp, sizeof(ev.timestamp),
-			 "%Y-%m-%d %H:%M:%S %z", tm);
-	else
-		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
+	get_timestamp(s, record, ras, (char *)&ev.timestamp, sizeof(ev.timestamp));
 	if (trace_seq_printf(s, "%s ", ev.timestamp) <= 0)
 		return -1;
 
@@ -277,19 +283,11 @@ int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
 {
 	int len, i;
 	unsigned long long val;
-	time_t now;
-	struct tm *tm;
 	struct ras_events *ras = context;
 	struct ras_cxl_aer_ue_event ev;
 
 	memset(&ev, 0, sizeof(ev));
-	now = record->ts / user_hz + ras->uptime_diff;
-	tm = localtime(&now);
-	if (tm)
-		strftime(ev.timestamp, sizeof(ev.timestamp),
-			 "%Y-%m-%d %H:%M:%S %z", tm);
-	else
-		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
+	get_timestamp(s, record, ras, (char *)&ev.timestamp, sizeof(ev.timestamp));
 	if (trace_seq_printf(s, "%s ", ev.timestamp) <= 0)
 		return -1;
 
@@ -372,18 +370,10 @@ int ras_cxl_aer_ce_event_handler(struct trace_seq *s,
 {
 	int len;
 	unsigned long long val;
-	time_t now;
-	struct tm *tm;
 	struct ras_events *ras = context;
 	struct ras_cxl_aer_ce_event ev;
 
-	now = record->ts / user_hz + ras->uptime_diff;
-	tm = localtime(&now);
-	if (tm)
-		strftime(ev.timestamp, sizeof(ev.timestamp),
-			 "%Y-%m-%d %H:%M:%S %z", tm);
-	else
-		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
+	get_timestamp(s, record, ras, (char *)&ev.timestamp, sizeof(ev.timestamp));
 	if (trace_seq_printf(s, "%s ", ev.timestamp) <= 0)
 		return -1;
 
-- 
2.25.1


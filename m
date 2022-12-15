Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A838264DBDB
	for <lists+linux-edac@lfdr.de>; Thu, 15 Dec 2022 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLONBn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 15 Dec 2022 08:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiLONBm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 15 Dec 2022 08:01:42 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D89252B5
        for <linux-edac@vger.kernel.org>; Thu, 15 Dec 2022 05:01:41 -0800 (PST)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NXshJ6DtpzqT8B;
        Thu, 15 Dec 2022 20:57:20 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 15 Dec
 2022 21:01:38 +0800
From:   Lv Ying <lvying6@huawei.com>
To:     <mchehab@kernel.org>
CC:     <linux-edac@vger.kernel.org>, <xiezhipeng1@huawei.com>,
        <lvying6@huawei.com>
Subject: [PATCH] rasdaemon/diskerror: fix incomplete diskerror log
Date:   Thu, 15 Dec 2022 21:01:59 +0800
Message-ID: <20221215130159.1000843-1-lvying6@huawei.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently, rasdaemon output incomplete diskerror log(only contains timestamp):
<idle>-0     [000]     0.017915: block_rq_complete:    2022-12-16 04:17:32 +0800

Fix incomplete diskerror log just like block_rq_complete tracepoint output format:
<idle>-0       [042] d.h. 177962.715669: block_rq_complete: 21,0 N () 18446744073709551615 + 0 [-121]
---
 ras-diskerror-handler.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/ras-diskerror-handler.c b/ras-diskerror-handler.c
index b16319f..0a6e315 100644
--- a/ras-diskerror-handler.c
+++ b/ras-diskerror-handler.c
@@ -97,26 +97,32 @@ int ras_diskerror_event_handler(struct trace_seq *s,
 	dev = (dev_t)val;
 	if (asprintf(&ev.dev, "%u:%u", major(dev), minor(dev)) < 0)
 		return -1;
+	trace_seq_printf(s, "%s ", ev.dev);
+
+	ev.rwbs = pevent_get_field_raw(s, event, "rwbs", record, &len, 1);
+	if (!ev.rwbs)
+		return -1;
+	trace_seq_printf(s, "%s ", ev.rwbs);
+
+	ev.cmd = pevent_get_field_raw(s, event, "cmd", record, &len, 1);
+	if (!ev.cmd)
+		return -1;
+	trace_seq_printf(s, "(%s) ", ev.cmd);
 
 	if (pevent_get_field_val(s, event, "sector", record, &val, 1) < 0)
 		return -1;
 	ev.sector = val;
+	trace_seq_printf(s, "%llu ", ev.sector);
 
 	if (pevent_get_field_val(s, event, "nr_sector", record, &val, 1) < 0)
 		return -1;
 	ev.nr_sector = (unsigned int)val;
+	trace_seq_printf(s, "+ %u ", ev.nr_sector);
 
 	if (pevent_get_field_val(s, event, "error", record, &val, 1) < 0)
 		return -1;
 	ev.error = get_blk_error((int)val);
-
-	ev.rwbs = pevent_get_field_raw(s, event, "rwbs", record, &len, 1);
-	if (!ev.rwbs)
-		return -1;
-
-	ev.cmd = pevent_get_field_raw(s, event, "cmd", record, &len, 1);
-	if (!ev.cmd)
-		return -1;
+	trace_seq_printf(s, "[%s]", ev.error);
 
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
-- 
2.36.1


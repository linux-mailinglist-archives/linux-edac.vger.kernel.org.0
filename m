Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B31700423
	for <lists+linux-edac@lfdr.de>; Fri, 12 May 2023 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239803AbjELJnZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 12 May 2023 05:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbjELJmr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 12 May 2023 05:42:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C95D12481
        for <linux-edac@vger.kernel.org>; Fri, 12 May 2023 02:42:03 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHkJT0QMRz67l04;
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
Subject: [PATCH 1/4] rasdaemon: fix return value type issue of read/write function from unistd.h
Date:   Fri, 12 May 2023 17:41:26 +0800
Message-ID: <20230512094129.1468-2-shiju.jose@huawei.com>
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

The return value type of read/write function from unistd.h is ssize_t.
It's signed normally, and return -1 on error. Fix incorrect use in the
function read_ras_event_all_cpus().

BTW, make setting buffer_percent as a separate function.

Fixes: 94750bcf9309 ("rasdaemon: Fix poll() on per_cpu trace_pipe_raw blocks indefinitely")
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/ras-events.c b/ras-events.c
index 2662467..d041828 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -368,10 +368,37 @@ static int get_num_cpus(struct ras_events *ras)
 #endif
 }
 
+static int set_buffer_percent(struct ras_events *ras, int percent)
+{
+	char buf[16];
+	ssize_t size;
+	int res = 0;
+	int fd;
+
+	fd = open_trace(ras, "buffer_percent", O_WRONLY);
+	if (fd >= 0) {
+		/* For the backward compatibility to the old kernels, do not return
+		 * if fail to set the buffer_percent.
+		 */
+		snprintf(buf, sizeof(buf), "%d", percent);
+		size = write(fd, buf, strlen(buf));
+		if (size <= 0) {
+			log(TERM, LOG_WARNING, "can't write to buffer_percent\n");
+			res = -1;
+		}
+		close(fd);
+	} else {
+		log(TERM, LOG_WARNING, "Can't open buffer_percent\n");
+		res = -1;
+	}
+
+	return res;
+}
+
 static int read_ras_event_all_cpus(struct pthread_data *pdata,
 				   unsigned n_cpus)
 {
-	unsigned size;
+	ssize_t size;
 	unsigned long long time_stamp;
 	void *data;
 	int ready, i, count_nready;
@@ -383,8 +410,6 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	int warnonce[n_cpus];
 	char pipe_raw[PATH_MAX];
 	int legacy_kernel = 0;
-	int fd;
-	char buf[16];
 #if 0
 	int need_sleep = 0;
 #endif
@@ -411,18 +436,8 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	 * Set buffer_percent to 0 so that poll() will return immediately
 	 * when the trace data is available in the ras per_cpu trace pipe_raw
 	 */
-	fd = open_trace(pdata[0].ras, "buffer_percent", O_WRONLY);
-	if (fd >= 0) {
-		/* For the backward compatibility to the old kernels, do not return
-		 * if fail to set the buffer_percent.
-		 */
-		snprintf(buf, sizeof(buf), "0");
-		size = write(fd, buf, strlen(buf));
-		if (size <= 0)
-			log(TERM, LOG_WARNING, "can't write to buffer_percent\n");
-		close(fd);
-	} else
-		log(TERM, LOG_WARNING, "Can't open buffer_percent\n");
+	if (set_buffer_percent(pdata[0].ras, 0))
+		log(TERM, LOG_WARNING, "Set buffer_percent failed\n");
 
 	for (i = 0; i < (n_cpus + 1); i++)
 		fds[i].fd = -1;
-- 
2.25.1


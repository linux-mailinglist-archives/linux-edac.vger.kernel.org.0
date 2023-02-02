Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229D5688649
	for <lists+linux-edac@lfdr.de>; Thu,  2 Feb 2023 19:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjBBSYA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Feb 2023 13:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjBBSX7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Feb 2023 13:23:59 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC50C65F02;
        Thu,  2 Feb 2023 10:23:57 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P76XB6ZHdz67bmq;
        Fri,  3 Feb 2023 02:20:10 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.167) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 18:23:55 +0000
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/1] rasdaemon: Fix poll() on per_cpu trace_pipe_raw do not retun
Date:   Thu, 2 Feb 2023 18:23:51 +0000
Message-ID: <20230202182352.792-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.151.167]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
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

The error events are not received in the rasdaemon since kernel 6.1-rc6.
This issue is firstly detected and reported, when testing the CXL error
events in the rasdaemon.

Debugging showed, poll() on trace_pipe_raw in the ras-events.c do not return.
and this issue is seen after the commit
42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
polling block on watermark").

This also verified using the test application for poll()
and select() on trace_pipe_raw.

There is also a bug reported on this issue, 
https://lore.kernel.org/all/31eb3b12-3350-90a4-a0d9-d1494db7cf74@oracle.com/

This issue occurs for the per_cpu case, when calling the ring_buffer_poll_wait(),
in kernel/trace/ring_buffer.c, with the buffer_percent > 0 and then wait until the
percentage of pages are available. The default value set for the buffer_percent is 50
in the kernel/trace/trace.c.

As a fix, rasdaemon set buffer_percent = 0 through the
/sys/kernel/debug/tracing/instances/rasdaemon/buffer_percent, then the task will
wake up as soon as data is added to any of the specific cpu buffer and
poll() on per_cpu/cpuX/trace_pipe_raw does not block indefinitely.

Depends on kernel patch
tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/ras-events.c b/ras-events.c
index 3691311..72225a9 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -383,6 +383,8 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	int warnonce[n_cpus];
 	char pipe_raw[PATH_MAX];
 	int legacy_kernel = 0;
+	int fd;
+	char buf[2];
 #if 0
 	int need_sleep = 0;
 #endif
@@ -402,6 +404,33 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		return -ENOMEM;
 	}
 
+	/* Fix for poll() do not return on per_cpu trace_pipe and
+	 * trace_pipe_raw with the default buffer_percent in the kernel trace,
+	 * introduced by the following change in the kernel
+	 * https://lore.kernel.org/all/20221020231427.41be3f26@gandalf.local.home/T/#u.
+	 * Set buffer_percent to 0 so that poll() returned immediately
+	 * when the trace data is available in the ras per_cpu trace pipe_raw */
+	fd = open_trace(pdata[0].ras, "buffer_percent", O_RDWR);
+	if (fd < 0) {
+		log(TERM, LOG_ERR, "Can't open trace buffer_percent\n");
+		return -1;
+	}
+	size = write(fd, "0", 1);
+	if (size <= 0) {
+		log(TERM, LOG_ERR, "Can't set rasdaemon trace buffer_percent\n");
+		return -1;
+	}
+	size = read(fd, buf, 1);
+	if (size <= 0) {
+		log(TERM, LOG_ERR, "Can't read rasdaemon trace buffer_percent\n");
+		return -1;
+	}
+	if (atoi(buf) != 0) {
+		log(TERM, LOG_ERR, "Can't verify rasdaemon trace buffer_percent\n");
+		return -1;
+	}
+	close(fd);
+
 	for (i = 0; i < (n_cpus + 1); i++)
 		fds[i].fd = -1;
 
-- 
2.25.1


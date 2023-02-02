Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADF0688647
	for <lists+linux-edac@lfdr.de>; Thu,  2 Feb 2023 19:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjBBSXg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Feb 2023 13:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbjBBSXf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 2 Feb 2023 13:23:35 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BD5EF85;
        Thu,  2 Feb 2023 10:23:34 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P76W72gbJz67KVh;
        Fri,  3 Feb 2023 02:19:15 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.167) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 18:23:32 +0000
From:   <shiju.jose@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>, <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
        <tanxiaofei@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/1] tracing: Fix poll() and select() do not work on per_cpu trace_pipe and trace_pipe_raw
Date:   Thu, 2 Feb 2023 18:23:09 +0000
Message-ID: <20230202182309.742-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.151.167]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
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

poll() and select() on per_cpu trace_pipe and trace_pipe_raw do not work
since kernel 6.1-rc6. This issue is seen after the commit
42fb0a1e84ff525ebe560e2baf9451ab69127e2b ("tracing/ring-buffer: Have
polling block on watermark").

This issue is firstly detected and reported, when testing the CXL error
events in the rasdaemon and also erified using the test application for poll()
and select().

This issue occurs for the per_cpu case, when calling the ring_buffer_poll_wait(),
in kernel/trace/ring_buffer.c, with the buffer_percent > 0 and then wait until the
percentage of pages are available. The default value set for the buffer_percent is 50
in the kernel/trace/trace.c.

As a fix, allow userspace application could set buffer_percent as 0 through
the buffer_percent_fops, so that the task will wake up as soon as data is added
to any of the specific cpu buffer.

Fixes: 42fb0a1e84ff5 ("tracing/ring-buffer: Have polling block on watermark")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 kernel/trace/trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a555a861b978..01164c78483a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9148,9 +9148,6 @@ buffer_percent_write(struct file *filp, const char __user *ubuf,
 	if (val > 100)
 		return -EINVAL;
 
-	if (!val)
-		val = 1;
-
 	tr->buffer_percent = val;
 
 	(*ppos)++;
-- 
2.25.1


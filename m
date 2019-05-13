Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCF211C074
	for <lists+linux-edac@lfdr.de>; Tue, 14 May 2019 04:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfENCFb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 May 2019 22:05:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726327AbfENCFb (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 13 May 2019 22:05:31 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6A62EF73079E742C9E90;
        Tue, 14 May 2019 10:05:28 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 May 2019
 10:05:19 +0800
From:   Ying Lv <lvying6@huawei.com>
To:     <mchehab@s-opensource.com>, <linux-edac@vger.kernel.org>
CC:     <shanshishi@huawei.com>, <hehuazhen@huawei.com>,
        <chenjialong@huawei.com>, <xiezhipeng1@huawei.com>,
        <xuchunmei@huawei.com>
Subject: [PATCH] fix rasdaemon high CPU usage when part of CPUs offline
Date:   Tue, 14 May 2019 06:16:11 +0800
Message-ID: <20190513221611.10851-1-lvying6@huawei.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When we set part of CPU core offline, such as by setting the kernel cmdline
maxcpus = N(N is less than the total number of system CPU cores).
And then, we will observe that the CPU usage of some rasdaemon threads
is very close to 100.

This is because when part of CPU offline, poll in read_ras_event_all_cpus func
will fallback to pthread way.
Offlined CPU thread will return negative value when read trace_pipe_raw,
negative return value will covert to positive value because of 'unsigned size'.
So code will always go into 'size > 0' branch, and the CPU usage is too high.

Here, variable size uses int type will go to the right branch.

Fiexs: eff7c9e0("ras-events: Only use pthreads for collect if poll() not available")
Reported-by: Zhipeng Xie <xiezhipeng1@huawei.com>
Signed-off-by: Ying Lv <lvying6@huawei.com>
---
 ras-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ras-events.c b/ras-events.c
index 9395f6f..1094df0 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -421,7 +421,7 @@ static int read_ras_event(int fd,
 			  struct kbuffer *kbuf,
 			  void *page)
 {
-	unsigned size;
+	int size;
 	unsigned long long time_stamp;
 	void *data;
 
-- 
2.21.0


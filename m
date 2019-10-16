Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB8BD977B
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405888AbfJPQe3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 12:34:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfJPQe3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 12:34:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4C50A5BB5C39C4F8DC2;
        Thu, 17 Oct 2019 00:34:26 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 00:34:17 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 1/7] rasdaemon: fix cleanup issues in ras-events.c:read_ras_event_all_cpus()
Date:   Wed, 16 Oct 2019 17:33:55 +0100
Message-ID: <20191016163401.16980-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20191016163401.16980-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20191016163401.16980-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch fix memory leaks and close the open files if the
open_trace() or read(fds[i].fd, page, pdata[i].ras->page_size)
function calls fail.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/ras-events.c b/ras-events.c
index 3cdac19..d1773b1 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -353,6 +353,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	struct pollfd fds[n_cpus];
 	int warnonce[n_cpus];
 	char pipe_raw[PATH_MAX];
+	int legacy_kernel = 0;
 #if 0
 	int need_sleep = 0;
 #endif
@@ -372,6 +373,9 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		return -ENOMEM;
 	}
 
+	for (i = 0; i < n_cpus; i++)
+		fds[i].fd = -1;
+
 	for (i = 0; i < n_cpus; i++) {
 		fds[i].events = POLLIN;
 
@@ -382,9 +386,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		fds[i].fd = open_trace(pdata[0].ras, pipe_raw, O_RDONLY);
 		if (fds[i].fd < 0) {
 			log(TERM, LOG_ERR, "Can't open trace_pipe_raw\n");
-			kbuffer_free(kbuf);
-			free(page);
-			return -EINVAL;
+			goto error;
 		}
 	}
 
@@ -416,7 +418,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 			size = read(fds[i].fd, page, pdata[i].ras->page_size);
 			if (size < 0) {
 				log(TERM, LOG_WARNING, "read\n");
-				return -1;
+				goto error;
 			} else if (size > 0) {
 				kbuffer_load_subbuffer(kbuf, page);
 
@@ -441,6 +443,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		 */
 		if (count_nready == n_cpus) {
 			/* Should only happen with legacy kernels */
+			legacy_kernel = 1;
 			break;
 		}
 #endif
@@ -449,12 +452,18 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	/* poll() is not supported. We need to fallback to the old way */
 	log(TERM, LOG_INFO,
 	    "Old kernel detected. Stop listening and fall back to pthread way.\n");
+error:
 	kbuffer_free(kbuf);
 	free(page);
-	for (i = 0; i < n_cpus; i++)
-		close(fds[i].fd);
+	for (i = 0; i < n_cpus; i++) {
+		if (fds[i].fd > 0)
+			close(fds[i].fd);
+	}
 
-	return -255;
+	if (legacy_kernel)
+		return -255;
+	else
+		return -1;
 }
 
 static int read_ras_event(int fd,
-- 
2.1.4



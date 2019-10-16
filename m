Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE5CD9784
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbfJPQep (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 12:34:45 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4229 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405428AbfJPQep (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 12:34:45 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CE2DE6407188DB20BBCB;
        Thu, 17 Oct 2019 00:34:36 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 00:34:28 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 7/7] rasdaemon: add signal handling for the cleanup
Date:   Wed, 16 Oct 2019 17:34:01 +0100
Message-ID: <20191016163401.16980-8-shiju.jose@huawei.com>
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

Presently rasdaemon would not free allocated memory and
would not do other cleanup when the rasdaemon closed
with ctrl+c or kill etc.
This patch adds handling of the signals SIGINT, SIGTERM, SIGHUP
and SIGQUIT and do necessary clean ups when receive the
specified signals.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/ras-events.c b/ras-events.c
index d155caa..511c93d 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -25,6 +25,8 @@
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/poll.h>
+#include <signal.h>
+#include <sys/signalfd.h>
 #include "libtrace/kbuffer.h"
 #include "libtrace/event-parse.h"
 #include "ras-mc-handler.h"
@@ -350,7 +352,9 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 	int ready, i, count_nready;
 	struct kbuffer *kbuf;
 	void *page;
-	struct pollfd fds[n_cpus];
+	struct pollfd fds[n_cpus + 1];
+	struct signalfd_siginfo fdsiginfo;
+	sigset_t mask;
 	int warnonce[n_cpus];
 	char pipe_raw[PATH_MAX];
 	int legacy_kernel = 0;
@@ -373,7 +377,7 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		return -ENOMEM;
 	}
 
-	for (i = 0; i < n_cpus; i++)
+	for (i = 0; i < (n_cpus + 1); i++)
 		fds[i].fd = -1;
 
 	for (i = 0; i < n_cpus; i++) {
@@ -390,15 +394,51 @@ static int read_ras_event_all_cpus(struct pthread_data *pdata,
 		}
 	}
 
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGINT);
+	sigaddset(&mask, SIGTERM);
+	sigaddset(&mask, SIGHUP);
+	sigaddset(&mask, SIGQUIT);
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) == -1)
+		log(TERM, LOG_WARNING, "sigprocmask\n");
+	fds[n_cpus].events = POLLIN;
+	fds[n_cpus].fd = signalfd(-1, &mask, 0);
+	if (fds[n_cpus].fd < 0) {
+		log(TERM, LOG_WARNING, "signalfd\n");
+		goto error;
+	}
+
 	log(TERM, LOG_INFO, "Listening to events for cpus 0 to %d\n", n_cpus - 1);
 	if (pdata[0].ras->record_events)
 		ras_mc_event_opendb(pdata[0].cpu, pdata[0].ras);
 
 	do {
-		ready = poll(fds, n_cpus, -1);
+		ready = poll(fds, (n_cpus + 1), -1);
 		if (ready < 0) {
 			log(TERM, LOG_WARNING, "poll\n");
 		}
+
+		/* check for the signal */
+		if (fds[n_cpus].revents & POLLIN) {
+			size = read(fds[n_cpus].fd, &fdsiginfo,
+				    sizeof(struct signalfd_siginfo));
+			if (size != sizeof(struct signalfd_siginfo))
+				log(TERM, LOG_WARNING, "signalfd read\n");
+
+			if (fdsiginfo.ssi_signo == SIGINT ||
+			    fdsiginfo.ssi_signo == SIGTERM ||
+			    fdsiginfo.ssi_signo == SIGHUP ||
+			    fdsiginfo.ssi_signo == SIGQUIT) {
+				log(TERM, LOG_INFO, "Recevied signal=%d\n",
+				    fdsiginfo.ssi_signo);
+				goto  cleanup;
+			} else {
+				log(TERM, LOG_INFO,
+				    "Received unexpected signal=%d\n",
+				    fdsiginfo.ssi_signo);
+			}
+		}
+
 		count_nready = 0;
 		for (i = 0; i < n_cpus; i++) {
 			if (fds[i].revents & POLLERR) {
@@ -462,7 +502,9 @@ cleanup:
 error:
 	kbuffer_free(kbuf);
 	free(page);
-	for (i = 0; i < n_cpus; i++) {
+	sigprocmask(SIG_UNBLOCK, &mask, NULL);
+
+	for (i = 0; i < (n_cpus + 1); i++) {
 		if (fds[i].fd > 0)
 			close(fds[i].fd);
 	}
-- 
2.1.4



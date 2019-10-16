Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D95B0D977E
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 18:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405459AbfJPQee (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 12:34:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4227 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730251AbfJPQed (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 12:34:33 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B4790F4FF67101A94860;
        Thu, 17 Oct 2019 00:34:31 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 00:34:22 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 4/7] rasdaemon: fix memory leak in ras-events.c:add_event_handler()
Date:   Wed, 16 Oct 2019 17:33:58 +0100
Message-ID: <20191016163401.16980-5-shiju.jose@huawei.com>
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

This patch rearranges the free(page) call to prevent the
memory leak when __toggle_ras_mc_event() fail.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ras-events.c b/ras-events.c
index fc6b288..f912dae 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -688,6 +688,7 @@ static int add_event_handler(struct ras_events *ras, struct pevent *pevent,
 
 	/* Enable RAS events */
 	rc = __toggle_ras_mc_event(ras, group, event, 1);
+	free(page);
 	if (rc < 0) {
 		log(TERM, LOG_ERR, "Can't enable %s:%s tracing\n",
 		    group, event);
@@ -697,7 +698,6 @@ static int add_event_handler(struct ras_events *ras, struct pevent *pevent,
 
 	log(ALL, LOG_INFO, "Enabled event %s:%s\n", group, event);
 
-	free(page);
 	return 0;
 }
 
-- 
2.1.4



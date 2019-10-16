Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0647D977C
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 18:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfJPQe3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 12:34:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4191 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730251AbfJPQe3 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 12:34:29 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B11D79A0D81127DA638A;
        Thu, 17 Oct 2019 00:34:26 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 00:34:19 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 2/7] rasdaemon: fix memory leak in ras-events.c:handle_ras_events()
Date:   Wed, 16 Oct 2019 17:33:56 +0100
Message-ID: <20191016163401.16980-3-shiju.jose@huawei.com>
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

This patch fix memory leak in handle_ras_events()
when failed to trace all supported RAS events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-events.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ras-events.c b/ras-events.c
index d1773b1..d543251 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -846,7 +846,8 @@ int handle_ras_events(int record_events)
 	if (!num_events) {
 		log(ALL, LOG_INFO,
 		    "Failed to trace all supported RAS events. Aborting.\n");
-		return EINVAL;
+		rc = -EINVAL;
+		goto err;
 	}
 
 	data = calloc(sizeof(*data), cpus);
-- 
2.1.4



Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94F29D9780
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2019 18:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404724AbfJPQee (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 16 Oct 2019 12:34:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4228 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404676AbfJPQee (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 16 Oct 2019 12:34:34 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BB5E56CA3D3A6D709533;
        Thu, 17 Oct 2019 00:34:31 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.439.0; Thu, 17 Oct 2019 00:34:24 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 5/7] rasdaemon: delete multiple definitions of ARRAY_SIZE
Date:   Wed, 16 Oct 2019 17:33:59 +0100
Message-ID: <20191016163401.16980-6-shiju.jose@huawei.com>
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

This patch deletes multiple definitions of ARRAY_SIZE and
move the definition to a common file.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-diskerror-handler.c | 2 --
 ras-mce-handler.h       | 3 ---
 ras-record.c            | 3 ---
 ras-record.h            | 2 ++
 4 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/ras-diskerror-handler.c b/ras-diskerror-handler.c
index 271dfac..68c0c77 100644
--- a/ras-diskerror-handler.c
+++ b/ras-diskerror-handler.c
@@ -50,8 +50,6 @@ static const struct {
 	{ -EIO,       "I/O error" },
 };
 
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
-
 static const char *get_blk_error(int err)
 {
 	int i;
diff --git a/ras-mce-handler.h b/ras-mce-handler.h
index 94395eb..4d615b4 100644
--- a/ras-mce-handler.h
+++ b/ras-mce-handler.h
@@ -24,9 +24,6 @@
 #include "ras-events.h"
 #include "libtrace/event-parse.h"
 
-
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
-
 enum cputype {
 	CPU_GENERIC,
 	CPU_P6OLD,
diff --git a/ras-record.c b/ras-record.c
index ae5d359..8f1c550 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -35,9 +35,6 @@
 
 #define SQLITE_RAS_DB RASSTATEDIR "/" RAS_DB_FNAME
 
-
-#define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
-
 /*
  * Table and functions to handle ras:mc_event
  */
diff --git a/ras-record.h b/ras-record.h
index 5311c67..c9af5ae 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -23,6 +23,8 @@
 #include <stdint.h>
 #include "config.h"
 
+#define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
+
 extern long user_hz;
 
 struct ras_events *ras;
-- 
2.1.4



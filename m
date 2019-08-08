Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A794B85809
	for <lists+linux-edac@lfdr.de>; Thu,  8 Aug 2019 04:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfHHCQu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 22:16:50 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51488 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727230AbfHHCQt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 7 Aug 2019 22:16:49 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DA486DBA3BB31A386D65;
        Thu,  8 Aug 2019 10:16:47 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 10:16:37 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH 1/1] rasdaemon: fix the issue of sqlite3 integer bind parameter mismatch
Date:   Thu, 8 Aug 2019 10:14:30 +0800
Message-ID: <1565230470-52916-1-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Some interger fields of arm_event and mc_event are 8 bytes width,
and sqlite3_bind_int64() should be used when restore the event to
sqlite3. But we use sqlite3_bind_int() in current code. This will
lead to an wrong value in sqlite3 DB.

This patch is to fix the issue.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 ras-record.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ras-record.c b/ras-record.c
index 4c8b55b..0bf0080 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -94,9 +94,9 @@ int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev)
 	sqlite3_bind_int (priv->stmt_mc_event,  7, ev->top_layer);
 	sqlite3_bind_int (priv->stmt_mc_event,  8, ev->middle_layer);
 	sqlite3_bind_int (priv->stmt_mc_event,  9, ev->lower_layer);
-	sqlite3_bind_int (priv->stmt_mc_event, 10, ev->address);
-	sqlite3_bind_int (priv->stmt_mc_event, 11, ev->grain);
-	sqlite3_bind_int (priv->stmt_mc_event, 12, ev->syndrome);
+	sqlite3_bind_int64 (priv->stmt_mc_event, 10, ev->address);
+	sqlite3_bind_int64 (priv->stmt_mc_event, 11, ev->grain);
+	sqlite3_bind_int64 (priv->stmt_mc_event, 12, ev->syndrome);
 	sqlite3_bind_text(priv->stmt_mc_event, 13, ev->driver_detail, -1, NULL);
 	rc = sqlite3_step(priv->stmt_mc_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
@@ -242,7 +242,7 @@ int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev)
 	sqlite3_bind_text (priv->stmt_arm_record,  1,  ev->timestamp, -1, NULL);
 	sqlite3_bind_int  (priv->stmt_arm_record,  2,  ev->error_count);
 	sqlite3_bind_int  (priv->stmt_arm_record,  3,  ev->affinity);
-	sqlite3_bind_int  (priv->stmt_arm_record,  4,  ev->mpidr);
+	sqlite3_bind_int64  (priv->stmt_arm_record,  4,  ev->mpidr);
 	sqlite3_bind_int  (priv->stmt_arm_record,  5,  ev->running_state);
 	sqlite3_bind_int  (priv->stmt_arm_record,  6,  ev->psci_state);
 
-- 
2.8.1


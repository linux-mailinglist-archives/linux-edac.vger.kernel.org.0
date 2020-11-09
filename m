Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D412AB8A2
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 13:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKIMvc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 Nov 2020 07:51:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7160 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729797AbgKIMvN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Nov 2020 07:51:13 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CV9pC45Tpz15MFT;
        Mon,  9 Nov 2020 20:50:43 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Nov 2020
 20:50:40 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <fanwentao@huawei.com>
Subject: [PATCH] ras-record: fix memory leak when sqlite3_open_v2 fails
Date:   Mon, 9 Nov 2020 20:49:23 +0800
Message-ID: <1604926163-27370-1-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

According to SQLite documentation, a database connection handle
is usually returned, even if an error occurs. This behavior has
caused rasdaemon to leak memory when opening a database is failed. Now,
even if sqlite3_open_v2() does not return SQLITE_OK, rasdaemon tries to
release SQLite database handle by calling sqlite3_close_v2().

Signed-off-by: lvying6 <lvying6@huawei.com>
---
 ras-record.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ras-record.c b/ras-record.c
index 549c494..dc89f01 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -726,6 +726,8 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 	} while (rc == SQLITE_BUSY);
 
 	if (rc != SQLITE_OK) {
+		sqlite3_close_v2(db);
+		db = NULL;
 		log(TERM, LOG_ERR,
 		    "cpu %u: Failed to connect to %s: error = %d\n",
 		    cpu, SQLITE_RAS_DB, rc);
-- 
1.8.3.1


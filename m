Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A77E9A51F0
	for <lists+linux-edac@lfdr.de>; Mon,  2 Sep 2019 10:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbfIBIiZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 2 Sep 2019 04:38:25 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3965 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729408AbfIBIiZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 2 Sep 2019 04:38:25 -0400
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id EC5FCDCAF5A8EAF0A371;
        Mon,  2 Sep 2019 16:38:23 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 16:38:23 +0800
Received: from DGGEMM534-MBX.china.huawei.com ([169.254.8.49]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0439.000;
 Mon, 2 Sep 2019 16:38:18 +0800
From:   tanxiaofei <tanxiaofei@huawei.com>
To:     "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: Re: [PATCH 1/1] rasdaemon: fix the issue of sqlite3 integer bind
 parameter mismatch
Thread-Topic: [PATCH 1/1] rasdaemon: fix the issue of sqlite3 integer bind
 parameter mismatch
Thread-Index: AdVhaVF/NotimrCXTHCfI6wY3A7Svw==
Date:   Mon, 2 Sep 2019 08:38:17 +0000
Message-ID: <5913F89621C075469A7BAF08CC5DFC11A931D32B@dggemm534-mbx.china.huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.184.86]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Mchehab, 
Could you please review this patch? Thanks..

.....

Some interger fields of arm_event and mc_event are 8 bytes width, and sqlite3_bind_int64() should be used when restore the event to sqlite3. But we use sqlite3_bind_int() in current code. This will lead to an wrong value in sqlite3 DB.

This patch is to fix the issue.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 ras-record.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/ras-record.c b/ras-record.c index 4c8b55b..0bf0080 100644
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
 	if (rc != SQLITE_OK && rc != SQLITE_DONE) @@ -242,7 +242,7 @@ int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev)
 	sqlite3_bind_text (priv->stmt_arm_record,  1,  ev->timestamp, -1, NULL);
 	sqlite3_bind_int  (priv->stmt_arm_record,  2,  ev->error_count);
 	sqlite3_bind_int  (priv->stmt_arm_record,  3,  ev->affinity);
-	sqlite3_bind_int  (priv->stmt_arm_record,  4,  ev->mpidr);
+	sqlite3_bind_int64  (priv->stmt_arm_record,  4,  ev->mpidr);
 	sqlite3_bind_int  (priv->stmt_arm_record,  5,  ev->running_state);
 	sqlite3_bind_int  (priv->stmt_arm_record,  6,  ev->psci_state);
 
--
2.8.1


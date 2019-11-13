Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5749FFB51D
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2019 17:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKMQbf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Nov 2019 11:31:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56090 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728402AbfKMQbf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 13 Nov 2019 11:31:35 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E63E79D9FAD5E5310762;
        Thu, 14 Nov 2019 00:31:32 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.55) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Thu, 14 Nov 2019 00:31:25 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH rasdaemon 2/2] rasdaemon: store PCIe dev name and TLP header for the aer event
Date:   Wed, 13 Nov 2019 16:31:13 +0000
Message-ID: <20191113163113.3356-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20191113163113.3356-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20191113163113.3356-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.55]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds logging and recording of the PCIe dev name and the
TLP header for the aer event.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-aer-handler.c | 21 ++++++++++++++++++++-
 ras-record.c      |  6 ++++--
 ras-record.h      |  2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/ras-aer-handler.c b/ras-aer-handler.c
index 664f7b4..8ddd439 100644
--- a/ras-aer-handler.c
+++ b/ras-aer-handler.c
@@ -52,6 +52,8 @@ static const char *aer_uncor_errors[32] = {
 	[20] = "Unsupported Request",
 };
 
+#define BUF_LEN	1024
+
 int ras_aer_event_handler(struct trace_seq *s,
 			 struct pevent_record *record,
 			 struct event_format *event, void *context)
@@ -59,11 +61,12 @@ int ras_aer_event_handler(struct trace_seq *s,
 	int len;
 	unsigned long long severity_val;
 	unsigned long long status_val;
+	unsigned long long val;
 	struct ras_events *ras = context;
 	time_t now;
 	struct tm *tm;
 	struct ras_aer_event ev;
-	char buf[1024];
+	char buf[BUF_LEN];
 
 	/*
 	 * Newer kernels (3.10-rc1 or upper) provide an uptime clock.
@@ -89,6 +92,7 @@ int ras_aer_event_handler(struct trace_seq *s,
 					   record, &len, 1);
 	if (!ev.dev_name)
 		return -1;
+	trace_seq_printf(s, "%s ", ev.dev_name);
 
 	if (pevent_get_field_val(s,  event, "status", record, &status_val, 1) < 0)
 		return -1;
@@ -104,6 +108,21 @@ int ras_aer_event_handler(struct trace_seq *s,
 	else
 		bitfield_msg(buf, sizeof(buf), aer_uncor_errors, 32, 0, 0, status_val);
 	ev.msg = buf;
+
+	if (pevent_get_field_val(s, event, "tlp_header_valid",
+				record, &val, 1) < 0)
+		return -1;
+
+	ev.tlp_header_valid = val;
+	if (ev.tlp_header_valid) {
+		ev.tlp_header = pevent_get_field_raw(s, event, "tlp_header",
+						     record, &len, 1);
+		snprintf((buf + strlen(ev.msg)), BUF_LEN - strlen(ev.msg),
+			 " TLP Header: %08x %08x %08x %08x",
+			 ev.tlp_header[0], ev.tlp_header[1],
+			 ev.tlp_header[2], ev.tlp_header[3]);
+	}
+
 	trace_seq_printf(s, "%s ", ev.msg);
 
 	/* Use hw_event_aer_err_type switch between different severity_val */
diff --git a/ras-record.c b/ras-record.c
index ca58b22..318bace 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -106,6 +106,7 @@ int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev)
 static const struct db_fields aer_event_fields[] = {
 		{ .name="id",			.type="INTEGER PRIMARY KEY" },
 		{ .name="timestamp",		.type="TEXT" },
+		{ .name="dev_name",		.type="TEXT" },
 		{ .name="err_type",		.type="TEXT" },
 		{ .name="err_msg",		.type="TEXT" },
 };
@@ -126,8 +127,9 @@ int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev)
 	log(TERM, LOG_INFO, "aer_event store: %p\n", priv->stmt_aer_event);
 
 	sqlite3_bind_text(priv->stmt_aer_event,  1, ev->timestamp, -1, NULL);
-	sqlite3_bind_text(priv->stmt_aer_event,  2, ev->error_type, -1, NULL);
-	sqlite3_bind_text(priv->stmt_aer_event,  3, ev->msg, -1, NULL);
+	sqlite3_bind_text(priv->stmt_aer_event,  2, ev->dev_name, -1, NULL);
+	sqlite3_bind_text(priv->stmt_aer_event,  3, ev->error_type, -1, NULL);
+	sqlite3_bind_text(priv->stmt_aer_event,  4, ev->msg, -1, NULL);
 
 	rc = sqlite3_step(priv->stmt_aer_event);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
diff --git a/ras-record.h b/ras-record.h
index 440669d..cc217a9 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -43,6 +43,8 @@ struct ras_aer_event {
 	char timestamp[64];
 	const char *error_type;
 	const char *dev_name;
+	uint8_t tlp_header_valid;
+	uint32_t *tlp_header;
 	const char *msg;
 };
 
-- 
1.9.1



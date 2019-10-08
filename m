Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD4FCFA2E
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfJHMmE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 08:42:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730883AbfJHMmE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 08:42:04 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4E8F7542217A6AE6E34C;
        Tue,  8 Oct 2019 20:41:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 20:41:50 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 4/5] rasdaemon: add timestamp for hip08 OEM error records in sqlite3 DB
Date:   Tue, 8 Oct 2019 20:38:57 +0800
Message-ID: <1570538338-230884-5-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
References: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch does two things:
1.Add timestamp for hip08 OEM error records in sqlite3 DB.
2.Add suffix "_v2" for hip08 OEM event names to keep compatibility
with old sqlite3 DB.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip07.c  |  9 ++++++---
 non-standard-hisi_hip08.c  | 41 ++++++++++++++++++++++++++++++++---------
 ras-non-standard-handler.c |  3 +--
 ras-non-standard-handler.h |  2 +-
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/non-standard-hisi_hip07.c b/non-standard-hisi_hip07.c
index 7f58fb3..09ddcb2 100644
--- a/non-standard-hisi_hip07.c
+++ b/non-standard-hisi_hip07.c
@@ -89,11 +89,13 @@ static char *sas_axi_err_type(int etype)
 
 static int decode_hip07_sas_error(struct ras_events *ras,
 				  struct ras_ns_dec_tab *dec_tab,
-				  struct trace_seq *s, const void *error)
+				  struct trace_seq *s,
+				  struct ras_non_standard_event *event)
 {
 	char buf[1024];
 	char *p = buf;
-	const struct hisi_sas_err_sec *err = error;
+	const struct hisi_sas_err_sec *err =
+			(struct hisi_sas_err_sec *)event->error;
 
 	if (err->val_bits == 0) {
 		trace_seq_printf(s, "%s: no valid error data\n",
@@ -124,7 +126,8 @@ static int decode_hip07_sas_error(struct ras_events *ras,
 
 static int decode_hip07_hns_error(struct ras_events *ras,
 				  struct ras_ns_dec_tab *dec_tab,
-				  struct trace_seq *s, const void *error)
+				  struct trace_seq *s,
+				  struct ras_non_standard_event *event)
 {
 	return 0;
 }
diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 002f4bf..61e19b7 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -140,6 +140,7 @@ enum hisi_oem_data_type {
 
 enum {
 	hip08_oem_type1_field_id,
+	hip08_oem_type1_field_timestamp,
 	hip08_oem_type1_field_version,
 	hip08_oem_type1_field_soc_id,
 	hip08_oem_type1_field_socket_id,
@@ -152,6 +153,7 @@ enum {
 
 enum {
 	hip08_oem_type2_field_id,
+	hip08_oem_type2_field_timestamp,
 	hip08_oem_type2_field_version,
 	hip08_oem_type2_field_soc_id,
 	hip08_oem_type2_field_socket_id,
@@ -164,6 +166,7 @@ enum {
 
 enum {
 	hip08_pcie_local_field_id,
+	hip08_pcie_local_field_timestamp,
 	hip08_pcie_local_field_version,
 	hip08_pcie_local_field_soc_id,
 	hip08_pcie_local_field_socket_id,
@@ -289,6 +292,7 @@ static char *pcie_local_sub_module_name(uint8_t id)
 #ifdef HAVE_SQLITE3
 static const struct db_fields hip08_oem_type1_event_fields[] = {
 	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",          .type = "TEXT" },
 	{ .name = "version",		.type = "INTEGER" },
 	{ .name = "soc_id",		.type = "INTEGER" },
 	{ .name = "socket_id",		.type = "INTEGER" },
@@ -300,13 +304,14 @@ static const struct db_fields hip08_oem_type1_event_fields[] = {
 };
 
 static const struct db_table_descriptor hip08_oem_type1_event_tab = {
-	.name = "hip08_oem_type1_event",
+	.name = "hip08_oem_type1_event_v2",
 	.fields = hip08_oem_type1_event_fields,
 	.num_fields = ARRAY_SIZE(hip08_oem_type1_event_fields),
 };
 
 static const struct db_fields hip08_oem_type2_event_fields[] = {
 	{ .name = "id",                 .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",          .type = "TEXT" },
 	{ .name = "version",            .type = "INTEGER" },
 	{ .name = "soc_id",             .type = "INTEGER" },
 	{ .name = "socket_id",          .type = "INTEGER" },
@@ -318,13 +323,14 @@ static const struct db_fields hip08_oem_type2_event_fields[] = {
 };
 
 static const struct db_table_descriptor hip08_oem_type2_event_tab = {
-	.name = "hip08_oem_type2_event",
+	.name = "hip08_oem_type2_event_v2",
 	.fields = hip08_oem_type2_event_fields,
 	.num_fields = ARRAY_SIZE(hip08_oem_type2_event_fields),
 };
 
 static const struct db_fields hip08_pcie_local_event_fields[] = {
 	{ .name = "id",                 .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",          .type = "TEXT" },
 	{ .name = "version",            .type = "INTEGER" },
 	{ .name = "soc_id",             .type = "INTEGER" },
 	{ .name = "socket_id",          .type = "INTEGER" },
@@ -338,7 +344,7 @@ static const struct db_fields hip08_pcie_local_event_fields[] = {
 };
 
 static const struct db_table_descriptor hip08_pcie_local_event_tab = {
-	.name = "hip08_pcie_local_event",
+	.name = "hip08_pcie_local_event_v2",
 	.fields = hip08_pcie_local_event_fields,
 	.num_fields = ARRAY_SIZE(hip08_pcie_local_event_fields),
 };
@@ -399,9 +405,11 @@ static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
 /* error data decoding functions */
 static int decode_hip08_oem_type1_error(struct ras_events *ras,
 					struct ras_ns_dec_tab *dec_tab,
-					struct trace_seq *s, const void *error)
+					struct trace_seq *s,
+					struct ras_non_standard_event *event)
 {
-	const struct hisi_oem_type1_err_sec *err = error;
+	const struct hisi_oem_type1_err_sec *err =
+			(struct hisi_oem_type1_err_sec*)event->error;
 	char buf[1024];
 	char *p = buf;
 
@@ -422,6 +430,9 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 		}
 	}
 #endif
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_oem_type1_field_timestamp,
+			   0, event->timestamp);
 
 	p += sprintf(p, "[ ");
 	p += sprintf(p, "table_version=%d ", err->version);
@@ -524,9 +535,11 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 
 static int decode_hip08_oem_type2_error(struct ras_events *ras,
 					struct ras_ns_dec_tab *dec_tab,
-					struct trace_seq *s, const void *error)
+					struct trace_seq *s,
+					struct ras_non_standard_event *event)
 {
-	const struct hisi_oem_type2_err_sec *err = error;
+	const struct hisi_oem_type2_err_sec *err =
+			(struct hisi_oem_type2_err_sec *)event->error;
 	char buf[1024];
 	char *p = buf;
 
@@ -546,6 +559,10 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 		}
 	}
 #endif
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_oem_type2_field_timestamp,
+			   0, event->timestamp);
+
 	p += sprintf(p, "[ ");
 	p += sprintf(p, "table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
@@ -657,9 +674,11 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 
 static int decode_hip08_pcie_local_error(struct ras_events *ras,
 					 struct ras_ns_dec_tab *dec_tab,
-					 struct trace_seq *s, const void *error)
+					 struct trace_seq *s,
+					 struct ras_non_standard_event *event)
 {
-	const struct hisi_pcie_local_err_sec *err = error;
+	const struct hisi_pcie_local_err_sec *err =
+			(struct hisi_pcie_local_err_sec *)event->error;
 	char buf[1024];
 	char *p = buf;
 	uint32_t i;
@@ -680,6 +699,10 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 		}
 	}
 #endif
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_pcie_local_field_timestamp,
+			   0, event->timestamp);
+
 	p += sprintf(p, "[ ");
 	p += sprintf(p, "table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index 4eda80b..1b5d67a 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -166,8 +166,7 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 		for (i = 0; dec_tab[i].decode; i++) {
 			if (uuid_le_cmp(ev.sec_type,
 					dec_tab[i].sec_type) == 0) {
-				dec_tab[i].decode(ras, &dec_tab[i],
-						  s, ev.error);
+				dec_tab[i].decode(ras, &dec_tab[i], s, &ev);
 				dec_done = true;
 				break;
 			}
diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index a7e48a3..fd9dd92 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -23,7 +23,7 @@
 typedef struct ras_ns_dec_tab {
 	const char *sec_type;
 	int (*decode)(struct ras_events *ras, struct ras_ns_dec_tab *dec_tab,
-		      struct trace_seq *s, const void *err);
+		      struct trace_seq *s, struct ras_non_standard_event *event);
 #ifdef HAVE_SQLITE3
 #include <sqlite3.h>
 	sqlite3_stmt *stmt_dec_record;
-- 
2.8.1


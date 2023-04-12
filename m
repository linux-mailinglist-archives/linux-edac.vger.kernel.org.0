Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394C06DEFB7
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjDLIxM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbjDLIxM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 04:53:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0649EDB;
        Wed, 12 Apr 2023 01:52:49 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGDX0q3xz67n97;
        Wed, 12 Apr 2023 16:32:44 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 09:33:41 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/7] rasdaemon: Add support for the CXL generic events
Date:   Wed, 12 Apr 2023 16:33:08 +0800
Message-ID: <20230412083312.1384-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230412083312.1384-1-shiju.jose@huawei.com>
References: <20230412083312.1384-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support to log and record the CXL generic events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 185 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |   3 +
 ras-events.c      |   9 +++
 ras-events.h      |   1 +
 ras-record.c      |  89 ++++++++++++++++++++++
 ras-record.h      |  25 +++++++
 ras-report.c      |  86 +++++++++++++++++++++
 ras-report.h      |   2 +
 8 files changed, 400 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index b08c5e3..59f87c0 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -56,6 +56,49 @@ static void get_timestamp(struct trace_seq *s, struct tep_record *record,
 		strncpy(ts_ptr, "1970-01-01 00:00:00 +0000", size);
 }
 
+struct cxl_event_flags {
+	uint32_t bit;
+	const char *flag;
+};
+
+static int decode_cxl_event_flags(struct trace_seq *s, uint32_t flags,
+				  const struct cxl_event_flags *cxl_ev_flags,
+				  uint8_t num_elems)
+{
+	int i;
+
+	for (i = 0; i < num_elems; i++) {
+		if (flags & cxl_ev_flags[i].bit)
+			if (trace_seq_printf(s, "\'%s\' ", cxl_ev_flags[i].flag) <= 0)
+				return -1;
+	}
+	return 0;
+}
+
+static char *uuid_be(const char *uu)
+{
+	static char uuid[sizeof("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")];
+	char *p = uuid;
+	int i;
+	static const unsigned char be[16] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15};
+
+	for (i = 0; i < 16; i++) {
+		p += sprintf(p, "%.2x", (unsigned char) uu[be[i]]);
+		switch (i) {
+		case 3:
+		case 5:
+		case 7:
+		case 9:
+			*p++ = '-';
+			break;
+		}
+	}
+
+	*p = 0;
+
+	return uuid;
+}
+
 /* Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
 #define CXL_POISON_FLAG_OVERFLOW        BIT(1)
@@ -516,3 +559,145 @@ int ras_cxl_overflow_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+/*
+ * Common Event Record Format
+ * CXL 3.0 section 8.2.9.2.1; Table 8-42
+ */
+#define CXL_EVENT_RECORD_FLAG_PERMANENT		BIT(2)
+#define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED	BIT(3)
+#define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED	BIT(4)
+#define CXL_EVENT_RECORD_FLAG_HW_REPLACE	BIT(5)
+
+static const struct  cxl_event_flags cxl_hdr_flags[] = {
+	{ .bit = CXL_EVENT_RECORD_FLAG_PERMANENT, .flag = "PERMANENT_CONDITION" },
+	{ .bit = CXL_EVENT_RECORD_FLAG_MAINT_NEEDED, .flag = "MAINTENANCE_NEEDED" },
+	{ .bit = CXL_EVENT_RECORD_FLAG_PERF_DEGRADED, .flag = "PERFORMANCE_DEGRADED" },
+	{ .bit = CXL_EVENT_RECORD_FLAG_HW_REPLACE, .flag = "HARDWARE_REPLACEMENT_NEEDED" },
+};
+
+static int handle_ras_cxl_common_hdr(struct trace_seq *s,
+				     struct tep_record *record,
+				     struct tep_event *event, void *context,
+				     struct ras_cxl_event_common_hdr *hdr)
+{
+	int len;
+	unsigned long long val;
+	struct ras_events *ras = context;
+
+	get_timestamp(s, record, ras, (char *)&hdr->timestamp, sizeof(hdr->timestamp));
+	if (trace_seq_printf(s, "%s ", hdr->timestamp) <= 0)
+		return -1;
+
+	hdr->memdev = tep_get_field_raw(s, event, "memdev", record, &len, 1);
+	if (!hdr->memdev)
+		return -1;
+	if (trace_seq_printf(s, "memdev:%s ", hdr->memdev) <= 0)
+		return -1;
+
+	hdr->host = tep_get_field_raw(s, event, "host", record, &len, 1);
+	if (!hdr->host)
+		return -1;
+	if (trace_seq_printf(s, "host:%s ", hdr->host) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "serial", record, &val, 1) < 0)
+		return -1;
+	hdr->serial = val;
+	if (trace_seq_printf(s, "serial:0x%llx ", (unsigned long long)hdr->serial) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "log", record, &val, 1) < 0)
+		return -1;
+	hdr->log_type = cxl_event_log_type_str(val);
+	if (trace_seq_printf(s, "log type:%s ", hdr->log_type) <= 0)
+		return -1;
+
+	hdr->hdr_uuid = tep_get_field_raw(s, event, "hdr_uuid", record, &len, 1);
+	if (!hdr->hdr_uuid)
+		return -1;
+	hdr->hdr_uuid = uuid_be(hdr->hdr_uuid);
+	if (trace_seq_printf(s, "hdr_uuid:%s ", hdr->hdr_uuid) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "hdr_flags", record, &val, 1) < 0)
+		return -1;
+	hdr->hdr_flags = val;
+	if (decode_cxl_event_flags(s, hdr->hdr_flags, cxl_hdr_flags,
+				   ARRAY_SIZE(cxl_hdr_flags)) < 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "hdr_handle", record, &val, 1) < 0)
+		return -1;
+	hdr->hdr_handle = val;
+	if (trace_seq_printf(s, "hdr_handle:0x%x ", hdr->hdr_handle) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "hdr_related_handle", record, &val, 1) < 0)
+		return -1;
+	hdr->hdr_related_handle = val;
+	if (trace_seq_printf(s, "hdr_related_handle:0x%x ", hdr->hdr_related_handle) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "hdr_timestamp", record, &val, 1) < 0)
+		return -1;
+	convert_timestamp(val, hdr->hdr_timestamp, sizeof(hdr->hdr_timestamp));
+	if (trace_seq_printf(s, "hdr_timestamp:%s ", hdr->hdr_timestamp) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "hdr_length", record, &val, 1) < 0)
+		return -1;
+	hdr->hdr_length = val;
+	if (trace_seq_printf(s, "hdr_length:%u ", hdr->hdr_length) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "hdr_maint_op_class", record, &val, 1) < 0)
+		return -1;
+	hdr->hdr_maint_op_class = val;
+	if (trace_seq_printf(s, "hdr_maint_op_class:%u ", hdr->hdr_maint_op_class) <= 0)
+		return -1;
+
+	return 0;
+}
+
+int ras_cxl_generic_event_handler(struct trace_seq *s,
+				  struct tep_record *record,
+				  struct tep_event *event, void *context)
+{
+	int len, i;
+	struct ras_events *ras = context;
+	struct ras_cxl_generic_event ev;
+	const uint8_t *buf;
+
+	memset(&ev, 0, sizeof(ev));
+	if (handle_ras_cxl_common_hdr(s, record, event, context, &ev.hdr) < 0)
+		return -1;
+
+	ev.data = tep_get_field_raw(s, event, "data", record, &len, 1);
+	if (!ev.data)
+		return -1;
+	i = 0;
+	buf = ev.data;
+	if (trace_seq_printf(s, "\ndata:\n  %08x: ", i) <= 0)
+		return -1;
+	for (i = 0; i < CXL_EVENT_RECORD_DATA_LENGTH; i += 4) {
+		if ((i > 0) && ((i % 16) == 0))
+			if (trace_seq_printf(s, "\n  %08x: ", i) <= 0)
+				break;
+		if (trace_seq_printf(s, "%02x%02x%02x%02x ",
+				     buf[i], buf[i+1], buf[i+2], buf[i+3]) <= 0)
+			break;
+	}
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_generic_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_generic_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index e7847ec..9f77cb7 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -32,4 +32,7 @@ int ras_cxl_aer_ce_event_handler(struct trace_seq *s,
 int ras_cxl_overflow_event_handler(struct trace_seq *s,
 				   struct tep_record *record,
 				   struct tep_event *event, void *context);
+int ras_cxl_generic_event_handler(struct trace_seq *s,
+				  struct tep_record *record,
+				  struct tep_event *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index ded8648..debdc87 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -249,6 +249,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_uncorrectable_error", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_correctable_error", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_overflow", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_generic_event", enable);
 #endif
 
 free_ras:
@@ -1013,6 +1014,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_overflow");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_generic_event",
+			       ras_cxl_generic_event_handler, NULL, CXL_GENERIC_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_generic_event");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index ea590c9..989ab29 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -43,6 +43,7 @@ enum {
 	CXL_AER_UE_EVENT,
 	CXL_AER_CE_EVENT,
 	CXL_OVERFLOW_EVENT,
+	CXL_GENERIC_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index 57fe117..36665aa 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -773,6 +773,79 @@ int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow
 
 	return rc;
 }
+
+static int ras_store_cxl_common_hdr(sqlite3_stmt *stmt, struct ras_cxl_event_common_hdr *hdr)
+{
+	if (!stmt || !hdr)
+		return 0;
+
+	sqlite3_bind_text(stmt, 1, hdr->timestamp, -1, NULL);
+	sqlite3_bind_text(stmt, 2, hdr->memdev, -1, NULL);
+	sqlite3_bind_text(stmt, 3, hdr->host, -1, NULL);
+	sqlite3_bind_int64(stmt, 4, hdr->serial);
+	sqlite3_bind_text(stmt, 5, hdr->log_type, -1, NULL);
+	sqlite3_bind_text(stmt, 6, hdr->hdr_uuid, -1, NULL);
+	sqlite3_bind_int(stmt, 7, hdr->hdr_flags);
+	sqlite3_bind_int(stmt, 8, hdr->hdr_handle);
+	sqlite3_bind_int(stmt, 9, hdr->hdr_related_handle);
+	sqlite3_bind_text(stmt, 10, hdr->hdr_timestamp, -1, NULL);
+	sqlite3_bind_int(stmt, 11, hdr->hdr_length);
+	sqlite3_bind_int(stmt, 12, hdr->hdr_maint_op_class);
+
+	return 0;
+}
+
+/*
+ * Table and functions to handle cxl:cxl_generic_event
+ */
+static const struct db_fields cxl_generic_event_fields[] = {
+	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",		.type = "TEXT" },
+	{ .name = "memdev",		.type = "TEXT" },
+	{ .name = "host",		.type = "TEXT" },
+	{ .name = "serial",		.type = "INTEGER" },
+	{ .name = "log_type",		.type = "TEXT" },
+	{ .name = "hdr_uuid",		.type = "TEXT" },
+	{ .name = "hdr_flags",		.type = "INTEGER" },
+	{ .name = "hdr_handle",		.type = "INTEGER" },
+	{ .name = "hdr_related_handle",	.type = "INTEGER" },
+	{ .name = "hdr_ts",		.type = "TEXT" },
+	{ .name = "hdr_length",		.type = "INTEGER" },
+	{ .name = "hdr_maint_op_class",	.type = "INTEGER" },
+	{ .name = "data",		.type = "BLOB" },
+};
+
+static const struct db_table_descriptor cxl_generic_event_tab = {
+	.name = "cxl_generic_event",
+	.fields = cxl_generic_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_generic_event_fields),
+};
+
+int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_generic_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_generic_event store: %p\n", priv->stmt_cxl_generic_event);
+
+	ras_store_cxl_common_hdr(priv->stmt_cxl_generic_event, &ev->hdr);
+	sqlite3_bind_blob(priv->stmt_cxl_generic_event, 13, ev->data,
+			  CXL_EVENT_RECORD_DATA_LENGTH, NULL);
+
+	rc = sqlite3_step(priv->stmt_cxl_generic_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do stmt_cxl_generic_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_generic_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset stmt_cxl_generic_event on sqlite: error = %d\n", rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
 #endif
 
 /*
@@ -1144,6 +1217,14 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		if (rc != SQLITE_OK)
 			goto error;
 	}
+
+	rc = ras_mc_create_table(priv, &cxl_generic_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_generic_event,
+					 &cxl_generic_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 	ras->db_priv = priv;
@@ -1290,6 +1371,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_overflow_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_generic_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_generic_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_generic_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index 90db6ad..9ecfcda 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -133,6 +133,7 @@ struct ras_cxl_poison_event {
 #define SZ_512                          0x200
 #define CXL_HEADERLOG_SIZE              SZ_512
 #define CXL_HEADERLOG_SIZE_U32          (SZ_512 / sizeof(uint32_t))
+#define CXL_EVENT_RECORD_DATA_LENGTH	0x50
 
 struct ras_cxl_aer_ue_event {
 	char timestamp[64];
@@ -163,6 +164,26 @@ struct ras_cxl_overflow_event {
 	uint16_t count;
 };
 
+struct ras_cxl_event_common_hdr {
+	char timestamp[64];
+	const char *memdev;
+	const char *host;
+	uint64_t serial;
+	const char *log_type;
+	const char *hdr_uuid;
+	uint32_t hdr_flags;
+	uint16_t hdr_handle;
+	uint16_t hdr_related_handle;
+	char hdr_timestamp[64];
+	uint8_t hdr_length;
+	uint8_t hdr_maint_op_class;
+};
+
+struct ras_cxl_generic_event {
+	struct ras_cxl_event_common_hdr hdr;
+	uint8_t *data;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -176,6 +197,7 @@ struct ras_cxl_poison_event;
 struct ras_cxl_aer_ue_event;
 struct ras_cxl_aer_ce_event;
 struct ras_cxl_overflow_event;
+struct ras_cxl_generic_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -213,6 +235,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_cxl_aer_ue_event;
 	sqlite3_stmt	*stmt_cxl_aer_ce_event;
 	sqlite3_stmt	*stmt_cxl_overflow_event;
+	sqlite3_stmt	*stmt_cxl_generic_event;
 #endif
 };
 
@@ -245,6 +268,7 @@ int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_eve
 int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
 int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
+int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -262,6 +286,7 @@ static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_
 static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 static inline int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
 static inline int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
+static inline int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index dbed454..8d7b76a 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -451,6 +451,44 @@ static int set_cxl_overflow_event_backtrace(char *buf, struct ras_cxl_overflow_e
 	return 0;
 }
 
+static int set_cxl_generic_event_backtrace(char *buf, struct ras_cxl_generic_event *ev)
+{
+	char bt_buf[MAX_BACKTRACE_SIZE];
+
+	if (!buf || !ev)
+		return -1;
+
+	sprintf(bt_buf, "BACKTRACE="	\
+						"timestamp=%s\n"	\
+						"memdev=%s\n"		\
+						"host=%s\n"		\
+						"serial=0x%lx\n"	\
+						"log_type=%s\n"		\
+						"hdr_uuid=%s\n"		\
+						"hdr_flags=0x%x\n"	\
+						"hdr_handle=0x%x\n"	\
+						"hdr_related_handle=0x%x\n"	\
+						"hdr_timestamp=%s\n"	\
+						"hdr_length=%u\n"	\
+						"hdr_maint_op_class=%u\n",	\
+						ev->hdr.timestamp,	\
+						ev->hdr.memdev,		\
+						ev->hdr.host,		\
+						ev->hdr.serial,		\
+						ev->hdr.log_type,	\
+						ev->hdr.hdr_uuid,	\
+						ev->hdr.hdr_flags,	\
+						ev->hdr.hdr_handle,	\
+						ev->hdr.hdr_related_handle,	\
+						ev->hdr.hdr_timestamp,	\
+						ev->hdr.hdr_length,	\
+						ev->hdr.hdr_maint_op_class);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -500,6 +538,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_OVERFLOW_EVENT:
 		rc = set_cxl_overflow_event_backtrace(buf, (struct ras_cxl_overflow_event *)ev);
 		break;
+	case CXL_GENERIC_EVENT:
+		rc = set_cxl_generic_event_backtrace(buf, (struct ras_cxl_generic_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -1084,3 +1125,48 @@ cxl_overflow_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev)
+{
+	char buf[MAX_MESSAGE_SIZE];
+	int sockfd = 0;
+	int done = 0;
+	int rc = -1;
+
+	memset(buf, 0, sizeof(buf));
+
+	sockfd = setup_report_socket();
+	if (sockfd < 0)
+		return -1;
+
+	rc = commit_report_basic(sockfd);
+	if (rc < 0)
+		goto cxl_generic_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_GENERIC_EVENT, ev);
+	if (rc < 0)
+		goto cxl_generic_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl_generic_event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_generic_fail;
+
+	sprintf(buf, "REASON=%s", "CXL Generic Event ");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_generic_fail;
+
+	done = 1;
+
+cxl_generic_fail:
+
+	if (sockfd >= 0)
+		close(sockfd);
+
+	if (done)
+		return 0;
+	else
+		return -1;
+
+}
diff --git a/ras-report.h b/ras-report.h
index 204d485..bf591a6 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -43,6 +43,7 @@ int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_ev
 int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
 int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
+int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
 
 #else
 
@@ -58,6 +59,7 @@ static inline int ras_report_cxl_poison_event(struct ras_events *ras, struct ras
 static inline int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 static inline int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
 static inline int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
+static inline int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


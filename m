Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A939466A3
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfFNRzy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 13:55:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727715AbfFNRzv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AA62F353356BE10C8F55;
        Sat, 15 Jun 2019 01:55:47 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Jun 2019 01:55:38 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <mchehab@kernel.org>, <linuxarm@huawei.com>, <jcm@redhat.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 2/6] rasdaemon: CCIX: Cache error support
Date:   Sat, 15 Jun 2019 01:55:13 +0800
Message-ID: <20190614175517.58442-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
References: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds the support of CCIX cache error reporting and logging
to sqlite3.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ras-ccix-handler.c | 114 +++++++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h |  24 ++++++++++
 ras-events.c       |   9 ++++
 ras-record.c       | 100 +++++++++++++++++++++++++++++++++++++++
 ras-record.h       |   3 ++
 5 files changed, 250 insertions(+)

diff --git a/ras-ccix-handler.c b/ras-ccix-handler.c
index 2be413f..f68c297 100644
--- a/ras-ccix-handler.c
+++ b/ras-ccix-handler.c
@@ -127,6 +127,79 @@ static char *ccix_mem_err_cper_data(const char *c)
 	return buf;
 }
 
+static char *ccix_cache_type(uint8_t type)
+{
+	switch (type) {
+	case 0: return "instruction";
+	case 1: return "data";
+	case 2: return "generic/unified";
+	case 3: return "snoop filter directory";
+	}
+	return "unknown";
+}
+
+static char *ccix_cache_err_type(int etype)
+{
+	switch (etype) {
+	case 0: return "data";
+	case 1: return "tag";
+	case 2: return "timeout";
+	case 3: return "hang";
+	case 4: return "data loss";
+	case 5: return "invalid address";
+	}
+	return "unknown-type";
+}
+
+static char *ccix_cache_op(uint8_t op)
+{
+	switch (op) {
+	case 0: return "generic";
+	case 1: return "generic read";
+	case 2: return "generic write";
+	case 3: return "data read";
+	case 4: return "data write";
+	case 5: return "instruction fetch";
+	case 6: return "prefetch";
+	case 7: return "eviction";
+	case 8: return "snooping";
+	case 9: return "snooped";
+	case 10: return "management/command";
+	}
+	return "unknown";
+}
+
+static char *ccix_cache_err_cper_data(const char *c)
+{
+	const struct cper_ccix_cache_err_compact *cpd =
+		(struct cper_ccix_cache_err_compact *)c;
+	static char buf[1024];
+	char *p = buf;
+
+	if (!(cpd->validation_bits))
+		return "";
+
+	p += sprintf(p, " (");
+	if (cpd->validation_bits & CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
+		p += sprintf(p, "error: %s ",
+			     ccix_cache_err_type(cpd->cache_error_type));
+	if (cpd->validation_bits & CCIX_CACHE_ERR_TYPE_VALID)
+		p += sprintf(p, "type: %s ", ccix_cache_type(cpd->cache_type));
+	if (cpd->validation_bits & CCIX_CACHE_ERR_OP_VALID)
+		p += sprintf(p, "op: %s ", ccix_cache_op(cpd->op_type));
+	if (cpd->validation_bits & CCIX_CACHE_ERR_LEVEL_VALID)
+		p += sprintf(p, "level: %u ", cpd->cache_level);
+	if (cpd->validation_bits & CCIX_CACHE_ERR_SET_VALID)
+		p += sprintf(p, "set: %u ", cpd->set);
+	if (cpd->validation_bits & CCIX_CACHE_ERR_WAY_VALID)
+		p += sprintf(p, "way: %u ", cpd->way);
+	if (cpd->validation_bits & CCIX_CACHE_ERR_INSTANCE_ID_VALID)
+		p += sprintf(p, "instance: %u ", cpd->instance);
+	p += sprintf(p - 1, ")");
+
+	return buf;
+}
+
 static char *ccix_component_type(int type)
 {
 	switch (type) {
@@ -242,3 +315,44 @@ int ras_ccix_memory_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+int ras_ccix_cache_event_handler(struct trace_seq *s,
+				  struct pevent_record *record,
+				  struct event_format *event, void *context)
+{
+	struct ras_events *ras = context;
+	struct tm *tm;
+	struct ras_ccix_event ev;
+	time_t now;
+	int ret;
+
+	if (ras->use_uptime)
+		now = record->ts/user_hz + ras->uptime_diff;
+	else
+		now = time(NULL);
+
+	tm = localtime(&now);
+
+	if (tm)
+		strftime(ev.timestamp, sizeof(ev.timestamp),
+			 "%Y-%m-%d %H:%M:%S %z", tm);
+	trace_seq_printf(s, "%s ", ev.timestamp);
+	ret = ras_ccix_common_parse(s, record, event, context, &ev);
+	if (ret)
+		return ret;
+
+	trace_seq_printf(s, "%d %s id:%d CCIX cache error %s ue:%d nocomm:%d degraded:%d deferred:%d physical addr: 0x%llx mask: 0x%llx %s",
+			 ev.error_seq, err_severity(ev.severity),
+			 ev.source, ccix_component_type(ev.component),
+			 (ev.severity_detail & 0x1) ? 1 : 0,
+			 (ev.severity_detail & 0x2) ? 1 : 0,
+			 (ev.severity_detail & 0x4) ? 1 : 0,
+			 (ev.severity_detail & 0x8) ? 1 : 0,
+			 ev.address,
+			 err_mask(ev.pa_mask_lsb),
+			 ccix_cache_err_cper_data(ev.cper_data));
+
+	ras_store_ccix_cache_event(ras, &ev);
+
+	return 0;
+}
diff --git a/ras-ccix-handler.h b/ras-ccix-handler.h
index f6d25b1..629ccbe 100644
--- a/ras-ccix-handler.h
+++ b/ras-ccix-handler.h
@@ -21,6 +21,9 @@
 int ras_ccix_memory_event_handler(struct trace_seq *s,
 				  struct pevent_record *record,
 				  struct event_format *event, void *context);
+int ras_ccix_cache_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context);
 
 /* Perhaps unnecessary paranoia, but the tracepoint structure is packed */
 #pragma pack(1)
@@ -41,6 +44,18 @@ struct cper_ccix_mem_err_compact {
 	uint8_t chip_id;
 	uint8_t fru;
 };
+
+struct cper_ccix_cache_err_compact {
+	uint32_t validation_bits;
+	uint32_t set;
+	uint32_t way;
+	uint8_t cache_type;
+	uint8_t op_type;
+	uint8_t cache_error_type;
+	uint8_t cache_level;
+	uint8_t instance;
+};
+
 #pragma pack()
 
 #define CCIX_MEM_ERR_GENERIC_MEM_VALID		0x0001
@@ -58,4 +73,13 @@ struct cper_ccix_mem_err_compact {
 #define CCIX_MEM_ERR_MOD_VALID			0x1000
 #define CCIX_MEM_ERR_SPEC_TYPE_VALID		0x2000
 
+#define CCIX_CACHE_ERR_TYPE_VALID		0x0001
+#define CCIX_CACHE_ERR_OP_VALID			0x0002
+#define CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID	0x0004
+#define CCIX_CACHE_ERR_LEVEL_VALID		0x0008
+#define CCIX_CACHE_ERR_SET_VALID		0x0010
+#define CCIX_CACHE_ERR_WAY_VALID		0x0020
+#define CCIX_CACHE_ERR_INSTANCE_ID_VALID	0x0040
+#define CCIX_CACHE_ERR_VENDOR_DATA_VALID	0x0080
+
 #endif
diff --git a/ras-events.c b/ras-events.c
index c7bd1c3..1e34cd1 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -205,6 +205,7 @@ int toggle_ras_mc_event(int enable)
 
 #ifdef HAVE_CCIX
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_memory_event", enable);
+	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_cache_event", enable);
 #endif
 
 #ifdef HAVE_MCE
@@ -700,6 +701,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "ras", "ccix_memory_event");
+	rc = add_event_handler(ras, pevent, page_size, "ras",
+			       "ccix_cache_error_event",
+			       ras_ccix_cache_event_handler);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "ccix_cache_event");
 #endif
 
 #ifdef HAVE_NON_STANDARD
diff --git a/ras-record.c b/ras-record.c
index b1a241a..51180f7 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -326,6 +326,101 @@ int ras_store_ccix_memory_event(struct ras_events *ras,
 	log(TERM, LOG_INFO, "register inserted at db\n");
 	return rc;
 }
+
+enum {
+	ccix_cache_field_type = ccix_field_common_end,
+	ccix_cache_field_operation,
+	ccix_cache_field_error_type,
+	ccix_cache_field_level,
+	ccix_cache_field_set,
+	ccix_cache_field_way,
+	ccix_cache_field_instance,
+	ccix_cache_field_vendor,
+};
+
+static const struct db_fields ccix_cache_event_fields[] = {
+	CCIX_COMMON_FIELDS,
+	[ccix_cache_field_type] =	{ .name = "type",		.type = "INTEGER" },
+	[ccix_cache_field_operation] =	{ .name = "operation",		.type = "INTEGER" },
+	[ccix_cache_field_error_type] =	{ .name = "cache_err_type",	.type = "INTEGER" },
+	[ccix_cache_field_level] =	{ .name = "\"level\"",		.type = "INTEGER" },
+	[ccix_cache_field_set] =	{ .name = "\"set\"",		.type = "INTEGER" },
+	[ccix_cache_field_way] =	{ .name = "way",		.type = "INTEGER" },
+	[ccix_cache_field_instance] =	{ .name = "instance",		.type = "INTEGER" },
+	[ccix_cache_field_vendor] =	{ .name = "vendor_data",	.type = "BLOB" },
+};
+
+static const struct db_table_descriptor ccix_cache_event_tab = {
+	.name = "ccix_cache_event",
+	.fields = ccix_cache_event_fields,
+	.num_fields = ARRAY_SIZE(ccix_cache_event_fields),
+};
+
+int ras_store_ccix_cache_event(struct ras_events *ras,
+			       struct ras_ccix_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+	struct cper_ccix_cache_err_compact *cache =
+		(struct cper_ccix_cache_err_compact *)ev->cper_data;
+	sqlite3_stmt *rec = priv->stmt_ccix_cache_record;
+
+	if (!priv || !rec)
+		return 0;
+	log(TERM, LOG_INFO, "ccix_cache_eventstore: %p\n", rec);
+
+	ras_store_ccix_common(rec, ev);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_CACHE_ERR_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_error_type,
+				 cache->cache_error_type);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_type, cache->cache_type);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_OP_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_operation,
+				 cache->op_type);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_LEVEL_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_level,
+				 cache->cache_level);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_SET_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_set, cache->set);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_WAY_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_way, cache->way);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_INSTANCE_ID_VALID)
+		sqlite3_bind_int(rec, ccix_cache_field_instance,
+				 cache->instance);
+
+	if (cache->validation_bits & CCIX_CACHE_ERR_VENDOR_DATA_VALID)
+		sqlite3_bind_blob(rec, ccix_cache_field_vendor,
+				  ev->vendor_data, ev->vendor_data_length,
+				  NULL);
+
+	rc = sqlite3_step(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do ccix_cache_record step on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_reset(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset ccix_cache_record on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_clear_bindings(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear ccix_cache_record: error %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+	return rc;
+}
 #endif
 /*
  * Table and functions to handle ras:non standard
@@ -721,6 +816,11 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 	if (rc == SQLITE_OK)
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_mem_record,
 					 &ccix_memory_event_tab);
+
+	rc = ras_mc_create_table(priv, &ccix_cache_event_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_cache_record,
+					 &ccix_cache_event_tab);
 #endif
 
 #ifdef HAVE_MCE
diff --git a/ras-record.h b/ras-record.h
index 4a871fa..8c90bd5 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -115,6 +115,7 @@ struct sqlite3_priv {
 #endif
 #ifdef HAVE_CCIX
 	sqlite3_stmt	*stmt_ccix_mem_record;
+	sqlite3_stmt	*stmt_ccix_cache_record;
 #endif
 #ifdef HAVE_NON_STANDARD
 	sqlite3_stmt	*stmt_non_standard_record;
@@ -130,6 +131,7 @@ int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev);
 int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev);
 int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev);
 int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev);
+int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 
@@ -140,6 +142,7 @@ static inline int ras_store_aer_event(struct ras_events *ras, struct ras_aer_eve
 static inline int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev) { return 0; };
 static inline int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev) { return 0; };
 static inline int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev) { return 0; };
+static inline int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 
-- 
2.20.1


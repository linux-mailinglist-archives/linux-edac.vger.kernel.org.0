Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA9466A7
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 19:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfFNRz4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 13:55:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727374AbfFNRzz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:55 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C346595AFD984F8E4021;
        Sat, 15 Jun 2019 01:55:52 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Jun 2019 01:55:42 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <mchehab@kernel.org>, <linuxarm@huawei.com>, <jcm@redhat.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 4/6] rasdaemon: CCIX: Port error handling
Date:   Sat, 15 Jun 2019 01:55:15 +0800
Message-ID: <20190614175517.58442-5-Jonathan.Cameron@huawei.com>
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

Add support for reporting and storing to sqlite3 for CCIX
Port errors.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ras-ccix-handler.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h | 14 +++++++
 ras-events.c       |  9 +++++
 ras-record.c       | 75 +++++++++++++++++++++++++++++++++++++
 ras-record.h       |  3 ++
 5 files changed, 194 insertions(+)

diff --git a/ras-ccix-handler.c b/ras-ccix-handler.c
index f7b9e8e..0a79627 100644
--- a/ras-ccix-handler.c
+++ b/ras-ccix-handler.c
@@ -220,6 +220,58 @@ static char *ccix_atc_err_cper_data(const char *c)
 	return buf;
 }
 
+static char *ccix_port_op(uint8_t op)
+{
+	switch (op) {
+	case 0: return "command";
+	case 1: return "read";
+	case 2: return "write";
+	}
+	return "unknown";
+}
+
+static char *ccix_port_err_type(uint8_t type)
+{
+	switch (type) {
+	case 0: return "generic bus / slave error";
+	case 1: return "bus parity / ECC error";
+	case 2: return "BDF not present";
+	case 3: return "invalid address";
+	case 4: return "invalid agent ID";
+	case 5: return "bus timeout";
+	case 6: return "hang";
+	case 7: return "egress blocked";
+	}
+	return "unknown-type";
+};
+
+static char *ccix_port_err_cper_data(const char *c)
+{
+	const struct cper_ccix_port_err_compact *cpd =
+		(struct cper_ccix_port_err_compact *)c;
+	static char buf[1024];
+	char *p = buf;
+	int i;
+
+	if (!cpd->validation_bits)
+		return "";
+
+	p += sprintf(p, " (");
+	if (cpd->validation_bits & CCIX_PORT_ERR_TYPE_VALID)
+		p += sprintf(p, "error: %s ",
+			     ccix_port_err_type(cpd->err_type));
+	if (cpd->validation_bits & CCIX_PORT_ERR_OP_VALID)
+		p += sprintf(p, "op: %s ", ccix_port_op(cpd->op_type));
+	if (cpd->validation_bits & CCIX_PORT_ERR_MESSAGE_VALID) {
+		p += sprintf(p, "message: ");
+		for (i = 0; i < 8; i++)
+			p += sprintf(p, "0x%08x ", cpd->message[i]);
+	}
+	p += sprintf(p - 1, ")");
+
+	return buf;
+}
+
 static char *ccix_component_type(int type)
 {
 	switch (type) {
@@ -417,3 +469,44 @@ int ras_ccix_atc_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+int ras_ccix_port_event_handler(struct trace_seq *s,
+				struct pevent_record *record,
+				struct event_format *event, void *context)
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
+	trace_seq_printf(s, "%d %s id:%d CCIX Port error: %s ue:%d nocomm:%d degraded:%d deferred:%d physical addr: 0x%llx mask: 0x%llx %s",
+			 ev.error_seq, err_severity(ev.severity),
+			 ev.source, ccix_component_type(ev.component),
+			 (ev.severity_detail & 0x1) ? 1 : 0,
+			 (ev.severity_detail & 0x2) ? 1 : 0,
+			 (ev.severity_detail & 0x4) ? 1 : 0,
+			 (ev.severity_detail & 0x8) ? 1 : 0,
+			 ev.address,
+			 err_mask(ev.pa_mask_lsb),
+			 ccix_port_err_cper_data(ev.cper_data));
+
+	ras_store_ccix_port_event(ras, &ev);
+
+	return 0;
+}
diff --git a/ras-ccix-handler.h b/ras-ccix-handler.h
index 4528af7..e824aed 100644
--- a/ras-ccix-handler.h
+++ b/ras-ccix-handler.h
@@ -27,6 +27,9 @@ int ras_ccix_cache_event_handler(struct trace_seq *s,
 int ras_ccix_atc_event_handler(struct trace_seq *s,
 			       struct pevent_record *record,
 			       struct event_format *event, void *context);
+int ras_ccix_port_event_handler(struct trace_seq *s,
+				struct pevent_record *record,
+				struct event_format *event, void *context);
 
 /* Perhaps unnecessary paranoia, but the tracepoint structure is packed */
 #pragma pack(1)
@@ -65,6 +68,12 @@ struct cper_ccix_atc_err_compact {
 	uint8_t instance;
 };
 
+struct cper_ccix_port_err_compact {
+	uint32_t validation_bits;
+	uint32_t message[8];
+	uint8_t err_type;
+	uint8_t op_type;
+};
 #pragma pack()
 
 #define CCIX_MEM_ERR_GENERIC_MEM_VALID		0x0001
@@ -95,4 +104,9 @@ struct cper_ccix_atc_err_compact {
 #define CCIX_ATC_ERR_INSTANCE_ID_VALID		0x0002
 #define CCIX_ATC_ERR_VENDOR_DATA_VALID		0x0004
 
+#define CCIX_PORT_ERR_OP_VALID			0x0001
+#define CCIX_PORT_ERR_TYPE_VALID		0x0002
+#define CCIX_PORT_ERR_MESSAGE_VALID		0x0004
+#define CCIX_PORT_ERR_VENDOR_DATA_VALID		0x0008
+
 #endif
diff --git a/ras-events.c b/ras-events.c
index 20e29dd..aef5eae 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -207,6 +207,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_memory_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_cache_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_atc_event", enable);
+	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_port_event", enable);
 #endif
 
 #ifdef HAVE_MCE
@@ -718,6 +719,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "ras", "ccix_atc_event");
+	rc = add_event_handler(ras, pevent, page_size, "ras",
+			       "ccix_port_error_event",
+			       ras_ccix_port_event_handler);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "ccix_port_event");
 #endif
 
 #ifdef HAVE_NON_STANDARD
diff --git a/ras-record.c b/ras-record.c
index 3e8d720..4824dd3 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -485,6 +485,76 @@ int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev)
 	log(TERM, LOG_INFO, "register inserted at db\n");
 	return rc;
 }
+
+enum {
+	ccix_port_field_operation = ccix_field_common_end,
+	ccix_port_field_etype,
+	ccix_port_field_message,
+	ccix_port_field_vendor,
+};
+
+static const struct db_fields ccix_port_event_fields[] = {
+	CCIX_COMMON_FIELDS,
+	[ccix_port_field_operation] =	{ .name = "operation",		.type = "INTEGER" },
+	[ccix_port_field_etype] =	{ .name = "etype",		.type = "INTEGER" },
+	[ccix_port_field_message] =	{ .name = "message",		.type = "BLOB" },
+	[ccix_port_field_vendor] =	{ .name = "vendor_data",	.type = "BLOB" },
+};
+
+static const struct db_table_descriptor ccix_port_event_tab = {
+	.name = "ccix_port_event",
+	.fields = ccix_port_event_fields,
+	.num_fields = ARRAY_SIZE(ccix_port_event_fields),
+};
+
+int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+	struct cper_ccix_port_err_compact *port =
+		(struct cper_ccix_port_err_compact *)ev->cper_data;
+	sqlite3_stmt *rec = priv->stmt_ccix_port_record;
+
+	if (!priv || !rec)
+		return 0;
+	log(TERM, LOG_INFO, "ccix_port_eventstore: %p\n", rec);
+
+	ras_store_ccix_common(rec, ev);
+	if (port->validation_bits & CCIX_PORT_ERR_OP_VALID)
+		sqlite3_bind_int(rec, ccix_port_field_operation, port->op_type);
+
+	if (port->validation_bits & CCIX_PORT_ERR_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_port_field_etype, port->err_type);
+
+	if (port->validation_bits & CCIX_PORT_ERR_MESSAGE_VALID)
+		sqlite3_bind_blob(rec, ccix_port_field_message,
+				  port->message, sizeof(port->message), NULL);
+
+	if (port->validation_bits & CCIX_PORT_ERR_VENDOR_DATA_VALID)
+		sqlite3_bind_blob(rec, ccix_port_field_vendor,
+				  ev->vendor_data, ev->vendor_data_length,
+				  NULL);
+
+	rc = sqlite3_step(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do ccix_port_record step on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_reset(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset ccix_port_record on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_clear_bindings(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear ccix_port_record: error %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+	return rc;
+}
 #endif
 /*
  * Table and functions to handle ras:non standard
@@ -890,6 +960,11 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 	if (rc == SQLITE_OK)
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_atc_record,
 					 &ccix_atc_event_tab);
+
+	rc = ras_mc_create_table(priv, &ccix_port_event_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_port_record,
+					 &ccix_port_event_tab);
 #endif
 
 #ifdef HAVE_MCE
diff --git a/ras-record.h b/ras-record.h
index 8141d26..3a473a5 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -117,6 +117,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_ccix_mem_record;
 	sqlite3_stmt	*stmt_ccix_cache_record;
 	sqlite3_stmt	*stmt_ccix_atc_record;
+	sqlite3_stmt	*stmt_ccix_port_record;
 #endif
 #ifdef HAVE_NON_STANDARD
 	sqlite3_stmt	*stmt_non_standard_record;
@@ -134,6 +135,7 @@ int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event
 int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev);
+int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 
@@ -146,6 +148,7 @@ static inline int ras_store_extlog_mem_record(struct ras_events *ras, struct ras
 static inline int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev) { return 0; };
 static inline int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
+static inline int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 
-- 
2.20.1


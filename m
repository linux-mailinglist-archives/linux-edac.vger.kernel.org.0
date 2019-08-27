Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B83C89E6CD
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 13:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfH0LbB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 07:31:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:36932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbfH0LbB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Aug 2019 07:31:01 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2563956575B8FB7F4310;
        Tue, 27 Aug 2019 19:30:59 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 19:30:51 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <jcm@redhat.com>, <shiju.jose@huawei.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH V2 5/6] rasdaemon: CCIX: Link error support
Date:   Tue, 27 Aug 2019 19:30:09 +0800
Message-ID: <20190827113010.50405-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190827113010.50405-1-Jonathan.Cameron@huawei.com>
References: <20190827113010.50405-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support for reporting and storing to sqlite3 of
CCIX Link errors.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ras-ccix-handler.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h | 19 +++++++++
 ras-events.c       |  9 +++++
 ras-record-ccix.c  | 87 +++++++++++++++++++++++++++++++++++++++++
 ras-record.h       |  3 ++
 5 files changed, 214 insertions(+)

diff --git a/ras-ccix-handler.c b/ras-ccix-handler.c
index 0a79627..69baa48 100644
--- a/ras-ccix-handler.c
+++ b/ras-ccix-handler.c
@@ -272,6 +272,61 @@ static char *ccix_port_err_cper_data(const char *c)
 	return buf;
 }
 
+static char *ccix_link_err_type(uint8_t err)
+{
+	switch (err) {
+	case 0: return "generic";
+	case 1: return "credit underflow";
+	case 2: return "credit overflow";
+	case 3: return "unusable credit";
+	case 4: return "credit timeout";
+	}
+	return "unknown";
+};
+
+static char *ccix_link_credit(uint8_t credit)
+{
+	switch (credit) {
+	case 0: return "memory";
+	case 1: return "snoop";
+	case 2: return "data";
+	case 3: return "misc";
+	}
+	return "unknown";
+};
+
+static char *ccix_link_err_cper_data(const char *c)
+{
+	const struct cper_ccix_link_err_compact *cpd =
+		(struct cper_ccix_link_err_compact *)c;
+	static char buf[1024];
+	char *p = buf;
+	int i;
+
+	if (!cpd->validation_bits)
+		return "";
+
+	p += sprintf(p, " (");
+	if (cpd->validation_bits & CCIX_LINK_ERR_TYPE_VALID)
+		p += sprintf(p, "error: %s ",
+			     ccix_link_err_type(cpd->err_type));
+	if (cpd->validation_bits & CCIX_LINK_ERR_OP_VALID)
+		p += sprintf(p, "op: %s ", ccix_port_op(cpd->op_type));
+	if (cpd->validation_bits & CCIX_LINK_ERR_LINK_ID_VALID)
+		p += sprintf(p, "id: %u ", cpd->link_id);
+	if (cpd->validation_bits & CCIX_LINK_ERR_CREDIT_TYPE_VALID)
+		p += sprintf(p, "credit-type: %s ",
+			     ccix_link_credit(cpd->credit_type));
+	if (cpd->validation_bits & CCIX_LINK_ERR_MESSAGE_VALID) {
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
@@ -510,3 +565,44 @@ int ras_ccix_port_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+int ras_ccix_link_event_handler(struct trace_seq *s,
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
+	trace_seq_printf(s, "%d %s id:%d CCIX Link error: %s ue:%d nocomm:%d degraded:%d deferred:%d physical addr: 0x%llx mask: 0x%llx %s",
+			 ev.error_seq, err_severity(ev.severity),
+			 ev.source, ccix_component_type(ev.component),
+			 (ev.severity_detail & 0x1) ? 1 : 0,
+			 (ev.severity_detail & 0x2) ? 1 : 0,
+			 (ev.severity_detail & 0x4) ? 1 : 0,
+			 (ev.severity_detail & 0x8) ? 1 : 0,
+			 ev.address,
+			 err_mask(ev.pa_mask_lsb),
+			 ccix_link_err_cper_data(ev.cper_data));
+
+	ras_store_ccix_link_event(ras, &ev);
+
+	return 0;
+}
diff --git a/ras-ccix-handler.h b/ras-ccix-handler.h
index e824aed..3def534 100644
--- a/ras-ccix-handler.h
+++ b/ras-ccix-handler.h
@@ -30,6 +30,9 @@ int ras_ccix_atc_event_handler(struct trace_seq *s,
 int ras_ccix_port_event_handler(struct trace_seq *s,
 				struct pevent_record *record,
 				struct event_format *event, void *context);
+int ras_ccix_link_event_handler(struct trace_seq *s,
+				struct pevent_record *record,
+				struct event_format *event, void *context);
 
 /* Perhaps unnecessary paranoia, but the tracepoint structure is packed */
 #pragma pack(1)
@@ -74,6 +77,15 @@ struct cper_ccix_port_err_compact {
 	uint8_t err_type;
 	uint8_t op_type;
 };
+
+struct cper_ccix_link_err_compact {
+	uint32_t validation_bits;
+	uint32_t message[8];
+	uint8_t err_type;
+	uint8_t op_type;
+	uint8_t link_id;
+	uint8_t credit_type;
+};
 #pragma pack()
 
 #define CCIX_MEM_ERR_GENERIC_MEM_VALID		0x0001
@@ -109,4 +121,11 @@ struct cper_ccix_port_err_compact {
 #define CCIX_PORT_ERR_MESSAGE_VALID		0x0004
 #define CCIX_PORT_ERR_VENDOR_DATA_VALID		0x0008
 
+#define CCIX_LINK_ERR_OP_VALID			0x0001
+#define CCIX_LINK_ERR_TYPE_VALID		0x0002
+#define CCIX_LINK_ERR_LINK_ID_VALID		0x0004
+#define CCIX_LINK_ERR_CREDIT_TYPE_VALID		0x0008
+#define CCIX_LINK_ERR_MESSAGE_VALID		0x0010
+#define CCIX_LINK_ERR_VENDOR_DATA_VALID		0x0020
+
 #endif
diff --git a/ras-events.c b/ras-events.c
index 83e28a7..c73a36d 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -209,6 +209,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_cache_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_atc_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_port_event", enable);
+	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_link_event", enable);
 #endif
 
 #ifdef HAVE_MCE
@@ -758,6 +759,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "ras", "ccix_port_event");
+	rc = add_event_handler(ras, pevent, page_size, "ras",
+			       "ccix_link_error_event",
+			       ras_ccix_link_event_handler, NULL);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "ccix_link_event");
 #endif
 
 #ifdef HAVE_NON_STANDARD
diff --git a/ras-record-ccix.c b/ras-record-ccix.c
index e1c5df4..1e03e84 100644
--- a/ras-record-ccix.c
+++ b/ras-record-ccix.c
@@ -422,6 +422,88 @@ int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev)
 	return rc;
 }
 
+enum {
+	ccix_link_field_operation = ccix_field_common_end,
+	ccix_link_field_etype,
+	ccix_link_field_link_id,
+	ccix_link_field_credit_type,
+	ccix_link_field_message,
+	ccix_link_field_vendor,
+};
+
+static const struct db_fields ccix_link_event_fields[] = {
+	CCIX_COMMON_FIELDS,
+	[ccix_link_field_operation] =	{ .name = "operation",		.type = "INTEGER" },
+	[ccix_link_field_etype] =	{ .name = "etype",		.type = "INTEGER" },
+	[ccix_link_field_link_id] =	{ .name = "credit_id",		.type = "INTEGER" },
+	[ccix_link_field_credit_type] =	{ .name = "credit_type",	.type = "INTEGER" },
+	[ccix_link_field_message] =	{ .name = "message",		.type = "BLOB" },
+	[ccix_link_field_vendor] =	{ .name = "vendor_data",	.type = "BLOB" },
+};
+
+static const struct db_table_descriptor ccix_link_event_tab = {
+	.name = "ccix_link_event",
+	.fields = ccix_link_event_fields,
+	.num_fields = ARRAY_SIZE(ccix_link_event_fields),
+};
+
+int ras_store_ccix_link_event(struct ras_events *ras, struct ras_ccix_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+	struct cper_ccix_link_err_compact *link =
+		(struct cper_ccix_link_err_compact *)ev->cper_data;
+	sqlite3_stmt *rec = priv->stmt_ccix_link_record;
+
+	if (!priv || !rec)
+		return 0;
+	log(TERM, LOG_INFO, "ccix_link_eventstore: %p\n", rec);
+
+	ras_store_ccix_common(rec, ev);
+	if (link->validation_bits & CCIX_LINK_ERR_OP_VALID)
+		sqlite3_bind_int(rec, ccix_link_field_operation, link->op_type);
+
+	if (link->validation_bits & CCIX_LINK_ERR_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_link_field_operation,
+				 link->err_type);
+
+	if (link->validation_bits & CCIX_LINK_ERR_LINK_ID_VALID)
+		sqlite3_bind_int(rec, ccix_link_field_link_id, link->link_id);
+
+	if (link->validation_bits & CCIX_LINK_ERR_CREDIT_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_link_field_credit_type,
+				 link->credit_type);
+
+	if (link->validation_bits & CCIX_LINK_ERR_MESSAGE_VALID)
+		sqlite3_bind_blob(rec, ccix_link_field_message,
+				  link->message, sizeof(link->message), NULL);
+
+	if (link->validation_bits & CCIX_LINK_ERR_VENDOR_DATA_VALID)
+		sqlite3_bind_blob(rec, ccix_link_field_vendor,
+				  ev->vendor_data, ev->vendor_data_length,
+				  NULL);
+
+	rc = sqlite3_step(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do ccix_link_record step on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_reset(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset ccix_link_record on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_clear_bindings(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear ccix_link_record: error %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+	return rc;
+}
+
 void ras_ccix_create_table(struct sqlite3_priv *priv)
 {
 	int rc;
@@ -445,4 +527,9 @@ void ras_ccix_create_table(struct sqlite3_priv *priv)
 	if (rc == SQLITE_OK)
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_port_record,
 					 &ccix_port_event_tab);
+
+	rc = ras_mc_create_table(priv, &ccix_link_event_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_link_record,
+					 &ccix_link_event_tab);
 }
diff --git a/ras-record.h b/ras-record.h
index 778de25..f13e286 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -128,6 +128,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_ccix_cache_record;
 	sqlite3_stmt	*stmt_ccix_atc_record;
 	sqlite3_stmt	*stmt_ccix_port_record;
+	sqlite3_stmt	*stmt_ccix_link_record;
 #endif
 #ifdef HAVE_NON_STANDARD
 	sqlite3_stmt	*stmt_non_standard_record;
@@ -169,6 +170,7 @@ int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *e
 int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev);
+int ras_store_ccix_link_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
@@ -184,6 +186,7 @@ static inline int ras_store_ccix_memory_event(struct ras_events *ras, struct ras
 static inline int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
+static inline int ras_store_ccix_link_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
-- 
2.20.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD03D9E702
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 13:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfH0LrM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 07:47:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:52704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728763AbfH0LrM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 27 Aug 2019 07:47:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1D7EC2763C2188B19219;
        Tue, 27 Aug 2019 19:30:54 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 27 Aug 2019 19:30:47 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <jcm@redhat.com>, <shiju.jose@huawei.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [PATCH V2 3/6] rasdaemon: CCIX: ATC error support
Date:   Tue, 27 Aug 2019 19:30:07 +0800
Message-ID: <20190827113010.50405-4-Jonathan.Cameron@huawei.com>
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

Adds support for CCIX address translation cache (ATC) errors.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ras-ccix-handler.c | 61 ++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h | 13 +++++++++
 ras-events.c       |  9 ++++++
 ras-record-ccix.c  | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-record.h       |  3 ++
 5 files changed, 155 insertions(+)

diff --git a/ras-ccix-handler.c b/ras-ccix-handler.c
index f68c297..f7b9e8e 100644
--- a/ras-ccix-handler.c
+++ b/ras-ccix-handler.c
@@ -200,6 +200,26 @@ static char *ccix_cache_err_cper_data(const char *c)
 	return buf;
 }
 
+static char *ccix_atc_err_cper_data(const char *c)
+{
+	const struct cper_ccix_atc_err_compact *cpd =
+		(struct cper_ccix_atc_err_compact *)c;
+	static char buf[1024];
+	char *p = buf;
+
+	if (!cpd->validation_bits)
+		return "";
+
+	p += sprintf(p, " (");
+	if (cpd->validation_bits & CCIX_ATC_ERR_OP_VALID)
+		p += sprintf(p, "op: %s ", ccix_cache_op(cpd->op_type));
+	if (cpd->validation_bits & CCIX_ATC_ERR_INSTANCE_ID_VALID)
+		p += sprintf(p, "instance: %u ", cpd->instance);
+	p += sprintf(p - 1, ")");
+
+	return buf;
+}
+
 static char *ccix_component_type(int type)
 {
 	switch (type) {
@@ -356,3 +376,44 @@ int ras_ccix_cache_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+int ras_ccix_atc_event_handler(struct trace_seq *s,
+			       struct pevent_record *record,
+			       struct event_format *event, void *context)
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
+	trace_seq_printf(s, "%d %s id:%d CCIX ATC error: %s ue:%d nocomm:%d degraded:%d deferred:%d physical addr: 0x%llx mask: 0x%llx %s",
+			 ev.error_seq, err_severity(ev.severity),
+			 ev.source, ccix_component_type(ev.component),
+			 (ev.severity_detail & 0x1) ? 1 : 0,
+			 (ev.severity_detail & 0x2) ? 1 : 0,
+			 (ev.severity_detail & 0x4) ? 1 : 0,
+			 (ev.severity_detail & 0x8) ? 1 : 0,
+			 ev.address,
+			 err_mask(ev.pa_mask_lsb),
+			 ccix_atc_err_cper_data(ev.cper_data));
+
+	ras_store_ccix_atc_event(ras, &ev);
+
+	return 0;
+}
diff --git a/ras-ccix-handler.h b/ras-ccix-handler.h
index 629ccbe..4528af7 100644
--- a/ras-ccix-handler.h
+++ b/ras-ccix-handler.h
@@ -24,6 +24,9 @@ int ras_ccix_memory_event_handler(struct trace_seq *s,
 int ras_ccix_cache_event_handler(struct trace_seq *s,
 				 struct pevent_record *record,
 				 struct event_format *event, void *context);
+int ras_ccix_atc_event_handler(struct trace_seq *s,
+			       struct pevent_record *record,
+			       struct event_format *event, void *context);
 
 /* Perhaps unnecessary paranoia, but the tracepoint structure is packed */
 #pragma pack(1)
@@ -56,6 +59,12 @@ struct cper_ccix_cache_err_compact {
 	uint8_t instance;
 };
 
+struct cper_ccix_atc_err_compact {
+	uint32_t validation_bits;
+	uint8_t op_type;
+	uint8_t instance;
+};
+
 #pragma pack()
 
 #define CCIX_MEM_ERR_GENERIC_MEM_VALID		0x0001
@@ -82,4 +91,8 @@ struct cper_ccix_cache_err_compact {
 #define CCIX_CACHE_ERR_INSTANCE_ID_VALID	0x0040
 #define CCIX_CACHE_ERR_VENDOR_DATA_VALID	0x0080
 
+#define CCIX_ATC_ERR_OP_VALID			0x0001
+#define CCIX_ATC_ERR_INSTANCE_ID_VALID		0x0002
+#define CCIX_ATC_ERR_VENDOR_DATA_VALID		0x0004
+
 #endif
diff --git a/ras-events.c b/ras-events.c
index f1b67cd..68ed246 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -207,6 +207,7 @@ int toggle_ras_mc_event(int enable)
 #ifdef HAVE_CCIX
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_memory_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_cache_event", enable);
+	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_atc_event", enable);
 #endif
 
 #ifdef HAVE_MCE
@@ -740,6 +741,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "ras", "ccix_cache_event");
+	rc = add_event_handler(ras, pevent, page_size, "ras",
+			       "ccix_atc_error_event",
+			       ras_ccix_atc_event_handler, NULL);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "ccix_atc_event");
 #endif
 
 #ifdef HAVE_NON_STANDARD
diff --git a/ras-record-ccix.c b/ras-record-ccix.c
index 5b6e044..df68eef 100644
--- a/ras-record-ccix.c
+++ b/ras-record-ccix.c
@@ -288,6 +288,70 @@ int ras_store_ccix_cache_event(struct ras_events *ras,
 	return rc;
 }
 
+enum {
+	ccix_atc_field_operation = ccix_field_common_end,
+	ccix_atc_field_instance,
+	ccix_atc_field_vendor,
+};
+
+static const struct db_fields ccix_atc_event_fields[] = {
+	CCIX_COMMON_FIELDS,
+	[ccix_atc_field_operation] =	{ .name = "operation",		.type = "INTEGER" },
+	[ccix_atc_field_instance] =	{ .name = "instance",		.type = "INTEGER" },
+	[ccix_atc_field_vendor] =	{ .name = "vendor_data",	.type = "BLOB" },
+};
+
+static const struct db_table_descriptor ccix_atc_event_tab = {
+	.name = "ccix_atc_event",
+	.fields = ccix_atc_event_fields,
+	.num_fields = ARRAY_SIZE(ccix_atc_event_fields),
+};
+
+int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+	struct cper_ccix_atc_err_compact *atc =
+		(struct cper_ccix_atc_err_compact *)ev->cper_data;
+	sqlite3_stmt *rec = priv->stmt_ccix_atc_record;
+
+	if (!priv || !rec)
+		return 0;
+	log(TERM, LOG_INFO, "ccix_atc_eventstore: %p\n", rec);
+
+	ras_store_ccix_common(priv->stmt_ccix_atc_record, ev);
+	if (atc->validation_bits & CCIX_ATC_ERR_OP_VALID)
+		sqlite3_bind_int(rec, ccix_atc_field_operation, atc->op_type);
+
+	if (atc->validation_bits & CCIX_ATC_ERR_INSTANCE_ID_VALID)
+		sqlite3_bind_int(rec, ccix_atc_field_instance, atc->instance);
+
+	if (atc->validation_bits & CCIX_ATC_ERR_VENDOR_DATA_VALID)
+		sqlite3_bind_blob(rec, ccix_atc_field_vendor,
+				  ev->vendor_data, ev->vendor_data_length,
+				  NULL);
+
+	rc = sqlite3_step(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do ccix_atc_record step on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_reset(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset ccix_atc_record on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_clear_bindings(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear ccix_atc_record: error %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+	return rc;
+}
+
 void ras_ccix_create_table(struct sqlite3_priv *priv)
 {
 	int rc;
@@ -301,4 +365,9 @@ void ras_ccix_create_table(struct sqlite3_priv *priv)
 	if (rc == SQLITE_OK)
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_cache_record,
 					 &ccix_cache_event_tab);
+
+	rc = ras_mc_create_table(priv, &ccix_atc_event_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_atc_record,
+					 &ccix_atc_event_tab);
 }
diff --git a/ras-record.h b/ras-record.h
index ac25ffc..c3b3586 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -126,6 +126,7 @@ struct sqlite3_priv {
 #ifdef HAVE_CCIX
 	sqlite3_stmt	*stmt_ccix_mem_record;
 	sqlite3_stmt	*stmt_ccix_cache_record;
+	sqlite3_stmt	*stmt_ccix_atc_record;
 #endif
 #ifdef HAVE_NON_STANDARD
 	sqlite3_stmt	*stmt_non_standard_record;
@@ -165,6 +166,7 @@ int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event
 void ras_ccix_create_table(struct sqlite3_priv *priv);
 int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev);
+int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
@@ -178,6 +180,7 @@ static inline int ras_store_extlog_mem_record(struct ras_events *ras, struct ras
 static inline void ras_ccix_create_table(void *priv) {};
 static inline int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev) { return 0; };
 static inline int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
+static inline int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
-- 
2.20.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E296DF032
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 11:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDLJWR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 05:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjDLJWO (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 05:22:14 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D427676BB;
        Wed, 12 Apr 2023 02:22:03 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGDX2c8Bz67lH1;
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
Subject: [RFC PATCH 5/7] rasdaemon: Add support for the CXL general media events
Date:   Wed, 12 Apr 2023 16:33:09 +0800
Message-ID: <20230412083312.1384-6-shiju.jose@huawei.com>
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

Add support to log and record the CXL general media events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |   3 +
 ras-events.c      |   9 +++
 ras-events.h      |   1 +
 ras-record.c      |  85 +++++++++++++++++++++++++
 ras-record.h      |  19 ++++++
 ras-report.c      | 101 ++++++++++++++++++++++++++++++
 ras-report.h      |   2 +
 8 files changed, 376 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 59f87c0..e2e80ff 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -99,6 +99,14 @@ static char *uuid_be(const char *uu)
 	return uuid;
 }
 
+static const char* get_cxl_type_str(const char** type_array, uint8_t num_elems, uint8_t type)
+{
+	if (type >= num_elems)
+		return "Unknown";
+
+	return type_array[type];
+}
+
 /* Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
 #define CXL_POISON_FLAG_OVERFLOW        BIT(1)
@@ -701,3 +709,151 @@ int ras_cxl_generic_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+#define CXL_DPA_VOLATILE		BIT(0)
+#define CXL_DPA_NOT_REPAIRABLE		BIT(1)
+
+static const struct cxl_event_flags cxl_dpa_flags[] = {
+	{ .bit = CXL_DPA_VOLATILE, .flag = "VOLATILE" },
+	{ .bit = CXL_DPA_NOT_REPAIRABLE, .flag = "NOT_REPAIRABLE" },
+};
+
+/*
+ * General Media Event Record - GMER
+ * CXL rev 3.0 Section 8.2.9.2.1.1; Table 8-43
+ */
+#define CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT		BIT(0)
+#define CXL_GMER_EVT_DESC_THRESHOLD_EVENT		BIT(1)
+#define CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW		BIT(2)
+
+static const struct cxl_event_flags cxl_gmer_event_desc_flags[] = {
+	{ .bit = CXL_GMER_EVT_DESC_UNCORECTABLE_EVENT, .flag = "UNCORRECTABLE EVENT" },
+	{ .bit = CXL_GMER_EVT_DESC_THRESHOLD_EVENT, .flag = "THRESHOLD EVENT" },
+	{ .bit = CXL_GMER_EVT_DESC_POISON_LIST_OVERFLOW, .flag = "POISON LIST OVERFLOW" },
+};
+
+#define CXL_GMER_VALID_CHANNEL			BIT(0)
+#define CXL_GMER_VALID_RANK			BIT(1)
+#define CXL_GMER_VALID_DEVICE			BIT(2)
+#define CXL_GMER_VALID_COMPONENT		BIT(3)
+
+static const char* cxl_gmer_mem_event_type[] = {
+	"ECC Error",
+	"Invalid Address",
+	"Data Path Error",
+};
+
+static const char* cxl_gmer_trans_type[] = {
+	"Unknown",
+	"Host Read",
+	"Host Write",
+	"Host Scan Media",
+	"Host Inject Poison",
+	"Internal Media Scrub",
+	"Internal Media Management",
+};
+
+int ras_cxl_general_media_event_handler(struct trace_seq *s,
+					struct tep_record *record,
+					struct tep_event *event, void *context)
+{
+	int len, i;
+	unsigned long long val;
+	struct ras_events *ras = context;
+	struct ras_cxl_general_media_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	if (handle_ras_cxl_common_hdr(s, record, event, context, &ev.hdr) < 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "dpa", record, &val, 1) < 0)
+		return -1;
+	ev.dpa = val;
+	if (trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "dpa_flags", record, &val, 1) < 0)
+		return -1;
+	ev.dpa_flags = val;
+	if (trace_seq_printf(s, "dpa_flags:") <= 0)
+		return -1;
+	if (decode_cxl_event_flags(s, ev.dpa_flags, cxl_dpa_flags, ARRAY_SIZE(cxl_dpa_flags)) < 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "descriptor", record, &val, 1) < 0)
+		return -1;
+	ev.descriptor = val;
+	if (trace_seq_printf(s, "descriptor:") <= 0)
+		return -1;
+	if (decode_cxl_event_flags(s, ev.descriptor, cxl_gmer_event_desc_flags,
+				   ARRAY_SIZE(cxl_gmer_event_desc_flags)) < 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "type", record, &val, 1) < 0)
+		return -1;
+	ev.type = val;
+	if (trace_seq_printf(s, "type:%s ", get_cxl_type_str(cxl_gmer_mem_event_type,
+			     ARRAY_SIZE(cxl_gmer_mem_event_type), ev.type)) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "transaction_type", record, &val, 1) < 0)
+		return -1;
+	ev.transaction_type = val;
+	if (trace_seq_printf(s, "transaction_type:%s ",
+			     get_cxl_type_str(cxl_gmer_trans_type,
+					      ARRAY_SIZE(cxl_gmer_trans_type),
+					      ev.transaction_type)) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "validity_flags", record, &val, 1) < 0)
+		return -1;
+	ev.validity_flags = val;
+
+	if (ev.validity_flags & CXL_GMER_VALID_CHANNEL) {
+		if (tep_get_field_val(s,  event, "channel", record, &val, 1) < 0)
+			return -1;
+		ev.channel = val;
+		if (trace_seq_printf(s, "channel:%u ", ev.channel) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_GMER_VALID_RANK) {
+		if (tep_get_field_val(s,  event, "rank", record, &val, 1) < 0)
+			return -1;
+		ev.rank = val;
+		if (trace_seq_printf(s, "rank:%u ", ev.rank) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_GMER_VALID_DEVICE) {
+		if (tep_get_field_val(s,  event, "device", record, &val, 1) < 0)
+			return -1;
+		ev.device = val;
+		if (trace_seq_printf(s, "device:%x ", ev.device) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_GMER_VALID_COMPONENT) {
+		ev.comp_id = tep_get_field_raw(s, event, "comp_id", record, &len, 1);
+		if (!ev.comp_id)
+			return -1;
+		if (trace_seq_printf(s, "comp_id:") <= 0)
+			return -1;
+		for (i = 0; i < CXL_EVENT_GEN_MED_COMP_ID_SIZE; i++) {
+			if (trace_seq_printf(s, "%02x ", ev.comp_id[i]) <= 0)
+				break;
+		}
+	}
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_general_media_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_general_media_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index 9f77cb7..3adca4a 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -35,4 +35,7 @@ int ras_cxl_overflow_event_handler(struct trace_seq *s,
 int ras_cxl_generic_event_handler(struct trace_seq *s,
 				  struct tep_record *record,
 				  struct tep_event *event, void *context);
+int ras_cxl_general_media_event_handler(struct trace_seq *s,
+					struct tep_record *record,
+					struct tep_event *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index debdc87..0858b51 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -250,6 +250,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_correctable_error", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_overflow", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_generic_event", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_general_media", enable);
 #endif
 
 free_ras:
@@ -1022,6 +1023,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_generic_event");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_general_media",
+			       ras_cxl_general_media_event_handler, NULL, CXL_GENERAL_MEDIA_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_general_media");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index 989ab29..0a3edf5 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -44,6 +44,7 @@ enum {
 	CXL_AER_CE_EVENT,
 	CXL_OVERFLOW_EVENT,
 	CXL_GENERIC_EVENT,
+	CXL_GENERAL_MEDIA_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index 36665aa..0546b29 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -846,6 +846,75 @@ int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_e
 
 	return rc;
 }
+
+/*
+ * Table and functions to handle cxl:cxl_general_media_event
+ */
+static const struct db_fields cxl_general_media_event_fields[] = {
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
+	{ .name = "dpa",		.type = "INTEGER" },
+	{ .name = "dpa_flags",		.type = "INTEGER" },
+	{ .name = "descriptor",		.type = "INTEGER" },
+	{ .name = "type",		.type = "INTEGER" },
+	{ .name = "transaction_type",	.type = "INTEGER" },
+	{ .name = "channel",		.type = "INTEGER" },
+	{ .name = "rank",		.type = "INTEGER" },
+	{ .name = "device",		.type = "INTEGER" },
+	{ .name = "comp_id",		.type = "BLOB" },
+};
+
+static const struct db_table_descriptor cxl_general_media_event_tab = {
+	.name = "cxl_general_media_event",
+	.fields = cxl_general_media_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_general_media_event_fields),
+};
+
+int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_general_media_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_general_media_event store: %p\n",
+	    priv->stmt_cxl_general_media_event);
+
+	ras_store_cxl_common_hdr(priv->stmt_cxl_general_media_event, &ev->hdr);
+	sqlite3_bind_int64(priv->stmt_cxl_general_media_event, 13, ev->dpa);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 14, ev->dpa_flags);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 15, ev->descriptor);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 16, ev->type);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 17, ev->transaction_type);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 18, ev->channel);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 19, ev->rank);
+	sqlite3_bind_int(priv->stmt_cxl_general_media_event, 20, ev->device);
+	sqlite3_bind_blob(priv->stmt_cxl_general_media_event, 21, ev->comp_id,
+			  CXL_EVENT_GEN_MED_COMP_ID_SIZE, NULL);
+
+	rc = sqlite3_step(priv->stmt_cxl_general_media_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do stmt_cxl_general_media_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_general_media_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset stmt_cxl_general_media_event on sqlite: error = %d\n", rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
 #endif
 
 /*
@@ -1225,6 +1294,14 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		if (rc != SQLITE_OK)
 			goto error;
 	}
+
+	rc = ras_mc_create_table(priv, &cxl_general_media_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_general_media_event,
+					 &cxl_general_media_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 	ras->db_priv = priv;
@@ -1379,6 +1456,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_generic_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_general_media_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_general_media_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_general_media_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index 9ecfcda..37c32de 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -134,6 +134,7 @@ struct ras_cxl_poison_event {
 #define CXL_HEADERLOG_SIZE              SZ_512
 #define CXL_HEADERLOG_SIZE_U32          (SZ_512 / sizeof(uint32_t))
 #define CXL_EVENT_RECORD_DATA_LENGTH	0x50
+#define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
 
 struct ras_cxl_aer_ue_event {
 	char timestamp[64];
@@ -184,6 +185,20 @@ struct ras_cxl_generic_event {
 	uint8_t *data;
 };
 
+struct ras_cxl_general_media_event {
+	struct ras_cxl_event_common_hdr hdr;
+	uint64_t dpa;
+	uint8_t dpa_flags;
+	uint8_t descriptor;
+	uint8_t type;
+	uint8_t transaction_type;
+	uint8_t channel;
+	uint8_t rank;
+	uint32_t device;
+	uint8_t *comp_id;
+	uint16_t validity_flags;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -198,6 +213,7 @@ struct ras_cxl_aer_ue_event;
 struct ras_cxl_aer_ce_event;
 struct ras_cxl_overflow_event;
 struct ras_cxl_generic_event;
+struct ras_cxl_general_media_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -236,6 +252,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_cxl_aer_ce_event;
 	sqlite3_stmt	*stmt_cxl_overflow_event;
 	sqlite3_stmt	*stmt_cxl_generic_event;
+	sqlite3_stmt	*stmt_cxl_general_media_event;
 #endif
 };
 
@@ -269,6 +286,7 @@ int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_eve
 int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
 int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
 int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
+int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -287,6 +305,7 @@ static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_
 static inline int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
 static inline int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
 static inline int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
+static inline int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 8d7b76a..725dc9b 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -489,6 +489,60 @@ static int set_cxl_generic_event_backtrace(char *buf, struct ras_cxl_generic_eve
 	return 0;
 }
 
+static int set_cxl_general_media_event_backtrace(char *buf, struct ras_cxl_general_media_event *ev)
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
+						"hdr_maint_op_class=%u\n"	\
+						"dpa=0x%lx\n"		\
+						"dpa_flags=%u\n"	\
+						"descriptor=%u\n"	\
+						"type=%u\n"		\
+						"transaction_type=%u\n"	\
+						"channel=%u\n"		\
+						"rank=%u\n"		\
+						"device=0x%x\n",	\
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
+						ev->hdr.hdr_maint_op_class,	\
+						ev->dpa,		\
+						ev->dpa_flags,		\
+						ev->descriptor,		\
+						ev->type,		\
+						ev->transaction_type,	\
+						ev->channel,		\
+						ev->rank,		\
+						ev->device);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -541,6 +595,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_GENERIC_EVENT:
 		rc = set_cxl_generic_event_backtrace(buf, (struct ras_cxl_generic_event *)ev);
 		break;
+	case CXL_GENERAL_MEDIA_EVENT:
+		rc = set_cxl_general_media_event_backtrace(buf, (struct ras_cxl_general_media_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -1170,3 +1227,47 @@ cxl_generic_fail:
 		return -1;
 
 }
+
+int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev)
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
+		goto cxl_general_media_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_GENERAL_MEDIA_EVENT, ev);
+	if (rc < 0)
+		goto cxl_general_media_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl_general_media_event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_general_media_fail;
+
+	sprintf(buf, "REASON=%s", "CXL General Media Event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_general_media_fail;
+
+	done = 1;
+
+cxl_general_media_fail:
+
+	if (sockfd >= 0)
+		close(sockfd);
+
+	if (done)
+		return 0;
+	else
+		return -1;
+}
diff --git a/ras-report.h b/ras-report.h
index bf591a6..d9ec7df 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -44,6 +44,7 @@ int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_ev
 int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
 int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
 int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
+int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev);
 
 #else
 
@@ -60,6 +61,7 @@ static inline int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras
 static inline int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
 static inline int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
 static inline int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
+static inline int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


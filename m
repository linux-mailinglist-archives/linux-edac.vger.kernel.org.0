Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C6B6DEFC4
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 10:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjDLIxn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjDLIxj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 04:53:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713B2A25C;
        Wed, 12 Apr 2023 01:53:17 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGDX3fYZz67gR6;
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
Subject: [RFC PATCH 6/7] rasdaemon: Add support for the CXL dram events
Date:   Wed, 12 Apr 2023 16:33:10 +0800
Message-ID: <20230412083312.1384-7-shiju.jose@huawei.com>
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

Add support to log and record the CXL dram events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |   3 +
 ras-events.c      |   9 +++
 ras-events.h      |   1 +
 ras-record.c      |  93 ++++++++++++++++++++++++++++
 ras-record.h      |  23 +++++++
 ras-report.c      | 109 +++++++++++++++++++++++++++++++++
 ras-report.h      |   2 +
 8 files changed, 391 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index e2e80ff..fadf5db 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -857,3 +857,154 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+/*
+ * DRAM Event Record - DER
+ *
+ * CXL rev 3.0 section 8.2.9.2.1.2; Table 8-44
+ */
+#define CXL_DER_VALID_CHANNEL			BIT(0)
+#define CXL_DER_VALID_RANK			BIT(1)
+#define CXL_DER_VALID_NIBBLE			BIT(2)
+#define CXL_DER_VALID_BANK_GROUP		BIT(3)
+#define CXL_DER_VALID_BANK			BIT(4)
+#define CXL_DER_VALID_ROW			BIT(5)
+#define CXL_DER_VALID_COLUMN			BIT(6)
+#define CXL_DER_VALID_CORRECTION_MASK		BIT(7)
+
+int ras_cxl_dram_event_handler(struct trace_seq *s,
+			       struct tep_record *record,
+			       struct tep_event *event, void *context)
+{
+	int len, i;
+	unsigned long long val;
+	struct ras_events *ras = context;
+	struct ras_cxl_dram_event ev;
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
+	if (ev.validity_flags & CXL_DER_VALID_CHANNEL) {
+		if (tep_get_field_val(s,  event, "channel", record, &val, 1) < 0)
+			return -1;
+		ev.channel = val;
+		if (trace_seq_printf(s, "channel:%u ", ev.channel) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_RANK) {
+		if (tep_get_field_val(s,  event, "rank", record, &val, 1) < 0)
+			return -1;
+		ev.rank = val;
+		if (trace_seq_printf(s, "rank:%u ", ev.rank) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_NIBBLE) {
+		if (tep_get_field_val(s,  event, "nibble_mask", record, &val, 1) < 0)
+			return -1;
+		ev.nibble_mask = val;
+		if (trace_seq_printf(s, "nibble_mask:%u ", ev.nibble_mask) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_BANK_GROUP) {
+		if (tep_get_field_val(s,  event, "bank_group", record, &val, 1) < 0)
+			return -1;
+		ev.bank_group = val;
+		if (trace_seq_printf(s, "bank_group:%u ", ev.bank_group) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_BANK) {
+		if (tep_get_field_val(s,  event, "bank", record, &val, 1) < 0)
+			return -1;
+		ev.bank = val;
+		if (trace_seq_printf(s, "bank:%u ", ev.bank) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_ROW) {
+		if (tep_get_field_val(s,  event, "row", record, &val, 1) < 0)
+			return -1;
+		ev.row = val;
+		if (trace_seq_printf(s, "row:%u ", ev.row) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_COLUMN) {
+		if (tep_get_field_val(s,  event, "column", record, &val, 1) < 0)
+			return -1;
+		ev.column = val;
+		if (trace_seq_printf(s, "column:%u ", ev.column) <= 0)
+			return -1;
+	}
+
+	if (ev.validity_flags & CXL_DER_VALID_CORRECTION_MASK) {
+		ev.cor_mask = tep_get_field_raw(s, event, "cor_mask", record, &len, 1);
+		if (!ev.cor_mask)
+			return -1;
+		if (trace_seq_printf(s, "correction_mask:") <= 0)
+			return -1;
+		for (i = 0; i < CXL_EVENT_DER_CORRECTION_MASK_SIZE; i++) {
+			if (trace_seq_printf(s, "%02x ", ev.cor_mask[i]) <= 0)
+				break;
+		}
+	}
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_dram_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_dram_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index 3adca4a..35455af 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -38,4 +38,7 @@ int ras_cxl_generic_event_handler(struct trace_seq *s,
 int ras_cxl_general_media_event_handler(struct trace_seq *s,
 					struct tep_record *record,
 					struct tep_event *event, void *context);
+int ras_cxl_dram_event_handler(struct trace_seq *s,
+			       struct tep_record *record,
+			       struct tep_event *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index 0858b51..00159e6 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -251,6 +251,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_overflow", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_generic_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_general_media", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_dram", enable);
 #endif
 
 free_ras:
@@ -1031,6 +1032,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_general_media");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_dram",
+			       ras_cxl_dram_event_handler, NULL, CXL_DRAM_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_dram");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index 0a3edf5..3fe28da 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -45,6 +45,7 @@ enum {
 	CXL_OVERFLOW_EVENT,
 	CXL_GENERIC_EVENT,
 	CXL_GENERAL_MEDIA_EVENT,
+	CXL_DRAM_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index 0546b29..36f43cf 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -915,6 +915,83 @@ int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_gen
 
 	return rc;
 }
+
+/*
+ * Table and functions to handle cxl:cxl_dram_event
+ */
+static const struct db_fields cxl_dram_event_fields[] = {
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
+	{ .name = "nibble_mask",	.type = "INTEGER" },
+	{ .name = "bank_group",		.type = "INTEGER" },
+	{ .name = "bank",		.type = "INTEGER" },
+	{ .name = "row",		.type = "INTEGER" },
+	{ .name = "column",		.type = "INTEGER" },
+	{ .name = "cor_mask",		.type = "BLOB" },
+};
+
+static const struct db_table_descriptor cxl_dram_event_tab = {
+	.name = "cxl_dram_event",
+	.fields = cxl_dram_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_dram_event_fields),
+};
+
+int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_dram_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_dram_event store: %p\n",
+	    priv->stmt_cxl_dram_event);
+
+	ras_store_cxl_common_hdr(priv->stmt_cxl_dram_event, &ev->hdr);
+	sqlite3_bind_int64(priv->stmt_cxl_dram_event, 13, ev->dpa);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 14, ev->dpa_flags);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 15, ev->descriptor);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 16, ev->type);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 17, ev->transaction_type);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 18, ev->channel);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 19, ev->rank);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 20, ev->nibble_mask);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 21, ev->bank_group);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 22, ev->bank);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 23, ev->row);
+	sqlite3_bind_int(priv->stmt_cxl_dram_event, 24, ev->column);
+	sqlite3_bind_blob(priv->stmt_cxl_dram_event, 25, ev->cor_mask,
+			  CXL_EVENT_DER_CORRECTION_MASK_SIZE, NULL);
+
+	rc = sqlite3_step(priv->stmt_cxl_dram_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do stmt_cxl_dram_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_dram_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset stmt_cxl_dram_event on sqlite: error = %d\n", rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
 #endif
 
 /*
@@ -1302,6 +1379,14 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		if (rc != SQLITE_OK)
 			goto error;
 	}
+
+	rc = ras_mc_create_table(priv, &cxl_dram_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_dram_event,
+					 &cxl_dram_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 	ras->db_priv = priv;
@@ -1464,6 +1549,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_general_media_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_dram_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_dram_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_dram_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index 37c32de..480ff92 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -135,6 +135,7 @@ struct ras_cxl_poison_event {
 #define CXL_HEADERLOG_SIZE_U32          (SZ_512 / sizeof(uint32_t))
 #define CXL_EVENT_RECORD_DATA_LENGTH	0x50
 #define CXL_EVENT_GEN_MED_COMP_ID_SIZE	0x10
+#define CXL_EVENT_DER_CORRECTION_MASK_SIZE	0x20
 
 struct ras_cxl_aer_ue_event {
 	char timestamp[64];
@@ -199,6 +200,24 @@ struct ras_cxl_general_media_event {
 	uint16_t validity_flags;
 };
 
+struct ras_cxl_dram_event {
+	struct ras_cxl_event_common_hdr hdr;
+	uint64_t dpa;
+	uint8_t dpa_flags;
+	uint8_t descriptor;
+	uint8_t type;
+	uint8_t transaction_type;
+	uint8_t channel;
+	uint8_t rank;
+	uint32_t nibble_mask;
+	uint8_t bank_group;
+	uint8_t bank;
+	uint32_t row;
+	uint16_t column;
+	uint8_t *cor_mask;
+	uint16_t validity_flags;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -214,6 +233,7 @@ struct ras_cxl_aer_ce_event;
 struct ras_cxl_overflow_event;
 struct ras_cxl_generic_event;
 struct ras_cxl_general_media_event;
+struct ras_cxl_dram_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -253,6 +273,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_cxl_overflow_event;
 	sqlite3_stmt	*stmt_cxl_generic_event;
 	sqlite3_stmt	*stmt_cxl_general_media_event;
+	sqlite3_stmt	*stmt_cxl_dram_event;
 #endif
 };
 
@@ -287,6 +308,7 @@ int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_eve
 int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
 int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
 int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev);
+int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -306,6 +328,7 @@ static inline int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_
 static inline int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
 static inline int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
 static inline int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev) { return 0; };
+static inline int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 725dc9b..21180b1 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -543,6 +543,68 @@ static int set_cxl_general_media_event_backtrace(char *buf, struct ras_cxl_gener
 	return 0;
 }
 
+static int set_cxl_dram_event_backtrace(char *buf, struct ras_cxl_dram_event *ev)
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
+						"nibble_mask=%u\n"	\
+						"bank_group=%u\n"	\
+						"bank=%u\n"		\
+						"row=%u\n"		\
+						"column=%u\n",		\
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
+						ev->nibble_mask,	\
+						ev->bank_group,		\
+						ev->bank,		\
+						ev->row,		\
+						ev->column);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -598,6 +660,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_GENERAL_MEDIA_EVENT:
 		rc = set_cxl_general_media_event_backtrace(buf, (struct ras_cxl_general_media_event *)ev);
 		break;
+	case CXL_DRAM_EVENT:
+		rc = set_cxl_dram_event_backtrace(buf, (struct ras_cxl_dram_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -1271,3 +1336,47 @@ cxl_general_media_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev)
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
+		goto cxl_dram_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_DRAM_EVENT, ev);
+	if (rc < 0)
+		goto cxl_dram_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl_dram_event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_dram_fail;
+
+	sprintf(buf, "REASON=%s", "CXL DRAM Event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_dram_fail;
+
+	done = 1;
+
+cxl_dram_fail:
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
index d9ec7df..1ad00e0 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -45,6 +45,7 @@ int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_ev
 int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
 int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
 int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev);
+int ras_report_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev);
 
 #else
 
@@ -62,6 +63,7 @@ static inline int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras
 static inline int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
 static inline int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
 static inline int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev) { return 0; };
+static inline int ras_report_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


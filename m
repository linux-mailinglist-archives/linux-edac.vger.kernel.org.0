Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC9BC466A5
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 19:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfFNRzz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 13:55:55 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36444 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfFNRzy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:54 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD8A9A23B25ACEC3CB2C;
        Sat, 15 Jun 2019 01:55:52 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Jun 2019 01:55:46 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <mchehab@kernel.org>, <linuxarm@huawei.com>, <jcm@redhat.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 6/6] rasdaemon: CCIX: Agent Internal error support
Date:   Sat, 15 Jun 2019 01:55:17 +0800
Message-ID: <20190614175517.58442-7-Jonathan.Cameron@huawei.com>
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

Add support for reporting and stroing to sqlite3 of
CCIX Agent Interal errors.

In the current 1.0 CCIX specification these only have vendor_data
defined.  However, they are structured to allow additional fields
in future so we handle them the same way as all the other CCIX
error types.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 ras-ccix-handler.c | 40 ++++++++++++++++++++++++++++++
 ras-ccix-handler.h |  8 ++++++
 ras-events.c       |  9 +++++++
 ras-record.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-record.h       |  3 +++
 5 files changed, 121 insertions(+)

diff --git a/ras-ccix-handler.c b/ras-ccix-handler.c
index 69baa48..2088790 100644
--- a/ras-ccix-handler.c
+++ b/ras-ccix-handler.c
@@ -606,3 +606,43 @@ int ras_ccix_link_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+int ras_ccix_agent_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context)
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
+	trace_seq_printf(s, "%d %s id:%d CCIX Agent Internal error: %s ue:%d nocomm:%d degraded:%d deferred:%d physical addr: 0x%llx mask: 0x%llx",
+			 ev.error_seq, err_severity(ev.severity),
+			 ev.source, ccix_component_type(ev.component),
+			 (ev.severity_detail & 0x1) ? 1 : 0,
+			 (ev.severity_detail & 0x2) ? 1 : 0,
+			 (ev.severity_detail & 0x4) ? 1 : 0,
+			 (ev.severity_detail & 0x8) ? 1 : 0,
+			 ev.address,
+			 err_mask(ev.pa_mask_lsb));
+
+	ras_store_ccix_agent_event(ras, &ev);
+
+	return 0;
+}
diff --git a/ras-ccix-handler.h b/ras-ccix-handler.h
index 3def534..c53e3ee 100644
--- a/ras-ccix-handler.h
+++ b/ras-ccix-handler.h
@@ -33,6 +33,9 @@ int ras_ccix_port_event_handler(struct trace_seq *s,
 int ras_ccix_link_event_handler(struct trace_seq *s,
 				struct pevent_record *record,
 				struct event_format *event, void *context);
+int ras_ccix_agent_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context);
 
 /* Perhaps unnecessary paranoia, but the tracepoint structure is packed */
 #pragma pack(1)
@@ -86,6 +89,10 @@ struct cper_ccix_link_err_compact {
 	uint8_t link_id;
 	uint8_t credit_type;
 };
+
+struct cper_ccix_agent_internal_err_compact {
+	uint32_t validation_bits;
+};
 #pragma pack()
 
 #define CCIX_MEM_ERR_GENERIC_MEM_VALID		0x0001
@@ -128,4 +135,5 @@ struct cper_ccix_link_err_compact {
 #define CCIX_LINK_ERR_MESSAGE_VALID		0x0010
 #define CCIX_LINK_ERR_VENDOR_DATA_VALID		0x0020
 
+#define CCIX_AGENT_ERR_VENDOR_DATA_VALID	0x0001
 #endif
diff --git a/ras-events.c b/ras-events.c
index 96c406e..88fcad1 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -209,6 +209,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_atc_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_port_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_link_event", enable);
+	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_agent_event", enable);
 #endif
 
 #ifdef HAVE_MCE
@@ -736,6 +737,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "ras", "ccix_link_event");
+	rc = add_event_handler(ras, pevent, page_size, "ras",
+			       "ccix_agent_error_event",
+			       ras_ccix_agent_event_handler);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Cant' get traces from %s:%s\n",
+		    "ras", "ccix_agent_error_event");
 #endif
 
 #ifdef HAVE_NON_STANDARD
diff --git a/ras-record.c b/ras-record.c
index 51ccc02..0525ff0 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -637,6 +637,62 @@ int ras_store_ccix_link_event(struct ras_events *ras, struct ras_ccix_event *ev)
 	log(TERM, LOG_INFO, "register inserted at db\n");
 	return rc;
 }
+
+enum {
+	ccix_agent_field_vendor = ccix_field_common_end,
+};
+
+static const struct db_fields ccix_agent_event_fields[] = {
+	CCIX_COMMON_FIELDS,
+	[ccix_agent_field_vendor] =	{ .name = "vendor_data",	.type = "BLOB" },
+};
+
+static const struct db_table_descriptor ccix_agent_event_tab = {
+	.name = "ccix_agent_event",
+	.fields = ccix_agent_event_fields,
+	.num_fields = ARRAY_SIZE(ccix_agent_event_fields),
+};
+
+int ras_store_ccix_agent_event(struct ras_events *ras,
+			       struct ras_ccix_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+	struct cper_ccix_agent_internal_err_compact *agent =
+		(struct cper_ccix_agent_internal_err_compact *)ev->cper_data;
+	sqlite3_stmt *rec = priv->stmt_ccix_agent_record;
+
+	if (!priv || !rec)
+		return 0;
+	log(TERM, LOG_INFO, "ccix_agent_eventstore: %p\n", rec);
+
+	ras_store_ccix_common(rec, ev);
+
+	if (agent->validation_bits & CCIX_AGENT_ERR_VENDOR_DATA_VALID)
+		sqlite3_bind_blob(rec, ccix_agent_field_vendor,
+				  ev->vendor_data, ev->vendor_data_length,
+				  NULL);
+
+	rc = sqlite3_step(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do ccix_agent_record step on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_reset(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset ccix_agent_record on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_clear_bindings(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear ccix_agent_record: error %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+	return rc;
+}
 #endif
 /*
  * Table and functions to handle ras:non standard
@@ -1052,6 +1108,11 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 	if (rc == SQLITE_OK)
 		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_link_record,
 					 &ccix_link_event_tab);
+
+	rc = ras_mc_create_table(priv, &ccix_agent_event_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_agent_record,
+					 &ccix_agent_event_tab);
 #endif
 
 #ifdef HAVE_MCE
diff --git a/ras-record.h b/ras-record.h
index 47bfb0d..07be4bf 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -119,6 +119,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_ccix_atc_record;
 	sqlite3_stmt	*stmt_ccix_port_record;
 	sqlite3_stmt	*stmt_ccix_link_record;
+	sqlite3_stmt	*stmt_ccix_agent_record;
 #endif
 #ifdef HAVE_NON_STANDARD
 	sqlite3_stmt	*stmt_non_standard_record;
@@ -138,6 +139,7 @@ int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_ccix_event *ev
 int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_ccix_link_event(struct ras_events *ras, struct ras_ccix_event *ev);
+int ras_store_ccix_agent_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 
@@ -152,6 +154,7 @@ static inline int ras_store_ccix_cache_event(struct ras_events *ras, struct ras_
 static inline int ras_store_ccix_atc_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_ccix_port_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_ccix_link_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
+static inline int ras_store_ccix_agent_event(struct ras_events *ras, struct ras_ccix_event *ev) {return 0; };
 static inline int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 
-- 
2.20.1


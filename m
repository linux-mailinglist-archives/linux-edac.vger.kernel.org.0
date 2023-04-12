Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC316DEDE0
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 10:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjDLIgn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 04:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjDLIgS (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 04:36:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C77E65BA;
        Wed, 12 Apr 2023 01:34:45 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGDW6hBvz67m7K;
        Wed, 12 Apr 2023 16:32:43 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 09:33:40 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 3/7] rasdaemon: Add support for the CXL overflow events
Date:   Wed, 12 Apr 2023 16:33:07 +0800
Message-ID: <20230412083312.1384-4-shiju.jose@huawei.com>
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

Add support to log and record the CXL overflow events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |  3 ++
 ras-events.c      |  9 +++++
 ras-events.h      |  1 +
 ras-record.c      | 69 +++++++++++++++++++++++++++++++++
 ras-record.h      | 15 ++++++++
 ras-report.c      | 77 +++++++++++++++++++++++++++++++++++++
 ras-report.h      |  2 +
 8 files changed, 274 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 025e582..b08c5e3 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -418,3 +418,101 @@ int ras_cxl_aer_ce_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+/*
+ * CXL rev 3.0 section 8.2.9.2.2; Table 8-49
+ */
+enum cxl_event_log_type {
+	CXL_EVENT_TYPE_INFO = 0x00,
+	CXL_EVENT_TYPE_WARN,
+	CXL_EVENT_TYPE_FAIL,
+	CXL_EVENT_TYPE_FATAL,
+	CXL_EVENT_TYPE_UNKNOWN
+};
+
+static char *cxl_event_log_type_str(uint32_t log_type)
+{
+
+	switch (log_type) {
+	case CXL_EVENT_TYPE_INFO:
+		return "Informational";
+	case CXL_EVENT_TYPE_WARN:
+		return "Warning";
+	case CXL_EVENT_TYPE_FAIL:
+		return "Failure";
+	case CXL_EVENT_TYPE_FATAL:
+		return "Fatal";
+	default:
+		break;
+	}
+
+	return "Unknown";
+}
+
+int ras_cxl_overflow_event_handler(struct trace_seq *s,
+				   struct tep_record *record,
+				   struct tep_event *event, void *context)
+{
+	int len;
+	unsigned long long val;
+	struct ras_events *ras = context;
+	struct ras_cxl_overflow_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	get_timestamp(s, record, ras, (char *)&ev.timestamp, sizeof(ev.timestamp));
+	if (trace_seq_printf(s, "%s ", ev.timestamp) <= 0)
+		return -1;
+
+	ev.memdev = tep_get_field_raw(s, event, "memdev", record, &len, 1);
+	if (!ev.memdev)
+		return -1;
+	if (trace_seq_printf(s, "memdev:%s ", ev.memdev) <= 0)
+		return -1;
+
+	ev.host = tep_get_field_raw(s, event, "host", record, &len, 1);
+	if (!ev.host)
+		return -1;
+	if (trace_seq_printf(s, "host:%s ", ev.host) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "serial", record, &val, 1) < 0)
+		return -1;
+	ev.serial = val;
+	if (trace_seq_printf(s, "serial:0x%llx ", (unsigned long long)ev.serial) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "log", record, &val, 1) < 0)
+		return -1;
+	ev.log_type = cxl_event_log_type_str(val);
+	if (trace_seq_printf(s, "log type:%s ", ev.log_type) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "count", record, &val, 1) < 0)
+		return -1;
+	ev.count = val;
+
+	if (tep_get_field_val(s,  event, "first_ts", record, &val, 1) < 0)
+		return -1;
+	convert_timestamp(val, ev.first_ts, sizeof(ev.first_ts));
+
+	if (tep_get_field_val(s,  event, "last_ts", record, &val, 1) < 0)
+		return -1;
+	convert_timestamp(val, ev.last_ts, sizeof(ev.last_ts));
+
+	if (ev.count) {
+		if (trace_seq_printf(s, "%u errors from %s to %s\n",
+				     ev.count, ev.first_ts, ev.last_ts) <= 0)
+			return -1;
+	}
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_overflow_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_overflow_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index 711daf4..e7847ec 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -29,4 +29,7 @@ int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
 int ras_cxl_aer_ce_event_handler(struct trace_seq *s,
 				 struct tep_record *record,
 				 struct tep_event *event, void *context);
+int ras_cxl_overflow_event_handler(struct trace_seq *s,
+				   struct tep_record *record,
+				   struct tep_event *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index 716317b..ded8648 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -248,6 +248,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_uncorrectable_error", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_correctable_error", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_overflow", enable);
 #endif
 
 free_ras:
@@ -1004,6 +1005,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_aer_correctable_error");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_overflow",
+			       ras_cxl_overflow_event_handler, NULL, CXL_OVERFLOW_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_overflow");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index dc7bdfb..ea590c9 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -42,6 +42,7 @@ enum {
 	CXL_POISON_EVENT,
 	CXL_AER_UE_EVENT,
 	CXL_AER_CE_EVENT,
+	CXL_OVERFLOW_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index 82e310b..57fe117 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -720,6 +720,59 @@ int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_eve
 
 	return rc;
 }
+
+/*
+ * Table and functions to handle cxl:cxl_overflow
+ */
+static const struct db_fields cxl_overflow_event_fields[] = {
+	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",		.type = "TEXT" },
+	{ .name = "memdev",		.type = "TEXT" },
+	{ .name = "host",		.type = "TEXT" },
+	{ .name = "serial",		.type = "INTEGER" },
+	{ .name = "log_type",		.type = "TEXT" },
+	{ .name = "count",		.type = "INTEGER" },
+	{ .name = "first_ts",		.type = "TEXT" },
+	{ .name = "last_ts",		.type = "TEXT" },
+};
+
+static const struct db_table_descriptor cxl_overflow_event_tab = {
+	.name = "cxl_overflow_event",
+	.fields = cxl_overflow_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_overflow_event_fields),
+};
+
+int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_overflow_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_overflow_event store: %p\n", priv->stmt_cxl_overflow_event);
+
+	sqlite3_bind_text(priv->stmt_cxl_overflow_event, 1, ev->timestamp, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_overflow_event, 2, ev->memdev, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_overflow_event, 3, ev->host, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_overflow_event, 4, ev->serial);
+	sqlite3_bind_text(priv->stmt_cxl_overflow_event, 5, ev->log_type, -1, NULL);
+	sqlite3_bind_int(priv->stmt_cxl_overflow_event, 6, ev->count);
+	sqlite3_bind_text(priv->stmt_cxl_overflow_event, 7, ev->first_ts, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_overflow_event, 8, ev->last_ts, -1, NULL);
+
+	rc = sqlite3_step(priv->stmt_cxl_overflow_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do cxl_overflow_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_overflow_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset cxl_overflow_event on sqlite: error = %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
 #endif
 
 /*
@@ -1083,6 +1136,14 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		if (rc != SQLITE_OK)
 			goto error;
 	}
+
+	rc = ras_mc_create_table(priv, &cxl_overflow_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_overflow_event,
+					 &cxl_overflow_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 	ras->db_priv = priv;
@@ -1221,6 +1282,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_aer_ce_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_overflow_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_overflow_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_overflow_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index ab7153d..90db6ad 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -152,6 +152,17 @@ struct ras_cxl_aer_ce_event {
 	uint32_t error_status;
 };
 
+struct ras_cxl_overflow_event {
+	char timestamp[64];
+	const char *memdev;
+	const char *host;
+	uint64_t serial;
+	const char *log_type;
+	char first_ts[64];
+	char last_ts[64];
+	uint16_t count;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -164,6 +175,7 @@ struct ras_mf_event;
 struct ras_cxl_poison_event;
 struct ras_cxl_aer_ue_event;
 struct ras_cxl_aer_ce_event;
+struct ras_cxl_overflow_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -200,6 +212,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_cxl_poison_event;
 	sqlite3_stmt	*stmt_cxl_aer_ue_event;
 	sqlite3_stmt	*stmt_cxl_aer_ce_event;
+	sqlite3_stmt	*stmt_cxl_overflow_event;
 #endif
 };
 
@@ -231,6 +244,7 @@ int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
+int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -247,6 +261,7 @@ static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event
 static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 static inline int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
+static inline int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 63b47f5..dbed454 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -421,6 +421,36 @@ static int set_cxl_aer_ce_event_backtrace(char *buf, struct ras_cxl_aer_ce_event
 	return 0;
 }
 
+static int set_cxl_overflow_event_backtrace(char *buf, struct ras_cxl_overflow_event *ev)
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
+						"count=%u\n"		\
+						"first_ts=%s\n"		\
+						"last_ts=%s\n",		\
+						ev->timestamp,		\
+						ev->memdev,		\
+						ev->host,		\
+						ev->serial,		\
+						ev->log_type,		\
+						ev->count,		\
+						ev->first_ts,		\
+						ev->last_ts);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -467,6 +497,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_AER_CE_EVENT:
 		rc = set_cxl_aer_ce_event_backtrace(buf, (struct ras_cxl_aer_ce_event *)ev);
 		break;
+	case CXL_OVERFLOW_EVENT:
+		rc = set_cxl_overflow_event_backtrace(buf, (struct ras_cxl_overflow_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -1007,3 +1040,47 @@ cxl_aer_ce_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev)
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
+		goto cxl_overflow_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_OVERFLOW_EVENT, ev);
+	if (rc < 0)
+		goto cxl_overflow_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl-overflow");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_overflow_fail;
+
+	sprintf(buf, "REASON=%s", "CXL overflow");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_overflow_fail;
+
+	done = 1;
+
+cxl_overflow_fail:
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
index 46155ee..204d485 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -42,6 +42,7 @@ int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
+int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev);
 
 #else
 
@@ -56,6 +57,7 @@ static inline int ras_report_mf_event(struct ras_events *ras, struct ras_mf_even
 static inline int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 static inline int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 static inline int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
+static inline int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


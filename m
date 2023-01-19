Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94435673FC0
	for <lists+linux-edac@lfdr.de>; Thu, 19 Jan 2023 18:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjASRTG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Jan 2023 12:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjASRS6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Jan 2023 12:18:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCB545BD8;
        Thu, 19 Jan 2023 09:18:35 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NyTq256tLz6J9bx;
        Fri, 20 Jan 2023 01:18:06 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.145.221) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 19 Jan 2023 17:18:33 +0000
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 4/4] rasdaemon: Add support for the CXL AER correctable errors
Date:   Thu, 19 Jan 2023 17:18:09 +0000
Message-ID: <20230119171809.1406-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20230119171809.1406-1-shiju.jose@huawei.com>
References: <20230119171809.1406-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.145.221]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support to log and record the CXL AER correctable errors.

The corresponding Kernel patch here:
https://patchwork.kernel.org/project/cxl/patch/166974413388.1608150.5875712482260436188.stgit@djiang5-desk3.ch.intel.com/

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |  3 +++
 ras-events.c      |  9 +++++++
 ras-events.h      |  1 +
 ras-record.c      | 57 ++++++++++++++++++++++++++++++++++++++++
 ras-record.h      | 10 +++++++
 ras-report.c      | 67 +++++++++++++++++++++++++++++++++++++++++++++++
 ras-report.h      |  2 ++
 8 files changed, 213 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index b1aedd7..8136635 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -180,6 +180,14 @@ int ras_cxl_poison_event_handler(struct trace_seq *s,
 #define CXL_AER_UE_IDE_TX_ERR		BIT(15)
 #define CXL_AER_UE_IDE_RX_ERR		BIT(16)
 
+#define CXL_AER_CE_CACHE_DATA_ECC	BIT(0)
+#define CXL_AER_CE_MEM_DATA_ECC		BIT(1)
+#define CXL_AER_CE_CRC_THRESH		BIT(2)
+#define CXL_AER_CE_RETRY_THRESH		BIT(3)
+#define CXL_AER_CE_CACHE_POISON		BIT(4)
+#define CXL_AER_CE_MEM_POISON		BIT(5)
+#define CXL_AER_CE_PHYS_LAYER_ERR	BIT(6)
+
 struct cxl_error_list {
 	uint32_t bit;
 	const char *error;
@@ -203,6 +211,16 @@ static const struct cxl_error_list cxl_aer_ue[] = {
 	{ .bit = CXL_AER_UE_IDE_RX_ERR, .error = "IDE Rx Error" },
 };
 
+static const struct cxl_error_list cxl_aer_ce[] = {
+	{ .bit = CXL_AER_CE_CACHE_DATA_ECC, .error = "Cache Data ECC Error" },
+	{ .bit = CXL_AER_CE_MEM_DATA_ECC, .error = "Memory Data ECC Error" },
+	{ .bit = CXL_AER_CE_CRC_THRESH, .error = "CRC Threshold Hit" },
+	{ .bit = CXL_AER_CE_RETRY_THRESH, .error = "Retry Threshold" },
+	{ .bit = CXL_AER_CE_CACHE_POISON, .error = "Received Cache Poison From Peer" },
+	{ .bit = CXL_AER_CE_MEM_POISON, .error = "Received Memory Poison From Peer" },
+	{ .bit = CXL_AER_CE_PHYS_LAYER_ERR, .error = "Received Error From Physical Layer" },
+};
+
 static void decode_cxl_error_status(struct trace_seq *s, uint32_t status,
 				   const struct cxl_error_list *cxl_error_list,
 				   uint8_t num_elems)
@@ -285,3 +303,49 @@ int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+int ras_cxl_aer_ce_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context)
+{
+	int len;
+	unsigned long long val;
+	time_t now;
+	struct tm *tm;
+	struct ras_events *ras = context;
+	struct ras_cxl_aer_ce_event ev;
+
+	now = record->ts/user_hz + ras->uptime_diff;
+	tm = localtime(&now);
+	if (tm)
+		strftime(ev.timestamp, sizeof(ev.timestamp),
+			 "%Y-%m-%d %H:%M:%S %z", tm);
+	else
+		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
+	trace_seq_printf(s, "%s ", ev.timestamp);
+
+	ev.dev_name = pevent_get_field_raw(s, event, "dev_name",
+					   record, &len, 1);
+	if (!ev.dev_name)
+		return -1;
+	trace_seq_printf(s, "dev_name:%s ", ev.dev_name);
+
+	if (pevent_get_field_val(s, event, "status", record, &val, 1) < 0)
+		return -1;
+	ev.error_status = val;
+	trace_seq_printf(s, "error status:");
+	decode_cxl_error_status(s, ev.error_status,
+				cxl_aer_ce, ARRAY_SIZE(cxl_aer_ce));
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_aer_ce_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_aer_ce_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index f96ed35..253b5a3 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -26,4 +26,7 @@ int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
 				 struct pevent_record *record,
 				 struct event_format *event, void *context);
 
+int ras_cxl_aer_ce_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index 5688878..1fa1fbc 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -241,6 +241,7 @@ int toggle_ras_mc_event(int enable)
 #ifdef HAVE_CXL
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_uncorrectable_error", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_correctable_error", enable);
 #endif
 
 free_ras:
@@ -947,6 +948,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_aer_uncorrectable_error");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_aer_correctable_error",
+			       ras_cxl_aer_ce_event_handler, NULL, CXL_AER_CE_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_aer_correctable_error");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index b9ae336..90cecb7 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -41,6 +41,7 @@ enum {
 	MF_EVENT,
 	CXL_POISON_EVENT,
 	CXL_AER_UE_EVENT,
+	CXL_AER_CE_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index 4b4c068..e0d9015 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -666,6 +666,48 @@ int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_eve
 	return rc;
 }
 
+/*
+ * Table and functions to handle cxl:cxl_aer_correctable_error
+ */
+static const struct db_fields cxl_aer_ce_event_fields[] = {
+	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",            .type = "TEXT" },
+	{ .name = "dev_name",             .type = "TEXT" },
+	{ .name = "error_status",         .type = "INTEGER" },
+};
+
+static const struct db_table_descriptor cxl_aer_ce_event_tab = {
+	.name = "cxl_aer_ce_event",
+	.fields = cxl_aer_ce_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_aer_ce_event_fields),
+};
+
+int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_aer_ce_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_aer_ce_event store: %p\n", priv->stmt_cxl_aer_ce_event);
+
+	sqlite3_bind_text(priv->stmt_cxl_aer_ce_event, 1, ev->timestamp, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_aer_ce_event, 2, ev->dev_name, -1, NULL);
+	sqlite3_bind_int(priv->stmt_cxl_aer_ce_event, 3, ev->error_status);
+
+	rc = sqlite3_step(priv->stmt_cxl_aer_ce_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do cxl_aer_ce_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_aer_ce_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset cxl_aer_ce_event on sqlite: error = %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
 #endif
 
 /*
@@ -1022,6 +1064,13 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 			goto error;
 	}
 
+	rc = ras_mc_create_table(priv, &cxl_aer_ce_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_aer_ce_event,
+					 &cxl_aer_ce_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 	ras->db_priv = priv;
@@ -1152,6 +1201,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_aer_ue_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_aer_ce_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_aer_ce_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_aer_ce_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index 0e2c178..1f28cc1 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -140,6 +140,12 @@ struct ras_cxl_aer_ue_event {
 	uint32_t *header_log;
 };
 
+struct ras_cxl_aer_ce_event {
+	char timestamp[64];
+	const char *dev_name;
+	uint32_t error_status;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -151,6 +157,7 @@ struct diskerror_event;
 struct ras_mf_event;
 struct ras_cxl_poison_event;
 struct ras_cxl_aer_ue_event;
+struct ras_cxl_aer_ce_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -186,6 +193,7 @@ struct sqlite3_priv {
 #ifdef HAVE_CXL
 	sqlite3_stmt	*stmt_cxl_poison_event;
 	sqlite3_stmt	*stmt_cxl_aer_ue_event;
+	sqlite3_stmt	*stmt_cxl_aer_ce_event;
 #endif
 };
 
@@ -216,6 +224,7 @@ int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev
 int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
+int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -231,6 +240,7 @@ static inline int ras_store_diskerror_event(struct ras_events *ras, struct diske
 static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
+static inline int ras_store_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index d040ec1..4580a1d 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -389,6 +389,26 @@ static int set_cxl_aer_ue_event_backtrace(char *buf, struct ras_cxl_aer_ue_event
 	return 0;
 }
 
+static int set_cxl_aer_ce_event_backtrace(char *buf, struct ras_cxl_aer_ce_event *ev)
+{
+	char bt_buf[MAX_BACKTRACE_SIZE];
+
+	if (!buf || !ev)
+		return -1;
+
+	sprintf(bt_buf, "BACKTRACE="	\
+						"timestamp=%s\n"	\
+						"dev_name=%s\n"		\
+						"error_status=%u\n"	\
+						ev->timestamp,		\
+						ev->dev_name,		\
+						ev->error_status);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -432,6 +452,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_AER_UE_EVENT:
 		rc = set_cxl_aer_ue_event_backtrace(buf, (struct ras_cxl_aer_ue_event *)ev);
 		break;
+	case CXL_AER_CE_EVENT:
+		rc = set_cxl_aer_ce_event_backtrace(buf, (struct ras_cxl_aer_ce_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -928,3 +951,47 @@ cxl_aer_ue_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev)
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
+		goto cxl_aer_ce_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_AER_CE_EVENT, ev);
+	if (rc < 0)
+		goto cxl_aer_ce_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl-aer-correctable-error");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_aer_ce_fail;
+
+	sprintf(buf, "REASON=%s", "CXL AER correctable error");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_aer_ce_fail;
+
+	done = 1;
+
+cxl_aer_ce_fail:
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
index dfe89d1..46155ee 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -41,6 +41,7 @@ int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *e
 int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
+int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev);
 
 #else
 
@@ -54,6 +55,7 @@ static inline int ras_report_diskerror_event(struct ras_events *ras, struct disk
 static inline int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 static inline int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 static inline int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
+static inline int ras_report_cxl_aer_ce_event(struct ras_events *ras, struct ras_cxl_aer_ce_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


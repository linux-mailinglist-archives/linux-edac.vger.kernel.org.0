Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFF4673FBF
	for <lists+linux-edac@lfdr.de>; Thu, 19 Jan 2023 18:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjASRTF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 19 Jan 2023 12:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjASRS6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 19 Jan 2023 12:18:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0345BCA;
        Thu, 19 Jan 2023 09:18:35 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NyTq24BfYz6J9b0;
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
Subject: [RFC PATCH 3/4] rasdaemon: Add support for the CXL AER uncorrectable errors
Date:   Thu, 19 Jan 2023 17:18:08 +0000
Message-ID: <20230119171809.1406-4-shiju.jose@huawei.com>
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

Add support to log and record the CXL AER uncorrectable errors.

The corresponding Kernel patch here:
https://patchwork.kernel.org/project/cxl/patch/166974413388.1608150.5875712482260436188.stgit@djiang5-desk3.ch.intel.com/

Note: It was found that the header log data to be converted to the
      big-endian format to correctly store in the SQLite database, likely
      because the SQLite database seems uses the big-endian storage.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 125 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |   5 ++
 ras-events.c      |   9 ++++
 ras-events.h      |   1 +
 ras-record.c      |  65 ++++++++++++++++++++++++
 ras-record.h      |  16 ++++++
 ras-report.c      |  69 +++++++++++++++++++++++++
 ras-report.h      |   2 +
 8 files changed, 292 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index 11531ef..b1aedd7 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -21,6 +21,7 @@
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-report.h"
+#include <endian.h>
 
 /* Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
@@ -160,3 +161,127 @@ int ras_cxl_poison_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+/* CXL AER Errors */
+
+#define CXL_AER_UE_CACHE_DATA_PARITY	BIT(0)
+#define CXL_AER_UE_CACHE_ADDR_PARITY	BIT(1)
+#define CXL_AER_UE_CACHE_BE_PARITY	BIT(2)
+#define CXL_AER_UE_CACHE_DATA_ECC	BIT(3)
+#define CXL_AER_UE_MEM_DATA_PARITY	BIT(4)
+#define CXL_AER_UE_MEM_ADDR_PARITY	BIT(5)
+#define CXL_AER_UE_MEM_BE_PARITY	BIT(6)
+#define CXL_AER_UE_MEM_DATA_ECC		BIT(7)
+#define CXL_AER_UE_REINIT_THRESH	BIT(8)
+#define CXL_AER_UE_RSVD_ENCODE		BIT(9)
+#define CXL_AER_UE_POISON		BIT(10)
+#define CXL_AER_UE_RECV_OVERFLOW	BIT(11)
+#define CXL_AER_UE_INTERNAL_ERR		BIT(14)
+#define CXL_AER_UE_IDE_TX_ERR		BIT(15)
+#define CXL_AER_UE_IDE_RX_ERR		BIT(16)
+
+struct cxl_error_list {
+	uint32_t bit;
+	const char *error;
+};
+
+static const struct cxl_error_list cxl_aer_ue[] = {
+	{ .bit = CXL_AER_UE_CACHE_DATA_PARITY, .error = "Cache Data Parity Error" },
+	{ .bit = CXL_AER_UE_CACHE_ADDR_PARITY, .error = "Cache Address Parity Error" },
+	{ .bit = CXL_AER_UE_CACHE_BE_PARITY, .error = "Cache Byte Enable Parity Error" },
+	{ .bit = CXL_AER_UE_CACHE_DATA_ECC, .error = "Cache Data ECC Error" },
+	{ .bit = CXL_AER_UE_MEM_DATA_PARITY, .error = "Memory Data Parity Error" },
+	{ .bit = CXL_AER_UE_MEM_ADDR_PARITY, .error = "Memory Address Parity Error" },
+	{ .bit = CXL_AER_UE_MEM_BE_PARITY, .error = "Memory Byte Enable Parity Error" },
+	{ .bit = CXL_AER_UE_MEM_DATA_ECC, .error = "Memory Data ECC Error" },
+	{ .bit = CXL_AER_UE_REINIT_THRESH, .error = "REINIT Threshold Hit" },
+	{ .bit = CXL_AER_UE_RSVD_ENCODE, .error = "Received Unrecognized Encoding" },
+	{ .bit = CXL_AER_UE_POISON, .error = "Received Poison From Peer" },
+	{ .bit = CXL_AER_UE_RECV_OVERFLOW, .error = "Receiver Overflow" },
+	{ .bit = CXL_AER_UE_INTERNAL_ERR, .error = "Component Specific Error" },
+	{ .bit = CXL_AER_UE_IDE_TX_ERR, .error = "IDE Tx Error" },
+	{ .bit = CXL_AER_UE_IDE_RX_ERR, .error = "IDE Rx Error" },
+};
+
+static void decode_cxl_error_status(struct trace_seq *s, uint32_t status,
+				   const struct cxl_error_list *cxl_error_list,
+				   uint8_t num_elems)
+{
+	int i;
+
+	for (i = 0; i < num_elems; i++) {
+		if (status & cxl_error_list[i].bit)
+			trace_seq_printf(s, "\'%s\' ", cxl_error_list[i].error);
+	}
+}
+
+int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context)
+{
+	int len, i;
+	unsigned long long val;
+	time_t now;
+	struct tm *tm;
+	struct ras_events *ras = context;
+	struct ras_cxl_aer_ue_event ev;
+
+	memset(&ev, 0, sizeof(ev));
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
+
+	trace_seq_printf(s, "error status:");
+	decode_cxl_error_status(s, ev.error_status,
+				cxl_aer_ue, ARRAY_SIZE(cxl_aer_ue));
+
+	if (pevent_get_field_val(s,  event, "first_error", record, &val, 1) < 0)
+		return -1;
+	ev.first_error = val;
+
+	trace_seq_printf(s, "first error:");
+	decode_cxl_error_status(s, ev.first_error,
+				cxl_aer_ue, ARRAY_SIZE(cxl_aer_ue));
+
+	ev.header_log = pevent_get_field_raw(s, event, "header_log",
+					     record, &len, 1);
+	if (!ev.header_log)
+		return -1;
+	trace_seq_printf(s, "header log:\n");
+	for (i = 0; i < CXL_HEADERLOG_SIZE_U32; i++) {
+		trace_seq_printf(s, "%08x ", ev.header_log[i]);
+		if ((i > 0) && ((i % 20) == 0))
+			trace_seq_printf(s, "\n");
+		/* Convert header log data to the big-endian format because
+		 * the SQLite database seems uses the big-endian storage.
+		 */
+		ev.header_log[i] = htobe32(ev.header_log[i]);
+	}
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_aer_ue_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_aer_ue_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index 4508624..f96ed35 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -21,4 +21,9 @@
 int ras_cxl_poison_event_handler(struct trace_seq *s,
 			 struct pevent_record *record,
 			 struct event_format *event, void *context);
+
+int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context);
+
 #endif
diff --git a/ras-events.c b/ras-events.c
index 09142f2..5688878 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -240,6 +240,7 @@ int toggle_ras_mc_event(int enable)
 
 #ifdef HAVE_CXL
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_uncorrectable_error", enable);
 #endif
 
 free_ras:
@@ -938,6 +939,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_poison");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_aer_uncorrectable_error",
+			       ras_cxl_aer_ue_event_handler, NULL, CXL_AER_UE_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_aer_uncorrectable_error");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index 24f7ccc..b9ae336 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -40,6 +40,7 @@ enum {
 	DISKERROR_EVENT,
 	MF_EVENT,
 	CXL_POISON_EVENT,
+	CXL_AER_UE_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index c3bc961..4b4c068 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -618,6 +618,54 @@ int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_eve
 
 	return rc;
 }
+
+/*
+ * Table and functions to handle cxl:cxl_aer_uncorrectable_error
+ */
+static const struct db_fields cxl_aer_ue_event_fields[] = {
+	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",            .type = "TEXT" },
+	{ .name = "dev_name",             .type = "TEXT" },
+	{ .name = "error_status",         .type = "INTEGER" },
+	{ .name = "first_error",          .type = "INTEGER" },
+	{ .name = "header_log",           .type = "BLOB" },
+};
+
+static const struct db_table_descriptor cxl_aer_ue_event_tab = {
+	.name = "cxl_aer_ue_event",
+	.fields = cxl_aer_ue_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_aer_ue_event_fields),
+};
+
+int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_aer_ue_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_aer_ue_event store: %p\n", priv->stmt_cxl_aer_ue_event);
+
+	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 1, ev->timestamp, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 2, ev->dev_name, -1, NULL);
+	sqlite3_bind_int(priv->stmt_cxl_aer_ue_event, 3, ev->error_status);
+	sqlite3_bind_int(priv->stmt_cxl_aer_ue_event, 4, ev->first_error);
+	sqlite3_bind_blob(priv->stmt_cxl_aer_ue_event, 5, ev->header_log, CXL_HEADERLOG_SIZE, NULL);
+
+	rc = sqlite3_step(priv->stmt_cxl_aer_ue_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do cxl_aer_ue_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_aer_ue_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset cxl_aer_ue_event on sqlite: error = %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
+
 #endif
 
 /*
@@ -965,6 +1013,15 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		if (rc != SQLITE_OK)
 			goto error;
 	}
+
+	rc = ras_mc_create_table(priv, &cxl_aer_ue_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_aer_ue_event,
+					 &cxl_aer_ue_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
+
 #endif
 
 	ras->db_priv = priv;
@@ -1087,6 +1144,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_poison_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_aer_ue_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_aer_ue_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_aer_ue_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index e5bf483..0e2c178 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -128,6 +128,18 @@ struct ras_cxl_poison_event {
 	char overflow_ts[64];
 };
 
+#define SZ_512                          0x200
+#define CXL_HEADERLOG_SIZE              SZ_512
+#define CXL_HEADERLOG_SIZE_U32          (SZ_512 / sizeof(uint32_t))
+
+struct ras_cxl_aer_ue_event {
+	char timestamp[64];
+	const char *dev_name;
+	uint32_t error_status;
+	uint32_t first_error;
+	uint32_t *header_log;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -138,6 +150,7 @@ struct devlink_event;
 struct diskerror_event;
 struct ras_mf_event;
 struct ras_cxl_poison_event;
+struct ras_cxl_aer_ue_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -172,6 +185,7 @@ struct sqlite3_priv {
 #endif
 #ifdef HAVE_CXL
 	sqlite3_stmt	*stmt_cxl_poison_event;
+	sqlite3_stmt	*stmt_cxl_aer_ue_event;
 #endif
 };
 
@@ -201,6 +215,7 @@ int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
 int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
+int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -215,6 +230,7 @@ static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink
 static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
 static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
+static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 415920a..d040ec1 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -367,6 +367,28 @@ static int set_cxl_poison_event_backtrace(char *buf, struct ras_cxl_poison_event
 	return 0;
 }
 
+static int set_cxl_aer_ue_event_backtrace(char *buf, struct ras_cxl_aer_ue_event *ev)
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
+						"first_error=%u\n"	\
+						ev->timestamp,		\
+						ev->dev_name,		\
+						ev->error_status,	\
+						ev->first_error);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -407,6 +429,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_POISON_EVENT:
 		rc = set_cxl_poison_event_backtrace(buf, (struct ras_cxl_poison_event *)ev);
 		break;
+	case CXL_AER_UE_EVENT:
+		rc = set_cxl_aer_ue_event_backtrace(buf, (struct ras_cxl_aer_ue_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -859,3 +884,47 @@ cxl_poison_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev)
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
+		goto cxl_aer_ue_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_AER_UE_EVENT, ev);
+	if (rc < 0)
+		goto cxl_aer_ue_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl-aer-uncorrectable-error");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_aer_ue_fail;
+
+	sprintf(buf, "REASON=%s", "CXL AER uncorrectable error");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_aer_ue_fail;
+
+	done = 1;
+
+cxl_aer_ue_fail:
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
index d1591ce..dfe89d1 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -40,6 +40,7 @@ int ras_report_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
 int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
+int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 
 #else
 
@@ -52,6 +53,7 @@ static inline int ras_report_devlink_event(struct ras_events *ras, struct devlin
 static inline int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
 static inline int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 static inline int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
+static inline int ras_report_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


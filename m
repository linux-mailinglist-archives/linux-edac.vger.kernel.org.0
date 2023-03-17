Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB026BEB13
	for <lists+linux-edac@lfdr.de>; Fri, 17 Mar 2023 15:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCQOYU (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 17 Mar 2023 10:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjCQOYT (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 17 Mar 2023 10:24:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBD413DF9;
        Fri, 17 Mar 2023 07:24:16 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PdRDy2prdz6J6bl;
        Fri, 17 Mar 2023 22:23:14 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.168.91) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 17 Mar 2023 14:24:13 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V5 3/4] rasdaemon: Add support for the CXL AER uncorrectable errors
Date:   Fri, 17 Mar 2023 14:23:50 +0000
Message-ID: <20230317142351.1234-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20230317142351.1234-1-shiju.jose@huawei.com>
References: <20230317142351.1234-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.168.91]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

Add support to log and record the CXL AER uncorrectable errors.

The corresponding Kernel patches are here:
https://lore.kernel.org/linux-cxl/166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com/T/#t
https://lore.kernel.org/lkml/63eeb2a8c9e3f_32d612941f@dwillia2-xfh.jf.intel.com.notmuch/T/

It was found that the header log data to be converted to the
big-endian format to correctly store in the SQLite DB likely
because the SQLite database seems uses the big-endian storage.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 ras-cxl-handler.c | 151 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |   4 ++
 ras-events.c      |   9 +++
 ras-events.h      |   1 +
 ras-record.c      |  67 ++++++++++++++++++++
 ras-record.h      |  18 ++++++
 ras-report.c      |  73 ++++++++++++++++++++++
 ras-report.h      |   2 +
 8 files changed, 325 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index b6175bf..06f8d91 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -21,6 +21,7 @@
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-report.h"
+#include <endian.h>
 
 /* Poison List: Payload out flags */
 #define CXL_POISON_FLAG_MORE            BIT(0)
@@ -176,3 +177,153 @@ int ras_cxl_poison_event_handler(struct trace_seq *s,
 
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
+static int decode_cxl_error_status(struct trace_seq *s, uint32_t status,
+				   const struct cxl_error_list *cxl_error_list,
+				   uint8_t num_elems)
+{
+	int i;
+
+	for (i = 0; i < num_elems; i++) {
+		if (status & cxl_error_list[i].bit)
+			if (trace_seq_printf(s, "\'%s\' ", cxl_error_list[i].error) <= 0)
+				return -1;
+	}
+	return 0;
+}
+
+int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
+				 struct tep_record *record,
+				 struct tep_event *event, void *context)
+{
+	int len, i;
+	unsigned long long val;
+	time_t now;
+	struct tm *tm;
+	struct ras_events *ras = context;
+	struct ras_cxl_aer_ue_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	now = record->ts / user_hz + ras->uptime_diff;
+	tm = localtime(&now);
+	if (tm)
+		strftime(ev.timestamp, sizeof(ev.timestamp),
+			 "%Y-%m-%d %H:%M:%S %z", tm);
+	else
+		strncpy(ev.timestamp, "1970-01-01 00:00:00 +0000", sizeof(ev.timestamp));
+	if (trace_seq_printf(s, "%s ", ev.timestamp) <= 0)
+		return -1;
+
+	ev.memdev = tep_get_field_raw(s, event, "memdev",
+				      record, &len, 1);
+	if (!ev.memdev)
+		return -1;
+	if (trace_seq_printf(s, "memdev:%s ", ev.memdev) <= 0)
+		return -1;
+
+	ev.host = tep_get_field_raw(s, event, "host",
+				    record, &len, 1);
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
+	if (tep_get_field_val(s, event, "status", record, &val, 1) < 0)
+		return -1;
+	ev.error_status = val;
+
+	if (trace_seq_printf(s, "error status:") <= 0)
+		return -1;
+	if (decode_cxl_error_status(s, ev.error_status,
+				    cxl_aer_ue, ARRAY_SIZE(cxl_aer_ue)) < 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "first_error", record, &val, 1) < 0)
+		return -1;
+	ev.first_error = val;
+
+	if (trace_seq_printf(s, "first error:") <= 0)
+		return -1;
+	if (decode_cxl_error_status(s, ev.first_error,
+				    cxl_aer_ue, ARRAY_SIZE(cxl_aer_ue)) < 0)
+		return -1;
+
+	ev.header_log = tep_get_field_raw(s, event, "header_log",
+					  record, &len, 1);
+	if (!ev.header_log)
+		return -1;
+	if (trace_seq_printf(s, "header log:\n") <= 0)
+		return -1;
+	for (i = 0; i < CXL_HEADERLOG_SIZE_U32; i++) {
+		if (trace_seq_printf(s, "%08x ", ev.header_log[i]) <= 0)
+			break;
+		if ((i > 0) && ((i % 20) == 0))
+			if (trace_seq_printf(s, "\n") <= 0)
+				break;
+		/* Convert header log data to the big-endian format because
+		 * the SQLite database seems uses the big-endian storage.
+		 */
+		ev.header_log[i] = htobe32(ev.header_log[i]);
+	}
+	if (i < CXL_HEADERLOG_SIZE_U32)
+		return -1;
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
index 84d5cc6..35efadd 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -21,4 +21,8 @@
 int ras_cxl_poison_event_handler(struct trace_seq *s,
 				 struct tep_record *record,
 				 struct tep_event *event, void *context);
+
+int ras_cxl_aer_ue_event_handler(struct trace_seq *s,
+				 struct tep_record *record,
+				 struct tep_event *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index a981356..b3daf28 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -246,6 +246,7 @@ int toggle_ras_mc_event(int enable)
 
 #ifdef HAVE_CXL
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_aer_uncorrectable_error", enable);
 #endif
 
 free_ras:
@@ -986,6 +987,14 @@ int handle_ras_events(int record_events)
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
index fc51070..65f9d9a 100644
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
index 9db5d93..cb6c2a3 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -620,6 +620,57 @@ int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_eve
 
 	return rc;
 }
+
+/*
+ * Table and functions to handle cxl:cxl_aer_uncorrectable_error
+ */
+static const struct db_fields cxl_aer_ue_event_fields[] = {
+	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",            .type = "TEXT" },
+	{ .name = "memdev",               .type = "TEXT" },
+	{ .name = "host",                 .type = "TEXT" },
+	{ .name = "serial",               .type = "INTEGER" },
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
+	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 2, ev->memdev, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_aer_ue_event, 3, ev->host, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_aer_ue_event, 4, ev->serial);
+	sqlite3_bind_int(priv->stmt_cxl_aer_ue_event, 5, ev->error_status);
+	sqlite3_bind_int(priv->stmt_cxl_aer_ue_event, 6, ev->first_error);
+	sqlite3_bind_blob(priv->stmt_cxl_aer_ue_event, 7, ev->header_log, CXL_HEADERLOG_SIZE, NULL);
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
 #endif
 
 /*
@@ -967,6 +1018,14 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
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
 #endif
 
 	ras->db_priv = priv;
@@ -1089,6 +1148,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
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
index 9ede444..7e8e060 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -129,6 +129,20 @@ struct ras_cxl_poison_event {
 	char overflow_ts[64];
 };
 
+#define SZ_512                          0x200
+#define CXL_HEADERLOG_SIZE              SZ_512
+#define CXL_HEADERLOG_SIZE_U32          (SZ_512 / sizeof(uint32_t))
+
+struct ras_cxl_aer_ue_event {
+	char timestamp[64];
+	const char *memdev;
+	const char *host;
+	uint64_t serial;
+	uint32_t error_status;
+	uint32_t first_error;
+	uint32_t *header_log;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -139,6 +153,7 @@ struct devlink_event;
 struct diskerror_event;
 struct ras_mf_event;
 struct ras_cxl_poison_event;
+struct ras_cxl_aer_ue_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -173,6 +188,7 @@ struct sqlite3_priv {
 #endif
 #ifdef HAVE_CXL
 	sqlite3_stmt	*stmt_cxl_poison_event;
+	sqlite3_stmt	*stmt_cxl_aer_ue_event;
 #endif
 };
 
@@ -202,6 +218,7 @@ int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
 int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
+int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -216,6 +233,7 @@ static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink
 static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
 static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
+static inline int ras_store_cxl_aer_ue_event(struct ras_events *ras, struct ras_cxl_aer_ue_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index b1b7614..6ca754a 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -369,6 +369,32 @@ static int set_cxl_poison_event_backtrace(char *buf, struct ras_cxl_poison_event
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
+						"memdev=%s\n"		\
+						"host=%s\n"		\
+						"serial=0x%lx\n"	\
+						"error_status=%u\n"	\
+						"first_error=%u\n"	\
+						ev->timestamp,		\
+						ev->memdev,		\
+						ev->host,		\
+						ev->serial,		\
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
@@ -409,6 +435,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_POISON_EVENT:
 		rc = set_cxl_poison_event_backtrace(buf, (struct ras_cxl_poison_event *)ev);
 		break;
+	case CXL_AER_UE_EVENT:
+		rc = set_cxl_aer_ue_event_backtrace(buf, (struct ras_cxl_aer_ue_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -861,3 +890,47 @@ cxl_poison_fail:
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


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73446DEFDB
	for <lists+linux-edac@lfdr.de>; Wed, 12 Apr 2023 10:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjDLIyh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Apr 2023 04:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjDLIyg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 12 Apr 2023 04:54:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3521AA265;
        Wed, 12 Apr 2023 01:54:15 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PxGBw57Zlz6J7Dy;
        Wed, 12 Apr 2023 16:31:20 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 09:33:42 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 7/7] rasdaemon: Add support for the CXL memory module events
Date:   Wed, 12 Apr 2023 16:33:11 +0800
Message-ID: <20230412083312.1384-8-shiju.jose@huawei.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support to log and record the CXL memory module events.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 ras-cxl-handler.c | 156 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |   3 +
 ras-events.c      |   9 +++
 ras-events.h      |   1 +
 ras-record.c      |  84 +++++++++++++++++++++++++
 ras-record.h      |  17 +++++
 ras-report.c      | 103 ++++++++++++++++++++++++++++++
 ras-report.h      |   2 +
 8 files changed, 375 insertions(+)

diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
index fadf5db..ca23b97 100644
--- a/ras-cxl-handler.c
+++ b/ras-cxl-handler.c
@@ -1008,3 +1008,159 @@ int ras_cxl_dram_event_handler(struct trace_seq *s,
 
 	return 0;
 }
+
+/*
+ * Memory Module Event Record - MMER
+ *
+ * CXL res 3.0 section 8.2.9.2.1.3; Table 8-45
+ */
+static const char* cxl_dev_evt_type[] = {
+	"Health Status Change",
+	"Media Status Change",
+	"Life Used Change",
+	"Temperature Change",
+	"Data Path Error",
+	"LSA Error",
+};
+
+/*
+ * Device Health Information - DHI
+ *
+ * CXL res 3.0 section 8.2.9.8.3.1; Table 8-100
+ */
+#define CXL_DHI_HS_MAINTENANCE_NEEDED				BIT(0)
+#define CXL_DHI_HS_PERFORMANCE_DEGRADED				BIT(1)
+#define CXL_DHI_HS_HW_REPLACEMENT_NEEDED			BIT(2)
+
+static const struct cxl_event_flags cxl_health_status[] = {
+	{ .bit = CXL_DHI_HS_MAINTENANCE_NEEDED, .flag = "MAINTENANCE_NEEDED" },
+	{ .bit = CXL_DHI_HS_PERFORMANCE_DEGRADED, .flag = "PERFORMANCE_DEGRADED" },
+	{ .bit = CXL_DHI_HS_HW_REPLACEMENT_NEEDED, .flag = "REPLACEMENT_NEEDED" },
+};
+
+static const char* cxl_media_status[] = {
+	"Normal",
+	"Not Ready",
+	"Write Persistency Lost",
+	"All Data Lost",
+	"Write Persistency Loss in the Event of Power Loss",
+	"Write Persistency Loss in Event of Shutdown",
+	"Write Persistency Loss Imminent",
+	"All Data Loss in Event of Power Loss",
+	"All Data loss in the Event of Shutdown",
+	"All Data Loss Imminent",
+};
+
+static const char* cxl_two_bit_status[] = {
+	"Normal",
+	"Warning",
+	"Critical",
+};
+
+static const char* cxl_one_bit_status[] = {
+	"Normal",
+	"Warning",
+};
+
+#define CXL_DHI_AS_LIFE_USED(as)	(as & 0x3)
+#define CXL_DHI_AS_DEV_TEMP(as)		((as & 0xC) >> 2)
+#define CXL_DHI_AS_COR_VOL_ERR_CNT(as)	((as & 0x10) >> 4)
+#define CXL_DHI_AS_COR_PER_ERR_CNT(as)	((as & 0x20) >> 5)
+
+int ras_cxl_memory_module_event_handler(struct trace_seq *s,
+					struct tep_record *record,
+					struct tep_event *event, void *context)
+{
+	unsigned long long val;
+	struct ras_events *ras = context;
+	struct ras_cxl_memory_module_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	if (handle_ras_cxl_common_hdr(s, record, event, context, &ev.hdr) < 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "event_type", record, &val, 1) < 0)
+		return -1;
+	ev.event_type = val;
+	if (trace_seq_printf(s, "event_type:%s ", get_cxl_type_str(cxl_dev_evt_type,
+			     ARRAY_SIZE(cxl_dev_evt_type), ev.event_type)) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "health_status", record, &val, 1) < 0)
+		return -1;
+	ev.health_status = val;
+	if (trace_seq_printf(s, "health_status:") <= 0)
+		return -1;
+	if (decode_cxl_event_flags(s, ev.health_status, cxl_health_status,
+				   ARRAY_SIZE(cxl_health_status)) < 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "media_status", record, &val, 1) < 0)
+		return -1;
+	ev.media_status = val;
+	if (trace_seq_printf(s, "media_status:%s ", get_cxl_type_str(cxl_media_status,
+			     ARRAY_SIZE(cxl_media_status), ev.media_status)) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "add_status", record, &val, 1) < 0)
+		return -1;
+	ev.add_status = val;
+	if (trace_seq_printf(s, "as_life_used:%s ", get_cxl_type_str(cxl_two_bit_status,
+			     ARRAY_SIZE(cxl_two_bit_status),
+			     CXL_DHI_AS_LIFE_USED(ev.add_status))) <= 0)
+		return -1;
+	if (trace_seq_printf(s, "as_dev_temp:%s ", get_cxl_type_str(cxl_two_bit_status,
+			     ARRAY_SIZE(cxl_two_bit_status),
+			     CXL_DHI_AS_DEV_TEMP(ev.add_status))) <= 0)
+		return -1;
+	if (trace_seq_printf(s, "as_cor_vol_err_cnt:%s ", get_cxl_type_str(cxl_one_bit_status,
+			     ARRAY_SIZE(cxl_one_bit_status),
+			     CXL_DHI_AS_COR_VOL_ERR_CNT(ev.add_status))) <= 0)
+		return -1;
+	if (trace_seq_printf(s, "as_cor_per_err_cnt:%s ", get_cxl_type_str(cxl_one_bit_status,
+			     ARRAY_SIZE(cxl_one_bit_status),
+			     CXL_DHI_AS_COR_PER_ERR_CNT(ev.add_status))) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "life_used", record, &val, 1) < 0)
+		return -1;
+	ev.life_used = val;
+	if (trace_seq_printf(s, "life_used:%u ", ev.life_used) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "device_temp", record, &val, 1) < 0)
+		return -1;
+	ev.device_temp = val;
+	if (trace_seq_printf(s, "device_temp:%u ", ev.device_temp) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "dirty_shutdown_cnt", record, &val, 1) < 0)
+		return -1;
+	ev.dirty_shutdown_cnt = val;
+	if (trace_seq_printf(s, "dirty_shutdown_cnt:%u ", ev.dirty_shutdown_cnt) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "cor_vol_err_cnt", record, &val, 1) < 0)
+		return -1;
+	ev.cor_vol_err_cnt = val;
+	if (trace_seq_printf(s, "cor_vol_err_cnt:%u ", ev.cor_vol_err_cnt) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "cor_per_err_cnt", record, &val, 1) < 0)
+		return -1;
+	ev.cor_per_err_cnt = val;
+	if (trace_seq_printf(s, "cor_per_err_cnt:%u ", ev.cor_per_err_cnt) <= 0)
+		return -1;
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_memory_module_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_memory_module_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
index 35455af..1ea0f93 100644
--- a/ras-cxl-handler.h
+++ b/ras-cxl-handler.h
@@ -41,4 +41,7 @@ int ras_cxl_general_media_event_handler(struct trace_seq *s,
 int ras_cxl_dram_event_handler(struct trace_seq *s,
 			       struct tep_record *record,
 			       struct tep_event *event, void *context);
+int ras_cxl_memory_module_event_handler(struct trace_seq *s,
+					struct tep_record *record,
+					struct tep_event *event, void *context);
 #endif
diff --git a/ras-events.c b/ras-events.c
index 00159e6..182f28f 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -252,6 +252,7 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_generic_event", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_general_media", enable);
 	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_dram", enable);
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_memory_module", enable);
 #endif
 
 free_ras:
@@ -1040,6 +1041,14 @@ int handle_ras_events(int record_events)
 	else
 		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
 		    "cxl", "cxl_dram");
+
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_memory_module",
+			       ras_cxl_memory_module_event_handler, NULL, CXL_MEMORY_MODULE_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "memory_module");
 #endif
 
 	if (!num_events) {
diff --git a/ras-events.h b/ras-events.h
index 3fe28da..ccc1336 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -46,6 +46,7 @@ enum {
 	CXL_GENERIC_EVENT,
 	CXL_GENERAL_MEDIA_EVENT,
 	CXL_DRAM_EVENT,
+	CXL_MEMORY_MODULE_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index 36f43cf..89fca74 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -992,6 +992,74 @@ int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *
 
 	return rc;
 }
+
+/*
+ * Table and functions to handle cxl:cxl_memory_module_event
+ */
+static const struct db_fields cxl_memory_module_event_fields[] = {
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
+	{ .name = "event_type",		.type = "INTEGER" },
+	{ .name = "health_status",	.type = "INTEGER" },
+	{ .name = "media_status",	.type = "INTEGER" },
+	{ .name = "life_used",		.type = "INTEGER" },
+	{ .name = "dirty_shutdown_cnt",	.type = "INTEGER" },
+	{ .name = "cor_vol_err_cnt",	.type = "INTEGER" },
+	{ .name = "cor_per_err_cnt",	.type = "INTEGER" },
+	{ .name = "device_temp",	.type = "INTEGER" },
+	{ .name = "add_status",		.type = "INTEGER" },
+};
+
+static const struct db_table_descriptor cxl_memory_module_event_tab = {
+	.name = "cxl_memory_module_event",
+	.fields = cxl_memory_module_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_memory_module_event_fields),
+};
+
+int ras_store_cxl_memory_module_event(struct ras_events *ras, struct ras_cxl_memory_module_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_memory_module_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_memory_module_event store: %p\n",
+	    priv->stmt_cxl_memory_module_event);
+
+	ras_store_cxl_common_hdr(priv->stmt_cxl_memory_module_event, &ev->hdr);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 13, ev->event_type);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 14, ev->health_status);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 15, ev->media_status);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 16, ev->life_used);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 17, ev->dirty_shutdown_cnt);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 18, ev->cor_vol_err_cnt);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 19, ev->cor_per_err_cnt);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 20, ev->device_temp);
+	sqlite3_bind_int(priv->stmt_cxl_memory_module_event, 21, ev->add_status);
+
+	rc = sqlite3_step(priv->stmt_cxl_memory_module_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do stmt_cxl_memory_module_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_memory_module_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset stmt_cxl_memory_module_event on sqlite: error = %d\n", rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
 #endif
 
 /*
@@ -1387,6 +1455,14 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 		if (rc != SQLITE_OK)
 			goto error;
 	}
+
+	rc = ras_mc_create_table(priv, &cxl_memory_module_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_memory_module_event,
+					 &cxl_memory_module_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
 #endif
 
 	ras->db_priv = priv;
@@ -1557,6 +1633,14 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 			    "cpu %u: Failed to finalize cxl_dram_event sqlite: error = %d\n",
 			    cpu, rc);
 	}
+
+	if (priv->stmt_cxl_memory_module_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_memory_module_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize stmt_cxl_memory_module_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
 #endif
 
 	rc = sqlite3_close_v2(db);
diff --git a/ras-record.h b/ras-record.h
index 480ff92..a7b9ab9 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -218,6 +218,19 @@ struct ras_cxl_dram_event {
 	uint16_t validity_flags;
 };
 
+struct ras_cxl_memory_module_event {
+	struct ras_cxl_event_common_hdr hdr;
+	uint8_t event_type;
+	uint8_t health_status;
+	uint8_t media_status;
+	uint8_t life_used;
+	uint32_t dirty_shutdown_cnt;
+	uint32_t cor_vol_err_cnt;
+	uint32_t cor_per_err_cnt;
+	int16_t device_temp;
+	uint8_t add_status;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -234,6 +247,7 @@ struct ras_cxl_overflow_event;
 struct ras_cxl_generic_event;
 struct ras_cxl_general_media_event;
 struct ras_cxl_dram_event;
+struct ras_cxl_memory_module_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -274,6 +288,7 @@ struct sqlite3_priv {
 	sqlite3_stmt	*stmt_cxl_generic_event;
 	sqlite3_stmt	*stmt_cxl_general_media_event;
 	sqlite3_stmt	*stmt_cxl_dram_event;
+	sqlite3_stmt	*stmt_cxl_memory_module_event;
 #endif
 };
 
@@ -309,6 +324,7 @@ int ras_store_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflow
 int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
 int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev);
 int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev);
+int ras_store_cxl_memory_module_event(struct ras_events *ras, struct ras_cxl_memory_module_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -329,6 +345,7 @@ static inline int ras_store_cxl_overflow_event(struct ras_events *ras, struct ra
 static inline int ras_store_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
 static inline int ras_store_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev) { return 0; };
 static inline int ras_store_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev) { return 0; };
+static inline int ras_store_cxl_memory_module_event(struct ras_events *ras, struct ras_cxl_memory_module_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 21180b1..a30b66d 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -605,6 +605,62 @@ static int set_cxl_dram_event_backtrace(char *buf, struct ras_cxl_dram_event *ev
 	return 0;
 }
 
+static int set_cxl_memory_module_event_backtrace(char *buf, struct ras_cxl_memory_module_event *ev)
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
+						"event_type=%u\n"	\
+						"health_status=%u\n"	\
+						"media_status=%u\n"	\
+						"life_used=%u\n"	\
+						"dirty_shutdown_cnt=%u\n"	\
+						"cor_vol_err_cnt=%u\n"	\
+						"cor_per_err_cnt=%u\n"	\
+						"device_temp=%d\n"	\
+						"add_status=%u\n",	\
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
+						ev->event_type,		\
+						ev->health_status,	\
+						ev->media_status,	\
+						ev->life_used,		\
+						ev->dirty_shutdown_cnt,	\
+						ev->cor_vol_err_cnt,	\
+						ev->cor_per_err_cnt,	\
+						ev->device_temp,	\
+						ev->add_status);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -663,6 +719,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case CXL_DRAM_EVENT:
 		rc = set_cxl_dram_event_backtrace(buf, (struct ras_cxl_dram_event *)ev);
 		break;
+	case CXL_MEMORY_MODULE_EVENT:
+		rc = set_cxl_memory_module_event_backtrace(buf, (struct ras_cxl_memory_module_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -1380,3 +1439,47 @@ cxl_dram_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_memory_module_event(struct ras_events *ras, struct ras_cxl_memory_module_event *ev)
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
+		goto cxl_memory_module_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_MEMORY_MODULE_EVENT, ev);
+	if (rc < 0)
+		goto cxl_memory_module_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl_memory_module_event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_memory_module_fail;
+
+	sprintf(buf, "REASON=%s", "CXL Memory Module Event");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_memory_module_fail;
+
+	done = 1;
+
+cxl_memory_module_fail:
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
index 1ad00e0..e401850 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -46,6 +46,7 @@ int ras_report_cxl_overflow_event(struct ras_events *ras, struct ras_cxl_overflo
 int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev);
 int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev);
 int ras_report_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev);
+int ras_report_cxl_memory_module_event(struct ras_events *ras, struct ras_cxl_memory_module_event *ev);
 
 #else
 
@@ -64,6 +65,7 @@ static inline int ras_report_cxl_overflow_event(struct ras_events *ras, struct r
 static inline int ras_report_cxl_generic_event(struct ras_events *ras, struct ras_cxl_generic_event *ev) { return 0; };
 static inline int ras_report_cxl_general_media_event(struct ras_events *ras, struct ras_cxl_general_media_event *ev) { return 0; };
 static inline int ras_report_cxl_dram_event(struct ras_events *ras, struct ras_cxl_dram_event *ev) { return 0; };
+static inline int ras_report_cxl_memory_module_event(struct ras_events *ras, struct ras_cxl_memory_module_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


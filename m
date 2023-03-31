Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A5D6D219B
	for <lists+linux-edac@lfdr.de>; Fri, 31 Mar 2023 15:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjCaNom (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 31 Mar 2023 09:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbjCaNol (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 31 Mar 2023 09:44:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FC27690;
        Fri, 31 Mar 2023 06:44:37 -0700 (PDT)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pp1j71hjWz6J7fk;
        Fri, 31 Mar 2023 21:43:55 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 14:44:35 +0100
From:   <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-edac@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH V6 2/4] rasdaemon: Add support for the CXL poison events
Date:   Fri, 31 Mar 2023 21:44:02 +0800
Message-ID: <20230331134404.1315-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20230331134404.1315-1-shiju.jose@huawei.com>
References: <20230331134404.1315-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support to log and record the CXL poison events.

The corresponding Kernel patches here:
https://lore.kernel.org/linux-cxl/20230330184514.000011ac@Huawei.com/T/#t

Presently for logging only, could be extended for the policy
based recovery action for the frequent poison events depending on the above
kernel patches.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Makefile.am       |   7 +-
 configure.ac      |  11 +++
 ras-cxl-handler.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |  24 ++++++
 ras-events.c      |  15 ++++
 ras-events.h      |   1 +
 ras-record.c      |  85 ++++++++++++++++++++
 ras-record.h      |  22 ++++++
 ras-report.c      |  87 +++++++++++++++++++++
 ras-report.h      |   2 +
 10 files changed, 447 insertions(+), 1 deletion(-)
 create mode 100644 ras-cxl-handler.c
 create mode 100644 ras-cxl-handler.h

diff --git a/Makefile.am b/Makefile.am
index 56c144e..5bddeac 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -73,6 +73,11 @@ endif
 if WITH_CPU_FAULT_ISOLATION
    rasdaemon_SOURCES += ras-cpu-isolation.c queue.c
 endif
+
+if WITH_CXL
+   rasdaemon_SOURCES += ras-cxl-handler.c
+endif
+
 rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) $(LIBTRACEEVENT_LIBS)
 rasdaemon_CFLAGS = $(SQLITE3_CFLAGS) $(LIBTRACEEVENT_CFLAGS)
 
@@ -81,7 +86,7 @@ include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
 		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-page-isolation.h \
 		  non-standard-hisilicon.h non-standard-ampere.h ras-memory-failure-handler.h \
-		  ras-cpu-isolation.h queue.h
+		  ras-cxl-handler.h ras-cpu-isolation.h queue.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/configure.ac b/configure.ac
index 6a7c210..dacc1d1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -127,6 +127,16 @@ AS_IF([test "x$enable_memory_failure" = "xyes" || test "x$enable_all" = "xyes"],
 AM_CONDITIONAL([WITH_MEMORY_FAILURE], [test x$enable_memory_failure = xyes || test x$enable_all = xyes])
 AM_COND_IF([WITH_MEMORY_FAILURE], [USE_MEMORY_FAILURE="yes"], [USE_MEMORY_FAILURE="no"])
 
+AC_ARG_ENABLE([cxl],
+    AS_HELP_STRING([--enable-cxl], [enable CXL events (currently experimental)]))
+
+AS_IF([test "x$enable_cxl" = "xyes" || test "x$enable_all" == "xyes"], [
+  AC_DEFINE(HAVE_CXL,1,"have CXL events collect")
+  AC_SUBST([WITH_CXL])
+])
+AM_CONDITIONAL([WITH_CXL], [test x$enable_cxl = xyes || test x$enable_all == xyes])
+AM_COND_IF([WITH_CXL], [USE_CXL="yes"], [USE_CXL="no"])
+
 AC_ARG_ENABLE([abrt_report],
     AS_HELP_STRING([--enable-abrt-report], [enable report event to ABRT (currently experimental)]))
 
@@ -215,6 +225,7 @@ compile time options summary
     DEVLINK             : $USE_DEVLINK
     Disk I/O errors     : $USE_DISKERROR
     Memory Failure      : $USE_MEMORY_FAILURE
+    CXL events          : $USE_CXL
     Memory CE PFA       : $USE_MEMORY_CE_PFA
     AMP RAS errors      : $USE_AMP_NS_DECODE
     CPU fault isolation : $USE_CPU_FAULT_ISOLATION
diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
new file mode 100644
index 0000000..7d1deb9
--- /dev/null
+++ b/ras-cxl-handler.c
@@ -0,0 +1,194 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2023. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <traceevent/kbuffer.h>
+#include "ras-cxl-handler.h"
+#include "ras-record.h"
+#include "ras-logger.h"
+#include "ras-report.h"
+
+/* Poison List: Payload out flags */
+#define CXL_POISON_FLAG_MORE            BIT(0)
+#define CXL_POISON_FLAG_OVERFLOW        BIT(1)
+#define CXL_POISON_FLAG_SCANNING        BIT(2)
+
+/* CXL poison - source types */
+enum cxl_poison_source {
+	CXL_POISON_SOURCE_UNKNOWN = 0,
+	CXL_POISON_SOURCE_EXTERNAL = 1,
+	CXL_POISON_SOURCE_INTERNAL = 2,
+	CXL_POISON_SOURCE_INJECTED = 3,
+	CXL_POISON_SOURCE_VENDOR = 7,
+};
+
+/* CXL poison - trace types */
+enum cxl_poison_trace_type {
+	CXL_POISON_TRACE_LIST,
+};
+
+int ras_cxl_poison_event_handler(struct trace_seq *s,
+				 struct tep_record *record,
+				 struct tep_event *event, void *context)
+{
+	int len;
+	unsigned long long val;
+	struct ras_events *ras = context;
+	time_t now;
+	struct tm *tm;
+	struct ras_cxl_poison_event ev;
+
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
+	if (tep_get_field_val(s,  event, "trace_type", record, &val, 1) < 0)
+		return -1;
+	switch (val) {
+	case CXL_POISON_TRACE_LIST:
+		ev.trace_type = "List";
+		break;
+	default:
+		ev.trace_type = "Invalid";
+	}
+	if (trace_seq_printf(s, "trace_type:%s ", ev.trace_type) <= 0)
+		return -1;
+
+	ev.region = tep_get_field_raw(s, event, "region",
+				      record, &len, 1);
+	if (!ev.region)
+		return -1;
+	if (trace_seq_printf(s, "region:%s ", ev.region) <= 0)
+		return -1;
+
+	ev.uuid = tep_get_field_raw(s, event, "uuid",
+				    record, &len, 1);
+	if (!ev.uuid)
+		return -1;
+	if (trace_seq_printf(s, "region_uuid:%s ", ev.uuid) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "hpa", record, &val, 1) < 0)
+		return -1;
+	ev.hpa = val;
+	if (trace_seq_printf(s, "poison list: hpa:0x%llx ", (unsigned long long)ev.hpa) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "dpa", record, &val, 1) < 0)
+		return -1;
+	ev.dpa = val;
+	if (trace_seq_printf(s, "dpa:0x%llx ", (unsigned long long)ev.dpa) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s, event, "dpa_length", record, &val, 1) < 0)
+		return -1;
+	ev.dpa_length = val;
+	if (trace_seq_printf(s, "dpa_length:0x%x ", ev.dpa_length) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "source", record, &val, 1) < 0)
+		return -1;
+	switch (val) {
+	case CXL_POISON_SOURCE_UNKNOWN:
+		ev.source = "Unknown";
+		break;
+	case CXL_POISON_SOURCE_EXTERNAL:
+		ev.source = "External";
+		break;
+	case CXL_POISON_SOURCE_INTERNAL:
+		ev.source = "Internal";
+		break;
+	case CXL_POISON_SOURCE_INJECTED:
+		ev.source = "Injected";
+		break;
+	case CXL_POISON_SOURCE_VENDOR:
+		ev.source = "Vendor";
+		break;
+	default:
+		ev.source = "Invalid";
+	}
+	if (trace_seq_printf(s, "source:%s ", ev.source) <= 0)
+		return -1;
+
+	if (tep_get_field_val(s,  event, "flags", record, &val, 1) < 0)
+		return -1;
+	ev.flags = val;
+	if (trace_seq_printf(s, "flags:%d ", ev.flags) <= 0)
+		return -1;
+
+	if (ev.flags & CXL_POISON_FLAG_OVERFLOW) {
+		if (tep_get_field_val(s,  event, "overflow_t", record, &val, 1) < 0)
+			return -1;
+		if (val) {
+			/* CXL Specification 3.0
+			 * Overflow timestamp - The number of unsigned nanoseconds
+			 * that have elapsed since midnight, 01-Jan-1970 UTC
+			 */
+			time_t ovf_ts_secs = val / 1000000000ULL;
+
+			tm = localtime(&ovf_ts_secs);
+			if (tm) {
+				strftime(ev.overflow_ts, sizeof(ev.overflow_ts),
+					 "%Y-%m-%d %H:%M:%S %z", tm);
+			}
+		}
+		if (!val || !tm)
+			strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000",
+				sizeof(ev.overflow_ts));
+	} else
+		strncpy(ev.overflow_ts, "1970-01-01 00:00:00 +0000", sizeof(ev.overflow_ts));
+	if (trace_seq_printf(s, "overflow timestamp:%s\n", ev.overflow_ts) <= 0)
+		return -1;
+
+	/* Insert data into the SGBD */
+#ifdef HAVE_SQLITE3
+	ras_store_cxl_poison_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_cxl_poison_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-cxl-handler.h b/ras-cxl-handler.h
new file mode 100644
index 0000000..84d5cc6
--- /dev/null
+++ b/ras-cxl-handler.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2023. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __RAS_CXL_HANDLER_H
+#define __RAS_CXL_HANDLER_H
+
+#include "ras-events.h"
+#include <traceevent/event-parse.h>
+
+int ras_cxl_poison_event_handler(struct trace_seq *s,
+				 struct tep_record *record,
+				 struct tep_event *event, void *context);
+#endif
diff --git a/ras-events.c b/ras-events.c
index 49e4f9a..a981356 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -40,6 +40,7 @@
 #include "ras-devlink-handler.h"
 #include "ras-diskerror-handler.h"
 #include "ras-memory-failure-handler.h"
+#include "ras-cxl-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-page-isolation.h"
@@ -243,6 +244,10 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "ras", "memory_failure_event", enable);
 #endif
 
+#ifdef HAVE_CXL
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison", enable);
+#endif
+
 free_ras:
 	free(ras);
 	return rc;
@@ -973,6 +978,16 @@ int handle_ras_events(int record_events)
 		    "ras", "memory_failure_event");
 #endif
 
+#ifdef HAVE_CXL
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_poison",
+			       ras_cxl_poison_event_handler, NULL, CXL_POISON_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "cxl", "cxl_poison");
+#endif
+
 	if (!num_events) {
 		log(ALL, LOG_INFO,
 		    "Failed to trace all supported RAS events. Aborting.\n");
diff --git a/ras-events.h b/ras-events.h
index 6c9f507..fc51070 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -39,6 +39,7 @@ enum {
 	DEVLINK_EVENT,
 	DISKERROR_EVENT,
 	MF_EVENT,
+	CXL_POISON_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-record.c b/ras-record.c
index a367939..eb904bf 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -559,6 +559,71 @@ int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev)
 }
 #endif
 
+#ifdef HAVE_CXL
+/*
+ * Table and functions to handle cxl:cxl_poison
+ */
+static const struct db_fields cxl_poison_event_fields[] = {
+	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",		.type = "TEXT" },
+	{ .name = "memdev",		.type = "TEXT" },
+	{ .name = "host",		.type = "TEXT" },
+	{ .name = "serial",		.type = "INTEGER" },
+	{ .name = "trace_type",		.type = "TEXT" },
+	{ .name = "region",		.type = "TEXT" },
+	{ .name = "region_uuid",	.type = "TEXT" },
+	{ .name = "hpa",		.type = "INTEGER" },
+	{ .name = "dpa",		.type = "INTEGER" },
+	{ .name = "dpa_length",		.type = "INTEGER" },
+	{ .name = "source",		.type = "TEXT" },
+	{ .name = "flags",		.type = "INTEGER" },
+	{ .name = "overflow_ts",	.type = "TEXT" },
+};
+
+static const struct db_table_descriptor cxl_poison_event_tab = {
+	.name = "cxl_poison_event",
+	.fields = cxl_poison_event_fields,
+	.num_fields = ARRAY_SIZE(cxl_poison_event_fields),
+};
+
+int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_cxl_poison_event)
+		return 0;
+	log(TERM, LOG_INFO, "cxl_poison_event store: %p\n", priv->stmt_cxl_poison_event);
+
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 1, ev->timestamp, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 2, ev->memdev, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 3, ev->host, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_poison_event, 4, ev->serial);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 5, ev->trace_type, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 6, ev->region, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 7, ev->uuid, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_poison_event, 8, ev->hpa);
+	sqlite3_bind_int64(priv->stmt_cxl_poison_event, 9, ev->dpa);
+	sqlite3_bind_int(priv->stmt_cxl_poison_event, 10, ev->dpa_length);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 11, ev->source, -1, NULL);
+	sqlite3_bind_int(priv->stmt_cxl_poison_event, 12, ev->flags);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event, 13, ev->overflow_ts, -1, NULL);
+
+	rc = sqlite3_step(priv->stmt_cxl_poison_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do cxl_poison_event step on sqlite: error = %d\n", rc);
+	rc = sqlite3_reset(priv->stmt_cxl_poison_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset cxl_poison_event on sqlite: error = %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
+#endif
+
 /*
  * Generic code
  */
@@ -896,6 +961,16 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 	}
 #endif
 
+#ifdef HAVE_CXL
+	rc = ras_mc_create_table(priv, &cxl_poison_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_cxl_poison_event,
+					 &cxl_poison_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
+#endif
+
 	ras->db_priv = priv;
 	return 0;
 
@@ -1008,6 +1083,16 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 	}
 #endif
 
+#ifdef HAVE_CXL
+	if (priv->stmt_cxl_poison_event) {
+		rc = sqlite3_finalize(priv->stmt_cxl_poison_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize cxl_poison_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
 	rc = sqlite3_close_v2(db);
 	if (rc != SQLITE_OK)
 		log(TERM, LOG_ERR,
diff --git a/ras-record.h b/ras-record.h
index 219f10b..fd15215 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -114,6 +114,22 @@ struct ras_mf_event {
 	const char *action_result;
 };
 
+struct ras_cxl_poison_event {
+	char timestamp[64];
+	const char *memdev;
+	const char *host;
+	uint64_t serial;
+	const char *trace_type;
+	const char *region;
+	const char *uuid;
+	uint64_t hpa;
+	uint64_t dpa;
+	uint32_t dpa_length;
+	const char *source;
+	uint8_t flags;
+	char overflow_ts[64];
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -123,6 +139,7 @@ struct mce_event;
 struct devlink_event;
 struct diskerror_event;
 struct ras_mf_event;
+struct ras_cxl_poison_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -155,6 +172,9 @@ struct sqlite3_priv {
 #ifdef HAVE_MEMORY_FAILURE
 	sqlite3_stmt	*stmt_mf_event;
 #endif
+#ifdef HAVE_CXL
+	sqlite3_stmt	*stmt_cxl_poison_event;
+#endif
 };
 
 struct db_fields {
@@ -182,6 +202,7 @@ int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
 int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
+int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -195,6 +216,7 @@ static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_ev
 static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
 static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
 static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
+static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 62d5eb7..3daecc0 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -331,6 +331,46 @@ static int set_mf_event_backtrace(char *buf, struct ras_mf_event *ev)
 	return 0;
 }
 
+static int set_cxl_poison_event_backtrace(char *buf, struct ras_cxl_poison_event *ev)
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
+						"trace_type=%s\n"	\
+						"region=%s\n"		\
+						"region_uuid=%s\n"	\
+						"hpa=0x%lx\n"		\
+						"dpa=0x%lx\n"		\
+						"dpa_length=0x%x\n"	\
+						"source=%s\n"		\
+						"flags=%u\n"		\
+						"overflow_timestamp=%s\n", \
+						ev->timestamp,		\
+						ev->memdev,		\
+						ev->host,		\
+						ev->serial,		\
+						ev->trace_type,		\
+						ev->region,		\
+						ev->uuid,		\
+						ev->hpa,		\
+						ev->dpa,		\
+						ev->dpa_length,		\
+						ev->source,		\
+						ev->flags,		\
+						ev->overflow_ts);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -368,6 +408,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case MF_EVENT:
 		rc = set_mf_event_backtrace(buf, (struct ras_mf_event *)ev);
 		break;
+	case CXL_POISON_EVENT:
+		rc = set_cxl_poison_event_backtrace(buf, (struct ras_cxl_poison_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -776,3 +819,47 @@ mf_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev)
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
+		goto cxl_poison_fail;
+
+	rc = commit_report_backtrace(sockfd, CXL_POISON_EVENT, ev);
+	if (rc < 0)
+		goto cxl_poison_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-cxl-poison");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_poison_fail;
+
+	sprintf(buf, "REASON=%s", "CXL poison");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto cxl_poison_fail;
+
+	done = 1;
+
+cxl_poison_fail:
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
index e605eb1..d1591ce 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -39,6 +39,7 @@ int ras_report_arm_event(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_report_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
 int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
+int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 
 #else
 
@@ -50,6 +51,7 @@ static inline int ras_report_arm_event(struct ras_events *ras, struct ras_arm_ev
 static inline int ras_report_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
 static inline int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
 static inline int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
+static inline int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 
 #endif
 
-- 
2.25.1


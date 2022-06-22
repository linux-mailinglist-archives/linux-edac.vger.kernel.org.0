Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E2D5549E5
	for <lists+linux-edac@lfdr.de>; Wed, 22 Jun 2022 14:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiFVMUg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Jun 2022 08:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiFVMUf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 22 Jun 2022 08:20:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B1537007;
        Wed, 22 Jun 2022 05:20:28 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LSjBS51SNz6GDFj;
        Wed, 22 Jun 2022 20:20:00 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 14:20:26 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.126.173.29) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 22 Jun 2022 13:20:25 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <mchehab@kernel.org>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <ben.widawsky@intel.com>
CC:     <jonathan.cameron@huawei.com>, <linuxarm@huawei.com>,
        <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
        <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/1] rasdaemon: Add support for the CXL poison events
Date:   Wed, 22 Jun 2022 13:20:21 +0100
Message-ID: <20220622122021.1986-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.173.29]
X-ClientProxiedBy: lhreml726-chm.china.huawei.com (10.201.108.77) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Shiju Jose <shiju.jose@huawei.com>

Add support to handle the CXL poison kernel trace events.

The corresponding Kernel patches here:
https://lore.kernel.org/linux-cxl/cover.1655250669.git.alison.schofield@intel.com

Presently RFC draft version for logging, could be possible
to extend for the DPA address translation and for the
policy based recovery action for the frequently occurring
poison events depending on the above kernel patches.

Suggested-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Makefile.am       |   8 +++-
 configure.ac      |  11 +++++
 ras-cxl-handler.c | 118 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-cxl-handler.h |  25 ++++++++++
 ras-events.c      |  15 ++++++
 ras-events.h      |   1 +
 ras-record.c      |  69 +++++++++++++++++++++++++++
 ras-record.h      |  14 ++++++
 ras-report.c      |  70 +++++++++++++++++++++++++++
 ras-report.h      |   2 +
 10 files changed, 332 insertions(+), 1 deletion(-)
 create mode 100644 ras-cxl-handler.c
 create mode 100644 ras-cxl-handler.h

diff --git a/Makefile.am b/Makefile.am
index a322b9a..4216370 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -69,13 +69,19 @@ endif
 if WITH_AMP_NS_DECODE
    rasdaemon_SOURCES += non-standard-ampere.c
 endif
+
+if WITH_CXL
+   rasdaemon_SOURCES += ras-cxl-handler.c
+endif
+
 rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 
 include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
 		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
 		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-page-isolation.h \
-		  non-standard-hisilicon.h non-standard-ampere.h ras-memory-failure-handler.h
+		  non-standard-hisilicon.h non-standard-ampere.h ras-memory-failure-handler.h \
+		  ras-cxl-handler.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/configure.ac b/configure.ac
index a77991f..c18a67d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -161,6 +161,16 @@ AS_IF([test "x$enable_amp_ns_decode" = "xyes" || test "x$enable_all" == "xyes"],
 AM_CONDITIONAL([WITH_AMP_NS_DECODE], [test x$enable_amp_ns_decode = xyes || test x$enable_all == xyes])
 AM_COND_IF([WITH_AMP_NS_DECODE], [USE_AMP_NS_DECODE="yes"], [USE_AMP_NS_DECODE="no"])
 
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
 test "$sysconfdir" = '${prefix}/etc' && sysconfdir=/etc
 
 CFLAGS="$CFLAGS -Wall -Wmissing-prototypes -Wstrict-prototypes"
@@ -201,4 +211,5 @@ compile time options summary
     Memory Failure      : $USE_MEMORY_FAILURE
     Memory CE PFA       : $USE_MEMORY_CE_PFA
     AMP RAS errors      : $USE_AMP_NS_DECODE
+    CXL events          : $USE_CXL
 EOF
diff --git a/ras-cxl-handler.c b/ras-cxl-handler.c
new file mode 100644
index 0000000..7e6b06f
--- /dev/null
+++ b/ras-cxl-handler.c
@@ -0,0 +1,123 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
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
+#include "libtrace/kbuffer.h"
+#include "ras-cxl-handler.h"
+#include "ras-record.h"
+#include "ras-logger.h"
+#include "ras-report.h"
+
+#define BUF_LEN	1024
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
+int ras_cxl_poison_event_handler(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context)
+{
+	int len;
+	unsigned long long val;
+	struct ras_events *ras = context;
+	time_t now;
+	struct tm *tm;
+	struct ras_cxl_poison_event ev;
+
+	/*
+	 * Given old kernels do not support this event, do we still need
+	 * the following workaround for the timestamp?
+	 */
+
+	/*
+	 * Newer kernels (3.10-rc1 or upper) provide an uptime clock.
+	 * On previous kernels, the way to properly generate an event would
+	 * be to inject a fake one, measure its timestamp and diff it against
+	 * gettimeofday. We won't do it here. Instead, let's use uptime,
+	 * falling-back to the event report's time, if "uptime" clock is
+	 * not available (legacy kernels).
+	 */
+
+	if (ras->use_uptime)
+		now = record->ts/user_hz + ras->uptime_diff;
+	else
+		now = time(NULL);
+
+	tm = localtime(&now);
+	if (tm)
+		strftime(ev.timestamp, sizeof(ev.timestamp),
+			 "%Y-%m-%d %H:%M:%S %z", tm);
+	trace_seq_printf(s, "%s ", ev.timestamp);
+
+	ev.dev_name = pevent_get_field_raw(s, event, "name",
+					   record, &len, 1);
+	if (!ev.dev_name)
+		return -1;
+	trace_seq_printf(s, "%s ", ev.dev_name);
+
+	if (pevent_get_field_val(s,  event, "source", record, &val, 1) < 0)
+		return -1;
+
+	switch (val) {
+	case CXL_POISON_SOURCE_UNKNOWN:
+		ev.poison_source = "Unknown";
+		break;
+	case CXL_POISON_SOURCE_EXTERNAL:
+		ev.poison_source = "External";
+		break;
+	case CXL_POISON_SOURCE_INTERNAL:
+		ev.poison_source = "Internal";
+		break;
+	case CXL_POISON_SOURCE_INJECTED:
+		ev.poison_source = "Injected";
+		break;
+	case CXL_POISON_SOURCE_VENDOR:
+		ev.poison_source = "Vendor";
+		break;
+	default:
+		ev.poison_source = "Invalid";
+	}
+	trace_seq_printf(s, "poison source: %s ", ev.poison_source);
+
+	if (pevent_get_field_val(s, event, "start", record, &val, 1) < 0)
+		return -1;
+	ev.poison_dpa_start = val;
+	trace_seq_printf(s, "poison dpa start: 0x%llx ", (unsigned long long)ev.poison_dpa_start);
+
+	if (pevent_get_field_val(s, event, "length", record, &val, 1) < 0)
+		return -1;
+	ev.poison_length = val;
+	trace_seq_printf(s, "poison length: %d\n", ev.poison_length);
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
index 0000000..ef3b95f
--- /dev/null
+++ b/ras-cxl-handler.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2022. All rights reserved.
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
+#ifndef __RAS_CXL_POISON_HANDLER_H
+#define __RAS_CXL_POISON_HANDLER_H
+
+#include "ras-events.h"
+#include "libtrace/event-parse.h"
+
+int ras_cxl_poison_event_handler(struct trace_seq *s,
+			 struct pevent_record *record,
+			 struct event_format *event, void *context);
+
+#endif
diff --git a/ras-events.c b/ras-events.c
index 39cab20..730e2be 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -39,6 +39,7 @@
 #include "ras-devlink-handler.h"
 #include "ras-diskerror-handler.h"
 #include "ras-memory-failure-handler.h"
+#include "ras-cxl-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-page-isolation.h"
@@ -237,6 +238,10 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "ras", "memory_failure_event", enable);
 #endif
 
+#ifdef HAVE_CXL
+	rc |= __toggle_ras_mc_event(ras, "cxl", "cxl_poison_list", enable);
+#endif
+
 free_ras:
 	free(ras);
 	return rc;
@@ -925,6 +930,16 @@ int handle_ras_events(int record_events)
 		    "ras", "memory_failure_event");
 #endif
 
+#ifdef HAVE_CXL
+	rc = add_event_handler(ras, pevent, page_size, "cxl", "cxl_poison_list",
+			       ras_cxl_poison_event_handler, NULL, CXL_POISON_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "cxl_poison_list");
+#endif
+
 	if (!num_events) {
 		log(ALL, LOG_INFO,
 		    "Failed to trace all supported RAS events. Aborting.\n");
diff --git a/ras-events.h b/ras-events.h
index dfd690c..24f7ccc 100644
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
index d845f81..ce27963 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -559,6 +559,55 @@ int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev)
 }
 #endif
 
+#ifdef HAVE_CXL
+/*
+ * Table and functions to handle cxl:cxl_poison
+ */
+static const struct db_fields cxl_poison_event_fields[] = {
+	{ .name = "id",                   .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",            .type = "TEXT" },
+	{ .name = "dev_name",             .type = "TEXT" },
+	{ .name = "poison_source",        .type = "TEXT" },
+	{ .name = "poison_dpa_start",     .type = "INTEGER" },
+	{ .name = "poison_length",        .type = "INTEGER" },
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
+	sqlite3_bind_text(priv->stmt_cxl_poison_event,  1, ev->timestamp, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event,  2, ev->dev_name, -1, NULL);
+	sqlite3_bind_text(priv->stmt_cxl_poison_event,  3, ev->poison_source, -1, NULL);
+	sqlite3_bind_int64(priv->stmt_cxl_poison_event, 4,  ev->poison_dpa_start);
+	sqlite3_bind_int(priv->stmt_cxl_poison_event, 5,  ev->poison_length);
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
@@ -896,6 +945,16 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
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
 
@@ -1008,6 +1067,16 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
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
index d9f7733..3d229df 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -111,6 +111,14 @@ struct ras_mf_event {
 	const char *action_result;
 };
 
+struct ras_cxl_poison_event {
+	char timestamp[64];
+	const char *dev_name;
+	const char *poison_source;
+	uint64_t poison_dpa_start;
+	uint32_t poison_length;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -120,6 +128,7 @@ struct mce_event;
 struct devlink_event;
 struct diskerror_event;
 struct ras_mf_event;
+struct ras_cxl_poison_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -152,6 +161,9 @@ struct sqlite3_priv {
 #ifdef HAVE_MEMORY_FAILURE
 	sqlite3_stmt	*stmt_mf_event;
 #endif
+#ifdef HAVE_CXL
+	sqlite3_stmt	*stmt_cxl_poison_event;
+#endif
 };
 
 struct db_fields {
@@ -179,6 +191,7 @@ int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
 int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
+int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -192,6 +205,7 @@ static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_ev
 static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
 static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
 static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
+static inline int ras_store_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index ea3a9b6..e60ffc5 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -331,6 +331,30 @@ static int set_mf_event_backtrace(char *buf, struct ras_mf_event *ev)
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
+						"timestamp=%s\n"		\
+						"dev_name=%s\n"			\
+						"poison_source=%s\n"		\
+						"poison_dpa_start=0x%lx\n"	\
+						"poison_length=%d\n",		\
+						ev->timestamp,			\
+						ev->dev_name,			\
+						ev->poison_source,		\
+						ev->poison_dpa_start,		\
+						ev->poison_length);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -368,6 +392,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case MF_EVENT:
 		rc = set_mf_event_backtrace(buf, (struct ras_mf_event *)ev);
 		break;
+	case CXL_POISON_EVENT:
+		rc = set_cxl_poison_event_backtrace(buf, (struct ras_cxl_poison_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -776,3 +803,46 @@ mf_fail:
 	else
 		return -1;
 }
+
+int ras_report_cxl_poison_event(struct ras_events *ras, struct ras_cxl_poison_event *ev){
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
+	if (sockfd > 0)
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


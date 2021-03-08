Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9823313FB
	for <lists+linux-edac@lfdr.de>; Mon,  8 Mar 2021 18:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhCHRBQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Mar 2021 12:01:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2658 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHRAq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 8 Mar 2021 12:00:46 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DvPZz0cSqz67wj5;
        Tue,  9 Mar 2021 00:54:51 +0800 (CST)
Received: from lhreml715-chm.china.huawei.com (10.201.108.66) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 18:00:45 +0100
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.25.24) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 8 Mar 2021 17:00:44 +0000
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab+huawei@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <shiju.jose@huawei.com>
Subject: [PATCH v3 1/7] rasdaemon: add support for memory_failure events
Date:   Mon, 8 Mar 2021 16:57:26 +0000
Message-ID: <20210308165732.273-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210308165732.273-1-shiju.jose@huawei.com>
References: <20210308165732.273-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.25.24]
X-ClientProxiedBy: lhreml747-chm.china.huawei.com (10.201.108.197) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add support to log the memory_failure kernel trace
events.

Example rasdaemon log and SQLite DB output for the
memory_failure event,
=================================================
rasdaemon: memory_failure_event store: 0x126ce8f8
rasdaemon: register inserted at db
<...>-785   [000]     0.000024: memory_failure_event: 2020-10-02 13:27:13 -0400 pfn=0x204000000 page_type=free buddy page action_result=Delayed

CREATE TABLE memory_failure_event (id INTEGER PRIMARY KEY, timestamp TEXT, pfn TEXT, page_type TEXT, action_result TEXT);
INSERT INTO memory_failure_event VALUES(1,'2020-10-02 13:27:13 -0400','0x204000000','free buddy page','Delayed');
==================================================

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 .travis.yml                  |   2 +-
 Makefile.am                  |   7 +-
 configure.ac                 |  11 +++
 ras-events.c                 |  15 +++
 ras-events.h                 |   1 +
 ras-memory-failure-handler.c | 179 +++++++++++++++++++++++++++++++++++
 ras-memory-failure-handler.h |  25 +++++
 ras-record.c                 |  70 ++++++++++++++
 ras-record.h                 |  13 +++
 ras-report.c                 |  68 +++++++++++++
 ras-report.h                 |   2 +
 11 files changed, 390 insertions(+), 3 deletions(-)
 create mode 100644 ras-memory-failure-handler.c
 create mode 100644 ras-memory-failure-handler.h

diff --git a/.travis.yml b/.travis.yml
index 41d716d..7855b8e 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -26,7 +26,7 @@ before_install:
 - sudo apt-get install -y sqlite3
 install:
 - autoreconf -vfi
-- ./configure --enable-sqlite3 --enable-aer --enable-non-standard --enable-arm --enable-mce --enable-extlog --enable-devlink --enable-diskerror --enable-abrt-report --enable-hisi-ns-decode --enable-memory-ce-pfa
+- ./configure --enable-sqlite3 --enable-aer --enable-non-standard --enable-arm --enable-mce --enable-extlog --enable-devlink --enable-diskerror --enable-memory-failure --enable-abrt-report --enable-hisi-ns-decode --enable-memory-ce-pfa
 
 script:
 - make && sudo make install
diff --git a/Makefile.am b/Makefile.am
index de01098..7c1c027 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -48,6 +48,9 @@ endif
 if WITH_DISKERROR
    rasdaemon_SOURCES += ras-diskerror-handler.c
 endif
+if WITH_MEMORY_FAILURE
+   rasdaemon_SOURCES += ras-memory-failure-handler.c
+endif
 if WITH_ABRT_REPORT
    rasdaemon_SOURCES += ras-report.c
 endif
@@ -62,8 +65,8 @@ rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
 		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
-		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-page-isolation.h \
-		  non-standard-hisilicon.h
+		  ras-devlink-handler.h ras-diskerror-handler.h ras-memory-failure-handler.h \
+		  rbtree.h ras-page-isolation.h non-standard-hisilicon.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/configure.ac b/configure.ac
index e276c84..a6251d4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -111,6 +111,16 @@ AS_IF([test "x$enable_diskerror" = "xyes" || test "x$enable_all" == "xyes"], [
 AM_CONDITIONAL([WITH_DISKERROR], [test x$enable_diskerror = xyes || test x$enable_all == xyes])
 AM_COND_IF([WITH_DISKERROR], [USE_DISKERROR="yes"], [USE_DISKERROR="no"])
 
+AC_ARG_ENABLE([memory_failure],
+    AS_HELP_STRING([--enable-memory-failure], [enable memory failure events (currently experimental)]))
+
+AS_IF([test "x$enable_memory_failure" = "xyes" || test "x$enable_all" == "xyes"], [
+  AC_DEFINE(HAVE_MEMORY_FAILURE,1,"have memory failure events collect")
+  AC_SUBST([WITH_MEMORY_FAILURE])
+])
+AM_CONDITIONAL([WITH_MEMORY_FAILURE], [test x$enable_memory_failure = xyes || test x$enable_all == xyes])
+AM_COND_IF([WITH_MEMORY_FAILURE], [USE_MEMORY_FAILURE="yes"], [USE_MEMORY_FAILURE="no"])
+
 AC_ARG_ENABLE([abrt_report],
     AS_HELP_STRING([--enable-abrt-report], [enable report event to ABRT (currently experimental)]))
 
@@ -178,5 +188,6 @@ compile time options summary
     ARM events          : $USE_ARM
     DEVLINK             : $USE_DEVLINK
     Disk I/O errors     : $USE_DISKERROR
+    Memory Failure      : $USE_MEMORY_FAILURE
     Memory CE PFA       : $USE_MEMORY_CE_PFA
 EOF
diff --git a/ras-events.c b/ras-events.c
index 4509f56..fe4bd26 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -37,6 +37,7 @@
 #include "ras-extlog-handler.h"
 #include "ras-devlink-handler.h"
 #include "ras-diskerror-handler.h"
+#include "ras-memory-failure-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-page-isolation.h"
@@ -231,6 +232,10 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "block", "block_rq_complete", enable);
 #endif
 
+#ifdef HAVE_MEMORY_FAILURE
+	rc |= __toggle_ras_mc_event(ras, "ras", "memory_failure_event", enable);
+#endif
+
 free_ras:
 	free(ras);
 	return rc;
@@ -909,6 +914,16 @@ int handle_ras_events(int record_events)
 	}
 #endif
 
+#ifdef HAVE_MEMORY_FAILURE
+	rc = add_event_handler(ras, pevent, page_size, "ras", "memory_failure_event",
+			       ras_memory_failure_event_handler, NULL, MF_EVENT);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "memory_failure_event");
+#endif
+
 	if (!num_events) {
 		log(ALL, LOG_INFO,
 		    "Failed to trace all supported RAS events. Aborting.\n");
diff --git a/ras-events.h b/ras-events.h
index f028741..dfd690c 100644
--- a/ras-events.h
+++ b/ras-events.h
@@ -38,6 +38,7 @@ enum {
 	EXTLOG_EVENT,
 	DEVLINK_EVENT,
 	DISKERROR_EVENT,
+	MF_EVENT,
 	NR_EVENTS
 };
 
diff --git a/ras-memory-failure-handler.c b/ras-memory-failure-handler.c
new file mode 100644
index 0000000..9941e68
--- /dev/null
+++ b/ras-memory-failure-handler.c
@@ -0,0 +1,179 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved.
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
+#include "libtrace/kbuffer.h"
+#include "ras-memory-failure-handler.h"
+#include "ras-record.h"
+#include "ras-logger.h"
+#include "ras-report.h"
+
+/* Memory failure - various types of pages */
+enum mf_action_page_type {
+	MF_MSG_KERNEL,
+	MF_MSG_KERNEL_HIGH_ORDER,
+	MF_MSG_SLAB,
+	MF_MSG_DIFFERENT_COMPOUND,
+	MF_MSG_POISONED_HUGE,
+	MF_MSG_HUGE,
+	MF_MSG_FREE_HUGE,
+	MF_MSG_NON_PMD_HUGE,
+	MF_MSG_UNMAP_FAILED,
+	MF_MSG_DIRTY_SWAPCACHE,
+	MF_MSG_CLEAN_SWAPCACHE,
+	MF_MSG_DIRTY_MLOCKED_LRU,
+	MF_MSG_CLEAN_MLOCKED_LRU,
+	MF_MSG_DIRTY_UNEVICTABLE_LRU,
+	MF_MSG_CLEAN_UNEVICTABLE_LRU,
+	MF_MSG_DIRTY_LRU,
+	MF_MSG_CLEAN_LRU,
+	MF_MSG_TRUNCATED_LRU,
+	MF_MSG_BUDDY,
+	MF_MSG_BUDDY_2ND,
+	MF_MSG_DAX,
+	MF_MSG_UNSPLIT_THP,
+	MF_MSG_UNKNOWN,
+};
+
+/* Action results for various types of pages */
+enum mf_action_result {
+	MF_IGNORED,     /* Error: cannot be handled */
+	MF_FAILED,      /* Error: handling failed */
+	MF_DELAYED,     /* Will be handled later */
+	MF_RECOVERED,   /* Successfully recovered */
+};
+
+/* memory failure page types */
+static const struct {
+	int	type;
+	const char	*page_type;
+} mf_page_type[] = {
+	{ MF_MSG_KERNEL, "reserved kernel page" },
+	{ MF_MSG_KERNEL_HIGH_ORDER, "high-order kernel page"},
+	{ MF_MSG_SLAB, "kernel slab page"},
+	{ MF_MSG_DIFFERENT_COMPOUND, "different compound page after locking"},
+	{ MF_MSG_POISONED_HUGE, "huge page already hardware poisoned"},
+	{ MF_MSG_HUGE, "huge page"},
+	{ MF_MSG_FREE_HUGE, "free huge page"},
+	{ MF_MSG_NON_PMD_HUGE, "non-pmd-sized huge page"},
+	{ MF_MSG_UNMAP_FAILED, "unmapping failed page"},
+	{ MF_MSG_DIRTY_SWAPCACHE, "dirty swapcache page"},
+	{ MF_MSG_CLEAN_SWAPCACHE, "clean swapcache page"},
+	{ MF_MSG_DIRTY_MLOCKED_LRU, "dirty mlocked LRU page"},
+	{ MF_MSG_CLEAN_MLOCKED_LRU, "clean mlocked LRU page"},
+	{ MF_MSG_DIRTY_UNEVICTABLE_LRU, "dirty unevictable LRU page"},
+	{ MF_MSG_CLEAN_UNEVICTABLE_LRU, "clean unevictable LRU page"},
+	{ MF_MSG_DIRTY_LRU, "dirty LRU page"},
+	{ MF_MSG_CLEAN_LRU, "clean LRU page"},
+	{ MF_MSG_TRUNCATED_LRU, "already truncated LRU page"},
+	{ MF_MSG_BUDDY, "free buddy page"},
+	{ MF_MSG_BUDDY_2ND, "free buddy page (2nd try)"},
+	{ MF_MSG_DAX, "dax page"},
+	{ MF_MSG_UNSPLIT_THP, "unsplit thp"},
+	{ MF_MSG_UNKNOWN, "unknown page"},
+};
+
+/* memory failure action results */
+static const struct {
+	int result;
+	const char *action_result;
+} mf_action_result[] = {
+	{ MF_IGNORED, "Ignored" },
+	{ MF_FAILED, "Failed" },
+	{ MF_DELAYED, "Delayed" },
+	{ MF_RECOVERED, "Recovered" },
+};
+
+static const char *get_page_type(int page_type)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mf_page_type); i++)
+		if (mf_page_type[i].type == page_type)
+			return mf_page_type[i].page_type;
+
+	return "unknown page";
+}
+
+static const char *get_action_result(int result)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mf_action_result); i++)
+		if (mf_action_result[i].result == result)
+			return mf_action_result[i].action_result;
+
+	return "unknown";
+}
+
+
+int ras_memory_failure_event_handler(struct trace_seq *s,
+				     struct pevent_record *record,
+				     struct event_format *event, void *context)
+{
+	unsigned long long val;
+	struct ras_events *ras = context;
+	time_t now;
+	struct tm *tm;
+	struct ras_mf_event ev;
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
+	if (pevent_get_field_val(s,  event, "pfn", record, &val, 1) < 0)
+		return -1;
+	sprintf(ev.pfn, "0x%llx", val);
+	trace_seq_printf(s, "pfn=0x%llx ", val);
+
+	if (pevent_get_field_val(s, event, "type", record, &val, 1) < 0)
+		return -1;
+	ev.page_type = get_page_type(val);
+	trace_seq_printf(s, "page_type=%s ", ev.page_type);
+
+	if (pevent_get_field_val(s, event, "result", record, &val, 1) < 0)
+		return -1;
+	ev.action_result = get_action_result(val);
+	trace_seq_printf(s, "action_result=%s ", ev.action_result);
+
+	/* Store data into the SQLite DB */
+#ifdef HAVE_SQLITE3
+	ras_store_mf_event(ras, &ev);
+#endif
+
+#ifdef HAVE_ABRT_REPORT
+	/* Report event to ABRT */
+	ras_report_mf_event(ras, &ev);
+#endif
+
+	return 0;
+}
diff --git a/ras-memory-failure-handler.h b/ras-memory-failure-handler.h
new file mode 100644
index 0000000..b9e9971
--- /dev/null
+++ b/ras-memory-failure-handler.h
@@ -0,0 +1,25 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2020. All rights reserved.
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
+*/
+
+#ifndef __RAS_MEMORY_FAILURE_HANDLER_H
+#define __RAS_MEMORY_FAILURE_HANDLER_H
+
+#include "ras-events.h"
+#include "libtrace/event-parse.h"
+
+int ras_memory_failure_event_handler(struct trace_seq *s,
+				     struct pevent_record *record,
+				     struct event_format *event, void *context);
+
+#endif
diff --git a/ras-record.c b/ras-record.c
index 549c494..1a2ea06 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -498,6 +498,56 @@ int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev
 }
 #endif
 
+/*
+ * Table and functions to handle ras:memory_failure
+ */
+
+#ifdef HAVE_MEMORY_FAILURE
+static const struct db_fields mf_event_fields[] = {
+	{ .name="id",			.type="INTEGER PRIMARY KEY" },
+	{ .name="timestamp",		.type="TEXT" },
+	{ .name="pfn",			.type="TEXT" },
+	{ .name="page_type",		.type="TEXT" },
+	{ .name="action_result",	.type="TEXT" },
+};
+
+static const struct db_table_descriptor mf_event_tab = {
+	.name = "memory_failure_event",
+	.fields = mf_event_fields,
+	.num_fields = ARRAY_SIZE(mf_event_fields),
+};
+
+int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv || !priv->stmt_mf_event)
+		return 0;
+	log(TERM, LOG_INFO, "memory_failure_event store: %p\n", priv->stmt_mf_event);
+
+	sqlite3_bind_text(priv->stmt_mf_event,  1, ev->timestamp, -1, NULL);
+	sqlite3_bind_text(priv->stmt_mf_event,  2, ev->pfn, -1, NULL);
+	sqlite3_bind_text(priv->stmt_mf_event,  3, ev->page_type, -1, NULL);
+	sqlite3_bind_text(priv->stmt_mf_event,  4, ev->action_result, -1, NULL);
+
+	rc = sqlite3_step(priv->stmt_mf_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do memory_failure_event step on sqlite: error = %d\n", rc);
+
+	rc = sqlite3_reset(priv->stmt_mf_event);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset memory_failure_event on sqlite: error = %d\n",
+		    rc);
+
+	log(TERM, LOG_INFO, "register inserted at db\n");
+
+	return rc;
+}
+#endif
+
 /*
  * Generic code
  */
@@ -810,6 +860,16 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 	}
 #endif
 
+#ifdef HAVE_MEMORY_FAILURE
+	rc = ras_mc_create_table(priv, &mf_event_tab);
+	if (rc == SQLITE_OK) {
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_mf_event,
+					 &mf_event_tab);
+		if (rc != SQLITE_OK)
+			goto error;
+	}
+#endif
+
 	ras->db_priv = priv;
 	return 0;
 
@@ -912,6 +972,16 @@ int ras_mc_event_closedb(unsigned int cpu, struct ras_events *ras)
 	}
 #endif
 
+#ifdef HAVE_MEMORY_FAILURE
+	if (priv->stmt_mf_event) {
+		rc = sqlite3_finalize(priv->stmt_mf_event);
+		if (rc != SQLITE_OK)
+			log(TERM, LOG_ERR,
+			    "cpu %u: Failed to finalize mf_event sqlite: error = %d\n",
+			    cpu, rc);
+	}
+#endif
+
 	rc = sqlite3_close_v2(db);
 	if (rc != SQLITE_OK)
 		log(TERM, LOG_ERR,
diff --git a/ras-record.h b/ras-record.h
index cc217a9..4bbeb0c 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -98,6 +98,13 @@ struct diskerror_event {
 	const char *cmd;
 };
 
+struct ras_mf_event {
+	char timestamp[64];
+	char pfn[30];
+	const char *page_type;
+	const char *action_result;
+};
+
 struct ras_mc_event;
 struct ras_aer_event;
 struct ras_extlog_event;
@@ -106,6 +113,7 @@ struct ras_arm_event;
 struct mce_event;
 struct devlink_event;
 struct diskerror_event;
+struct ras_mf_event;
 
 #ifdef HAVE_SQLITE3
 
@@ -135,6 +143,9 @@ struct sqlite3_priv {
 #ifdef HAVE_DISKERROR
 	sqlite3_stmt	*stmt_diskerror_event;
 #endif
+#ifdef HAVE_MEMORY_FAILURE
+	sqlite3_stmt	*stmt_mf_event;
+#endif
 };
 
 struct db_fields {
@@ -161,6 +172,7 @@ int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standar
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
+int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 
 #else
 static inline int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras) { return 0; };
@@ -173,6 +185,7 @@ static inline int ras_store_non_standard_record(struct ras_events *ras, struct r
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 static inline int ras_store_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
 static inline int ras_store_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
+static inline int ras_store_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 
 #endif
 
diff --git a/ras-report.c b/ras-report.c
index 2710eac..ea3a9b6 100644
--- a/ras-report.c
+++ b/ras-report.c
@@ -309,6 +309,28 @@ static int set_diskerror_event_backtrace(char *buf, struct diskerror_event *ev)
 	return 0;
 }
 
+static int set_mf_event_backtrace(char *buf, struct ras_mf_event *ev)
+{
+	char bt_buf[MAX_BACKTRACE_SIZE];
+
+	if (!buf || !ev)
+		return -1;
+
+	sprintf(bt_buf, "BACKTRACE="    \
+                                                "timestamp=%s\n"	\
+                                                "pfn=%s\n"		\
+                                                "page_type=%s\n"	\
+                                                "action_result=%s\n",	\
+                                                ev->timestamp,		\
+                                                ev->pfn,		\
+                                                ev->page_type,		\
+                                                ev->action_result);
+
+	strcat(buf, bt_buf);
+
+	return 0;
+}
+
 static int commit_report_backtrace(int sockfd, int type, void *ev){
 	char buf[MAX_BACKTRACE_SIZE];
 	char *pbuf = buf;
@@ -343,6 +365,9 @@ static int commit_report_backtrace(int sockfd, int type, void *ev){
 	case DISKERROR_EVENT:
 		rc = set_diskerror_event_backtrace(buf, (struct diskerror_event *)ev);
 		break;
+	case MF_EVENT:
+		rc = set_mf_event_backtrace(buf, (struct ras_mf_event *)ev);
+		break;
 	default:
 		return -1;
 	}
@@ -708,3 +733,46 @@ diskerror_fail:
 		return -1;
 	}
 }
+
+int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev)
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
+		goto mf_fail;
+
+	rc = commit_report_backtrace(sockfd, MF_EVENT, ev);
+	if (rc < 0)
+		goto mf_fail;
+
+	sprintf(buf, "ANALYZER=%s", "rasdaemon-memory_failure");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto mf_fail;
+
+	sprintf(buf, "REASON=%s", "memory failure problem");
+	rc = write(sockfd, buf, strlen(buf) + 1);
+	if (rc < strlen(buf) + 1)
+		goto mf_fail;
+
+	done = 1;
+
+mf_fail:
+	if (sockfd > 0)
+		close(sockfd);
+
+	if (done)
+		return 0;
+	else
+		return -1;
+}
diff --git a/ras-report.h b/ras-report.h
index 1d911de..e605eb1 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -38,6 +38,7 @@ int ras_report_non_standard_event(struct ras_events *ras, struct ras_non_standar
 int ras_report_arm_event(struct ras_events *ras, struct ras_arm_event *ev);
 int ras_report_devlink_event(struct ras_events *ras, struct devlink_event *ev);
 int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev);
+int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev);
 
 #else
 
@@ -48,6 +49,7 @@ static inline int ras_report_non_standard_event(struct ras_events *ras, struct r
 static inline int ras_report_arm_event(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 static inline int ras_report_devlink_event(struct ras_events *ras, struct devlink_event *ev) { return 0; };
 static inline int ras_report_diskerror_event(struct ras_events *ras, struct diskerror_event *ev) { return 0; };
+static inline int ras_report_mf_event(struct ras_events *ras, struct ras_mf_event *ev) { return 0; };
 
 #endif
 
-- 
2.17.1


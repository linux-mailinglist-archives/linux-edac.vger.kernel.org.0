Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CBA1E7845
	for <lists+linux-edac@lfdr.de>; Fri, 29 May 2020 10:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725355AbgE2I1H (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 29 May 2020 04:27:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5311 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726687AbgE2I1G (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 29 May 2020 04:27:06 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 08FC2BD030B16859BB85;
        Fri, 29 May 2020 16:27:03 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 16:26:55 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <guanyalong@huawei.com>, <wuyun.wu@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: [PATCH 2/2] rasdaemon: add support for memory Corrected Error predictive failure analysis
Date:   Fri, 29 May 2020 16:24:23 +0800
Message-ID: <1590740663-6664-3-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
References: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: wuyun <wuyun.wu@huawei.com>

Memory Corrected Error was corrected by hardware. These errors do not
require immediate software actions, but are still reported for
accounting and predictive failure analysis.

Based on statistical results, some actions can be taken to prevent
Corrected Error from evoluting to Uncorrected Error.

Signed-off-by: lvying <lvying6@huawei.com>
---
 Makefile.am               |   4 +-
 misc/rasdaemon.env        |  29 +++++
 misc/rasdaemon.service.in |   1 +
 ras-events.c              |   3 +
 ras-mc-handler.c          |   5 +
 ras-page-isolation.c      | 308 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-page-isolation.h      |  68 ++++++++++
 7 files changed, 416 insertions(+), 2 deletions(-)
 create mode 100644 misc/rasdaemon.env
 create mode 100644 ras-page-isolation.c
 create mode 100644 ras-page-isolation.h

diff --git a/Makefile.am b/Makefile.am
index 2ff742d..6fc39f2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -17,7 +17,7 @@ all-local: $(SYSTEMD_SERVICES)
 
 sbin_PROGRAMS = rasdaemon
 rasdaemon_SOURCES = rasdaemon.c ras-events.c ras-mc-handler.c \
-		    bitfield.c rbtree.c
+		    bitfield.c rbtree.c ras-page-isolation.c
 if WITH_SQLITE3
    rasdaemon_SOURCES += ras-record.c
 endif
@@ -59,7 +59,7 @@ rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
 		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
-		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h
+		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-page-isolation.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/misc/rasdaemon.env b/misc/rasdaemon.env
new file mode 100644
index 0000000..0c05af0
--- /dev/null
+++ b/misc/rasdaemon.env
@@ -0,0 +1,29 @@
+# Page Isolation
+# Note: Run-time configuration is unsupported, service restart needed.
+# Note: this file should be installed at /etc/sysconfig/rasdaemon
+
+# Specify the threshold of isolating buggy pages.
+#
+# Format:
+#   [0-9]+[unit]
+# WARNING: please make sure perfectly match this format.
+#
+# Supported units:
+# PAGE_CE_REFRESH_CYCLE: D|d (day), H|h (hour), M|m (min), default is in hour
+# PAGE_CE_THRESHOLD: K|k (x1000), M|m (x1000k), default is none
+#
+# The two configs will only take no effect when PAGE_CE_ACTION is "off".
+PAGE_CE_REFRESH_CYCLE="24h"
+PAGE_CE_THRESHOLD="50"
+
+# Specify the internal action in rasdaemon to exceeding a page error threshold.
+#
+# off      no action
+# account  only account errors
+# soft     try to soft-offline page without killing any processes
+#          This requires an uptodate kernel. Might not be successfull.
+# hard     try to hard-offline page by killing processes
+#          Requires an uptodate kernel. Might not be successfull.
+# soft-then-hard   First try to soft offline, then try hard offlining.
+# Note: default offline choice is "soft".
+PAGE_CE_ACTION="soft"
diff --git a/misc/rasdaemon.service.in b/misc/rasdaemon.service.in
index be9ad5a..e73a08a 100644
--- a/misc/rasdaemon.service.in
+++ b/misc/rasdaemon.service.in
@@ -3,6 +3,7 @@ Description=RAS daemon to log the RAS events
 After=syslog.target
 
 [Service]
+EnvironmentFile=/etc/sysconfig/rasdaemon
 ExecStart=@sbindir@/rasdaemon -f -r
 ExecStartPost=@sbindir@/rasdaemon --enable
 ExecStop=@sbindir@/rasdaemon --disable
diff --git a/ras-events.c b/ras-events.c
index 511c93d..c034f6c 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -798,6 +798,9 @@ int handle_ras_events(int record_events)
 	ras->page_size = page_size;
 	ras->record_events = record_events;
 
+	/* FIXME: enable memory isolation unconditionally */
+	ras_page_account_init();
+
 	rc = add_event_handler(ras, pevent, page_size, "ras", "mc_event",
 			       ras_mc_event_handler, NULL, MC_EVENT);
 	if (!rc)
diff --git a/ras-mc-handler.c b/ras-mc-handler.c
index deb7e05..bfbe1ef 100644
--- a/ras-mc-handler.c
+++ b/ras-mc-handler.c
@@ -23,6 +23,7 @@
 #include "ras-mc-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
+#include "ras-page-isolation.h"
 #include "ras-report.h"
 
 int ras_mc_event_handler(struct trace_seq *s,
@@ -183,6 +184,10 @@ int ras_mc_event_handler(struct trace_seq *s,
 
 	ras_store_mc_event(ras, &ev);
 
+	/* Account page corrected errors */
+	if (!strcmp(ev.error_type, "Corrected"))
+		ras_record_page_error(ev.address, ev.error_count, now);
+
 #ifdef HAVE_ABRT_REPORT
 	/* Report event to ABRT */
 	ras_report_mc_event(ras, &ev);
diff --git a/ras-page-isolation.c b/ras-page-isolation.c
new file mode 100644
index 0000000..1bd04e4
--- /dev/null
+++ b/ras-page-isolation.c
@@ -0,0 +1,308 @@
+/*
+ * Copyright (C) 2015 Yun Wu (Abel)  <wuyun.wu@huawei.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+*/
+
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "ras-logger.h"
+#include "ras-page-isolation.h"
+
+static const struct config threshold_units[] = {
+	{ "m",	1000 },
+	{ "k",	1000 },
+	{ "",	1    },
+	{}
+};
+
+static const struct config cycle_units[] = {
+	{ "d",	24 },
+	{ "h",	60 },
+	{ "m",	60 },
+	{}
+};
+
+static struct isolation threshold = {
+	.name = "PAGE_CE_THRESHOLD",
+	.units = threshold_units,
+	.env = "50",
+	.unit = "",
+};
+
+static struct isolation cycle = {
+	.name = "PAGE_CE_REFRESH_CYCLE",
+	.units = cycle_units,
+	.env = "24h",
+	.unit = "h",
+};
+
+static const char *kernel_offline[] = {
+	[OFFLINE_SOFT]		 = "/sys/devices/system/memory/soft_offline_page",
+	[OFFLINE_HARD]		 = "/sys/devices/system/memory/hard_offline_page",
+	[OFFLINE_SOFT_THEN_HARD] = "/sys/devices/system/memory/soft_offline_page",
+};
+
+static const struct config offline_choice[] = {
+	{ "off",		OFFLINE_OFF },
+	{ "account",		OFFLINE_ACCOUNT },
+	{ "soft",		OFFLINE_SOFT },
+	{ "hard",		OFFLINE_HARD },
+	{ "soft-then-hard",	OFFLINE_SOFT_THEN_HARD },
+	{}
+};
+
+static const char *page_state[] = {
+	[PAGE_ONLINE]		= "online",
+	[PAGE_OFFLINE]		= "offlined",
+	[PAGE_OFFLINE_FAILED]	= "offline-failed",
+};
+
+static enum otype offline = OFFLINE_SOFT;
+static struct rb_root page_records;
+
+static void page_offline_init(void)
+{
+	const char *env = "PAGE_CE_ACTION";
+	char *choice = getenv(env);
+	const struct config *c = NULL;
+	int matched = 0;
+
+	if (choice) {
+		for (c = offline_choice; c->name; c++) {
+			if (!strcasecmp(choice, c->name)) {
+				offline = c->val;
+				matched = 1;
+				break;
+			}
+		}
+	}
+
+	if (!matched)
+		log(TERM, LOG_INFO, "Improper %s, set to default soft\n", env);
+
+	if (offline > OFFLINE_ACCOUNT && access(kernel_offline[offline], W_OK)) {
+		log(TERM, LOG_INFO, "Kernel does not support page offline interface\n");
+		offline = OFFLINE_ACCOUNT;
+	}
+
+	log(TERM, LOG_INFO, "Page offline choice on Corrected Errors is %s\n",
+	    offline_choice[offline].name);
+}
+
+static void parse_isolation_env(struct isolation *config)
+{
+	char *env = getenv(config->name), *unit = NULL;
+	const struct config *units = NULL;
+	unsigned long value;
+	int no_unit, unit_matched;
+	int last, i;
+
+reparse:
+	/* Start a new round */
+	no_unit = unit_matched = 0;
+
+	/* Environments could be un-configured */
+	if (!env || !strlen(env))
+		goto use_default;
+
+	/* Index of the last char of environment */
+	last = strlen(env) - 1;
+	unit = env + last;
+	if (isdigit(*unit)) {
+		unit = config->unit;
+		no_unit = 1;
+	}
+
+	/* Only decimal digit can be accepted */
+	for (i = 0; i < last; i++) {
+		if (!isdigit(env[i]))
+			goto use_default;
+	}
+
+	/* Check if value is valid or not */
+	if (sscanf(env, "%lu", &value) < 1 || !value)
+		goto use_default;
+
+	for (units = config->units; units->name; units++) {
+		if (!strcasecmp(unit, units->name))
+			unit_matched = 1;
+		if (unit_matched)
+			value *= units->val;
+	}
+
+	/* Improper unit */
+	if (!unit_matched)
+		goto use_default;
+
+	config->env = env;
+	config->val = value;
+	config->unit = no_unit ? unit : "";
+	return;
+
+use_default:
+	log(TERM, LOG_INFO, "Improper %s, set to default %s.\n",
+	    config->name, config->env);
+
+	env = config->env;
+	goto reparse;
+}
+
+static void page_isolation_init(void)
+{
+	/**
+	 * It's unnecessary to parse threshold configuration when offline
+	 * choice is off.
+	 */
+	if (offline == OFFLINE_OFF)
+		return;
+
+	parse_isolation_env(&threshold);
+	parse_isolation_env(&cycle);
+	log(TERM, LOG_INFO, "Threshold of memory Corrected Errors is %s%s / %s%s\n",
+	    threshold.env, threshold.unit, cycle.env, cycle.unit);
+}
+
+void ras_page_account_init(void)
+{
+	page_offline_init();
+	page_isolation_init();
+}
+
+static int do_page_offline(unsigned long long addr, enum otype type)
+{
+	FILE *offline_file;
+	int err;
+
+	offline_file = fopen(kernel_offline[type], "w");
+	if (!offline_file)
+		return -1;
+
+	fprintf(offline_file, "%#llx", addr);
+	err = ferror(offline_file) ? -1 : 0;
+	fclose(offline_file);
+
+	return err;
+}
+
+static void page_offline(struct page_record *pr)
+{
+	unsigned long long addr = pr->addr;
+	int ret;
+
+	/* Offlining page is not required */
+	if (offline <= OFFLINE_ACCOUNT)
+		return;
+
+	/* Ignore offlined pages */
+	if (pr->offlined != PAGE_ONLINE)
+		return;
+
+	/* Time to silence this noisy page */
+	if (offline == OFFLINE_SOFT_THEN_HARD) {
+		ret = do_page_offline(addr, OFFLINE_SOFT);
+		if (ret < 0)
+			ret = do_page_offline(addr, OFFLINE_HARD);
+	} else {
+		ret = do_page_offline(addr, offline);
+	}
+
+	pr->offlined = ret < 0 ? PAGE_OFFLINE_FAILED : PAGE_OFFLINE;
+
+	log(TERM, LOG_INFO, "Result of offlining page at %#llx: %s\n",
+	    addr, page_state[pr->offlined]);
+}
+
+static void page_record(struct page_record *pr, unsigned count, time_t time)
+{
+	unsigned long period = time - pr->start;
+	unsigned long tolerate;
+
+	if (period >= cycle.val) {
+		/**
+		 * Since we don't refresh automatically, it is possible that the period
+		 * between two occurences longer than the pre-configured refresh cycle.
+		 * In this case, we tolerate the frequency of the whole period up to
+		 * the pre-configured threshold.
+		 */
+		tolerate = (period / (double)cycle.val) * threshold.val;
+		pr->count -= (tolerate > pr->count) ? pr->count : tolerate;
+		pr->start = time;
+		pr->excess = 0;
+	}
+
+	pr->count += count;
+	if (pr->count >= threshold.val) {
+		log(TERM, LOG_INFO, "Corrected Errors at %#llx exceed threshold\n", pr->addr);
+
+		/**
+		 * Backup ce count of current cycle to enable next round, which actually
+		 * should never happen if we can disable overflow completely in the same
+		 * time unit (but sadly we can't).
+		 */
+		pr->excess += pr->count;
+		pr->count = 0;
+		page_offline(pr);
+	}
+}
+
+static struct page_record *page_lookup_insert(unsigned long long addr)
+{
+	struct rb_node **entry = &page_records.rb_node;
+	struct rb_node *parent = NULL;
+	struct page_record *pr = NULL, *find = NULL;
+
+	while (*entry) {
+		parent = *entry;
+		pr = rb_entry(parent, struct page_record, entry);
+		if (addr == pr->addr) {
+			return pr;
+		} else if (addr < pr->addr) {
+			entry = &(*entry)->rb_left;
+		} else {
+			entry = &(*entry)->rb_right;
+		}
+	}
+
+	find = calloc(1, sizeof(struct page_record));
+	if (!find) {
+		log(TERM, LOG_ERR, "No memory for page records\n");
+		return NULL;
+	}
+
+	find->addr = addr;
+	rb_link_node(&find->entry, parent, entry);
+	rb_insert_color(&find->entry, &page_records);
+
+	return find;
+}
+
+void ras_record_page_error(unsigned long long addr, unsigned count, time_t time)
+{
+	struct page_record *pr = NULL;
+
+	if (offline == OFFLINE_OFF)
+		return;
+
+	pr = page_lookup_insert(addr & PAGE_MASK);
+	if (pr) {
+		if (!pr->start)
+			pr->start = time;
+		page_record(pr, count, time);
+	}
+}
diff --git a/ras-page-isolation.h b/ras-page-isolation.h
new file mode 100644
index 0000000..6aefa1e
--- /dev/null
+++ b/ras-page-isolation.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright (C) 2015 Yun Wu (Abel)  <wuyun.wu@huawei.com>
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+*/
+
+#ifndef __RAS_PAGE_ISOLATION_H
+#define __RAS_PAGE_ISOLATION_H
+
+#include <time.h>
+#include "rbtree.h"
+
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		(1 << PAGE_SHIFT)
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
+struct config {
+	char			*name;
+	int			val;
+};
+
+enum otype {
+	OFFLINE_OFF,
+	OFFLINE_ACCOUNT,
+	OFFLINE_SOFT,
+	OFFLINE_HARD,
+	OFFLINE_SOFT_THEN_HARD,
+};
+
+enum pstate {
+	PAGE_ONLINE,
+	PAGE_OFFLINE,
+	PAGE_OFFLINE_FAILED,
+};
+
+struct page_record {
+	struct rb_node		entry;
+	unsigned long long	addr;
+	time_t			start;
+	enum pstate		offlined;
+	unsigned long		count;
+	unsigned long		excess;
+};
+
+struct isolation {
+	char			*name;
+	char			*env;
+	const struct config	*units;
+	unsigned long		val;
+	char			*unit;
+};
+
+void ras_page_account_init(void);
+void ras_record_page_error(unsigned long long addr, unsigned count, time_t time);
+
+#endif
-- 
1.8.3.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3068C2023C7
	for <lists+linux-edac@lfdr.de>; Sat, 20 Jun 2020 14:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgFTM0k (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 20 Jun 2020 08:26:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727964AbgFTM0j (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 20 Jun 2020 08:26:39 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0FFB9ADBF1D6A90753FA;
        Sat, 20 Jun 2020 20:26:35 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Sat, 20 Jun 2020
 20:26:28 +0800
From:   lvying6 <lvying6@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <guanyalong@huawei.com>, <wuyun.wu@huawei.com>,
        <tanxiaofei@huawei.com>
Subject: [PATCH v2 rasdaemon 2/2] rasdaemon: add support for memory Corrected Error predictive failure analysis
Date:   Sat, 20 Jun 2020 20:26:22 +0800
Message-ID: <1592655982-12725-3-git-send-email-lvying6@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1592655982-12725-1-git-send-email-lvying6@huawei.com>
References: <1590740663-6664-1-git-send-email-lvying6@huawei.com>
 <1592655982-12725-1-git-send-email-lvying6@huawei.com>
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

Signed-off-by: wuyun <wuyun.wu@huawei.com>
Signed-off-by: lvying6 <lvying6@huawei.com>
---
 .travis.yml               |   2 +-
 Makefile.am               |   5 +-
 configure.ac              |  11 ++
 man/rasdaemon.1.in        |   7 +
 misc/rasdaemon.env        |  29 ++++
 misc/rasdaemon.service.in |   1 +
 misc/rasdaemon.spec.in    |   2 +
 ras-events.c              |   6 +
 ras-mc-handler.c          |   7 +
 ras-page-isolation.c      | 332 ++++++++++++++++++++++++++++++++++++++++++++++
 ras-page-isolation.h      |  66 +++++++++
 11 files changed, 466 insertions(+), 2 deletions(-)
 create mode 100644 misc/rasdaemon.env
 create mode 100644 ras-page-isolation.c
 create mode 100644 ras-page-isolation.h

diff --git a/.travis.yml b/.travis.yml
index 846e8f6..79cf4ca 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -20,7 +20,7 @@ before_install:
 - sudo apt-get install -y sqlite3
 install:
 - autoreconf -vfi
-- ./configure --enable-sqlite3 --enable-aer --enable-non-standard --enable-arm --enable-mce --enable-extlog --enable-devlink --enable-diskerror --enable-abrt-report --enable-hisi-ns-decode
+- ./configure --enable-sqlite3 --enable-aer --enable-non-standard --enable-arm --enable-mce --enable-extlog --enable-devlink --enable-diskerror --enable-abrt-report --enable-hisi-ns-decode --enable-memory-ce-pfa
 
 script:
 - make && sudo make install
diff --git a/Makefile.am b/Makefile.am
index 843b538..51ef4de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -54,12 +54,15 @@ endif
 if WITH_HISI_NS_DECODE
    rasdaemon_SOURCES += non-standard-hisi_hip07.c non-standard-hisi_hip08.c
 endif
+if WITH_MEMORY_CE_PFA
+   rasdaemon_SOURCES += rbtree.c ras-page-isolation.c
+endif
 rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 
 include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
 		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
-		  ras-devlink-handler.h ras-diskerror-handler.h
+		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-page-isolation.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/configure.ac b/configure.ac
index a5a04dc..c50f818 100644
--- a/configure.ac
+++ b/configure.ac
@@ -131,6 +131,16 @@ AS_IF([test "x$enable_hisi_ns_decode" = "xyes" || test "x$enable_all" == "xyes"]
 AM_CONDITIONAL([WITH_HISI_NS_DECODE], [test x$enable_hisi_ns_decode = xyes || test x$enable_all == xyes])
 AM_COND_IF([WITH_HISI_NS_DECODE], [USE_HISI_NS_DECODE="yes"], [USE_HISI_NS_DECODE="no"])
 
+AC_ARG_ENABLE([memory_ce_pfa],
+    AS_HELP_STRING([--enable-memory-ce-pfa], [enable memory Corrected Error predictive failure analysis]))
+
+AS_IF([test "x$enable_memory_ce_pfa" = "xyes" || test "x$enable_all" == "xyes"], [
+  AC_DEFINE(HAVE_MEMORY_CE_PFA,1,"have memory corrected error predictive failure analysis")
+  AC_SUBST([WITH_MEMORY_CE_PFA])
+])
+AM_CONDITIONAL([WITH_MEMORY_CE_PFA], [test x$enable_memory_ce_pfa = xyes || test x$enable_all == xyes])
+AM_COND_IF([WITH_MEMORY_CE_PFA], [USE_MEMORY_CE_PFA="yes"], [USE_MEMORY_CE_PFA="no"])
+
 test "$sysconfdir" = '${prefix}/etc' && sysconfdir=/etc
 
 CFLAGS="$CFLAGS -Wall -Wmissing-prototypes -Wstrict-prototypes"
@@ -162,4 +172,5 @@ compile time options summary
     ARM events          : $USE_ARM
     DEVLINK             : $USE_DEVLINK
     Disk I/O errors     : $USE_DISKERROR
+    Memory CE PFA       : $USE_MEMORY_CE_PFA
 EOF
diff --git a/man/rasdaemon.1.in b/man/rasdaemon.1.in
index 834df16..833c8e1 100644
--- a/man/rasdaemon.1.in
+++ b/man/rasdaemon.1.in
@@ -62,6 +62,13 @@ feature.
 .BI "--version"
 Print the program version and exit.
 
+.SH CONFIG FILE
+
+The \fBrasdaemon\fR program supports a config file to set rasdaemon systemd service
+environment variables. By default the config file is read from /etc/sysconfig/rasdaemon.
+
+The general format is environmentname=value.
+
 .SH SEE ALSO
 \fBras-mc-ctl\fR(8)
 
diff --git a/misc/rasdaemon.env b/misc/rasdaemon.env
new file mode 100644
index 0000000..12fd766
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
+# Notice: please make sure match this format, rasdaemon will use default value for exception input cases.
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
diff --git a/misc/rasdaemon.spec.in b/misc/rasdaemon.spec.in
index 48dd311..378bbcd 100644
--- a/misc/rasdaemon.spec.in
+++ b/misc/rasdaemon.spec.in
@@ -44,6 +44,7 @@ make %{?_smp_mflags}
 
 %install
 make install DESTDIR=%{buildroot}
+install -D -p -m 0644 misc/rasdaemon.env %{buildroot}%{_sysconfdir}/sysconfig/%{name}
 install -D -p -m 0644 misc/rasdaemon.service %{buildroot}/%{_unitdir}/rasdaemon.service
 install -D -p -m 0644 misc/ras-mc-ctl.service %{buildroot}%{_unitdir}/ras-mc-ctl.service
 rm INSTALL %{buildroot}/usr/include/*.h
@@ -56,6 +57,7 @@ rm INSTALL %{buildroot}/usr/include/*.h
 %{_unitdir}/*.service
 %{_sharedstatedir}/rasdaemon
 %{_sysconfdir}/ras/dimm_labels.d
+%config(noreplace) %{_sysconfdir}/sysconfig/%{name}
 
 %changelog
 
diff --git a/ras-events.c b/ras-events.c
index 511c93d..8a56887 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -39,6 +39,7 @@
 #include "ras-diskerror-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
+#include "ras-page-isolation.h"
 
 /*
  * Polling time, if read() doesn't block. Currently, trace_pipe_raw never
@@ -798,6 +799,11 @@ int handle_ras_events(int record_events)
 	ras->page_size = page_size;
 	ras->record_events = record_events;
 
+#ifdef HAVE_MEMORY_CE_PFA
+	/* FIXME: enable memory isolation unconditionally */
+	ras_page_account_init();
+#endif
+
 	rc = add_event_handler(ras, pevent, page_size, "ras", "mc_event",
 			       ras_mc_event_handler, NULL, MC_EVENT);
 	if (!rc)
diff --git a/ras-mc-handler.c b/ras-mc-handler.c
index deb7e05..42b05cd 100644
--- a/ras-mc-handler.c
+++ b/ras-mc-handler.c
@@ -23,6 +23,7 @@
 #include "ras-mc-handler.h"
 #include "ras-record.h"
 #include "ras-logger.h"
+#include "ras-page-isolation.h"
 #include "ras-report.h"
 
 int ras_mc_event_handler(struct trace_seq *s,
@@ -183,6 +184,12 @@ int ras_mc_event_handler(struct trace_seq *s,
 
 	ras_store_mc_event(ras, &ev);
 
+#ifdef HAVE_MEMORY_CE_PFA
+	/* Account page corrected errors */
+	if (!strcmp(ev.error_type, "Corrected"))
+		ras_record_page_error(ev.address, ev.error_count, now);
+#endif
+
 #ifdef HAVE_ABRT_REPORT
 	/* Report event to ABRT */
 	ras_report_mc_event(ras, &ev);
diff --git a/ras-page-isolation.c b/ras-page-isolation.c
new file mode 100644
index 0000000..50e4406
--- /dev/null
+++ b/ras-page-isolation.c
@@ -0,0 +1,332 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2020-2020. All rights reserved.
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
+#include <ctype.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "ras-logger.h"
+#include "ras-page-isolation.h"
+
+#define PARSED_ENV_LEN 50
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
+	{ "s",  1  },
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
+	char *env = getenv(config->name);
+	char *unit = NULL;
+	const struct config *units = NULL;
+	int i, no_unit;
+	int valid = 0;
+	int unit_matched = 0;
+	unsigned long value, tmp;
+
+	/* check if env is vaild */
+	if (env && strlen(env)) {
+		/* All the character before unit must be digit */
+		for (i = 0; i < strlen(env) - 1; i++) {
+			if (!isdigit(env[i]))
+				goto parse;
+		}
+		if (sscanf(env, "%lu", &value) < 1 || !value)
+			goto parse;
+		/* check if the unit is vaild */
+		unit = env + strlen(env) - 1;
+		/* no unit, all the character are value character */
+		if (isdigit(*unit)) {
+			valid = 1;
+			no_unit = 1;
+			goto parse;
+		}
+		for (units = config->units; units->name; units++) {
+			/* value character and unit character are both valid */
+			if (!strcasecmp(unit, units->name)) {
+				valid = 1;
+				no_unit = 0;
+				break;
+			}
+		}
+	}
+
+parse:
+	/* if invalid, use default env */
+	if (valid) {
+		config->env = env;
+		if (!no_unit)
+			config->unit = unit;
+	} else {
+		 log(TERM, LOG_INFO, "Improper %s, set to default %s.\n",
+				 config->name, config->env);
+	}
+
+	/* if env value string is greater than ulong_max, truncate the last digit */
+	sscanf(config->env, "%lu", &value);
+	for (units = config->units; units->name; units++) {
+		if (!strcasecmp(config->unit, units->name))
+			unit_matched = 1;
+		if (unit_matched) {
+			tmp = value;
+			value *= units->val;
+			if (tmp != 0 && value / tmp != units->val)
+				config->overflow = true;
+		}
+	}
+	config->val = value;
+	/* In order to output value and unit perfectly */
+	config->unit = no_unit ? config->unit : "";
+}
+
+static void parse_env_string(struct isolation *config, char *str)
+{
+	int i;
+
+	if (config->overflow) {
+		/* when overflow, use basic unit */
+		for (i = 0; config->units[i].name; i++) ;
+		sprintf(str, "%lu%s", config->val, config->units[i-1].name);
+		log(TERM, LOG_INFO, "%s is set overflow(%s), truncate it\n",
+				config->name, config->env);
+	} else {
+		sprintf(str, "%s%s", config->env, config->unit);
+	}
+}
+
+static void page_isolation_init(void)
+{
+	char threshold_string[PARSED_ENV_LEN];
+	char cycle_string[PARSED_ENV_LEN];
+	/**
+	 * It's unnecessary to parse threshold configuration when offline
+	 * choice is off.
+	 */
+	if (offline == OFFLINE_OFF)
+		return;
+
+	parse_isolation_env(&threshold);
+	parse_isolation_env(&cycle);
+	parse_env_string(&threshold, threshold_string);
+	parse_env_string(&cycle, cycle_string);
+	log(TERM, LOG_INFO, "Threshold of memory Corrected Errors is %s / %s\n",
+			threshold_string, cycle_string);
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
+		 * between two occurences will be longer than the pre-configured refresh cycle.
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
+		log(TERM, LOG_INFO, "Corrected Errors at %#llx exceeded threshold\n", pr->addr);
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
index 0000000..3d03cef
--- /dev/null
+++ b/ras-page-isolation.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2020-2020. All rights reserved.
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
+#ifndef __RAS_PAGE_ISOLATION_H
+#define __RAS_PAGE_ISOLATION_H
+
+#include <time.h>
+#include <stdbool.h>
+#include "rbtree.h"
+
+#define PAGE_SHIFT		12
+#define PAGE_SIZE		(1 << PAGE_SHIFT)
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
+struct config {
+	char			*name;
+	unsigned long   val;
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
+	bool			overflow;
+	char			*unit;
+};
+
+void ras_page_account_init(void);
+void ras_record_page_error(unsigned long long addr, unsigned count, time_t time);
+
+#endif
-- 
1.8.3.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAF5F3344
	for <lists+linux-edac@lfdr.de>; Mon,  3 Oct 2022 18:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJCQSA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 3 Oct 2022 12:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJCQRu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 3 Oct 2022 12:17:50 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5950356CF
        for <linux-edac@vger.kernel.org>; Mon,  3 Oct 2022 09:17:41 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mh5XP1qllz67lg9;
        Tue,  4 Oct 2022 00:15:17 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 18:17:39 +0200
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.152.147) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 17:17:38 +0100
From:   <shiju.jose@huawei.com>
To:     <linux-edac@vger.kernel.org>, <mchehab@kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
        <luoshengwei@huawei.com>, <panjunchong@hisilicon.com>,
        <fenglei47@h-partners.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 01/10] rasdaemon: Support cpu fault isolation for corrected errors
Date:   Mon, 3 Oct 2022 17:17:33 +0100
Message-ID: <20221003161742.1697-2-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20221003161742.1697-1-shiju.jose@huawei.com>
References: <20221003161742.1697-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.48.152.147]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

From: Shengwei Luo <luoshengwei@huawei.com>

When the corrected errors exceed the set limit in cycle, try to
offline the related cpu core.

Signed-off-by: Shengwei Luo <luoshengwei@huawei.com>
Signed-off-by: Junchong Pan <panjunchong@hisilicon.com>
Signed-off-by: Lei Feng <fenglei47@h-partners.com>
Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Makefile.am         |   6 +-
 configure.ac        |  11 ++
 misc/rasdaemon.env  |  17 ++
 queue.c             | 119 ++++++++++++++
 queue.h             |  39 +++++
 ras-arm-handler.c   |  97 +++++++++++
 ras-arm-handler.h   |  18 ++
 ras-cpu-isolation.c | 388 ++++++++++++++++++++++++++++++++++++++++++++
 ras-cpu-isolation.h |  67 ++++++++
 ras-events.c        |   9 +-
 10 files changed, 769 insertions(+), 2 deletions(-)
 create mode 100644 queue.c
 create mode 100644 queue.h
 create mode 100644 ras-cpu-isolation.c
 create mode 100644 ras-cpu-isolation.h

diff --git a/Makefile.am b/Makefile.am
index a322b9a..36e7d4e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -69,13 +69,17 @@ endif
 if WITH_AMP_NS_DECODE
    rasdaemon_SOURCES += non-standard-ampere.c
 endif
+if WITH_CPU_FAULT_ISOLATION
+   rasdaemon_SOURCES += ras-cpu-isolation.c queue.c
+endif
 rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 
 include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
 		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
 		  ras-devlink-handler.h ras-diskerror-handler.h rbtree.h ras-page-isolation.h \
-		  non-standard-hisilicon.h non-standard-ampere.h ras-memory-failure-handler.h
+		  non-standard-hisilicon.h non-standard-ampere.h ras-memory-failure-handler.h \
+		  ras-cpu-isolation.h queue.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/configure.ac b/configure.ac
index a77991f..e0ed751 100644
--- a/configure.ac
+++ b/configure.ac
@@ -161,6 +161,16 @@ AS_IF([test "x$enable_amp_ns_decode" = "xyes" || test "x$enable_all" == "xyes"],
 AM_CONDITIONAL([WITH_AMP_NS_DECODE], [test x$enable_amp_ns_decode = xyes || test x$enable_all == xyes])
 AM_COND_IF([WITH_AMP_NS_DECODE], [USE_AMP_NS_DECODE="yes"], [USE_AMP_NS_DECODE="no"])
 
+AC_ARG_ENABLE([cpu_fault_isolation],
+    AS_HELP_STRING([--enable-cpu-fault-isolation], [enable cpu online fault isolation]))
+
+AS_IF([test "x$enable_cpu_fault_isolation" = "xyes" || test "x$enable_all" == "xyes"], [
+  AC_DEFINE(HAVE_CPU_FAULT_ISOLATION,1,"have cpu online fault isolation")
+  AC_SUBST([WITH_CPU_FAULT_ISOLATION])
+])
+AM_CONDITIONAL([WITH_CPU_FAULT_ISOLATION], [test x$enable_cpu_fault_isolation = xyes || test x$enable_all == xyes])
+AM_COND_IF([WITH_CPU_FAULT_ISOLATION], [USE_CPU_FAULT_ISOLATION="yes"], [USE_CPU_FAULT_ISOLATION="no"])
+
 test "$sysconfdir" = '${prefix}/etc' && sysconfdir=/etc
 
 CFLAGS="$CFLAGS -Wall -Wmissing-prototypes -Wstrict-prototypes"
@@ -201,4 +211,5 @@ compile time options summary
     Memory Failure      : $USE_MEMORY_FAILURE
     Memory CE PFA       : $USE_MEMORY_CE_PFA
     AMP RAS errors      : $USE_AMP_NS_DECODE
+    CPU fault isolation : $USE_CPU_FAULT_ISOLATION
 EOF
diff --git a/misc/rasdaemon.env b/misc/rasdaemon.env
index 12fd766..7cb18e8 100644
--- a/misc/rasdaemon.env
+++ b/misc/rasdaemon.env
@@ -27,3 +27,20 @@ PAGE_CE_THRESHOLD="50"
 # soft-then-hard   First try to soft offline, then try hard offlining.
 # Note: default offline choice is "soft".
 PAGE_CE_ACTION="soft"
+
+# CPU Online Fault Isolation
+# Whether to enable cpu online fault isolation (yes|no).
+CPU_ISOLATION_ENABLE="no"
+# Specify the threshold of CE numbers.
+#
+# Format:
+#   [0-9]+[unit]
+#
+# Supported units:
+# CPU_CE_THRESHOLD: no unit
+# CPU_ISOLATION_CYCLE: D|d (day), H|h (hour), M|m (minute), S|s (second), default is in second
+CPU_CE_THRESHOLD="18"
+CPU_ISOLATION_CYCLE="24h"
+
+# Prevent excessive isolation from causing an avalanche effect
+CPU_ISOLATION_LIMIT="10"
\ No newline at end of file
diff --git a/queue.c b/queue.c
new file mode 100644
index 0000000..65b6fb8
--- /dev/null
+++ b/queue.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
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
+#include <stdio.h>
+#include <stdlib.h>
+#include "queue.h"
+#include "ras-logger.h"
+
+int is_empty(struct link_queue *queue)
+{
+	if (queue)
+		return queue->size == 0;
+
+	return 1;
+}
+
+struct link_queue *init_queue(void)
+{
+	struct link_queue *queue = NULL;
+
+	queue = (struct link_queue *)malloc(sizeof(struct link_queue));
+	if (queue == NULL) {
+		log(TERM, LOG_ERR, "Failed to allocate memory for queue.\n");
+		return NULL;
+	}
+
+	queue->size = 0;
+	queue->head = NULL;
+	queue->tail = NULL;
+
+	return queue;
+}
+
+void clear_queue(struct link_queue *queue)
+{
+	if (queue == NULL)
+		return;
+
+	struct queue_node *node = queue->head;
+	struct queue_node *tmp = NULL;
+
+	while (node != NULL) {
+		tmp = node;
+		node = node->next;
+		free(tmp);
+	}
+
+	queue->head = NULL;
+	queue->tail = NULL;
+	queue->size = 0;
+}
+
+void free_queue(struct link_queue *queue)
+{
+	clear_queue(queue);
+
+	if (queue)
+		free(queue);
+}
+
+/* It should be guranteed that the param is not NULL */
+void push(struct link_queue *queue, struct queue_node *node)
+{
+	/* there is no element in the queue */
+	if (queue->head == NULL)
+		queue->head = node;
+	else
+		queue->tail->next = node;
+
+	queue->tail = node;
+	(queue->size)++;
+}
+
+int pop(struct link_queue *queue)
+{
+	struct queue_node *tmp = NULL;
+
+	if (queue == NULL || is_empty(queue))
+		return -1;
+
+	tmp = queue->head;
+	queue->head = queue->head->next;
+	free(tmp);
+	(queue->size)--;
+
+	return 0;
+}
+
+struct queue_node *front(struct link_queue *queue)
+{
+	if (queue == NULL)
+		return NULL;
+
+	return queue->head;
+}
+
+struct queue_node *node_create(time_t time, unsigned int value)
+{
+	struct queue_node *node = NULL;
+
+	node = (struct queue_node *)malloc(sizeof(struct queue_node));
+	if (node != NULL) {
+		node->time = time;
+		node->value = value;
+		node->next = NULL;
+	}
+
+	return node;
+}
diff --git a/queue.h b/queue.h
new file mode 100644
index 0000000..5459f40
--- /dev/null
+++ b/queue.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
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
+#ifndef __RAS_QUEUE_H
+#define __RAS_QUEUE_H
+
+struct queue_node {
+	time_t time;
+	unsigned int value;
+	struct queue_node *next;
+};
+
+struct link_queue {
+	struct queue_node *head;
+	struct queue_node *tail;
+	int size;
+};
+
+int is_empty(struct link_queue *queue);
+struct link_queue *init_queue(void);
+void clear_queue(struct link_queue *queue);
+void free_queue(struct link_queue *queue);
+void push(struct link_queue *queue, struct queue_node *node);
+int pop(struct link_queue *queue);
+struct queue_node *front(struct link_queue *queue);
+struct queue_node *node_create(time_t time, unsigned int value);
+
+#endif
diff --git a/ras-arm-handler.c b/ras-arm-handler.c
index 1149dc6..9c7a3c3 100644
--- a/ras-arm-handler.c
+++ b/ras-arm-handler.c
@@ -22,6 +22,10 @@
 #include "ras-report.h"
 #include "ras-non-standard-handler.h"
 #include "non-standard-ampere.h"
+#include "ras-cpu-isolation.h"
+
+#define ARM_ERR_VALID_ERROR_COUNT BIT(0)
+#define ARM_ERR_VALID_FLAGS BIT(1)
 
 void display_raw_data(struct trace_seq *s,
 		const uint8_t *buf,
@@ -42,6 +46,93 @@ void display_raw_data(struct trace_seq *s,
 	}
 }
 
+#ifdef HAVE_CPU_FAULT_ISOLATION
+static int count_errors(struct ras_arm_event *ev)
+{
+	struct ras_arm_err_info *err_info;
+	int num_pei;
+	int err_info_size = sizeof(struct ras_arm_err_info);
+	int num = 0;
+	int i;
+	int error_count;
+
+	if (ev->pei_len % err_info_size != 0) {
+		log(TERM, LOG_ERR,
+			"The event data does not match to the ARM Processor Error Information Structure\n");
+		return num;
+	}
+	num_pei = ev->pei_len / err_info_size;
+	err_info = (struct ras_arm_err_info *)(ev->pei_error);
+
+	for (i = 0; i < num_pei; ++i) {
+		error_count = 1;
+		if (err_info->validation_bits & ARM_ERR_VALID_ERROR_COUNT) {
+			/*
+			 * The value of this field is defined as follows:
+			 * 0: Single Error
+			 * 1: Multiple Errors
+			 * 2-65535: Error Count
+			 */
+			error_count = err_info->multiple_error + 1;
+		}
+
+		num += error_count;
+		err_info += 1;
+	}
+	log(TERM, LOG_INFO, "%d error in cpu core catched\n", num);
+	return num;
+}
+
+static int ras_handle_cpu_error(struct trace_seq *s,
+			 struct pevent_record *record,
+			 struct event_format *event,
+			 struct ras_arm_event *ev, time_t now)
+{
+	unsigned long long val;
+	int cpu;
+	char *severity;
+	struct error_info err_info;
+
+	if (pevent_get_field_val(s, event, "cpu", record, &val, 1) < 0)
+		return -1;
+	cpu = val;
+	trace_seq_printf(s, "\n cpu: %d", cpu);
+
+	/* record cpu error */
+	if (pevent_get_field_val(s, event, "sev", record, &val, 1) < 0)
+		return -1;
+	/* refer to UEFI_2_9 specification chapter N2.2 Table N-5 */
+	switch (val) {
+	case GHES_SEV_NO:
+		severity = "Informational";
+		break;
+	case GHES_SEV_CORRECTED:
+		severity = "Corrected";
+		break;
+	case GHES_SEV_RECOVERABLE:
+		severity = "Recoverable";
+		break;
+	default:
+	case GHES_SEV_PANIC:
+		severity = "Fatal";
+	}
+	trace_seq_printf(s, "\n severity: %s", severity);
+
+	if (val == GHES_SEV_CORRECTED) {
+		int nums = count_errors(ev);
+
+		if (nums > 0) {
+			err_info.nums = nums;
+			err_info.time = now;
+			err_info.err_type = val;
+			ras_record_cpu_error(&err_info, cpu);
+		}
+	}
+
+	return 0;
+}
+#endif
+
 int ras_arm_event_handler(struct trace_seq *s,
 			 struct pevent_record *record,
 			 struct event_format *event, void *context)
@@ -52,6 +143,7 @@ int ras_arm_event_handler(struct trace_seq *s,
 	struct tm *tm;
 	struct ras_arm_event ev;
 	int len = 0;
+
 	memset(&ev, 0, sizeof(ev));
 
 	/*
@@ -139,6 +231,11 @@ int ras_arm_event_handler(struct trace_seq *s,
 	display_raw_data(s, ev.vsei_error, ev.oem_len);
 #endif
 
+#ifdef HAVE_CPU_FAULT_ISOLATION
+	if (ras_handle_cpu_error(s, record, event, &ev, now) < 0)
+		return -1;
+#endif
+
 	/* Insert data into the SGBD */
 #ifdef HAVE_SQLITE3
 	ras_store_arm_record(ras, &ev);
diff --git a/ras-arm-handler.h b/ras-arm-handler.h
index 563a2d3..52813e7 100644
--- a/ras-arm-handler.h
+++ b/ras-arm-handler.h
@@ -17,6 +17,24 @@
 #include "ras-events.h"
 #include "libtrace/event-parse.h"
 
+/*
+ * ARM Processor Error Information Structure, According to
+ * UEFI_2_9 specification chapter N2.4.4.
+ */
+#pragma pack(1)
+struct ras_arm_err_info {
+	uint8_t version;
+	uint8_t length;
+	uint16_t validation_bits;
+	uint8_t type;
+	uint16_t multiple_error;
+	uint8_t flags;
+	uint64_t error_info;
+	uint64_t virt_fault_addr;
+	uint64_t physical_fault_addr;
+};
+#pragma pack()
+
 int ras_arm_event_handler(struct trace_seq *s,
 			 struct pevent_record *record,
 			 struct event_format *event, void *context);
diff --git a/ras-cpu-isolation.c b/ras-cpu-isolation.c
new file mode 100644
index 0000000..1694a08
--- /dev/null
+++ b/ras-cpu-isolation.c
@@ -0,0 +1,388 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
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
+#include <fcntl.h>
+#include <errno.h>
+#include <unistd.h>
+#include <limits.h>
+#include <ctype.h>
+#include "ras-logger.h"
+#include "ras-cpu-isolation.h"
+
+#define SECOND_OF_MON (30 * 24 * 60 * 60)
+#define SECOND_OF_DAY (24 * 60 * 60)
+#define SECOND_OF_HOU (60 * 60)
+#define SECOND_OF_MIN (60)
+
+#define LIMIT_OF_CPU_THRESHOLD 10000
+#define INIT_OF_CPU_THRESHOLD 18
+#define DEC_CHECK 10
+#define LAST_BIT_OF_UL 5
+
+static struct cpu_info *cpu_infos;
+static unsigned int ncores;
+static unsigned int enabled = 1;
+static const char *cpu_path_format = "/sys/devices/system/cpu/cpu%d/online";
+
+static const struct param normal_units[] = {
+	{"", 1},
+	{}
+};
+
+static const struct param cycle_units[] = {
+	{"d", SECOND_OF_DAY},
+	{"h", SECOND_OF_HOU},
+	{"m", SECOND_OF_MIN},
+	{"s", 1},
+	{}
+};
+
+static struct isolation_param threshold = {
+	.name = "CPU_CE_THRESHOLD",
+	.units = normal_units,
+	.value = INIT_OF_CPU_THRESHOLD,
+	.limit = LIMIT_OF_CPU_THRESHOLD
+};
+
+static struct isolation_param cpu_limit = {
+	.name = "CPU_ISOLATION_LIMIT",
+	.units = normal_units
+};
+
+static struct isolation_param cycle = {
+	.name = "CPU_ISOLATION_CYCLE",
+	.units = cycle_units,
+	.value = SECOND_OF_DAY,
+	.limit = SECOND_OF_MON
+};
+
+static const char * const cpu_state[] = {
+	[CPU_OFFLINE] = "offline",
+	[CPU_ONLINE] = "online",
+	[CPU_OFFLINE_FAILED] = "offline-failed",
+	[CPU_UNKNOWN] = "unknown"
+};
+
+static int open_sys_file(unsigned int cpu, int __oflag, const char *format)
+{
+	int fd;
+	char path[PATH_MAX] = "";
+	char real_path[PATH_MAX] = "";
+
+	snprintf(path, sizeof(path), format, cpu);
+	if (strlen(path) > PATH_MAX || realpath(path, real_path) == NULL) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, path);
+		return -1;
+	}
+	fd = open(real_path, __oflag);
+	if (fd == -1) {
+		log(TERM, LOG_ERR, "[%s]:open file: %s failed\n", __func__, real_path);
+		return -1;
+	}
+
+	return fd;
+}
+
+static int get_cpu_status(unsigned int cpu)
+{
+	int fd, num;
+	char buf[2] = "";
+
+	fd = open_sys_file(cpu, O_RDONLY, cpu_path_format);
+	if (fd == -1)
+		return CPU_UNKNOWN;
+
+	if (read(fd, buf, 1) <= 0 || sscanf(buf, "%d", &num) != 1)
+		num = CPU_UNKNOWN;
+
+	close(fd);
+
+	return (num < 0 || num > CPU_UNKNOWN) ? CPU_UNKNOWN : num;
+}
+
+static int init_cpu_info(unsigned int cpus)
+{
+	ncores = cpus;
+	cpu_infos = (struct cpu_info *)malloc(sizeof(*cpu_infos) * cpus);
+	if (!cpu_infos) {
+		log(TERM, LOG_ERR,
+			"Failed to allocate memory for cpu infos in %s.\n", __func__);
+		return -1;
+	}
+
+	for (unsigned int i = 0; i < cpus; ++i) {
+		cpu_infos[i].ce_nums = 0;
+		cpu_infos[i].state = get_cpu_status(i);
+		cpu_infos[i].ce_queue = init_queue();
+
+		if (cpu_infos[i].ce_queue == NULL) {
+			log(TERM, LOG_ERR,
+				"Failed to allocate memory for cpu ce queue in %s.\n", __func__);
+			return -1;
+		}
+	}
+	/* set limit of offlined cpu limit according to number of cpu */
+	cpu_limit.limit = cpus - 1;
+	cpu_limit.value = 0;
+
+	return 0;
+}
+
+static void check_config(struct isolation_param *config)
+{
+	if (config->value > config->limit) {
+		log(TERM, LOG_WARNING, "Value: %lu exceed limit: %lu, set to limit\n",
+			config->value, config->limit);
+		config->value = config->limit;
+	}
+}
+
+static int parse_ul_config(struct isolation_param *config, char *env, unsigned long *value)
+{
+	char *unit = NULL;
+	int env_size, has_unit = 0;
+
+	if (!env || strlen(env) == 0)
+		return -1;
+
+	env_size = strlen(env);
+	unit = env + env_size - 1;
+
+	if (isalpha(*unit)) {
+		has_unit = 1;
+		env_size--;
+		if (env_size <= 0)
+			return -1;
+	}
+
+	for (int i = 0; i < env_size; ++i) {
+		if (isdigit(env[i])) {
+			if (*value > ULONG_MAX / DEC_CHECK ||
+				(*value == ULONG_MAX / DEC_CHECK && env[i] - '0' > LAST_BIT_OF_UL)) {
+				log(TERM, LOG_ERR, "%s is out of range: %lu\n", env, ULONG_MAX);
+				return -1;
+			}
+			*value = DEC_CHECK * (*value) + (env[i] - '0');
+		} else
+			return -1;
+	}
+
+	if (!has_unit)
+		return 0;
+
+	for (const struct param *units = config->units; units->name; units++) {
+		/* value character and unit character are both valid */
+		if (!strcasecmp(unit, units->name)) {
+			if (*value > (ULONG_MAX / units->value)) {
+				log(TERM, LOG_ERR,
+				    "%s is out of range: %lu\n", env, ULONG_MAX);
+				return -1;
+			}
+			*value = (*value) * units->value;
+			return 0;
+		}
+	}
+	log(TERM, LOG_ERR, "Invalid unit %s\n", unit);
+	return -1;
+}
+
+static void init_config(struct isolation_param *config)
+{
+	char *env = getenv(config->name);
+	unsigned long value = 0;
+
+	if (parse_ul_config(config, env, &value) < 0) {
+		log(TERM, LOG_ERR, "Invalid %s: %s! Use default value %lu.\n",
+			config->name, env, config->value);
+		return;
+	}
+
+	config->value = value;
+	check_config(config);
+}
+
+static int check_config_status(void)
+{
+	char *env = getenv("CPU_ISOLATION_ENABLE");
+
+	if (env == NULL || strcasecmp(env, "yes"))
+		return -1;
+
+	return 0;
+}
+
+void ras_cpu_isolation_init(unsigned int cpus)
+{
+	if (init_cpu_info(cpus) < 0 || check_config_status() < 0) {
+		enabled = 0;
+		log(TERM, LOG_WARNING, "Cpu fault isolation is disabled\n");
+		return;
+	}
+
+	log(TERM, LOG_INFO, "Cpu fault isolation is enabled\n");
+	init_config(&threshold);
+	init_config(&cpu_limit);
+	init_config(&cycle);
+}
+
+void cpu_infos_free(void)
+{
+	if (cpu_infos) {
+		for (int i = 0; i < ncores; ++i)
+			free_queue(cpu_infos[i].ce_queue);
+
+		free(cpu_infos);
+	}
+}
+
+static int do_cpu_offline(unsigned int cpu)
+{
+	int fd, rc;
+	char buf[2] = "";
+
+	cpu_infos[cpu].state = CPU_OFFLINE_FAILED;
+	fd = open_sys_file(cpu, O_RDWR, cpu_path_format);
+	if (fd == -1)
+		return HANDLE_FAILED;
+
+	strcpy(buf, "0");
+	rc = write(fd, buf, strlen(buf));
+	if (rc < 0) {
+		log(TERM, LOG_ERR, "cpu%u offline failed, errno:%d\n", cpu, errno);
+		close(fd);
+		return HANDLE_FAILED;
+	}
+
+	close(fd);
+	/* check wthether the cpu is isolated successfully */
+	cpu_infos[cpu].state = get_cpu_status(cpu);
+
+	if (cpu_infos[cpu].state == CPU_OFFLINE)
+		return HANDLE_SUCCEED;
+
+	return HANDLE_FAILED;
+}
+
+static int do_ce_handler(unsigned int cpu)
+{
+	struct link_queue *queue = cpu_infos[cpu].ce_queue;
+	unsigned int tmp;
+	/*
+	 * Since we just count all error numbers in setted cycle, we store the time
+	 * and error numbers from current event to the queue, then everytime we
+	 * calculate the period from beginning time to ending time, if the period
+	 * exceeds setted cycle, we pop the beginning time and error until the period
+	 * from new beginning time to ending time is less than cycle.
+	 */
+	while (queue->head && queue->tail && queue->tail->time - queue->head->time > cycle.value) {
+		tmp = queue->head->value;
+		if (pop(queue) == 0)
+			cpu_infos[cpu].ce_nums -= tmp;
+	}
+	log(TERM, LOG_INFO,
+		"Current number of Corrected Errors in cpu%d in the cycle is %lu\n",
+		cpu, cpu_infos[cpu].ce_nums);
+
+	if (cpu_infos[cpu].ce_nums >= threshold.value) {
+		log(TERM, LOG_INFO,
+			"Corrected Errors exceeded threshold %lu, try to offline cpu%u\n",
+			threshold.value, cpu);
+		return do_cpu_offline(cpu);
+	}
+	return HANDLE_NOTHING;
+}
+
+static int error_handler(unsigned int cpu, struct error_info *err_info)
+{
+	int ret = HANDLE_NOTHING;
+
+	switch (err_info->err_type) {
+	case CE:
+		ret = do_ce_handler(cpu);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void record_error_info(unsigned int cpu, struct error_info *err_info)
+{
+	switch (err_info->err_type) {
+	case CE:
+	{
+		struct queue_node *node = node_create(err_info->time, err_info->nums);
+
+		if (node == NULL) {
+			log(TERM, LOG_ERR, "Fail to allocate memory for queue node\n");
+			return;
+		}
+		push(cpu_infos[cpu].ce_queue, node);
+		cpu_infos[cpu].ce_nums += err_info->nums;
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+void ras_record_cpu_error(struct error_info *err_info, int cpu)
+{
+	int ret;
+
+	if (enabled == 0)
+		return;
+
+	if (cpu >= ncores || cpu < 0) {
+		log(TERM, LOG_ERR,
+			"The current cpu %d has exceed the total number of cpu:%u\n", cpu, ncores);
+		return;
+	}
+
+	log(TERM, LOG_INFO, "Handling error on cpu%d\n", cpu);
+	cpu_infos[cpu].state = get_cpu_status(cpu);
+
+	if (cpu_infos[cpu].state != CPU_ONLINE) {
+		log(TERM, LOG_INFO, "Cpu%d is not online or unknown, ignore\n", cpu);
+		return;
+	}
+
+	record_error_info(cpu, err_info);
+	/*
+	 * Since user may change cpu state, we get current offlined
+	 * cpu numbers every recording time.
+	 */
+	if (ncores - sysconf(_SC_NPROCESSORS_ONLN) >= cpu_limit.value) {
+		log(TERM, LOG_WARNING,
+			"Offlined cpus have exceeded limit: %lu, choose to do nothing\n",
+			cpu_limit.value);
+		return;
+	}
+
+	ret = error_handler(cpu, err_info);
+	if (ret == HANDLE_NOTHING)
+		log(TERM, LOG_WARNING, "Doing nothing in the cpu%d\n", cpu);
+	else if (ret == HANDLE_SUCCEED) {
+		log(TERM, LOG_INFO, "Offline cpu%d succeed, the state is %s\n",
+			cpu, cpu_state[cpu_infos[cpu].state]);
+		clear_queue(cpu_infos[cpu].ce_queue);
+		cpu_infos[cpu].ce_nums = 0;
+	} else
+		log(TERM, LOG_WARNING, "Offline cpu%d fail, the state is %s\n",
+			cpu, cpu_state[cpu_infos[cpu].state]);
+}
diff --git a/ras-cpu-isolation.h b/ras-cpu-isolation.h
new file mode 100644
index 0000000..35b5225
--- /dev/null
+++ b/ras-cpu-isolation.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright (c) Huawei Technologies Co., Ltd. 2021-2021. All rights reserved.
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
+#ifndef __RAS_CPU_ISOLATION_H
+#define __RAS_CPU_ISOLATION_H
+
+#include "queue.h"
+
+#define MAX_BUF_LEN 1024
+
+struct param {
+	char *name;
+	unsigned long value;
+};
+
+struct isolation_param {
+	char *name;
+	const struct param *units;
+	unsigned long value;
+	unsigned long limit;
+};
+
+enum cpu_state {
+	CPU_OFFLINE,
+	CPU_ONLINE,
+	CPU_OFFLINE_FAILED,
+	CPU_UNKNOWN,
+};
+
+enum error_handle_result {
+	HANDLE_FAILED = -1,
+	HANDLE_SUCCEED,
+	HANDLE_NOTHING,
+};
+
+enum error_type {
+	CE = 1
+};
+
+struct cpu_info {
+	unsigned long ce_nums;
+	struct link_queue *ce_queue;
+	enum cpu_state state;
+};
+
+struct error_info {
+	unsigned long nums;
+	time_t time;
+	enum error_type err_type;
+};
+
+void ras_cpu_isolation_init(unsigned int cpus);
+void ras_record_cpu_error(struct error_info *err_info, int cpu);
+void cpu_infos_free(void);
+
+#endif
diff --git a/ras-events.c b/ras-events.c
index 39cab20..beda655 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -42,6 +42,7 @@
 #include "ras-record.h"
 #include "ras-logger.h"
 #include "ras-page-isolation.h"
+#include "ras-cpu-isolation.h"
 
 /*
  * Polling time, if read() doesn't block. Currently, trace_pipe_raw never
@@ -856,6 +857,10 @@ int handle_ras_events(int record_events)
 
 	cpus = get_num_cpus(ras);
 
+#ifdef HAVE_CPU_FAULT_ISOLATION
+	ras_cpu_isolation_init(cpus);
+#endif
+
 #ifdef HAVE_MCE
 	rc = register_mce_handler(ras, cpus);
 	if (rc)
@@ -982,6 +987,8 @@ err:
 		}
 		free(ras);
 	}
-
+#ifdef HAVE_CPU_FAULT_ISOLATION
+	cpu_infos_free();
+#endif
 	return rc;
 }
-- 
2.25.1


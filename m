Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00A01466A1
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfFNRzv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 13:55:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18613 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727793AbfFNRzv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 13:55:51 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B05746C90371480363B1;
        Sat, 15 Jun 2019 01:55:47 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 15 Jun 2019 01:55:36 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>
CC:     <mchehab@kernel.org>, <linuxarm@huawei.com>, <jcm@redhat.com>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: [RFC PATCH 1/6] rasdaemon: CCIX: CCIX memory error reporting.
Date:   Sat, 15 Jun 2019 01:55:12 +0800
Message-ID: <20190614175517.58442-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
References: <20190614175517.58442-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Adds support for basic decoding and logging of ccix memory errors
+ storing to sqlite3 DB.

Given that the CCIX memory record is very tightly defined by the
specification and that databases with large blobs in them
are not particularly useful, I have separately exposed all of the
standard fields.  Note that this means setting them NULL if the
validation bits indicate that the field is not valid.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 Makefile.am        |   6 +-
 configure.ac       |  10 ++
 ras-ccix-handler.c | 244 +++++++++++++++++++++++++++++++++++++++++++++
 ras-ccix-handler.h |  61 ++++++++++++
 ras-events.c       |  16 +++
 ras-record.c       | 176 ++++++++++++++++++++++++++++++++
 ras-record.h       |  20 ++++
 ras-report.h       |   6 +-
 8 files changed, 537 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 87b5a3a..0b4f1ac 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -24,6 +24,9 @@ endif
 if WITH_AER
    rasdaemon_SOURCES += ras-aer-handler.c
 endif
+if WITH_CCIX
+   rasdaemon_SOURCES += ras-ccix-handler.c
+endif
 if WITH_NON_STANDARD
    rasdaemon_SOURCES += ras-non-standard-handler.c
 endif
@@ -51,7 +54,8 @@ rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 
 include_HEADERS = config.h  ras-events.h  ras-logger.h  ras-mc-handler.h \
 		  ras-aer-handler.h ras-mce-handler.h ras-record.h bitfield.h ras-report.h \
-		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h
+		  ras-extlog-handler.h ras-arm-handler.h ras-non-standard-handler.h \
+		  ras-ccix-handler.h
 
 # This rule can't be called with more than one Makefile job (like make -j8)
 # I can't figure out a way to fix that
diff --git a/configure.ac b/configure.ac
index 6ad5421..75fea44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -44,6 +44,15 @@ AS_IF([test "x$enable_aer" = "xyes"], [
 ])
 AM_CONDITIONAL([WITH_AER], [test x$enable_aer = xyes])
 
+AC_ARG_ENABLE([ccix],
+    AS_HELP_STRING([--enable-ccix], [enable CCIX PER events (currently experimental)]))
+
+AS_IF([test "x$enable_ccix" = "xyes"], [
+  AC_DEFINE(HAVE_CCIX,1,"have CCIX PER events collect")
+  AC_SUBST([WITH_CCIX])
+])
+AM_CONDITIONAL([WITH_CCIX], [test x$enable_ccix = xyes])
+
 AC_ARG_ENABLE([non_standard],
     AS_HELP_STRING([--enable-non-standard], [enable NON_STANDARD events (currently experimental)]))
 
@@ -127,4 +136,5 @@ compile time options summary
     ABRT report         : $enable_abrt_report
     HIP07 SAS HW errors : $enable_hisi_ns_decode
     ARM events          : $enable_arm
+    CCIX                : $enable_ccix
 EOF
diff --git a/ras-ccix-handler.c b/ras-ccix-handler.c
new file mode 100644
index 0000000..2be413f
--- /dev/null
+++ b/ras-ccix-handler.c
@@ -0,0 +1,244 @@
+/*
+ * Copyright (c) 2019 Hisilicon Limited.
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
+#include <string.h>
+#include <unistd.h>
+#include "libtrace/kbuffer.h"
+#include "ras-record.h"
+#include "ras-logger.h"
+#include "bitfield.h"
+#include "ras-report.h"
+
+static char *ccix_mem_pool_type(uint8_t pt)
+{
+	switch (pt) {
+	case 0: return "other/not-specified";
+	case 1: return "ROM";
+	case 2: return "volatile";
+	case 3: return "non-volatile";
+	case 4: return "device/register";
+	}
+	if (pt >= 0x80)
+		return "vendor";
+	return "unknown";
+}
+
+static char *ccix_mem_spec_type(uint8_t st)
+{
+	switch (st) {
+	case 0: return "other/not-specified";
+	case 1: return "SRAM";
+	case 2: return "DDR";
+	case 3: return "NVDIMM-F";
+	case 4: return "NVDIMM-N";
+	case 5: return "HBM";
+	case 6: return "flash";
+	}
+	if (st >= 0x80)
+		return "vendor";
+	return "unknown";
+}
+
+static char *ccix_mem_op(uint8_t op)
+{
+	switch (op) {
+	case 0: return "generic";
+	case 1: return "read";
+	case 2: return "write";
+	case 4: return "scrub";
+	}
+	return "unknown";
+}
+
+static char *ccix_mem_err_type(int etype)
+{
+	switch (etype) {
+	case 0: return "unknown";
+	case 1: return "no error";
+	case 2: return "single-bit ECC";
+	case 3: return "multi-bit ECC";
+	case 4: return "single-symbol chipkill ECC";
+	case 5: return "multi-symbol chipkill ECC";
+	case 6: return "master abort";
+	case 7: return "target abort";
+	case 8: return "parity error";
+	case 9: return "watchdog timeout";
+	case 10: return "invalid address";
+	case 11: return "mirror Broken";
+	case 12: return "memory sparing";
+	case 13: return "scrub";
+	case 14: return "physical memory map-out event";
+	}
+	return "unknown-type";
+}
+
+static char *ccix_mem_err_cper_data(const char *c)
+{
+	const struct cper_ccix_mem_err_compact *cpd =
+		(struct cper_ccix_mem_err_compact *)c;
+	static char buf[1024];
+	char *p = buf;
+
+	p += sprintf(p, " (");
+	p += sprintf(p, "fru: %u ", cpd->fru);
+	if (cpd->validation_bits & CCIX_MEM_ERR_MEM_ERR_TYPE_VALID)
+		p += sprintf(p, "error: %s ",
+			     ccix_mem_err_type(cpd->mem_err_type));
+	if (cpd->validation_bits & CCIX_MEM_ERR_GENERIC_MEM_VALID)
+		p += sprintf(p, "type: %s ",
+			     ccix_mem_pool_type(cpd->pool_generic_type));
+	if (cpd->validation_bits & CCIX_MEM_ERR_SPEC_TYPE_VALID)
+		p += sprintf(p, "sub_type: %s ",
+			     ccix_mem_spec_type(cpd->pool_specific_type));
+	if (cpd->validation_bits & CCIX_MEM_ERR_OP_VALID)
+		p += sprintf(p, "op: %s ", ccix_mem_op(cpd->op_type));
+	if (cpd->validation_bits & CCIX_MEM_ERR_CARD_VALID)
+		p += sprintf(p, "card: %u ", cpd->card);
+	if (cpd->validation_bits & CCIX_MEM_ERR_MOD_VALID)
+		p += sprintf(p, "mod: %u ", cpd->module);
+	if (cpd->validation_bits & CCIX_MEM_ERR_BANK_VALID)
+		p += sprintf(p, "bank: %u ", cpd->bank);
+	if (cpd->validation_bits & CCIX_MEM_ERR_DEVICE_VALID)
+		p += sprintf(p, "device: %u ", cpd->device);
+	if (cpd->validation_bits & CCIX_MEM_ERR_ROW_VALID)
+		p += sprintf(p, "row: %u ", cpd->row);
+	if (cpd->validation_bits & CCIX_MEM_ERR_COL_VALID)
+		p += sprintf(p, "col: %u ", cpd->column);
+	if (cpd->validation_bits & CCIX_MEM_ERR_RANK_VALID)
+		p += sprintf(p, "rank: %u ", cpd->rank);
+	if (cpd->validation_bits & CCIX_MEM_ERR_BIT_POS_VALID)
+		p += sprintf(p, "bitpos: %u ", cpd->bit_pos);
+	if (cpd->validation_bits & CCIX_MEM_ERR_CHIP_ID_VALID)
+		p += sprintf(p, "chipid: %u ", cpd->chip_id);
+	p += sprintf(p - 1, ")");
+
+	return buf;
+}
+
+static char *ccix_component_type(int type)
+{
+	switch (type) {
+	case 0: return "RA";
+	case 1: return "HA";
+	case 2: return "SA";
+	case 3: return "Port";
+	case 4: return "CCIX-Link";
+	}
+	return "unknown-component";
+}
+
+static char *err_severity(int severity)
+{
+	switch (severity) {
+	case 0: return "recoverable";
+	case 1: return "fatal";
+	case 2: return "corrected";
+	case 3: return "informational";
+	}
+	return "unknown-severity";
+}
+
+static unsigned long long err_mask(int lsb)
+{
+	if (lsb == 0xff)
+		return ~0ull;
+	return ~((1ull << lsb) - 1);
+}
+
+static int ras_ccix_common_parse(struct trace_seq *s,
+				 struct pevent_record *record,
+				 struct event_format *event, void *context,
+				 struct ras_ccix_event *ev)
+{
+	unsigned long long val;
+	int len;
+
+	if (pevent_get_field_val(s,  event, "err_seq", record, &val, 1) < 0)
+		return -1;
+	ev->error_seq = val;
+	if (pevent_get_field_val(s,  event, "sev", record, &val, 1) < 0)
+		return -1;
+	ev->severity = val;
+	if (pevent_get_field_val(s, event, "sevdetail", record, &val, 1) < 0)
+		return -1;
+	ev->severity_detail = val;
+	if (pevent_get_field_val(s,  event, "pa", record, &val, 1) < 0)
+		return -1;
+	ev->address = val;
+	if (pevent_get_field_val(s,  event, "pa_mask_lsb", record, &val, 1) < 0)
+		return -1;
+	ev->pa_mask_lsb = val;
+	if (pevent_get_field_val(s, event, "source", record, &val, 1) < 0)
+		return -1;
+	ev->source = val;
+	if (pevent_get_field_val(s, event, "component", record, &val, 1) < 0)
+		return -1;
+	ev->component = val;
+
+	ev->cper_data = pevent_get_field_raw(s, event, "data", record, &len, 1);
+	ev->cper_data_length = len;
+
+	if (pevent_get_field_val(s, event, "vendor_data_length", record, &val,
+				 1))
+		return -1;
+	ev->vendor_data_length = val;
+
+	ev->vendor_data = pevent_get_field_raw(s, event, "vendor_data", record,
+					       &len, 1);
+
+	return 0;
+}
+
+int ras_ccix_memory_event_handler(struct trace_seq *s,
+				  struct pevent_record *record,
+				  struct event_format *event, void *context)
+{
+	struct ras_events *ras = context;
+	struct tm *tm;
+	struct ras_ccix_event ev;
+	time_t now;
+	int ret;
+
+	if (ras->use_uptime)
+		now = record->ts/user_hz + ras->uptime_diff;
+	else
+		now = time(NULL);
+
+	tm = localtime(&now);
+
+	if (tm)
+		strftime(ev.timestamp, sizeof(ev.timestamp),
+			 "%Y-%m-%d %H:%M:%S %z", tm);
+	trace_seq_printf(s, "%s ", ev.timestamp);
+
+	ret = ras_ccix_common_parse(s, record, event, context, &ev);
+	if (ret)
+		return ret;
+
+	trace_seq_printf(s, "%d %s id:%d CCIX memory error %s ue:%d nocomm:%d degraded:%d deferred:%d physical addr: 0x%llx mask: 0x%llx %s",
+			 ev.error_seq, err_severity(ev.severity),
+			 ev.source, ccix_component_type(ev.component),
+			 (ev.severity_detail & 0x1) ? 1 : 0,
+			 (ev.severity_detail & 0x2) ? 1 : 0,
+			 (ev.severity_detail & 0x4) ? 1 : 0,
+			 (ev.severity_detail & 0x8) ? 1 : 0,
+			 ev.address,
+			 err_mask(ev.pa_mask_lsb),
+			 ccix_mem_err_cper_data(ev.cper_data));
+
+	ras_store_ccix_memory_event(ras, &ev);
+
+	return 0;
+}
diff --git a/ras-ccix-handler.h b/ras-ccix-handler.h
new file mode 100644
index 0000000..f6d25b1
--- /dev/null
+++ b/ras-ccix-handler.h
@@ -0,0 +1,61 @@
+/*
+ * Copyright (c) 2019 Hisilicon Limited.
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
+#ifndef __RAS_CCIX_HANDLER_H
+#define __RAS_CCIX_HANDLER_H
+
+#include "ras-events.h"
+#include "libtrace/event-parse.h"
+
+int ras_ccix_memory_event_handler(struct trace_seq *s,
+				  struct pevent_record *record,
+				  struct event_format *event, void *context);
+
+/* Perhaps unnecessary paranoia, but the tracepoint structure is packed */
+#pragma pack(1)
+struct cper_ccix_mem_err_compact {
+	uint32_t validation_bits;
+	uint8_t mem_err_type;
+	uint8_t pool_generic_type;
+	uint8_t pool_specific_type;
+	uint8_t op_type;
+	uint8_t card;
+	uint16_t module;
+	uint16_t bank;
+	uint32_t device;
+	uint32_t row;
+	uint32_t column;
+	uint32_t rank;
+	uint8_t bit_pos;
+	uint8_t chip_id;
+	uint8_t fru;
+};
+#pragma pack()
+
+#define CCIX_MEM_ERR_GENERIC_MEM_VALID		0x0001
+#define CCIX_MEM_ERR_OP_VALID			0x0002
+#define CCIX_MEM_ERR_MEM_ERR_TYPE_VALID		0x0004
+#define CCIX_MEM_ERR_CARD_VALID			0x0008
+#define CCIX_MEM_ERR_BANK_VALID			0x0010
+#define CCIX_MEM_ERR_DEVICE_VALID		0x0020
+#define CCIX_MEM_ERR_ROW_VALID			0x0040
+#define CCIX_MEM_ERR_COL_VALID			0x0080
+#define CCIX_MEM_ERR_RANK_VALID			0x0100
+#define CCIX_MEM_ERR_BIT_POS_VALID		0x0200
+#define CCIX_MEM_ERR_CHIP_ID_VALID		0x0400
+#define CCIX_MEM_ERR_VENDOR_DATA_VALID		0x0800
+#define CCIX_MEM_ERR_MOD_VALID			0x1000
+#define CCIX_MEM_ERR_SPEC_TYPE_VALID		0x2000
+
+#endif
diff --git a/ras-events.c b/ras-events.c
index 9395f6f..c7bd1c3 100644
--- a/ras-events.c
+++ b/ras-events.c
@@ -29,6 +29,7 @@
 #include "libtrace/event-parse.h"
 #include "ras-mc-handler.h"
 #include "ras-aer-handler.h"
+#include "ras-ccix-handler.h"
 #include "ras-non-standard-handler.h"
 #include "ras-arm-handler.h"
 #include "ras-mce-handler.h"
@@ -202,6 +203,10 @@ int toggle_ras_mc_event(int enable)
 	rc |= __toggle_ras_mc_event(ras, "ras", "aer_event", enable);
 #endif
 
+#ifdef HAVE_CCIX
+	rc |= __toggle_ras_mc_event(ras, "ras", "ccix_memory_event", enable);
+#endif
+
 #ifdef HAVE_MCE
 	rc |= __toggle_ras_mc_event(ras, "mce", "mce_record", enable);
 #endif
@@ -686,6 +691,17 @@ int handle_ras_events(int record_events)
 		    "ras", "aer_event");
 #endif
 
+#ifdef HAVE_CCIX
+	rc = add_event_handler(ras, pevent, page_size, "ras",
+			       "ccix_memory_error_event",
+			       ras_ccix_memory_event_handler);
+	if (!rc)
+		num_events++;
+	else
+		log(ALL, LOG_ERR, "Can't get traces from %s:%s\n",
+		    "ras", "ccix_memory_event");
+#endif
+
 #ifdef HAVE_NON_STANDARD
         rc = add_event_handler(ras, pevent, page_size, "ras", "non_standard_event",
                                ras_non_standard_event_handler);
diff --git a/ras-record.c b/ras-record.c
index 2e7525e..b1a241a 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -28,6 +28,7 @@
 #include "ras-events.h"
 #include "ras-mc-handler.h"
 #include "ras-aer-handler.h"
+#include "ras-ccix-handler.h"
 #include "ras-mce-handler.h"
 #include "ras-logger.h"
 
@@ -158,6 +159,174 @@ int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev)
 }
 #endif
 
+#ifdef HAVE_CCIX
+enum {
+	ccix_field_id,
+	ccix_field_timestamp,
+	ccix_field_error_count,
+	ccix_field_severity,
+	ccix_field_severity_detail,
+	ccix_field_address,
+	ccix_field_address_mask,
+	ccix_field_source,
+	ccix_field_component,
+	ccix_field_common_end
+};
+
+#define CCIX_COMMON_FIELDS \
+	[ccix_field_id] =		{ .name = "id",			.type = "INTEGER PRIMARY KEY" }, \
+	[ccix_field_timestamp] =	{ .name = "timestamp",		.type = "TEXT" },	\
+	[ccix_field_error_count] =	{ .name = "error_count",	.type = "INTEGER" }, \
+	[ccix_field_severity] =		{ .name = "severity",		.type = "INTEGER" }, \
+	[ccix_field_severity_detail] =	{ .name = "severity_detail",	.type = "INTEGER" }, \
+	[ccix_field_address] =		{ .name = "address",		.type = "INTEGER" }, \
+	[ccix_field_address_mask] =	{ .name = "address_mask",	.type = "INTEGER" }, \
+	[ccix_field_source] =		{ .name = "source",		.type = "INTEGER" }, \
+	[ccix_field_component] =	{ .name = "component",		.type = "INTEGER" }
+
+enum {
+	ccix_mem_field_error_type = ccix_field_common_end,
+	ccix_mem_field_fru,
+	ccix_mem_field_type,
+	ccix_mem_field_sub_type,
+	ccix_mem_field_operation,
+	ccix_mem_field_card,
+	ccix_mem_field_mod,
+	ccix_mem_field_bank,
+	ccix_mem_field_device,
+	ccix_mem_field_row,
+	ccix_mem_field_col,
+	ccix_mem_field_rank,
+	ccix_mem_field_bit_pos,
+	ccix_mem_field_chip_id,
+	ccix_mem_field_vendor
+};
+
+static const struct db_fields ccix_memory_event_fields[] = {
+	CCIX_COMMON_FIELDS,
+	[ccix_mem_field_error_type] =	{ .name = "mem_err_type",	.type = "INTEGER" },
+	[ccix_mem_field_fru] =		{ .name = "fru",		.type = "INTEGER" },
+	[ccix_mem_field_type] =		{ .name = "type",		.type = "INTEGER" },
+	[ccix_mem_field_sub_type] =	{ .name = "sub_type",		.type = "INTEGER" },
+	[ccix_mem_field_operation] =	{ .name = "operation",		.type = "INTEGER" },
+	[ccix_mem_field_card] =		{ .name = "card",		.type = "INTEGER" },
+	[ccix_mem_field_mod] =		{ .name = "mod",		.type = "INTEGER" },
+	[ccix_mem_field_bank] =		{ .name = "bank",		.type = "INTEGER" },
+	[ccix_mem_field_device] =	{ .name = "device",		.type = "INTEGER" },
+	[ccix_mem_field_row] =		{ .name = "row",		.type = "INTEGER" },
+	[ccix_mem_field_col] =		{ .name = "col",		.type = "INTEGER" },
+	[ccix_mem_field_rank] =		{ .name = "rank",		.type = "INTEGER" },
+	[ccix_mem_field_bit_pos] =	{ .name = "bit_position",	.type = "INTEGER" },
+	[ccix_mem_field_chip_id] =	{ .name = "chip_id",		.type = "INTEGER" },
+	[ccix_mem_field_vendor] =	{ .name = "vendor_data",	.type = "BLOB" },
+};
+
+static const struct db_table_descriptor ccix_memory_event_tab = {
+	.name = "ccix_memory_event",
+	.fields = ccix_memory_event_fields,
+	.num_fields = ARRAY_SIZE(ccix_memory_event_fields),
+};
+
+static void ras_store_ccix_common(sqlite3_stmt *record,
+				  struct ras_ccix_event *ev)
+{
+	sqlite3_bind_text(record, ccix_field_timestamp, ev->timestamp, -1,
+			  NULL);
+	sqlite3_bind_int(record, ccix_field_error_count, ev->error_seq);
+	sqlite3_bind_int(record, ccix_field_severity, ev->severity);
+	sqlite3_bind_int(record, ccix_field_severity_detail,
+			 ev->severity_detail);
+	sqlite3_bind_int64(record, ccix_field_address, ev->address);
+	sqlite3_bind_int64(record, ccix_field_address_mask, ev->pa_mask_lsb);
+	sqlite3_bind_int(record, ccix_field_source, ev->source);
+	sqlite3_bind_int(record, ccix_field_component, ev->component);
+}
+
+int ras_store_ccix_memory_event(struct ras_events *ras,
+				struct ras_ccix_event *ev)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+	struct cper_ccix_mem_err_compact *mem =
+	  (struct cper_ccix_mem_err_compact *)ev->cper_data;
+	sqlite3_stmt *rec = priv->stmt_ccix_mem_record;
+
+	if (!priv || !rec)
+		return 0;
+	log(TERM, LOG_INFO, "ccix_memory_eventstore: %p\n", rec);
+
+	ras_store_ccix_common(rec, ev);
+
+	sqlite3_bind_int(rec, ccix_mem_field_fru, mem->fru);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_MEM_ERR_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_error_type,
+				 mem->mem_err_type);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_GENERIC_MEM_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_type,
+				 mem->pool_generic_type);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_SPEC_TYPE_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_sub_type,
+				 mem->pool_specific_type);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_OP_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_operation, mem->op_type);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_CARD_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_card, mem->card);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_MOD_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_mod, mem->module);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_BANK_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_bank, mem->bank);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_DEVICE_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_device, mem->device);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_ROW_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_row, mem->row);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_COL_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_col, mem->column);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_RANK_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_rank, mem->rank);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_BIT_POS_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_bit_pos, mem->bit_pos);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_CHIP_ID_VALID)
+		sqlite3_bind_int(rec, ccix_mem_field_chip_id, mem->chip_id);
+
+	if (mem->validation_bits & CCIX_MEM_ERR_VENDOR_DATA_VALID)
+		sqlite3_bind_blob(rec, ccix_mem_field_vendor,
+				  ev->vendor_data, ev->vendor_data_length,
+				  NULL);
+
+	rc = sqlite3_step(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do ccix_mem_record step on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_reset(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed reset ccix_mem_record on sqlite: error = %d\n",
+		    rc);
+
+	rc = sqlite3_clear_bindings(rec);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear ccix_mem_record: error %d\n",
+		    rc);
+	log(TERM, LOG_INFO, "register inserted at db\n");
+	return rc;
+}
+#endif
 /*
  * Table and functions to handle ras:non standard
  */
@@ -547,6 +716,13 @@ int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 					 &extlog_event_tab);
 #endif
 
+#ifdef HAVE_CCIX
+	rc = ras_mc_create_table(priv, &ccix_memory_event_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, &priv->stmt_ccix_mem_record,
+					 &ccix_memory_event_tab);
+#endif
+
 #ifdef HAVE_MCE
 	rc = ras_mc_create_table(priv, &mce_record_tab);
 	if (rc == SQLITE_OK)
diff --git a/ras-record.h b/ras-record.h
index a11f290..4a871fa 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -44,6 +44,21 @@ struct ras_aer_event {
 	const char *msg;
 };
 
+struct ras_ccix_event {
+	char timestamp[64];
+	int32_t error_seq;
+	int8_t severity;
+	int8_t severity_detail;
+	unsigned long long address;
+	int8_t pa_mask_lsb;
+	uint8_t source;
+	uint8_t component;
+	const char *cper_data;
+	unsigned short cper_data_length;
+	uint16_t vendor_data_length;
+	const char *vendor_data;
+};
+
 struct ras_extlog_event {
 	char timestamp[64];
 	int32_t error_seq;
@@ -98,6 +113,9 @@ struct sqlite3_priv {
 #ifdef HAVE_EXTLOG
 	sqlite3_stmt	*stmt_extlog_record;
 #endif
+#ifdef HAVE_CCIX
+	sqlite3_stmt	*stmt_ccix_mem_record;
+#endif
 #ifdef HAVE_NON_STANDARD
 	sqlite3_stmt	*stmt_non_standard_record;
 #endif
@@ -111,6 +129,7 @@ int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev);
 int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev);
 int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev);
 int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev);
+int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev);
 int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev);
 
@@ -120,6 +139,7 @@ static inline int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event
 static inline int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev) { return 0; };
 static inline int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev) { return 0; };
 static inline int ras_store_extlog_mem_record(struct ras_events *ras, struct ras_extlog_event *ev) { return 0; };
+static inline int ras_store_ccix_memory_event(struct ras_events *ras, struct ras_ccix_event *ev) { return 0; };
 static inline int ras_store_non_standard_record(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_store_arm_record(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
 
diff --git a/ras-report.h b/ras-report.h
index 6c466f5..72e950a 100644
--- a/ras-report.h
+++ b/ras-report.h
@@ -19,6 +19,7 @@
 #include "ras-mc-handler.h"
 #include "ras-mce-handler.h"
 #include "ras-aer-handler.h"
+#include "ras-ccix-handler.h"
 
 /* Maximal length of backtrace. */
 #define MAX_BACKTRACE_SIZE (1024*1024)
@@ -34,7 +35,8 @@ enum {
 	MCE_EVENT,
 	AER_EVENT,
 	NON_STANDARD_EVENT,
-	ARM_EVENT
+	ARM_EVENT,
+	CCIX_EVENT,
 };
 
 #ifdef HAVE_ABRT_REPORT
@@ -44,6 +46,7 @@ int ras_report_aer_event(struct ras_events *ras, struct ras_aer_event *ev);
 int ras_report_mce_event(struct ras_events *ras, struct mce_event *ev);
 int ras_report_non_standard_event(struct ras_events *ras, struct ras_non_standard_event *ev);
 int ras_report_arm_event(struct ras_events *ras, struct ras_arm_event *ev);
+int ras_report_ccix_event(struct ras_events *ras, struct ras_ccix_event *ev);
 
 #else
 
@@ -52,6 +55,7 @@ static inline int ras_report_aer_event(struct ras_events *ras, struct ras_aer_ev
 static inline int ras_report_mce_event(struct ras_events *ras, struct mce_event *ev) { return 0; };
 static inline int ras_report_non_standard_event(struct ras_events *ras, struct ras_non_standard_event *ev) { return 0; };
 static inline int ras_report_arm_event(struct ras_events *ras, struct ras_arm_event *ev) { return 0; };
+static inline int ras_report_ccix_event(struct ras_events *ras, struct ras_ccix_event *ev) { return 0; };
 
 #endif
 
-- 
2.20.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB8948566
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfFQO3o (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfFQO3n (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 193A4F2BA2C985DFAA91;
        Mon, 17 Jun 2019 22:29:39 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:32 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 4/6] rasdaemon:add logging HiSilicon HIP08 H/W errors reported in the OEM format1
Date:   Mon, 17 Jun 2019 15:28:50 +0100
Message-ID: <20190617142852.12140-5-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.19.2.windows.1
In-Reply-To: <20190617142852.12140-1-shiju.jose@huawei.com>
References: <Shiju Jose>
 <20190617142852.12140-1-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.202.226.53]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch adds logging the HiSilicon HIP08 H/W errors reported
in the non-standard OEM format1.
These errors are from the H/W modules MN, PLL, SLLC, AA, SIOE,
POE, DISP, LPC, SAS and SATA.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 Makefile.am                |   2 +-
 non-standard-hisi_hip07.c  |   8 +-
 non-standard-hisi_hip08.c  | 332 +++++++++++++++++++++++++++++++++++++++++++++
 ras-non-standard-handler.c |   3 +-
 ras-non-standard-handler.h |   7 +-
 ras-record.c               |  30 ++--
 ras-record.h               |  13 ++
 7 files changed, 378 insertions(+), 17 deletions(-)
 create mode 100644 non-standard-hisi_hip08.c

diff --git a/Makefile.am b/Makefile.am
index f036ffd..3d89672 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -49,7 +49,7 @@ if WITH_ABRT_REPORT
    rasdaemon_SOURCES += ras-report.c
 endif
 if WITH_HISI_NS_DECODE
-   rasdaemon_SOURCES += non-standard-hisi_hip07.c
+   rasdaemon_SOURCES += non-standard-hisi_hip07.c non-standard-hisi_hip08.c
 endif
 rasdaemon_LDADD = -lpthread $(SQLITE3_LIBS) libtrace/libtrace.a
 
diff --git a/non-standard-hisi_hip07.c b/non-standard-hisi_hip07.c
index bb2576e..7f58fb3 100644
--- a/non-standard-hisi_hip07.c
+++ b/non-standard-hisi_hip07.c
@@ -87,7 +87,9 @@ static char *sas_axi_err_type(int etype)
 	return "unknown error";
 }
 
-static int decode_hip07_sas_error(struct trace_seq *s, const void *error)
+static int decode_hip07_sas_error(struct ras_events *ras,
+				  struct ras_ns_dec_tab *dec_tab,
+				  struct trace_seq *s, const void *error)
 {
 	char buf[1024];
 	char *p = buf;
@@ -120,7 +122,9 @@ static int decode_hip07_sas_error(struct trace_seq *s, const void *error)
 	return 0;
 }
 
-static int decode_hip07_hns_error(struct trace_seq *s, const void *error)
+static int decode_hip07_hns_error(struct ras_events *ras,
+				  struct ras_ns_dec_tab *dec_tab,
+				  struct trace_seq *s, const void *error)
 {
 	return 0;
 }
diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
new file mode 100644
index 0000000..240e832
--- /dev/null
+++ b/non-standard-hisi_hip08.c
@@ -0,0 +1,332 @@
+/*
+ * Copyright (c) 2019 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include "ras-record.h"
+#include "ras-logger.h"
+#include "ras-report.h"
+#include "ras-non-standard-handler.h"
+
+/* HISI OEM error definitions */
+/* HISI OEM format1 error definitions */
+#define HISI_OEM_MODULE_ID_MN	0
+#define HISI_OEM_MODULE_ID_PLL	1
+#define HISI_OEM_MODULE_ID_SLLC	2
+#define HISI_OEM_MODULE_ID_AA	3
+#define HISI_OEM_MODULE_ID_SIOE	4
+#define HISI_OEM_MODULE_ID_POE	5
+#define HISI_OEM_MODULE_ID_DISP	8
+#define HISI_OEM_MODULE_ID_LPC	9
+#define HISI_OEM_MODULE_ID_SAS	15
+#define HISI_OEM_MODULE_ID_SATA	16
+
+#define HISI_OEM_VALID_SOC_ID		BIT(0)
+#define HISI_OEM_VALID_SOCKET_ID	BIT(1)
+#define HISI_OEM_VALID_NIMBUS_ID	BIT(2)
+#define HISI_OEM_VALID_MODULE_ID	BIT(3)
+#define HISI_OEM_VALID_SUB_MODULE_ID	BIT(4)
+#define HISI_OEM_VALID_ERR_SEVERITY	BIT(5)
+
+#define HISI_OEM_TYPE1_VALID_ERR_MISC_0	BIT(6)
+#define HISI_OEM_TYPE1_VALID_ERR_MISC_1	BIT(7)
+#define HISI_OEM_TYPE1_VALID_ERR_MISC_2	BIT(8)
+#define HISI_OEM_TYPE1_VALID_ERR_MISC_3	BIT(9)
+#define HISI_OEM_TYPE1_VALID_ERR_MISC_4	BIT(10)
+#define HISI_OEM_TYPE1_VALID_ERR_ADDR	BIT(11)
+
+struct hisi_oem_type1_err_sec {
+	uint32_t   val_bits;
+	uint8_t    version;
+	uint8_t    soc_id;
+	uint8_t    socket_id;
+	uint8_t    nimbus_id;
+	uint8_t    module_id;
+	uint8_t    sub_module_id;
+	uint8_t    err_severity;
+	uint8_t    reserv;
+	uint32_t   err_misc_0;
+	uint32_t   err_misc_1;
+	uint32_t   err_misc_2;
+	uint32_t   err_misc_3;
+	uint32_t   err_misc_4;
+	uint64_t   err_addr;
+};
+
+enum hisi_oem_data_type {
+	hisi_oem_data_type_int,
+	hisi_oem_data_type_int64,
+	hisi_oem_data_type_text,
+};
+
+enum {
+	hip08_oem_type1_field_id,
+	hip08_oem_type1_field_version,
+	hip08_oem_type1_field_soc_id,
+	hip08_oem_type1_field_socket_id,
+	hip08_oem_type1_field_nimbus_id,
+	hip08_oem_type1_field_module_id,
+	hip08_oem_type1_field_sub_module_id,
+	hip08_oem_type1_field_err_sev,
+	hip08_oem_type1_field_err_misc_0,
+	hip08_oem_type1_field_err_misc_1,
+	hip08_oem_type1_field_err_misc_2,
+	hip08_oem_type1_field_err_misc_3,
+	hip08_oem_type1_field_err_misc_4,
+	hip08_oem_type1_field_err_addr,
+};
+
+/* helper functions */
+static char *err_severity(uint8_t err_sev)
+{
+	switch (err_sev) {
+	case 0: return "recoverable";
+	case 1: return "fatal";
+	case 2: return "corrected";
+	case 3: return "none";
+	}
+	return "unknown";
+}
+
+static char *oem_type1_module_name(uint8_t module_id)
+{
+	switch (module_id) {
+	case HISI_OEM_MODULE_ID_MN: return "MN";
+	case HISI_OEM_MODULE_ID_PLL: return "PLL";
+	case HISI_OEM_MODULE_ID_SLLC: return "SLLC";
+	case HISI_OEM_MODULE_ID_AA: return "AA";
+	case HISI_OEM_MODULE_ID_SIOE: return "SIOE";
+	case HISI_OEM_MODULE_ID_POE: return "POE";
+	case HISI_OEM_MODULE_ID_DISP: return "DISP";
+	case HISI_OEM_MODULE_ID_LPC: return "LPC";
+	case HISI_OEM_MODULE_ID_SAS: return "SAS";
+	case HISI_OEM_MODULE_ID_SATA: return "SATA";
+	}
+	return "unknown";
+}
+
+#ifdef HAVE_SQLITE3
+static const struct db_fields hip08_oem_type1_event_fields[] = {
+	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
+	{ .name = "version",		.type = "INTEGER" },
+	{ .name = "soc_id",		.type = "INTEGER" },
+	{ .name = "socket_id",		.type = "INTEGER" },
+	{ .name = "nimbus_id",		.type = "INTEGER" },
+	{ .name = "module_id",		.type = "TEXT" },
+	{ .name = "sub_module_id",	.type = "INTEGER" },
+	{ .name = "err_severity",	.type = "TEXT" },
+	{ .name = "err_misc_0",		.type = "INTEGER" },
+	{ .name = "err_misc_1",		.type = "INTEGER" },
+	{ .name = "err_misc_2",		.type = "INTEGER" },
+	{ .name = "err_misc_3",		.type = "INTEGER" },
+	{ .name = "err_misc_4",		.type = "INTEGER" },
+	{ .name = "err_addr",		.type = "INTEGER" },
+};
+
+static const struct db_table_descriptor hip08_oem_type1_event_tab = {
+	.name = "hip08_oem_type1_event",
+	.fields = hip08_oem_type1_event_fields,
+	.num_fields = ARRAY_SIZE(hip08_oem_type1_event_fields),
+};
+
+static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+			       enum hisi_oem_data_type data_type,
+			       int id, int64_t data, const char *text)
+{
+	switch (data_type) {
+	case hisi_oem_data_type_int:
+		sqlite3_bind_int(dec_tab->stmt_dec_record, id, data);
+		break;
+	case hisi_oem_data_type_int64:
+		sqlite3_bind_int64(dec_tab->stmt_dec_record, id, data);
+		break;
+	case hisi_oem_data_type_text:
+		sqlite3_bind_text(dec_tab->stmt_dec_record, id, text, -1, NULL);
+		break;
+	default:
+		break;
+	}
+}
+
+static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
+{
+	int rc;
+
+	rc = sqlite3_step(dec_tab->stmt_dec_record);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to do %s step on sqlite: error = %d\n", name, rc);
+
+	rc = sqlite3_reset(dec_tab->stmt_dec_record);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to reset %s on sqlite: error = %d\n", name, rc);
+
+	rc = sqlite3_clear_bindings(dec_tab->stmt_dec_record);
+	if (rc != SQLITE_OK && rc != SQLITE_DONE)
+		log(TERM, LOG_ERR,
+		    "Failed to clear bindings %s on sqlite: error = %d\n",
+		    name, rc);
+
+	return rc;
+}
+#else
+static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+			       enum hisi_oem_data_type data_type,
+			       int id, int64_t data, const char *text)
+{ }
+
+static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
+{
+	return 0;
+}
+#endif
+
+/* error data decoding functions */
+static int decode_hip08_oem_type1_error(struct ras_events *ras,
+					struct ras_ns_dec_tab *dec_tab,
+					struct trace_seq *s, const void *error)
+{
+	const struct hisi_oem_type1_err_sec *err = error;
+	char buf[1024];
+	char *p = buf;
+
+	if (err->val_bits == 0) {
+		trace_seq_printf(s, "%s: no valid error information\n",
+				 __func__);
+		return -1;
+	}
+
+#ifdef HAVE_SQLITE3
+	if (!dec_tab->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
+					    &hip08_oem_type1_event_tab)
+			!= SQLITE_OK) {
+			trace_seq_printf(s,
+					"create sql hip08_oem_type1_event_tab fail\n");
+			return -1;
+		}
+	}
+#endif
+
+	p += sprintf(p, "[ ");
+	p += sprintf(p, "Table version=%d ", err->version);
+	record_vendor_data(dec_tab, hisi_oem_data_type_int,
+			   hip08_oem_type1_field_version, err->version, NULL);
+
+	if (err->val_bits & HISI_OEM_VALID_SOC_ID) {
+		p += sprintf(p, "SOC ID=%d ", err->soc_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_soc_id,
+				   err->soc_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID) {
+		p += sprintf(p, "socket ID=%d ", err->socket_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_socket_id,
+				   err->socket_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID) {
+		p += sprintf(p, "nimbus ID=%d ", err->nimbus_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_nimbus_id,
+				   err->nimbus_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
+		p += sprintf(p, "module=%s-",
+			     oem_type1_module_name(err->module_id));
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_oem_type1_field_module_id,
+				   0, oem_type1_module_name(err->module_id));
+		if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
+			p += sprintf(p, "%d ", err->sub_module_id);
+			record_vendor_data(dec_tab, hisi_oem_data_type_int,
+					   hip08_oem_type1_field_sub_module_id,
+					   err->sub_module_id, NULL);
+		}
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
+		p += sprintf(p, "error severity=%s ",
+			     err_severity(err->err_severity));
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_oem_type1_field_err_sev,
+				   0, err_severity(err->err_severity));
+	}
+
+	p += sprintf(p, "]");
+	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
+	trace_seq_printf(s, "%s\n", buf);
+
+	trace_seq_printf(s, "Reg Dump:\n");
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_0) {
+		trace_seq_printf(s, "ERR_MISC0=0x%x\n", err->err_misc_0);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_err_misc_0,
+				   err->err_misc_0, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_1) {
+		trace_seq_printf(s, "ERR_MISC1=0x%x\n", err->err_misc_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_err_misc_1,
+				   err->err_misc_1, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_2) {
+		trace_seq_printf(s, "ERR_MISC2=0x%x\n", err->err_misc_2);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_err_misc_2,
+				   err->err_misc_2, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_3) {
+		trace_seq_printf(s, "ERR_MISC3=0x%x\n", err->err_misc_3);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_err_misc_3,
+				   err->err_misc_3, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_4) {
+		trace_seq_printf(s, "ERR_MISC4=0x%x\n", err->err_misc_4);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type1_field_err_misc_4,
+				   err->err_misc_4, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_ADDR) {
+		trace_seq_printf(s, "ERR_ADDR=0x%p\n", (void *)err->err_addr);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int64,
+				   hip08_oem_type1_field_err_addr,
+				   err->err_addr, NULL);
+	}
+
+	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
+
+	return 0;
+}
+
+struct ras_ns_dec_tab hip08_ns_oem_tab[] = {
+	{
+		.sec_type = "1f8161e155d641e6bd107afd1dc5f7c5",
+		.decode = decode_hip08_oem_type1_error,
+	},
+	{ /* sentinel */ }
+};
+
+__attribute__((constructor))
+static void hip08_init(void)
+{
+	register_ns_dec_tab(hip08_ns_oem_tab);
+}
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index 392bb27..4eda80b 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -166,7 +166,8 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 		for (i = 0; dec_tab[i].decode; i++) {
 			if (uuid_le_cmp(ev.sec_type,
 					dec_tab[i].sec_type) == 0) {
-				dec_tab[i].decode(s, ev.error);
+				dec_tab[i].decode(ras, &dec_tab[i],
+						  s, ev.error);
 				dec_done = true;
 				break;
 			}
diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index b2c9743..a7e48a3 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -22,7 +22,12 @@
 
 typedef struct ras_ns_dec_tab {
 	const char *sec_type;
-	int (*decode)(struct trace_seq *s, const void *err);
+	int (*decode)(struct ras_events *ras, struct ras_ns_dec_tab *dec_tab,
+		      struct trace_seq *s, const void *err);
+#ifdef HAVE_SQLITE3
+#include <sqlite3.h>
+	sqlite3_stmt *stmt_dec_record;
+#endif
 } *p_ns_dec_tab;
 
 int ras_non_standard_event_handler(struct trace_seq *s,
diff --git a/ras-record.c b/ras-record.c
index 4c8b55b..b212607 100644
--- a/ras-record.c
+++ b/ras-record.c
@@ -38,17 +38,6 @@
 
 #define ARRAY_SIZE(x) (sizeof(x)/sizeof(*(x)))
 
-struct db_fields {
-	char *name;
-	char *type;
-};
-
-struct db_table_descriptor {
-	char			*name;
-	const struct db_fields	*fields;
-	size_t			num_fields;
-};
-
 /*
  * Table and functions to handle ras:mc_event
  */
@@ -511,7 +500,7 @@ static int ras_mc_create_table(struct sqlite3_priv *priv,
 {
 	const struct db_fields *field;
 	char sql[1024], *p = sql, *end = sql + sizeof(sql);
-	int i,rc;
+	int i, rc;
 
 	p += snprintf(p, end - p, "CREATE TABLE IF NOT EXISTS %s (",
 		      db_tab->name);
@@ -538,6 +527,23 @@ static int ras_mc_create_table(struct sqlite3_priv *priv,
 	return rc;
 }
 
+int ras_mc_add_vendor_table(struct ras_events *ras,
+			    sqlite3_stmt **stmt,
+			    const struct db_table_descriptor *db_tab)
+{
+	int rc;
+	struct sqlite3_priv *priv = ras->db_priv;
+
+	if (!priv)
+		return -1;
+
+	rc = ras_mc_create_table(priv, db_tab);
+	if (rc == SQLITE_OK)
+		rc = ras_mc_prepare_stmt(priv, stmt, db_tab);
+
+	return rc;
+}
+
 int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras)
 {
 	int rc;
diff --git a/ras-record.h b/ras-record.h
index 2183167..432a571 100644
--- a/ras-record.h
+++ b/ras-record.h
@@ -119,7 +119,20 @@ struct sqlite3_priv {
 #endif
 };
 
+struct db_fields {
+	char *name;
+	char *type;
+};
+
+struct db_table_descriptor {
+	char                    *name;
+	const struct db_fields  *fields;
+	size_t                  num_fields;
+};
+
 int ras_mc_event_opendb(unsigned cpu, struct ras_events *ras);
+int ras_mc_add_vendor_table(struct ras_events *ras, sqlite3_stmt **stmt,
+			    const struct db_table_descriptor *db_tab);
 int ras_store_mc_event(struct ras_events *ras, struct ras_mc_event *ev);
 int ras_store_aer_event(struct ras_events *ras, struct ras_aer_event *ev);
 int ras_store_mce_record(struct ras_events *ras, struct mce_event *ev);
-- 
1.9.1



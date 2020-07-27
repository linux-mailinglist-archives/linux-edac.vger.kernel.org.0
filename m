Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A4122E6C0
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgG0Hjt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 03:39:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:60072 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbgG0Hjs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 03:39:48 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6E01C8C6662D86E34D1B;
        Mon, 27 Jul 2020 15:39:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Mon, 27 Jul 2020 15:39:34 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <shiju.jose@huawei.com>,
        <jonathan.cameron@huawei.com>, Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH rasdaemon 3/3] rasdaemon: add support for hisilicon common section decoder
Date:   Mon, 27 Jul 2020 15:38:39 +0800
Message-ID: <1595835519-32039-4-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
References: <1595835519-32039-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a new non-standard error section, Hisilicon common section.
It is defined for the next generation SoC Kunpeng930. It also supports
Kunpeng920 and some modules of Kunpeng920 could be changed to use
this section.

We put the code to an new source file, as it supports multiple Hardware
platform. Some code of hip08 could be shared. Move them to this new file.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 Makefile.am               |   2 +-
 non-standard-hisi_hip08.c |  79 +-----------
 non-standard-hisilicon.c  | 307 ++++++++++++++++++++++++++++++++++++++++++++++
 non-standard-hisilicon.h  |  49 ++++++++
 4 files changed, 358 insertions(+), 79 deletions(-)
 create mode 100644 non-standard-hisilicon.c
 create mode 100644 non-standard-hisilicon.h

diff --git a/Makefile.am b/Makefile.am
index 2b38e4b..c956d35 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -52,7 +52,7 @@ if WITH_ABRT_REPORT
    rasdaemon_SOURCES += ras-report.c
 endif
 if WITH_HISI_NS_DECODE
-   rasdaemon_SOURCES += non-standard-hisi_hip08.c
+   rasdaemon_SOURCES += non-standard-hisi_hip08.c non-standard-hisilicon.c
 endif
 if WITH_MEMORY_CE_PFA
    rasdaemon_SOURCES += rbtree.c ras-page-isolation.c
diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 7fc6939..2197f81 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -15,6 +15,7 @@
 #include "ras-logger.h"
 #include "ras-report.h"
 #include "ras-non-standard-handler.h"
+#include "non-standard-hisilicon.h"
 
 /* HISI OEM error definitions */
 /* HISI OEM format1 error definitions */
@@ -83,11 +84,6 @@
 #define HISI_PCIE_LOCAL_ERR_MISC_MAX	33
 #define HISI_BUF_LEN	1024
 
-#define HISI_ERR_SEVERITY_NFE	0
-#define HISI_ERR_SEVERITY_FE	1
-#define HISI_ERR_SEVERITY_CE	2
-#define HISI_ERR_SEVERITY_NONE	3
-
 struct hisi_oem_type1_err_sec {
 	uint32_t   val_bits;
 	uint8_t    version;
@@ -145,12 +141,6 @@ struct hisi_pcie_local_err_sec {
 	uint32_t   err_misc[HISI_PCIE_LOCAL_ERR_MISC_MAX];
 };
 
-enum hisi_oem_data_type {
-	HISI_OEM_DATA_TYPE_INT,
-	HISI_OEM_DATA_TYPE_INT64,
-	HISI_OEM_DATA_TYPE_TEXT,
-};
-
 enum {
 	HIP08_OEM_TYPE1_FIELD_ID,
 	HIP08_OEM_TYPE1_FIELD_TIMESTAMP,
@@ -199,20 +189,6 @@ struct hisi_module_info {
 	int sub_num;
 };
 
-/* helper functions */
-static char *err_severity(uint8_t err_sev)
-{
-	switch (err_sev) {
-	case HISI_ERR_SEVERITY_NFE: return "recoverable";
-	case HISI_ERR_SEVERITY_FE: return "fatal";
-	case HISI_ERR_SEVERITY_CE: return "corrected";
-	case HISI_ERR_SEVERITY_NONE: return "none";
-	default:
-		break;
-	}
-	return "unknown";
-}
-
 static const char *pll_submodule_name[] = {
 	"TB_PLL0",
 	"TB_PLL1",
@@ -549,59 +525,6 @@ static const struct db_table_descriptor hip08_pcie_local_event_tab = {
 	.fields = hip08_pcie_local_event_fields,
 	.num_fields = ARRAY_SIZE(hip08_pcie_local_event_fields),
 };
-
-static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
-			       enum hisi_oem_data_type data_type,
-			       int id, int64_t data, const char *text)
-{
-	switch (data_type) {
-	case HISI_OEM_DATA_TYPE_INT:
-		sqlite3_bind_int(dec_tab->stmt_dec_record, id, data);
-		break;
-	case HISI_OEM_DATA_TYPE_INT64:
-		sqlite3_bind_int64(dec_tab->stmt_dec_record, id, data);
-		break;
-	case HISI_OEM_DATA_TYPE_TEXT:
-		sqlite3_bind_text(dec_tab->stmt_dec_record, id, text, -1, NULL);
-		break;
-	default:
-		break;
-	}
-}
-
-static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab,
-				const char *name)
-{
-	int rc;
-
-	rc = sqlite3_step(dec_tab->stmt_dec_record);
-	if (rc != SQLITE_OK && rc != SQLITE_DONE)
-		log(TERM, LOG_ERR,
-		    "Failed to do %s step on sqlite: error = %d\n", name, rc);
-
-	rc = sqlite3_reset(dec_tab->stmt_dec_record);
-	if (rc != SQLITE_OK && rc != SQLITE_DONE)
-		log(TERM, LOG_ERR,
-		    "Failed to reset %s on sqlite: error = %d\n", name, rc);
-
-	rc = sqlite3_clear_bindings(dec_tab->stmt_dec_record);
-	if (rc != SQLITE_OK && rc != SQLITE_DONE)
-		log(TERM, LOG_ERR,
-		    "Failed to clear bindings %s on sqlite: error = %d\n",
-		    name, rc);
-
-	return rc;
-}
-#else
-static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
-			       enum hisi_oem_data_type data_type,
-			       int id, int64_t data, const char *text)
-{ }
-
-static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
-{
-	return 0;
-}
 #endif
 
 #define IN_RANGE(p, start, end) ((p) >= (start) && (p) < (end))
diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
new file mode 100644
index 0000000..c9e1fa9
--- /dev/null
+++ b/non-standard-hisilicon.c
@@ -0,0 +1,307 @@
+/*
+ * Copyright (c) 2020 Hisilicon Limited.
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
+#include "non-standard-hisilicon.h"
+
+#define HISI_BUF_LEN	2048
+
+struct hisi_common_error_section {
+	uint32_t   val_bits;
+	uint8_t    version;
+	uint8_t    soc_id;
+	uint8_t    socket_id;
+	uint8_t    totem_id;
+	uint8_t    nimbus_id;
+	uint8_t    subsystem_id;
+	uint8_t    module_id;
+	uint8_t    submodule_id;
+	uint8_t    core_id;
+	uint8_t    port_id;
+	uint16_t   err_type;
+	struct {
+		uint8_t  function;
+		uint8_t  device;
+		uint16_t segment;
+		uint8_t  bus;
+		uint8_t  reserved[3];
+	}          pcie_info;
+	uint8_t    err_severity;
+	uint8_t    reserved[3];
+	uint32_t   reg_array_size;
+	uint32_t   reg_array[];
+};
+
+enum {
+	HISI_COMMON_VALID_SOC_ID,
+	HISI_COMMON_VALID_SOCKET_ID,
+	HISI_COMMON_VALID_TOTEM_ID,
+	HISI_COMMON_VALID_NIMBUS_ID,
+	HISI_COMMON_VALID_SUBSYSTEM_ID,
+	HISI_COMMON_VALID_MODULE_ID,
+	HISI_COMMON_VALID_SUBMODULE_ID,
+	HISI_COMMON_VALID_CORE_ID,
+	HISI_COMMON_VALID_PORT_ID,
+	HISI_COMMON_VALID_ERR_TYPE,
+	HISI_COMMON_VALID_PCIE_INFO,
+	HISI_COMMON_VALID_ERR_SEVERITY,
+	HISI_COMMON_VALID_REG_ARRAY_SIZE,
+};
+
+enum {
+	HISI_COMMON_FIELD_ID,
+	HISI_COMMON_FIELD_TIMESTAMP,
+	HISI_COMMON_FIELD_ERR_INFO,
+	HISI_COMMON_FIELD_REGS_DUMP,
+};
+
+struct hisi_event {
+	char error_msg[HISI_BUF_LEN];
+	char reg_msg[HISI_BUF_LEN];
+};
+
+#ifdef HAVE_SQLITE3
+void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+			       enum hisi_oem_data_type data_type,
+			       int id, int64_t data, const char *text)
+{
+	switch (data_type) {
+	case HISI_OEM_DATA_TYPE_INT:
+		sqlite3_bind_int(dec_tab->stmt_dec_record, id, data);
+		break;
+	case HISI_OEM_DATA_TYPE_INT64:
+		sqlite3_bind_int64(dec_tab->stmt_dec_record, id, data);
+		break;
+	case HISI_OEM_DATA_TYPE_TEXT:
+		sqlite3_bind_text(dec_tab->stmt_dec_record, id, text, -1, NULL);
+		break;
+	}
+}
+
+int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name)
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
+void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+			enum hisi_oem_data_type data_type,
+			int id, int64_t data, const char *text)
+{ }
+
+int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name)
+{
+	return 0;
+}
+#endif
+
+#ifdef HAVE_SQLITE3
+static const struct db_fields hisi_common_section_fields[] = {
+	{ .name = "id",                 .type = "INTEGER PRIMARY KEY" },
+	{ .name = "timestamp",          .type = "TEXT" },
+	{ .name = "err_info",		.type = "TEXT" },
+	{ .name = "regs_dump",		.type = "TEXT" },
+};
+
+static const struct db_table_descriptor hisi_common_section_tab = {
+	.name = "hisi_common_section",
+	.fields = hisi_common_section_fields,
+	.num_fields = ARRAY_SIZE(hisi_common_section_fields),
+};
+#endif
+
+static const char* soc_desc[] = {
+	"Kunpeng916",
+	"Kunpeng920",
+	"Kunpeng930",
+};
+
+static const char* module_name[] = {
+	"MN",
+	"PLL",
+	"SLLC",
+	"AA",
+	"SIOE",
+	"POE",
+	"CPA",
+	"DISP",
+	"GIC",
+	"ITS",
+	"AVSBUS",
+	"CS",
+	"PPU",
+	"SMMU",
+	"PA",
+	"HLLC",
+	"DDRC",
+	"L3TAG",
+	"L3DATA",
+	"PCS",
+	"MATA",
+	"PCIe Local",
+	"SAS",
+	"SATA",
+	"NIC",
+	"RoCE",
+	"USB",
+	"ZIP",
+	"HPRE",
+	"SEC",
+	"RDE",
+	"MEE",
+	"HHA",
+};
+
+static const char* get_soc_desc(uint8_t soc_id)
+{
+	if (soc_id >= sizeof(soc_desc)/sizeof(char *))
+		return "unknown";
+
+	return soc_desc[soc_id];
+}
+
+static void decode_module(struct hisi_event *event, uint8_t module_id)
+{
+	if (module_id >= sizeof(module_name)/sizeof(char *))
+		HISI_SNPRINTF(event->error_msg, "module=unknown(id=%d) ", module_id);
+	else
+		HISI_SNPRINTF(event->error_msg, "module=%s ", module_name[module_id]);
+}
+
+static void decode_hisi_common_section_hdr(struct ras_ns_dec_tab *dec_tab,
+					  const struct hisi_common_error_section *err,
+					  struct hisi_event *event)
+{
+	HISI_SNPRINTF(event->error_msg, "[ table_version=%d", err->version);
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SOC_ID))
+		HISI_SNPRINTF(event->error_msg, "soc=%s", get_soc_desc(err->soc_id));
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SOCKET_ID))
+		HISI_SNPRINTF(event->error_msg, "socket_id=%d", err->socket_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_TOTEM_ID))
+		HISI_SNPRINTF(event->error_msg, "totem_id=%d", err->totem_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_NIMBUS_ID))
+		HISI_SNPRINTF(event->error_msg, "nimbus_id=%d", err->nimbus_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBSYSTEM_ID))
+		HISI_SNPRINTF(event->error_msg, "subsystem_id=%d", err->subsystem_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_MODULE_ID))
+		decode_module(event, err->module_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_SUBMODULE_ID))
+		HISI_SNPRINTF(event->error_msg, "submodule_id=%d", err->submodule_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_CORE_ID))
+		HISI_SNPRINTF(event->error_msg, "core_id=%d", err->core_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_PORT_ID))
+		HISI_SNPRINTF(event->error_msg, "port_id=%d", err->port_id);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_TYPE))
+		HISI_SNPRINTF(event->error_msg, "err_type=%d", err->err_type);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_PCIE_INFO))
+		HISI_SNPRINTF(event->error_msg, "pcie_device_id=%04x:%02x:%02x.%x",
+			      err->pcie_info.segment, err->pcie_info.bus,
+			      err->pcie_info.device, err->pcie_info.function);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_ERR_SEVERITY))
+		HISI_SNPRINTF(event->error_msg, "err_severity=%s", err_severity(err->err_severity));
+
+	HISI_SNPRINTF(event->error_msg, "]");
+}
+
+static int decode_hisi_common_section(struct ras_events *ras,
+				      struct ras_ns_dec_tab *dec_tab,
+				      struct trace_seq *s,
+				      struct ras_non_standard_event *event)
+{
+	const struct hisi_common_error_section *err =
+			(struct hisi_common_error_section *)event->error;
+	struct hisi_event hevent;
+
+#ifdef HAVE_SQLITE3
+	if (ras->record_events && !dec_tab->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
+				&hisi_common_section_tab) != SQLITE_OK) {
+			trace_seq_printf(s, "create sql hisi_common_section_tab fail\n");
+			return -1;
+		}
+	}
+#endif
+
+	memset(&hevent, 0, sizeof(struct hisi_event));
+	trace_seq_printf(s, "\nHisilicon Common Error Section:\n");
+	decode_hisi_common_section_hdr(dec_tab, err, &hevent);
+	trace_seq_printf(s, "%s\n", hevent.error_msg);
+
+	if (err->val_bits & BIT(HISI_COMMON_VALID_REG_ARRAY_SIZE) && err->reg_array_size > 0) {
+		int i;
+
+		trace_seq_printf(s, "Register Dump:\n");
+		for (i = 0; i < err->reg_array_size / sizeof(uint32_t); i++) {
+			trace_seq_printf(s, "reg%02d=0x%08x\n", i,
+					 err->reg_array[i]);
+			HISI_SNPRINTF(hevent.reg_msg, "reg%02d=0x%08x",
+				      i, err->reg_array[i]);
+		}
+	}
+
+	if (ras->record_events) {
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_TIMESTAMP,
+				   0, event->timestamp);
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_ERR_INFO, 0, hevent.error_msg);
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HISI_COMMON_FIELD_REGS_DUMP, 0, hevent.reg_msg);
+		step_vendor_data_tab(dec_tab, "hisi_common_section_tab");
+	}
+
+	return 0;
+}
+
+struct ras_ns_dec_tab hisi_section_ns_tab[] = {
+	{
+		.sec_type = "c8b328a899174af69a132e08ab2e7586",
+		.decode = decode_hisi_common_section,
+	},
+	{ /* sentinel */ }
+};
+
+static void __attribute__((constructor)) hisi_ns_init(void)
+{
+	register_ns_dec_tab(hisi_section_ns_tab);
+}
diff --git a/non-standard-hisilicon.h b/non-standard-hisilicon.h
new file mode 100644
index 0000000..1ce210a
--- /dev/null
+++ b/non-standard-hisilicon.h
@@ -0,0 +1,49 @@
+/*
+ * Copyright (c) 2020 Hisilicon Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#ifndef __NON_STANDARD_HISILICON_H
+#define __NON_STANDARD_HISILICON_H
+
+#include "ras-non-standard-handler.h"
+#include "ras-mc-handler.h"
+
+#define HISI_SNPRINTF	mce_snprintf
+
+#define HISI_ERR_SEVERITY_NFE	0
+#define HISI_ERR_SEVERITY_FE	1
+#define HISI_ERR_SEVERITY_CE	2
+#define HISI_ERR_SEVERITY_NONE	3
+
+enum hisi_oem_data_type {
+	HISI_OEM_DATA_TYPE_INT,
+	HISI_OEM_DATA_TYPE_INT64,
+	HISI_OEM_DATA_TYPE_TEXT,
+};
+
+/* helper functions */
+static inline char *err_severity(uint8_t err_sev)
+{
+	switch (err_sev) {
+	case HISI_ERR_SEVERITY_NFE: return "recoverable";
+	case HISI_ERR_SEVERITY_FE: return "fatal";
+	case HISI_ERR_SEVERITY_CE: return "corrected";
+	case HISI_ERR_SEVERITY_NONE: return "none";
+	default:
+		break;
+	}
+	return "unknown";
+}
+
+void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+			enum hisi_oem_data_type data_type,
+			int id, int64_t data, const char *text);
+int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name);
+
+#endif
-- 
2.8.1


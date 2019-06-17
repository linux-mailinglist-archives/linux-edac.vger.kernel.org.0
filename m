Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E56F48568
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFQO3s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727738AbfFQO3s (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 28123BE817185209D881;
        Mon, 17 Jun 2019 22:29:44 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:33 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 5/6] rasdaemon:add logging HiSilicon HIP08 H/W errors reported in the OEM format2
Date:   Mon, 17 Jun 2019 15:28:51 +0100
Message-ID: <20190617142852.12140-6-shiju.jose@huawei.com>
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
in the non-standard OEM format2.
These errors are from the H/W modules SMMU, HHA, HLLC, PA and DDRC.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c | 300 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 300 insertions(+)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 240e832..6fe5cbe 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -43,6 +43,20 @@
 #define HISI_OEM_TYPE1_VALID_ERR_MISC_4	BIT(10)
 #define HISI_OEM_TYPE1_VALID_ERR_ADDR	BIT(11)
 
+/* HISI OEM format2 error definitions */
+#define HISI_OEM_MODULE_ID_SMMU	0
+#define HISI_OEM_MODULE_ID_HHA	1
+#define HISI_OEM_MODULE_ID_HLLC	2
+#define HISI_OEM_MODULE_ID_PA	3
+#define HISI_OEM_MODULE_ID_DDRC	4
+
+#define HISI_OEM_TYPE2_VALID_ERR_FR	BIT(6)
+#define HISI_OEM_TYPE2_VALID_ERR_CTRL	BIT(7)
+#define HISI_OEM_TYPE2_VALID_ERR_STATUS	BIT(8)
+#define HISI_OEM_TYPE2_VALID_ERR_ADDR	BIT(9)
+#define HISI_OEM_TYPE2_VALID_ERR_MISC_0	BIT(10)
+#define HISI_OEM_TYPE2_VALID_ERR_MISC_1	BIT(11)
+
 struct hisi_oem_type1_err_sec {
 	uint32_t   val_bits;
 	uint8_t    version;
@@ -61,6 +75,30 @@ struct hisi_oem_type1_err_sec {
 	uint64_t   err_addr;
 };
 
+struct hisi_oem_type2_err_sec {
+	uint32_t   val_bits;
+	uint8_t    version;
+	uint8_t    soc_id;
+	uint8_t    socket_id;
+	uint8_t    nimbus_id;
+	uint8_t    module_id;
+	uint8_t    sub_module_id;
+	uint8_t    err_severity;
+	uint8_t    reserv;
+	uint32_t   err_fr_0;
+	uint32_t   err_fr_1;
+	uint32_t   err_ctrl_0;
+	uint32_t   err_ctrl_1;
+	uint32_t   err_status_0;
+	uint32_t   err_status_1;
+	uint32_t   err_addr_0;
+	uint32_t   err_addr_1;
+	uint32_t   err_misc0_0;
+	uint32_t   err_misc0_1;
+	uint32_t   err_misc1_0;
+	uint32_t   err_misc1_1;
+};
+
 enum hisi_oem_data_type {
 	hisi_oem_data_type_int,
 	hisi_oem_data_type_int64,
@@ -84,6 +122,29 @@ enum {
 	hip08_oem_type1_field_err_addr,
 };
 
+enum {
+	hip08_oem_type2_field_id,
+	hip08_oem_type2_field_version,
+	hip08_oem_type2_field_soc_id,
+	hip08_oem_type2_field_socket_id,
+	hip08_oem_type2_field_nimbus_id,
+	hip08_oem_type2_field_module_id,
+	hip08_oem_type2_field_sub_module_id,
+	hip08_oem_type2_field_err_sev,
+	hip08_oem_type2_field_err_fr_0,
+	hip08_oem_type2_field_err_fr_1,
+	hip08_oem_type2_field_err_ctrl_0,
+	hip08_oem_type2_field_err_ctrl_1,
+	hip08_oem_type2_field_err_status_0,
+	hip08_oem_type2_field_err_status_1,
+	hip08_oem_type2_field_err_addr_0,
+	hip08_oem_type2_field_err_addr_1,
+	hip08_oem_type2_field_err_misc0_0,
+	hip08_oem_type2_field_err_misc0_1,
+	hip08_oem_type2_field_err_misc1_0,
+	hip08_oem_type2_field_err_misc1_1,
+};
+
 /* helper functions */
 static char *err_severity(uint8_t err_sev)
 {
@@ -113,6 +174,62 @@ static char *oem_type1_module_name(uint8_t module_id)
 	return "unknown";
 }
 
+static char *oem_type2_module_name(uint8_t module_id)
+{
+	switch (module_id) {
+	case HISI_OEM_MODULE_ID_SMMU: return "SMMU";
+	case HISI_OEM_MODULE_ID_HHA: return "HHA";
+	case HISI_OEM_MODULE_ID_HLLC: return "HLLC";
+	case HISI_OEM_MODULE_ID_PA: return "PA";
+	case HISI_OEM_MODULE_ID_DDRC: return "DDRC";
+	}
+	return "unknown module";
+}
+
+static char *oem_type2_sub_module_id(char *p, uint8_t module_id,
+				     uint8_t sub_module_id)
+{
+	switch (module_id) {
+	case HISI_OEM_MODULE_ID_SMMU:
+	case HISI_OEM_MODULE_ID_HLLC:
+	case HISI_OEM_MODULE_ID_PA:
+		p += sprintf(p, "%d ", sub_module_id);
+		break;
+
+	case HISI_OEM_MODULE_ID_HHA:
+		if (sub_module_id == 0)
+			p += sprintf(p, "TA HHA0 ");
+		else if (sub_module_id == 1)
+			p += sprintf(p, "TA HHA1 ");
+		else if (sub_module_id == 2)
+			p += sprintf(p, "TB HHA0 ");
+		else if (sub_module_id == 3)
+			p += sprintf(p, "TB HHA1 ");
+		break;
+
+	case HISI_OEM_MODULE_ID_DDRC:
+		if (sub_module_id == 0)
+			p += sprintf(p, "TA DDRC0 ");
+		else if (sub_module_id == 1)
+			p += sprintf(p, "TA DDRC1 ");
+		else if (sub_module_id == 2)
+			p += sprintf(p, "TA DDRC2 ");
+		else if (sub_module_id == 3)
+			p += sprintf(p, "TA DDRC3 ");
+		else if (sub_module_id == 4)
+			p += sprintf(p, "TB DDRC0 ");
+		else if (sub_module_id == 5)
+			p += sprintf(p, "TB DDRC1 ");
+		else if (sub_module_id == 6)
+			p += sprintf(p, "TB DDRC2 ");
+		else if (sub_module_id == 7)
+			p += sprintf(p, "TB DDRC3 ");
+		break;
+	}
+
+	return p;
+}
+
 #ifdef HAVE_SQLITE3
 static const struct db_fields hip08_oem_type1_event_fields[] = {
 	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
@@ -137,6 +254,35 @@ static const struct db_table_descriptor hip08_oem_type1_event_tab = {
 	.num_fields = ARRAY_SIZE(hip08_oem_type1_event_fields),
 };
 
+static const struct db_fields hip08_oem_type2_event_fields[] = {
+	{ .name = "id",                 .type = "INTEGER PRIMARY KEY" },
+	{ .name = "version",            .type = "INTEGER" },
+	{ .name = "soc_id",             .type = "INTEGER" },
+	{ .name = "socket_id",          .type = "INTEGER" },
+	{ .name = "nimbus_id",          .type = "INTEGER" },
+	{ .name = "module_id",          .type = "TEXT" },
+	{ .name = "sub_module_id",      .type = "INTEGER" },
+	{ .name = "err_severity",       .type = "TEXT" },
+	{ .name = "err_fr_0",		.type = "INTEGER" },
+	{ .name = "err_fr_1",		.type = "INTEGER" },
+	{ .name = "err_ctrl_0",		.type = "INTEGER" },
+	{ .name = "err_ctrl_1",		.type = "INTEGER" },
+	{ .name = "err_status_0",	.type = "INTEGER" },
+	{ .name = "err_status_1",	.type = "INTEGER" },
+	{ .name = "err_addr_0",         .type = "INTEGER" },
+	{ .name = "err_addr_1",         .type = "INTEGER" },
+	{ .name = "err_misc0_0",	.type = "INTEGER" },
+	{ .name = "err_misc0_1",	.type = "INTEGER" },
+	{ .name = "err_misc1_0",	.type = "INTEGER" },
+	{ .name = "err_misc1_1",	.type = "INTEGER" },
+};
+
+static const struct db_table_descriptor hip08_oem_type2_event_tab = {
+	.name = "hip08_oem_type2_event",
+	.fields = hip08_oem_type2_event_fields,
+	.num_fields = ARRAY_SIZE(hip08_oem_type2_event_fields),
+};
+
 static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
 			       enum hisi_oem_data_type data_type,
 			       int id, int64_t data, const char *text)
@@ -317,11 +463,165 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	return 0;
 }
 
+static int decode_hip08_oem_type2_error(struct ras_events *ras,
+					struct ras_ns_dec_tab *dec_tab,
+					struct trace_seq *s, const void *error)
+{
+	const struct hisi_oem_type2_err_sec *err = error;
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
+			&hip08_oem_type2_event_tab) != SQLITE_OK) {
+			trace_seq_printf(s,
+				"create sql hip08_oem_type2_event_tab fail\n");
+			return -1;
+		}
+	}
+#endif
+	p += sprintf(p, "[ ");
+	p += sprintf(p, "Table version=%d ", err->version);
+	record_vendor_data(dec_tab, hisi_oem_data_type_int,
+			   hip08_oem_type2_field_version,
+			   err->version, NULL);
+	if (err->val_bits & HISI_OEM_VALID_SOC_ID) {
+		p += sprintf(p, "SOC ID=%d ", err->soc_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_soc_id,
+				   err->soc_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID) {
+		p += sprintf(p, "socket ID=%d ", err->socket_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_socket_id,
+				   err->socket_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID) {
+		p += sprintf(p, "nimbus ID=%d ", err->nimbus_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_nimbus_id,
+				   err->nimbus_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
+		p += sprintf(p, "module=%s ",
+			     oem_type2_module_name(err->module_id));
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_oem_type2_field_module_id,
+				   0, oem_type2_module_name(err->module_id));
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
+		p =  oem_type2_sub_module_id(p, err->module_id,
+					     err->sub_module_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_sub_module_id,
+				   err->sub_module_id, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
+		p += sprintf(p, "error severity=%s ",
+			     err_severity(err->err_severity));
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_oem_type2_field_err_sev,
+				   0, err_severity(err->err_severity));
+	}
+
+	p += sprintf(p, "]");
+	trace_seq_printf(s, "\nHISI HIP08: OEM Type-2 Error\n");
+	trace_seq_printf(s, "%s\n", buf);
+
+	trace_seq_printf(s, "Reg Dump:\n");
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_FR) {
+		trace_seq_printf(s, "ERR_FR_0=0x%x\n", err->err_fr_0);
+		trace_seq_printf(s, "ERR_FR_1=0x%x\n", err->err_fr_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_fr_0,
+				   err->err_fr_0, NULL);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_fr_1,
+				   err->err_fr_1, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_CTRL) {
+		trace_seq_printf(s, "ERR_CTRL_0=0x%x\n", err->err_ctrl_0);
+		trace_seq_printf(s, "ERR_CTRL_1=0x%x\n", err->err_ctrl_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_ctrl_0,
+				   err->err_ctrl_0, NULL);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_ctrl_1,
+				   err->err_ctrl_1, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_STATUS) {
+		trace_seq_printf(s, "ERR_STATUS_0=0x%x\n", err->err_status_0);
+		trace_seq_printf(s, "ERR_STATUS_1=0x%x\n", err->err_status_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_status_0,
+				   err->err_status_0, NULL);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_status_1,
+				   err->err_status_1, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_ADDR) {
+		trace_seq_printf(s, "ERR_ADDR_0=0x%x\n", err->err_addr_0);
+		trace_seq_printf(s, "ERR_ADDR_1=0x%x\n", err->err_addr_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_addr_0,
+				   err->err_addr_0, NULL);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_addr_1,
+				   err->err_addr_1, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_0) {
+		trace_seq_printf(s, "ERR_MISC0_0=0x%x\n", err->err_misc0_0);
+		trace_seq_printf(s, "ERR_MISC0_1=0x%x\n", err->err_misc0_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_misc0_0,
+				   err->err_misc0_0, NULL);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_misc0_1,
+				   err->err_misc0_1, NULL);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_1) {
+		trace_seq_printf(s, "ERR_MISC1_0=0x%x\n", err->err_misc1_0);
+		trace_seq_printf(s, "ERR_MISC1_1=0x%x\n", err->err_misc1_1);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_misc1_0,
+				   err->err_misc1_0, NULL);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_oem_type2_field_err_misc1_1,
+				   err->err_misc1_1, NULL);
+	}
+
+	step_vendor_data_tab(dec_tab, "hip08_oem_type2_event_tab");
+
+	return 0;
+}
+
 struct ras_ns_dec_tab hip08_ns_oem_tab[] = {
 	{
 		.sec_type = "1f8161e155d641e6bd107afd1dc5f7c5",
 		.decode = decode_hip08_oem_type1_error,
 	},
+	{
+		.sec_type = "45534ea6ce2341158535e07ab3aef91d",
+		.decode = decode_hip08_oem_type2_error,
+	},
 	{ /* sentinel */ }
 };
 
-- 
1.9.1



Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A323948567
	for <lists+linux-edac@lfdr.de>; Mon, 17 Jun 2019 16:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfFQO3s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Jun 2019 10:29:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:18593 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726286AbfFQO3s (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 17 Jun 2019 10:29:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2D8B092A176324E8DCA9;
        Mon, 17 Jun 2019 22:29:44 +0800 (CST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.202.226.53) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 17 Jun 2019 22:29:35 +0800
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>,
        <linuxarm@huawei.com>
CC:     Shiju Jose <shiju.jose@huawei.com>
Subject: [PATCH 6/6] rasdaemon:add logging HiSilicon HIP08 PCIe local errors
Date:   Mon, 17 Jun 2019 15:28:52 +0100
Message-ID: <20190617142852.12140-7-shiju.jose@huawei.com>
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

This patch adds logging for the HiSilicon HIP08 PCIe local errors.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c | 223 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 6fe5cbe..ae543d6 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -57,6 +57,24 @@
 #define HISI_OEM_TYPE2_VALID_ERR_MISC_0	BIT(10)
 #define HISI_OEM_TYPE2_VALID_ERR_MISC_1	BIT(11)
 
+/* HISI PCIe Local error definitions */
+#define HISI_PCIE_SUB_MODULE_ID_AP	0
+#define HISI_PCIE_SUB_MODULE_ID_TL	1
+#define HISI_PCIE_SUB_MODULE_ID_MAC	2
+#define HISI_PCIE_SUB_MODULE_ID_DL	3
+#define HISI_PCIE_SUB_MODULE_ID_SDI	4
+
+#define HISI_PCIE_LOCAL_VALID_VERSION		BIT(0)
+#define HISI_PCIE_LOCAL_VALID_SOC_ID		BIT(1)
+#define HISI_PCIE_LOCAL_VALID_SOCKET_ID		BIT(2)
+#define HISI_PCIE_LOCAL_VALID_NIMBUS_ID		BIT(3)
+#define HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID	BIT(4)
+#define HISI_PCIE_LOCAL_VALID_CORE_ID		BIT(5)
+#define HISI_PCIE_LOCAL_VALID_PORT_ID		BIT(6)
+#define HISI_PCIE_LOCAL_VALID_ERR_TYPE		BIT(7)
+#define HISI_PCIE_LOCAL_VALID_ERR_SEVERITY	BIT(8)
+#define HISI_PCIE_LOCAL_VALID_ERR_MISC		9
+
 struct hisi_oem_type1_err_sec {
 	uint32_t   val_bits;
 	uint8_t    version;
@@ -99,6 +117,21 @@ struct hisi_oem_type2_err_sec {
 	uint32_t   err_misc1_1;
 };
 
+struct hisi_pcie_local_err_sec {
+	uint64_t   val_bits;
+	uint8_t    version;
+	uint8_t    soc_id;
+	uint8_t    socket_id;
+	uint8_t    nimbus_id;
+	uint8_t    sub_module_id;
+	uint8_t    core_id;
+	uint8_t    port_id;
+	uint8_t    err_severity;
+	uint16_t   err_type;
+	uint8_t    reserv[2];
+	uint32_t   err_misc[33];
+};
+
 enum hisi_oem_data_type {
 	hisi_oem_data_type_int,
 	hisi_oem_data_type_int64,
@@ -145,6 +178,20 @@ enum {
 	hip08_oem_type2_field_err_misc1_1,
 };
 
+enum {
+	hip08_pcie_local_field_id,
+	hip08_pcie_local_field_version,
+	hip08_pcie_local_field_soc_id,
+	hip08_pcie_local_field_socket_id,
+	hip08_pcie_local_field_nimbus_id,
+	hip08_pcie_local_field_sub_module_id,
+	hip08_pcie_local_field_core_id,
+	hip08_pcie_local_field_port_id,
+	hip08_pcie_local_field_err_sev,
+	hip08_pcie_local_field_err_type,
+	hip08_pcie_local_field_err_misc,
+};
+
 /* helper functions */
 static char *err_severity(uint8_t err_sev)
 {
@@ -230,6 +277,18 @@ static char *oem_type2_sub_module_id(char *p, uint8_t module_id,
 	return p;
 }
 
+static char *pcie_local_sub_module_name(uint8_t id)
+{
+	switch (id) {
+	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
+	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
+	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
+	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
+	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
+	}
+	return "unknown";
+}
+
 #ifdef HAVE_SQLITE3
 static const struct db_fields hip08_oem_type1_event_fields[] = {
 	{ .name = "id",			.type = "INTEGER PRIMARY KEY" },
@@ -283,6 +342,58 @@ static const struct db_table_descriptor hip08_oem_type2_event_tab = {
 	.num_fields = ARRAY_SIZE(hip08_oem_type2_event_fields),
 };
 
+static const struct db_fields hip08_pcie_local_event_fields[] = {
+	{ .name = "id",                 .type = "INTEGER PRIMARY KEY" },
+	{ .name = "version",            .type = "INTEGER" },
+	{ .name = "soc_id",             .type = "INTEGER" },
+	{ .name = "socket_id",          .type = "INTEGER" },
+	{ .name = "nimbus_id",          .type = "INTEGER" },
+	{ .name = "sub_module_id",      .type = "TEXT" },
+	{ .name = "core_id",		.type = "INTEGER" },
+	{ .name = "port_id",		.type = "INTEGER" },
+	{ .name = "err_severity",       .type = "TEXT" },
+	{ .name = "err_type",		.type = "INTEGER" },
+	{ .name = "err_misc0",		.type = "INTEGER" },
+	{ .name = "err_misc1",		.type = "INTEGER" },
+	{ .name = "err_misc2",		.type = "INTEGER" },
+	{ .name = "err_misc3",		.type = "INTEGER" },
+	{ .name = "err_misc4",		.type = "INTEGER" },
+	{ .name = "err_misc5",		.type = "INTEGER" },
+	{ .name = "err_misc6",		.type = "INTEGER" },
+	{ .name = "err_misc7",		.type = "INTEGER" },
+	{ .name = "err_misc8",		.type = "INTEGER" },
+	{ .name = "err_misc9",		.type = "INTEGER" },
+	{ .name = "err_misc10",		.type = "INTEGER" },
+	{ .name = "err_misc11",		.type = "INTEGER" },
+	{ .name = "err_misc12",		.type = "INTEGER" },
+	{ .name = "err_misc13",		.type = "INTEGER" },
+	{ .name = "err_misc14",		.type = "INTEGER" },
+	{ .name = "err_misc15",		.type = "INTEGER" },
+	{ .name = "err_misc16",		.type = "INTEGER" },
+	{ .name = "err_misc17",		.type = "INTEGER" },
+	{ .name = "err_misc18",		.type = "INTEGER" },
+	{ .name = "err_misc19",		.type = "INTEGER" },
+	{ .name = "err_misc20",		.type = "INTEGER" },
+	{ .name = "err_misc21",		.type = "INTEGER" },
+	{ .name = "err_misc22",		.type = "INTEGER" },
+	{ .name = "err_misc23",		.type = "INTEGER" },
+	{ .name = "err_misc24",		.type = "INTEGER" },
+	{ .name = "err_misc25",		.type = "INTEGER" },
+	{ .name = "err_misc26",		.type = "INTEGER" },
+	{ .name = "err_misc27",		.type = "INTEGER" },
+	{ .name = "err_misc28",		.type = "INTEGER" },
+	{ .name = "err_misc29",		.type = "INTEGER" },
+	{ .name = "err_misc30",		.type = "INTEGER" },
+	{ .name = "err_misc31",		.type = "INTEGER" },
+	{ .name = "err_misc32",		.type = "INTEGER" },
+};
+
+static const struct db_table_descriptor hip08_pcie_local_event_tab = {
+	.name = "hip08_pcie_local_event",
+	.fields = hip08_pcie_local_event_fields,
+	.num_fields = ARRAY_SIZE(hip08_pcie_local_event_fields),
+};
+
 static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
 			       enum hisi_oem_data_type data_type,
 			       int id, int64_t data, const char *text)
@@ -613,6 +724,114 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	return 0;
 }
 
+static int decode_hip08_pcie_local_error(struct ras_events *ras,
+					 struct ras_ns_dec_tab *dec_tab,
+					 struct trace_seq *s, const void *error)
+{
+	const struct hisi_pcie_local_err_sec *err = error;
+	char buf[1024];
+	char *p = buf;
+	uint32_t i;
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
+				&hip08_pcie_local_event_tab) != SQLITE_OK) {
+			trace_seq_printf(s,
+				"create sql hip08_pcie_local_event_tab fail\n");
+			return -1;
+		}
+	}
+#endif
+	p += sprintf(p, "[ ");
+	p += sprintf(p, "Table version=%d ", err->version);
+	record_vendor_data(dec_tab, hisi_oem_data_type_int,
+			   hip08_pcie_local_field_version,
+			   err->version, NULL);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID) {
+		p += sprintf(p, "SOC ID=%d ", err->soc_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_pcie_local_field_soc_id,
+				   err->soc_id, NULL);
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID) {
+		p += sprintf(p, "socket ID=%d ", err->socket_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_pcie_local_field_socket_id,
+				   err->socket_id, NULL);
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID) {
+		p += sprintf(p, "nimbus ID=%d ", err->nimbus_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_pcie_local_field_nimbus_id,
+				   err->nimbus_id, NULL);
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID) {
+		p += sprintf(p, "sub module=%s ",
+			     pcie_local_sub_module_name(err->sub_module_id));
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_pcie_local_field_sub_module_id,
+				   0, pcie_local_sub_module_name(err->sub_module_id));
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID) {
+		p += sprintf(p, "core ID=core%d ", err->core_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_pcie_local_field_core_id,
+				   err->core_id, NULL);
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID) {
+		p += sprintf(p, "port ID=port%d ", err->port_id);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_pcie_local_field_port_id,
+				   err->port_id, NULL);
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY) {
+		p += sprintf(p, "error severity=%s ",
+			     err_severity(err->err_severity));
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_pcie_local_field_err_sev,
+				   0, err_severity(err->err_severity));
+	}
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE) {
+		p += sprintf(p, "error type=0x%x ", err->err_type);
+		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+				   hip08_pcie_local_field_err_type,
+				   err->err_type, NULL);
+	}
+	p += sprintf(p, "]");
+
+	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
+	trace_seq_printf(s, "%s\n", buf);
+
+	trace_seq_printf(s, "Reg Dump:\n");
+	for (i = 0; i < 33; i++) {
+		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i)) {
+			trace_seq_printf(s, "ERR_MISC_%d=0x%x\n", i,
+					 err->err_misc[i]);
+			record_vendor_data(dec_tab, hisi_oem_data_type_int,
+					   (hip08_pcie_local_field_err_misc + i),
+					   err->err_misc[i], NULL);
+		}
+	}
+
+	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
+
+	return 0;
+}
+
 struct ras_ns_dec_tab hip08_ns_oem_tab[] = {
 	{
 		.sec_type = "1f8161e155d641e6bd107afd1dc5f7c5",
@@ -622,6 +841,10 @@ struct ras_ns_dec_tab hip08_ns_oem_tab[] = {
 		.sec_type = "45534ea6ce2341158535e07ab3aef91d",
 		.decode = decode_hip08_oem_type2_error,
 	},
+	{
+		.sec_type = "b2889fc9e7d74f9da867af42e98be772",
+		.decode = decode_hip08_pcie_local_error,
+	},
 	{ /* sentinel */ }
 };
 
-- 
1.9.1



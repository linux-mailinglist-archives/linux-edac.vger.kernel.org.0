Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AB9CFA2C
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 14:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbfJHMl6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 08:41:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36700 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730605AbfJHMl6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 08:41:58 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3E56188A22D7603D3A75;
        Tue,  8 Oct 2019 20:41:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 20:41:43 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 1/5] rasdaemon: optimize sqlite3 DB record of register fields for hip08
Date:   Tue, 8 Oct 2019 20:38:54 +0800
Message-ID: <1570538338-230884-2-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
References: <1570538338-230884-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Optimize sqlite3 DB record of register fields for hip08 by combining
all register fields to one text field, which will include register name.
This will make the record easier to read.

For example, from:
INSERT INTO hip08_oem_type2_event VALUES(1,1,1,0,0,'SMMU',2,'corrected',
273058,0,-1,0,1308622858,0,0,0,0,133,0,0,NULL);

change to:
INSERT INTO hip08_oem_type2_event VALUES(1,1,1,0,0,'SMMU',2,'corrected',
'ERR_FR_0=0x42aa2 ERR_FR_1=0x0 ERR_CTRL_0=0xffffffff ERR_CTRL_1=0x0
ERR_STATUS_0=0x4e00000a ERR_STATUS_1=0x0 ERR_ADDR_0=0x0, ERR_ADDR_1=0x0
ERR_MISC0_0=0x0 ERR_MISC0_1=0x90 ERR_MISC1_0=0x0 ERR_MISC1_1=0x0');

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 167 +++++++++++-----------------------------------
 1 file changed, 40 insertions(+), 127 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index ae543d6..393053d 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -147,12 +147,7 @@ enum {
 	hip08_oem_type1_field_module_id,
 	hip08_oem_type1_field_sub_module_id,
 	hip08_oem_type1_field_err_sev,
-	hip08_oem_type1_field_err_misc_0,
-	hip08_oem_type1_field_err_misc_1,
-	hip08_oem_type1_field_err_misc_2,
-	hip08_oem_type1_field_err_misc_3,
-	hip08_oem_type1_field_err_misc_4,
-	hip08_oem_type1_field_err_addr,
+	hip08_oem_type1_field_regs_dump,
 };
 
 enum {
@@ -164,18 +159,7 @@ enum {
 	hip08_oem_type2_field_module_id,
 	hip08_oem_type2_field_sub_module_id,
 	hip08_oem_type2_field_err_sev,
-	hip08_oem_type2_field_err_fr_0,
-	hip08_oem_type2_field_err_fr_1,
-	hip08_oem_type2_field_err_ctrl_0,
-	hip08_oem_type2_field_err_ctrl_1,
-	hip08_oem_type2_field_err_status_0,
-	hip08_oem_type2_field_err_status_1,
-	hip08_oem_type2_field_err_addr_0,
-	hip08_oem_type2_field_err_addr_1,
-	hip08_oem_type2_field_err_misc0_0,
-	hip08_oem_type2_field_err_misc0_1,
-	hip08_oem_type2_field_err_misc1_0,
-	hip08_oem_type2_field_err_misc1_1,
+	hip08_oem_type2_field_regs_dump,
 };
 
 enum {
@@ -189,7 +173,7 @@ enum {
 	hip08_pcie_local_field_port_id,
 	hip08_pcie_local_field_err_sev,
 	hip08_pcie_local_field_err_type,
-	hip08_pcie_local_field_err_misc,
+	hip08_pcie_local_field_regs_dump,
 };
 
 /* helper functions */
@@ -299,12 +283,7 @@ static const struct db_fields hip08_oem_type1_event_fields[] = {
 	{ .name = "module_id",		.type = "TEXT" },
 	{ .name = "sub_module_id",	.type = "INTEGER" },
 	{ .name = "err_severity",	.type = "TEXT" },
-	{ .name = "err_misc_0",		.type = "INTEGER" },
-	{ .name = "err_misc_1",		.type = "INTEGER" },
-	{ .name = "err_misc_2",		.type = "INTEGER" },
-	{ .name = "err_misc_3",		.type = "INTEGER" },
-	{ .name = "err_misc_4",		.type = "INTEGER" },
-	{ .name = "err_addr",		.type = "INTEGER" },
+	{ .name = "regs_dump",		.type = "TEXT" },
 };
 
 static const struct db_table_descriptor hip08_oem_type1_event_tab = {
@@ -322,18 +301,7 @@ static const struct db_fields hip08_oem_type2_event_fields[] = {
 	{ .name = "module_id",          .type = "TEXT" },
 	{ .name = "sub_module_id",      .type = "INTEGER" },
 	{ .name = "err_severity",       .type = "TEXT" },
-	{ .name = "err_fr_0",		.type = "INTEGER" },
-	{ .name = "err_fr_1",		.type = "INTEGER" },
-	{ .name = "err_ctrl_0",		.type = "INTEGER" },
-	{ .name = "err_ctrl_1",		.type = "INTEGER" },
-	{ .name = "err_status_0",	.type = "INTEGER" },
-	{ .name = "err_status_1",	.type = "INTEGER" },
-	{ .name = "err_addr_0",         .type = "INTEGER" },
-	{ .name = "err_addr_1",         .type = "INTEGER" },
-	{ .name = "err_misc0_0",	.type = "INTEGER" },
-	{ .name = "err_misc0_1",	.type = "INTEGER" },
-	{ .name = "err_misc1_0",	.type = "INTEGER" },
-	{ .name = "err_misc1_1",	.type = "INTEGER" },
+	{ .name = "regs_dump",		.type = "TEXT" },
 };
 
 static const struct db_table_descriptor hip08_oem_type2_event_tab = {
@@ -353,39 +321,7 @@ static const struct db_fields hip08_pcie_local_event_fields[] = {
 	{ .name = "port_id",		.type = "INTEGER" },
 	{ .name = "err_severity",       .type = "TEXT" },
 	{ .name = "err_type",		.type = "INTEGER" },
-	{ .name = "err_misc0",		.type = "INTEGER" },
-	{ .name = "err_misc1",		.type = "INTEGER" },
-	{ .name = "err_misc2",		.type = "INTEGER" },
-	{ .name = "err_misc3",		.type = "INTEGER" },
-	{ .name = "err_misc4",		.type = "INTEGER" },
-	{ .name = "err_misc5",		.type = "INTEGER" },
-	{ .name = "err_misc6",		.type = "INTEGER" },
-	{ .name = "err_misc7",		.type = "INTEGER" },
-	{ .name = "err_misc8",		.type = "INTEGER" },
-	{ .name = "err_misc9",		.type = "INTEGER" },
-	{ .name = "err_misc10",		.type = "INTEGER" },
-	{ .name = "err_misc11",		.type = "INTEGER" },
-	{ .name = "err_misc12",		.type = "INTEGER" },
-	{ .name = "err_misc13",		.type = "INTEGER" },
-	{ .name = "err_misc14",		.type = "INTEGER" },
-	{ .name = "err_misc15",		.type = "INTEGER" },
-	{ .name = "err_misc16",		.type = "INTEGER" },
-	{ .name = "err_misc17",		.type = "INTEGER" },
-	{ .name = "err_misc18",		.type = "INTEGER" },
-	{ .name = "err_misc19",		.type = "INTEGER" },
-	{ .name = "err_misc20",		.type = "INTEGER" },
-	{ .name = "err_misc21",		.type = "INTEGER" },
-	{ .name = "err_misc22",		.type = "INTEGER" },
-	{ .name = "err_misc23",		.type = "INTEGER" },
-	{ .name = "err_misc24",		.type = "INTEGER" },
-	{ .name = "err_misc25",		.type = "INTEGER" },
-	{ .name = "err_misc26",		.type = "INTEGER" },
-	{ .name = "err_misc27",		.type = "INTEGER" },
-	{ .name = "err_misc28",		.type = "INTEGER" },
-	{ .name = "err_misc29",		.type = "INTEGER" },
-	{ .name = "err_misc30",		.type = "INTEGER" },
-	{ .name = "err_misc31",		.type = "INTEGER" },
-	{ .name = "err_misc32",		.type = "INTEGER" },
+	{ .name = "regs_dump",		.type = "TEXT" },
 };
 
 static const struct db_table_descriptor hip08_pcie_local_event_tab = {
@@ -526,49 +462,42 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
 	trace_seq_printf(s, "%s\n", buf);
 
+	p = buf;
 	trace_seq_printf(s, "Reg Dump:\n");
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_0) {
 		trace_seq_printf(s, "ERR_MISC0=0x%x\n", err->err_misc_0);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_err_misc_0,
-				   err->err_misc_0, NULL);
+		p += sprintf(p, "ERR_MISC0=0x%x ", err->err_misc_0);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_1) {
 		trace_seq_printf(s, "ERR_MISC1=0x%x\n", err->err_misc_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_err_misc_1,
-				   err->err_misc_1, NULL);
+		p += sprintf(p, "ERR_MISC1=0x%x ", err->err_misc_1);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_2) {
 		trace_seq_printf(s, "ERR_MISC2=0x%x\n", err->err_misc_2);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_err_misc_2,
-				   err->err_misc_2, NULL);
+		p += sprintf(p, "ERR_MISC2=0x%x ", err->err_misc_2);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_3) {
 		trace_seq_printf(s, "ERR_MISC3=0x%x\n", err->err_misc_3);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_err_misc_3,
-				   err->err_misc_3, NULL);
+		p += sprintf(p, "ERR_MISC3=0x%x ", err->err_misc_3);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_4) {
 		trace_seq_printf(s, "ERR_MISC4=0x%x\n", err->err_misc_4);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_err_misc_4,
-				   err->err_misc_4, NULL);
+		p += sprintf(p, "ERR_MISC4=0x%x ", err->err_misc_4);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_ADDR) {
 		trace_seq_printf(s, "ERR_ADDR=0x%p\n", (void *)err->err_addr);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int64,
-				   hip08_oem_type1_field_err_addr,
-				   err->err_addr, NULL);
+		p += sprintf(p, "ERR_ADDR=0x%p ", (void *)err->err_addr);
 	}
 
+	*(--p) = '\0';
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_oem_type1_field_regs_dump, 0, buf);
+
 	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
 
 	return 0;
@@ -652,73 +581,54 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-2 Error\n");
 	trace_seq_printf(s, "%s\n", buf);
 
+	p = buf;
 	trace_seq_printf(s, "Reg Dump:\n");
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_FR) {
 		trace_seq_printf(s, "ERR_FR_0=0x%x\n", err->err_fr_0);
 		trace_seq_printf(s, "ERR_FR_1=0x%x\n", err->err_fr_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_fr_0,
-				   err->err_fr_0, NULL);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_fr_1,
-				   err->err_fr_1, NULL);
+		p += sprintf(p, "ERR_FR_0=0x%x ERR_FR_1=0x%x ",
+			     err->err_fr_0, err->err_fr_1);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_CTRL) {
 		trace_seq_printf(s, "ERR_CTRL_0=0x%x\n", err->err_ctrl_0);
 		trace_seq_printf(s, "ERR_CTRL_1=0x%x\n", err->err_ctrl_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_ctrl_0,
-				   err->err_ctrl_0, NULL);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_ctrl_1,
-				   err->err_ctrl_1, NULL);
+		p += sprintf(p, "ERR_CTRL_0=0x%x ERR_CTRL_1=0x%x ",
+				err->err_ctrl_0, err->err_ctrl_1);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_STATUS) {
 		trace_seq_printf(s, "ERR_STATUS_0=0x%x\n", err->err_status_0);
 		trace_seq_printf(s, "ERR_STATUS_1=0x%x\n", err->err_status_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_status_0,
-				   err->err_status_0, NULL);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_status_1,
-				   err->err_status_1, NULL);
+		p += sprintf(p, "ERR_STATUS_0=0x%x ERR_STATUS_1=0x%x ",
+			     err->err_status_0, err->err_status_1);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_ADDR) {
 		trace_seq_printf(s, "ERR_ADDR_0=0x%x\n", err->err_addr_0);
 		trace_seq_printf(s, "ERR_ADDR_1=0x%x\n", err->err_addr_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_addr_0,
-				   err->err_addr_0, NULL);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_addr_1,
-				   err->err_addr_1, NULL);
+		p += sprintf(p, "ERR_ADDR_0=0x%x ERR_ADDR_1=0x%x ",
+			     err->err_addr_0, err->err_addr_1);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_0) {
 		trace_seq_printf(s, "ERR_MISC0_0=0x%x\n", err->err_misc0_0);
 		trace_seq_printf(s, "ERR_MISC0_1=0x%x\n", err->err_misc0_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_misc0_0,
-				   err->err_misc0_0, NULL);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_misc0_1,
-				   err->err_misc0_1, NULL);
+		p += sprintf(p, "ERR_MISC0_0=0x%x ERR_MISC0_1=0x%x ",
+			     err->err_misc0_0, err->err_misc0_1);
 	}
 
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_1) {
 		trace_seq_printf(s, "ERR_MISC1_0=0x%x\n", err->err_misc1_0);
 		trace_seq_printf(s, "ERR_MISC1_1=0x%x\n", err->err_misc1_1);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_misc1_0,
-				   err->err_misc1_0, NULL);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_err_misc1_1,
-				   err->err_misc1_1, NULL);
+		p += sprintf(p, "ERR_MISC1_0=0x%x ERR_MISC1_1=0x%x ",
+			     err->err_misc1_0, err->err_misc1_1);
 	}
 
+	*(--p) = '\0';
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_oem_type2_field_regs_dump, 0, buf);
+
 	step_vendor_data_tab(dec_tab, "hip08_oem_type2_event_tab");
 
 	return 0;
@@ -816,17 +726,20 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
 	trace_seq_printf(s, "%s\n", buf);
 
+	p = buf;
 	trace_seq_printf(s, "Reg Dump:\n");
 	for (i = 0; i < 33; i++) {
 		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i)) {
 			trace_seq_printf(s, "ERR_MISC_%d=0x%x\n", i,
 					 err->err_misc[i]);
-			record_vendor_data(dec_tab, hisi_oem_data_type_int,
-					   (hip08_pcie_local_field_err_misc + i),
-					   err->err_misc[i], NULL);
+			p += sprintf(p, "ERR_MISC_%d=0x%x ", i, err->err_misc[i]);
 		}
 	}
 
+	*(--p) = '\0';
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_pcie_local_field_regs_dump, 0, buf);
+
 	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
 
 	return 0;
-- 
2.8.1


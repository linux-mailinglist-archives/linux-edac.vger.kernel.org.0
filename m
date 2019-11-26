Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBD78109DB4
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfKZMQS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbfKZMQS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:18 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB5406C95EF24758A7F3;
        Tue, 26 Nov 2019 20:16:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:52 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 7/9] rasdaemon: replace sprintf with snprintf for hip08
Date:   Tue, 26 Nov 2019 20:12:34 +0800
Message-ID: <1574770356-129510-8-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
References: <1574770356-129510-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace sprintf with snprintf for hip08 to improve reliability.
Besides, add border check for buffer pointer.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 227 ++++++++++++++++++++++++++++------------------
 1 file changed, 137 insertions(+), 90 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index dfb3e51..3ac5a70 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -569,69 +569,74 @@ static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
 }
 #endif
 
+#define IN_RANGE(p, start, end) ((p) >= (start) && (p) < (end))
 static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 				     struct trace_seq *s,
 				     const struct hisi_oem_type1_err_sec *err)
 {
 	char buf[HISI_BUF_LEN];
 	char *p = buf;
+	char *end = buf + HISI_BUF_LEN;
 
-	p += sprintf(p, "[ ");
-	p += sprintf(p, "table_version=%d ", err->version);
+	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
 			   hip08_oem_type1_field_version, err->version, NULL);
 
-	if (err->val_bits & HISI_OEM_VALID_SOC_ID) {
-		p += sprintf(p, "SOC_ID=%d ", err->soc_id);
+	if (err->val_bits & HISI_OEM_VALID_SOC_ID && IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type1_field_soc_id,
 				   err->soc_id, NULL);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID) {
-		p += sprintf(p, "socket_ID=%d ", err->socket_id);
+	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID && IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type1_field_socket_id,
 				   err->socket_id, NULL);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID) {
-		p += sprintf(p, "nimbus_ID=%d ", err->nimbus_id);
+	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID && IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type1_field_nimbus_id,
 				   err->nimbus_id, NULL);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
+	if (err->val_bits & HISI_OEM_VALID_MODULE_ID && IN_RANGE(p, buf, end)) {
 		const char *str = oem_module_name(hisi_oem_type1_module,
 						  err->module_id);
 
-		p += sprintf(p, "module=%s ", str);
+		p += snprintf(p, end - p, "module=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_module_id,
 				   0, str);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
+	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID &&
+	    IN_RANGE(p, buf, end)) {
 		const char *str = oem_submodule_name(hisi_oem_type1_module,
 						     err->module_id,
 						     err->sub_module_id);
 
-		p += sprintf(p, "submodule=%s ", str);
+		p += snprintf(p, end - p, "submodule=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_sub_module_id,
 				   0, str);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
-		p += sprintf(p, "error_severity=%s ",
+	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "error_severity=%s ",
 			     err_severity(err->err_severity));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_err_sev,
 				   0, err_severity(err->err_severity));
 	}
 
-	p += sprintf(p, "]");
+	if (IN_RANGE(p, buf, end))
+		p += snprintf(p, end - p, "]");
+
 	trace_seq_printf(s, "%s\n", buf);
 }
 
@@ -641,42 +646,53 @@ static void decode_oem_type1_err_regs(struct ras_ns_dec_tab *dec_tab,
 {
 	char buf[HISI_BUF_LEN];
 	char *p = buf;
+	char *end = buf + HISI_BUF_LEN;
 
 	trace_seq_printf(s, "Reg Dump:\n");
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_0) {
 		trace_seq_printf(s, "ERR_MISC0=0x%x\n", err->err_misc_0);
-		p += sprintf(p, "ERR_MISC0=0x%x ", err->err_misc_0);
+		p += snprintf(p, end - p, "ERR_MISC0=0x%x ", err->err_misc_0);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_1) {
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_1 &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_MISC1=0x%x\n", err->err_misc_1);
-		p += sprintf(p, "ERR_MISC1=0x%x ", err->err_misc_1);
+		p += snprintf(p, end - p, "ERR_MISC1=0x%x ", err->err_misc_1);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_2) {
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_2 &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_MISC2=0x%x\n", err->err_misc_2);
-		p += sprintf(p, "ERR_MISC2=0x%x ", err->err_misc_2);
+		p += snprintf(p, end - p, "ERR_MISC2=0x%x ", err->err_misc_2);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_3) {
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_3 &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_MISC3=0x%x\n", err->err_misc_3);
-		p += sprintf(p, "ERR_MISC3=0x%x ", err->err_misc_3);
+		p += snprintf(p, end - p, "ERR_MISC3=0x%x ", err->err_misc_3);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_4) {
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_4 &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_MISC4=0x%x\n", err->err_misc_4);
-		p += sprintf(p, "ERR_MISC4=0x%x ", err->err_misc_4);
+		p += snprintf(p, end - p, "ERR_MISC4=0x%x ", err->err_misc_4);
+	}
+
+	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_ADDR &&
+	    IN_RANGE(p, buf, end)) {
+		trace_seq_printf(s, "ERR_ADDR=0x%llx\n",
+				 (unsigned long long)err->err_addr);
+		p += snprintf(p, end - p, "ERR_ADDR=0x%llx ",
+			     (unsigned long long)err->err_addr);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_ADDR) {
-		trace_seq_printf(s, "ERR_ADDR=0x%p\n", (void *)err->err_addr);
-		p += sprintf(p, "ERR_ADDR=0x%p ", (void *)err->err_addr);
+	if (p > buf && p < end) {
+		p--;
+		*p = '\0';
 	}
 
-	*(--p) = '\0';
 	record_vendor_data(dec_tab, hisi_oem_data_type_text,
 			   hip08_oem_type1_field_regs_dump, 0, buf);
-
 	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
 }
 
@@ -723,62 +739,67 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 {
 	char buf[HISI_BUF_LEN];
 	char *p = buf;
+	char *end = buf + HISI_BUF_LEN;
 
-	p += sprintf(p, "[ ");
-	p += sprintf(p, "table_version=%d ", err->version);
+	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
-			   hip08_oem_type2_field_version,
-			   err->version, NULL);
-	if (err->val_bits & HISI_OEM_VALID_SOC_ID) {
-		p += sprintf(p, "SOC_ID=%d ", err->soc_id);
+			   hip08_oem_type2_field_version, err->version, NULL);
+
+	if (err->val_bits & HISI_OEM_VALID_SOC_ID && IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type2_field_soc_id,
 				   err->soc_id, NULL);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID) {
-		p += sprintf(p, "socket_ID=%d ", err->socket_id);
+	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID && IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type2_field_socket_id,
 				   err->socket_id, NULL);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID) {
-		p += sprintf(p, "nimbus_ID=%d ", err->nimbus_id);
+	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID && IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type2_field_nimbus_id,
 				   err->nimbus_id, NULL);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
+	if (err->val_bits & HISI_OEM_VALID_MODULE_ID && IN_RANGE(p, buf, end)) {
 		const char *str = oem_module_name(hisi_oem_type2_module,
 						  err->module_id);
-		p += sprintf(p, "module=%s ", str);
+
+		p += snprintf(p, end - p, "module=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type2_field_module_id,
 				   0, str);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
+	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID &&
+	    IN_RANGE(p, buf, end)) {
 		const char *str = oem_submodule_name(hisi_oem_type2_module,
 						     err->module_id,
 						     err->sub_module_id);
 
-		p += sprintf(p, "submodule=%s ", str);
+		p += snprintf(p, end - p, "submodule=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type2_field_sub_module_id,
 				   0, str);
 	}
 
-	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
-		p += sprintf(p, "error_severity=%s ",
+	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "error_severity=%s ",
 			     err_severity(err->err_severity));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type2_field_err_sev,
 				   0, err_severity(err->err_severity));
 	}
 
-	p += sprintf(p, "]");
+	if (IN_RANGE(p, buf, end))
+		p += snprintf(p, end - p, "]");
+
 	trace_seq_printf(s, "%s\n", buf);
 }
 
@@ -788,54 +809,63 @@ static void decode_oem_type2_err_regs(struct ras_ns_dec_tab *dec_tab,
 {
 	char buf[HISI_BUF_LEN];
 	char *p = buf;
+	char *end = buf + HISI_BUF_LEN;
 
 	trace_seq_printf(s, "Reg Dump:\n");
 	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_FR) {
 		trace_seq_printf(s, "ERR_FR_0=0x%x\n", err->err_fr_0);
 		trace_seq_printf(s, "ERR_FR_1=0x%x\n", err->err_fr_1);
-		p += sprintf(p, "ERR_FR_0=0x%x ERR_FR_1=0x%x ",
+		p += snprintf(p, end - p, "ERR_FR_0=0x%x ERR_FR_1=0x%x ",
 			     err->err_fr_0, err->err_fr_1);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_CTRL) {
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_CTRL &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_CTRL_0=0x%x\n", err->err_ctrl_0);
 		trace_seq_printf(s, "ERR_CTRL_1=0x%x\n", err->err_ctrl_1);
-		p += sprintf(p, "ERR_CTRL_0=0x%x ERR_CTRL_1=0x%x ",
-				err->err_ctrl_0, err->err_ctrl_1);
+		p += snprintf(p, end - p, "ERR_CTRL_0=0x%x ERR_CTRL_1=0x%x ",
+			      err->err_ctrl_0, err->err_ctrl_1);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_STATUS) {
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_STATUS &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_STATUS_0=0x%x\n", err->err_status_0);
 		trace_seq_printf(s, "ERR_STATUS_1=0x%x\n", err->err_status_1);
-		p += sprintf(p, "ERR_STATUS_0=0x%x ERR_STATUS_1=0x%x ",
-			     err->err_status_0, err->err_status_1);
+		p += snprintf(p, end - p, "ERR_STATUS_0=0x%x ERR_STATUS_1=0x%x ",
+			      err->err_status_0, err->err_status_1);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_ADDR) {
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_ADDR &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_ADDR_0=0x%x\n", err->err_addr_0);
 		trace_seq_printf(s, "ERR_ADDR_1=0x%x\n", err->err_addr_1);
-		p += sprintf(p, "ERR_ADDR_0=0x%x ERR_ADDR_1=0x%x ",
-			     err->err_addr_0, err->err_addr_1);
+		p += snprintf(p, end - p, "ERR_ADDR_0=0x%x ERR_ADDR_1=0x%x ",
+			      err->err_addr_0, err->err_addr_1);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_0) {
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_0 &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_MISC0_0=0x%x\n", err->err_misc0_0);
 		trace_seq_printf(s, "ERR_MISC0_1=0x%x\n", err->err_misc0_1);
-		p += sprintf(p, "ERR_MISC0_0=0x%x ERR_MISC0_1=0x%x ",
-			     err->err_misc0_0, err->err_misc0_1);
+		p += snprintf(p, end - p, "ERR_MISC0_0=0x%x ERR_MISC0_1=0x%x ",
+			      err->err_misc0_0, err->err_misc0_1);
 	}
 
-	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_1) {
+	if (err->val_bits & HISI_OEM_TYPE2_VALID_ERR_MISC_1 &&
+	    IN_RANGE(p, buf, end)) {
 		trace_seq_printf(s, "ERR_MISC1_0=0x%x\n", err->err_misc1_0);
 		trace_seq_printf(s, "ERR_MISC1_1=0x%x\n", err->err_misc1_1);
-		p += sprintf(p, "ERR_MISC1_0=0x%x ERR_MISC1_1=0x%x ",
-			     err->err_misc1_0, err->err_misc1_1);
+		p += snprintf(p, end - p, "ERR_MISC1_0=0x%x ERR_MISC1_1=0x%x ",
+			      err->err_misc1_0, err->err_misc1_1);
+	}
+
+	if (p > buf && p < end) {
+		p--;
+		*p = '\0';
 	}
 
-	*(--p) = '\0';
 	record_vendor_data(dec_tab, hisi_oem_data_type_text,
 			   hip08_oem_type2_field_regs_dump, 0, buf);
-
 	step_vendor_data_tab(dec_tab, "hip08_oem_type2_event_tab");
 }
 
@@ -867,7 +897,6 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 			   hip08_oem_type2_field_timestamp,
 			   0, event->timestamp);
 
-
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-2 Error\n");
 	decode_oem_type2_err_hdr(dec_tab, s, err);
 	decode_oem_type2_err_regs(dec_tab, s, err);
@@ -881,70 +910,82 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 {
 	char buf[HISI_BUF_LEN];
 	char *p = buf;
+	char *end = buf + HISI_BUF_LEN;
 
-	p += sprintf(p, "[ ");
-	p += sprintf(p, "table_version=%d ", err->version);
+	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
 			   hip08_pcie_local_field_version,
 			   err->version, NULL);
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID) {
-		p += sprintf(p, "SOC_ID=%d ", err->soc_id);
+
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_soc_id,
 				   err->soc_id, NULL);
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID) {
-		p += sprintf(p, "socket_ID=%d ", err->socket_id);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_socket_id,
 				   err->socket_id, NULL);
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID) {
-		p += sprintf(p, "nimbus_ID=%d ", err->nimbus_id);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_nimbus_id,
 				   err->nimbus_id, NULL);
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID) {
-		p += sprintf(p, "submodule=%s ",
-			     pcie_local_sub_module_name(err->sub_module_id));
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "submodule=%s ",
+			      pcie_local_sub_module_name(err->sub_module_id));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_pcie_local_field_sub_module_id,
 				   0, pcie_local_sub_module_name(err->sub_module_id));
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID) {
-		p += sprintf(p, "core_ID=core%d ", err->core_id);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "core_ID=core%d ", err->core_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_core_id,
 				   err->core_id, NULL);
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID) {
-		p += sprintf(p, "port_ID=port%d ", err->port_id);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "port_ID=port%d ", err->port_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_port_id,
 				   err->port_id, NULL);
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY) {
-		p += sprintf(p, "error_severity=%s ",
-			     err_severity(err->err_severity));
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "error_severity=%s ",
+			      err_severity(err->err_severity));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_pcie_local_field_err_sev,
 				   0, err_severity(err->err_severity));
 	}
 
-	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE) {
-		p += sprintf(p, "error_type=0x%x ", err->err_type);
+	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE &&
+	    IN_RANGE(p, buf, end)) {
+		p += snprintf(p, end - p, "error_type=0x%x ", err->err_type);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_err_type,
 				   err->err_type, NULL);
 	}
-	p += sprintf(p, "]");
+
+	if (IN_RANGE(p, buf, end))
+		p += snprintf(p, end - p, "]");
+
 	trace_seq_printf(s, "%s\n", buf);
 }
 
@@ -954,21 +995,27 @@ static void decode_pcie_local_err_regs(struct ras_ns_dec_tab *dec_tab,
 {
 	char buf[HISI_BUF_LEN];
 	char *p = buf;
+	char *end = buf + HISI_BUF_LEN;
 	uint32_t i;
 
 	trace_seq_printf(s, "Reg Dump:\n");
 	for (i = 0; i < HISI_PCIE_LOCAL_ERR_MISC_MAX; i++) {
-		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i)) {
+		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i) &&
+		    IN_RANGE(p, buf, end)) {
 			trace_seq_printf(s, "ERR_MISC_%d=0x%x\n", i,
 					 err->err_misc[i]);
-			p += sprintf(p, "ERR_MISC_%d=0x%x ", i, err->err_misc[i]);
+			p += snprintf(p, end - p, "ERR_MISC_%d=0x%x ",
+				      i, err->err_misc[i]);
 		}
 	}
 
-	*(--p) = '\0';
+	if (p > buf && p < end) {
+		p--;
+		*p = '\0';
+	}
+
 	record_vendor_data(dec_tab, hisi_oem_data_type_text,
 			   hip08_pcie_local_field_regs_dump, 0, buf);
-
 	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
 }
 
-- 
2.8.1


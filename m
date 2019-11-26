Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C8109DB2
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbfKZMQG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727717AbfKZMQG (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:06 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E42CC32A04E34E5C5E9D;
        Tue, 26 Nov 2019 20:16:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:53 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 8/9] rasdaemon: fix case style issues for enum constant
Date:   Tue, 26 Nov 2019 20:12:35 +0800
Message-ID: <1574770356-129510-9-git-send-email-tanxiaofei@huawei.com>
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

Change lowercase letters of enum constant to uppercase ones.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 192 +++++++++++++++++++++++-----------------------
 1 file changed, 96 insertions(+), 96 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 3ac5a70..f8f8e1d 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -144,50 +144,50 @@ struct hisi_pcie_local_err_sec {
 };
 
 enum hisi_oem_data_type {
-	hisi_oem_data_type_int,
-	hisi_oem_data_type_int64,
-	hisi_oem_data_type_text,
+	HISI_OEM_DATA_TYPE_INT,
+	HISI_OEM_DATA_TYPE_INT64,
+	HISI_OEM_DATA_TYPE_TEXT,
 };
 
 enum {
-	hip08_oem_type1_field_id,
-	hip08_oem_type1_field_timestamp,
-	hip08_oem_type1_field_version,
-	hip08_oem_type1_field_soc_id,
-	hip08_oem_type1_field_socket_id,
-	hip08_oem_type1_field_nimbus_id,
-	hip08_oem_type1_field_module_id,
-	hip08_oem_type1_field_sub_module_id,
-	hip08_oem_type1_field_err_sev,
-	hip08_oem_type1_field_regs_dump,
+	HIP08_OEM_TYPE1_FIELD_ID,
+	HIP08_OEM_TYPE1_FIELD_TIMESTAMP,
+	HIP08_OEM_TYPE1_FIELD_VERSION,
+	HIP08_OEM_TYPE1_FIELD_SOC_ID,
+	HIP08_OEM_TYPE1_FIELD_SOCKET_ID,
+	HIP08_OEM_TYPE1_FIELD_NIMBUS_ID,
+	HIP08_OEM_TYPE1_FIELD_MODULE_ID,
+	HIP08_OEM_TYPE1_FIELD_SUB_MODULE_ID,
+	HIP08_OEM_TYPE1_FIELD_ERR_SEV,
+	HIP08_OEM_TYPE1_FIELD_REGS_DUMP,
 };
 
 enum {
-	hip08_oem_type2_field_id,
-	hip08_oem_type2_field_timestamp,
-	hip08_oem_type2_field_version,
-	hip08_oem_type2_field_soc_id,
-	hip08_oem_type2_field_socket_id,
-	hip08_oem_type2_field_nimbus_id,
-	hip08_oem_type2_field_module_id,
-	hip08_oem_type2_field_sub_module_id,
-	hip08_oem_type2_field_err_sev,
-	hip08_oem_type2_field_regs_dump,
+	HIP08_OEM_TYPE2_FIELD_ID,
+	HIP08_OEM_TYPE2_FIELD_TIMESTAMP,
+	HIP08_OEM_TYPE2_FIELD_VERSION,
+	HIP08_OEM_TYPE2_FIELD_SOC_ID,
+	HIP08_OEM_TYPE2_FIELD_SOCKET_ID,
+	HIP08_OEM_TYPE2_FIELD_NIMBUS_ID,
+	HIP08_OEM_TYPE2_FIELD_MODULE_ID,
+	HIP08_OEM_TYPE2_FIELD_SUB_MODULE_ID,
+	HIP08_OEM_TYPE2_FIELD_ERR_SEV,
+	HIP08_OEM_TYPE2_FIELD_REGS_DUMP,
 };
 
 enum {
-	hip08_pcie_local_field_id,
-	hip08_pcie_local_field_timestamp,
-	hip08_pcie_local_field_version,
-	hip08_pcie_local_field_soc_id,
-	hip08_pcie_local_field_socket_id,
-	hip08_pcie_local_field_nimbus_id,
-	hip08_pcie_local_field_sub_module_id,
-	hip08_pcie_local_field_core_id,
-	hip08_pcie_local_field_port_id,
-	hip08_pcie_local_field_err_sev,
-	hip08_pcie_local_field_err_type,
-	hip08_pcie_local_field_regs_dump,
+	HIP08_PCIE_LOCAL_FIELD_ID,
+	HIP08_PCIE_LOCAL_FIELD_TIMESTAMP,
+	HIP08_PCIE_LOCAL_FIELD_VERSION,
+	HIP08_PCIE_LOCAL_FIELD_SOC_ID,
+	HIP08_PCIE_LOCAL_FIELD_SOCKET_ID,
+	HIP08_PCIE_LOCAL_FIELD_NIMBUS_ID,
+	HIP08_PCIE_LOCAL_FIELD_SUB_MODULE_ID,
+	HIP08_PCIE_LOCAL_FIELD_CORE_ID,
+	HIP08_PCIE_LOCAL_FIELD_PORT_ID,
+	HIP08_PCIE_LOCAL_FIELD_ERR_SEV,
+	HIP08_PCIE_LOCAL_FIELD_ERR_TYPE,
+	HIP08_PCIE_LOCAL_FIELD_REGS_DUMP,
 };
 
 struct hisi_module_info {
@@ -520,13 +520,13 @@ static void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
 			       int id, int64_t data, const char *text)
 {
 	switch (data_type) {
-	case hisi_oem_data_type_int:
+	case HISI_OEM_DATA_TYPE_INT:
 		sqlite3_bind_int(dec_tab->stmt_dec_record, id, data);
 		break;
-	case hisi_oem_data_type_int64:
+	case HISI_OEM_DATA_TYPE_INT64:
 		sqlite3_bind_int64(dec_tab->stmt_dec_record, id, data);
 		break;
-	case hisi_oem_data_type_text:
+	case HISI_OEM_DATA_TYPE_TEXT:
 		sqlite3_bind_text(dec_tab->stmt_dec_record, id, text, -1, NULL);
 		break;
 	default:
@@ -579,27 +579,27 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	char *end = buf + HISI_BUF_LEN;
 
 	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
-	record_vendor_data(dec_tab, hisi_oem_data_type_int,
-			   hip08_oem_type1_field_version, err->version, NULL);
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+			   HIP08_OEM_TYPE1_FIELD_VERSION, err->version, NULL);
 
 	if (err->val_bits & HISI_OEM_VALID_SOC_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_soc_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_OEM_TYPE1_FIELD_SOC_ID,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_socket_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_OEM_TYPE1_FIELD_SOCKET_ID,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type1_field_nimbus_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_OEM_TYPE1_FIELD_NIMBUS_ID,
 				   err->nimbus_id, NULL);
 	}
 
@@ -608,8 +608,8 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						  err->module_id);
 
 		p += snprintf(p, end - p, "module=%s ", str);
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_oem_type1_field_module_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_OEM_TYPE1_FIELD_MODULE_ID,
 				   0, str);
 	}
 
@@ -620,8 +620,8 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						     err->sub_module_id);
 
 		p += snprintf(p, end - p, "submodule=%s ", str);
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_oem_type1_field_sub_module_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_OEM_TYPE1_FIELD_SUB_MODULE_ID,
 				   0, str);
 	}
 
@@ -629,8 +629,8 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_severity=%s ",
 			     err_severity(err->err_severity));
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_oem_type1_field_err_sev,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_OEM_TYPE1_FIELD_ERR_SEV,
 				   0, err_severity(err->err_severity));
 	}
 
@@ -691,8 +691,8 @@ static void decode_oem_type1_err_regs(struct ras_ns_dec_tab *dec_tab,
 		*p = '\0';
 	}
 
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_oem_type1_field_regs_dump, 0, buf);
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+			   HIP08_OEM_TYPE1_FIELD_REGS_DUMP, 0, buf);
 	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
 }
 
@@ -722,8 +722,8 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 		}
 	}
 #endif
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_oem_type1_field_timestamp,
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+			   HIP08_OEM_TYPE1_FIELD_TIMESTAMP,
 			   0, event->timestamp);
 
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
@@ -742,27 +742,27 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	char *end = buf + HISI_BUF_LEN;
 
 	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
-	record_vendor_data(dec_tab, hisi_oem_data_type_int,
-			   hip08_oem_type2_field_version, err->version, NULL);
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+			   HIP08_OEM_TYPE2_FIELD_VERSION, err->version, NULL);
 
 	if (err->val_bits & HISI_OEM_VALID_SOC_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_soc_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_OEM_TYPE2_FIELD_SOC_ID,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_socket_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_OEM_TYPE2_FIELD_SOCKET_ID,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_oem_type2_field_nimbus_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_OEM_TYPE2_FIELD_NIMBUS_ID,
 				   err->nimbus_id, NULL);
 	}
 
@@ -771,8 +771,8 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						  err->module_id);
 
 		p += snprintf(p, end - p, "module=%s ", str);
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_oem_type2_field_module_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_OEM_TYPE2_FIELD_MODULE_ID,
 				   0, str);
 	}
 
@@ -783,8 +783,8 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						     err->sub_module_id);
 
 		p += snprintf(p, end - p, "submodule=%s ", str);
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_oem_type2_field_sub_module_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_OEM_TYPE2_FIELD_SUB_MODULE_ID,
 				   0, str);
 	}
 
@@ -792,8 +792,8 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_severity=%s ",
 			     err_severity(err->err_severity));
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_oem_type2_field_err_sev,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_OEM_TYPE2_FIELD_ERR_SEV,
 				   0, err_severity(err->err_severity));
 	}
 
@@ -864,8 +864,8 @@ static void decode_oem_type2_err_regs(struct ras_ns_dec_tab *dec_tab,
 		*p = '\0';
 	}
 
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_oem_type2_field_regs_dump, 0, buf);
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+			   HIP08_OEM_TYPE2_FIELD_REGS_DUMP, 0, buf);
 	step_vendor_data_tab(dec_tab, "hip08_oem_type2_event_tab");
 }
 
@@ -893,8 +893,8 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 		}
 	}
 #endif
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_oem_type2_field_timestamp,
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+			   HIP08_OEM_TYPE2_FIELD_TIMESTAMP,
 			   0, event->timestamp);
 
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-2 Error\n");
@@ -913,31 +913,31 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	char *end = buf + HISI_BUF_LEN;
 
 	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
-	record_vendor_data(dec_tab, hisi_oem_data_type_int,
-			   hip08_pcie_local_field_version,
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+			   HIP08_PCIE_LOCAL_FIELD_VERSION,
 			   err->version, NULL);
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_pcie_local_field_soc_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_PCIE_LOCAL_FIELD_SOC_ID,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_pcie_local_field_socket_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_PCIE_LOCAL_FIELD_SOCKET_ID,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_pcie_local_field_nimbus_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_PCIE_LOCAL_FIELD_NIMBUS_ID,
 				   err->nimbus_id, NULL);
 	}
 
@@ -945,24 +945,24 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "submodule=%s ",
 			      pcie_local_sub_module_name(err->sub_module_id));
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_pcie_local_field_sub_module_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_PCIE_LOCAL_FIELD_SUB_MODULE_ID,
 				   0, pcie_local_sub_module_name(err->sub_module_id));
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "core_ID=core%d ", err->core_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_pcie_local_field_core_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_PCIE_LOCAL_FIELD_CORE_ID,
 				   err->core_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "port_ID=port%d ", err->port_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_pcie_local_field_port_id,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_PCIE_LOCAL_FIELD_PORT_ID,
 				   err->port_id, NULL);
 	}
 
@@ -970,16 +970,16 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_severity=%s ",
 			      err_severity(err->err_severity));
-		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-				   hip08_pcie_local_field_err_sev,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+				   HIP08_PCIE_LOCAL_FIELD_ERR_SEV,
 				   0, err_severity(err->err_severity));
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_type=0x%x ", err->err_type);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
-				   hip08_pcie_local_field_err_type,
+		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+				   HIP08_PCIE_LOCAL_FIELD_ERR_TYPE,
 				   err->err_type, NULL);
 	}
 
@@ -1014,8 +1014,8 @@ static void decode_pcie_local_err_regs(struct ras_ns_dec_tab *dec_tab,
 		*p = '\0';
 	}
 
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_pcie_local_field_regs_dump, 0, buf);
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+			   HIP08_PCIE_LOCAL_FIELD_REGS_DUMP, 0, buf);
 	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
 }
 
@@ -1043,8 +1043,8 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 		}
 	}
 #endif
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_pcie_local_field_timestamp,
+	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+			   HIP08_PCIE_LOCAL_FIELD_TIMESTAMP,
 			   0, event->timestamp);
 
 	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
-- 
2.8.1


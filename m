Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0EBCFA2B
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbfJHMl4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 08:41:56 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:36692 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730719AbfJHMl4 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 08:41:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39C0BAF65C89AD05B3BB;
        Tue,  8 Oct 2019 20:41:53 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 20:41:45 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 2/5] rasdaemon: add underscore(_) for some logging item names for hip08
Date:   Tue, 8 Oct 2019 20:38:55 +0800
Message-ID: <1570538338-230884-3-git-send-email-tanxiaofei@huawei.com>
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

Add underscore(_) for some logging item names for hip08. Then we can
match and catch specific fields of the log easily if needed.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 48 +++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 393053d..9de7be8 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -264,11 +264,11 @@ static char *oem_type2_sub_module_id(char *p, uint8_t module_id,
 static char *pcie_local_sub_module_name(uint8_t id)
 {
 	switch (id) {
-	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP Layer";
-	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL Layer";
-	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC Layer";
-	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL Layer";
-	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI Layer";
+	case HISI_PCIE_SUB_MODULE_ID_AP: return "AP_Layer";
+	case HISI_PCIE_SUB_MODULE_ID_TL: return "TL_Layer";
+	case HISI_PCIE_SUB_MODULE_ID_MAC: return "MAC_Layer";
+	case HISI_PCIE_SUB_MODULE_ID_DL: return "DL_Layer";
+	case HISI_PCIE_SUB_MODULE_ID_SDI: return "SDI_Layer";
 	}
 	return "unknown";
 }
@@ -411,26 +411,26 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 #endif
 
 	p += sprintf(p, "[ ");
-	p += sprintf(p, "Table version=%d ", err->version);
+	p += sprintf(p, "table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
 			   hip08_oem_type1_field_version, err->version, NULL);
 
 	if (err->val_bits & HISI_OEM_VALID_SOC_ID) {
-		p += sprintf(p, "SOC ID=%d ", err->soc_id);
+		p += sprintf(p, "SOC_ID=%d ", err->soc_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type1_field_soc_id,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID) {
-		p += sprintf(p, "socket ID=%d ", err->socket_id);
+		p += sprintf(p, "socket_ID=%d ", err->socket_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type1_field_socket_id,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID) {
-		p += sprintf(p, "nimbus ID=%d ", err->nimbus_id);
+		p += sprintf(p, "nimbus_ID=%d ", err->nimbus_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type1_field_nimbus_id,
 				   err->nimbus_id, NULL);
@@ -451,7 +451,7 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
-		p += sprintf(p, "error severity=%s ",
+		p += sprintf(p, "error_severity=%s ",
 			     err_severity(err->err_severity));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_err_sev,
@@ -528,26 +528,26 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	}
 #endif
 	p += sprintf(p, "[ ");
-	p += sprintf(p, "Table version=%d ", err->version);
+	p += sprintf(p, "table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
 			   hip08_oem_type2_field_version,
 			   err->version, NULL);
 	if (err->val_bits & HISI_OEM_VALID_SOC_ID) {
-		p += sprintf(p, "SOC ID=%d ", err->soc_id);
+		p += sprintf(p, "SOC_ID=%d ", err->soc_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type2_field_soc_id,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID) {
-		p += sprintf(p, "socket ID=%d ", err->socket_id);
+		p += sprintf(p, "socket_ID=%d ", err->socket_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type2_field_socket_id,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID) {
-		p += sprintf(p, "nimbus ID=%d ", err->nimbus_id);
+		p += sprintf(p, "nimbus_ID=%d ", err->nimbus_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_oem_type2_field_nimbus_id,
 				   err->nimbus_id, NULL);
@@ -570,7 +570,7 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
-		p += sprintf(p, "error severity=%s ",
+		p += sprintf(p, "error_severity=%s ",
 			     err_severity(err->err_severity));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type2_field_err_sev,
@@ -660,33 +660,33 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 	}
 #endif
 	p += sprintf(p, "[ ");
-	p += sprintf(p, "Table version=%d ", err->version);
+	p += sprintf(p, "table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
 			   hip08_pcie_local_field_version,
 			   err->version, NULL);
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID) {
-		p += sprintf(p, "SOC ID=%d ", err->soc_id);
+		p += sprintf(p, "SOC_ID=%d ", err->soc_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_soc_id,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID) {
-		p += sprintf(p, "socket ID=%d ", err->socket_id);
+		p += sprintf(p, "socket_ID=%d ", err->socket_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_socket_id,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID) {
-		p += sprintf(p, "nimbus ID=%d ", err->nimbus_id);
+		p += sprintf(p, "nimbus_ID=%d ", err->nimbus_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_nimbus_id,
 				   err->nimbus_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SUB_MODULE_ID) {
-		p += sprintf(p, "sub module=%s ",
+		p += sprintf(p, "submodule=%s ",
 			     pcie_local_sub_module_name(err->sub_module_id));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_pcie_local_field_sub_module_id,
@@ -694,21 +694,21 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID) {
-		p += sprintf(p, "core ID=core%d ", err->core_id);
+		p += sprintf(p, "core_ID=core%d ", err->core_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_core_id,
 				   err->core_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID) {
-		p += sprintf(p, "port ID=port%d ", err->port_id);
+		p += sprintf(p, "port_ID=port%d ", err->port_id);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_port_id,
 				   err->port_id, NULL);
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_SEVERITY) {
-		p += sprintf(p, "error severity=%s ",
+		p += sprintf(p, "error_severity=%s ",
 			     err_severity(err->err_severity));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_pcie_local_field_err_sev,
@@ -716,7 +716,7 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE) {
-		p += sprintf(p, "error type=0x%x ", err->err_type);
+		p += sprintf(p, "error_type=0x%x ", err->err_type);
 		record_vendor_data(dec_tab, hisi_oem_data_type_int,
 				   hip08_pcie_local_field_err_type,
 				   err->err_type, NULL);
-- 
2.8.1


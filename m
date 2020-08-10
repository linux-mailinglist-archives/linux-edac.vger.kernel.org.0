Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441D82407CC
	for <lists+linux-edac@lfdr.de>; Mon, 10 Aug 2020 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgHJOrX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Aug 2020 10:47:23 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2587 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727055AbgHJOrW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 10 Aug 2020 10:47:22 -0400
Received: from lhreml715-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 95AD5F12F26F281AE184;
        Mon, 10 Aug 2020 15:47:13 +0100 (IST)
Received: from DESKTOP-6T4S3DQ.china.huawei.com (10.47.95.125) by
 lhreml715-chm.china.huawei.com (10.201.108.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 10 Aug 2020 15:47:12 +0100
From:   Shiju Jose <shiju.jose@huawei.com>
To:     <mchehab+huawei@kernel.org>, <linux-edac@vger.kernel.org>
CC:     <linuxarm@huawei.com>, <tanxiaofei@huawei.com>,
        <jonathan.cameron@huawei.com>
Subject: [PATCH 1/1] rasdaemon: Modify non-standard error decoding interface using linked list
Date:   Mon, 10 Aug 2020 15:42:56 +0100
Message-ID: <20200810144256.1311-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.47.95.125]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml715-chm.china.huawei.com (10.201.108.66)
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace the current non-standard error decoding interface with the
interface based on the linked list to avoid using realloc and
to improve the interface.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 non-standard-hisi_hip08.c  | 114 +++++++++++++++++-----------------
 non-standard-hisilicon.c   |  46 +++++++-------
 non-standard-hisilicon.h   |   4 +-
 ras-non-standard-handler.c | 122 ++++++++++++++++++++-----------------
 ras-non-standard-handler.h |  13 ++--
 5 files changed, 155 insertions(+), 144 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 2197f81..ebf03e1 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -528,7 +528,7 @@ static const struct db_table_descriptor hip08_pcie_local_event_tab = {
 #endif
 
 #define IN_RANGE(p, start, end) ((p) >= (start) && (p) < (end))
-static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
+static void decode_oem_type1_err_hdr(struct ras_ns_ev_decoder *ev_decoder,
 				     struct trace_seq *s,
 				     const struct hisi_oem_type1_err_sec *err)
 {
@@ -537,26 +537,26 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	char *end = buf + HISI_BUF_LEN;
 
 	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 			   HIP08_OEM_TYPE1_FIELD_VERSION, err->version, NULL);
 
 	if (err->val_bits & HISI_OEM_VALID_SOC_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_OEM_TYPE1_FIELD_SOC_ID,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_OEM_TYPE1_FIELD_SOCKET_ID,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_OEM_TYPE1_FIELD_NIMBUS_ID,
 				   err->nimbus_id, NULL);
 	}
@@ -566,7 +566,7 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						  err->module_id);
 
 		p += snprintf(p, end - p, "module=%s ", str);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_OEM_TYPE1_FIELD_MODULE_ID,
 				   0, str);
 	}
@@ -578,7 +578,7 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						     err->sub_module_id);
 
 		p += snprintf(p, end - p, "submodule=%s ", str);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_OEM_TYPE1_FIELD_SUB_MODULE_ID,
 				   0, str);
 	}
@@ -587,7 +587,7 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_severity=%s ",
 			     err_severity(err->err_severity));
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_OEM_TYPE1_FIELD_ERR_SEV,
 				   0, err_severity(err->err_severity));
 	}
@@ -598,7 +598,7 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	trace_seq_printf(s, "%s\n", buf);
 }
 
-static void decode_oem_type1_err_regs(struct ras_ns_dec_tab *dec_tab,
+static void decode_oem_type1_err_regs(struct ras_ns_ev_decoder *ev_decoder,
 				      struct trace_seq *s,
 				      const struct hisi_oem_type1_err_sec *err)
 {
@@ -649,14 +649,14 @@ static void decode_oem_type1_err_regs(struct ras_ns_dec_tab *dec_tab,
 		*p = '\0';
 	}
 
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_OEM_TYPE1_FIELD_REGS_DUMP, 0, buf);
-	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
+	step_vendor_data_tab(ev_decoder, "hip08_oem_type1_event_tab");
 }
 
 /* error data decoding functions */
 static int decode_hip08_oem_type1_error(struct ras_events *ras,
-					struct ras_ns_dec_tab *dec_tab,
+					struct ras_ns_ev_decoder *ev_decoder,
 					struct trace_seq *s,
 					struct ras_non_standard_event *event)
 {
@@ -670,8 +670,8 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	}
 
 #ifdef HAVE_SQLITE3
-	if (!dec_tab->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
+	if (!ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 					    &hip08_oem_type1_event_tab)
 			!= SQLITE_OK) {
 			trace_seq_printf(s,
@@ -680,18 +680,18 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 		}
 	}
 #endif
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_OEM_TYPE1_FIELD_TIMESTAMP,
 			   0, event->timestamp);
 
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
-	decode_oem_type1_err_hdr(dec_tab, s, err);
-	decode_oem_type1_err_regs(dec_tab, s, err);
+	decode_oem_type1_err_hdr(ev_decoder, s, err);
+	decode_oem_type1_err_regs(ev_decoder, s, err);
 
 	return 0;
 }
 
-static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
+static void decode_oem_type2_err_hdr(struct ras_ns_ev_decoder *ev_decoder,
 				     struct trace_seq *s,
 				     const struct hisi_oem_type2_err_sec *err)
 {
@@ -700,26 +700,26 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	char *end = buf + HISI_BUF_LEN;
 
 	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 			   HIP08_OEM_TYPE2_FIELD_VERSION, err->version, NULL);
 
 	if (err->val_bits & HISI_OEM_VALID_SOC_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_OEM_TYPE2_FIELD_SOC_ID,
 				   err->soc_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SOCKET_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_OEM_TYPE2_FIELD_SOCKET_ID,
 				   err->socket_id, NULL);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_NIMBUS_ID && IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_OEM_TYPE2_FIELD_NIMBUS_ID,
 				   err->nimbus_id, NULL);
 	}
@@ -729,7 +729,7 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						  err->module_id);
 
 		p += snprintf(p, end - p, "module=%s ", str);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_OEM_TYPE2_FIELD_MODULE_ID,
 				   0, str);
 	}
@@ -741,7 +741,7 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 						     err->sub_module_id);
 
 		p += snprintf(p, end - p, "submodule=%s ", str);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_OEM_TYPE2_FIELD_SUB_MODULE_ID,
 				   0, str);
 	}
@@ -750,7 +750,7 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_severity=%s ",
 			     err_severity(err->err_severity));
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_OEM_TYPE2_FIELD_ERR_SEV,
 				   0, err_severity(err->err_severity));
 	}
@@ -761,7 +761,7 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	trace_seq_printf(s, "%s\n", buf);
 }
 
-static void decode_oem_type2_err_regs(struct ras_ns_dec_tab *dec_tab,
+static void decode_oem_type2_err_regs(struct ras_ns_ev_decoder *ev_decoder,
 				      struct trace_seq *s,
 				      const struct hisi_oem_type2_err_sec *err)
 {
@@ -822,13 +822,13 @@ static void decode_oem_type2_err_regs(struct ras_ns_dec_tab *dec_tab,
 		*p = '\0';
 	}
 
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_OEM_TYPE2_FIELD_REGS_DUMP, 0, buf);
-	step_vendor_data_tab(dec_tab, "hip08_oem_type2_event_tab");
+	step_vendor_data_tab(ev_decoder, "hip08_oem_type2_event_tab");
 }
 
 static int decode_hip08_oem_type2_error(struct ras_events *ras,
-					struct ras_ns_dec_tab *dec_tab,
+					struct ras_ns_ev_decoder *ev_decoder,
 					struct trace_seq *s,
 					struct ras_non_standard_event *event)
 {
@@ -842,8 +842,8 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	}
 
 #ifdef HAVE_SQLITE3
-	if (!dec_tab->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
+	if (!ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 			&hip08_oem_type2_event_tab) != SQLITE_OK) {
 			trace_seq_printf(s,
 				"create sql hip08_oem_type2_event_tab fail\n");
@@ -851,18 +851,18 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 		}
 	}
 #endif
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_OEM_TYPE2_FIELD_TIMESTAMP,
 			   0, event->timestamp);
 
 	trace_seq_printf(s, "\nHISI HIP08: OEM Type-2 Error\n");
-	decode_oem_type2_err_hdr(dec_tab, s, err);
-	decode_oem_type2_err_regs(dec_tab, s, err);
+	decode_oem_type2_err_hdr(ev_decoder, s, err);
+	decode_oem_type2_err_regs(ev_decoder, s, err);
 
 	return 0;
 }
 
-static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
+static void decode_pcie_local_err_hdr(struct ras_ns_ev_decoder *ev_decoder,
 				      struct trace_seq *s,
 				      const struct hisi_pcie_local_err_sec *err)
 {
@@ -871,14 +871,14 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	char *end = buf + HISI_BUF_LEN;
 
 	p += snprintf(p, end - p, "[ table_version=%d ", err->version);
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 			   HIP08_PCIE_LOCAL_FIELD_VERSION,
 			   err->version, NULL);
 
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOC_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "SOC_ID=%d ", err->soc_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_PCIE_LOCAL_FIELD_SOC_ID,
 				   err->soc_id, NULL);
 	}
@@ -886,7 +886,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_SOCKET_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "socket_ID=%d ", err->socket_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_PCIE_LOCAL_FIELD_SOCKET_ID,
 				   err->socket_id, NULL);
 	}
@@ -894,7 +894,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_NIMBUS_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "nimbus_ID=%d ", err->nimbus_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_PCIE_LOCAL_FIELD_NIMBUS_ID,
 				   err->nimbus_id, NULL);
 	}
@@ -903,7 +903,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "submodule=%s ",
 			      pcie_local_sub_module_name(err->sub_module_id));
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_PCIE_LOCAL_FIELD_SUB_MODULE_ID,
 				   0, pcie_local_sub_module_name(err->sub_module_id));
 	}
@@ -911,7 +911,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_CORE_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "core_ID=core%d ", err->core_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_PCIE_LOCAL_FIELD_CORE_ID,
 				   err->core_id, NULL);
 	}
@@ -919,7 +919,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_PORT_ID &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "port_ID=port%d ", err->port_id);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_PCIE_LOCAL_FIELD_PORT_ID,
 				   err->port_id, NULL);
 	}
@@ -928,7 +928,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_severity=%s ",
 			      err_severity(err->err_severity));
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HIP08_PCIE_LOCAL_FIELD_ERR_SEV,
 				   0, err_severity(err->err_severity));
 	}
@@ -936,7 +936,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	if (err->val_bits & HISI_PCIE_LOCAL_VALID_ERR_TYPE &&
 	    IN_RANGE(p, buf, end)) {
 		p += snprintf(p, end - p, "error_type=0x%x ", err->err_type);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_INT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_INT,
 				   HIP08_PCIE_LOCAL_FIELD_ERR_TYPE,
 				   err->err_type, NULL);
 	}
@@ -947,7 +947,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 	trace_seq_printf(s, "%s\n", buf);
 }
 
-static void decode_pcie_local_err_regs(struct ras_ns_dec_tab *dec_tab,
+static void decode_pcie_local_err_regs(struct ras_ns_ev_decoder *ev_decoder,
 				       struct trace_seq *s,
 				       const struct hisi_pcie_local_err_sec *err)
 {
@@ -972,13 +972,13 @@ static void decode_pcie_local_err_regs(struct ras_ns_dec_tab *dec_tab,
 		*p = '\0';
 	}
 
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_PCIE_LOCAL_FIELD_REGS_DUMP, 0, buf);
-	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
+	step_vendor_data_tab(ev_decoder, "hip08_pcie_local_event_tab");
 }
 
 static int decode_hip08_pcie_local_error(struct ras_events *ras,
-					 struct ras_ns_dec_tab *dec_tab,
+					 struct ras_ns_ev_decoder *ev_decoder,
 					 struct trace_seq *s,
 					 struct ras_non_standard_event *event)
 {
@@ -992,8 +992,8 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 	}
 
 #ifdef HAVE_SQLITE3
-	if (!dec_tab->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
+	if (!ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 				&hip08_pcie_local_event_tab) != SQLITE_OK) {
 			trace_seq_printf(s,
 				"create sql hip08_pcie_local_event_tab fail\n");
@@ -1001,18 +1001,18 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 		}
 	}
 #endif
-	record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+	record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 			   HIP08_PCIE_LOCAL_FIELD_TIMESTAMP,
 			   0, event->timestamp);
 
 	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
-	decode_pcie_local_err_hdr(dec_tab, s, err);
-	decode_pcie_local_err_regs(dec_tab, s, err);
+	decode_pcie_local_err_hdr(ev_decoder, s, err);
+	decode_pcie_local_err_regs(ev_decoder, s, err);
 
 	return 0;
 }
 
-struct ras_ns_dec_tab hip08_ns_oem_tab[] = {
+static struct ras_ns_ev_decoder hip08_ns_ev_decoder[] = {
 	{
 		.sec_type = "1f8161e155d641e6bd107afd1dc5f7c5",
 		.decode = decode_hip08_oem_type1_error,
@@ -1025,10 +1025,12 @@ struct ras_ns_dec_tab hip08_ns_oem_tab[] = {
 		.sec_type = "b2889fc9e7d74f9da867af42e98be772",
 		.decode = decode_hip08_pcie_local_error,
 	},
-	{ /* sentinel */ }
 };
 
 static void __attribute__((constructor)) hip08_init(void)
 {
-	register_ns_dec_tab(hip08_ns_oem_tab);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hip08_ns_ev_decoder); i++)
+		register_ns_ev_decoder(&hip08_ns_ev_decoder[i]);
 }
diff --git a/non-standard-hisilicon.c b/non-standard-hisilicon.c
index c9e1fa9..a6f5e78 100644
--- a/non-standard-hisilicon.c
+++ b/non-standard-hisilicon.c
@@ -73,38 +73,38 @@ struct hisi_event {
 };
 
 #ifdef HAVE_SQLITE3
-void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+void record_vendor_data(struct ras_ns_ev_decoder *ev_decoder,
 			       enum hisi_oem_data_type data_type,
 			       int id, int64_t data, const char *text)
 {
 	switch (data_type) {
 	case HISI_OEM_DATA_TYPE_INT:
-		sqlite3_bind_int(dec_tab->stmt_dec_record, id, data);
+		sqlite3_bind_int(ev_decoder->stmt_dec_record, id, data);
 		break;
 	case HISI_OEM_DATA_TYPE_INT64:
-		sqlite3_bind_int64(dec_tab->stmt_dec_record, id, data);
+		sqlite3_bind_int64(ev_decoder->stmt_dec_record, id, data);
 		break;
 	case HISI_OEM_DATA_TYPE_TEXT:
-		sqlite3_bind_text(dec_tab->stmt_dec_record, id, text, -1, NULL);
+		sqlite3_bind_text(ev_decoder->stmt_dec_record, id, text, -1, NULL);
 		break;
 	}
 }
 
-int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name)
+int step_vendor_data_tab(struct ras_ns_ev_decoder *ev_decoder, const char *name)
 {
 	int rc;
 
-	rc = sqlite3_step(dec_tab->stmt_dec_record);
+	rc = sqlite3_step(ev_decoder->stmt_dec_record);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
 		log(TERM, LOG_ERR,
 		    "Failed to do %s step on sqlite: error = %d\n", name, rc);
 
-	rc = sqlite3_reset(dec_tab->stmt_dec_record);
+	rc = sqlite3_reset(ev_decoder->stmt_dec_record);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
 		log(TERM, LOG_ERR,
 		    "Failed to reset %s on sqlite: error = %d\n", name, rc);
 
-	rc = sqlite3_clear_bindings(dec_tab->stmt_dec_record);
+	rc = sqlite3_clear_bindings(ev_decoder->stmt_dec_record);
 	if (rc != SQLITE_OK && rc != SQLITE_DONE)
 		log(TERM, LOG_ERR,
 		    "Failed to clear bindings %s on sqlite: error = %d\n",
@@ -113,12 +113,12 @@ int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name)
 	return rc;
 }
 #else
-void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+void record_vendor_data(struct ras_ns_ev_decoder *ev_decoder,
 			enum hisi_oem_data_type data_type,
 			int id, int64_t data, const char *text)
 { }
 
-int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name)
+int step_vendor_data_tab(struct ras_ns_ev_decoder *ev_decoder, const char *name)
 {
 	return 0;
 }
@@ -197,7 +197,7 @@ static void decode_module(struct hisi_event *event, uint8_t module_id)
 		HISI_SNPRINTF(event->error_msg, "module=%s ", module_name[module_id]);
 }
 
-static void decode_hisi_common_section_hdr(struct ras_ns_dec_tab *dec_tab,
+static void decode_hisi_common_section_hdr(struct ras_ns_ev_decoder *ev_decoder,
 					  const struct hisi_common_error_section *err,
 					  struct hisi_event *event)
 {
@@ -244,7 +244,7 @@ static void decode_hisi_common_section_hdr(struct ras_ns_dec_tab *dec_tab,
 }
 
 static int decode_hisi_common_section(struct ras_events *ras,
-				      struct ras_ns_dec_tab *dec_tab,
+				      struct ras_ns_ev_decoder *ev_decoder,
 				      struct trace_seq *s,
 				      struct ras_non_standard_event *event)
 {
@@ -253,8 +253,8 @@ static int decode_hisi_common_section(struct ras_events *ras,
 	struct hisi_event hevent;
 
 #ifdef HAVE_SQLITE3
-	if (ras->record_events && !dec_tab->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
+	if (ras->record_events && !ev_decoder->stmt_dec_record) {
+		if (ras_mc_add_vendor_table(ras, &ev_decoder->stmt_dec_record,
 				&hisi_common_section_tab) != SQLITE_OK) {
 			trace_seq_printf(s, "create sql hisi_common_section_tab fail\n");
 			return -1;
@@ -264,7 +264,7 @@ static int decode_hisi_common_section(struct ras_events *ras,
 
 	memset(&hevent, 0, sizeof(struct hisi_event));
 	trace_seq_printf(s, "\nHisilicon Common Error Section:\n");
-	decode_hisi_common_section_hdr(dec_tab, err, &hevent);
+	decode_hisi_common_section_hdr(ev_decoder, err, &hevent);
 	trace_seq_printf(s, "%s\n", hevent.error_msg);
 
 	if (err->val_bits & BIT(HISI_COMMON_VALID_REG_ARRAY_SIZE) && err->reg_array_size > 0) {
@@ -280,28 +280,30 @@ static int decode_hisi_common_section(struct ras_events *ras,
 	}
 
 	if (ras->record_events) {
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HISI_COMMON_FIELD_TIMESTAMP,
 				   0, event->timestamp);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HISI_COMMON_FIELD_ERR_INFO, 0, hevent.error_msg);
-		record_vendor_data(dec_tab, HISI_OEM_DATA_TYPE_TEXT,
+		record_vendor_data(ev_decoder, HISI_OEM_DATA_TYPE_TEXT,
 				   HISI_COMMON_FIELD_REGS_DUMP, 0, hevent.reg_msg);
-		step_vendor_data_tab(dec_tab, "hisi_common_section_tab");
+		step_vendor_data_tab(ev_decoder, "hisi_common_section_tab");
 	}
 
 	return 0;
 }
 
-struct ras_ns_dec_tab hisi_section_ns_tab[] = {
+static struct ras_ns_ev_decoder hisi_section_ns_ev_decoder[]  = {
 	{
 		.sec_type = "c8b328a899174af69a132e08ab2e7586",
 		.decode = decode_hisi_common_section,
 	},
-	{ /* sentinel */ }
 };
 
 static void __attribute__((constructor)) hisi_ns_init(void)
 {
-	register_ns_dec_tab(hisi_section_ns_tab);
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(hisi_section_ns_ev_decoder); i++)
+		register_ns_ev_decoder(&hisi_section_ns_ev_decoder[i]);
 }
diff --git a/non-standard-hisilicon.h b/non-standard-hisilicon.h
index 1ce210a..75b911e 100644
--- a/non-standard-hisilicon.h
+++ b/non-standard-hisilicon.h
@@ -41,9 +41,9 @@ static inline char *err_severity(uint8_t err_sev)
 	return "unknown";
 }
 
-void record_vendor_data(struct ras_ns_dec_tab *dec_tab,
+void record_vendor_data(struct ras_ns_ev_decoder *ev_decoder,
 			enum hisi_oem_data_type data_type,
 			int id, int64_t data, const char *text);
-int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, const char *name);
+int step_vendor_data_tab(struct ras_ns_ev_decoder *ev_decoder, const char *name);
 
 #endif
diff --git a/ras-non-standard-handler.c b/ras-non-standard-handler.c
index d92fd42..1862335 100644
--- a/ras-non-standard-handler.c
+++ b/ras-non-standard-handler.c
@@ -22,46 +22,7 @@
 #include "ras-logger.h"
 #include "ras-report.h"
 
-static p_ns_dec_tab * ns_dec_tab;
-static size_t dec_tab_count;
-
-int register_ns_dec_tab(const p_ns_dec_tab tab)
-{
-	ns_dec_tab = (p_ns_dec_tab *)realloc(ns_dec_tab,
-					    (dec_tab_count + 1) * sizeof(tab));
-	if (ns_dec_tab == NULL) {
-		printf("%s p_ns_dec_tab malloc failed", __func__);
-		return -1;
-	}
-	ns_dec_tab[dec_tab_count] = tab;
-	dec_tab_count++;
-	return 0;
-}
-
-void unregister_ns_dec_tab(void)
-{
-	if (ns_dec_tab) {
-#ifdef HAVE_SQLITE3
-		p_ns_dec_tab dec_tab;
-		int i, count;
-
-		for (count = 0; count < dec_tab_count; count++) {
-			dec_tab = ns_dec_tab[count];
-			for (i = 0; dec_tab[i].decode; i++) {
-				if (dec_tab[i].stmt_dec_record) {
-					ras_mc_finalize_vendor_table(
-						dec_tab[i].stmt_dec_record);
-					dec_tab[i].stmt_dec_record = NULL;
-				}
-			}
-		}
-#endif
-
-		free(ns_dec_tab);
-		ns_dec_tab = NULL;
-		dec_tab_count = 0;
-	}
-}
+static struct  ras_ns_ev_decoder *ras_ns_ev_dec_list;
 
 void print_le_hex(struct trace_seq *s, const uint8_t *buf, int index) {
 	trace_seq_printf(s, "%02x%02x%02x%02x", buf[index+3], buf[index+2], buf[index+1], buf[index]);
@@ -105,18 +66,75 @@ static int uuid_le_cmp(const char *sec_type, const char *uuid2)
 	return strncmp(uuid1, uuid2, 32);
 }
 
+int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder)
+{
+	struct ras_ns_ev_decoder *list;
+
+	if (!ns_ev_decoder)
+		return -1;
+
+	ns_ev_decoder->next = NULL;
+	ns_ev_decoder->stmt_dec_record = NULL;
+	if (!ras_ns_ev_dec_list) {
+		ras_ns_ev_dec_list = ns_ev_decoder;
+	} else {
+		list = ras_ns_ev_dec_list;
+		while (list->next)
+			list = list->next;
+		list->next = ns_ev_decoder;
+	}
+
+	return 0;
+}
+
+static int find_ns_ev_decoder(const char *sec_type, struct ras_ns_ev_decoder **p_ns_ev_dec)
+{
+	struct ras_ns_ev_decoder *ns_ev_decoder;
+	int match = 0;
+
+	ns_ev_decoder = ras_ns_ev_dec_list;
+	while (ns_ev_decoder) {
+		if (uuid_le_cmp(sec_type, ns_ev_decoder->sec_type) == 0) {
+			*p_ns_ev_dec = ns_ev_decoder;
+			match  = 1;
+			break;
+		}
+		ns_ev_decoder = ns_ev_decoder->next;
+	}
+
+	if (!match)
+		return -1;
+
+	return 0;
+}
+
+static void unregister_ns_ev_decoder(void)
+{
+#ifdef HAVE_SQLITE3
+	struct ras_ns_ev_decoder *ns_ev_decoder = ras_ns_ev_dec_list;
+
+	while (ns_ev_decoder) {
+		if (ns_ev_decoder->stmt_dec_record) {
+			ras_mc_finalize_vendor_table(ns_ev_decoder->stmt_dec_record);
+			ns_ev_decoder->stmt_dec_record = NULL;
+		}
+		ns_ev_decoder = ns_ev_decoder->next;
+	}
+#endif
+	ras_ns_ev_dec_list = NULL;
+}
+
 int ras_non_standard_event_handler(struct trace_seq *s,
 			 struct pevent_record *record,
 			 struct event_format *event, void *context)
 {
-	int len, i, line_count, count;
+	int len, i, line_count;
 	unsigned long long val;
 	struct ras_events *ras = context;
 	time_t now;
 	struct tm *tm;
 	struct ras_non_standard_event ev;
-	p_ns_dec_tab dec_tab;
-	bool dec_done = false;
+	struct ras_ns_ev_decoder *ns_ev_decoder;
 
 	/*
 	 * Newer kernels (3.10-rc1 or upper) provide an uptime clock.
@@ -177,19 +195,9 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 	if(!ev.error)
 		return -1;
 
-	for (count = 0; count < dec_tab_count && !dec_done; count++) {
-		dec_tab = ns_dec_tab[count];
-		for (i = 0; dec_tab[i].decode; i++) {
-			if (uuid_le_cmp(ev.sec_type,
-					dec_tab[i].sec_type) == 0) {
-				dec_tab[i].decode(ras, &dec_tab[i], s, &ev);
-				dec_done = true;
-				break;
-			}
-		}
-	}
-
-	if (!dec_done) {
+	if (!find_ns_ev_decoder(ev.sec_type, &ns_ev_decoder)) {
+		ns_ev_decoder->decode(ras, ns_ev_decoder, s, &ev);
+	} else {
 		len = ev.length;
 		i = 0;
 		line_count = 0;
@@ -222,5 +230,5 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 __attribute__((destructor))
 static void ns_exit(void)
 {
-	unregister_ns_dec_tab();
+	unregister_ns_ev_decoder();
 }
diff --git a/ras-non-standard-handler.h b/ras-non-standard-handler.h
index 2b9bf40..57d4cb5 100644
--- a/ras-non-standard-handler.h
+++ b/ras-non-standard-handler.h
@@ -20,15 +20,16 @@
 #define BIT(nr)                 (1UL << (nr))
 #define BIT_ULL(nr)             (1ULL << (nr))
 
-typedef struct ras_ns_dec_tab {
+struct ras_ns_ev_decoder {
+	struct ras_ns_ev_decoder *next;
 	const char *sec_type;
-	int (*decode)(struct ras_events *ras, struct ras_ns_dec_tab *dec_tab,
+	int (*decode)(struct ras_events *ras, struct ras_ns_ev_decoder *ev_decoder,
 		      struct trace_seq *s, struct ras_non_standard_event *event);
 #ifdef HAVE_SQLITE3
 #include <sqlite3.h>
 	sqlite3_stmt *stmt_dec_record;
 #endif
-} *p_ns_dec_tab;
+};
 
 int ras_non_standard_event_handler(struct trace_seq *s,
 			 struct pevent_record *record,
@@ -37,11 +38,9 @@ int ras_non_standard_event_handler(struct trace_seq *s,
 void print_le_hex(struct trace_seq *s, const uint8_t *buf, int index);
 
 #ifdef HAVE_NON_STANDARD
-int register_ns_dec_tab(const p_ns_dec_tab tab);
-void unregister_ns_dec_tab(void);
+int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder);
 #else
-static inline int register_ns_dec_tab(const p_ns_dec_tab tab) { return 0; };
-static inline void unregister_ns_dec_tab(void) { return; };
+static inline int register_ns_ev_decoder(struct ras_ns_ev_decoder *ns_ev_decoder) { return 0; };
 #endif
 
 #endif
-- 
2.17.1



Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4DC9F8FB3
	for <lists+linux-edac@lfdr.de>; Tue, 12 Nov 2019 13:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfKLMam (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Nov 2019 07:30:42 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6641 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726985AbfKLMam (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Nov 2019 07:30:42 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C16DFB6AB842F8FFAD7C;
        Tue, 12 Nov 2019 20:30:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Tue, 12 Nov 2019 20:30:27 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 7/9] rasdaemon: split PCIe local table decode function to reduce length
Date:   Tue, 12 Nov 2019 20:27:12 +0800
Message-ID: <1573561634-225173-8-git-send-email-tanxiaofei@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
References: <1573561634-225173-1-git-send-email-tanxiaofei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patch splits function decode_hip08_pcie_local_error() to reduce
length. Move header decoding and register dump to single function
separately.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 75 ++++++++++++++++++++++++++++-------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index ea640a6..fcc7a0e 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -868,36 +868,12 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	return 0;
 }
 
-static int decode_hip08_pcie_local_error(struct ras_events *ras,
-					 struct ras_ns_dec_tab *dec_tab,
-					 struct trace_seq *s,
-					 struct ras_non_standard_event *event)
+static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
+				      struct trace_seq *s,
+				      const struct hisi_pcie_local_err_sec *err)
 {
-	const struct hisi_pcie_local_err_sec *err =
-			(struct hisi_pcie_local_err_sec *)event->error;
 	char buf[1024];
 	char *p = buf;
-	uint32_t i;
-
-	if (err->val_bits == 0) {
-		trace_seq_printf(s, "%s: no valid error information\n",
-				 __func__);
-		return -1;
-	}
-
-#ifdef HAVE_SQLITE3
-	if (!dec_tab->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
-				&hip08_pcie_local_event_tab) != SQLITE_OK) {
-			trace_seq_printf(s,
-				"create sql hip08_pcie_local_event_tab fail\n");
-			return -1;
-		}
-	}
-#endif
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_pcie_local_field_timestamp,
-			   0, event->timestamp);
 
 	p += sprintf(p, "[ ");
 	p += sprintf(p, "table_version=%d ", err->version);
@@ -962,11 +938,17 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 				   err->err_type, NULL);
 	}
 	p += sprintf(p, "]");
-
-	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
 	trace_seq_printf(s, "%s\n", buf);
+}
+
+static void decode_pcie_local_err_regs(struct ras_ns_dec_tab *dec_tab,
+				       struct trace_seq *s,
+				       const struct hisi_pcie_local_err_sec *err)
+{
+	char buf[1024];
+	char *p = buf;
+	uint32_t i;
 
-	p = buf;
 	trace_seq_printf(s, "Reg Dump:\n");
 	for (i = 0; i < 33; i++) {
 		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i)) {
@@ -981,6 +963,39 @@ static int decode_hip08_pcie_local_error(struct ras_events *ras,
 			   hip08_pcie_local_field_regs_dump, 0, buf);
 
 	step_vendor_data_tab(dec_tab, "hip08_pcie_local_event_tab");
+}
+
+static int decode_hip08_pcie_local_error(struct ras_events *ras,
+					 struct ras_ns_dec_tab *dec_tab,
+					 struct trace_seq *s,
+					 struct ras_non_standard_event *event)
+{
+	const struct hisi_pcie_local_err_sec *err =
+			(struct hisi_pcie_local_err_sec *)event->error;
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
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_pcie_local_field_timestamp,
+			   0, event->timestamp);
+
+	trace_seq_printf(s, "\nHISI HIP08: PCIe local error\n");
+	decode_pcie_local_err_hdr(dec_tab, s, err);
+	decode_pcie_local_err_regs(dec_tab, s, err);
 
 	return 0;
 }
-- 
2.8.1


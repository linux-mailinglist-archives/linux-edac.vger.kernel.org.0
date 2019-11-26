Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88D14109DAD
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbfKZMQC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6714 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727717AbfKZMQC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:02 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DBAF6C749A254BAEF5CA;
        Tue, 26 Nov 2019 20:15:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:48 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 3/9] rasdaemon: split OEM type1 table decode function to reduce length
Date:   Tue, 26 Nov 2019 20:12:30 +0800
Message-ID: <1574770356-129510-4-git-send-email-tanxiaofei@huawei.com>
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

This patch splits function decode_hip08_oem_type1_error() to reduce
length. Move header decoding and register dump to single function
separately.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 76 ++++++++++++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 421e03c..79fc1b9 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -561,38 +561,13 @@ static int step_vendor_data_tab(struct ras_ns_dec_tab *dec_tab, char *name)
 }
 #endif
 
-/* error data decoding functions */
-static int decode_hip08_oem_type1_error(struct ras_events *ras,
-					struct ras_ns_dec_tab *dec_tab,
-					struct trace_seq *s,
-					struct ras_non_standard_event *event)
+static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
+				     struct trace_seq *s,
+				     const struct hisi_oem_type1_err_sec *err)
 {
-	const struct hisi_oem_type1_err_sec *err =
-			(struct hisi_oem_type1_err_sec*)event->error;
 	char buf[1024];
 	char *p = buf;
 
-	if (err->val_bits == 0) {
-		trace_seq_printf(s, "%s: no valid error information\n",
-				 __func__);
-		return -1;
-	}
-
-#ifdef HAVE_SQLITE3
-	if (!dec_tab->stmt_dec_record) {
-		if (ras_mc_add_vendor_table(ras, &dec_tab->stmt_dec_record,
-					    &hip08_oem_type1_event_tab)
-			!= SQLITE_OK) {
-			trace_seq_printf(s,
-					"create sql hip08_oem_type1_event_tab fail\n");
-			return -1;
-		}
-	}
-#endif
-	record_vendor_data(dec_tab, hisi_oem_data_type_text,
-			   hip08_oem_type1_field_timestamp,
-			   0, event->timestamp);
-
 	p += sprintf(p, "[ ");
 	p += sprintf(p, "table_version=%d ", err->version);
 	record_vendor_data(dec_tab, hisi_oem_data_type_int,
@@ -649,10 +624,16 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	}
 
 	p += sprintf(p, "]");
-	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
 	trace_seq_printf(s, "%s\n", buf);
+}
+
+static void decode_oem_type1_err_regs(struct ras_ns_dec_tab *dec_tab,
+				      struct trace_seq *s,
+				      const struct hisi_oem_type1_err_sec *err)
+{
+	char buf[1024];
+	char *p = buf;
 
-	p = buf;
 	trace_seq_printf(s, "Reg Dump:\n");
 	if (err->val_bits & HISI_OEM_TYPE1_VALID_ERR_MISC_0) {
 		trace_seq_printf(s, "ERR_MISC0=0x%x\n", err->err_misc_0);
@@ -689,6 +670,41 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 			   hip08_oem_type1_field_regs_dump, 0, buf);
 
 	step_vendor_data_tab(dec_tab, "hip08_oem_type1_event_tab");
+}
+
+/* error data decoding functions */
+static int decode_hip08_oem_type1_error(struct ras_events *ras,
+					struct ras_ns_dec_tab *dec_tab,
+					struct trace_seq *s,
+					struct ras_non_standard_event *event)
+{
+	const struct hisi_oem_type1_err_sec *err =
+			(struct hisi_oem_type1_err_sec*)event->error;
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
+	record_vendor_data(dec_tab, hisi_oem_data_type_text,
+			   hip08_oem_type1_field_timestamp,
+			   0, event->timestamp);
+
+	trace_seq_printf(s, "\nHISI HIP08: OEM Type-1 Error\n");
+	decode_oem_type1_err_hdr(dec_tab, s, err);
+	decode_oem_type1_err_regs(dec_tab, s, err);
 
 	return 0;
 }
-- 
2.8.1


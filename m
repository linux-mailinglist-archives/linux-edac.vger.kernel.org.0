Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2588109DAF
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfKZMQE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6718 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727761AbfKZMQD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:03 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E077CC634F8B1661B388;
        Tue, 26 Nov 2019 20:16:00 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:51 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 6/9] rasdaemon: fix magic number issues reported by static code analysis for hip08
Date:   Tue, 26 Nov 2019 20:12:33 +0800
Message-ID: <1574770356-129510-7-git-send-email-tanxiaofei@huawei.com>
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

Fix magic number issues reported by static code analysis for hip08.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index f2df496..dfb3e51 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -78,6 +78,14 @@
 #define HISI_PCIE_LOCAL_VALID_ERR_SEVERITY	BIT(8)
 #define HISI_PCIE_LOCAL_VALID_ERR_MISC		9
 
+#define HISI_PCIE_LOCAL_ERR_MISC_MAX	33
+#define HISI_BUF_LEN	1024
+
+#define HISI_ERR_SEVERITY_NFE	0
+#define HISI_ERR_SEVERITY_FE	1
+#define HISI_ERR_SEVERITY_CE	2
+#define HISI_ERR_SEVERITY_NONE	3
+
 struct hisi_oem_type1_err_sec {
 	uint32_t   val_bits;
 	uint8_t    version;
@@ -132,7 +140,7 @@ struct hisi_pcie_local_err_sec {
 	uint8_t    err_severity;
 	uint16_t   err_type;
 	uint8_t    reserv[2];
-	uint32_t   err_misc[33];
+	uint32_t   err_misc[HISI_PCIE_LOCAL_ERR_MISC_MAX];
 };
 
 enum hisi_oem_data_type {
@@ -193,10 +201,10 @@ struct hisi_module_info {
 static char *err_severity(uint8_t err_sev)
 {
 	switch (err_sev) {
-	case 0: return "recoverable";
-	case 1: return "fatal";
-	case 2: return "corrected";
-	case 3: return "none";
+	case HISI_ERR_SEVERITY_NFE: return "recoverable";
+	case HISI_ERR_SEVERITY_FE: return "fatal";
+	case HISI_ERR_SEVERITY_CE: return "corrected";
+	case HISI_ERR_SEVERITY_NONE: return "none";
 	}
 	return "unknown";
 }
@@ -565,7 +573,7 @@ static void decode_oem_type1_err_hdr(struct ras_ns_dec_tab *dec_tab,
 				     struct trace_seq *s,
 				     const struct hisi_oem_type1_err_sec *err)
 {
-	char buf[1024];
+	char buf[HISI_BUF_LEN];
 	char *p = buf;
 
 	p += sprintf(p, "[ ");
@@ -631,7 +639,7 @@ static void decode_oem_type1_err_regs(struct ras_ns_dec_tab *dec_tab,
 				      struct trace_seq *s,
 				      const struct hisi_oem_type1_err_sec *err)
 {
-	char buf[1024];
+	char buf[HISI_BUF_LEN];
 	char *p = buf;
 
 	trace_seq_printf(s, "Reg Dump:\n");
@@ -713,7 +721,7 @@ static void decode_oem_type2_err_hdr(struct ras_ns_dec_tab *dec_tab,
 				     struct trace_seq *s,
 				     const struct hisi_oem_type2_err_sec *err)
 {
-	char buf[1024];
+	char buf[HISI_BUF_LEN];
 	char *p = buf;
 
 	p += sprintf(p, "[ ");
@@ -778,7 +786,7 @@ static void decode_oem_type2_err_regs(struct ras_ns_dec_tab *dec_tab,
 				      struct trace_seq *s,
 				      const struct hisi_oem_type2_err_sec *err)
 {
-	char buf[1024];
+	char buf[HISI_BUF_LEN];
 	char *p = buf;
 
 	trace_seq_printf(s, "Reg Dump:\n");
@@ -871,7 +879,7 @@ static void decode_pcie_local_err_hdr(struct ras_ns_dec_tab *dec_tab,
 				      struct trace_seq *s,
 				      const struct hisi_pcie_local_err_sec *err)
 {
-	char buf[1024];
+	char buf[HISI_BUF_LEN];
 	char *p = buf;
 
 	p += sprintf(p, "[ ");
@@ -944,12 +952,12 @@ static void decode_pcie_local_err_regs(struct ras_ns_dec_tab *dec_tab,
 				       struct trace_seq *s,
 				       const struct hisi_pcie_local_err_sec *err)
 {
-	char buf[1024];
+	char buf[HISI_BUF_LEN];
 	char *p = buf;
 	uint32_t i;
 
 	trace_seq_printf(s, "Reg Dump:\n");
-	for (i = 0; i < 33; i++) {
+	for (i = 0; i < HISI_PCIE_LOCAL_ERR_MISC_MAX; i++) {
 		if (err->val_bits & BIT(HISI_PCIE_LOCAL_VALID_ERR_MISC + i)) {
 			trace_seq_printf(s, "ERR_MISC_%d=0x%x\n", i,
 					 err->err_misc[i]);
-- 
2.8.1


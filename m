Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81E22F789
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jul 2020 20:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731575AbgG0SPH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jul 2020 14:15:07 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:18368 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728214AbgG0SPF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jul 2020 14:15:05 -0400
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RIBYK8007070;
        Mon, 27 Jul 2020 18:15:03 GMT
Received: from g4t3425.houston.hpe.com (g4t3425.houston.hpe.com [15.241.140.78])
        by mx0b-002e3701.pphosted.com with ESMTP id 32ge1nrsff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Jul 2020 18:15:03 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g4t3425.houston.hpe.com (Postfix) with ESMTP id 55236A1;
        Mon, 27 Jul 2020 18:15:02 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 201855)
        id 1C58B2006D2B4; Mon, 27 Jul 2020 13:15:02 -0500 (CDT)
From:   Alex Kluver <alex.kluver@hpe.com>
To:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, mchehab@kernel.org, russ.anderson@hpe.com,
        dimitri.sivanich@hpe.com, Alex Kluver <alex.kluver@hpe.com>
Subject: [PATCH] edac,ghes,cper: Add Row Extension to Memory Error Record
Date:   Mon, 27 Jul 2020 13:14:45 -0500
Message-Id: <20200727181445.111002-1-alex.kluver@hpe.com>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_13:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270123
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Memory errors could be printed with incorrect row values since the DIMM
size has outgrown the 16 bit row field in the CPER structure. UEFI
Specification Version 2.8 has increased the size of row by allowing it to
use the first 2 bits from a previously reserved space within the structure.

When needed, add the extension bits to the row value printed.

Based on UEFI 2.8 Table 299. Memory Error Record

Tested-by: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Alex Kluver <alex.kluver@hpe.com>
---
 drivers/edac/ghes_edac.c    | 10 ++++++++--
 drivers/firmware/efi/cper.c | 11 +++++++++--
 include/linux/cper.h        |  9 +++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..cfa3156300f5 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -337,8 +337,14 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 		p += sprintf(p, "rank:%d ", mem_err->rank);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BANK)
 		p += sprintf(p, "bank:%d ", mem_err->bank);
-	if (mem_err->validation_bits & CPER_MEM_VALID_ROW)
-		p += sprintf(p, "row:%d ", mem_err->row);
+	if (mem_err->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
+		u32 row_extended = 0;
+		if (mem_err->validation_bits & CPER_MEM_VALID_ROW_EXT)
+			row_extended = (mem_err->extended & CPER_MEM_EXT_ROW_MASK)
+				<<CPER_MEM_EXT_ROW_SHIFT;
+		row_extended |= mem_err->row;
+		p += sprintf(p, "row:%d ", row_extended);
+	}
 	if (mem_err->validation_bits & CPER_MEM_VALID_COLUMN)
 		p += sprintf(p, "col:%d ", mem_err->column);
 	if (mem_err->validation_bits & CPER_MEM_VALID_BIT_POSITION)
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index f564e15fbc7e..5faaf6ecd659 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -234,8 +234,14 @@ static int cper_mem_err_location(struct cper_mem_err_compact *mem, char *msg)
 		n += scnprintf(msg + n, len - n, "bank: %d ", mem->bank);
 	if (mem->validation_bits & CPER_MEM_VALID_DEVICE)
 		n += scnprintf(msg + n, len - n, "device: %d ", mem->device);
-	if (mem->validation_bits & CPER_MEM_VALID_ROW)
-		n += scnprintf(msg + n, len - n, "row: %d ", mem->row);
+	if (mem->validation_bits & (CPER_MEM_VALID_ROW | CPER_MEM_VALID_ROW_EXT)) {
+		u32 row_extended = 0;
+		if (mem->validation_bits & CPER_MEM_VALID_ROW_EXT)
+			row_extended = (mem->extended & CPER_MEM_EXT_ROW_MASK)
+				<<CPER_MEM_EXT_ROW_SHIFT;
+		row_extended |= mem->row;
+		n += scnprintf(msg + n, len - n, "row: %d ", row_extended);
+	}
 	if (mem->validation_bits & CPER_MEM_VALID_COLUMN)
 		n += scnprintf(msg + n, len - n, "column: %d ", mem->column);
 	if (mem->validation_bits & CPER_MEM_VALID_BIT_POSITION)
@@ -292,6 +298,7 @@ void cper_mem_err_pack(const struct cper_sec_mem_err *mem,
 	cmem->requestor_id = mem->requestor_id;
 	cmem->responder_id = mem->responder_id;
 	cmem->target_id = mem->target_id;
+	cmem->extended = mem->extended;
 	cmem->rank = mem->rank;
 	cmem->mem_array_handle = mem->mem_array_handle;
 	cmem->mem_dev_handle = mem->mem_dev_handle;
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 8537e9282a65..c8313753ee49 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -230,6 +230,10 @@ enum {
 #define CPER_MEM_VALID_RANK_NUMBER		0x8000
 #define CPER_MEM_VALID_CARD_HANDLE		0x10000
 #define CPER_MEM_VALID_MODULE_HANDLE		0x20000
+#define CPER_MEM_VALID_ROW_EXT			0x40000
+
+#define CPER_MEM_EXT_ROW_MASK			0x3
+#define CPER_MEM_EXT_ROW_SHIFT			16
 
 #define CPER_PCIE_VALID_PORT_TYPE		0x0001
 #define CPER_PCIE_VALID_VERSION			0x0002
@@ -443,7 +447,7 @@ struct cper_sec_mem_err_old {
 	u8	error_type;
 };
 
-/* Memory Error Section (UEFI >= v2.3), UEFI v2.7 sec N.2.5 */
+/* Memory Error Section (UEFI >= v2.3), UEFI v2.8 sec N.2.5 */
 struct cper_sec_mem_err {
 	u64	validation_bits;
 	u64	error_status;
@@ -461,7 +465,7 @@ struct cper_sec_mem_err {
 	u64	responder_id;
 	u64	target_id;
 	u8	error_type;
-	u8	reserved;
+	u8	extended;
 	u16	rank;
 	u16	mem_array_handle;	/* "card handle" in UEFI 2.4 */
 	u16	mem_dev_handle;		/* "module handle" in UEFI 2.4 */
@@ -483,6 +487,7 @@ struct cper_mem_err_compact {
 	u16	rank;
 	u16	mem_array_handle;
 	u16	mem_dev_handle;
+	u8      extended;
 };
 
 /* PCI Express Error Section, UEFI v2.7 sec N.2.7 */

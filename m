Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3875ACFA2D
	for <lists+linux-edac@lfdr.de>; Tue,  8 Oct 2019 14:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730890AbfJHMmB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Oct 2019 08:42:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730605AbfJHMmA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 8 Oct 2019 08:42:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 49AA22F73986B259C67F;
        Tue,  8 Oct 2019 20:41:58 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Tue, 8 Oct 2019 20:41:48 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 3/5] rasdaemon: change submodule ID of sqlite3 DB field to text for hip08
Date:   Tue, 8 Oct 2019 20:38:56 +0800
Message-ID: <1570538338-230884-4-git-send-email-tanxiaofei@huawei.com>
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

Change submodule ID of sqlite3 DB field from integer to text for hip08
to make it easier to understand by user.

For example, from:
INSERT INTO hip08_oem_type2_event VALUES(1,1,1,0,0,'SMMU',2,
'corrected','');

change to:
INSERT INTO hip08_oem_type2_event VALUES(1,1,1,0,0,'SMMU','MGMT_SMMU',
'corrected','');

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 113 +++++++++++++++++++++++++++-------------------
 1 file changed, 67 insertions(+), 46 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 9de7be8..002f4bf 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -46,8 +46,8 @@
 /* HISI OEM format2 error definitions */
 #define HISI_OEM_MODULE_ID_SMMU	0
 #define HISI_OEM_MODULE_ID_HHA	1
-#define HISI_OEM_MODULE_ID_HLLC	2
-#define HISI_OEM_MODULE_ID_PA	3
+#define HISI_OEM_MODULE_ID_PA	2
+#define HISI_OEM_MODULE_ID_HLLC	3
 #define HISI_OEM_MODULE_ID_DDRC	4
 
 #define HISI_OEM_TYPE2_VALID_ERR_FR	BIT(6)
@@ -217,48 +217,61 @@ static char *oem_type2_module_name(uint8_t module_id)
 	return "unknown module";
 }
 
-static char *oem_type2_sub_module_id(char *p, uint8_t module_id,
-				     uint8_t sub_module_id)
+static const char *smmu_submodule_name[] = {
+	"HAC_SMMU",
+	"PCIE_SMMU",
+	"MGMT_SMMU",
+	"NIC_SMMU",
+};
+
+static const char *hllc_submodule_name[] = {
+	"HLLC0",
+	"HLLC1",
+	"HLLC2",
+};
+
+static const char *hha_submodule_name[] = {
+	"TA_HHA0",
+	"TA_HHA1",
+	"TB_HHA0",
+	"TB_HHA1"
+};
+
+static const char *ddrc_submodule_name[] = {
+	"TA_DDRC0",
+	"TA_DDRC1",
+	"TA_DDRC2",
+	"TA_DDRC3",
+	"TB_DDRC0",
+	"TB_DDRC1",
+	"TB_DDRC2",
+	"TB_DDRC3",
+};
+
+static const char *oem_type2_sub_module_name(uint8_t module_id, uint8_t sub_module_id)
 {
 	switch (module_id) {
 	case HISI_OEM_MODULE_ID_SMMU:
+		if (sub_module_id < sizeof(smmu_submodule_name)/sizeof(char *))
+			return smmu_submodule_name[sub_module_id];
+		break;
 	case HISI_OEM_MODULE_ID_HLLC:
-	case HISI_OEM_MODULE_ID_PA:
-		p += sprintf(p, "%d ", sub_module_id);
+		if (sub_module_id < sizeof(hllc_submodule_name)/sizeof(char *))
+			return hllc_submodule_name[sub_module_id];
 		break;
-
+	case HISI_OEM_MODULE_ID_PA:
+		return "PA";
 	case HISI_OEM_MODULE_ID_HHA:
-		if (sub_module_id == 0)
-			p += sprintf(p, "TA HHA0 ");
-		else if (sub_module_id == 1)
-			p += sprintf(p, "TA HHA1 ");
-		else if (sub_module_id == 2)
-			p += sprintf(p, "TB HHA0 ");
-		else if (sub_module_id == 3)
-			p += sprintf(p, "TB HHA1 ");
+		if (sub_module_id < sizeof(hha_submodule_name)/sizeof(char *))
+			return hha_submodule_name[sub_module_id];
 		break;
-
 	case HISI_OEM_MODULE_ID_DDRC:
-		if (sub_module_id == 0)
-			p += sprintf(p, "TA DDRC0 ");
-		else if (sub_module_id == 1)
-			p += sprintf(p, "TA DDRC1 ");
-		else if (sub_module_id == 2)
-			p += sprintf(p, "TA DDRC2 ");
-		else if (sub_module_id == 3)
-			p += sprintf(p, "TA DDRC3 ");
-		else if (sub_module_id == 4)
-			p += sprintf(p, "TB DDRC0 ");
-		else if (sub_module_id == 5)
-			p += sprintf(p, "TB DDRC1 ");
-		else if (sub_module_id == 6)
-			p += sprintf(p, "TB DDRC2 ");
-		else if (sub_module_id == 7)
-			p += sprintf(p, "TB DDRC3 ");
+		if (sub_module_id < sizeof(ddrc_submodule_name)/sizeof(char *))
+			return ddrc_submodule_name[sub_module_id];
 		break;
 	}
 
-	return p;
+	return "unknown";
 }
 
 static char *pcie_local_sub_module_name(uint8_t id)
@@ -281,7 +294,7 @@ static const struct db_fields hip08_oem_type1_event_fields[] = {
 	{ .name = "socket_id",		.type = "INTEGER" },
 	{ .name = "nimbus_id",		.type = "INTEGER" },
 	{ .name = "module_id",		.type = "TEXT" },
-	{ .name = "sub_module_id",	.type = "INTEGER" },
+	{ .name = "sub_module_id",	.type = "TEXT" },
 	{ .name = "err_severity",	.type = "TEXT" },
 	{ .name = "regs_dump",		.type = "TEXT" },
 };
@@ -299,7 +312,7 @@ static const struct db_fields hip08_oem_type2_event_fields[] = {
 	{ .name = "socket_id",          .type = "INTEGER" },
 	{ .name = "nimbus_id",          .type = "INTEGER" },
 	{ .name = "module_id",          .type = "TEXT" },
-	{ .name = "sub_module_id",      .type = "INTEGER" },
+	{ .name = "sub_module_id",      .type = "TEXT" },
 	{ .name = "err_severity",       .type = "TEXT" },
 	{ .name = "regs_dump",		.type = "TEXT" },
 };
@@ -437,17 +450,23 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
-		p += sprintf(p, "module=%s-",
+		p += sprintf(p, "module=%s ",
 			     oem_type1_module_name(err->module_id));
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_module_id,
 				   0, oem_type1_module_name(err->module_id));
-		if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
-			p += sprintf(p, "%d ", err->sub_module_id);
-			record_vendor_data(dec_tab, hisi_oem_data_type_int,
-					   hip08_oem_type1_field_sub_module_id,
-					   err->sub_module_id, NULL);
-		}
+	}
+
+	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
+		char submodule_name[64];
+
+		sprintf(submodule_name, "%s%d",
+			oem_type1_module_name(err->module_id),
+			err->sub_module_id);
+		p += sprintf(p, "submodule=%s ", submodule_name);
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
+				   hip08_oem_type1_field_sub_module_id,
+				   0, submodule_name);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
@@ -562,11 +581,13 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
-		p =  oem_type2_sub_module_id(p, err->module_id,
-					     err->sub_module_id);
-		record_vendor_data(dec_tab, hisi_oem_data_type_int,
+		const char *str = oem_type2_sub_module_name(err->module_id,
+							    err->sub_module_id);
+
+		p += sprintf(p, "submodule=%s ", str);
+		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type2_field_sub_module_id,
-				   err->sub_module_id, NULL);
+				   0, str);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
-- 
2.8.1


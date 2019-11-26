Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37C19109DB0
	for <lists+linux-edac@lfdr.de>; Tue, 26 Nov 2019 13:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfKZMQF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Nov 2019 07:16:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6715 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727615AbfKZMQF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Nov 2019 07:16:05 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EDCC8DF58BAEA934655D;
        Tue, 26 Nov 2019 20:15:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Tue, 26 Nov 2019 20:15:46 +0800
From:   Xiaofei Tan <tanxiaofei@huawei.com>
To:     <mchehab@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Xiaofei Tan <tanxiaofei@huawei.com>, <linuxarm@huawei.com>,
        <shiju.jose@huawei.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH v2 1/9] rasdaemon: decode submodule of OEM type1 for hip08
Date:   Tue, 26 Nov 2019 20:12:28 +0800
Message-ID: <1574770356-129510-2-git-send-email-tanxiaofei@huawei.com>
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

Decode submodule of OEM type1 for hip08, and reconstruct the functions
of geting OEM module name and submodule name.

Signed-off-by: Xiaofei Tan <tanxiaofei@huawei.com>
---
 non-standard-hisi_hip08.c | 283 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 219 insertions(+), 64 deletions(-)

diff --git a/non-standard-hisi_hip08.c b/non-standard-hisi_hip08.c
index 5e4b6a0..6fff21a 100644
--- a/non-standard-hisi_hip08.c
+++ b/non-standard-hisi_hip08.c
@@ -182,6 +182,13 @@ enum {
 	hip08_pcie_local_field_regs_dump,
 };
 
+struct hisi_module_info {
+	int id;
+	const char *name;
+	const char **sub;
+	int sub_num;
+};
+
 /* helper functions */
 static char *err_severity(uint8_t err_sev)
 {
@@ -194,37 +201,137 @@ static char *err_severity(uint8_t err_sev)
 	return "unknown";
 }
 
-static char *oem_type1_module_name(uint8_t module_id)
-{
-	switch (module_id) {
-	case HISI_OEM_MODULE_ID_MN: return "MN";
-	case HISI_OEM_MODULE_ID_PLL: return "PLL";
-	case HISI_OEM_MODULE_ID_SLLC: return "SLLC";
-	case HISI_OEM_MODULE_ID_AA: return "AA";
-	case HISI_OEM_MODULE_ID_SIOE: return "SIOE";
-	case HISI_OEM_MODULE_ID_POE: return "POE";
-	case HISI_OEM_MODULE_ID_DISP: return "DISP";
-	case HISI_OEM_MODULE_ID_LPC: return "LPC";
-	case HISI_OEM_MODULE_ID_GIC: return "GIC";
-	case HISI_OEM_MODULE_ID_RDE: return "RDE";
-	case HISI_OEM_MODULE_ID_SAS: return "SAS";
-	case HISI_OEM_MODULE_ID_SATA: return "SATA";
-	case HISI_OEM_MODULE_ID_USB: return "USB";
-	}
-	return "unknown";
-}
+static const char *pll_submodule_name[] = {
+	"TB_PLL0",
+	"TB_PLL1",
+	"TB_PLL2",
+	"TB_PLL3",
+	"TA_PLL0",
+	"TA_PLL1",
+	"TA_PLL2",
+	"TA_PLL3",
+	"NIMBUS_PLL0",
+	"NIMBUS_PLL1",
+	"NIMBUS_PLL2",
+	"NIMBUS_PLL3",
+	"NIMBUS_PLL4",
+};
 
-static char *oem_type2_module_name(uint8_t module_id)
-{
-	switch (module_id) {
-	case HISI_OEM_MODULE_ID_SMMU: return "SMMU";
-	case HISI_OEM_MODULE_ID_HHA: return "HHA";
-	case HISI_OEM_MODULE_ID_HLLC: return "HLLC";
-	case HISI_OEM_MODULE_ID_PA: return "PA";
-	case HISI_OEM_MODULE_ID_DDRC: return "DDRC";
-	}
-	return "unknown module";
-}
+static const char *sllc_submodule_name[] = {
+	"TB_SLLC0",
+	"TB_SLLC1",
+	"TB_SLLC2",
+	"TA_SLLC0",
+	"TA_SLLC1",
+	"TA_SLLC2",
+	"NIMBUS_SLLC0",
+	"NIMBUS_SLLC1",
+};
+
+static const char *sioe_submodule_name[] = {
+	"TB_SIOE0",
+	"TB_SIOE1",
+	"TB_SIOE2",
+	"TB_SIOE3",
+	"TA_SIOE0",
+	"TA_SIOE1",
+	"TA_SIOE2",
+	"TA_SIOE3",
+	"NIMBUS_SIOE0",
+	"NIMBUS_SIOE1",
+};
+
+static const char *poe_submodule_name[] = {
+	"TB_POE",
+	"TA_POE",
+};
+
+static const char *disp_submodule_name[] = {
+	"TB_PERI_DISP",
+	"TB_POE_DISP",
+	"TB_GIC_DISP",
+	"TA_PERI_DISP",
+	"TA_POE_DISP",
+	"TA_GIC_DISP",
+	"HAC_DISP",
+	"PCIE_DISP",
+	"IO_MGMT_DISP",
+	"NETWORK_DISP",
+};
+
+static const char *sas_submodule_name[] = {
+	"SAS0",
+	"SAS1",
+};
+
+static const struct hisi_module_info hisi_oem_type1_module[] = {
+	{
+		.id = HISI_OEM_MODULE_ID_PLL,
+		.name = "PLL",
+		.sub = pll_submodule_name,
+		.sub_num = ARRAY_SIZE(pll_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_SAS,
+		.name = "SAS",
+		.sub = sas_submodule_name,
+		.sub_num = ARRAY_SIZE(sas_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_POE,
+		.name = "POE",
+		.sub = poe_submodule_name,
+		.sub_num = ARRAY_SIZE(poe_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_SLLC,
+		.name = "SLLC",
+		.sub = sllc_submodule_name,
+		.sub_num = ARRAY_SIZE(sllc_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_SIOE,
+		.name = "SIOE",
+		.sub = sioe_submodule_name,
+		.sub_num = ARRAY_SIZE(sioe_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_DISP,
+		.name = "DISP",
+		.sub = disp_submodule_name,
+		.sub_num = ARRAY_SIZE(disp_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_MN,
+		.name = "MN",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_AA,
+		.name = "AA",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_LPC,
+		.name = "LPC",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_GIC,
+		.name = "GIC",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_RDE,
+		.name = "RDE",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_SATA,
+		.name = "SATA",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_USB,
+		.name = "USB",
+	},
+	{
+	}
+};
 
 static const char *smmu_submodule_name[] = {
 	"HAC_SMMU",
@@ -257,27 +364,72 @@ static const char *ddrc_submodule_name[] = {
 	"TB_DDRC3",
 };
 
-static const char *oem_type2_sub_module_name(uint8_t module_id, uint8_t sub_module_id)
+static const struct hisi_module_info hisi_oem_type2_module[] = {
+	{
+		.id = HISI_OEM_MODULE_ID_SMMU,
+		.name = "SMMU",
+		.sub = smmu_submodule_name,
+		.sub_num = ARRAY_SIZE(smmu_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_HHA,
+		.name = "HHA",
+		.sub = hha_submodule_name,
+		.sub_num = ARRAY_SIZE(hha_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_PA,
+		.name = "PA",
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_HLLC,
+		.name = "HLLC",
+		.sub = hllc_submodule_name,
+		.sub_num = ARRAY_SIZE(hllc_submodule_name),
+	},
+	{
+		.id = HISI_OEM_MODULE_ID_DDRC,
+		.name = "DDRC",
+		.sub = ddrc_submodule_name,
+		.sub_num = ARRAY_SIZE(ddrc_submodule_name),
+	},
+	{
+	}
+};
+
+static const char *oem_module_name(const struct hisi_module_info *info,
+				   uint8_t module_id)
 {
-	switch (module_id) {
-	case HISI_OEM_MODULE_ID_SMMU:
-		if (sub_module_id < sizeof(smmu_submodule_name)/sizeof(char *))
-			return smmu_submodule_name[sub_module_id];
-		break;
-	case HISI_OEM_MODULE_ID_HLLC:
-		if (sub_module_id < sizeof(hllc_submodule_name)/sizeof(char *))
-			return hllc_submodule_name[sub_module_id];
-		break;
-	case HISI_OEM_MODULE_ID_PA:
-		return "PA";
-	case HISI_OEM_MODULE_ID_HHA:
-		if (sub_module_id < sizeof(hha_submodule_name)/sizeof(char *))
-			return hha_submodule_name[sub_module_id];
-		break;
-	case HISI_OEM_MODULE_ID_DDRC:
-		if (sub_module_id < sizeof(ddrc_submodule_name)/sizeof(char *))
-			return ddrc_submodule_name[sub_module_id];
-		break;
+	const struct hisi_module_info *module = &info[0];
+
+	for (; module->name; module++) {
+		if (module->id != module_id)
+			continue;
+
+		return module->name;
+	}
+
+	return "unknown";
+}
+
+static const char *oem_submodule_name(const struct hisi_module_info *info,
+				      uint8_t module_id, uint8_t sub_module_id)
+{
+	const struct hisi_module_info *module = &info[0];
+
+	for (; module->name; module++) {
+		const char **submodule = module->sub;
+
+		if (module->id != module_id)
+			continue;
+
+		if (module->sub == NULL)
+			return module->name;
+
+		if (sub_module_id >= module->sub_num)
+			return "unknown";
+
+		return submodule[sub_module_id];
 	}
 
 	return "unknown";
@@ -467,23 +619,24 @@ static int decode_hip08_oem_type1_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
-		p += sprintf(p, "module=%s ",
-			     oem_type1_module_name(err->module_id));
+		const char *str = oem_module_name(hisi_oem_type1_module,
+						  err->module_id);
+
+		p += sprintf(p, "module=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_module_id,
-				   0, oem_type1_module_name(err->module_id));
+				   0, str);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
-		char submodule_name[64];
+		const char *str = oem_submodule_name(hisi_oem_type1_module,
+						     err->module_id,
+						     err->sub_module_id);
 
-		sprintf(submodule_name, "%s%d",
-			oem_type1_module_name(err->module_id),
-			err->sub_module_id);
-		p += sprintf(p, "submodule=%s ", submodule_name);
+		p += sprintf(p, "submodule=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type1_field_sub_module_id,
-				   0, submodule_name);
+				   0, str);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_ERR_SEVERITY) {
@@ -596,16 +749,18 @@ static int decode_hip08_oem_type2_error(struct ras_events *ras,
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_MODULE_ID) {
-		p += sprintf(p, "module=%s ",
-			     oem_type2_module_name(err->module_id));
+		const char *str = oem_module_name(hisi_oem_type2_module,
+						  err->module_id);
+		p += sprintf(p, "module=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
 				   hip08_oem_type2_field_module_id,
-				   0, oem_type2_module_name(err->module_id));
+				   0, str);
 	}
 
 	if (err->val_bits & HISI_OEM_VALID_SUB_MODULE_ID) {
-		const char *str = oem_type2_sub_module_name(err->module_id,
-							    err->sub_module_id);
+		const char *str = oem_submodule_name(hisi_oem_type2_module,
+						     err->module_id,
+						     err->sub_module_id);
 
 		p += sprintf(p, "submodule=%s ", str);
 		record_vendor_data(dec_tab, hisi_oem_data_type_text,
-- 
2.8.1


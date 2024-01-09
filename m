Return-Path: <linux-edac+bounces-316-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD8D8283F5
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jan 2024 11:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 974BD1C21027
	for <lists+linux-edac@lfdr.de>; Tue,  9 Jan 2024 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254F3609D;
	Tue,  9 Jan 2024 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KPF2Fy4L"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E811364BB
	for <linux-edac@vger.kernel.org>; Tue,  9 Jan 2024 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1bXCR+ZBl0cwFhauSwWHOliRWFnBot4eWDbPO7kZ16xyB/ntEJ/yIWZmrHs51NVdk8uKOHfXF8T/ChXR8XuQhWt5Bby7jM3KJ5qRS+jJJiVQo9PH7wJmguxGo7xfTQ3MtbXIpdcXk0gqliiaLBhSklnBP2aGY0jhvkZ7HYUGn26A4XeWvDY5bhA1tk4KoUVGccGhnppHQVZZgpmNqjW1Y8UYNIj9ogRZFfICWLOTK+KtFsNKk8ojdj4IV+3XyRmx+OxPXV5djP8iVC9G+o+VlkWvsNl02r4ptGvXaRZfvOsUQWeOVzfL2MyJVrgDS+HKhtn5OLx+YoD5iFybuf8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mgwycve9wYLO7gwJv++6ruHSS0/LxCsRTNkSZfWxlLg=;
 b=CCRHkE8o+nuIBFMCDWL1DKMPLhByOD7mhTYF8eUdZVhxfCjsjBhkqElyt9RdEhxB+F8W9bMvtJPaGbx9rwjAOQd+esM75hkES2VsnNYo68c9oURJl8+rY/Xw4ve188y0Uk5jajfKMutvAr3/LxCrmpt3CdTzPepVgKjChaI2e94n1Q82sgdhq8a41ng0d3PyHHZAIUSOVZRjTEt80f6UYnUstz7oMBu+D4RrR7RAP8rb1drDW4Zq/NxCorntNW26YAPXZiOpPBrqEAP7EvziyIh2IdJJCcGJOfMQmVxNCEkrzxS0zxryJt5jT89cv8DYTWDO4DlFxFbAmk83tKliIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgwycve9wYLO7gwJv++6ruHSS0/LxCsRTNkSZfWxlLg=;
 b=KPF2Fy4LpdKDZJHE0PGc6VUiK7xpvdV3KX45PxvwWEMJkGDmMllQ6sh1RF/ZIawWQBGGFUGWBhqyomRPft9zzHL7MrT+hdAyknOC9w8e7tcHIevWomPgDaPO5WDNQVtJisYMDw2gnW9ms0cphEHQi3I2ekz8Ubnk/n6tt6as18c=
Received: from BL0PR02CA0072.namprd02.prod.outlook.com (2603:10b6:207:3d::49)
 by LV2PR12MB5773.namprd12.prod.outlook.com (2603:10b6:408:17b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 10:26:09 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:207:3d:cafe::ea) by BL0PR02CA0072.outlook.office365.com
 (2603:10b6:207:3d::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Tue, 9 Jan 2024 10:26:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Tue, 9 Jan 2024 10:26:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 9 Jan
 2024 04:26:08 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Tue, 9 Jan 2024 04:26:06 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <git@amd.com>, <shubhrajyoti.datta@amd.com>,
	<sai.krishna.potthuri@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<james.morse@arm.com>, <shubhrajyoti.datta@gmail.com>, <mchehab@kernel.org>,
	<rric@kernel.org>
Subject: [PATCH v2] EDAC/versal: Make the bits in error injection configurable
Date: Tue, 9 Jan 2024 15:56:05 +0530
Message-ID: <20240109102605.31600-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV2PR12MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: a505cf2d-33a4-4688-7712-08dc10fd659b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o5MWJdEBTHTa4rkAhj8jIe5tEnh8gfdpejzWL/vAi1+4qgzbZZXZzZ9XOKhYQcyzGomJKm0K6fAh8IidFPKYkO5NUEmhoQ1WPHXI1/XGccf3UwSAnwKn/5r2L89R1ZWIMYa6a7UVucixjVKGRkCTI7IfbDyYSfONhwzKe2wZmjdhljxOup8KI63Nvl2qLitf9m+0yYtdOe8d+4HM9euvRvZSBlsnet0HlZwhUts2vH0IScJvxTQ1jIn20b5SsTCT6+LUViJSO79DxbOpOtbz8xWw4HA6jVI1b2Ay/fGbv7Va0y8V2H4JffOdv53bQqauO1b2xTImOu6PTAuRqM94a0IAPfqQIV1uSKOzFbhFGQENsLPx+Hk6RMlUSpYSg+W4rfoKTL2qLAND91XKRkwo6GSHoiCrGDRjsBCu4JBKV4Q1cEz6D8uI3eIQAr21Vn0agx6daDbgtH2UQn7VuYN2pgo//Dr+wKX1PHvE5W1mDFFyyy57NDTeuU2xbaYHylDcREMcNDB6lc9zV1fvou+5YiTUqCBQEvWV+oIapU3SB4vBr5gClB7KMFlDQidJSK3QyXkWXz5fRX9fAWXMQgoy/8TiUUitoihoGmVkifhSRdVXtGxcRdavcp4rTYzpqOfmQ3FQvFwHWTHx0UDHxLbRDElvIVBdu4pWswBTAAP8JlF0j4ZTafA36Nc5NkXaihapPyDmiezLc7PaKTk0MYL3MWGpkRG+jQrgkUGlawocFnlSJsOemEvrg+iEw6m7n+GHZRuhgARU+RiosjjWsERh8g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(1076003)(2616005)(426003)(336012)(478600001)(26005)(82740400003)(356005)(36756003)(86362001)(81166007)(2906002)(41300700001)(36860700001)(5660300002)(83380400001)(6916009)(70586007)(70206006)(4326008)(54906003)(316002)(47076005)(8676002)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:26:09.6756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a505cf2d-33a4-4688-7712-08dc10fd659b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5773

Currently the error injection bits are hardcoded.
Make them configurable. Add separate entries to configure the
bits to inject errors.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>

---

Changes in v2:
- Update the descripotion to use first person
- Reorder the fops.
- Add null check for edac_debugfs_create_file

 drivers/edac/versal_edac.c | 140 ++++++++++++++++++++++++++++++++-----
 1 file changed, 121 insertions(+), 19 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 8625de20fc71..1c9ab41ec67b 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -42,8 +42,11 @@
 
 #define ECCW0_FLIP_CTRL				0x109C
 #define ECCW0_FLIP0_OFFSET			0x10A0
+#define ECCW0_FLIP0_BITS			31
+#define ECCW0_FLIP1_OFFSET			0x10A4
 #define ECCW1_FLIP_CTRL				0x10AC
 #define ECCW1_FLIP0_OFFSET			0x10B0
+#define ECCW1_FLIP1_OFFSET			0x10B4
 #define ECCR0_CERR_STAT_OFFSET			0x10BC
 #define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
 #define ECCR0_CE_ADDR_HI_OFFSET			0x10C4
@@ -142,6 +145,7 @@
 #define XILINX_DRAM_SIZE_12G			3
 #define XILINX_DRAM_SIZE_16G			4
 #define XILINX_DRAM_SIZE_32G			5
+#define NUM_UE_BITPOS				2
 
 /**
  * struct ecc_error_info - ECC error log information.
@@ -734,38 +738,43 @@ static void poison_setup(struct edac_priv *priv)
 	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC15_OFFSET);
 }
 
-static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
-					     const char __user *data)
+static int xddr_inject_data_ce_store(struct mem_ctl_info *mci, u8 ce_bitpos)
 {
 	struct edac_priv *priv = mci->pvt_info;
 
 	writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
 	writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);
 
-	if (strncmp(data, "CE", 2) == 0) {
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
+	if (ce_bitpos < ECCW0_FLIP0_BITS) {
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
 		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
 		       ECCW1_FLIP0_OFFSET);
 	} else {
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW0_FLIP0_OFFSET);
-		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
-		       ECCW1_FLIP0_OFFSET);
+		ce_bitpos = ce_bitpos - ECCW0_FLIP0_BITS;
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
+		       ECCW0_FLIP1_OFFSET);
+		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
+		       ECCW1_FLIP1_OFFSET);
 	}
 
-	/* Lock the PCSR registers */
-	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
-
 	return 0;
 }
 
-static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
-					size_t count, loff_t *ppos)
+/*
+ * Correctable errors are injected on system Write transaction data by configuring
+ * address mask/match registers to select transactions to have errors,
+ * and by configuring bit flip registers to select how to corrupt write data
+ * (which bits are corrupted).
+ */
+static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
 {
 	struct device *dev = file->private_data;
 	struct mem_ctl_info *mci = to_mci(dev);
 	struct edac_priv *priv = mci->pvt_info;
+	u8 ce_bitpos;
+	int ret;
 
 	/* Unlock the PCSR registers */
 	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
@@ -773,17 +782,101 @@ static ssize_t inject_data_poison_store(struct file *file, const char __user *da
 
 	poison_setup(priv);
 
+	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
+	if (ret)
+		return ret;
+
+	ret = xddr_inject_data_ce_store(mci, ce_bitpos);
+
 	/* Lock the PCSR registers */
 	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	return count;
+}
+
+static const struct file_operations xddr_inject_ce_fops = {
+	.open = simple_open,
+	.write = inject_data_ce_store,
+	.llseek = generic_file_llseek,
+};
+
+static void xddr_inject_data_ue_store(struct mem_ctl_info *mci, u32 val0, u32 val1)
+{
+	struct edac_priv *priv = mci->pvt_info;
+
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
+	writel(val0, priv->ddrmc_baseaddr + ECCW0_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+	writel(val1, priv->ddrmc_baseaddr + ECCW1_FLIP1_OFFSET);
+}
+
+/*
+ * Uncorrectable errors are injected on system Write transaction data by configuring
+ * address mask/match registers to select transactions to have errors,
+ * and by configuring bit flip registers to select how to corrupt write data
+ * (which bits are corrupted). For uncorrectable errors more than one bits
+ * are corrupted.
+ */
+static ssize_t inject_data_ue_store(struct file *file, const char __user *data,
+				    size_t count, loff_t *ppos)
+{
+	struct device *dev = file->private_data;
+	struct mem_ctl_info *mci = to_mci(dev);
+	struct edac_priv *priv = mci->pvt_info;
+	char buf[6], *pbuf, *token[2];
+	u32 val0 = 0, val1 = 0;
+	u8 len, ue0, ue1;
+	int i, ret;
+
+	len = min_t(size_t, count, sizeof(buf));
+	if (copy_from_user(buf, data, len))
+		return -EFAULT;
+
+	buf[len] = '\0';
+	pbuf = &buf[0];
+	for (i = 0; i < NUM_UE_BITPOS; i++)
+		token[i] = strsep(&pbuf, ",");
+
+	ret = kstrtou8(token[0], 0, &ue0);
+	if (ret)
+		return ret;
+
+	ret = kstrtou8(token[1], 0, &ue1);
+	if (ret)
+		return ret;
+
+	if (ue0 < ECCW0_FLIP0_BITS) {
+		val0 = BIT(ue0);
+	} else {
+		ue0 = ue0 - ECCW0_FLIP0_BITS;
+		val1 = BIT(ue0);
+	}
+
+	if (ue1 < ECCW0_FLIP0_BITS) {
+		val0 |= BIT(ue1);
+	} else {
+		ue1 = ue1 - ECCW0_FLIP0_BITS;
+		val1 |= BIT(ue1);
+	}
+
+	/* Unlock the PCSR registers */
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(PCSR_UNLOCK_VAL, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+
+	poison_setup(priv);
 
-	xddr_inject_data_poison_store(mci, data);
+	xddr_inject_data_ue_store(mci, val0, val1);
 
+	/* Lock the PCSR registers */
+	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
+	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
 	return count;
 }
 
-static const struct file_operations xddr_inject_enable_fops = {
+static const struct file_operations xddr_inject_ue_fops = {
 	.open = simple_open,
-	.write = inject_data_poison_store,
+	.write = inject_data_ue_store,
 	.llseek = generic_file_llseek,
 };
 
@@ -795,8 +888,17 @@ static void create_debugfs_attributes(struct mem_ctl_info *mci)
 	if (!priv->debugfs)
 		return;
 
-	edac_debugfs_create_file("inject_error", 0200, priv->debugfs,
-				 &mci->dev, &xddr_inject_enable_fops);
+	if (!edac_debugfs_create_file("inject_ce", 0200, priv->debugfs,
+				      &mci->dev, &xddr_inject_ce_fops)) {
+		debugfs_remove_recursive(priv->debugfs);
+		return;
+	}
+
+	if (!edac_debugfs_create_file("inject_ue", 0200, priv->debugfs,
+				      &mci->dev, &xddr_inject_ue_fops)) {
+		debugfs_remove_recursive(priv->debugfs);
+		return;
+	}
 	debugfs_create_x64("address", 0600, priv->debugfs,
 			   &priv->err_inject_addr);
 	mci->debugfs = priv->debugfs;
-- 
2.17.1



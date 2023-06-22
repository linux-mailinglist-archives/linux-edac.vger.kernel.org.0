Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E426B739789
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjFVGmY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 02:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjFVGmX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 02:42:23 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBC019AB;
        Wed, 21 Jun 2023 23:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fG+ccaxzmSnRKED7nKS2/czB8QPXDTe/OI2UWNzgH5v3+5ZMaUW1D/Bhi3Km79a/gv7DxLG3dGvo3+iqgBXLbVZiDhv3phwMMUqAxSXYt0TLqveOACvNQlHwBvxYBI6+K13nAJBe8byTLW93Zar9or44xdo1LjPC1GzREIOHKW2d1gLxUYPzKLryYjmIMxNVrt/J3v27NCU7dO9eq7eEnvLPsAvPPRfmg/xlnCuj8u4iPSOTcs7qT8iRBz/8TTsD0epylYs5GVb0YTV668aA3cBbmuMGOJiDV6132c4ulb4fxI/oSxWw6E3rU1IQRL/M4g837mZf9Z5S4ciusiD93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMqa0n9bFoHl7hzK9wPRKnG5YOiXC3bMF5kUyIN0OUI=;
 b=jmq12+pppJOzM59AD9DYX4HIFOHOVXmd9iUCZTDf+dsnnv/dx+vhoD5n6uS7Pj8LEJiz/xiex2qt20LsYRiOFud/GmWgk/SuMIBH9WuGwKSmrSXcoL+xbiveoyCqEedcsi3w0BLSej/WS/7jBagAtwpiKYjSCrTwqZa8JsTK1nNJYrTC2sLMvT8/4awpQ+4f2NxRnMGrsgJ2rDzUEQG6jn+WcX8DyQUrFSpmkOeHgbRpsm1QqJQ/nj4nfD5O9S19hqsbR9mWCQU6/c0AFOEykR4h7K1fdMvBTLb1abPzljmQ2Tr/D0I1bYhYQwr5/j343oNrgdpAx8PSfKt4tCqt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMqa0n9bFoHl7hzK9wPRKnG5YOiXC3bMF5kUyIN0OUI=;
 b=S0akqZ/nP/Pe3RzM9tsB/UJHFS/zECrbw0pzkiOZSaNl5conSJl7Ct4yAroplV/ShuJrDW++BzRX/vObIaQ3S2kZYTagB5M9qw7f36RuTv9PXuiKUueWdUF27Ns3UJvbinAF0sJlmoFF5N3PU2Kd25MjM9cvjxlTFeRDdUvJ0OZUUs2L5Z5Qfmmue1ssqXrb9+0qUCEffR/hdGuBlhU0+8gMkbhzM/vDFvbpNN3rV812GQs48Du/5+zO4qXNx0hpQTOUd81Uhn55PUwcRPTOB5mAJyXfmburJESjkiQolbQt4L2Dezhi+XWoiZ6fB8NTgHuzjnFSDJxYV/Y+AO5BQA==
Received: from BY3PR04CA0010.namprd04.prod.outlook.com (2603:10b6:a03:217::15)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Thu, 22 Jun
 2023 06:42:19 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a03:217:cafe::d6) by BY3PR04CA0010.outlook.office365.com
 (2603:10b6:a03:217::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 06:42:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 06:42:19 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 21 Jun 2023
 23:42:08 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 21 Jun
 2023 23:42:08 -0700
Received: from vdi.nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 21 Jun
 2023 23:42:07 -0700
From:   Shravan Kumar Ramani <shravankr@nvidia.com>
To:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
CC:     Shravan Kumar Ramani <shravankr@nvidia.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v0 RESEND] EDAC/bluefield_edac: Add SMC support
Date:   Thu, 22 Jun 2023 02:42:04 -0400
Message-ID: <6cdf948948ddd9d5e8ff770b001a7c123465a8ea.1682581034.git.shravankr@nvidia.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 7475b909-733f-48ed-37b1-08db72ebd386
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eDIKVeYf/MeIIP434C9Q8dqjV2jI8F22mjy3xBWkTnfol0+rh7B1jNysTA33xfVN6qRnP6NZqmoQLzx1eCpZ/NdYdGdejmsOPEQeu+8dJmI1vdoAvcFlEdC/Z32/z37fvEusfAaBSoTo8URqCS4rgBqVrZFrnVOo6twG8c3Y8lDFwzTMotKUvAxZQ4bCQeSj/W2XenPnl+sYZ3b7YG+2ntv2T/tToCfD0A1zjntgMtfy9y4hWBkTLeJaqK56/CeQUgMpw70iECqnjkRDA++uLzVpnKA2OeFOkB0RGRfXSnmTrHiHX5f3T62WAMDBGDhTfhdBd61W6QLkcrIlt6E2QGlcdPe3dhI8nbAc4YZr/aAO42X066KD46mjY2gsc+LBuRzYRGC8sx3tcHA4508Y/B141ljOM6l9efDbe6KUDGNcJnJ4180xgQUtGnJHewmXatig8FLT/76/OSmxZGAuIYipE33y3BhK7u19dHM5TIHQmYmNv8e8tf6Ku6NysRmNfmnJRoztqYCVQ584GfR5MnGRldEXSd/+EzUqp5lipIKJBGCNX+ZGE5vNkX0/k80r2dT0iH+uVP/x/HwBiOsmjBPDfX4cIBIwLv63Mi+Btroz6BDr/RPVzJUI5q38fC7agadtUADG/hIRDK9Hm1oXxCbIMy7Pi8Eh3yqg9Cpw78enI3EtWsX5wpvH1nnCwdrU4UP4Qz2LcRY3OWID0XVbNTfWCgHnUUwrBQRVIBk0gWbmMk1mMOT42u3+zjAW5J+3
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(8936002)(83380400001)(54906003)(6666004)(7696005)(316002)(41300700001)(8676002)(26005)(36756003)(86362001)(4326008)(2616005)(186003)(336012)(5660300002)(70206006)(82310400005)(110136005)(70586007)(426003)(7636003)(356005)(40460700003)(82740400003)(2906002)(478600001)(36860700001)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 06:42:19.3789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7475b909-733f-48ed-37b1-08db72ebd386
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add secure read/write calls to bluefield_edac. The ACPI
table entry decides whether the secure calls need to be
used for accessing the EMI registers.

Signed-off-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
 drivers/edac/bluefield_edac.c | 176 ++++++++++++++++++++++++++++++----
 1 file changed, 156 insertions(+), 20 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index e4736eb37bfb..cb9e42ef64d1 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -47,13 +47,25 @@
 #define MLXBF_EDAC_MAX_DIMM_PER_MC	2
 #define MLXBF_EDAC_ERROR_GRAIN		8
 
+#define MLXBF_WRITE_REG_32		(0x82000009)
+#define MLXBF_READ_REG_32		(0x8200000A)
+#define MLXBF_WRITE_REG_64		(0x8200000B)
+#define MLXBF_READ_REG_64		(0x8200000C)
+#define MLXBF_SIP_SVC_UID		(0x8200ff01)
+#define MLXBF_SIP_SVC_VERSION		(0x8200ff03)
+
+#define MLXBF_SMCCC_ACCESS_VIOLATION	(-4)
+
+#define MLXBF_SVC_REQ_MAJOR		0
+#define MLXBF_SVC_REQ_MINOR		3
+
 /*
- * Request MLNX_SIP_GET_DIMM_INFO
+ * Request MLXBF_SIP_GET_DIMM_INFO
  *
  * Retrieve information about DIMM on a certain slot.
  *
  * Call register usage:
- * a0: MLNX_SIP_GET_DIMM_INFO
+ * a0: MLXBF_SIP_GET_DIMM_INFO
  * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
  * a2-7: not used.
  *
@@ -61,7 +73,7 @@
  * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
  * a1-3: not used.
  */
-#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
 
 /* Format for the SMC response about the memory information */
 #define MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0)
@@ -72,9 +84,12 @@
 #define MLXBF_DIMM_INFO__PACKAGE_X GENMASK_ULL(31, 24)
 
 struct bluefield_edac_priv {
+	struct device *dev;
 	int dimm_ranks[MLXBF_EDAC_MAX_DIMM_PER_MC];
 	void __iomem *emi_base;
 	int dimm_per_mc;
+	bool svc_sreg_support;
+	u32 sreg_tbl_edac;
 };
 
 static u64 smc_call1(u64 smc_op, u64 smc_arg)
@@ -86,6 +101,71 @@ static u64 smc_call1(u64 smc_op, u64 smc_arg)
 	return res.a0;
 }
 
+static int secure_readl(void __iomem *addr, uint32_t *result, uint32_t sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_READ_REG_32, sreg_tbl, (uintptr_t)addr,
+		      0, 0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		*result = (uint32_t)res.a1;
+		return 0;
+	}
+}
+
+static int secure_writel(void __iomem *addr, uint32_t data, uint32_t sreg_tbl)
+{
+	struct arm_smccc_res res;
+	int status;
+
+	arm_smccc_smc(MLXBF_WRITE_REG_32, sreg_tbl, data, (uintptr_t)addr,
+		      0, 0, 0, 0, &res);
+
+	status = res.a0;
+
+	switch (status) {
+	case SMCCC_RET_NOT_SUPPORTED:
+	case MLXBF_SMCCC_ACCESS_VIOLATION:
+		return -1;
+	default:
+		return 0;
+	}
+}
+
+static int edac_readl(void __iomem *addr, uint32_t *result,
+		      bool sreg_support, uint32_t sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = secure_readl(addr, result, sreg_tbl);
+	else
+		*result = readl(addr);
+
+	return err;
+}
+
+static int edac_writel(void __iomem *addr, uint32_t data,
+		       bool sreg_support, uint32_t sreg_tbl)
+{
+	int err = 0;
+
+	if (sreg_support)
+		err = secure_writel(addr, data, sreg_tbl);
+	else
+		writel(data, addr);
+
+	return err;
+}
+
 /*
  * Gather the ECC information from the External Memory Interface registers
  * and report it to the edac handler.
@@ -99,7 +179,7 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	u32 ecc_latch_select, dram_syndrom, serr, derr, syndrom;
 	enum hw_event_mc_err_type ecc_type;
 	u64 ecc_dimm_addr;
-	int ecc_dimm;
+	int ecc_dimm, err;
 
 	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
 				   HW_EVENT_ERR_UNCORRECTED;
@@ -109,14 +189,22 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 	 * registers with information about the last ECC error occurrence.
 	 */
 	ecc_latch_select = MLXBF_ECC_LATCH_SEL__START;
-	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
+	err = edac_writel(priv->emi_base + MLXBF_ECC_LATCH_SEL,
+			  ecc_latch_select, priv->svc_sreg_support,
+			  priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC latch select write failed.\n");
 
 	/*
 	 * Verify that the ECC reported info in the registers is of the
 	 * same type as the one asked to report. If not, just report the
 	 * error without the detailed information.
 	 */
-	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
+	err = edac_readl(priv->emi_base + MLXBF_SYNDROM, &dram_syndrom,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM syndrom read failed.\n");
+
 	serr = FIELD_GET(MLXBF_SYNDROM__SERR, dram_syndrom);
 	derr = FIELD_GET(MLXBF_SYNDROM__DERR, dram_syndrom);
 	syndrom = FIELD_GET(MLXBF_SYNDROM__SYN, dram_syndrom);
@@ -127,13 +215,24 @@ static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
 		return;
 	}
 
-	dram_additional_info = readl(priv->emi_base + MLXBF_ADD_INFO);
+	err = edac_readl(priv->emi_base + MLXBF_ADD_INFO, &dram_additional_info,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "DRAM additional info read failed.\n");
+
 	err_prank = FIELD_GET(MLXBF_ADD_INFO__ERR_PRANK, dram_additional_info);
 
 	ecc_dimm = (err_prank >= 2 && priv->dimm_ranks[0] <= 2) ? 1 : 0;
 
-	edea0 = readl(priv->emi_base + MLXBF_ERR_ADDR_0);
-	edea1 = readl(priv->emi_base + MLXBF_ERR_ADDR_1);
+	err = edac_readl(priv->emi_base + MLXBF_ERR_ADDR_0, &edea0,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 0 read failed.\n");
+
+	err = edac_readl(priv->emi_base + MLXBF_ERR_ADDR_1, &edea1,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "Error addr 1 read failed.\n");
 
 	ecc_dimm_addr = ((u64)edea1 << 32) | edea0;
 
@@ -147,6 +246,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
 	u32 ecc_count, single_error_count, double_error_count, ecc_error = 0;
+	int err;
 
 	/*
 	 * The memory controller might not be initialized by the firmware
@@ -155,7 +255,11 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	if (mci->edac_cap == EDAC_FLAG_NONE)
 		return;
 
-	ecc_count = readl(priv->emi_base + MLXBF_ECC_CNT);
+	err = edac_readl(priv->emi_base + MLXBF_ECC_CNT, &ecc_count,
+			 priv->svc_sreg_support, priv->sreg_tbl_edac);
+	if (err)
+		dev_err(priv->dev, "ECC count read failed.\n");
+
 	single_error_count = FIELD_GET(MLXBF_ECC_CNT__SERR_CNT, ecc_count);
 	double_error_count = FIELD_GET(MLXBF_ECC_CNT__DERR_CNT, ecc_count);
 
@@ -172,15 +276,19 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
 	}
 
 	/* Write to clear reported errors. */
-	if (ecc_count)
-		writel(ecc_error, priv->emi_base + MLXBF_ECC_ERR);
+	if (ecc_count) {
+		err = edac_writel(priv->emi_base + MLXBF_ECC_ERR, ecc_error,
+				  priv->svc_sreg_support, priv->sreg_tbl_edac);
+		if (err)
+			dev_err(priv->dev, "ECC Error write failed.\n");
+	}
 }
 
 /* Initialize the DIMMs information for the given memory controller. */
 static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 {
 	struct bluefield_edac_priv *priv = mci->pvt_info;
-	int mem_ctrl_idx = mci->mc_idx;
+	u64 mem_ctrl_idx = mci->mc_idx;
 	struct dimm_info *dimm;
 	u64 smc_info, smc_arg;
 	int is_empty = 1, i;
@@ -189,7 +297,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
@@ -244,6 +352,7 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	struct bluefield_edac_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct edac_mc_layer layers[1];
+	struct arm_smccc_res res;
 	struct mem_ctl_info *mci;
 	struct resource *emi_res;
 	unsigned int mc_idx, dimm_count;
@@ -280,12 +389,40 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 
 	priv = mci->pvt_info;
 
+	/*
+	 * ACPI indicates whether we use SMCs to access registers or not.
+	 * If sreg_tbl_perf is not present, just assume we're not using SMCs.
+	 */
+	if (device_property_read_u32(dev,
+				     "sec_reg_block", &priv->sreg_tbl_edac)) {
+		priv->svc_sreg_support = false;
+	} else {
+		/*
+		 * Check service version to see if we actually do support the
+		 * needed SMCs. If we have the calls we need, mark support for
+		 * them in the pmc struct.
+		 */
+		arm_smccc_smc(MLXBF_SIP_SVC_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0 == MLXBF_SVC_REQ_MAJOR &&
+		    res.a1 >= MLXBF_SVC_REQ_MINOR) {
+			priv->svc_sreg_support = true;
+		} else {
+			dev_err(dev, "Required SMCs are not supported.\n");
+			ret = -EINVAL;
+			goto err;
+		}
+	}
+
 	priv->dimm_per_mc = dimm_count;
-	priv->emi_base = devm_ioremap_resource(dev, emi_res);
-	if (IS_ERR(priv->emi_base)) {
-		dev_err(dev, "failed to map EMI IO resource\n");
-		ret = PTR_ERR(priv->emi_base);
-		goto err;
+	if (!priv->svc_sreg_support) {
+		priv->emi_base = devm_ioremap_resource(dev, emi_res);
+		if (IS_ERR(priv->emi_base)) {
+			dev_err(dev, "failed to map EMI IO resource\n");
+			ret = PTR_ERR(priv->emi_base);
+			goto err;
+		}
+	} else {
+		priv->emi_base = (void __iomem *)emi_res->start;
 	}
 
 	mci->pdev = dev;
@@ -320,7 +457,6 @@ static int bluefield_edac_mc_probe(struct platform_device *pdev)
 	edac_mc_free(mci);
 
 	return ret;
-
 }
 
 static int bluefield_edac_mc_remove(struct platform_device *pdev)
-- 
2.30.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A5767EC11
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjA0RGf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235048AbjA0RGG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:06:06 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7644A29156;
        Fri, 27 Jan 2023 09:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YvFPkkjdRHeqYZ/Mlo0+9e9d/4wRTO/mE+43ejOi9sMpg3jx/2dZwuA+mOfR+oBharU0GGBF74a4HRblt8kj8WxzfXIEN5zMZYp9mSKzXza4gpjpHGr57Id+xmDVNUPjWZiShP5X0om9/pr1h57GhQptfC0MsFiOTOTfpNiqzBVSJG1XuhvfyuJTgO8zW1VdeZlDXqPEUhUBajRlZdEsIarCYLwd5gd83Lu/XGesplb58wLtPbNr+m/Lo7zyYAGabxgkFcXaIxWdul/FSkuUrCbv88Y3M8E3hUiooiTwyJOL12CcSlq734ZkeeI3vtxExlgTkhrjQcJz5Jp64ierkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IbdYxXAzDlrlEDnsG0h1hntKMoMNbwjpAEEZgCD3alY=;
 b=PtuBr+JV1H/JUqibgqPSJwIO6LtJz39OsIQXw8jAY+gDXBte4/c9Bg3eIlRuZ3qlU6ny5E7gywakDw0w36OrhzgvTV0VNN0ppSp61EVp0IhDT7gN/BBm1TpwdUTlcLd6bMjBdDX1zCjQTuAtFtqT1yhf/zv4QSH0R1y3uc7b9VRC4rSeW7OL6Lm5HmeA8caLc3VYr4oAAR87DaaJ6rzTHbVY20/u7laKGCe1erHDbe0LzCUVJv0PuLWIIGHMWcDLS8TDZ9Rr3NBV+qJcs5FJM4nVyJzRTTT6rhEyVYEEAa1LRg5Xe1OzNh9TVmVJt36Kw8IJzP/kZmgRleSw3lEAVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IbdYxXAzDlrlEDnsG0h1hntKMoMNbwjpAEEZgCD3alY=;
 b=xcUBRbkeFM5safMCfY6o3PS0omkVge5+SK+jkFrMiPH6ljl/DjmQR6or4+959MDq5Z8kPRe+EbkgKNxTWImHy+RO2LzbnPsSVt9YKTgHf/eVDu9j0YHedZdVg4jd/O0wLBGq8r0OAKXLLrwLASCLiz8y0jtHcXMdcHZj2ig4tDE=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by CH3PR12MB8283.namprd12.prod.outlook.com (2603:10b6:610:12a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:34 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::1f) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:34 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:32 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 06/22] EDAC/amd64: Rename debug_display_dimm_sizes()
Date:   Fri, 27 Jan 2023 17:04:03 +0000
Message-ID: <20230127170419.1824692-7-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|CH3PR12MB8283:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e1a93e-3d32-42c8-ef8b-08db0088905c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xlVaUMLAfZ7mVB0tveNuOEk8jZFLYxIlsMc6HpBkxXK7whS/lY1qpmI41rcJldiC7ustVKKyW1tiq1y1pD19vYFBa2qfrmbaiZiJZro3UN1GDxK2K8+5/KYs71ICidbuvkBqm65aguVf6GqUIr7xMy8+r5zLTd/Qyqc3PM5g5wAtZrKtQy3842briQs6BCWmjayNmOnk/Ne13JNnTuc3ipjDU1qmxIg2Y+Mkp66X+JI4B8LVTxu350GSBz/kxyOuSjUCnxq0EH9CngAuIOteFtCZsRbojjApdNTIN6Y4il8wjzFUyeMAYGh+U/KSaVE2l5qwRffQdfLTsppGW4zVmYeTbrWJ+3oUjUGNDx/7xq7QheMUeuIp+MPrWlj+NicQaBpVz3D7iwXR43Do873nAgklhb7tq2m/GeFAwiVqfe67gNd3wESBMGmCSMphCXNS0vniG/DCzLDIVPKS/0PmbAZFmKyJ8YF3NypaTeGmGctg0HII6P7UNAytv/9h3J0FEV6fv5hwbeSx4tQc58ipRb0wU6znrzC+jR/ruRRE/Wxo9Dc49wrWu1rDJgBIq00dROG7sRGSfPaY1zpikrHde2IndPYsw1qw2RnXbYvfpOmWx+FMndHJbK20YMalqpAaEweIayJGMdvwZDekVe17WhUsiYHqnxDMWq4myH9kMlTQJH/QVSo7MTOy45n2daY01HW3uMJLFeDg0QnvNjtIz48Hxv57KhN2zt0JOVWTG668cvEUnFdW9SHVEbvWlamAn/ZNjSxnG08VlQr0NPwsQg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(451199018)(46966006)(36840700001)(40470700004)(47076005)(8676002)(36756003)(40460700003)(7696005)(54906003)(40480700001)(356005)(336012)(16526019)(110136005)(81166007)(36860700001)(26005)(2616005)(83380400001)(86362001)(966005)(82310400005)(426003)(186003)(44832011)(6666004)(478600001)(316002)(1076003)(70586007)(82740400003)(8936002)(70206006)(41300700001)(5660300002)(4326008)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:34.0150
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e1a93e-3d32-42c8-ef8b-08db0088905c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8283
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use the "dct" and "umc" prefixes for legacy and modern versions
respectively.

Also, move the "dct" version to avoid a forward declaration, and fixup
some checkpatch warnings in the process.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 128 +++++++++++++++++++-------------------
 1 file changed, 63 insertions(+), 65 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1c4bef1cdf28..2d0558aeca28 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1291,7 +1291,65 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 	return edac_cap;
 }
 
-static void debug_display_dimm_sizes(struct amd64_pvt *, u8);
+/*
+ * debug routine to display the memory sizes of all logical DIMMs and its
+ * CSROWs
+ */
+static void dct_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
+{
+	u32 *dcsb = ctrl ? pvt->csels[1].csbases : pvt->csels[0].csbases;
+	u32 dbam  = ctrl ? pvt->dbam1 : pvt->dbam0;
+	int dimm, size0, size1;
+
+	if (pvt->fam == 0xf) {
+		/* K8 families < revF not supported yet */
+		if (pvt->ext_model < K8_REV_F)
+			return;
+
+		WARN_ON(ctrl != 0);
+	}
+
+	if (pvt->fam == 0x10) {
+		dbam = (ctrl && !dct_ganging_enabled(pvt)) ? pvt->dbam1
+							   : pvt->dbam0;
+		dcsb = (ctrl && !dct_ganging_enabled(pvt)) ?
+				 pvt->csels[1].csbases :
+				 pvt->csels[0].csbases;
+	} else if (ctrl) {
+		dbam = pvt->dbam0;
+		dcsb = pvt->csels[1].csbases;
+	}
+	edac_dbg(1, "F2x%d80 (DRAM Bank Address Mapping): 0x%08x\n",
+		 ctrl, dbam);
+
+	edac_printk(KERN_DEBUG, EDAC_MC, "DCT%d chip selects:\n", ctrl);
+
+	/* Dump memory sizes for DIMM and its CSROWs */
+	for (dimm = 0; dimm < 4; dimm++) {
+		size0 = 0;
+		if (dcsb[dimm * 2] & DCSB_CS_ENABLE)
+			/*
+			 * For F15m60h, we need multiplier for LRDIMM cs_size
+			 * calculation. We pass dimm value to the dbam_to_cs
+			 * mapper so we can find the multiplier from the
+			 * corresponding DCSM.
+			 */
+			size0 = pvt->ops->dbam_to_cs(pvt, ctrl,
+						     DBAM_DIMM(dimm, dbam),
+						     dimm);
+
+		size1 = 0;
+		if (dcsb[dimm * 2 + 1] & DCSB_CS_ENABLE)
+			size1 = pvt->ops->dbam_to_cs(pvt, ctrl,
+						     DBAM_DIMM(dimm, dbam),
+						     dimm);
+
+		amd64_info(EDAC_MC ": %d: %5dMB %d: %5dMB\n",
+			   dimm * 2,     size0,
+			   dimm * 2 + 1, size1);
+	}
+}
+
 
 static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 {
@@ -1366,7 +1424,7 @@ static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 	return cs_mode;
 }
 
-static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
+static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 {
 	int dimm, size0, size1, cs0, cs1, cs_mode;
 
@@ -1426,7 +1484,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 					i, 1 << ((tmp >> 4) & 0x3));
 		}
 
-		debug_display_dimm_sizes_df(pvt, i);
+		umc_debug_display_dimm_sizes(pvt, i);
 	}
 }
 
@@ -1451,13 +1509,13 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 		 (pvt->fam == 0xf) ? k8_dhar_offset(pvt)
 				   : f10_dhar_offset(pvt));
 
-	debug_display_dimm_sizes(pvt, 0);
+	dct_debug_display_dimm_sizes(pvt, 0);
 
 	/* everything below this point is Fam10h and above */
 	if (pvt->fam == 0xf)
 		return;
 
-	debug_display_dimm_sizes(pvt, 1);
+	dct_debug_display_dimm_sizes(pvt, 1);
 
 	/* Only if NOT ganged does dclr1 have valid info */
 	if (!dct_ganging_enabled(pvt))
@@ -2681,66 +2739,6 @@ static void f1x_map_sysaddr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr,
 		err->channel = get_channel_from_ecc_syndrome(mci, err->syndrome);
 }
 
-/*
- * debug routine to display the memory sizes of all logical DIMMs and its
- * CSROWs
- */
-static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
-{
-	int dimm, size0, size1;
-	u32 *dcsb = ctrl ? pvt->csels[1].csbases : pvt->csels[0].csbases;
-	u32 dbam  = ctrl ? pvt->dbam1 : pvt->dbam0;
-
-	if (pvt->fam == 0xf) {
-		/* K8 families < revF not supported yet */
-	       if (pvt->ext_model < K8_REV_F)
-			return;
-	       else
-		       WARN_ON(ctrl != 0);
-	}
-
-	if (pvt->fam == 0x10) {
-		dbam = (ctrl && !dct_ganging_enabled(pvt)) ? pvt->dbam1
-							   : pvt->dbam0;
-		dcsb = (ctrl && !dct_ganging_enabled(pvt)) ?
-				 pvt->csels[1].csbases :
-				 pvt->csels[0].csbases;
-	} else if (ctrl) {
-		dbam = pvt->dbam0;
-		dcsb = pvt->csels[1].csbases;
-	}
-	edac_dbg(1, "F2x%d80 (DRAM Bank Address Mapping): 0x%08x\n",
-		 ctrl, dbam);
-
-	edac_printk(KERN_DEBUG, EDAC_MC, "DCT%d chip selects:\n", ctrl);
-
-	/* Dump memory sizes for DIMM and its CSROWs */
-	for (dimm = 0; dimm < 4; dimm++) {
-
-		size0 = 0;
-		if (dcsb[dimm*2] & DCSB_CS_ENABLE)
-			/*
-			 * For F15m60h, we need multiplier for LRDIMM cs_size
-			 * calculation. We pass dimm value to the dbam_to_cs
-			 * mapper so we can find the multiplier from the
-			 * corresponding DCSM.
-			 */
-			size0 = pvt->ops->dbam_to_cs(pvt, ctrl,
-						     DBAM_DIMM(dimm, dbam),
-						     dimm);
-
-		size1 = 0;
-		if (dcsb[dimm*2 + 1] & DCSB_CS_ENABLE)
-			size1 = pvt->ops->dbam_to_cs(pvt, ctrl,
-						     DBAM_DIMM(dimm, dbam),
-						     dimm);
-
-		amd64_info(EDAC_MC ": %d: %5dMB %d: %5dMB\n",
-				dimm * 2,     size0,
-				dimm * 2 + 1, size1);
-	}
-}
-
 static struct amd64_family_type family_types[] = {
 	[K8_CPUS] = {
 		.ctl_name = "K8",
-- 
2.25.1


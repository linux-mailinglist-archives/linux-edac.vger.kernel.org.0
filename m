Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510294C7178
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiB1QO7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237349AbiB1QO7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:14:59 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33C44553F
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWoov+TXKseslYML6LurWqZlrvXLUEqyV9PA+vvaKgo7mcslZXEaUQzOK+j8xzGXK7jl90U1ZASb4U7mTE42/YDT78DxgBUMfmPu7ptFj3GvwBEZmgGXMT07/PcDlsMj+8eWn0surlf8GHAIt1wpUSvQSJaLfHVBpZgYvfO8mbXM1KpPuTlUpMEiLCHLZ1igpe/jDTu4lfifsKDJ8K/piujOfdfrUFzG3Z8yDz1/fVmtQXk4pCuz675ptG3r4xa1WP+Jvegmum09IJEtbdlx9sqOfEWwsJtSy198bbjfgB5POpFu/7xLyv3zCtJsGVGFtZKZlaZ0t3c19Rlj73FKgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHri+p2R3Z/dqHIAh8yRYIH+z5otPO5HhgRnBiEp18U=;
 b=WOMkxrq6Brf3gjLCY/X5HykHbvrBQcXJrx+mOXLCn0tEYs2tbFxdI8Q8itHLbEJFy4NSfry9rL1mqr7s9Qr2Hh+e8cHonu7HfFtNXNSAKmlDQvbzjb722DNhTgqasKYjvfxUfN1kqcFiAprEN+Um7o2uke6KYAGYAnoaHwsOZ70PJNkoa1blEzRdjxOrUXJBbTEo+cn50NeId2WOkFb3MIoicu+bNIXclrGXLbtl8COCFTsH8y/EoiInxsyVDGuAOqZ5MF8icps5M9bwpZ9+FR7pPe80rRmE20oy+Lo6xu9i9JQB+CNxIl7ZTxPIUPNoB3MB9mCaTTf7sGSjhn56Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHri+p2R3Z/dqHIAh8yRYIH+z5otPO5HhgRnBiEp18U=;
 b=rR926yJNk+Wbb4hx8ZgxekPFVDj1INRxqT+Drhe5mvk+S0XEwMX/ULGQJX5BcHyFJxAD7HqYwPlyWB+eliXADwzR2G2XQPOPLWDX26OfMfHh1jkfsh2nunsp/ovLv6qApfQrsj0VQvRJ0HhXajdrhi+cOIWJjvMGPd6J+oHCjgQ=
Received: from BN8PR16CA0016.namprd16.prod.outlook.com (2603:10b6:408:4c::29)
 by PH7PR12MB5733.namprd12.prod.outlook.com (2603:10b6:510:1e0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23; Mon, 28 Feb
 2022 16:14:17 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::ec) by BN8PR16CA0016.outlook.office365.com
 (2603:10b6:408:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:16 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:13 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 01/14] EDAC/amd64: Move struct fam_type variables into struct amd64_pvt
Date:   Mon, 28 Feb 2022 21:43:41 +0530
Message-ID: <20220228161354.54923-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228161354.54923-1-nchatrad@amd.com>
References: <20220228161354.54923-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 927a84a9-cdc8-4a39-4386-08d9fad55e84
X-MS-TrafficTypeDiagnostic: PH7PR12MB5733:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5733F2443DF7303DAEB7DAF8E8019@PH7PR12MB5733.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z5GV7NLXcc3YyduOQvzpIzKnwlCrnk8kuKEy+OxFRKe4xxf322nLXPg3x88b1lS3d9j8IWhLyMKlztTWY/q91gunJ2Pwvm2UsG3tD8ueauZof3Osqbtg5w9dt1tsD2ABxm3xb2Jak7QXF38jGNqT4PxLPLD8YyvtvqIrMoiNodlfbhfoWhEp9MqysG/i/jwfabJ8QOGCHm8vFn/RkkVLwFsFkkDQBYhIZw+BG0ExbCqaegH7PKwZSO60+WzBm7aosevH/WCGxKDSDtu7PRMZ2VfXGgvqg829VlaoavKWWGyjlUjBF1P7NBHLlio9lUAV6tLnVOb+oTiXzzy1BWS0txf9QWJpLK292YqacAk6R4DQEY/sTuD3WcaEXXxvzJOPAJr6LY4vuCDFqHbHzRl1IeZf4yo4vCoUWd3pDzSVglvxUvoIl2R5/J+l+sQepGeiOL69/qx/4NjGGhQbAIvzhTGAgA7Bdzg4thiZte7mu0SHsuho2OabjVh/ica9YN/Dy7/jKaSltvHU11UqLlI/Fv/A+yP7q3g9JPUxnuNdorNllz8s4bFmIOzOm8iwgS5r8/2EkoakHiJmn69eFn0eP1ag4KnDoLqTUa7WBVbyo+4+8D7mcn35PXy9mnARjRp4paZ3lpkpSfSQtgyHMQZCJmbIv1EA2UAGxzykfAS5pUkQdQn18sBsLoHqZ2u5cPDKZjF+kAlmet9sgI5OpIAY3PKILIeThFlhk+fYfVKUn/rdEgTJZgd626xMR6eynEuSbbGoNy3ydlWcyHtwZ6EzTjU4KxhmT3Sw4xjkGbgkQvM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(1076003)(40460700003)(54906003)(6916009)(36756003)(966005)(2906002)(26005)(316002)(186003)(336012)(426003)(82310400004)(508600001)(81166007)(16526019)(2616005)(5660300002)(8936002)(47076005)(30864003)(36860700001)(356005)(7696005)(70586007)(70206006)(4326008)(6666004)(8676002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:16.9559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 927a84a9-cdc8-4a39-4386-08d9fad55e84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5733
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Move struct low_ops routines and members of struct amd64_family_type
to struct amd64_pvt.

This change makes code readable and simplifies adding support for
various families/models.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is the 4/12th patch in series
[v7 4/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-5-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 339 ++++++++++++--------------------------
 drivers/edac/amd64_edac.h |  42 ++---
 2 files changed, 114 insertions(+), 267 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index af2c578f8ab3..b21f43a3ec98 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -13,8 +13,6 @@ module_param(ecc_enable_override, int, 0644);
 
 static struct msr __percpu *msrs;
 
-static struct amd64_family_type *fam_type;
-
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
 
@@ -448,7 +446,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
 	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
 
 #define for_each_umc(i) \
-	for (i = 0; i < fam_type->max_mcs; i++)
+	for (i = 0; i < pvt->max_mcs; i++)
 
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Return the
@@ -2787,166 +2785,6 @@ static void debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
-static struct amd64_family_type family_types[] = {
-	[K8_CPUS] = {
-		.ctl_name = "K8",
-		.f1_id = PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP,
-		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= k8_early_channel_count,
-			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
-			.dbam_to_cs		= k8_dbam_to_chip_select,
-		}
-	},
-	[F10_CPUS] = {
-		.ctl_name = "F10h",
-		.f1_id = PCI_DEVICE_ID_AMD_10H_NB_MAP,
-		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f10_dbam_to_chip_select,
-		}
-	},
-	[F15_CPUS] = {
-		.ctl_name = "F15h",
-		.f1_id = PCI_DEVICE_ID_AMD_15H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_dbam_to_chip_select,
-		}
-	},
-	[F15_M30H_CPUS] = {
-		.ctl_name = "F15h_M30h",
-		.f1_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F15_M60H_CPUS] = {
-		.ctl_name = "F15h_M60h",
-		.f1_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
-		}
-	},
-	[F16_CPUS] = {
-		.ctl_name = "F16h",
-		.f1_id = PCI_DEVICE_ID_AMD_16H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F16_M30H_CPUS] = {
-		.ctl_name = "F16h_M30h",
-		.f1_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F1,
-		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
-			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
-			.dbam_to_cs		= f16_dbam_to_chip_select,
-		}
-	},
-	[F17_CPUS] = {
-		.ctl_name = "F17h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M10H_CPUS] = {
-		.ctl_name = "F17h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M10H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M30H_CPUS] = {
-		.ctl_name = "F17h_M30h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M30H_DF_F6,
-		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M60H_CPUS] = {
-		.ctl_name = "F17h_M60h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M60H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F17_M70H_CPUS] = {
-		.ctl_name = "F17h_M70h",
-		.f0_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_17H_M70H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_CPUS] = {
-		.ctl_name = "F19h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_DF_F6,
-		.max_mcs = 8,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_M10H_CPUS] = {
-		.ctl_name = "F19h_M10h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
-		.max_mcs = 12,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-	[F19_M50H_CPUS] = {
-		.ctl_name = "F19h_M50h",
-		.f0_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F0,
-		.f6_id = PCI_DEVICE_ID_AMD_19H_M50H_DF_F6,
-		.max_mcs = 2,
-		.ops = {
-			.early_channel_count	= f17_early_channel_count,
-			.dbam_to_cs		= f17_addr_mask_to_cs_size,
-		}
-	},
-};
-
 /*
  * These are tables of eigenvectors (one per line) which can be used for the
  * construction of the syndrome tables. The modified syndrome search algorithm
@@ -3896,7 +3734,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-	mci->ctl_name		= fam_type->ctl_name;
+	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
@@ -3908,111 +3746,143 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 /*
  * returns a pointer to the family descriptor on success, NULL otherwise.
  */
-static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
+static int per_family_init(struct amd64_pvt *pvt)
 {
 	pvt->ext_model  = boot_cpu_data.x86_model >> 4;
 	pvt->stepping	= boot_cpu_data.x86_stepping;
 	pvt->model	= boot_cpu_data.x86_model;
 	pvt->fam	= boot_cpu_data.x86;
+	pvt->max_mcs	= 2;
 
 	switch (pvt->fam) {
 	case 0xf:
-		fam_type	= &family_types[K8_CPUS];
-		pvt->ops	= &family_types[K8_CPUS].ops;
+		pvt->ctl_name				= (pvt->ext_model > K8_REV_F) ?
+							  "K8 revF or later" : "K8 revE or earlier";
+		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
+		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
+		pvt->ops->early_channel_count		= k8_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
 		break;
 
 	case 0x10:
-		fam_type	= &family_types[F10_CPUS];
-		pvt->ops	= &family_types[F10_CPUS].ops;
+		pvt->ctl_name				= "F10h";
+		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
+		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
+		pvt->ops->early_channel_count		= f1x_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
 		break;
 
 	case 0x15:
 		if (pvt->model == 0x30) {
-			fam_type = &family_types[F15_M30H_CPUS];
-			pvt->ops = &family_types[F15_M30H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F15h_M30h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
+			pvt->ops->dbam_to_cs		= f16_dbam_to_chip_select;
 		} else if (pvt->model == 0x60) {
-			fam_type = &family_types[F15_M60H_CPUS];
-			pvt->ops = &family_types[F15_M60H_CPUS].ops;
-			break;
-		/* Richland is only client */
+			pvt->ctl_name			= "F15h_M60h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
+			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
 		} else if (pvt->model == 0x13) {
-			return NULL;
+		/* Richland is only client */
+			return -ENODEV;
 		} else {
-			fam_type	= &family_types[F15_CPUS];
-			pvt->ops	= &family_types[F15_CPUS].ops;
+			pvt->ctl_name			= "F15h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
+			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
 		}
+		pvt->ops->early_channel_count		= f1x_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		break;
 
 	case 0x16:
 		if (pvt->model == 0x30) {
-			fam_type = &family_types[F16_M30H_CPUS];
-			pvt->ops = &family_types[F16_M30H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F16h_M30h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
+		} else {
+			pvt->ctl_name			= "F16h";
+			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
+			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
 		}
-		fam_type	= &family_types[F16_CPUS];
-		pvt->ops	= &family_types[F16_CPUS].ops;
+		pvt->ops->early_channel_count		= f1x_early_channel_count;
+		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
+		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
 		break;
 
 	case 0x17:
 		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M10H_CPUS];
-			pvt->ops = &family_types[F17_M10H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F17h_M10h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M10H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M10H_DF_F6;
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
-			fam_type = &family_types[F17_M30H_CPUS];
-			pvt->ops = &family_types[F17_M30H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F17h_M30h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M30H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M30H_DF_F6;
+			pvt->max_mcs			= 8;
 		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
-			fam_type = &family_types[F17_M60H_CPUS];
-			pvt->ops = &family_types[F17_M60H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F17h_M60h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M60H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M60H_DF_F6;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F17h_M70h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F6;
+		} else {
+			pvt->ctl_name			= "F17h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_DF_F6;
 		}
 		fallthrough;
 	case 0x18:
-		fam_type	= &family_types[F17_CPUS];
-		pvt->ops	= &family_types[F17_CPUS].ops;
+		pvt->ops->early_channel_count		= f17_early_channel_count;
+		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 
-		if (pvt->fam == 0x18)
-			family_types[F17_CPUS].ctl_name = "F18h";
+		if (pvt->fam == 0x18) {
+			pvt->ctl_name			= "F18h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_DF_F6;
+		}
 		break;
 
 	case 0x19:
 		if (pvt->model >= 0x10 && pvt->model <= 0x1f) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
-			break;
+			pvt->ctl_name			= "F19h_M10h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
+			pvt->max_mcs			= 12;
 		} else if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M70H_CPUS];
-			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M20h";
-			break;
+			pvt->ctl_name			= "F19h_M20h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_17H_M70H_DF_F6;
 		} else if (pvt->model >= 0x50 && pvt->model <= 0x5f) {
-			fam_type = &family_types[F19_M50H_CPUS];
-			pvt->ops = &family_types[F19_M50H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M50h";
-			break;
+			pvt->ctl_name			= "F19h_M50h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M50H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M50H_DF_F6;
 		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
-			fam_type = &family_types[F19_M10H_CPUS];
-			pvt->ops = &family_types[F19_M10H_CPUS].ops;
-			fam_type->ctl_name = "F19h_MA0h";
-			break;
+			pvt->ctl_name			= "F19h_MA0h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
+			pvt->max_mcs			= 12;
+		} else {
+			pvt->ctl_name			= "F19h";
+			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_DF_F0;
+			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_DF_F6;
+			pvt->max_mcs			= 8;
 		}
-		fam_type	= &family_types[F19_CPUS];
-		pvt->ops	= &family_types[F19_CPUS].ops;
-		family_types[F19_CPUS].ctl_name = "F19h";
+		pvt->ops->early_channel_count		= f17_early_channel_count;
+		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
 		break;
 
 	default:
 		amd64_err("Unsupported family!\n");
-		return NULL;
+		return -ENODEV;
 	}
 
-	return fam_type;
+	return 0;
 }
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
@@ -4029,15 +3899,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	int ret;
 
 	if (pvt->fam >= 0x17) {
-		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
 
-		pci_id1 = fam_type->f0_id;
-		pci_id2 = fam_type->f6_id;
+		pci_id1 = pvt->f0_id;
+		pci_id2 = pvt->f6_id;
 	} else {
-		pci_id1 = fam_type->f1_id;
-		pci_id2 = fam_type->f2_id;
+		pci_id1 = pvt->f1_id;
+		pci_id2 = pvt->f2_id;
 	}
 
 	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
@@ -4083,7 +3953,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -4113,7 +3983,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
 	bool cs_enabled = false;
 	int cs = 0, dct = 0;
 
-	for (dct = 0; dct < fam_type->max_mcs; dct++) {
+	for (dct = 0; dct < pvt->max_mcs; dct++) {
 		for_each_chip_select(cs, dct, pvt)
 			cs_enabled |= csrow_enabled(cs, dct, pvt);
 	}
@@ -4142,10 +4012,13 @@ static int probe_one_instance(unsigned int nid)
 	pvt->mc_node_id	= nid;
 	pvt->F3 = F3;
 
+	pvt->ops = kzalloc(sizeof(*pvt->ops), GFP_KERNEL);
+	if (!pvt->ops)
+		goto err_out;
+
 	ret = -ENODEV;
-	fam_type = per_family_init(pvt);
-	if (!fam_type)
-		goto err_enable;
+	if (per_family_init(pvt))
+		goto err_out;
 
 	ret = hw_info_get(pvt);
 	if (ret < 0)
@@ -4183,11 +4056,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
-		     (pvt->fam == 0xf ?
-				(pvt->ext_model >= K8_REV_F  ? "revF or later "
-							     : "revE or earlier ")
-				 : ""), pvt->mc_node_id);
+	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
 
 	dump_misc_regs(pvt);
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 352bda9803f6..1b2055af26b9 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -288,25 +288,6 @@
 
 #define UMC_SDP_INIT			BIT(31)
 
-enum amd_families {
-	K8_CPUS = 0,
-	F10_CPUS,
-	F15_CPUS,
-	F15_M30H_CPUS,
-	F15_M60H_CPUS,
-	F16_CPUS,
-	F16_M30H_CPUS,
-	F17_CPUS,
-	F17_M10H_CPUS,
-	F17_M30H_CPUS,
-	F17_M60H_CPUS,
-	F17_M70H_CPUS,
-	F19_CPUS,
-	F19_M10H_CPUS,
-	F19_M50H_CPUS,
-	NUM_FAMILIES,
-};
-
 /* Error injection control structure */
 struct error_injection {
 	u32	 section;
@@ -388,6 +369,11 @@ struct amd64_pvt {
 	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
 
+	const char *ctl_name;
+	u16 f0_id, f1_id, f2_id, f6_id;
+	/* Maximum number of memory controllers per die/node. */
+	u8 max_mcs;
+
 	/* place to store error injection parameters prior to issue */
 	struct error_injection injection;
 
@@ -473,19 +459,11 @@ struct ecc_settings {
  * functions and per device encoding/decoding logic.
  */
 struct low_ops {
-	int (*early_channel_count)	(struct amd64_pvt *pvt);
-	void (*map_sysaddr_to_csrow)	(struct mem_ctl_info *mci, u64 sys_addr,
-					 struct err_info *);
-	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
-					 unsigned cs_mode, int cs_mask_nr);
-};
-
-struct amd64_family_type {
-	const char *ctl_name;
-	u16 f0_id, f1_id, f2_id, f6_id;
-	/* Maximum number of memory controllers per die/node. */
-	u8 max_mcs;
-	struct low_ops ops;
+	int  (*early_channel_count)(struct amd64_pvt *pvt);
+	void (*map_sysaddr_to_csrow)(struct mem_ctl_info *mci, u64 sys_addr,
+				     struct err_info *err);
+	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
+			   unsigned int cs_mode, int cs_mask_nr);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


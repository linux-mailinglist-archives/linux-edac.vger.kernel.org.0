Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F70267EC13
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjA0RGg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbjA0RGG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:06:06 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08E84B64;
        Fri, 27 Jan 2023 09:05:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4G3827lXFpSy0+3tNZAwGbeZWxLJDAblaDpb4R0+0/k1I7loda7MMOTuqicZQl94PxqPLp7LFHH0+ANWji8JQ+eywL6Isi5lAfoEHhAAFPjfRwMUk5VX6x3l307o6g+hySPw+9jEZn25qX2Oivl16OCgamVtmUEu8n2+lyAUAzvKcGX0uPm0FAZu/CNb7lDOmt8+x/Jq1RadzPpXwVDTpekmiHQFtbgbuWV5CTuGsMmwKixxJ2Q50tQjUVL7bN7pyswgJjiEK0aAU8yeURXS/UVWz07+vXW6pNw7BXo8ZancdLcRgG8yo2l29FhvM+nzsmltqhHsPWhcIsFbY4p8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2IgvE9TU2YO6XPGd29qJ+TgRhdjCT7uD4FYbjwA3FE=;
 b=E7vXkZdAYhTskHvkGy+hKK2Si+7hGThxbok2YesepN3Nm836W2HO5dLEYPRzyDukGZbcl+u5LFxcHszSlVYbkeNlOEfpDvbDkncYOj9frUk+9r+y6IjykSVZu5gWZuxOyqXSj5YBCWEB8fJOXfS2xs2Z98xNX/cxn0QaG+IJx5IAI2VfM1rAZn5bj2whFjvMOxSGMJN95T7wPN/HjldqkSsWNr0LGidV4pw6vnHTHEwSGBb/oFp8hZH4eJqNFY1ffNmVkbHXkdYoaCJLy5pQkbs+EtBznjm/YzpiX8aKwci3EUM0oIDTa/CCxiN9q8CF+VmyTZ5TA8FU1kCKpkX2PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2IgvE9TU2YO6XPGd29qJ+TgRhdjCT7uD4FYbjwA3FE=;
 b=BUOOqFabURlJ0E2w7MLE9GBp+PMrEeLqg8lG6c/C8osExb8aOJxRIEB94zonD53zDL+JCGw6c/uMd1GZm+tU9C+99rAOGu8IJ3KL6BLb/10NhhujRhRBoUfukWLvdFTwg31O3I5z7//oujVAheMhYa7qjUxBG0hVfcmCCLkym8k=
Received: from BN8PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:d4::35)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:33 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::a3) by BN8PR04CA0061.outlook.office365.com
 (2603:10b6:408:d4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:33 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:32 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 05/22] EDAC/amd64: Remove early_channel_count()
Date:   Fri, 27 Jan 2023 17:04:02 +0000
Message-ID: <20230127170419.1824692-6-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 4231b723-52ed-4394-2d0c-08db00889039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Aeg8hUfqNodtX+IHC9Rha2ebGvSyDfLnPwGLdo4RTzk2SfSvXEWvRamHVWacoAW0ajpF6v65YoFFVg7sPgDRvbB9wGEKls7x6evDJYb9m5i8DAglnBJLOMRguEvk8GlUHkDXJm67TXuQ7rSWBLQs9M7KU2/Jg6SKalPuoxzcVthnNyB6jo1YjaT1xuAtAKG3WZ4BSi+inrdpyz26Ip1DzLiAn+GcpAwcyz3L4SV+Or9j0g/pq04vw2jurb06xBbxET2oUt6cGr+iLqzAJDA4xNG63FR2y0bmZ4RdVt8OEMgH64SNcFQOOSLUQ/B6Eol8stZVAsiBNwTRxMeRlDR/z7EFX/Y6bIjItTSNV8TkU7pxoWgSXMwquyHzNzQw5b0cHaNTywPy0aIxdIo+FLJrreSb54IjnCgbUgUFlIS7arbm0WY1DC9TosRdy4Bscn7oELVDNV/uWFVaViWE5SGuPeU2ElqNwLXwg5OOJ9Wo57zp2OmhsNc0fBG+T1QZKfwkx4+ZMWbI01IwssB7yydwkni6ASp2s7JcE5hyl/qFklzlIL/YAMKEDQTj8MlEXU/kDVPEIRMbIrvTa4brT3qUu7p260Bmn6TaV498HgQ59EO6FPrsh4yP2NWJJafHb4qqcAjgcLHGxdWnS2Ol1klHbWEYgcaN368v8ILjmF5/0LATYw2fGX+ecwKiB/cvKlSBJS7tzmKoGTgebczAObT4ZDlQ2ktboB1mppZ7yI2eUSdeF+k8y7DCf+msDinCA5pT3ZWfiF6r8LvNoYIAGHMnBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199018)(46966006)(36840700001)(40470700004)(86362001)(7696005)(36860700001)(82310400005)(82740400003)(336012)(8936002)(26005)(186003)(41300700001)(316002)(16526019)(356005)(36756003)(966005)(47076005)(426003)(54906003)(478600001)(1076003)(110136005)(2616005)(44832011)(40480700001)(6666004)(81166007)(8676002)(70586007)(70206006)(40460700003)(4326008)(2906002)(5660300002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:33.7806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4231b723-52ed-4394-2d0c-08db00889039
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The early_channel_count() function seems to have been useful in the past
for knowing how many EDAC mci structures to populate. However, this is no
longer needed as the maximum channel count for a system is used instead.

Remove the early_channel_count() helper functions and related code. Use the
size of the channel layer when iterating over channel structures.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 116 +-------------------------------------
 drivers/edac/amd64_edac.h |   2 -
 2 files changed, 2 insertions(+), 116 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 352cbcda53f9..1c4bef1cdf28 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1703,24 +1703,6 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	pvt->dram_type = (pvt->dclr0 & BIT(16)) ? MEM_DDR3 : MEM_RDDR3;
 }
 
-/* Get the number of DCT channels the memory controller is using. */
-static int k8_early_channel_count(struct amd64_pvt *pvt)
-{
-	int flag;
-
-	if (pvt->ext_model >= K8_REV_F)
-		/* RevF (NPT) and later */
-		flag = pvt->dclr0 & WIDTH_128;
-	else
-		/* RevE and earlier */
-		flag = pvt->dclr0 & REVE_WIDTH_128;
-
-	/* not used */
-	pvt->dclr1 = 0;
-
-	return (flag) ? 2 : 1;
-}
-
 /* On F10h and later ErrAddr is MC4_ADDR[47:1] */
 static u64 get_error_address(struct amd64_pvt *pvt, struct mce *m)
 {
@@ -1972,69 +1954,6 @@ static int k8_dbam_to_chip_select(struct amd64_pvt *pvt, u8 dct,
 	}
 }
 
-/*
- * Get the number of DCT channels in use.
- *
- * Return:
- *	number of Memory Channels in operation
- * Pass back:
- *	contents of the DCL0_LOW register
- */
-static int f1x_early_channel_count(struct amd64_pvt *pvt)
-{
-	int i, j, channels = 0;
-
-	/* On F10h, if we are in 128 bit mode, then we are using 2 channels */
-	if (pvt->fam == 0x10 && (pvt->dclr0 & WIDTH_128))
-		return 2;
-
-	/*
-	 * Need to check if in unganged mode: In such, there are 2 channels,
-	 * but they are not in 128 bit mode and thus the above 'dclr0' status
-	 * bit will be OFF.
-	 *
-	 * Need to check DCT0[0] and DCT1[0] to see if only one of them has
-	 * their CSEnable bit on. If so, then SINGLE DIMM case.
-	 */
-	edac_dbg(0, "Data width is not 128 bits - need more decoding\n");
-
-	/*
-	 * Check DRAM Bank Address Mapping values for each DIMM to see if there
-	 * is more than just one DIMM present in unganged mode. Need to check
-	 * both controllers since DIMMs can be placed in either one.
-	 */
-	for (i = 0; i < 2; i++) {
-		u32 dbam = (i ? pvt->dbam1 : pvt->dbam0);
-
-		for (j = 0; j < 4; j++) {
-			if (DBAM_DIMM(j, dbam) > 0) {
-				channels++;
-				break;
-			}
-		}
-	}
-
-	if (channels > 2)
-		channels = 2;
-
-	amd64_info("MCT channel count: %d\n", channels);
-
-	return channels;
-}
-
-static int f17_early_channel_count(struct amd64_pvt *pvt)
-{
-	int i, channels = 0;
-
-	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
-	for_each_umc(i)
-		channels += !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
-
-	amd64_info("MCT channel count: %d\n", channels);
-
-	return channels;
-}
-
 static int ddr3_cs_size(unsigned i, bool dct_width)
 {
 	unsigned shift = 0;
@@ -2829,7 +2748,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_K8_NB_MEMCTL,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= k8_early_channel_count,
 			.map_sysaddr_to_csrow	= k8_map_sysaddr_to_csrow,
 			.dbam_to_cs		= k8_dbam_to_chip_select,
 		}
@@ -2840,7 +2758,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_10H_NB_DRAM,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
 			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
 			.dbam_to_cs		= f10_dbam_to_chip_select,
 		}
@@ -2851,7 +2768,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_15H_NB_F2,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
 			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
 			.dbam_to_cs		= f15_dbam_to_chip_select,
 		}
@@ -2862,7 +2778,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_15H_M30H_NB_F2,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
 			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
 			.dbam_to_cs		= f16_dbam_to_chip_select,
 		}
@@ -2873,7 +2788,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_15H_M60H_NB_F2,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
 			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
 			.dbam_to_cs		= f15_m60h_dbam_to_chip_select,
 		}
@@ -2884,7 +2798,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_16H_NB_F2,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
 			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
 			.dbam_to_cs		= f16_dbam_to_chip_select,
 		}
@@ -2895,7 +2808,6 @@ static struct amd64_family_type family_types[] = {
 		.f2_id = PCI_DEVICE_ID_AMD_16H_M30H_NB_F2,
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f1x_early_channel_count,
 			.map_sysaddr_to_csrow	= f1x_map_sysaddr_to_csrow,
 			.dbam_to_cs		= f16_dbam_to_chip_select,
 		}
@@ -2904,7 +2816,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F17h",
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2912,7 +2823,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F17h_M10h",
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2920,7 +2830,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F17h_M30h",
 		.max_mcs = 8,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2928,7 +2837,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F17h_M60h",
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2936,7 +2844,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F17h_M70h",
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2944,7 +2851,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F19h",
 		.max_mcs = 8,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2953,7 +2859,6 @@ static struct amd64_family_type family_types[] = {
 		.max_mcs = 12,
 		.flags.zn_regs_v2 = 1,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -2961,7 +2866,6 @@ static struct amd64_family_type family_types[] = {
 		.ctl_name = "F19h_M50h",
 		.max_mcs = 2,
 		.ops = {
-			.early_channel_count	= f17_early_channel_count,
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
@@ -3620,7 +3524,7 @@ static int init_csrows(struct mem_ctl_info *mci)
 					: EDAC_SECDED;
 		}
 
-		for (j = 0; j < pvt->channel_count; j++) {
+		for (j = 0; j < fam_type->max_mcs; j++) {
 			dimm = csrow->channels[j]->dimm;
 			dimm->mtype = pvt->dram_type;
 			dimm->edac_mode = edac_mode;
@@ -4057,28 +3961,12 @@ static int init_one_instance(struct amd64_pvt *pvt)
 {
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[2];
-	int ret = -EINVAL;
+	int ret = -ENOMEM;
 
-	/*
-	 * We need to determine how many memory channels there are. Then use
-	 * that information for calculating the size of the dynamic instance
-	 * tables in the 'mci' structure.
-	 */
-	pvt->channel_count = pvt->ops->early_channel_count(pvt);
-	if (pvt->channel_count < 0)
-		return ret;
-
-	ret = -ENOMEM;
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
 	layers[0].size = pvt->csels[0].b_cnt;
 	layers[0].is_virt_csrow = true;
 	layers[1].type = EDAC_MC_LAYER_CHANNEL;
-
-	/*
-	 * Always allocate two channels since we can have setups with DIMMs on
-	 * only one channel. Also, this simplifies handling later for the price
-	 * of a couple of KBs tops.
-	 */
 	layers[1].size = fam_type->max_mcs;
 	layers[1].is_virt_csrow = false;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 398fb58dacbf..e4329dff8cf2 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -346,7 +346,6 @@ struct amd64_pvt {
 	u8 stepping;		/* ... stepping */
 
 	int ext_model;		/* extended model value of this node */
-	int channel_count;
 
 	/* Raw registers */
 	u32 dclr0;		/* DRAM Configuration Low DCT0 reg */
@@ -466,7 +465,6 @@ struct ecc_settings {
  * functions and per device encoding/decoding logic.
  */
 struct low_ops {
-	int (*early_channel_count)	(struct amd64_pvt *pvt);
 	void (*map_sysaddr_to_csrow)	(struct mem_ctl_info *mci, u64 sys_addr,
 					 struct err_info *);
 	int (*dbam_to_cs)		(struct amd64_pvt *pvt, u8 dct,
-- 
2.25.1


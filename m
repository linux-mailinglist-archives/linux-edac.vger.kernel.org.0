Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD7237AAA3
	for <lists+linux-edac@lfdr.de>; Tue, 11 May 2021 17:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhEKP1F (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 May 2021 11:27:05 -0400
Received: from mail-dm6nam12on2070.outbound.protection.outlook.com ([40.107.243.70]:41440
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231808AbhEKP1F (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 11 May 2021 11:27:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8tKIxtwbVK1kxdo0dOKY7MuCPsHwmEdEKH2ww8Q5OkxupyT1zuZP7NGlX3r/576ONeP0OW0PdU5pbSYvHt8SNZPg1MzFsg4Mq8NAhjwShScApj5VyydVCpqZYE7PEtZHgTfYMs6NF8TrMwtSlyzJYReCzfts0I9OQ0NtpHlCSvQtdRmWoiAPI/dAdBu67oMEOe4Xb9WxCCYcDKfjxDHrMkDGLv06waHgrdhvjRB1QjI/JaP7ryADkKIw/6X9EPTeQs6vGbFpovQ9W6c7W7omvfhtpaSCuov64JU8jEkn4s30jQRW/gqlAERktTGES0kRCnKO5mnkmnycrknDZCkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iARQkXFQ7NBH2v1fFXaU9jJp3UwPCmAp0PSYviHQ3Kw=;
 b=TKOgL5cCApqr6nD+3sSLBylM6hES8pVb1uK5k0CWG1RWWUFlBjft7GnPuUtleZ2MwYv+yBzl9uYbY5PCjubW6zeDOFa1YePTKOZ6Zh8r63e7SS5MW65qSovnniVS3/ZYhO5HgGqDx78ECqE6Lu/ID2n+ux0puvYEHYO88eQs3ygEEvfRKx0sxN98tHJf9MejtKx2ums0DvqDu2ZuwXUdHhRKk5KbnpoFVjSjsyNGnks71iokGR1DLFbcUn0lrLL+Qvl5xbovz6KXOZPYY8hsrXKJBdKXK9RzMTF6KzwGo7OLFar/VyV7iEJeaoDVqSJhsj28rwUWNFB7PSBdU/6EfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iARQkXFQ7NBH2v1fFXaU9jJp3UwPCmAp0PSYviHQ3Kw=;
 b=etnrHELkKgxkr0WFHdT+B0PbXBT5LIHgEJ2Kg7uY/wNV3OWNNboXaIFiE5cecX/S5puDebCTqd0MuhALsNxL/xs34Qr1tyNPyg4v5qqLy3UitN3FzSid+fMfOpoEk9WWaJk1NDyn3ZAofBbTbyoiBjsrjOd689jaTnQSsCuju+g=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10)
 by DM6PR12MB3020.namprd12.prod.outlook.com (2603:10b6:5:11f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Tue, 11 May
 2021 15:25:57 +0000
Received: from DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961]) by DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961%5]) with mapi id 15.20.4108.032; Tue, 11 May 2021
 15:25:57 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>
Subject: [PATCH 1/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Date:   Tue, 11 May 2021 20:55:36 +0530
Message-Id: <20210511152538.148084-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::14) To DM6PR12MB4388.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from milan-ETHANOL-X.amd.com (165.204.156.251) by MA1PR0101CA0004.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 11 May 2021 15:25:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 541d3d88-3640-4b31-0ab8-08d9149112ca
X-MS-TrafficTypeDiagnostic: DM6PR12MB3020:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3020BAF1BE61BFC7B2DAEA09E8539@DM6PR12MB3020.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PrjT4HOKPjDkBURVv23AHX4iyP7S4iCWCbSFoC4TlAS7Lkl7kpqerN/4lebryUwTUoWHBwHXJ/JEiMfTNUQBPDL6G1wkQHzduvd2C3j6xVI66+pyikWYvZn+qkqBcEQHkOGxpZr3wxmxf9dZDGemSfj6kB1lcEW7Qwx75ZgCY7H1BRVxOj2Ep+GOMHkfx02Vq7pb2V4r3x23Y7Tm4cB/wwOx+ngwP7tzMLUjjVHsqVvPpnUeVHCmFXR0OBZF/lcDQJUgm+OAPZ+Uo52upbwhStDT/ti7/gTQhE5Z7UrLgIOKbkW1XSQ6QQR/z1zWvMUbSlzfABKoaWTDZLqY2Kuc+qJncXq9fNYzRLRc+dXTPBanfY9CCalQ/uTkGIIdo+bfvc4/2aeZRtysWl4xwAPiiJuUanXAWR0NVmMBg8oZ3t4pJ4pI/PZWN1mdVEnIKlsis2AqPS4m03GLVTTrgE2E+iUmNLtycOA1otWzGVw0avq3pPZVkYz2YupqMzJNzQXmVIpEYcIV+R5NnfHAPOeuW9G1PKiRyVWdrVPGYENJdHBkcxVjOAzeHrb57yPhLwQ8pfxq9lxNffUKELSOH+54/R89kyt7ZAbz5e//yhcxJaSpzNj9HdH/9B2p7uBTGMsOmk0/EWroqqSOQQ0yyqhlSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(66476007)(7696005)(16526019)(186003)(66556008)(1076003)(52116002)(15650500001)(66946007)(2906002)(316002)(83380400001)(478600001)(36756003)(5660300002)(6666004)(38350700002)(38100700002)(6486002)(8676002)(26005)(4326008)(956004)(2616005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?TUgZkdawxoOb/Ym4oZ5DgbAlzacY9hJwArjcn00gUqBFIK2cq8Hno4qltkBk?=
 =?us-ascii?Q?Znm+WORR53AiFMqrf9+aLxiASzqLa9Y9ksBzabidnVQ85uZPDqTApawTvrD8?=
 =?us-ascii?Q?Zs0yUB85VO7jkdqD6AQ0RcXUTKUHM+1dV+yENN9VTHdTHZFqi1XkjpyUFN1z?=
 =?us-ascii?Q?uohayc9avohx4N2VP6zsA/vNtGRUUnhpWYC+ckE7bLLpcR1YW3kCWGW2qIdw?=
 =?us-ascii?Q?A+aF9BAMgPXCbprB42DoOxK1ZODoVQdPcCcMJ6C6nIcyh35sxmCFIdVclJV3?=
 =?us-ascii?Q?ZHCHOInoJO/c1ZzyognBoifVU9h7hH6OY0l2S3CkEzjXAybaJbWsTgHZy3p4?=
 =?us-ascii?Q?S3Z9b+/aLGmZ0pWedX8FkuxvXs8lktCuBZU1hbvn6PIyQ76AVezHLL2ZLFWn?=
 =?us-ascii?Q?puazDqdFqzm0yzc62/8QI3pVTQaHvdGp3SrZbkXl5gtSn60/N1jj5VenDjsW?=
 =?us-ascii?Q?AwLgeaITS0IuQlx0T5nOEwy2QXJpawLcXLveQabBvHOQlejiY4BA/L/dg1+w?=
 =?us-ascii?Q?Bf5hBMUoSrOieeocsD44FPIMOc7WsoeHvFAunofKi6qoocdFsR/dYZjWF4tP?=
 =?us-ascii?Q?2MLsAt8PjWKmDgjq7HgeUe1KsUzfpijzVNLq0DpXUTxSw5ovUSQpxFZ3d8kl?=
 =?us-ascii?Q?xQmv98Gh0Y9UnPsUIQ+BHOzyvCONZGDzgV/MSiR1RRQbctu23pPrrxiLvQgz?=
 =?us-ascii?Q?ZhER9BNIXwS6fJ8IZUieOqaqPtyZPvCtYPLLPPxHJOXEsmZVNjtLUgulTujv?=
 =?us-ascii?Q?i/b3QZ/2iSo99U2tJS7g/6ZkRHtLNp6p19WC3FDq0ULGOnGfJiPSqgxsc0CU?=
 =?us-ascii?Q?XYPnHYsNAr10Al3LRuwx+XnrlD6ww6iwKKmNOsLwbIYcmoGLSQIZf90yAvbQ?=
 =?us-ascii?Q?Yvxmk4VKTQejPAluukfgHIt2NFt8wBpzJeUbp7OYTxEjZO3kw4kHvjq/CGkY?=
 =?us-ascii?Q?ptyYnFh1pjOf3XoYL6y0QIBocG7MqoMetCEEudVoDLJU2HydcdLpHxl49G2D?=
 =?us-ascii?Q?/pkg9HM3JZN1hB6u5u4tm3OkiODAW20t686rY47yihHDzORnnGnVqW3OkC+W?=
 =?us-ascii?Q?E+V1h+y2LIOHPMAuSYYbPq2a0Tie9GiIfNKxgyvQ8MMa5vz/5wRY4gkQHEZR?=
 =?us-ascii?Q?MdnstTDwscBulRNt3a/NGNOG/Yggozde1S7wJnMTziq2Kv3Xf0tJDeEOUbRT?=
 =?us-ascii?Q?kw0BDBL7XtFywFwV6H5Ta3Tjvs7ecAQtWUyRjyS9PAM12e4O9oCaUpA3yBH9?=
 =?us-ascii?Q?0l6z2sI4MpVzquwDs9TG8+R3YQn8WRgKRogODPqwvnzguotPW99iykzlaTZ0?=
 =?us-ascii?Q?OwtQli8Dm5oXR5mPK3X3W+Xz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541d3d88-3640-4b31-0ab8-08d9149112ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2021 15:25:57.1682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P0tSUNDrZeaQjcM+mb7aFAhYT5mkdBHlmpfmmH3fBcNrublvbJrffh2WJSp40Ef4tibFXyYNPt5KNXzqFzxUdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3020
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add the (HWID, MCATYPE) tuples and names for new
SMCA bank types.

Also, add their respective error descriptions to the MCE
decoding module edac_mce_amd.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  5 +++
 arch/x86/kernel/cpu/mce/amd.c | 16 ++++++++
 drivers/edac/mce_amd.c        | 70 +++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ddfb3cad8dff..cf7f35fdf2c8 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -317,6 +317,7 @@ enum smca_bank_types {
 	SMCA_CS_V2,	/* Coherent Slave */
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
+	SMCA_UMC_V2,	/* Unified Memory Controller */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_PSP_V2,	/* Platform Security Processor */
@@ -325,6 +326,10 @@ enum smca_bank_types {
 	SMCA_MP5,	/* Microprocessor 5 Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
+	SMCA_PCIE_V2,	/* PCI Express Unit */
+	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
+	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e486f96b3cb3..055f3a0acf5e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -90,6 +90,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
 	[SMCA_PIE]	= { "pie",		"Power, Interrupts, etc." },
 	[SMCA_UMC]	= { "umc",		"Unified Memory Controller" },
+	[SMCA_UMC_V2]	= { "umc_v2",		"Unified Memory Controller" },
 	[SMCA_PB]	= { "param_block",	"Parameter Block" },
 	[SMCA_PSP]	= { "psp",		"Platform Security Processor" },
 	[SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
@@ -98,6 +99,10 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_MP5]	= { "mp5",		"Microprocessor 5 Unit" },
 	[SMCA_NBIO]	= { "nbio",		"Northbridge IO Unit" },
 	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
+	[SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
+	[SMCA_XGMI_PCS]	= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
+	[SMCA_XGMI_PHY]	= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
+	[SMCA_WAFL_PHY]	= { "wafl_phy",		"WAFL PHY Unit" },
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -155,6 +160,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
+	{ SMCA_UMC_V2,	 HWID_MCATYPE(0x96, 0x1)	},
 
 	/* Parameter Block MCA type */
 	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
@@ -175,6 +181,16 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* PCI Express Unit MCA type */
 	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
+	{ SMCA_PCIE_V2,	 HWID_MCATYPE(0x46, 0x1)	},
+
+	/* xGMI PCS MCA type */
+	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
+
+	/* xGMI PHY MCA type */
+	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
+
+	/* WAFL PHY MCA type */
+	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5dd905a3f30c..5515fd9336b1 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -323,6 +323,21 @@ static const char * const smca_umc_mce_desc[] = {
 	"AES SRAM ECC error",
 };
 
+static const char * const smca_umc2_mce_desc[] = {
+	"DRAM ECC error",
+	"Data poison error",
+	"SDP parity error",
+	"Reserved",
+	"Address/Command parity error",
+	"Write data parity error",
+	"DCQ SRAM ECC error",
+	"Reserved",
+	"Read data parity error",
+	"Rdb SRAM ECC error",
+	"RdRsp SRAM ECC error",
+	"LM32 MP errors",
+};
+
 static const char * const smca_pb_mce_desc[] = {
 	"An ECC error in the Parameter Block RAM array",
 };
@@ -400,6 +415,56 @@ static const char * const smca_pcie_mce_desc[] = {
 	"CCIX Non-okay write response with data error",
 };
 
+static const char * const smca_pcie2_mce_desc[] = {
+	"SDP Parity Error logging",
+};
+
+static const char * const smca_xgmipcs_mce_desc[] = {
+	"DataLossErr",
+	"TrainingErr",
+	"FlowCtrlAckErr",
+	"RxFifoUnderflowErr",
+	"RxFifoOverflowErr",
+	"CRCErr",
+	"BERExceededErr",
+	"TxVcidDataErr",
+	"ReplayBufParityErr",
+	"DataParityErr",
+	"ReplayFifoOverflowErr",
+	"ReplayFIfoUnderflowErr",
+	"ElasticFifoOverflowErr",
+	"DeskewErr",
+	"FlowCtrlCRCErr",
+	"DataStartupLimitErr",
+	"FCInitTimeoutErr",
+	"RecoveryTimeoutErr",
+	"ReadySerialTimeoutErr",
+	"ReadySerialAttemptErr",
+	"RecoveryAttemptErr",
+	"RecoveryRelockAttemptErr",
+	"ReplayAttemptErr",
+	"SyncHdrErr",
+	"TxReplayTimeoutErr",
+	"RxReplayTimeoutErr",
+	"LinkSubTxTimeoutErr",
+	"LinkSubRxTimeoutErr",
+	"RxCMDPktErr",
+};
+
+static const char * const smca_xgmiphy_mce_desc[] = {
+	"RAM ECC Error",
+	"ARC instruction buffer parity error",
+	"ARC data buffer parity error",
+	"PHY APB error",
+};
+
+static const char * const smca_waflphy_mce_desc[] = {
+	"RAM ECC Error",
+	"ARC instruction buffer parity error",
+	"ARC data buffer parity error",
+	"PHY APB error",
+};
+
 struct smca_mce_desc {
 	const char * const *descs;
 	unsigned int num_descs;
@@ -418,6 +483,7 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_CS_V2]	= { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
 	[SMCA_PIE]	= { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
 	[SMCA_UMC]	= { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
+	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
 	[SMCA_PB]	= { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
 	[SMCA_PSP]	= { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
 	[SMCA_PSP_V2]	= { smca_psp2_mce_desc,	ARRAY_SIZE(smca_psp2_mce_desc)	},
@@ -426,6 +492,10 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
 	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
 	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
+	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
+	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
+	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
+	[SMCA_WAFL_PHY]	= { smca_waflphy_mce_desc, ARRAY_SIZE(smca_waflphy_mce_desc)	},
 };
 
 static bool f12h_mc0_mce(u16 ec, u8 xec)
-- 
2.17.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3BF43AACC5
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jun 2021 08:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhFQG42 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Jun 2021 02:56:28 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75]:39488
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229515AbhFQG40 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 17 Jun 2021 02:56:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RW8vYxjhoL84tZb1rCccQMgwgU5cbZyaHXm2lp84pRVeoOFbqzK/lqTwKT7jjp2P593+lwSIK7DUCi7oUzqHciqeYxHzqHCWaE0OjwyYr7L84W2mJv8pnhPPIsWtdpOlos9QB11VLejm1K25Xl9FzmXyKrcQ8Ql41TxFO9fSDlNylPzgUwbKEGNjPNxa7DZtXStGoddq2gyjAbQ7chIOT3yC7pSKfz9Unv4LEEudVU8UhAhS1qhQJszTBUBGpVQ6k81jYUDSVkE6dCVHOywurtGbhW2zwdQi2tlrUMjqwqV0lC76HjnlzN8wH0a6+VLWTnsZg4Kt8CnENM24aUTvsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTVEd7jdPa/QJkVgCxAFJiks2RN2gMViUNxl1zlaf4c=;
 b=XJtN1KYgICOsoGNan5VFxnAB2zeREQ2TCKHvfGguYIxbAkR9MvUYJ3sBvloIIXWPZFxQshKELMSG30m2GDhxYyuIPTIhaWUsEKRRqT7CouoK9rT4NqSieIOBsCxf2JQKX3B22Az+Xd2u0kY96ovwbUithsq7KcUyMuFO66JYdsPoRjvUEqe585DPc3LatXNw9O8ZyP+/usYnFBNXsronYBUdchrC6QLI4cgQ6a02c6u63CcWUrx/z9ZGG71Wi+huALqDMFpi0S/x1vYaDLIXgbmAbbFeQwbMCtcbWSZC3dTBo+mtXO1bMBbnAX0ybg3SrBN3XFwMcUxK/nO9qPItPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vTVEd7jdPa/QJkVgCxAFJiks2RN2gMViUNxl1zlaf4c=;
 b=hpRH/H7IMHHsWpNLGDEvh6vYhS8wYLmGogg4H0GFS+Cke1TR4qXjROJzeIBwLgi5xpnGmJX6OPoBNzGKbJzII7KLTq/DVpzavLS3IwgBNqEb6NH6b4ONxP4m44QE5UlnjfXojJ2UziKGuXUKGF0oU4MDMTlBxnzYdaX+62rh7pQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5291.namprd12.prod.outlook.com (2603:10b6:408:104::13)
 by BN9PR12MB5051.namprd12.prod.outlook.com (2603:10b6:408:134::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 06:54:17 +0000
Received: from BN9PR12MB5291.namprd12.prod.outlook.com
 ([fe80::3dba:a5b2:37ed:ed33]) by BN9PR12MB5291.namprd12.prod.outlook.com
 ([fe80::3dba:a5b2:37ed:ed33%8]) with mapi id 15.20.4219.025; Thu, 17 Jun 2021
 06:54:17 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     mchehab@kernel.org
Subject: [PATCH] rasdaemon: Add new SMCA bank types with error decoding
Date:   Thu, 17 Jun 2021 13:02:33 +0530
Message-Id: <20210617073233.14498-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::18) To BN9PR12MB5291.namprd12.prod.outlook.com
 (2603:10b6:408:104::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MAXPR0101CA0056.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:e::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 06:54:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 121add6f-bcd7-46e0-a7bc-08d9315cb977
X-MS-TrafficTypeDiagnostic: BN9PR12MB5051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB505180DB2AA2E3D813241760E80E9@BN9PR12MB5051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9F/ipp7Rk61ZfTtpM7JR1c4K/fLxlxC5oCtd2WBx34uEAhY6JIjX0J5cBYnXzNVceA6XE7SnR0PuDQ4W40zhK7MABHAEoV4hHEkiFVDc9o2A9MOARKDJNWM5AGMx4xXp6YAtOSWGo1YAq7057HqMnXObfpmZZVVrFMSRrZyv88K8AeumF055yt2YRIrjoPemC/5wqdWUWv9xYM43TYnhRfxhg7jUhJyGGh4+UAh0gSMFIgZ7uuHXcAEnclfDEXc8CZWjwttRs/AJ2ge4B3ATJ0+dMNu81BnQL2MW6+AB5rtnNtrMqVx0tPLmYigy/ARYf1+XnuLNPUITJFH5b8PlIzgO7e9Gb5qGw9iUJi9LRTpizD9FLb7vcuK/7/BOIFDJSKEQWajrHhAhTBZ7PEUySSywZFdtPKSUbUt2tWHdqJ1vGWU9bCgt2FjBzELFMQErY+ekdZBA3h8OFd/qZpHJlIeBcPlfj7+OGQRTqW5DqS7fUZU+rDuRpsN/R0OfIy69FbNx2ljGuk/TLaFWbD+etU1j6/CmMrZ4+jUEoBaZ8dki/AWnbae0nwCLs4gwE3p3U0Y5F7dCkWcwgLt3cIXIsJtx+ShSh14fJeR4zsLIjVjL+3sFVZhinvwr0F0zPA1TYkdWyxQnJu89r1RAZBoEdZ1i8/bHsiR4hKd4fJ3V8R4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5291.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(346002)(136003)(366004)(396003)(376002)(38350700002)(7696005)(38100700002)(16526019)(6486002)(478600001)(52116002)(36756003)(26005)(66946007)(66556008)(15650500001)(66476007)(186003)(2906002)(8936002)(2616005)(956004)(83380400001)(5660300002)(6666004)(1076003)(316002)(6916009)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d74efyx2U+L/SVPLQo6JCNqCuI3m1Mwep7GWAgKRZqjCFA1VwoGhKe2dATNH?=
 =?us-ascii?Q?QCEaRHm7RK/+eDEN2qVv4+wW/fGorK0aDzSiyOtkIg09lxOcHo6Ru2b/0XtK?=
 =?us-ascii?Q?vNQkEC4Mq8U2xCwMOk/B4jUzceeiDiNhFB02LaQcUJ8VtYCx0/YrvLrhnnJu?=
 =?us-ascii?Q?5zlJD8YAjULD46r7MquV0T0Mv2MiADqGQkG44E+6iR5GPYIzs78M7m/Ek2kG?=
 =?us-ascii?Q?d2nBcCVSbUcguR7YstXVetQnu5j9fnetem7WegIWMgFUxPIfg+8JiSgvgw+X?=
 =?us-ascii?Q?9a0w6EDCArIMr2W1Y+Jg7/gUJb6O3ViK9yiRXaB/wMefbTAW75s3GpihNU9w?=
 =?us-ascii?Q?wUcbRavkPnPOCbV7WXL8zPL+46dI5B3USFpJilSj6GzrpY6NsaXNOXiKGzqz?=
 =?us-ascii?Q?T1rWbRNFoTGLyjA/quTOjixq4C/+WrcZRC1CJWMWrrExOEvcl3EEgo+2zxcs?=
 =?us-ascii?Q?8jlQ1NNpLnER3tl65v8/FdSKVqmGUzWjj2cA22Xh19xNtjNqJGECwO660j/3?=
 =?us-ascii?Q?lgs3y948lqG6KLSdZCaqVV11NhkyfhnUA79tFDNIw634QGj3JPACI6ectbX6?=
 =?us-ascii?Q?BeBSoXZ12StqN7QpUuVs7aK1AWqYyOzPcLfpcqgSoxQ6WQeRRKvfdIYjHZTv?=
 =?us-ascii?Q?UWooLCsSdi6sdIikl8Zh4g5INXRAmJHrj0xXRPFkYozaw5Se+/ptP1KHWP/3?=
 =?us-ascii?Q?GnXh3ICQf/n+hiZB/fEpl7/DSLPRkQkIPn/HNGxC5DbUmXw1vKaA4peFzKYF?=
 =?us-ascii?Q?c7lMxvW2SdQSuUUdt5qRAk1l9e9c7VX7Irc64yblYoKn0GKnvERcXNfGroKm?=
 =?us-ascii?Q?zVLy6Ngp83z0V7c/B+/xynB0Ssu7NopkgQLMgPoNFd6iJ0Cx9RakcH25TxRG?=
 =?us-ascii?Q?3bJQ0BVJvxPkkt119V65FcaBAE+b3rVbaWxUQAtL9rB/7tUWXcy1YIYZp+lK?=
 =?us-ascii?Q?FTbJxWIE+ljTvGfwrBUNA2eLgNiD9q193xFF0I0HoOmFPdwK6QSUrB+PiLhu?=
 =?us-ascii?Q?gecOq7pSuFVD+A4QtcyZhMcIeZ4BZxkOrOijZHUjva0NlHmQ1m67G6G9vYXX?=
 =?us-ascii?Q?fyngk8j9HNxeGtzC+kyPwmz90B93CZwJr3jNmF7AvUFWEb/VvWsgGexxcoYr?=
 =?us-ascii?Q?xPhxClFDtxzpnlT68VjXwsvMQiMuG2Ilyi1DZa3tzVDEKTTNwWUeSnNGD25v?=
 =?us-ascii?Q?FxgWrOcOa3NQgg1NzdRSvzg45qS8j2jOy0AZO6mq+2JvUtYcE0piTy9aj9HN?=
 =?us-ascii?Q?HYUCpX3hkeaU08M9JYF/riLv2Y/RAESTaByZR0XePc+uRVIgPENE5/lmsQZi?=
 =?us-ascii?Q?fIm+cPURXcg6YawjhC1fudYQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121add6f-bcd7-46e0-a7bc-08d9315cb977
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5291.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 06:54:17.1419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtcTLlV379fEC76BB/d3fI1XDFblzAmZvrP2+e72KNgm7qn0XI2/1iQYurPa5vHuReyo4GcbeelmACCN+gLO0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5051
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Upcoming systems with Scalable Machine Check Architecture (SMCA) have
new MCA banks added.

This patch adds the (HWID, MCATYPE) tuple, name and error decoding for
those new SMCA banks.
While at it, optimize the string names in smca_bank_name[].

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
 mce-amd-smca.c | 138 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 25 deletions(-)

diff --git a/mce-amd-smca.c b/mce-amd-smca.c
index 7c619fd..e0cf512 100644
--- a/mce-amd-smca.c
+++ b/mce-amd-smca.c
@@ -47,7 +47,7 @@
 /* These may be used by multiple smca_hwid_mcatypes */
 enum smca_bank_types {
 	SMCA_LS = 0,    /* Load Store */
-	SMCA_LS_V2,	/* Load Store */
+	SMCA_LS_V2,
 	SMCA_IF,        /* Instruction Fetch */
 	SMCA_L2_CACHE,  /* L2 Cache */
 	SMCA_DE,        /* Decoder Unit */
@@ -56,17 +56,22 @@ enum smca_bank_types {
 	SMCA_FP,        /* Floating Point */
 	SMCA_L3_CACHE,  /* L3 Cache */
 	SMCA_CS,        /* Coherent Slave */
-	SMCA_CS_V2,     /* Coherent Slave V2 */
+	SMCA_CS_V2,
 	SMCA_PIE,       /* Power, Interrupts, etc. */
 	SMCA_UMC,       /* Unified Memory Controller */
+	SMCA_UMC_V2,
 	SMCA_PB,        /* Parameter Block */
 	SMCA_PSP,       /* Platform Security Processor */
-	SMCA_PSP_V2,    /* Platform Security Processor V2 */
+	SMCA_PSP_V2,
 	SMCA_SMU,       /* System Management Unit */
-	SMCA_SMU_V2,    /* System Management Unit V2 */
+	SMCA_SMU_V2,
 	SMCA_MP5,	/* Microprocessor 5 Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
+	SMCA_PCIE_V2,
+	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
+	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
 	N_SMCA_BANK_TYPES
 };
 
@@ -237,6 +242,22 @@ static const char * const smca_umc_mce_desc[] = {
 	"Command/address parity error",
 	"Write data CRC error",
 };
+
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
 /* Parameter Block */
 static const char * const smca_pb_mce_desc[] = {
 	"Parameter Block RAM ECC error",
@@ -314,6 +335,55 @@ static const char * const smca_pcie_mce_desc[] = {
 	"CCIX Non-okay write response with data error",
 };
 
+static const char * const smca_pcie2_mce_desc[] = {
+	"SDP Parity Error logging",
+};
+
+static const char * const smca_xgmipcs_mce_desc[] = {
+	"Data Loss Error",
+	"Training Error",
+	"Flow Control Acknowledge Error",
+	"Rx Fifo Underflow Error",
+	"Rx Fifo Overflow Error",
+	"CRC Error",
+	"BER Exceeded Error",
+	"Tx Vcid Data Error",
+	"Replay Buffer Parity Error",
+	"Data Parity Error",
+	"Replay Fifo Overflow Error",
+	"Replay Fifo Underflow Error",
+	"Elastic Fifo Overflow Error",
+	"Deskew Error",
+	"Flow Control CRC Error",
+	"Data Startup Limit Error",
+	"FC Init Timeout Error",
+	"Recovery Timeout Error",
+	"Ready Serial Timeout Error",
+	"Ready Serial Attempt Error",
+	"Recovery Attempt Error",
+	"Recovery Relock Attempt Error",
+	"Replay Attempt Error",
+	"Sync Header Error",
+	"Tx Replay Timeout Error",
+	"Rx Replay Timeout Error",
+	"LinkSub Tx Timeout Error",
+	"LinkSub Rx Timeout Error",
+	"Rx CMD Pocket Error",
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
 
 struct smca_mce_desc {
 	const char * const *descs;
@@ -333,6 +403,7 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_CS_V2]    = { smca_cs2_mce_desc,  ARRAY_SIZE(smca_cs2_mce_desc) },
 	[SMCA_PIE]      = { smca_pie_mce_desc,  ARRAY_SIZE(smca_pie_mce_desc) },
 	[SMCA_UMC]      = { smca_umc_mce_desc,  ARRAY_SIZE(smca_umc_mce_desc) },
+	[SMCA_UMC_V2]	= { smca_umc2_mce_desc,	ARRAY_SIZE(smca_umc2_mce_desc)	},
 	[SMCA_PB]       = { smca_pb_mce_desc,   ARRAY_SIZE(smca_pb_mce_desc)  },
 	[SMCA_PSP]      = { smca_psp_mce_desc,  ARRAY_SIZE(smca_psp_mce_desc) },
 	[SMCA_PSP_V2]   = { smca_psp2_mce_desc, ARRAY_SIZE(smca_psp2_mce_desc)},
@@ -341,6 +412,10 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_MP5]      = { smca_mp5_mce_desc,  ARRAY_SIZE(smca_mp5_mce_desc) },
 	[SMCA_NBIO]     = { smca_nbio_mce_desc, ARRAY_SIZE(smca_nbio_mce_desc)},
 	[SMCA_PCIE]     = { smca_pcie_mce_desc, ARRAY_SIZE(smca_pcie_mce_desc)},
+	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
+	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
+	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
+	[SMCA_WAFL_PHY]	= { smca_waflphy_mce_desc, ARRAY_SIZE(smca_waflphy_mce_desc)	},
 };
 
 struct smca_hwid {
@@ -369,6 +444,8 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,      0x00000096 },
+	/* Heterogeneous systems may have both UMC and UMC_v2 types on the same node. */
+	{ SMCA_UMC_V2,   0x00010096 },
 
 	/* Parameter Block MCA type */
 	{ SMCA_PB,       0x00000005 },
@@ -389,6 +466,16 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* PCI Express Unit MCA type */
 	{ SMCA_PCIE,     0x00000046 },
+	{ SMCA_PCIE_V2,  0x00010046 },
+
+	/* Ext Global Memory Interconnect PCS MCA type */
+	{ SMCA_XGMI_PCS, 0x00000050 },
+
+	/* Ext Global Memory Interconnect PHY MCA type */
+	{ SMCA_XGMI_PHY, 0x00000259 },
+
+	/* WAFL PHY MCA type */
+	{ SMCA_WAFL_PHY, 0x00000267 },
 };
 
 struct smca_bank_name {
@@ -396,27 +483,28 @@ struct smca_bank_name {
 };
 
 static struct smca_bank_name smca_names[] = {
-	[SMCA_LS]       = { "Load Store Unit" },
-	[SMCA_LS_V2]    = { "Load Store Unit" },
-	[SMCA_IF]       = { "Instruction Fetch Unit" },
-	[SMCA_L2_CACHE] = { "L2 Cache" },
-	[SMCA_DE]       = { "Decode Unit" },
-	[SMCA_RESERVED] = { "Reserved" },
-	[SMCA_EX]       = { "Execution Unit" },
-	[SMCA_FP]       = { "Floating Point Unit" },
-	[SMCA_L3_CACHE] = { "L3 Cache" },
-	[SMCA_CS]       = { "Coherent Slave" },
-	[SMCA_CS_V2]    = { "Coherent Slave" },
-	[SMCA_PIE]      = { "Power, Interrupts, etc." },
-	[SMCA_UMC]      = { "Unified Memory Controller" },
-	[SMCA_PB]       = { "Parameter Block" },
-	[SMCA_PSP]      = { "Platform Security Processor" },
-	[SMCA_PSP_V2]   = { "Platform Security Processor" },
-	[SMCA_SMU]      = { "System Management Unit" },
-	[SMCA_SMU_V2]   = { "System Management Unit" },
-	[SMCA_MP5]	= { "Microprocessor 5 Unit" },
-	[SMCA_NBIO]     = { "Northbridge IO Unit" },
-	[SMCA_PCIE]     = { "PCI Express Unit" },
+	[SMCA_LS ... SMCA_LS_V2]	= { "Load Store Unit" },
+	[SMCA_IF]			= { "Instruction Fetch Unit" },
+	[SMCA_L2_CACHE]			= { "L2 Cache" },
+	[SMCA_DE]			= { "Decode Unit" },
+	[SMCA_RESERVED]			= { "Reserved" },
+	[SMCA_EX]			= { "Execution Unit" },
+	[SMCA_FP]			= { "Floating Point Unit" },
+	[SMCA_L3_CACHE]			= { "L3 Cache" },
+	[SMCA_CS ... SMCA_CS_V2]	= { "Coherent Slave" },
+	[SMCA_PIE]			= { "Power, Interrupts, etc." },
+	[SMCA_UMC]			= { "Unified Memory Controller" },
+	[SMCA_UMC_V2]			= { "Unified Memory Controller V2" },
+	[SMCA_PB]			= { "Parameter Block" },
+	[SMCA_PSP ... SMCA_PSP_V2]	= { "Platform Security Processor" },
+	[SMCA_SMU ... SMCA_SMU_V2]	= { "System Management Unit" },
+	[SMCA_MP5]			= { "Microprocessor 5 Unit" },
+	[SMCA_NBIO]			= { "Northbridge IO Unit" },
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "PCI Express Unit" },
+	[SMCA_XGMI_PCS]			= { "Ext Global Memory Interconnect PCS Unit" },
+	[SMCA_XGMI_PHY]			= { "Ext Global Memory Interconnect PHY Unit" },
+	[SMCA_WAFL_PHY]			= { "WAFL PHY Unit" },
+
 };
 
 static void amd_decode_errcode(struct mce_event *e)
-- 
2.26.2


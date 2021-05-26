Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E677391CCE
	for <lists+linux-edac@lfdr.de>; Wed, 26 May 2021 18:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhEZQSi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 May 2021 12:18:38 -0400
Received: from mail-bn8nam08on2088.outbound.protection.outlook.com ([40.107.100.88]:16897
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231622AbhEZQSi (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 May 2021 12:18:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtvenwl3J0KsH5gErE4ovql+ZKwG3Y/CrWxJypAFkj/v8xeiUEB8aHvCpsfkraUzdLULgL+JWjPnZBXHKeiEfdcU0ZNbKvMwkFv6tLWzHDxeIgDDW6BqBG3JSav9U34fG5fydmWdngq63Kiyt7+C6vWDlQNp9+FqORAPVVz+Yihs0cOvn9ymNk0fpQAK8FcUvhmudVOfTjhQDi0+w3dYw24nUkkJd0PaatWXns7O94T8CIULTQoZ2sWKInQT3ZeIPiVhu6iIZw5IpbtuSw1WzHwYhvAiczAfpHcdGinKvQi9IoNc6/iSXCK94fePTVw51hxqAXdY+phTAiTEO9eTJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egk9o9DaKqFgrCnRn4IsDKrs47IIM+h5VEe9bpn80xQ=;
 b=fYHxRGJ2HUlGZXeb5JYHCSI8wjv39RpKfJvbMSaNhUJhXr7bsJ+e2lkM6Ot0TL+PmTcj6XwnXjU7Td4WdW1TA2wZZOqP98v4lU231FrPJMXacKVdcauJkr0/dYGzoCzmdSkRmMUvpHNJ+OlFf1slnaz+vB/6yAkNUodWcY7/yIGjez7uDQLK/MlAUxXmjiJN/5Ur9Ew1+iuUcCdfXweoTwAAmvr9nKNeDKSvAb5wUNq8L6BMW2lLvvFyCSKm1ibQVQOtajITZ4iotif9LhxKD1hsQWl8l1VSBklydLgXOANFTGjeiV3jwTimxTWO2YlOpetwuUWUZ2y3m3m/V5zMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Egk9o9DaKqFgrCnRn4IsDKrs47IIM+h5VEe9bpn80xQ=;
 b=eOXA7ipW6tvXP32UGYUsPRheFNI5LZz+DHGuOFSJydAGg0aa9hffwaQRvtF62YBxkvagw/dsQBKflpn76Sl/7JMWr+u19l2lDHC39p/UK2Xgra0VD3pc+i2EIGeH54hGvYtkVN+PumqY93MQ2ThItHnDJ09zfgyUnFzWQbvYdno=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10)
 by DM6PR12MB4499.namprd12.prod.outlook.com (2603:10b6:5:2ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 16:17:04 +0000
Received: from DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961]) by DM6PR12MB4388.namprd12.prod.outlook.com
 ([fe80::9030:4dbb:df11:c961%4]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 16:17:04 +0000
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     linux-edac@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de, mingo@redhat.com,
        mchehab@kernel.org, Muralidhara M K <muralimk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v2] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Date:   Wed, 26 May 2021 22:16:01 +0530
Message-Id: <20210526164601.66228-1-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210511152538.148084-1-nchatrad@amd.com>
References: <20210511152538.148084-1-nchatrad@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::11) To DM6PR12MB4388.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MA1PR01CA0176.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 16:17:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e2b10d3-c68d-4ef7-1dc7-08d92061b31e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4499:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB44998D8B8C4FBC05772D789AE8249@DM6PR12MB4499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Anz2sMNKWUUmALofeSJPgfNQ+bSiKE2riwxbcm07bKfC8FSBowhTC8PUn3W/+h1/VjscQZBK8OLKf+xiC6jsQikiCs7IeI+aBTP+UaswoKIZ+3HIOpSnlkTa1XThigAUPf1VAhy2oNZYGkpDyQLiVv6EpYCsHTE3RXXDnu/dBA/gmzabyV0s3+aM7Jq+9/LiYGr4D/r2YC7XmDUsiTkZlTxAivHHw7BrLfGM+lC3uzkKduN6GvpQ/9yCQiVt7Eyw9ulSnd1mD68eg+rDQeaiL3H9lTqQDEgczrAJYICIaMXR1s1f+LYnId0us1cQcyd35q8jrtpTuTn7TB9vFamSQulMgOOQMYGjCOaj0Vy6tRIGuWG/eecCi1q7Gq//vWbEOLCOlNCnEw5lvj9O1YeRmIipCTK01iUQluw0pmrngmkYE0/bBSe/c7P0hPrMnP01GU9ZzSbE+TQpgNZrgQLjOd6aF5fERa8TmC0gcXH6DcN8Al5OYxlbeUbNiJWb8knRwQv8uh14InoAD7L4CbtJm8RPGdzCj6I8wuPwIIAf+gDFLznx/OmbgkDZjvwZxy9jbVtytf5b48rec7O5JJY4eJwgZn1//bWaY9+mfhoVVYZBSU/SFGvo0LY5ZN9q56oln3a95PxVM8FfLf953A+F5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4388.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(15650500001)(66556008)(66946007)(66476007)(1076003)(6486002)(26005)(956004)(54906003)(2616005)(8936002)(52116002)(5660300002)(316002)(16526019)(7696005)(38350700002)(36756003)(186003)(8676002)(2906002)(478600001)(38100700002)(83380400001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?btWKc9izeAdg9c3LdFIE6RnDx0dLhpXaoVhvdT/o/4rnijIsxNDoJnt2FwzX?=
 =?us-ascii?Q?UztM6ztlm9VYuEfrO6VioSFn4xlgR1oeNLHZtxH8OAmF5j8bt+D8eTOWeZOa?=
 =?us-ascii?Q?ps4whK/IsGKaMU8sRS/g0/AwAZcNsgyaAW007iFOoWMfzMEljNqDGdD6GJUr?=
 =?us-ascii?Q?e0jgRAh0mOwtMs9ps15BEEZ+9CXac7Dt7JyiLKoqih1UdKkgT57rixxxo74j?=
 =?us-ascii?Q?L9+/KEKl4hPAaQ0deeiDsh0Fi6T8kQn487TKxMDPQ2GFUHhPE2qH/uawLm3M?=
 =?us-ascii?Q?fXt/SXWZpG/khQAtwQDgaAoKfJXyYK3r/wt0mAdybi+DiDpNjqP1pfPLGgKm?=
 =?us-ascii?Q?5lxNTH4HWQOPYizzmBQH3HYr8gNXwUeweSuBQFyvkPkcjQLymrFOp8iuLXDX?=
 =?us-ascii?Q?900Pp0z9p1HaYJedVDS0NWX0yu/aMKHYksDjJhneFUR6mbMGEkIjDsN4YVuC?=
 =?us-ascii?Q?AFm5CssicHUp6W0hbD1jrwD2SkR27iVJ9Gyk1ymmvn4sCgy/mLvX50D8IP3r?=
 =?us-ascii?Q?jbUQrkV/cqDVva62MQxnyQ2v78Ecn6AQkrdxMAhva0eaLdMpYTnklVIWQF25?=
 =?us-ascii?Q?hXN/VQ/ZQw119xPh6HoCRsS+5ioSuebLZcXorSNUOD051rDVRu/80GAwMXxH?=
 =?us-ascii?Q?gn3mxkfe3JP4C0/42nQeRMdB9TfdIEbKxSGLhzV+REAKv42BMhmW2oHPNfUv?=
 =?us-ascii?Q?63cv1h/sscx/AFwBrrz5zOyp9jn2wso6swS+oTXpa6YdkHxufKArRP5+ACz5?=
 =?us-ascii?Q?Wdn63fEpZq3UpkGnrJ28qSrIdgVlsDq8M76cyCJFFaZcKJqXG3YyjB99CHHu?=
 =?us-ascii?Q?jyzRuXU4bL2MHC5zMNCRlOk3j1p8190Mca/owgWzDLTBL+t6efk8iHVrLmd4?=
 =?us-ascii?Q?I2vfFxYm6UZQtH+9AXDGkqrJJa1uNK98+DSUQRAtmxjmE7nwHOfmUX1o26KC?=
 =?us-ascii?Q?FPiGqGnNL5MhmY+Vc0ZKn50ZQt9dwE49eWaBoJr2h48xqOXjRzSboyzwLkFc?=
 =?us-ascii?Q?c/rYEqQbUF2Fr4messrWkhMKId4Yj4UvBThMK5CpRh+/AvR7PTvkwob+3Zwq?=
 =?us-ascii?Q?yNb+4YFd4SM8eoK4Jxzp11N/X3GKpR1fWr8KvEuIPO6aIRkrziWMbvs0ejC8?=
 =?us-ascii?Q?3jwgv8I2g64jvAr327AAVSdldkc72QDjZZq2cUFHeykpoQVtfGIkEHh/05YX?=
 =?us-ascii?Q?KudK7OnPqCdDJy+J2gkJaJddca0Yru2UBam9LRvheSfKkxXCdqvJlYQtlQ6f?=
 =?us-ascii?Q?UzrW0pmrtmx24dlHU1tNKFeeQbwgwMCQKsvGaonohfO8ES9URFCogccewLvD?=
 =?us-ascii?Q?VNpugJcRlP/aa0h9+w85j+6T?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e2b10d3-c68d-4ef7-1dc7-08d92061b31e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4388.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 16:17:04.2550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d5QpHRoz+l3rrwiFQmAhdYDHoJ5YO5PzgJVUpFaasvGFamONROOsnkTG+EOD8xAtsMszxh/ODvoUNtKJO9pMQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4499
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add the (HWID, MCATYPE) tuples and names for new
SMCA bank types.

Also, add their respective error descriptions to the MCE
decoding module edac_mce_amd.
Also while at it, optimize the string names for some SMCA banks.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Naveen Krishna Chatradhi  <nchatrad@amd.com>
---
 arch/x86/include/asm/mce.h    |  5 +++
 arch/x86/kernel/cpu/mce/amd.c | 55 ++++++++++++++++-----------
 drivers/edac/mce_amd.c        | 70 +++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index ddfb3cad8dff..691a9985cb95 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -317,6 +317,7 @@ enum smca_bank_types {
 	SMCA_CS_V2,	/* Coherent Slave */
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
+	SMCA_UMC_V2,	/* Unified Memory Controller V2 */
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
index e486f96b3cb3..d47edf207391 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -77,27 +77,29 @@ struct smca_bank_name {
 };
 
 static struct smca_bank_name smca_names[] = {
-	[SMCA_LS]	= { "load_store",	"Load Store Unit" },
-	[SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
-	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
-	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
-	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
-	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
-	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
-	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
-	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
-	[SMCA_CS]	= { "coherent_slave",	"Coherent Slave" },
-	[SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
-	[SMCA_PIE]	= { "pie",		"Power, Interrupts, etc." },
-	[SMCA_UMC]	= { "umc",		"Unified Memory Controller" },
-	[SMCA_PB]	= { "param_block",	"Parameter Block" },
-	[SMCA_PSP]	= { "psp",		"Platform Security Processor" },
-	[SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
-	[SMCA_SMU]	= { "smu",		"System Management Unit" },
-	[SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
-	[SMCA_MP5]	= { "mp5",		"Microprocessor 5 Unit" },
-	[SMCA_NBIO]	= { "nbio",		"Northbridge IO Unit" },
-	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
+	[SMCA_LS ... SMCA_LS_V2]	= { "load_store",	"Load Store Unit" },
+	[SMCA_IF]			= { "insn_fetch",	"Instruction Fetch Unit" },
+	[SMCA_L2_CACHE]			= { "l2_cache",		"L2 Cache" },
+	[SMCA_DE]			= { "decode_unit",	"Decode Unit" },
+	[SMCA_RESERVED]			= { "reserved",		"Reserved" },
+	[SMCA_EX]			= { "execution_unit",	"Execution Unit" },
+	[SMCA_FP]			= { "floating_point",	"Floating Point Unit" },
+	[SMCA_L3_CACHE]			= { "l3_cache",		"L3 Cache" },
+	[SMCA_CS ... SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
+	[SMCA_PIE]			= { "pie",		"Power, Interrupts, etc." },
+	[SMCA_UMC]			= { "umc",		"Unified Memory Controller" },
+	[SMCA_UMC_V2]			= { "umc_v2",		"Unified Memory Controller V2" },
+	[SMCA_PB]			= { "param_block",	"Parameter Block" },
+	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
+	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
+	[SMCA_MP5]			= { "mp5",		"Microprocessor 5 Unit" },
+	[SMCA_NBIO]			= { "nbio",		"Northbridge IO Unit" },
+	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
+	[SMCA_XGMI_PCS]			= { "xgmi_pcs",
+					    "Ext Global Memory Interconnect PCS Unit" },
+	[SMCA_XGMI_PHY]			= { "xgmi_phy",
+					    "Ext Global Memory Interconnect PHY Unit" },
+	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -155,6 +157,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
+	{ SMCA_UMC_V2,	 HWID_MCATYPE(0x96, 0x1)	},
 
 	/* Parameter Block MCA type */
 	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
@@ -175,6 +178,16 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
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
index 5dd905a3f30c..43ba0f931629 100644
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
+	"Replay FIfo Underflow Error",
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
2.26.2


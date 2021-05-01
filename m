Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB683707C4
	for <lists+linux-edac@lfdr.de>; Sat,  1 May 2021 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhEAPrp (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 1 May 2021 11:47:45 -0400
Received: from mail-dm6nam08on2056.outbound.protection.outlook.com ([40.107.102.56]:33650
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230391AbhEAPrn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sat, 1 May 2021 11:47:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGAYfH28jTaRQVKzoWcX6rUS1AMdWkMj8gpXHqwKopAyJhYPYHTDc5050nMd8HT7vBwwFJVG4ZZv5hfxcqsCXt6Il6y0GQ0DicBgJb59ODXLAsWmFIemNrSshd8jE1J7Lsb/uuvzxinVbkbWolx4maR9JsK7SFQMffslenM9mXBzjf+rb2HKEi08bLhgWKZhJQivLd5uRuYZuveBUqnNpzCkaS6cE71E6EuAXwcWoYU0tOYIACkmfCotEknlTIWGX1vOo19fPEeyWaNnVY87E3K+jE20kVt9bljjfTXwyzLcfTQMIERr5CxChpzOkZ99jwSgU9VZd8yhBJxzPYA9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOvE1uM+kijfRhjaQGf8jCSfUOY1r9ii7WSikFdLb6E=;
 b=eFGKMhSGiM3OyeOLEajJEkBNoE7qU7dhrn+3duhKQM1Y45wETh5B+8WiXKV7w9kwbhAchdWEde0t7hXDNXPGk5ryY9UroDBZJlzCvRRuDj/BhKrTYytc877hROBiIu9R4GsAi05FFk0kls36xFa8Wr9aq6ST14E3lbBra7nuFss2n03PcEKnynhvUAkb2maDCdvwFIg4G6yILDT8mriLandOvc+BY8hRvIEET9nlFKNmY7j/kFQ6ICY6nY5oAydGEpcwJ8ELwHs+wKMe1MW7ha/vnAWSYWtaLjKyFxx+lGzvze5BaB7N+wVXpqOhaKKTGEUd1OZUzSJPWfrUbrt7gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOvE1uM+kijfRhjaQGf8jCSfUOY1r9ii7WSikFdLb6E=;
 b=VVXxGUl1fimHvHyp2qu1T/inJwYDMKJaqx8BN3QcZJ5I/PVig8Myvhs0zRknoi5fkbhAKR/DK3YuNIMOwUUWNrDIl0Aw4kfs025TWvi5Z+tn4crjgqP9E5v2yyVVGn/uvOLAiawE2ArzzYScWg6tZSzQzmiVgsTcjeW7VyCJKIU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Sat, 1 May
 2021 15:46:51 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::859d:af9b:3ebd:3365]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::859d:af9b:3ebd:3365%5]) with mapi id 15.20.4065.027; Sat, 1 May 2021
 15:46:51 +0000
From:   Muralidhara M K <muralimk@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     bp@alien8.de, mchehab@kernel.org, x86@kernel.org,
        Muralidhara M K <muralimk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA bank types.
Date:   Sat,  1 May 2021 21:46:43 +0530
Message-Id: <20210501161643.189876-1-muralimk@amd.com>
X-Mailer: git-send-email 2.26.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::25)
 To BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from SLES15.amd.com (165.204.156.251) by MA1PR01CA0085.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Sat, 1 May 2021 15:46:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05d2e103-64ed-4005-d33d-08d90cb85629
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5259A8345CD4E3739F4314B9855D9@BN9PR12MB5259.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9aXbc65V5j1JwgEj3gs0D8FH8aR/sh9x4FXmR8AbK4oEmksmWGtIjTAoSQnoPhXTdT5JzkYNlYAjTm2V+YombpGy2HrboBttBBWuf/NCPZ5wZsKhJLRX9ZYTc14icQRnVfPHTv/VJ+/FY7o1Xy+32unnlOHHUG4aYgp7mysN/L0rhSvV85mF9PemTiQL4LjNuVf1IK7e45xzsHIXLnEj+6NwuMC9GS8sTe9hlfj3jLa5oAw0OXMhnp1Ee3BRBL1Yfwim9Zr0pP23NKmZFEpXyvPBz0iyvxFyyxTZlop5jgQesu1cZOV4aJlJ3HkvALSNavW1D/GZXYvE74FtBeMcbXsBJaP8JpYTu7rYAn1wBTZAMnCMmk+Ex1yzMSEo3s9Fs2wKwPslt+wT43taKi8EZ9yg4RS8GMeesZ8KCggHumHTRTf75ndROYAgBMWVU4JJVbct9CeA377sKd6DLTT1Xreb4xaIaYH1qM2Qo9kd4iHJZc+L+EtRKUziFVf9HiDR0r8DWuTLfCdF92L+HQeI3AqbNEvV4BsDBMr8eS+JVSQtEmACfi7zdyA5nLtEri8xjjrKg/oNqC0mIkyYLVm+LKvpUcp+Lq2DniWSls+1cm5qOkz/J6MvFNA/JnCIZk/FTWjETNKjjVwTt5gE8kHVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(54906003)(36756003)(16526019)(26005)(6486002)(15650500001)(478600001)(1076003)(316002)(186003)(66476007)(66556008)(7696005)(38350700002)(38100700002)(66946007)(6666004)(5660300002)(8936002)(2906002)(2616005)(4326008)(6916009)(52116002)(8676002)(956004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+ejZH/150KUD6ZC2c0ZCi436PdMTJLcx/kWq9xqYwXQyGdL8p899fkL7xanC?=
 =?us-ascii?Q?2u1L/IatmMZtFAGgHxICIR3RDV6quHz8v3nTcz2vJQrmKiSc3EQ+/urHzEjA?=
 =?us-ascii?Q?E/FO3ObGqmYOzpUYzDE3jdW2Sr8BCxDmamn8+fAKLhYt77TzPpyypqIife1r?=
 =?us-ascii?Q?OAvatBIaTVxkGUO0bRdgY2QqI98+yMkAE9b9ObpV1NB9wFDlY7yLtRvnYwqW?=
 =?us-ascii?Q?dlEOt3OVn25SDOIe5GtxHJV7zc5XssDl6Ztvxz1ss60QZsdqFV9q+IbYlBQB?=
 =?us-ascii?Q?g8JCWrRvI1m+TYe91YsFBGVhQ3/22Y4HM0axfSedYmdldDmvMnrE12UNUF4C?=
 =?us-ascii?Q?R8NQ9w0Q89fGemfd7UrSsxeHRsXK6vsIw2Uj0TG2B2TTqRc1HN4f4tGK7vQR?=
 =?us-ascii?Q?ZN12YJP/cqeKDtEzaz8sVLAv74UxKGjHiY6sQO2FT506BichvOjIlR8xp/Zp?=
 =?us-ascii?Q?HOPcQ8hzbtwfGdz4XksXfGyQCBHHdWpQDvUTA6PuiwHHclXUzNVszwaJyZLS?=
 =?us-ascii?Q?6ktnAWUYc/QD1Oni837RrWNAXz690oVVZ3Rg3dTkW5T4x9ICmrNfBF1MQelv?=
 =?us-ascii?Q?I7R/xwC0L96uwyIPht9Z21kh9x93cqDEWPDM/4er4wRFmUEEWpXHXD0IA8o8?=
 =?us-ascii?Q?uTXb2crUHB80OPxBAmC46CDLXtu6EeoFvR1Nv5WLJKqaz4llVj3iD+OeboEQ?=
 =?us-ascii?Q?mzAfsvQGnnfh2muzuRbPFMHE28fookUfdtm9Lsn4HoCKXH4hgx+vT4/qvxTj?=
 =?us-ascii?Q?PbxNvozHp+5AxEfq1Q1oe5sgdDlIVx7ybkzGAcWDZbdYHMFTatUjJatwbwSF?=
 =?us-ascii?Q?dddV+GRic5eshkLE17H4UTL30WW8CQFWuZSUD/qsAGQWrEAANshlMsuuhIYK?=
 =?us-ascii?Q?Q++ca1m7odfZ9HNnDpZikPvMtldSMe5rzYmsLCYzHY2zIdxMhaSm0acraazn?=
 =?us-ascii?Q?f6Lh9F+1PiP4VjTkEoepe7IY3N35pHRblAtQeKc+Vb5Jjt408JeY4a/qnvey?=
 =?us-ascii?Q?USYZKRTyV6PaC/r6DZg0VJOueRKJRZNsKIETgrQ3JO27/9Jot5lvLfygEola?=
 =?us-ascii?Q?JWuq1NG1OqpumkuMNyTHIee/62K4QCbibCKoIkx9Q5ezlnDzKrcstlkxxiCC?=
 =?us-ascii?Q?wCY8qDHtSg6yIX/wxvdrGoDGJ9OrJDMNmZpJaXpxl2XCUyE1joeX5SY+rdgf?=
 =?us-ascii?Q?rumr9Jz+sxneQsXumo1sGQhexDVTy2TvVth4jsL3LwA9S1g9BgOlFPi3TqDI?=
 =?us-ascii?Q?wwNEuvVyld3g8oFNrl+6h1XEolsnl2XB/eEMnjV2TMxT+PXJIqsJkmQBOqOV?=
 =?us-ascii?Q?vBS0J8qL34tIj2AWtZ5+FKLx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d2e103-64ed-4005-d33d-08d90cb85629
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2021 15:46:51.1043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOXWRtg9hLHlYfcVb8MKHPawobJ1QAvFEWjccMfCuHLjGB1Mk1inWF3K5L6jqbEeAa/ofY+silmplns7K/PjCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5259
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

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
2.26.2


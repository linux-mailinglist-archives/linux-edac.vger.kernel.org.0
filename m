Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B113E7E26
	for <lists+linux-edac@lfdr.de>; Tue, 10 Aug 2021 19:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhHJRXP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 10 Aug 2021 13:23:15 -0400
Received: from mail-bn8nam11on2064.outbound.protection.outlook.com ([40.107.236.64]:48704
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229456AbhHJRXP (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 10 Aug 2021 13:23:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SekhP5vdGRlfVVUb3/pCOh3LMox1zaEHd+llha1fP7DkkXJNYnaVqF4avonQ1cJawdrae7ANA62SI2J1IMfeIC1Dn1z3gQIDxmld8H/EI/+TUIrMgjOBKLMHoKSb7BHgvlT8m4HvlmbKauBftddqJHp/t9VH+Unh9YlXqf7LQMXgABHzXIYr2/TlQy0PbvHt28eE+hxsD27WMcQyCtjOdDqoA1/kyRKhOCXDTzsOBjjai4EZfTVhx93Y7rDpx3B2gljz5WO9h96lLB2K1bhRxpo8s9tSjXMEtvIb0vHIAzSyPtmi5k5mANMOb8WNxHaDvUnDX7fn30AnmCogf39W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDRoUzm06odvHus9TYolcxm3o2UgbTEvTV+RVGT37hU=;
 b=bY5gS1c5Imv4Ix2beShxsBYmGKlAsEnGn9ip4tgqEf95ZhiAXimNrPljoZyfmb6OWzF4HiT9842RVcF2GUCJmk7OBuxFsFU1Pkj4oNFoGoe2vOqDj9+WE2zhqzEdlJjQZw86twab9FKBAOm0zzUZeLAtUcNWmcePoPy1orkaTz6vO/P0MfdqGthI9b/4BnO3KNs9iwn9iI4SlCTzQsADLehZiGxi70q3Hk13Uwry3JsZeVX9TdRpjcfIEx4bcK1nug52GMQnyidHj/2pjfQAM8Ebqotqc9Ac90/o5l3jw07oBdV/CbN3JG1iyK8THdY4aLeSBPU8WYtGivWGgREPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VDRoUzm06odvHus9TYolcxm3o2UgbTEvTV+RVGT37hU=;
 b=sC3HQCf8exfuerhgASnvzJIjNv03zcXD/7Sl3GenCuPDVgZjc56xdj9HdxMr+tUDficmAxG4ata/T6qAqAQvndY6hPpB7etzOOyfGcNtZ9aBM1ULoRZnvQwxDPcpTIwVTTWsWB+QkYkPqLF7M38daHBrJxovc7wzMiinwvTOjuc=
Received: from MW4PR04CA0015.namprd04.prod.outlook.com (2603:10b6:303:69::20)
 by MWHPR12MB1376.namprd12.prod.outlook.com (2603:10b6:300:13::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.18; Tue, 10 Aug
 2021 17:22:50 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:69:cafe::28) by MW4PR04CA0015.outlook.office365.com
 (2603:10b6:303:69::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend
 Transport; Tue, 10 Aug 2021 17:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 17:22:50 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 10 Aug
 2021 12:22:46 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <mchehab+huawei@kernel.org>, <yazen.ghannam@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH 1/4] rasdaemon: Add new SMCA bank types with error decoding
Date:   Tue, 10 Aug 2021 22:52:11 +0530
Message-ID: <20210810172214.134099-2-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810172214.134099-1-nchatrad@amd.com>
References: <20210810172214.134099-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 430242b9-2a62-4b15-fe72-08d95c237ad0
X-MS-TrafficTypeDiagnostic: MWHPR12MB1376:
X-Microsoft-Antispam-PRVS: <MWHPR12MB137675B419BD9770B314F979E8F79@MWHPR12MB1376.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PT5opLK+5v1b9+REma3Srugm/FxodXFOlz/wxG9awTNMBRDZ4DS4ueudtkUil8DASW90AZX+zfRG7MRBn2roBvZnkmZMppLGI9qK6+8h3jBIR5bA8g9jXqDfdXfPcgcx6rGxE/qHU2OQRj8BolgKhXUYYTlcnMU2YNI4qq6pr32dmObNwPk2o+X8KM1r03iGDfIn3oAzIHKmwA68pIayX2dOKIy7pwtK4RnNRYGnPNgXO1MfTOMqWYvXQa/ULvNYr55j66Wh+ASDefpFccg9Q13zCmFDV+YwVkm0NdOLTFIL4O1ijVx9qDeCEy8z8xb52gb5UurpwGn6Ndx4HmYoDhbWSFfSXb5KTvqoKpSC/LPEw/5M99q0E0h37isymvsT2VVg3sj72Q8AaShcDdTOhxbDomcgoTQu5CUI1bFP3gUVxPJ5fzcguGaeNVmsISKWHlE3H0mjnImnrlWtLidP6Pq01IT8NiKrvQkRZ04t8/ot1TgWJPnfMvntSO8shlSCenjenB+uEaOInN0kZDA5nzSrju3Gu+n2AfVv71n6nHgdZaAqbefCaBpIQ2G+KcvrNdlWwBpd8l2dSeqxv6b9akt6gyZXTcFWCmMU7i6du0t8bK7onPcmXQftmYsmcBA/g/OZqkYlPxyKLmnVXVKabOTAvjcVNLiqLOAtInPGLBkWRar8KTLo0NjhcGq/X9nHGtFDq3gTofgh5Z7hTDvVoZc6kNspmLaemEz2lBH4el3Ax6m8IlSFJjqQbNXbx79In2vpfzYv1uLuGW9Z1ChMeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(82310400003)(426003)(47076005)(1076003)(36756003)(6916009)(54906003)(81166007)(7696005)(2616005)(356005)(6666004)(316002)(26005)(336012)(8936002)(5660300002)(478600001)(34020700004)(70586007)(36860700001)(15650500001)(82740400003)(70206006)(2906002)(8676002)(83380400001)(186003)(16526019)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 17:22:50.2214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 430242b9-2a62-4b15-fe72-08d95c237ad0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1376
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Upcoming systems with Scalable Machine Check Architecture (SMCA) have
new MCA banks added.

This patch adds the (HWID, MCATYPE) tuple, name and error decoding for
those new SMCA banks.
While at it, optimize the string names in smca_bank_name[].

This patch is based on the commit below upstremed into the kernel
94a311ce248e0b53c76e110fd00511af47b72ffb

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
2.17.1


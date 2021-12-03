Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40852466F75
	for <lists+linux-edac@lfdr.de>; Fri,  3 Dec 2021 03:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350106AbhLCCEH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 21:04:07 -0500
Received: from mail-sn1anam02on2041.outbound.protection.outlook.com ([40.107.96.41]:41369
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240452AbhLCCEF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Dec 2021 21:04:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVPqt2JoSibRpAUHZeHcGS7uPCC1E1NF6kvJ3m0wT/TDrVY8a3tNCP55AZzpF2EGri+PPWmQzdHj5Z4zqwrjZNgSwGU87Tj6asJFFwZUqMGlck3WGnfWE2I4OWm1POyzOAvtSMYb01I+U0zqYgeBrupvCLx5RIrUPefST2AG/N3W7Pl/HGmRgndkWc3W/c6phF19agdtv38fdXDdwTOT22DDp53Bfp9t4ylTAETRW20ERV1fFDeoFc2Xxjqp75JZtEAMJMNyIOZw13HrRSfDdmVIazUNELMHw68yTUXI1Le1/zPLjm1VI+6qSVhg3IVrtrD081MDguwGTV0igPKcLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bauXyoSNpDtfaIczXcYut3V/38OOtMf7VO2B0WRp24=;
 b=LgSMTTql2GlnTL8bfHklN6YFRbB68/CLNt/uripM6Y0mJJSO3nGH+uP0RZge7AaF+vs/7x9mrottStR1sgE3xNgEQxBlvlKtR1uqOwOd0SGxc9hREd1yzs8DFUp2E+cSpOLkCxf8m2rtEwG9PeNM7qDZDWnqu9mr1MoQrXp5/bJLAivTBLsSgf9VCUpGEuauO4ve8SE6p6obaQIT9qO/xiITa7SX1ju1FUTJNkFZnsLz0NJTMLYx9EKY9jrsCnJSJm/C20tbw8m/3P/DE8e2RIcLpwpfmNIbvoiH5pIPdonwcADyAi5wts2QTth96BOkoTdWJm5QtwWRPoy1dYBL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bauXyoSNpDtfaIczXcYut3V/38OOtMf7VO2B0WRp24=;
 b=JnkSgkxxSOlwW0lWAJpHnWXknjibkgoDrM9yaxzc2p06Lt2shwd/v/riQJNlWIFmcJ/0qEcl7aEnwNnm/x6JH38101V+b3IuBACIvFDzz4svrmtRZxllIfZm6942TlGV3rfCiHUeG3PmAwH6lFbzfskSkHYSCEyFyekPxA6WJqk=
Received: from MW4PR04CA0137.namprd04.prod.outlook.com (2603:10b6:303:84::22)
 by BL1PR12MB5045.namprd12.prod.outlook.com (2603:10b6:208:310::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 02:00:40 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::51) by MW4PR04CA0137.outlook.office365.com
 (2603:10b6:303:84::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 02:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 02:00:39 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 20:00:38 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <mukul.joshi@amd.com>, <alexander.deucher@amd.com>,
        <william.roche@oracle.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/3] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA Bank Types
Date:   Fri, 3 Dec 2021 02:00:16 +0000
Message-ID: <20211203020017.728440-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211203020017.728440-1-yazen.ghannam@amd.com>
References: <20211203020017.728440-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9cf2408-3558-44b2-99a4-08d9b600b4bd
X-MS-TrafficTypeDiagnostic: BL1PR12MB5045:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50459E989A78C1C2E69CE4B8F86A9@BL1PR12MB5045.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k2OMjHPGAtzF9PGxdQ9uAIPbBFMyr3vjMazYd4W7Sy/zMtVP5XqrdyuA4J2sRFWXKEv4Kcecu3HhhqQYKJbC/w6WIT9+sfzv9TJFNt5ptHfbRLPaTasIhYgSvRY6kHWZUJW+L12QGmZlnsLmhJKsJO+xhUZ7o6YnAa3o6Zr1Txn1gV71jQOEn17s5fu2QGa5HDK0K8PFb3/gka6rc64p3/CrhJ16fSllOECue/ks2xEUpE/un4RwmH05uwTRgzMJIDBSsidigapQ5F/Yk61Cz8LZaRXdtDoWQiA9fR5pAl9Z1AttcO0zYLFKTI+JThLbWxG1NJUQb01zW7u5XPCgg5ut8jrN9kn3Tck19xL9E2jZ+4X8eZMWsYP7zvc3ZFLNBR7xZsXL/xuQuvayeoMh6xjcWchQFx3AhwOUrNh3CaQ/RlSHtJZf/ni8dJRZug3TMvd+sKhUY/qkJ+YnVaJrwo4SYutNto3IPpZ5XulPxUH36Pbxijr1nXDqZmQH9Dq7bHPMg8DaqaEVxEZPjlWDR0tZd4WLAgKqYvsEFifLO8XhFaHy6kl+BiocYKq+dJzbDDpp2P9WN4/zqsDZnQWKtuzMFl4dNunFmGSz7YBThVIzHkqqT5hGuOoOXK4VDauOU9Cl59DeKwp2WLIW9v+ItoyGH0yQ0fWSkt8vqynv22oNfdM35QQXiRXiumv4sOsQa8dh6vRP7Fi/FvlWcPsceciAGzyvzbZt+9svzOCU3F3Q2+yJxfvZjkE3rNWLYopjPNAwAaupWFiP27j0f8USoYekykkoAU7z5F6EK+YLFn8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(6916009)(81166007)(36756003)(356005)(8936002)(508600001)(426003)(8676002)(6666004)(47076005)(4326008)(2616005)(44832011)(82310400004)(40460700001)(30864003)(5660300002)(186003)(83380400001)(2906002)(70206006)(1076003)(16526019)(316002)(36860700001)(7696005)(336012)(54906003)(86362001)(26005)(70586007)(15650500001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:00:39.6653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cf2408-3558-44b2-99a4-08d9b600b4bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5045
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add HWID and McaType values for new SMCA bank types, and add their error
descriptions to edac_mce_amd.

The "PHY" bank types all have the same error descriptions, and the NBIF
and SHUB bank types have the same error descriptions. So reuse the same
arrays where appropriate.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |   7 ++
 arch/x86/kernel/cpu/mce/amd.c |  28 +++++++
 drivers/edac/mce_amd.c        | 133 ++++++++++++++++++++++++++++++++--
 3 files changed, 162 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 7c1c35909946..d6834e8fbb6a 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -313,12 +313,19 @@ enum smca_bank_types {
 	SMCA_SMU,	/* System Management Unit */
 	SMCA_SMU_V2,
 	SMCA_MP5,	/* Microprocessor 5 Unit */
+	SMCA_MPDMA,	/* MPDMA Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
 	SMCA_PCIE_V2,
 	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_NBIF,	/* NBIF Unit */
+	SMCA_SHUB,	/* System HUB Unit */
+	SMCA_SATA,	/* SATA Unit */
+	SMCA_USB,	/* USB Unit */
+	SMCA_GMI_PCS,	/* GMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
+	SMCA_GMI_PHY,	/* GMI PHY Unit */
 	SMCA_UNKNOWN,	/* Unknown type */
 	N_SMCA_BANK_TYPES
 };
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b9a5a94914a9..e12a8f3414f5 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -95,11 +95,18 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_PSP ... SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
 	[SMCA_SMU ... SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
 	[SMCA_MP5]			= { "mp5",		"Microprocessor 5 Unit" },
+	[SMCA_MPDMA]			= { "mpdma",		"MPDMA Unit" },
 	[SMCA_NBIO]			= { "nbio",		"Northbridge IO Unit" },
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= { "pcie",		"PCI Express Unit" },
 	[SMCA_XGMI_PCS]			= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
+	[SMCA_NBIF]			= { "nbif",		"NBIF Unit" },
+	[SMCA_SHUB]			= { "shub",		"System Hub Unit" },
+	[SMCA_SATA]			= { "sata",		"SATA Unit" },
+	[SMCA_USB]			= { "usb",		"USB Unit" },
+	[SMCA_GMI_PCS]			= { "gmi_pcs",		"Global Memory Interconnect PCS Unit" },
 	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
 	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
+	[SMCA_GMI_PHY]			= { "gmi_phy",		"Global Memory Interconnect PHY Unit" },
 	[SMCA_UNKNOWN]			= { "unknown",		"Unrecognized Bank Type" },
 };
 
@@ -175,6 +182,9 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* Microprocessor 5 Unit MCA type */
 	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2)	},
 
+	/* MPDMA MCA type */
+	{ SMCA_MPDMA,	 HWID_MCATYPE(0x01, 0x3)	},
+
 	/* Northbridge IO Unit MCA type */
 	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
@@ -185,12 +195,30 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* xGMI PCS MCA type */
 	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
 
+	/* NBIF MCA type */
+	{ SMCA_NBIF,	 HWID_MCATYPE(0x6C, 0x0)	},
+
+	/* SHUB MCA type */
+	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
+
+	/* SATA MCA type */
+	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
+
+	/* USB MCA type */
+	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+
+	/* GMI PCS MCA type */
+	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
+
 	/* xGMI PHY MCA type */
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
 
 	/* WAFL PHY MCA type */
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
 
+	/* GMI PHY MCA type */
+	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
+
 	/* Unknown type - this must be last in the list */
 	{ SMCA_UNKNOWN,  HWID_MCATYPE(0xFFF, 0xFFFF)	},
 };
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5ccc09db0a51..720df7b4d6ab 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -399,6 +399,63 @@ static const char * const smca_mp5_mce_desc[] = {
 	"Instruction Tag Cache Bank B ECC or parity error",
 };
 
+static const char * const smca_mpdma_mce_desc[] = {
+	"Main SRAM [31:0] bank ECC or parity error",
+	"Main SRAM [63:32] bank ECC or parity error",
+	"Main SRAM [95:64] bank ECC or parity error",
+	"Main SRAM [127:96] bank ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"System Hub Read Buffer ECC or parity error",
+	"MPDMA TVF DVSEC Memory ECC or parity error",
+	"MPDMA TVF MMIO Mailbox0 ECC or parity error",
+	"MPDMA TVF MMIO Mailbox1 ECC or parity error",
+	"MPDMA TVF Doorbell Memory ECC or parity error",
+	"MPDMA TVF SDP Slave Memory 0 ECC or parity error",
+	"MPDMA TVF SDP Slave Memory 1 ECC or parity error",
+	"MPDMA TVF SDP Slave Memory 2 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 0 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 1 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 2 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 3 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 4 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 5 ECC or parity error",
+	"MPDMA TVF SDP Master Memory 6 ECC or parity error",
+	"MPDMA PTE Command FIFO ECC or parity error",
+	"MPDMA PTE Hub Data FIFO ECC or parity error",
+	"MPDMA PTE Internal Data FIFO ECC or parity error",
+	"MPDMA PTE Command Memory DMA ECC or parity error",
+	"MPDMA PTE Command Memory Internal ECC or parity error",
+	"MPDMA PTE DMA Completion FIFO ECC or parity error",
+	"MPDMA PTE Tablewalk Completion FIFO ECC or parity error",
+	"MPDMA PTE Descriptor Completion FIFO ECC or parity error",
+	"MPDMA PTE ReadOnly Completion FIFO ECC or parity error",
+	"MPDMA PTE DirectWrite Completion FIFO ECC or parity error",
+	"SDP Watchdog Timer expired",
+};
+
 static const char * const smca_nbio_mce_desc[] = {
 	"ECC or Parity error",
 	"PCIE error",
@@ -458,11 +515,66 @@ static const char * const smca_xgmiphy_mce_desc[] = {
 	"PHY APB error",
 };
 
-static const char * const smca_waflphy_mce_desc[] = {
-	"RAM ECC Error",
-	"ARC instruction buffer parity error",
-	"ARC data buffer parity error",
-	"PHY APB error",
+static const char * const smca_nbif_mce_desc[] = {
+	"Timeout error from GMI",
+	"SRAM ECC error",
+	"NTB Error Event",
+	"SDP Parity error",
+};
+
+static const char * const smca_sata_mce_desc[] = {
+	"Parity error for port 0",
+	"Parity error for port 1",
+	"Parity error for port 2",
+	"Parity error for port 3",
+	"Parity error for port 4",
+	"Parity error for port 5",
+	"Parity error for port 6",
+	"Parity error for port 7",
+};
+
+static const char * const smca_usb_mce_desc[] = {
+	"Parity error or ECC error for S0 RAM0",
+	"Parity error or ECC error for S0 RAM1",
+	"Parity error or ECC error for S0 RAM2",
+	"Parity error for PHY RAM0",
+	"Parity error for PHY RAM1",
+	"AXI Slave Response error",
+};
+
+static const char * const smca_gmipcs_mce_desc[] = {
+	"Data Loss Error",
+	"Training Error",
+	"Replay Parity Error",
+	"Rx Fifo Underflow Error",
+	"Rx Fifo Overflow Error",
+	"CRC Error",
+	"BER Exceeded Error",
+	"Tx Fifo Underflow Error",
+	"Replay Buffer Parity Error",
+	"Tx Overflow Error",
+	"Replay Fifo Overflow Error",
+	"Replay Fifo Underflow Error",
+	"Elastic Fifo Overflow Error",
+	"Deskew Error",
+	"Offline Error",
+	"Data Startup Limit Error",
+	"FC Init Timeout Error",
+	"Recovery Timeout Error",
+	"Ready Serial Timeout Error",
+	"Ready Serial Attempt Error",
+	"Recovery Attempt Error",
+	"Recovery Relock Attempt Error",
+	"Deskew Abort Error",
+	"Rx Buffer Error",
+	"Rx LFDS Fifo Overflow Error",
+	"Rx LFDS Fifo Underflow Error",
+	"LinkSub Tx Timeout Error",
+	"LinkSub Rx Timeout Error",
+	"Rx CMD Pocket Error",
+	"LFDS Training Timeout Error",
+	"LFDS FC Init Timeout Error",
+	"Data Loss Error",
 };
 
 struct smca_mce_desc {
@@ -490,12 +602,21 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_SMU]	= { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
 	[SMCA_SMU_V2]	= { smca_smu2_mce_desc,	ARRAY_SIZE(smca_smu2_mce_desc)	},
 	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
+	[SMCA_MPDMA]	= { smca_mpdma_mce_desc,	ARRAY_SIZE(smca_mpdma_mce_desc)	},
 	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
 	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
 	[SMCA_PCIE_V2]	= { smca_pcie2_mce_desc,   ARRAY_SIZE(smca_pcie2_mce_desc)	},
 	[SMCA_XGMI_PCS]	= { smca_xgmipcs_mce_desc, ARRAY_SIZE(smca_xgmipcs_mce_desc)	},
+	/* NBIF and SHUB have the same error descriptions, for now. */
+	[SMCA_NBIF]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
+	[SMCA_SHUB]	= { smca_nbif_mce_desc, ARRAY_SIZE(smca_nbif_mce_desc)	},
+	[SMCA_SATA]	= { smca_sata_mce_desc, ARRAY_SIZE(smca_sata_mce_desc)	},
+	[SMCA_USB]	= { smca_usb_mce_desc,	ARRAY_SIZE(smca_usb_mce_desc)	},
+	[SMCA_GMI_PCS]	= { smca_gmipcs_mce_desc,  ARRAY_SIZE(smca_gmipcs_mce_desc)	},
+	/* All the PHY bank types have the same error descriptions, for now. */
 	[SMCA_XGMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
-	[SMCA_WAFL_PHY]	= { smca_waflphy_mce_desc, ARRAY_SIZE(smca_waflphy_mce_desc)	},
+	[SMCA_WAFL_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
+	[SMCA_GMI_PHY]	= { smca_xgmiphy_mce_desc, ARRAY_SIZE(smca_xgmiphy_mce_desc)	},
 };
 
 static bool f12h_mc0_mce(u16 ec, u8 xec)
-- 
2.25.1


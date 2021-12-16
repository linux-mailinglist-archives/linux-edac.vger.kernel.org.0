Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D98647790D
	for <lists+linux-edac@lfdr.de>; Thu, 16 Dec 2021 17:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhLPQ31 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Dec 2021 11:29:27 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:65188
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233799AbhLPQ3Y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Dec 2021 11:29:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IcreXYaFvEXMwh58JLt7g8u2XEtu1U7IP5efX5ururV3JBhiGi0jDbFL1WgyJdI1iaCSymJf4Zw4zcxlVrZjE+gcHG54B0LXoP9Z1lRv+sp3mMJQ217JH/Kwt0xR9fUvSCi5KvyTTFV3qc2iUq2Cv+ihMEcMV9mvtnHy6sXntGNVqnelbiaIExXoYkGmjKNutnQnRApvV1nZx8zJACuMuK5SbHJVcgGs9e09K8zAp+T28LZjZChIp5KkTlZVmyOCo2Nr7achtGzn/EpuitradrMSI8E++IWiKjx0hQEHe9hZjyk0ISdT1a/NLWrNwwD9ydPANjqszVD+o61wC5vduw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHUvgEej3rJPLESEVHs93Ih+scS1MfF7a1LdmnxASo4=;
 b=SXCEIRu/wRupQu/LNX0o3A1x9O56Bf24+vG263CTyMRrwxx2ynEHiULwiDOTyDihCvkIcj8O0Mm0qrjcdiq5ee6YJ/Q8xupsHyX6amgAuiBoVIMVUIshpJyhK3YTE3qJCON0pg3bRilMs8+lno19kuPIFItW6Wc3pGRiJ7IKYGBcVIc9Bakn6LcFVoe4Wkgo6oyWzEBCC7uYGppUuaSZfnHhT7VNJ/oKaoDouRsDRWflxCYWNUTiN/6wXE7rLT1W1ZiY3+E1CmDPPW4W2rhx6/VWDb3QGflu32tEgY//ZsA2mAVayen3SvGQpR+l5UJ0DM5P1ztk56fomanPS9qAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHUvgEej3rJPLESEVHs93Ih+scS1MfF7a1LdmnxASo4=;
 b=Z/940kTmDd8KkZE9e/ZVkQpc3XD6UQph7JavDgTU8Rx4MOdrUpnKAtGIyN3pt7IFEzQtl+GwVJyOt8Uhd/S4HJeOtM3F3RaoJOgyqrptdKb6UgL2h2LicEV+ub7dTqqlz1n/tCLCGCQeXyXlsC2nOvY3Ed+dm13yR66UO7bGmPk=
Received: from MW3PR05CA0012.namprd05.prod.outlook.com (2603:10b6:303:2b::17)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Thu, 16 Dec
 2021 16:29:23 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::3f) by MW3PR05CA0012.outlook.office365.com
 (2603:10b6:303:2b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.11 via Frontend
 Transport; Thu, 16 Dec 2021 16:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Thu, 16 Dec 2021 16:29:22 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 16 Dec
 2021 10:29:21 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, <alexander.deucher@amd.com>,
        <mukul.joshi@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/2] x86/MCE/AMD, EDAC/mce_amd: Add new SMCA Bank Types
Date:   Thu, 16 Dec 2021 16:29:04 +0000
Message-ID: <20211216162905.4132657-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211216162905.4132657-1-yazen.ghannam@amd.com>
References: <20211216162905.4132657-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec18de1-6683-4382-cfa0-08d9c0b137e0
X-MS-TrafficTypeDiagnostic: BY5PR12MB4965:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4965AA3F5611E040583845B7F8779@BY5PR12MB4965.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YN6NGEy7USJqNkFlALz/iVWjSD//tKz3rFhommZ55YVlwgEJeVf8iYPMClz5URX6ha/nMYkhLdpmoo0xuq+U7QauQlD29llw4neIx/HTKWEHR5YHrBPqxRUh5OgQY3Kn0k9M1AyI1d97Go9I6VY9yyuEE8c7+WluDvO9JxSsFGp4yOLD1V/DYUyRD3HB288MpRos67XQydTKEDLmPqHMucaRxmB/Ug23gpDU8shNMut1JPy9/2BvSGlmVvnEpJRM0/W1yK7ooxrSr+8mGC17kMOn6SrLJ10T09OhmwLaQbJ4OjALYtz1sTZslUZZSoGEnrOsxl8mE36J3as5OH5oYCCLz2JBmGaGIBTOYZtQ9c74RVur0t8zTMM8vyd6+ANHjz3a9RNPi6M39bxXMN60kX8BlRONbGCT9n1r0sTHOq9hl0lvrsFzyTFWiIJEa4yOEm1ebbmgwi0/aX3gnyMY7JTsw7GPLIwKRCZJPt+EKgs5dg6F/71lvw7wiIs/9XsljOKJ1ZlVRlXcAqffIs5vGR/nAy2qh+lPpWpaTNkqKdSinRIVn6r6DaR1MGDZmXg9PPRQQl7KwVPUyhB3u8Q2DClBPXd4pobF0P27c8ClWBm2nz0USpa/9XcYExw7sFMMqZBrtPlczmkyJPmMd3z5B+d0tGQtsKWUw+GxA8dp8qIfJdl4j7qpYZ7eJO2QaTOfq6AfIpYOnPs6+EXlZEuXX+Jad77+3isQcTbZazyagfng/y4EJhgLpuRNGyN1ooPQXyJutQMF3iCSX/DyMGht8ZKgHCnu35aMUbrgGLm3hnxBZFoAxtT3yFLOkTM6iFC5O9jtRxbF99VQ16VYR//+Zu++fsWAYq9B/njJdwmSEUgZYhr0CfXulFbawzcZtT2k
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(83380400001)(508600001)(16526019)(426003)(966005)(186003)(40460700001)(36756003)(356005)(86362001)(30864003)(316002)(4326008)(36860700001)(26005)(15650500001)(2616005)(6916009)(70586007)(47076005)(70206006)(8936002)(82310400004)(2906002)(1076003)(81166007)(7696005)(336012)(44832011)(5660300002)(6666004)(54906003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 16:29:22.7297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec18de1-6683-4382-cfa0-08d9c0b137e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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
Link:
https://lkml.kernel.org/r/20211203020017.728440-3-yazen.ghannam@amd.com

v1->v2:
* Rework due to dropping patch 1 from v1.

 arch/x86/include/asm/mce.h    |   7 ++
 arch/x86/kernel/cpu/mce/amd.c |  28 +++++++
 drivers/edac/mce_amd.c        | 135 ++++++++++++++++++++++++++++++++--
 3 files changed, 163 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index d58f4f2e006f..52d2b35cac2d 100644
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
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2f351838d5f7..ffe8ea8bc877 100644
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
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -174,6 +181,9 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* Microprocessor 5 Unit MCA type */
 	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2)	},
 
+	/* MPDMA MCA type */
+	{ SMCA_MPDMA,	 HWID_MCATYPE(0x01, 0x3)	},
+
 	/* Northbridge IO Unit MCA type */
 	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
@@ -184,11 +194,29 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
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
+
+	/* GMI PHY MCA type */
+	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 67dbf4c31271..cfd3f7ae9251 100644
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
@@ -448,7 +505,7 @@ static const char * const smca_xgmipcs_mce_desc[] = {
 	"Rx Replay Timeout Error",
 	"LinkSub Tx Timeout Error",
 	"LinkSub Rx Timeout Error",
-	"Rx CMD Pocket Error",
+	"Rx CMD Packet Error",
 };
 
 static const char * const smca_xgmiphy_mce_desc[] = {
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
+	"Rx CMD Packet Error",
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


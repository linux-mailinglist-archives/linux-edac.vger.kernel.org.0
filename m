Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC02E466F73
	for <lists+linux-edac@lfdr.de>; Fri,  3 Dec 2021 03:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245422AbhLCCEC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 2 Dec 2021 21:04:02 -0500
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:4289
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233682AbhLCCEB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 2 Dec 2021 21:04:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVYYlD4dOEqqnUY3gpLpaU6Ihfq8klz+aKLrlEHAtkYnmDe7U76lgDo3+Ur0p+p5wONWKZStttfW3w5dT4wamjAj2zzmne8ytw/1K17sPFnpxoCcF58Y4yaG59m0U2D8mcClEKilJJIh4NRitVIqXLsMKsmvro3LtPnecs2V55DCPUN8/HU/5fxwtMLKc0VC5ER7aa+NZW68I4RDBWZmHEEyVmhzzGa5Va31vdHReYsQ2bzpgbuC8yjc3R6foSowZfmkTJLPkaOM3STbX86Y4Pes8jrAPG9nwy0JNF5BOn5zPyD+SAfvSO+QvD1NsPBdllnNwKRJFe2fmUhPpwxriQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1B7ghVupRKUurgNdLDHakvFePcMYWg7HZivH+SFYXE=;
 b=lLPU4vUIx1gLtnHyzxWXGwkTRh/Vs5LEiyqYYI6b63e1hMTJkAkzJv27K/Yk5HvVz2zcKBJKaa/yku6UlUuxy7Inzp8OKiyvhLTjq2IcHL1NACeFaZt6op4081dMyl+g+zPiwvw0uE2u3BOgyiTmxSaZhjP0J6RlAInA/eZHCu0MZjEFWj/dhCYYXmTUEZCsPjporBdT2KJt+SFb3s64Pq/EelnMcfKaWGz/LMDDVAUARlYMYn/QRcRCcV5Jtnzhe7UXBWgx6+7N/fIFSqHu9PcJWrSvtARkKSF8nrBrz/pcFX7wdW5EbJ9+xafMSv74H7iU5E10eUd0wQEYk4n7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1B7ghVupRKUurgNdLDHakvFePcMYWg7HZivH+SFYXE=;
 b=djoMTU/SdkzurjkAWNQSG5gqRn3Npz7dKAxctJTGiTk1o0VPXP5+EC0YIjQtPWPxa1UJ8JufZkCDwLFq1jBb5wGzqfcukBss2+YSQcuuUXC1t7KJRW4E54BfAUcmnA3QraSp02gBaoraVqhtGUUd4q4Dy54+bSHCeTAB9pFLarw=
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by DM5PR1201MB2472.namprd12.prod.outlook.com (2603:10b6:3:e1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.24; Fri, 3 Dec
 2021 02:00:36 +0000
Received: from CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::56) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 02:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT021.mail.protection.outlook.com (10.13.175.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 02:00:35 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 2 Dec
 2021 20:00:34 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <mukul.joshi@amd.com>, <alexander.deucher@amd.com>,
        <william.roche@oracle.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/3] x86/MCE/AMD: Provide an "Unknown" MCA bank type
Date:   Fri, 3 Dec 2021 02:00:15 +0000
Message-ID: <20211203020017.728440-2-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bd99a38-6fea-4197-ee4c-08d9b600b284
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2472:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2472503C77FB099625C13276F86A9@DM5PR1201MB2472.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:313;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVRb7Tg1r3BkiyL6OjQRgacu6WojRHLIrIwvl2gi0Lyt5yYkUnZzIsToRdcaN417WM5ls9xsxxzg1Ow59SZnvBRVWdpHNuZWgrRFjLr46MpIvbsCDDDtJcOw2TVQOzNSTg9461I2q8bW2a5fZVi3i0iLrrUgyJZdAF9iNLpR+Y5eYszsKS9Qh+EVFnmzepMJ0NAO21Jd+hWcCpcQP16FF32vAIF9iwAWM4nuljfIwnJG/OdfZDlBTC/1K9YV9Oh61iWFU9dYcSMaEOIFQTr3UX/5rb/Ll2tDhHwU6DNHgrwg5SBIqdpydECm5fwjM6x21f7YgNL7VSVrFbbQdRahWXHvpkAfHX7XgN00hUONFMBIO9+eEzSInxF8k6DX2P9kIeo94tIzdbyGLRXamF5BKjH+jj2opTxaipT9NmkyNDZ75mDAbb+xWAnYstIhjtj73a0HBQ0e51EYPTth4cnq30s4YwBC4YPenVJQifrUCEH2dUAVl9SOa5cPQraiEvoneIj+9OecZHRRmdXyfuaOfHP9Hakzliu5kMs4hN/Fc2/OkrUJXXFUtknHuVVIpbTryz9h3YGfldcam1gtT6TTZJwdr5hfpuhmg8XssGjuxsRwofoBeFCwV48+6mFyFf4bGkuoPJh4F/8MZxOg60+l3kQEXzHmSRQD2C7dGbfmxO64U3fpzeShaOYUhHcSghufwqyM1uKnReWPDA5L3ymHbw/B36JO+Tg7gpGnYXz2KItcCXqXUQWeMjvD0V5EGWFeUbY3PNbo6t/DmFJicHHvDspc6lX5GMV9PBEGDx9y10M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(508600001)(2616005)(5660300002)(47076005)(4326008)(8676002)(44832011)(15650500001)(1076003)(36860700001)(336012)(2906002)(8936002)(16526019)(40460700001)(26005)(83380400001)(426003)(6666004)(36756003)(7696005)(54906003)(86362001)(70206006)(356005)(70586007)(82310400004)(316002)(6916009)(81166007)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 02:00:35.9385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd99a38-6fea-4197-ee4c-08d9b600b284
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2472
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The AMD MCA Thresholding sysfs interface populates directories for each
bank and thresholding block. The name used for each directory is looked
up in a table of known bank types. However, new bank types won't match
in this list and will return NULL for the name. This will cause the
machinecheck sysfs interface to fail to be populated.

Set new and unknown MCA bank types to the "unknown" type. Also,
ensure that the bank's thresholding block directories have unique names.
This will ensure that the machinecheck sysfs interface can be
initialized.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  1 +
 arch/x86/kernel/cpu/mce/amd.c | 34 ++++++++++++++++++++++++++++------
 drivers/edac/mce_amd.c        |  3 +++
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index d58f4f2e006f..7c1c35909946 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -319,6 +319,7 @@ enum smca_bank_types {
 	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
 	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
+	SMCA_UNKNOWN,	/* Unknown type */
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 2f351838d5f7..b9a5a94914a9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -100,6 +100,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_XGMI_PCS]			= { "xgmi_pcs",		"Ext Global Memory Interconnect PCS Unit" },
 	[SMCA_XGMI_PHY]			= { "xgmi_phy",		"Ext Global Memory Interconnect PHY Unit" },
 	[SMCA_WAFL_PHY]			= { "wafl_phy",		"WAFL PHY Unit" },
+	[SMCA_UNKNOWN]			= { "unknown",		"Unrecognized Bank Type" },
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -189,6 +190,9 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* WAFL PHY MCA type */
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
+
+	/* Unknown type - this must be last in the list */
+	{ SMCA_UNKNOWN,  HWID_MCATYPE(0xFFF, 0xFFFF)	},
 };
 
 struct smca_bank smca_banks[MAX_NR_BANKS];
@@ -300,7 +304,9 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 	for (i = 0; i < ARRAY_SIZE(smca_hwid_mcatypes); i++) {
 		s_hwid = &smca_hwid_mcatypes[i];
-		if (hwid_mcatype == s_hwid->hwid_mcatype) {
+
+		if (hwid_mcatype == s_hwid->hwid_mcatype ||
+		    s_hwid->bank_type == SMCA_UNKNOWN) {
 			smca_banks[bank].hwid = s_hwid;
 			smca_banks[bank].id = low;
 			smca_banks[bank].sysfs_id = s_hwid->count++;
@@ -1032,12 +1038,28 @@ static const char *get_name(unsigned int bank, struct threshold_block *b)
 		return NULL;
 	}
 
-	if (smca_banks[bank].hwid->count == 1)
-		return smca_get_name(bank_type);
+	if (smca_banks[bank].hwid->count == 1) {
+		if (bank_type == SMCA_UNKNOWN) {
+			snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
+				 "%s_%x", smca_get_name(bank_type),
+					  smca_banks[bank].id);
+
+			return buf_mcatype;
+		} else {
+			return smca_get_name(bank_type);
+		}
+	}
+
+	if (b && bank_type == SMCA_UNKNOWN) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
+			 "%s_%x_block_%u", smca_get_name(bank_type),
+			 smca_banks[bank].id, b->block);
+	} else {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
+			 "%s_%u", smca_get_name(bank_type),
+				  smca_banks[bank].sysfs_id);
+	}
 
-	snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN,
-		 "%s_%x", smca_get_name(bank_type),
-			  smca_banks[bank].sysfs_id);
 	return buf_mcatype;
 }
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 67dbf4c31271..5ccc09db0a51 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1068,6 +1068,9 @@ static void decode_smca_error(struct mce *m)
 
 	pr_emerg(HW_ERR "%s Ext. Error Code: %d", ip_name, xec);
 
+	if (bank_type == SMCA_UNKNOWN)
+		return;
+
 	/* Only print the decode of valid error codes */
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
-- 
2.25.1


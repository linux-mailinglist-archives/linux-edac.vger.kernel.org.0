Return-Path: <linux-edac+bounces-5785-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DsgOoBTrGkOowEAu9opvQ
	(envelope-from <linux-edac+bounces-5785-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:34:08 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C522CB2D
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 150ED303AF17
	for <lists+linux-edac@lfdr.de>; Sat,  7 Mar 2026 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941BB3A4F55;
	Sat,  7 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lv6/1k+c"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBC53A63F7;
	Sat,  7 Mar 2026 16:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901222; cv=fail; b=HMlYMsPR94Iz+rCVcirWB5M2Kuy4mrieL4vcNomhpLyyWeGXelzh7ro0F7q/HhVju/nD6FlqMCYMlAu8PVzilfjLsBW0G3wX8fgjkwTgFnrBEgUg9kKkSNIcC2LMFNDMct2PzuoMGQ1mB/bfMTCAFZWgGX98mk2no4NbXCyL6R0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901222; c=relaxed/simple;
	bh=bMIGE/Ay9bLzGv5toEn+WJwK2kdWlt+3NjV6BQn+A+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sLimOKlRrT6cAZl2E+BTttXI65zQiSSS4iCsjeW97beQypj9vrWXQfs9oH2g4wuM8Dv0EXC248/lsMI/An7w9Am9yv7CkSU3f8bta+gtZfxlw80meKp27k1QF+OUDt6WAu9svgbWSEutVuytN8r58Dao4kMkMHLFBYzequQDy08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lv6/1k+c; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7wtYD80Loth2g/9hz4uSxgoO5pvJNx9B8hTdIYiQGPHXmLQTeJTWJ+XkqxChVbrdzYJCf3ocYZ75zAp5oMPMO/TshfFY2xm1Ioktad18kx8zQYuab5fUIBir/OPUW+rGfMVL4i8iWcFl4iG2gQ31bQJpaCdPBXzc0oivQ080TVQKeKi0baCQARo5C4aXBIz+8mN3gwHi086cFdIFjeCMrAkWaAAKgnhDuqu4PwtGcJDmelRmW7gcpQCeqrYn8VwYX2LEFhAeNhUnF3LDDaKxvpC8f9hUoknrBIgAZLgEIvspGD0c/gKEe0qDi7rOjELUmsECcroSCxctJIsJdlfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBETdPqzr8LVGkFMv6pnt8FBkQqI3Catom6dsHE22qI=;
 b=CxVeFsTwLs9Zco0u5vYAn3E76c3H0c6TN8zc/CqN942DlOfavcBSFIMGkW9JwSlUqNcJu7ZSu3RYLxSkIex7bBuUecBqvMcPQXkdKD6Zjxan9CTHQAdigokMOa7d5lhOutG9Fzy8RurIcHK2LxI21zln1V8+YlcQp3mhXlgje84xEzmmMyTSYqKlXd+Cc75BAKeE6AlDbA6pp0UowkTRsQOgbZc3BzLP0clz9NPxqQUo59bbsE2Cx3vRKx8IG9V3mZqb7GVwcEuGRURuD6C8df+DlZC/VrRarK14XKSF8e+9PPa7UmIfd4oZ9Rw7mmND4fW6sjkfSo0ouI+Hv13iaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBETdPqzr8LVGkFMv6pnt8FBkQqI3Catom6dsHE22qI=;
 b=Lv6/1k+ceIA3eShoOEXcphYoU/9XN3XoC20BcD4P9OQfKNMcjUzU8IayWVilCT51CvOlS27R4pSDiP0H7lft+jTKrfH8D8eF/WM3Sxtq3Ruz5r/H0HzkwixvA65Y5p4HiwNMIaECm09IC1RZ8r8I3kQMbEFmAQuuVl7ykL0tjF4=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by BL1PR12MB5922.namprd12.prod.outlook.com (2603:10b6:208:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Sat, 7 Mar
 2026 16:33:36 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::58) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Sat,
 7 Mar 2026 16:33:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 16:33:35 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Mar
 2026 10:33:33 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 1/3] x86/mce, EDAC/mce_amd: Reorder SMCA bank type enums
Date: Sat, 7 Mar 2026 11:33:14 -0500
Message-ID: <20260307163316.345923-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307163316.345923-1-yazen.ghannam@amd.com>
References: <20260307163316.345923-1-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|BL1PR12MB5922:EE_
X-MS-Office365-Filtering-Correlation-Id: 232739cd-2f16-447f-3504-08de7c6747c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	n8t+e8uWgDlngw6pcdkiYuQMOnd9B8ISoDuK76YzjXVKSd6TqqrnqpbuuQJ02YGaWsXMRONZMjwh9Rpc4P+VxnXKCaWaNeCLVW0dzRviaCc39mLHhcogOLRb51m4jKvOfJ0Pxd7fBL7F4Oo3YgKxDs7P9NreCD9c3XNiIT5oSwCE1h1pkGn9Pl7zjUYN4mGSvfYUi10Edk9we3ZOt5YSGkjU7xIitx1TAtIipJHc7xt+KNKC0/yo3Bio3OBd1YxMtXHPaJx4voAE4m0Kex/EDUzz4nEDEEdAkS/P60mGE0I4V82loN4edqR0Z9kzsd0MLGfDsQbNNuRWd4iybwJhp8HfjzK871xPS0mhag7nPiXj760LJTCNF58frPDx3qoNaKMFCZ1fwZDzvVbN4KeME+jyQQb2z8R8Fq6wGSYGZpmoPA/CfsKuUf95+imMHGnikeVtM1mRDLlVmTWiMYOKiNpKyiCoK5hAqIIlMs6Id6lSFHIXU52hor+vQnc2drp0UIlsS8GX5B+KkZE2Aww421M7VQtJ1bTyddofwdTGF+XAKi1OgItUWDEfosDjYgri/DnJVvPCIG1eI+tt9JSqHiawxGWtfNFeRyMUgq0okplCoFH1qYA7TQX7OIqqO4QNrbZAz1X2bjlFVzAc2PU5CZxhh3jQ9pZVDung1v3nkKSeH+EGjL5cgRIXS9/OOm7VZVc7gfihD7p8oEj0eRAikdb5yMBwBm/CRj9GL4BMhfC0soCFDwEeoBJn5JgyhVKSfPJWItPAeoBpIfIyFmHXgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sHwzrBLBn9rpCP5F99diY4YK3vC8L425obU9PTlH/f+1g00K/hCPds1Bml38lPgV4FyTSZCaC9PwJlX5w13e38467ib8wtQ8docEO2S4uLaPoDB745MBlD3Q4oe2E3G/iY3OFtBQh4CeZULBfqVf+VYRkJV2jBN6OZOkqap4aOhRMNbZych7lI210JQISxIo+H9tiQg+obwYP9bhdXyrS32C9D+xT8kzrjx3JnKigRM+JWEOATWxl0XxtDmw0whErcHP9TAU6Zj3s0+VatPYjWxV+qtwqUyM/OXXPu/6QVSXrAyKJkJxZBJw7j4R7BlFxnytmc3eu8qaDNoAAtHxAR6TyT/3teTXPjYh7hBuf/NUE/IfNABHNWZ6AFkMc+0fVEfCLhxt8cnirPlI0/oVGaduTFshzRDMavMzNo1ONImzTQRz0PVOKIucLDik+qx7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 16:33:35.9374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 232739cd-2f16-447f-3504-08de7c6747c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5922
X-Rspamd-Queue-Id: 8B5C522CB2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5785-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Originally, the SMCA bank type enums were ordered based on processor
documentation. However, the ordering became inconsistent after new bank
types were added over time.

Sort the bank type enums alphanumerically in most places.  Sort the
"enum to HWID/McaType" mapping by HWID/McaType. Drop redundant code
comments.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    |  48 ++++++++-------
 arch/x86/kernel/cpu/mce/amd.c | 110 +++++++++++++++++-----------------
 drivers/edac/mce_amd.c        |  38 ++++++------
 3 files changed, 99 insertions(+), 97 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 2d98886de09a..83899711da4e 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -345,42 +345,46 @@ extern void apei_mce_report_mem_error(int corrected,
 
 /* These may be used by multiple smca_hwid_mcatypes */
 enum smca_bank_types {
-	SMCA_LS = 0,	/* Load Store */
-	SMCA_LS_V2,
-	SMCA_IF,	/* Instruction Fetch */
-	SMCA_L2_CACHE,	/* L2 Cache */
+	/*
+	 * Keep in alphanumeric order, numerals before letters.
+	 * Exception: Keep "V2, etc." with their originals.
+	 */
+	SMCA_CS,	/* Coherent Slave */
+	SMCA_CS_V2,
 	SMCA_DE,	/* Decoder Unit */
-	SMCA_RESERVED,	/* Reserved */
 	SMCA_EX,	/* Execution Unit */
 	SMCA_FP,	/* Floating Point */
+	SMCA_GMI_PCS,	/* GMI PCS Unit */
+	SMCA_GMI_PHY,	/* GMI PHY Unit */
+	SMCA_IF,	/* Instruction Fetch */
+	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_L3_CACHE,	/* L3 Cache */
-	SMCA_CS,	/* Coherent Slave */
-	SMCA_CS_V2,
-	SMCA_PIE,	/* Power, Interrupts, etc. */
-	SMCA_UMC,	/* Unified Memory Controller */
-	SMCA_UMC_V2,
+	SMCA_LS,	/* Load Store */
+	SMCA_LS_V2,
 	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
-	SMCA_PB,	/* Parameter Block */
-	SMCA_PSP,	/* Platform Security Processor */
-	SMCA_PSP_V2,
-	SMCA_SMU,	/* System Management Unit */
-	SMCA_SMU_V2,
 	SMCA_MP5,	/* Microprocessor 5 Unit */
 	SMCA_MPDMA,	/* MPDMA Unit */
+	SMCA_NBIF,	/* NBIF Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
+	SMCA_PB,	/* Parameter Block */
 	SMCA_PCIE,	/* PCI Express Unit */
 	SMCA_PCIE_V2,
-	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
-	SMCA_NBIF,	/* NBIF Unit */
-	SMCA_SHUB,	/* System HUB Unit */
+	SMCA_PIE,	/* Power, Interrupts, etc. */
+	SMCA_PSP,	/* Platform Security Processor */
+	SMCA_PSP_V2,
+	SMCA_RESERVED,	/* Reserved */
 	SMCA_SATA,	/* SATA Unit */
+	SMCA_SHUB,	/* System HUB Unit */
+	SMCA_SMU,	/* System Management Unit */
+	SMCA_SMU_V2,
+	SMCA_UMC,	/* Unified Memory Controller */
+	SMCA_UMC_V2,
 	SMCA_USB,	/* USB Unit */
-	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
 	SMCA_USR_CP,	/* Ultra Short Reach Control Plane Controller */
-	SMCA_GMI_PCS,	/* GMI PCS Unit */
-	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
+	SMCA_USR_DP,	/* Ultra Short Reach Data Plane Controller */
 	SMCA_WAFL_PHY,	/* WAFL PHY Unit */
-	SMCA_GMI_PHY,	/* GMI PHY Unit */
+	SMCA_XGMI_PCS,	/* xGMI PCS Unit */
+	SMCA_XGMI_PHY,	/* xGMI PHY Unit */
 	N_SMCA_BANK_TYPES
 };
 
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index da13c1e37f87..44e490119b89 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -95,39 +95,39 @@ static DEFINE_PER_CPU_READ_MOSTLY(struct smca_bank[MAX_NR_BANKS], smca_banks);
 static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
 
 static const char * const smca_names[] = {
-	[SMCA_LS ... SMCA_LS_V2]	= "load_store",
-	[SMCA_IF]			= "insn_fetch",
-	[SMCA_L2_CACHE]			= "l2_cache",
+	[SMCA_CS ... SMCA_CS_V2]	= "coherent_slave",
 	[SMCA_DE]			= "decode_unit",
-	[SMCA_RESERVED]			= "reserved",
 	[SMCA_EX]			= "execution_unit",
 	[SMCA_FP]			= "floating_point",
+	[SMCA_GMI_PCS]			= "gmi_pcs",
+	[SMCA_GMI_PHY]			= "gmi_phy",
+	[SMCA_IF]			= "insn_fetch",
+	[SMCA_L2_CACHE]			= "l2_cache",
 	[SMCA_L3_CACHE]			= "l3_cache",
-	[SMCA_CS ... SMCA_CS_V2]	= "coherent_slave",
-	[SMCA_PIE]			= "pie",
-
-	/* UMC v2 is separate because both of them can exist in a single system. */
-	[SMCA_UMC]			= "umc",
-	[SMCA_UMC_V2]			= "umc_v2",
+	[SMCA_LS ... SMCA_LS_V2]	= "load_store",
 	[SMCA_MA_LLC]			= "ma_llc",
-	[SMCA_PB]			= "param_block",
-	[SMCA_PSP ... SMCA_PSP_V2]	= "psp",
-	[SMCA_SMU ... SMCA_SMU_V2]	= "smu",
 	[SMCA_MP5]			= "mp5",
 	[SMCA_MPDMA]			= "mpdma",
+	[SMCA_NBIF]			= "nbif",
 	[SMCA_NBIO]			= "nbio",
+	[SMCA_PB]			= "param_block",
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= "pcie",
-	[SMCA_XGMI_PCS]			= "xgmi_pcs",
-	[SMCA_NBIF]			= "nbif",
-	[SMCA_SHUB]			= "shub",
+	[SMCA_PIE]			= "pie",
+	[SMCA_PSP ... SMCA_PSP_V2]	= "psp",
+	[SMCA_RESERVED]			= "reserved",
 	[SMCA_SATA]			= "sata",
+	[SMCA_SHUB]			= "shub",
+	[SMCA_SMU ... SMCA_SMU_V2]	= "smu",
+
+	/* UMC v2 is separate because both of them can exist in a single system. */
+	[SMCA_UMC]			= "umc",
+	[SMCA_UMC_V2]			= "umc_v2",
 	[SMCA_USB]			= "usb",
-	[SMCA_USR_DP]			= "usr_dp",
 	[SMCA_USR_CP]			= "usr_cp",
-	[SMCA_GMI_PCS]			= "gmi_pcs",
-	[SMCA_XGMI_PHY]			= "xgmi_phy",
+	[SMCA_USR_DP]			= "usr_dp",
 	[SMCA_WAFL_PHY]			= "wafl_phy",
-	[SMCA_GMI_PHY]			= "gmi_phy",
+	[SMCA_XGMI_PCS]			= "xgmi_pcs",
+	[SMCA_XGMI_PHY]			= "xgmi_phy",
 };
 
 static const char *smca_get_name(enum smca_bank_types t)
@@ -153,67 +153,65 @@ enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank)
 }
 EXPORT_SYMBOL_GPL(smca_get_bank_type);
 
+/* Order by HWID then McaType with newline between HWID groups. */
 static const struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype } */
 
-	/* Reserved type */
 	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0)	},
 
-	/* ZN Core (HWID=0xB0) MCA types */
-	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0)	},
-	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10)	},
-	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1)	},
-	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2)	},
-	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3)	},
-	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
-	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5)	},
-	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6)	},
-	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7)	},
-
-	/* Data Fabric MCA types */
-	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
-	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
-	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
-	{ SMCA_MA_LLC,	 HWID_MCATYPE(0x2E, 0x4)	},
-
-	/* Unified Memory Controller MCA type */
-	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
-	{ SMCA_UMC_V2,	 HWID_MCATYPE(0x96, 0x1)	},
-
-	/* Parameter Block MCA type */
-	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
-
-	/* Platform Security Processor MCA type */
-	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0)	},
-	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1)	},
-
-	/* System Management Unit MCA type */
 	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0)	},
 	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1)	},
-
-	/* Microprocessor 5 Unit MCA type */
 	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2)	},
-
-	/* MPDMA MCA type */
 	{ SMCA_MPDMA,	 HWID_MCATYPE(0x01, 0x3)	},
 
-	/* Northbridge IO Unit MCA type */
+	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
+
 	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
-	/* PCI Express Unit MCA type */
+	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
+	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1)	},
+	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2)	},
+	{ SMCA_MA_LLC,	 HWID_MCATYPE(0x2E, 0x4)	},
+
 	{ SMCA_PCIE,	 HWID_MCATYPE(0x46, 0x0)	},
 	{ SMCA_PCIE_V2,	 HWID_MCATYPE(0x46, 0x1)	},
 
 	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
+
 	{ SMCA_NBIF,	 HWID_MCATYPE(0x6C, 0x0)	},
+
 	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
+
+	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0)	},
+	{ SMCA_UMC_V2,	 HWID_MCATYPE(0x96, 0x1)	},
+
 	{ SMCA_SATA,	 HWID_MCATYPE(0xA8, 0x0)	},
+
 	{ SMCA_USB,	 HWID_MCATYPE(0xAA, 0x0)	},
+
+	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0)	},
+	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1)	},
+	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2)	},
+	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3)	},
+	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
+	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5)	},
+	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6)	},
+	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7)	},
+	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10)	},
+
+	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0)	},
+	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1)	},
+
 	{ SMCA_USR_DP,	 HWID_MCATYPE(0x170, 0x0)	},
+
 	{ SMCA_USR_CP,	 HWID_MCATYPE(0x180, 0x0)	},
+
 	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
+
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
+
 	{ SMCA_WAFL_PHY, HWID_MCATYPE(0x267, 0x0)	},
+
 	{ SMCA_GMI_PHY,	 HWID_MCATYPE(0x269, 0x0)	},
 };
 
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index af3c12284a1e..7fba230cb9e1 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -689,36 +689,36 @@ static void decode_mc6_mce(struct mce *m)
 }
 
 static const char * const smca_long_names[] = {
-	[SMCA_LS ... SMCA_LS_V2]	= "Load Store Unit",
-	[SMCA_IF]			= "Instruction Fetch Unit",
-	[SMCA_L2_CACHE]			= "L2 Cache",
+	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Slave",
 	[SMCA_DE]			= "Decode Unit",
-	[SMCA_RESERVED]			= "Reserved",
 	[SMCA_EX]			= "Execution Unit",
 	[SMCA_FP]			= "Floating Point Unit",
+	[SMCA_GMI_PCS]			= "Global Memory Interconnect PCS Unit",
+	[SMCA_GMI_PHY]			= "Global Memory Interconnect PHY Unit",
+	[SMCA_IF]			= "Instruction Fetch Unit",
+	[SMCA_L2_CACHE]			= "L2 Cache",
 	[SMCA_L3_CACHE]			= "L3 Cache",
-	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Slave",
-	[SMCA_PIE]			= "Power, Interrupts, etc.",
-
-	/* UMC v2 is separate because both of them can exist in a single system. */
-	[SMCA_UMC]			= "Unified Memory Controller",
-	[SMCA_UMC_V2]			= "Unified Memory Controller v2",
-	[SMCA_PB]			= "Parameter Block",
-	[SMCA_PSP ... SMCA_PSP_V2]	= "Platform Security Processor",
-	[SMCA_SMU ... SMCA_SMU_V2]	= "System Management Unit",
+	[SMCA_LS ... SMCA_LS_V2]	= "Load Store Unit",
 	[SMCA_MP5]			= "Microprocessor 5 Unit",
 	[SMCA_MPDMA]			= "MPDMA Unit",
+	[SMCA_NBIF]			= "NBIF Unit",
 	[SMCA_NBIO]			= "Northbridge IO Unit",
+	[SMCA_PB]			= "Parameter Block",
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= "PCI Express Unit",
-	[SMCA_XGMI_PCS]			= "Ext Global Memory Interconnect PCS Unit",
-	[SMCA_NBIF]			= "NBIF Unit",
-	[SMCA_SHUB]			= "System Hub Unit",
+	[SMCA_PIE]			= "Power, Interrupts, etc.",
+	[SMCA_PSP ... SMCA_PSP_V2]	= "Platform Security Processor",
+	[SMCA_RESERVED]			= "Reserved",
 	[SMCA_SATA]			= "SATA Unit",
+	[SMCA_SHUB]			= "System Hub Unit",
+	[SMCA_SMU ... SMCA_SMU_V2]	= "System Management Unit",
+
+	/* UMC v2 is separate because both of them can exist in a single system. */
+	[SMCA_UMC]			= "Unified Memory Controller",
+	[SMCA_UMC_V2]			= "Unified Memory Controller v2",
 	[SMCA_USB]			= "USB Unit",
-	[SMCA_GMI_PCS]			= "Global Memory Interconnect PCS Unit",
-	[SMCA_XGMI_PHY]			= "Ext Global Memory Interconnect PHY Unit",
 	[SMCA_WAFL_PHY]			= "WAFL PHY Unit",
-	[SMCA_GMI_PHY]			= "Global Memory Interconnect PHY Unit",
+	[SMCA_XGMI_PCS]			= "Ext Global Memory Interconnect PCS Unit",
+	[SMCA_XGMI_PHY]			= "Ext Global Memory Interconnect PHY Unit",
 };
 
 static const char *smca_get_long_name(enum smca_bank_types t)
-- 
2.53.0



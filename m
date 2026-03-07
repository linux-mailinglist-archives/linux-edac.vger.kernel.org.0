Return-Path: <linux-edac+bounces-5786-lists+linux-edac=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-edac@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKGrBXVTrGkOowEAu9opvQ
	(envelope-from <linux-edac+bounces-5786-lists+linux-edac=lfdr.de@vger.kernel.org>)
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:33:57 +0100
X-Original-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8D822CB15
	for <lists+linux-edac@lfdr.de>; Sat, 07 Mar 2026 17:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD6AF302B526
	for <lists+linux-edac@lfdr.de>; Sat,  7 Mar 2026 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF293A6EE8;
	Sat,  7 Mar 2026 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PPWFtc/X"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011040.outbound.protection.outlook.com [40.107.208.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521523A640F;
	Sat,  7 Mar 2026 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772901224; cv=fail; b=ZVYvsGWPXKIqYbf3gDyP1R/3lmeiPU/DiveaW4HIMaJudgZNW2sxiNM8IT/OcYViPdIeZOJ//eOXW+pv2Bh6ruYzFM/ZBUy4aISjIg8QepR+6jH4W/hmJcpUm2CjlY+idyo9dahsfIucIVHMLnMeJS9GiUFWDmx7QKh84CROwMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772901224; c=relaxed/simple;
	bh=pyfTYbvRvvziyZrHWQ4/FbJxUbXjyVjRRUq5I4mxpXc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jxk0IIKbxqm/JvR/ejr/zo5kWeqk8VtIK6UrcvjIxnK/YK0oRP81Y7iE3rzWmilIQNgTZMbMJL6W/ZzX/YbkOzdv7KEC4Oyj7ovVnYyd2fiO3Ju2XY0a/d1WcO2eJqRCMqpVV8scU4SuupMDvyefY4uF7k08IJ1CE9K+4SBxKjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PPWFtc/X; arc=fail smtp.client-ip=40.107.208.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yj51B1bzjJZXs2+4MkMCubnnMQPRuXnzK0iDPdsi+h6JAcBeAoaCemc2t1S7RPzXm6fG8hm1f3wlIlsk2ZcGt/q01qeu/x9gLr8ZFge+r+4dxkJh4VrT1xSIZTzB8TY63yyTfh2pbojlS95sBvaDUWSwRh4WLxPxlyRZ6DLBl/aceC2IsInuUAAiILrQYkN5+u4ZC08QMhRAmPsBNEtQYhotolRFsHgRtUmlLJOsNZMjHiFfOrcjRSSwXPLlSw4YT2YgIT87QRB1Guvpu9wmrEzsQUxLfYvQ83IIFrCgAVW4dVRDY8JF7XBcGLl7ZnjMxnj2P/yhEJJVcvjDwo9HUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TK99qf/ors4i/bTVLhvOuft0NPYgNSyv8q7p1ZOjDCE=;
 b=cGxSwo9HtxpB2Lg2VSSA1qZAMPtvr6j4EX05ayQWCOryIJU8ueJAoIQwD4te3A1ru4MTuRMoVQj/aw+dN2LXZh6GXYRkrkFhnhKYLyHZDTbmu/X73ZdSJ+E/c3gGUZz9vtxRFyCd43UY01xavgbR29if5O1oz6OgJR3c8pdxWfK7VS3Pl60oi1kLmDF3+v6YHkwiV5TxE197d0AIVJaqd6kNkzqmfGyb7eQJpE2jcvP2ULS+pQdMLsxlnBxIsyRWZbYdqmDsmYCqzjgNmxRvtOewYCSzg7uEGGZXeIiFxuRpA1cRlwcAffNjH9Hok2SfPB/zb7FPUCoUAsCao1YLSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TK99qf/ors4i/bTVLhvOuft0NPYgNSyv8q7p1ZOjDCE=;
 b=PPWFtc/XK26X+UrxrMAiLsdWUgw2mv2DjM7rNB1XLAudQXvTOcuQvBRKJlfeJY1NXnkvxwj1sgeSIdJmXJKf9QjcHf+BK1meTwFMpwLOupC12ThVZ4tuE37N/ux8Yg5fDEV4db/uzT8xgiD+kaQD7GS9d5N+1nso/oAZx3+04e4=
Received: from SJ0PR03CA0154.namprd03.prod.outlook.com (2603:10b6:a03:338::9)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Sat, 7 Mar
 2026 16:33:38 +0000
Received: from SJ1PEPF00002327.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::59) by SJ0PR03CA0154.outlook.office365.com
 (2603:10b6:a03:338::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Sat,
 7 Mar 2026 16:33:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002327.mail.protection.outlook.com (10.167.242.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Sat, 7 Mar 2026 16:33:38 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 7 Mar
 2026 10:33:35 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 3/3] x86/mce, EDAC/mce_amd: Add new SMCA bank types
Date: Sat, 7 Mar 2026 11:33:16 -0500
Message-ID: <20260307163316.345923-4-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002327:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bf9fa2-6b93-4893-8fa4-08de7c674901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	uhiV9Xt5LiuhIsNJTFd3DrQtPlN53LgenLuCuKzPi2JZM4Io6LYldt3b1TpDB8xEbxPo9lZraRUSq2foYuGC+r+VZyvNYjP0Zx2FIoTGlUVErlsUM4wkxnA3rOFfZRJfvKB+iRCeuFnF4Nt5z3146hHvEej55KMJ7tXi11rlWxYEj/UV1mEz+bYUpbcSatGPIEbnGrcPiRzbXQtz7qsz/qmuT8FopRlSmB+T8bTtcep+JZxJ94fhmFMtbJFVbau6HVFqExnhHxyTGCmzgFIgEa+uBXOks8s7+rNzhRhvChJNOM7+haXVOCeI6PuphVNyIhJ2E8mj2AtfUP0Vjw8/KC2rUoUnHjkIyIOfQmAlvzcnTRkNDn3btX7oSti9ZEGEYmBnqreAXcjuyzaCbNiRq1TlegZgFyJLy5boVn3p1k9z6I7VZc+oCVptLQxpM3EQx3CgHMATld5eSTCkXVMcr5F1D/tq11V1thHTSvvvmwKRTO5M/97S3M1m3YKeyGdv3/y0s2G3d7MCOdLPAmKpoIXXFgmpBZpuNnaCc9EzkyT5H7i848/Nl6QETyCsc3x84xygZ2annQ3h9tXq08rdTWdnYLJ0Ctoq61v1Dmc32l6dpZFzuaA/O8iMROBuHWS39CroJOKqR1am9PieDl8wQqJm5MJz8Q2GG+ilUDD7UdmZPLbZmtRjSPu88YGcJa6KSYh6H4Sx1rnwGKrGJH/gNucg1ZMWYQJ/SXiaq8Hg6R+4P9TF+IOQIf0rRY3DQIQel9jbg+ZO/WAKuUYw92fL4Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r525z77TK1tWmiJ+JhQfj6TDEwbX9z1qiuJrLXAQTMXUNYY1X798Fo1Bg2SBUpNVdFuz/BxLTrR3rNrhvNUB2vBW2iU9aCGqQSP++yOxoj3I8h1d4ScKRaRdWeDifVByrmCBVwJuf8dwLb4Ds5u8tvwt3R8/ho/lIXIj66PkcOpdylh8KyhCszCXRYMczTpwezX0GznITj7G+55DJrMMnVHT4kAJIqqpASTdILfLT5jTlPZzYbm26VP0/Imxbjyu4AadGr6CJ4/ZRAD/3FX7UQekenQmh2VYtTc7eiTMLYGTMi9GYda1/21n0ibho6hdANYo7ylSs9uqDGOKwbXp2fvW+n8JkH4+B0bBl+9Nv8iDibbUm3Ri63CDk4sT5EuJniMnSEaThCFnreIT0m9UQwama33uhwZF6Xf4Kx4eeYtkbFRr03SldBQFjDRroQ07
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2026 16:33:38.0157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bf9fa2-6b93-4893-8fa4-08de7c674901
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002327.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270
X-Rspamd-Queue-Id: 7F8D822CB15
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5786-lists,linux-edac=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yazen.ghannam@amd.com,linux-edac@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-edac];
	NEURAL_HAM(-0.00)[-0.992];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Recognize new SMCA bank types and include their short names for sysfs
and long names for decoding.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h    | 11 +++++++++++
 arch/x86/kernel/cpu/mce/amd.c | 30 ++++++++++++++++++++++++++++++
 drivers/edac/mce_amd.c        | 10 ++++++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 576a4b6e83ea..e4d0fc0978ac 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -351,7 +351,10 @@ enum smca_bank_types {
 	 */
 	SMCA_CS,	/* Coherent Station */
 	SMCA_CS_V2,
+	SMCA_DACC_BE,	/* Data Acceleration Back-end */
+	SMCA_DACC_FE,	/* Data Acceleration Front-end */
 	SMCA_DE,	/* Decoder Unit */
+	SMCA_EDDR5CMN,	/* eDDR5 CMN */
 	SMCA_EX,	/* Execution Unit */
 	SMCA_FP,	/* Floating Point */
 	SMCA_GMI_PCS,	/* GMI PCS Unit */
@@ -363,12 +366,19 @@ enum smca_bank_types {
 	SMCA_LS_V2,
 	SMCA_MA_LLC,	/* Memory Attached Last Level Cache */
 	SMCA_MP5,	/* Microprocessor 5 Unit */
+	SMCA_MPART,	/* AMD Root of Trust Microprocessor */
+	SMCA_MPASP,	/* AMD Secure Processor */
+	SMCA_MPASP_V2,
+	SMCA_MPDACC,	/* MP for Data Acceleration */
 	SMCA_MPDMA,	/* MPDMA Unit */
+	SMCA_MPM,	/* Microprocessor Manageability Core */
+	SMCA_MPRAS,	/* MP for RAS */
 	SMCA_NBIF,	/* NBIF Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PCIE,	/* PCI Express Unit */
 	SMCA_PCIE_V2,
+	SMCA_PCIE_PL,	/* PCIe Link */
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_PSP,	/* Platform Security Processor */
 	SMCA_PSP_V2,
@@ -377,6 +387,7 @@ enum smca_bank_types {
 	SMCA_SHUB,	/* System HUB Unit */
 	SMCA_SMU,	/* System Management Unit */
 	SMCA_SMU_V2,
+	SMCA_SSBDCI,	/* Die to Die Interconnect */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_UMC_V2,
 	SMCA_USB,	/* USB Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 86f51415283c..fc1513f8d180 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -96,7 +96,10 @@ static DEFINE_PER_CPU_READ_MOSTLY(u8[N_SMCA_BANK_TYPES], smca_bank_counts);
 
 static const char * const smca_names[] = {
 	[SMCA_CS ... SMCA_CS_V2]	= "coherent_station",
+	[SMCA_DACC_BE]			= "dacc_be",
+	[SMCA_DACC_FE]			= "dacc_fe",
 	[SMCA_DE]			= "decode_unit",
+	[SMCA_EDDR5CMN]			= "eddr5_cmn",
 	[SMCA_EX]			= "execution_unit",
 	[SMCA_FP]			= "floating_point",
 	[SMCA_GMI_PCS]			= "gmi_pcs",
@@ -107,17 +110,24 @@ static const char * const smca_names[] = {
 	[SMCA_LS ... SMCA_LS_V2]	= "load_store",
 	[SMCA_MA_LLC]			= "ma_llc",
 	[SMCA_MP5]			= "mp5",
+	[SMCA_MPART]			= "mpart",
+	[SMCA_MPASP ... SMCA_MPASP_V2]	= "mpasp",
+	[SMCA_MPDACC]			= "mpdacc",
 	[SMCA_MPDMA]			= "mpdma",
+	[SMCA_MPM]			= "mpm",
+	[SMCA_MPRAS]			= "mpras",
 	[SMCA_NBIF]			= "nbif",
 	[SMCA_NBIO]			= "nbio",
 	[SMCA_PB]			= "param_block",
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= "pcie",
+	[SMCA_PCIE_PL]			= "pcie_pl",
 	[SMCA_PIE]			= "pie",
 	[SMCA_PSP ... SMCA_PSP_V2]	= "psp",
 	[SMCA_RESERVED]			= "reserved",
 	[SMCA_SATA]			= "sata",
 	[SMCA_SHUB]			= "shub",
 	[SMCA_SMU ... SMCA_SMU_V2]	= "smu",
+	[SMCA_SSBDCI]			= "ssbdci",
 
 	/* UMC v2 is separate because both of them can exist in a single system. */
 	[SMCA_UMC]			= "umc",
@@ -166,6 +176,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 
 	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0)	},
 
+	{ SMCA_MPRAS,	 HWID_MCATYPE(0x12, 0x0)	},
+
 	{ SMCA_NBIO,	 HWID_MCATYPE(0x18, 0x0)	},
 
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0)	},
@@ -178,6 +190,8 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 
 	{ SMCA_XGMI_PCS, HWID_MCATYPE(0x50, 0x0)	},
 
+	{ SMCA_SSBDCI,	 HWID_MCATYPE(0x5C, 0x0)	},
+
 	{ SMCA_NBIF,	 HWID_MCATYPE(0x6C, 0x0)	},
 
 	{ SMCA_SHUB,	 HWID_MCATYPE(0x80, 0x0)	},
@@ -199,13 +213,29 @@ static const struct smca_hwid smca_hwid_mcatypes[] = {
 	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7)	},
 	{ SMCA_LS_V2,	 HWID_MCATYPE(0xB0, 0x10)	},
 
+	{ SMCA_MPDACC,	 HWID_MCATYPE(0xBE, 0x0)	},
+
+	{ SMCA_MPM,	 HWID_MCATYPE(0xF9, 0x0)	},
+
+	{ SMCA_MPASP,	 HWID_MCATYPE(0xFD, 0x0)	},
+	{ SMCA_MPASP_V2, HWID_MCATYPE(0xFD, 0x1)	},
+
 	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0)	},
 	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1)	},
+	{ SMCA_MPART,	 HWID_MCATYPE(0xFF, 0x2)	},
+
+	{ SMCA_DACC_FE,	 HWID_MCATYPE(0x157, 0x0)	},
+
+	{ SMCA_DACC_BE,	 HWID_MCATYPE(0x164, 0x0)	},
 
 	{ SMCA_USR_DP,	 HWID_MCATYPE(0x170, 0x0)	},
 
 	{ SMCA_USR_CP,	 HWID_MCATYPE(0x180, 0x0)	},
 
+	{ SMCA_EDDR5CMN, HWID_MCATYPE(0x1E0, 0x0)	},
+
+	{ SMCA_PCIE_PL,	 HWID_MCATYPE(0x1E1, 0x0)	},
+
 	{ SMCA_GMI_PCS,  HWID_MCATYPE(0x241, 0x0)	},
 
 	{ SMCA_XGMI_PHY, HWID_MCATYPE(0x259, 0x0)	},
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 54ad56f2a9e0..bd252cb3c38e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -690,7 +690,10 @@ static void decode_mc6_mce(struct mce *m)
 
 static const char * const smca_long_names[] = {
 	[SMCA_CS ... SMCA_CS_V2]	= "Coherent Station",
+	[SMCA_DACC_BE]			= "DACC Back-end Unit",
+	[SMCA_DACC_FE]			= "DACC Front-end Unit",
 	[SMCA_DE]			= "Decode Unit",
+	[SMCA_EDDR5CMN]			= "eDDR5 CMN Unit",
 	[SMCA_EX]			= "Execution Unit",
 	[SMCA_FP]			= "Floating Point Unit",
 	[SMCA_GMI_PCS]			= "Global Memory Interconnect PCS Unit",
@@ -700,17 +703,24 @@ static const char * const smca_long_names[] = {
 	[SMCA_L3_CACHE]			= "L3 Cache",
 	[SMCA_LS ... SMCA_LS_V2]	= "Load Store Unit",
 	[SMCA_MP5]			= "Microprocessor 5 Unit",
+	[SMCA_MPART]			= "MPART Unit",
+	[SMCA_MPASP ... SMCA_MPASP_V2]	= "MPASP Unit",
+	[SMCA_MPDACC]			= "MPDACC Unit",
 	[SMCA_MPDMA]			= "MPDMA Unit",
+	[SMCA_MPM]			= "MPM Unit",
+	[SMCA_MPRAS]			= "MPRAS Unit",
 	[SMCA_NBIF]			= "NBIF Unit",
 	[SMCA_NBIO]			= "Northbridge IO Unit",
 	[SMCA_PB]			= "Parameter Block",
 	[SMCA_PCIE ... SMCA_PCIE_V2]	= "PCI Express Unit",
+	[SMCA_PCIE_PL]			= "PCIe Link Unit",
 	[SMCA_PIE]			= "Power, Interrupts, etc.",
 	[SMCA_PSP ... SMCA_PSP_V2]	= "Platform Security Processor",
 	[SMCA_RESERVED]			= "Reserved",
 	[SMCA_SATA]			= "SATA Unit",
 	[SMCA_SHUB]			= "System Hub Unit",
 	[SMCA_SMU ... SMCA_SMU_V2]	= "System Management Unit",
+	[SMCA_SSBDCI]			= "Die to Die Interconnect Unit",
 
 	/* UMC v2 is separate because both of them can exist in a single system. */
 	[SMCA_UMC]			= "Unified Memory Controller",
-- 
2.53.0



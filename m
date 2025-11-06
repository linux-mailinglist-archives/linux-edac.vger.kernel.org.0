Return-Path: <linux-edac+bounces-5352-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC41C38C5F
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 02:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F901A25542
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 01:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038D24886E;
	Thu,  6 Nov 2025 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r8XBpVM8"
X-Original-To: linux-edac@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010051.outbound.protection.outlook.com [52.101.46.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD2324503C;
	Thu,  6 Nov 2025 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394276; cv=fail; b=SBk/Fcplsk5SDMj88DO0Yvr3PmDkAykma5k2+a4RuguU8PXJMFRKSa4FxGzLfHJechNKSzoFWn71oB+IRhV7RvyoiythYUh09+itUQLdBFU/gQZ0th3hZ4ERzSgztSO1oM7ZduHlmojVHYitxud6ZP6BBH3+EMAE+CxsHhCwnBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394276; c=relaxed/simple;
	bh=P/qmrtkXwYcFXV4HeeL1Y9Yrkt5V8oeK/Kp1L4VIY/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ab3XFXe/nncoT4IFSbc4o5JO52zROa8EtE+lhcyi4LxdgXIs8j8YneyU4sP+SDL9X8RJz4aMikeI6dZ6J5hVJ4odtHzG9MiYPXXhRsM3221UW6keCbpNusd/RWiuF8Oc5Sd2a9eehdr+FOxHFP9AVOph2N+K2yxLE2ehjmRB4gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r8XBpVM8; arc=fail smtp.client-ip=52.101.46.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OthZ0zyExA8iiISXP4U3huYOiYlHiITIQy0v0dDuMqZW5HSLOb984WEP0z5mZXtLAyCxLPDovp/eMrlgaJYP4QObOg96xt/rt1XVqNoWZGBSTcvYUa1L6MWRQ2bWot7VgOydXnNNTjXQltshQ1GeW6s88f52rV0Pcd8z+AwVjEsx8cfvSmHfmZe1V2FPtkayrNw/LqoUOkruvIabUUvmFmiv4mT7SnIEtAtqwIe5WCVCGQT9YrxfAj2UYGtrb06Tf41YguOreEghdyaQ9difb3fLC0snsb6eQWgQvDLyuO0PxqQepDhdSrZfr+WAWQl59c5NAczKrjTtGjRRPynfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcZx7XHjCpYDE8lzT0ZJmmyK37yShmPxFxPV2ZONuYI=;
 b=OZun/5X48FCvIAtcfkxxp4IfEaTQZY6TqgrhcgjzMD40oE+fu0ctUe5MtcvArYl9jPRK1cdN9GYbMed20ckStb/EJ6ItxOy6PXYQ9E1c1rgFNfIzdKHBnkzJV/CuBEwpMCA/guYHSotWiiDXXrQmbrpaWs4Bp0vqABtBstDV4m/8dbofwP/U4EPVkTnNjpZgrLdu2rXrF1cOVFe5L8ZESHFWx4N4chir8mXtk2+6NbN2tNSaU0f7KiFW547Gf4H8WLu3me89nmnpp9CpDkmXPRefqZnYYYQ36LXK0QEOmcOj3RHWIg4yn47rvVQSXUqEZ4DUZWM3iOYD5j5flq3tsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcZx7XHjCpYDE8lzT0ZJmmyK37yShmPxFxPV2ZONuYI=;
 b=r8XBpVM8OHBwyHuMVx/Oj2vfFyM57kpYdYWf6Xp+RmT1JFTqBA34WrUlcmgfeuXG0vMqMSIw3j+5aQvrNKfjDFDTTsOUiRgzKZzXfDRA1woNUBJroO2WUFOQoepEz+5EHLQar2VpHipFdOaGkddZJOS8cCNeI67weJl/tDMXQPM=
Received: from SJ0PR05CA0027.namprd05.prod.outlook.com (2603:10b6:a03:33b::32)
 by DS4PR12MB9612.namprd12.prod.outlook.com (2603:10b6:8:278::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 01:57:51 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::13) by SJ0PR05CA0027.outlook.office365.com
 (2603:10b6:a03:33b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 01:57:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 01:57:50 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 17:57:48 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
	<chenhuacai@kernel.org>, <mchehab+huawei@kernel.org>,
	<yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 1/3] EDAC/amd64: Generate ctl_name string at runtime
Date: Thu, 6 Nov 2025 01:54:44 +0000
Message-ID: <20251106015727.1987246-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106015727.1987246-1-avadhut.naik@amd.com>
References: <20251106015727.1987246-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|DS4PR12MB9612:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b5f9a6d-f357-49db-b96d-08de1cd7e465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lk6hc2pwlugGEGwbTHGx+oP1EnrfLSkFEXdvLsCg5qnKVyuo7kDj6ALAsMlJ?=
 =?us-ascii?Q?emvyMCvTkkgi7DELjrsFHw2lnoW7OTZQC3Zllc75N5bbWqi0nl0qMIeIvYgT?=
 =?us-ascii?Q?tjKIFPZKRMAq3SuHjFzuCQ3hJtbTQ2dpznO31VDf4vFs8jMT9sWL3KHw+qWQ?=
 =?us-ascii?Q?d8bq5IkiUa0AwbQKANw1NYAEU20dCKCkNiPn3LlyVnUsNu+WukWfkZWqXFVc?=
 =?us-ascii?Q?4SsmBSm4CyzUCSrMLm6PuzgZRk7fz1Lu1dIWitFPdW4yZu76TuheluYRcRvw?=
 =?us-ascii?Q?caYkNNAbGTOW5/48EdVD5w+nE+/povMP4QxTw2yHM/7PEDjyr0CKbDNctZHJ?=
 =?us-ascii?Q?5A1BzXCfOdYnX+CFHFp/xeA32NK4Un07ywmLp532JTYVZ+BLbn5E4N8gmZWS?=
 =?us-ascii?Q?e9dgtL265fPCC1/nHyDxxGZyZ/25CCjJqo2uqto9j4KFQ9AYUvjS+/xe3mDE?=
 =?us-ascii?Q?eSrjIx9abI6SMZ104cuLwDlOABBeeVbqD0gm/ina9lg5uiFgsPtxhi/eYkXL?=
 =?us-ascii?Q?dLeEjjS4Vw/hspRsfVR+7qlp1gFFEmp5EpvduP3jSM3mNRwAmIB0llFTLNjZ?=
 =?us-ascii?Q?lX8vqBu1TrCn/hbvVyvtPaqgZPIIWKVUELJLqDgwylaqMYBA6L3/gaSQ+MPd?=
 =?us-ascii?Q?LG4pRv6pzQVYLcCRbxq88aAr93FzPCOH3e3ihAf41A08NwH4GES9h+l57X45?=
 =?us-ascii?Q?zxp0+o6JwTMfk1h0TnS8id4OXMc8J1odpBI7yqK2SLttokOniKvOSqRjoJbp?=
 =?us-ascii?Q?Nax1zJ74mHVaECtA9MTHvZDB+p/Bmz3NPm1Xgyfg13eCKYRr+QN9aF1DxJ7O?=
 =?us-ascii?Q?nkZdzFebH1CcaywMzcy0YiIMGaD60THOSbdfXIPaow/YDG3OqPT/6IvMJIsg?=
 =?us-ascii?Q?W0oyyIi5lsIUZWLOHyuuFkhkhza0IxhnyFux+gyeoDV39Bz25DpaB+wH9B9x?=
 =?us-ascii?Q?+TK9dyPuEkHIV23Mvu9YG6cpYitHpxiqgOwIjfrUflvM6K26G/tcSRhBXoJH?=
 =?us-ascii?Q?eSTmNaeu6JYB6xpvI3zSL6ELFRz3ZXQDFjPWoycsQ+0oOiMd/R5cwWTH0xH2?=
 =?us-ascii?Q?TuU8Gd7U7UQjLDIeNjjtt9aqYmp0Og+mtQmq+MbWeXXFH/Nlp1KQlae8pZ5d?=
 =?us-ascii?Q?9fWegu+K/fVRYcsgxPT30ij0/OM2UcL+oj3ocN3ZVbN8nkGH2y90xS60I1JZ?=
 =?us-ascii?Q?C8l3KLhlCH4lhgX8M6F+HRcbrErUe/JrmMa705jcxMqBfep3Fw7qObOiVq6k?=
 =?us-ascii?Q?5oGxnK970OiWB6TEWN6XeREUiHvhr5tMevN4KbN9YlSYWSHble6yqXAxK+51?=
 =?us-ascii?Q?uBBmA0Cg4CZ3zS/gxIdaaXdt2CoJKCrCmnWT5MZTWb6KZezNdhxvInHRY//j?=
 =?us-ascii?Q?h8Iiyk/i+kNLwVH6poBTUBbys3uJTdy2DOnMAE68OR8XkdVe2UHKQkxltFci?=
 =?us-ascii?Q?Ow3jnU2Eua3W//rJ+J4tiYoxS9cLtYRMlLJ+96QEtUy8zz55utRelqhRW+u1?=
 =?us-ascii?Q?t3bgCEnM2hib+mBNf4nFFAi9UDda5E87KwINgeimqLFAACeCSyxyPu0My5X8?=
 =?us-ascii?Q?n7KshcWixztA/AWL2ww=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 01:57:50.7266
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5f9a6d-f357-49db-b96d-08de1cd7e465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9612

Currently, the ctl_name string is statically assigned based on the family
and model of the SOC when the amd64_edac module is loaded.

The same, however, is not exactly needed as the string can be generated
and assigned at runtime through scnprintf().

Remove all static assignments and generate the string at runtime. Also,
cleanup the switch cases which became defunct and consolidate identical
cases.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 56 +++++++--------------------------------
 drivers/edac/amd64_edac.h |  4 ++-
 2 files changed, 13 insertions(+), 47 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f6ab783bf20..886ad075d222 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3766,6 +3766,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	pvt->stepping	= boot_cpu_data.x86_stepping;
 	pvt->model	= boot_cpu_data.x86_model;
 	pvt->fam	= boot_cpu_data.x86;
+	char *tmp_name = NULL;
 	pvt->max_mcs	= 2;
 
 	/*
@@ -3779,7 +3780,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 
 	switch (pvt->fam) {
 	case 0xf:
-		pvt->ctl_name				= (pvt->ext_model >= K8_REV_F) ?
+		tmp_name				= (pvt->ext_model >= K8_REV_F) ?
 							  "K8 revF or later" : "K8 revE or earlier";
 		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
 		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
@@ -3788,7 +3789,6 @@ static int per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x10:
-		pvt->ctl_name				= "F10h";
 		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
 		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
 		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
@@ -3797,12 +3797,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 	case 0x15:
 		switch (pvt->model) {
 		case 0x30:
-			pvt->ctl_name			= "F15h_M30h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M30H_NB_F2;
 			break;
 		case 0x60:
-			pvt->ctl_name			= "F15h_M60h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_M60H_NB_F2;
 			pvt->ops->dbam_to_cs		= f15_m60h_dbam_to_chip_select;
@@ -3811,7 +3809,6 @@ static int per_family_init(struct amd64_pvt *pvt)
 			/* Richland is only client */
 			return -ENODEV;
 		default:
-			pvt->ctl_name			= "F15h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
 			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
@@ -3822,12 +3819,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 	case 0x16:
 		switch (pvt->model) {
 		case 0x30:
-			pvt->ctl_name			= "F16h_M30h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_M30H_NB_F2;
 			break;
 		default:
-			pvt->ctl_name			= "F16h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_16H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_16H_NB_F2;
 			break;
@@ -3836,76 +3831,51 @@ static int per_family_init(struct amd64_pvt *pvt)
 
 	case 0x17:
 		switch (pvt->model) {
-		case 0x10 ... 0x2f:
-			pvt->ctl_name			= "F17h_M10h";
-			break;
 		case 0x30 ... 0x3f:
-			pvt->ctl_name			= "F17h_M30h";
 			pvt->max_mcs			= 8;
 			break;
-		case 0x60 ... 0x6f:
-			pvt->ctl_name			= "F17h_M60h";
-			break;
-		case 0x70 ... 0x7f:
-			pvt->ctl_name			= "F17h_M70h";
-			break;
 		default:
-			pvt->ctl_name			= "F17h";
 			break;
 		}
 		break;
 
 	case 0x18:
-		pvt->ctl_name				= "F18h";
 		break;
 
 	case 0x19:
 		switch (pvt->model) {
 		case 0x00 ... 0x0f:
-			pvt->ctl_name			= "F19h";
 			pvt->max_mcs			= 8;
 			break;
 		case 0x10 ... 0x1f:
-			pvt->ctl_name			= "F19h_M10h";
 			pvt->max_mcs			= 12;
 			pvt->flags.zn_regs_v2		= 1;
 			break;
-		case 0x20 ... 0x2f:
-			pvt->ctl_name			= "F19h_M20h";
-			break;
 		case 0x30 ... 0x3f:
 			if (pvt->F3->device == PCI_DEVICE_ID_AMD_MI200_DF_F3) {
-				pvt->ctl_name		= "MI200";
+				tmp_name			= "MI200";
 				pvt->max_mcs		= 4;
 				pvt->dram_type		= MEM_HBM2;
 				pvt->gpu_umc_base	= 0x50000;
 				pvt->ops		= &gpu_ops;
 			} else {
-				pvt->ctl_name		= "F19h_M30h";
 				pvt->max_mcs		= 8;
 			}
 			break;
-		case 0x50 ... 0x5f:
-			pvt->ctl_name			= "F19h_M50h";
-			break;
 		case 0x60 ... 0x6f:
-			pvt->ctl_name			= "F19h_M60h";
 			pvt->flags.zn_regs_v2		= 1;
 			break;
 		case 0x70 ... 0x7f:
-			pvt->ctl_name			= "F19h_M70h";
 			pvt->max_mcs			= 4;
 			pvt->flags.zn_regs_v2		= 1;
 			break;
 		case 0x90 ... 0x9f:
-			pvt->ctl_name			= "F19h_M90h";
 			pvt->max_mcs			= 4;
 			pvt->dram_type			= MEM_HBM3;
 			pvt->gpu_umc_base		= 0x90000;
 			pvt->ops			= &gpu_ops;
 			break;
 		case 0xa0 ... 0xaf:
-			pvt->ctl_name			= "F19h_MA0h";
 			pvt->max_mcs			= 12;
 			pvt->flags.zn_regs_v2		= 1;
 			break;
@@ -3915,34 +3885,22 @@ static int per_family_init(struct amd64_pvt *pvt)
 	case 0x1A:
 		switch (pvt->model) {
 		case 0x00 ... 0x1f:
-			pvt->ctl_name           = "F1Ah";
 			pvt->max_mcs            = 12;
 			pvt->flags.zn_regs_v2   = 1;
 			break;
 		case 0x40 ... 0x4f:
-			pvt->ctl_name           = "F1Ah_M40h";
 			pvt->flags.zn_regs_v2   = 1;
 			break;
 		case 0x50 ... 0x57:
-			pvt->ctl_name           = "F1Ah_M50h";
+		case 0xc0 ... 0xc7:
 			pvt->max_mcs            = 16;
 			pvt->flags.zn_regs_v2   = 1;
 			break;
 		case 0x90 ... 0x9f:
-			pvt->ctl_name           = "F1Ah_M90h";
-			pvt->max_mcs            = 8;
-			pvt->flags.zn_regs_v2   = 1;
-			break;
 		case 0xa0 ... 0xaf:
-			pvt->ctl_name           = "F1Ah_MA0h";
 			pvt->max_mcs            = 8;
 			pvt->flags.zn_regs_v2   = 1;
 			break;
-		case 0xc0 ... 0xc7:
-			pvt->ctl_name           = "F1Ah_MC0h";
-			pvt->max_mcs            = 16;
-			pvt->flags.zn_regs_v2   = 1;
-			break;
 		}
 		break;
 
@@ -3951,6 +3909,12 @@ static int per_family_init(struct amd64_pvt *pvt)
 		return -ENODEV;
 	}
 
+	if (tmp_name)
+		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), tmp_name);
+	else
+		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
+			  pvt->fam, pvt->model);
+
 	return 0;
 }
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index d70b8a8d0b09..4ec6133d5179 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -101,6 +101,8 @@
 #define ON true
 #define OFF false
 
+#define MAX_CTL_NAMELEN	19
+
 /*
  * PCI-defined configuration space registers
  */
@@ -362,7 +364,7 @@ struct amd64_pvt {
 	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
 
-	const char *ctl_name;
+	char ctl_name[MAX_CTL_NAMELEN];
 	u16 f1_id, f2_id;
 	/* Maximum number of memory controllers per die/node. */
 	u8 max_mcs;
-- 
2.43.0



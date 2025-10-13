Return-Path: <linux-edac+bounces-5031-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DE86BD58CA
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AAA3C17A4
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 17:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1BC30595D;
	Mon, 13 Oct 2025 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XWzhq/Rp"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011046.outbound.protection.outlook.com [52.101.62.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919FF2FBDEB;
	Mon, 13 Oct 2025 17:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377026; cv=fail; b=fj2JitGD2biX4C83Wzg1w0xJjeTOE4ywp7zk8f1BHqnRXMxau/V3gt7Rc5EFglSOQ0Wv7MfOxpNHeQw/yLkvVfOno073feNWgvf1EmG3cjLk492PHVWGzvIA/tioPW9o6eJ1+VGZUvusotPL3a2GoOZJ+eJXG/IMXpi3Ojq0TvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377026; c=relaxed/simple;
	bh=2VwYgme0YtmU/PphCcXLy5I2Rd/AJqtOKrLySsdl8xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGNtqJZfyBuSpuzQHdzLP2Gjgthy0zh5/q/2cwk2110/9OtnguAYY6C59dj0aVEBCbAvkkv0GMi34nohtFb7bV82QfgEuq1n00Wcl29E+q5XbplDsil1WXyqZ6zKr+WbV9XSS1sKn0FqfcnoHaVqjbmd53QJjIw9Q6MMZMyKLHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XWzhq/Rp; arc=fail smtp.client-ip=52.101.62.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiTv0sMU/dXEK2VyyU6NBzTq4z7TXpKTSjAbtpBtzym/+7On6m+gzO9y6x4fW2H0IkGJbMIYslSkka+apT92IS1AlRO+SfcOxjW8F42+Ew0Rl9YHKC9SMimwjHSOp2+cXpuhQNytgO6fiPX9hHjdStRoMsbPeR4I66zdkZKNWaZ1AQ4oQwV/bJpq5ZAJc7YmXgOzQikv39NCS4259XwJGSMUdCQdOa731MYgDfw6pXfihfqvAM5a0URdTt2zU/+Q7G5se9AadYpe9iVsOVyGAGKVquJ+xKsHRduPfqSJO1dgIIzyF2kHRFo5gf1IX2jwEptcO3hIN6WniCjQ2X6cwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkwLHieeEjZZCm9PHDeWsK8RgFcflo5m1e0qZtTEN10=;
 b=cZ2d7SWN2CjNS6CizDKeURatV6i3gEcG008MvzGGw9yy7Y31XCYTT7Ywq4BOANjBrAKwmjvVGAv0KXPa4mz+zL/GkvY6qRwK7nbR4GmoenD+ujJEkroRBIsxZNP7pmH2HOyqu0ha+TmLXv8/DG6KEOEv1g9ej3RaGBNtne+Kam1IZjxKBJg6T0LC3s/Pip3eUDD9N+tJDtjPlF3rg3WPVjyaETvvgvkg8LpYUDnvhyQGixweP3drnnNMNpvEzET8A5+YfbZF5qy+xvggJ7Ie51ao0l9KMEi0pfJo8kTzMZF0fCOUw0tVuj6m0qnkbNCuIl3jQsl7D1xM0AwLCSFuRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkwLHieeEjZZCm9PHDeWsK8RgFcflo5m1e0qZtTEN10=;
 b=XWzhq/RphtbCN2ZJgQcEnYThDXFMY8Mu0zfCbEyobElejGVUzFP/uj0PJhHhzGCSzYboSrLqZ8IdGZXQijp7ztVj5l2y9xRBKUIlQYX7SoZ6jLvuWZ7FeDRO5vnDA4Bs2DeZOT3nnUbTFwRzCIkrmwyyFhv4rwlEelWeaX7lh5U=
Received: from CH2PR07CA0046.namprd07.prod.outlook.com (2603:10b6:610:5b::20)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Mon, 13 Oct
 2025 17:37:01 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::aa) by CH2PR07CA0046.outlook.office365.com
 (2603:10b6:610:5b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:37:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 17:37:00 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 10:36:59 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH 1/4] EDAC/amd64: Generate ctl_name string at runtime
Date: Mon, 13 Oct 2025 17:30:40 +0000
Message-ID: <20251013173632.1449366-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013173632.1449366-1-avadhut.naik@amd.com>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: aed3c72d-3b11-4880-6f1f-08de0a7f1dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ANzUxdwXVNupoY1fY0RqqXd38x64LdZIIAT/PYa2C0yqvnvQKJCPB1f31Au6?=
 =?us-ascii?Q?2Xskhp+wsH+8cl4USGZIJUY2xfzXIiN+nzme0e2R+Go+ZB/msxWuyWZa+Lc2?=
 =?us-ascii?Q?/TyWd37AgsCk1l77DeUX5VkfkZTNG+Ig3XgAIc5ukhkmHYCew8XFw61eFLBP?=
 =?us-ascii?Q?m9XxrVnL/myzb15E7dHwPytQOqXGfjWfY6Uus3OchI0j2ip+Li0+fpfyTTkX?=
 =?us-ascii?Q?BhUOoJaqQegs41FPlkO5ktc4o2JxBCycaeDK9rmyIbjKi57Ae2eiEz5JobDP?=
 =?us-ascii?Q?3FN07zbJmMavka0rR8zAQUF60eWm9QtFUs//Cyqt/iG0o/qAOs6kwKypjXHA?=
 =?us-ascii?Q?f3I569mdmKiHClkImOwooNZWSVRGGBVwUmz7FiwloySxFBCmX0hOx4bdIBJY?=
 =?us-ascii?Q?nwI9VOcu6EU8eoZG97OpPGL8ZIlpWQLCCXO8uz2J1S3YNPgNLTb5RV/OFqzF?=
 =?us-ascii?Q?tdez0ZEOqJCQD6jR+6X+1dK1IdbdbQZQsf5+J5CnFRLq3WSaWwagBCder1qe?=
 =?us-ascii?Q?tsXPopVjZ9HdAN1rCkacqfc1eScRwFW7fw5KQm2qVo6w07hJeGiAKDRjuWc9?=
 =?us-ascii?Q?7HhlTzOxsogHZBUqO/vLdWuoybFQ05v+9Uqg7hSkFMft0jKyd1tjMLpd2rF2?=
 =?us-ascii?Q?7IB+aW1FnceOyVYK/UGKVhBCDT0fmy7EMjuB2l12Byzyktx2u1wPpbB/Ql7j?=
 =?us-ascii?Q?m4MGs7orxUhJIbFGCDA/k1cvZyHuYWaJK3sWtzuce8dFpCHCZTVDxtP5fDOZ?=
 =?us-ascii?Q?BiG23fKj7wdGHiDlNsQSpjIwrB/R+TuNMPWKvT4mEce0++gyrcHfQPc2u8XO?=
 =?us-ascii?Q?Gg/oppD9LKK+JjSj+3tiqOfLjRdendTrAf640jP5dN57XRrBenH8I3uRyrwT?=
 =?us-ascii?Q?fIgDkCdKQ0ndpaOgbt03uBwptayMWg0FxpIbOL0igh27uR+fGz31qSo71VQa?=
 =?us-ascii?Q?e/R8uSzvk03Zaf0v4+t3tHVTNGSRE1qiDKJptPa2xhFLQqID688r+B52D8AC?=
 =?us-ascii?Q?IwRD1ri0zScBSMYM0B/6q+O6dvLvy7XOUcrxynP50lOJLPpZpl+k7B3wzF/d?=
 =?us-ascii?Q?z05zFlz2lX+3utkEeiJgYSvmUjytaZQkbm2VfYb+d0MAFfiq3jSrwMh5j0/S?=
 =?us-ascii?Q?3jZsJM3iNx9joI62qJidi18SYy6D0C0Vpp5lIPHoYQOBzvR44PrIpB39dJ3J?=
 =?us-ascii?Q?Fi/ZLoRO5D6LyoAahdlAZfr1ZidrlUw76eT7shJd5NJ1h7v7SOjm1x73wSgf?=
 =?us-ascii?Q?w9eKOIGKKf+eGQS4GRyrY5SFBqiemZUmguBSYD9G8LDiCebbmgySYns9phaI?=
 =?us-ascii?Q?+3VoXBbryUSbf1ptuqMM/AbkMht5TsPx1/oDH0cG9b/EtykTkQDt6MfxZ9Hs?=
 =?us-ascii?Q?ni4+8P1Rnd+sATVrH0WwkxHv1y3hXKxpH8BD6MA2dwOUzgsL1QSwvTCHJsh5?=
 =?us-ascii?Q?tWY+4U6VFTfnGLgVIAUH6u+mI4R9EWVwoXeKIUMJNcOuEOdHlub/HCZPLeWv?=
 =?us-ascii?Q?9IfR9A/mu8pLy3PU3z+IAtTQ1D9y2RsksFm/A5uO177u7+A40pazMQE5RQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:37:00.8484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed3c72d-3b11-4880-6f1f-08de0a7f1dbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

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
index d70b8a8d0b09..bb6cf4b1ab77 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -101,6 +101,8 @@
 #define ON true
 #define OFF false
 
+#define MAX_CTL_NAMELEN	20
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



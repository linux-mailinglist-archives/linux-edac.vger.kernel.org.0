Return-Path: <linux-edac+bounces-4765-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB04FB505B2
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 20:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 865C416F4F4
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B853570D6;
	Tue,  9 Sep 2025 18:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lK8QoMub"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11F335BB1;
	Tue,  9 Sep 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444297; cv=fail; b=mr9V6/YQmbYo7n9snIJjLbt92K0ztkWCEZp8Vw1/1PkdoHVaBpqKYvbBa+F9H7dL8qGPLy5EWlzldA+E1q0L0kCFGiPxaSmdpw3zsN/tFxI5BoYc2aJWVP0LI4lKEljVBc18gBvoWZnomL7u4BWYYXgr/YVjC8wnoNFcsCIYcVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444297; c=relaxed/simple;
	bh=efnK+kHiE29x15dXn55wAU2AsupMIofCqEkc750g7AU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cBJqRyBApSJDBYa1z9J9Rwkgl3AmURRNbeMCpA2OC08WbHOQMBC2TvJ8oAKTFENeiU72GjOWr0dE8j80PwfH9bkMX5O9iSdo5blcOu7alN7sY8VOwoRcGQjXCdH62Q4ADIB3MSxHt5wjU2zecf2C6l3N077a8u63zMOAew6iKbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lK8QoMub; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fs06PFDu0U6wZiYGPtAfSIfAP4fq2Zd2pAJxmQHajQgKEmO6Li6Cl0Q5KqeccCFlFJjqw5z6Gga+zGzAPR4efurAp1u7sBOhUi2jBafm+7dS745dKM/9ONYwldfsYmqidYJFxTFPhdqN6MhWWdXGgZvNs0YfT1a0brKUYdHhedRJXUquVEjcH4pMkM+bxI+9cAZOGj5/ocPJoezwQNiT+1cqBEU6RglTX6dLwnp8J9Ue21WH0CVb2BXi8oXY4Z7cfGqVg3zFIAog+WLK0Lh2Ybz54CI9JguApFDDarhpNh3y7uapgfuND30ggdxkgBdF1ckPw2jjD4gjprcsU5VVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncLhxJ+7XLorIo2awyopMwkuaXo0nREe3DBKLKUdu10=;
 b=IuVM+zlJUvjME0J3WG9BKWEgilK+I7t7IsBStFZdbXrnffXJfoTmSNBBbhEqkPJmxYXvHWV9gJEnMsuBMwXHCKT2ZDeu3smAWGtrNesYkd5AlRQ5HbOhz/V25kGQ32fdBVrnXWmVp7mLpXWa5e5IfJ//zNruC9Li0Ux9bbcmsX9mzLOILPsMUv2YPbmXFcsXIXdwh8wXcRyG7dQQRy5Ez+AN9MtsSTBu73/21yoq1yE04ZjnRd6NOaQwkfQtXKoZtBDFGlgVEdJRvLykugCiePfVaEvqxRag7MBA2i3cGQ6TraxWRIogRX+r+p7DBb9JxEHKTkr5UeBoUOcXJ0OTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncLhxJ+7XLorIo2awyopMwkuaXo0nREe3DBKLKUdu10=;
 b=lK8QoMubXlEs3tLtOzRz0d+4E5B4JGlnoLAyxpXveDiuX1OkHR4bdt8XBOxDCLtWuoiplYcbNx0wVlbsGLBmYsxPVIzCA9rv9PF1mJ0gl7ahswWkuPBxUTvsuUCB8zpm4Iari8epeCDE9NzguLP00E16c4XimHrd3zRNdWzuKWk=
Received: from BN0PR04CA0209.namprd04.prod.outlook.com (2603:10b6:408:e9::34)
 by SA3PR12MB7832.namprd12.prod.outlook.com (2603:10b6:806:31f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:58:10 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:e9:cafe::cb) by BN0PR04CA0209.outlook.office365.com
 (2603:10b6:408:e9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 18:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 18:58:10 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:58:04 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v3 1/5] EDAC/amd64: Generate ctl_name string at runtime
Date: Tue, 9 Sep 2025 18:53:10 +0000
Message-ID: <20250909185748.1621098-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909185748.1621098-1-avadhut.naik@amd.com>
References: <20250909185748.1621098-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|SA3PR12MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f042946-26e6-4385-e5c4-08ddefd2d1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PZAIO/WzS/dBMzZUqiKRqJvFumwUUak+yQVhtfnLSx9acCcWRui8jJeW4Z5U?=
 =?us-ascii?Q?mL39O6JGVCLTaWGU0KF+bsq4LpTt5dy15x1veF/4SPYM7eWq21CV3HfhMMYe?=
 =?us-ascii?Q?i7ZcLqBlsfg9D+0TOuVJshi9dSgkxgOqt5pn1ubOjvpGsvVKsW/1FzB7QuUt?=
 =?us-ascii?Q?CTRkc12279bY3B0pV2IwPsA/ZJU2xmVTz8hN3hzZ9A3S49U428Nv6NlJ41Bd?=
 =?us-ascii?Q?3wjThgHpEvbD8+0yK7aEWMx1+sB3veNWmuSjdOhKARoreOc3ulisqjR/sxeU?=
 =?us-ascii?Q?ATNgDY3U7WwGuqr3212XexwBKXaGVl6lJuMThaYZ7phdGcTsTjybYhaBLnQJ?=
 =?us-ascii?Q?iPlw48HRT715pLBWevjvVf/wRUaEU0rJOGEi98s3pwfkTuqANUybZReEbKGI?=
 =?us-ascii?Q?opozyasqh8cVjt3tMhSVo7qzdFnkE/O8X5SM+9JAzePPHHlIs1RCSI9vZpOs?=
 =?us-ascii?Q?R5GhnSMDXcCw58jCuUP5Wa+BPSrt2hvYmYeqiVs1gI24JLAwXpOc/TnJV6gg?=
 =?us-ascii?Q?U8wHjATqNgAusQZHQ7B7TbvUQD3JchZIm3cza4VmiW0ixDF26d4BO7Yol4MZ?=
 =?us-ascii?Q?nXoJQf4XATuZEIDFJ5vSOk9Onc0UDCQ8Oz1TdruDkF/hQc3LAUJVjEGxPs4X?=
 =?us-ascii?Q?EGXC18uB55U+up4M65edoySgKYQV61NwUne8mQIGSWYYz2hpK8jnyQU4fGhr?=
 =?us-ascii?Q?f3CwrvTcquvkx6bcHFIwfv19iUuCAcR8Yr6Wf3TMl47SnrtpAuGnG8BB5C7X?=
 =?us-ascii?Q?XMXuhHwIz3/34//qZ41Sua+JzhXKixxupQ2KRn9FPxbdW/mtNqYEzRc9xWPh?=
 =?us-ascii?Q?zcdi6Kw2Fz2WpAlwQv2ZS9cILk6Jz+vNqBnVoBzYNl7TCsPQVretwE+RWguj?=
 =?us-ascii?Q?6Ls33SkNQ6QtV/LG6f4lx5josmWPOPnZEBE5+BU8OV7Pw2rj57MxOoMjyVXi?=
 =?us-ascii?Q?DiE6xy4Ee1BkLSr2TV5oteEIegyQxU9cK47S3jvEbmrNWoZW2si2a9YMQbdQ?=
 =?us-ascii?Q?IIGf+SciPMDbTx8Jup8Key9Pa4abxIP2xiRAdxmsgzCJqSSdD/nOUP4XwOYl?=
 =?us-ascii?Q?Zh4TR2wVnO3V8f5CqEW4tVWXtFM1CsBzDJJpDlIz4E25MKBHe8aEDTM97gPA?=
 =?us-ascii?Q?0rWNv7pYTuykUNDw29FwhKEKmFfd9J6bOdCvFmquRlpNhfHvzzFs0ZFDJ5iU?=
 =?us-ascii?Q?jeFNIrPdfH+cr2VN/EnXjkKXfotdxyeyt/+O+a1Ze+7a4hrpK/AVfiU6abzL?=
 =?us-ascii?Q?okpw8JD90GMl9h6jUJUojFBBRD9TlfRvqwLPZPLnVFI+KgqZSAVyhVS2Vt8w?=
 =?us-ascii?Q?RqjVAtqPNbgEuBWTNwvmtYWnPmwEYZB/0sfiiqVB+iUURmvhw+1RS5mf4K7F?=
 =?us-ascii?Q?7oeJuKaTucrd5nu0wOXFPl8S3R5uSl07GmKD91UCUENONRGEXCaAwQW3ZQhr?=
 =?us-ascii?Q?1YPn9z8WQ1XBd7p4okE1OLVwA0ddrcP+vLZBh0x6eytDTjptGi+rttvL07vu?=
 =?us-ascii?Q?XkO+y7bUnn/QTp3eRoDe/SU7aX0GayE/x/Nn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:58:10.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f042946-26e6-4385-e5c4-08ddefd2d1ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7832

Currently, the ctl_name string is statically assigned based on the family
and model of the SOC when the amd64_edac module is loaded.

The same, however, is not exactly needed as the string can be generated
and assigned at runtime through scnprintf().

Remove all static assignments and generate the string at runtime. Also,
cleanup the switch cases which now become defunct.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v3:
Patch introduced.
---
 drivers/edac/amd64_edac.c | 44 +++++++--------------------------------
 drivers/edac/amd64_edac.h |  4 +++-
 2 files changed, 11 insertions(+), 37 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07f1e9dc1ca7..3989794e4f29 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3767,6 +3767,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 	pvt->model	= boot_cpu_data.x86_model;
 	pvt->fam	= boot_cpu_data.x86;
 	pvt->max_mcs	= 2;
+	scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
+		  pvt->fam, pvt->model);
 
 	/*
 	 * Decide on which ops group to use here and do any family/model
@@ -3779,8 +3781,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 
 	switch (pvt->fam) {
 	case 0xf:
-		pvt->ctl_name				= (pvt->ext_model >= K8_REV_F) ?
-							  "K8 revF or later" : "K8 revE or earlier";
+		if (pvt->ext_model >= K8_REV_F)
+			strscpy(pvt->ctl_name, "K8 revF or later", sizeof(pvt->ctl_name));
+		else
+			strscpy(pvt->ctl_name, "K8 revE or earlier", sizeof(pvt->ctl_name));
 		pvt->f1_id				= PCI_DEVICE_ID_AMD_K8_NB_ADDRMAP;
 		pvt->f2_id				= PCI_DEVICE_ID_AMD_K8_NB_MEMCTL;
 		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
@@ -3788,7 +3792,6 @@ static int per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x10:
-		pvt->ctl_name				= "F10h";
 		pvt->f1_id				= PCI_DEVICE_ID_AMD_10H_NB_MAP;
 		pvt->f2_id				= PCI_DEVICE_ID_AMD_10H_NB_DRAM;
 		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
@@ -3797,12 +3800,10 @@ static int per_family_init(struct amd64_pvt *pvt)
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
@@ -3811,7 +3812,6 @@ static int per_family_init(struct amd64_pvt *pvt)
 			/* Richland is only client */
 			return -ENODEV;
 		default:
-			pvt->ctl_name			= "F15h";
 			pvt->f1_id			= PCI_DEVICE_ID_AMD_15H_NB_F1;
 			pvt->f2_id			= PCI_DEVICE_ID_AMD_15H_NB_F2;
 			pvt->ops->dbam_to_cs		= f15_dbam_to_chip_select;
@@ -3822,12 +3822,10 @@ static int per_family_init(struct amd64_pvt *pvt)
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
@@ -3836,76 +3834,52 @@ static int per_family_init(struct amd64_pvt *pvt)
 
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
+				memset(pvt->ctl_name, 0, sizeof(pvt->ctl_name));
+				strscpy(pvt->ctl_name, "MI200", sizeof(pvt->ctl_name));
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
@@ -3915,12 +3889,10 @@ static int per_family_init(struct amd64_pvt *pvt)
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
 		}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 17228d07de4c..56999ed3ae56 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -101,6 +101,8 @@
 #define ON true
 #define OFF false
 
+#define MAX_CTL_NAMELEN 20
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



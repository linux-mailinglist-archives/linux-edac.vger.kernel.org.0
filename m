Return-Path: <linux-edac+bounces-4537-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 121A2B1DE33
	for <lists+linux-edac@lfdr.de>; Thu,  7 Aug 2025 22:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C780F18C6F72
	for <lists+linux-edac@lfdr.de>; Thu,  7 Aug 2025 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164612749C8;
	Thu,  7 Aug 2025 20:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fVAozItf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2050.outbound.protection.outlook.com [40.107.95.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D16627467A;
	Thu,  7 Aug 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597964; cv=fail; b=Qcutex0DHP6HDGDForlunfbAwGfDb0n7vmeHeQISqr4JOPIgCWT5Brxz3XGaVpI2DsyJsBULrHmt6AamKwec+2jcCc4c0JfenudR5ZRBG6JGBs+Kas5hZNzg/4B35Q8WDGYjR/l8VSU8Vfv+XJZ/tu8FdbQsDr/axlEfsB/59Bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597964; c=relaxed/simple;
	bh=d/gcuT3/gedOoFjO3WNWfL7v4gs82IIvgpdKXVhqdas=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXsIhEEiofb80qHr6hax+g8iVcCdGRnpv1vjuLLknYcCviLSnRWMZIM+o2j8oDoKcWQMnAMS0F3uhX7D0b0uASvmoZ1rYeyqlBdT2rkhKYq4DrdP1UI4bVA2bONSq5ld6zYukplU8W68jIjWjervByYGXtWChslK6cMi1WKtYLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fVAozItf; arc=fail smtp.client-ip=40.107.95.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=im3WLvZZw9JfOS2bpwgFZ7qvY1funKOlKNdlWBFCJUclb1Yg9iYAAfdN6OQbhPa/zaWLv5fIMhhpnC1BKrpNA/mIMVsJiS4jHbOG19y6One4IomELb/oFkPq5VO8Q5IoEbXHEO9CXRIvarfgC8uW4GV3dKfWfU3KHbHjJwWtTgeBY1CtyWgEneqnC10cxcABVwzuUWNIOQj0df3F4Xjqo5/3VDloPnYYjgjD5HEw5WmU+aTGXxuv7ptvMqBF9aRA0lmLiEAaS95Cx5NRZb8dhzTIO7IwqoXTLJJ97jxeu4s6PtegUFzUOxSG5xo3aiGc+8MfGhb7eC8JbY8b5fdgjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AMuqWfYB2b+NjmFf6VHLne3pNthlpkyiHhhDQA95ErQ=;
 b=dbDEepKqvvvBRes2d7Gapn25vIoxvVKJFR1VlwBDJTmts/WF6G2/mMkkqJykZoaUXPO88+f7MVYedO7n88aF+61JHgO/NFOkOk9NOHGtdfUBZnVtddpjhZsQT56r5ZtZ0zItYRnuBOTCXqUJZzxwwQ5NGS9EYWHUcoR2ueOiNHZ3aRh6SLIhwy2OTST4uonVRFo4SKR52JgPviUxD+wWCL+MaVEHJ3Q+BlWVTMWKna9o1+ua+SZOFEQuZdh3pDI13fcpm1Q0fhnNI6wqwElWLt5b4hTcepaJOeEnwaTA6IIp9A5plmY9FVujW11ZXxKg7Wfr8W8z6cyPvjvV6D7jsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AMuqWfYB2b+NjmFf6VHLne3pNthlpkyiHhhDQA95ErQ=;
 b=fVAozItfkKHe1j7Cb26TQxQDq6UfcLpZ2ekrhQJz1g61KFPGr4JNpfxcJnBTLjC6m+k/mzRWNAnEIDt2OYoIdN5xXr+q1Vagpdr8DMO9T+xPpIBWa+4qKXegIwL7KhnAYTmOYvGOHGypj86jYBdVkrS4Ub/4pehoK1B8R+f/Vbo=
Received: from SJ0PR13CA0021.namprd13.prod.outlook.com (2603:10b6:a03:2c0::26)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.15; Thu, 7 Aug
 2025 20:19:18 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::53) by SJ0PR13CA0021.outlook.office365.com
 (2603:10b6:a03:2c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.8 via Frontend Transport; Thu, 7
 Aug 2025 20:19:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.0 via Frontend Transport; Thu, 7 Aug 2025 20:19:18 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 7 Aug 2025 15:19:16 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 2/2] EDAC/mc_sysfs: Increase legacy channel support to 16
Date: Thu, 7 Aug 2025 20:14:54 +0000
Message-ID: <20250807201843.4045761-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807201843.4045761-1-avadhut.naik@amd.com>
References: <20250807201843.4045761-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: ac63402c-b763-4c83-c594-08ddd5efafe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V1esmnzzNZKxhJit/s9i9fMRKJVZj/lGo9163hQyC3z8ST5zT+zD0RoYMApi?=
 =?us-ascii?Q?YIqIwzuNOZk6HlDOJ5jvYNyQrslodS3d38RP7xcNowDrxRi6WNMk1Kl8wzJE?=
 =?us-ascii?Q?w++sVW4PcpwKlCv2stpn2Bjv2tg5QVM1Kei6Y3h8oxMmNpeshoVlOe9FAkn5?=
 =?us-ascii?Q?Xw2gduf1ZBdnAeiIOD/tKRgTVkisihspLCvBW2UXJJ9VYjI3U2lQfxoFg3Zp?=
 =?us-ascii?Q?e86taMVRLz/FTrKI/6ChPSxQCrZmuu5Vlnb62/Y3z7BxBNzhsHKJL9NTA+Vj?=
 =?us-ascii?Q?Ss0spYhhOiSAFxTQr4VIFcdmC6U41JPoLLTkKeI8n+zY9mcXkW9BWYpjRSdH?=
 =?us-ascii?Q?NWOz2jEZocCSxdPzD/nQaz2LG2pZh5kwCAYOhRW7AK5nrj3of9RL/6srNIUJ?=
 =?us-ascii?Q?WipZdstkoHq3FbDeLjHqN7sc6g3yEbIxkVJ4faM99YMCw3DrO8KZLPTcFMqs?=
 =?us-ascii?Q?8AVscAYDPtuitJWK7eMcFzDdAde1sG4rsw4T1oyfiFJR46itcoFItzT20rNy?=
 =?us-ascii?Q?Q8qRG61F4cIF6BlKuab2MmhbUcFBWqtTEaKZV8t8T2vWjakMrDt1q1cKzsIR?=
 =?us-ascii?Q?98S37sL4Hnf9b+hy542djnubq1R5fFEpC2dMMpBxuWLKk0uGMWI1AKgKSEi0?=
 =?us-ascii?Q?w+/JOgjHjv2JAKZtjCVHkzVYumIk8FQ+L3+D2llop/z+lczzkzXHAj+ZtQlI?=
 =?us-ascii?Q?LMqflIX919NKiiX4PKxgUKmVF6qfSfYYIMR7w5s7GFlp33/sLoBeiiKxLHyA?=
 =?us-ascii?Q?hqA1lKXL0ovoNDyzU/o8YULxh/J2QEaNjUZjV3A2nVNPMjlCqKWcJOgZA17l?=
 =?us-ascii?Q?OPeuvNEZ/W/1fN+Jp/EO0iMRFi3NXxdBsc95ZvuPsayYSTO837Rv6eZILMNX?=
 =?us-ascii?Q?aESg3yOJ+Mf5Zs27VflI9hvF/akO+Aq/9viRuaCqRphA1lN2+nkOfYHW9/BK?=
 =?us-ascii?Q?Y2FtJg6wMItCUTu1LnalIix4zllmPGHxuf5+1P8piZag/fSTwvg5j7sonBoE?=
 =?us-ascii?Q?BxZeSWXhu8swBc8QSmKd4J6w44KIDJYSK8OK34/znwRV6pim9qXqV+nZIc7j?=
 =?us-ascii?Q?/ef+QKRzxulvE3t4sx9OYz2TJXeuO2EFsCpwd5Hp1KEpIiAc2922GtavvzpF?=
 =?us-ascii?Q?G/cu0nV1KfyMZjhexSsIj3b5hw8WMqbIw5AVBY9BI+mi3Zh1aWE3ZpCD5mmo?=
 =?us-ascii?Q?rrFvT3btFnGmKGmg+sk5Vc02K6SLc9LG8q+NYw632iX/CDCdTR6QgnYqgvFY?=
 =?us-ascii?Q?328NEd9Mef4ck26b6VN4gvIK3UJVwMAaogM6DotjBfv9cC5Oip1m3VkDivCd?=
 =?us-ascii?Q?G7obq3S8cVZQitOH62bWU18Et1A3JAHFQWfWojUMs2focJw87/PaSz1YBDzZ?=
 =?us-ascii?Q?LjfqdXOh+Yw3AZI+P7bMNWl7j3Fr7Ju6SgovhcNg73zt0v80Jg9UeEsPQUl2?=
 =?us-ascii?Q?p0y4DZcTNA4ZyEKJvtTKTni8O7gEhpmUic8bwsmKtjxoWndE2rz000oinKV/?=
 =?us-ascii?Q?CUSGhZu6Q7KXqw2xmL1j5pbiopjFMHU8HID8?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 20:19:18.0111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac63402c-b763-4c83-c594-08ddd5efafe5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984

Newer AMD systems can support up to 16 channels per EDAC "mc" device.
These are detected by the EDAC module running on the device, and the
current EDAC interface is appropriately enumerated.

The legacy EDAC sysfs interface however, provides device attributes for
channels 0 through 11 only. Consequently, the last four channels, 12
through 15, will not be enumerated and will not be visible through the
legacy sysfs interface.

Add additional device attributes to ensure that all 16 channels, if
present, are enumerated by and visible through the legacy EDAC sysfs
interface.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 0f338adf7d93..8689631f1905 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -305,6 +305,14 @@ DEVICE_CHANNEL(ch10_dimm_label, S_IRUGO | S_IWUSR,
 	channel_dimm_label_show, channel_dimm_label_store, 10);
 DEVICE_CHANNEL(ch11_dimm_label, S_IRUGO | S_IWUSR,
 	channel_dimm_label_show, channel_dimm_label_store, 11);
+DEVICE_CHANNEL(ch12_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 12);
+DEVICE_CHANNEL(ch13_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 13);
+DEVICE_CHANNEL(ch14_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 14);
+DEVICE_CHANNEL(ch15_dimm_label, S_IRUGO | S_IWUSR,
+	channel_dimm_label_show, channel_dimm_label_store, 15);
 
 /* Total possible dynamic DIMM Label attribute file table */
 static struct attribute *dynamic_csrow_dimm_attr[] = {
@@ -320,6 +328,10 @@ static struct attribute *dynamic_csrow_dimm_attr[] = {
 	&dev_attr_legacy_ch9_dimm_label.attr.attr,
 	&dev_attr_legacy_ch10_dimm_label.attr.attr,
 	&dev_attr_legacy_ch11_dimm_label.attr.attr,
+	&dev_attr_legacy_ch12_dimm_label.attr.attr,
+	&dev_attr_legacy_ch13_dimm_label.attr.attr,
+	&dev_attr_legacy_ch14_dimm_label.attr.attr,
+	&dev_attr_legacy_ch15_dimm_label.attr.attr,
 	NULL
 };
 
@@ -348,6 +360,14 @@ DEVICE_CHANNEL(ch10_ce_count, S_IRUGO,
 		   channel_ce_count_show, NULL, 10);
 DEVICE_CHANNEL(ch11_ce_count, S_IRUGO,
 		   channel_ce_count_show, NULL, 11);
+DEVICE_CHANNEL(ch12_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 12);
+DEVICE_CHANNEL(ch13_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 13);
+DEVICE_CHANNEL(ch14_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 14);
+DEVICE_CHANNEL(ch15_ce_count, S_IRUGO,
+		   channel_ce_count_show, NULL, 15);
 
 /* Total possible dynamic ce_count attribute file table */
 static struct attribute *dynamic_csrow_ce_count_attr[] = {
@@ -363,6 +383,10 @@ static struct attribute *dynamic_csrow_ce_count_attr[] = {
 	&dev_attr_legacy_ch9_ce_count.attr.attr,
 	&dev_attr_legacy_ch10_ce_count.attr.attr,
 	&dev_attr_legacy_ch11_ce_count.attr.attr,
+	&dev_attr_legacy_ch12_ce_count.attr.attr,
+	&dev_attr_legacy_ch13_ce_count.attr.attr,
+	&dev_attr_legacy_ch14_ce_count.attr.attr,
+	&dev_attr_legacy_ch15_ce_count.attr.attr,
 	NULL
 };
 
-- 
2.43.0



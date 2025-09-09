Return-Path: <linux-edac+bounces-4769-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17847B505BC
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF43D561830
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB20335BB1;
	Tue,  9 Sep 2025 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EnENHtTC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2052.outbound.protection.outlook.com [40.107.96.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515793570DE;
	Tue,  9 Sep 2025 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444334; cv=fail; b=g41Z1YlYWzMFB9ffP2fO+c+OWzmT199t2pbSMlpSLR3bDfzn2PA+rDrkdlO8+z5Gl1jN3vnI21vJxHOEkWlIce7Bjos8a1hNR17ELBHtRCJIbjSnf2JDLV5k/ArWFoGBxj+G7YUYzpoHFuQEAL2Uy5LdcGgP/R6ASf7MqAnWOBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444334; c=relaxed/simple;
	bh=Au2BEuRokjXsncjzqRdSuw2qay1noMoPrBaucXoRZJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdYFHnjMOkiYfKcnIp0Ux+AuauO2SKA9Wn7o2PqIlsIsceKQwmFfFLil2NKrPBBHNT4BbxXoEd9cpbvd0XrEC5LQj+DDu685wdKDu/0tocNfQCT0Ep6P4s3r6+C2QWB0RZ0kkEn54H3AjO8v2uPTMT0ipSCHsguXyTNhqncz3ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EnENHtTC; arc=fail smtp.client-ip=40.107.96.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4rOfkgneD8KkOiu85GBlnGRzyT8fy5KBf10pap5Bflgw15FCEtrecED2jmJ/XV21jZrYgpajbvqL4Mh6QjgoviJMaMzjxHk5P0B5+M4PPjrP9VN8aMKjoY+vB9+7gbL6dco8hqkD2arAPCDIECRfBt2X6Yl4qwnjN9GKHUsmEc/FN4vpEtcT5n3n03KcbpX+vNX5h2c+1nxuTlvcPlxPpNL7pfU2MW7FRu4DUE3N5acJNUOZL7X5IFqBPK64DRgCrukY7sXgTw4rWZTlFTleAJiyKv+YDNOHVchUI2nfJAAlr4GhGKW2z0mvOWqNRMkfJP7QZlyDngtw65zrF135g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OgGWrbMBM3+nnPztn90kOVJVctdZCf8IodwmkDZYiHg=;
 b=EOT5azBPx4q/B7me8bqDSoRW5phxnhlMF5Hb5K+W/bHGsv+N9KgqyrK1CIhShB+1Wh6d1LUtjj0N75dhJo9xwq2SXwmkBIwJ5mPNItAtHB5wAma6R8CV1qgeq5l/hUiR9rZUFOwj/e+x31uAZhBD5aao6AVWzeQwSVHOKkHOuSbU2NTHZIkFiagfUHKtJEn9pojkW2Ki+GfvQq234NX8t0pISRqXTTpAoYucKdVwRYM+BxHSqXCOcTUXPeKPuT0a6h67tLRow9RUmSIzwqigfMe3NvQ5bkPDdKLIyQ28lged36HKIK78/9Tx3gZ+xx4rJAXmvOLhrR2tJntBl8wVyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OgGWrbMBM3+nnPztn90kOVJVctdZCf8IodwmkDZYiHg=;
 b=EnENHtTCwJkDP3OHGmu/DQFbcfLYOn4rBrJao0Z+mmYCij/GjPBYjDc35qA87nELCvy8UoawFJYYeKRsE9b88Qh9OZTNnkBpz+GOJya28QkwAo7ort0pFRYrS2deVSCZYbG63VlsA3V/oQD8qykbnsxD+dve3ssVW6bpNmz7yu4=
Received: from MN2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:208:23c::27)
 by IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:58:48 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::27) by MN2PR18CA0022.outlook.office365.com
 (2603:10b6:208:23c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 18:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 18:58:48 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:58:48 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v3 5/5] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC interface
Date: Tue, 9 Sep 2025 18:53:14 +0000
Message-ID: <20250909185748.1621098-6-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA0PR12MB8975:EE_
X-MS-Office365-Filtering-Correlation-Id: cdbdfc85-b895-4d42-b87f-08ddefd2e8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/k2bD+Ys6xS/lGKY9B3bA6E8sb7vSp0JD6y/yzNTa30D0+dT7+OKPu9V8Dq3?=
 =?us-ascii?Q?SVuSfk425SNkwCqU1kkU5jMB34yWi9ybXmJWgQFwBsyEUwGF6KbSOZXqgstV?=
 =?us-ascii?Q?CsDa30IenJ8z3TFwG2KTLvcgxrgcqcBYtYYlJ/catqV6tdiJ1OVvFGeDHtv3?=
 =?us-ascii?Q?98QrmZPe8CkKGlR10XUUQ8L9nlQKrpWQQtOTGm9XB4ffa9n2EjvT0A/zr9G+?=
 =?us-ascii?Q?VQsNr0y25fgzOpd0hCGPmiO8u9yL+5s1cWJIcxk51I2RMzLOCnga98yRWTcI?=
 =?us-ascii?Q?Jmzh6mhbYy1FuN6y8KHgpLlhIilOOk7o4RWCfAx67PS8yX7MK315V1J0W5sL?=
 =?us-ascii?Q?V8avWw5mh1grY+gXXX4y0Rb6kedor9TKAmOXbpoXfXB88mg9dnFkFKbh3ARC?=
 =?us-ascii?Q?+F6BeVydf/MV53yQA4JEzSJHvH9JRi8CZUedwmgL06RQshwWAvIACPsyfPxZ?=
 =?us-ascii?Q?9lP3BJ0KiGUU7f0diKrB9fNaAKpRo4R6LDxPIY6tnMXPuAZglv1ousEq0LED?=
 =?us-ascii?Q?hhvMMiV8I7kie1AHm5KbFOXnl3Kw5b8Pl3Pc8LK2AWjBgd5GfsvR7xr77yxm?=
 =?us-ascii?Q?kCbjZTO2c7wlM7PiYLg/nya2wi7j7qkxLew3brUkUbQU6efEwSXodTqw4G2J?=
 =?us-ascii?Q?K22QOaglIamJ7vjTWYnNwx9Z25JeAydfA/oCc55oAq+dVoe66AnzmhTagk+8?=
 =?us-ascii?Q?MmT506aUWs8gLQ/A7LH1IjR5oulwF0N9mU1PWCj7n0us3rhOA39/Hq5E5uIx?=
 =?us-ascii?Q?OxJypqw32FtItSS03D62dnhybVZHdCnFguns7GW6fRJhHohMfAwa/LtR5fDx?=
 =?us-ascii?Q?zAwbrM5CAqIsxf+HowhwD0sDDtHiH11q0nNFOQ7mkZFxs3MACEy/Q9vbk6jt?=
 =?us-ascii?Q?J62pPR30SaMJNsKSoNTXtHwlFeVKWDqdlwcTG3V5Y1NypSG67dSgVoJtDb7c?=
 =?us-ascii?Q?W6KzA72qtct4Idn81APhE50IjfIVI5VB22UhFVIFMXtLtQfo2O7sitlYNV02?=
 =?us-ascii?Q?S3iBGtsC7VJYRj2FhzeQPVGsCNuZxNDpgpmqKAFk3XOBG9djcN+WP2dmjgBi?=
 =?us-ascii?Q?Li3ydnGo9GQsc5EigQ3CCf05XCV10/Yg9jcBdCy9ItQS4v5Z7W/f9PIvDO4g?=
 =?us-ascii?Q?sBfgv1Bsnzc17rm1kzQ1M8eyqlhSE+wi9JNt3to7QnliLEJqd4DfUzdS1k/S?=
 =?us-ascii?Q?4AzlauSEz2IiONMYvlx8Yb+KcLhXJWaG+GDSU6c79iNC1iHB4+BlGhpaHga2?=
 =?us-ascii?Q?195tIuJnBYOKkv/4dyQ9DoKNYChlMjC8a4nwchBtbl518vttvmonWM8UgwAs?=
 =?us-ascii?Q?ytmIXD51LiJ9tZ4bFYzO8RulF+dDg+nvwoqH71WwS/3HaK/wzB8I9nrD1byH?=
 =?us-ascii?Q?ZR759pj/jyXh6wN8ZZfGX313JhrxGKGi90ShDf/Ob5l4K/2Iw8PG0aS/oLwZ?=
 =?us-ascii?Q?9xVJ4wRJaKeXyY11VhWls9YRxUIkar2/Ccl1dJyVpq8vc+EH8MhrL5N3mekV?=
 =?us-ascii?Q?lC4WnainAEduzD8KLPDRGafFK6L5CkCyvBg4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:58:48.7093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdbdfc85-b895-4d42-b87f-08ddefd2e8fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975

The legacy sysfs EDAC interface has been made obsolete more than a decade
ago through the introduction of a new per-DIMM interface.

The legacy interface however, hasn't been removed till date.

Begin deprecating it so that it can eventually be removed two releases
later.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
Changes in v3:
Patch introduced.
---
 drivers/edac/Kconfig         |  2 +-
 drivers/edac/edac_mc_sysfs.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index b824472208c4..19470f4efee7 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -25,7 +25,7 @@ if EDAC
 
 config EDAC_LEGACY_SYSFS
 	bool "EDAC legacy sysfs"
-	default y
+	default n
 	help
 	  Enable the compatibility sysfs nodes.
 	  Use 'Y' if your edac utilities aren't ported to work with the newer
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 8689631f1905..3840eef942f8 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -144,6 +144,8 @@ struct dev_ch_attribute {
 static ssize_t csrow_ue_count_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%u\n", csrow->ue_count);
@@ -152,6 +154,8 @@ static ssize_t csrow_ue_count_show(struct device *dev,
 static ssize_t csrow_ce_count_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%u\n", csrow->ce_count);
@@ -160,6 +164,8 @@ static ssize_t csrow_ce_count_show(struct device *dev,
 static ssize_t csrow_size_show(struct device *dev,
 			       struct device_attribute *mattr, char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
+
 	struct csrow_info *csrow = to_csrow(dev);
 	int i;
 	u32 nr_pages = 0;
@@ -172,6 +178,8 @@ static ssize_t csrow_size_show(struct device *dev,
 static ssize_t csrow_mem_type_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
@@ -180,6 +188,8 @@ static ssize_t csrow_mem_type_show(struct device *dev,
 static ssize_t csrow_dev_type_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
@@ -189,6 +199,8 @@ static ssize_t csrow_edac_mode_show(struct device *dev,
 				    struct device_attribute *mattr,
 				    char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
@@ -199,6 +211,7 @@ static ssize_t channel_dimm_label_show(struct device *dev,
 				       struct device_attribute *mattr,
 				       char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
 	struct csrow_info *csrow = to_csrow(dev);
 	unsigned int chan = to_channel(mattr);
 	struct rank_info *rank = csrow->channels[chan];
@@ -238,6 +251,7 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 static ssize_t channel_ce_count_show(struct device *dev,
 				     struct device_attribute *mattr, char *data)
 {
+	pr_warn_once("Depcreated interface! Will be removed within two future releases. Please switch to using the new interface!\n");
 	struct csrow_info *csrow = to_csrow(dev);
 	unsigned int chan = to_channel(mattr);
 	struct rank_info *rank = csrow->channels[chan];
-- 
2.43.0



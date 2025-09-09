Return-Path: <linux-edac+bounces-4768-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BC4B505BA
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 20:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002795617FE
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5913570CB;
	Tue,  9 Sep 2025 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dBNKIH2X"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E01DC994;
	Tue,  9 Sep 2025 18:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444322; cv=fail; b=K8Mj9SPuRaUpkYlLVFIfLy5g3MX/2OWzMSsMlhWGYyqgEzXsTexX7Xx1mr1NC//7KwIBufjKJvF2sJv2FPobIceGzw5NXekZAsvac7p6c1Od0mtq9K5B5luyzg4bsrjm9A20sikEdQ+e0KEp/ItgG+4/4jToKUXAyUSXE1xK6Hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444322; c=relaxed/simple;
	bh=EjFIwD4cnTMWdolbnEnAjLJwkRRhOrqyLDmeW9dZkDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BUdaO1Djb+4G2U1wAWFAQBlo0pgtajCfK+hlB6w0CsM70ZMy9IFM+H0mska11nRBuXJwWKBmPPf/ZRq3XYyB6OQifr1JwQ6MKfxqwPK2THT6x5WO0PDqerH2Uzp+xAHrqQJBgX+GVAiQ/YarTj0qPdAMfKm1t9gO9wiVMVl/nW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dBNKIH2X; arc=fail smtp.client-ip=40.107.223.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uWQnsyRedZPaP2J9h5xUgaCNhxWkWZxbG/1G1BdY1MO1mK517Cd9TF7M0dLWDRWDoCWYwD1K1hmuCkyU8fwtcr76P+ooomXm5IiXYjKIjwknLLwhIVZKiEOIq7dzcnTFn1XEBFCiA7WyxMUeontwG6hhfSE0UlvXITbAfxmvz92fM8BKURpHmglNaOtZhVi3JHtUPpoizVKRUDOIp+HPSbn+P9ZjEnxDGGcCCA66/CrxR+uVgFXjmmjwd00PcieyAz0n+Q3lLCxzsh3M3Gp20AAZDNl8Ms50Wot4oHGfyYMrMPQMC/osivNpH2tG1swWOhtoQitXf479K721mzErmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHb2X0NMEtwK6V//n1tawxI0ANFm2XE4SJk/U7CN3WU=;
 b=O9sxWaobEobBEONw8g2tQW8Tz90dedj+3ofaROTjidZxVznisO1nkrjUnldvBCNxcLFQBTCGzcYLsuVKfEH37OJT9Te4XgRM3yHCOb35HBcKbrJsx6K8wws/n/O8nf8RHjzQXCf6RV+DdgDsXnzfOINUR2iwD0nAYzg9GUozyZcYkf1Rxv7BrXoauDYND3DJgLHBG+cvzJRVjRJEF0r1KL3Mi3IN1T9TIC+000K5kJWeMmvwfJJyN2YTTIwvP2A6Sz0McYY0MA5Je0FggOvDDbDaY2Npc0L/ZDi0SeCHadPrGCyU66sP4O6qYTxRW9UF11vGxRNKSbdbuGl70EMvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHb2X0NMEtwK6V//n1tawxI0ANFm2XE4SJk/U7CN3WU=;
 b=dBNKIH2Xj3x1cEBWkQilMy/Zmsi2Hv0f6z1ufXfUwFwKT41TpKRFlBsMu6/1asWjeWO0ycae3lOZdTokrG6N+YJqcimm/RDb62Cl97WtIfwxlOXV2aEayO+a/u6IIPYfqjxhrB4JutwwudQjaUW269S5OjU1UNPk0St3pn4yGKc=
Received: from BN9PR03CA0741.namprd03.prod.outlook.com (2603:10b6:408:110::26)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:58:38 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::54) by BN9PR03CA0741.outlook.office365.com
 (2603:10b6:408:110::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 18:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 18:58:37 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:58:37 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v3 4/5] EDAC/mc_sysfs: Increase legacy channel support to 16
Date: Tue, 9 Sep 2025 18:53:13 +0000
Message-ID: <20250909185748.1621098-5-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: fc87fd2e-2b87-4402-a8ea-08ddefd2e285
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6nD29jBpmsIR9tcRvSiR99eYqNSSOQe+hpFbFE0/sZw6pIE+HR+OEVAjLhg2?=
 =?us-ascii?Q?v5XIRWbLNIdVvB1ZCkOs35wMqndh26OGsBAiVketzQBY1ckKg28+zuXiGX70?=
 =?us-ascii?Q?aipbqhKSdjXz2u5+Bv0StZZCm4DqlVSeoIyzynN7dbsJM1ZwsQ4PtFeXr/T4?=
 =?us-ascii?Q?G/avpORdAqKGs9jmERmjMA1o0L2Sb6QlZX8l/umWrHSLTH4WmaYDiGtRkFNw?=
 =?us-ascii?Q?L3Jj69qXDegp3jD+x/KHi3ns6AKRUNSoXsJn8+pOEcdFyRNnGxT713FAVCZ5?=
 =?us-ascii?Q?uK2EgLvPhPQS+7qfzWSn9YF1LxSWDsy5Kp5xEdI5CMhdt0RbNcjarMqbiIBb?=
 =?us-ascii?Q?Igyh3Y0RTcgMNSul3iSSmy3B3MCUlHTgNBd03gGhFLTByb00LMu11gvj5gzR?=
 =?us-ascii?Q?sQBwDkUuKYdZBRlFXGTYZm71lESeKXpaE1g47u6R083Rx3OtnBDkHWH8BHKU?=
 =?us-ascii?Q?RIiJKxZ5YaaHp3+KhZrBjhse5CGIDjmCqDw8xG/x7kFVlCYgbaK1K09YBSok?=
 =?us-ascii?Q?Rpt6uN9IJXHxFeCfpqsafmKKTNutUBPX0c7tMECBMmeCLir/TFGYSsccljd4?=
 =?us-ascii?Q?+51qySp3vng2uqXm7s8sOgpdXT6baTTg5klCMjT0w2WbVoerdwvU1yoMVlB0?=
 =?us-ascii?Q?8NV0BZwAoLvWl2Ydj+GkVrUOMaPeGEmKIcULbZnhrua8QTZo+bdgY1WUxXIQ?=
 =?us-ascii?Q?O65KagjXYQVljBcfwSBA+EctVryK3k25C8BdPM/BlF/9cAEh7x6HbugNQx4n?=
 =?us-ascii?Q?4aqUMG0b68WSlf7+kovoHgsmO0hp3ABW595LeYYPt8HFK0zcQ8NCqPohIgfq?=
 =?us-ascii?Q?RNad/62+b8BSbhX6KyP1hABO7eAFoIzVtjt8IellnTO2osx2EBXQBWjNJLPO?=
 =?us-ascii?Q?21zIUG5t2D+rNxINya8wwZMQshlPmvoiTz1kXA372eIREJg+antMNr3STCsF?=
 =?us-ascii?Q?eWqkSrb46caePxc6k80yurqaDX/S93xJrnpPg+scwWIyg4xBvh8dTRnMT7mj?=
 =?us-ascii?Q?pRRFRs90duA0773yWg8vc8TVRfS6O8bbSTOhHNAAIFYrpNMRskL2Jv0UEyyA?=
 =?us-ascii?Q?5Uyb4u5HKMdcE3VieP3I2fjBhT7q/5mEgS7e/INI0hQCx+isFpcYpqGHWJRU?=
 =?us-ascii?Q?OyeTILHFbsq1h9qZvdfca75DTHnqIz7dApk96383wrI0GlrpIU2bXMzpxFO8?=
 =?us-ascii?Q?8/W6djubV/00AltFMWYvfITTKOZDDo/ykD9qh1/GzXrpzOutuhp5YQnh7rjo?=
 =?us-ascii?Q?+4aVNA42bwK0dp7hQmJaUFe3oyn1NiYb+8R2qxiW+LUDS//zVkvypUKMvwfV?=
 =?us-ascii?Q?waxqp9pg5LSX7Lk5t8bNU3yVHZoWQcCtMHkF6atvySTRCU6h3zTwVUwZB/qr?=
 =?us-ascii?Q?3NnBMdvWyIuqgrmKM4cg7qrsoYSrtzlpugLFb2hW+ElfdoEd0TatuEb1Ksod?=
 =?us-ascii?Q?IGiRaEu8eh87Sj7V4RcqYd/W5U/OJrYpoXC1R0mh8zkrO2f6KbpN0ChXVca1?=
 =?us-ascii?Q?/F6a9QBojhO5jBq1FmzPx4S+sjJXrVPxKGoW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:58:37.8632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc87fd2e-2b87-4402-a8ea-08ddefd2e285
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105

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
Changes in v2:
Patch introduced.

Changes in v3:
No changes.
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



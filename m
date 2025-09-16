Return-Path: <linux-edac+bounces-4817-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E404FB5A34A
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 22:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B43F83A5C3D
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 20:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551DF31BCAE;
	Tue, 16 Sep 2025 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FM6XSFwa"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81E31BCAD;
	Tue, 16 Sep 2025 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054799; cv=fail; b=L4dRyyVdHDrpDc80ImcoG8OK9xHquW8fIxMiCZ3fqMmPZ8kAp+5uDltCawEGqaB40JuJzo6iDMywJ2AWNm56YCtK0kNL4BEigpX/KVQSjgY6eBZGJRCKSN0zAnbN4OF+KiPLkP45NOO2BqmW0L8yMg6/D7bAhjVkn/A/pomd7vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054799; c=relaxed/simple;
	bh=A6+8nBT8FXOk4z3MFEDQ2CKtMYjWMxhjn6qbsMC9FVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+XZL6/6cGvo06mjlbrwdowJJZjL4kXvPtv8Q2OkB7xP7ONHEpApTbcA5IuGCzc82iUTiL/XL39WKzqI/pfhEgk8i/DYuMzysU1iblWzAxG0ZMw9AwcCCrBJyhigv0XosLeXU3KBjtsbIsLluNrmRFImqgtq+U+2ybWB0P0SB6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FM6XSFwa; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ySF41nlil/dhUaW4XSQZ1UDDHjFAcSqgthHoHPIMoxCnXJyCOzxXsLmcPSLBSwcIENtKfKOIivrWNbmdQfwNapLRmPPyh9w0pTI0iS+dEV23/ko8qStKWt8MohtOGHCT/XXQZHXuy/2sM59tFEndoNDY+5/j8rT4Q31gQyqwGZ6OKWaZ9LHJPltnFEg57nN9zdqvPQ+rHK0TbfORd/KirfMBnxm6jjXwLFTiyyNsSV7Dpo6ret/uIfrIylNAdcsRuiLGi/3JsYs7hx4ICFn/gepB3zVv6MrTmGWPCabte/ix7GyWzfewe9VUfMex0iis6hu3JMqxZUwqR0pHTnmxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wS8FB8GP4sSVEY7WKDK2JgS2QXMDbWSD7TREoUd2iRA=;
 b=nEb6zM4jFGomcI9kze3kf4CBrIU6KKHBhiUutvAHqhZxmnHjB8im5kKHCfq8fBdWGKc5NhII0NC2ss9erwJ1tatqiOpdZTWpMB3iAVjp69YXcqQPexX9bd2YEY0m9X3CiSgja9V6zj1iM+RvvRss+OKPQ0Z4kL8kzQ3Nk94UvR09ACEgmeBvZ2WnHwfGcv1tKMzDorEo8ilULvwSRd5hFqx8PyCl+KZg8ioVNcNKHYIzXUExFj2Vwv0KVe64ka8uNWifcwaLqvwI24itTxjMMj+DRMlFzyKMEIUj+tM2xrT8T12+QE/R3Ju8xMImW2fTBbp9jyaSYbxu47viCUG8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wS8FB8GP4sSVEY7WKDK2JgS2QXMDbWSD7TREoUd2iRA=;
 b=FM6XSFwajZjdjc9tZ7+nD8yPstfZlRbbwCJrBZc57QR1lc5k3KwDdbFgewi6CZYj3J8nbmwMPjrrvFxzIw/A+ChipWMYfrxEX/UOWqJRNglYYPLdywwIv9xEIwg9c7f9NDNnJtbPMeIdjUKXFKp9kE1OO0KUHyggrWcuCRAVdtI=
Received: from SJ0PR03CA0056.namprd03.prod.outlook.com (2603:10b6:a03:33e::31)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 20:33:12 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::1f) by SJ0PR03CA0056.outlook.office365.com
 (2603:10b6:a03:33e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 20:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 20:33:12 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 13:33:11 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadnaik@amd.com>
Subject: [PATCH 2/2] EDAC/mc_sysfs: Increase legacy channel support to 16
Date: Tue, 16 Sep 2025 20:30:17 +0000
Message-ID: <20250916203242.1281036-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916203242.1281036-1-avadhut.naik@amd.com>
References: <20250916203242.1281036-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9b594b-0702-43a3-fed0-08ddf5604190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?861ZSfJr1XWOGrSgCHGv8VzFcgOqT2j5FzQYva3tg2f7MGlyHTVFXcqMrihP?=
 =?us-ascii?Q?Q/QcSBOeF5AtO1TZBFOM1fttWiUjm+rKU4H/0gVLZBLlf/Y1/FjNDgBOweFy?=
 =?us-ascii?Q?b6RP2lK3g0K6dSYd2OZeT7bj/32lFbplTxNqmEVhwfeGJ0RXwtwdNHtNKgfM?=
 =?us-ascii?Q?WG3GdZ5RyDptQ2CSOjA7kZAka0wFBGmhFEtZuhJL6JkjSZ+CrT8Q12jonQH3?=
 =?us-ascii?Q?eU1O7HLaYFSkYO7fQMfrC2frtsFkrox0/hRouflK5J35g/9Dv2MXE3Jed6NL?=
 =?us-ascii?Q?W7K6Z4Ksz+/RVuCVQvwSbXgY13bG0IJeOJU9Qv4+GxrzOApWkLptHszFD16j?=
 =?us-ascii?Q?SoPWLDztDIXggmrYUkQAshWNwuSFlj3Nv8rGBeQchfKMwZvABlYQzWtUK2Ob?=
 =?us-ascii?Q?xFQ2PHb3MgwilKNVe9JwMc0sHTQj6wpXTg/yEBUgyAKB5SAtki5CcilS+6rt?=
 =?us-ascii?Q?+DYHWfhMSD30e6Qnp6yWfiUuJFBOv+evw4oZ6qeNG5fmUKMbVpjsLnAgpkxX?=
 =?us-ascii?Q?mSvUrlMrF68vjj3qS2zbk043z6W8n9/eO0SRLGPRfTs09LgTBa/KO60oavY1?=
 =?us-ascii?Q?Uqzs9De0JcAV1osWAUZDKuUjI0TRQqGfrsBlNzGK+7bB759m7A+On7/XuuDE?=
 =?us-ascii?Q?LNNlAk0zvArLv0fZxP5TEICXojk2OSdeZQYttHabjvpZtnk2FtU3RtDqa8Bx?=
 =?us-ascii?Q?5Ht99cVLzOJP8K8wpmpqUHG7FY2CRTh94Bfor3HHVSqAZo0tXhMEVH3nDA00?=
 =?us-ascii?Q?ItIa27UI0ZoN5dlOlwnbQbbyN+/3QmUqTUOFz/QvcH50vtGvj3xIjnwBvEpF?=
 =?us-ascii?Q?D7/cW2f24jmLUwMAx4jhTk7Zzzzs1HWbdvUj3Xpl5RT3b5vGmMFMkMW0lFH9?=
 =?us-ascii?Q?qZjhidq5WQz4FzLOhlzp+tgF+tL1eIQTF3xDYsLeP4+cl8jon8Lp/eR7qVcb?=
 =?us-ascii?Q?lodKqcziFEzJbi5cdhHkZeA0dQ1hgbCBP9wNMpUlaa4AVVQQ8QUBTvkQ8Goo?=
 =?us-ascii?Q?KqtC8VkXemVXz+/SGbQSpxzLfHjPd+raa+h6qxlUK8gsow5J+0mWYAsZ6d1r?=
 =?us-ascii?Q?qMxmbo1L0cz0trJhFuKeWeo4tAK60RbqFGxrljiizpojOzvmaWM6FJtszO7p?=
 =?us-ascii?Q?vh+rDTJefFjKTDIbvSjdgx339EhxPuV47G8BnyljfPvB59bnLQQnYabsESt9?=
 =?us-ascii?Q?kQ0GmL/cyfI/IMy/JVCpeXqiOzTxGKk0Y6DdGJq1quqMxM6/pNVlcq82hNA9?=
 =?us-ascii?Q?EpnxivDjA3Jh+1maEXx3D5WOhmvEHgFcZP7bbyzhGbBhf0fLyhKXl0045DQe?=
 =?us-ascii?Q?+mz4Ey5BJ1q9JOypQWP0eHzWsLFrvszUMUyBTPhifQud1fGE62hA8vp0gp5u?=
 =?us-ascii?Q?11kfE0PL9AplhocRb9A1DF/kN9QjNUMvquFjzAJGkbHXYGKeGDtzgYZ3NsgB?=
 =?us-ascii?Q?DBI/X3Z0Ep+egtt+RwalNdGDAReH5TqRJ/MTRaQh8iN80KbJQZeI2JyxHWS3?=
 =?us-ascii?Q?ZFM6VFokxJsuHrCnzX+Nk/UIuE7woqS4GCxQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 20:33:12.0823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9b594b-0702-43a3-fed0-08ddf5604190
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779

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

Note: Checkpatch warnings/errors are ignored to maintain coding style.

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



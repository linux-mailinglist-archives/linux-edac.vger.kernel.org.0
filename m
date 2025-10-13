Return-Path: <linux-edac+bounces-5034-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AA87CBD588B
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 644B54E7EB2
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D6C308F07;
	Mon, 13 Oct 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Zh/cZVY"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43B021D596;
	Mon, 13 Oct 2025 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377060; cv=fail; b=F5BgT01sc5TTTU79gdZwlxGAjmyVV/2krHvnbwvQCvvYyZ+TSafkx4GHUJdni51tb3RxEIPZ6CKWH/jqyNgJfPwnzZR1FBARs+samcvK/1unWsZW+PZ7Hgu7p+dhqeeW6p/lFaJCGg9PeNd9dLJHG4XekHp+sNp5LUFu28cXTi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377060; c=relaxed/simple;
	bh=7y+dRSebsWw8gPc0uCb22KSByNDnL1NFRBtT95RlvuQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jk/RQDf8gsN/xY+/WjY7CV2MnkB7WXVqCuSE5pSvAk6K5uLE4d9P40Ob2o6TnEk62Oufb1PEFpr5RC40u4akmp9t3sL4Nj1gWK19AVRBUpVS5OVpynOrwRFfVEL09VLce/UTdz/Jk2wrEZvLuVqquax9XvUME0cgz8j6mivBrNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Zh/cZVY; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lo9MehgGATThZxsXcB/x7KNyr8f6Qxffzde7FVN6DlQvkLuVZN8wALeCbTQtMG8gNzef6FezhObsrEtt5tfG7iqkAFsWE53+Y193cH9pHECbfIWVVI+vNq3tIgpGlwr3mZDFVsRrom71Y2xrJlM1gVeNHXsPHSWiw27h+3HjQ9fdHmkrQxzGUGSnwwEUIHrIWp4Y0YR1Nojip+F3mKEuZgUrb4jp8L0XaG1AudNjq6i3ZBnBqW+7eg4BTAwGeCkAGUuH/tTHcWNr4J9siUs7DHVhYsnN8rn6sqQfOT0Sr4N7a4SaHfH4AWqx2a2CP3912vEFpqii+lk0aRf26esJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptUrY+Ih7/8qPeH1o6ORIgHFbJLt6AhGxN/XRqZEjeA=;
 b=sMca096//iOjNdU+xH9702od88V+py9X1DbXWDPZPsP16ylYyaTXmLHeEne31e5ooOuS7Y14O1spgzWiWJeR8VlFEPGdSJL4vuMpKix2DONPaAQSytwb5Tqq5PuiUFHsXuEnekXHME/GVsyIFABrDcPOVQRS74Ka6ZI8yLPRjmnAHoA7T2zhHBzftFfKsUr/IcQgHHydnNPYor5sei6PCAchoovBI+iw958kuy5Los1p6DjAhUtN8bwUOt/H4BZx1AsOUC+IiBXjArVINAdwGjeL+/L5GJmYyO87srDk8UtGzgffpPb8rcMRsB4LQ6sj8t/Z9w2ygtt0ybY/CEO6Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptUrY+Ih7/8qPeH1o6ORIgHFbJLt6AhGxN/XRqZEjeA=;
 b=3Zh/cZVYCnc9Vbi7CwZnCN7PntIC0mxDqOxngKjiipjQr4oQYfhetT3e5Nakd/FUfESj7UlZ+EkwAe0ME5qX7k2qecqczP0nyNjKisTrceJ57mRoQ8+b/EME4qNmjFfRdp0eRMCj5/BtA/ihhZyL/ZaiLX2sEAtTZb+miboZaQ0=
Received: from CH2PR10CA0019.namprd10.prod.outlook.com (2603:10b6:610:4c::29)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 17:37:33 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::72) by CH2PR10CA0019.outlook.office365.com
 (2603:10b6:610:4c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 17:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 17:37:33 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 10:37:32 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC interface
Date: Mon, 13 Oct 2025 17:30:43 +0000
Message-ID: <20251013173632.1449366-5-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc62663-2622-43a1-b984-08de0a7f3152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4hxG4bzKnPPJPyccBHIRIduwD9QeBBzULQmv6drgCQh6JG5stVQVLk+P4hoo?=
 =?us-ascii?Q?MPu2/BsPTSlIoymsbM4/P4LiJDtPGqhGUJUXjklQTrKA46xjlVpwJ7jcZbLz?=
 =?us-ascii?Q?6gvYhJchZje2ObMuzF4AWtib9kSaTzuxwSHPIK3hn6NQdkB5DfkQAc6EQN7o?=
 =?us-ascii?Q?41OWdYCpxZUMUZUfgaWPFBEdTFDhWgEoS7gFy4/BBg6ZkgPYLUDguazxwtRr?=
 =?us-ascii?Q?g30h99Jqk4nIv0R0wIF8UKKqVbUfTWVv/+CfFHGYN1QrWXS+eAlNzuQCA8yP?=
 =?us-ascii?Q?os+Go84uPLM+y/y7h42URrzLna12tC3tOk3dDcz3nO4wvtlK4yDxBXJlUU8p?=
 =?us-ascii?Q?fQdi9kPetA2Iu+OXnQ1jkIRhBFiCT+2XTEnsHPr/5Mq7u9Yn98J7c22ZvrbU?=
 =?us-ascii?Q?KVKgAD/95fd2psrhcQPUlc18R2TzEtgdAfx7jaZDyFW6tn52B23i8Mjllfg3?=
 =?us-ascii?Q?y/Aj+KYT0cw2rz8WVmrFC1wasOxcbwI0kgZ4jYyTwTpuaK/knZk4PGxcriEr?=
 =?us-ascii?Q?MCUk0DY0nM/7mqRPZjxtaHkfK8caHskVJqqeNR6QhWEuRNwP308wO+uPyLYN?=
 =?us-ascii?Q?XoTB869O4h8+dHHYJyitEh20llMZMiaElL2jzxRQbwfa8axCm3dPQWrtDHsE?=
 =?us-ascii?Q?S36WG/2y5DXy0xpdYMKg7OPbJrJar+vOaiIrZ1XodZoBKkTk3kUWz/R2FbI7?=
 =?us-ascii?Q?nBYv9MSe9QRQtYAQh+v6pMG3HnNS1mAxWqIu4XwKg++UDguUcjkuBX/+13jD?=
 =?us-ascii?Q?fm1y7wcV1+6F4UV0+rC+f2hdfOfmxQbJJYiQS2Jjsa6Dn4DMNhb92YxMwA2m?=
 =?us-ascii?Q?FdBxhGGHUKZj8TETtmumpovl2J69ShYDgBDNVNidk9nDbycDzT/0vUFnOFws?=
 =?us-ascii?Q?4E/kYJbW4cavA8VL0KbtTIbWXvfAPJIUZArpTnHXEGMLJFh3XdsyHdGoIn/j?=
 =?us-ascii?Q?xU1ij9M66r/DHUTT4PooGpLtt6TRdvNtcDdkW0BYqu90PDqLHQ8IsFEkdL4X?=
 =?us-ascii?Q?ZOfjmG7a6buqKOw14oPcNdLjcwN5Q+0DVM8GoFvHWqa8mjmiO2vYPb2gFOaK?=
 =?us-ascii?Q?3aDMy5UC31MyyelWaJLL4WZFDPX98tu3/hZs6qygWsypzR89ueyY0DbpyyCe?=
 =?us-ascii?Q?KCU6Bvcg/l/uO2Gbbs6ooOFMKwv8JwYvqO23xe6+hWrnUodw8hposPolhzrE?=
 =?us-ascii?Q?CYr25VwyFBixNDrzp2f6F/Wt4+FctX5vaWDw7VYD5wGHHf8ij2MHT036gM2p?=
 =?us-ascii?Q?g8TRk/8LzD9SNWgP0g/TCs1Udlmog0l8bOGArAzIyJUGt2BqxR0bgJrt6MCo?=
 =?us-ascii?Q?LmZIOVUtWD8Y9419gGaVMe4NFH2vnQJYQ0cCXcTBBP1+EoLZniqphpjcCeoP?=
 =?us-ascii?Q?iELp6ULaj4HjuYPzwJYfoCFfwAzLa4UqXZw8aS0tJdzja/z9R8yuu7u78H6j?=
 =?us-ascii?Q?6HAiXKkbiQltBTTLpueJN0cOBxdNz1MmyIQXXhN/cNkj1NMxJ5KqviaNffBt?=
 =?us-ascii?Q?LHNFaWdkQbx+cpYQWadCn/JE7W7kH0Is+6XPaMSzvWxWiPp2dhIf2dNT0v3J?=
 =?us-ascii?Q?x0J1N3jrUyMAyuwyHx8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:37:33.7181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc62663-2622-43a1-b984-08de0a7f3152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667

The legacy sysfs EDAC interface has been made obsolete more than a decade
ago through the introduction of a new per-DIMM interface.

The legacy interface however, hasn't been removed till date.

Begin deprecating it so that it can eventually be removed by v6.21.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/Kconfig         |  2 +-
 drivers/edac/edac_mc.h       |  5 +++++
 drivers/edac/edac_mc_sysfs.c | 16 ++++++++++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 39352b9b7a7e..fdfeba848114 100644
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
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..78b49d6906fd 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -95,6 +95,11 @@ do {									\
 
 #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
 
+static inline void deprecate_interface(void)
+{
+	pr_warn_once("NOTICE: The legacy EDAC sysfs interface has been deprecated and will be removed by v6.21. Please switch to the new interface!\n");
+}
+
 /**
  * edac_mc_alloc() - Allocate and partially fill a struct &mem_ctl_info.
  *
diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
index 8689631f1905..8ed4b239b7f1 100644
--- a/drivers/edac/edac_mc_sysfs.c
+++ b/drivers/edac/edac_mc_sysfs.c
@@ -144,6 +144,8 @@ struct dev_ch_attribute {
 static ssize_t csrow_ue_count_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%u\n", csrow->ue_count);
@@ -152,6 +154,8 @@ static ssize_t csrow_ue_count_show(struct device *dev,
 static ssize_t csrow_ce_count_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%u\n", csrow->ce_count);
@@ -160,6 +164,8 @@ static ssize_t csrow_ce_count_show(struct device *dev,
 static ssize_t csrow_size_show(struct device *dev,
 			       struct device_attribute *mattr, char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 	int i;
 	u32 nr_pages = 0;
@@ -172,6 +178,8 @@ static ssize_t csrow_size_show(struct device *dev,
 static ssize_t csrow_mem_type_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%s\n", edac_mem_types[csrow->channels[0]->dimm->mtype]);
@@ -180,6 +188,8 @@ static ssize_t csrow_mem_type_show(struct device *dev,
 static ssize_t csrow_dev_type_show(struct device *dev,
 				   struct device_attribute *mattr, char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%s\n", dev_types[csrow->channels[0]->dimm->dtype]);
@@ -189,6 +199,8 @@ static ssize_t csrow_edac_mode_show(struct device *dev,
 				    struct device_attribute *mattr,
 				    char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 
 	return sysfs_emit(data, "%s\n", edac_caps[csrow->channels[0]->dimm->edac_mode]);
@@ -199,6 +211,8 @@ static ssize_t channel_dimm_label_show(struct device *dev,
 				       struct device_attribute *mattr,
 				       char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 	unsigned int chan = to_channel(mattr);
 	struct rank_info *rank = csrow->channels[chan];
@@ -238,6 +252,8 @@ static ssize_t channel_dimm_label_store(struct device *dev,
 static ssize_t channel_ce_count_show(struct device *dev,
 				     struct device_attribute *mattr, char *data)
 {
+	deprecate_interface();
+
 	struct csrow_info *csrow = to_csrow(dev);
 	unsigned int chan = to_channel(mattr);
 	struct rank_info *rank = csrow->channels[chan];
-- 
2.43.0



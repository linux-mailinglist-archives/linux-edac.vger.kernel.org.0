Return-Path: <linux-edac+bounces-5037-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B659BD5F81
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 21:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E16E18A025B
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0361C2D9EEC;
	Mon, 13 Oct 2025 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Sl3MSCQd"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011026.outbound.protection.outlook.com [40.93.194.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4025783C;
	Mon, 13 Oct 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384280; cv=fail; b=e0lOnbbtdayz6EE/dIpqIBC8Yin/LRX75BB62TheskHs5kFcGy6/CYgA1gWyo5Jn3FZaKB+Rc5bpA09kvSHshuTLbgX78godzyfgZA3dLVbEq1SVeqlrWc1E0hZ9cixQgcTWu60UXzzzbaCdluYnYOsTVonFjN4Hh05Ub8k+zwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384280; c=relaxed/simple;
	bh=ESEKelxi51aq0LV2woM+2k+l1PAw5Qacydc1NZnv4s8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snspgy+lPEdWaxiVzOAWZKTBdi0foGPh5fDRZ2xVq03QOZ/FPx6CqX80fElLH0R2GKv9ibEoJtCWr3lyG6SKajk6Jm84trSkOeO2sGVsZjCnqgNam1bZFQfKMI6XEWbo0oseMTnZ0oQDvbNxGOUtm87uHwtHQbex5TEe3dWgVOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Sl3MSCQd; arc=fail smtp.client-ip=40.93.194.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/B84MNjtOAsS6Jpc32YyMKfKhyH2Irg7eb2LKcNOrzP/GKpRX9aFm+k9f7WLKTKJ9UU+Il5z7+mAFr/frWc2hHxfHZoI0xXt0rXlxAM3CTuGbv/QEsF6akpKUji3+nuhk2sPWLTE7ILL5DOxc17+sYOEAYls/VMG2T1eIAJOxJ2QBRftdL++0wPwXzboupanqwgEMFkutXdAHYsnoj0tneW5WIlLvF4vY2ZOtrutJfiVxumkcIQj5e2Jb3NwRcPr7HpDA8YWrMHjmcwOKUE8n9jpp267wmyTwUBTaKdx/XtVXxfNZ3xNyHRvzjhJ3mm0OICWatVB6Zfaq6rARQMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AwJB9xqAuKuR1d8649BsNj5q2CUFBWw493yJiFtDYU=;
 b=M27joUkPPW2r61CeiJ3HcI4IsXZXMFGKjLpUVaiT3uKJG7hxRikjyodRAR1CkEqxKcJzU2zhZmitQdgl/8frU3EnIxDwc+fV5UXKYKjZlHCtTEGmY/NofptTeDsXHufZ9EKnFS8NTMDI6hyu5cLakN/S5uwpweRX9d8U9IB8Zky/5Z9NsE5V38QX7xq4r+xnXk3HjiGtGarrdKbjgOYyv56PTI5KJSIej+wbOo/z/jDkXWzXdi3A90zEIN1k3eIeJs2CRkWFEevav9NiwrmtC5dAFL1YsvK5ijvfQejXCUu+RFoN6KyhHLF6OvlGsSsTM2X8hyLCqr5wBum608zMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AwJB9xqAuKuR1d8649BsNj5q2CUFBWw493yJiFtDYU=;
 b=Sl3MSCQdpJKy+mFYnWxM3o5JqFlmjM+mz7d+CPUK2/liQtzyaIN5cwH2fBYbkCHaXYhsKdRZ5rO2f5FjZ+eNl1oG9O9ktu1ZEXrsElfvLsSkKNd6mBifzlrxnwBYMxI7uqJtOhiZ5EUheRIl8skOU3eOgq5FBKNIloVrCzmRP1Q=
Received: from MN2PR05CA0010.namprd05.prod.outlook.com (2603:10b6:208:c0::23)
 by IA1PR12MB9531.namprd12.prod.outlook.com (2603:10b6:208:596::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 19:37:56 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:208:c0:cafe::2) by MN2PR05CA0010.outlook.office365.com
 (2603:10b6:208:c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via Frontend Transport; Mon,
 13 Oct 2025 19:37:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 19:37:56 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 12:37:54 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH v3 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
Date: Mon, 13 Oct 2025 19:34:49 +0000
Message-ID: <20251013193726.2221539-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013193726.2221539-1-avadhut.naik@amd.com>
References: <20251013193726.2221539-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|IA1PR12MB9531:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e8d69c3-d006-4407-6dba-08de0a900252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/RFFtf8KzZre9CPQlrbVkCZpm+50lI0ZXb5i4GAye7FC66c5xbcCv3cmf5B?=
 =?us-ascii?Q?NUloiaYG7oSERxIrV4PEVKWX8ApVe1A1LjWeMngUSXymLYenw+HT9bnz95pb?=
 =?us-ascii?Q?YThjsngO7qkyEkN2sFXtK7oobtIgpoWCsMotyHvq4R4k+WLxQe+qGOu7yLy/?=
 =?us-ascii?Q?oeZv3MulBQ8j14dMh6CeBPIoBcMVX/8CeScCsrPI7ra0xwRWgHZHWD3lCQk8?=
 =?us-ascii?Q?9+uk/++XrbwN9G0DHOqepoZnVYvocwrymuTImH72WPq3rqbWeCbN2uqq4cSN?=
 =?us-ascii?Q?MnprxCrDHEsankpJ4ww/wcSMRig7t/K0iRAx1PJHNuqS+ktc/dQDbprcXcyX?=
 =?us-ascii?Q?P34qr9JFYjEZLXcziOkTGVWOEaMihkiZfnWmIb8jvjSbuCCM6quj32W9EAWt?=
 =?us-ascii?Q?orn9UuCNaigVQGVT9d3yWidRXUtd5fDwJj7vb52+1lp3oorTC1veNErnSzBZ?=
 =?us-ascii?Q?F8oQcFyeWQTeM9bfWhF6o928kx5CT6c3vzyq4QUnwxKv9gLBWiUM4rtprkDc?=
 =?us-ascii?Q?Jp/kxVrnoX8Gq0OGgmfNMNvX+rCCw1p76IFr6VbfP+BSl9ougyzCTfvr+uQq?=
 =?us-ascii?Q?xK7x4zYxwAUCBzIV6OOYhihzcTW4CoIvNFeOGlRJolFnQfhXWAo2Z6dT2fzD?=
 =?us-ascii?Q?SFngOssuPzt0TRIMoIhxKYWokKtc/GKY4cAuxYKNvDoXWIaFl/O1qII6vOdx?=
 =?us-ascii?Q?HjzCq1LPpMXQvKWBwFLnhZdSkqNGDSTHyuzyq37S89peO3hgkHK3R9FieqJP?=
 =?us-ascii?Q?kVogzSG4B8vdVEo7i5s2SKqwW5339rfm1PZqqxP9lPdKY2Jtlqvg2c473pUe?=
 =?us-ascii?Q?n32a46g+rR8iRu22d2RiYw9LS+jOXR/qaYVgiwvEuoDdVJUq7Up2Otwq3dGd?=
 =?us-ascii?Q?8H+mMDDoLk6Yh6Twe99nPuiWCrfOYSsXP8yPUjKhWMsyGbOekxrAci5+vBX8?=
 =?us-ascii?Q?HUo02E6QwO0Drq68HOFpI1FVv8r1l61hzKUuJafEFhJRrh4pdPBkBPQHjrm3?=
 =?us-ascii?Q?wxo0Ux1Wc4ZJyHGbJ52RL5S0kqXO2QMcqCiLJPBdhoS+YKPkneIZtOdg7aL+?=
 =?us-ascii?Q?urErP/BRMqXSGY6TeAD9+FhGsvJFGmABcIy5t2Rffu31EM/sHfFQldGm0OV6?=
 =?us-ascii?Q?c+i7Ew1wIhuDgmp5nk4K7TIUIr27P7BXai/2QwcuxbwuVwnz/uMtkSR5Qs3V?=
 =?us-ascii?Q?APmcMIdJhkXNRREZ+ecIlvYQnkXnoyYPzU/YEVvs0a+5reTlAG5q/lh+uZhM?=
 =?us-ascii?Q?xjAocVHUIvMqz0tvM6Q6ipaqhXdpydweP7TcP6QOsZAueV5MTQPzIrDwBtZz?=
 =?us-ascii?Q?Yt8S+8bDCe4PYvBeIby92jkn3kS3FM1zSuU1gbTn3lVw2iz5GUOemwt/cSW0?=
 =?us-ascii?Q?WPnOGTGErJIsLYBjOZXg6e5WU2b41oK5qXksvoq8sF+PWi7vD2gFokuMNqJ9?=
 =?us-ascii?Q?zmMTkkMVwNMFKy47YrRhddvrHgC21mkgeDv5m9vjtTgBpdOuORBk+GQxYRJZ?=
 =?us-ascii?Q?PTOWoKlLCtwWzgrBFME/RLDA4U9ZVlsiyy1p78Dc0PnX3ocJuZ2qG4MMqZxk?=
 =?us-ascii?Q?lmHOLvy++JwQEVVfamM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:37:56.3280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8d69c3-d006-4407-6dba-08de0a900252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9531

Currently, the amd64_edac module provides decoded error data to the EDAC
interface. This data involves the system physical address (PFN + offset).
Furthermore, the UMC normalized address, gathered from MCA error decoding,
is also provided. The DRAM Address on which the error has occurred,
however, is not provided.

Use the new PRM call in the AMD Address Translation Library to gather the
DRAM address of an error. Include this data in the EDAC 'string' so it
is available in the kernel messages and the RAS tracepoint.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Changes in v2:
1. Modify commit message per feedback received.
2. Pass the DRAM Address to edac_mc_handle_error() through "other_detail"
parameter instead of "msg".
3. Replace sprintf call with scnprintf in __log_ecc_error().

Changes in v3:
1. Rebase on top of edac-for-next.
2. Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 23 ++++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f6ab783bf20..856a78175885 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2709,6 +2709,9 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 {
 	enum hw_event_mc_err_type err_type;
 	const char *string;
+	char s[100];
+
+	memset(s, 0, sizeof(s));
 
 	if (ecc_type == 2)
 		err_type = HW_EVENT_ERR_CORRECTED;
@@ -2724,6 +2727,17 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 	switch (err->err_code) {
 	case DECODE_OK:
 		string = "";
+
+		if (err->dram_addr) {
+			scnprintf(s, sizeof(s), "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x Row: 0x%x Column: 0x%x RankMul: 0x%x SubChannel: 0x%x",
+				  err->dram_addr->chip_select,
+				  err->dram_addr->bank_group,
+				  err->dram_addr->bank_addr,
+				  err->dram_addr->row_addr,
+				  err->dram_addr->col_addr,
+				  err->dram_addr->rank_mul,
+				  err->dram_addr->sub_ch);
+		}
 		break;
 	case ERR_NODE:
 		string = "Failed to map error addr to a node";
@@ -2748,7 +2762,7 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 	edac_mc_handle_error(err_type, mci, 1,
 			     err->page, err->offset, err->syndrome,
 			     err->csrow, err->channel, -1,
-			     string, "");
+			     string, s);
 }
 
 static inline void decode_bus_error(int node_id, struct mce *m)
@@ -2808,11 +2822,13 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
+	struct atl_dram_addr dram_addr;
 	struct mem_ctl_info *mci;
 	unsigned long sys_addr;
 	struct amd64_pvt *pvt;
 	struct atl_err a_err;
 	struct err_info err;
+	int ret;
 
 	node_id = fixup_node_id(node_id, m);
 
@@ -2822,6 +2838,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt = mci->pvt_info;
 
+	memset(&dram_addr, 0, sizeof(dram_addr));
 	memset(&err, 0, sizeof(err));
 
 	if (m->status & MCI_STATUS_DEFERRED)
@@ -2853,6 +2870,10 @@ static void decode_umc_error(int node_id, struct mce *m)
 		goto log_error;
 	}
 
+	ret = amd_convert_umc_mca_addr_to_dram_addr(&a_err, &dram_addr);
+	if (!ret)
+		err.dram_addr = &dram_addr;
+
 	error_address_to_page_and_offset(sys_addr, &err);
 
 log_error:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index d70b8a8d0b09..5d82e052746d 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -399,6 +399,7 @@ struct err_info {
 	u16 syndrome;
 	u32 page;
 	u32 offset;
+	struct atl_dram_addr *dram_addr;
 };
 
 static inline u32 get_umc_base(u8 channel)
-- 
2.43.0



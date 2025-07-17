Return-Path: <linux-edac+bounces-4380-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC472B0925B
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 18:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B584E62BD
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B8A2FCFFB;
	Thu, 17 Jul 2025 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BCQ369Ic"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DDE2FCFFE;
	Thu, 17 Jul 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771423; cv=fail; b=B7RbqYv8bT7Z3irDS8BRQkkvHYWa3szjxTvacGQ5tLs+c2b1WClwDdWW4UneOobB/hWdFGkK9PwHFdKUJyl8w6lcCU31/32AFtdaKZPEx4CB2IbS5ZuxLa6wUahdGr/h7UnDHIu6avJeU3r+kJTB98c5eKmzeffX0Ggy+Gx9oSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771423; c=relaxed/simple;
	bh=TcauzZKFoW5SZ0rxFAx/+mge3sn95HX2dbPppFhePr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m14QwV0bB80DQTShzuGd7tVxfnvvN0RVQGizrWxs/pLdqH7zLkML/OHZeOcZc/O8W6M7GtiDB6KdbZfvSSiJ3BDLrtQYbKILDyfkq96pQZgoTURMrLvTGDV1c5trl/Xe8uMD3yXpOe+YV8uJr7Dvl7/v56supDmxreUKeHfqOO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BCQ369Ic; arc=fail smtp.client-ip=40.107.94.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jLsyr62lLOBiTFqSlamXxtvTZAVdFTZ70j3Yr0n3r3j9HugE9Zjs1QUKahay7+RwjITQngYmhYDXwIO2cABy3i6Jl06v9VUj38wHzVR9SUk+Yx+to0tMBky9Gwb48P73YCiNOHRFdo13811RNOYgENQohAlMuiSjh2l3MtswDsqv6IRhgF7RQMkEBLhT3nnKIYqXJp6A8HUZswycBC+8lB8JvmX9jNiXwr4k4IvlMMucz2t8DFYxNyLeusgbvG0/1QzA8fGK5yKooa5wYyFXA3l+E8gj8bVyfLTwjQ+cngoHvMPZCQvFKO95JmH9apxoFFy3XKch2etXnVKV6wKXKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GAcveHOCjuRhirAGXqS08nPqh5sMbrHTXwUhjqqPAw=;
 b=a0rYiePrs+eF4gAamloI70uqwsUu0BZJlVYl3Wxb9Oe0jgYEmsMRKuGksAj1qcxL+JBCKCgw3udvM2NIyJXULcRCmaRR5rAx6A3mSBtCgHuWHuqmaZ0LKnAia7eGjcrbIo+rL6YA/dasANVaN6uSYnw369u2C1EVuReltHDvFMCtPc6LZEZADwQuG0cMCX859iHQfvad7eR4ASwV22kRBa9k8uvILHxM7WNOon2v6wss3EWsNGNsa5nJxjT205BctLjarbuwvYzgk8FLfxSR7Q/CIJT4/mMCUrNToYbnN/XpbfRL551ZzrQqVz2AYF2WiYA3mhrF7Jv6BMyFbj+vNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GAcveHOCjuRhirAGXqS08nPqh5sMbrHTXwUhjqqPAw=;
 b=BCQ369IcYJUHbkBXxA3MBoMZMbAXzXBlmKFWzyjT7CHDTpwKd2Ea5cBHdfrun1HBa0McRYV6Hywf3u/DF+aXQ2OWMcRRzdgxV7/tQJo5r12v58PaESgBpYb1azkgKkTqfrav/uEZ4f1BuMSNq2LvcJ0RJwGQZzk8U/yrYgfXOPc=
Received: from SA9PR13CA0060.namprd13.prod.outlook.com (2603:10b6:806:22::35)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 16:56:56 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::9e) by SA9PR13CA0060.outlook.office365.com
 (2603:10b6:806:22::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Thu,
 17 Jul 2025 16:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 16:56:56 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Jul 2025 11:56:55 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH 2/2] EDAC/amd64: Incorporate DRAM Address in EDAC message
Date: Thu, 17 Jul 2025 16:48:43 +0000
Message-ID: <20250717165622.1162091-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717165622.1162091-1-avadhut.naik@amd.com>
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: de46ce48-23b3-42a7-a23d-08ddc552f060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/iKRLZbIpWp5BToUbWHof7vJPv2EFnGeoXoMWwL62stBMv9IIBmLt2vZlgG?=
 =?us-ascii?Q?UKXL22Fngtk3LDH/mC0stWb1XuCF2Xg7fNCGinj/ldMwlhEiRECh3WJ39Sq2?=
 =?us-ascii?Q?nljNmg81QA4w6x4ONXLroWngSjAT3PzGlkWML7TRkCz23hNtiCutpzGBq2Pf?=
 =?us-ascii?Q?hBPrZ5tf75gcmxDaw2O9x3IZiF1EKuLJZxgYm9GlwPYknb2Wc8CoKFxfcmYd?=
 =?us-ascii?Q?CP8OWSrzepMAh/58Mx+KpbCHb/hb8wvA4DHqEt8UOmqjt4Pv/iC7IUSiKdJt?=
 =?us-ascii?Q?3eSHPh/Zsa07QNh1P3NpfVTGfMPlTbykLcdzkSDxs505Ekn68QdjLoPY6lCm?=
 =?us-ascii?Q?7CpvtzV4TOYYHsfgjBe+VDkclkbCL0jsYzTI7uXn1F1fZiOUu8r1iZANcAcc?=
 =?us-ascii?Q?n5TDqHMj89VTuhTsaPJBtTSw4JsFp975Hp53royVg87afD2DwclqMv0ArIJY?=
 =?us-ascii?Q?XHb8QmnR/VPBA9+h8FFrxQNSC96hDAEh1WzfVTKP5cUTaJSGnR4tHqrIHxfH?=
 =?us-ascii?Q?UA7my8jUPlK4icrB/1C1jFGrhvvdq20EUbbMk45MjBsaLYOkoxBhZZwWv+kE?=
 =?us-ascii?Q?HCvXenl16KcdBUV+pC+io0saibltcRBBYIRbfoMc9z7xWfBTTo72aPCx51Z2?=
 =?us-ascii?Q?EyQ31/GPvxKEEVyFTwSTEBJUpJLXfYY5QQEiN1DY24HU8q2Ytxggb4Tlt1th?=
 =?us-ascii?Q?NmI2HN40ZMSWJ+OadY4exlSrl4zBi478eTUORJgJc8VbV9unHc/a4mqxelax?=
 =?us-ascii?Q?HGM6HVb661mjklhmRg2LbQBXUoLCBTo/X04hzgeO12zCZpTRhpOiQJU6D4n2?=
 =?us-ascii?Q?MCAP1pxJZqXJ9X3VtmMaRkWrJ3lUF5hXnRztQHnahby+de6Wh0+oGNcBD35I?=
 =?us-ascii?Q?51BGu+Ujlov8ALEtSDF5WB+CUNf1cDWOJhm9VcpoyPfRtV7gZ77wZFkdSmOR?=
 =?us-ascii?Q?CMq8KVayDdI0ksPaVwAMKQ2P1S3fLGGyra9LOCjeUV+RiTyyluWBem1rf15c?=
 =?us-ascii?Q?EbU++0ErrKTq4UceYBEYyxlnRtq/DyCQg2PCJOeA+nIiE/THifFT0ZAS/CWA?=
 =?us-ascii?Q?Vc59yLj0DdQsBCzyTjzV1lhklEMZvHRCYmEJlyBKLdStEU2lN4MH281JE0GH?=
 =?us-ascii?Q?xcv85hdzlJxUt9LxWibeNwvGDbgNAHIN9EEVAsplstbiwfenfI7d39rqmP/z?=
 =?us-ascii?Q?zclMCacSVeqm2iIyJlneXkVBIIKHD4eAC2PwpqDuqCs25/X6W6k+B9WBe27v?=
 =?us-ascii?Q?X0ydHxr8lUkPrE6jWPr1gPYfgO9+PahVsp5ZDbcJiSuXdrkWj4WwzXrbXeQg?=
 =?us-ascii?Q?7n9alcKZkD90+zv9NyYTJctO7Ve2tU13YILYGZ6Bk01BwtnnNkuzgkq6pCgs?=
 =?us-ascii?Q?kockhy7VhDS3dVnQfnClbgjlRVF6jh/iMieyqqaFHD157nnMA2/oQwLCncEn?=
 =?us-ascii?Q?AaSh2vGoCV/mMctx0T6342U6v+gvyy1ZEoafBFfA6fnGhwmL1F+kAL/M2Xno?=
 =?us-ascii?Q?9fleqn7uZzzOyAm0nV7o4uqiKDRK4f1R2gKz?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:56.6675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de46ce48-23b3-42a7-a23d-08ddc552f060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101

Currently, the amd64_edac module only provides UMC normalized and system
physical address when a DRAM ECC error occurs. DRAM Address on which the
error has occurred is not provided since the support required to translate
the normalized address into DRAM address has not yet been implemented.

This support however, has now been implemented through an earlier patch
(RAS/AMD/ATL: Translate UMC normalized address to DRAM address using PRM)
and DRAM address, which provides additional debugging information relating
to the error received, can now be logged by the module.

Add the required support to log DRAM address on which the error has been
received in dmesg and through the RAS tracepoint.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 23 +++++++++++++++++++++++
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 07f1e9dc1ca7..36b46cd81bb2 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2724,6 +2724,22 @@ static void __log_ecc_error(struct mem_ctl_info *mci, struct err_info *err,
 	switch (err->err_code) {
 	case DECODE_OK:
 		string = "";
+		if (err->dram_addr) {
+			char s[100];
+
+			memset(s, 0, 100);
+			sprintf(s, "Cs: 0x%x Bank Grp: 0x%x Bank Addr: 0x%x"
+					   " Row: 0x%x Column: 0x%x"
+					   " RankMul: 0x%x SubChannel: 0x%x",
+					   err->dram_addr->chip_select,
+					   err->dram_addr->bank_group,
+					   err->dram_addr->bank_addr,
+					   err->dram_addr->row_addr,
+					   err->dram_addr->col_addr,
+					   err->dram_addr->rank_mul,
+					   err->dram_addr->sub_ch);
+			string = s;
+		}
 		break;
 	case ERR_NODE:
 		string = "Failed to map error addr to a node";
@@ -2808,11 +2824,13 @@ static void umc_get_err_info(struct mce *m, struct err_info *err)
 static void decode_umc_error(int node_id, struct mce *m)
 {
 	u8 ecc_type = (m->status >> 45) & 0x3;
+	struct dram_addr dram_addr;
 	struct mem_ctl_info *mci;
 	unsigned long sys_addr;
 	struct amd64_pvt *pvt;
 	struct atl_err a_err;
 	struct err_info err;
+	int ret;
 
 	node_id = fixup_node_id(node_id, m);
 
@@ -2822,6 +2840,7 @@ static void decode_umc_error(int node_id, struct mce *m)
 
 	pvt = mci->pvt_info;
 
+	memset(&dram_addr, 0, sizeof(dram_addr));
 	memset(&err, 0, sizeof(err));
 
 	if (m->status & MCI_STATUS_DEFERRED)
@@ -2853,6 +2872,10 @@ static void decode_umc_error(int node_id, struct mce *m)
 		goto log_error;
 	}
 
+	ret = amd_convert_umc_mca_addr_to_dram_addr(&a_err, &dram_addr);
+	if (!ret)
+		err.dram_addr = &dram_addr;
+
 	error_address_to_page_and_offset(sys_addr, &err);
 
 log_error:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 17228d07de4c..88b0b8425ab3 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -399,6 +399,7 @@ struct err_info {
 	u16 syndrome;
 	u32 page;
 	u32 offset;
+	struct dram_addr *dram_addr;
 };
 
 static inline u32 get_umc_base(u8 channel)
-- 
2.43.0



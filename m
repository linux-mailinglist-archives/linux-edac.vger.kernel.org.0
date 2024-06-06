Return-Path: <linux-edac+bounces-1228-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A58FF5EE
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 22:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBBA1C2227A
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 20:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8D196449;
	Thu,  6 Jun 2024 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bw1VoJDB"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17DD13AD0D;
	Thu,  6 Jun 2024 20:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717706021; cv=fail; b=YtJ5kOtrvJmZqFlI1WEYBKkiiiVwoaTDMxV3riZPXmmE5/oF/zvTaoyDopHpfoJRzymTDTSV1ZC1eYs/FkF8PU9fGcmGldfo27Mu4pK5ZilPOQpJ0F2A9IhOcMUKJFVOkowrw3wdh9H4LUiPYbwo3gyPTMLXJWrCuT7Z6QlKCy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717706021; c=relaxed/simple;
	bh=F9BLyAPpcE93fn+yA2tHvc6zwKzZ0sKBcsqryUr/O1I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kVuBFsLzgnZBQQu7ViYku5IITPHLzwwYa5Y89n7zTKCdYJ4jeaA3uS1tTdVgOgwHMetGlAMEKGHQj0EwVvNiRsWuIEa46oNeC+qf6NVovRWI8OrpwXkBWbpOArlTggH982SrTTAvx/YqzMwTyYbyfQAKpUo32YJ5TFSMggjS9FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bw1VoJDB; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LJkj9NhqG4/RVyEydRImpZiRpHNsRZZw6V65JJx8SJGWQzFWpJJORmlDSZh1+OXMCoEl+QPhtCRiOQnzqW4dIi05/jzSexC8X0uuem2xM9Fcqn+Z1XKVJAmQzTjwH2KKV28JF4mKC5ocz+88NK/fI1TaUd0S1J8TyQp1pUN6RmDJChI6H+4QkrfO82yRcbfFuTvyATEjUDfctvnIWVphWsdd2Uy3lj5bOBpp5uBTWPSud2eZ95E0aD365GMcQYdn6PKzTTWp2JiZmtMyEYJK1t/iMYOF56DJuj2IFBSGQIMagO/s1+d7Rf7kJ40t/eCuwJsz+SpxdC3YjUnt7tqTiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFd4CfqyV16VobCWQPmql8AMl0s5DsG0FP6euJZ1EDI=;
 b=YgkcXn3pt9/5WbmRKfYlJAo8X49W1pipmDFKzNeSicvlCvLfuVtfx1rjBy35cvh471ss1I4e0zYk6iULItbixgUn4QLML8iF1689NlrcCRkz3hqobQqd3XpWmbE3K1A49AtxxEdPtf/XA4mXHPT9lxWf++DCERJj4oQMn77LxGtDsgsszokmbLvn7hZeLMoFWuJWz7KOZy1R0C/wNRK+8yT0W0AdRbF+lxPB+c4DHmao19H48P7UVmxWvHK0wwn1MEcUsLkXJAHnegp1P+FfrZFqiuDz6D9GmXx5BBC8G4VZ+PoRwYHc+soILqhK7h1tV+ay6eKXB0XY7HL4YJaXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFd4CfqyV16VobCWQPmql8AMl0s5DsG0FP6euJZ1EDI=;
 b=bw1VoJDB94MvzGWB3oFJ+JcGpHwVORgel+OGFWAebO89cTBCp9nw/HRkD1zaQV0fD/xE7ZnxN4SMQ7sdZ3FNiXB1yIt/Hh7R7aAF2OJsrSBsMHS1Fmf/GmSbz7k7qMEyJB6Z3VlxxmJyg1Osl6u02rBa9XkxRAHATHvLnZ0k2ks=
Received: from CH0PR04CA0012.namprd04.prod.outlook.com (2603:10b6:610:76::17)
 by DS0PR12MB9399.namprd12.prod.outlook.com (2603:10b6:8:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 20:33:37 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::95) by CH0PR04CA0012.outlook.office365.com
 (2603:10b6:610:76::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 20:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 20:33:37 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 15:33:36 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v5 1/6] RAS/AMD/ATL: Add amd_atl pr_fmt prefix
Date: Thu, 6 Jun 2024 20:33:08 +0000
Message-ID: <20240606203313.51197-2-john.allen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240606203313.51197-1-john.allen@amd.com>
References: <20240606203313.51197-1-john.allen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|DS0PR12MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebdcbfe-c4bc-4d86-c052-08dc8667f183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1X9Va1DKjd8ASdxmX4qNZy++A9Ev/2xeySmAjHKysRISTKJZkLiBh21i0mH?=
 =?us-ascii?Q?FREVhsOLAITRLDTX929UmSg584b5iRb/D4ovt7JHasmyGf3JxyK+PuEQ2yTe?=
 =?us-ascii?Q?OGDxkCQRMgdozPIP1kXrq/A8FfprdotnjTftReqneVdR1kyg3V+X0PexNFVN?=
 =?us-ascii?Q?FgA+O4E8zPKHuTxVGenN9P5s7rxNCjcoY2MH8rLF+4arVqUIbxLpPNIMni7d?=
 =?us-ascii?Q?beqggKf4qexkLGEoERaNVQZ6xpIlpQBVoFmpmLHYZVDf7i+RLfFWarO4cm4k?=
 =?us-ascii?Q?UZF8NZD1PZssx2wpNv8iy1henUnF3vCX4bOm2UnhWrt7ZuscpiuskPPkjFzI?=
 =?us-ascii?Q?Jg+98qYP4eGvm2IXucPMtnmeWU6wKJGG8yI2PfWwjgn+sy8Bv+lHXiw6hsZI?=
 =?us-ascii?Q?OMvS2re7kFmWi4mKjkPFKOeuuvNrFIXaDNA4hGFUdCCwyJVf5Jfyqva4o/WD?=
 =?us-ascii?Q?37P3gaiVVIvOKYYPNvCX+RCKJK2jtvjYtkOZE6Ioy1SNXbdU+DnXkHLjU6gH?=
 =?us-ascii?Q?LAMGh0azO4v99dweFKc1LICsGtuoqUjeIE3FUjq5PrRtmTIReT/SL/CcIALY?=
 =?us-ascii?Q?LuDu6FHp6kXhLslEU6EH0S3pW3yZisAlrbsK7u/q0xoLSOPvLGqomSLCNGse?=
 =?us-ascii?Q?7Nr1w8nHXnBVdwnYEUKs7PGzEFd2rePDsxFJqbHzPRcyDMeXTgnaVDkncVty?=
 =?us-ascii?Q?bt+dILfEA8/V/MtACGCbF6NqGklw2SyRLKcEGegO25LJfuRE1GUR1WH87hiN?=
 =?us-ascii?Q?nkzQRrmyYE5q7BqkCRp/pvZy+TnC64iTt9FT9RFpfw53F61hjcBUkDn6Qc2x?=
 =?us-ascii?Q?9zxufCeNmhg/Q79SKAuBFn1NIeAA0klL39OH2B9Er9EMF6n6Mydra27J9JOP?=
 =?us-ascii?Q?y4buuZGSqZxylB6ArTNyMvzogZHtphKYrNakpMHsYR1PVd6Qnwbc0znFGLgx?=
 =?us-ascii?Q?B7UI/Xg+eFELrODqe3TiXrgAT6L4ZSQIVefWIJKTj9ifsFSHmqwawsvUFhOn?=
 =?us-ascii?Q?7czoxGrcbpd2DJd5nwbROdzOq+K978Xbkz/Y7HRXWNZ5pR+nzzol6rBDT+pd?=
 =?us-ascii?Q?2RepG/78sJnj5oNDSTHun/cyZGSn5EIHf2M6N8If/CB90GutrV1dl4b7Mg/z?=
 =?us-ascii?Q?Fxe3tYk3hdZ6Mnb6aqp0toJnhd38QZ6e4/Ti404SG7YYQ+sxcpuMB0eX8lA9?=
 =?us-ascii?Q?Ty0y+QWXT4AJZ0wNE6IMt9hhxNLHL3gsVRRoEWZC5dSyctJrdasVFZMaLf4/?=
 =?us-ascii?Q?QYEuDJgyGn+kBUiagXx2gqxBoCySWjuJMDLZkLcNA5rO9AHxuCQo7jR1Arqq?=
 =?us-ascii?Q?Y652iMItmJjF4e5qbNIEEUJJakEJQGVhYvG2Ct1kirLZnCgQneYK/8dxPLb2?=
 =?us-ascii?Q?bPkjO+9/TWD+ILhqLLQjq5J51o9mhqG2bG6o6UdO/eu9EH8+qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 20:33:37.0683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebdcbfe-c4bc-4d86-c052-08dc8667f183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9399

Prefix all AMD ATL pr_* statements with "amd_atl:".

Signed-off-by: John Allen <john.allen@amd.com>
---
v5:
  - New in v5.
---
 drivers/ras/amd/atl/internal.h | 3 +++
 drivers/ras/amd/atl/system.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 5de69e0bb0f9..cb0f96040fbd 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -21,6 +21,9 @@
 
 #include "reg_fields.h"
 
+#undef pr_fmt
+#define pr_fmt(fmt) "amd_atl: " fmt
+
 /* Maximum possible number of Coherent Stations within a single Data Fabric. */
 #define MAX_COH_ST_CHANNELS		32
 
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 701349e84942..248ea493b841 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -273,7 +273,7 @@ static void dump_df_cfg(void)
 int get_df_system_info(void)
 {
 	if (determine_df_rev()) {
-		pr_warn("amd_atl: Failed to determine DF Revision");
+		pr_warn("Failed to determine DF Revision");
 		df_cfg.rev = UNKNOWN;
 		return -EINVAL;
 	}
-- 
2.34.1



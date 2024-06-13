Return-Path: <linux-edac+bounces-1274-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513F4906338
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 06:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF686284096
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2024 04:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F281913667E;
	Thu, 13 Jun 2024 04:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBWV4ubW"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4722B135A69;
	Thu, 13 Jun 2024 04:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254763; cv=fail; b=OZslkq5VHFZQugOeqJ50ZxH71uZwC7+0z/p7G1wutcyA3NcGItUkJI1E6wzUbDB5jaYj+EukHcBix+vGIQjiDYzG9zV6DXP+hwigbZtZ2DILoSUrGjcGr3i+k0RFoAm9Vqp/amQbMcSUG9lnXeSto8/y6jGkdwunbh8aA0bD7f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254763; c=relaxed/simple;
	bh=XoN9CXeol2rx52dN9ztCwSiLtX8+fJqpYJtrHv55UNc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GwSDZFyAAfJgILriDrzdoseO9NDYKcLUCMZjChkaHdNuCp7ns8VeA564oDAQu5Y+V+clOlCciSwtW9ak9gapJQWH6Ds4Qh4wy6DkxSVj4VpcbYcFtHW3zWcBksLTjQUPUZC6papKOqtDLOMQzDCvT+Y86V1iE2UZWtZbljdIxEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBWV4ubW; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a41nVllb8Y01RGiJZ05mb7+8EMdSb7XR15ZmAmmoj/KmP/3XX48b3VlJI9qxLrTNMQy+qVbkJsG7rpm030CKyCG8e6uGk6lbnc5sZfsuaE84zxvzaKwLF0Fgz9lyZ2nYrOfaUbMJAuRu6E4iO5nLnza+ztWCv/pRZQ95/MHakpG52ZAVelipLIR6Ah8jIdYqYtQ+JMr9fnNDnFMaDpaOXCoxFuuH8tOODMBsVaoDUGXPDtaFpAymtN82Lw1vY9j0ccZ90kfDdi7H6s9my4asFWL7bHinFSbtAQ3fwEP2m9ys464pMzOoznD/OYHIpFnv/g31tgm2QQ0V08NDgRUeyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn0Vw+VVG5NcRrP2Kauy1dnyOtIhM/7tjF8xZY+zXcc=;
 b=FAiL27Nd0kjFoscP2YzZQffYe08H+f67zVGNZZonq7F+lQ7uRsGL3RXf6nZBNYX90sWq83bUjoBBEhscp731/0wVlYWHEg3oNxRXfifHn0ogCcgTHimYVoirPxdFSX/4rFXfhQV6MhW4+AzNy1bLaxS3I36xyZw/TYmDitlEpHJXJIyvmICYR4yU1cMntTRss7GSgxXllEcUwaJvXkxyO1kS6lAqWWzjCEBr/0NitpVQeLuqjfvF81WaM42de7EpPeubpcGQ5qyJCvLROGgEWE+mNtCjB3zJHvp0awvvhZL4Zd844CuTNkX6/GVgbrLJUrV48cQpR8fqeM9WWW/ptw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=alien8.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn0Vw+VVG5NcRrP2Kauy1dnyOtIhM/7tjF8xZY+zXcc=;
 b=IBWV4ubWnPCgl/I7Kapr9eAt2gr6j0cdjbGuilNg05DmREIZtTi0J0l7NlbDsJkaoKne2NykpKM96QGHPv4ohnj+791ZcDBqtjW89/eQgL/pTqJTzxXkhpeQCsNKcC+8axPsKJuto6LhecFlajsbwwPg6dJ2mkH8lryRVBwnDuW7NQyD1B3iFBgp+9PHQjTEy0HTmNhVs7aoulwltUO/NemOX6gh2peu5JfMQAVHJvN0HNmDlLPDOYlTSiteLFdTdHK744jBjugPkhfbQLXwiu1lEq7Cy3+A7NqZY7WcyRaJV3d+ZUJ99FZHiEmrRioFr9hoUYRx7w1/R647FBZFcA==
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21; Thu, 13 Jun
 2024 04:59:19 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::6a) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Thu, 13 Jun 2024 04:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 04:59:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 21:59:10 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Jun
 2024 21:59:10 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 12 Jun
 2024 21:59:08 -0700
From: David Thompson <davthompson@nvidia.com>
To: <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
CC: <shravankr@nvidia.com>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: [PATCH v2 2/2] EDAC/bluefield: fix prefix for GET_DIMM_INFO defines
Date: Thu, 13 Jun 2024 00:59:02 -0400
Message-ID: <20240613045902.12029-3-davthompson@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20240613045902.12029-1-davthompson@nvidia.com>
References: <20240613045902.12029-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SJ1PR12MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: 00615c23-b931-42f9-1bcf-08dc8b659486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230034|376008|1800799018|82310400020|36860700007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bfpZN32F2dhfYj0DUGPgOEhhdECJba5UtFDS0bxmDkNnfuDgxLgpy/36e0gL?=
 =?us-ascii?Q?KzsRu5udhlHnQq1vXu6S90dgjoRIgU1zA1dmoVAqeQmUFBFRiocLRy8uhjD5?=
 =?us-ascii?Q?ZgLSsganzYmGdEsRk52DrIUVaKYyy/yPqTcletC78qCSQ1ZGbd2jMBlms5U6?=
 =?us-ascii?Q?vl5ZxxTxaPgP8oEIFWPzuvmb8aEF9RlueZ+lc/qzXfGxduejqRLNMgGpKuym?=
 =?us-ascii?Q?mJhZkOUNCeoVFHBy4im99DDQidM3sy2JBlScWEdht8qM1fupg7lv+CpYICH/?=
 =?us-ascii?Q?MfLsN9OQ2I0ZArxEpWEVc8qdkiJ6STsMiFwW8/kLFLS1RSeumtgUAI950meF?=
 =?us-ascii?Q?Zyq1BDpOkhMrheUX/rzk8kHB0csA2c89ZBvPzV7xuyxcuNCOlUlOP8hqcbt9?=
 =?us-ascii?Q?PQ/t6k5LSGf/SA2qPFFIs7kZQFshonGYQbTDPwaHq4x/JTl8JcIgtwBGG7jz?=
 =?us-ascii?Q?Jkau956LJN7rKl/kBnNXg3bAosOtzoxyS3XMqKLRWxxXpnhp5/wsKeDqeoxO?=
 =?us-ascii?Q?5/BCEMMRgbgFc568SF4mgZoTawP5zyR8bgh2iC112jq5AyrVXnB1zxW8Sed5?=
 =?us-ascii?Q?CDyNZt3rH4n/SK3iXxTyDeZd5iaIOBVJnO1890lPXCLiUtOwmeapvzyvkKXe?=
 =?us-ascii?Q?pCgqXR0pQBLN/I7Aqa5IIrO5ZIs7EIn9YUiB5PJcKawhml4CsgYgRAkmPIiy?=
 =?us-ascii?Q?1+18K4pclaphkg4+lBshsaVYmDSlh+ZqZcf8p4dzXB9ehtCAnLO/7kXz0x7b?=
 =?us-ascii?Q?GSbs8LnSMzdLpSygmX/Y8Gp99zaQLtwD/dmorFHXZboc3bi7VP+B4gzQp3hQ?=
 =?us-ascii?Q?v+F9ll5nhwHPwqXwWjbSM/nf8k6YH6TRHMBaj+xEvj2jJh5xJjVlm07+SLMx?=
 =?us-ascii?Q?r01C9fwjobS3MSBLGk6LIEeDDnjxy0MJYW5u5iKBE+WiSvs/YqsHu1enlSAt?=
 =?us-ascii?Q?EJpNuzZahXQR7Z5WyFzdx3hdOvZu8ErambpY+jmyOSzlIS0U7VlzuGDG3gXi?=
 =?us-ascii?Q?nUzkLofaASvThkTSlUnc+jb972qQBkDyeXKWuqbYIbcjHwDLolt0dUbTsEJz?=
 =?us-ascii?Q?hlj54myJhbeuw/9sEMbn/HSD/YhDlfLP6/HoDNr8COy+6t0SisYpbbSpx5Td?=
 =?us-ascii?Q?/q/8FChlGEYr21cO/R3mMVYTRSWgngFJjZuTrit1X5FDo1NC5kPyMF+5jKnH?=
 =?us-ascii?Q?9BvGO6o+vLOa9LFTctdqb7XUsg/jx5bNBiLjmzvwDUqn7RVWxHpMKOIEdTo4?=
 =?us-ascii?Q?0NMJ1Dg15+6nO0xJUU6ad1/Vn2SW7sS4svMKnnRizMo4E9bTR85bOGEHBHBN?=
 =?us-ascii?Q?K/OCNlDrXBE7ditYVkMwWZRNsocvReYztAtB5EkgLLJMfqedE+V1XZqD7iui?=
 =?us-ascii?Q?VHDJhdoQxuWrhiFfHZIerLqD9a4h6LV2j9C/E4PdoIvHfeguZw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230034)(376008)(1800799018)(82310400020)(36860700007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 04:59:17.7979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00615c23-b931-42f9-1bcf-08dc8b659486
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340

The GET_DIMM_INFO defines used by the driver have an "MLNX_" prefix.
This prefix does not align with the other #defines in the driver,
which use an "MLXBF_" prefix.  The driver must be consistent in its
prefix usage, so align them to use "MLXBF_" prefix.

Signed-off-by: David Thompson <davthompson@nvidia.com>
Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
---
v2
- Updated commit message per review comments
---
 drivers/edac/bluefield_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
index 1f6f39a7dbf3..8f1cc029606f 100644
--- a/drivers/edac/bluefield_edac.c
+++ b/drivers/edac/bluefield_edac.c
@@ -48,12 +48,12 @@
 #define MLXBF_EDAC_ERROR_GRAIN		8
 
 /*
- * Request MLNX_SIP_GET_DIMM_INFO
+ * Request MLXBF_SIP_GET_DIMM_INFO
  *
  * Retrieve information about DIMM on a certain slot.
  *
  * Call register usage:
- * a0: MLNX_SIP_GET_DIMM_INFO
+ * a0: MLXBF_SIP_GET_DIMM_INFO
  * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
  * a2-7: not used.
  *
@@ -61,7 +61,7 @@
  * a0: MLXBF_DIMM_INFO defined below describing the DIMM.
  * a1-3: not used.
  */
-#define MLNX_SIP_GET_DIMM_INFO		0x82000008
+#define MLXBF_SIP_GET_DIMM_INFO		0x82000008
 
 /* Format for the SMC response about the memory information */
 #define MLXBF_DIMM_INFO__SIZE_GB GENMASK_ULL(15, 0)
@@ -189,7 +189,7 @@ static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
 		dimm = mci->dimms[i];
 
 		smc_arg = mem_ctrl_idx << 16 | i;
-		smc_info = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg);
+		smc_info = smc_call1(MLXBF_SIP_GET_DIMM_INFO, smc_arg);
 
 		if (!FIELD_GET(MLXBF_DIMM_INFO__SIZE_GB, smc_info)) {
 			dimm->mtype = MEM_EMPTY;
-- 
2.30.1



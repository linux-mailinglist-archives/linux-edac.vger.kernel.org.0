Return-Path: <linux-edac+bounces-4012-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D74AC626A
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 08:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775AF18928F1
	for <lists+linux-edac@lfdr.de>; Wed, 28 May 2025 06:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B552E212B0C;
	Wed, 28 May 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f2AuFdB6"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143CC206F23;
	Wed, 28 May 2025 06:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415421; cv=fail; b=Fy8PRzs17BhXjupK0zLaq66ha0+PlOIt9jpp1K3+CHCrTpvU5uDYjtCzacppcJTumGIn2S/gPyEHyariiX/U8L+65UIGm6yWfzBDt4C29UCwnpa/KQXh2x0VpIBRmcMnxu9dcWsRtZwkZgz4//AAv35Z0YX1NgXlfk5wi3xlwMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415421; c=relaxed/simple;
	bh=plG3+h3RGYJSA+BFgPhp2U5XAVcq7vSWhGwegmFHNX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TAHppNDYVBd6jgtsg5gwSH3F0nEkxWvYMGOMEnHNnYajiFR+RBtgPTm8ks9t0sC8PIi7wWLCezs5Y7fu8fgazaXNUSW0Nbq+tWyIj9ibOkBw1hHsTIa5Je78x0HZ7po+c8uE3boaEtlMc0tUOUUvFlom61WwMY+6TCu2W+ziaG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2AuFdB6; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRhrdhNNlPihm9KaE/2MjRWNxTx90S++piOBt04zyQlAflkDdxlgCSuitpmiTc0kqb9/QG4Drx/j+6jDRYkIkBpS3eDiPlyIuvZCf4viAQ4Y/3P5eiX7eSmUBx1WbcVBxXsX66TwwXgiYP3st078yhtf344C4YZKJU4WedAuxHEHf9NbS3VJi0CgKTfBMWDgyEiYzI39WK7E1koRZ/25jM157WOL3p9zZhRGO5ZdS1fmlTTJE3I2RW+zaBxZVtydx7tE5OUYluFoTR6+5ej4AGG/GNmyLS/ftXptlrT2s8VLf2oMwkhuiCX2kcTTGFfOh34chVPcsb/WAoyeNZymHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vFEL/YnwcknuU/DvJYicLEJtiozeg/YWGUA+T0JB3aM=;
 b=UGAxn3/KgqzDphKxPyDd58VBkQdY23JK+9CbW3PA4wqe1mR6XNq7WF6cAZxyiia2cvYlOboGoYEw5lEB+whr/fLWc2uy23IhSzj1ETxzZVeS3RP65Gr/O3yB6qOneLXPQA63B0xD91hW7bVz7G1bo4SGtBCMmTiKbvGjKAVEjQBmJ9X1xPxnS9FoYBALaN+n0npqjykkxfNz9xieIDHUje+Op61cb4Cd+OW9TgzwP2i8yfvSu2EyKhkWrxZw26W2EO02izV+ct/O2TDpWhD7odzXAMoM5v1nZccwQRbk5uXGN58gwN+2az2mSkhA0j03AcX6C2VvKuDh4ZUhjHHyuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vFEL/YnwcknuU/DvJYicLEJtiozeg/YWGUA+T0JB3aM=;
 b=f2AuFdB6cKn31bbDRt390cLvi/yptDg94sL1n7FVf+AbhlMgibIjsEgxmTLrrmHi2JG8uGteQ/Dc5deXpC/N1LS4fiSG50vDULZjOidB3dZOpbdA0y5E6WX8/UBGC2rn8+PSi3VYwdzSIJdS549HuIWUmkBiVe1XC+m0IE0UZvM=
Received: from MW4PR03CA0184.namprd03.prod.outlook.com (2603:10b6:303:b8::9)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 06:56:57 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:303:b8:cafe::63) by MW4PR03CA0184.outlook.office365.com
 (2603:10b6:303:b8::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 28 May 2025 06:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 28 May 2025 06:56:56 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 01:56:55 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 28 May
 2025 01:56:54 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 28 May 2025 01:56:51 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <git@amd.com>, Michal Simek <michal.simek@amd.com>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>
Subject: [PATCH] EDAC/synopsys: Clear the ecc counters at init
Date: Wed, 28 May 2025 12:26:50 +0530
Message-ID: <20250528065650.27646-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: 27c3d367-38a5-4c91-e5e7-08dd9db4d5eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/ShIgZ6Mw3VeK7OFq8I0F+TSXkAOx4n3vC4BEfj/6IxtHFWPlQ1N8j1prcxb?=
 =?us-ascii?Q?aW2Qgc1ez+qTFluJL0FMiwhhIb18PF4XpgmWBPxb6qEFX4bToDC4Zh0hB/vj?=
 =?us-ascii?Q?gRAzSPMvPACFn28DRDqQLRW5TS3XlIjYDsL+FboKiKuhLdJBWGk8GH+cxib8?=
 =?us-ascii?Q?GTAuCFv+oQDkMDAN+h75KVi8tW5icV2Kse2BGX6G1A4R0h3DWweeSrMFIvHb?=
 =?us-ascii?Q?ZpGhN1ZFSO0XVzflSFF6/iF8+BXTGO2q5tkh/f99Ewh84VdHD/zbLt5v4ov9?=
 =?us-ascii?Q?VjPxwOrUj7yK95zJ128UOQEaE4Mq6sQmJgagQbPrYaOoYOWgKdl1qwKBYAGa?=
 =?us-ascii?Q?IzWCPiOl+YhixxkAnd3NBOplGUItQzfZrKxZsrQ4MK01Wmxq/ieXqJMXDM3c?=
 =?us-ascii?Q?m08XH3nFmDvNnG0Ktx9Eo+YBXE7LGZ0HogBkqsq9KTFH7rN/h2HZCQMn/kXM?=
 =?us-ascii?Q?qIxgWjTgJLCuBciTW93weTfl+reINwgey24ReNzvv5VdaanUfFVD1qPqJHFD?=
 =?us-ascii?Q?orLC9wyfy6uN7o7Ki8Bw0JgdNI4P6dgxJWbfK3FNwqfIcK8pRVCAFdSeTAGa?=
 =?us-ascii?Q?uUlKIbpbnTjZppqqcHv0pkn7JbWa86hVLNGhGlJwA7cNqxFxTHfkuA4Blm/2?=
 =?us-ascii?Q?FvfFWiPtRvy6J991p3FArp+ZsaErARW3HMuSv6g4MhnTnrTy35Hcw58xQXaO?=
 =?us-ascii?Q?1yERNK1Hhy5+lW/wZNKxJ0ofQJJUFI6Z8sv+9KieEyz94oo443+hjb/CAc5a?=
 =?us-ascii?Q?NaYI1dLzjcGMJDH7U9q/XVG1WZD2fGh5+2Rqw0yXbH6VN2oX02J6TyPnSEC3?=
 =?us-ascii?Q?Xru68A2IV4ajow6GL6EdjsMl7HO+vZV/+t8vRHLuUfXa1Qy5dd7rRZOYChc7?=
 =?us-ascii?Q?HRjKpzKCQCbeP5s7po//mYkLdmgrnk8+57nSJtPbv/sLV506Rko4ea/xsiUY?=
 =?us-ascii?Q?5bp9jDAhDSspyI4uA0mmf96zXf8ONVq/fHDIa5ThNgPoPg1XQ3I2wB6kaHbq?=
 =?us-ascii?Q?60gXiAaR077PmKFDExzohoO4zgKJQZZxs2g8ANEnIIA7xkr5HBbrm+7rdneE?=
 =?us-ascii?Q?zGhcXdC1EHUAGQcWhgIxhICRBQkGPJs5GTWbGkcdX0dCSqX3FEAmCnNGKmc5?=
 =?us-ascii?Q?QkGJKPr+iCHx+6boEYPhVDs/6bneXJ1VQMn1BTwvFUA2uviZQOarSxI9Fg1n?=
 =?us-ascii?Q?PRjipRDewUsEFh3S7wFeyaY1+ZO56NpSfDVDsXzse8LLkg3VgQHyUATf29aU?=
 =?us-ascii?Q?9A7JPZj7SmaWJz2LQaMFpEABLK4MmOnaVZpfNMOzPa2DPi4+41wmlkvdt2cd?=
 =?us-ascii?Q?QsehEfqkRRY0xXpaI4WjTl3wLZd/DQOzds/SJhmdWxBbj+rW2ZzULw8pNHZB?=
 =?us-ascii?Q?sodzfZAWfNE5XomrDu693d7SngXQjX2SSsHRphxylyemwh68ItLC7lK96xec?=
 =?us-ascii?Q?g55ySzc6CSZzQSjEjy9tHALRUsiUtfB9bqJ1teKE7iHyL/2iJg9Ju8xUTweC?=
 =?us-ascii?Q?orDSy1gcRdqjb3cxqL6WKySCcZ+srQXSyEoL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 06:56:56.3699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27c3d367-38a5-4c91-e5e7-08dd9db4d5eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453

Clear ECC error and counter registers at init to ensure a clean state
by clearing all ECC error and counter registers before registering
the controller with the EDAC framework.

This avoids reporting stale errors that may have occurred during
boot or prior configuration.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/edac/synopsys_edac.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 5ed32a3299c4..ebd2d6e771a1 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -755,7 +755,7 @@ static bool zynq_get_ecc_state(void __iomem *base)
 static bool zynqmp_get_ecc_state(void __iomem *base)
 {
 	enum dev_type dt;
-	u32 ecctype;
+	u32 ecctype, clearval;
 
 	dt = zynqmp_get_dtype(base);
 	if (dt == DEV_UNKNOWN)
@@ -763,8 +763,13 @@ static bool zynqmp_get_ecc_state(void __iomem *base)
 
 	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
 	if ((ecctype == SCRUB_MODE_SECDED) &&
-	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
+	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8))) {
+		clearval = readl(base + ECC_CLR_OFST) |
+				ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+				ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+		writel(clearval, base + ECC_CLR_OFST);
 		return true;
+	}
 
 	return false;
 }
-- 
2.34.1



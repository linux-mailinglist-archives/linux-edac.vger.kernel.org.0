Return-Path: <linux-edac+bounces-1092-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AE58CD7EA
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 17:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C231F21723
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 15:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2D12943F;
	Thu, 23 May 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N0Iy817w"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0A91865B;
	Thu, 23 May 2024 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479826; cv=fail; b=THgMVl+OifnC5VfF6hsHv55h8KA1hPMQTAOLuMO6zQ95l1cHqkP/Qr9RBf4z1goTwL5t7V1TpT4zlN8JDYJ17YkPF/OyWJ+LJV0kfwRRp8VvJIQlbbEfhnCqKrKFTCuiATKNiScGwmjhdPQnQ85UDEYOgRYF977Il7TVdTOPvYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479826; c=relaxed/simple;
	bh=EajZo3Zvg2YmRfm6byPDKKEm910dTZeJfTqU71mqg+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fzGy/63nlkbH2rvpJRpX/rFOE0RT49nwOX3lcShy13UEu82FGieVX8qhb0yvBinAnVtPNHQQCWtYf7mtAuhifnpVIYvvnLnaFCwc1qxV8NL1+ZAfoTqT7vY28taQoe4U4Um4eLhGyd+5soinWJXOOKfuFb4aRu4F5opqSEYe0Ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N0Iy817w; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrTAucvu7ETpRTwgcYjrhqpbj4x2UXQbqeQ7SRT6ERDxiaU0490aurmY0QqtxaTzfUjjU5OWE28pGjM6H6bOQ+eo2HqueXUrBur0/mCO6sohZA/zL9mFPLm5VGo4vzWr9i0WEBYJr5en2HD9NuskHz/VoZWkpyD/j9Oy+R0A/Xf47pBp1xQgkSkLn+J3fKxib/VarLk5GsNboh8S41NIbZT1ahH+1e28g4xIFpp7onUQMJTvrcBEjf/4/a6I+E64YkYiVaSb23iy+z2DDYF5BgvQAU54WmhwmkCha30ONvXpibwvkQoxUYW0BZMcBY22uWBZ/PMyFmhS4D3leaOCpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnBcC1T8Nj3qdazULR3V1w2Ejd7ggyyO9vl3jUEOXVA=;
 b=iFaGDefve2R0JkCxPhuj8QqXEF7MOryCL7VIxneE26fp8YERUkS2iP9F3pVt9n+4c4ass//WHzpN4Mw5mLawipkNDf7cTv+bWywGvqzte4obThUN0isPGcQ+O8ORkOPBr8DtL1BgcDop77fLHD5qjosPVHjrhdE3WQQlDZFTNDFL4m3yYVda4aRkDqOQwmbIIypXirl7cpU5tqZJxVEDrrzP+0bPRLn8Yz5fl7xyiz8B/a55NLIKajJ4AmxG6jZIm9L9Bhm2BIrDRjIX/dB4/PrOdCBOjwX8ZiLn4GIGTFGiK69Pf/GxRgpQoeyH5kIRIflbbFFn35Xt2n3Y1IUgfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnBcC1T8Nj3qdazULR3V1w2Ejd7ggyyO9vl3jUEOXVA=;
 b=N0Iy817wDFHpG/1qPOqQxe4t9/Z3tQb0JPgEgNdMoEtR2IzTb95kcWXEk+qiS77uL2rjsxubG7E/H+6/BCCVIK150rcKkJXq8G1JxzlLG3e1Z5B3jK029jrK6O1OnSI9jLaG/1DdgLudXZp0h6H9/3+p6KcBkAPIpEidx3kglq0=
Received: from BN0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:408:142::9)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 15:57:02 +0000
Received: from BN1PEPF00004680.namprd03.prod.outlook.com
 (2603:10b6:408:142:cafe::d1) by BN0PR08CA0030.outlook.office365.com
 (2603:10b6:408:142::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 15:57:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004680.mail.protection.outlook.com (10.167.243.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7611.14 via Frontend Transport; Thu, 23 May 2024 15:57:02 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 10:56:57 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<avadhut.naik@amd.com>, <john.allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH 5/9] x86/mce: Skip AMD threshold init if no threshold banks found
Date: Thu, 23 May 2024 10:56:37 -0500
Message-ID: <20240523155641.2805411-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523155641.2805411-1-yazen.ghannam@amd.com>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004680:EE_|MN2PR12MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c67d38-8160-4493-0336-08dc7b40fc56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YqKTann4ZZt/ISBlGtza47+dbO1dSxb2/Bq47cvI8k5vINih7BF5sj2CUdCV?=
 =?us-ascii?Q?wuo+2ToSv0OBifHmVShG69J7EuiuR6GoF4noC4rYlzUlt02ar83Fzb6/Hkcu?=
 =?us-ascii?Q?q/roBZp/GUdUbvIoyxKh3Q1axgtdBTtwWBva5kSwYekDPppFfdCWr/Bgn4r6?=
 =?us-ascii?Q?c7uoLf8C0h3A+qSQ7eB4KNBG6wqyGkZsETNYeU+CAlPqmk3TnifnzD92Rydf?=
 =?us-ascii?Q?7LBCg8eVJ4IyiUFEZifMtKqwZx8p6W0vqWP2ThBIrl7IzyXXLc1U7DAsHTms?=
 =?us-ascii?Q?XJvSAVoDV83KIbEzKsPJM6j0Qd3BUVOOPXEywHx4WPgBySi/fC5/3BCMAOVy?=
 =?us-ascii?Q?ZL6zI3QzNkSDH4HCzZ/W5pmOorBTf/IBGwKOxe9ImOoJmi1kfdepQxIaP80f?=
 =?us-ascii?Q?wZwKbtCKjnfz3JyAVqKhP7TgVJXQ01LIU+ghcDZ5QiQ9edw/mw9eBF/r7DrG?=
 =?us-ascii?Q?jvrOzw2b76tbCNsA1Clfx+v8NFXeWve4MWqSgfq+FUHcKlElsvc2i2edVINt?=
 =?us-ascii?Q?PuK9O1PcBH5cD1Dul/CK6QrjgUGwAFckAvuiLcyjwKtoalcA9geRtk71GWMH?=
 =?us-ascii?Q?tXoHV/CrtVsGjGEUB/lAHde3MmRaUVM7oHGG5/urAXNxzUMUYZLwWmT4ev7O?=
 =?us-ascii?Q?eUbg7FoxaCXBeyd6zLWF1vUAxR8qIl+SaM5gwwhHhgLDEDvMO2K2UId5RWvs?=
 =?us-ascii?Q?czwiF/7tLM6LR4TLXlj7ZpvxiPajx5IOKBXarQTp8dele+tP+dAAzfp7Ttur?=
 =?us-ascii?Q?DlfG2wU8dSdYZvHzas+ztv2VoH+zzZlpJRF+aHuz6K5u4NVcniQF6yFBGW4k?=
 =?us-ascii?Q?ianHX9EzvCGzmKjX0etvuFQW4bRfVB27E5TWUyuGqZk35vdbjhjgtfroYHVg?=
 =?us-ascii?Q?tCIFv4a0ZDvCgm+bL+vD+DshSvjVJoz4vKlmrRsui4kiKn1wOEPWhoW7DhqI?=
 =?us-ascii?Q?enWKpoes0DN6/u9K4ZAd1D5wM9Hi0NbFsGJqKBQ7HXlbthHAQpaH0nMmRLcH?=
 =?us-ascii?Q?GHqTFeiH6iixcfETS2uWQTF5H7p/L7b+EUX0EwEKw9YfsQjKjhERNC8x8S1d?=
 =?us-ascii?Q?KzdXbDJfIdmiN9h+LqJK1p6CCPWfF/NL3pKYxuuH23ZJmVN+Drd/VyqPWdbA?=
 =?us-ascii?Q?Bx5i9p1fo+jkGzFrcbAJLx+L4deBKph3abe7gqqrM8X3x/gWRYJN2CBSUiSJ?=
 =?us-ascii?Q?gVLrNKmqcJNNSHnzGR3AarsbQYu75wgxNgtMgNME7w5voxzoxuA5Q3A9HFZl?=
 =?us-ascii?Q?Wl2UKKVfz93ekujhqPEn/CnjDepsuDAF5pjkxZFB1aZ0j9klJfQ01qMfJYp0?=
 =?us-ascii?Q?zceejkuEKpek1HWrOCqilLIWyeyQyPwzuavnuTDiJtCzjeYthh5wDKEUKwwD?=
 =?us-ascii?Q?JJhTaeJLV8hUDm923Y/STgydJNBv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:57:02.0917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c67d38-8160-4493-0336-08dc7b40fc56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004680.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318

AMD systems optionally support MCA thresholding. This feature is
discovered by checking capability bits in the MCA_MISC* registers.

Currently, MCA thresholding is set up in two passes. The first is during
CPU init where available banks are detected, and the "bank_map" variable
is updated. The second is during sysfs/device init when the thresholding
data structures are allocated and hardware is fully configured.

During device init, the "threshold_banks" array is allocated even if no
available banks were discovered. Furthermore, the thresholding reset
flow checks if the top-level "threshold_banks" array is non-NULL, but it
doesn't check if individual "threshold_bank" structures are non-NULL.
This is avoided because the hardware interrupt is not enabled in this
case. But this issue becomes present if enabling the interrupt when the
thresholding data structures are not initialized.

Check "bank_map" to determine if the thresholding structures should be
allocated and initialized. Also, remove "mce_flags.amd_threshold" which
is redundant when checking "bank_map".

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c      | 2 +-
 arch/x86/kernel/cpu/mce/core.c     | 1 -
 arch/x86/kernel/cpu/mce/internal.h | 5 +----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133ef7e20..d7dee59cc1ca 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1395,7 +1395,7 @@ int mce_threshold_create_device(unsigned int cpu)
 	struct threshold_bank **bp;
 	int err;
 
-	if (!mce_flags.amd_threshold)
+	if (!this_cpu_read(bank_map))
 		return 0;
 
 	bp = this_cpu_read(threshold_banks);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 704e651203b4..58b8efdcec0b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1984,7 +1984,6 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 01f8f03969e6..08571b10bf3f 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -214,9 +214,6 @@ struct mce_vendor_flags {
 	/* Zen IFU quirk */
 	zen_ifu_quirk		: 1,
 
-	/* AMD-style error thresholding banks present. */
-	amd_threshold		: 1,
-
 	/* Pentium, family 5-style MCA */
 	p5			: 1,
 
@@ -229,7 +226,7 @@ struct mce_vendor_flags {
 	/* Skylake, Cascade Lake, Cooper Lake REP;MOVS* quirk */
 	skx_repmov_quirk	: 1,
 
-	__reserved_0		: 55;
+	__reserved_0		: 56;
 };
 
 extern struct mce_vendor_flags mce_flags;
-- 
2.34.1



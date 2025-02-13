Return-Path: <linux-edac+bounces-3061-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6619DA34B30
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 18:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 376803BC2FE
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB06123A98D;
	Thu, 13 Feb 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AESW2R9k"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCF628A2CF;
	Thu, 13 Feb 2025 16:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465193; cv=fail; b=POn1eBMbv+gUdIbTyAFLgL0RvlctWJzEyjyvT+ZXU0Z7iD3JYSk5zk7fecUwRmA/CO8hQ1K8YkP+FxESFQyeQpCy7veaFPFsWeVOZim7+tEJ9myZSiToYlFNQjoFzrwSJ/vgpYTxgKW7OkxyqLFbz46FrNOrBDiBNHirvYsN4YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465193; c=relaxed/simple;
	bh=CbODem0pxySjbgKVz7f7ps89LEQVa6P2ejcztv2usRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HQqFqJABpOOUE088cSeZVZz6YxHbKA5q/OpqiloxzmzUS65XbvtLChxwbHwuK655/OY5IuCATXymEhjLzA2/QMMN6QjTRGKsGW20IDx8eLUQobkZrZrLbeColEpwIa6mXSu2CJb2QQ6JTl0SS0Cb0+0J4VJovaJhySBDAYZrhwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AESW2R9k; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6mNLrj5mWJWuY/ashlpuRGWB9BrANrkDJeEcwcdtNVPdOGQy0sVymNFuo0WTfN2qsaXDkIHFumthvAqh7lvbIQDzO5SqquxTiXzDDe2P9rurB+Zpbbs3qg0+9/u53noaF2LlFuLW7vDQ8iyDst78tDTU91lo1V9z+L5RiP/7aNNh8k+3ak/Njq3bhUdXjh5opZyqB6qyOzkcNt2AqlXqNn0kDguVGxzgWMLtUC/5mlvOmEJjkeMOc2H/+SggysNMk+rI9fYBN2DMqOcLUBfntsDOG7j3dEi9AAPN2wmX9oPY/sQFGNbA0OBDZJTrgqtreUnHzescvr2k5RBsjO0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCw0tGefJPwiRqQfxwHTL8Bw6+qlfuBMsDzZIR1vM6g=;
 b=NqN2VWZt0qQf/IcknwKSWYUhcRX3OyPM7Cfi00SMoawWSiIaFed6h4jLt/UllHYhTdfWq+u9/omIEkGfskWGlCuIjWw9VzzJAaXfL0Cc3cqQoB8KDcuX9cD3XEGilIQKwzgTcq3sYKZ4vOzXqpA9fLBoZbzQSmeHT+ALnUnWM0HtXOTKqCZ2Ug7MLy9KAd79tVVB6RVDwk/63Sj6F8J8H4P/bA1OMjP7h3d51E+gBVzoDWRKYeR2dV7syTqu8yggIUYkBzbYgbNiZTNILTTAXvCvjpnbpK+ZJwgWZM0/ADiW2B7uVAAPdPgxgJtQve8Gr4i731PeteMRSVOEF1aGug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCw0tGefJPwiRqQfxwHTL8Bw6+qlfuBMsDzZIR1vM6g=;
 b=AESW2R9kEpjHEyGpnInT8PlNg7FLG57AZ2/r8ujGvn0XXsrJxd38JK/Sd3TN4YG7iecFM3enkQE8nV55qYV4kpDZPGEH5WYinKBcdxDlMxAW4yBLb/eRmrtGNcqESfL7Mr0/ngmuYkrxVyPIvOQP/VztnHeaW4hZW9/OBceEVFw=
Received: from DM6PR11CA0036.namprd11.prod.outlook.com (2603:10b6:5:190::49)
 by LV3PR12MB9186.namprd12.prod.outlook.com (2603:10b6:408:197::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 16:46:28 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::82) by DM6PR11CA0036.outlook.office365.com
 (2603:10b6:5:190::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Thu,
 13 Feb 2025 16:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:28 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:26 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:55 +0000
Subject: [PATCH v2 06/16] x86/mce: Remove __mcheck_cpu_init_early()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-6-3636547fe05f@amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|LV3PR12MB9186:EE_
X-MS-Office365-Filtering-Correlation-Id: 732741e3-5b43-4340-8ec7-08dd4c4df62c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VEhuYnBQR2xuWU1Ba0RHVG9kZXdBSVNKRVV0U05pK1Jldm1UNHJEa1RzaFRE?=
 =?utf-8?B?VkdIbjM4NEk3R2lNeGxCRjR6SE1ta2ozdGZ0QnE4ZFcyZ2t1c28ycVV4d2Rq?=
 =?utf-8?B?VVlCRmxldWhaaWlMaEZpcEUzc2RleTVaci9tY3JqWHNJaGQzL0xqV3JnbTBX?=
 =?utf-8?B?cjQrV283ek13OWVtMW1qN1J5UzErVW8zcWFjdEhwa25TVTBWZVJFa05FbUgv?=
 =?utf-8?B?bFVuU1l2N2NGTHZaY28wZWN1NE5VTXpnSTJuVmJLL2l5R2cxWWJYU2U0UWJ5?=
 =?utf-8?B?VUhFMWYrT3ZOanMrS2YwRFQ5YkF5WVcwbEZLV2tsN1liWTZvc2xzNU1CcFdI?=
 =?utf-8?B?ZGE1TmY1NkdpcUovVnY2QVpKL3cxdEUreW5NV0JrNzlYRjlpemxIM1VRRGp6?=
 =?utf-8?B?V0NJMTlEKythc3c4T0RsS2h5c2wyaFMwckdGZzQ5TkVzY1BOcFU4Qm5SN1lz?=
 =?utf-8?B?TGdRZDk5bU5vOEw0YjgycUtpTDVNOEkwdzJielNNMlo2M2c5T0hLalZ0K1lQ?=
 =?utf-8?B?dWM2aVFLcnh5NHNTdTF6OEZocVUwVHRKakJhdVVzeXBHcjJZNkpNcUZ3Y0pT?=
 =?utf-8?B?YXVhcDNvSDQ0RVhpNUxZenc5VU5YRzQrNzhyeFlZN0s0N2RqZGRYdE1UM20x?=
 =?utf-8?B?UlJiQmV0M0FWU01RVkF1d1g3UndaSTJXd0RPYzZ3T2Z0QTJkR2x2RDNmQWU2?=
 =?utf-8?B?N1cvSWNUVWNZK1VKNmtsd1RhbFp0VnlMUFBVVHRMUEhReWF6blZ6ZUdyaGw1?=
 =?utf-8?B?WjNLMFY4M0xnbitXRkhBcmtaNmdaalpPQnl5TkxiTHdqNmJVVk4rWWtxbFI1?=
 =?utf-8?B?ak53UHRRNUx0akl6YzVPZmJVNW5rZjVJb3pvYk1ad0RMVDREeEU4UUdsbzFi?=
 =?utf-8?B?WVBDK25pUXorcTlWNGM2cEpjcTU4TFdLNDRPQ0hUaTE5OGo2cXVyQy9tUHVt?=
 =?utf-8?B?cjEzM1hDTnNua1hTakVxd0lsd2k5YTBQTEsxd1J4cXpSVzBnWXpXY3VIeHZI?=
 =?utf-8?B?RklqRSs4eFhUMUwwSkQwVStkQ1pwbHdLQy9LSkh4dGY1TEk3bVV5TmNjbEUw?=
 =?utf-8?B?RHNPU2poVFZXQnBUenBudXJ0czNIY0k0aHBHTGJUcmdhczhKK0pBZzhFdUt3?=
 =?utf-8?B?WkpuN096V2U4VEIyRFpvbU9MM0UxTDg5NWtMcDJjakgwSHZNN1lWQTh5NTNo?=
 =?utf-8?B?d2N1dHlXbk1aVHRsOWRyR3ptKzFrUGR3NmVOQW9MRnZmRmxnN3VZUk4wR3hy?=
 =?utf-8?B?Z1ZGSW5LT0IzZzZrMytjSzJTZHFNRG13R1U1S2hLRGl1cXdyWktuZDZJS1pW?=
 =?utf-8?B?OWg5N0ZkaGRGN2xEMlYyY0NXekVBVk04VmZSNGVVSnpTMkVkSFdTNmNlaC9i?=
 =?utf-8?B?K05sTkNvS0c2ay9CUE5XcGNETEViWlZ6NGdFR1lVaGhYaG41N3lzTUJwNEc4?=
 =?utf-8?B?MC9EUWtuUUpMMFRONjFDR09QYWUxazh0Y2NTeWhmOGZPVXdQQUs1ZFp4WjFM?=
 =?utf-8?B?emNMSFNOblErL2x2bG9IVWJicVQ1V0tGZDBmb00zbHpPUkN1QXNibGNHb1JZ?=
 =?utf-8?B?SUg2akt6eGxOZlg1SlFlRnd0RkJ4T2dPYzBUZlM0aWZVc0YxSWZpNkRYOTBD?=
 =?utf-8?B?MTVVNE0rK1pCdXhUWVRaVGZXU1d6dWRXV2xJam80WXR0YVhJZUw2bXFhTzB1?=
 =?utf-8?B?Tm9xT3VBSnF6OXJnNXhhbktaa3NGbTdHeEdMRmJsNDVESURFWitLL2J2aVc0?=
 =?utf-8?B?SUdTTGFoTHBxczVUTTR5RWNBcGdrdnhxcnhEcmRJTDlTV3RtV1dvQ3RablFW?=
 =?utf-8?B?dGx3MXBVN1lkV0JhQ25mbUh3dTFRcG1yVVhqRllFS2JpbFZhZFY2WnhXdDB5?=
 =?utf-8?B?YUxYd09nOE40dDRBeFJ4dDJhWXQyRXhZTnBuV2lKbk5qNTIyT2Zway9wSlBa?=
 =?utf-8?B?SEZLV3N4bStkUWlkNElpbVNKQlI0N0wvREtKVnU1V3I4Mm5OTmhJdlBzaEV5?=
 =?utf-8?Q?I5qHgJuaiTLrWPXhCUmVWM7/1TzZyE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:28.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732741e3-5b43-4340-8ec7-08dd4c4df62c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9186

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event
done in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().
Also, move __mcheck_cpu_init_generic() after
__mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
MCA polling event.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20221206173607.1185907-3-yazen.ghannam@amd.com
    
    v1->v2:
    * New in v2, but based on old patch (see link).
    * Changed cpu_has() to cpu_feature_enabled().

 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 20 +++-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index df8984aac1c6..302a310d0630 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -656,6 +656,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = cpu_feature_enabled(X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d85bd861ecca..7fbf1c8291b8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2029,19 +2029,6 @@ static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	return false;
 }
 
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -2281,10 +2268,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2450,9 +2436,9 @@ static void mce_syscore_shutdown(void)
  */
 static void mce_syscore_resume(void)
 {
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2469,8 +2455,8 @@ static void mce_cpu_restart(void *data)
 {
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.43.0



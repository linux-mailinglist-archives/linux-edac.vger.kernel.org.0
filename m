Return-Path: <linux-edac+bounces-4217-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B245AE6854
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B0816FD0D
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1994D2D6624;
	Tue, 24 Jun 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eM8E7w1l"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E99B2D5C81;
	Tue, 24 Jun 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774593; cv=fail; b=APCeFxl6paOJ63ILEqOQizQrcQvFo+z9KQTEu8dJV7ByuzOqCUoENVZ2kLMNNauxt6jqT5wwJ3eURI8Uv0h1vkXZfQSevtvyVdCRYoPk2FQT4DTfHzRtp9hSaNNdfQl6Sau30Tf2J2lQHyXkmWuLf3bRE23AswwHtmB/BcJ8wm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774593; c=relaxed/simple;
	bh=GIZ5GpG5nkVzk2J6ez7Rehd01uIa82RDZuLzTvrggJY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B3O3d/V630pOuVhpCdfl3WLMeA3lVy7cAhIzwAoaGSsEb1/jlSfYwgMbDsO8qk2GIgfSMaF6G2TXNMV+VFASBGYwmDUXd/y00yTe/MADF/Q5rEfeuN5b111ulnK1ZNW026W6m4nYT701EbKi/GF/WEFd3A3r3qkWrCHqZRV1U94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eM8E7w1l; arc=fail smtp.client-ip=40.107.236.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peEUZvjheEZDOpAZiNNf8c9Yl7mmJmPqTeHUS0WU2tkLifhwxu8p9GOxJIO4fZp0q8ThsqVjYpa04UxQxCxfG5VN0oh/12U/aeqWESWp0PWjG6kLX08zu+vBY5Ky2/BvAfrn1/sl0tO7X/T7Nk3HUayRc4jmFKMNghc6xBsTzRiGJAQ+TkmWqgeEgVbuFEA5NJBaRkzqrnfa2ooAmMNPuzD3RalpggTUyttSYeFeg8q62W92aZTEPaxv+NRPZ+jcHTXe83x9OrSEQNOcr+Xag3pmsuZVgnsgp6P3uw6HUHv5XDcx/WKukQ3erMMYSiHwnCUiOSaNbfzSsgV3xelrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44cokBpdbsJW67lwiFhRqWRNBVt+hMmz4cDEACOmYMQ=;
 b=h1Y1S6nyobFpZdpKCpeyQ4loajFyEHgrjh/2UvWlkV0yZUt7rn8I1rX+npmLKwlKnnAjha5G8UNEBGGslRVWnZcarAAXDqcFfKpMBikHCv4q8oVq28VTDaMMJxUmzJYLEYLJsHk8TAAZY3ILS3DsB4wzvVlVkmeNHUqO395wd+m+5eBdmIJKlEx+pfm5ZxudTEj7VGj76bz4zlCoame6XiFxh4fg7mgQJai8PnkYf89VcWOvwdrrbwiBQtH2hT5Ecdg5C2K/I3Z5cQyQMf9y9ShQOidnMMjCutEeevz3oLYR3u1w+NKOQ6DyHVhewum5UdrSLpRC/FDEeyqIlxzJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44cokBpdbsJW67lwiFhRqWRNBVt+hMmz4cDEACOmYMQ=;
 b=eM8E7w1lHfErcD3thOCzMB2wuYJxDT3rSCQypNdleq60CLt3tVANSTAOsx8FQmBDMDx3AieJMQ6r9YdUTxleINir0V23zGGm49suEL3JryfxYFctdd1dt2gVtYPcWYpYKMAVtdCA2LrLdylQdbbasHsvEFSzQKmAxPXE6jMZz8Y=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by CY1PR12MB9602.namprd12.prod.outlook.com (2603:10b6:930:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 24 Jun
 2025 14:16:28 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::21) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:25 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:15:58 +0000
Subject: [PATCH v4 03/22] x86/mce/amd: Add default names for MCA banks and
 blocks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-3-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
In-Reply-To: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CY1PR12MB9602:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e3e9329-3daa-47b3-d0b6-08ddb329b59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXVRZzllWDRYNEh2amNValhWRW0zQkV5ZWk0R0U5NWZldTc2QmFzdGdXeDBv?=
 =?utf-8?B?amQzZ0N4Y3J6NlZqb0tSSG55ZUE5bk9RSnF1ZzFRMTRkVlc0MWRzdEZFUGVP?=
 =?utf-8?B?L1pqSXJuN2FSSmZaZHVBTitndy9GTkhnckdESnd4OFdPT2FQeVYvNFpsRzFG?=
 =?utf-8?B?bWNCOVV3a2ZwK2pNZ2FMOCtWa2gwVmhsT0tvS3FXdGZ6b3RpMitIRmdzUXha?=
 =?utf-8?B?b3RwMmRJTWpWYzZXcGI1ZXpLWG10TWVFejVZeUo4ZlduS0Y3dmRSampoVUJ2?=
 =?utf-8?B?Vnl1amVSN05lVThsZUswbFRRdFI5eG50SGxTYkpHTHdva2ltalpqVmJLd2Fr?=
 =?utf-8?B?cVl4bERxN3luVDVQcENRYUlpY2VsdDRHRjJOMkFoL2w2YzQrdUF0TWh2Zi82?=
 =?utf-8?B?NC9QOWF4UXR6b2dJNXZ5YnVOSitIeUNwTWZSL1JHMEZiMEZZd3JzUHdUS0Jz?=
 =?utf-8?B?S1hXeHh2NmZIcHpxaXZWSllyWThhV0d1ZmZMWXEweEYwbEhVbG1Eem5qMERl?=
 =?utf-8?B?NGRkLzZFWnNaOEpLd0Zvc2xkYWJyT0wyaW5ENUFic3VwUm5XVDlTUGNmck5N?=
 =?utf-8?B?bkx1WnBaNVJGTzV4N1BRK3lIcytzSFlLVUN0SmN6bEZTeEFVSDdQY3hDRThz?=
 =?utf-8?B?OGpQN29JV3VrcGRqdHZiRE1Eb1ZsZmhjcDJMQWgzU2xQTkpvR2xoNmR2Vk4x?=
 =?utf-8?B?RXprL2o1aC90TWdWVmxNbWR4cnc3REk5UXNFanRLNHJLSXFPN0phSlFITDhI?=
 =?utf-8?B?WnRlcDJwQkxzL2QvRkU0d2ZsWmZhemFQWHQvVGJreUVHZG9WVjJDeGpqWnc4?=
 =?utf-8?B?cllWb3d0ZDMyREVoa3BkNm9rNHFFZWFGOE5mNzVqTkdydE0rSXVSd2lhQlZF?=
 =?utf-8?B?ck4rU3dmcG5QOVllTHpGdkJ1TWNNdjRlYjNBL25nbkFGUEhaUkM4SUhvZ0hV?=
 =?utf-8?B?ZFdONS82RjRiSGNoNU16alZDelg3T2VWYzY3c2pJbEFiUlRZN3F6a2tQMGpP?=
 =?utf-8?B?bWl4bWJwSUdaRy9EYWY2bnBxT0lEVitOS2FmWFZ4ekM0dkRKTDNxbUZ0eXhP?=
 =?utf-8?B?dHJmeWhjVjA2Q1kvb2ZpeU8wMXVsS3kzUHRKUUJCQWgrYWMzSUF5RURRVDA1?=
 =?utf-8?B?QitSdFdMOE5ObWQzUnpxMXNaSlFoU3g5bWtkYzZZV2s5WHhHdjRPUTNWRG5i?=
 =?utf-8?B?d2l3S0llOHM0K3drazZraGFJMUN3MlBBLzg2TnZFakFsZld6WUZkMThIbUxj?=
 =?utf-8?B?bVZsWHJXMWJJYndpMy90NzRuM2VyZkxkdlRyMi8vcE9RMUlZRnpHMHpwV3hJ?=
 =?utf-8?B?ODlVc2tmdTRQeTd4OEZVb0RLYUhLSS8yL0FPOGdrTTZMNVVhUFFHdklyLzRP?=
 =?utf-8?B?czl2VUNBNEFLQTJDRmtqMTdUZnhJbmFDUmhYb3hFYkZyS0sxS1B3SkptVkpB?=
 =?utf-8?B?eDkxcUs2OUlsQkpGWFdiaHBVOTJoeGg4YmFBeEI0OUkwVjN2dVZBMzJwdkV5?=
 =?utf-8?B?cnhjQ3VFc3lDL0JnaUh6cjdkZWdPRTVCYzVhWm9iS0lBNDJkVXNsengxbnBC?=
 =?utf-8?B?Z0l3cEIya1hLTlkvV3N6YVc0OEs4dytnb0RISkJuWUtDRm5CTkE0WlBEbnNM?=
 =?utf-8?B?UFhXNkJCYzQ0ejVRWjFialZBMzlXclRoVjdWL043WkRXL3g0cXhweDdLOXpi?=
 =?utf-8?B?SzdpMkdnMTVXL3ZJUlJVZ0xXS1JwZ3BjOHQ1NVNYOEFOd21qSEc0eU9NTmJ4?=
 =?utf-8?B?NE9BaDJGL3hmdW9pRXUrVFZXSnVHcFVzcXQrMUQ4a2pZMXMwWDVEWTJjL0hV?=
 =?utf-8?B?WEsrWUNjd1BvdTBUdkhKdUVTYXN2RzFzZUdYTXZrUHN5RnpZRXM2MTRFR1ly?=
 =?utf-8?B?cVR1a2x6STRhR0U4SHpnTTFZU0xqZUVtU2U1cHhKd252K2NZWm5ldEFmcWt1?=
 =?utf-8?B?OGVyQXlNeTJBMWJCVVc0RHF6RkozSTBONmpIemV5QTBDUldVeURBZzhXSmg1?=
 =?utf-8?B?UWdhUHh2b0V2MGtlMk5ZM3R0NFNZWTNEN09FWWtiTlBVY1B2VmJvVFlIbW1V?=
 =?utf-8?Q?eGwq0d?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:27.6926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e9329-3daa-47b3-d0b6-08ddb329b59b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9602

...so sysfs init doesn't fail for new/unrecognized bank types or if a
bank has additional blocks available.

Most MCA banks have a single thresholding block, so the block takes the
same name as the bank.

Unified Memory Controllers (UMCs) are a special case where there are two
blocks and each has a unique name.

However, the microarchitecture allows for five blocks. Any new MCA bank
types with more than one block will be missing names for the extra
blocks. The MCE sysfs will fail to initialize in this case.

Fixes: 87a6d4091bd7 ("x86/mce/AMD: Update sysfs bank names for SMCA systems")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---

Notes:
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9d852c3b2cb5..6820ebce5d46 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1113,13 +1113,20 @@ static const char *get_name(unsigned int cpu, unsigned int bank, struct threshol
 	}
 
 	bank_type = smca_get_bank_type(cpu, bank);
-	if (bank_type >= N_SMCA_BANK_TYPES)
-		return NULL;
 
 	if (b && (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2)) {
 		if (b->block < ARRAY_SIZE(smca_umc_block_names))
 			return smca_umc_block_names[b->block];
-		return NULL;
+	}
+
+	if (b && b->block) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_block_%u", b->block);
+		return buf_mcatype;
+	}
+
+	if (bank_type >= N_SMCA_BANK_TYPES) {
+		snprintf(buf_mcatype, MAX_MCATYPE_NAME_LEN, "th_bank_%u", bank);
+		return buf_mcatype;
 	}
 
 	if (per_cpu(smca_bank_counts, cpu)[bank_type] == 1)

-- 
2.49.0



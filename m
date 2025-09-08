Return-Path: <linux-edac+bounces-4759-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED9B49405
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434281BC0CC8
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956A8313552;
	Mon,  8 Sep 2025 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DzpQv2aa"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE9A313528;
	Mon,  8 Sep 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346084; cv=fail; b=XAyIjSmapg+XQ2hutZngJZtNzQOtp1c/mrg8N1CHmeKm2Z7aJHtiqZKodsI/w7ZIf7Atr7t8d5CW1PefY6mPPVf2nS4yGlkzw85bR+oKBsLPbtpU6m6opCgjJYERiL+H021y+B21ZGt+9yVoGlnHtxAyjJ8d0nu9/8s7/QLtQBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346084; c=relaxed/simple;
	bh=fbynwiriBv219A3wH6zt0YpcyheZX8fGelNUHi0E1Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Ms03O6NdtI4msL6nKafTZt3sqxIJwXaGQhStzz25hMFQ/8bF15n3aLxqGKPkypVxBh198h5yPZuL+yGFoVWWinh+twQyyl+hqOHLxMGqD2wU+Nf6866LLQtJ8gin8cfHk5gCS0kkXVl/dASxMc9EVKbouZg8fW+kFqbPIEiNUTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DzpQv2aa; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g2mjKhItqIKlbP2jDqlEoGXzDZFL+w5ZkdjTxugcnxfDUHa1rpB/RZHaqpzeXRKWT6tRihBk+/18LX7HR5WCIqHa5c1aTUCiQ0BwSCSklxBrj08sBfqlLEVT8piZ3ZEglg81djCrstecHgFIIRUmR9w1CQsqaKeNPurDSMRoO78Gx1Tk5rgg+gxDQzm5QNJtqSDPpJNhwOU0ILQikdC3TM5mDJiBrmwORcoJwHK1mJATWGtbmLVJqW/X4iaaMqcPhLI0kXBiTDCkqWnvx9Ut+P/qy2mu+WvuehTtLzmP9WuJAdv8He1qlr+ypd9S+qlRwlL9T0/F9qG78O8f5jxV8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Au4dciVogdwbrSzK2lPcfjKNPiIWtkpfwTQpbMB7yzo=;
 b=vOTkjfzF8+3hWlQwIwsy2vTBcXyy5ywCyZLlmEy210FYEkEeVnUsVJb7lCYvfOrWqioLsSmiS9NdQKSYp7SIEhBMoYFYcpLp8IkO8yXnYK1gwmYLjIKM0Jli/suf/VbwTTBGJnGKawxhwOO7g5RBgpoxwiaLOprq3KBH4bbDpg9ZmnurXJXZIbpNAvsPAJrgvTurRyOFXU3GOjLRWmeH2DSXFvqY5ZMp04hK7qBvJJnKdfRqL39VW6clyuBIBZbAKKqX/yfPiVUENJC3T5XvdWLE+XKDO02iIVC4dkKVDiAfNaBr6doh1SoxnB5IBQU5hvtA3olg/gz97w6153S65w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au4dciVogdwbrSzK2lPcfjKNPiIWtkpfwTQpbMB7yzo=;
 b=DzpQv2aaJ4+0mEnaMAhgttswGZHpmvouRIv8ngERVvxNpxuK1K//z2e/BmGMk9+HAHJQQVbx+xzBuoyUGsTl7zNvWJsJCv1xwDyYQEl13xETtC82mYY99e+ckN53yoFbxSvwKklZeCHhXs66SieCTUUz58pKuJLfav9dPih8Idw=
Received: from CH2PR17CA0004.namprd17.prod.outlook.com (2603:10b6:610:53::14)
 by SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:41:13 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::21) by CH2PR17CA0004.outlook.office365.com
 (2603:10b6:610:53::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:10 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:41:01 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:41 +0000
Subject: [PATCH v6 12/15] x86/mce/amd: Remove redundant reset_block()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-12-eef5d6c74b9c@amd.com>
References: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
In-Reply-To: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ca85106-8de2-4abd-003b-08ddeeee22ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHVZNGJQanExRDFqOGpkcGpnSTBnLzNxY2UvMENuVEhHZHpVS1BGVlVSNXpl?=
 =?utf-8?B?MDhiNmhoZFlnR0tYTjhoa3FZb3lzR2NUaFV2aHBKV1F5R1gwZkxWbzliLzhY?=
 =?utf-8?B?RzF0UDhwbUt1OXU3dDdkeEJEVFNFeDhZdHlnZy85NjZkSVVGQk50am9hM042?=
 =?utf-8?B?bWV2cnhWOHV4bVJXZFdVYzQ2MW1XVnFzc1Z3QjRqU3RrVjVlN0VKbDlzQmJC?=
 =?utf-8?B?aXBSdXl4OURZb0dBVG82c21WRExaUnUxeVRWTWhiL0ZadW1PQm9EeGlpWUgw?=
 =?utf-8?B?OWNlSU0wN1dldkp1RnRUeExGSjNqcEhaNGhvcGtyQkpwMFVreHBzUEVEUjly?=
 =?utf-8?B?QmUwVnk3TDJnQ0plZXdxYXplVFl4Njlpdnk4N3lqYjE2Vm93NHE2alEzcE85?=
 =?utf-8?B?YTVzYTFqQjhlTHpoVnd4eUFHbjV1VWdWbVkvSncxYi9kYlpPL3BmVTV3UVRy?=
 =?utf-8?B?TVZGaDExRXBJZG8rN2tyZFp0Q3E5dlRoWk5OdStmVC9SazhtUjRUYVFoT0hJ?=
 =?utf-8?B?WitCeFI4ZzZhYkd1WkhldTVid28yaVRZY3JNQTdXNGJNRzBZSDloNDVoUFlm?=
 =?utf-8?B?R2oyWWxQakFmd3pEQUVOajhFaWxPVHVYQ2NZMVloeERJb0NtNU5TYzBYdW1X?=
 =?utf-8?B?emRFWGhsTlRYUjNoaWVVN0pFVzJ4cVZjVTVuN1VZY0NEczNMMHkzc3FNZmx6?=
 =?utf-8?B?cW51Q1ZxTjJvWmF1R1Vzc3hOdDNvbUN0dHloczAxSmVHcDNhZGZsUVhuaHlI?=
 =?utf-8?B?SmRoS1dZSDg0Qm9Tbzlmcyt6T3dnblBHY0IraDBwcG92bWlrY0lnc0czblAx?=
 =?utf-8?B?a0NmUmc1bjRFVjBENCtBRVphSWNFSmIrVnlHUHluNjZoTzNiRW9IYnhrR3pW?=
 =?utf-8?B?YmJyeW5pekZ1Y1ZTZ09nOUFGVm9KdWJCWlcybFVFOXByWnJGTStNVGVsWEI0?=
 =?utf-8?B?VTdiSUZMNVluQ25mWlkrVmtwN3dMUnFLdGN4cVJGUCswSXFGc1ZnMHg4YnI0?=
 =?utf-8?B?YkI0YTBjdlFWeG9YbzhtOGRGRU1pK1A4WUNrUThBSmFEQWN6QnI4UnVKbjVW?=
 =?utf-8?B?S1JPdGV6K0lNMTN3cTBTOTg4aGVoU1REQUtGcUNCanZxaTNkTUtBYUF0bURC?=
 =?utf-8?B?aVE2WnFkSnNHMTVVdk9sbFpRT1hDWTlCaU5aVWNWYkRra25qS0NmMWVDRnY0?=
 =?utf-8?B?ZTkrMmJTUys5NjVvZFB0c0VHUjhNSm5iTUQ4M2o5aWlrZ0VlQ2VNbmVxTURj?=
 =?utf-8?B?R093Ry9hNWpOdkY5c01VS2MxcTZmYjlRTnlhbUwrZGtVeXdLWmhxeDI2ZUNt?=
 =?utf-8?B?cWo2QWR5TW1paXpkaDN1Y2V5NTN5SXdTVlZML3lHRU9GSmhxQktmYXpLemc1?=
 =?utf-8?B?NWFTVkN4dm11UjMydWNkN0VWSWVGSkdXbmVldGVIKzFyb240RVFOdE4wL1Rp?=
 =?utf-8?B?WjdEUGF6bzlEVUJTcXYwNmFNVHd4SVJWb05qcldPTE90MUYwSDNiREV6UmFq?=
 =?utf-8?B?MUNYUEhWbjJOaEJBQitneFA1RTJmTzhFVDYreVRsNm5QaVFpemZZQ2ptYmZU?=
 =?utf-8?B?TWg1RFc3WldvTHlRc3B0SVdvQU16cVNMaFcybG9ZWGZJaEtoaTVUVFgwckt5?=
 =?utf-8?B?QlQ3RGtUK3dWd1lxaE1oQjRIdnZtdkFkTWI5eHF0YSsrUmxhT2VuNlNHbDBl?=
 =?utf-8?B?R2UyYUx2VDBnVzBFQzFKV1g3c0hacEE4bnorc1dyREZhRk9aZ1cxOXpuQnFp?=
 =?utf-8?B?MVk0Mmdza1RMODRkSmd5YzRncmxTdy9XeXliNVNiRkl0V3FEalJJZHpZNHNx?=
 =?utf-8?B?MkFweXllSUJEMTN4Q1ZnM3dsYVAxM2ZmbW5oaEE4L2RrbFVmZ0gydUQwbVVp?=
 =?utf-8?B?cm1HMjh6MEJIclFISzlyd3JRZjQvT05FTDlhU3NXNnc5RGRqTTRXZVd6NlJl?=
 =?utf-8?B?bzd5dnphNTEzMlozL2dyK3dBcWhKRE4xK2o3bnFVVWRyK3RVOWpJVWpNckFB?=
 =?utf-8?B?NmR3dG5YWk1CZ0tIMXRtS01MRmZjbzRWWFJzRWt6OGthMi9sUXlqZkMxelZY?=
 =?utf-8?Q?l/uitl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:10.8158
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ca85106-8de2-4abd-003b-08ddeeee22ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

Many of the checks in reset_block() are done again in the block reset
function. So drop the redundant checks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-17-865768a2eef8@amd.com
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 34268940c88a..9ca4079ff342 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -812,29 +812,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
-static void reset_block(struct threshold_block *block)
-{
-	struct thresh_restart tr;
-	u32 low = 0, high = 0;
-
-	if (!block)
-		return;
-
-	if (rdmsr_safe(block->address, &low, &high))
-		return;
-
-	if (!(high & MASK_OVERFLOW_HI))
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-	tr.b = block;
-	threshold_restart_block(&tr);
-}
-
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -844,8 +826,12 @@ static void amd_reset_thr_limit(unsigned int bank)
 	if (!bp || !bp[bank])
 		return;
 
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
-		reset_block(block);
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
+		tr.b = block;
+		threshold_restart_block(&tr);
+	}
 }
 
 /*

-- 
2.51.0



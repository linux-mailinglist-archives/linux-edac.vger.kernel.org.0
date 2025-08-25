Return-Path: <linux-edac+bounces-4671-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0572AB348E1
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0168A1B21AF5
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7306F3002A2;
	Mon, 25 Aug 2025 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dw6arO/O"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705AA30BF5C;
	Mon, 25 Aug 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143235; cv=fail; b=DxTh2N1//QY14KZHO68p0p+NBzJtIHr0jSyRRMy9saSCkSn8BR04dB8W5RMdtlcs1uUVwdWogBRKU6tP9ypaWIrVyGm5NiDh51iwmxtUVExMXIqkszUdKfo4ruXOBKT4QVW1Re+4uS6p4N8efz5MBJHRO5UYg0XmgVsryxMp8Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143235; c=relaxed/simple;
	bh=Z8UtCcAdO7YJqJEN7FUgBjYOkgwJjXmh5ny6lTm0r0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NAuXb9eSjf7qKx/OXBQMyrrl0ppDYL4amK33NSghg2AvRoP8/1fKxai1YVrSMacyNHv6v8xiuy9umiSqD5WDDMgaFOn1eGXT/yguGA3FA0+rnsqbFpQKemB/SClWsiUSTT5AR1czh40JWb4G11uF/E5EWDEne5hWq7odVYeUUxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dw6arO/O; arc=fail smtp.client-ip=40.107.94.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTeiYPELpHmcoon9+m0HCkGn8YSRGx2Nhgnn+i/N3WlxEp/4KfLyEBTW1IhQd/pJCvgRlR7BUhkC8KA3MUWXYEEkAwn5O7vGXz1NqqTEFqx83olbztR5dFk6C8x+aEg34qjCuTdaYp5qRx23cYPRfZLlp0x3FPFJiLfMSqJPt+fPlDixBnGSqFbzLRRKFxuLRMmOrlnGY/ppRy8jq6UWI6bSkEQuxxCXA+oCQGq7rsgsrbEe63M5uFsMTtnXfxK1MJ4xgtqKEQlSp6YPz4j7KcidyLaJzfEobN2yMZLkoHzXn9S+HNz5zYer3YYZ6A45c1P/48NTRtXAEKPj5/pyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/YR5kOt+6Q4zzkyEaMUPLLLU78+PTuo9LSkTHBvPXFY=;
 b=RncCuF1GuOZI271TDar+bdCe0CKSBbw5J2aKEZ6QkpVqdvQ0wji78DOxB4vPQg60WMbG3Maqz37T7gOjyibC8+AzQFn2zWMvJ+WblS/gFparUkyX3wzZeN045Y3vH9VU8JU555LoXpT99XGyCZ/259PzBN4T+GD0nw3dHfe+xVxaQ63gOhSgO5QjGC7oDkvDAjoMH1T4Vo5vBgsKPAAxgoRUbbt78dcR9D7ZgRw2OFxPUetvOHzoDaRwV7iXESs0megKOuwSbHR4LlQymmqt1a8KVuroM+DR+5JSgGmcbHPTBkmkL15tZ6APSoCbseKBws5CcWkaDSdedcCVZvuFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/YR5kOt+6Q4zzkyEaMUPLLLU78+PTuo9LSkTHBvPXFY=;
 b=Dw6arO/Occewrqs2KlRbNn6V2KA/2LrrqEaqauvD2LyXdRKJQoi0Jz304b13ahSGKKau5fBX7gwdMSgXkLPUpj8izS0+O0FV4MGUvvwoDAenxpCjoOeQ8svQNkCZvKjHECgmgq5PE8vcCREfgckbbu68aVgC3Aiz2A1NGS3Nypo=
Received: from SN7PR04CA0042.namprd04.prod.outlook.com (2603:10b6:806:120::17)
 by DS4PR12MB9747.namprd12.prod.outlook.com (2603:10b6:8:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:50 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::fd) by SN7PR04CA0042.outlook.office365.com
 (2603:10b6:806:120::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:50 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:46 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:14 +0000
Subject: [PATCH v5 17/20] x86/mce/amd: Remove redundant reset_block()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-17-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
In-Reply-To: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|DS4PR12MB9747:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f40839-bb8d-4437-42f4-08dde3fd8e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDd2RnIxTEZTUXcvT1lwTWU0SmY3QjJFdDN3a1djR0pqY3FZd0FrUXBPQU9a?=
 =?utf-8?B?UWFqckFsN1ViQ0xlYkVmMG5mMTVOUEQ4YW9WMUdJWk04STJoMGFaRjJIVlFV?=
 =?utf-8?B?cXNZOFNZbzZGMTRkanN3dTRDVW8xdGtHanA4TU5UT3FCVHRNOWRiUGFyK1RH?=
 =?utf-8?B?NWJHalFYaXQ2MUluSkN2YlJqZkhxelJQUm5haGdwQlpmTkg1MjVjQWhJN3Qz?=
 =?utf-8?B?bjVHRWo4V0pvd1BkU0VtOHo0c0RsVUdWMlU1U2lObTlQOGhwcmk4VXlITFRU?=
 =?utf-8?B?ekFjWllsMW4renVVaElVVmRwanRWNjBmK1JIYmNIYkUxamVKbVVvaEZGYzFX?=
 =?utf-8?B?TlFWazR6aVFvZHlFd2Y3TlpzSTdyaXA5MHovU3N3cjZLd2h6bFFUSWNlR0VG?=
 =?utf-8?B?MkFRTWhHQVFSTWlrdnM3ZzBvUWlXbjhZYnZMWEh0RlhkSmFzZHBNK3pBU0VQ?=
 =?utf-8?B?V1oxU3cvbHZwYW81UExwa3pGR1MvTHBlekFNeU9NS0pLR3ZvdEJWMi9kK3NI?=
 =?utf-8?B?bURJSnFrWFlmUElaYmc1MTdFbWc1RzBpODhQZTcraG1zV1pWbXNMNEExcEht?=
 =?utf-8?B?dThNSHdYeC9JL0FXYjNQUHRYSngzV3BmRTMwd2tJS1lJRWFab0F2TWFScmho?=
 =?utf-8?B?WklVNjgyY2wyZHZnTi9Wak9MWWRvcElCaXIyNE02N3JsUUoybmFYZlNGMks5?=
 =?utf-8?B?cFp5c2RTTm9rS08vdDJCTUY2VkFNRDVPUUVpU0wrOHJTN2FzL3JMSXpjRWtT?=
 =?utf-8?B?Sk15SkEzc21SN204ZEorZ3lLZW80eHV6ZlJZc0U1aURKY08rOE1WdGpEQkJm?=
 =?utf-8?B?c1ZLazNCWmt3SFR0T25vMmNhR0JxdjU3MEQ0SHJJei9rWUgyTnF1YXk3UlNw?=
 =?utf-8?B?ckJlL2kvREhjU1VKbGgvNUttbzBkRXRYWllBdjdaL3FCUS9Pb0xpRGZvanph?=
 =?utf-8?B?cStNaTB4V3NxVkNjWTYwcTZ0WVhvSWUzSGNaTTJSN0R3SzAwVDU0enJ1L2hx?=
 =?utf-8?B?cmFVK2IrMHZpWDdHN1RKU1RCTjNSWVhod1VpVXEyd0VvY3ZRTm1KQzdmRkZC?=
 =?utf-8?B?RSt1aDlhOGJhMXBEc3o3VnBnWmdSVjZOTEtJVERud1JvMTRmSTgwQ0dDWFM5?=
 =?utf-8?B?ZmxNeXRjbnVnc1MzT0NaQ2thNVQ3bHpnK05HQzJnSHB0eStXendNd3I0Tmkr?=
 =?utf-8?B?VmRka3grb1UwNGx3V1FCeXVDNVJOY1RDSFBPa05VdGNnbkZtTC9TVloyMlg0?=
 =?utf-8?B?VEMwcDBJR3F3c0p1bzhiT0VhV2ZYNVpqSG9WUkl4NUpQeFI0L29DVjRzLzZX?=
 =?utf-8?B?YkZTczB6S0JGakloT0xINjh1QlpWVjhwcytMT1FxTjR2U1UvQ2ZsYnc2anNl?=
 =?utf-8?B?NGh6aU1CVER3UEVxWXRoN0M0MEZ0eHpnTXNDSm51VHhkSzFRMnQ2TU5QR1hz?=
 =?utf-8?B?UFJ6Q2xuZFJKTXN4MWpEaVFyQlhmR251NmtjWEptaHdMeTZ5eGhlNjkwSC8r?=
 =?utf-8?B?eW5KVU9EeTBQMy9KNWUvMnBPN3lEV1FtTHhSNHN6Z1NmMnFESXdsTnpLeGFw?=
 =?utf-8?B?S09RUjZqUjFFS0JYb3VNcFBlc3pMYktmWmNRSXBXMkJnVVJkUDRadFkrM2ND?=
 =?utf-8?B?OGs3dUV5cDNoNlk4RkZhNmFVUHNjcFN0a2FLekYrUEVxMGNqbWthYUJUczVB?=
 =?utf-8?B?bHFYZW80LzFFVG9UOXk3T3JhWDArbE1ISzQ0UUw2eVJWbnlsRmh3QVRVZHE1?=
 =?utf-8?B?RkcvSjg4NnQvQm5DOHNjMUNDeFFXUmZFNHdxWHE5TlZtazZOWXM2K1cyMktt?=
 =?utf-8?B?ZWZIU095OUQzQWFyRmtNUlhGSXg4UkNBOUdUVHZZWVNJSUFQdFhESFhFVSsz?=
 =?utf-8?B?SExoVzVOZXY3UUJ0M2p6WUREcnJ2VnJrRUxPWkxXV1VHS0dEQnlUbGR0Wks3?=
 =?utf-8?B?K1J5WTZ6LzNwd3RHTEY2NURXSHNaTG9SczRDY3h4ZEdwZk9JZDNCVEVCNDB0?=
 =?utf-8?B?Zk5kd2lMMkR2MzN4SDhPN3FYTDFNVDlsUXZUd0M5TE5Vdk05bGNkNzI4Z2RW?=
 =?utf-8?Q?FTAZnt?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:50.6450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f40839-bb8d-4437-42f4-08dde3fd8e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9747

Many of the checks in reset_block() are done again in the block reset
function. So drop the redundant checks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-19-236dd74f645f@amd.com
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 559ad5ddb7a0..b929b09dd7eb 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -814,29 +814,11 @@ static void amd_deferred_error_interrupt(void)
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
 void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -846,8 +828,12 @@ void amd_reset_thr_limit(unsigned int bank)
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



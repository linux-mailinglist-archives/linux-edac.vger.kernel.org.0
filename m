Return-Path: <linux-edac+bounces-4219-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D453AE6861
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C727918913A1
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23A12DECAA;
	Tue, 24 Jun 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yLus5xQP"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3F2D8DC3;
	Tue, 24 Jun 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774598; cv=fail; b=mGnvDgVwXMvP4tUxVtcG/FRwyTlrBSmrvUYgQw8uo1xf/fLLSaIdkjsrTv57lfLcS3ZnvYgq2E+amwcMN70FCjH1H5r7qT0cpm1XsJKm1DMVIeFUxKpItW2QIh6Fbjk/9CoxC4zL7xq6yXzljFQKurYWOYHwq6HfqhyitptqYT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774598; c=relaxed/simple;
	bh=liGglePT9VG9HvXwQP3CHIByHGBxBRi6dGu6ErWsDk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eNMJcDn+cvELTb01JrW3Dn5Tbc9KOprAQ7OyvbQePxCreiHmp7OJFQHaHbUNJm39TWKm4UKSY2ohvh6u5Aakt+15DXVOCAbrQfZPZ0BueztGVtcwOUf7Iyq2/ecj9hZ5DxatHim8bZaU/fKEegjZIv/bQ2mn8oMs3XpJmiRyDqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yLus5xQP; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkrjHWsWllv7BkHY6aGr4nXyMKELVIxZh8ct+hpjamUGaRpvZDaowsCKSVpH3dp3MmETE2TxAPYrX4NNI3t4oiqJ8BJVmxxJvqstpLkC3Rld+8EmUfnicIaDxH8QwmymSCpywWqL4zhBjKtZGj5+OjFuEFtodFgBg4oDBvB3ETFGCXJaqBuexgM+/Agehs8c0ahe/GETmswLHGJ0FVEwE9vIJmMjvudukzeweTq2mOQ9srPvKmvJqX0DQUeFH9f+lZfFTL3HjPurcMWkepGodunNyVkix92Gyh1dwNTd+mnm3g6lE0uD/s7Ei7jf2R1KnsmQkN2DXnlR0J3wiBDURQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yWES8a+ryd3REhb7jrntofsfPU3SgRsWUTmB5Aj/x0=;
 b=CYopl9IFTsDlCL9lS2hbjdxxAoAEBU+Qvh/eDAVrT4j1poKmao/bz2jXY5B87tplp3/wwxeIlZsYu/ews7PDYnqoQ5bFTcwkDAGI6re60lpMj7aC6RMMQOc4QkfDAQLDPbXhaLeydUZp9wYC7563bGqxdOcOCT+slXPU6CljDMqa0k98irbKzSgMm8ZvpsZVpGEfl4KcLGVQLNpLXYrLZZ/LTUOYoT2Hg/Hz/+Accoavy5/IruYQHzygwW28Kue9mHjyRVsO0YJ2Lqyld0KE3cC+idl7xy6ISkboywoi4xWck39Ac66ArsfHw6DryiVO4xlFdKn4TBZL38dYbO6vCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yWES8a+ryd3REhb7jrntofsfPU3SgRsWUTmB5Aj/x0=;
 b=yLus5xQPDfwISKs4vefu6cky6Z2jfQCHswmSg1EbuSItQCgNiheA5wA39kmTJPjHZ40+0V0U21evu5CL+fggpoJDiFVThH+j/VzVWu3xJwDBaDCZFEmsXnfnuKKt4tHgjDm8neakG557QOJyTr3x5Xb4Sz94DJ+GFfQ0+KNc9hc=
Received: from MW4PR03CA0235.namprd03.prod.outlook.com (2603:10b6:303:b9::30)
 by CY8PR12MB8267.namprd12.prod.outlook.com (2603:10b6:930:7c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.38; Tue, 24 Jun
 2025 14:16:34 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::20) by MW4PR03CA0235.outlook.office365.com
 (2603:10b6:303:b9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:16:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:33 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:28 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:02 +0000
Subject: [PATCH v4 07/22] x86/mce/amd: Remove smca_banks_map
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-7-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CY8PR12MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdafb79-80dd-4514-5202-08ddb329b93c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RGxZMlVmcHF3ajlOOWRjelEzL2x6c3Q4VGtwL3JBOVpjNll5QXFuSjJ1bVlw?=
 =?utf-8?B?MktFZWYySWlkMG9RbDc4UnQrZDhzVHhuQjBaTldYV2UzaUd0bm9tQ2lQZnRU?=
 =?utf-8?B?Y2pwMmdJUERjdUZseUdKYlpoc0tKZU9ZUXhLSk5yek4ySFg5OWQ3NXpIdlQz?=
 =?utf-8?B?WHFkYll3TzJKM2lNenVHeFpSd0ZOMkFiUGM0T29qMzhDOWdOSzBmZTdDSUVY?=
 =?utf-8?B?TldsK2JIaXJGeUJuTjMwMVNyTDlyVVhxQXRianhjaElYRFhTQVlwZTVPb0VR?=
 =?utf-8?B?VFU1MkR5Qk1mT2hRbVpiVHYrcmI3eXo3ZDJnMS9YbnQvT0tvSEE5NjlPRmZ2?=
 =?utf-8?B?TW1tM29Rb3FmLzQ3bEtYZ0ZuVGp4cTFPM0pvWjhhaXJhMTlCdDVjRGp1NjNy?=
 =?utf-8?B?TnNuSTVZRjZNakZwTWpMUE5IcDBja1ZWV2h6eFZYTnA3ZDlSRk1YckVhMW9l?=
 =?utf-8?B?cFdTbDhPQTFFYUdTb2FERWhaaFVYZGYyZ2FxVFpweEZ5NkFONm1wY3ZESkJp?=
 =?utf-8?B?RTFHbTgxdC9kZjI4RjNacnF1QW5mK21qQVM0TnZDTm9iWW16OUdSd01Pd0Vn?=
 =?utf-8?B?ak0vMzA5enJFNkprbHVMWkRHYld4emNvTkN4eS84WGxScFl1THUvM1F1MkZr?=
 =?utf-8?B?SzNEK1VaZ1I1dHVNMHNOeHlCRVNGMk1vNXRiZ2NMMlB0cVVMdGpmUGlkeVdq?=
 =?utf-8?B?U202cEhFZHBydU5pS3NLMFAzd2dtVi9CZU9SeDVsY1Q5Y0xhZnRUalJZS2pO?=
 =?utf-8?B?QzZDWWNaYVozRWpPcHVFRUFubmJzRmVyS0lnRUFxTmtyVFBnQkJyd1BCZlRz?=
 =?utf-8?B?QWdVZ1FpbHlJZWRkOEJwRmNaTmFzaVpsRUsrTUxvNUVxY1E4blR4dmdsbkUx?=
 =?utf-8?B?RGMwcEFSaDN3emdUWU5YV3FxeGhHMCt6dnk2dENVRFdnQkVDd3B6b2JjUVA0?=
 =?utf-8?B?V2ZxQlZ4aC9mRTN0SkRvUWFRNUtlRmR4aWRwNG5mY1p6MHA3S210Q2ROMmox?=
 =?utf-8?B?UkM1UzVyQmhqVUlyUHB0YWRnRVBId1BpTjhJdUxFZnAxclU4cUN1ekFSbHRU?=
 =?utf-8?B?amg3SHQxS1hSc20xT2JBdVhxZlZOTk5QMDdPUVdrSDUvQXlteEExdlhZWDlj?=
 =?utf-8?B?dlBsZXk2bVFkUHJneFdJclVJeEdEZ0d1cklKSFYwZXdQVW9STmpPZDZMY0F2?=
 =?utf-8?B?QnBSdjlaVHJtekxjYU1jRnVrYWExdjFYaTExZGlJMHRSTkliMmd3Mm1KU1dJ?=
 =?utf-8?B?T3R6aWtZckhaOG1laXlGQmE2eUhWa2VVcllQRElueWtyR2lQOHZ1ZW1pcFNB?=
 =?utf-8?B?WGZadnZRWmFEV29MaHpJMXBsR0ZjanJGQThlSnZJRmp0Nkl2ei9CeHhTQVVV?=
 =?utf-8?B?MmprSFltRFRrenVRVzdNRndabFg4R3J2NHBicy9SZnBqNFJZbURRZlYxYVBO?=
 =?utf-8?B?TXNZVWgwcXRWTDBPcGFDZFZaTFVmc2hOOTJuK0hyYTdXeUhXZzhYT3M4TXBq?=
 =?utf-8?B?cDJTUWZHRG5leVNTNFRlSDY0Ti9mcDBhMWpzQ0tHaVA2cVdLencwNVdrNjlU?=
 =?utf-8?B?VXp4Z0hzUFJhNVNmYTFSSmRFa0dOV1QyZm43SUhheDBHZXJiZm5lalY3WDJ1?=
 =?utf-8?B?OTdXd0RXa3dpYmVNclh4OWU4dXhRakJqM1daOURDVC9TTlFJZHlvTDZQYnNL?=
 =?utf-8?B?ZkhwRmhBT29CSU1JaG9ONlZwdWpGeW5MNXpGbklMcXhxS2VveTRaU1hrYURx?=
 =?utf-8?B?N2EyZ0piUU9rMUlNcEltMzdsc0NKNHR4NWIwclJFMnA4dVVCcHZ6ajBwV0xI?=
 =?utf-8?B?RHpyRGx2RkFGbjNSWEhvM1FXNEhlaHRvRHFOSWhVYU8rR3Q3L04vMG5OUVhy?=
 =?utf-8?B?ZmhTMXR6SXc5bE5UaFQvYm0vTWF6K1lRVnJwT2lndjdWUTBKSi9hZ0VUblVz?=
 =?utf-8?B?S0hhaGdVTW1OQ24rM0o3YXVQQXdydUNzdUhZT0pKSEhKV1J4RFcwNHJmTy8x?=
 =?utf-8?B?SDJuYVhuVTRZc1h0cDFYbXRHRWJPSXRNVHAvdTBSOHRSYVF2WWVhSzBrVEV2?=
 =?utf-8?B?RlVUVEkzV3F5bFBtMHUyakpiRHpIZll0Vzdjdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:33.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdafb79-80dd-4514-5202-08ddb329b93c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8267

The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a
register offset for the next MCx_MISC* register. In this way, an
implementation-specific number of registers can be discovered at
runtime.

The MCAX/SMCA register space simplifies this by always including
the MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to
indicate (true/false) whether any MCx_MISC[1-4] registers are present.
But it indicates neither which ones nor how many. Therefore, all the
registers are accessed and their bits are checked.

AMD systems generally enforce a Read-as-Zero/Writes-Ignored policy for
unused registers. Therefore, there is no harm to read an unused
register. This is already done in practice for most of the MCx_MISC
registers.

Remove the smca_banks_map variable as it is effectively redundant.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-3-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Minor edit in commit message.
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f429451cafc8..0ffbee329a8c 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -252,9 +252,6 @@ static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
  */
 static DEFINE_PER_CPU(u64, bank_map);
 
-/* Map of banks that have more than MCA_MISC0 available. */
-static DEFINE_PER_CPU(u64, smca_misc_banks_map);
-
 static void amd_threshold_interrupt(void);
 static void amd_deferred_error_interrupt(void);
 
@@ -264,28 +261,6 @@ static void default_deferred_error_interrupt(void)
 }
 void (*deferred_error_int_vector)(void) = default_deferred_error_interrupt;
 
-static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
-{
-	u32 low, high;
-
-	/*
-	 * For SMCA enabled processors, BLKPTR field of the first MISC register
-	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
-	 */
-	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-		return;
-
-	if (!(low & MCI_CONFIG_MCAX))
-		return;
-
-	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high))
-		return;
-
-	if (low & MASK_BLKPTR_LO)
-		per_cpu(smca_misc_banks_map, cpu) |= BIT_ULL(bank);
-
-}
-
 static void smca_configure(unsigned int bank, unsigned int cpu)
 {
 	u8 *bank_counts = this_cpu_ptr(smca_bank_counts);
@@ -326,8 +301,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		wrmsr(smca_config, low, high);
 	}
 
-	smca_set_misc_banks_map(bank, cpu);
-
 	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_IPID(bank), &low, &high)) {
 		pr_warn("Failed to read MCA_IPID for bank %d\n", bank);
 		return;
@@ -531,9 +504,6 @@ static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
-		return 0;
-
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
 }
 

-- 
2.49.0



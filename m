Return-Path: <linux-edac+bounces-4659-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D09C3B348BD
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEDBF1A87BEA
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2CC3074AA;
	Mon, 25 Aug 2025 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DxQCQr24"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2350D306D50;
	Mon, 25 Aug 2025 17:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143228; cv=fail; b=eaORNtTD3kKuuZqREtH+cBateYJxCSYw+Tb+sH0SouYSMH/gRtbMSxpbyh1KWZrLBnXUUeAtCsVixmU8907FvG5KHdd5lYqfMuLVs0EqnRhFZkiV8tG2Hm6nDOLUJ9cxzpBX0ZdO5+fubjkF7QL6ngiQNH+pqCd/0+8CcGXjdOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143228; c=relaxed/simple;
	bh=mgRsywZ13X30ULyuIfl4WGmRSC8KQPPlLkyMXF0A7S8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HNq8bpxZVVw74nFcfa/CyHR7DgIeO0CwfW8HNABs8u/jX0hQYtblg+YI7JZIDLcFecjfxfaGvOTLM1c/mj5hi2ECJwG4oaBIPx5NRaw7pcWVZzXDYkBQ9GZbNsyUFrjlSZfUL7fnizq5viWI+8v8eSbhliv5yKKHn93zOpX/bUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DxQCQr24; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5XN6j8xm/OvrzE/YI/fuQ90A8fu8AE56yvXYM7e1NBuiNfsFTgpRAvhrPIdU0GqyiygI7cV+e4knRaefh2ZmtcnASV+s/5w/hejrZtLjKuDGEqlNJHREl2tzeWwCVTStcV0SM3Zh+0Q8bFY8BPRTc9ipEx0EpGTZOzfQyVFB6T4JQHS5CANwJUHKf+RDj0f+E4QyJqfHPWxSRmTLw6L8i80NVp6Fl+QDVWFeL/1QLEZOmT1yVKSkgQnKp1BJIVfE2bnQ7DtMTFlgMFBgolGnyY1PArixsiiBOrSA//DbEaQ7GkY6XSIg3eZ1z2pBHL9lj30R4pl9cgeeEcx1W1aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iR5wgOI4L+8eRgSSiW65P78x9wDRLYOVuOnD0qbo+Is=;
 b=W4FhY+gOKbef2uwybr7p5Av5RxIGGnAurjxih0V1SzFXQ5L9esCMj5Y9XiE73J1x5zTmjGUeLWJ1OLnhF+55KqvFqJuu4kOOzgKu/MKuPix5Ti7ilH71UzhVCEUKxGR7nud4n9mSo2NfJd6+0rkgeHWU0uGxNhYWpBZ0yrj6wMO5QLHu5KZe80HbfTJlAiEw3vWinOI8nlqpyBBOwqZFqQryBoC2cVNfhoS5RLclhEjp4GIs12aoy1g5LM9RfWb0RNw799e0O7C5WCKiPXQky6F8Lg/DQia5Chy31I97lnFN+sDgK3NnP4opLc4o8yXLSJ/ct2sOeiiXwLQxKnIOtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iR5wgOI4L+8eRgSSiW65P78x9wDRLYOVuOnD0qbo+Is=;
 b=DxQCQr24AwHbE/PxKDCSr0aVAw1j5hzEebi0Xu2a57W65E4JOMQcQDhinKPiPVVBqXwk1hTihdBWtXCVBWlDYTsevLhaTjRPNruKn4wSOS0OWAghpYANu4wggjoyDJqQMavloEtfbXYn1eZ3AVgTZ4Gqn/G1muiDSunTplaQ8f8=
Received: from SN7PR04CA0056.namprd04.prod.outlook.com (2603:10b6:806:120::31)
 by SJ2PR12MB8978.namprd12.prod.outlook.com (2603:10b6:a03:545::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 17:33:41 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::34) by SN7PR04CA0056.outlook.office365.com
 (2603:10b6:806:120::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:36 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 25 Aug 2025 17:33:00 +0000
Subject: [PATCH v5 03/20] x86/mce/amd: Remove smca_banks_map
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250825-wip-mca-updates-v5-3-865768a2eef8@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR12MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e817fd5-b99d-4192-837c-08dde3fd8897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clBWeWNpUG5EV3RPc0kwR0NQb2grNGEvTFhZK3Uxb1F6Z2V5RGtqTkdiQ1kr?=
 =?utf-8?B?bWdMZUdiRURkRU5VZkoxY2ltRlpXUHhWYlNEQkJlZk4wWmpJQzlhNjE0NEYw?=
 =?utf-8?B?UFRRSHJ0SHR3aktPS3R3NVZ5cnBFblN3OURQUU53dmcvdDBlTFZiUlg2bzFh?=
 =?utf-8?B?eVBSK04rOWlaZGsrdlFHOGJlV093Uy9QazEzSDZ4NkppN2dCdnRGU095em5a?=
 =?utf-8?B?NUMzV1YvM09YUjBuWlh2dzVzaTZZczJiK0hUUm0rOWdVQlIyc3Y4WTB6SzRU?=
 =?utf-8?B?UEg3aitIUVNuVW1Ibi9DMFJ0bzMwODArVTVJSTJZZEhNRmRUc3FuOHRUTUI5?=
 =?utf-8?B?aVJxUzR1WmdHOCt0Wnd1eWdtODIyYU1KSnRQVm9SZDBzcUhhTWFzbmZJZkph?=
 =?utf-8?B?T0VCdHR6V2lzWDhlNDh2bzlnMk1lZEd4Y0czUlp0VWhMRXY3cGl4VytVb0JD?=
 =?utf-8?B?dU8rOW5CaFNxSE9sRjJHUlFXWmNzZ0lFRU01QXN4WWRhOXcwN2VKNHBpL0JD?=
 =?utf-8?B?dlVHS0daZm1leWxsYUxQYXRIcEdkSFBXdGE5RDB2bkFNUXRXeXVNdnE4MEd3?=
 =?utf-8?B?OE5WTEp0TXA3blBxOHl0cjhLSmZHdkIxNEQrQjB1aytPN01IUjhuSDRlaU9K?=
 =?utf-8?B?MHJ1b0xDOWtnWGMvK3NYU1IwTWpxMlU0U0ZSQkdkMHE2MjdnR29BcjkvODUw?=
 =?utf-8?B?c0d4akc1eUg1UVc3UGwzUUNlT3F2YTR6U2JVMktaS0VlelhXc01OVE9EN3dI?=
 =?utf-8?B?Nm5qSGxWdGZUOGlKZXVYUHZYQ3ExeUc0eWxkVUFLS25lWEg3Q3hSaWF3bWFY?=
 =?utf-8?B?R2VnZGZnSE13T0xhYkNySVdvMDFJYzloYzhMSHVTcytNSFdBT1FFalF4MzVX?=
 =?utf-8?B?alhuMDNqTUJlTTBkWUFnQXBWU3hQck9YNm53cFhhUUQvUHUydzhEZytWSmtw?=
 =?utf-8?B?VWcvUHM3TEdXWVJ1d3NFUW1Ob0dMM216MlhoU3A3SCtXR25XN0R5MHU2Z3Y3?=
 =?utf-8?B?WFRvWTlMQUdZUWZwdVpQczJLNHdtNXZrNC8rUlprMDBadXFyNnNuS1NLTGxX?=
 =?utf-8?B?dUY4Vngzc1dPRmJMQ1FxdXJaZFZpdXVJZ3lEQnlSSVdJeGZXeGZ3UXlRTFUx?=
 =?utf-8?B?bXBTYlAyaVllb1ROczFMOU5lOE5RMG04ald6bmwveEswYndLbHFkOEU1TVpU?=
 =?utf-8?B?YkRaaE4vTEZySlR4MC9uenhORG9WNU5jQmNaMEM5S1RhcFErWHM3MzBFdVRn?=
 =?utf-8?B?d1NsMFQ0Z2g0cFNmVzc2MXNwekhwU2d0dVVMa1FSNU5wZEZ5SERHMGRmVE1V?=
 =?utf-8?B?a0ZGNXl6enpEN0Y4Z3JHVDR4SDlTOWlpSGkyWExDNjAvd2d0TUliV285RFpJ?=
 =?utf-8?B?MWVFOEZlZVBFaDFXUWV3amp2Um43NC9MMVR5Y3hhTU5lZGNHYzB0WTE1Y2ph?=
 =?utf-8?B?dzd1ZGp0c2Z1bFM1US9kYjJXTXZrR25JZEpicjhPZmsyaU9xNTh4aTBWdXRz?=
 =?utf-8?B?YnMzTGVaYlBxbUtUQlM5MmtHWkhmSks3Y3JUNzhmVWMwZFZQYVNuUTdORkxj?=
 =?utf-8?B?RW1yR3FEaFVLdVc4ZjNGSDE1MmhCL3RacVhNZ2NPS09FcFNGbGZjUm1vWXIv?=
 =?utf-8?B?V3NmcDVpdXQ1cGxxNmdENjk5Z2pvZlFkNTNWV1E4dVBSNWk3SVRGZWJ5dnVK?=
 =?utf-8?B?S1ozanBrNENzY0laRS9Wb2U4MHN2Y0xxM3RBN09LNmNrTnYwbzlpMjZjRU1T?=
 =?utf-8?B?Tnh2TittUWU0cWJmK1RLZmROZjBTRDJzcGYyODJ5M0QrOHZiTXdSN3c4M1E1?=
 =?utf-8?B?dnlqUEQ1TXZhL3Z6c2ZSZm5PUjkwbDNqS2dDSW1KbUdvaUpNNncvT3VORGl1?=
 =?utf-8?B?WmlGN0xjY1dCRGdwdG1kVVQ5c3JVTURiNHZyVHlyWGc4UTNUQjRDUU5HZlda?=
 =?utf-8?B?VW9vM2pxSWNQU005dnIxVXMra3BsZHcweUFUVUMweDNmZ2dJK0ZFZWJmdnlN?=
 =?utf-8?B?ZVVTWlRYbU1NSTdGQXh0dEIxT25YcDlGaG43bmVneWtFTEJjL0hmSWhsTEFO?=
 =?utf-8?B?Y2VTME1TM1FhLzhwdVJ4WU1WT2U0VFB4eTZwdz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:41.3687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e817fd5-b99d-4192-837c-08dde3fd8897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8978

The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a
register offset for the next MCx_MISC* register. In this way, an
implementation-specific number of registers can be discovered at
runtime.

The MCAX/SMCA register space simplifies this by always including
the MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to
indicate (true/false) whether any MCx_MISC[1-4] registers are present.

Currently, MCx_MISC0[BlkPtr] is checked early and cached to be used
during sysfs init later. This is unnecessary as the MCx_MISC0 register
is read again later anyway.

Remove the smca_banks_map variable as it is effectively redundant, and
use a direct register/bit check instead.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250624-wip-mca-updates-v4-7-236dd74f645f@amd.com
    
    v4->v5:
    * Keep MCx_MISC0[BlkPtr] check to be compliant with uarch.
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Minor edit in commit message.
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 34 +++-------------------------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f429451cafc8..580682af432d 100644
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
@@ -525,13 +498,12 @@ static void deferred_error_interrupt_enable(struct cpuinfo_x86 *c)
 	wrmsr(MSR_CU_DEF_ERR, low, high);
 }
 
-static u32 smca_get_block_address(unsigned int bank, unsigned int block,
-				  unsigned int cpu)
+static u32 smca_get_block_address(unsigned int bank, unsigned int block, u32 low)
 {
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
+	if (!(low & MASK_BLKPTR_LO))
 		return 0;
 
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
@@ -547,7 +519,7 @@ static u32 get_block_address(u32 current_addr, u32 low, u32 high,
 		return addr;
 
 	if (mce_flags.smca)
-		return smca_get_block_address(bank, block, cpu);
+		return smca_get_block_address(bank, block, low);
 
 	/* Fall back to method we used for older processors: */
 	switch (block) {

-- 
2.51.0



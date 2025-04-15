Return-Path: <linux-edac+bounces-3547-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220B8A8A200
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DEB4440F88
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A34729CB5C;
	Tue, 15 Apr 2025 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1Oieniva"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE35329B772;
	Tue, 15 Apr 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728920; cv=fail; b=qCYTlkPwR6pYCBbTSRqOFHNuHUeEBnkAWlK05WRcLVdo9/7lClkuSuiUu0yCh4xJ2eHk5LcdGJjwfeC27qfdq1G17vMdktcWMVeQ8d6xWG0LQvwZZxm3KCsMTkYPBVUx1aENUbbnYziLm4dAAhIGhwv1iQRA18H11MkGVedzg2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728920; c=relaxed/simple;
	bh=3/+o90YFxMTYrNhqzKnS0FztUlBhyN33QWX22Jkl04k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WIR880BJ3cEuIw9hSx/wUIB5gVeYnAoXj51TQ5vNOM+2E4Kb+dF7zj5RcE+KD7qTwyrvGVY+i2YjUv2g4w8wK3ZENTw8EIUfRPHVTM5YuI0z2v8e/sQtaZZbIKtmB3gTSOrGOEb5y4QQRu3A05r1GMiiqrR51EB68UfbPaDyw/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1Oieniva; arc=fail smtp.client-ip=40.107.101.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpj9sUerl6C8qP1cUeRQFAteNfVs2V4hAMN/T1rRu3HuWpTiZE0Bi1x3a4sd+QiezPkSzcjGYhfdTAusRrLs4ypoylc1+rTrtzuyCBoJ3ctM8Mg2xoqRtKzrt59xsRMHhc7rr6YR1i1GqqQ8kHZXuJTxDoB5KrhWSm2KxpRQ4poRqsZpODeARAFtCvAPGDx/ggP/5UwUn3P0bkkeUdVuhArJApL+WlAx0l3r75BuzsPhG7hk9buIb91vi39p/7dm5IYDlzspnVBXvOXOefo66ymIjcbhQxiZUrpzeJhdiawzF3SKcpuwqci35LnJq8Se+rCNf7BU4Zlxc4c66VpubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ReduzVARG1m+V/PDGKuVMeSEWQNHitJc7MM7egUtkQ=;
 b=NU5xhK+vaJ/QdQ9kcfAYaBv69cNOqiYETJMD+E49KzHmQJk7+knBty0XFsYF4ZyyWs78KB5rBVvmpyXstbscq0y6xuNBER6j3UcPEkEmWWLjKllbjILeCrH0izrfjL3SRC4YQLodsUR9bPGoew+jRKEezmNEIitf1NLi1xXTADiMMYZN8Rmxm7Q+VWw2OPPFPSfG3is8VDyFsq1/4uFP3c3caOxMot6g5PtxngW7s1NfGATrBmMYbTC0q5geJNNjYrt3nYe2ps6mW/UqTEAq9ShcbVfwXYUnk/eDlMaCjRMzj74GxbAXm1R4D4Oxzi3g4RsVvgVCn00Bo9HeGqeYhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ReduzVARG1m+V/PDGKuVMeSEWQNHitJc7MM7egUtkQ=;
 b=1Oieniva0BaBW45HrJSKNqAQnrujtyENSAndUVqZ7AHrDFu2rVt9EakeGaYwedOIlxpiVIflz2lOpG/BZXBOI47qRPOSWFFIlt3rofknJRUGa2BG1Kghj/85WLGfR7VMYJ2G7tW2+P88DitwENukP4MsJsfoVHXqA6wyiU7g5qs=
Received: from CH0PR04CA0103.namprd04.prod.outlook.com (2603:10b6:610:75::18)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:55:13 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::d1) by CH0PR04CA0103.outlook.office365.com
 (2603:10b6:610:75::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:13 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:12 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:54:58 +0000
Subject: [PATCH v3 03/17] x86/mce/amd: Remove smca_banks_map
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-3-8ffd9eb4aa56@amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
In-Reply-To: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: f77c4f6b-a147-47bd-5cc6-08dd7c2d8708
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UzA1UUN6U2RGS1NoaGxLTnVteFVRV1I3NUt3RmM4bmUxT2ZPRFh2bjNLMHE2?=
 =?utf-8?B?aW5pQlN0T0pTRmN5ekNYc3JYUXVjQ2JDNzJDckhLcWxNcmVyRTB1UjNxVTh4?=
 =?utf-8?B?ejk4bXc4elVGSmxXVWRJYjhDY2FLQ1VsenQ5TlJmUkpnQlNFZ1JkK0Y1aW9G?=
 =?utf-8?B?OWZvbGdiWko2dlYxTHRnZkNSaVZMWHU1L1pGL1VSanNtZW51b08wdXNucjdO?=
 =?utf-8?B?dXFiS05LNC9KNjhSd283bEJoNFlsSHcraEpyOWZmUGRSSEJqcTBjbFQ2S2JX?=
 =?utf-8?B?b3dVY1JuSjhLNGJoSDVsTG1qdWk1VjYwMnNlRUZiY05LdjR5bHQyQ2Z3WXdY?=
 =?utf-8?B?NTVBa0JidTNyczFZK1V2aTAxcm9jalVWaUw3Mm95bnlPMVFvRThHMkliWm5v?=
 =?utf-8?B?MkIwSi9RSDF6a0h3LzZodVgzS2lZeVhtcVJYTlJSd1hmSmxRZnNiNGkxVWtR?=
 =?utf-8?B?TFYxaVc4L0EvSm5tOUljdU1OT2dJZTJJOGQ4UlFkUXgyUmo5WE43ZDN6c05M?=
 =?utf-8?B?dGpPRzVwbWZidGdwOVYwb3Zpa0NzMEZ4aXJyM3pLckdCdXQrVmxzVkIrY00x?=
 =?utf-8?B?d0hMOGtiM25LaU9wVE5lZTRMdElSNkdaQnBNb0tOODdKV0E4b1ZldGFJR1JD?=
 =?utf-8?B?ZVlFU3AwdWNKMFhpczQ1TGRNRG1SSmRyeUFTVkhGZHVNRmNSbnFlbUxKbG9v?=
 =?utf-8?B?NmlGOVJoZmM2eTM1RnB6WHRlajJWaTNHNkd6YzFBMGlCRnUyN05uTTJ3OEw2?=
 =?utf-8?B?cHhRRHpocG5OWWo4WHN2ckFCSEl5VWlwSFBsR2R3RzhMNGtUN3h3bS84ZFRF?=
 =?utf-8?B?OVFjclpFQ3llK1luRDNSY0tScCtCS1lPajVxN2YvVXhEdmVud1dCaWxBMndW?=
 =?utf-8?B?dUNsUHFQd1dwbFVvRHByZUhwR0s3dWJncGprSnZFbjByakNSYnh3Ump6OHgr?=
 =?utf-8?B?RFpvWkZ6Ym1mTjRCWW1Nc3R6UEwvc1M4RDcyRDBsQ0hlekZGei9zaGwwVTNS?=
 =?utf-8?B?dVZtVEUxM3BEN3JaSHRQdTc5Z3NJMVVPY2JHSDhwNzlrbE54Y1hjSk53YjBL?=
 =?utf-8?B?YXNzc0tFMnNNSXBwbWRBMVdLQVl4M2YwaUhReWNwREI3aDFJejhPVHVScm1o?=
 =?utf-8?B?QU9oWDYvWE1sMEV4ejNxVHRZSzRPT2NEK2Vod1o1UHZmUkdEN2V2T3Z6eXRR?=
 =?utf-8?B?eXBQZzJ2eEkxZWZQd2QyWDdSaDV0ajJ5RzNiMFJleG9DN1QyMkNBK2U3VmN6?=
 =?utf-8?B?TjMwZ0VQM0MxZGdjQzE1U3h4YXFCdlJRNlE5SEVkbGFBc1psZFlrN1ZOaWRi?=
 =?utf-8?B?T0pvTkhBd2xVaWRaQVBRQ09BRjJ1NW4rSXdkUGYxWWtXNHFVN0o2VUREUExo?=
 =?utf-8?B?RUFmSWtWZ29nblk2TUxQNGNRTEE0dnlQMndvOE42ZS9EK3k2Q2FLMVUzU0do?=
 =?utf-8?B?eFpYQkJsLzhCOWVUVzk1ek5DOFJ4blZ5M3gwV1VhMVdFZnR5Mm1pcTJBZFFy?=
 =?utf-8?B?Ym9JYUhNMXNtR3AwMWNkeWN1MjJTNnk4Q29YK0xtQnBjV0J4amc5ZmY1M0Uz?=
 =?utf-8?B?NWNvMXVETFdsWnpMU3BrK2RBNnFvUlUrZlJXUU9yWGtsdDlqTVowSUtEMGVr?=
 =?utf-8?B?MUhNY3E4NDZYSVlnRUc1VHpDeHQvZXlTaTlBYURHRkt6cGdJME95anBFTWpG?=
 =?utf-8?B?RzRIeEFqb1luR3I3VUw5YTdJNEFTcGFmVUhiSEpaMVliZFNlK3UrdmxXU0RO?=
 =?utf-8?B?Zy95VkRWQ1JJWjdHckgya1gvVm5CTmRERjdWUGpsR2hVdzBrQTBueG9xYjVX?=
 =?utf-8?B?RTUxSHBKMUpFQ3BQeWI0bVVKcFU1TVd3MXpzUWM3NStkZlluakZQYy9rWkJE?=
 =?utf-8?B?NGhOVHZFbTYycHQxYWJ3L1FKQzJhMGdXYWNCRmRNSU0xb2dNZXJiMmw0bWQz?=
 =?utf-8?B?WWx6TW9jbWNNQUJpcnh1TXNvN2ZZMU1pdlF6eHVaK1Q1OUhQVTVlOGFVc3Rw?=
 =?utf-8?B?dHpJV0xTeUdYZWw1ZTZ3UDNzQVlMOFBiWXVucWU2RlVZM1hRb3c1ckJsZ1Nw?=
 =?utf-8?B?ZUNYa01xdVh5WmxiREV3RElQaEl5MFpKRFZMZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:13.6698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77c4f6b-a147-47bd-5cc6-08dd7c2d8708
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

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
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-3-3636547fe05f@amd.com
    
    v2->v3:
    * Minor edit in commit message.
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 7ff479c679fb..46ff41c1b50d 100644
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
@@ -532,9 +505,6 @@ static u32 smca_get_block_address(unsigned int bank, unsigned int block,
 	if (!block)
 		return MSR_AMD64_SMCA_MCx_MISC(bank);
 
-	if (!(per_cpu(smca_misc_banks_map, cpu) & BIT_ULL(bank)))
-		return 0;
-
 	return MSR_AMD64_SMCA_MCx_MISCy(bank, block - 1);
 }
 

-- 
2.49.0



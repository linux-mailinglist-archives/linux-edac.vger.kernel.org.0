Return-Path: <linux-edac+bounces-3062-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E5A34ACB
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCC291893DFF
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4064024168A;
	Thu, 13 Feb 2025 16:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wDH0+Ha3"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D3D23A9B1;
	Thu, 13 Feb 2025 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465196; cv=fail; b=IU/9ieY9a4Mzjp1YJu4qNJhAYI5XDUVyEck+b470+7UNeBD9U/XUXrz+/NcI82ko7I8rXKDZF/Zsg6hn6g1AYxwaKz0PBFnj+XVcUMS/GM+zPGcPX0RKZp0pUnnZq5kIN58vEWInSLH5ozcs2up9OStFLg/odeXVkDC8ZrZuEs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465196; c=relaxed/simple;
	bh=chQVIuLXLKVQXkjYv5UchYWd3VH2HZHnyq3v2zX7zWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DpgZ3JrXabop7rrVSo3PkbWGXgxp9Cyd+ZD1PiQ+DFuqrlYfoHJY2f3v5NFtqbXPezzi8SuAooR3HN6lMHanuBZQl+x3ZHMP43kopHAWTvVtF6C2wbrpJI1bdlPOCCIuFrEhruQlikffW9GX2Xu4ePEDMsbWCpsCg+ZsTmM6On0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wDH0+Ha3; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BaRyxS+TKV8yadYPN8cRiBluh+Ti/hp8n5HCpB/OB62PNY9+RflQt/mqxmKwO0otkjT1Su6HH9mNhUNHy6Tz+GQ8DDV4UjE0ob38jlWcDOTvuJ68Nxe1ZjpYzpsyLQTAXVib3eReTAPXW3y30T/zssdrBWo43fFvO1GD9lyMvaMQTjH9f5cahxIEOyStynU8qScEPgEazQH7zF46MeBV0EDTyR69Yr9wgnt+fg6RvfXkobOulLx52R3dUP01HUlGBacIZq+yhdptRhBHWA5cuYd3g5fORH+USS9ShA8zgG/FI+sq1xOD4ipzVADfDPBx5/cZns0Th+4ZmVy3cNXrWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf6VoZ2b6Kl6W+i1gUSGrMJuppy6CtGCYHrgan/miIE=;
 b=b4T1QTZyw9aIkpFuEnRJ2ynYFNkZpGEfT0vToBV/3yShpPH6a2FEHRxRtTsIdwhoF8PEg8/a02e7eelt6+NdYCa5HG/4QFGOHfmFCvKnrlndpNYpxtRvBz3d1xgiIX2WzAvTD+q1LVCGzWvH9Gs0DGA8tUOap+p+NvCv1nlBT53j30PTKRpMkJbMAz+8njgKPpRjWEUPQJtxtLBZYdmYy3yAeeWm6wKiiAXxxMWlzEvFU90npxR7G2iC/Mf/A31O6Xd3Dajh0Fbj8MpyQTDulxRmBplp6mo45eTrzJ4mLjVfyXjendMzq3lOZLTsxyMYLzBrdeEU+BCsHR55TXGZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf6VoZ2b6Kl6W+i1gUSGrMJuppy6CtGCYHrgan/miIE=;
 b=wDH0+Ha3qfR2ZGRDpWUWOf2Y//ZUTq7LHXJ6CFO66d1InJ4szGT1G8VQpA8tt303RSYnWF8BXwB/O+3/4O3HowflYlNB5r+56JKgUbv6d5cHtPw2mRUrMFK8bVOzb58xLoQ4XPfduPfLcS+VGMDsqKmuEroWlLLG0cM6FiOy9vk=
Received: from DM6PR11CA0006.namprd11.prod.outlook.com (2603:10b6:5:190::19)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 16:46:27 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::36) by DM6PR11CA0006.outlook.office365.com
 (2603:10b6:5:190::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 16:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:27 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:25 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:54 +0000
Subject: [PATCH v2 05/16] x86/mce: Cleanup bank processing on init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-5-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 8294c072-4657-4126-2f52-08dd4c4df5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnVoQTdONlJ1U1hFS3hYVDhjM2lNek5rMUZHTWc2WVd6cnZLMlczYytxbnpo?=
 =?utf-8?B?cm9mTmk0MG1GZWl1ZFBzMjV1aG1MN3B6Z0d1Tm5EbHVzSUhxZlhBSEI0MGE3?=
 =?utf-8?B?NURyTk9Na0NXOHlmQkRCd3pGaVcxSytESUpqNnNRbTc0OENVWTlxYndEMXhS?=
 =?utf-8?B?cGUwMDVDQW9jRm5zcFhMeEZNZ1JmcndjRDliWmh2bmt0bmhUZ1RXR1lPRHdv?=
 =?utf-8?B?MkpNSllnT2lxMDk2aUlRS3dWWWF0SHBmOWo4N1RyTXlYT0FUVWFSOHdaQVB1?=
 =?utf-8?B?Qks5N0JORlMvektMMVAraDlxNmtnNll4Tjd4NTRIclBvWCszcUp0MGZRSXF3?=
 =?utf-8?B?NHZWRkxOU0VRNVJ3Q0FUSUs2N3hwYjRUQ3VEWUFjQVdnUUNsYXZwelZXUjdE?=
 =?utf-8?B?emNGVk53dmxwK010amNEL1o0cU1RbTV3RHlmT1QxeWN5SmxqS2d1dVE0SlYw?=
 =?utf-8?B?MmFGdjYzWlVMT3ZZRkZJN1U5R1J0MU4xL3JmWnkwRFpPZ3RxeWhSTUYra0Ir?=
 =?utf-8?B?aTFPNlpjVmF6bzVGSEJpWVlwN3JPUDk2dHh0MlA4L3hZWHBOaW9oOGtzdWZD?=
 =?utf-8?B?MU9ncGJ6K0dVSHdSdlVKeGo0Si9JeW0wemk3b2lnWUUxVXFpMVB5Mkg0N2Zx?=
 =?utf-8?B?ZzFFV09hVytaS1VsbmR4S0l4U3JPc0J2N0hUUDVSQ3haVC9DQzdaalNxVS9O?=
 =?utf-8?B?N1U4bWxmVEoxZ3RQM1k4KysrUWUrT1NjSm1nMHpmaEhuRW9ZV3ZlQlFyTTh1?=
 =?utf-8?B?R25nWkp3RGJLUTc5RHJieldpaVM5SWRMRTUzeUtEcmthMGVzbitYcGdrYU9I?=
 =?utf-8?B?Z1dkazRIb2hweWJaUkk1bGFwaHdxMjF4c2V4ejNTYzl0OU0yYmV0RVkyMzNT?=
 =?utf-8?B?bTAwWTB6RC9tdWc5M1gxTFhMWlRtbkZhOVFGaEt3ZVZ3MkZrb0Rxbi9HUTZG?=
 =?utf-8?B?ckx3L2dNYkRTOVN2SjJZTWxrUS8yZEV5eTZTeVI1c1YvVWZNd1dzdTBkTWxh?=
 =?utf-8?B?REJjV0t0Y3A0SjVvQ1pSQTZLRnR3MnpVdVZCUUxwSXpYdEFUYlVWNGVPK0s2?=
 =?utf-8?B?c0RZTHl1dFFBUkkvZHFKMnRZMVBDWjA2RGJXUW5jaytrWVhzQXNYc2diVnl6?=
 =?utf-8?B?NDBuWU1yUU5WbzhxQlZSaSt4VHo1RTJmaTZpSm0vOFIzV0VPNW5GNitsYWRK?=
 =?utf-8?B?b1NSTEM2b3ZtLzlkbkhScTVUVjN5cUZ3QjNCazlSNDh1NUhoVDlBR0pOUXFH?=
 =?utf-8?B?US90eGk1VUErVDhRNUpmcUE3SHl4ZGVCMnNaWHFvVzB4d0pjRWNlKytNSWQ0?=
 =?utf-8?B?czJsU29aRGQvWTJpTzczT0ViUHlpaGdhTnArQ3ErbGhnTUJBZWhVSWlnclBU?=
 =?utf-8?B?VytVUTBKS0ZxQ25IbGhRWmp0T1FScnBKSzdWSURVZ1h4bTN3RlFDU01XRG50?=
 =?utf-8?B?ekxPWWlUZVVveFFTb1hLVVErZ1Fla3hhRjdkazhhSjlOUGZhMklLdTR1N1VY?=
 =?utf-8?B?K0RGVGtpcjdvNWt1TkJvdmwvNnFBUGJhVzJodTZFMmQyUFVCanlmSCsvZXVH?=
 =?utf-8?B?Y1JrZERjS1ZXUytldFM0TlhuVmpVRUhmYmNVaWx2Nk9lN2FSRWNFNUE0RzQx?=
 =?utf-8?B?U2hRS3E5WXVVdERtd0dnSnFwa0hLSGJaWHRmOTduYVFaa1BJT1BtVkVaSkta?=
 =?utf-8?B?cnNwd3ZucWV3Z2tjb1JoQlkvZjNQMEpxcXQ5WWttQ1lTZXRIbisxZjJWeGpp?=
 =?utf-8?B?RmdweDVJYjlLYXZHc05SaVFCMzZiTXpCdE5JSU5VdlBRMk1yTFFVWHVJaDRP?=
 =?utf-8?B?SjdSdktnZFRDM2NPWGhHR0VwUm9RMlBkbURIOGQybFUwR21hcWE0U0ZlR0h2?=
 =?utf-8?B?dUtnYWdISVdIK1R2MVlYNE40TzUwUzFXZFQ5RDVKdVJRVHpJUmdwWlNKaWlp?=
 =?utf-8?B?c3hOcXBkMmg4VEZKeU5RbVYyVUlxR1lhQUhuVzZOcG1wV0dJNlU5YnpWWlpV?=
 =?utf-8?Q?nCGro3z3/GQ8LjmruAIJRuJY7/IIGg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:27.7474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8294c072-4657-4126-2f52-08dd4c4df5ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767

From: Borislav Petkov <bp@suse.de>

Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
that function to what it does now - prepares banks. Do this so that
generic and vendor banks init goes first so that settings done during
that init can take effect before the first bank polling takes place.

Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
as it already loops over the banks.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20221206173607.1185907-2-yazen.ghannam@amd.com
    
    v1->v2:
    * New in v2, but based on old patch (see link).
    * Kept old tags for reference.

 arch/x86/include/asm/mce.h     |  3 +-
 arch/x86/kernel/cpu/mce/core.c | 63 ++++++++++++------------------------------
 2 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 2701aca04aec..36ff81c1b3b1 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -290,8 +290,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
 enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
-	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
-	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
+	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
 };
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index d39af20154c7..d85bd861ecca 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -785,9 +785,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		continue;
 
 log_it:
-		if (flags & MCP_DONTLOG)
-			goto clear_it;
-
 		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*
@@ -1807,7 +1804,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
 		b->init = true;
@@ -1846,21 +1843,8 @@ static void __mcheck_cpu_cap_init(void)
 
 static void __mcheck_cpu_init_generic(void)
 {
-	enum mcp_flags m_fl = 0;
-	mce_banks_t all_banks;
 	u64 cap;
 
-	if (!mca_cfg.bootlog)
-		m_fl = MCP_DONTLOG;
-
-	/*
-	 * Log the machine checks left over from the previous reset. Log them
-	 * only, do not start processing them. That will happen in mcheck_late_init()
-	 * when all consumers have been registered on the notifier chain.
-	 */
-	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
-
 	cr4_set_bits(X86_CR4_MCE);
 
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
@@ -1868,36 +1852,23 @@ static void __mcheck_cpu_init_generic(void)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 }
 
-static void __mcheck_cpu_init_clear_banks(void)
+static void __mcheck_cpu_init_prepare_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	u64 msrval;
 	int i;
 
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		struct mce_bank *b = &mce_banks[i];
+	/*
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
+	 */
+	if (mca_cfg.bootlog) {
+		mce_banks_t all_banks;
 
-		if (!b->init)
-			continue;
-		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+		bitmap_fill(all_banks, MAX_NR_BANKS);
+		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
 	}
-}
-
-/*
- * Do a final check to see if there are any unused/RAZ banks.
- *
- * This must be done after the banks have been initialized and any quirks have
- * been applied.
- *
- * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
- * Otherwise, a user who disables a bank will not be able to re-enable it
- * without a system reboot.
- */
-static void __mcheck_cpu_check_banks(void)
-{
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	u64 msrval;
-	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
@@ -1905,6 +1876,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
+		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
@@ -2310,8 +2284,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2479,7 +2452,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2497,7 +2470,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.43.0



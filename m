Return-Path: <linux-edac+bounces-4223-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF08AE686A
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C41FB1895CD5
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EFD2DFA37;
	Tue, 24 Jun 2025 14:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TpFIz6rM"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8AC2DECB4;
	Tue, 24 Jun 2025 14:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774601; cv=fail; b=iWkdJADVKBlqrCans7EjZH288Yq5Qtwz4uLwkmkw4EGojzIaC4vTwNlNn7w1zPoTO1PoFMg4j+mvgZtHGu7587IQKz77aAWDSPcrsYWkBqRFXAxGKGhm0dMqFnZqJcNSTm7dk3pDEnS92adne0cwkwChq5dBdXn4CmOYZKI2SYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774601; c=relaxed/simple;
	bh=RCSFoip5d9yz84EdTnlujnp/QvQSuxN4ThaFuihHNe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=S/x5iXo6XI9KXlbtTZc4wqiLqUqZ0MeeK5Bv80s7AxpcrBbU3JVKgQpLK8arewJbO57U0lE/Lkx0K1Yi5KCt1JMFZ5bLJtgz2hYb1G0DnxlyDXLfYdxT/3IhDsQ+ebW9AB+8dhUkZEax1UgaTWM7pG0Lhk7DTyd892hZlffGYp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TpFIz6rM; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSZVMsflB/zZa5TrWPdnc6wq6A4Vu+3ZJA+DL6qWYQskc5u3ogHRFE+Uhouk9kAtDvaIRpI+j40m4foEF3Cms0o4BqwV2Dc2eke1BQE3qAG0TQBbK4wh771pb/YT9jDlmJYMJ6Er05KeJmrAq7ou3Ath8Fympqfzd7jByWV6k7iWNwP1rv0Jo5C2fSpf/rBgQgfqdPu39InGOu0OfaHsFKMqPSvrBjoF3eTxW/IXcdbqAHxdk/u/XQCncbp0vSaRhqYHDDpge3sd9NproGpfkeEm29tzUt4FeI79KJZ5iHHc7PnZADwQLsRTrFw1Zkk2LUApsfmgJqwcb4KzNkb6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P13giJnnIZznlZLsPwq+qWANtKA2hjEc8r1VvvCfSRs=;
 b=mic+ukOJkkE+uFoKCiJQ/EiiyqWWbp7i67qg4sDXffsKKmh25/liLfsJGdHUzbA9404ygNEXt2lX04cSzFNUKasXN1HS7FQTuzF8wNTwsGMDBPPIlqLdeFS3NQ5T8vsvEUaPMNNFOKGzUWhWEmbnrj3eWPrn4fXhpSlqAC98lZ7oybWJTOi8dbJlL+6GOL9gEuerGeixktNKOvyIE7J9V3oxIQzWWzuzMcGpx0tPynaGihOIEMbgO3GO/pOYIjlp6Yo0d2hcCtBxVOmBB/dOyjcT4Lp/vhkHmPGKUzryjM+HXkjerc4oOJvo+IbWrWQY1VsiZhXVu/DfW5UKJANcEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P13giJnnIZznlZLsPwq+qWANtKA2hjEc8r1VvvCfSRs=;
 b=TpFIz6rMLZkpBRfP2lnE/U/hm6YXW3UntSnv4urpSGBwie5qmh2kNyjBfKydvzr+2ctw0tdetLx1LMsdSbWUIb5sbLrmFPYpBNhY6CsjJRjblU09m3Q2/Y4h9+PrWAMPz82sa8El95AUw6gISVt+VSse4V6ixIq9qifytsLQLgE=
Received: from BYAPR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:74::29)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Tue, 24 Jun
 2025 14:16:37 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::77) by BYAPR05CA0052.outlook.office365.com
 (2603:10b6:a03:74::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:36 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:30 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:04 +0000
Subject: [PATCH v4 09/22] x86/mce: Cleanup bank processing on init
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-9-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: f80c2c3a-81b8-4afb-ade5-08ddb329baf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2ZyTHlEckt0QkJBNXBpbGJobTEvVUZFSU1XalhoWlE0OXZtZk42YktnZnp2?=
 =?utf-8?B?L2FhRjFhQ1lHQXJnMCtVcVNoTU1GZFRVeDBDWUNQNWRpdi93cDFFUEFKTm90?=
 =?utf-8?B?YUppaGpybGJsYkV1MnBwZnZMS3FTbWdxcCtuL1JIeWg3dWhBRUdzclVuREFZ?=
 =?utf-8?B?NjZFQVh1cTd0V0lVeEJmR0ZaV0piUVU2N01vbkJsV2t4MXRMZUlKU1VTemtP?=
 =?utf-8?B?dTR5Q0FDR0RFY0NOWDJ5RjRpZCtzRmp6ZkFnTzNLUmZDZlhJNGJQVlhwTWRH?=
 =?utf-8?B?aDNPMDZ1d0kvWFpCWWZJV0xkMGtaUGhhaExhd1AwUFZKOGxxdnljVlpjQkNB?=
 =?utf-8?B?NzR2K1pJdk5OWWFMeURhcXBOdklEV3poUFRqUlJnazYyS1JTYlBVaTBOMHFX?=
 =?utf-8?B?YTJFK2pHS1AzT1ZsTmVRV3FVN2JuWW5iZGtJc2h2RWd4QWovY2ZOczBiNXl6?=
 =?utf-8?B?bWxpNktBZjZncDdiaU12MFpJUXcrRVJoaG1lYS81dWtGTldvRi81UU4zelk3?=
 =?utf-8?B?MDlKVFFmUkl2QU5OcVhVdGlrQ3RLRlg3c29yM3FpWm5FUWtVQi9aYjdjTjRC?=
 =?utf-8?B?RTIvZUljTmt5eU9lZU9qbHE3SGJLbmVrdlY3OXp3VXhHMkVQS001em5HQVh1?=
 =?utf-8?B?Q0Jnbnlqbmx4V2tMcTVFM2RJaTZuNHFqQ2IzREkyTlhNNktyTGZ4c0ZmNzBz?=
 =?utf-8?B?aHVKOU1xeGZrZHdKWGwxZkpkcUhOY3U2cDdmcVBJMndzRzBEVjBES0JtZWdK?=
 =?utf-8?B?ZjErN3FJdkNVOHBTQTNRbEc5TWhRQ2dQWjM5Q3lvcVg1SjZ5aUk2Z2pRY0hH?=
 =?utf-8?B?THR5OXc4bjNISmE2MVMrcXh6NWFZb0hGUkZPMmx6QWdhZjQwdSsxWFMrNXlk?=
 =?utf-8?B?M01NUjhqMjdwWGZMRHV6V05RQTVpcXdtZDNaQVR3bGduNC8vNTJIdE13V0Yv?=
 =?utf-8?B?UDV2UHZxckZCaUxFZUFRTmg3enJkTG5LdDBaYzEyL1AzcWJLY0pEVFJCRXp1?=
 =?utf-8?B?VkU1WEttOS9MelZ5c3YrYm9JaEkwRERQSnZ3L2pCZVZCV3g0YmtJaHo4SGhC?=
 =?utf-8?B?clJ5dExabWYyWjJ3MlhtQVZJclp2Y1BzVmU0MU82cXZEMTExTllnQUVodEFu?=
 =?utf-8?B?dytVQmNUOHY2YWw3WXBDS2I2RkNvV0lOLy9Ja2xsZDRWc0R1djRnVUo2UWRM?=
 =?utf-8?B?bFF0ZHlhMTNIMEVmczV6T1dieko5Nis4ZDlGa25tUldkTE0wV0UrYjFNbnRB?=
 =?utf-8?B?L2Nvam5MWTdoZnBBRVFjOFNFSW54NTBYTjFrKzFJaGFIZlFteDU5WE9KOUI5?=
 =?utf-8?B?SXdxcFBDUExqeEo2cHIybWJWbXhwTlRDMyszRi9iNkhZYURqdytEak5iekxa?=
 =?utf-8?B?N3M0QTkwVENnRUNsMm5YQTNnMWJkTXNoU1p5MnA1L3lZTEJFWEJvdEU5TVhE?=
 =?utf-8?B?YWhPeXB4RG02cDdCdm1hVVR5ZjROZ0VYZ0x0Z1NrSDFlMDYvR0RYT2hhYXg5?=
 =?utf-8?B?NXZzcFZyTWZLcGlrcXNqRXI3enRrcWZiZGxUNWxoSzBEYzVXelZkWWUxQ081?=
 =?utf-8?B?akdDVVpveU95VmMwVDNKbnB6RXlDeFV6eG9WL084Y2hJUWI3SG9XaEFrM1BT?=
 =?utf-8?B?ZjlIamhaNis3VlRJTHB2NEpRWFFkYk4yMEVrTGNiS2piV3ovd0d3S2EyQ3pX?=
 =?utf-8?B?dVlXMFJpUTllSXN5cXpDbXdIaE5hdW9kU1IrSWhIeVZRZkpkTk1nd2dNL25u?=
 =?utf-8?B?VFBXWW5Mck1BT081QkFjMXRzRkhiRkJ2V0V5SGZRVGpnZ2hFeHRsZHhlS0pQ?=
 =?utf-8?B?RkkwTU5GNzY3ZEhRV0pkcDZ3NGUxTktjb2xQdVVRM2wyTVlzRHh4akFsMDZR?=
 =?utf-8?B?WmdHZE84QjFKYXNPUEtucW9pVXRveERGb29WVHVTZ1YrNW1MZ1J3NktGNTVJ?=
 =?utf-8?B?UjlLMHRtUnBGZ1hFVWJ5bmFSNy8xRDl2L2VmTzRhcmw3RzM0WmY5bEY2OUFq?=
 =?utf-8?B?L3NHQ2pqdEROMEJrbjJPeWtnYXRzY2JZaWFTd2VrSHBNOW9PL2xVNXY2ZVl1?=
 =?utf-8?B?OERqZ1NpdFU1RVdqTGcxTTZScWFmbVZRV09hQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:36.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f80c2c3a-81b8-4afb-ade5-08ddb329baf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

From: Borislav Petkov <bp@suse.de>

Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
that function to what it does now - prepares banks. Do this so that
generic and vendor banks init goes first so that settings done during
that init can take effect before the first bank polling takes place.

Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
as it already loops over the banks.

The MCP_DONTLOG flag is no longer needed, since the MCA polling function
is now called only if boot-time logging should be done.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-5-8ffd9eb4aa56@amd.com
    
    v3->v4:
    * No change.
    
    v2->v3:
    * Update commit message.
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2, but based on old patch (see link).
    * Kept old tags for reference.

 arch/x86/include/asm/mce.h     |  3 +-
 arch/x86/kernel/cpu/mce/core.c | 63 ++++++++++++------------------------------
 2 files changed, 19 insertions(+), 47 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 752802bf966b..3224f3862dc8 100644
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
index ae2e2d8ec99b..486cddefaa7a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -807,9 +807,6 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		continue;
 
 log_it:
-		if (flags & MCP_DONTLOG)
-			goto clear_it;
-
 		mce_read_aux(&err, i);
 		m->severity = mce_severity(m, NULL, NULL, false);
 		/*
@@ -1812,7 +1809,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
 		b->init = true;
@@ -1851,21 +1848,8 @@ static void __mcheck_cpu_cap_init(void)
 
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
 
 	rdmsrq(MSR_IA32_MCG_CAP, cap);
@@ -1873,36 +1857,23 @@ static void __mcheck_cpu_init_generic(void)
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
-		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
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
@@ -1910,6 +1881,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
+		wrmsrq(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrq(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
@@ -2315,8 +2289,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2484,7 +2457,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2502,7 +2475,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
 

-- 
2.49.0



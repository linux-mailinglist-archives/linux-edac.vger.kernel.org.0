Return-Path: <linux-edac+bounces-4755-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85354B493FB
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3747A442B9A
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3D73126C6;
	Mon,  8 Sep 2025 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DP3995BK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F3A311C21;
	Mon,  8 Sep 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346076; cv=fail; b=FoCzEpHxZwOs/jtrBuEvGlWZfkloqUeDiLSW37LhjFUoOP2N88QJ28dxEmncTvjYx43WlnsT7/APIU5QfOLKG5YL4HNnfeDdrQxN6kYmZ4bKN4zf1wi7NP1fe5vdEcp4xleb2/IzBdKVIrzR/kVYN45huXQHS5PGAdptxORvWsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346076; c=relaxed/simple;
	bh=Mf8jnSGE48vC1vtZXaxgRnJfT9clQkeM7bjbNKI1fgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=T/fNH/6xMEmO6tsp+6Msny1Ez/3U0carU8Fqw03IKUC6h1JJBP+O6xEc8xGRnmV9VCcSwMF9CJTEi8kSH71aPtEefEN+urI5YU+WDVQexlrFfutJ1Z7CeWn49ac4+cjW8Nsby0ja29yDcc8vHMKchA8G2MiCQJsE38Al8MrylX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DP3995BK; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWB33qZi7B8X1j8gSTSb7hXmZB8IIcdlsNRJ1uyLDrUDqUhc+I6M8gYVTKQK9h738mPSOYJlnGMEv45xczIprOHTjXtClUMiOeadAhW+sDD0hpwU/yoBhb8J/NZC8F/RboY3WFJ6KxUByoGBOfDnO3TNsSWFmT4B0y/k36v5V+Nl6LiHtq5XoW0nWZvblT/b/OVu5H6GkwN0mSgKzyPxHVflMLb282zvXxdSHsdIqYiNnV2aexrX4SOy036xzN4R0tj26NPWpTjx70y4KWtPrJplAwCG9iQcmbMSeuqUkKx/JET5vTloUbZe5mmT+pfAPNJH3ki+birPdzPO0V5Cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lc3fv4LjD8ehesqCTS+NXmGai1DzGuUZn/V0rrmNHpY=;
 b=HiPOx8ppiR/NXaOJYM/WDI3kPESimhuJakhtYpnIsWobYDmpJ0+er3PgNQgtMsZqzHBOU9Xpi5K3dCedarwXPMRKbYt+3K5E1Huzf0lb2gge9TWDdb3CDskRklF4JxLf4Rv/ePLSjrEP+jB0P9+dKPUxo7vyj1BK7+na8JT/CBwmciJ3H1roxOmvz0BXGYbgWxfyH3e+beI9r75WEz4Vxv3OVl0ckgp3wE4NXBVvqp731Nzx+yiAM8NSHLnfBYZrU9i+3cdifVd8WFyZ9OXEMJb1zV000C1UwlE5xmUrLLb3Vz0Z8EFAUrn+SW+jsrdng0RSbiOR886jYgGLaTD4wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lc3fv4LjD8ehesqCTS+NXmGai1DzGuUZn/V0rrmNHpY=;
 b=DP3995BKcI5GoJALvUkFtME0BTOjilqfXOdKFetg0bl0gdKZpMigy1Edwy4AVlgNWpw8JnpRHNqrCjbvUkhYuYwDbAzE2dfGawhbS5jp33yE6kX8JUgCAnhC5CKwvHxCbSGjFvoqfC0INYD4mmu5AVbPhYGszzbB0jEYv24BDzU=
Received: from CH2PR17CA0022.namprd17.prod.outlook.com (2603:10b6:610:53::32)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Mon, 8 Sep 2025 15:41:07 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::7f) by CH2PR17CA0022.outlook.office365.com
 (2603:10b6:610:53::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:41:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:41:07 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:59 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 8 Sep 2025 15:40:38 +0000
Subject: [PATCH v6 09/15] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250908-wip-mca-updates-v6-9-eef5d6c74b9c@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a47138-fff9-4e27-18f2-08ddeeee20cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm9oWThmNys4V2Vwd3hybFk1c1JoRGFGY00wbHFnOW1VRnd1Y2xGS2tTNkNJ?=
 =?utf-8?B?VjlxbGFEYkx5ZXpRRXkvSUVrdFZPRnZQWXNOakZyVWYyMGtkRm1MemdvVitu?=
 =?utf-8?B?QlFWSFVoVExkdW9iQTM1ZWxnYm1kZlpocHZOZmExMDUzTE1jY01sM1ZKS3Q4?=
 =?utf-8?B?VXdzNVYwV0VoZ2VRK3NyUWhLeVJVWkJxdlpRYk5XNGozQWNFUHVrRVhOL2RT?=
 =?utf-8?B?RTNjY3JEZTJuL1J1WEVaejk3ZHM0bWFzWTNnK3Vad0orY0dvbE43dDlzQzRL?=
 =?utf-8?B?cGg5K1hoeWtWeVdTTktPZFpkd3cvVkk1V2tEQnVrS3kwc1RqNm92Z3ovZWZv?=
 =?utf-8?B?Mko2UmpYNzNHQlJFWXhFWjJsUmZDamxDYml1T3FNZTdVUmI1eWxvQ21iVWxk?=
 =?utf-8?B?b2s5Rk4rcm1iZ0lGTmJ6dW5Oc3BocC9zK0N5Qlgxc2c0ZGlYcGpWMkE5bmh3?=
 =?utf-8?B?aHN3NGI0TjBDUXRzWWJybVB1aGN4OHVMbGc5OEk0YnRHSlNKRmJZc2Q3TWxl?=
 =?utf-8?B?VDRmdFhvVW8vaC83bXBscHZHL052V2lXaitZYit5TXNQVzMzZVdTLzR2OEdQ?=
 =?utf-8?B?dTBlWlBmbTVzQ1pxSllYT05uOHBDbXQ0TTF1L2FvTTBoN0FvZisxeUZ4MEZI?=
 =?utf-8?B?Ui9MNkg1MUgwK1ZqcjJNZDczYVhYSzBhN1hqQS9uelh5TnBmRmhXb2dIZTA1?=
 =?utf-8?B?UmZmMkw4SzMrVjEzQXBjSUZkR01Wd2lCWldGbU5tNUYvdHNyNFJleUZxeTRC?=
 =?utf-8?B?RGZuVEx2SWxxaFZVWkpIWFZSYnpkMFRuLzZWOVpoemdOS2txRDhlQzJEWWdt?=
 =?utf-8?B?MnkyTHEvRWJFekFJVXhiVkl1bjFZNjVkaGZvN1RwK29GbVlrU05LVmVsSzhN?=
 =?utf-8?B?S1RFc1ZOVXB1UGhGMzFvMWNDa0llRDRXOWtmbCtHMHBSWW5RRStCSkY1QWJP?=
 =?utf-8?B?c3pCSDVPWWJKSlI1RFpkT21ZcER2enV6RWlNSVlQRFZlRk5va2hJd29YcmF0?=
 =?utf-8?B?S2czVXdUb1RKOTRCZFZGMlJmR0lqdUx1VEhyWXdVdDRSUUloVkpQMHdlODk0?=
 =?utf-8?B?dElBVktUbnovbkhFMEVkN1dTWFRGTFZwbjF6Rmk4WWRPV1EzUWwrRzkxWXZy?=
 =?utf-8?B?MllFOU1HcnVMNlhLaDREcURNalppdVRqcGFlMlJKeDhRN0t2QThjVWEzNW1a?=
 =?utf-8?B?bDZrTDFPbUlzOXVvVkNXZXRzeDBiMy9nUFhtTnRrWnZZaThSMTZIZ0UvRmN2?=
 =?utf-8?B?WjRLUGNQQlhnU2lZTlpQM1dCN1pwT0p4d1A1S0JzME4vaDNkYi9jdVNVVzFu?=
 =?utf-8?B?bU4wSFUwWGlqVVhIdlpzYmRwRHYyMitzN0VRUVhyVDlSdktLOXRhemVQdXgv?=
 =?utf-8?B?SEJzeEVxUmtPZ1lLUkh5ZkNwaDBGMmtwZDI2ZlVJL1p0VkhCdTdONGkyRFhl?=
 =?utf-8?B?MXJXUmU3a1Y0ZzQ3dWVTNDEzU2QxUVlieWk2YVNHUnpkZlVRbFd4S01IS0x5?=
 =?utf-8?B?OUwxWXplMVRmZEh1NlpHU2hZU0RKYVZycSs2NDF6VDhVQzdTYUZlUmNRdisr?=
 =?utf-8?B?cHgxUW5FRUNXaXZwV0Z4RU1URzU4b3VERnV1Y0x4MWN2VzhXYllJRDAxRWZX?=
 =?utf-8?B?UjhEdzdnY29ENUl5SWRDK1ErbS90bFV0NHN3dWd0NVo1bnllQzBiUWh4eVRL?=
 =?utf-8?B?dDlUV3JzaUFaRGpmSWh0Y3diYUtKc3Vzb011NFc5R252c3ZKYjBNNnVMamE4?=
 =?utf-8?B?ak16NEpTYzJVNkgyYmY2OEFoZnB6d0xzYi9iV0E5L09tTlM4NXk4Vm5qcCt2?=
 =?utf-8?B?TXRpMkZSczEzakdYNlFoNEtxcXhOS3BhbFI3Rnh0TDB3eC9SVzRNNm1BekhO?=
 =?utf-8?B?MU9DdFIzbDU4R0MxVWEyWnpoSlBLUkZwSGxZNFMrYzJpbHN5MHBxMHFNdTZF?=
 =?utf-8?B?aVFnZ1kvbUlleVhYakJydTJub0hka3FYcEZ1SG9NU2hHRjFvWlkrdXFqUGdy?=
 =?utf-8?B?SkIxbFpUSDBxUnhXQzgyd0RwYUg4ckJXNmc5UzFQa2dwbXF5UldmTDZXNGNr?=
 =?utf-8?B?NEF5ZDExb3R6NExDcStidmtzUnhvMmErQVp6Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:41:07.5804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a47138-fff9-4e27-18f2-08ddeeee20cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351

AMD systems optionally support a deferred error interrupt. The interrupt
should be used as another signal to trigger MCA polling. This is similar
to how other MCA interrupts are handled.

Deferred errors do not require any special handling related to the
interrupt, e.g. resetting or rearming the interrupt, etc.

However, Scalable MCA systems include a pair of registers, MCA_DESTAT
and MCA_DEADDR, that should be checked for valid errors. This check
should be done whenever MCA registers are polled. Currently, the
deferred error interrupt does this check, but the MCA polling function
does not.

Call the MCA polling function when handling the deferred error
interrupt. This keeps all "polling" cases in a common function.

Call the polling function only for banks that have the deferred error
interrupt enabled.

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends
the common polling flow to find AMD deferred errors.

Remove old code whose functionality is already covered in the common MCA
code.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250825-wip-mca-updates-v5-14-865768a2eef8@amd.com
    
    v5->v6:
    * Move status clearing code to new helper.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Add kflag for checking DFR registers.
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Keep code comment.
    * Log directly from helper function rather than pass values.
    
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-13-3636547fe05f@amd.com
    
    v2->v3:
    * Add tags from Qiuxu and Tony.
    
    v1->v2:
    * Keep code comment.
    * Log directly from helper function rather than pass values.

 arch/x86/include/asm/mce.h     |   6 +++
 arch/x86/kernel/cpu/mce/amd.c  | 108 ++++-------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  45 ++++++++++++++++-
 3 files changed, 59 insertions(+), 100 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 31e3cb550fb3..7d6588195d56 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -165,6 +165,12 @@
  */
 #define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)
 
+/*
+ * Indicates that handler should check and clear Deferred error registers
+ * rather than common ones.
+ */
+#define MCE_CHECK_DFR_REGS	BIT_ULL(8)
+
 /*
  * This structure contains all data related to the MCE log.  Also
  * carries a signature to make it easier to find from external
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ac6a98aa7bc2..1b1b83b3aef9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -56,6 +56,7 @@ static bool thresholding_irq_en;
 
 struct mce_amd_cpu_data {
 	mce_banks_t     thr_intr_banks;
+	mce_banks_t     dfr_intr_banks;
 };
 
 static DEFINE_PER_CPU_READ_MOSTLY(struct mce_amd_cpu_data, mce_amd_data);
@@ -300,8 +301,10 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 		 * APIC based interrupt. First, check that no interrupt has been
 		 * set.
 		 */
-		if ((low & BIT(5)) && !((high >> 5) & 0x3))
+		if ((low & BIT(5)) && !((high >> 5) & 0x3)) {
+			__set_bit(bank, this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 			high |= BIT(5);
+		}
 
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
@@ -792,37 +795,6 @@ bool amd_mce_usable_address(struct mce *m)
 	return false;
 }
 
-static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-{
-	struct mce_hw_err err;
-	struct mce *m = &err.m;
-
-	mce_prep_record(&err);
-
-	m->status = status;
-	m->misc   = misc;
-	m->bank   = bank;
-	m->tsc	 = rdtsc();
-
-	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = addr;
-
-		smca_extract_err_addr(m);
-	}
-
-	if (mce_flags.smca) {
-		rdmsrq(MSR_AMD64_SMCA_MCx_IPID(bank), m->ipid);
-
-		if (m->status & MCI_STATUS_SYNDV) {
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND(bank), m->synd);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND1(bank), err.vendor.amd.synd1);
-			rdmsrq(MSR_AMD64_SMCA_MCx_SYND2(bank), err.vendor.amd.synd2);
-		}
-	}
-
-	mce_log(&err);
-}
-
 DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 {
 	trace_deferred_error_apic_entry(DEFERRED_ERROR_VECTOR);
@@ -832,75 +804,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
 	apic_eoi();
 }
 
-/*
- * Returns true if the logged error is deferred. False, otherwise.
- */
-static inline bool
-_log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
-{
-	u64 status, addr = 0;
-
-	rdmsrq(msr_stat, status);
-	if (!(status & MCI_STATUS_VAL))
-		return false;
-
-	if (status & MCI_STATUS_ADDRV)
-		rdmsrq(msr_addr, addr);
-
-	__log_error(bank, status, addr, misc);
-
-	wrmsrq(msr_stat, 0);
-
-	return status & MCI_STATUS_DEFERRED;
-}
-
-static bool _log_error_deferred(unsigned int bank, u32 misc)
-{
-	if (!_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-			     mca_msr_reg(bank, MCA_ADDR), misc))
-		return false;
-
-	/*
-	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
-	 * Return true here to avoid accessing these registers.
-	 */
-	if (!mce_flags.smca)
-		return true;
-
-	/* Clear MCA_DESTAT if the deferred error was logged from MCA_STATUS. */
-	wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
-	return true;
-}
-
-/*
- * We have three scenarios for checking for Deferred errors:
- *
- * 1) Non-SMCA systems check MCA_STATUS and log error if found.
- * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
- *    clear MCA_DESTAT.
- * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
- *    log it.
- */
-static void log_error_deferred(unsigned int bank)
-{
-	if (_log_error_deferred(bank, 0))
-		return;
-
-	/*
-	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
-	 * for a valid error.
-	 */
-	_log_error_bank(bank, MSR_AMD64_SMCA_MCx_DESTAT(bank),
-			      MSR_AMD64_SMCA_MCx_DEADDR(bank), 0);
-}
-
 /* APIC interrupt handler for deferred errors */
 static void amd_deferred_error_interrupt(void)
 {
-	unsigned int bank;
-
-	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank)
-		log_error_deferred(bank);
+	machine_check_poll(MCP_TIMESTAMP, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
 static void reset_block(struct threshold_block *block)
@@ -952,7 +859,10 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
-	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
+	if (m->kflags & MCE_CHECK_DFR_REGS)
+		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+	else
+		mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 06645f56b564..e2d51609d2cb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -687,7 +687,10 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 		m->misc = mce_rdmsrq(mca_msr_reg(i, MCA_MISC));
 
 	if (m->status & MCI_STATUS_ADDRV) {
-		m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			m->addr = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DEADDR(i));
+		else
+			m->addr = mce_rdmsrq(mca_msr_reg(i, MCA_ADDR));
 
 		/*
 		 * Mask the reported address by the reported granularity.
@@ -714,6 +717,43 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
+/*
+ * We have three scenarios for checking for Deferred errors:
+ *
+ * 1) Non-SMCA systems check MCA_STATUS and log error if found.
+ * 2) SMCA systems check MCA_STATUS. If error is found then log it and also
+ *    clear MCA_DESTAT.
+ * 3) SMCA systems check MCA_DESTAT, if error was not found in MCA_STATUS, and
+ *    log it.
+ */
+static bool smca_should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
+{
+	struct mce *m = &err->m;
+
+	/*
+	 * If this is a deferred error found in MCA_STATUS, then clear
+	 * the redundant data from the MCA_DESTAT register.
+	 */
+	if (m->status & MCI_STATUS_VAL) {
+		if (m->status & MCI_STATUS_DEFERRED)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+		return true;
+	}
+
+	/*
+	 * If the MCA_DESTAT register has valid data, then use
+	 * it as the status register.
+	 */
+	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	m->kflags |= MCE_CHECK_DFR_REGS;
+	return true;
+}
+
 /*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
@@ -740,6 +780,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;

-- 
2.51.0



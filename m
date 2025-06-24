Return-Path: <linux-edac+bounces-4234-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F1CAE6889
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824046A28A1
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F432E2F05;
	Tue, 24 Jun 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="et1Smrlk"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57202E0B72;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774606; cv=fail; b=VfaP70Ygagvvxz0z21dlaVRqpgBhxQgcTGtLZbweYINj80Bv8eSggvfQTkqi6kNgVneDDn9qiIP6bXM6jPZJNe1E2tWIdkEvjGU8dIjuRDYhYgQoxha3lsi1natXB3bWVBjnZ01bhTNmWEp/lxBAh05UU8yFQFWOfE6BD8fSAqQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774606; c=relaxed/simple;
	bh=yKLBPeSrnTP0I6c//Q571rSafa6MIhhkBOa6hnTx+OI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rZtwBV75wcCySEpTx9je6RdBhKEiDoWd/TTWUv/se+TRKSsbrD69mdgkyuw7fWg8oCEYv4eK8fSyRMFCrON2MWf/oN64UVHKm0yAbq+w5yJA2vyQWW+HOIidLLPo9/mddklvf+O6XBCQNgN6tqQzDKzKvHI9gDWjiRzubpmxP6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=et1Smrlk; arc=fail smtp.client-ip=40.107.95.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9uIX/QdZIqvanmQ9LMIMk9R75lM2bP5PsfoVXCN/i0DqvY6Fw8xmx5DQVziBRQRD3RH3q+p0wFvPk5/gLVh9/X+gpZ+WdgXM6gWZadWgBSxjkwtoYQ84DzoP5aGb/4ar3gDrotIrXyVHhxyUKlNfrRfI+ADfu2Hk7KWB7NhjG8nFbPQxyTIWQG7g/52CfCynzzBxwjDEJr3ZaHo4eDEXf/9aV7HgT/nKGTTT7xJBOFG/4f7ppqhSjf/dICYvgL4YxtuxV4j/KzwL0YLG0kGCIrTKr0/xC9w6ZwESHT1XJbHuQaP7DSlqu2LzWhNhHtWUVSEmXvkdDTs2Yn6fXYtow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybO7Lsblyw2k+njvFMV3qSECHZYxwPKRlogOcMUaWug=;
 b=NuyMtJi1xtGMjK6QJ8KsYHjqT4BQgZFn2naV7GF7gAPJez3ec/8XSoUEEk0fLSxvxXTbiIzL+211HNSStQoFLtd7fs1+EhnHlWXdoi0Q/EAwwkNzvhCiFT8XCxsi/ksqZUsqq8HRD9hoo9OZHYaLnSUXir+tRG9xMjcrVf7rc2RQQA4iGnviCG3VHuT9SgaWzaXxLxS5DVi9LIq24h9Sm5yoT20qb/DAUFjKfUnd8R85rt02lyvN1JyuVgfzALlKg60TDCM7V8Szz3KHAxF7eB8PgjYE2bIZFFpI2QVmIDkPvE1BM+pvLjdqouBG3zOs9pcj9sGWtIg+X8xlvGt41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybO7Lsblyw2k+njvFMV3qSECHZYxwPKRlogOcMUaWug=;
 b=et1Smrlkpa95n8YDi5vH89DVjasf6kqfZKeHKT+eiwbVidL7hat0D9OnxRgW9us4jUX2f2ySlpdNt0ujUjQMbLTR+dIskTC7qBYw6hW+2r/8tVUF58crb4ZIGRIyunwA3f5N5NR0ESmJUniLrgn523p3HiEvPf6Nrd8sva75v0A=
Received: from MW4PR03CA0229.namprd03.prod.outlook.com (2603:10b6:303:b9::24)
 by CY8PR12MB7100.namprd12.prod.outlook.com (2603:10b6:930:60::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 24 Jun
 2025 14:16:40 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::dc) by MW4PR03CA0229.outlook.office365.com
 (2603:10b6:303:b9::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Tue,
 24 Jun 2025 14:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:39 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:36 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:12 +0000
Subject: [PATCH v4 17/22] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-17-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|CY8PR12MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5963fec1-79dd-4428-bb67-08ddb329bc7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmNzVllaM0VIUzFZckVGVkVLUWtQVXFWRjVtSHczOVZ1ekptbmU3VGsvMXd3?=
 =?utf-8?B?dGV3QVZWclRmeGVWQnhIS0tXdnRETGR4ZFJOcGI5K2ZjTWgzNUFkNkJBUGVz?=
 =?utf-8?B?dFo1eUxQK01CcTdaVVJNUDlDUU0wRE1IWEUrRWl1TVZYNXJDWWVZQXNOQ0F1?=
 =?utf-8?B?MkEwVU4xSUtVMEFrN2dxdmJPVXZvNmdKZ2hmY3p6U0NyczMzYVZRbjFFUXEy?=
 =?utf-8?B?WDlSZzlKNWIzRGVMYW1WaFMwMlFlVHFTSEdvdm1yOUJUcGZaSU5oa2ppSHFj?=
 =?utf-8?B?Wi84YzBsa1R1ZURwcm5kTHladHNpSVhmRi83TGRiNXF6L0c0M2RsSmFxTkJK?=
 =?utf-8?B?NlVBQThFVlVXMWtpMWlUWXdLNGtIK3dlRys0cERJYWFTL3gvQ3FQOUV1a2Q4?=
 =?utf-8?B?VUd4ZWZWc2czc3FaWnB5UGM3SFdHRzR3b2IrNjdQdlRJdnR5M0k3N0t0dTZv?=
 =?utf-8?B?V05nZ3JsSWhsajdMWGxaL1EzUVY0cHZQWmprc3o5SW13bjJaWGRvUTdndy9u?=
 =?utf-8?B?UmxKWDFMOEhRT3FQbUhxZTZkV3ZQUUZCa1NlVi9hYmFVU0V1bFkwZ3NyZlVs?=
 =?utf-8?B?Y0RpYkJmcWw0emtGbXZDeHBpR2pkSkF6UTh6eW45M1c0cWd4cjhtYllodDVs?=
 =?utf-8?B?ZkJnUHhiMHVKWmcxbnhkK1RLNGd0WHpGTWMvcTZQZ1JuY2s3YWVyMXZROCtK?=
 =?utf-8?B?Z2lkbFJaSCtvdnZqbUcwM1RqcjI2bE1iNkRCbTVIbThGdHRWeGJoeXFmeXQ3?=
 =?utf-8?B?em15VEdDOFB4M2FVUlZZajFUaFNLbUVNU1l2RWVvdDVLUTdTOWMweTdXR2RU?=
 =?utf-8?B?VUYrcmYvRHRHWnF1emI3UlEzRWRveHRlRHR1MWpxbWtqdXEzSVhwd0p4UGlu?=
 =?utf-8?B?WmdmVmFUR3RHZVdEOWowT3BlVjcxbGwwajhkVS94eHgyTEhwT1p6cHNmbGRw?=
 =?utf-8?B?STQ5RlU0eEJ2REhPTFZmendFdkl0d1A2MVhpUWJHdzdoREN5UnhiQi8rUFRS?=
 =?utf-8?B?ZWtWei9yQmxlUVh1aEFHVXlOdklxR1ZlLzhaNmpuMjNYMTZuU1RsNm9mSFRh?=
 =?utf-8?B?c08rMHBUUVFVREpHZzNZZzhEdTdtbUxwOHZVQnV4TXlYYjBDM0dCY3NqaXkx?=
 =?utf-8?B?bG0vd1c2Z0Z1L3ZqVElMb01LcTM0QUZrcG9LUDlwK2xQbElBTGVpNXRKY0ww?=
 =?utf-8?B?bDFmYjNpTXVPM1NYakFxMnBLTmVjaEYvZC9va2xpaHpTSUI5Zno3eXpsSC95?=
 =?utf-8?B?WnpZaDJkZ0hlKzhQMmRtK08zcUwxVFp6ZnhtN3kzeThEVmpkSHJpemJCeFNq?=
 =?utf-8?B?UUZiUDhqSndNRUpyNjA1U3dDMVRBaVdhMkZiTGU3WnY3SzBsMWJOWUZLdXRu?=
 =?utf-8?B?Zjg0b3BTVzQ1SmdBMlh5MGttTnVGUjViTjB1ZU9rRjVUN1kxV1ErZ2RVVDdO?=
 =?utf-8?B?cTY2aWVwT2swVko0UXhwK3QraUtmbllwYk03aEJBQmhxb1F4ZGxPWG8wcW1a?=
 =?utf-8?B?VXV4OVkzQXlXV1laTGNaTGVMNjV2R2ZRVGZ5WngrWEd0UkpiUmpZbjl5Y2Z3?=
 =?utf-8?B?VUt4YkJzbTBkTFZ5NTlpNlA5aHNrNm1abjVKNEVpMDZWNDZ1aXFQMlZ1RFZ3?=
 =?utf-8?B?THpYb1g2SlpNUy9UdnFmbkVBQlV4UkdVOXBIK0xtekgrWXNJbllKYnZDSm55?=
 =?utf-8?B?eXdPRGY1UHFoSmdhUFFmTGhzUVFQenNaMnMvQk4zNXZKWFcxclJ3bkJ3ZDYv?=
 =?utf-8?B?MXRHRmFUNDVlRzNwYXB5VVJUOXFOeTF5RGtpY044aW9JUDllNWdETUJVeHY5?=
 =?utf-8?B?alkzTWlpWVRrTU0wYm50b2RQazlOY2M5c01PZW80UkRnNW9JRDNMektLZFhF?=
 =?utf-8?B?d3F1WkdnQkxPcGlKVGJCZDc5SjdKeVBLNHIvY3Foc3ljYlJFL3dWMGhEcHFT?=
 =?utf-8?B?aFdYOUhVNlQ0TDFhSnFLSWc0U3BlNUFZRzRFMko2Um9wMHkwZFV5b1VtOVls?=
 =?utf-8?B?T05hWFlWMUJnMDhFUUFJOTVmRm9tSzlnTVMxcExvU0ZGQWptT3hGdmNReTJ1?=
 =?utf-8?B?VU1XNkZ6UDBPQkxUdXgyY1B4ME1HSkgzWkI2QT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:39.2590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5963fec1-79dd-4428-bb67-08ddb329bc7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7100

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
    https://lore.kernel.org/r/20250415-wip-mca-updates-v3-13-8ffd9eb4aa56@amd.com
    
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
 arch/x86/kernel/cpu/mce/amd.c  | 103 ++---------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  50 +++++++++++++++++++-
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
index 0c789fa1ae4c..9d4d0169713b 100644
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
 
@@ -794,37 +797,6 @@ bool amd_mce_usable_address(struct mce *m)
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
@@ -834,75 +806,10 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_deferred_error)
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
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a0aaf0abd798..dc5ddddceb22 100644
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
@@ -837,7 +880,10 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		/*
 		 * Clear state for this bank.
 		 */
-		mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
+		if (m->kflags & MCE_CHECK_DFR_REGS)
+			mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(i), 0);
+		else
+			mce_wrmsrq(mca_msr_reg(i, MCA_STATUS), 0);
 	}
 
 	/*

-- 
2.49.0



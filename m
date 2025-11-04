Return-Path: <linux-edac+bounces-5328-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597BAC31AA9
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 15:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C63B42E9
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FBB532ED4B;
	Tue,  4 Nov 2025 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CsBZiM4C"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336A032E75A;
	Tue,  4 Nov 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268162; cv=fail; b=XtlOU31xAeROk26nGv93LscU2lS6vVLyx0U3eZdDLLUN08UDfQU7zwOnuoqQYFsIczSujFPJbw2YG+nQ2LYp5pt5qS8zc90CsUoxUek8EAXd/iaTqgbrLDQO9IYuJ5w7rxNmerkwxBPvlbUh3+0HpnzYWgtfFqIv71MAgiJ3yV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268162; c=relaxed/simple;
	bh=1hgU//1Ywyt8KjRhC07xChNP3cWmoPufOpYBpO9QvsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qC3OPcQZuv9daNpbUJVkvP0r18pNYou+0LzZZ4t+ta3jGTPqz3NgAJDsZQWCGGOBszWBcDZFS+FfGcz6FDxbKomksmLPXMbiwr9jE4zyb/cYBnQySun995XCK3kaeCilFy8jbfT5Spf8+C0k0xPK+55nLry7xuTJBnkLVonSX5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CsBZiM4C; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzZu3OMneJ5/Kjhed2xupEix9pjbOYUdr89Z/QmH/WxRkoVMfTZsKMgbznoobsZfdX9XfUjn+R3BJ/KdNqRlErWUB5nUWbBq/pFUSctbApyV4B0vFnyj528abn1ZWYWB7ohwXyq1QrMlzTLLNtgViSsxxSHYYYFO4jfSd/P/86LxcpPYMnfowccy4Z5LWRbMJpPLl+rEtd241+0+LUOccaXS99P13gkqFtFxv50+lkmW372ooVrQxbvMrBye20FkpGr9AGDkzyu9y7DuQtP6LoM9lWCyEeDvCWNDr4YoMFp/cPcu2k6HtiKzmTGkmxlW998R8rrpV9B0lpu9Hclbww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6osGcKJQtHqc12vZqDP0ztpUSofFSKoggee8bfrIQ3M=;
 b=qb5s1GtqkIfT9bDBcGBQ5fQHDFA/NQu4Mf4Ouxf9DaxG53pB5BU7VgiHoBC7pJbYa62aq2yyN6YhHfj4ZlNWZ0mBFE2d8FJ95KsuFab7seB0OaAT/y8FVbcfUJIO/1PR1yOkj0PAoTdv1hoplR39u1xhOBGtRqfaCIjwsty7jGhmecJ6PwDxrEbiFLNzM28rWkh8DRcD0vuEOVqMGN02yrX5isCTSIIHZLZXjdadVDLYJxXRI5JpWZo6XFmY61LgXYnaxk3Ato9v4qrnNbv3/9wDW0EllnXzslWXgpFpVCH6mPu4Z38rdDgSq2/Wmsei/w7qQj/auBwl/0hw0C7AUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6osGcKJQtHqc12vZqDP0ztpUSofFSKoggee8bfrIQ3M=;
 b=CsBZiM4C0qogYR7PxKFOgpNd04ZYPHJBZT/3yW2J3ANqVArBs5fjbMGQpIbXR8LmN7cxBTQBgeGy97ICbowfkaTsxodDD2YphJUM+ZjI5jPnmhN+DVCNji78LWob3NUzRq+WWW5cC8LocI4RSRcWFCLzcR0hjw2H7W7oPEOqYEg=
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by PH0PR12MB8822.namprd12.prod.outlook.com (2603:10b6:510:28d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:55:57 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::d5) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 14:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:57 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:51 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:39 +0000
Subject: [PATCH v8 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-2-66c8eacf67b9@amd.com>
References: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
In-Reply-To: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|PH0PR12MB8822:EE_
X-MS-Office365-Filtering-Correlation-Id: 912b796b-e036-4aba-1671-08de1bb242e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UTI2Y043YTRJOEVOeHExS3haUzF2STEzUUpCQVFpOGRzUkdaKzFvWllBemZ4?=
 =?utf-8?B?TzBEeDNlcis0YlBwVkZUUnpKd1B4cHppZmxvdWdtbDdZd0hkRzdqUDluNklQ?=
 =?utf-8?B?ck9mMEtZYnRzakNxK0pEQmRmbGI2dzlzRDRra3hGQVRpbWd2UUdOYm5tZDlM?=
 =?utf-8?B?dW1TVGRRb1N4Q1JwYW5NMVNWbmd1V2JxbE1lUFJRQ05yY0dHc0llNUdpWmRz?=
 =?utf-8?B?czlSOWZIWXBZU1VxSUFPbWtpQUwwQWkyR2FhNEMrK2dEeG5aV043YjFVT051?=
 =?utf-8?B?YnBtY1AyS3dITFRaOFkxdnFiaEp3K3FlVHNtTVRCNFU4d0tCdFByL3JDWE1t?=
 =?utf-8?B?RHF3LzU3TnRJZk85cUQ4ZHFxNW9oVzhJclcvSWtmT1F6YVZxVjltRkJHRngy?=
 =?utf-8?B?cGdOUmZobkhBNE9Td3ZaU0lWb25qb2dKbUhDeUlTMlh4M2M3UVkyNEZubHBy?=
 =?utf-8?B?emRhajV4SlRac3FKRmkyQzgwRGJVSERCQkY5MUNVMmp5WktpRWY1SVVqdnZ0?=
 =?utf-8?B?V3FKRmZnMVFNVTNPdklNdlJWVHQwbzQ5R2E4Wm4wRE1pdGdXWXhMcXFXaHln?=
 =?utf-8?B?STBDT0RFUUlEUnk4SUV5OVlvbmxqb0MwU0FiTTR3bnlSTmtGd3RmR29RUXNj?=
 =?utf-8?B?UVdEUHBwRytVclQ5M1A5YktmV042MmszVDI0OGowR2g1K1JyMmxIWnBMSVE4?=
 =?utf-8?B?aHVpb2J6REMzTXh0SEVxclFVTHdCUkFOSkVqcGM4Szh1Ukdnb1VXbGxkVFhi?=
 =?utf-8?B?SHp4MUJqZFZQR1pmZCtKempNSktZbk5uU3lVN1Fkc3FYekFrZk82UEY5VlQz?=
 =?utf-8?B?bG5MSmJwTXpMODNPT1FlYzJKWEJ3cktld0tyL2lKVkVUaWZIRS9qQ2xrV1RH?=
 =?utf-8?B?TkJ1Vm00MFdtNElUa3hOVjc4MFYrQzh1eHBFZmRrUjhMdUw4TWpLTGdVWlhB?=
 =?utf-8?B?WDdsVzNIWXVpeGNKc1kyM2ZENEw3SFJ6VUZqTm15OG9wZTBPVDlRNVRIem8x?=
 =?utf-8?B?NVNGNklEbWM5S0VkbVlPQlpzNHorMXlkOFEvbC9ocFN4NWRORDdjQkZ3WE9Z?=
 =?utf-8?B?ZmZBUXpRTU1iSXVRM2l4cjBacXk2QkgvZ3NzeFkzSDRSVHprb2duMkQ3dXg3?=
 =?utf-8?B?TCtrellGaENSUjBuK2pLZ3dtNHZPRUNJOFlIMC83ZXZUdUd0MTcyTHlxaXZJ?=
 =?utf-8?B?SVc5cFJLUE9lU29Ba0VXR2NKSllHTEpROTU1RWtNOHdzK3RJcjdhOWh2Yzgy?=
 =?utf-8?B?bStwVUJvUTFUdzlNak94NmQ1UVB3TWNScCtvcjRLMjZvYStiS3JxVVYvMFBP?=
 =?utf-8?B?QWFRVUt1bW9nVURxTXpzZUV5MzZSaTRJMzFVZk8vZFFHakV2dHhvRG9RZm1H?=
 =?utf-8?B?b0NLSEd3MUIyNE1nVm5zdHpLeDlhUXZvdnI3cXdUcmdYaGVPbzlTaVhHWTNi?=
 =?utf-8?B?WUdsdkdFYmM1OVlSdTJIeURNWktFQVE1MSt1OWYvZkJTMDEzYlZLeE1aMnUr?=
 =?utf-8?B?OVRNVUErN3VoQ01DWlAzS256U1JRMnRFMnZuaDVUbGZNVzlpdVo0endLWlM0?=
 =?utf-8?B?dXBTVm5tS2Foaithc3hvcDNYc2JQbUN4SXlJS0lPek44ZjN3K0VwdFZOUUND?=
 =?utf-8?B?amduK3F4Ny9EVzgwaTQ3QmpLMGZzNU5pZGMvNFFCUXM3TmFwU2Y0WFpWTldD?=
 =?utf-8?B?S0p4YmpZYjhrV3ZHaEN1cDV0S1FHenRkRGdwTlJJRXZZS3RPUThWQ2J0RUM0?=
 =?utf-8?B?RkxBcXdZNFlXV011NzRqS0JnRUlkTE1wSWZIN3ZzT0FVOTc2YnpmRDdNbi9a?=
 =?utf-8?B?VENvQ1VWMmg2YzRtQ0kzZHBpQWtqa0JUNmtMT0tnaHNpQ2poWUd4dHViREx0?=
 =?utf-8?B?TGtySS9kTTFDRUl1cDhaaVpUM1RJOHk1cENtNjkvcExrQ3I2MjFKempKRkNV?=
 =?utf-8?B?ZHpGVTl1bVRMa1k5VEx1Qm1wZEFPWkxqZlN4TzVLRnJ0TVl4UW9vbXh2Zkpl?=
 =?utf-8?B?OENCdzJpbm90QWJLOW8xdWRFekNQMUhYUlFtdUREOTVtRWlmYWRYQkZPSDds?=
 =?utf-8?B?MGw3eVhZeXZPckIyeE1KV0tjMHpValMwVjBEUlE0dHA0MEh3S3ZGV2VjMjMz?=
 =?utf-8?Q?c2njQ/gK7KFn8/q181z1Lxe5W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:57.2769
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 912b796b-e036-4aba-1671-08de1bb242e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8822

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

Add an SMCA status check helper. This will do the same status check and
register clearing that the interrupt handler has done. And it extends
the common polling flow to find AMD deferred errors.

Clear the MCA_DESTAT register at the end of the handler rather than the
beginning. This maintains the procedure that the 'status' register must
be cleared as the final step.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com
    
    v7->v8:
    * Simplify code flow and comments. (Boris)
    
    v6->v7:
    * Rework DFR error handling to avoid reporting bogus errors.
    * Clear MCA_DESTAT at the end of handler. (Nikolay)
    * Link: https://lore.kernel.org/r/20250915010010.3547-1-spasswolf@web.de
    
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
 arch/x86/kernel/cpu/mce/amd.c  | 111 +++++------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  31 +++++++++++-
 3 files changed, 49 insertions(+), 99 deletions(-)

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
index ac6a98aa7bc2..d9f9ee7db5c8 100644
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
@@ -952,6 +859,14 @@ void amd_clear_bank(struct mce *m)
 {
 	amd_reset_thr_limit(m->bank);
 
+	/* Clear MCA_DESTAT for all deferred errors even those logged in MCA_STATUS. */
+	if (m->status & MCI_STATUS_DEFERRED)
+		mce_wrmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank), 0);
+
+	/* Don't clear MCA_STATUS if MCA_DESTAT was used exclusively. */
+	if (m->kflags & MCE_CHECK_DFR_REGS)
+		return;
+
 	mce_wrmsrq(mca_msr_reg(m->bank, MCA_STATUS), 0);
 }
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 460e90a1a0b1..4aff14e04287 100644
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
@@ -714,6 +717,29 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
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
+static bool smca_should_log_poll_error(struct mce *m)
+{
+	if (m->status & MCI_STATUS_VAL)
+		return true;
+
+	m->status = mce_rdmsrq(MSR_AMD64_SMCA_MCx_DESTAT(m->bank));
+	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED)) {
+		m->kflags |= MCE_CHECK_DFR_REGS;
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Newer Intel systems that support software error
  * recovery need to make additional checks. Other
@@ -740,6 +766,9 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (mce_flags.smca)
+		return smca_should_log_poll_error(m);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;

-- 
2.51.2



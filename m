Return-Path: <linux-edac+bounces-5068-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AF7BE49E2
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD461A67663
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB33314AB;
	Thu, 16 Oct 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GawmQvhD"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3988332D0CA;
	Thu, 16 Oct 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632687; cv=fail; b=AFcdotmUMUIP+oAwkvxpJD37TKYgF9xVn5rSuYWbpF6uHH20gvdc2L5pd+krqZnCZCmLg/NmO/wpoIp8oQcbiAo8WHRc6T65VnypW8at6/vS52YTWsh5CJf4CaZ3Lk7cIHWjc2YEFfYRKAlcum6fUn8x1BNjgztdFyHj1MonUeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632687; c=relaxed/simple;
	bh=KHgYAKI4we+RN9HtXnc6x17A4JDbZIq+4OuL0pKZk9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qXVmOpIYj0syvwiM3sRtUYhh+q2su1g3iDCPQZfNb1Cx8KdN2EFdGyZXf03J43HmeEFTbbX/HUnIi1CuHpQE1t0W1B6wa5E+sB/6iz8T/9SOdJc6ESusgDKdWyH5JReNn0hLLMmKSYYytGvMGVP3BboyvpnTcDJ6Ajs/MtNCkS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GawmQvhD; arc=fail smtp.client-ip=52.101.62.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKoFAF7sK7YBAebmaBjXPDG5QB7r+GnWnpac9JgAUpoqWeTFLaEOtRE9siD7cO2MTlMMcHhT+xkL2V8mK1etfgp9lFGWk9XvAxXrDh20plDpI0CTNcmduAvh+fn0YQtOOYt73ekeMSaHHWb0M//68f9QfbvOleoj5Y4b2na7PtqW8HK5A9GY2WVbhw/h4uIJIxAQZS613aTDiZu428BZyy7lxQEWroMeoKunwrw+17fPWzOsJi9R1iFQypS3E078CRw4h/k1QGxopHIZyJMH23iEJcE0Drd7ZU/AoW6wHAmMHxL4ObjQwstvoAFua/Kuq/8bcimRCLrw5SRhmJp02w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E78O4XquwnWmm16dyR6dP4max9ZdsN//avOxQwMqqis=;
 b=GFOPVIMg8pgWqvCIoiVKB5ocV3FSA0yrorqfsXMO844bNfayLX9lsxXBa7j6ugKQFFkK6Uo91UPSNHOxeN4NndUBPJJW5fdAOQGg60xRX5PLfYj/m5oSj70V+2Tgze8ZK22JsE1aTCqPSfTvhDv+7a3z755Dh/S0aqwojUo/I33+3PDu1lMdZnN4GEHF6yB/8JFgUp4yy4l4uYWoenXWlcyONQ0wwywqsICcl5rXHB008SjWvJ6wkSVK+mjEQ9QUXRFClyvh/MpXXIeG2zYHmodYguGuIGdURWmf0qXxXnkHUaSmOSV9EDtUnvlpLg2qJRkYhTycPb6ptujLqJem+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E78O4XquwnWmm16dyR6dP4max9ZdsN//avOxQwMqqis=;
 b=GawmQvhDnQ5WcmvVJLmIvG9kjhj+bay+Rr9qVtedLt1uM91QZH2DSLRObTFQjaM1+PWVi1VA7SG1ttjnh+XMCStdV6sVdBKi9sIeKO7Dv2cO/1DZERA41ibFG9JeNl+UMEDqzmjLxeObFOX5EN7F0QaOtoBDTrqk4VTlEqDn2ro=
Received: from BLAP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::6)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Thu, 16 Oct
 2025 16:38:01 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::2a) by BLAP220CA0001.outlook.office365.com
 (2603:10b6:208:32c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:00 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:47 +0000
Subject: [PATCH v7 2/8] x86/mce: Unify AMD DFR handler with MCA Polling
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-2-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c927d3-28fc-4b3a-31ac-08de0cd25f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFhxcno5eVdobzNTZzFCUUVzeEVlSEM5K1RFYXVxRkdLOWVMUHhZUXdmV3Jk?=
 =?utf-8?B?RzV6dEU1aVJ4N0xYbXFIWUp1V2crclhCOWNGN0pSWDdoQnpRQ0s5dWpZV0x1?=
 =?utf-8?B?MVEzeEoxOElJamxlL2J2eHNQVFdkQ0dRM1VaclRYTUoxZzJ1SytOTllmemVZ?=
 =?utf-8?B?REFaZ3Rrd004MWI2U1VpcnZQUkdnQ0RpVVVVZEFxV1NiL2c3b1gzSUQ5L3hy?=
 =?utf-8?B?R0NUbVV3dnFBRGxSNElWbDlUUE1xanQydG9xK3Q1K3NxS0pzdldoczRuN0gv?=
 =?utf-8?B?Y0ZGYWpPYUIwQnZncFZQMWFwRG5jRG0rM2ZCM2VrRUtYMWxPTGtudHUwYnpY?=
 =?utf-8?B?b0xsdVc0bFl5SUVUdCtvU3JreXdDdGtMb3NOa3ZWcHI0ZXFRb3RNbkxNcFR0?=
 =?utf-8?B?TW5JNnF2cGgvSGc5RjNDRHdjMU9EVnVPb0p4SVdWTjFlUEpnYVB4a0lPTThy?=
 =?utf-8?B?Rnk5SVVqVGhZV2pnVkNQU1Rzazc0dHZqV2h5M1k1Zy9DWEVaL1BNRGNvQ3F6?=
 =?utf-8?B?U1lsY1hRNzFsMDhabjZIay9NaE9WOTZzMmdqNkVrSDNDL0ZvRDU4ckt3SG0x?=
 =?utf-8?B?R0dHdDAyMXdDaTZVTlpRYmpIY2txaTR4RDRyS2N5bjZkTG9WWVllZ0tzNklr?=
 =?utf-8?B?V1ZoK3QzZjQ5bXJvK3BCUExCamo4TVZVbFBpSnZNQk5QbDRvY0NxRnZ4cmR5?=
 =?utf-8?B?M250SkN6L2liOGJqOGJkMTBFMnI4d21Pakc0YmI1RXRvUVRzdzdrN1d2aHJQ?=
 =?utf-8?B?dzNBY2tnYzFmcEhVYis2R09TYXhia3l3WTBYRnFLTzFzVVNzd3dRQUI3MCt3?=
 =?utf-8?B?ZGZPb2xUWkZKVUFXN2hUeTNiMk1yVmF0OHhyTHhCVGhNeVY5WWtGVytwNDVH?=
 =?utf-8?B?clFPZU5idTdTUjd6aHlhMmVieUI3ZEtOZ21qZUlDd01oN2JVOU1tSTQvdWFm?=
 =?utf-8?B?ckdRNCttS3ZWaUlZY2pXTGdkSVM4RndqcG1qd0NJd0xLMjlMOWl4UC9jTi9Q?=
 =?utf-8?B?TndVbTdyK3Z2WFJkQXVTSUFmNW81ckpwdWNJU2xvUDBXMGtZMnBJUDhPSUdD?=
 =?utf-8?B?Z0phS1Fuc1hYNkNjdDc0MkhiZmp0STFUK1dkMGw5N1AwR1dsUzBUeVRHdkRa?=
 =?utf-8?B?Wk94NGthSnpmdFZkamZhRmZXYlk4aUwrVWY1R0RPNzJBZlVtVDFiOHZqWnRV?=
 =?utf-8?B?Um1PR2JTOUJ6Q0Y1TlQ2RjY2TWRSQjJMdDBTOUdrRk9yZkVaVWxhL0hIWGtE?=
 =?utf-8?B?SlBobE1qcVdvNTEvV2V0amNmWWI0R1A1RXNRYUJmMm84andvNzRVVFk5alFK?=
 =?utf-8?B?VTJhUnhnc29Hc2tnamJFWmZRZERCcFJyQklGSk52QkRBYWtkZHNHZXBNOFl5?=
 =?utf-8?B?RmxCMjFHY0tHcnpBdXEyT3VUNzR5cHJBeGxROEVzR1JyTGFmNGNwTEZQTWxU?=
 =?utf-8?B?ZUl6SkFhYnVqSG5FaFYwM2FWUzFWQ201ZkxZaFdkaWpuUEp2RlJCdzhHWkg0?=
 =?utf-8?B?ZVp6MUpvK1FoUUNLVDQ3ME5qb2hzaFVQc1ZrbitkTXFtZ2I1TTVLOHYvV0Ey?=
 =?utf-8?B?dHl5Mk5aT3FDVzhRajBBVUd5dllBV3kwYUFFR3g3QjJBSTdsRU5raFFIQUNl?=
 =?utf-8?B?TmtiVzg1V0RIL1JUUWV3NmFzMWNnTG92VitWK0VzN1Y5L3R4cHBzbzNaS0Jm?=
 =?utf-8?B?YVFVUjF6Qi9zdGFNQzlFanFLNmpVUnY2LzNPMGUzUVNlMEVXZDdQWm9JNjVt?=
 =?utf-8?B?OGdoQTY0UkJXdVMxRVBqclJPNVVJN1owRVg2bG0yUTI4T3JaU3p4dHA1eUNJ?=
 =?utf-8?B?L1UzQVB3MGhMcGo2WHVKQldDdE04UlQ2Tko2VHA1bWNzMFZXOWlrK0VlYUJE?=
 =?utf-8?B?T0svT09TZE5OZXBXRTlmZUo3b0NhT3IzSGRoZTZrWXhPVVhCUDcxRFNabEJ4?=
 =?utf-8?B?bXpOL1YvNUZkL3F2ZVI4d1llc3JQWWZnZTNWOFgyZHJSY00vUjB5VkJPTDZW?=
 =?utf-8?B?RlJLdGJlTC9pTmdzNVFtWGhvYUk2Um1uMmw5dzNFcEg1SURzRGlLOHQ3YmhZ?=
 =?utf-8?B?WU1DRno2L293S0tIcUVlQ1QwcWVnT0ZPcGhJVHFhKytSVUtaalhjZFF5MXVK?=
 =?utf-8?Q?tKxVuByCje7hehOK60T2w5BY3?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:01.2672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c927d3-28fc-4b3a-31ac-08de0cd25f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

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

Add a flag to poll for Deferred errors similar to MCP_UC for
uncorrectable errors. This will do checks specific to deferred errors
and fallback to common UC/CE checks otherwise.

Also, clear the MCA_DESTAT register at the end of the handler rather
than the beginning. This maintains the procedure that the 'status'
register must be cleared as the final step.

Remove old code whose functionality is already covered in the common MCA
code.

Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-9-eef5d6c74b9c@amd.com
    
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

 arch/x86/include/asm/mce.h     |   7 +++
 arch/x86/kernel/cpu/mce/amd.c  | 111 +++++------------------------------------
 arch/x86/kernel/cpu/mce/core.c |  51 ++++++++++++++++++-
 3 files changed, 70 insertions(+), 99 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 31e3cb550fb3..1482648c8508 100644
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
@@ -293,6 +299,7 @@ enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
 	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
+	MCP_DFR		= BIT(3),	/* log deferred errors */
 };
 
 void machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ac6a98aa7bc2..64aa7ecfd332 100644
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
+	machine_check_poll(MCP_TIMESTAMP | MCP_DFR, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
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
index 460e90a1a0b1..39725df7d35c 100644
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
@@ -714,6 +717,42 @@ static noinstr void mce_read_aux(struct mce_hw_err *err, int i)
 
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
+	 * If the MCA_STATUS register has a deferred error, then continue using it as
+	 * the status register.
+	 *
+	 * MCA_DESTAT will be cleared at the end of the handler.
+	 */
+	if ((m->status & MCI_STATUS_VAL) && (m->status & MCI_STATUS_DEFERRED))
+		return true;
+
+	/*
+	 * If the MCA_DESTAT register has a deferred error, then use it instead.
+	 *
+	 * MCA_STATUS will not be cleared at the end of the handler.
+	 */
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
@@ -740,10 +779,17 @@ static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *err)
 {
 	struct mce *m = &err->m;
 
+	if (flags & MCP_DFR)
+		return smca_should_log_poll_error(flags, err);
+
 	/* If this entry is not valid, ignore it. */
 	if (!(m->status & MCI_STATUS_VAL))
 		return false;
 
+	/* Ignore deferred errors if not looking for them (MCP_DFR not set). */
+	if (m->status & MCI_STATUS_DEFERRED)
+		return false;
+
 	/*
 	 * If we are logging everything (at CPU online) or this
 	 * is a corrected error, then we must log it.
@@ -1878,6 +1924,9 @@ static void __mcheck_cpu_init_prepare_banks(void)
 
 		bitmap_fill(all_banks, MAX_NR_BANKS);
 		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
+
+		if (mce_flags.smca)
+			machine_check_poll(MCP_DFR | MCP_QUEUE_LOG, &all_banks);
 	}
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {

-- 
2.51.0



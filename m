Return-Path: <linux-edac+bounces-3059-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A05A34AC2
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D4018970B2
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675891411DE;
	Thu, 13 Feb 2025 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j0E1HHyk"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE6128A2BA;
	Thu, 13 Feb 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465192; cv=fail; b=rYjrnoSZTzKegtUHNrK6iYrlpXahc3bIbFwx0qLxtTjvfYzHRtFYRAkbLIfkcMkPfXLHZbYPanQhvUl6Gavmoq+3qhWriUFvl5oC37pVlfkpacMvC9VcyjfozUmWPcve/bfhpn+9xRfrLrKtTw2oaKMAhsxh0TmyKidIMIAP0Zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465192; c=relaxed/simple;
	bh=OyB6R/SPNcRydbbvB9SpKXBlq4MA7R8ifeAoX/LZVU8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=qNyGJjG03E0WWv05dr8b+GlbaepzD2ajb2uyZF8iOrpv03CzJIdfdfeqGxJoKcYa+AC1rGO5bFOLLM4+JkDBVwsO0z3CDqjVl/mEKdHairLaeDuMrrWbHcRJbxYSuRbilGoOO2OZRmA5JVJSxQX0UPR/wI/J4zVXZ9CdJps9KcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j0E1HHyk; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxg9kUXRioKEvY4HX0Dmm8JIzsVv4hCWaoEJOwoVoDEGD0ctTdUNZZBWKxxuttwL6u7KFqpADLRiESsgAmTfZqmSve4FKNUXG8Z0sFTPmIKKHwtkLK/hwA5sFTdESu0Yn4WWQub5LSBeTFJMlDM2DHw9lG+8bxBLTMIiTMIrEqRh44Yezcw5MgkdLMtY9mTDnbYeQYQrh/6BmOYD5Pho9HuhyiS7TSWiPQFVUXvL9vli/EDjXqYLxuHN2JglPjiJOa+jjkLA9IBiP6Ocr8SXJ99Qx6DmKPxSHfN9i7R8TokH8bgDvb4myHmcOiqCWFxJeBZWJbQF6Ayts9vX/WiaCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYjq4Yplv4Rp0LjLe+ZbUbPlID7+tQ9ewTvcbKpenz4=;
 b=N0OKWGXUU+k0UtfJw4lwtGUQlTTBoXGd5gc6yH/i85vpQOkwFZal87ayhgffdT9xZ/xogQFA49d9eKTnL2pVpL7iIYKyy80m++W1F/PGGl/Hx/6Cy6PMTtXhHN1LCRKHKEUeONtnKsLRE5IwRgNh9AXD5Fwy97dfVG2mW2bKwOI7D1OeNIVaE7U3OQ+si3g52Je/It8qc7Bo3N8H5IZe5dwiz7HaM95/6ccUWUpAVJIrWXT6qHwK/vew1JexpiLb/0KaIbMCcVW/pWteZR4GOPlIBJC4OUQh8TyU3g/A/mGmICBbxh5zUnawp426I0QFyj/+T/OrpOPh0E74aFzgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYjq4Yplv4Rp0LjLe+ZbUbPlID7+tQ9ewTvcbKpenz4=;
 b=j0E1HHykIWq8kJzfokSimmpYVDcGA/ZEZ7P8FM5OQAmL1X8ThDgOvohrZZiO44k8JUoLDxzdHI+JuVYH5jiI80JMjx0BqcpEnNyn3WaeL+Ek+gR4iZsyOvfO74JmtmCkWYRfx54p7kuHU8dPbNen2507eev72yoVznznGmRNs1g=
Received: from DM6PR11CA0019.namprd11.prod.outlook.com (2603:10b6:5:190::32)
 by DM3PR12MB9351.namprd12.prod.outlook.com (2603:10b6:8:1ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.11; Thu, 13 Feb
 2025 16:46:26 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::cf) by DM6PR11CA0019.outlook.office365.com
 (2603:10b6:5:190::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.14 via Frontend Transport; Thu,
 13 Feb 2025 16:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:26 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:24 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:52 +0000
Subject: [PATCH v2 03/16] x86/mce/amd: Remove smca_banks_map
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-3-3636547fe05f@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|DM3PR12MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: ad09244b-a369-4356-71b3-08dd4c4df54c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MERzeHhHM3ZUY29nYW9sL3FIWDk3ajQ0VU1zakNBemxUOUpxR2hNeHBwdVBO?=
 =?utf-8?B?U0JYczZRSDh4S0hTRHp6QW9vTjVGV2ZkNVltZlltaFhsNklTSkRxL21XYnk2?=
 =?utf-8?B?UWI5ajN5MUs1MDlNZjdNd3R0NklDVkdQUWhSbzlzT0hGK3NXWjM1cFArdWw3?=
 =?utf-8?B?aEdVaUZQeTVxTG9HOUlyblBHMjBTbFg1Z0dudmRaRGJuc2VDZ2RFR3VUZVJE?=
 =?utf-8?B?ZnVLM0VlQnZUZDFWc1RrZjJCN09sMkJ1NDFRRjk3QlUwVWpyUDJiV2V0bXA5?=
 =?utf-8?B?dlJieFgzTGg0dThvcnR6ZURXaitnenEzQ0YzdFo3THVxN3FpdzFHUTgyL1BM?=
 =?utf-8?B?dFpIOTZuZThwSDdqTS9XTHFHcURyYnJMYVljRmRWZUNWUWQ1anpuM3JpejNq?=
 =?utf-8?B?RnQvRkNpRkdOb2UxbG0vNHo3eGhOMkxHcFcvNjBUc2cwdXhSeThZVGdGejdS?=
 =?utf-8?B?YlYrUituZEgxS3cvbTV1U1R5K1JJN21zaXh6OXFZSkhmaXNZRCtZMitFdFU0?=
 =?utf-8?B?cjZLZlBjaEY1N2VITDRMRk5NMCtIMnI4NjMyS0VHLzY5L0tQb2RyK05oZVdL?=
 =?utf-8?B?VWxxay9UcEs2OVlzZ2JDZWU5RTNLUGtER24vS2gyS1hhZUtHWjZCSGN1L1Bl?=
 =?utf-8?B?aSsvRlNnbFEza2haaWFRM3gxcHNQbklXZ2UyMWRDelZiTHVPZURWS2RUVldS?=
 =?utf-8?B?WGFnckNsVlZBTFpqZWFJZ2xwcTdxbXlFUjZDNTN6WllhRVozTDBIMjQzdUpx?=
 =?utf-8?B?RFE3NmNmUUYvWGg5WlZucVpiR2x4Z1g4WHZrWG01L2MyVllTVW9QRHBiZ0VE?=
 =?utf-8?B?Y3RjWEhrZ1lQemZCSkJqejZCQ3FoU3ZKVGd4TVBDQnJ5K0JhbFNPV3RLT1Fj?=
 =?utf-8?B?QnhNMjZyTG5BTnV6TzlFeSsvR21LNXhJb255Q05wRXJNVUExT0h2ZVVRTWZZ?=
 =?utf-8?B?U3ZPeDl3emx3U1RUdmNEY2pKeWRzTVhGVWNDMXpNblBzbWhiWWZpL2toNnFn?=
 =?utf-8?B?WGJsaGxLWHhNRmdtSE04RUZCU1dTQnhjZEIrWFJDRWN2bGZkZTQwd2dYOUF0?=
 =?utf-8?B?YXE0RUMzaTYrTm5FS1AwdG5LVlpvMU4xclBVUllmWW5KdG1zcVl1eEJPVzNs?=
 =?utf-8?B?TG41WlhRNGF3QXJIL2VudmN3U0NZOUtNdWlPbjdCamRjcE5oRmo5TWF1MSth?=
 =?utf-8?B?Z0ZaekdOT2EyU0hGSVh1djR0NTZxa1dHaXI5YlN0eXhycUowWElwam0rNSti?=
 =?utf-8?B?bjlZNjZXeThLVDFZSzVWcVA3RCtVMkVRWUo0V0thL1I2NXlGVEl5bXd2eVhG?=
 =?utf-8?B?L2Y4NXRDUGRucnZ1TFRDTTZjUUM1TEdOeGR0UVFXU2lGQkVkaVhaNFZSMGZ4?=
 =?utf-8?B?Yms3dHZWUk1scnQrTVlndzhkUjU3Z0dsajJjeFdMblBXdGQwRndoaXA2ODFx?=
 =?utf-8?B?LzY3a1NUcjY3cHFWeVV1WG9pWDdBOTJaaFdwVXhKTlB6bkt4MlZyVEp4Qmc0?=
 =?utf-8?B?Y1NKUkdndEFYaUJMTVFUcUNtZzZJTVVmVE53S0ZZcVAwdFdOVDJZRWJqbWFy?=
 =?utf-8?B?SXNaR2cvajJEelN0b0FLTGFVcU1SWCs1QUlGRkFOeXJvQS92RlkrZHFnUkIx?=
 =?utf-8?B?QUEwaHlyL01raTNzVGFBRnVoQ09MMVdBa2wvMnhFQ1p3bUF2WDUyOXU4TXlZ?=
 =?utf-8?B?K3RFWXlUYXNyWmtiRnFrb0tOU1hrQjJqVCtzQnp0b3grUTJYT05SZTRRNnky?=
 =?utf-8?B?RHV4UXVhZWVSWnJqUFlnOTFQTHczV3Rsd1RUZnBadVdycDJ2d2EzUGt1V2JX?=
 =?utf-8?B?SlFzS0szVlR5OFlMZ1c3TnhMU1Q5UWdYbkJPRVk4Z0hCaGNUNEdkdTBIaEFu?=
 =?utf-8?B?VEQ2S3RFcGh2MXducGZLdHRpL0IyaGw1MDdNRk1neCtBZE9nVXZMQjVNQ0hL?=
 =?utf-8?B?S3Qrak54ZUVJSEZsVVp5ZnFmZlJ6Q0tTb3dwMFZuMFhWNURlSkNxbS9rbjVt?=
 =?utf-8?Q?PGB7M8EG7AqVNWTLFxxnSovs3pkg4Q=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:26.7005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad09244b-a369-4356-71b3-08dd4c4df54c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9351

The MCx_MISC0[BlkPtr] field was used on legacy systems to hold a
register offset for the next MCx_MISC* register. In this way, an
implementation-specific number of registers can be discovered at
runtime.

The MCAX/SMCA register space simplifies this by always including
the MCx_MISC[1-4] registers. The MCx_MISC0[BlkPtr] field is used to
indicate (true/false) whether any MCx_MISC[1-4] registers are present.
But it does not indicate which ones nor how many. Therefore, all the
registers are accessed and their bits are checked.

AMD systems generally enforce a Read-as-Zero/Writes-Ignored policy for
unused registers. Therefore, there is no harm to read an unused
register. This is already done in practice for most of the MCx_MISC
registers.

Remove the smca_banks_map variable as it is effectively redundant.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v1->v2:
    * New in v2.

 arch/x86/kernel/cpu/mce/amd.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 4ea691006c3b..f8ad40c5c887 100644
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
2.43.0



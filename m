Return-Path: <linux-edac+bounces-5070-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90627BE4A11
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D034248157F
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7B034AAFC;
	Thu, 16 Oct 2025 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Z+txOkVW"
X-Original-To: linux-edac@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6064133CEAA;
	Thu, 16 Oct 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632690; cv=fail; b=L+Qccela3zRXxiFav0MW9WPVK6FlLvSbWxcyH2ApVsiX5wQHKuUFKKQhGWEFPaGueWApOiAD8zoL9TRoOhuiMLeQLhGLxaS18h1DF9WGDn/d/rGyYz1M1HHgKYKXxsWhXQlgh5RCTimizFcEEU2Tl+3Wlb4nXBulVoUircKRUYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632690; c=relaxed/simple;
	bh=EobZeXEAx1PiiwOFEZg+/0X8qSDffgEZ5emtp1aSke4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cX+e1zWfYmhkaNznliDF8lH/nU5ckyJvxJKbvST1OlGS8KoZkt/ZLth1FzFQifS5RhR44h9wo9WP1x0+ze2yzVUd2pc/MxHAcGW/3InpxxMjRWIJE92cQw3RpuRrTYdmIgz6/cX3NS84Iv51yM/rDXxodNqx4Ho9uoG3OWBwOYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Z+txOkVW; arc=fail smtp.client-ip=52.101.61.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y9vV4Ng6TeC3eVdjRdgwOJeMtx3FrwupODBkC8REJiZ6ACdva00r8SvsUGD6bRcJYQMNH017XCCMFRp2aAAAYJ7D1W81uCXBKthE5wIRK37e9DCOhS7G16VDoVUGS3bXaAV02+PvoDDHIQi6GaTj+ML2uc8FwiwlsNglEDh0YeXZvGKvy+T3DjvIBjKHB6IqZFBR3thLPv8e+CnhPOrxCJV39PWGBaN67f4YgwjtQYmsl6EN1DnHbiRcoDe43PcZ9aiJW64VaUpukYwHLFbVefBd5H17/g1Vc5sI3MSl0Tp3kcZW8eTndf2N7ianNX2i5Nb0uM8LGhQw3aav5+mlqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv6kccuNvP0eij3y7nnLuGNKXsVguh14uIXc3WrxfRY=;
 b=mK1QJB0TowtiQsQTokRLroEDNlzOiRmbHtDNABXZ4+SxAmibVKpGOTYhcGC4JGeeq7L05Nj7AIeXlc4UFrVcXWwGOYP59xhO4Wg2dc/yc89eAZbtOQKD0wMODElKKxRATxbCMUUxKKJIIurgmfyF7YiMhl6cNagAfIsA/xQF6ObLm1dCWBosg0cMRdpuG3/AH4VbEFdLAzG1H6yjwN40+PAx5f3Nz96jUb6eCh9naPho7SOqp16z/o9HpDN03LyC7N1kPCNK2sB+st7+uHatikBCP/5Oz7etoc6q7OpxrTQSpNMCf6K9WwuX96BvY90I01T5umZMD5tR3yR3EZAxsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qv6kccuNvP0eij3y7nnLuGNKXsVguh14uIXc3WrxfRY=;
 b=Z+txOkVWLL1sImr395tre8IJ6/dV09TgUy8YBn6L/gezJq4EGmVhlsLsl0hQc0WG2weXSAy+wLzLnBMcXo7V5En4HsFvG9DQuUSjsN1Xa6T8ph8Pb2SxvxYWxUbH1K3wynMw2q5W+5K/OiMzgPAcAkHxz8YF8g7E3YzsHHJVvoo=
Received: from BLAP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::18)
 by DS2PR12MB9663.namprd12.prod.outlook.com (2603:10b6:8:27a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 16:38:05 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::c1) by BLAP220CA0013.outlook.office365.com
 (2603:10b6:208:32c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Thu,
 16 Oct 2025 16:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:05 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:02 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:50 +0000
Subject: [PATCH v7 5/8] x86/mce/amd: Remove redundant reset_block()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-5-5c139a4062cb@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|DS2PR12MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: ae7bdca9-17e2-4cec-6534-08de0cd26184
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S29TU2NrOVJaNVpOV3ViYjRaUll3ZGFzYW1aMHQzMlE1Vnp6SmxMT1Z4a2Ra?=
 =?utf-8?B?Njh5VW10TmpCOWc0WWJSNHN5L05JTkpoaGxpVy9LOUszTTRhSVArdTJwQTU4?=
 =?utf-8?B?Ky9NaWp5dWJiUVlKUEE0V0Zsc3JJdTBKcXVtc3NPWkhGcDBsdFB2UDFBSGYx?=
 =?utf-8?B?WlptSkRhL0ZhSm9tdFRVRzBTaUR6RjczbFlLN0pCdjdoZmUzNk1NaENPR1Jt?=
 =?utf-8?B?QUxLNkNNdTRyUlJvNlJlUlFoQTc0T1JHOEUxMjZYL2hKamNrMXlsUGtkTjFj?=
 =?utf-8?B?aXY1L0g4dlpWNWhvbHpxaHVJemovTDVRL0c5OUc2VjZzb2RHUTU1NDcydyth?=
 =?utf-8?B?aFV6T0R6UXhFa09hSjUvdEpDQW81TXh1SFpvUWIyT0xNNXl5VTYxQWV5VHZC?=
 =?utf-8?B?Y29Ra05jdUErWmJwU01WZ1FwNVNiRWdLVXMvbFhERUF5ZXNVd1FmSHptZk9W?=
 =?utf-8?B?cmJvYjF4NkIyTXZ6MUN6MmVKeEVwckJJZzdYVzEwRmdjV1B5eG9iZXNFbGQ1?=
 =?utf-8?B?ZWtOczRCekVaWVRLWG45WjAzWjdtZk5JRDI0aUJrMENSc0RlTlBHeHVUd2gx?=
 =?utf-8?B?WFZWa2N5dHdXcUJYVW81ZS92cTJKWVNPUlBjRllpcWs1KzF2V3E2Y2JnSHhi?=
 =?utf-8?B?N0lQTDNyU1BINnplRU5qVnR1c2llRU1lK1RacDJOQWNaYzA5aE5ybW1EQVps?=
 =?utf-8?B?a3pQNmxldnpFMnMyN0U4TWpKbm9vc2lYUnE3d2lweXRSaUR4bGJkQkVXc2lB?=
 =?utf-8?B?YnRpY0JrNmJUVmh2ZHJabnFBL0hzRDU3WFdROHJ0c2RuaURDbWlwT004SHZR?=
 =?utf-8?B?ZXdCcFlyKy9oaEJDdlltOFpWMDE4b29pc3craTU1dWhmU0M0VHFrS1pPbjU2?=
 =?utf-8?B?eDJjMVU4SllLOFdjK3lvSTBNQU9RcDlMRm56V0xWTi93YjV5TVBxTHVKbHdG?=
 =?utf-8?B?UmNKZGh2eEZyKzBMZldyVnViYVhzUFA5cmF6N1BOd3BxdWxQVnpEcXB6U3RL?=
 =?utf-8?B?OEY4dlF2R3hXc0E4N0hOSHUybVM5QkRiTnZCTTdDZDdpb3V0cHJKLzdoM2Fa?=
 =?utf-8?B?eUlXUisrTlVWR1pYWkoyam4zcmFFeXhZV2t4eXlJYlFrcXlPRDJ3V1VCS1VE?=
 =?utf-8?B?SFBNdDNHdlRCUUN0d21STUZtTlpFSytneEhzOS94UGJsb0loZUVmYW9SVnpF?=
 =?utf-8?B?NmJ3RExBOGFEODZKcnk2eFMvcXJLTFZTd0dvL1FCVGp0dmwxRFpzd01mSnpy?=
 =?utf-8?B?TlVIOWhLTjVGQWFXcDlhR3B5eHRUVjJvSzJqd0xXdXFqSUNhYzdtV3dJVkRC?=
 =?utf-8?B?blBpQS9GRWFMMUhGNDhzZmMrM0gxSVpMTHdmcDFlZmkyQ3VBNlZuSzU2VTJY?=
 =?utf-8?B?RHkrR1RUV3BYb2piOWVyL1VuU0lwY0thZ3NIWGYzZ2w2ZTF3ZXJYdzFXV1NC?=
 =?utf-8?B?TlhDeVN5emR1bzdOemJjbFZPMDFicVdQbEhXV3l0Tis2YmxlY3ZpVGtaZFpp?=
 =?utf-8?B?aEJtVkU4QzM1aXgvajB3bUNkay9iMDRQTW1CeWJLZGlYcy9xTVR3b1hqWENG?=
 =?utf-8?B?SEU1ayswTjlvOXgzbm1hUDNnZUl1OWs4WFJraWhrRE1ESTBUTFUvYzZnWTRR?=
 =?utf-8?B?YnNzRU5GdE5Jc2pYeU9YWFZCdWZsZ3NZTndGOWhkM0ttR01kNnZrRUFhLzR6?=
 =?utf-8?B?cHREajZscERRUmZ0SUNyeW92NEsxYTR4NnBpM1ljeVp4S3lTUE9oc2x2V3hs?=
 =?utf-8?B?dElQTmwwaVd4SzRCeGJraGNyTlVIWGU3ajVwYTkvSlljbS84Uzg0Si9laFo3?=
 =?utf-8?B?RjJKbTJOcWwwQnhnQ1d4L1VnT0tBVDBHRHFQTjBkM1dwWnJOSTZwZkpIY0w3?=
 =?utf-8?B?MzBXWmJXaFBVcUpTMzI0V2dXZ0YrL0dHcWpPSUI1ZFRROWlpTWE0L3ZBcmx4?=
 =?utf-8?B?bnRyMXU2MVdJK1YwTk5XTUVOclNqTHR3dk40ZjA3WE42allLTjN1dGdWcmJD?=
 =?utf-8?B?ME5YU0JiNndaWnhXR3g2cXlMNzBrQ1pRVHliU2o0VDJQNHRJSnhNbTJPbU5Z?=
 =?utf-8?B?Rk5WeEk2Vzk3dTB2eFVyWWI4MWEyR080d2VrM2tCY1JnTmhQSndmTEk3dzE0?=
 =?utf-8?Q?ZEyM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:05.1472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae7bdca9-17e2-4cec-6534-08de0cd26184
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9663

Many of the checks in reset_block() are done again in the block reset
function. So drop the redundant checks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-12-eef5d6c74b9c@amd.com
    
    v6->v7:
    * No change.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 91af769b9d8a..29f777b404cc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -812,29 +812,11 @@ static void amd_deferred_error_interrupt(void)
 	machine_check_poll(MCP_TIMESTAMP | MCP_DFR, &this_cpu_ptr(&mce_amd_data)->dfr_intr_banks);
 }
 
-static void reset_block(struct threshold_block *block)
-{
-	struct thresh_restart tr;
-	u32 low = 0, high = 0;
-
-	if (!block)
-		return;
-
-	if (rdmsr_safe(block->address, &low, &high))
-		return;
-
-	if (!(high & MASK_OVERFLOW_HI))
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-	tr.b = block;
-	threshold_restart_block(&tr);
-}
-
 static void amd_reset_thr_limit(unsigned int bank)
 {
 	struct threshold_bank **bp = this_cpu_read(threshold_banks);
 	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
 
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -844,8 +826,12 @@ static void amd_reset_thr_limit(unsigned int bank)
 	if (!bp || !bp[bank])
 		return;
 
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj)
-		reset_block(block);
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
+		tr.b = block;
+		threshold_restart_block(&tr);
+	}
 }
 
 /*

-- 
2.51.0



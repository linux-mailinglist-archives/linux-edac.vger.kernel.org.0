Return-Path: <linux-edac+bounces-5117-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 519E2BE8D6D
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 15:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261C75665BA
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7263570DA;
	Fri, 17 Oct 2025 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXapAAe0"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFAD3570BF;
	Fri, 17 Oct 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707627; cv=fail; b=fmyfBf6HQ27chCtL1KIB1i5XBwyFxNeG7LuL8lKUVvwMVXSV5BrsVALkg1FZkBQxKsdUPXgKBZv0vJ/JPoLGIYMh90u2TIWlFem04Dd39Oj+75GibBO0elaMRBLNorD5WraMd1R/C2aOgbPGkTyyQv46PfcixM9Q2KPU8h5xkl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707627; c=relaxed/simple;
	bh=8wvclkueylO7gbcOlfGNQ82jhxgFuKe4khH4Dn3+lFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BJ50qVvrHsxcnhxig/+0Wzu+TdSBxYZb7uYyY8iPttVBQSdh28Yc+uH2tIT8C0b5z8LyUXYb+k01uYRuPFU/d00cyg+MDVtqV2u0ezl04ysTxKZg3rwKpgsAfiI4VdQkNw0Yl1lxBTkMndmh9ZvCl9edSpwNnCDsSjcjObiUyb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXapAAe0; arc=fail smtp.client-ip=40.93.196.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXrvPj9QR3aWDyRKl71m0ufUpAWM2LlgY5bsF0dOFyi2M2aIdaqjbaUIVCkrmn7/4uaOVBoWc59w28/4LtSP3gFKMTK9xZ+i7jIXWFf1S/lpXusX033jDpsSQruFoMlDeM9ukUglnqKdgjLDvTaf4pL1jzc4rr/3BC3IsmoQt4RGzVSvurr1h1xsEd4eHPHKcUmCbMibvRU/cBz32LJzjcoLVEM3V/RwFFfw6wjRlNL0AOa8S70kgi9kChZRP7gVCSXkH8X5g/UbylASnucd9WYrVM2mrOeAR9sUoxMCPUQfumRNrRPSl0j3+Woog+D9gL+Q6LdIdNqFuIKN7FjYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3egDY5agUqMgN8EiU0XepjW9+lpN7dGY3uSuPzIY+n8=;
 b=bRIGmCxaa3FCDsghjcio55WOgF7vm5Tqij5hmDke8lrmSAwSH0j/BMmhviYIQFkma9ooj1PnaRZiIy8Ygi1zMW9mPCrISqdDHzJaPtxCTvKvegwvB/xr7XR3lHjwA/5W0Gb968QxLgoekO2qU64CLxr3Gue1/19PXaO8e1ekNmC/r67rRvbH1bKOMmMPUDDc1b1bATwF3A/2mwfNrOq3yjvTtCKPs/LAKJrKOGuzBghbFd/+2WWRUcAz32NsBcL9831qvMvk10m7gwUNSKpMHOcbEd1kGcSQfTmsBUSiBi8BJiudMcqxm0FJ3gRVkVJ4Nqe8NlX8ViOmmVw0KkgSpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3egDY5agUqMgN8EiU0XepjW9+lpN7dGY3uSuPzIY+n8=;
 b=JXapAAe0a0FfpWDMfF78guG3xhJHWkmGJPK5MMHgGU04t8oVudfAUXzDNiVx/5fd5533CAh9dDp3bxSyVrDqZadfLipNjo0+tHhfE4SArCtCBsKKkN+aQ3AN0jZTarPKNh9E8btgwNLG3aAQvuvTQ8w6Yc3PUq5+DnTaqn4DpVE=
Received: from BN9PR03CA0329.namprd03.prod.outlook.com (2603:10b6:408:112::34)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 13:26:59 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::5d) by BN9PR03CA0329.outlook.office365.com
 (2603:10b6:408:112::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Fri,
 17 Oct 2025 13:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 13:26:58 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 06:26:55 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Fri, 17 Oct 2025 13:26:29 +0000
Subject: [PATCH v2 2/2] RAS/AMD/ATL: Require PRM support for future systems
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251017-wip-atl-prm-v2-2-7ab1df4a5fbc@amd.com>
References: <20251017-wip-atl-prm-v2-0-7ab1df4a5fbc@amd.com>
In-Reply-To: <20251017-wip-atl-prm-v2-0-7ab1df4a5fbc@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 574b34fa-a048-44be-a463-08de0d80d95b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXp4NFI1RGx4bUpZTTMzZWdRSEJKbkNYTzZ6bEdnUHRrOTBNNzRaWkdJNnV1?=
 =?utf-8?B?MXpEVXJFampmbGVvblA1OVFkSFkrTGYrMy9qajFPa3ZWTHR1V2FnM08za3RV?=
 =?utf-8?B?clN5amdFdFFLTTlDZzNyYjFhcTJnMysybUN3STluMER5TW1VMDl2dEEydzRr?=
 =?utf-8?B?ZFUyUmdGZnNWODBuZ2J0QXIrcFlGODFxUlZJbUpzK1B3NXlIcHYyNDRYVmdy?=
 =?utf-8?B?UDJkRVAreGxzc2s3ZjNDN1FNemk2UjdvY2F3LzRtMmhzSDBqZ2RwRktOMUJN?=
 =?utf-8?B?Njh2alFlNWs1N29IbWpidlJ6UkNlb1Z4OVRoV1R5bXRLOHdoNVNWOFN1MWRu?=
 =?utf-8?B?amd3T3BkNkFsRFlHTmpYSklmT041ZTNZSXJxRThBRm1qVU9OYzlMQThMSXBH?=
 =?utf-8?B?N1c1OTRIcFdzdGdHblE5U1huWjR0R25Wb01sbjN1ZzZ3UTBUek9La3N5N0hh?=
 =?utf-8?B?eFZnS0RSSlovMVVKVWtUTXdJUVFBOU1Tbmw5V3lVVVN4cVBERzcwdDV0MTNQ?=
 =?utf-8?B?WW8xcDJ6TnV6MWJ2cnVlcFlNcG5SYVhWV0M5QWMycWtzUUxHMENyMlF2UTl6?=
 =?utf-8?B?c3FDNGpEMXVySkl4S3psV0pTdndsWnF5RmtoRzBPeitTOHIya3dyZ0JFYVFS?=
 =?utf-8?B?OGRaZGhpSVJ5UVNzUi9EMzIzcGtVSnU3ak1ySFBZSnNhSHgrakFsdlJNVEgw?=
 =?utf-8?B?VW9WM3ZtYjZ2VVErN1haYzFESURZNGRMaE5GaERDOVNhZSt4eHZxVVZEY0RI?=
 =?utf-8?B?VTFUR0xLL1diYzkreTRsaHlDdmRZRXR3VjRibGYya2tqMk1GdUdrTDFLS2FM?=
 =?utf-8?B?QkptUlZSOFZzOGsxT3VVU2RvdmliamxjM09LR3A5YlhnTmsyMmhHSVpZaGZ5?=
 =?utf-8?B?Mnd5bmhGNnNSWmdWT04wT0Z0YXhtN2o1QVEweFpOSVpkckNZdTNUM2FhTmJE?=
 =?utf-8?B?a0tBOG9NYWpvN3R3M3NKR2d5b1Q4OXdXSWR2NXJUN0RiS0RQdFZLeGdqV293?=
 =?utf-8?B?LytlYkxUUWFJUlljTDg2RHMvc1FXeEVQV2Q1blFoazBaUUdzbDBCcFY0YUlp?=
 =?utf-8?B?anR1dkhPSUFIeDIzMW0veElhVGVaaDIrT29xQUZ4YkJ3cWk0aGUxWFMrZFoz?=
 =?utf-8?B?bDVsQklpeWlXcEExQ08xMTVJTm5OYVlGYzRGSkJLSmRxNHdUTXVsSjM2OWxw?=
 =?utf-8?B?elVudkU1aWNsS0djelBOTlUxK25YdGlQbEt4aHpEc01laEhSMkpMNXc3bjF2?=
 =?utf-8?B?OVdTVlFIUDRSeEg0dTQvbnhPa2sra2VGNGswQjNnVHorZWx1dVFWZXcvb3FI?=
 =?utf-8?B?cGp2QitWRE5OR3NkcC9WR2RvY25kdzZWRWR5UXp2bGlmV2NYd3JidW9DbWhX?=
 =?utf-8?B?WC94WjNkSkE4QjFBVmNSS0NIbTJicm9KTjZFL3Y3V0RqMWl3RW5JQ3RjYjRG?=
 =?utf-8?B?bVdqWVcwTVVIQko0NDhVU0lxWHgyYmVKWkJ1S212b1RHVFJVY2wzMU9ycXNx?=
 =?utf-8?B?RHc4UUNlVjIzYXVPMTJSR1lqVkgvM0R0V3UrODFrVW10eGFqTzI2MklvenBJ?=
 =?utf-8?B?UlJWbXg1Q1hya2NSSHNFWlNlMGRHMzZTZ3dCaVdnTjRkdi9XODF6SUhIRWtE?=
 =?utf-8?B?YWNvR3FPUzZMQ0NoRUQ5QThiOWxIcXZxWFNVVUlKZnhHeUh3bjR2T1JuZmli?=
 =?utf-8?B?VEVEbUZ2MDkzYkd0UldzRnQwRDYyMHJFNnZLRGFDcmN3dVZ4UDV3RXU4TXQr?=
 =?utf-8?B?a3FxV2lpZ3drbk9PVEx1MzJQb1VDN2l5Wm91Vkw2eFNERlVyUG9raGI3M3Fp?=
 =?utf-8?B?YnpaRGRTbm5DUm9YN1lncDA4aGh3K0plTFBzQWpTVTR3dlI2djhaLzMraVRt?=
 =?utf-8?B?bk16SDhsdVhvTlQvK0ZPMlcrRkMxUlIzdnA2SGJIaXArdDdxRFYzejYxcXNR?=
 =?utf-8?B?WUZENG1WZUJrNkV0NzhXQ1FoSFVwaEFZREhqZGVMam1MV3NPUW1rNzUya3p5?=
 =?utf-8?B?MWZsdDRJdmhVZFBpdHpBK1VjRGdIZXF3dTltaTVOYXlqTGl1NXdjWDFrK0ow?=
 =?utf-8?B?cHcyL3JtVDMvR1hSTkphWTNOUUlNUHg3d1U0dXYzZG9FVFRSSUFuMjhkSTBn?=
 =?utf-8?Q?HWt4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:26:58.6378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574b34fa-a048-44be-a463-08de0d80d95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

Currently, the AMD Address Translation Library will fail to load for
new, unrecognized systems (based on Data Fabric revision). The intention
is to prevent the code from executing on new systems and returning
incorrect results.

Recent AMD systems may provide UEFI PRM handlers for address
translation. This is code provided by the platform through BIOS tables.
These are the preferred method for translation, and the Linux native
code can be used as a fallback.

Future AMD systems are expected to provide PRM handlers by default. And
Linux native code will not be used.

Adjust the ATL init code so that new, unrecognized systems will default
to using PRM handlers only.

Reviewed-by: "Mario Limonciello (AMD)" <superm1@kernel.org>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/ras/amd/atl/internal.h |  6 +++++-
 drivers/ras/amd/atl/prm.c      |  4 ----
 drivers/ras/amd/atl/system.c   | 23 +++++++++++++++++------
 drivers/ras/amd/atl/umc.c      |  2 +-
 4 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 2b6279d32774..82a56d9c2be1 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -138,7 +138,8 @@ struct df_flags {
 	__u8	legacy_ficaa		: 1,
 		socket_id_shift_quirk	: 1,
 		heterogeneous		: 1,
-		__reserved_0		: 5;
+		prm_only		: 1,
+		__reserved_0		: 4;
 };
 
 struct df_config {
@@ -283,6 +284,9 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
 
+/* GUIDs for PRM handlers */
+extern const guid_t norm_to_sys_guid;
+
 #ifdef CONFIG_AMD_ATL_PRM
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
 #else
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
index 0931a20d213b..0f9bfa96e16a 100644
--- a/drivers/ras/amd/atl/prm.c
+++ b/drivers/ras/amd/atl/prm.c
@@ -29,10 +29,6 @@ struct norm_to_sys_param_buf {
 	void *out_buf;
 } __packed;
 
-static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
-						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
-						 0x2B, 0xEB, 0xA6);
-
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
 {
 	struct norm_to_sys_param_buf p_buf;
diff --git a/drivers/ras/amd/atl/system.c b/drivers/ras/amd/atl/system.c
index 099841433cf9..812a30e21d3a 100644
--- a/drivers/ras/amd/atl/system.c
+++ b/drivers/ras/amd/atl/system.c
@@ -12,6 +12,12 @@
 
 #include "internal.h"
 
+#include <linux/prmt.h>
+
+const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
+					  0x92, 0xCD, 0x2B, 0x56, 0xF1,
+					  0x2B, 0xEB, 0xA6);
+
 int determine_node_id(struct addr_ctx *ctx, u8 socket_id, u8 die_id)
 {
 	u16 socket_id_bits, die_id_bits;
@@ -212,15 +218,17 @@ static int determine_df_rev(void)
 	if (!rev)
 		return determine_df_rev_legacy();
 
-	/*
-	 * Fail out for major revisions other than '4'.
-	 *
-	 * Explicit support should be added for newer systems to avoid issues.
-	 */
 	if (rev == 4)
 		return df4_determine_df_rev(reg);
 
-	return -EINVAL;
+	/* All other systems should have PRM handlers. */
+	if (!acpi_prm_handler_available(&norm_to_sys_guid)) {
+		pr_debug("PRM not available\n");
+		return -ENODEV;
+	}
+
+	df_cfg.flags.prm_only = true;
+	return 0;
 }
 
 static int get_dram_hole_base(void)
@@ -297,6 +305,9 @@ int get_df_system_info(void)
 		return ret;
 	}
 
+	if (df_cfg.flags.prm_only)
+		return 0;
+
 	apply_node_id_shift();
 
 	get_num_maps();
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 6e072b7667e9..18ce419236a5 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -422,7 +422,7 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 		 socket_id, die_id, coh_st_inst_id, addr);
 
 	ret_addr = prm_umc_norm_to_sys_addr(socket_id, err->ipid, addr);
-	if (!IS_ERR_VALUE(ret_addr))
+	if (!IS_ERR_VALUE(ret_addr) || df_cfg.flags.prm_only)
 		return ret_addr;
 
 	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);

-- 
2.51.0



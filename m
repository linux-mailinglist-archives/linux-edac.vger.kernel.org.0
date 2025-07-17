Return-Path: <linux-edac+bounces-4379-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6B3B09254
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 18:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC563BA58E
	for <lists+linux-edac@lfdr.de>; Thu, 17 Jul 2025 16:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18872FD592;
	Thu, 17 Jul 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3Ryfj+53"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4DA2FD589;
	Thu, 17 Jul 2025 16:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771412; cv=fail; b=NLkZEfY1zl+tCr74Shi/KqNwnzJjA18SdxgzCNgcSKQW3PGYml30D0Y96rsa64zOVNVh3jXrrMFWcMXejVXuvI/51bsJcx8EWXCoxj+ZHRRrcdnvoqP6NRh2sZsXva2vywYpOFo1r/FWnwcjfmKKwmXkwq5ZVdinaiFIYIKatLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771412; c=relaxed/simple;
	bh=s23R5pJzP7sApjX7JvOFbTjXTQcyjDvnh558JaX2TVE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IUMkJr3wpBrOWhNxcjY6uytuUgqrcItqXQf378L5LNMtSRf80RNrFTtUuUjNuQTzG1Sa/WHVr7hBgNSqXUcYX9YTiuMaPu4jyfHKvaEUp2oamd8mqtHgn1v8QOc2j7CeDZeATn9L50oACW/qSSPXSgUwJ/rdKRj3nLiF0m7x6Kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3Ryfj+53; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sRP6LgoyPo/ZOmUwbtEvUzRpmmoEXCGwMVE75Olq/9NIIZTZ/qBs0GwOUrz3S2If53xJCSiYbmAv79AQYtkJNhPdUd+QZMZAXMztemWc9kq34uPNFe+dcRZGlaXz12yOcrZ1/fDtRQD2jCJAUfDM1mOqUGUlY3GkVRX+nwpsDDw1iVWG35x/QQd67Drd2YncHft5PoaGNP5XnFzeLmT1USZlco4hUVSWJ+/KnV1Am6Sd9wJ818tidjKfg2Y1ygVu3yk3u038Zl9O4lRzsfAoBXRPzb/SNpAHKXYHuB9MnTttvHvGoLxqWrwAmopZ+2NEsYycj15/vYgy2GHpk+ad4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJLmmvnjomIqgjdRoi1OnxeBb/GD+K7pbD7eRTAcDic=;
 b=ohs3SlSESKwMOUPl7FEy7eT36e7FS19AOaQA+p1eSZ1i8HK6YI8A41vyypGXyKDHmeAI2DaHantAWvGhJa3KDoGLRarzuaYnSEJFiKwgDLuePK5SGKOO5buGKLuVgq+Xtil0XlIs3OdtgUM98k33laSNvxLnNmC/qwtrT8CAfuHaeLkR4YRk7Msg9nHpy+hvaF2oTpXLkOz4eZkTxEHCYvQ19lNeXZVOrMLH5ult4TK7TD5BLSrqVawIvIEa7gU76XVEacMywNP89EU7CByx6lpDEj5uqeK+6ABJrRhwJj3BRj5DKsCwvrJHUwrCHKJ2VHsutdgdYOt7KDF7xDlugw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJLmmvnjomIqgjdRoi1OnxeBb/GD+K7pbD7eRTAcDic=;
 b=3Ryfj+53vdYi9zBv7P3albxIsbVE+AQsmo+QCTQ/bdl9A9y+4iaVxAynnr4cgDtiLo9Oxj5f5mQm8XCoLY2pw2oxiWAcclVtAS4AzjPmuie6O2u06VaTTNlrTtr35ZdyeH+AZVewNcGVZxgNv7kXDH7WRO3KRYdYdll1F2XdgJQ=
Received: from MN2PR14CA0014.namprd14.prod.outlook.com (2603:10b6:208:23e::19)
 by MN0PR12MB6175.namprd12.prod.outlook.com (2603:10b6:208:3c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:47 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::5) by MN2PR14CA0014.outlook.office365.com
 (2603:10b6:208:23e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Thu,
 17 Jul 2025 16:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 16:56:46 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Jul 2025 11:56:44 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH 1/2] RAS/AMD/ATL: Translate UMC normalized address to DRAM address using PRM
Date: Thu, 17 Jul 2025 16:48:42 +0000
Message-ID: <20250717165622.1162091-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250717165622.1162091-1-avadhut.naik@amd.com>
References: <20250717165622.1162091-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|MN0PR12MB6175:EE_
X-MS-Office365-Filtering-Correlation-Id: aed143e9-a7ab-45ec-653f-08ddc552ea85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3p5ai9IM3NqdGI0ZXdibHBIczZidUt4Y1J1bUFxZWFjYlRLZ3l5OUZSK05D?=
 =?utf-8?B?UzZvWDZTWUNPTlVsWnNGbU9ZQVJkbllZQjlpTjhOSitvTmIyblNTeGcydkUw?=
 =?utf-8?B?T0hnczVuRExTckl5MlRBYW9hd0QwQXZDajZDSnpJa0FEVEFqWHdZR2Z3YllQ?=
 =?utf-8?B?OXhqNGtjRnd5QUhIU05SNG5MQldjVnZaaGo2YmFUbGpOci80bE82aS9RMzNN?=
 =?utf-8?B?NklGRjhUZG5kbWVQWEtlODJsZ0lXbnNFdXhOa3FBOFVQR281STl6aFNiV2k0?=
 =?utf-8?B?d2xaV0Zyc2hIbjhFc0lld21YMVEwRmJQYTRqVUNUS29DaHJzZnR1WEVOcFdq?=
 =?utf-8?B?VDVvdGhPTnIwdlJRYXpWd1A0M1Fab1E5MmJxOEhORWZUeHcrZ1BwODJ0c280?=
 =?utf-8?B?YmhNUTNhVFhvYnJ0OExleDBlNURnTG1xaStpQzBUVy9NS2lqSkgwb2JoRVZP?=
 =?utf-8?B?aFUxVDlkUHR4bzdOSTV4bHdnYzVvZEZqSlA4NnMxMW1WbE5NMGZlK2ZNaE1Z?=
 =?utf-8?B?VGlCUXVVNkRTVG1WQlV2SzYzNDAxZ2ZkcCtZVk0vVXJHVHI4dDFKaGVTSHRN?=
 =?utf-8?B?WlFET2xKREYwOVdiMHJNMnF3YnByeExJUGNvRElrNlp4b0xVRGhZaG9aMDB1?=
 =?utf-8?B?OWhDV05zWW40cnFWTHZlclZMK3BvWm5JWDV1UUxueXdOV2pvbWtJbkdIRDBa?=
 =?utf-8?B?WWMrMlAxdjNxc2JxMnVVNEhkMUhvcG5mVENmcWgwdG5jM0ZPMDVkcUpKeDd5?=
 =?utf-8?B?M0djTkRoRkFHY3pXWVpXT2wrcnczVDAyZlJSeEtqYlhhWTFNSVUzdFV3MEM2?=
 =?utf-8?B?ZDJQOFV1ODJzdFVkRDFpditYdHpqbUpEcEMwcHlWb1dIYlZQV3BtSE9DZytn?=
 =?utf-8?B?NGF5am54YXlhWTFaMm5KNS9rQnpXdjRQeXZHdllBcFZtT2Q0SWdaTmxtTkU2?=
 =?utf-8?B?M00wa3AwS1lzMTl2UUpEdmdqRFBKMVpsQVJ2K1Vhc2FUN05sYytvd0dKMHJ4?=
 =?utf-8?B?RjIrd2hHOStxTndpS1N1VTFsK3BnTGZmWjZQS0RROHU3cmNtSy9hRXhmRVRk?=
 =?utf-8?B?Y3FOTW1UckNmOWd0bm4rWm1WcjU1dkkxdjdCakJvajFKTEhnOUl4VmJTa1Uy?=
 =?utf-8?B?Y3lsYUFoZ1VxRTRzTjJEVzVZY1NyZDh4TU5WOUlUS1MzNVROMm9iWmNGOHJh?=
 =?utf-8?B?L0pQend4aFA0YW1DUkpDbStUd0lyU0RONXAyY2FkWE0xRWFBaEpxU0dybWRH?=
 =?utf-8?B?SFNSN3RrRDlHUXFMQmUybERaYUxHb3BmOWRYWXh2WUdhQVRjYlZQenZqbFpY?=
 =?utf-8?B?M21rSW5YYVpibi9MUnFEMStYVXBQSStKTlViaWZ3UDVWbDg2WCtmbXJ5dkhH?=
 =?utf-8?B?dDI4V0MxcXhVdlhGaDBtRGhGc0h0WmxOd3lSMW9yUnBxMWNzZ0NpN1Y5cVl4?=
 =?utf-8?B?QVM1bWc1d3hxR0xBdTdrU3VuOVl0cWRDN1dIQmFYMTNnTFhqcVplRHFOVTE2?=
 =?utf-8?B?Z0FGWU1IZWNaZncrb09aYnRjQlBERjQxWnVLZzJwVzc3RktZV3UrNmlOS2Js?=
 =?utf-8?B?Si8ycThUVVk5SGJaSXJTMXUzL0g0cUx6UFBqYitFNGNBKy91ei8wZFdNdVhR?=
 =?utf-8?B?OHFnVkE3cFJ2QWovT0dQRXFuL2poNDRiK0Z6QzRyWndTRUEwZEdPcFVKeVhv?=
 =?utf-8?B?clZ4ZjZtTk9XeFhBTFVLTE8rQ3kvbU1ocG1OdWlZVnNweENhalR4MktRbEUv?=
 =?utf-8?B?aEM3V25lRWN3MXY5RDhEa2xrMWlQT250emkydkNDZ2NGc1pobjlIRkI4Y0xU?=
 =?utf-8?B?NUNVd0NOTlJhRHlwWFVPMFNadTdQOUtzTldab295ampGOHZPeEdtZUtBRTdQ?=
 =?utf-8?B?RGFQbWNmdG9RdFg0NHo5b1I3OFBKNkx2U0E5MlIzNGdtemREM2h3QW9mallo?=
 =?utf-8?B?dmxKeWFoSHQxWmZxWSttWkFtTitndGo0d0NCbHkzOHhNS0toTmRhckhDOFFZ?=
 =?utf-8?B?TzN0Ym1lcDdoS0NsaDJwa3FlN1BIeHhGRytkSGVEbXg4ZUNnTXBaT2FyUlNV?=
 =?utf-8?Q?bBZ4PN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:46.8401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aed143e9-a7ab-45ec-653f-08ddc552ea85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6175

Modern AMD SOCs like Zen5 provide UEFI PRM module that implements various
address translation PRM handlers.[1] These handlers can be invoked by the
OS or hypervisor at runtime to perform address translations.

On AMD's Zen-based SOCs, Unified Memory Controller (UMC) relative
"normalized" address is reported through MCA_ADDR of UMC SMCA bank type
on occurrence of a DRAM ECC error. This address must be converted into
system physical address and DRAM address to export additional information
about the error.

Add support to convert normalized address into DRAM address through the
appropriate PRM handler. Support for obtaining the system physical address
already exists. Instead of logging the translated DRAM address locally,
register the translating function when the Address Translation library is
initialized. Modules like amd64_edac can then invoke the PRM handler to
add the DRAM address to their error records. Additionally, it can also be
exported through the RAS tracepont.

[1] AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh ACPI v6.5 Porting Guide, Chapter 22

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/ras/amd/atl/core.c     |  3 ++-
 drivers/ras/amd/atl/internal.h |  9 +++++++++
 drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
 drivers/ras/amd/atl/umc.c      | 12 ++++++++++++
 drivers/ras/ras.c              | 18 +++++++++++++++--
 include/linux/ras.h            | 19 +++++++++++++++++-
 6 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
index 4197e10993ac..ca1646d030ca 100644
--- a/drivers/ras/amd/atl/core.c
+++ b/drivers/ras/amd/atl/core.c
@@ -207,7 +207,8 @@ static int __init amd_atl_init(void)
 
 	/* Increment this module's recount so that it can't be easily unloaded. */
 	__module_get(THIS_MODULE);
-	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
+	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr,
+				 convert_umc_mca_addr_to_dram_addr);
 
 	pr_info("AMD Address Translation Library initialized\n");
 	return 0;
diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
index 2b6279d32774..53095310438c 100644
--- a/drivers/ras/amd/atl/internal.h
+++ b/drivers/ras/amd/atl/internal.h
@@ -279,18 +279,27 @@ int dehash_address(struct addr_ctx *ctx);
 
 unsigned long norm_to_sys_addr(u8 socket_id, u8 die_id, u8 coh_st_inst_id, unsigned long addr);
 unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
+int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr);
 
 u64 add_base_and_hole(struct addr_ctx *ctx, u64 addr);
 u64 remove_base_and_hole(struct addr_ctx *ctx, u64 addr);
 
 #ifdef CONFIG_AMD_ATL_PRM
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id, unsigned long addr);
+int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
+			      unsigned long addr, struct dram_addr *dram_addr);
 #else
 static inline unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 umc_bank_inst_id,
 						     unsigned long addr)
 {
        return -ENODEV;
 }
+
+static inline int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
+					    unsigned long addr, struct dram_addr *dram_addr)
+{
+	return -ENODEV;
+}
 #endif
 
 /*
diff --git a/drivers/ras/amd/atl/prm.c b/drivers/ras/amd/atl/prm.c
index 0931a20d213b..9bbaf8c85da0 100644
--- a/drivers/ras/amd/atl/prm.c
+++ b/drivers/ras/amd/atl/prm.c
@@ -19,10 +19,11 @@
 #include <linux/prmt.h>
 
 /*
- * PRM parameter buffer - normalized to system physical address, as described
- * in the "PRM Parameter Buffer" section of the AMD ACPI Porting Guide.
+ * PRM parameter buffer - normalized to system physical address and normalized
+ * to DRAM address, as described in the "PRM Parameter Buffer" section of the
+ * AMD ACPI Porting Guide.
  */
-struct norm_to_sys_param_buf {
+struct prm_parameter_buffer {
 	u64 norm_addr;
 	u8 socket;
 	u64 bank_id;
@@ -33,9 +34,13 @@ static const guid_t norm_to_sys_guid = GUID_INIT(0xE7180659, 0xA65D, 0x451D,
 						 0x92, 0xCD, 0x2B, 0x56, 0xF1,
 						 0x2B, 0xEB, 0xA6);
 
+static const guid_t norm_to_dram_guid = GUID_INIT(0x7626C6AE, 0xF973, 0x429C,
+						 0xA9, 0x1C, 0x10, 0x7D, 0x7B,
+						 0xE2, 0x98, 0xB0);
+
 unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long addr)
 {
-	struct norm_to_sys_param_buf p_buf;
+	struct prm_parameter_buffer p_buf;
 	unsigned long ret_addr;
 	int ret;
 
@@ -55,3 +60,26 @@ unsigned long prm_umc_norm_to_sys_addr(u8 socket_id, u64 bank_id, unsigned long
 
 	return ret;
 }
+
+int prm_umc_norm_to_dram_addr(u8 socket_id, u64 bank_id,
+			      unsigned long addr, struct dram_addr *dram_addr)
+{
+	struct prm_parameter_buffer p_buf;
+	int ret;
+
+	p_buf.norm_addr	= addr;
+	p_buf.socket	= socket_id;
+	p_buf.bank_id	= bank_id;
+	p_buf.out_buf	= dram_addr;
+
+	ret = acpi_call_prm_handler(norm_to_dram_guid, &p_buf);
+	if (!ret)
+		return ret;
+
+	if (ret == -ENODEV)
+		pr_debug("PRM module/handler not available.\n");
+	else
+		pr_notice_once("PRM DRAM Address Translation failed.\n");
+
+	return ret;
+}
diff --git a/drivers/ras/amd/atl/umc.c b/drivers/ras/amd/atl/umc.c
index 6e072b7667e9..df6accae8929 100644
--- a/drivers/ras/amd/atl/umc.c
+++ b/drivers/ras/amd/atl/umc.c
@@ -427,3 +427,15 @@ unsigned long convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 
 	return norm_to_sys_addr(socket_id, die_id, coh_st_inst_id, addr);
 }
+
+int convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr)
+{
+	u8 socket_id = topology_physical_package_id(err->cpu);
+	unsigned long addr = get_addr(err->addr);
+	u64 bank_id = err->ipid;
+	int ret;
+
+	ret = prm_umc_norm_to_dram_addr(socket_id, bank_id, addr, dram_addr);
+
+	return ret;
+}
diff --git a/drivers/ras/ras.c b/drivers/ras/ras.c
index a6e4792a1b2e..cae6388d41be 100644
--- a/drivers/ras/ras.c
+++ b/drivers/ras/ras.c
@@ -19,15 +19,20 @@
  */
 static unsigned long (*amd_atl_umc_na_to_spa)(struct atl_err *err);
 
-void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *))
+static int (*amd_atl_umc_na_to_dram_addr)(struct atl_err *err, struct dram_addr *dram_addr);
+
+void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
+			      int (*f2)(struct atl_err *, struct dram_addr *))
 {
-	amd_atl_umc_na_to_spa = f;
+	amd_atl_umc_na_to_spa = f1;
+	amd_atl_umc_na_to_dram_addr = f2;
 }
 EXPORT_SYMBOL_GPL(amd_atl_register_decoder);
 
 void amd_atl_unregister_decoder(void)
 {
 	amd_atl_umc_na_to_spa = NULL;
+	amd_atl_umc_na_to_dram_addr = NULL;
 }
 EXPORT_SYMBOL_GPL(amd_atl_unregister_decoder);
 
@@ -39,6 +44,15 @@ unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err)
 	return amd_atl_umc_na_to_spa(err);
 }
 EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_sys_addr);
+
+int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr)
+{
+	if (!amd_atl_umc_na_to_dram_addr)
+		return -EINVAL;
+
+	return amd_atl_umc_na_to_dram_addr(err, dram_addr);
+}
+EXPORT_SYMBOL_GPL(amd_convert_umc_mca_addr_to_dram_addr);
 #endif /* CONFIG_AMD_ATL */
 
 #define CREATE_TRACE_POINTS
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..feb53f8470b0 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -42,15 +42,32 @@ struct atl_err {
 	u32 cpu;
 };
 
+struct dram_addr {
+	u8 chip_select;
+	u8 bank_group;
+	u8 bank_addr;
+	u32 row_addr;
+	u16 col_addr;
+	u8 rank_mul;
+	u8 sub_ch;
+} __packed;
+
 #if IS_ENABLED(CONFIG_AMD_ATL)
-void amd_atl_register_decoder(unsigned long (*f)(struct atl_err *));
+void amd_atl_register_decoder(unsigned long (*f1)(struct atl_err *),
+			      int (*f2)(struct atl_err *, struct dram_addr *));
 void amd_atl_unregister_decoder(void);
 void amd_retire_dram_row(struct atl_err *err);
 unsigned long amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err);
+int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err, struct dram_addr *dram_addr);
 #else
 static inline void amd_retire_dram_row(struct atl_err *err) { }
 static inline unsigned long
 amd_convert_umc_mca_addr_to_sys_addr(struct atl_err *err) { return -EINVAL; }
+static inline int amd_convert_umc_mca_addr_to_dram_addr(struct atl_err *err,
+							struct dram_addr *dram_addr)
+{
+	return -EINVAL;
+}
 #endif /* CONFIG_AMD_ATL */
 
 #endif /* __RAS_H__ */
-- 
2.43.0



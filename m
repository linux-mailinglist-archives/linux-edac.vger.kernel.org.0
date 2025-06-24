Return-Path: <linux-edac+bounces-4232-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7F7AE6840
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF1837AB8CD
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7B52E1754;
	Tue, 24 Jun 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B89mipnt"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D722E0B67;
	Tue, 24 Jun 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774606; cv=fail; b=U1cG6CnLUBSAcbPJq43bwDzXWZf5pkVLFR2pDmJffynNlu7teGcelTvFn4fg0lXtMgtyAuaxTsvDOvAsv2ufXnAV5lenp1yMWB7oOydiMCV/XGCF6aVAInwF4eaRqqj+eLXixUZXmv3jIjulxCQf7o0gHuwFQicYzXVpGZTbYsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774606; c=relaxed/simple;
	bh=PUxvdU/FGrtMkKmlTayh4Bas0x/axFzp32/5zqxbNvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CwWkpFbBkxduLk4nLVPA0e8ZstiebFIYPATGohLIWKclshufO20Pj9TgDzN93CHYlvV79JnSOo3+0DOSe3KTActRSSSkBJioH8A24mlDZH5He9nuXlLIFh+TwCrV0vfeUdGNORFMqfGES7jtDTZQSx0jPR6iTzs7tX2N+3Ch/18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B89mipnt; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWWhe/3GP0TQFrFnRfe1A0UqHmEkDztWVmzDeuDWJH2LLo+S8N8516ChYkdxgUlypL5RINE2gy/Fg+qcVlAu6El2qBCBFLMfLvG6c76V25UN3uY5tYgeAlVtMPKYU8uYxvdOnUuft7PuCQPobC5kPdugO3vLcmBCNEodVYf9LBdLUGO3L9igiIF69gGWCFWjgdUdHdmCj79dkIcO4BC6qHqYqww+alMP2JR/S8XGX9ii2fN8zhIzd64zGP5yAc7PwUeDzWpdYDJasxHrN54/0HpFis0vxipzqyC9mLcQJmA+Vmf3cngnFLX0Rydtp1+GZQPbKGeAPlLl4IvrWv7W1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHoRZxtQL8M056Q0UaUCoTJKmPrv3TjuLdceI5SgjLk=;
 b=sMZYC6qLfDXniuD1Q/M1w7sOrq7xA0Ia22tevS+ZGSmG8teio0LBPbgbJKBl8e3Shnm6OtRPBgI7fajTKn/OMdQfxw9jumckgBc+yndt+VdqWMkOV6enFlxzeHlSA2vUaLFO9UcQ+Cw126JetQvOIbVzZxhYw8Evz46wPpSZU5RAo+kQ/4ukVwd/SOg/EvEkA8NYPgVqGenDn2Ix/853dQGPdE1vIvE7Y6LEerhFbcUxkRCc9LH0XygIsdVi7pzsZeo+/eggwL7oexyGczctCH9MWVY+gSpkw2053kPWt0lzfJIfEEp74FL0KYz1WLSUXsriIQ4fxK3XytNz8SVuhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHoRZxtQL8M056Q0UaUCoTJKmPrv3TjuLdceI5SgjLk=;
 b=B89mipnt+nRV7/rXqAHsWSo4f56RqPyuyoIS3cmOSpvcK4hEUzl4bgslaCASyhGYItsIwbMNsE05omCukoQrS8m++VSXXlpaECiZFwieeBDUGKQORINV/m0evnPJVl9GIyPkWvFwb3Si5ptiGdi7o43+zgXNGZR0FaxWbj4Ov2g=
Received: from BYAPR05CA0054.namprd05.prod.outlook.com (2603:10b6:a03:74::31)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Tue, 24 Jun
 2025 14:16:41 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::92) by BYAPR05CA0054.outlook.office365.com
 (2603:10b6:a03:74::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:41 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:39 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:16:17 +0000
Subject: [PATCH v4 22/22] x86/mce: Save and use APEI corrected threshold
 limit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-22-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a5964c-e5b3-4ba7-7e43-08ddb329bdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGNiT205R3pUbnpxZi9tL0c5UlIzZ1ZrK1lDbGFaNFlLV0Uyem5kQkxJczNC?=
 =?utf-8?B?dmNkTm8wdE04UWRTRnRzWmZjNFVRK2lTS05OYldzMDJaUlh3V1RINzVYTGRk?=
 =?utf-8?B?ZENVUHZmd1lKc1pUSXM0ajdlc2pmOWhiOVBpZ0t6bkNicmk4ZjVnZ2NaU2wv?=
 =?utf-8?B?bVNIQmlEVUk3ckJMaGRMbU1pQ1NKUEp3NXpKWjBXOWI4dE1CMGZnZ3hESVo0?=
 =?utf-8?B?TEdWUjhxcmJGc3RSYmJRWDU4RG5jem1HMDZSMXJJQ2Z3bXBjbHBGR3UwSy9i?=
 =?utf-8?B?S3FlWDRyZ00vbHYyQmxWQXoxUXVibXFQRzh5OWNwMFB5ZnpQcWhTTXZsM29r?=
 =?utf-8?B?N1R4UTdmU2JTajdad3FOT1dTUENGalhab0Q1Y3N1eVlHbWlmYk50ZWNLSHBw?=
 =?utf-8?B?UVN2SWsyRnpuZVVEb0lQTUFRZjRtNWlRVTBVN0Q5VTMyS0FRQi91OW1WUmwy?=
 =?utf-8?B?amY0cTh3d29VSnViSHpwWDB5SnhTSE93NXZTM3crVG03U2ErYzB3WWRjN2ho?=
 =?utf-8?B?TS9JSnlhU2pKNmx0eTNYYlhxNCtHNngrRzlXdGtvRkw5L0FEZ0d4V2xpN21m?=
 =?utf-8?B?V25QUHA5MmRjVVZ5dXVzLy84ZkdFN3J0d1dnd2ZORGQwakRSM3lOeUxwRkZo?=
 =?utf-8?B?WjRuQXV1dUZoam1oSEhhbTRaMXM1a2pXUmh4VG5wNDAyVG5GNGVONTFKa2Yr?=
 =?utf-8?B?WDF1QnNsa2dpQ1F5dXZMclYxRW9oekpGMzRiekxCR3FaVkRXNzhmSitFS0lV?=
 =?utf-8?B?SENsYi94UFphcjJBd1lDQ0tEMmR4a1NFWHNabVlGcmtLNUtib3pIQkxVcHpq?=
 =?utf-8?B?UjVmUXFJaGtjUEZmUEIwY082RSt2M0NxcjFIV3puOG9HU2VqWDM4THdJR2hu?=
 =?utf-8?B?cFZxTmpha2t3RGgzVE9OQ0tJTU9TNTB3YzZsZW5RbzN5dDVvUURrNCs5WHRz?=
 =?utf-8?B?M1FHK2h3bmpWQzF3MG45c0QwQWtEOTMzdlplaGduTDB1Yis4Yk5hT0VjbSt1?=
 =?utf-8?B?dk9uZ20vQzNYYmtCV2luUXhrVGFtc2ZNZ2dsdENPcG14Q1pEU3ZkWXZnTVBE?=
 =?utf-8?B?aGcvTERTY2NvbXBXU25weGY5T29BN2xoMzhZb0JaY1dOSGdRdEtQSmdXMnRU?=
 =?utf-8?B?c3RyRnoyZ2g0YzF5MWhKaEhnUVVzRFJaYnNWZytKU3o4d2tsQlovZ3V5eERN?=
 =?utf-8?B?TFEyemkvZTQyR1JDV0cyaFBVRHV5WEZ6NmRRNUN3ODJaaXZXUTlSSlZGUFNN?=
 =?utf-8?B?MnZuc0hsV2xKYkk2Tmd0UjNkVXUyemxZeVBmek5CdTNIVEw5OCtac2dCZ2Zm?=
 =?utf-8?B?ZkJqUzUvVjRhdzM0RmdjMWovNWQxNDZicTBYSnNwa2xJZm9nZnordGdZaVIz?=
 =?utf-8?B?NWVzanhXdVFmbXhGYzJtTU9zeWhuVnJrWWtJL2lHY2dnOEJBQmRIYVk0OTdy?=
 =?utf-8?B?NmRaMjA5N2NUMVFTR3pYQjVwWEdoMVVOdUhVekE5T0w2dkRvNy90NzZ5YURJ?=
 =?utf-8?B?ZVp3UnhON044VmxRQ2d2ZWxjaXZ3TWJmM0IvNTRWanRVcXFiRDgzRzdEU0s1?=
 =?utf-8?B?K1FzT1dkK0UxMmRuUVczUkY1U2x4SjJzZ1h3eExlUjQ4Z2grZ2xqUkh2cmtj?=
 =?utf-8?B?ZHZQVzZ0TjRsLzRraEljd1FqenU5bkFMREZKeUpZQTBPR1Z3dHlNZTFKRlNn?=
 =?utf-8?B?MXpkSDc2ak80WjBQbnR4THpVTy9haWVOck1CSTVUY0d0MGhyL1NCcVRpaVhp?=
 =?utf-8?B?MEpreHBIYStxVU10MVExcXNVRUZ4MVhac2J0TlovZDV0em1Ra1dSRk5IeXJ5?=
 =?utf-8?B?Ry9qOTdHRnc5N2QrTy9PYWpudDV6d29lVVVVWndlMEVrVmZsWGFac2VoenZT?=
 =?utf-8?B?OXB2N0FTNDRyWkF3R1Z5eXNINTd3RGQ4K3EzNWhZSEY4UlBEeHpKTHRUU3pu?=
 =?utf-8?B?WmhwbDllYTA4Z2ZMVnU2QUpTaEM3dnZ2Mmk5anY4blJ4RVRWUTJLNFRUQWtN?=
 =?utf-8?B?eWNZQUZPRDlZWE1mZ245K0dMMXVZWFZ1d3pjM3pWVTZScVRvdWR5WEpIRHJl?=
 =?utf-8?Q?+YygeN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:41.3005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a5964c-e5b3-4ba7-7e43-08ddb329bdb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070

The MCA threshold limit generally is not something that needs to change
during runtime. It is common for a system administrator to decide on a
policy for their managed systems.

If MCA thresholding is OS-managed, then the threshold limit must be set
at every boot. However, many systems allow the user to set a value in
their BIOS. And this is reported through an APEI HEST entry even if
thresholding is not in FW-First mode.

Use this value, if available, to set the OS-managed threshold limit.
Users can still override it through sysfs if desired for testing or
debug.

APEI is parsed after MCE is initialized. So reset the thresholding
blocks later to pick up the threshold limit.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    v3->v4:
    * New in v4.

 arch/x86/include/asm/mce.h          |  6 ++++++
 arch/x86/kernel/acpi/apei.c         |  2 ++
 arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
 arch/x86/kernel/cpu/mce/internal.h  |  2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 7d6588195d56..1cfbfff0be3f 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
 /* Disable CMCI/polling for MCA bank claimed by firmware */
 extern void mce_disable_bank(int bank);
 
+#ifdef CONFIG_X86_MCE_THRESHOLD
+void mce_save_apei_thr_limit(u32 thr_limit);
+#else
+static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
+#endif /* CONFIG_X86_MCE_THRESHOLD */
+
 /*
  * Exception handler
  */
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index 0916f00a992e..e21419e686eb 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hdr, void *data)
 	if (!cmc->enabled)
 		return 0;
 
+	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
+
 	/*
 	 * We expect HEST to provide a list of MC banks that report errors
 	 * in firmware first mode. Otherwise, return non-zero value to
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 85fd9273e90a..9e26b0437dc6 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -488,6 +488,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
 	}
 }
 
+/* Try to use the threshold limit reported through APEI. */
+static u16 get_thr_limit(void)
+{
+	u32 thr_limit = mce_get_apei_thr_limit();
+
+	/* Fallback to old default if APEI limit is not available. */
+	if (!thr_limit)
+		return THRESHOLD_MAX;
+
+	return min(thr_limit, THRESHOLD_MAX);
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -496,7 +508,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 		.lvt_off		= offset,
 	};
 
-	b->threshold_limit		= THRESHOLD_MAX;
+	b->threshold_limit		= get_thr_limit();
 	threshold_restart_block(&tr);
 };
 
@@ -1079,7 +1091,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->address		= address;
 	b->interrupt_enable	= 0;
 	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
-	b->threshold_limit	= THRESHOLD_MAX;
+	b->threshold_limit	= get_thr_limit();
 
 	if (b->interrupt_capable) {
 		default_attrs[2] = &interrupt_enable.attr;
@@ -1090,6 +1102,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	list_add(&b->miscj, &tb->miscj);
 
+	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
+
 	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 09ebcf82df93..df98930a32a5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -67,6 +67,7 @@ void mce_track_storm(struct mce *mce);
 void mce_inherit_storm(unsigned int bank);
 bool mce_get_storm_mode(void);
 void mce_set_storm_mode(bool storm);
+u32  mce_get_apei_thr_limit(void);
 #else
 static inline void cmci_storm_begin(unsigned int bank) {}
 static inline void cmci_storm_end(unsigned int bank) {}
@@ -74,6 +75,7 @@ static inline void mce_track_storm(struct mce *mce) {}
 static inline void mce_inherit_storm(unsigned int bank) {}
 static inline bool mce_get_storm_mode(void) { return false; }
 static inline void mce_set_storm_mode(bool storm) {}
+static inline u32  mce_get_apei_thr_limit(void) { return 0; }
 #endif
 
 /*
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/threshold.c
index 45144598ec74..d00d5bf9959d 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -13,6 +13,19 @@
 
 #include "internal.h"
 
+static u32 mce_apei_thr_limit;
+
+void mce_save_apei_thr_limit(u32 thr_limit)
+{
+	mce_apei_thr_limit = thr_limit;
+	pr_info("HEST: Corrected error threshold limit = %u\n", thr_limit);
+}
+
+u32 mce_get_apei_thr_limit(void)
+{
+	return mce_apei_thr_limit;
+}
+
 static void default_threshold_interrupt(void)
 {
 	pr_err("Unexpected threshold interrupt at vector %x\n",

-- 
2.49.0



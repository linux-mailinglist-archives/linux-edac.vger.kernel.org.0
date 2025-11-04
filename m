Return-Path: <linux-edac+bounces-5333-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CF4C31A94
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115AB1885D91
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374F1332ECA;
	Tue,  4 Nov 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ABi67jMW"
X-Original-To: linux-edac@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A93321D2;
	Tue,  4 Nov 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268169; cv=fail; b=nYRhDle8aRDF2XTezpCAJwjQcSA43jDBxrRGkx4PhATulf50gUzSHSBeFhxJHU03DDMC6V11t7YtSOFXwgo4digb9HWdH9XpdDXi1yO1OyTTebMMhw+phIn5t43tF792ZAPi2zPWnCK88xu1kZ6+bQBFaGizCeRtWfG4E6/1AfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268169; c=relaxed/simple;
	bh=Fa2sov21IiuO257jrVAGTFrhKIZsBFv0RXrVzKbDDwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NdofGZKvh5dehqgQqamYSUizZmFWHbhPBjU3KUHc7BbImSVzb+ooarYE5SchOQhf+HuVAkDAyxYMrA3m8S2wecBq+AQZtGeunoV2Lh/6vvwLiIH4sfv9BgeNzTV2OE6xpOZ/SQvUdgGo1Ivk5EsddiPgDLhM2p/KNJHTEUI7kJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ABi67jMW; arc=fail smtp.client-ip=52.101.56.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EJzBdg8TmnVSAwPitAeSog/aKlyWIP/uobde8at74hctUsec305zQ3/9HTutO6fWVrd9LfKbSbM4KwcTcts1ZW1KXYEZ+XPynOVzLqIuZq6VAH/QU0coo3lXm3SZ7vN7UPPLRIICMF0ZIbjFAN2Y+ivwo00xbFp2oHruKqDdRrWwWBeq9SwpG/NnAQ3ld7oQ3F1LteYNO3PTbjCKwCcacg81U+a4k5nknZxNZs00VARye0WWQNgAlY/SL6BInxhKpoBWW9Ql7JXQXN8tRXxZNseVv5ygJeOWjLWpBzpVqOGNWx5mFoacSm9mukl1J8DMEYykU/y+IgF1LBbq8JhDpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUjOw3pc7h+hw75dOg/Bg/0mysNfbA8ZeZu4ow1sRkA=;
 b=mc+Gzd0eSDWJ44l27meTfAKJ+ThoVUwDrY0ne5S5Imhpb01vht45XtTlSqzq+zUMrnkwzUsWZXwkR98h0pJwL+ZKl1seV2X94K7K1SnoOWrhsorxSfMJM0Z73RKg1x1hqRnD3lfAGJn0i61oS0+xVVDzx9W8fUDRYQbYCxO/Nm7MI+8/n7/KnE+HIAAV+YwRyh8EkeE8LC+vXuoCGYJkIIK+5KJq4q07qJ2CAnExN64hG0IZB9Em4aXLIKGFid+uflWnExr/qn6kmvju+C0COAVLD0lN9gY/UGlTYakML+Iap30XYN8JJxHe3lZGrkb4HSvgIo0oLHb/aOtwGushNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUjOw3pc7h+hw75dOg/Bg/0mysNfbA8ZeZu4ow1sRkA=;
 b=ABi67jMWtgxU4poaLEQJd85AzdUs/Xc4LuDhkD7AX24Ap3mCylN7Qb2HqZAKte5yvA0rfgMNU1Je2AIUAFwsBMhzemyHWgm86+KBiT3cKsRpIlmi4HY0RqMCyiFhvOpttl3C1OgQ83RQV4waa8y3xTJxOazCQ3JNZ0IS1dH7LEQ=
Received: from DM6PR06CA0088.namprd06.prod.outlook.com (2603:10b6:5:336::21)
 by SJ2PR12MB8738.namprd12.prod.outlook.com (2603:10b6:a03:548::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:56:03 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::b1) by DM6PR06CA0088.outlook.office365.com
 (2603:10b6:5:336::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:56:01 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:55 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:45 +0000
Subject: [PATCH v8 8/8] x86/mce: Save and use APEI corrected threshold
 limit
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-8-66c8eacf67b9@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ2PR12MB8738:EE_
X-MS-Office365-Filtering-Correlation-Id: 7af1eef4-99e5-4976-ea31-08de1bb24585
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2JsbkZDaWJzaXlSeVUrSWFtMlI5NEFrRTZzd0xDbkZHcERGT0g3a2NRZVgw?=
 =?utf-8?B?NUxXL2dxZDRkSHFuNkFsTWQrQ1Z6UGhxSEVkelhZTUdTcnRRQ0lXQU5ydndC?=
 =?utf-8?B?aVhUcjN4YlQyZHhpVFVNRkh1UFJIUXNXT1NSNmI3cHFkVjFBRGo3bW1JZ2Fa?=
 =?utf-8?B?aW05WEovZVpmbit4U0tsYStzVys2bnZQb2Z1T2d6dlI5dE04U1hYTktOeTF0?=
 =?utf-8?B?NVFqOXh6amljSXYrQ29jZWhGTFg3c005SXFKaDhSL05OYk92QURxeFhiZDE3?=
 =?utf-8?B?ci9XTWszNTBmMklseWl4MUc4TUkvaHM5NHlGeHJ0QTNGNjBDMW1GOVRlVDRx?=
 =?utf-8?B?VEN0MmJmUmQ1cnBWamJkNUVFdVg5SFYxT25uZ0dsdHRDNkt5L0ppTWgwUHlE?=
 =?utf-8?B?ZERRVGNlSmVSbllQdG5GbFY0N3NBRmFSazc5Nm1EK214NmN3dVhPTStOb2tQ?=
 =?utf-8?B?OUV5cFlJSFUwaE80Z0gralBZYjRlRnpZTEw4KzI3amtxSXZvNlVFYWFKUkJ6?=
 =?utf-8?B?cDVrTkw1TFdoMlJ6RVVEdGpSTUx3bUFBSUdocmE4TS9uL3BobG82VGw4NkR5?=
 =?utf-8?B?QWpLZGx2WS9td1g2NUdTVGV3WlVjTVhqaGgzRTlMVC8vWDkxRkM3N2RqcjBz?=
 =?utf-8?B?NUMvVENETjVERUhqanpDMnNVOWZmeE4vYkw4TFBNekZZSWd4K2luN01TeVBp?=
 =?utf-8?B?RjB4cUtBRnFkNjlKYzRNSWRkNGN5a1ByQ0xBODljb09HRjM1MWtoU28xTC8v?=
 =?utf-8?B?WldUSFRtY3dhVGhXc1ZkSHFXOXNveERSdVY1a2tzYjVEdDFCU2dRSDV6RWIz?=
 =?utf-8?B?cTJWcytCaVhGMFRQZUw4YXFBQkhRSVZzaGR4YmIyejlRTkxKU2ZWSWhTYytZ?=
 =?utf-8?B?ZWZRT0ZPajQ1bVZlcnlYRHFEaGJvaUkwRXo2VlV3VytiNVF0WjVsQjRzOXJ0?=
 =?utf-8?B?dzhSYjlldGpVZkw2VUN6V1dKb3ZKRHFzbVpNcmUveGtrdE5jY2lGblZtOTJn?=
 =?utf-8?B?NWtHMjNrcTRiTFJXaUtiVXgzOTI4WVQ4dnUwcUd0N2R1alRWU2hGMnJuaFJm?=
 =?utf-8?B?K2NkSTJSQnBmWTMxSXFEYzZ1Q2xQazNoSmhTQ3pHdkZwb09FaEVUY0JnQmMy?=
 =?utf-8?B?MGZzSWxZK29DNkNCQVVucC9GTm1SUk0zY1lac2d6NTE4d091NGlwZUJscnRW?=
 =?utf-8?B?UHk0WXRoNVgralp3SEhSZEN3MWxheWRJRFVqY0FOKzJyMitpM2R6VVRYejYr?=
 =?utf-8?B?Y2pqdUxJN05XRkZ2dUhjWnpVVk9mMzdTK2t5V3JkSkdwUCtCMUFSS2lzMkI2?=
 =?utf-8?B?MXdta2ZDZDYwVm9qcVhhckIvdWdsNnlqRms0WTRwOTNNcEU1ZC9HOXd2NXlx?=
 =?utf-8?B?WGFyN0NXU2EySWFvOG84Tm4zdjdQRHN3STJvWVFaR3lHTmJWbzJ2cnc5SDFQ?=
 =?utf-8?B?eDJXTjBGcHdVNXpYRTM0dnJ0RHkyWkVSS0tJSUtkdjduVGEvQlR6bHlRZ01X?=
 =?utf-8?B?eXJ3QVFsQTF0Y082QlpNYkxyV2oxZ1MyblladEpHV0E3M00vdTFmY3N5bFc2?=
 =?utf-8?B?LzJndCs5MXpqRmtZVkNnNkFyTS85cS9xYjdydWRITGpGUTRHY2tSd1dmeTR0?=
 =?utf-8?B?YmtVL1ZTSTJnVGtQV0hRZGhSS212Znp5QWRWUUxvWnRZSmprQitFMGVQK3Bm?=
 =?utf-8?B?aHFsVWRQS1JjS2JHY2sra2JvUkxwdEVOaWlkd3dwbVF4RnUwT2hTUThHdllF?=
 =?utf-8?B?bDBWT29CZFMzd3ZMcE9TdXJIc0lEQUE5TjQvVGczc0kvZmUvZFZLWWVqeWEz?=
 =?utf-8?B?WWpBdk80M29DdktIakE3R3FkeW05Szd5bm5DQldpWmRYaWhMNXJjVmFhbmQx?=
 =?utf-8?B?NW11emlUWC81ajVId1c3cFBhNTdORG1BdWZlZlowNnlHYkQ4cy9OQm9NUG5D?=
 =?utf-8?B?UmFwTEM2REhRL3hzTnp4Zi9kbHNJeE1ka3RKczN2MnV0U29VWkRwN3pwVDBX?=
 =?utf-8?B?QkMraGRLSlE5SmNWZDhuZE41Y09adWIvVEgwM2FWcVQ2VVpvYkpoQjViSjJG?=
 =?utf-8?B?eGh6SHV4VEFkMDl0cUUvMnpQbG1pUG1ZdHBDaHBzdUJzT1NiUHhaSkRWS0Rv?=
 =?utf-8?Q?igdU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:56:01.6930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af1eef4-99e5-4976-ea31-08de1bb24585
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8738

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
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-8-5c139a4062cb@amd.com
    
    v7->v8:
    * Change pr_info() string. (Boris)
    
    v6->v7:
    * No change.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
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
index ec5417586b8b..53385e6aa230 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bool intr_en)
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
@@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_block *b, int offset)
 		.lvt_off		= offset,
 	};
 
-	b->threshold_limit		= THRESHOLD_MAX;
+	b->threshold_limit		= get_thr_limit();
 	threshold_restart_block(&tr);
 };
 
@@ -1076,7 +1088,7 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 	b->address		= address;
 	b->interrupt_enable	= 0;
 	b->interrupt_capable	= lvt_interrupt_supported(bank, high);
-	b->threshold_limit	= THRESHOLD_MAX;
+	b->threshold_limit	= get_thr_limit();
 
 	if (b->interrupt_capable) {
 		default_attrs[2] = &interrupt_enable.attr;
@@ -1087,6 +1099,8 @@ static int allocate_threshold_blocks(unsigned int cpu, struct threshold_bank *tb
 
 	list_add(&b->miscj, &tb->miscj);
 
+	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
+
 	err = kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name(cpu, bank, b));
 	if (err)
 		goto out_free;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 9920ee5fb34c..a31cf984619c 100644
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
index 22930a8fcf9e..0d13c9ffcba0 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -13,6 +13,19 @@
 
 #include "internal.h"
 
+static u32 mce_apei_thr_limit;
+
+void mce_save_apei_thr_limit(u32 thr_limit)
+{
+	mce_apei_thr_limit = thr_limit;
+	pr_info("HEST corrected error threshold limit: %u\n", thr_limit);
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
2.51.2



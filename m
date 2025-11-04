Return-Path: <linux-edac+bounces-5332-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B96C31AD1
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A337D3B5D0B
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613CF3321C6;
	Tue,  4 Nov 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="feQnPfjP"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011025.outbound.protection.outlook.com [40.93.194.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A01E3314C4;
	Tue,  4 Nov 2025 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268166; cv=fail; b=kcA3NYa5c1eXouwQfBWCBqL3LThu+W4neXPgXEmKYxFKHWiN66pLN1Q3uZF8QyUBx9BKMFDMYjYDCVj+420SQD3xb7dpwxifBWagWqeErH2BfGwtGouJ/oFPF0cyf8ca7gYDczeogKyNvg6K0J8WAf3QfLU1AA1nTJkBdhCMJlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268166; c=relaxed/simple;
	bh=Xw4VNqTifHdCF0yWzwXjUtwdLt0AILxM0atG9EPi1t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BBSNheWMxetat4s9LvRTj1Yo7ek6d8YdVHJ6rByFTfL2Ia8UtoFx9WFPZd2bGclMY7q/AXAIwLjVaCA4+FPgIrgVL3enirtY2W9KxlmqwtgwuhH+f2u5gD3Cne1t+7eVxWIndTdx+sOW+7g7YsgxJC0Op+M2g9kSmLerC7TZfcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=feQnPfjP; arc=fail smtp.client-ip=40.93.194.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6xkdr6H6BhWXzDMLIh7BojxOF6zTK3R5WTi7tXCf4Twtsa6nGrsbPmb7EOlhc2a8PjEhkL4yqLsryKtJbajf56l5YehfQWSWgnY2ExHhTpg1x4XmH0je6UzzW3ZqcjdVdhyL6T9BNlCsX6W7xF6ZijL8AOApaqBs95MVLg8j7rhuAP/IPufRpJWO96M0FGz6EYB78okaSkWY+9LCeclBz4Axf7t428Dpl7iTDzgxb2RQ2SEtAUgYX9i5AG2IGGQE2S4nDoZZsbgD4ct1r22d8nWc+XbPNSF5wufe1I3v22gEspMoHMg5v7MO6VPCrtUBdKqljAL/sdq3tIVZsp4Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ncxfpE72B+L8aJxSlHjDOPr5ZPB8T1rIcnio/u2mOI=;
 b=L8cFqvmFALUlQPefOIVg6CO60I9vfODEyjEr4bUwS3u18VLoPHil57ugnfZrPzVWEmia0uD6iALsBSnuI3WjLZ9V8wpfQDzuZjeo21TqGwz+AjJWJMwHy4m9Mf4f1z64oNH92m89WYWSV/IhUoTyWQY1zIkh1ufMvuesjIw+W46A1DnMY7ogcI9DOlC7LOKrfCKVLDp/g8BAP3ZHRvtG1CpZULe1ZPSVCfUUzeN3y9iGG9YHeFkVRJZzYtCdb5NUFlI8DIxhD+7d/wPIlZB7JBJPGx8YcxScH6/wd+ecgUuYMehQ39hS0JX1Wt7of9MZxkk5xRGnj3V7PiQrB4pelA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ncxfpE72B+L8aJxSlHjDOPr5ZPB8T1rIcnio/u2mOI=;
 b=feQnPfjPkC9KKbeWQYnkXBuC2BI7pcW1foE2ouUvhaoheUpQoFnUpYuM9Q/RfCpZp+fRH+dbf1/UAxPz1TchVwL+jdwfebEZ9cpXR65jU00bKg865McIpucwATg02AlYMlO3WgxzazQyhgRbwgxRuOehxUwal/oI1g/hw3euEx8=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by SJ2PR12MB8110.namprd12.prod.outlook.com (2603:10b6:a03:4fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:56:00 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::db) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:54 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 4 Nov 2025 14:55:43 +0000
Subject: [PATCH v8 6/8] x86/mce/amd: Define threshold restart function for
 banks
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251104-wip-mca-updates-v8-6-66c8eacf67b9@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ2PR12MB8110:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d31c22-b0a2-4380-ebf0-08de1bb2445b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zzc2c3gwSTRTeGg3bHNYOVlYZUZ4enN1TVF6WFRRZDJnTmRnaWpMaHFVUHQ4?=
 =?utf-8?B?RDg0MkNoSmZteGN4Sk0vWVAzak9xdXIyQ0traFpJSVpDbmRhUWtKMjA4SDcx?=
 =?utf-8?B?eWl6K1VNVHhVaktITk5jakN4RXZtbE4wN1ExT3dCVmROdzVsSzlJVDdHSzd3?=
 =?utf-8?B?Zk1QN01HWkFmWnpkbnhFcjk5YzRiaW9YbmdPYWtjblQ2dFRjU3pxVFc2YXFv?=
 =?utf-8?B?Yk5jbEhRMzBVSkZscTRCSDFnZXNMbDRteGpGbzhuVzM3UllZQm5sQmlYMFha?=
 =?utf-8?B?ZVA2bU1tRzhpMjBTN2xzTy9DRFdCOGZhK1lSRm8wUHFLRTVUODhwd1RHYzkx?=
 =?utf-8?B?SnhCTDF0UlhoOUgzd1E2TVRkdkV5TmMzOGp5cGgwbE9hYzRWYURwZjFoQnhU?=
 =?utf-8?B?aGNWdTVsMkhFemtRTmJLa0tSa0VHVWlMOUdxbzBDOEVacUs4WnBzK3cwOXdo?=
 =?utf-8?B?WXJQaC93bCt1YWdWN0hTYjgyVHg0di81NnhRVG9qUldEbURlNUZ2Nm9IaUpp?=
 =?utf-8?B?a01qUGRmQlVZditpUnE1YUh5Q1RLTEs2WkhoYnREcVFQN1FoVHdDN3hTdVhz?=
 =?utf-8?B?eHpzVEhpaG5NWnRqQURKUHFBRk5kUEtzWmVlOEhBaWNIbkNoTFE1SWpJd1N3?=
 =?utf-8?B?QlNjcUdIMUduNWVqYitGcXBQQjUrZ2VhRUR0M1E2ODlqU1U0WVR2bm93ajNv?=
 =?utf-8?B?MVVGcmlBMWRnZDdlSnBZU0R1TjI3UFg5UXN5SEhOMmVUWWhWLzJSYUNmNklN?=
 =?utf-8?B?UlFtQklhanhPbnBDb0puazRabDBXc3ZreTFTT3Z4bW5mZ0NFSXJFc2tEL0Nr?=
 =?utf-8?B?Qk5RK0RrMlF4Vlp0MVJsTVZ1aVVrdTJGR210N2I0eVZ1Umk4Z1NNNEdqZXoz?=
 =?utf-8?B?dWRJbDhPM3JWM05FTGpnK2tQK3hFTWY3QUMzbGFtVWIvalZ3UWxNTDI1VE1R?=
 =?utf-8?B?YTVCbFNmWnRxZ2ZZZzN3aHNYa01sRm1UdENHTE9ic3NRWVBpMEdBczNva21F?=
 =?utf-8?B?RkQ1ZGNnUFBTcGVibkpFaWEvMDhjdDh3WmNsRExTaWJtSVBFTGU2MHp2ait1?=
 =?utf-8?B?QzRmVy92NGN1TkpEQkQxRWFMVGFQZkk4RENDMFB2ckRVVnVCR3E0My96Mjlv?=
 =?utf-8?B?Vm1RSDRGL1VrSll5NFg3cUtBczJGMEh2aFFzL05WeVBTb1lYVXhRVzZTejVa?=
 =?utf-8?B?SVVpWUVTOTZtejdIZGZxUzNnV2daVEkzUjJYZkpKdkV1dHFPVFZndWdmQjRj?=
 =?utf-8?B?UXpycnN5R0xRSVRqL29MeDdMbld6akNoZlFvSkxHUmd4YndQajJ5a3lxdDBL?=
 =?utf-8?B?U3IwMVFyZnBuQkM3Q0ZSaWxIZm9qREdHSnNUbFdGajV4SWs0c3pSRmVjZ2NG?=
 =?utf-8?B?dnROT3lSZlRJUTNXTHA0eGJsT2VWcTRQWUV1d2NsQTRwWm9Xd3NVdnBOdm1V?=
 =?utf-8?B?Q213VjRudDdCNXltcHZOdnFYdVh1c1BQUEU4OWxUSXEvciswcXBDV09pVDJS?=
 =?utf-8?B?VDZ4ZFFvZkdUWi9ZNXRhRGFvYmlJdG0wMi9sY0xPaTYrTkdJS3EySFhQUlE5?=
 =?utf-8?B?RHhuaW1rSGFhNk8xZ3F5RCtYOUlONXpKaFp4MlpwZitDOU9pb3V3S0ViclR5?=
 =?utf-8?B?WGsrUWF6WXFrQzlnVmZjVXJ1TVFWc3AxVnRBQUt0YU85REFEWHFRbnZsaFAz?=
 =?utf-8?B?NGtrdEo0MHpJeVRvWngvU1d6bk0xOEZVdm5QU1ZucUV2QVpicTJpLzlXMzZB?=
 =?utf-8?B?SGFib1RzZ0xPQWpiZS84T0JPNUhnbHNTYzZlYkFBL0JERS84aVI0RWE2Tk9T?=
 =?utf-8?B?bEU2Y1FLSU90Q3B4ejBRL0NiNGhJMjVHSVhtd215ZlM1TDVWN2FFV1hOY2RH?=
 =?utf-8?B?ZDlDUXpYeUp2UjdLcHQ2Qjl4QksyVnY5S00rR28xSW5lOCtLK0RtSFpDMnFz?=
 =?utf-8?B?L1NhMzhMRUVFakxCb3Q0OVArT1FOYVpMakU2UVVkUys1WVVPUlNsazE3TVkx?=
 =?utf-8?B?T05qdmtYcmZocHJPU1NSUFFlM0I4WlNaR2I0Z0pFUTNPRE5pQnhtMFArckpZ?=
 =?utf-8?B?eWhPNktZTXJQZVFkRlptSUM0ZGpTWHg3SmQ1bmJBTzRId2lVMEtnTEJVSURw?=
 =?utf-8?Q?+VSo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:59.7402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d31c22-b0a2-4380-ebf0-08de1bb2445b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8110

Prepare for CMCI storm support by moving the common bank/block
iterator code to a helper function.

Include a parameter to switch the interrupt enable. This will be used by
the CMCI storm handling function.

Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20251016-wip-mca-updates-v7-6-5c139a4062cb@amd.com
    
    v7->v8:
    * No change.
    
    v6->v7:
    * Add tag from Nikolay.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index af2221bcba96..940d1a033569 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -471,6 +471,24 @@ static void threshold_restart_block(void *_tr)
 	wrmsr(tr->b->address, lo, hi);
 }
 
+static void threshold_restart_bank(unsigned int bank, bool intr_en)
+{
+	struct threshold_bank **thr_banks = this_cpu_read(threshold_banks);
+	struct threshold_block *block, *tmp;
+	struct thresh_restart tr;
+
+	if (!thr_banks || !thr_banks[bank])
+		return;
+
+	memset(&tr, 0, sizeof(tr));
+
+	list_for_each_entry_safe(block, tmp, &thr_banks[bank]->miscj, miscj) {
+		tr.b = block;
+		tr.b->interrupt_enable = intr_en;
+		threshold_restart_block(&tr);
+	}
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr = {
@@ -814,24 +832,7 @@ static void amd_deferred_error_interrupt(void)
 
 static void amd_reset_thr_limit(unsigned int bank)
 {
-	struct threshold_bank **bp = this_cpu_read(threshold_banks);
-	struct threshold_block *block, *tmp;
-	struct thresh_restart tr;
-
-	/*
-	 * Validate that the threshold bank has been initialized already. The
-	 * handler is installed at boot time, but on a hotplug event the
-	 * interrupt might fire before the data has been initialized.
-	 */
-	if (!bp || !bp[bank])
-		return;
-
-	memset(&tr, 0, sizeof(tr));
-
-	list_for_each_entry_safe(block, tmp, &bp[bank]->miscj, miscj) {
-		tr.b = block;
-		threshold_restart_block(&tr);
-	}
+	threshold_restart_bank(bank, true);
 }
 
 /*

-- 
2.51.2



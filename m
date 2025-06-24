Return-Path: <linux-edac+bounces-4218-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 240ACAE6860
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC1D188E63F
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE2D2D8DB3;
	Tue, 24 Jun 2025 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p3W+r9zm"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208EE2D8787;
	Tue, 24 Jun 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774596; cv=fail; b=P511Pvwz2s/ROx7BFvFr5UCPeBNgLVCKJ0DktZsA4q48l7ARmTxTmWdk8RN34w36eCYNjQDvhNQNl087zVT1g793uQsywaztlSb1WtgBwFoO2fUCqBhC2FYUa7RXjmCPgOy+KZFr8B8rCDLOe2uDEJ7U+YO71ezVJ/k95RY5OAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774596; c=relaxed/simple;
	bh=NgvHgEEOHL7Ms24hWu+Nq8hgrfxwlcM9+jjHF/zn8SQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lCrAIjJLiz/W5ry4VayWdcaKyzQnc7/YCkoxLk4xpdoAtUvraM43vXZHFz2l2X/piuwgbr5bsvOgHqPupPXz6gwdYmfIdytB7i7anT2j5V9MDWgL+D/6ZrkxM0a2+p7r36oImoqKB72ZwTRq7zGA6zQancfDfmm65HTCFsrOdSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p3W+r9zm; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xSw6404mWvG0bMuR7h8b7qh0TyyeJZbdT4Yjdv0lqUAeSMS8JrdNe1asefkfTu/HQ1mHzwLitu06dprTW09PWggmQw3RXfATG6Djp3gE24s+MJRjOjbt1kop/LMYDyb/Sy59EqL3ZAgiuv7JqWGl/qE1W1UCM4WuAfR+wrTuttz+cHsD0AqUyLk+8IeGqQTKfNiyab78IZIjvE9zRmXNMdRS1Nv8idrecXDnkd8lO1KtyIklH0woZCEL5XV5BxzZbjkavOzo4NgQJNqT1cASBbnOZ0A5QdbzSG//VvlhXyA3hPzYI3QYEkHLa+APh4HCsmX7/wzDeFubVaQZxIngxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfanEZymOX1nYK8d4M4pL27vO0XShk1kDIJ2f9BcQWg=;
 b=bPJQVm8eP6P5t+DnFmnYNhFmMJDQcVUsyjhTBMPH/ogXIEDl/GtJUCYIUoJtor9IGr6FAkNFmFZrWlGRKwC3VVl5tQ3FIquKSUILqwfYJCsocEhigpHJG8Mb9qeEq+tNvSqqSqE9FHcTqA97feVww9Pbbmmg3n9JnSi2oTHtb5vg1pqZ/XpHLwiC7ke28zG8WhK03EvZbiRLWP2PeVS7bnEVp011WlO/42XPkv2SJfDYy2aw3NbNaUHWWVzw7NjtKcPBVySNoSjeI/16bTwqpqQ1UDurM1RCbK6bsvVlwfNOERmxDM5hnwOAnaxu3xcXAlv+/R6265V9JptRX1WuMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfanEZymOX1nYK8d4M4pL27vO0XShk1kDIJ2f9BcQWg=;
 b=p3W+r9zmfSqfIWgmu3gXYRuqpbGFEdlpFXZKYenDzXWiGWM52jmXdi776YsDJmQFDWRaYl5ZY9SsHKyPIU5pkbmKdWUAUO8sIMYVOwauiQGXPoMTh4+RS2Qj4GhGngcfei/mFV8l060OBKrm1xWtIKGInDaWVrbWRnai33t/39M=
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by IA0PR12MB8862.namprd12.prod.outlook.com (2603:10b6:208:48e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:16:32 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::ea) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:31 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:26 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 24 Jun 2025 14:15:59 +0000
Subject: [PATCH v4 04/22] x86/mce/amd: Fix threshold limit reset
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250624-wip-mca-updates-v4-4-236dd74f645f@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|IA0PR12MB8862:EE_
X-MS-Office365-Filtering-Correlation-Id: efbc86fd-51dd-4b44-69c7-08ddb329b7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vm81Q1pta0w4eXhnb0s2KzhOTkFHWDRoc3dFc2lrUm1meUxYbHJRaGVxWmtP?=
 =?utf-8?B?Uko4emxOM1BIQ2xQcG5nV0FTWkQ0N3IzZnU2SjdjN1U0RVJ1Q1lyZ3pmRGo2?=
 =?utf-8?B?TmpBakFPWlNKQUJBZG8vM2JlRVhTZUYrYmpwTlZHajh6akk3dFdNWXdvZSsr?=
 =?utf-8?B?OStzNlk2U09UemFac3U3VmZlMC9jeHJzUWk5bURzaEt5S1Jod2UwOW9YTU1s?=
 =?utf-8?B?N2VrTVpVMlFLQjBIU0gwaE80eEZTdDRadTg3enlnK1pJZW5MbHRlZUhMajVx?=
 =?utf-8?B?cmE0UC9lK2Qxb2ZoSVlwNFpZalV3cXJiWkJrbWxXaVBEak5xV1hVWHJqMkRw?=
 =?utf-8?B?dnR2c2FKem13RVlrYWVOTmFQUnZtVDdXcmdMbUZzZDlNdHpRUUhOclBadFRj?=
 =?utf-8?B?VDc5bGlIdXFSRFVOVTlnbEJYbTgxeXhDa0pFbHZ1RmNGdXVXUFYxU2xKRHZU?=
 =?utf-8?B?dGRKLy9uaEdPdjBDaHBEaHhndnh1YTM4Q0ZNYkwzYTEweWVpd25FWTVldWdz?=
 =?utf-8?B?OGl3WUV2WGhJRGlwZENDOUVaTlhEVThaTGU3SDdocERzMUo5OFZ1WFFvQXps?=
 =?utf-8?B?TlZMZ2lwaVlwV3VidkFpUGxzeDNkazljOXFJdWl1WUJwTkxmT3hDNTFxY2F4?=
 =?utf-8?B?RndBLzVYK3VFMnk3bkh2bDVnYTRxNmE2by9OaWxGYzY2Vjc1OGxEYmNDcDVN?=
 =?utf-8?B?eXVxYUxCdm9rTW5JSG1uSFZxeTFHOTkxY1dMdXk4MkNSNlVZM0FtbGV6V1Bv?=
 =?utf-8?B?bmM2cEtlbDZhWWNaMEZRVStWWnpTeXhMY01ZTTd3Z09NUkxyZlZWQUFFVTlm?=
 =?utf-8?B?WUwvdVd6MUptbXkyNW11RFlFVVJ4cGZtc0tENWM5Vy9scnduTFBnekJrK3FV?=
 =?utf-8?B?cittZjBQWEhXYWkzTXdVcXc0a3d6MWNnejlzS0pBQllzMVJKZnFXUVFCejZ4?=
 =?utf-8?B?UEd0QVhoWEV6dWFlQStxOGNhNVFKQ2dKZDNyL2ZvbWlkUm55ZEZlMmp2ZjZj?=
 =?utf-8?B?QjhoZmNjanc2cG1yRjJtZUdDVXRWb0tmVWVxUno5V0JoMFFPNFhJWEt1b01J?=
 =?utf-8?B?eEZwb1h5alUzU1phWkx6M3hXV0NzTmZ6SzFobW4vM0h0aElXSDF4T3Y3OENS?=
 =?utf-8?B?c0lUdWl4NkdEN3hCSHNMQUNMOEcyYWk5ZmlQamlEeGIxbk8xeVQ1SFVLZkdE?=
 =?utf-8?B?RmhtVU5SMnlWcU0yQmhURzkvVk8zR05xV09vdjBvYUM1QzRjcFlzUm5xUlRw?=
 =?utf-8?B?aUNOM2dFOXBrOC9iU3hLMTVrSDd2NnkwcVpBanNZNlptOTNjdnJXaEhieXpo?=
 =?utf-8?B?MC95UCthOWd2QTVmZ2l0RmpQSVZFN0oyc3NMeDNvV1NzWStCQWxmUzc2eUVq?=
 =?utf-8?B?SFlGdHRCaysyZm9WOGY2aCtoeEJEa2p3Z1ppMVEzcGFWU1BEd3VXeFFhUE1V?=
 =?utf-8?B?ZHhiaFpHYWdWNmJSbWdDcGE5SHoxOEZJUjFHcWpuYWJNNnA5dkpSeS8yZzNj?=
 =?utf-8?B?VS91RzJITVlvUnJtcUYraFFEMGVkZllxcndnR2Rrd1RaNDNRQzZxWlNTQkEw?=
 =?utf-8?B?b3BZWk11d2VzS0h3clJRNHlyRWNjMnhNelFOc0h2TUFsK3UvNVV2QjNGVTh6?=
 =?utf-8?B?VDN3VUljeVBMZEJOUlVORVpmKzl5N3AyY1J0ZnprVG8rdVVOZldLNnhmS2x1?=
 =?utf-8?B?UDRxTVIxbkM3TlRRYU1nWDhvM0JvVWFEcnRCZ0p0a3lHWmRQdFJJNXRVSk5W?=
 =?utf-8?B?S3Zkb2lrSnJHSnVZeXEvOHQxSkxHVzQvTmw3U0tQYW93bzN0NkRTUlNlVTh1?=
 =?utf-8?B?a2FHK0FnNlFIeWFtaEVIY2tnN0RRYVdOY1NLMEovenRMUWI4WGZSRmZobFpG?=
 =?utf-8?B?dWpEUFVyWmRHK201Vkthend0UXhPRldLY3lGL2hlOGNBY0U4Vk1kVldwbC9N?=
 =?utf-8?B?T2hpOUJNRnE2MDNqRWJJTmhoV2FhcmJYaHEvRkp4YlF3OHNVdHJ1L0grMGtY?=
 =?utf-8?B?Mlo2L1N4dnpzZG81SjczNU0yZm1zdm9SS0NqUXdXckV3amZxVzhFUjdtSkJT?=
 =?utf-8?Q?4ZvnLX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:31.3530
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efbc86fd-51dd-4b44-69c7-08ddb329b7c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8862

The MCA threshold limit must be reset after servicing the interrupt.

Currently, the restart function doesn't have an explicit check for this.
It makes some assumptions based on the current limit and what's in the
registers. These assumptions don't always hold, so the limit won't be
reset in some cases.

Make the reset condition explicit. Either an interrupt/overflow has
occurred. Or the bank is being initialized.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---

Notes:
    v3->v4:
    * New in v4.

 arch/x86/kernel/cpu/mce/amd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6820ebce5d46..5c4eb28c3ac9 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -350,7 +350,6 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 
 struct thresh_restart {
 	struct threshold_block	*b;
-	int			reset;
 	int			set_lvt_off;
 	int			lvt_off;
 	u16			old_limit;
@@ -432,13 +431,13 @@ static void threshold_restart_bank(void *_tr)
 
 	rdmsr(tr->b->address, lo, hi);
 
-	if (tr->b->threshold_limit < (hi & THRESHOLD_MAX))
-		tr->reset = 1;	/* limit cannot be lower than err count */
-
-	if (tr->reset) {		/* reset err count and overflow bit */
-		hi =
-		    (hi & ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI)) |
-		    (THRESHOLD_MAX - tr->b->threshold_limit);
+	/*
+	 * Reset error count and overflow bit.
+	 * This is done during init or after handling an interrupt.
+	 */
+	if (hi & MASK_OVERFLOW_HI || tr->set_lvt_off) {
+		hi &= ~(MASK_ERR_COUNT_HI | MASK_OVERFLOW_HI);
+		hi |= THRESHOLD_MAX - tr->b->threshold_limit;
 	} else if (tr->old_limit) {	/* change limit w/o reset */
 		int new_count = (hi & THRESHOLD_MAX) +
 		    (tr->old_limit - tr->b->threshold_limit);

-- 
2.49.0



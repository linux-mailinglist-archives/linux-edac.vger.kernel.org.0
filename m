Return-Path: <linux-edac+bounces-1223-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4741C8FF22B
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C611F20F15
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221C19CCE1;
	Thu,  6 Jun 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u63+BYx2"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D767719B5A3;
	Thu,  6 Jun 2024 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690413; cv=fail; b=k4touC2JtjhzCXgV5MWsdVPR30JoFitG+2YCnZ6DjJ9s4mRQkpLs+OHiMjSnpTErbxQ0nr7iFd1gI4rxkceM5ze1epVZZLOCBxi5yFYXFeFiB3cAJ3xrptHnRJurzqWSNlfiAHWUEHcHm4BHuWC6+EC2x1Pv4D96BgOIIy5jveU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690413; c=relaxed/simple;
	bh=HlMe0Gc3kR6Av85KHTRT5SCGGwJ2tnl78akSFegQH0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rHm6Xy3bWUTl6oKNpoTIscaAuRN+SxrjlydVtKvXZOvFQU5ivVKYS5SqKYeklkQbQbjG6WKRBiVlNPuKpToHejtSnK3/PyjCyl7hE/ScRo/SN+S3ROVlp9WkuA2wxsynhGv4WHCEL1NQxeT0Hp6tfXgj/gbEoDXmTT6g44JLbFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u63+BYx2; arc=fail smtp.client-ip=40.107.101.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AJ7l3BL6BinPPglZb2p5fSSSTFr7umC6dExBfMAj938v/i0FLZ/mZruxOL+num4SsUoDQ66R7Xjuvpb1ivWeWlx9E6ikW7ubNy5lc/psVQD30wf2JpFzjY0SfXKrurFydUo9l39c9z1xus+keWVBiTzWpPGBcqWnY1WQk1ekw2HKyS/qRDGZtF7ycSffFLQjkQbGTKr6kn6GOXjZzHASlXfO1BwBgQGfXrudV2+haQCr9bWB2F2uKhIQ3R8Ugx9bhfgo4LSQjHRlXGCneWdJ1bhzabJUvyV3SMoVm/J7sFPg90IOGxNxG3HDQ1PpeHBYigxkT9Ab07iakYGzaTUPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLPh46yqPqgF8WLaVPPxOOQvI0dGu5nvOUdYlRnGLgY=;
 b=FCf8dOI/3D3cRa7L4IxppfhXAuD7K5zWuJpy8p9r4v5MirS+D7uyT/y1WdsUQ2XJPQC0VTbB3mHHRB+IkHv8pudwmai/h6rS/5/NF7Hyy7zX+5Mo4iZ5ZAxp4kwS67V3HoUGOm2kroRtqNNS/di8Zm/u8PNW6fsNHomdhzQux/IWueoYxnvEbnlPUV0paM3V1Uvd7iohERofQvkuPO5tzeoO/4Yse2zT88UyyNDXOwvcRhGP9Sg1s7qxKRKc+Iv3KmTM6AWfMwZZvIOetmGQdwWXCcmH3n5RTOyGYZaBpIy4YP2v3LBtVNso/bk57sogmJFpvw5RYFIBk+d9KLiZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLPh46yqPqgF8WLaVPPxOOQvI0dGu5nvOUdYlRnGLgY=;
 b=u63+BYx2mPrP3XkkedX+KIdmYRDStLEMS0EEyRBptX1PU7t837cxiLE0bte741wQrXUVirdFx51tD94lAB0FwEv4TwKd/ToZ3NKfVG9ZyZJnlZmIS44Wl3IQ+muC3RRjW4FyC6uzp+n7QZVr2951g/V7iJP0C/CNqwBj+tovGd4=
Received: from CH0PR04CA0114.namprd04.prod.outlook.com (2603:10b6:610:75::29)
 by DM4PR12MB8559.namprd12.prod.outlook.com (2603:10b6:8:17d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 16:13:28 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::7f) by CH0PR04CA0114.outlook.office365.com
 (2603:10b6:610:75::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:28 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:22 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:13:00 -0500
Subject: [PATCH v4 7/8] hwmon: (k10temp) Remove unused HAVE_TDIE() macro
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-7-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
In-Reply-To: <20240606-fix-smn-bad-read-v4-0-ffde21931c3f@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>, <babu.moger@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|DM4PR12MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a87e0f-daa0-4ac1-e19c-08dc86439a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmRvdkFtN0NOcHo0MkNiZkUxSWRZL3pnaEtmUW1mNG5wYjJJQ3lJeGtKK1lx?=
 =?utf-8?B?bzlJRzZITUhMeFdjY1J5cGE3ZExzZmRubFVUWnp6bzN5ZXBVYzdGZy9acnR2?=
 =?utf-8?B?V0ZHNUl4dVhnQ0RJZjVGcHRGTXdBZlArdTZabzc4QTBISDVWeGpPcU9QNnlE?=
 =?utf-8?B?ajVuVlRqWnNYSGtFNy96ay8yci82K2VGOGxkSTZYbXc5Q1lSU3lnV2pjQUtI?=
 =?utf-8?B?VzkxNEZlZkxIMzZhZXBiRytCYWp4RHV0bHlibVByOUVTSDViSHJKeHF6R0hV?=
 =?utf-8?B?UkNmcnVDRHZiZWFFL2RuTnlnNEx1R2RrbEl2OVh4dkNvRjA5TjVHLzNXRUxU?=
 =?utf-8?B?ai9BaEROU21ZblNZK0FnbDJVeFlkZTlycnNlVENIOCtxV3N2aUJZNGE5UHJy?=
 =?utf-8?B?cXIzczI3eTJyWm9sZWpWYXQxSWk5Z1ZsMVR0d29wdDg4S04vZHF4cHhEczBP?=
 =?utf-8?B?M0lpWW9wdEFlS0dvRCtYVENkM0FVOFpzM2xBcjZJMGxjaGN5YUFzcUg1S3JR?=
 =?utf-8?B?U21XZFpLL3V4ZEc3OHZ0cmo5UDRTa3NYS0pVaksyYWtoV0VJSk1MSWxFQlMw?=
 =?utf-8?B?OEY5MzRZdzZZZDhmSUl0aWthYlZYUFY0NU1KZ005Z2Fna3hvRzgyZ1JWOFQ1?=
 =?utf-8?B?c3ZtWDRNenVLR2k0bGh1NDk4M2RST0M0Zzhkc0Z6Wk1CVE5iQURSSGl0Z3I2?=
 =?utf-8?B?dzFGZWUxZDBwNGtWQW5IaXhBTlpJNm1GK2l1YVplVGszUUlUcEd0WEh5Mi9o?=
 =?utf-8?B?VVVseGJSeDQrU0d2Si9NQWNmVWIzUVB2Uzdad3ZpUHFJQk9kZTJKMnl0bDBy?=
 =?utf-8?B?aXo1ZDBVNDdhZmN5TG84TVdTT1pKTVhBMUhoSXBIQnFXOFUyTnVSWFFManVa?=
 =?utf-8?B?Z0hrMUNNSTcza1BLdHRaZzlyanYxQmwzTmU4Rm5aeWZRMFdSUEdGMHJLbVNC?=
 =?utf-8?B?cVJqejkrakl3dHVJeWd3Qm5EODQ3ZjYydWtCakVTd3NjOXJpNVJ5OTlvQWVs?=
 =?utf-8?B?cWRnTUNIUTV0M1loUUN5ek5Ec0kwVUlHWUhuQ1MrTEdOZ3JQYzhXbUcrSG1M?=
 =?utf-8?B?WXVFUEVvU1VkNHpyTE8wYzBJTXpwbGU1SGxTV25maTZrQVhmQzJwNVhLZmdT?=
 =?utf-8?B?eFF0d1hGN1M2U1AwU2Z5TmpUNUZyV0tUOUJtd29PUkhlSWZiMkxmaU1XSGhn?=
 =?utf-8?B?dHYrUTA1V2V1aXdUQ1MyUFM1NnY3WVMzWUhYeFRueWNUQVY2azIxUlp1dks0?=
 =?utf-8?B?R08xbndHNWdtakdrNXd4N09KM2pabmhCTEZpRFloaWZncUNRUjlTTEFMVGZt?=
 =?utf-8?B?elNYNUwyZXR2WCtoQ0FpbG1BWUliRWNTeHJIdHpDWmIzZnF6MnRkQ3o2Vm5U?=
 =?utf-8?B?dUdhRmVGVlVvSGZDeHBKdlhGcC84U2FtQUhhY1hKNTg2a0VsVTh3bFFsVWtD?=
 =?utf-8?B?RnFKa3JNRXo2VEJqZ1BHSks2emd2eFdzRUY1K1RXaEl2dDdZYkNyMk11NnJv?=
 =?utf-8?B?T2xlaEowQVFEVG9lNkgzd25PS0lNWGhQaGRjRG1nbWk3MG9WcldOVDRiN1pO?=
 =?utf-8?B?bmloVm5TazJ6WVZNM2E0UjRlWHh3azRSRFFzZlU2TFJyUHF1eEJiLzFmNEhZ?=
 =?utf-8?B?QUNVMXdNTnpWK1VQYU9BQmRJZ1dhUVQyTHZET1c5RUtWZSs4bkVYdkpCQXNC?=
 =?utf-8?B?c2R6YjRaL3UwUExrNXluMld5SklIZDlLZnlCSmthUUNnL1BzQ0ZuU3FIWFB1?=
 =?utf-8?B?dlN0WFdPRy9ZeG5sWFlkNkNZMXRQSnZPcHU1MzRZVE96czU1eERhejRwUURv?=
 =?utf-8?B?L2U3ZUI5ZHpPaHZ4WGJjNm1CaWdIcGsrUUlrMUFKSGtiSlRLTXZLOFdmVzBU?=
 =?utf-8?B?bEk3YjUvZW1RYUdQbFZtYUllRDJaeFl0ckhlUWwvWEYrdVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:28.4951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a87e0f-daa0-4ac1-e19c-08dc86439a16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8559

...to address the following warning:

drivers/hwmon/k10temp.c:104:9:
warning: macro is not used [-Wunused-macros]

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 6deb272c7cef..a2d203304533 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -101,7 +101,6 @@ struct k10temp_data {
 #define TCCD_BIT(x)	((x) + 2)
 
 #define HAVE_TEMP(d, channel)	((d)->show_temp & BIT(channel))
-#define HAVE_TDIE(d)		HAVE_TEMP(d, TDIE_BIT)
 
 struct tctl_offset {
 	u8 model;

-- 
2.34.1



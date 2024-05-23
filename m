Return-Path: <linux-edac+bounces-1102-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6645E8CD9DE
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE171F211D7
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF083CC9;
	Thu, 23 May 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5U2ZjGoB"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF14839F4;
	Thu, 23 May 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488839; cv=fail; b=lMo4XQa0LxYJVbBA3Vd3dfY6MEKRVYVP5n6LeKXRSXMMik6uHiDRq4+o6HGJvn6qTAQJGakPL7iiXGjFIZF7qbPCWdVR8n+Msoax3a8C9+Q4GXUp1NLfZllnRNoJd0zWu9+UWIsRsump10aR9OVN0OXNuo+OofofLESg/fJfieI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488839; c=relaxed/simple;
	bh=f6hqEN1VIsd63HVw54vGLB6GVd2Qpx/lRCj+1dUDUQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JTDQTM77KT1Llfxsxs77obtxa+egg/4FTPLpkZ5fQ0HlAlErpgFN6An1UBasCiLBfFmb80Y7KQYsWv7fEOWTh7sQmORJnxR6CC2M267oN+RhtewHv3RB1ncDj3G8y/PlgIlHaWnIsxGcIggQEmRIbLWxzqq3v3p6hc9l0ZSNLCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5U2ZjGoB; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwcYYdHGDnDUBfxZQGccEP+iF5bV40T96yeGzvBSYtIU6JwKJeJfZevMAeRVn7iPNs7vyH0Cv862wShDjNA8hYzqBwTMy1su8Wd+0cnooy/BRrsqLAHgAGNt43qEWty3dnXZPYz0qfUOs6OK1axmc8BV60ixcrre70i51Ge+Yobks6TnCg/zmYDdfVXuwZEya1xWP1gXgkT6EC+cp2RoagK0fBv01RV69zIJFxdEZWjiIBOHE4Rl63aP9/oZFMaK9rr6JjxCCwKoRlhAz8sjYeFtVkKwrmcyuFqc/Sz8uIpU/l4obJM12jj4TN0hH4KU+vzeLP4CvyTUv7OEbBhmBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bHFV0adVCqx/ezBMck7stOQmPqgwE41m48rs+rvyqc=;
 b=U6bybkYqTQjAVn61QTWG06VvTHkMH8diMTAL12AEs/MBYUUaxRU6Q+we5rWmKx6R0j0yJUBmSSYs2+LGnrnFuRGocv+pQgi2ZPiOTalK1Uf9YtI1wL8bDVGJRs90Uawlc87yqGEWGH0WWpN6l7WHeSCGSCHt/msNbzgRIPkYDVDSqxCX9nH4UPaYlCwbaCBeqhBM30KPwJP9NXSw0aqgp7WEZKOotH7Gxys+K6DUZZU0PLb8PhW0XJbaUoNC/GmowYdIzzyX6aB5wm92KrLigmt3gKWco9h34RhKDCM3gJeMWl2u6mEsHJOTAKqEEjzcO76dXO0lrBeEU0KlgATD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bHFV0adVCqx/ezBMck7stOQmPqgwE41m48rs+rvyqc=;
 b=5U2ZjGoBLlmQrbded+2iiJUAisacMk9pgE+8rf3VMKH2hfEbgibwjT7Q3KHTCyidUu6UEK5aWmlPCkjJ+Yrts3jX3/Y5QnnQwBlAn4mRHsl6FDaMKVUws2Y3PMArjAQvvnpoHSw5mKZF7hIOTXkXrfmXFQODVlUgmzTKZUx7yhU=
Received: from DS7PR03CA0266.namprd03.prod.outlook.com (2603:10b6:5:3b3::31)
 by SJ0PR12MB7475.namprd12.prod.outlook.com (2603:10b6:a03:48d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 18:27:15 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::79) by DS7PR03CA0266.outlook.office365.com
 (2603:10b6:5:3b3::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36 via Frontend
 Transport; Thu, 23 May 2024 18:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:15 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:57 -0500
Subject: [PATCH v3 6/8] hwmon: (k10temp) Reduce k10temp_get_ccd_support()
 parameters
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-6-aa44c622de39@amd.com>
References: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
In-Reply-To: <20240523-fix-smn-bad-read-v3-0-aa44c622de39@amd.com>
To: Guenter Roeck <linux@roeck-us.net>, <x86@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hwmon@vger.kernel.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ0PR12MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0aeeae-b846-42d4-9ea7-08dc7b55f8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUFBa1VueUxUV1g5bkdtTVRYeVFZS1BUeFFEZXdyVVpOQzdzL2QvLzRBSldW?=
 =?utf-8?B?TjNiZWVxSmZSbWo2MHd1NytiWGcwSmhhRTVOYmx2QXFwMmJvbXlVclluQytD?=
 =?utf-8?B?MER4a1dCUnA4RkpBaVZjSFFMVEI2Ri9paFZPcWZ2bE1jalRlYjYrRG1xOEov?=
 =?utf-8?B?cExRKzNVSS9nSXp5eUNuTjBMaklJUXJzcTByWlFpNlFVemxlRXNyNFV3M001?=
 =?utf-8?B?SUVCZkp6Z1c2K1h6b0hjOUJBN3BEQk1XeE05M25YYWlPVmIveDR2bHpPMUJP?=
 =?utf-8?B?TUhJUTRpTExndmxSUDJPeWhzTVF2SGtIWGlvdGpJME9BeU5NWk5NSmRQUVlW?=
 =?utf-8?B?M0FWMVIyTEVtVGxqZ200NGlKS1JVSkJ3bDFDam5vdVpqeGRnOFBDMmVXYk5s?=
 =?utf-8?B?RkNYRFhNY0pQYmplSzdwNzJVanBoSDJqc0JXd3BTa2U2cWxMeWVWV1BMWi80?=
 =?utf-8?B?bFhFR0Q3MWRscWZrQmltb0dQWXcrQmFBd2lFWjg0bmNnYWVWWnJYTVJsMCtk?=
 =?utf-8?B?QktGVE9YbVhBdkFHS2Q1b3ROa2h0Q0p0YmQvd2EzQ3BFdGpRR1pQbVZQUk12?=
 =?utf-8?B?VWloMWdURmErcmJXbDlaRVpUM3JZUTN2UlhId2o1TW5ON2ZPM1JmcWdUY2V4?=
 =?utf-8?B?aG5zYlJBVEJPbzM3L3pDUlFmU1VXcUlCcHE5T0RvM1NrbndnOCtibWFFbTUz?=
 =?utf-8?B?eEM1RnFGeXpXbFJWZytZa1JhOXFKRDZJWjNFb2hqRjZuU3ltQmhLcDMxK2sz?=
 =?utf-8?B?NEkrWjg5T1c4bmFUbmMwQzNBYnpGbzI5Z0t4eWMzUG9JOEYyYkhPY3kvVm5y?=
 =?utf-8?B?bDc5SlZTK0xHeU14U0tYUFppMTlmeFdRUzl2WkNMQVYzZDgrZjlUUTJCWHpu?=
 =?utf-8?B?c28xdm9PeE9QelhLUU1sSk83aGNZTzlJVE05eWVlbmxpTEJpYk5FTzVVRy9w?=
 =?utf-8?B?QXFiU2FwQkp6Zm42c1JveTdORTJIMHR3Uk5ZYzVyQWRzZEpqVVhNelkxVW8r?=
 =?utf-8?B?N2huK0RJc1MvYlNPdVJDdUN2VUw0VkJEN2pmYVpsZVV4L1VvNnJVeGlxTXFu?=
 =?utf-8?B?bU4wbzY1UjdSOXQ5eEFnb3paVDhybmlUeVIwVTI5L2wveFI4MURnNDNOWjJt?=
 =?utf-8?B?QmFYeGdZSzFDbWF5SmtVTnJBVUpxN0p3TllqRkh3bFJWUlpPZTZXaFJGb2Ry?=
 =?utf-8?B?SGJQR3RpcTlWMTd0UFp6RmNyMXp4bHFKS2F4UEt5RnVIUTMxYmZldkJFbStY?=
 =?utf-8?B?MWZyYXk2NkV2cWRNdnRhaFhOZy9VMjFPOXE0YmFGZ0wyTlMyQlNYTmg3eWkr?=
 =?utf-8?B?TlVRNTNJR1MrR1FhTXlETTdlTm0rbzM3R2NPZXY3TzhtYzMrUW5zby9CZ3Jo?=
 =?utf-8?B?SnpBWGEyV0NhQ2x1dXdJRVNMRVZqaWRCWDJQak1PMk1seldTbFRscW5BL0dh?=
 =?utf-8?B?NEhGWncwbHhadkV5cktjU3o1YmFZTzlDeGtqcVNVSDMrNHpDZzVPUHQrbVEw?=
 =?utf-8?B?b2g4NzdUbUZjMXluRTgxUVhWRUJUaEhPL0pZMWNPOUhQTDZML09ub0JjNUpk?=
 =?utf-8?B?aXVFYVpZemJvT21nckNSdXpIbUREWHdkbnZySlVNOHM1QkZxKy9kQXNtZnpl?=
 =?utf-8?B?U0ZWUmQvYkhGWm1qWEd1TENVZm9FRThWMWV1MElFUVlWcmo2NHRINms2QVBp?=
 =?utf-8?B?QTQvdFdxYUQ3cG05cUV2K2tUZWtVcUJ3eEw5aVpwNUhjSy9SaTFrcU9xVFlN?=
 =?utf-8?B?VTMvUHJUc2YyUVJzNGFUa1ZmVDRIbVhkWXpoeENnVWMxcUMydU1RRmZoRHVu?=
 =?utf-8?B?V3dhQnRFWUh3NDFIYXZXOWQyU3FxckhsdEEwZ0dPQ1dBQnNFV0JzZnA2V25M?=
 =?utf-8?Q?M9d5PPZWBM+vm?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:15.7115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0aeeae-b846-42d4-9ea7-08dc7b55f8e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475

Currently, k10temp_get_ccd_support() takes as input "pdev" and "data".
However, "pdev" is already included in "data". Furthermore, the "pdev"
parameter is no longer used in k10temp_get_ccd_support(), since its use
was moved into read_ccd_temp_reg().

Drop the "pdev" input parameter as it is no longer needed.

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 315c52de6e54..6deb272c7cef 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -385,8 +385,7 @@ static const struct hwmon_chip_info k10temp_chip_info = {
 	.info = k10temp_info,
 };
 
-static void k10temp_get_ccd_support(struct pci_dev *pdev,
-				    struct k10temp_data *data, int limit)
+static void k10temp_get_ccd_support(struct k10temp_data *data, int limit)
 {
 	u32 regval;
 	int i;
@@ -456,18 +455,18 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x11:	/* Zen APU */
 		case 0x18:	/* Zen+ APU */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 4);
+			k10temp_get_ccd_support(data, 4);
 			break;
 		case 0x31:	/* Zen2 Threadripper */
 		case 0x60:	/* Renoir */
 		case 0x68:	/* Lucienne */
 		case 0x71:	/* Zen2 */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x19) {
@@ -481,21 +480,21 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		case 0x21:		/* Zen3 Ryzen Desktop */
 		case 0x50 ... 0x5f:	/* Green Sardine */
 			data->ccd_offset = 0x154;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x40 ... 0x4f:	/* Yellow Carp */
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x60 ... 0x6f:
 		case 0x70 ... 0x7f:
 			data->ccd_offset = 0x308;
-			k10temp_get_ccd_support(pdev, data, 8);
+			k10temp_get_ccd_support(data, 8);
 			break;
 		case 0x10 ... 0x1f:
 		case 0xa0 ... 0xaf:
 			data->ccd_offset = 0x300;
-			k10temp_get_ccd_support(pdev, data, 12);
+			k10temp_get_ccd_support(data, 12);
 			break;
 		}
 	} else if (boot_cpu_data.x86 == 0x1a) {

-- 
2.34.1



Return-Path: <linux-edac+bounces-1224-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E96028FF22E
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EE881F21248
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7AD19CCE3;
	Thu,  6 Jun 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uzA9cSOk"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3219B5A5;
	Thu,  6 Jun 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690413; cv=fail; b=YiBhY1z3YFdQpr5NhfU2TYdv3xXjpWM4GOfWsHRBWmtbNuEY5p12K5MWlg9s3HHy/ka9eyDlOtYjaCF1k/INmDqcaFDJr2ZZO8Z6u+kLq5DKHuIn8V7bxQAdJ5dkR7ulLKUvDIhsM8usRxSjAa9gclQQLm0MFUBoKotVlPvDCbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690413; c=relaxed/simple;
	bh=f6hqEN1VIsd63HVw54vGLB6GVd2Qpx/lRCj+1dUDUQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=k0ZTDzr84N3fPMu9FJdiyzF6ukaw9qMdwQGj+Fb0virBl8Q0YOJYq7VyL0OyB4Bn0plw3kRyEwWn6cWCGWJ2ezWkiAQOAlavmYMa2ptfC81YtzhxEBE41Utf+ouBr4vN5vmbZ43v1qrXcOUUbkTIxrnhrQZ9kcLXequRCrdiHus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uzA9cSOk; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOwrjDHXogRyv+5q9hOLdKWqQMwVHql4GieJLPvmJXngJd08rHXXVtlf3Ib8/7nP+BHf5nvpaZHqbNuMWD+RAaZWa898CgyAZ1mSI3snkPCj9z1QHovfiq9HwCJDZncKoVqg6D+dsbm9Ny6tE9vR/rJTU8pauCmqR7bLs8zSJ8SP+r0Euex4K7o4CwFFVKkMsE71ezX3JQMQWvvL7t7N0Uf3S2hrPEvUnRiaZud1EQs5a9EaEgsaMPKLASa6TYGZxc/3GPhWDmvv2Y80xsWwpJGxVkmINDDdeaUCRtWy0bxv+Sjpm9C9d7U55iJ9L/bvveVps6t4UC4RYzmmilp4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/bHFV0adVCqx/ezBMck7stOQmPqgwE41m48rs+rvyqc=;
 b=GTHro1TGKiP6IKOjsNq8x8/OI7j2gWyEHdpH2CsrUBT2IvqnenzUmiauqn7ZC/PbuiyHS5e4OQsZ5RotTpKYmKWf5xB1wL5uD4u4fYvZGKaO//ndH4guRD1cFiydS5+JseHyqNcI5nS60pWuaDz/CfQWyOUnD0ExSmH0yYE4Vlonc2EWYFQU7Nb5Sd4fIrupJj4MfnvRVoy86Guvg4Jb5ZneKpsFZRcF47HcCEBA8/XRmlbPLgFDUP3IY1W5ZDBpACyBAtJmnqfK5MljP9CnQ1PBd7abivGjHVidx7Z+WO1jCHAlAH8CyoDlN9C/BrtkuWSVuLLKk/9VmE7680HMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/bHFV0adVCqx/ezBMck7stOQmPqgwE41m48rs+rvyqc=;
 b=uzA9cSOkeRpPWC3EJnPCxluUT5q5LC9aTA2jXuX+HSdluiOEa49wyoo3JmDQvsH10BwuGKhsx5dBdRjryopKeaqU71YxV9YnqEpPdExjIXLYpwjlh9cuvUN+STYBI2ZntFNAg09I77oUxieNAWkNXEdN4JBQtK7/48U9GnP+hsg=
Received: from CH0PR04CA0109.namprd04.prod.outlook.com (2603:10b6:610:75::24)
 by PH7PR12MB5999.namprd12.prod.outlook.com (2603:10b6:510:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Thu, 6 Jun
 2024 16:13:28 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::ec) by CH0PR04CA0109.outlook.office365.com
 (2603:10b6:610:75::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:26 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:21 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:12:59 -0500
Subject: [PATCH v4 6/8] hwmon: (k10temp) Reduce k10temp_get_ccd_support()
 parameters
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-6-ffde21931c3f@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH7PR12MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b8b172-1007-4995-8b86-08dc864398fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1A4TDBELzZ3NTk2cE1lYzN6biswaDd0UitUOFc5R2ZQNmtHdXFMSzRoMmRh?=
 =?utf-8?B?YzUzb1FuYXR1NHlrTzBaWU5hTVNqY1c1cWdBaVlPTExlNlpoM0l3ZzdjdXdy?=
 =?utf-8?B?VGhYU1pmOGZRVkNwYUEwQ3Fqay9TcVVzbStLZU9KaG9aVEpBNXgwU3E1Mll6?=
 =?utf-8?B?VTd4MnZaM0xrblp4dlIyYzJTRlhueFZZU21iVGVVYTJvbnp5aGkyc1NuUGZE?=
 =?utf-8?B?Um4zSGErU1ZVQnp1RVRzSHRTSnIxdTRlRG1KRWNsOGJOS3Fwd2huLytVcmQ5?=
 =?utf-8?B?WFZOWkRDbHpaZTh4K3k4ZkVNRW0ySi9taSthRzJVbXQxS2ZmK0QzMFBxOWs3?=
 =?utf-8?B?WkQ1bVROcFd3a2ViQzNrOGdUVkNVS2l4TFpyakdhNGNBSStINDBzVmUzZlky?=
 =?utf-8?B?SEFPL3QyVjR2NFhpa3RXYlFWY3NyMmI5aTcwUFRTaW83VTJoVitVSnVUZDZJ?=
 =?utf-8?B?ZTN5NWpWcGRnNUN0c2lGaFk1UU5iN1lCUUhuVGZJN09uY25HcElzenVmczZm?=
 =?utf-8?B?L1ZrZXVhbDBWeDVQc0s3SXVhVmx6UFo2TVNhZklkd2lwSjhUV0RIT29mbjAz?=
 =?utf-8?B?SDNpVVdmQlg2ZFZZc1hVOVZkaEZ4KzdHaWhkbzhqNHlZSFFUN29laE85VVI2?=
 =?utf-8?B?Uk40YW5CYkw4Ry9FZHdQVStqWlRaSDU2Z1o0U1NKTkxHQXU2ZGdkNXY0bk1I?=
 =?utf-8?B?djNXR01KcWkra2lLcjNQbVovUFFyQVlWMmI1MFBEY0V2VHhhWnZxTWZUd3A5?=
 =?utf-8?B?azMxR2U3TTE5ZEFQQTQzSnZEUTRRQ1h1WFlVNGJFYmR1U0ZBK3YvSDVlY0ZV?=
 =?utf-8?B?WjMwbEJqU0xtSEdacGRteDNUR2JaODllYmtMN05tSEZqdlkrUTdINmJyYm5S?=
 =?utf-8?B?b3kveTFlSCtYQXJYYUNKYndnS1VpZkZJTHkwZ2xYVnkxWk0wOVZNcnIraU9B?=
 =?utf-8?B?NEg3aEY1dzcxMGxhQytUTmJCY1FBVXhUY1Ntc0JDUThrcEYwaXZ6ZUFCRWN3?=
 =?utf-8?B?bjVPM3RMY1ZMUnpQRk0yRnkvYVZYN3VTeXpnWVNha0t4aXd5L09xNXFZRWxk?=
 =?utf-8?B?dkcvaUFFcTVYYkZJZXZ4Q3hGRFdqbTFPWktRNnhMRHB2bDIrWFI5S1BXWXVF?=
 =?utf-8?B?Szc0ZSs2a3lpdGtnVzRnNk5OTWdBbGV6d0doN1RHVGR2d3hTN0lMbVB6aWtT?=
 =?utf-8?B?dzNlbVZ1amowUVhRL3JhMlovQ1pqdXNQbE8xeVJrZXJOM25OSzN2SXdJSnha?=
 =?utf-8?B?RzEzZnhzdTg1MSswRnRRM3FaTkhiWlpBcWxoalBpQk96OVd1dmI2R2N0NXVi?=
 =?utf-8?B?d1NWY2FQMGhtRFhrd3ZKRXpNTTd2N2FhcXo5YUVKZHRyUjF5N3liWS9lL2pS?=
 =?utf-8?B?ZjgzS1YwSEVqbi9UOTI5WjNCczI1UGlIVEUybHZvbEJrQW9scUtkc1UxU3c4?=
 =?utf-8?B?TjBtRU1Hc3hJSWthczhYa0xLTW9LeTVUNEY0UUttSHRZTUhucm5RSmFqdnFT?=
 =?utf-8?B?c3J0WDFERlcwZzg3Z1E2dWtDYjFxM3dJTXF1NFhuaGtYT3Y1c2FHRkhuODV5?=
 =?utf-8?B?WWI1TTNFcU91Q3k0NzFNMFVFdS9VNkNYYVJYU0FkRzFndFdhOUdsZ2dMNjNJ?=
 =?utf-8?B?Q0YwL0JwZXUyU3JuZzhKejZqdXFoVVlhMmIvbTRJM3dQNGJCbVJUbEZraWdi?=
 =?utf-8?B?TW9FazlPWlpKUXRyU0M1eHg5bmM5M1VxQWVCWUUvYTY3NndLaWk3QlhKdWsr?=
 =?utf-8?B?UUZ6RUp0ZXlUZVlVcDNNWGM1TCtTZmdmUkJkZHVqS3E0dnFXeVZVVFZqUVcv?=
 =?utf-8?B?V2VZVHFyQXE3MXVKcFcvM1NOMFRCMlRBWStkc1Y2SzR4QnVRbU1tTEpzNmtQ?=
 =?utf-8?B?RUljMTdCcitSaW9rcWNMQ1B5ZkNHSG91VXlmcEV4SGtaeEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:26.6670
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b8b172-1007-4995-8b86-08dc864398fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5999

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



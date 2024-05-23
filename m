Return-Path: <linux-edac+bounces-1101-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BFE8CD9E0
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6681FB20B9C
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB83883CBE;
	Thu, 23 May 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uKySHWCV"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BB6839F1;
	Thu, 23 May 2024 18:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488839; cv=fail; b=QpEum1y1yZW2uhRBOClks/OJ/X+2jb3PiFwi+GSqc4zlsWV6a1LA0qRrISMFIRyNXjaItkCbFGhOZ2QRWmzbAOm4n4ehvS+1p6P4yM7G60fEvJRyzYnwoh883CAFE8u3oFOFgh4YBVjX4blmi8CE1IVB+a/g/11INwVRIRudDvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488839; c=relaxed/simple;
	bh=2gYvUh5PKw2233MexlsVSiWRL1PGFQPAhe56WcdKUdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GXuW1O0bE0c98QzQ/rNyVRRXO5/vY7TecytSjFOl84949nb/jrnPBdFiMtAFWVjUNPtwEzmNDndB/ZhfBI9uEitw3svNIlxsoR8Rve84dQu5l1cGUWuTVwXTzmJtoAg+qkTFsX3/8TM0KlbFT7E/AmCMJnT/BZqCVC6Yrfd5kU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uKySHWCV; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6xR4SuHUprAhD9apMlrecQaP/P0xFnIQWLN7IqK1K/ge6zjL77PWoHfnm4nrfiM/xXhs8luIPkL7io0Ox10HpIz1g0+B67K1cGGxCrGlwrWPTsf6LFnGT+FhHXAZPrty2fWVCFKr66eNbELkWN+e+Ri3fUcFJcQ5dNabTP1dqttOjQM/BQ0cnLZwnSi9PHNvxzNR3C41PPY15M8gcFoQtvvczZDIk8a7Gh4yae4qGxd3VIVVZpcMmSE0SuIZt8SvhooPP/JMwK1QfuQDR9QrhhehmjePTqPmL0kyvBR1JjjyZBy6phFjWwmx6yuLP8/yW7dwS913ZQmfbg6QLuaqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQMYUiQToI6bsPL5qK5LK7Ie+ErRZ5mhsBYqaRs6/bY=;
 b=M5Ym+qFZPCo0rVosB7tfNLs13W0uOAXJFNskKcdPP2uHcqtRW7QJo8cCkpP3doWbUY3cJ+VSnfVu2uomcy0WLFZcI2ubv38WgsLwXD6ezo68BYwSGgTfNHHqbDuy4uP9tJ/Xqu6C+0AAdHXoQpRU/BmrjT2gWoHAaBWOHSb5YkYm8PPXGh2ED+aU+QdxcMX6dZjJgnm3Ya2mtkptOcfurKCT4vlKXsMlgmsjmDBkdJ1uRA8VaYztjmTe7OLnlwyGT+qMRSf2CTrHv3JtD4HNMaVCMDWisdoRBa7Ur84Nx0qYo6l4CzIKTGuDsfyjuHR5KzrI1GzAKByGt94yY4sgiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQMYUiQToI6bsPL5qK5LK7Ie+ErRZ5mhsBYqaRs6/bY=;
 b=uKySHWCV569z7hhXvq//seSm7VQJjGmmLcbILkHBANk3FKWI6k833SCmW78h3/c3zstApvgFs1vJR8UtPVRvKgtas83BsNRQXTVAtl45XMlCNtizLj9Q857IFmMI/nz98KMIcVHFZcgCPpGkbFZX01YsHMxfzpxnEE9MF8fYNlo=
Received: from DS7PR03CA0247.namprd03.prod.outlook.com (2603:10b6:5:3b3::12)
 by DS0PR12MB9040.namprd12.prod.outlook.com (2603:10b6:8:f5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 23 May
 2024 18:27:15 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::da) by DS7PR03CA0247.outlook.office365.com
 (2603:10b6:5:3b3::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35 via Frontend
 Transport; Thu, 23 May 2024 18:27:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:11 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:09 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:54 -0500
Subject: [PATCH v3 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-3-aa44c622de39@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DS0PR12MB9040:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ae8702-a0f9-4b6c-445b-08dc7b55f660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTRQMnlQSmpmYUJQTi9tVXlUQTJLTDQ0REs0NUNkbjhsN1VDYTY4Vk83T3Zm?=
 =?utf-8?B?QXZXL2pQTE9KZHBRcjd2TzlIaStzdHpkdjRuQmtaOU0xZGloUm9nYUMvMVdS?=
 =?utf-8?B?R2VCclVrdSthNzNiSm1RNjZVa3JsSHAzYm01RW1lN2FWdmxJeU9LWk40UjVt?=
 =?utf-8?B?dnJmT1REYUl6SFNqakxzNkpsRnpUOGJHdVlEVFJHczVjT3JQbFR0NEJtL3BC?=
 =?utf-8?B?a1YrbGI5Y1pwZExlSzB4ZE5nSXVxbmRWKyt0VmswZW8yUkdZb3p2QXZWYnVN?=
 =?utf-8?B?UXBObngvbDZLRm8wdENRUC9DQ1BhVjVoOS9GZnoyTFUvWTIrSjQ3cHJCeWx5?=
 =?utf-8?B?VGtHaWxSKzlnaHBzYmpSTVVuTzNYL0ZwVEpTWFZKbUFhbFR6UVFlbUkvdFdw?=
 =?utf-8?B?anJTMXoxRU93cDRKM3FHN0xZYmo5eFR3UVRUQXQwV0xCY0ZUeUVFVkNGQUEx?=
 =?utf-8?B?VlRVQjZGVzlNaDRZR1dwMElzQUdQTVFxaUdmVjdiOFZQaTN4N2NPcFJjSi9Q?=
 =?utf-8?B?TUova1RidlBoaTl0RkJ2eGlyYUpQR1dFcnU2S3dNOEtZcW5UZ0pZRy9YZVgr?=
 =?utf-8?B?WVdHZUlGTlBQcVBTbWN4ZzF3bk4wQm1KY2dJQ0l6VlM4UnNLSzJjWEJ6SWRS?=
 =?utf-8?B?Q1ZvSm45Y2s2UytCNWdvMk15NHI1V1lnb1lxQU9FYmU3S3JMbHIyalQ5NmFY?=
 =?utf-8?B?WFBRZE1kZXNlNFIvOUJSMVF3bGJBak10ZDh1U1Nmcmx1SWZFQ3Y0a3FPYks3?=
 =?utf-8?B?QWFWRmMxek9zS2xzYVpmZ3loL3d5aVFPdTFLZ1BUcTRyQWhZQUhiZzNjM2FB?=
 =?utf-8?B?RGpSQWt5Z0piNE80ZHRsNmlSTEYxa0ZMWlBvNGE2S1JnV2dxTGRLS3VoTnUr?=
 =?utf-8?B?dHdRYkVHNGJ6enpTZWVnREhWb21McXVkRGhhd3YvRXlPVXpBMG5obnVGc29D?=
 =?utf-8?B?YkdiNi9NT0ZpNzQ5YmdFSU1lOGFmeVIzU2g5UnZZcGM0NE9YK0JJRGNVN0Q3?=
 =?utf-8?B?TjRIbDlBREo2c3ltSDRCanNBU0M5TldHOFBUczdEV01EUTVrVVpkY1hWZVdv?=
 =?utf-8?B?RFMweCtHSFBqMmZrYlZ5bG1DdHYwZnFQUXVrUnpNN3NHQm10Qnl5cUQxNjdl?=
 =?utf-8?B?K3ZjNDhMSkw1VW9BU2ZhdlVlLzBOdXJ4UEkwVnBxYTRxMHRCYld1bFZSYWlK?=
 =?utf-8?B?SDN6cmNzUHNSL2ExTVZhanAxNDFnZWpTMHltYUwrMnRyZVFkSTJvVjFFL0Zi?=
 =?utf-8?B?bHIxZjFUTkQ0RXVkVk5WTXNjN2RVRkNvZFI4YitDT3JRUGdIRi83NGMyQWxF?=
 =?utf-8?B?WlhyWGdpNURpTWtpaWNDbjZsN2VaWFF3ZmUyV3FQZ2RabEJETWZ4Szc3ZGh3?=
 =?utf-8?B?MXZjTVJGMTQ3d3Jud3dSd2E4MmI2dFc5N1Y1MXhnUStTc3JaVGJFYVRTU2VW?=
 =?utf-8?B?WHlkMmE5UHAvWmNMalQwRHd4Sk9FdkVpenBwYmhmOVpwa1N0L3phUVZCT1ZU?=
 =?utf-8?B?ZDJscnZwMU0wRGVJQy9lOW5jd0JYN0RkMnBPcUVUMFYvcURIRStDUmd5Ykxz?=
 =?utf-8?B?RngwalljU3J4NTltd0g4azgzRWFvU2VTbkxuUGl2UzduVzBaaVV6QzdXN1do?=
 =?utf-8?B?STQyWkdPaTVhaEdSM2M1a1pCa3h5cW9JWlIwSEhmTWdCdGprYzl1M3JNUDBQ?=
 =?utf-8?B?VTdJSnI1WkVWVVBJL0dmUis5bk1HNWdXa1RZOFJRYTBrZUNXa3FxWU5mdm1D?=
 =?utf-8?B?d0JkOHhWWEQrRzBtM3pzdXVUR1RhQUJoOUZINDBsd2R3d2cwUW14VUNMMGt3?=
 =?utf-8?B?dXRzU21ya1JHd3lhZjJhMmJKSlZRTEFsMXEwbmR5cFQrNnJzcERCRG1zR0J1?=
 =?utf-8?Q?6yTnNk0Ri0McS?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:11.5083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ae8702-a0f9-4b6c-445b-08dc7b55f660
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9040

Check the return value of amd_smn_read() before saving a value. This
ensures invalid values aren't saved or used.

There are three cases here with slightly different behavior.

1) read_tempreg_nb_zen():
	This is a function pointer which does not include a return code.
	In this case, set the register value to 0 on failure. This
	enforces Read-as-Zero behavior.

2) k10temp_read_temp():
	This function does have return codes, so return the error code
	from the failed register read. Continued operation is not
	necessary, since there is no valid data from the register.
	Furthermore, if the register value was set to 0, then the
	following operation would underflow.

3) k10temp_get_ccd_support():
	This function reads the same register from multiple CCD
	instances in a loop. And a bitmask is formed if a specific bit
	is set in each register instance. The loop should continue on a
	failed register read, skipping the bit check.

Furthermore, the __must_check attribute will be added to amd_smn_read().
Therefore, this change is required to avoid compile-time warnings.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/k10temp.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 8092312c0a87..6cad35e7f182 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -153,8 +153,9 @@ static void read_tempreg_nb_f15(struct pci_dev *pdev, u32 *regval)
 
 static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 {
-	amd_smn_read(amd_pci_dev_to_node_id(pdev),
-		     ZEN_REPORTED_TEMP_CTRL_BASE, regval);
+	if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+			 ZEN_REPORTED_TEMP_CTRL_BASE, regval))
+		*regval = 0;
 }
 
 static long get_raw_temp(struct k10temp_data *data)
@@ -205,6 +206,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			     long *val)
 {
 	struct k10temp_data *data = dev_get_drvdata(dev);
+	int ret = -EOPNOTSUPP;
 	u32 regval;
 
 	switch (attr) {
@@ -221,13 +223,17 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-				     ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-						  &regval);
+			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
+					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
+					   &regval);
+
+			if (ret)
+				return ret;
+
 			*val = (regval & ZEN_CCD_TEMP_MASK) * 125 - 49000;
 			break;
 		default:
-			return -EOPNOTSUPP;
+			return ret;
 		}
 		break;
 	case hwmon_temp_max:
@@ -243,7 +249,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 			- ((regval >> 24) & 0xf)) * 500 + 52000;
 		break;
 	default:
-		return -EOPNOTSUPP;
+		return ret;
 	}
 	return 0;
 }
@@ -381,8 +387,20 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 	int i;
 
 	for (i = 0; i < limit; i++) {
-		amd_smn_read(amd_pci_dev_to_node_id(pdev),
-			     ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
+		/*
+		 * Ignore inaccessible CCDs.
+		 *
+		 * Some systems will return a register value of 0, and the TEMP_VALID
+		 * bit check below will naturally fail.
+		 *
+		 * Other systems will return a PCI_ERROR_RESPONSE (0xFFFFFFFF) for
+		 * the register value. And this will incorrectly pass the TEMP_VALID
+		 * bit check.
+		 */
+		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
+				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+			continue;
+
 		if (regval & ZEN_CCD_TEMP_VALID)
 			data->show_temp |= BIT(TCCD_BIT(i));
 	}

-- 
2.34.1



Return-Path: <linux-edac+bounces-1222-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7635F8FF21F
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB8A1F23577
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F30B19B58F;
	Thu,  6 Jun 2024 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dXRFRNAq"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D219B3DB;
	Thu,  6 Jun 2024 16:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690411; cv=fail; b=U5hfbOpYLcaZ6quRAjxgpUm7gS9zxe/hJpwbDQqx79AsCguqRNG+veT2qaN1Xu6mj9zbiAyoqJNfI4e+Qn7sGRbho6AmMAa5WwW9FrahulHU0l+nYPCDGD5LMO0RRAk78FRFbIe1aHQa/LYBB4JTKdPYcfe1/a4jSZlauXCXe/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690411; c=relaxed/simple;
	bh=wS3+mE2h5wAiqHNbd5F0/aPcPHQiIWNi1aQuBqT3Qf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pP6m2oVS6+vxBFeIihKZPxZLegKjUs1iIZVapJWPgdByOFrqqbQrIPn3ILoRlSwbg73qbGHjTV0EF8P58bJ8tWvFfCk/lpuXrndI9q3q09ISXeLpPFhSITiktEy7mHPnMYsHdf+cSIEZxnbnlvaKJgUqfEnQ4UhCWAVLRccv4WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dXRFRNAq; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bB+f99TuKqWxqLYoovwCtNdmW9T4IRZIUju/DrYJ+KUubaAfYUFiEHmh8/3lgzsZviCykD8F5PxkS1nglf9zHQyzIm1bDQrL86GcEvSa1i7TCs+PywtL/AOCWjfQ5FMF+sagj3T2k1dvcP9/O6XVj0IL6/L5B2kus5oO+W3/R9ALsMNWP/wa1dbtABPlY0pXzRL/jk+KtV9HXrb16GF7QOAxZYaDS7V9SkCZoYWxPhaVtbMFevsSPQ5rH7jyivu/6LS+8zrbqk6A6JNaVq2uXnprC87k8ijF7MDDNesA8KhVCWJnjkBX1/s4aOblqKJILYDrDPl6LgMV1gH3f4GGDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSVWdwBYxEnXSQDb11DLW1FrriGwziZwr5kWDaJdBUU=;
 b=DyaStnTPp4ll++mehWt0Z7tTgPoYUiKW3zeNhq2bPhe9/mRs4JEr/4Crc6cZnz35wjZrvywvOyWKAOLiSsT3VRVZyqc8TSlA5sOBliN6hVNuLVqfzEt7qocX+9jPfz28wkGPv/X0mahtJrEDV7e+xfdKKhC7C+oCg6xnvbMJsoJbaWL/RnxIy0OYoPH5XuW6CU7RV7D2ayDjwBOe3DBo6RRBsFs0Kv0aKzmYSF23xTlxmQ4ddXMBBxtFWsmJeNsdeUxKpwgq5WFiNrKNuOKf7Mv2pZUMtoTLTi0bWbt4XfykU8in+jZ32es7RdaIBVTMdOcADRub9QqB2awGCxNqqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSVWdwBYxEnXSQDb11DLW1FrriGwziZwr5kWDaJdBUU=;
 b=dXRFRNAqC+VtpMgSqUun6o41B9p5+7v2VAnMVyVf8odHqbmAWqGh53Gc3qxH0rjhmTxPXPmZIIiLGW0JD9iX7vgym5ZyTOXkfN+RsoJDE57P9WzfSb8aPuzezp/g4E0dW9Si+KwHojfXctMD+B113gkJyZuOKM0/7b18g1D51/c=
Received: from CH0PR04CA0112.namprd04.prod.outlook.com (2603:10b6:610:75::27)
 by CY5PR12MB9053.namprd12.prod.outlook.com (2603:10b6:930:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 6 Jun
 2024 16:13:23 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::2e) by CH0PR04CA0112.outlook.office365.com
 (2603:10b6:610:75::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:23 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:21 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:12:58 -0500
Subject: [PATCH v4 5/8] hwmon: (k10temp) Define helper function to read CCD
 temp
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-5-ffde21931c3f@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY5PR12MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: e3c0f5d4-4619-45f6-18d8-08dc864396e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWtYZlZldXRmWTFHbnFocVAyNFhRamFjaGVtRlF6LzNydEg4cEN4UWIzWmo4?=
 =?utf-8?B?VW5YS00zbFJOVlE3ZUxxN1RiWWU2NWdndkxmYk8xRjhPanJKbmJxaVBhbFU1?=
 =?utf-8?B?amhOZUloVE1FVGxFL1dOUFhsWDJWUWdkVUc5cm5EaHdFVWwyazcwYjZGa3U0?=
 =?utf-8?B?bitFaXh4V1ovSTgwSjBVSlpEOVZkaDBGdnpEQm9yUUxPL0lURVNNNXdqcnJV?=
 =?utf-8?B?OVFXSHdzKzNRVlZSbkoxc3ZGdFloRFdVY3VUZnRIeUw4UC9NVFloYmxYNGcz?=
 =?utf-8?B?Zmc2Mk1NT3A3eVlRbjMxZm53WFlkdmY2QnMwa2V3LzYrQ0J2b08rMnhpWjJJ?=
 =?utf-8?B?SlRibVQ4T0t6NGtuaVpuamdseEFSSFBqbGZYZHljN1JCNC9oWXlZNW5wVDFM?=
 =?utf-8?B?VThBck45MWhGaGlMSmJGNjY0dUJlK1NNc0U5b1BMWVRUUHhDNjRoWXpSMXpZ?=
 =?utf-8?B?UDFscGtlMVVBVllzNEZyMzRzK1QwSjFHRXdjRzlIWGtMU1p2dis5TEtGalh4?=
 =?utf-8?B?dEpKbjhzNkxUSjhHaWFGNHBlY3krN2ljZlpHSXZGaVJlaXJFQXR0RmpiYXZl?=
 =?utf-8?B?TlhVMkc0ekI1QXFuRTJiR080bG92NkdyQ1FrWXo1M1N4SEJmWXhsSW0zbS9r?=
 =?utf-8?B?dkV1cGdzbU9XQ0NJVEp0dmJXYTdFYTVHUS80ZlJuZTZQclFoek5ZUkl5aTRS?=
 =?utf-8?B?NTFZWEhEejJHV0thNy9GR3VCcDVFU3F5d0V2VndNVndyYUxDaE50akVseUN1?=
 =?utf-8?B?ZlhGVmtTMmRtTGJ5YWlSKzI5NXlLQWF3VGx4cjNDeTI5UXR3TWJUK05tcmNE?=
 =?utf-8?B?a2Z6MFpBcUU3MUxuZDhaV2hhcnNUdkFqQVUvUWgwVS9kY21YdTVadzJ1djdx?=
 =?utf-8?B?VGdsNCszTllNVEttY3VpT05ZM1paNFJTM2JrYkxNbzhObHN2Smd2aFE4aERM?=
 =?utf-8?B?cS9vRy80S0JtaE5xYkNBeFFTd0NFbFlFVHhmVjhXQ0todGUzMCs0MUtvZUdC?=
 =?utf-8?B?clFEKzI2dkZ5RGNzT3NqcVNQOWpyU0MyeXBZNE42Z3pJSmc3Y3pkZHpDY292?=
 =?utf-8?B?U3BOWVFpdTlmV1ZsZXpCRzlUcjZIRkF0Rmlja3pqeUhhR08wWkhTQnlmMW1Q?=
 =?utf-8?B?NU4vY3JKZ0g0ZDhrcDFGVTc4bGp2Y1h4dUxyTkpLM2hVenRxU0VGMEI1ZFBS?=
 =?utf-8?B?MEFqeExTaC8ybHo1V2k3a1diSkRiM0N3NzVoWlllSElKOWU0U3ptNTg0N29x?=
 =?utf-8?B?OVBXU3BheUYzaGlxa1JqYXMrNVNSVW9aWENORHFJYnFBZmhtNzFXU2Fycmhm?=
 =?utf-8?B?NFBiTkd5cGw0RURwN2RCcVBsWURjSTkxbGNpdmdxQm54N2pTZnFhYlQxdmlU?=
 =?utf-8?B?V08rRTc4bElSNzZpT0hlZnZYWmQvVWVCcDBXSW8yemJBTUt0d2dDTTZDYjc1?=
 =?utf-8?B?NDZHNUZybEEyc2JHMGZrQlVSV2ppbEo5Y2JwR21DY3lDQ2JYSndCUXpBOUJH?=
 =?utf-8?B?VmFYcmZQcTJlekNoRjd3anZqWHA0dFhVMmZXc05xYzRqRE9xL1Bvc1dDMzUz?=
 =?utf-8?B?blBIbHI5VTFlcjU0Unh3b3hTZHBVU05YLzZ4NUY2cUpGMUYrc3BXNzBpZ05J?=
 =?utf-8?B?S2xzVGhIeFFRem5NMHRSa0w2V0pWQjBQdGsvVVhsdFlQdXUzVEhxM1FkY3hC?=
 =?utf-8?B?OVJ0blVjdFNVQVpDV0M4QThGeDZVVzNOUm0zSHI5RHM2bmFickllTXZZV3ZG?=
 =?utf-8?B?ZWR1OC84alBDckdPYXYrakZzMUZ1VWFXOEEzN29uSGNMNHl6ZjBsenE2NFFN?=
 =?utf-8?B?N3BHQXI2MXVGYWNKdk12cHgvODM5bnk1TzhVak13SWUwbzMzV2dlNC94c2t3?=
 =?utf-8?B?ZmdsQllHa0d0MTJvSm81YWY0MEdtRDQ2ckIwWWFLd1RoZlE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:23.1357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c0f5d4-4619-45f6-18d8-08dc864396e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9053

The CCD temperature register is read in two places. These reads are done
using an AMD SMN access, and a number of parameters are needed for the
operation.

Move the SMN access and parameter gathering into a helper function in
order to simply the code flow. This also has a benefit of centralizing
the hardware register access in a single place in case fixes or special
decoding is required.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/k10temp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 6cad35e7f182..315c52de6e54 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -158,6 +158,13 @@ static void read_tempreg_nb_zen(struct pci_dev *pdev, u32 *regval)
 		*regval = 0;
 }
 
+static int read_ccd_temp_reg(struct k10temp_data *data, int ccd, u32 *regval)
+{
+	u16 node_id = amd_pci_dev_to_node_id(data->pdev);
+
+	return amd_smn_read(node_id, ZEN_CCD_TEMP(data->ccd_offset, ccd), regval);
+}
+
 static long get_raw_temp(struct k10temp_data *data)
 {
 	u32 regval;
@@ -223,9 +230,7 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
 				*val = 0;
 			break;
 		case 2 ... 13:		/* Tccd{1-12} */
-			ret = amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
-					   ZEN_CCD_TEMP(data->ccd_offset, channel - 2),
-					   &regval);
+			ret = read_ccd_temp_reg(data, channel - 2, &regval);
 
 			if (ret)
 				return ret;
@@ -397,8 +402,7 @@ static void k10temp_get_ccd_support(struct pci_dev *pdev,
 		 * the register value. And this will incorrectly pass the TEMP_VALID
 		 * bit check.
 		 */
-		if (amd_smn_read(amd_pci_dev_to_node_id(pdev),
-				 ZEN_CCD_TEMP(data->ccd_offset, i), &regval))
+		if (read_ccd_temp_reg(data, i, &regval))
 			continue;
 
 		if (regval & ZEN_CCD_TEMP_VALID)

-- 
2.34.1



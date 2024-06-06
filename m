Return-Path: <linux-edac+bounces-1220-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 838D78FF216
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84D7E1C25AED
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383681993B9;
	Thu,  6 Jun 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4IgLUVhq"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE0D19938C;
	Thu,  6 Jun 2024 16:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690407; cv=fail; b=MXZBaEJtSOcpXYRghghdTYAnfQeouINCPrfuPuM1/hxpND/lWinDAwyS6Y68BEweFDw/9oBGMHTHS0Eqf6/NWhopatjQUk6KeTBorZtj9K8XQ7AMiQDcPQp5ulxRLITcPHcrdcOiCGsd7e4VVFNclxXAHIccm1eDUq6mWfOMdp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690407; c=relaxed/simple;
	bh=PMQ6PBDRlaZoSnBPMlsnw249a40yN1TcPjfZBEYP530=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QJSHO4PpEcSku/LdqNkxxzCwyUNBVtB62RN6gIUOXZmxTIAl3V3yr9BNqVudAas8jQWvuZyOK+GcM0ugNwe7OUEIV45e0tLkTF7UEGie2Gnd7+bjM1FilyQ6OCFFnYsgZZhrejJoLvxfT+dnCQ7bpuqiBhdPHhtefRsCUFfFr0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4IgLUVhq; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixswb4gDrWwJYSWLFCeo8LMzAevzMHz6qinFjytjaZaQIV0hcUuEM7+sPoD/OCTI2S5mdSTlE7KlFkuJqpv7SwMZLRYBWi2b6+Xnh9+K6kopCBVFduPQ7cZJ4Ai+IMuA5lznOgvS3EXL0qu9GF7HXUra8XF1hMWk2HX9ncJKBk/u0qNCuCEkayPkTzFZeePg8WJqpLeOX5GilQMIq8A/G+stZNqohB2K9AQ+E5gG5Z2HmY2Xw1F7G2W8Lz5x2NwxJDupjJOiJ5e/uZfZVffOG7aswbqSRGzgr1h4hzqTZrW6sxDSRkCM7Zng4iNdzPQk/7P+fCWiGwJEe2V1o9X5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3avHqH3H9cvY8+8JDGI6G5xgoIKzMDnfcPcP/x6ovs=;
 b=ir3ZeJ2LsdJw4D5968QHwyHqKxoq58HVTWEZOnZdPYB5om7dY6wuy/a4ubarTnakdTW4xtwMT5Qb7MKI5NIOmNDObcqsn0x3C2bR+LMiTfM/1nS4pX4c2Y0oRDynKcTxWVskgdxM30e3fsa7S7ACVH7pywZRFPzIGRTv6O3klBjKVLuQFMSXS+awTyXui5HbOZsRx5PoeKLw9eeYuBuLQ17sUR7p+HW++2TRZ92rUmiA1z7nNxCrfqpCSr9SlDOoYh6T8OqkIABNuIojZkLkUFaD+GBodB9FtIkcge69CqGpZ3m0LnVjcJg+nU2GIjttanLUtUARCDFA6Q+Z/Kzr3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3avHqH3H9cvY8+8JDGI6G5xgoIKzMDnfcPcP/x6ovs=;
 b=4IgLUVhqDm42OBCGJTXPh8du8lhCDZm+PtP18RYSHoCMFIqeWg7Wc9kA862UeBYpPyJRge65PO8IxbR0EHjFFxxO6s0k9PeU4yPHEwsmcprQFMVN+bnplUMoj4FArhabj7N1ZkA0k1XUVhnPI/CpR6kXGvB2+SaxpvlOzCvGOCc=
Received: from CH0PR04CA0096.namprd04.prod.outlook.com (2603:10b6:610:75::11)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Thu, 6 Jun
 2024 16:13:21 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::66) by CH0PR04CA0096.outlook.office365.com
 (2603:10b6:610:75::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.21 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 16:13:21 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 6 Jun
 2024 11:13:20 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 6 Jun 2024 11:12:56 -0500
Subject: [PATCH v4 3/8] hwmon: (k10temp) Check return value of
 amd_smn_read()
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-3-ffde21931c3f@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 08905f71-b40f-4d92-bfc0-08dc86439609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUdWSFpYSXd6U1Ruc3ppUytwQm9lRUNZTW83czZ4emgzVG42anV2cnNuaFQ3?=
 =?utf-8?B?eXBuZDNNdXJTR1dyOVBKc05KKzVtcHZ6eGNJSlIrNUdxRmxFcW9HOXVVNVhN?=
 =?utf-8?B?VFBuK25FdVN4TG9FcXhLVG1TS25xZVdUYTRMeEh3WlZGN1Q1QlhWR0h1RE5G?=
 =?utf-8?B?YnBqUHQxVmcrM3RBb2RrS0dUVVF6Rlc0MllGekhwOFNJcTRzRnVxMytxODF5?=
 =?utf-8?B?T0ZuL0E5all6b2g0N0hSYjQvRjJWeUFsb2M0TjFFQ2JRejhOZE03OFF4S2No?=
 =?utf-8?B?S1hxb0MxL3d2anNnWTRZMVYvcXZBNnZqRThQQXJLWXFLekV5aXM4eEMyamdu?=
 =?utf-8?B?c2F3dkdPOXRndXlXdTlRMXArMWdlZ1V3dmFKbDNsemRjbi90bFJhK3dydVpP?=
 =?utf-8?B?TUtjY3krUFpXS2ExanNLTCtFNlUwOHp1QUw3dDI1Wjh6TmdUMW85cVg1VDF1?=
 =?utf-8?B?RjAyc0o1YzRDc1p2aExiWmxXMytZdTRPY1gwYUEwNkZFV0dTQjZOUU5NYTVS?=
 =?utf-8?B?Q0RwdG93Zy95RTdTcCtQOURKQ05SRXhFT2NUWVQ0WDd1VTJ4UXdreXFmcWt1?=
 =?utf-8?B?UGdON0RsOUduRWx6SHhpUmZ1TDYwSUpDVEJWTkxWRHErc28vVjIvVStpSVVT?=
 =?utf-8?B?anJ3cXFxaG1pNmE3LzJaY3lnaVNoajZCOVUyMUxxVExMRGoxSzAwYnB5dWk4?=
 =?utf-8?B?amVYUTN6b1dOUjhyM29XZ1JEUHRhc3hwR2FLdXRYNlBiMU11V2pkaElOSTMz?=
 =?utf-8?B?UmRJcUtMNm16NWFzVXo1b05IbmVDaVhHR2VzempzWEJIQlQ1cFovN1k5R29Y?=
 =?utf-8?B?cWRob2Rrd3JZTGVraFZlOWNFbExXaTdmS0RpbUEzVGlPaHR5cnRqbEFOUmJx?=
 =?utf-8?B?cEM5c3VQTHpjb29lR0xpSGU4cmZmbEo3K2s4dUhjakdQQWtkSUQvbDM1UG42?=
 =?utf-8?B?RG8xY1V0R1VFbG8wSlFGRFhqT1JnUmhWSzQ2a2ppdkFSejU1N0k5REdvaEQy?=
 =?utf-8?B?YUhMbzZqNG1vcUEvQ0FMbitIcWpocU5xdUc0QXlkWXZYaDZUSms5MnFTcGE4?=
 =?utf-8?B?UGdmNytHNXlzaDlTQlhsb1ZGNkVOVFltK3NOcHRKTjJxcmZ5eDVrSUZaUFd6?=
 =?utf-8?B?a1p1dW9KTTJhZWxOU0M1UXM5OTlYSVFmeVdiZ04xdjgzTUhOL2tuTDJBL2pq?=
 =?utf-8?B?dGtFbVIrcjNZMzJHMEVTV09aSTBFVXdodnQ1NGt1R2RaM09mbDk5amhRRkh4?=
 =?utf-8?B?QkVTeGVJRlgzNkJrdXVuZXBiMm42Z2oxd0tDUzhxY3E4ZVFLWlVBMXVxSTda?=
 =?utf-8?B?dTE0MTlaQ2pvQTc0THA1OEpmN0ErcGp0ZzF2QWpSWWJUMzVYSTdIVWZKNE5o?=
 =?utf-8?B?MmVjYlhyTHgrNzBUNWtFSHJlUnQ5cS8yMFpYc0FsUWppZkRsMFA5OTh0UWRl?=
 =?utf-8?B?K3dqUHhXZzRvQ3p5bUQ5c0VSVHNWS0liMmtyeDFJSlk4U3JZUWRJZms5S1Mz?=
 =?utf-8?B?SG8zNUJNM2R3d0ZaQkpDMEQwOUFqQUZtaThwOXpqS0Zad2RTUWxsS0JkaTlP?=
 =?utf-8?B?eVdaQU5TSHkrOVlCU2F4OWE5TUk0ZDcyN3ZSMEJGODFRM2FrUmJUMTQ4VlJa?=
 =?utf-8?B?SkZoK2NjeVBydVAvdnFuV2x3c3FmajA5TVZyR255blVzZUNVQUU1eXRxZ0VP?=
 =?utf-8?B?emp3YXp4dGVxc2xBLytjdjNOQjRqTy85ZXZPMDFCeWg2eWFjbUlTNDFaM0Qr?=
 =?utf-8?B?NEJqbDZpV3lGS3o2Z2FSYUdxck9YWnNkbnQ4SFZwU1lJdHo3cVVaZzBLeFp2?=
 =?utf-8?B?VzlucTM2bEtwVjhiMGc3Y3IvQVlvM1RQWXFZUEU0b1ovaTR0ZlVnSld0NUhi?=
 =?utf-8?B?MS9QQjBsNHVwdlVidU5DcE84aFVyWklNWm9WeEwybVRpTGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:21.6982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08905f71-b40f-4d92-bfc0-08dc86439609
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467

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



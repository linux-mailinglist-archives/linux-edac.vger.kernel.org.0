Return-Path: <linux-edac+bounces-1104-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89A8CD9E6
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13AF282282
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BD784A41;
	Thu, 23 May 2024 18:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e9bwMbo8"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2ED883CC8;
	Thu, 23 May 2024 18:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488841; cv=fail; b=VowdkMemTZg93FYOOFvid0jn8r5vm+riq5BrZ5REQN2kH1DY0Y+bp05YvPpba0qbdg61wbF1Ni7ARrUoofGIUUatqMg1Lo+nNXFGrb18m4IZvAA1scqm2pkPLXdpQ5mwhLvi9yZ9aaLRFuXVZN3/352/4cu5kjvYKvThHfRePDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488841; c=relaxed/simple;
	bh=wS3+mE2h5wAiqHNbd5F0/aPcPHQiIWNi1aQuBqT3Qf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i9zKitCVnat4xnpcbaJ1/ef3WVYZlfsvW5B+J0ZP7rBDrantQbG5r2pwZak0gXquzNRBHYVEbf0ze+m39a1GiXWaKrdfkx4tJozxyj2GiBtACkoo0FaWH7ZW82+bLoQWqcW6Md5+cYrsn94T18cSLzWJuRxIU3U2LtWBgL5FogM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e9bwMbo8; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cfjno8kNge2FVbgJYiNZNhXiZqpDRvQJPezQ62W76NVnzZYQVDJkdTQ16S4iZjM6Jjf16GjkJvqlabXJinh1FyMVlotIHJJu/OPfwqbfsh9u5UCIDGXrLZYwqfxjbLc3Ohf5u6IiRrP/Uh/2Z2gTmkiZe5zWhcVTtLYPvabjgsf0roU/520qnjKJJduZEdsdC8WnFAaTVNN3vEOUon7qNTLbYVxI+dQa+p9fl/U2WsFyQznbD/8tFHrUgENg3EblhyxJCujhJb6o4okyjq/iXmEk9PbmuwIklb7WEmtWLnxd4DrimYmf7k+Y4dfpXUO350lQpNQaZt+hFPg3pAFpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSVWdwBYxEnXSQDb11DLW1FrriGwziZwr5kWDaJdBUU=;
 b=jj/+7k7go6xrVhHdzhoCtB16C6b241CBx9n9cd7OnnU7FXv98wZDN9kwm6QIY0YL4ccS9FbLe3IC/KEZfF+DH3TTvDU5hE1tdCtQJaZeM2Qm59QQS/HfrC+da7kVihk4fzBeJmP4gAVqCExaQfYpJxY1tKE4jE8eFiLz8bQkwQAXGvLRnJDpf6JjRH4KULCMtT+rTtLtk432gutlZFrHVSy8agMPS0jk42vL/PsHO+nqhjIDSXuXnjbZgJAaRqwH+LNJ+4Tj8Hqo3iH7w8U66vwt9D4/gyGjbQtqddXpi8AqRiu70cF3QGNRiy1ArdOLedtxDIo5ukrZSiBFsvt/LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QSVWdwBYxEnXSQDb11DLW1FrriGwziZwr5kWDaJdBUU=;
 b=e9bwMbo83G8VUAqlpM/7ZPOq4EtbvucpR9M6MWLQdn7Rj0OtMi4cgV9Q313TzTj4JJMVxEQHfPoC+QXCREvYDwrqtfWLvMFsXKGca4ODO3djua3r15fzj+igaWdhlDlPhgd09q9Yp8mDpUvnTFynXpr3msx8IvFEdnyBbcZM29c=
Received: from DS7PR03CA0261.namprd03.prod.outlook.com (2603:10b6:5:3b3::26)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 18:27:15 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::bd) by DS7PR03CA0261.outlook.office365.com
 (2603:10b6:5:3b3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18 via Frontend
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
Date: Thu, 23 May 2024 13:26:56 -0500
Subject: [PATCH v3 5/8] hwmon: (k10temp) Define helper function to read CCD
 temp
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-5-aa44c622de39@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: acf9d69c-106d-4c9e-8ccc-08dc7b55f8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400017|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0ZMYkIxUm5pd0dLYjlGejhBd3RNSlJuckNCRXdLK2FVazdvQ1M1clZLcit3?=
 =?utf-8?B?Y2NkNGhkcWdkWTdPVmt6TS9GbForL1R4WDlCWlorTURWdkhpb2ZJUys3ZmFN?=
 =?utf-8?B?by8rQ05kdUo0RVczYkZib3VxeElGSUhlTnhwNWlRckxHNllPT0N1M3lOWW5S?=
 =?utf-8?B?czRmSkZuUTdxOVEvRGhITU94UERIL0owYkVTQnhCMDN3aHhYcHJsN3pqbWRU?=
 =?utf-8?B?VFRwdk5YQjhNNXRXQi8ySEt2eXpsSWNuVUtRYWszc3pHUC9JaDZINmpjbHdU?=
 =?utf-8?B?bFpRUi9uVFIyMmJkMmZmY2k5SXp0UFRod1U2WFBBTWNJQzM0aER6cUJxTzdT?=
 =?utf-8?B?Ym9YdGNDdUlYeTNwOXo4S0xmajlmaEVZVHppeXlrUWd0N3dkSW5HcXFrbUZk?=
 =?utf-8?B?RmhnNk9JdWhZbkhNNTNvY040LzN0R1lHK1YxUlIva1FDY1M4b2g2bFhmbllZ?=
 =?utf-8?B?VGE3cFF6TWxWMFlCVy9iWU1qT0VaczBOZThRbzVZQUtqVzg0d1hzUmIvYVlN?=
 =?utf-8?B?enN0L1FnbUMwZlFVWTBtRXI4ajEvTjV2ODlZZGlQbklySDMzRmtLRDVFNlI4?=
 =?utf-8?B?V0pZRXhjcFA5SGgzT1oxem9BNEdNNytjQjBNdFpmQmhqdWFPR0FRWVNnSmxy?=
 =?utf-8?B?amVOV3NUNHBrOEprcTFvTjBIamJHN1ZZbUxXWTJ5eFdkVUVSUmJMeVRKYmdp?=
 =?utf-8?B?N1EwMXQrVlhQVGRHdzQ5L1hCRzdKRnM2eWdPUXBuUjhqN0d3dm52TERTSlRT?=
 =?utf-8?B?K2V2Zi9NL0RxUitLL3hmRXJyUEFrVW80ZWpKbnhDU0ZWSEdkd2FRR0JIdGhF?=
 =?utf-8?B?azUyMU5FTUN6UnhkZEJ4SHFlT0NBZ2dZNjB0dnRuOTU4Qk9Ddk1mSUhnQ2ha?=
 =?utf-8?B?dHdrRGxVUUl6UTNBNzBWYmxialBoUk95WURvelVYNFlGQjhzamV4MFlnckRI?=
 =?utf-8?B?SkcxcExNajdsVmF6MmEvUytBbGExRXBvN2VkdUFNVGpZZDlqZGRLQitud0N6?=
 =?utf-8?B?UjF6WDM5RWVuWUlXRmg4NGlPTm9uMkh6YWJ3OFZwaHBVai9BSURIaHRJS3Vh?=
 =?utf-8?B?QjhBUlFKMFltdnZqVEc0NFFKa2pnQVlxbS96OHdHZHY5dnYrU0VqNEJyaDQx?=
 =?utf-8?B?M09IZldRVHkyQU1DMnhIRiszVVNzbk0zRlJDMlRNVEhOVEZGTDY3N2g4Zlo0?=
 =?utf-8?B?N3JWMmhCRVBJSGN1VWxQditqMGxFT0NGbEVKTXJtNDIwRVBtVDlCaW9xUGZS?=
 =?utf-8?B?WjVXU0JJenRvRG9Sd0Q1bzhENWM2bjMvZ21TOVMvdy9aZzFKR3loWWNDQUhP?=
 =?utf-8?B?TUhXM2ZMbDh2WUcxdHUvUjBKNnlCeE14WlBBQUhISDYwRmZqRmFFdmF5bUZJ?=
 =?utf-8?B?QTBTVXBCTWJUdXBCenZpdnVVeGMzM0QvSHRIdzd1algwYVp0Uk1tMWc1Rkl2?=
 =?utf-8?B?WWdnK0UyOTVjNDVlMjd0Q3JOY05IRjI2WjBUVWhublZ2U010V2ZidFErbEZr?=
 =?utf-8?B?SVQvbUhweFZUZWc3U2N2K0tXVExRSnNFNnBtY2tmZHJQc0dIM2tYY3pvRCtB?=
 =?utf-8?B?VUh6aDFZUUVOQlNWa3huaFRUdlVaZFdTQUFuZVNzMjZrek9KWTdUbDQ5Z1B4?=
 =?utf-8?B?ZVpMSWNBYXdvWFFFRldwVVZVU3JhRXF0RUgwbllTVVlRVzdReGpGY3lXdTcr?=
 =?utf-8?B?c1R6U052bGkyRkY2NUpoN0ZkY0pvTW5IeU9MVTJMRGtkbWtIa2JMdDVpL3hD?=
 =?utf-8?B?NGZlWlBqRE5mbWVQY3NrZkx6MGxtUjJnNkFvYlBzL3pjb3o5cTlGeDFIc0Zv?=
 =?utf-8?Q?7OHReZC3wxOztzTf+koXJmBZIAi3AG9Zn0vkE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:15.3833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf9d69c-106d-4c9e-8ccc-08dc7b55f8af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

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



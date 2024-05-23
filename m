Return-Path: <linux-edac+bounces-1106-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B898CD9EB
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36A51F225B4
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C284D1C;
	Thu, 23 May 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z0V4//K0"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A3C84A24;
	Thu, 23 May 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488843; cv=fail; b=tRxNUiqEv+jpIReKjVL+CAIbYr8d1XLqjKCVGL/gJrSfQF50ppZV1HNoxl/woJKBrdgzAyrvBUsNC2q1oLC2oLUEpb/raxE7lCs8zl70BVFuyOsjIhzYQm+I4/V4qlBlIhPiCVqX3XHz9M9EFNlv0c8FOq2uv6Shj8nD1/pkbZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488843; c=relaxed/simple;
	bh=oB2R3j2lKRv63IrZ0oiRycPwUr7KbwNgetf4mRprZh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=IYlwrJ7qQc+X2hckNYnwW2rxfOG/8Q88Dg9E+2B2ZTQ6IDdlpKyw+g4StQ7ByZ6A3FsDlD08mx9KX0Gdhcp8vipE5fobF2M6rs8hx/4mzzoRV9gYiJmdeYkmXtCppSNJtWoN2so1Kri42iG4FiTSt0wIgHaTrY7ZOLZf4O39umo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z0V4//K0; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbytXOeqYVKcatYuMdTXpNPqL0jQobD3899IWUJMuKauaknkAiNQlo0Pdusn2MRNEqClsE3MSkUadX/Ev8m3ra3R1xuAOGwuti8XFysC9Fj5f2Z7UtOJpY1DfpMN3tTwzr76Aqb/vuX8WX5zdd2nQ3qMqiNuRoi9bYgzQxtjGy1NVToM5KO/LOumXydi2St2ENOIA5Hc8sY27NoGGRxEeS3SDEHtiAvcLSRllRM4dcvo4BMz/UxgpbtJfjNkWBxzxjoXFq8TDSzxYSOVk0TcSDgODagPDSDss9BbhiT4Q76YlHxsZZO3IHJVgnWWxUfyG9RP+omR3GcD4kP9SJvE6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sryX850tuSnxY6ts/Md6DOVM3hP9hrrQWRIrYnq0jvI=;
 b=Af/zDAkTUqwQm6QBwX7kHlQ4+Fm9fu8yJrcjFSKR8lAmE61a64H+7d9SSdRlaOJ79hZQ74BKpTTcZSDd2n23NVvUQ5T8sPpL6PDia0cRhQgYoAw9AJKtnNFKJGRo8U+wcWmyzsVEMjfCvU26ea4oPSENZwKEiFx+ZcG/Gh8tvXyIAy5FrDenl5FMyx1SFnowVBsb7c3cVZwQ34Jhz87HHlqEbK3cW8WKIl2s6lvIb36xjvPenDkokmZUXqiXRYCVKRqcDUbf2RohAkMReQPoNtzykedu/AN8jOgC03OOGh9DbYBWpY6T3xOAEhebcEBFg1sZgKxf0TYb4pIZB6ysvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sryX850tuSnxY6ts/Md6DOVM3hP9hrrQWRIrYnq0jvI=;
 b=z0V4//K0pznn7DoSzOCS3e7vqyWElp7Sv6Jf5lPgwKFrgm9xDojzZUrlu+FTc67RlDjdM8nnKhTtk9sx7zbn39y0JTAf9PJU2iyUlCiz6M6oaeiKzPtueZ/3Ve3vC9W+8saKUy+QOxU3Oo5ErHZHV1jgoWzp8TES9SqdT1BC/8I=
Received: from DS7PR03CA0260.namprd03.prod.outlook.com (2603:10b6:5:3b3::25)
 by SJ2PR12MB8181.namprd12.prod.outlook.com (2603:10b6:a03:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 18:27:17 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3b3:cafe::36) by DS7PR03CA0260.outlook.office365.com
 (2603:10b6:5:3b3::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34 via Frontend
 Transport; Thu, 23 May 2024 18:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:16 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:59 -0500
Subject: [PATCH v3 8/8] hwmon: (k10temp) Rename _data variable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-8-aa44c622de39@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SJ2PR12MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 262bff4c-fc4a-4c9e-20f6-08dc7b55f986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400017|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3ZEWFdib3dFUlRVcWFlTUZvNHRwdmZ4WmVQNWwrTGdYckduU0Vxc053NWhs?=
 =?utf-8?B?SlV0U2VnZlZRdFpxdXQxSE1EdHdMT3lBamdZS3ViZFB6M2NJWE9YdE5rbHJ3?=
 =?utf-8?B?eVI4UzhKdjZzbm1DRGErbHNncFdXQytHdG8zVDlDVXliTWhZd25VV1RZc1hN?=
 =?utf-8?B?SkRlOGY1OE8ydDlIRWNWU0VCd1prMG5VQzZxclhqNGdCQTlQcW9TTTJFakM0?=
 =?utf-8?B?VDc1VkhWbEhGYmlHak9Nb2ZtQ1l3VEFKeUV2cVoyRXdyejZFTm0vblF0R2s5?=
 =?utf-8?B?eGJ1S2tQZ1NVTkFGWnEzcExFOEx2THdQZmVqd3p1VTNRU2tQdFNRVDBrUE5V?=
 =?utf-8?B?NHNMY2EvOE1vMGV4dlhRc2oyYWR4MnV0OEF0TUVTcFhPM3lMMWUyTnZyU1Rk?=
 =?utf-8?B?dHZzaDRHdTEyUmxkeG1BejhNR0lrSXpBb1l2eHRKQWJGWmRDbklwZXR3YW5V?=
 =?utf-8?B?K0hDSy9DZ2ttYzVhQXp6RHpNUnZvekVBdlg3TnhsTCtrdTd0aEIvUk9RZVNm?=
 =?utf-8?B?RklzZnNIbit2c0ZsOVkvU0Zlb1p3a2RTcUw4WjUwOWhqdFNOZ2JzS244NWp4?=
 =?utf-8?B?dzlmaFVIamNwR3JEL2oza0FqREoxbEs2RlM5ZkRONzJsZ0RIM3g0NXB1SEli?=
 =?utf-8?B?d2VEUUF3emE0eFVRSUVEejhMN0V4QzFaTkZ4RlZzMmY2OXJtbmxscHRSNGVj?=
 =?utf-8?B?U0NZYWwycHRETDMrYy9XZlhiZ1l5bmlhVjYxWk5ZeGhnc3dWdWJMenJXYnZr?=
 =?utf-8?B?a2lJMU5OT0w0Q3JFdUZkaVJpdnFXMnZHN1Z2Sk1WVGZrcytmUWdEQ1pGNGJw?=
 =?utf-8?B?d0xSRGIrMWlHWmVWMTAwSXRoQ0U2OU54a3pEbm5JcUFoRHlncDdKRHdkUW9O?=
 =?utf-8?B?c244d0c0eE41QVVhZmhvdE8yenl5MHJuWkJYTk1VQzZlbEJOMEtURzFJbFNV?=
 =?utf-8?B?S2xYL1g1TUZRNUx1VWhuQ2UwTlRsaXNMN2YvMlNrRnRENndSM0VwbStaRDhW?=
 =?utf-8?B?VkZweXB0RGVBbXRySnRCbkpPMXRySVRKWkMzQmpvcFpVL1JMblVTNTNncWJM?=
 =?utf-8?B?cGhWNUxHNE5oczN5SVdCWW1LU3RSTERUZjUrOTl3a2lMeTlTZHpzN2M5VFlH?=
 =?utf-8?B?RWZSaEVFWHpSWUd3T1FOVkdqYURCbzRPSGlwTW9jTHRXemFsOGM1Lzl4Uzgx?=
 =?utf-8?B?a2lyTXFNcDRlSWdEZENKUjZOM0VCK3JBa0hjMEJLMzcrR2FZOThockdWcmJ2?=
 =?utf-8?B?L09sODlPWFkrYmpNVUovZjhMK0JocEJ5WWVIR3JPNy9OWGlRUytGL2xaSWk1?=
 =?utf-8?B?Vlp1cnd4SU5SbDlab1A4cVpwNW9lVktVMm9rMWVxdTM1RXZESS9nS2dBQmtw?=
 =?utf-8?B?OUh3SDhCWkp2aGFXYXBSZmE5STVsKzhmaml1M2J4MHJZeHVBeHF6ZENLQUo1?=
 =?utf-8?B?WVh4YjlCNlZxMDU3TXBvYzI0SFpVMGFmTFlPRWl5bG9RdHQrc3ltU1l2SWZB?=
 =?utf-8?B?RUVMWGdpQlFnRUZkZkdqcStkT1M1Zzk1QmZRelZYL2hwWGw1ejlDQjNua1dl?=
 =?utf-8?B?M0hwUzRIUENzR0lIMmRYNzRNU2ZJcys4UW1CaTVxeUg2ODRwbTZqdExLQ1Nl?=
 =?utf-8?B?aHFaZ1cwaFkxUEM5bC8vaU9NczJwWk95UW1DUVJDZE53REpodUFxRFd4bEs0?=
 =?utf-8?B?K3dwMFVaOWlrdDR6SEtXN29iMlZvY0hQWXYwWHpDWjk3aWJjWmNIZDRIU2NZ?=
 =?utf-8?B?QnRpNDRjQkVMcHIxTWd3clFlK2oxTndrVUd2MElSL1ZFOVBEL1ZjZHplK1k1?=
 =?utf-8?B?eURacG5GSGV6TGlrdEZRN0dPR2dxRnlINERlaW9DL2hqNlhKVTVrQzVLUFFv?=
 =?utf-8?Q?J4dgQHV+Tt2oA?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:16.7896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262bff4c-fc4a-4c9e-20f6-08dc7b55f986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8181

...to address the following warning:

drivers/hwmon/k10temp.c:273:47:
warning: declaration shadows a variable in the global scope [-Wshadow]
static umode_t k10temp_is_visible(const void *_data,
                                              ^
include/asm-generic/sections.h:36:13:
note: previous declaration is here
extern char _data[], _sdata[], _edata[];

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/hwmon/k10temp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index a2d203304533..543526bac042 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -269,11 +269,11 @@ static int k10temp_read(struct device *dev, enum hwmon_sensor_types type,
 	}
 }
 
-static umode_t k10temp_is_visible(const void *_data,
+static umode_t k10temp_is_visible(const void *drvdata,
 				  enum hwmon_sensor_types type,
 				  u32 attr, int channel)
 {
-	const struct k10temp_data *data = _data;
+	const struct k10temp_data *data = drvdata;
 	struct pci_dev *pdev = data->pdev;
 	u32 reg;
 

-- 
2.34.1



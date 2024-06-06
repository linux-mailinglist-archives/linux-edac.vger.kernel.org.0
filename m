Return-Path: <linux-edac+bounces-1225-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C166A8FF232
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 18:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A38C1F213E0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Jun 2024 16:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8337199EAA;
	Thu,  6 Jun 2024 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XhNjxgb5"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002219CCF4;
	Thu,  6 Jun 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717690415; cv=fail; b=KVMGbmBCkYQ81QfjA26sJbKhDu8o58AIdlotCfDEiH/gXx+/F/hRE4gX3vYUi0CjLU87REJ3pyLaRbYyoWfI2Pb58IdlKglJLoNWkH7WGFG8SS/x1wShWkhWAMkWK8AVVZqETetq0keq/kB6Hk0nW1mRPjrjGlhgRqGi7rdtIzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717690415; c=relaxed/simple;
	bh=1skJ/7VJ1g2JtxqhkVli2UyaJ7oCXqXoF/P+u1FuNqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Q1jrs6XFn++T3GZ/POgWWo/Th4uDVJp0sO4XvKTzjzGt7Apz2B3YeRSo2fqt27O34AfLSB/AJSvY2Xdsre7+hqWua4CXhaLrdC6J87fZF/sR60wQZdjL3NVpXeVQ69d1NOyTMbd8S7pOJy6xI24i8pQMtiZavV3M8krdaxVlQYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XhNjxgb5; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgtVhK4IWNTFh7qnraElEebZSN3gUOCVTjELqF7TWqmvC9zHnSC8ogKcmsEdWgMj9ldduq8wH1xCpdy2EFBEsrFBcIJXXNd/pkesQTim8r1PWQGKfjEFvKFHT8CJY9fdi9oZy4MUnUa2mPCEXjiGjpUwvtgFrOfDVb8xncHRS8Ezy9sNgh7W5ft7HmpyXzXtOBWgRvEMaciFO+PUdO6MCKENZ1P0dSkYMcbB1za6rbi1lSE0xl3AnAQuv8XPKcTxrQKqQ2WbChOqeX0PQKELkcxjNz2YWhJgQeVH/aGB3VMV/L5QZUcnNsLWzjSkUXaxvRQrMDD3VHcEci+fiV+TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UE47HnUxvTJjZSnzAEg9NHiMXdh7F1Vo3vF5L9ZH1NA=;
 b=Mh+yOSqj99Xws/jBf6Wzkht7ZTGACQ0GNlncMSXHH4UtTlQgSAPgCEDUjjEgjue8SsOQWaDq9u+W6ONGeKKg03YOSDqJulP3H2Iop91TaJ71MlS3ucc2swAmFGqRxYKZM5XWh4IlEVedbfA7S5rVuBWJE6aqAOMuPozfRrv4oNcZ2h54FXogKnxRf2G853pShkqNoXrVAEdhwOdH8OQjQUQDb9erJ92RGInOc8aOb7kawfqoY5iwtIBQ+NrWSh12s0fzRbnHmpaDBZtPtGpt/8sgEbKsqXLvB1Pb0auJksWsThEI2TyfFIwRQ9PzK8J4Dc8l7WaGGSf7EzE3IR0xgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UE47HnUxvTJjZSnzAEg9NHiMXdh7F1Vo3vF5L9ZH1NA=;
 b=XhNjxgb5YWQFYptXTbQUa6EIaA4W83ZI85e2Uy6NAa0SLJuc3m8haa24VQ07mLagZdvQ49O66RE8vyy8UGb1g3Ogp8LZjuJCbuRNCyNA1UvZzDRM8lEDJdzUr7t1SkppRuXh53/nFJrEcAlCod6fOCNPLbSefoZWN0dFTfLoEGE=
Received: from CH0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:610:75::12)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Thu, 6 Jun
 2024 16:13:29 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::ec) by CH0PR04CA0097.outlook.office365.com
 (2603:10b6:610:75::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.20 via Frontend
 Transport; Thu, 6 Jun 2024 16:13:29 +0000
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
Date: Thu, 6 Jun 2024 11:13:01 -0500
Subject: [PATCH v4 8/8] hwmon: (k10temp) Rename _data variable
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-fix-smn-bad-read-v4-8-ffde21931c3f@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c365862-689b-4bf6-a3a2-08dc86439a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGNaM21WM1hvc1ZrL2hnQ2syQ3FIMTJBdXV6UmVWWEJUN0lYalhLMDhaYnpk?=
 =?utf-8?B?ZEdzYkdOd2thaDJPamw3MkhoZjFYVlJza3RSc1F5TThZcWtjbyt4RCtHaThV?=
 =?utf-8?B?WTRVdHBGUXNlQzBQV3ZYanlSZytnNDZvY0J3U2pTMDZmSEpRV0hSRXhTekZz?=
 =?utf-8?B?WnE5NytRTEFmd3JaUm5zUEk4RnJVTjVQMlROTkZzVU9kYVZsUVRMTDdGUU1X?=
 =?utf-8?B?dnlicnU3Y2luMk55UGJTanZ5bVRRNURmWkdjdmFBRVR2VUliM3A5S2YzUDFO?=
 =?utf-8?B?UE9NUXdwZUErcjB0N3RFVTc5ZWV1R0pqNUdjSkJFa3JkcENVOVJUMjEvaVJz?=
 =?utf-8?B?bHZ0ejViSXhTL25YRmR1TGRPSldoNTZ5cFhZMklXREcxL3VRSkhGdm5kL3Br?=
 =?utf-8?B?ZnY0cXh5SFl6SWRoTlF1Tlo0NmxweFJEbGcyY0RERy9TMVZ4b2RnTHJrQ25Q?=
 =?utf-8?B?VnV3OW82blpPYVBiekxudStCNE5ML3kzQVV2Y1UrRGVEMjgxbmNjZGZZSTNt?=
 =?utf-8?B?NVhnSDFiQWU2Umduazd3NzFQYno1NjV0Q0VlRUhDcTVReXdmZlN1eXZCZWZi?=
 =?utf-8?B?TTZnbDIvNmRrZG5aTGxSRVpSNGErOGpRRTNneXE4enlqSjdDZEZVclBwS1pv?=
 =?utf-8?B?MkhmU3BFUjd5VW05d0tyVkJQNy9OZWF4VUVPWFA4dlE4VG9DK0tCSnRRbEZh?=
 =?utf-8?B?azA4Q1NIbDc2NnNTVUxKMitFZjY4aktzVXNuQVpWaTY2NUNoZURwWlVyVE9a?=
 =?utf-8?B?MmtKRXhnQUdUb3QxdkpHNm1IZGUzRWFDMGlTaU5VYkxjRUU0SE9vT2RCc3lH?=
 =?utf-8?B?b3ZEMTBuYW8xaUpTeTRPN05ZV1lFNENxQTdvS1JBTXlmblJMa0ZCanUvSkRi?=
 =?utf-8?B?Y2IvK3VreWJWekJtYVFhaG1PTEZma1VqdUZ4REI3REEvRUZtL3ltaXZzUzRl?=
 =?utf-8?B?WTFVQTA1eGVaRGJpUFU2R1NpNzN4WmFNZ25wbjJxejVPN3R2L29TMUp6ZUJO?=
 =?utf-8?B?ZzhCQ0lWa3hiVGN1OXZHOC9nOG9DREZackg1SmdXbmg5a25SbGdGcGc5OWRr?=
 =?utf-8?B?aU1MU05DbWY3Q0QrU24xUEhtbFJ2ZGRiOEFjdXo4WGh4TElna3phNktiSkgz?=
 =?utf-8?B?b1ZCejB4QytZalgxMXhPSHF6R2hUVCt4SXMrUm80Z0hzWi9pL2NVSk05cEs5?=
 =?utf-8?B?ejcySjFpTUtkem0vZUxtMG5xcEZ2R1JqUjdJbjFuWDZ4TXd1bTJjQ0ZIVnFl?=
 =?utf-8?B?aEtKa1lhbTU5QlJRc2EwUlI2bVZNU1VkNnlwVUkrWUFJdmJ3ckpmeDc5SjVw?=
 =?utf-8?B?WmxkemUzdmVHVzJHamQ2QjRZWGFPcFRzYkUzQk1qeWUxdVM3VDhtZ09McDJV?=
 =?utf-8?B?eFRhekxxWjhpUXJZRmp0UHRQdXgzcmhvem5aY2RYMDUrSlV2aGgyV3hkaTVo?=
 =?utf-8?B?ZElmM0RJWlM2Q09JcXQyemJ6aGJFYmIrMUNGSjFLY09pMVZjSHdJL0pwc3Z3?=
 =?utf-8?B?QjgzYXQzK3hjUVdjV2dRVmNYN3hUNEVIRU1oQUl1eE9NaFZHV2lIdEVnUXZa?=
 =?utf-8?B?RG53c0oxNlFyOFh6dWhKREFsVUZJT20xY0NVSjJQeFBGTWVkdFlBblNNMVhl?=
 =?utf-8?B?bS9KSExaS1pQcFNrYzdITzVWZ25EQzEzLzNGUnhqbnE5ZW9BQ3QvckpWRzRY?=
 =?utf-8?B?a0hISFFwQ0RHa3p4SU90SWZSajd3dkVMTGVIc2xSdUhYVTVzaVVJY0NSekJu?=
 =?utf-8?B?WmFzVTJPSVdnMFJuNmZKdnNyM3ZEeUNZZHNnS296ajdRN3gyckdrL3RmdEhD?=
 =?utf-8?B?a2xPcTl0V29zaCs3Uk9RYTFoN2xhazZVVUhMdDdkb3V5MklyRyttNDQwMXd5?=
 =?utf-8?B?ZmtUQ3hreG5OUnc1dVNZNFZDbFNYRlRaYzl4VzFRNzlScmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 16:13:28.9483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c365862-689b-4bf6-a3a2-08dc86439a59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

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
Acked-by: Guenter Roeck <linux@roeck-us.net>
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



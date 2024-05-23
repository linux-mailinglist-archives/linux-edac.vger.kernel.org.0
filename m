Return-Path: <linux-edac+bounces-1103-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6098CD9E1
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 20:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5397C2821CC
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2024 18:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044F883CD7;
	Thu, 23 May 2024 18:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vn5EbSLO"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB583A06;
	Thu, 23 May 2024 18:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716488839; cv=fail; b=QH+dyKyGQlvAXQxgL/PACplGwTQwugoA2MWgSyRwLaYkN9egC9Xe+e51560GvGUiho/ZGNwMTucvzMpMcu2fOJgT16gT16Pr8+Rj4fhk1E11mDOCUqVTw8r8P7Q5BgtULXu2U0GAriw+AOmwnQ+cTomJI89E4BJ4zqppf+KuNA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716488839; c=relaxed/simple;
	bh=OiKP1+GNYSbg1+OE5L0dnBHK6al0w4Wqt/Oqdqnncso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i1haJ1Apxg43qHPn5wetTrw8xJaHl4jADVLyV8X6hwIrySnCNWlcmZX+cHCbvGVytg8of/bbzv7w1cvGBzf9CpPb3IYy0iFzy2n0x+Hgcy22nKDVZV06f3l/TrIURM7KN9DP+zzSN84564tzEPyJCfT7W5GOKP/3vKr2jPJJlRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vn5EbSLO; arc=fail smtp.client-ip=40.107.223.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVDpAj+NptLVDss+qy4RcPjliy6eAYWy9DLRY1KpG4yiJfyB5YyaZO1d3w3JKAW1kd5AQLmQeSkLYvrcZEgNt6oZbdlDW47elZFrsPRCYM9YhUyLvyYe5g4F5fuELKpa/KTyFbqYtCXN8cCZ0S/W/rxZ2qpBQPRLBPuS00fzoj0d4mso1NcKAhe0/VpQMjWtVkUAmbQqubt7aMCKTMvTkda30NTdSrB8mC5KPga0Q+MoVNMuulk/6hCS8oGGna2WKZbX7Z4xKnSUlS/oCAkwzJVr0Gk8gvh0f+ZgjvKyvIW9KJfpzM070rMM0GI5cWWMAGsL2bcFfgZkRMCMZA+aPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J9+2SDlidu/RlDKIHhb76jZjeYkl9ua0Ft+dX8dBC8=;
 b=aL2jXBUHUEiUwTAOCEXS5iijWYCMZF7G1vHWrWJ3MhzRvp63DQ826gc7BzwPnwIB1eksixyJmcSP7nQLOupIpa8jEon21oe5cz7qKrmMRdlSdv+89ozj281jFlj5Ml4JQc/cR2UWjyj59LOOy3Scxj3W9UFrGH7QxkWidsArowuFWqSTepvvqIXDd4yw+SM4UtFWXmXzR28xSIqIPQojt7wh5xjIwkidzcK6att7w29hqPJswYvBQS6zeD74cwUQbEwRQhPBfLVXreo3qFTpxgOuekGJdw4k7+AnXtAaV7DjOEfDB6UofSaV/SkVFAV2ZusaFSjIaky+63KAp0Ol/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J9+2SDlidu/RlDKIHhb76jZjeYkl9ua0Ft+dX8dBC8=;
 b=Vn5EbSLOBvFs1msWIWqu7HXNpIcYk7sbfKl2wEfQXEdDKP21jWvtwNMPlCGuQ7dulj2weSYERGvJYRlvBvjIbdBmYoF00e5AlQwSlkatCeRkNbVkqjSMRyt+vjdYBaqWYC2ssQ2zSf/2HQhcnEnJd2gWyjFtBQniKHFJsCGUExw=
Received: from CH2PR19CA0025.namprd19.prod.outlook.com (2603:10b6:610:4d::35)
 by DM4PR12MB6231.namprd12.prod.outlook.com (2603:10b6:8:a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.18; Thu, 23 May
 2024 18:27:16 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:4d:cafe::50) by CH2PR19CA0025.outlook.office365.com
 (2603:10b6:610:4d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20 via Frontend
 Transport; Thu, 23 May 2024 18:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.0 via Frontend Transport; Thu, 23 May 2024 18:27:15 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 23 May
 2024 13:27:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 23 May 2024 13:26:58 -0500
Subject: [PATCH v3 7/8] hwmon: (k10temp) Remove unused HAVE_TDIE() macro
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240523-fix-smn-bad-read-v3-7-aa44c622de39@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|DM4PR12MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 0596a4e2-43a2-42b4-fc28-08dc7b55f8f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U2xsTVBuaHVGRlE5aUlIMytlVFRuM3Q1QUd0eXE1TG5BbTh2dVM0dnVYQUlZ?=
 =?utf-8?B?Y09IQmRzVkRlc2Q3SjlObFBoMlh0bVJtZ1hheEhNRzlsZGVoYzhuSmxnWERC?=
 =?utf-8?B?U1A3Z0tVQyt5M0tVNGI0YWo2MENLNEJReVhMNkNtVTBPMFBxSXFVS28xRFd3?=
 =?utf-8?B?MkhxUlNJZ05MaVFxeUpDRTJYR01jZjdXd0RyaTRIaFFSbkdQbmFLc3RvUDF4?=
 =?utf-8?B?VjF0cVNZdVNOUGZOK092b01jZ1VuVlNvU0hZaVZRVEVkcGRPN1RxUkdLN1J1?=
 =?utf-8?B?SXBUM0xZZFhaaExPdDFVU0JmK1pLTTR2bnlVOE9teTFudXlQQUdGSEpqRkZu?=
 =?utf-8?B?VEl3YTlGQS9pZEUyVHNEY3ZGZGVYL0hKZGh0UUI3c1BhMkJJZkU0enZiS0VM?=
 =?utf-8?B?Qnh4Q1UvUWp6U0lGdlRUOVFSaUVXV1k0VWZLQlFIdkM0SFNTV3VYai93YWhY?=
 =?utf-8?B?eHpOd1ZEQUhNUTJKYkRhS21JR05LVHZBa2xTbU4zWXRpZlhsaGpFY29leVBS?=
 =?utf-8?B?RSttRmh3ZW9aeE1jNGpwUlpmZlpJWVp6OEZnMEdUNHhpZGF2V3p2QzVOd2lx?=
 =?utf-8?B?QXkyZ1c0a0w2VCsyWHA4V1JSUWZCZm1tK0FGVVNWRHRNQW04RmRsMDFqUktK?=
 =?utf-8?B?MERkaDl5cVlHUDdQbGRDRERIcmNnN3l1QVFCbVlYR2EwZU1ZUkl5c0YrUUIz?=
 =?utf-8?B?TzY5ZDltb3A4U1l0MFpWM09RVWl2WW85OEp1UWk3YTlta2pod0NuUWwyQzZM?=
 =?utf-8?B?Nk5UWjVxdk45RHkwakxmZG1mZlRYT25LM0VnOE1RbVAvN3hkNjZaekJ4SE00?=
 =?utf-8?B?MStQR1pSTDJTVmJaRUlzdHdsczNHRmxIRWpZSE50WXNWZm4vYnlpdUhIaGFm?=
 =?utf-8?B?Q3Nybi9FNW93aVNaWjdKVTU4U3o2d2doN3J6akVJN290cDZqL1RMazN6RUtB?=
 =?utf-8?B?OU9GSDNjOXlGbHphNk5qZkd5M24wNDZEeVZuaThYZGxZZGoxVHhnUlZsS1lT?=
 =?utf-8?B?TU5CelBPQm1qUjlwRHF2am9lOUdpM0Z3V3ZFUGRqYWYxOThhMGdrSnBKdXhG?=
 =?utf-8?B?bXFCRVhDclgwUlBvcnBTMWQwcmF4cCtEZ29hODFrYUVzS0M3SnoxVGt4aUhM?=
 =?utf-8?B?Tm5US1hFYmlXQStaUTM0bElyL2xmNXNQSlMyNitKNk8rZ2hmdzg3OUlCa1Zv?=
 =?utf-8?B?YUxnVHpIMEtaUWM0L1pjMGMwSEtEQVhZcjdDRjlVWlAzWk5lMXRFNlhNU3VQ?=
 =?utf-8?B?blovYnVYZlIwNDlqTUxSUkt6TjNIWXJkVUsrSUdSdWJTUXcwR08zcGRWSnN4?=
 =?utf-8?B?dnFybUUrenZ2VThJNDJDU1hMaUhxekdiZzg1ZWZZbC9PLzB0Nm53N2VCSWdr?=
 =?utf-8?B?azI3UllpdXMrbkk1TWRFQzVmMXVwSkI2c1VSMkFJcG5xZ2s2cmNIL3BITEs2?=
 =?utf-8?B?OEJaTlMzYXhKbGFjRGF2VW5sSWRTMjJrZjVzV3ZBRXdXTzVLWk8xTjJ0YjRp?=
 =?utf-8?B?d3A4SjBDalBMeXlqdnRoY3ZWbFFDb3Y0SWFaSFM5ckVoWGN6TjdOcGdXZVdJ?=
 =?utf-8?B?cy93MTIycnJhMmhQQXV1dGZLa1d5Y1Q3SjdOVTgzSmxSbS9kd0VEWWxRdGM4?=
 =?utf-8?B?bUhweGxnSy9NWnF1bEhFN2tCdUNpVGk3bmh0L2JMR3dHd0dPM1RodjFobXNH?=
 =?utf-8?B?UVZRNnIySXRpWE15a3RtcWJiZWJmcDQvQU9vSWxSZ2lLNzFHL0xFZjFaSFMv?=
 =?utf-8?B?NWFURGhGMVdWYURRazFoM3ByenRIQUZWcS9pQ2tQZEZwZTdnZjRkVmZTYTFS?=
 =?utf-8?B?d0ZML1pKbXJKWEJVVU9lZXVaYzkvNHA5eFNCcjlIZWlzSVpoaXRwSkxtdXlw?=
 =?utf-8?Q?w3hU0zw3ON9SU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:27:15.8253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0596a4e2-43a2-42b4-fc28-08dc7b55f8f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6231

...to address the following warning:

drivers/hwmon/k10temp.c:104:9:
warning: macro is not used [-Wunused-macros]

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
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



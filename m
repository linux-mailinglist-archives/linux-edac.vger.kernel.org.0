Return-Path: <linux-edac+bounces-3057-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B32E1A34ABD
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631D21896753
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03828A2BE;
	Thu, 13 Feb 2025 16:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="INbTrgbb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2357E28A2A5;
	Thu, 13 Feb 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465190; cv=fail; b=gtC/QI1QyTX9ntwrmtL9XJAkkzTJ/rwnLut/gV0g5RNKWnrT3ohbgeRzvFZIqU/Ac+IA44b3D6H0jpOvjl/C/8WkmIEcDuZqWKH6LYaac1r7hNSlAlPlpuPjHAf40uonOLLw8kK5VnspOfomguczzY6amCstnaWkWPvKZ7qQWG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465190; c=relaxed/simple;
	bh=pN7In7TvK/oDeNDHEbPpXd8fWzex+57Cmb474FXLAwE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Tz4LXnlQww3AwPmeGkZ9pq+doJZP3XurWk/NU9hw1FDNEV0HmeTq5YZYqVPkEHb7gamKBuBdWbCEXiX+3lUKlRScvfo7QKVGbqKmMuT/jL1/GDujT1e2D2vxKE19GPa4GFyQ4k1b1FQWC1lFeDkqjJ/IqWOey8PsleuV86sHS+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=INbTrgbb; arc=fail smtp.client-ip=40.107.244.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1hEdx+Ldx+DHrNHVDcHJqb/L3VsZv5/XQHC9xELBcaIXPsv+8cidSo+F8ubyHNSH0QR1w9xXTSanqLVsitxaidvnryq5A4FwK4yZ3qkUjDTjTbvLU7Tv1BPEdauG/2+9clGqbSsrKHLp/OIH9VHLtk+05VYowGtZd8HWRvYJPAkvqOLBHjUpG7ONF0nbOh+rNafH/uZ1Bf6Zepj8a7yQ1iuf7clyDOh8DX6u0QWID3bV5rElpKGipvl3sKANXgfYko5wXRnbReRXRr29Sjq1oDJX1DaIc83nDBYFbqZAgER1sLF68OquNiwl/ER6q1hoIH/6YGLMr2VwHWfUWEGXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usB9/ZYCkzsHjK4qJEt1FqoNAgdM/ku3NN2pctYP6v4=;
 b=eTLS7vbj+bC+B+QYegQqxoduv+WnGUqplDcCUV6y9PwZZ4QS52+/dRF/5z/iWml+RIpEzL64jfYS2D/mv6YzA3Tk+miQESj5qXulx29xqV+Tf7XGa/E+gynNJPD086z+RTiJJxD7Vw9UgBifw7uEvN7vTn4ge06PKYxaQMeY16DF9CL71bSO0k5YcRPDraYJ/33Mx270n/KECpDZTa1DdNuoUOy1EeI9LqJ97i4Q9slgdKp/ZfDQl34TztMiVI11CZJIiGOUZCaQr0/2DhGOGhSnSH+KyTVM40qA0Our3Nk6XkS8Y3Tt9om1lj4CFCxksp6V1ylTvLac3ArYTwwBlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usB9/ZYCkzsHjK4qJEt1FqoNAgdM/ku3NN2pctYP6v4=;
 b=INbTrgbbmKnLaEYlHyfDnXtPeikVR3+0vsbV9stO8xt3AgOb4eY2LRD+a3pZKlas7Lb6C5iQ0TL5Xww2Z89aQBhpZJOAiJbsTUUqvgFvFmAGDA2ABDVl3fuBwcsIpMQYOMfop9vqLQydpBBQmRslJNPZ/Fm2h85IMbnyWPlD7ic=
Received: from DM6PR11CA0003.namprd11.prod.outlook.com (2603:10b6:5:190::16)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:46:24 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::60) by DM6PR11CA0003.outlook.office365.com
 (2603:10b6:5:190::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Thu,
 13 Feb 2025 16:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:23 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 13 Feb 2025 16:45:50 +0000
Subject: [PATCH v2 01/16] x86/mce: Don't remove sysfs if thresholding sysfs
 init fails
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250213-wip-mca-updates-v2-1-3636547fe05f@amd.com>
References: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
In-Reply-To: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: fd2c02d2-c16a-425e-9742-08dd4c4df3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blFqTmNEbmwzZ2crVjkzdURDYkN5TkQwY0s4NGdPU3pGbkV3Rzk5Q3ZMRHJY?=
 =?utf-8?B?TlFNbXZWc1pkZmhOa2ZzSk53K1BnLzJzMmZmSEdEZGltalJ0YmRReFRtcTND?=
 =?utf-8?B?MXRxQ1RPWkpLc0VLd2tGZFl4bmI3c0RoRmtTbkVMaGZ1V3Q0Z2RENmF0enRh?=
 =?utf-8?B?L1RvSXdDeEIvdmRkWnBBRmlSckxxZWI3U3hPRzJ6VnVQM1psdWRac1Mzbk94?=
 =?utf-8?B?K0NtY2Q2WFM4WXpPbGFNODBiRG9xQmRSdVEydlpiQlozN213QUhoMkhFN0R1?=
 =?utf-8?B?aFdCV05uRFZpVmpNZjFKV2pQUkY5b3Ruck5uUS9qZlNJSXNyQ3Y1TEVrSGdC?=
 =?utf-8?B?Skl5STZya3lFeEl4NXIvNXJ6VitzdnVhQzBvdDdYNmp6OHZVajF0UTV2di9D?=
 =?utf-8?B?NVFZcDNyTGxLbDNqNk1rb0VNSm5XT0tudDh3bUdhbzlaa3JrZkRQQlYxaHJU?=
 =?utf-8?B?NjhSYzZZYWg5ZEk1eHZCR3pxeTN6MG50VWNOM2hLc0ozNytwQjlVVSt5WTAz?=
 =?utf-8?B?SVR3SlJoSmdxSkhsbnRHTk5PYlBjK3NHeExMRDhxSlpxOG9RUkJKSkhzNXJl?=
 =?utf-8?B?Z2ZLUDFUZE4vSHRVMGpWUlZNTDMvS1Jkb2lOdjZtUzNza05BMGd5S296NUtC?=
 =?utf-8?B?MUpSdnNZZ2twbHBPNWJ3cDNCdWgyUXN5eWkxK3NjOFAwS2FzVW5GVlU4cllB?=
 =?utf-8?B?RkxQSTZZV0U3QmtwODFqN2VPczdyditnYWF0OW4zMzR0SFlhZXpPd0htaC9z?=
 =?utf-8?B?NUo1RzAzcS9ERUNkelIyUWVNQjVaNkh5Q0lkcUUyclNxcmd0djhKRkg4YWFO?=
 =?utf-8?B?T0NSZjJnamlNSyt1NEcvUzcwV0FnaUpCOHQyV2V5RzA5VGRjUFBWYzFLRVlB?=
 =?utf-8?B?SGtqdG91Z2dNSWZITFYwczdDVHRQSVlONXR1QmJhNTJnUWZSTzQ4MUNKeXR4?=
 =?utf-8?B?aXVSL29YM0Z1anRvVDFlb1ZoeElVRkZzS1VVS1BJR1VDS1VDTnZraVIrNHkx?=
 =?utf-8?B?L3JDMlhQY1B2QTU5cmxjVExDWjBoZlNwQTVCbVBaR0wxSzJkN293SWw5WkdB?=
 =?utf-8?B?bnJTQlN4MzllRFhtaXFUWmRKUWpVb1ZlWnV1Mll2dGRTUHBobld0blJ1RDBF?=
 =?utf-8?B?UDQxbExNVFNmU1R4d09HWm1kWnRWbFJxeWxncHVBcytabjNIR1A5Q1pFSVJC?=
 =?utf-8?B?a2E3WlNmaE8zREJwSjBKWit6YWVWeklTSG9oQTQwSlFHeCtPMVVlZHIyMFlJ?=
 =?utf-8?B?My94Z3B0cXhleHdnblhBUXhiZFI5cDhaWDNTdDhlY2FON3A1NTF0Z1pHdm1u?=
 =?utf-8?B?SVdCZmthcW40U0Z4MTBmYldEQVYxaW5CN1NmZzg5Qm1zZHFkTDhHaDNzQUd0?=
 =?utf-8?B?M2dKNDRSdTg4NktDZlM0T2lNMXFHTlhMQXlKMFpZK2plN2ZaMENtTncrUU5p?=
 =?utf-8?B?V3JkVlZGRnprUm5MWFZuWUlmS0FleVdkTCtjNTFqaEI1ZWxHaGJvUzJIVVlr?=
 =?utf-8?B?UitKbnh2WU1wWGZTV3NSUU5rQUtGeER4aEo1L3hZNE1PMUxTbkpLdGc5RURF?=
 =?utf-8?B?TkNBQzA5bFhvZHBMRkkyYTN6R0c2Z3dvcVNJOXIvdm5SOE84NHpneFNMTkNj?=
 =?utf-8?B?bXMrS2dGemNxTE1VNkVDbE5GbUR3NUdZc2RZOHA5WDQ0MGI2Mi9SOWFQbmN3?=
 =?utf-8?B?ZGhtYUN3QWlCb0JCL0prOER0OUR6MURuc1BGa3E0N3E5NExuTlBhanQwVy9Q?=
 =?utf-8?B?ZkgrZE0wUXIwTjBtdjZDVkJ6VytwMEVwaHg5bFdETG9GTTkzVUFYcDEya0l3?=
 =?utf-8?B?cWNsYnNaSzVVdHlpbGZvUzlKaHpkRm1XNVFiQUREaVZ1M25ndjVFRCtqZSti?=
 =?utf-8?B?aDljZldBUnVaZXlPdlN1Q2llbXZodENWbm81Sm4wR0VFczY4dVd5MnNqZUky?=
 =?utf-8?B?OHJ4MGNNQm1FaFlVUnhQVERoSXlLUEhzTkY0UWhyeEtzZ0ozUE5WNWtTd2xn?=
 =?utf-8?Q?8kNcg4Aiw6bj0eOa8GsEHBn8mnta2I=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:24.1848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd2c02d2-c16a-425e-9742-08dd4c4df3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

Currently, the MCE subsystem sysfs interface will be removed if the
thresholding sysfs interface fails to be created. A common failure is
due to new MCA bank types that are not recognized and don't have a short
name set.

The MCA thresholding feature is optional and should not break the common
MCE sysfs interface. Also, new MCA bank types are occasionally
introduced, and updates will be needed to recognize them. But likewise,
this should not break the common sysfs interface.

Keep the MCE sysfs interface regardless of the status of the
thresholding sysfs interface.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---

Notes:
    v1->v2:
    * New in v2.
    * Included stable tag but there's no specific commit for Fixes.

 arch/x86/kernel/cpu/mce/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0dc00c9894c7..d39af20154c7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2801,15 +2801,9 @@ static int mce_cpu_dead(unsigned int cpu)
 static int mce_cpu_online(unsigned int cpu)
 {
 	struct timer_list *t = this_cpu_ptr(&mce_timer);
-	int ret;
 
 	mce_device_create(cpu);
-
-	ret = mce_threshold_create_device(cpu);
-	if (ret) {
-		mce_device_remove(cpu);
-		return ret;
-	}
+	mce_threshold_create_device(cpu);
 	mce_reenable_cpu();
 	mce_start_timer(t);
 	return 0;

-- 
2.43.0



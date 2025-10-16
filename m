Return-Path: <linux-edac+bounces-5067-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1410EBE49D7
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB62A1A67661
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D5132AAD8;
	Thu, 16 Oct 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z19BZhxG"
X-Original-To: linux-edac@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B3132AAAD;
	Thu, 16 Oct 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632687; cv=fail; b=DdzJv4C+Y8PvTzllhbiqZFbve8zGRBg4qan9xWdt5dufX/q9HDxT7tCFkD11Uj8fDJGMEMIAlEWM3Koh/M3uZznkBrgPqhOLvoL8HJxvprvbkogKWKjUxZtzOOxrrnvxi0zm8Lc3uf9EE428+qKlTf65YQmIhh1+WHLgFsOcpUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632687; c=relaxed/simple;
	bh=R34cqNHE4rX7qCZrPiN7gBocI06kV11GF2HTnXu3g1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=i+hMFqBtTwtQJdMnPBX4e8/ssOuODCxl9yS7WwHjMIb7Ylsb19jKbddUdQW41aM/DgfwzZ/TWdpwXYskDPXjkWBAdnFOXgizO23SvvmgBsTE3R5ker3qZXOSv7AyuT76CWjHNsuL6ceZm4ZgiSOOWoPT5yh5DGhf15KoaLvsxaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z19BZhxG; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=av2tVzqxXMbvI3pbY+0aBn5SMUjzC9DfbsDIxe8S8cLNDYYfJNKn8onKcDbRGZUGsVnSQCiTNNJtB0fYelIIKe8R6hU7yCcgRz8lAxG8KJppoZse0EYv/EO56bW3UqmdDjV8EK1lPC3XyqdUY4AQRFtb3SM0coXvBFL83iBvGzCyATJxBK2jnEXfYc1a6oOzEukw8T4zUqNyHh2Lf7VeEccPiF0xm9M4wAgEHp1mxC3nhMOXDrkT2Gv/+/dFQEgN/YtILYGtzJuXvrAUne1ubuS6xOwHw0trszxH6agnSWkAS+9G0GNd/7R+GoGsm1CQgaHved3R0cFIjNnyONUjTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOCovX8z27LQrNRB50CFyp4ikHrxwkG0y+AK1Y9BV30=;
 b=NfgXbKnPFP5xgf12RFx44E8wU2DOIM3tc4iTj6BB6yw8XpEpMHjsQz8BwNSY2tk+9QTOB2c8zvKOPgFq6y1R0TFcrXE1Cd8ZceS1Y89xz6ZjUD/JfINSoLEK8V7ViXPBL6cSzHkoTLZ2HwbESKoTL93uWwWBLnscfXbqEs+6fjvE975qzxS0WXLz8weFXyC0fl424o9keeaYifVgVTRzJtt3TaYqOvqbaPx/Wv/0n12LzNThIPyBITJlcRhMmMj3QK4pC7XcBNm9e1FAEInqy7LL6EBzXwYlX5d6xuFUH6qpkkli7Hzt+7S3j0lcb0/6taYNvWEu0TFQFZeGt6PTOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EOCovX8z27LQrNRB50CFyp4ikHrxwkG0y+AK1Y9BV30=;
 b=z19BZhxGrXonZO6HEY9crSfY26xPuo+fwwb9gD2QJ3w+mhQPbjTLNOJa18D303pADSaSnf4WZvKjB/fB5A7puIrLfRQlv1FFPEWC5K3z1wBqY57kjsPoOY4hQjLUvqPxtmWnMG1eiGyODrZAd+CnkM2LTjYZ/M+u+3Mj/VOnrng=
Received: from BL1PR13CA0138.namprd13.prod.outlook.com (2603:10b6:208:2bb::23)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 16:38:03 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::86) by BL1PR13CA0138.outlook.office365.com
 (2603:10b6:208:2bb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.5 via Frontend Transport; Thu,
 16 Oct 2025 16:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:38:02 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:38:01 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Thu, 16 Oct 2025 16:37:49 +0000
Subject: [PATCH v7 4/8] x86/mce/amd: Support SMCA Corrected Error Interrupt
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251016-wip-mca-updates-v7-4-5c139a4062cb@amd.com>
References: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
In-Reply-To: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|LV2PR12MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 84ab72cb-034a-4584-9258-08de0cd2603b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUJXbXhhdExCMXFxQ2ZuQXJXVWNSVFlrTXJ3eExOaFR4enRVOXRtZ05kOVhU?=
 =?utf-8?B?VzRjS1pCSmVMYWJwWXExRmtIK01RRS8zaklLMW5rR25neCtLbENJZnFqUGdN?=
 =?utf-8?B?d2paVWNxbE1xTXhMaXVFT3pRck1SeGRhcWJRRXk4KzlBUXRHY21meDZVYkht?=
 =?utf-8?B?WGZpYzJsZTdCVFVYRndXK1dpbXF1YU01WWtCSW9nZ2pNWkNXVW5HVlF3a1RJ?=
 =?utf-8?B?alI0dUxJd3QyUmVEbUwySW9nYVJ6MjhtVkpablRFVEZSUFU4STdEdkNZNEtz?=
 =?utf-8?B?ak1wWmFuQUNBZTRVbGt0eGNLUEFKejBsV2hWaExubG5pRWYrS04rZzFOV2l1?=
 =?utf-8?B?ejJCNFcvS0FUczJ4SDVRTGpuZlFQRWNPd2l3bjAzZkpZVU1RZi9ZZDRHOHNT?=
 =?utf-8?B?VnR6UzFsRzlPd0tKNkIrb2dEOGUwME55a2lUTkJ6WllQbFhHUStMb3NwdTlm?=
 =?utf-8?B?dXUzK1EwTnBGVTZHWTBjM2JNN1pxcXpLZVlHZ09iMzUzdm9zK0NRWGpxeFNk?=
 =?utf-8?B?RnNvRk14SDI4cU56V29ZYVVPNG9LZUJyU09tU0ZtY2dwNVZpSW43Y1Iyay9B?=
 =?utf-8?B?azVYNkVLUHpwY0dTWFhVenVUcFBSU2hDc1ZVMEJqRk9yS09MNkw3Njhub2ZK?=
 =?utf-8?B?amlkVUtsZUxjdW1LKzFMVi92Uis0VDAzeGVTS3pGTFhsd0ZpUWthK1d0M0Ji?=
 =?utf-8?B?bGNpV0dodHhIbExjQVJ3VGd5RVVVQi9rMnFEN1Y0K1h3Um1jdFRmMDJNQXVY?=
 =?utf-8?B?blhqaXJwczVXbzhnall6V1lmaDNoYmlhWHIzUGk0dTJZaFJwVnZzb0dKT1dx?=
 =?utf-8?B?Undmcy9hei9XMzlScTZLWkdwcGhKN29Za0NWNUhnajJ5VmNORUlkcXQzaUIz?=
 =?utf-8?B?Vm0vd3M1c2tXUlA3TjMxVVA5eTFjczM4VUZQMFE5R0wzS3FZT1NPbm4ybHRt?=
 =?utf-8?B?TkhKc2FZdlk4Q2kwaDcxN1ZCdVppeCtNR1NlOXBOaU5nYnFqaWRjQ29VZDc0?=
 =?utf-8?B?ZFRLNlZxV2IwZmJoeGd0aE02TzVleXJJU0VIOUl0YmpsQjkvVFJRTVZGbDNY?=
 =?utf-8?B?S09yVFFPYnN0TXp5a0NGVDlVZGhLYkcxNnUxZmtYbURBZE5PeWlZVFhDNWpu?=
 =?utf-8?B?Ulg2TzlSTDJCQWdoWW9pWmZxcW5KdmhPVlRkUU9LNGRGZkpiMVVRL1MzU3A5?=
 =?utf-8?B?eE81RWFUNmFlSTU5cHA3eSt4dC9SQUFsdFBJNmdOT0ltN1NkUk9XWCtVQmlF?=
 =?utf-8?B?cTNqZmtwTjlmSkVEbm9ndG91TDArOEdOV09YS3BqMTRXUnRGYktGY1BFMUZj?=
 =?utf-8?B?R240SmNZOXhTeFFYdFBzaXNtazEveWlPWjg3T2xVMVdaNmZGeGpwbzhjUzRL?=
 =?utf-8?B?UkE5MDNSWE5IRjZrbHBjMWtUS2VwZlEwZTc5Mld4VUVubGlLSjNhTWQvamRE?=
 =?utf-8?B?V21icDVCQXZGMEx4aCtJWnB2UHQrM3B5d2UyY3JnUzBKTWlPSzgyb1lYeG8y?=
 =?utf-8?B?VnMwRTdycGYzMVhLS2JKK0J2SzhmMEpkQ0hqMmloeTN0MGd2dXh2b0oyeUhK?=
 =?utf-8?B?MVFrdG8wQTcvUmR5YW43cjh4YkJxOGlEa2JCNHNIcmlWbzVEZng3UWlxQjh2?=
 =?utf-8?B?Sk04eDV2NnpBL2t6TWRIalRhU3pPUXAvTDNyYTdwNUd6bzZiNHR4dUNFZUtP?=
 =?utf-8?B?T1ZmVkJrd2tiMEd0OGJoZ1lBVU1xcEVDZU8wS2QybjEwL1JQNXB3c1hFdnBy?=
 =?utf-8?B?V0RMOGZVMVR2Wi8vRmxZU3JBTk9JMjErRXo5L3NkQnVaUTRBTjFFa2FrT1Z5?=
 =?utf-8?B?emR6QkdTVDU5aDR3TFRLZE00ZU1wdG1rdFZZcFo3YVh3alNMYkJOb2pLenBq?=
 =?utf-8?B?by9OYVlPbnkxQ2szMmp4ekx6UTk0ZzI3d3JFbGt0VEtGT0ZsVjU1cWFQR2F2?=
 =?utf-8?B?WXJZOThXcHRqazY5ZkNZV3RSNmIvZFlKUmIreFFIdWI4c2h4N2ZwaGQ4K2Mv?=
 =?utf-8?B?T09MemFLMnFobERPZnF4K3hPdTUrK2prcFRNYVh3dTRyWjZER2pNTmFkTXND?=
 =?utf-8?B?VW1zU2FPSkloQzNMMUw1ZWtVVXFtVjErU1UwT3dnK0lHaTVQaVRPRU4wS3hx?=
 =?utf-8?Q?lAbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:38:02.9942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ab72cb-034a-4584-9258-08de0cd2603b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821

AMD systems optionally support MCA thresholding which provides the
ability for hardware to send an interrupt when a set error threshold is
reached. This feature counts errors of all severities, but it is
commonly used to report correctable errors with an interrupt rather than
polling.

Scalable MCA systems allow the Platform to take control of this feature.
In this case, the OS will not see the feature configuration and control
bits in the MCA_MISC* registers. The OS will not receive the MCA
thresholding interrupt, and it will need to poll for correctable errors.

A "corrected error interrupt" will be available on Scalable MCA systems.
This will be used in the same configuration where the Platform controls
MCA thresholding. However, the Platform will now be able to send the
MCA thresholding interrupt to the OS.

Check for, and enable, this feature during per-CPU SMCA init.

Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250908-wip-mca-updates-v6-11-eef5d6c74b9c@amd.com
    
    v6->v7:
    * No change.
    
    v5->v6:
    * No change.
    
    v4->v5:
    * No change.
    
    v3->v4:
    * Add code comment describing bits.
    
    v2->v3:
    * Add tags from Tony.
    
    v1->v2:
    * Use new per-CPU struct.

 arch/x86/kernel/cpu/mce/amd.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 3bbf2ecf71b6..91af769b9d8a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -308,6 +308,23 @@ static void smca_configure(unsigned int bank, unsigned int cpu)
 			high |= BIT(5);
 		}
 
+		/*
+		 * SMCA Corrected Error Interrupt
+		 *
+		 * MCA_CONFIG[IntPresent] is bit 10, and tells us if the bank can
+		 * send an MCA Thresholding interrupt without the OS initializing
+		 * this feature. This can be used if the threshold limit is managed
+		 * by the platform.
+		 *
+		 * MCA_CONFIG[IntEn] is bit 40 (8 in the high portion of the MSR).
+		 * The OS should set this to inform the platform that the OS is ready
+		 * to handle the MCA Thresholding interrupt.
+		 */
+		if ((low & BIT(10)) && data->thr_intr_en) {
+			__set_bit(bank, data->thr_intr_banks);
+			high |= BIT(8);
+		}
+
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(low & BIT(8));
 
 		wrmsr(smca_config, low, high);

-- 
2.51.0



Return-Path: <linux-edac+bounces-3545-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67547A8A1FE
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E577A98E5
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66C529B791;
	Tue, 15 Apr 2025 14:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FoFIMjlE"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202FE29B765;
	Tue, 15 Apr 2025 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728919; cv=fail; b=oqNOetPci6koqrGAu8fFNS3XfIe0EZ68FasxO85xETwAmXOkYI6datwCgPNdBbAYVQ6BtsTtWAXqTKr1Qu25CT9Wzz3hxErbO7oAqLAx+/7D/yf796QpLufi5O6xyDp/5ERC+tyaOP3LlhMNCLbUkaiKU5BcsFaCwc1zAMUSEJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728919; c=relaxed/simple;
	bh=j7lNttzvTCNvdfTfxO/YmM0R1v7ho4KYxoJcx9N57uo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B/f16BVJNEQ231guMW3+6FJLeerFdyun0rmBKO3REpPIvpoemaQ+H8WWZYjHYIn1mn+NDOHKzVv/Hj/MEvEfGNw7NXiNZXTNwJzgMlVbfF7YibKiwMFK/MEdVRY9QYv4WAQOZ6tqs0qbweaDOrQOx5RZskGupDLbpw0NiNFijxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FoFIMjlE; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ru5nd6/YHWys3R0omlRO7fLz3887/xEmyqEXxwEj8H7z0tJlYVv0i8DBCl4I2HgKX6Yb9bVZHp+Wg8jmdO7vbN6GgfTAFOQMRcTff+oJ9m9pZ5/UuCj+W6aQx9QY8Gfa2+5MGQSK1QXKNFP0B7j7vH1GTemDAY29WM/ikNe1TabJWJyThnvzNSarg2eypCJBSM4nYIY0MQpvIyaeJpSWx/Px5gL1ZwB84uVB5Qdch5o448aT3KiHdKb3rLL/U8qrs+dtTAz39QIM0gjyaNQ2ngtS56Lw8JoovLk7MRPcsx9mF7TwlB2Y48OM6LIe+tObMWckikgjK15etkxIIHNlPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KdztnGvl/dPo2HocxG0NIliBlcZ7PoaPwuRUc/V1/A=;
 b=aUHre3JekSze+6oVTSAt2B2ctZyYCTTKzVnkSN4KXik2a73qN96tw70ltw5gmGrzST5RDJn4trbHFU7WEGPcUW9/dcQfIhSlXYeCbYukjkhRSlIxTZezYnmZgRWj9rGk/fs9LYsALK2cvPEB7sUuAVrbFGntdalLvEx1VmuM5UQ9dPWxop5s4yhULEfJKjbO5Yf7XRsWkBH502iOLhrf0SiQcHxU0QCwwBkcNb3lU4c/xIyICYf8kCAdvBTp4x/GbeG6g0HhoZEHZXZ7PWT0SgJ0mYOC4bqa1eOfqxNobskKZ1J0wvg0qZicRDhsELCjoL3QVM/M9XVqnd7CObwX5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KdztnGvl/dPo2HocxG0NIliBlcZ7PoaPwuRUc/V1/A=;
 b=FoFIMjlEbZQdsZxRnaHMyhLoyAnXbwi/x8lbGwp1n5Ur7Lv7ZBipSES+qYk7fFpALTlsvZaYZHAm4A7nxA1TOR4lfpLDxVBdwfh+Zy0R1bERZ2CxfGGRdQxL0lFHl+GyGX+XPuQYCA57DUE71UolucSG3UtLORwiHhRYQ2GX0W8=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 14:55:12 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::64) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 14:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:12 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Tue, 15 Apr 2025 14:54:56 +0000
Subject: [PATCH v3 01/17] x86/mce: Don't remove sysfs if thresholding sysfs
 init fails
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250415-wip-mca-updates-v3-1-8ffd9eb4aa56@amd.com>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
In-Reply-To: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a3c66b-8448-41cc-7866-08dd7c2d8642
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTRmV3lVaWhXbDE3WG5YdjBHVitQNTc1dktqTFNMMjA1VmVnS0U3WVlxc3lt?=
 =?utf-8?B?aXJHL1FOeTc5b1kxNGVkS2tKVnAzaTR6ekcyV2pGOHBXZ2EwWVNUcmxEeUJh?=
 =?utf-8?B?Ymt6UGNBNHFEWmViR3VValI3clE5K0YrdllLcmxaRm9MVUpzeWFhS1FiYU44?=
 =?utf-8?B?UUY4YldheXNiN05pT21pSTVUbVlhTlRZLzAxUzdmdDREYUR5VURKRWc2OSt6?=
 =?utf-8?B?clJObGkrbkdMVEM3SmVQNDFhTWl2dlZobm8veTdhZUh2eitjdkh4ZG9IQmRs?=
 =?utf-8?B?ak04dGRmUktRakswUDUwdWI0Z1JncHJHUGRYaEg3YmFzR29MVEZrODM5WW1q?=
 =?utf-8?B?cDBtYWZ3SmNvRVBGbXhYd3VPRFkrMitwMlVBdVlVSXg0UTZtQklRU1NrdHFy?=
 =?utf-8?B?WWxsdmFCNVBObWIzMjdaSU5CQndnOVl1bkJZRUpvSHRvQmtRV0NoMUc3RWhS?=
 =?utf-8?B?blcwR1pjWnlQMmw1RnYzb0U4dTdoQXUwajB0YkZQNVFLcXZSNGtyUmFpU05E?=
 =?utf-8?B?eXhROENVR3g0dzlsdnVLeVJqVmEvMjdQRlBiR0QrTXdwdlFLOHdnMUNBemlI?=
 =?utf-8?B?bWliWkRPRmpZdEJkM2drdzFkNy85WWJHekF6RkZLZWdEbVF5MVQ2RjFiUTBF?=
 =?utf-8?B?VXpkd3lwckRhUVpEUkRzbFlML2lkbTFzeXFYcGhlZEgyZkRpdkFWUlFHamtO?=
 =?utf-8?B?STlqOEJldTZhK3VKRUZ2K1VmSEZCOW9pWTkwTnJDNzBCejQ3ZllZMnZ6cFNk?=
 =?utf-8?B?UlJ2UklIWkpSVldGdlRCQkF3VG1LQkhmN25vandQWXFuRTV3MDFHQVp0N2NY?=
 =?utf-8?B?OEo5NFZTMW1sM1NHV1pVamRVR1QrL0MxcHlKdzlyUUw5WW5oZVpPejU0T3Bu?=
 =?utf-8?B?Y0xHYWNzWVhTa2Ivdzk1czduVmc4aDhpTGlpY2JRSFBBSklnOWQzVnhpUU0v?=
 =?utf-8?B?cEt3YVVYR3luWEFmcHJTRmZCeGZMang3ZmhnNHVUSCtOTDR2MkRsZzQ1eWM3?=
 =?utf-8?B?ZWRBMVVGZFZHbUxYRlh1eEc2cmVWc1pjR0VCZFh0bnlrWnB6L3ZsdDBuMndl?=
 =?utf-8?B?WmlobXY5WllZdC91T0R4a2lrME9neGc0TXU4V3NiVXlFa2JxazROMDdhdGY1?=
 =?utf-8?B?S1JuS1pmSUYyeUhXZEpVNGNkRzBnWHJjbmE3d0NZdjQ2ckJuRmZaQ3NBa2Nv?=
 =?utf-8?B?aGsyU2FleFE2ZEhMaVhVOXpFaEt6WnN2MXY1VXAyYW55RWJEYzhxYUhsakhR?=
 =?utf-8?B?cGxsSUh0bHBGS0p4OXViL0FzK3ZYUW90d2gxQzN6Y21FdjBGdk5aUDNiaTRl?=
 =?utf-8?B?V0U0SEplaCtWSlhBdGpDM1hjelVpYXlqRk8vNE9pa2hQMFN2MFZFRlR0bWdI?=
 =?utf-8?B?Z2xnck05STZPcWptNHVzM29wSkRoeWQ3R3VPdnRyNkxCbDhqZmVSdUgzMWl2?=
 =?utf-8?B?WkYzRXB4UGFPUkZkaStBcmgzZkpNRWJYcEkwNDZLSHdJOThBL25Pa1liZHRH?=
 =?utf-8?B?S2VKcG5YYmhmQlRwdVY3ajcwdXJlOEhnUjBqTENnZmRna1liUU9tbytTRVEx?=
 =?utf-8?B?Z3NIQVlkWjhIYzJYOTVZeUszeFZhTXVoNEcrNHhkblcyUzdxYjh2NWxzNDZ6?=
 =?utf-8?B?SGQycG5uRHlkNUFsQUVpS3kwS3EvRFlTZWtNeFhlT2F5a08wM3AwZU04L3d5?=
 =?utf-8?B?Q3BrNC9CQUQ3RldlMzloREp2MndLTW5HakZjeEp3RlZCR3Zvc0gwWHNYVEtI?=
 =?utf-8?B?ckJBTU9XY1QvRTByakZTSnM1TW1acjEvRElDL3NOcE05OWMrRytWQktTUlZv?=
 =?utf-8?B?N3NhckxraEluUDBmeE5xSzNZQmdtTTZZS1lQVzc3amJKczFGcko0cldIY0NC?=
 =?utf-8?B?YWFzRnFncXlUbEVXbFpaQ1dzZjJNVjZPdGhQVzBkWjErdzNtczJHSFpnOWFH?=
 =?utf-8?B?bnhXQmhSQy9KYmlwTFRTSFNrYnhEeFNaUGEzNzZDQWpySjlRSE93UGtCUktV?=
 =?utf-8?B?UzhnOFJHakdjcGRLQXpXSkU3ejFGenZsTXVvRGl0RCtuQW5EU3ZtcDNpdlZI?=
 =?utf-8?B?OWtlc2JHL2oyMUg0RWRpY3pMYlFuVVlkb1ZxZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:12.3729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a3c66b-8448-41cc-7866-08dd7c2d8642
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276

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

Cc: stable@vger.kernel.org
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lore.kernel.org/r/20250213-wip-mca-updates-v2-1-3636547fe05f@amd.com
    
    v2->v3:
    * Added tags from Qiuxu and Tony.
    
    v1->v2:
    * New in v2.
    * Included stable tag but there's no specific commit for Fixes.

 arch/x86/kernel/cpu/mce/core.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 255927f0284e..72c2aa0809c0 100644
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
2.49.0



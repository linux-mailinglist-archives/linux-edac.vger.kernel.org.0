Return-Path: <linux-edac+bounces-3056-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1705A34B1B
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 18:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A553BF173
	for <lists+linux-edac@lfdr.de>; Thu, 13 Feb 2025 16:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464BE28A2AF;
	Thu, 13 Feb 2025 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WtFSQynL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813F928A2A0;
	Thu, 13 Feb 2025 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739465189; cv=fail; b=AnIl9xhoa3zYTLkF1FilpealQrZ522MC3CKDgkPsNWW3cQ+0ec6M79roYtp2/VjE0X6nhdKhyRXG+fpTbUBodVftdc93Vi4gD8OIo631PlaSuCT0dXepE2RWbj9u8IeihtijYaNkPdg1GG9beiqEZJliatQIlJNExfiWnGup4OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739465189; c=relaxed/simple;
	bh=/wjJafgwDKj82kTSCesv3NTHmlwBXEtycwkmcUkLWus=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=nYoebhqDY3QLrlOcaUHzEw8Ywyh8T7c/b+ri3kfqh+35/k5GN7KmEUE+2dx9TXiqQMl6mrB7YRzfxCm4dPe/NSjDJnqNgns69BGPxk7MY/8EWfyaOViWRrc8qglDOyIfl146mOy12OUc+7VG4GjzZ4K8X6c93vCE7tDAUp776PM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WtFSQynL; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFY+V7HvcFrYnCojkc0uGW87lxPKP2oKsX/zUvLlOrSpFrXn2NNhEXfcBPRbXygxTbwUjRvmmLTRywAROuYaTxGHZAyEuRVRPinDseSjU8sdlphKZuBqJcY9uU2l0k1u74UJz4svvvtvQAWhQ7avWCQ3Lm2NlpCJS69pkIUALqc7bAoPtkxVrfiTgbVgtsHiMlkC/c7ULRxohrOeLy6UdIpDEoId7zopgJJVhEuidakR6lcDbJNCFrfviuxtdXTf8apEa6f5QQ7Xje2HweKLJB7nuQ2Ul51BVM3NK0NNZ3k9IxY5rTcTwfFtVC4mr2brdaMh31SVXNEAep+vDmrOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+FfGNfDhZaD/W9JuVJlgXDBoYCp3dMuRvD6bmAcwbw=;
 b=Tn+yf076jgCkk1bOKCG4vrAdhxPjYXRt4hJQmFfl6xlBCrH8Axi5RpeHbljJgIC7IKlSUGdYTRnDFj5odN8IyhzblYvV1lBrF2/o1cEangOqP//U6Cm0X6AZ3v1rdnjdxjkCj+haMwd74n5v8t1Q4SY+fNh5akz0gB2WSbwdVdIrctSb1qMcG/WiSyfuPgu0OFSoWzJE7WoCx1GxZ0gC8YaJZutJUclS4AHjy8FyW8ca9yH1PBAga49gtr+7V+SFhcrQxCze8KzQiPFnnQlVMAxNr1tYfJeT+mMgJIgSrngEBt9zTBlFG/1bzpsjzIoulib8uyWA8Hv5BtkNb/EqKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+FfGNfDhZaD/W9JuVJlgXDBoYCp3dMuRvD6bmAcwbw=;
 b=WtFSQynLRJNMtZrI18eMrDczD2W4VkX3aIeS6mI47V35cfXOHPPebVyrLbPKKw0zGlLSj0zn7JmVe9qCAMUzMan3mfMS4JE3L38gfsJOlGBKTGLMvjn87y5CiFqa+XEqbHwmswDJNFRwt7N2Ux13/rpL/d53T0KMt0LZNopHXok=
Received: from DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 16:46:23 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::e1) by DM6PR11CA0012.outlook.office365.com
 (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.13 via Frontend Transport; Thu,
 13 Feb 2025 16:46:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 16:46:23 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Feb
 2025 10:46:22 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 00/16] AMD MCA interrupts rework
Date: Thu, 13 Feb 2025 16:45:49 +0000
Message-ID: <20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL4hrmcC/x2OwRKCIBRFf8VhHQYkWq36j8bFE17KAmSALHP89
 8Dlmbn33LuRiMFgJPdqIwEXE83sMohTRdQEbkRqdGYimJBMcEY/xlOrgL69hoSRDqgFtJ26Kdm
 R3PIBX+Z7GJ995gEi0iGAU1PxJOPPFmLCUMKTiWkO67G+8FIpQw2T4sKlbBteiyuTDeeU0xV+6
 Ooxn3JgH2B1rWZL+n3f/0LlHtvFAAAA
X-Change-ID: 20250210-wip-mca-updates-bed2a67c9c57
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.15-dev-e27d6
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 045c96b2-5418-4cd7-7431-08dd4c4df368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW5ra0YrWmViajB1L2RQcm9TTjVCMmdkZVBNaGhOTE5aVjFRUllPS1g2Vmx1?=
 =?utf-8?B?WkRTS3R2RlZpRnpoaGNJQWlvVE93L29qVXFsZ1Z6S1lxWnNaZkV5YkFHTGVL?=
 =?utf-8?B?YWlwUmgrNHZoVkdubkpnTEgzdHV4dFRNR1JvWE1tZGpnUEJ6WjdVQTJWNWVJ?=
 =?utf-8?B?N3U2eDBhNVFDTW9xZWZBZFhveGFtaWZKeHh2SkhqQ1IrdDAxeFFMbDdEY210?=
 =?utf-8?B?SjhKVmlFYTdMR1h4WGNhdEtQSG03ZTFyZTlmVGgyZ1pvTlViM29xQzRWZ2Vy?=
 =?utf-8?B?QkxaMDFnangrZjU5Vno4VnhqbzF1YWpVa0xyeWpVV0V2cjBvT0tWb3RoamM0?=
 =?utf-8?B?L2VNZzJTcy80VG1tdExUc29icFpUL0xFazdOQlU3T0VodGxvLzZJOVAvN2hj?=
 =?utf-8?B?SzdmOGxzMGRFWmFUVnJFTndLSlZKSlZ4bERKU0NrRnFUMEZaeVRDcERYQ1Fj?=
 =?utf-8?B?eGFSdTdld0NraUFrZHJ5R3pCQVlEcnVtV0pJY2dVaE9oRGxaaGs5SHpNNnVU?=
 =?utf-8?B?ZFhuN2hBSE55QkpNVHg0Zmg2ZmprWW5KUHBEY3JqT0RONDRWYkxFd1RsWjFQ?=
 =?utf-8?B?NUlySDkyNzdNTVNTMm5jcXlWTGFwUnViSGxiNEVPS3lxSkxCMkpLS0lhSVps?=
 =?utf-8?B?d0k5NnNWT2NVc2Vqdi9sNmpMaitmS2FUcUxhVXFGdEtmQ0xnSS9aOThNeFBB?=
 =?utf-8?B?MjdBQVJwVXBGRHZtbUVNUlhiSU9ROHlpVU15WlhHRzdTU3RTU0FVSlhPclds?=
 =?utf-8?B?UWRCdnZRdU1lMTBTMDI2L1FGMlp1MFlrK3B0UHRMN1NxRFdnMk9QRHplbDRS?=
 =?utf-8?B?SXFTZHhweW1MYm1JakFBWWZrYml4eVVnZURHcFN5YXdpZ2VhM3J2c1k1L09H?=
 =?utf-8?B?VFlaSVZRWm1IeDFiZEw4ak4wVjVwK1JXREdxQm5uMEtQdDNha21oRG1wWXJC?=
 =?utf-8?B?RFppanJHNUh5azY4VUtNSEw2M2Niek1laDRvcW1nSGxmSjUySUwrUjB5Y1JJ?=
 =?utf-8?B?cVVkQmxTMWgwWk9iZ1lSVzYySFc0cFhrbEFYRkxiMzJiYm1nLzVoTUFiZjRr?=
 =?utf-8?B?cFNuYzBhRkEzbS9EYkVyZ3dXNFJvUTc4T0lZY2QxQW5wUU5kcE9ycjIwRmll?=
 =?utf-8?B?WHNTaDVZN3oxemRVUmgrQVMyWldTRlJmRzRkUVB0N1V3RUZJdjl6WG1Na2RH?=
 =?utf-8?B?T0J0a2xCb01HeW9Pb3VOV1IvVU5PVXpLZHNPMHRQOUcwUXBETW1FL3ZmYXhK?=
 =?utf-8?B?WkhnalRUbFlqN0FoR29UZWZBZlpFZVIwaE1oS0dUVitYenY5QUNSU1FubmFK?=
 =?utf-8?B?RkxBYlFxbWF1M1ZjYjEyVEw2czdTU2VGMFI2QXp2dHVEN20zZUNpZmFQUU83?=
 =?utf-8?B?Q3o5d2ZXUEVOWVVEUE9WZnVJbVdyQ0trTGxmb2tlc0pONmNjL1NqYzdWdTgw?=
 =?utf-8?B?MHZkZkV0TFdmVExFTlJ0Q0RqNWlyUm83S1dJbnFBZmp2ZnQ5UU41UnZQQ0Ew?=
 =?utf-8?B?WDkwbjVPOEJQOFNwaFZxa1ltYTNtc0NueUpDTmVJTE9yR0lDeEllVndVTlNp?=
 =?utf-8?B?bGFDY3VPNzN5b3VhS3o0cHcremJOcHZIQTNhMjByU2k1M0s4V3I3Z1NOMGsz?=
 =?utf-8?B?MnQ3NWY5S2g4cHNlRFVwRnNzQVZVbSt3bDV5VnVDMXpuUjZoWE16MHBsSy9C?=
 =?utf-8?B?bExrb3laK3BDVDIvZDVoVC9IU1NjdzRSQTY5czQreHNzYnZjRWpmSXFvWFlH?=
 =?utf-8?B?Y1QxWXRkNjEzaisyN3Z6Z3VBYzhmcFpSNWFINXhvTnFZdUJxbVJXVU9pcjZp?=
 =?utf-8?B?cG1CMHhNMTFuTVdJM3JtYmxRY2J5VFEzSDBxSEZLbU5IaWJOSEVBUGtaNjhq?=
 =?utf-8?B?Q2tIZ1d3NWQ5Sy8vLzdGNFBNTjRZTndUSWpKLzU2aC95K3BjTTJWRUFQVUtt?=
 =?utf-8?B?Y1E4S3JyYUJVMWdXcm9zQ2FobEFCalVFSmxrYnZsNnNXdkpQeHgwbXFlamh1?=
 =?utf-8?Q?03F1RAIyQvQrjsumtYtHcqceu73UF8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 16:46:23.5286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 045c96b2-5418-4cd7-7431-08dd4c4df368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Based on feedback, this revision also include changes to the MCA init
flow.

Patches 1-4:
General fixes and cleanups.

Patches 5-10:
Add BSP-only init flow and related changes.

Patches 11-15:
Updates from v1 set.

Patch 16:
Interrupt storm handling rebased on current set.

Thanks,
Yazen

---
Changes in v2:
- Add general cleanup pre-patches.
- Add changes for BSP-only init.
- Add interrupt storm handling for AMD.
- Link to v1: https://lore.kernel.org/r/20240523155641.2805411-1-yazen.ghannam@amd.com

---
Borislav Petkov (1):
      x86/mce: Cleanup bank processing on init

Smita Koralahalli (1):
      x86/mce: Handle AMD threshold interrupt storms

Yazen Ghannam (14):
      x86/mce: Don't remove sysfs if thresholding sysfs init fails
      x86/mce/amd: Remove return value for mce_threshold_create_device()
      x86/mce/amd: Remove smca_banks_map
      x86/mce/amd: Put list_head in threshold_bank
      x86/mce: Remove __mcheck_cpu_init_early()
      x86/mce: Define BSP-only init
      x86/mce: Define BSP-only SMCA init
      x86/mce: Do 'UNKNOWN' vendor check early
      x86/mce: Separate global and per-CPU quirks
      x86/mce: Move machine_check_poll() status checks to helper functions
      x86/mce: Unify AMD THR handler with MCA Polling
      x86/mce: Unify AMD DFR handler with MCA Polling
      x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
      x86/mce/amd: Support SMCA Corrected Error Interrupt

 arch/x86/include/asm/mce.h          |   7 +-
 arch/x86/kernel/cpu/common.c        |   1 +
 arch/x86/kernel/cpu/mce/amd.c       | 391 +++++++++++++-----------------------
 arch/x86/kernel/cpu/mce/core.c      | 322 ++++++++++++++---------------
 arch/x86/kernel/cpu/mce/intel.c     |  15 ++
 arch/x86/kernel/cpu/mce/internal.h  |   8 +
 arch/x86/kernel/cpu/mce/threshold.c |   3 +
 7 files changed, 332 insertions(+), 415 deletions(-)
---
base-commit: b36de8b904b8ff2095ece7af6b3cfff8c73c2fb1
change-id: 20250210-wip-mca-updates-bed2a67c9c57



Return-Path: <linux-edac+bounces-4551-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7603B21688
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 22:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0CF716D340
	for <lists+linux-edac@lfdr.de>; Mon, 11 Aug 2025 20:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A632D9ECA;
	Mon, 11 Aug 2025 20:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e/nRnrEm"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF129BD86;
	Mon, 11 Aug 2025 20:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754944478; cv=fail; b=p5eooELfZ8Nwt6tDj47E10Ylr2br0aGXijzDnctsJP+Ya88pO0GLX/D7+gQkrmbhWhrFqfeS0JiYbh6ZxyM+80G5tokbv1Na1ARHELUN2z0gnsJvMMKbyQn7b2VvDynecCeMJRIf38JeJHVcl59aOSCf1jOEHIVT84uICC22Kgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754944478; c=relaxed/simple;
	bh=b4pcBiLXMPnTAMkiALzW8ctZKoe/rR601YHCt565Ma4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=itIIncWOXenpnRX5rwVi2YYPeg+N15H5gcATfI8tLeEv5NtxLbmjRx0Y5ykZJg8MWxOrRxJMOrzmdpb9ImeTwAyR6cOw9IFk0w+hdvc68VUcY6o7agjwNaw6LVJNWV6Jba8pktxYFiLGLgZquhTp/8fcTikjeI+MdVR0D1iXuY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e/nRnrEm; arc=fail smtp.client-ip=40.107.236.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CnIknRhkcV/JtIQ38cNdOr/84CyJGmDLqjbVKsY6twwdg0LkyEWt4oL15h6gJJdUNV9GgqBBobwWlwGxPCEy7jVwI+ABFTgzUWhJYj3aRiBpOp2jka+z3UGx+yQtaJLM9uMoR1Qu2o1Fi/3O5s8Hx15/Mzd13BF3mbouYma0OWNDD8Dpq9uJEti1BKFPokHU94nR47iY+Cw/uPlDgJHfC/zpNCfQPlYoRuBIJnof1vLsCoETWstTvLqpD6yZZrLdr42il0Zqqs7NAmsfNFWfZXkP7a/cQ3+lQGOFF8Zjn7dV0gvoeSAzvHuPvNJkuZ8oguuSE0bHJ1tlr7sXSmp9eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rzioShh/2r2/nakTgpW9CA2GG6B/p2FBkNhb8lasRM=;
 b=KOyRjaOaxIAjN5GGr085ktjefjTn2tJJ03wj0YdJoFNoYX2rQXgMjnVnHw4eKXHphCYn4UfuGn6UWATbircm+euZZpB85YzpWIekBngwXNe8di+eeOaEYvkhxLCCnLLsu9Us58YYzI0ptbTsrpuDumbKBjgnspRIsWSXwtuZ64mBcAc1rIqeLoP2ET5qUUPlZ9O/4PwkdAeC8Nvq4/OLmxt7cMkCg0JB+h1QYzia9UqaY955aZ90mjB5kmehxtVs1ESiE8XIcSuenWoAur7f5lapm9F2jk8K1bO/zN1kz/FiU3js7Ljd15uYcpJbNN6Y7vNiv1WnQmpwfQcYHsBTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rzioShh/2r2/nakTgpW9CA2GG6B/p2FBkNhb8lasRM=;
 b=e/nRnrEm3m7PrXYNXauZkCnDDllTty+5CVLJNZVjtI8i8plG4Tp66EGYtcisMU/beGJqs76+oq4QHw2sHUQvYdMJIuyc4nfuq9seYsjmUrexTSEr7M2a+NW31xJnNeQruXk6qOBt1DYOmSzX7wz6ZrwLQ96lfhxB/+7MBel3ST0=
Received: from SN7PR04CA0172.namprd04.prod.outlook.com (2603:10b6:806:125::27)
 by MW4PR12MB5642.namprd12.prod.outlook.com (2603:10b6:303:187::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 11 Aug
 2025 20:34:32 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:125:cafe::4e) by SN7PR04CA0172.outlook.office365.com
 (2603:10b6:806:125::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.21 via Frontend Transport; Mon,
 11 Aug 2025 20:34:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Mon, 11 Aug 2025 20:34:31 +0000
Received: from yaz-khff2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Aug
 2025 15:34:30 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Date: Mon, 11 Aug 2025 16:34:08 -0400
Subject: [PATCH] x86/mce: Use ZENx features for Zen IF quirk
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250811-wip-mca-reduce-if-quirk-v1-1-4e0f24d94872@amd.com>
X-B4-Tracking: v=1; b=H4sIAL9TmmgC/x3MQQ6CMBCF4auQWTuxRQjoVYyLoUxloq0wBTQh3
 N3q8svL+zdIrMIJLsUGyqskecUMeyjADRTvjNJnQ2nK2rTW4ltGDI5QuV9cXj1Oi+gD2xOdm6r
 yZOoG8ntU9vL5l6+37I4SY6cU3fDrBZL4lMjHQGlmhX3/AoxoAsWLAAAA
X-Change-ID: 20250811-wip-mca-reduce-if-quirk-83a9744fa057
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|MW4PR12MB5642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a209e46-42cb-4d05-fd9f-08ddd9167a2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHNlSTRoMnRLeGN0YnlzUmpVZk0xQkRkblVLZVE5enpCTEtPTXhURmVTRkFu?=
 =?utf-8?B?cmZUR3h2enUwcy9oWlN6ZnJFaDd1bDBmcWxCTzJpQWFxY0VRRXRKMGhpaHl6?=
 =?utf-8?B?Mm1POXR3QUptNy95STZjTWtySDBaV1ZpdVVTMGh3VnlhTkZleWVIazlzRUtx?=
 =?utf-8?B?Nk1YbUtMeU9sWnk0eXNnRXBLNHdUS3Vydm5DNzBxSC9LcWpKWlFBa1Z4Zkhn?=
 =?utf-8?B?em1nc1QzZ3FQOHpmT3VkUHRSd0h1bzJwQWJ2aE56Z2d4b2pKZVNtS21SdXlL?=
 =?utf-8?B?Ykp1YjVObUF1azdVNzR3L2JvdUpJVm94MVZqVk16cWlhaGtLN1lTSGNXK2lj?=
 =?utf-8?B?NU1rdTdkMEtYQlJ0L29FT3VSVFUvYm5qaHgzMzVYdXpVaUFuQkRyNC9aZmpy?=
 =?utf-8?B?UWtYT1BZbUV2YUpJSkl0Y2xaK0p3a0NaT3JEUlcvelk3SS9razV1R3JoWkw4?=
 =?utf-8?B?RDdycmZjRlhhcmRXc1lzajVvVVh4MjE5NjZkUk42S1lRcGZnWSt6YVB2Rll0?=
 =?utf-8?B?WXBjTENreEZyRW0xUCtwU0VEdElqS3NNWS9vYnRPS3B3TENDb3EvLzdlejl1?=
 =?utf-8?B?ZzRoVmxweGkrQmNsQUlxZ3Y2N29YTG5vYU9wMEZNS0FmVCtDSTNHSTlOZ2wz?=
 =?utf-8?B?NElLQmhqY2tUWmc3dDBocXRiV00vZnNJWFAyVEFudXFYamRETksrS1RqZmhY?=
 =?utf-8?B?TmtrZ3BXcnFFc0hNQ2FyZERVSVk0aWd0L052dUI0dUdBbmt6Q1pkTXh1NVZE?=
 =?utf-8?B?RThpcllVV3dnOWtPZHRTZFFhRnR0bTU1Ri9rWVM1TWVqS1ZBWG5FR2pKbEk2?=
 =?utf-8?B?aGtDcFptZ05XUnhkaG5sN3YwSks5WnVzNXlRVzE1Mmw3VUNyay8rdUJOaW1U?=
 =?utf-8?B?SFhFTmhVS0lCRlVoRXFNRWo3WGt4MDVqMVdVSjgxZDZvSVV2YlFVYmFpZ1dq?=
 =?utf-8?B?MFhxbW5BRVBBeWdZRXM3L1c2TlMwWDdvWVBMbU03emJqSmRkdjFzQWFHYUk0?=
 =?utf-8?B?UWYwUHcyOHV4WDdQc0NzQXNyT1VIUTZJaGNPdHR0K0JxZGJUSDQ2T1lJTnZt?=
 =?utf-8?B?bk5ITlVaUzJmREVEZnVTcmxYenRlUmk1TlovYWpWbHpsWm4rNDBqTjB4dXF1?=
 =?utf-8?B?OHZ0YmlDV2dLQzNROWNLYUlCV2R5VnZWaFkwZS9OQWk0OHgycndxT2VGZm5X?=
 =?utf-8?B?YmFLVFFKbmovaGt0OW9jT0FZUGZCeEJ0ZXdneVBJd2NhT21Xd3FwdUpCSkpw?=
 =?utf-8?B?cW4waUNFTHg5OTlFcnJMMlBITitmVWNQODgrZXNQSTZqKzFiaGdTSnJYcW5p?=
 =?utf-8?B?d2NyWmVkWWhma3grekhybUJQSDRsUnE4SGdWN2JONDRxcVZVWnZ0K0R2bkJu?=
 =?utf-8?B?dklLZDhSdUIxVTI2VFlaMWQwL2w0NnlqWlk5Zndnb2tBdCtiZmtveHUzQURJ?=
 =?utf-8?B?clRGaGw4MkRBTEM5OGJNZ3F3YmVRVnQyUVh5MGgyaGFnbUN2MDBYcVhxb3pP?=
 =?utf-8?B?RW5NVTlIdGVEMzdUMDVtN2F2ZWxveWdDSjhWNUNtZHpIZjdFUzZ0NWNPUWtW?=
 =?utf-8?B?T1dwbkVOTzRkeWM4Z0FSVjZDNGE3ejRMZ25HbHNFck1IdmxDNEhEa2R5ZTVz?=
 =?utf-8?B?elkra2NPbmVKTE9XTUV0c2ltaVFSUGRDY2RJQkdhcE9LTktwSGdhamFhTlY3?=
 =?utf-8?B?OXIxY1p0NEpWbXNHV1loWlVhK2RSYlpCZVVhTEpoUmdhNysyd1V4b0dlTFoy?=
 =?utf-8?B?NjJBSVZCaEsyYzcwblF4bkhvTGJnQmhlNC9YOFBNQnZqRlZDazBXc1g2RnpX?=
 =?utf-8?B?QnRxZFVJM0VXNTJzMS9DR0sxM1hOYlRqdHZQYmw5Znd2RWFnc1hYSm5GeXc2?=
 =?utf-8?B?NkxoYjE4cCtwYTJ5S0N1TkpIcjRpRURIMkY4U2lkSjVvcXRnSmwxRzYwVDRQ?=
 =?utf-8?B?Ynk4WWVjbUhqSlk1bHo0WjdzWUhjZ1crVDIvN0pFTmhQYXpkWC9iL2VxOVJR?=
 =?utf-8?B?ZFRHNTVCb25uc3U1YkdRb2xjYmErekZDK3RvejRoN21jc21UZ1FPOThud2xR?=
 =?utf-8?Q?nK5Q4O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 20:34:31.8026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a209e46-42cb-4d05-fd9f-08ddd9167a2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5642

Zen1 through Zen5 systems have a quirk related to Instruction Fetch
poison consumption.

Currently, the quirk is applied to families 17h, 18h, 19h, and 1Ah.
However, family numbers don't apply directly to Zen CPU revisions.

Update the quirk check to use the "X86_FEATURE_ZEN" CPU features to
apply only to affected CPU revisions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 4da4eab56c81..0ef164568077 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1951,8 +1951,11 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	if (c->x86 == 0x15 && c->x86_model <= 0xf)
 		mce_flags.overflow_recov = 1;
 
-	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
-		mce_flags.zen_ifu_quirk = 1;
+	mce_flags.zen_ifu_quirk = cpu_feature_enabled(X86_FEATURE_ZEN1) ||
+				  cpu_feature_enabled(X86_FEATURE_ZEN2) ||
+				  cpu_feature_enabled(X86_FEATURE_ZEN3) ||
+				  cpu_feature_enabled(X86_FEATURE_ZEN4) ||
+				  cpu_feature_enabled(X86_FEATURE_ZEN5);
 }
 
 static void apply_quirks_intel(struct cpuinfo_x86 *c)

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250811-wip-mca-reduce-if-quirk-83a9744fa057



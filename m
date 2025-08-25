Return-Path: <linux-edac+bounces-4657-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB2AB348B8
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 19:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18C482062A9
	for <lists+linux-edac@lfdr.de>; Mon, 25 Aug 2025 17:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB45303CA3;
	Mon, 25 Aug 2025 17:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MUUZCtvL"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1877A3002A2;
	Mon, 25 Aug 2025 17:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143222; cv=fail; b=K+9tMvGVrQzbOOMqnUbUbw0YBkIU+jKXqQrZf4XkpytxOHKqZ2jcLyxMt+u33pJvnecOb9G4yOThNBEeF0JV3pwqoIhYSwqR27obu6cTcxR97732FWy32DKu/T8h84Eg7+54io33CmB4GqEanj1AcP79cMo51ys/CPF4QOmXfEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143222; c=relaxed/simple;
	bh=9VET/I895W91S71pO3n34+DAc84djlAA95sRSAs6bWk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=eNHtAvxQK5nT9oWWqa2W2Ph71+R0189A7T3jh5ae30MPMR3Mj+JJ7P86tp1NAWRRw1QDCk8g11axoSTZtYgs0iggsJtpVUdGGIVBQjVWC3mwjFaVEokT2cPrs6WNwNEiet+i1mlCwVXX9d7vjDXZW8dx8yGUz4RpW0Tq2AxpPTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MUUZCtvL; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5tiqG5ih8/PELSyclx0xqNiKRPoovhGNzJT7rnMojHOJ0JFGFkiINB0nFdg1/0PHr4lNk80KlALvshVBIXMb2oe3nVzUbEKTXBRabUbMHYax8QCWKNyiCqWCNHY7n6B0n//+c62tAE8Rfu1OMb9QC6rILpMPlf2bUlqpuK7RQrjMmuk3x1mgQP1NkodlbvCnfTD4LQ1GN+1lI4UQKzHZ+QWHtDAJX2OSI4APn1/V968x2hwjjQXRFfRynq5eaiBDp5cWDTuJflSru8dC28JOHbdV4zRdZBipsEzGJr96C/Fxd7FhVpkua0zshkrelFy6hhocpLeZI7uBUDWvHqyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S76gn65nubK1eEdPFb2MK9smL/35AjCeYunnbizGKuM=;
 b=n/tY6W+ESFJIA4NJK25uJt4JhmhRJZNyW4fVvbZ2DB4pffV3cu7yig+5tNtzcgL17RzQ/2C7G6oEUmnnd1GsmV+AwWJVbGdpzL4YRoPIfPXpHsReuvGwCP4sdRcZHmbyfW4ReYg/QxHeqC6kuXlVL1MoTP9EMOzx1zX5DwUycqMWKI1uX1htpojTXdUW9QrV30K4cfMPF1/+OYm2UjTYemLX/PZsr0WI8i+atbBW1QqSI+1FOH86yXBRJdpsWcqdUDJdrxU0XMQ/pi2CGDc3zzV4Ozs+WT3sMravpw/0ItR9c9oOa5aK4uNSD9yLJzpSVE0G83bRJbZzD8negycNAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S76gn65nubK1eEdPFb2MK9smL/35AjCeYunnbizGKuM=;
 b=MUUZCtvLoC3Zn9i9LJOr/UopOM5rpnNUtJj5GQ61WVgQAyDDlmuUaYDurZX30t7jDyckcn1KdzFmGNRCJQnZVED6TBU8d2XP0RvQtzmeePF6wpPSY5gfGVfQEHZZy1nQsVRRvFDk5xJPQGotFOX7Cb5YC1ktNMn06jntnilJomE=
Received: from SN7PR04CA0041.namprd04.prod.outlook.com (2603:10b6:806:120::16)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 17:33:36 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:120:cafe::39) by SN7PR04CA0041.outlook.office365.com
 (2603:10b6:806:120::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 17:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 17:33:35 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Aug
 2025 12:33:34 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v5 00/20] AMD MCA interrupts rework
Date: Mon, 25 Aug 2025 17:32:57 +0000
Message-ID: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEmerGgC/2XOy27DIBAF0F+JWBeL1+Ckq/5H1cUYhpiFH4KUN
 o3874VIVRp5eaU5c++NZUqRMns93FiiEnNc5hrg5cDciPOZePQ1MyUUCCUF/4ornxzyz9XjhTI
 fyCu0vTs56FlVa6IQv+8f3z9qHjATHxLObmx/iu1kz5OT7XaM+bKk6728yCZajxGgtASwRnbqK
 MBIySW/4g/N3blumnF6w8l3bplYayjqT7aFerewKC64ttqC6QMJCM9aP7SRsNe66mMI/kSDQQT
 7rM1DW2X22lSttPW+N8Ga/93btv0ChK0gcX4BAAA=
X-Change-ID: 20250210-wip-mca-updates-bed2a67c9c57
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c1d402-0fbf-4428-9a39-08dde3fd8525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXk3S3NJMWsrc0QzRW9hczlKbEVyMkxRU0FQenRreGdWRzA0bkVFWXNHQzBL?=
 =?utf-8?B?QUZJOG9ma1ZmMUZJbjRGZW9CSy9relI0UEdrN2grMFVHUy9IckJrbHNtd1dX?=
 =?utf-8?B?M0w2QjM0R0RDL1grLzdkVEliWHJ0alRVMGtIMDFudTNScnBMbTYxbXNLRWMv?=
 =?utf-8?B?SUtqL2FuT1B2c0RYalExYzk4ejBEYzllWHdOd2YyMG1xdWlhejZrQjM5OWN1?=
 =?utf-8?B?TnpWK0o5MUd6UXdvZkRnSVVWSFNyWnJ5ckdGOVB1T296S3dTRkoxa055UW5r?=
 =?utf-8?B?bDZlUmFmRUN3VWxWOVB0MWYybzVjSTRIMWRFUVUzSm1JTG9uNndSQ2V5N3pM?=
 =?utf-8?B?ZTZrTUl0WEQ4UmhrT09WY3ZCUEhZYmFISC9EbG91SlB2bUMxZHNVeEdqVWNJ?=
 =?utf-8?B?YVZZWlNSTmdUNjVDZXhvd1M3TDFlK21IMnppNkFIV1ZpMnoyYmdmTGk4QVRJ?=
 =?utf-8?B?UTBLSWdEY1hDT2owQWNyamM4VXBTOGdPZ2JCTlc3Y0xSdzBkVGJXcXc4T2I2?=
 =?utf-8?B?YXZORUYwRi8zSHpkVDQ5Mk4xVWcwWWpQellHMHVrRi9lN3FUQ1hoTHBFU1k4?=
 =?utf-8?B?Uml4K0dtbFRHUXBrcSs2dUsrL3g5QW4wSnV6QzNWdGs4U0FVc3MyaTI2em9X?=
 =?utf-8?B?WEZRdDlTT1FranZNQThNZnJhMitDNHlTTXplZVpHQ1p1ZGdGdjAvc0lJZFJz?=
 =?utf-8?B?WXhFRGttSFZZOStucE05VlZyZ2pnRjB2R094cGtlTXN1cWw4VlJsMk9XZHR2?=
 =?utf-8?B?WklMb1BnYTBuZXRTUS84bEVBRzAxdXhmNHJoR3VlVGhFVlh4b0pIa2FzT3RH?=
 =?utf-8?B?RWVDTmpkVEZPZUo2aCtJb0xUMWh6b2szbHp6bTJIQmFldVZ1TXBIdENuWDZv?=
 =?utf-8?B?WHM2djliWm8vaTJJMTN6UEtlRDVXY2lnNktwbFVUSGl1WXYzVUxiVDREUFBm?=
 =?utf-8?B?RS9RY0N5bTJzbTlHM1lEV0V0YWdYelN6aEFONHVZK204UEFpQ1prLzNLQzRr?=
 =?utf-8?B?MmJjQXNYa3l2OFlEbnhNUjQ4Q0VEeFV6NnlNZjFnMDUwQ2dVK3ZvZVFoTS9I?=
 =?utf-8?B?RUNrNEsvVi9pRm1vRlkwRW1NWmFDRExralZacGlmazBwTGl6VElhd0ZabGhy?=
 =?utf-8?B?c0oyVWJZaE05SGZHTlRIZkEweWdEZFZhdG1SaEhCQ2lxSHFOOWp0Wk1LbkF2?=
 =?utf-8?B?bmJpeWNPRVJmeWxlWDd2ZDR5dmh1TldaNHlwaHJNWkpNVVlUSXBGUkUvQVlX?=
 =?utf-8?B?SUFiVW1qeGtRNndiRlZQZzZhenhwQWJjU1Noby9jZGZ4ZFNZQVpEcEZVbFBP?=
 =?utf-8?B?bjRpUkJFa2xNcHBCMVBJdndiYXgxWEE4VUN6T0phOStSY2s5YytlMzNjNkNr?=
 =?utf-8?B?Z2kzQWY0M09qZm1DSmdzOVNwR0FiSlIrVGp1bEQzZVNpc09LTGNVdVdPQ1VD?=
 =?utf-8?B?eEVLRE1lNmc5ZXRkSmFsYTNXcjZSTmN3K3dVV1EyeUQwVkVSTGVoU1N6a1Zz?=
 =?utf-8?B?YTgzcGFYZmRQUmdjekZpNGlrVUhEakx2VUczdkw2WkFWcm9MN1F0S3F1UDQy?=
 =?utf-8?B?cHAycjBvOEpFMVY3U2M2TEUyeXJ4TGFZVzdKYWR3OFBWUE1GR1EveEwrRmhq?=
 =?utf-8?B?TTF4QjZXczdwQ0hxR1QzcUdEMGRqaThpN3hVcUNSK1UzT0lib1FTMmRlUlhY?=
 =?utf-8?B?WHN4L01KN0U5MDVqY2xCeGhzTm53YmR3ajNyeEx0czYzN3o2UWluQnhseHdU?=
 =?utf-8?B?bUh5cUlwYnpPQk9Xb2NsRjczY1phUndkMFo4dGFrQUloeTBSWEc3R2svcyti?=
 =?utf-8?B?QVBwMDVJaXl3M0xINnJLN1BMeUo2SUpLTzdWNmh1ajk4dFgzTDFwT1hzUGRh?=
 =?utf-8?B?SmpzS2xocFBwQ0Ftcno0R0lQeDJCRFRoSGsyR2pNc2ZyZXhHWFc4WlhZRjNq?=
 =?utf-8?B?Z1VOS0hYNWdtTG9mUXhPNVRQSjB5bWFaMm90VmdCVWM0S0xyUURCSElBUm03?=
 =?utf-8?B?Wll4czl6SWlaTGlySGNmRWxQNmhJdUlhSS8rbFVsdTVvN0FUYThrS1JrSjY5?=
 =?utf-8?B?aHQ3aHFwS3BSVjFxSEVDRHh1UERpREdydTM3Zz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 17:33:35.5889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c1d402-0fbf-4428-9a39-08dde3fd8525
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Based on feedback, this revision also include changes to the MCA init
flow.

Patches 1-7:
General fixes and cleanups.

Patches 8-11:
Add BSP-only init flow and related changes.

Patches 12-14:
Unify AMD interrupt handlers with common MCE code.

Patches 15-16:
SMCA Corrected Error Interrupt support.

Patches 17-19:
Interrupt storm handling rebased on current set.

Patch 20:
Add support to get threshold limit from APEI HEST.

Thanks,
Yazen

---
Changes in v5:
- Rebase on v6.17-rc1.
- Add tags and address comments from Nikolay.
- Added back patch that was dropped from v4.
- Link to v4: https://lore.kernel.org/r/20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com

Changes in v4:
- Rebase on v6.16-rc3.
- Address comments from Boris about function names.
- Redo DFR handler integration.
- Drop AMD APIC LVT rework.
- Include more AMD thresholding reworks and fixes.
- Add support to get threshold limit from APEI HEST.
- Reorder patches so most fixes and reworks are at the beginning.
- Link to v3: https://lore.kernel.org/r/20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com

Changes in v3:
- Rebased on tip/x86/merge rather than tip/master.
- Updated MSR access helpers (*msrl -> *msrq).
- Add patch to fix polling after a storm.
- Link to v2: https://lore.kernel.org/r/20250213-wip-mca-updates-v2-0-3636547fe05f@amd.com

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

Yazen Ghannam (18):
      x86/mce/amd: Rename threshold restart function
      x86/mce/amd: Remove return value for mce_threshold_{create,remove}_device()
      x86/mce/amd: Remove smca_banks_map
      x86/mce/amd: Put list_head in threshold_bank
      x86/mce: Remove __mcheck_cpu_init_early()
      x86/mce: Reorder __mcheck_cpu_init_generic() call
      x86/mce: Define BSP-only init
      x86/mce: Define BSP-only SMCA init
      x86/mce: Do 'UNKNOWN' vendor check early
      x86/mce: Separate global and per-CPU quirks
      x86/mce: Move machine_check_poll() status checks to helper functions
      x86/mce: Unify AMD THR handler with MCA Polling
      x86/mce: Unify AMD DFR handler with MCA Polling
      x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
      x86/mce/amd: Support SMCA Corrected Error Interrupt
      x86/mce/amd: Remove redundant reset_block()
      x86/mce/amd: Define threshold restart function for banks
      x86/mce: Save and use APEI corrected threshold limit

 arch/x86/include/asm/mce.h          |  23 +-
 arch/x86/kernel/acpi/apei.c         |   2 +
 arch/x86/kernel/cpu/common.c        |   1 +
 arch/x86/kernel/cpu/mce/amd.c       | 448 ++++++++++++++----------------------
 arch/x86/kernel/cpu/mce/core.c      | 352 ++++++++++++++--------------
 arch/x86/kernel/cpu/mce/intel.c     |  18 ++
 arch/x86/kernel/cpu/mce/internal.h  |  12 +
 arch/x86/kernel/cpu/mce/threshold.c |  16 ++
 8 files changed, 404 insertions(+), 468 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250210-wip-mca-updates-bed2a67c9c57



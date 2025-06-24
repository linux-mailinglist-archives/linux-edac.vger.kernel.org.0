Return-Path: <linux-edac+bounces-4215-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17417AE6859
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB631921F1D
	for <lists+linux-edac@lfdr.de>; Tue, 24 Jun 2025 14:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC02D5C91;
	Tue, 24 Jun 2025 14:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MityjABf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8352D5C6B;
	Tue, 24 Jun 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774592; cv=fail; b=aSZ4Eb91jwVbrWlbnvfj1HGsz4n6R49qqOdcQussYRY0Mduu1U4FaIK4x5Pp+D0LDOnQa5vY3jQpOaRZ/xbOHrKYffDHPfj65vlHFTMIt/0UNcUItOyLiWffLI9aJBQ2bYWqn6j3GAz53GG3LKcVIzNWzYKlIyOmqZY8dvnyR0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774592; c=relaxed/simple;
	bh=IRbaDuSniktcXJ+bF0n+eXDpNeK21SrX31LZ9FTcRxo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Mco1JuKDEu4I3gJ9NS8wGxW9tl+UUEarOtOasRxedKOvyq/ahPP+H+CgAKo0Gq9mmAYHEg32CQSC2tWti6x5HFGWvpwUmKijonWZrJxErJxZEMzU7V82ejELILLz5l7GceAgeJfjkY28v2a+yUUr3khFY5jMSR0NeJPA9vHDWKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MityjABf; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5latdT1KGZgIocuMGMB9EoTZkmIsjo3Glp/b1ZjKZWfImE8zj34LeR5fEtuM87AFxokEmjzt2PeofhUvEUqh9L4ddiLLKHiq0IOFvyq4IMDgGvxtOf9emmItpmSxCHR4kakLyro1ji3YEM4PPJar8fhDlM4OH5iSMcAEpseFAKeiS3GHl0nLc/ea+tLYRyvf9VJze+InMQyXnWG6hnbuTXWtqSObumAMuiJiX7Eet2w1uFUOq9Vcxyk+Hywel1Hef05s7CinMDxXaHz2lggz2/JM4G3CZyGmOuANGRw4ipFdpXIgsCkqIfU0zqFbvR99F135IEoUeXwwMzD8UO8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLkIBw4Fb0M+MnzasAdFVbAjinn7GNlNeF33ZtlwIh4=;
 b=yLAz/fezhslxNcp1mevVs8ZuZ1LQ8wFxLQStqaRmOqv1MIq2OepJuZtXmd8TBmzGp9fCJzXNVscqgPP2HXMlMsqqVvy9/KofTV/sfay6oFolqzyDJoD9zBjhVVlJ985m9RjLeLgAkjHit4wQZr+o65DN53KAhLEGFy449w1MWsFN+Av7vFfbQVAlB8uoMATo35vCIqfR5yLMTs3g8e27ngKHOADEjVjtB78/GOI7kxUcey4aIe5nWotxTclj46zrqBgZZG/tm1NJXi8pwZElAWbIwqmVzCJvYnbl2dqaonv6lQ8WAYtVGGl321lwiOxo001t70YLzg7Jw7+OhOgncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLkIBw4Fb0M+MnzasAdFVbAjinn7GNlNeF33ZtlwIh4=;
 b=MityjABfHNFZkq3pOO4zStgYvaM7LMnOIrl6cLL1fldNemtiVI8VPw8mgfQ+q9Lt9vE+muxqbnIRcj85i6x6Dia9FuihTW4aS39AJ1Q15Ep9yDchiatB75jtCsCmmK7jwJMfXLEHkB79iHS5C2r9DCYu0H7LtZFKddmS9kfpN/M=
Received: from MW4PR03CA0240.namprd03.prod.outlook.com (2603:10b6:303:b9::35)
 by SJ0PR12MB6734.namprd12.prod.outlook.com (2603:10b6:a03:478::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:16:25 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::9f) by MW4PR03CA0240.outlook.office365.com
 (2603:10b6:303:b9::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Tue,
 24 Jun 2025 14:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:16:24 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:16:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v4 00/22] AMD MCA interrupts rework
Date: Tue, 24 Jun 2025 14:15:55 +0000
Message-ID: <20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABuzWmgC/2XOTWrDMBAF4KsErTtG/0666j1KF2NpFGth2Uip2
 jT47pUCJZQsH8w3791YoRypsNfDjWWqscQ1taBfDszNmM4E0bfMJJeGS8HhK26wOITPzeOFCkz
 kJdrRnZwZWVNbphC/7x/fP1qesBBMGZOb+59qB2EhO9Vv51gua77ey6voovdobqQSxlgtBnnkR
 gsBAq74Q2k4t00Jlzdc/ODWhfWGKv9kX6ieFlYJHJRV1ugxEDfhv1YPrYV51qrpYwj+RJNGNPa
 h933/BWbHoKJAAQAA
X-Change-ID: 20250210-wip-mca-updates-bed2a67c9c57
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|SJ0PR12MB6734:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ef2736-7016-46f9-5e1d-08ddb329b3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S094K2Y1RmNxbkZ6TVJkSXYvZHEraGVyMU0yN0E5eEdwRDRjbEFrcDZXVnlr?=
 =?utf-8?B?ZDdNcDFhK0Mycjc1Q2xkWTF2TUE0Wmo2R3I3TnJxYWhIS3k4MElIaGZKVHlk?=
 =?utf-8?B?dGJRV1Y2OHdYVFBpKzdTd1pSUVZ6SXVwRjg5aG5VSHB1R24yUUYwcEJuc2tU?=
 =?utf-8?B?dmxzL0IwUk5ZK1lsRXIzUDVUTFc4SGhXbDhTM3Z6c3RXNHd4L2pkb1l0cFIv?=
 =?utf-8?B?TWMyL3FvQzZ5SmdIQXd0Q2dDYmVsc2tRVTVneTl4Nnd0U0hMdGd5aXEwODFt?=
 =?utf-8?B?UGtGS01RWkdQUXIxcVJXSjhLZG45d2taZGJWTS9rK2FzOXJZNit3cDdKajRr?=
 =?utf-8?B?MTJ3NklVN1ByZkllZ2hOalV6RHp6WWg2SW1vcytLK0xlYnlwV1RKeXdyeDRS?=
 =?utf-8?B?OGU2N0RISHArSEhUZjVkbVI1eVhiYUR1Y29KdDFubEEzQWhkUjBlOTVzRStZ?=
 =?utf-8?B?N3FzNHNKTlMza1JheDdRTkd2Qmh3VEd1dG5SNmZVcklpcjNHZE5FbytKMHVh?=
 =?utf-8?B?SUMwajFBVndYZ2VSVThoNHg0cXYvVXd4N3RKdW0rOUt3VWJiUVdnbGJLTkR1?=
 =?utf-8?B?WEpMeER2eTc1bUJjZEZISUoxR2d4QWxvd21hcHJSWHhvdnY2Z1NYMG1iMGxv?=
 =?utf-8?B?bUhRT0tyYXZOZTVuenRCanUvWWZIQWVsaHFUdVAwSmlEanIxcEJYaUdCc2pG?=
 =?utf-8?B?U0wyR1A5RkQzYkhPSU5VTG5CeVRwTWo4NVFJZFcrd3lIVVNhTXg1ZVBvZFVB?=
 =?utf-8?B?dEUrWGhlNGtJK0dMeDFrcWZySGZFT3NUcytLUm1BYlFqbVJEMm1Jb1VWQXFZ?=
 =?utf-8?B?MTFXV2U1eG81dzV4eDB1ZEVVR3pDNkxJWE5tNU1GSzg5Vy9PZWxJcUl5bUtZ?=
 =?utf-8?B?MHNMbWlXL2NNUDFjRWVBT2pPN3BiYlA3RVpDY3pmc0FuVTZFWDB5MWdlZ1lY?=
 =?utf-8?B?WGRHZkFnaG95MW5lOEJINER2QjcvbkdReDA5QTVkdmZoRFlwYU0rbEp4RGhO?=
 =?utf-8?B?d2cwcysrR1RGMmhUdFBkY2x3OVhmalFCR0pqaTNseW9zMCtjRFlWYzkwYlIz?=
 =?utf-8?B?dnRGekJXOWxLSjA2eGhadWQyMGN6K1QyYXZoM25LREozSG53NEVPME1KZnd6?=
 =?utf-8?B?emNQaXZKLzRxNktQanZKM3dxa1lrK3FmMFdBL3NGS0VOcFY1SXJZOHhsTlVn?=
 =?utf-8?B?QXlYYnF4dUtVRGU2NjY2VlRLMHp3Yzk2M0t6MzBuMk11VlVWS3VIUXR3eW9x?=
 =?utf-8?B?VHhETEVLdWpUUUVHcUtDZTdpOHVodzRvV1pzcFdYQXAyQ0I0UVJzdGtyaVQx?=
 =?utf-8?B?M3M0RnRpdW9qKzF0SGI1UzJITmdFVGdrb0EwUWR6a0taSkUxTlFwRmRhVW12?=
 =?utf-8?B?eVBRQTVINWhzMmRaRDkrTU9IajRBQTFNK2VwSUdaY1oyUzNDM00zVzVNUnl6?=
 =?utf-8?B?ZWpHV3pXTGFyMmFSQnJXZGZtdXN4aGZKYjV4ZDl2RExkaTl4NU9qRk5Wbm9w?=
 =?utf-8?B?NWgzRStsYnduVHo4Z0h0RUJQby8zbGp2K0RXM1B3czU0aXlLV2dDUWU3UjNv?=
 =?utf-8?B?LzVhZDNqUTJQSmhCVWh1WnpNR3RwT2wzeW1GMjZLZG01b1NLR3JOaVR0aXBa?=
 =?utf-8?B?d1dNU1VNdGpPdlc4WEhNa1UwVDljVjhQSFl1ZFhzdDlkRVlpbDV2aVNyeE1O?=
 =?utf-8?B?ZFB0VW9XbVgzTFNmQ3ZhVUhKTVd3UUgrTWhZUVlKWWpvNjZkdFpzblNYNmtE?=
 =?utf-8?B?NTk2aEtUaG54Ung5bVJDWVZBRkpSZGFkK3BDY0V6RWFnMDJGTENqblpuSXJC?=
 =?utf-8?B?U1dzdWdLeks2YjZocUIzMHo5dnNGQmd3dWlIQUNmZW5rUVhLZ2x4NXNNTmZW?=
 =?utf-8?B?Z1RzaWlYV2IzamQ4Tzl3bnR2RFpyaVJFQ05ESkZRd3RMT3ZHSkRHcWwrd2o3?=
 =?utf-8?B?VWNxS3gwRjRIZUlRYm9LRDE3ekNoN1N2TVIwRXZ3dnNxQWFMekc4NlBkWUJp?=
 =?utf-8?B?a2t3VjlPUlBCa1lQZjNPZnhVZlcvT2VVdnhDaW9MSDJmWmkra0VtU2o5T1dJ?=
 =?utf-8?B?SHVhbi9VYW9vaDhneWZ3eEEva1M3M2RVS1lpQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:16:24.9228
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ef2736-7016-46f9-5e1d-08ddb329b3f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6734

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Based on feedback, this revision also include changes to the MCA init
flow.

Patches 1-8:
General fixes and cleanups.

Patches 9-14:
Add BSP-only init flow and related changes.

Patches 15-18:
Updates from v1 set.

Patches 19-21:
Interrupt storm handling rebased on current set.

Patch 22:
Add support to get threshold limit from APEI HEST.

Thanks,
Yazen

---
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

Yazen Ghannam (20):
      x86/mce: Don't remove sysfs if thresholding sysfs init fails
      x86/mce: Restore poll settings after storm subsides
      x86/mce/amd: Add default names for MCA banks and blocks
      x86/mce/amd: Fix threshold limit reset
      x86/mce/amd: Rename threshold restart function
      x86/mce/amd: Remove return value for mce_threshold_{create,remove}_device()
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
      x86/mce/amd: Support SMCA Corrected Error Interrupt
      x86/mce/amd: Remove redundant reset_block()
      x86/mce/amd: Define threshold restart function for banks
      x86/mce: Save and use APEI corrected threshold limit

 arch/x86/include/asm/mce.h          |  23 ++-
 arch/x86/kernel/acpi/apei.c         |   2 +
 arch/x86/kernel/cpu/common.c        |   1 +
 arch/x86/kernel/cpu/mce/amd.c       | 366 ++++++++++++++----------------------
 arch/x86/kernel/cpu/mce/core.c      | 363 +++++++++++++++++------------------
 arch/x86/kernel/cpu/mce/intel.c     |  18 ++
 arch/x86/kernel/cpu/mce/internal.h  |  12 ++
 arch/x86/kernel/cpu/mce/threshold.c |  16 ++
 8 files changed, 379 insertions(+), 422 deletions(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250210-wip-mca-updates-bed2a67c9c57



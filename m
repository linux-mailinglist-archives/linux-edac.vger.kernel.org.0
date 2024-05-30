Return-Path: <linux-edac+bounces-1157-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDBC8D5480
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 23:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923C41C24BF9
	for <lists+linux-edac@lfdr.de>; Thu, 30 May 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EBC18308B;
	Thu, 30 May 2024 21:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eEda1sMZ"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5FA17F4E0;
	Thu, 30 May 2024 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103795; cv=fail; b=OTgdzIweuGGFKecVeGimii91ycQ4GkPXfFQHXnZp+uzMhKsoWAu/HgMgsbEaVBrHKEwrWuGpCZQDizIXmOqwEj8ZHOWip48bw3e0cPfZBo4xUO7qamVMPx/4HvjimtMBBAKtMwSmTi8K7DSHwGxAU3wrA4iXvf+EgxFpXEYp7bs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103795; c=relaxed/simple;
	bh=4Fu4mxdNrXeHkJk0zjaaw4y0igatRQ2/luvn4wOZkQ4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SR5+lPIBQqkzj3Kp3YU4YRhMkc2x/Q323q+CWPr59/KDuVfWTpQDiELc0ula5FUaNiiJ4ooVwlAf7rHaSJwZHnv2pl5P9QOnVentLg/e4a5Rg2nIxte1RJQbm8sOqkV69olO43GM4yvqEnvDBcs5MDWwdOdR350oM5LahPNCrp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eEda1sMZ; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGEwpGMqw0e8wChdkZif6KQ6Bra0DXyhWfiQPiJ8S0tA/cZpNRYF/NlzUGNm1o5c4Xe8QOV03Q1kubMfesN2YdnO2QYDI/yoM1K77pAYa8OI+7hmmckaf9fC07Kpnd5YYy/ZmtPpGjxDISEPIfdJpvW+BUBYBp8Gfp4IxMq817LvR/LjZPgKmMJ5AcToz4I4u35XpNFlit+1qXntr87yKnbg8YGC70ghxThw7L+COlF2JvqAt+Ba65zJ6mhnE6jwbSZ5qaR+hJJ7yrx+Wrqfemj9waZUPMfVx+n8nOfi0OVwLH6pSW71wBMHsKC+aliuI1Q/K97teQ/Nis0YlqTWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8/VMFIK43gunIxU31epqYqj0svqpDggokGnhxOT4Cs=;
 b=IUU8gLRi5qV7PbQXzC4IgUJpjeszp7B5y0dSkUfHk9C9nO4RF5B+NZB9BTvjAgM3BQiXD61xtJoMTgHJn6VHq5gGVrmpm9kRF1VA84lms+zF4pVSLCRQvDHDTCGzju1TVQGLaPn8LLJWQ5IIV4yAFuRx34o+JTcthgH+XhtJAHhmNdpoAl80FW85XrzxhQ0qMCS618PDOk831ILm6gGQlmVe0TVZwfiZsjYJJugbv5QlHnkyywHwCNMrc+4ploNRCxCLC6rDYjxow8zaFRoQCI+PZ5VKFnEyx7D7Ft25Ld27kkAa5exq2qpFIYimm07TmwEC4pGHwwaRtKS//gSYcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8/VMFIK43gunIxU31epqYqj0svqpDggokGnhxOT4Cs=;
 b=eEda1sMZkR09Hasypq3NFkJeqtqCsqvnqtxkXiy+KiCXW9fHEL6SAidIbJVBaRJmnQdX1qOz2O5RRiY9cZBVLU/Er1uumbNPGdcG0YxAbroz8gQPgMgjE7N8EulSS9lzXdRBsAbrgUV+a6PiTCAPAtWNboIq3rDYAw24KzoHrU4=
Received: from PH1PEPF000132EE.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::36)
 by BL3PR12MB6569.namprd12.prod.outlook.com (2603:10b6:208:38c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Thu, 30 May
 2024 21:16:27 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2a01:111:f403:c936::) by PH1PEPF000132EE.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19 via Frontend
 Transport; Thu, 30 May 2024 21:16:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 30 May 2024 21:16:26 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 May 2024 16:16:25 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Date: Thu, 30 May 2024 16:16:16 -0500
Message-ID: <20240530211620.1829453-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|BL3PR12MB6569:EE_
X-MS-Office365-Filtering-Correlation-Id: 7804eb4d-bcd7-4cdf-3e57-08dc80edc42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400017|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UaMUX86Li+IWB5fr9+DKxRWUUTEgVI0KO8qOzyywdiALRR4GoxSC4pUS0Y4C?=
 =?us-ascii?Q?Gt2KWxZmGudRKhGBFCJkWSI/JCZROeGxA/cOFJXmZ7AJyq1ZnOC9lE22MzV1?=
 =?us-ascii?Q?gJl+vqF73+Y6vFizXI8ZORz+P7hNL3ngW7c54uVKXsYMntIPmjkjnF5cQ5fd?=
 =?us-ascii?Q?d6+tGmS+xdSbqkL36MSJu64EhX7JkIxe5mfsPhYNhukaCs/JJ16Tm1x2eyzY?=
 =?us-ascii?Q?QY3yLxJMUXGTqohrClAK98wYge23G451mXGv6EsVFreNIKuft9WoBx3xAcL1?=
 =?us-ascii?Q?nei7++z9Hsp8AduhytIjIA+n9PcumbvJEFzRwkE6jDfK+HRYZfNgbMWucnYn?=
 =?us-ascii?Q?c6XbJG4b5hKjPteSgit/K3Y71luugBTS2YQ4JCmE9iBexQEp7/fx66krd9Mx?=
 =?us-ascii?Q?l/J68r3Hl6W2AbcoPeL1y9YSzpBfnNaDHE5dyqX5LH4mg3fDWt6AhPJsm7yO?=
 =?us-ascii?Q?fe31QxmOR26w5g3m0kU7PevKELseZfrYoHneg4mly9np7ejr/7T7idwPt5MK?=
 =?us-ascii?Q?A2k20UWPuzRtDAhgRRY5Og6jYjDsZHAn7NPkL/24Wx4AFjWWv5HFd+ZkR6UH?=
 =?us-ascii?Q?eKji1QpmgBfEK21albU5lG2MRxBkXALMQopUysCJTKI0eFR7YogtD5xFKcRC?=
 =?us-ascii?Q?76RJbcrkUw3qayVXZRu5FYYeVo8QUzK5+5JsrCxNfNjk4/M7Tq3g9LFkg62b?=
 =?us-ascii?Q?YhvtyOcafGfdyVXsdt7B2lJt5u71rsXaX7DglrkdwJcjjJ1VCwWUvLoS1ODC?=
 =?us-ascii?Q?meZgyM0oTIXhBZnyOrzOGTWokF+FkE6WNz6k2O+IOFMShh5McVaWtjrdHLkP?=
 =?us-ascii?Q?kZM80IGsybfciyo1JE5s3u85T9gNUT5ljsxRk6jGPXBqBXQ05jG0OQl2Jobd?=
 =?us-ascii?Q?mTYtFUlGNyH9KMETam3xLhxngFbK+KUucwVPFtKBnx/JxDxSd2ufGIzXOUFZ?=
 =?us-ascii?Q?drWms6Kh/jNXEwSJY/+HdgmrgPo4eeA/RpUt5DzhXdCnLgxczNCh3boMgQyx?=
 =?us-ascii?Q?YDhTJUWlMRMZZ/4cLZQZxi6Daz/ugLPA5G3d1DqBY3OfIvm4whwONaUwHKzR?=
 =?us-ascii?Q?PZ/WsCRvNEjBKjwAUjnpUMb+w7gu7kQc7FP2xQM6x5Z49A52uR9BdlidAVv2?=
 =?us-ascii?Q?7gO1CYVIoszl3S1Nnf80y2gsKRaGN01jK0A2xqZnFjds4CaflPIQ5QbNbs0Z?=
 =?us-ascii?Q?IxNQaaKhbMWChClnysKKfJpOw53DIr45qkXchk5r7swTB/UWC3bXyhZCMuTo?=
 =?us-ascii?Q?VRofPG9dCiyKbbYubCXPgLw+uuzgimyP01Wy9SrkAnaE55DkSSexDoJgfYx3?=
 =?us-ascii?Q?aVZq2cpCjwQTtOjMgIl55zQF?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:16:26.5446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7804eb4d-bcd7-4cdf-3e57-08dc80edc42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569

This patchset adds a new wrapper for struct mce to prevent its bloating
and export vendor specific error information. Additionally, support is
also introduced for two new "syndrome" MSRs used in newer AMD Scalable
MCA (SMCA) systems. Also, a new "FRU Text in MCA" feature that uses these
new "syndrome" MSRs has been addded.

Patch 1 adds the new wrapper structure mce_hw_err for the struct mce
while also modifying the mce_record tracepoint to use the new wrapper.

Patch 2 adds support for the new "syndrome" registers. They are read/printed
wherever the existing MCA_SYND register is used.

Patch 3 updates the function that pulls MCA information from UEFI x86
Common Platform Error Records (CPERs) to handle systems that support the
new registers.

Patch 4 adds support to the AMD MCE decoder module to detect and use the
"FRU Text in MCA" feature which leverages the new registers.

NOTE:

This set was initially submitted as part of the larger MCA Updates set.

v1: https://lore.kernel.org/linux-edac/20231118193248.1296798-1-yazen.ghannam@amd.com/
v2: https://lore.kernel.org/linux-edac/20240404151359.47970-1-yazen.ghannam@amd.com/

However, since the MCA Updates set has been split up into smaller sets,
this set, going forward, will be submitted independently.

Having said that, this set set depends on and applies cleanly on top of
the below two sets.

1: https://lore.kernel.org/linux-edac/20240521125434.1555845-1-yazen.ghannam@amd.com/
2: https://lore.kernel.org/linux-edac/20240523155641.2805411-1-yazen.ghannam@amd.com/

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Yazen Ghannam (2):
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h              |  20 ++-
 arch/x86/kernel/cpu/mce/apei.c          | 111 ++++++++++----
 arch/x86/kernel/cpu/mce/core.c          | 191 ++++++++++++++----------
 arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
 arch/x86/kernel/cpu/mce/inject.c        |   4 +-
 arch/x86/kernel/cpu/mce/internal.h      |   4 +-
 drivers/acpi/acpi_extlog.c              |   2 +-
 drivers/acpi/nfit/mce.c                 |   2 +-
 drivers/edac/i7core_edac.c              |   2 +-
 drivers/edac/igen6_edac.c               |   2 +-
 drivers/edac/mce_amd.c                  |  27 +++-
 drivers/edac/pnd2_edac.c                |   2 +-
 drivers/edac/sb_edac.c                  |   2 +-
 drivers/edac/skx_common.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 drivers/ras/amd/fmpm.c                  |   2 +-
 drivers/ras/cec.c                       |   2 +-
 include/trace/events/mce.h              |  51 ++++---
 19 files changed, 286 insertions(+), 164 deletions(-)

-- 
2.34.1



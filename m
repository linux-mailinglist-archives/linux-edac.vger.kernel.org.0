Return-Path: <linux-edac+bounces-2087-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE99A0185
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 08:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E363E28726D
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 06:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3304F18E057;
	Wed, 16 Oct 2024 06:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gs6PwG/c"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6B18BBAA;
	Wed, 16 Oct 2024 06:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729060839; cv=fail; b=JH0AmBze5ZtPx+kEWzp59wtJgIfo3j0V7jqkj5Z7nY6ioRNc5XkzVnfPKDjYXtxKzCvCOXVosz7ql26Guq2eA1NypI0eoQX2cQ0MSVXZF/KniJpY6UcNAPpiS5G6cwMzTJSE2evikpwIH9QWE8zeOPg0wmV43F2cgMEvvhDgayE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729060839; c=relaxed/simple;
	bh=OfPH7tx8fa0VFboE0bOn5XWLqjZURA51eVuSl13M5JM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tP/UacQ6GKmAc1nThqFQm1YfRNqR3E3gbcHVEtAevfLVTgmOwutCKoSRG0aGqZGk6qKZSA8pc2ur0DHaTJqOavfVIip9TqjL7Ror1hixEq8CrRGhL3cBzkx59PPcDXGnaEgvFsngro7RryWIf41Q138Bau6M02DyM2nKNq13xoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gs6PwG/c; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSzyLuGY6NCxRxfR+aJvilLY2rbpQnA7ZcmgGp3rWAqSVwgnTJKgltEMry1c0e/mAaiUmKExtovkNWY+wYk5INxDPwtZzcuAPgtMfundmkaYLWiybJ+2cIx5Gc1ptruqWEUJ0NsDyRbaLm+S9QwkLh2EVZ7ACqgwHSL8A7R6oJpjuCd/pdHJkW40fyRM8M7FkuulrlhKSz0D0tmPhgVImzBCkP6UhQZRCzR6EQcttcdNmoyUSVM+9ivmU0wBXITR0Ufjp6Rdhq6G+bH8fCB5q6zi0IHWWU48UgXM7GUOJ2M5qSkwhl8zVrpCgJY2UCskQ3Qg1eG9ReU9ezlYiCIMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXMbcBFZLFqVNuBtqC7v6BQ9ff/H7NZoeF2XG/B9WZY=;
 b=poVuhDjBA8MORxbM44sr2RjDxMYdoxWf5/jJrLBKgbjtFHMW+rynTvTstfeu8hjFJExf3pf1CkIM9TQ6DbcpPg2cDQtu8mPPyrlLR8wBgywZbGv+KxKAofNCH+qzAH+Pmy2bMsXbyu1n7dHBxlcsm2cTppAAt9Y5IyrdqBePrZmcx+UOIw/jPyCvt9DCcpgJkYErmCiRjiEp/TnkedZ7QBkhv6u9Ar7p2pZ40S+BzATCRR1TQc02+ne5DgnEQ7VY8F0e6zFYgxcFKzyZX1D5nQoS3RbL9vll9x6uMXERKw9yqUwJk+WsWOIVZCU6vwnIcSiDazkqsWsrdDlc6jWw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXMbcBFZLFqVNuBtqC7v6BQ9ff/H7NZoeF2XG/B9WZY=;
 b=gs6PwG/cpUQFVL0lFbw+VLqmJjt6dSEHfJRXALSg53ECY62vX5rRbASNroihzROSD/+HAovp/bT0ABbCH5QUsjhEdAgryxDrZRvovlv1EGeMVz9lNtjFlJk5Ds+/HmjThEKkijBkSBNvZI++mD3dXXbj70zYYeynBR79EkPsvkU=
Received: from CH2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:610:57::39)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Wed, 16 Oct
 2024 06:40:33 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::68) by CH2PR12CA0029.outlook.office365.com
 (2603:10b6:610:57::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 06:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 06:40:33 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 16 Oct 2024 01:40:32 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v6 0/5] MCE wrapper and support for new SMCA syndrome MSRs
Date: Wed, 16 Oct 2024 06:36:26 +0000
Message-ID: <20241016064021.2773618-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 756b1701-f75e-4aaf-769a-08dcedad6f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUXVpuco2pGJ9yNVJ8034s1heZuhYNyRj0xB+kDRvx5p3BXgOGD0hQ1LxZkI?=
 =?us-ascii?Q?snHr3YZjAiQ/ps9g/X70oPbOK+AlYo5iMVSmgrhqoEzKCVZ3Zbzx2yjuGUHv?=
 =?us-ascii?Q?p6AHwbTPaZJYc8xSIzu35nc2Ccn4eTIX3bGyW4WJQjUzcmwh4A1hsDv5E+MI?=
 =?us-ascii?Q?0f0cJEToH2fX/UyAsSmDUGcES3dZNS0OXDoGkoyKC/vwhk6Wbc3Qyhi7O9Fr?=
 =?us-ascii?Q?qkc++ZM5wvwrK4ieN8nF7ypdv5/HUDr/oqLnvFeH0CGgP39lB1U05UpsI/2r?=
 =?us-ascii?Q?0Gx+PB835wB8nG7ijnTQNKsG/k8eqO+icUX3wDXnZit1QtXuVUwav+qbDbOU?=
 =?us-ascii?Q?CE4PGvVcLiucKehy9J4KIPS66vlOdYrmYivjUkk8azNgwLtwjXioslCyAmgd?=
 =?us-ascii?Q?BWPbHcQ2xrhM2OwQQtgMcjYhc1pABjzAJW9KjzBDu1FnanGWqfnh2glV6fuD?=
 =?us-ascii?Q?8GncHdN9cU2E0xc/9qMIjZ17R4Il0rpSFUNW/sExAvp8tqxLwy/Ve47FCJ0g?=
 =?us-ascii?Q?+98NkRv+DhhnnM04EM2ZAE7WkG0mbwTOXZNGLjVj23L/0OMDCaFp39VrjLMU?=
 =?us-ascii?Q?Ox832ED9kOouECcCQocXkM6NawBJMiJ2l+2TOo+BUXl6zzSUeywKinxwkgcJ?=
 =?us-ascii?Q?QNC9HY2zsqmTyZt6VMynmjMFfW0gz4PfIflejgLos5AEWSRrOVdP3ZAq78kr?=
 =?us-ascii?Q?xfUA2DxNF7M6mh9e4VgaRH+2PoTRI+LlcMENITrgCceVlN5Ixj/wTv3vruQA?=
 =?us-ascii?Q?6a+8KN9TiDIqFPexAoDTbZ3YyqWF2SIpa0hCdqcxwOKVj20TZ6JcqqQJjMwi?=
 =?us-ascii?Q?5EYQS7ANjbNiI9JapYzacJWVjoB3JGaMxMlJTiaMXnGUZZKVNxmo/M18FDWU?=
 =?us-ascii?Q?CJaBxnd1YRZU9YrwRcrge/u3YPuzF9Jian3P2JUcyIBycA7HRsgWPBB5UXmY?=
 =?us-ascii?Q?EG68wjNlvOZIms2TqJ+nlA86sjFXLXMKwQTGLhM+yFNzmnXks8H2REvyWw/h?=
 =?us-ascii?Q?MGnTVSKcYEcGlmCrnm3mK5gLwkVD45SYgZgEwYygqgDcSmLAguJSFwNoCBH6?=
 =?us-ascii?Q?2i6t63pTiq06rH/lbmabI5Jt6SWz9Kge4yL6exJxNkJslLBAjtu1ws7ACkZR?=
 =?us-ascii?Q?S3AqyeqC7h+KU62hKNDMxP4hzKOfovQsp4SGrikZE7elJ17ykg09WvKoGQvY?=
 =?us-ascii?Q?HzOCiLddza1kVBtbL6pdFxYk6Zr5xHyaEe8pDANQvBKHCaaPu37C9PVK1TCu?=
 =?us-ascii?Q?Tq623CmFyaEmqMfTHxRQHatKtX85w49d8ReDCheCOixP3E7Fz08YiS37W9rf?=
 =?us-ascii?Q?pY8NGQyR4TBiwpOXD3md98Ph8V9k+6/xofjRygknkGnqGe7SsrFJysMJKSWs?=
 =?us-ascii?Q?Pc/Yi1X+kRbikcraSFLF/18A2877?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 06:40:33.4342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 756b1701-f75e-4aaf-769a-08dcedad6f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791

This patchset adds a new wrapper for struct mce to prevent its bloating
and export vendor specific error information. Additionally, support is
also introduced for two new "syndrome" MSRs used in newer AMD Scalable
MCA (SMCA) systems. Also, a new "FRU Text in MCA" feature that uses these
new "syndrome" MSRs has been addded.

Patch 1 adds the new wrapper structure mce_hw_err for the struct mce
while also modifying the mce_record tracepoint to use the new wrapper.

Patch 2 introduces a new helper function, __print_dynamic_array(), for
logging dynamic arrays through tracepoints.

Patch 3 adds support for the new "syndrome" registers. They are read/printed
wherever the existing MCA_SYND register is used.

Patch 4 updates the function that pulls MCA information from UEFI x86
Common Platform Error Records (CPERs) to handle systems that support the
new registers.

Patch 5 adds support to the AMD MCE decoder module to detect and use the
"FRU Text in MCA" feature which leverages the new registers.

NOTE:

This set was initially submitted as part of the larger MCA Updates set.

v1: https://lore.kernel.org/linux-edac/20231118193248.1296798-1-yazen.ghannam@amd.com/
v2: https://lore.kernel.org/linux-edac/20240404151359.47970-1-yazen.ghannam@amd.com/

However, since the MCA Updates set has been split up into smaller sets,
this set, going forward, will be submitted independently.

Having said that, this set set depends on and applies cleanly on top of
the below two sets.

[1] https://lore.kernel.org/linux-edac/20240521125434.1555845-1-yazen.ghannam@amd.com/
[2] https://lore.kernel.org/linux-edac/20240523155641.2805411-1-yazen.ghannam@amd.com/

Changes in v2:
 - Drop dependencies on sets [1] and [2] above and rebase on top of
   tip/master.

Changes in v3:
 - Move wrapper changes required in mce_read_aux() and mce_no_way_out()
   from second patch to the first patch.
 - Modify commit messages for second and fourth patch per feedback
   received.
 - Add comments to explain purpose of the new wrapper structure.
 - Incorporate suggested touchup in the third patch.
 - Remove call to memset() for the frutext string in the fourth patch.
   Instead, just ensure that the string is NULL terminated.
 - Fix SoB chains on all patches to properly reflect the patch path.

Changes in v4:
 - Resolve kernel test robot's warning on the use of memset() in
   do_machine_check().
 - Rebase on top of tip/master to avoid merge conflicts.

Changes in v5:
 - Introduce a new helper function __print_dynamic_array() for logging
   dynamic arrays through tracepoints.
 - Remove "len" field from the modified mce_record tracepoint since the
   length of a dynamic array can be fetched from its metadata.
 - Substitute __print_array() with __print_dynamic_array().

Changes in v6:
 - Introduce to_mce_hw_err macro to eliminate changes required in notifier
   chain callback functions.
 - Use the above macro in amd_decode_mce() notifier chain callback.
 - Change third parameter of __mc_scan_banks() to a pointer to the new
   wrapper, struct mce_hw_err.
 - Rebase on top of tip/master.

Links:
v1: https://lore.kernel.org/linux-edac/20240530211620.1829453-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/linux-edac/20240625195624.2565741-1-avadhut.naik@amd.com/
v3: https://lore.kernel.org/linux-edac/20240730185406.3709876-1-avadhut.naik@amd.com/T/#t
v4: https://lore.kernel.org/linux-edac/20240815211635.1336721-1-avadhut.naik@amd.com/
v5: https://lore.kernel.org/linux-edac/20241001181617.604573-1-avadhut.naik@amd.com/

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Steven Rostedt (1):
  tracing: Add __print_dynamic_array() helper

Yazen Ghannam (2):
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h                 |  38 +++-
 arch/x86/include/uapi/asm/mce.h            |   3 +-
 arch/x86/kernel/cpu/mce/amd.c              |  31 +--
 arch/x86/kernel/cpu/mce/apei.c             | 109 ++++++++---
 arch/x86/kernel/cpu/mce/core.c             | 217 ++++++++++++---------
 arch/x86/kernel/cpu/mce/genpool.c          |  18 +-
 arch/x86/kernel/cpu/mce/inject.c           |   4 +-
 arch/x86/kernel/cpu/mce/internal.h         |   4 +-
 drivers/edac/mce_amd.c                     |  25 ++-
 include/trace/events/mce.h                 |  49 ++---
 include/trace/stages/stage3_trace_output.h |   8 +
 include/trace/stages/stage7_class_define.h |   1 +
 samples/trace_events/trace-events-sample.h |   7 +-
 13 files changed, 334 insertions(+), 180 deletions(-)


base-commit: c65649d7deaf077c9dd4141a7414f215b9ea3f88
-- 
2.43.0



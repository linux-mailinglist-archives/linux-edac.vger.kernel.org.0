Return-Path: <linux-edac+bounces-2186-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFE19AB712
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 21:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279A22849C3
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 19:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93DD1CB512;
	Tue, 22 Oct 2024 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qAPWIx8F"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758C1A2547;
	Tue, 22 Oct 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729626143; cv=fail; b=jkPXOyFZh2LRxDEvQKEfhmbBwuINBnTpGTXgrlaLwUAaDOsS2RGTaW+xC6hoPcUBoo9FmGpVDlkjNvSGkIFYGBpCoX5yg9fjYb+bV/8UEeojXO8Yj00+sP15wP6Vq8ES9gNwXyROnX+zjca89weaXvlHeP8ic1ld572wfDYbrMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729626143; c=relaxed/simple;
	bh=hD6g1RuI8DboAtdoGiDaqhlO/pu4+ntreUChx6I5aaE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Vt6ngx0OZO9B7yPPCkROEnFK3SdgGHLQ+/JEbIJejfpNGt8Wb+faShowdLlK6vkrKb71owThLDma7W2AVgKDcJCvCsgk4LRty1n0CFWYtSoXjrQkjmugjSC2bJpSaxYKSDWP3HHMBF7o6NEr+YzqxBtoONrnprqGC8ZIGmo+9z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qAPWIx8F; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chwU+NS2Gb5WuIroAl4xa2dFPXfDPsl0cbmwHe9ZuDBi/byd8HcPGxIQ22JTFK8DiCR5hP7nSUiXf6ZbSWXXqITRakSw3mpPU6Ton9qC/30Mj/FInovZ+ExRZ7e+Y5Y+xPBr0MYVEotM19WtJLgAT9albVVlhijUVIJhCApSVQ4XgNYWPaxs47XIlqKsOx3Ov/Ha7ndmRpLOQFRG3VgU5BJSaSDpj35bP4oQLneSGfXqy/9jXdWjRero2JcmDwQ9+BWd5ecgBPi9m3Cs91HQ0iYvOcbWIHFrpiIPp6pvyaIRoxMJDOpGbuAcnXFtkss6Q55d8aD9lo+Kmlp7HeJz5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSxr08FMIH5I2zUA5rY080r77IIqXLmdvXWinhS+Cls=;
 b=X3UXVqu4j1uv52YOeGj4wl4oOwuixa2ATfUSlrIHf6HqWK1zLcaf0kbtVpKeV/yGu04eDc8Ba6gYzqI+1E4H20D8nGOwxjOsI8UMeewZGTNV6CPrhSZYotqHYVG08MkhVgt1VNtJ8XyDR6Lxx5fzxcPSyBZ8ddcyOZ/0fG7EHlOTDL3g9HTmjt1TSj7YZ6XNT2fNdzs56uqYZ/slea1Nyu5xNYphsa8DBuxz6Tut9rvER2xct+8oqlVpTX7epnYxuHh7eAbVkyB6UUvMEel8eEh0yfDCaN29nwnPTjUJrrO/eT25kBtipMQgRXE3JwvY0n5EG65vtAb0jmwogmeAuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSxr08FMIH5I2zUA5rY080r77IIqXLmdvXWinhS+Cls=;
 b=qAPWIx8Fuk4YFSbAPwZTpAySBSVvMd0raMZ9AC2J6ZXjWEr8y7z4w56VOCFR/qTGINr/hDrM9lOwGZjqYs+oWKhd8z+xNdR7c8aPFqB0Zj8JtizuVevb9npx47R+Qa11LJzryUcuJfsuUEWbJ1eIPke9lnQ1iPwukRjTyOQ705M=
Received: from SJ0PR13CA0099.namprd13.prod.outlook.com (2603:10b6:a03:2c5::14)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 19:42:14 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::82) by SJ0PR13CA0099.outlook.office365.com
 (2603:10b6:a03:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 19:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 19:42:11 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 14:42:09 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<qiuxu.zhuo@intel.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadhut.naik@amd.com>
Subject: [PATCH v7 0/5] MCE wrapper and support for new SMCA syndrome MSRs
Date: Tue, 22 Oct 2024 19:36:26 +0000
Message-ID: <20241022194158.110073-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS0PR12MB6583:EE_
X-MS-Office365-Filtering-Correlation-Id: 024351f1-0838-4394-7ec0-08dcf2d19f2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmS4+b4B9mGsxsyBrgeXonDe/Nb1RuREOUJdReFw9aQrcFe9oq73x+ZcCXD9?=
 =?us-ascii?Q?ZF/ZsxXBZBlkb+N/yUYnj54dRYgypN5fojRHWgB63F+QtuDgj4i51TPAlL+M?=
 =?us-ascii?Q?yox+AZRmacbqSDiaHDbnrTzStMz50fxEuwy7DPbF4OtKs1v/XyMs0Y3kvI+0?=
 =?us-ascii?Q?3Pb+0S32vdMKi8P5Odleo85JuN40xt1StLM2fpJeHt8GPLNm1VXISkS6uXlJ?=
 =?us-ascii?Q?a5VFpB4y6b0rTLCIUvr+Xuy1Rz9aLwRLtoh1E8q6I1vtr/e3LmIFsErlt4Et?=
 =?us-ascii?Q?pn8jHk0CTUIDAYw1ejdiXBep+7tO27JQBtY5lKNN6EJBh8ysdNx43nnVY4b2?=
 =?us-ascii?Q?h9H4B9D9zqaki9oibYk07PW17KFpdZ77YFFl2bucMCqd1bbD/WXHWutTrLom?=
 =?us-ascii?Q?tmi8R18Bd2dxWvfDORQdtlyeGf0e78f7w9mn51mSpOFhIiIP24AymOvKPHk2?=
 =?us-ascii?Q?x8tipS57Vnuz6O2hmFTU/HD6T0v+MuJmrWadX0XMWyXmLWfQc2n+htt0Yz8/?=
 =?us-ascii?Q?xvWejPfQuItJSWK36K0gAWEzybd3OofY8XuGfBMpRwpnn6rROHtoeyju+a4a?=
 =?us-ascii?Q?c2zCZ11CLZf0q9ibo80YOtWMrFapzEZcAv4Ck5nl+WTTs3cekiCQDwE/OzAJ?=
 =?us-ascii?Q?HwSoYpLibnINAXVwFZBT8I73QRRLsQ+eQLPDGWpB6iy7kMlvqh4oOsZ8/8ix?=
 =?us-ascii?Q?hlf+bpDX9Jp5VJIKqUtIiO5hfhJhevxM5fmNg6r6rNG8eU6sONZd5kOLN2ea?=
 =?us-ascii?Q?diw5cYfrp9bJ8MoLplhElYKCSzX0FQt75Pp5QJlZ4/h0Y6om38+XygHalT2y?=
 =?us-ascii?Q?jBtSsBIErEYwEPcj83sGazm+sYgepRGdUxHbFfeKS3nexkMs5GxV9A7W4hSZ?=
 =?us-ascii?Q?N4LUspcTwETkT0WPP6XY/UYke75llCZdoinDwSuxwa7NMifNszVW/2SLkQ4C?=
 =?us-ascii?Q?PEcw0wzLJ7YBOngOxunXAjW/S7xKnjgHjSJ4IZvgDg/zKLtyZRm9SRsTh0NR?=
 =?us-ascii?Q?e+ZnLWgS7p8qGWomyVVswB+oLpEmNq+h3aOZRxKYD+7dppvjjMYtjDODgYFz?=
 =?us-ascii?Q?5hWJDZxS4YIFrUx4YyXokSI+pp8ZEsSN0zZcwsr10wKWbbSEDwYPnKXTWldH?=
 =?us-ascii?Q?M88OTt2Pn33sdZP1B724/X9pMn481DdE+y8KIIeDCzPJO2j1MihBMogY7Kob?=
 =?us-ascii?Q?iIbJH2qL56kG6k8MGwSbzj8MYwqNKKQe+4klnpIT7Mthb26ZW7KwkVuwbwnX?=
 =?us-ascii?Q?ZJ7/OkcAxaa4s9ZJtu7PLb9Ltc1JxtC++53PTUHqNafvSUSuuI3JtPkVYAoP?=
 =?us-ascii?Q?mIViQXgsbwS4w5iTqf/umdPsA1sKiYcEU2g11ZOF+xM/JxQit4Dj4axyhQog?=
 =?us-ascii?Q?bs1uD6hZ5vaSoD6KMRaMqRIz9IoX6DfJSLrLjEcjeyKfgi1pKsxDOia5UqFD?=
 =?us-ascii?Q?ntHBQSpuP7U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 19:42:11.0407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 024351f1-0838-4394-7ec0-08dcf2d19f2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583

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

Having said that, this set set depends on and applies cleanly on top ofthe below two sets.

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

Changes in v7:
 - Fix initialization of struct mce_hw_err *final in do_machine_check().
 - Add parenthesis around el_size parameter in __print_dynamic_array
   macro.
 - Add Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com> tag.
 - Change second parameter of __print_dynamic_array from 8 to sizeof(u8)
   to ensure that the dynamic array is parsed using a u8 pointer instead
   of u64 pointer.
 - Rebase on top of tip/master.

Links:
v1: https://lore.kernel.org/linux-edac/20240530211620.1829453-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/linux-edac/20240625195624.2565741-1-avadhut.naik@amd.com/
v3: https://lore.kernel.org/linux-edac/20240730185406.3709876-1-avadhut.naik@amd.com/T/#t
v4: https://lore.kernel.org/linux-edac/20240815211635.1336721-1-avadhut.naik@amd.com/
v5: https://lore.kernel.org/linux-edac/20241001181617.604573-1-avadhut.naik@amd.com/
v6: https://lore.kernel.org/linux-edac/20241016064021.2773618-1-avadhut.naik@amd.com/

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


base-commit: d7ec15ce8bdc955ce383123c4f01ad0a8155fb90
-- 
2.43.0



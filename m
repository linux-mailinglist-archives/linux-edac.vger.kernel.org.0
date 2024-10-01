Return-Path: <linux-edac+bounces-1945-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 403A598C524
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 20:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6CB52845FB
	for <lists+linux-edac@lfdr.de>; Tue,  1 Oct 2024 18:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4B1CC882;
	Tue,  1 Oct 2024 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nD+S/B/k"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269220DF4;
	Tue,  1 Oct 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727806592; cv=fail; b=n8QXlqrCat2NRCOzVCbdLyFnJsO0ihA/52l5rkk1Gc9+H8UdbYNCRdYh87E2kfi+5aK+izMH92tQsn0bfj+j+bzpLclREeZxGJyanooFBALLQeaSQSxAPonzzBL/Wwbd70+0fIo2m9Yqo736w80RvfAEuqMkiJnae2wHMAsfpEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727806592; c=relaxed/simple;
	bh=7IN9QkV2SRHL+hJtmWYdCDUp/nqdyiOSZhxrI4A55IU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LmO9FBfBFkeglje+sbnUt6XHxMWfy6Z0mM2O56EbmaJXQOCVjTha+Ib0Gs3r6gE598hcYQ2dGEGlY4+yoqs/WdYUk48yIHVrRVbjO+p+X/XfJ8jwHCPhwpgtViBe0IvcuT3TAHKo81+MtYnmmfyldeuyyFto1x1B49hZxuvIaC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nD+S/B/k; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Didg9PUSjFXzw9C6KgMeoe3xyv+HquDUeCd5yN3Y/J/1cq1w0103NfO+vmdcKdNxG6Zka8qMKijXiKVCscRsCh5W/PX86EWzkGsaiY/zdBPvxv1upM47UQZsuzZ226yoMKtPV5zWKA1RRWtP0M2JsVoY+foxSxe6vZJtmnC9jvO9Ht5Y/gHmk7HPES+NCnbIv9AIcltpljp0oxrIEbhEOPRNrW5Xl1ocaqqRop+cdLu3713VLGQSEuW9hgsPsIqQqLJIIT43qRNoJV1iariKPa5Jx0uZxX2tNsrqMSay15R8VA3AGoY9T4KhjX+2j2rjrGdld0uQGfqCCJhvkKJbDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTvDp1zJkovPAsbUE55V4reoOJcLYBzZs8GLbBZR4V8=;
 b=bMBKRXE7YniQtptR+dNpB8Ppju8CTU4dcYf04hiaZkluhHx+R3V4um7IlTNpNCdiZ5hbPQHQIQjkg+HX/F+NNECoHFQ4r2eD8s9OF6ytdY96OonXRkYybWpmg60pllEe1+Qm9nPsG8bSMZvWsfUWa/fOQ7StESfKv1yOU/Cj3VIpTvHY7YnMiD3BilOrvMq9qQSXUQPUq6mbewDR3piusgR0GfYQlsEmG87WdNlcM/BVyCOjOGwFWYMKGZRDWnJloov8lXf2Jh2CtbNuFFIJBajpyX1A6Uhq026IjX1gTU0izizcJmMgwr7v6PJfFVpt4Uw/H0K0KvdjD95LyE/GDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTvDp1zJkovPAsbUE55V4reoOJcLYBzZs8GLbBZR4V8=;
 b=nD+S/B/kT/r5S6HjIjWPo7YuFH7NmTXRNrVEFtULT/DjRS1v6GzCXnpqOyYM34S23Sg9/7PL5vWLHWy0OTUoFzOZNTZjaUnFp1Y9GaWEEegqEC2Ue9l9AcXxdMVKe6DO4HmiQOUHBBZwuyS3icB3AD8GEHuo3cm2TFJzUS332Ro=
Received: from BL6PEPF00016415.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:d) by CY8PR12MB7415.namprd12.prod.outlook.com
 (2603:10b6:930:5d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 18:16:25 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2a01:111:f403:c803::6) by BL6PEPF00016415.outlook.office365.com
 (2603:1036:903:4::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.26 via Frontend
 Transport; Tue, 1 Oct 2024 18:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 18:16:24 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 13:16:23 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v5 0/5] MCE wrapper and support for new SMCA syndrome MSRs
Date: Tue, 1 Oct 2024 18:12:24 +0000
Message-ID: <20241001181617.604573-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f7aa01-7a6e-4fe7-c639-08dce2452907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FstysShU3MmzCkHlfeaCVcUHXIHJQ5y7sa8u6BZPI3BD16+ZatmGnvkcEhE1?=
 =?us-ascii?Q?Norh0XDAeQPyX2jCv7860AIi25jqhLxvV5oIKjY8qc4maZmLNn6A7M2rID8v?=
 =?us-ascii?Q?LlJwrtBTGKuGMdYvgXadlLs8A0vg6x8e76A4W1LywDSi9b/WzcJMKTTMygab?=
 =?us-ascii?Q?mBaua7DyuYoolSCLjvv/e++8tpqXzp7QmE0O06A50W07kX8qchIHSaXimKZw?=
 =?us-ascii?Q?JhCZClV3+jzCltxt62fzjW2Kf6CVUjGcudJTELbLmDgiOWo/H95sI2yg4U0U?=
 =?us-ascii?Q?ANMotz6jNj3ttgnwNoTe5PM/v3Akr4EMO4lW2n7Bj2QaCiQRzc1ntq9sAymd?=
 =?us-ascii?Q?AomHwuhWwNXyQV+Rh/xp9jmT/hc34wzRGuta+AzxDHFciZQOqn2sQj8tExHV?=
 =?us-ascii?Q?ovJ6qNIVWvNOxaWMxuNZjEWyTBr51oybhHEdinb2zC7KEiIHU5yxvT1JfJ5U?=
 =?us-ascii?Q?rflYuzQZRNXORY8tYGlcLdoHZToj2Dp4STI07oKzBuFhxmVaJ2bv5ytg0XHN?=
 =?us-ascii?Q?xV6MJ6HQtpGVS5luEu1BVctTKCaH3kVL9a8p/f/JXj99hVRuOhCBRb5tPN8j?=
 =?us-ascii?Q?cuY5K3VBAPjut05QpTheIwnb62+BntOvmu1oW1CkzSl3kwjsLw7PC2nd0NxN?=
 =?us-ascii?Q?emIv2vLHMJ/fhsEewbSQI5RZjW4s+4YF7QMV4P+zaFIZy6M1YgKw+XFX1/Vh?=
 =?us-ascii?Q?7z7SaQhist/qUODDNXRcE7OGDR5q5dUIk9jJTn6yyFIgHq2fig7E9Lfgu0v2?=
 =?us-ascii?Q?e0OFplqPJnnmAWBdBtzRk+GJrwksvS+dtWF6bEQoV6fuSckMJ2XMfhEswb4t?=
 =?us-ascii?Q?YUiTmF+dG6M6waw1sm5NzFVGfEHZjVwBR4tmoQu6i6OR/63KubyilTsHB8al?=
 =?us-ascii?Q?G/eSGqkj1tiD1HfnDcho3tWgxkYXAgffxll95GVKOMZrF5rwi4nq+4JhQ5cy?=
 =?us-ascii?Q?3dvH5wOQ4r8Zp/LFp5GE1YZoagZWDaFCzW5SfvKZnv35ihTqmUA1xJmIP4rW?=
 =?us-ascii?Q?caZ9ktE3bY2imQNEc5I2H2WVVb82HEByjidBMDt6OHbrHY33BTR+euvKpkn1?=
 =?us-ascii?Q?IPIuAejebkuwgqExPH+9jsH/4VuHvonc58bT+oMiQEGKOX5hEeEJIY0a8+cd?=
 =?us-ascii?Q?+Dd+PTofBb1CdyUIt2UlmEhW2J3hkX40ff2QQ5eO6ZE1x5vUjr8sdprfNea7?=
 =?us-ascii?Q?Z1lqapRj4ZrzjY6xDODoiRW2meoKIB5AUOqOFj8dw8zTarWoWJSFNmO6D4Ei?=
 =?us-ascii?Q?DMh2+s/JzN6tC8P4/q7Li51gko3Ow+KsuUuIgj0xevGDt4gP4qIlhbemDtZF?=
 =?us-ascii?Q?tfPFLeSol7+atiZn2hhvdyPGCrOzAnEwvZo5Od1lKfh3JeaP1c0jhkcmTHs3?=
 =?us-ascii?Q?abj0i3HnlFQij4QbsOeOEfaoN3Xe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:16:24.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f7aa01-7a6e-4fe7-c639-08dce2452907
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415

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

Links:
v1: https://lore.kernel.org/linux-edac/20240530211620.1829453-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/linux-edac/20240625195624.2565741-1-avadhut.naik@amd.com/
v3: https://lore.kernel.org/linux-edac/20240730185406.3709876-1-avadhut.naik@amd.com/T/#t
v4: https://lore.kernel.org/linux-edac/20240815211635.1336721-1-avadhut.naik@amd.com/

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Steven Rostedt (1):
  tracing: Add __print_dynamic_array() helper

Yazen Ghannam (2):
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h                 |  36 +++-
 arch/x86/include/uapi/asm/mce.h            |   3 +-
 arch/x86/kernel/cpu/mce/amd.c              |  31 +--
 arch/x86/kernel/cpu/mce/apei.c             | 109 ++++++++---
 arch/x86/kernel/cpu/mce/core.c             | 210 ++++++++++++---------
 arch/x86/kernel/cpu/mce/dev-mcelog.c       |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c          |  20 +-
 arch/x86/kernel/cpu/mce/inject.c           |   4 +-
 arch/x86/kernel/cpu/mce/internal.h         |   4 +-
 drivers/acpi/acpi_extlog.c                 |   2 +-
 drivers/acpi/nfit/mce.c                    |   2 +-
 drivers/edac/i7core_edac.c                 |   2 +-
 drivers/edac/igen6_edac.c                  |   2 +-
 drivers/edac/mce_amd.c                     |  27 ++-
 drivers/edac/pnd2_edac.c                   |   2 +-
 drivers/edac/sb_edac.c                     |   2 +-
 drivers/edac/skx_common.c                  |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    |   2 +-
 drivers/ras/amd/fmpm.c                     |   2 +-
 drivers/ras/cec.c                          |   2 +-
 include/trace/events/mce.h                 |  49 ++---
 include/trace/stages/stage3_trace_output.h |   8 +
 include/trace/stages/stage7_class_define.h |   1 +
 samples/trace_events/trace-events-sample.h |   7 +-
 24 files changed, 342 insertions(+), 189 deletions(-)


base-commit: 040fcc9d4c772223d07972eceab5bfd25a2edbc9
-- 
2.43.0



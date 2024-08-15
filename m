Return-Path: <linux-edac+bounces-1650-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD81953C72
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F326D1F259BE
	for <lists+linux-edac@lfdr.de>; Thu, 15 Aug 2024 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBD114F9EB;
	Thu, 15 Aug 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pg2eGC6S"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C72149C7D;
	Thu, 15 Aug 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756609; cv=fail; b=T2Z50jvLGmY3Go+hI7+87pQiD2acVRScPp+zwdmj/VHgc4Wt1YrXGjrKHRmRHeLvvs8ujsXPmqOc/OslnrfrAwrhaGlOQ9XYhHWlu0TUNox2M+4lC3yxqu7qxbbL2HtmKgNkntCRQbKqLInmqlv+Qu5dwLP99Ykwjz+EwETmJJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756609; c=relaxed/simple;
	bh=47/jaZ/co0wFkJ27mIB8eHq4etPkj1AQSqHmGDIF738=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=siC838xFUXuOo+ddhmYlirp0EB0hZ24vIYXfTDd3ug0SQwYQV7AFrMqH/yoDAe6ygh1a5sodbWZCS2MOhteDB97n+pBRuKtC4d5rCCuVg+vbQoylOYlHIUc9hG1HBGNT2GLmhGaRQchcsUTsZrO5hO37oXsLG1TeJh6553F+mhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pg2eGC6S; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DG1JsexlhD35+NBSefhkIzaNqRwt2DOXTFjLYS0x0Jb7VjrTL86+1sHPDt6zUaANgYlxNmLMx8FrWaPXURSBwgDCPXVnoIjWPjg0vuS70Tx0fyhBlF+138xxYzaeqYwGD3OjIxDRw9sPkkqQldK2pTZL7Sh1aOKTZrRlGSwpxJXYlBnwz1ytwxBflV0KMvbeHzvOatMxwotVo+38F4jV4/J+luKGgz6PCvlEwksDVGfToB+5wReRlvfHBR46YjWSwBiMtCiN/hfp8djjbB4bHbbLiHYklTjOaeGZ/YgEuN+vaqdzzcmm+B/+4vNEE7dyon0im1J1qFdOjY+MHZ3oog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/yl6PzR9t8Km0UD1Fj5udwgS/8N789dzUR9tVg/ipk=;
 b=UtvOb/V/i94E1FbKvZZGhilPRRexNp5RquzmRFNBGNXrMr1ky5DE29C4HxdXMSWBcbs3jVKYyg8LNaqlw1UFCae+21nfkvNLjYVzoH1KHZKznG+DlphTiWPv47WdPE9IWmrtYMTOYcxgbWIEzozMBlqo0d6N9Mu+P7ZbfHocevzS0JjFvLSYHiPwcxSVjSCwZn9oRHOckY+Ux+QbdOfqeYvt2vQBy63RemRuqU2OaD8jHfhn8YZQ8vPKBk7kCZqWDJd4G7Y8wTcSDtQfVn48H4KEZvzA4XF7npD/KXEW5kqJKAWeDkTLdxLsvR+q2U2/6oQ0OgFdbqLhM7/kDP8g8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/yl6PzR9t8Km0UD1Fj5udwgS/8N789dzUR9tVg/ipk=;
 b=Pg2eGC6SdpkftPAhCdwzysJdWDBtaSc2WoWV9SDTcpLQc5L+PHVUM28l+xVxddpWvbj3qmbswZiinEVztZcERJGwfz4s5B67/WD34pHZpOwl7Pj356RZV1W2rDcJnGPpi2FeJsEfG5mG9tCXQ0gWHKzs5pp2aBiQsTSZxUts6q4=
Received: from MN2PR08CA0030.namprd08.prod.outlook.com (2603:10b6:208:239::35)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 21:16:42 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::c) by MN2PR08CA0030.outlook.office365.com
 (2603:10b6:208:239::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 21:16:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 21:16:42 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 15 Aug 2024 16:16:41 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v4 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Date: Thu, 15 Aug 2024 16:16:31 -0500
Message-ID: <20240815211635.1336721-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eea754b-dd09-41e3-d619-08dcbd6f8f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i/RWK/Mh+/caZ+oMabj1t/fBC1mPjN22lWxYgLlulDTF78CvERvh1mJ/iZB5?=
 =?us-ascii?Q?PyXDvCDmqgaeSIOuMMl+HV1NIifDmVXACRhuemlpr1op2iqg4+fKUUinQGIQ?=
 =?us-ascii?Q?XI9CrxkUZIoD7m2T6i7hdVgSvASQHv74+tocCIjcUqCTTgaahg0sSGHOEsP6?=
 =?us-ascii?Q?TwCXPTMbAnSIbfd/Bz5XF7RmIhFTn89R+59fwK4pApMZGilhWF/hBtPPtM8y?=
 =?us-ascii?Q?Wpofx93v1Ae5bxFcMZQTPyb1HP847KPT4hSZDBxTv/8XnrHOkiT300gI3LbS?=
 =?us-ascii?Q?ZvMmp3VkbZLjLYxSBUCV66alhmXj8Mu9+kCnHRAgS+R9wsCesl7TKoGFlhAA?=
 =?us-ascii?Q?EeJ+3mUS0OgGZKv7wnxgu2yRmWTHXJ86l+K150s34hZQnGhLqyMlilrPQWpE?=
 =?us-ascii?Q?WqDTRt2VUaRBZTKEUXCCY24yu4lze+mTE3CLBLdvzOn225rpR5mMAz8OHEsz?=
 =?us-ascii?Q?gzf9MKi5tQOrnpv/nIkT9i1T4pQxUGoO3eavLKijaqec/A8TY8NxWr5ZG09p?=
 =?us-ascii?Q?rJJdG3yRnKeITbOhRTMV64xD/xQOidDSD9FL2FBWShKcSqai6QtDn0Tu/gMR?=
 =?us-ascii?Q?UVydqA/jQhOCMiBCTzcVzYoXLSgctKusPj/qRNcu/du+Wwo1uNoE/e6UpQUl?=
 =?us-ascii?Q?c+hC7jHCUyEPzc/a1PJRpWQGh/A7QxxB6jQqqUb5CmNwdHBF1M3ljKa3rNEa?=
 =?us-ascii?Q?nNcXs1daE454ZrjRKWCbPLzDeGSCmEvCNsBukhlzrmkmvSKLQ+Pt/gV7OkrE?=
 =?us-ascii?Q?9OeUN3G8AtPo0+c+Frezwj82lz/J3dxzp0EW5guHUtnNsnoZo892cTgJmiqO?=
 =?us-ascii?Q?GVSy0PHZOCBIEtTsDuLmM92sC++XgYuIIlC2XMeCg1RuLLhOBEhUHStNv3VC?=
 =?us-ascii?Q?qGXoEHiD9+qqTF6L2Tluww3NHqBnCogR1IEF+njp2FAPDaamKJ6Zm8U9ThjV?=
 =?us-ascii?Q?dwc89x98bOldreJS3Ca0Wr1i8/eKvYxuYTlTlcLH+GypO1OgOTPXxIJ2lm9T?=
 =?us-ascii?Q?dFeeilRzXhVrFY8jMh6Hf2yfGZB+Wh5RyunEX/WsYgElX98HkwuGJXqm3ER4?=
 =?us-ascii?Q?gyIeb+43XSwm/1kX/WXidtU/WWa/FOW2Xp/x1E0Otm5bTB48lbX5jGGomN4t?=
 =?us-ascii?Q?KB2exCUvDacj4xW6kr9TlMEwgzXXVqgXti/fpO5nJnEXJ41W+b6eCz9d4Ntm?=
 =?us-ascii?Q?2MFx27lt+pGP2s0GSPGnbpMgcU7Vei7IeYdizJylhPZ3J5FrNKA6gvGSrQFC?=
 =?us-ascii?Q?e41fa/NbiYhev68wzBKo1Eov83azl15ugbJvl/1uNj0/iTG2lXtSncVEE2cC?=
 =?us-ascii?Q?bKREKtzFrkNbddwCSbNW1URndlIHMyB8plcI033dZX+GACqNxTjfGAO2Fi6C?=
 =?us-ascii?Q?X9QKyJHwXFsQex0rpWrYRJdJHLi7U1Kldpyblnk8ZofnER7vg+5stJHtAulg?=
 =?us-ascii?Q?70Ar0KsTGOCob6sk9W3kcI/ecf5FAFLkD3QksaaI8fF1beTVYzcBVQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 21:16:42.3559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eea754b-dd09-41e3-d619-08dcbd6f8f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

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

Links:
v1: https://lore.kernel.org/linux-edac/20240530211620.1829453-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/linux-edac/20240625195624.2565741-1-avadhut.naik@amd.com/
v3: https://lore.kernel.org/linux-edac/20240730185406.3709876-1-avadhut.naik@amd.com/T/#t

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Yazen Ghannam (2):
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h              |  36 +++-
 arch/x86/include/uapi/asm/mce.h         |   3 +-
 arch/x86/kernel/cpu/mce/amd.c           |  31 ++--
 arch/x86/kernel/cpu/mce/apei.c          | 109 ++++++++----
 arch/x86/kernel/cpu/mce/core.c          | 210 ++++++++++++++----------
 arch/x86/kernel/cpu/mce/dev-mcelog.c    |   2 +-
 arch/x86/kernel/cpu/mce/genpool.c       |  20 +--
 arch/x86/kernel/cpu/mce/inject.c        |   4 +-
 arch/x86/kernel/cpu/mce/internal.h      |   4 +-
 drivers/acpi/acpi_extlog.c              |   2 +-
 drivers/acpi/nfit/mce.c                 |   2 +-
 drivers/edac/i7core_edac.c              |   2 +-
 drivers/edac/igen6_edac.c               |   2 +-
 drivers/edac/mce_amd.c                  |  27 ++-
 drivers/edac/pnd2_edac.c                |   2 +-
 drivers/edac/sb_edac.c                  |   2 +-
 drivers/edac/skx_common.c               |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   2 +-
 drivers/ras/amd/fmpm.c                  |   2 +-
 drivers/ras/cec.c                       |   2 +-
 include/trace/events/mce.h              |  51 +++---
 21 files changed, 329 insertions(+), 188 deletions(-)


base-commit: 1d00f3427bfdb9f5b7a817b1f4f44c5b02da3edd
-- 
2.34.1



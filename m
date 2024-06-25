Return-Path: <linux-edac+bounces-1366-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E97C8917200
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 22:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D03F288597
	for <lists+linux-edac@lfdr.de>; Tue, 25 Jun 2024 20:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009217F39F;
	Tue, 25 Jun 2024 19:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AmIBiSxT"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F24317D890;
	Tue, 25 Jun 2024 19:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345403; cv=fail; b=dAkEiKh6PE0Nnq3bo+4J+Eco1tYqsrd/VOsmJu3wv74Gv7trsx7QSWtzjMNnO+iRMNC2DxBXA6VEJTCjidPUV4Cs8eAfpcWGI2gaXKV1ga67dGzZ7oD+eDFPs+bNoGEIORMYFb2JYkUFKB6avDTv1Bnu1INx8JDFcKk3cAnwn/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345403; c=relaxed/simple;
	bh=uudaWzmxCLdLwpWh5JOObl0j8crt58QX+KPfoTnPQEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBMoP0KNQ4CTKlOIvDFl2yVRHJdl5hsQtYhtMU/962tTnZd6V2gaSUdCbavurzYUeeP+EsO/TOt+X/N+WYA4GDbpgbByPP+r7mcfTx3hUhH/61/E630IsMzJYl3aw34usVpqEKZIv5w/arI056H8R/bGuMGpJTEGUj8nQ9nsUrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AmIBiSxT; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TxlaqWXxXO9KHo73GafLd+tkaIcO25d4CyI3Dcas0BlKPj09+AZbDOxIbaUxP6ciAu/fSJyK2QsNXruLOdCIF5pHeIxJpyZkNzMtNsk25ziKiuqrxH/0VYN+lckAAVZFLRAX6B4MjGk0xaXQVE4C/uetolz7lQrgri5kO/738TtgqZojsbtOV+6FG+nqUH2n6XQvZ+/OhsPxMI1siKmlT0tuafV01Hs8DWUEDf8NB/Ka8jbYUp0FDzHNluK/xjGGFlMX+ex2lrekvRq0Fr4S8eHfEqOSb6F/WlP4En0XdDwFSAIfaF22DlKhB622rVV4YdIngu8oc/hgA6FKXRJxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/y+emeftpZYpkKaCIvVDoMqhpsrGRP4HPJJm72ZGYU=;
 b=gVslZ1/79K6Pe4jK1ntruMPOzGdNHBemMeqJbCDvyrWYkBtVHcUrG3kkTyjQFpbUfYPCBr4aAgwJKdcx/3fQFO+6tOyhmzbTkC189Vbk3ZivsWzZWOQp+UpTfLHBLMa1Pc4TxBb7AAFKDQExXa7SbnzILA7fNs6PWX5xJAQKFD+NMH3eyCpZJNvFjfU230aIDp+JcQU2tWySeaa2mquYUj7ON85kfIP60XkZFWMxCss9J9pAZFDMEeaKxAwXQRGf+cHEQZ7pke9iHRba94oBtYDzxPsdE1tNssb6MtTb4NlE3SW1UBruQs746WE87RTYNgiD12DbmHKa/OTWl8gMtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/y+emeftpZYpkKaCIvVDoMqhpsrGRP4HPJJm72ZGYU=;
 b=AmIBiSxTkj4YeE8/CSP67DgWGvxREjs0X/LAcy6uOsO0UvUIBjE0vWiovws73FFgeitDj1cal2lAvtL1P++IIVuQyyql7lTJk+KTQimlXTETI45BA2KiJ/yJWefAFcuyWXlQtvohAULnH1TKGlDELpCM9oHVTiNkogHLRlf14YE=
Received: from DM6PR12CA0032.namprd12.prod.outlook.com (2603:10b6:5:1c0::45)
 by SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 19:56:32 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::60) by DM6PR12CA0032.outlook.office365.com
 (2603:10b6:5:1c0::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 19:56:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 19:56:31 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 14:56:30 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <x86@kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <tony.luck@intel.com>,
	<rafael@kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<rostedt@goodmis.org>, <lenb@kernel.org>, <mchehab@kernel.org>,
	<james.morse@arm.com>, <airlied@gmail.com>, <yazen.ghannam@amd.com>,
	<john.allen@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v2 0/4] MCE wrapper and support for new SMCA syndrome MSRs
Date: Tue, 25 Jun 2024 14:56:20 -0500
Message-ID: <20240625195624.2565741-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: c7be06a1-20d3-412a-4720-08dc9550e8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|36860700011|376012|7416012|1800799022|82310400024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kog25HFCJlGuljieFJrblAmDr1aMtlV/rxW6TT+dwJwtePphAIMcV0igxMwR?=
 =?us-ascii?Q?pry4fwnvfMUzbn71CHa3hCTqkc3Qhp9GEoU6k4tu31bltt2qIWACW53fQuFZ?=
 =?us-ascii?Q?qeDmKMOw13UDjXiN9b8IULTkygJ//jzAG1KohGQCEA0Rt2claEiraCXYH1Sr?=
 =?us-ascii?Q?TYPG688Y4Xi5+iBxIc0FPtHyeugwr7j1FvGK/vPHdwlXjqHd++EEBSF7O+rk?=
 =?us-ascii?Q?Ed7qiHDKSekQIKl/cGjijIAvUekBppq00yHqDVhhvlIlIaFAjpdFsLDjj+fe?=
 =?us-ascii?Q?nZRmmzFrs3gqyZeoMFXn+U49C+2QPTtUxecmEmh8ZdJ8oJS1rXUAw9ba7u3F?=
 =?us-ascii?Q?fCba92UqSn96TYuQPdKqmgjWg3sGvxDR6cZaEKC2s1GMdlDOUU7C1N/U6Nni?=
 =?us-ascii?Q?ZLZYHkbsvVFhZCLd724I2hwPMkRL02HZpUPzk4pIAQmIVef7Y7GEDk6Yr0YT?=
 =?us-ascii?Q?ILweCVV0LU8ysYc8Zv0ITQEbSobZaU3vc+2LHrIACIf/Iisz8Qh1aZ2fk6kW?=
 =?us-ascii?Q?yaaaMcbfOkGujEzPaodzOL9mzhOEWLsns8wk+kbGcBUGGqkAyMam9C0qXmz9?=
 =?us-ascii?Q?npWBJ3hW0otDvh78m5OAbcPR/ylT3X9N8aVttgxeQ5SFqOmyGrCVl6wkRtps?=
 =?us-ascii?Q?OBZ8RbSFUlF9zHGuD79D0XFtfmgh5+DZNRZSRf0SQRfatdmIOob49SksYYDW?=
 =?us-ascii?Q?pUWNpQNJsnO3bTKpCo+130pONj5SpD6f9KxX8/DFyEtE5kWmB6UYxESX9kJ5?=
 =?us-ascii?Q?+FiRHPy5RtZpMbiVHEIvu+oNJW4kwvA26y+ocKmwIw916285pzPJK9cRy08X?=
 =?us-ascii?Q?mMkgtabd+LTmUqiCjje8nmcAeK5hv+0fh1ZL4tG3RiR2Aj6HfjPv4WjoGvlP?=
 =?us-ascii?Q?Kj/o693rJM7Cbvl0IR/OndXB43MX464VCjXKboNKU5Y98XuCZcEUtJNoqpkl?=
 =?us-ascii?Q?bKgHuujN7hkdJ1Sh4nac1ho85Am1DgXBoxrPwDE3uIKLQXnXJxovVlCgCfJK?=
 =?us-ascii?Q?lOefdsdBLQERbplalht3vyLHjpd6vXkPglh4xgS+68zMLqAQwFv7n2sik6W7?=
 =?us-ascii?Q?y/E5WT7qFWxJooydMVUYnUcOtINciUjKicU6t4PaT63CNzUER+LlCoqzD7tu?=
 =?us-ascii?Q?J0/78REoKbUDB7dzFPiHzHyZgSN6ZatumQpEbirgVxjZIEqmlGMPOvVrjQGh?=
 =?us-ascii?Q?8ZmxyhzjVl+tJmO5nzmtfsXchLf/3/G1WbI+ybvcHyD0PIUJQPTtcm++uP1i?=
 =?us-ascii?Q?qSjGP/KUJdAhNyEWOJC7u4jvk61rCqnT1cpbK+2Zn/WHpk24RD9ERvnSjx93?=
 =?us-ascii?Q?2grtBmyAtEwoS4vhoIAHi3gTL+uRruRFIFEgMj8fZlq2Co1TmPWaTYM19SAE?=
 =?us-ascii?Q?b5LiLDA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(36860700011)(376012)(7416012)(1800799022)(82310400024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 19:56:31.5059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7be06a1-20d3-412a-4720-08dc9550e8da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270

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
   tip/master. (Boris)

Avadhut Naik (2):
  x86/mce: Add wrapper for struct mce to export vendor specific info
  x86/mce, EDAC/mce_amd: Add support for new MCA_SYND{1,2} registers

Yazen Ghannam (2):
  x86/mce/apei: Handle variable register array size
  EDAC/mce_amd: Add support for FRU Text in MCA

 arch/x86/include/asm/mce.h              |  20 ++-
 arch/x86/kernel/cpu/mce/amd.c           |  33 ++--
 arch/x86/kernel/cpu/mce/apei.c          | 119 ++++++++++----
 arch/x86/kernel/cpu/mce/core.c          | 201 ++++++++++++++----------
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
 include/trace/events/mce.h              |  51 +++---
 20 files changed, 316 insertions(+), 185 deletions(-)


base-commit: 4fe5c16f5e5e0bd1a71a5ac79b5870f91b6b8e81
-- 
2.34.1



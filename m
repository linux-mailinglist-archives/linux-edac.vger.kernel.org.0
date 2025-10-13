Return-Path: <linux-edac+bounces-5035-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F49BD5F78
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 21:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B2B2406B6C
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FFE0285C84;
	Mon, 13 Oct 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H9FFs53+"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010060.outbound.protection.outlook.com [52.101.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F62D77F6;
	Mon, 13 Oct 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384259; cv=fail; b=S9FQ8OTIaYRenOmG6XPOf4Y7RRqgVyHnoUyCjV4mYNFvYBaJW/XLc03eEog7bTuxgSRXuPEqg6cqjFWn1cCpcrRBBugLHNefwHCDjMn0UFwW/B933sWhsgpqQpKvUqT8K0RlR57VmzcfJQLMAVIlZlp37L2B7lKFPcEaUt6Flg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384259; c=relaxed/simple;
	bh=I/JXeVig5P3jj9uzpJozNeL05qgq4kjIj79gSqU5NPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Gkt5uKicWpJ1HXfNI8C8S9BXHEVCx1byCloH0KHuPLlLMIW+lTAyzLg1Ee6OhJwSYoqB6Ma0O6QspcSErcW5saYWRppWZPMP0I0RlASmnNcjbQSaAXZ+DfyKEvmaA9kOGOQgkay/pRRIEcoAL+OZGgwfnZIkXWViDg5WCz+eESU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H9FFs53+; arc=fail smtp.client-ip=52.101.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIXJTHyoZ5/LmMRJvdc3AsFMKQHoh5ZBjRZkAnczVdhHv7RrhXjTIQ0S9N2KxIgh43Xs8ZBiBiGNnF/zxKGTMsXFoUlgCeabD2cZ2cseTGzOa/7FlRpdCMeKfER6SWNlc8wTB4X0k25f9632UtIgVeLP1g3Ns4R/Nb12qM2gwABLvNSPP3IA4tJ9iMmc5JGFflXzzK6HUse1IlWB6o/9dOlwSKsZ1J02FzR89UcgyMfKFFdK6VTHNO9ukGUxwlXFOs1Sk66HbTdfjLzoXl1ldxU7t6GoT6xt4oUB/N3P7MYh+EvV41CqPb8s7TZuRScY8YMaAresVlivKF2SvF398w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/NqXdvtXZQGK3J4jUA72dI29SaF5gpR+F7/R9W8vlI=;
 b=syX34/YrNNq5tyT5HUenLCgE2vq/j9VcMIo22zIQMrLJSWSaQAp5JiIkA66ouYmvVY81e5KIt64JTS15pvKqrMxKLzYpkNNhmvgSG1KqzyZJkqj83ZNwE0cXrqol3MJFiLvRfD0jpJF2rOd7FnwaXr0gPzpSeflOGo98uHMK8bK/c6Jnw3vhdhW5M5/b20UgELY31Sa0Z+TZHuOWqwnMuRXpe7nADcF5i/XT/yqK4cOrjEQIWJw6NtyYJRdvWsCmiccJKR/wVZ3RsOmQqyOdIoG8Tsbh7i3gRCVnI0nQLmRTCmUWQj82XfhG3uMwiKSrhy/py7lRa4d7HkoGSCsXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/NqXdvtXZQGK3J4jUA72dI29SaF5gpR+F7/R9W8vlI=;
 b=H9FFs53+ML6h/wFLIRrWO9+DfdujdInp0P/ljVnmsi4xkJ4leEfUYDgLMiHbpJXVB5IsKq0u4CVmJiWm8f0NVGEVOG9i1Bx15GQHyeWZ3zoOB2UO6WESCkC8DsJL+3McLRb/VxnfYGTtvl9MOunVDa9ETjD5W/rvRSmsSQfYbIQ=
Received: from BN0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:408:141::20)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 19:37:33 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::3e) by BN0PR07CA0005.outlook.office365.com
 (2603:10b6:408:141::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Mon,
 13 Oct 2025 19:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 19:37:32 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 12:37:32 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <john.allen@amd.com>,
	<linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>
Subject: [PATCH v3 0/2] Incorporate DRAM address in EDAC messages
Date: Mon, 13 Oct 2025 19:34:47 +0000
Message-ID: <20251013193726.2221539-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c85223c-15e3-46ba-ce4e-08de0a8ff464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmyDThOd5Q8os0qq7UX3nuGbK2GNswy80UpudTfCRaSC9S9R9lBjE8kY+zsQ?=
 =?us-ascii?Q?tO57lcwn6MI/kDgU9I8y3wYE5Dp8MOtVMvQteM8Tty7nGkF4DQ5PFX2mX5yz?=
 =?us-ascii?Q?pahWAwIHmZCc/cacufsd/qpW8fSRqu77XYPAETL1C7OaN9NCKfZGctfwGtDE?=
 =?us-ascii?Q?NJwpX3eaogN1kgk3lqnOf550T8lHouSJSydA9ZSyIaW8JARhyf9S4xi16X09?=
 =?us-ascii?Q?e/JeuKFm0ljogsX3W7IIcZfM86GrHKuICVSWKzgytaciajUYdtogRMkhaxm9?=
 =?us-ascii?Q?7ByKr2Ewg925i8H99upgOMRUYFrpvF/wB4iYDC49dJOKbMJyxP0eOdstFb0U?=
 =?us-ascii?Q?IpWahM4DTyJ3v8Ji3/211ATixzVHqBUgH3ZBj52w7kV2oMhhxp7n7yIloyFF?=
 =?us-ascii?Q?TegD07cJqkMx0wRdecyO2AWIpgamDPG/Lr/lDQ0HVVMGhn/n0BqTswYwYm3b?=
 =?us-ascii?Q?6Bu3wEifcS41Cwh3gRvyIMc4851of0q3JmJ+f9ZlvL6v10phQcdu/V+QRc9T?=
 =?us-ascii?Q?Be7st8RwWxXaWe2vdbtZ/u55jo560cvcUK5JS+C/2UetrCs8NzKK0XSWGcqA?=
 =?us-ascii?Q?/dSubKK2pyFLnNCtPIBbG+uO6U0cEoygDRW+Z6eUSLz1YAp7+2rFFkKIzdTT?=
 =?us-ascii?Q?nnW5SDiRBCisOz3d93Un2Na9Vt/8zD66+XsHYaoqBHosAzRPctw+fDdK59Yt?=
 =?us-ascii?Q?Lk5JOvZy/vK1IesufbqsPHndUewnH8VtHLK4TLmDGmsVUtWxIqWLLOE9TZr7?=
 =?us-ascii?Q?9ZsT3quvwSVjUhtPLWq10E+3RthsFtpz4zIx4U2TgJuG83hMe8iPT2BAxNcn?=
 =?us-ascii?Q?r5LKvhHlXWtR2D6Rs48YbMtlqlTgR5H+LgQXcvEI3G1lj8Yl+6+p4Bc3gFXG?=
 =?us-ascii?Q?Tgn28FAWzT8dFGIPPyILOnmGuEYFXZK9fRI39SVbWwpJh9Y80b5vnMgrdLAq?=
 =?us-ascii?Q?e6ith9TEDFUsmKaW/IovBYkMCYiHfn/hegJ3niSkxxxidv7vU41Z1HACKW1J?=
 =?us-ascii?Q?bVGdRkhJBQGltdiECVi1zz/xXjKkDBtx6WyZiiFmFG9TrBs5aVUeXnqtz+os?=
 =?us-ascii?Q?G9VJV/FvR2qOs4UFZ8SaPYVNBY02cZRjRvn4MF2MOeZY/4RgFCUIqeWOWmV2?=
 =?us-ascii?Q?fRPtkaqQqWcqX9M6MRGYfHZKogeb9oWZwo9+6aiV0MePHMRAvITKykxMahb7?=
 =?us-ascii?Q?ijgr/HVjFK9DgAf/n2w+AxQiN84dkfbem07dlN2cTrru2g009IuvxcjVWIn1?=
 =?us-ascii?Q?tWqTDRqadiTIPsesX72NNdlCgWdmoX13HaVT4RtOpYMUlT7rsbzHpUhIWkng?=
 =?us-ascii?Q?3GFD7Mt9aTKjThCT/w8VOLNR00xmyoKxetTWbaA9RSz3VTueWKEAC9zGYeNx?=
 =?us-ascii?Q?oCb4+5BmczSBtFIk7p+2XEIToDX4K9z4iW+qLdc69X/brHgQQZlowl8xG2IE?=
 =?us-ascii?Q?tv7Zaro8uqSUbj16JgD8vp7ZzagO0ImpLJWpH9kBiyKpxk3YbCYEmuLdfZIe?=
 =?us-ascii?Q?pSE1cOffbyVl3NXS7smkg2pnAZ+tE3PKiQyvxaYKYihm3L5MnUgU9k5L9YQW?=
 =?us-ascii?Q?t1gdKlT/j3sxvUgBO+HVgCugr/G6/21e8BtlB7Mu?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 19:37:32.9573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c85223c-15e3-46ba-ce4e-08de0a8ff464
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539

Currently, the amd64_edac module only provides UMC normalized and system
physical address when a DRAM ECC error occurs. DRAM Address is neither
logged nor exported through tracepoint.

Modern AMD SOCs provide UEFI PRM module that implements various address
translation PRM handlers. These PRM handlers can be leveraged to convert
UMC normalized address into DRAM address at runtime on occurrence of a
DRAM ECC error. This translated DRAM address can then be logged and
exported through tracepoints. This set adds the required support to
accomplish the aforementioned.

The first patch adds support in the Address Translation Library to invoke
the appropriate PRM handler to perform the translation.

The second patch leverages the support added in the first patch to log
DRAM Address and export it through the RAS tracepoint on occurrence of a
DRAM ECC error.

Changes in v2:
 - Modify commit messages per feedback received.
 - Remove unnecessary variables.
 - Rename struct dram_addr to atl_dram_addr.
 - Replace sprintf call in __log_ecc_error() with scnprintf.
 - Pass the DRAM Address to edac_mc_handle_error() through "other_detail"
parameter instead of "msg".

Changes in v3:
 - Rebase on top of edac-for-next.
 - Add Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>

Links:
v1: https://lore.kernel.org/all/20250717165622.1162091-1-avadhut.naik@amd.com/
v2: https://lore.kernel.org/all/20250915212244.886668-1-avadhut.naik@amd.com/

Avadhut Naik (2):
  RAS/AMD/ATL: Translate UMC normalized address to DRAM address using
    PRM
  EDAC/amd64: Incorporate DRAM Address in EDAC message

 drivers/edac/amd64_edac.c      | 23 +++++++++++++++++++++-
 drivers/edac/amd64_edac.h      |  1 +
 drivers/ras/amd/atl/core.c     |  3 ++-
 drivers/ras/amd/atl/internal.h |  9 +++++++++
 drivers/ras/amd/atl/prm.c      | 36 ++++++++++++++++++++++++++++++----
 drivers/ras/amd/atl/umc.c      |  9 +++++++++
 drivers/ras/ras.c              | 18 +++++++++++++++--
 include/linux/ras.h            | 19 +++++++++++++++++-
 8 files changed, 109 insertions(+), 9 deletions(-)


base-commit: 79c0a2b7abc906c7cf3c793256c6b638d7dc477f
-- 
2.43.0



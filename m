Return-Path: <linux-edac+bounces-1244-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA23900D8B
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 23:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F95C1F22D11
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2024 21:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4D915534A;
	Fri,  7 Jun 2024 21:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JaYTVgkK"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDA015445E;
	Fri,  7 Jun 2024 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717796012; cv=fail; b=TmGfZBB17kAvuLJlhht2wow57bJEgG4DY3jGn579402MBG5EegBMirtcChKTk/OOkq1YPRGznUUbxUsOf/VS8fImZ+DKH81JGlRoU5PNyb028G8aOP5eDVlxZCX0UcSovbPWBzq8txWbC3tOsNghKdEWjOHIn1FcQTDZ4eEuGWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717796012; c=relaxed/simple;
	bh=pDQdiCqlkLSUCaSfUEpFPbZBWfrluuTANtBJDyaxQx8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=jJONXMwYFMoboPHq94JfvyAeio0u7TuydFzwrqWlh8kkAGBIIgrAYgJ1ic42OF11NBxkFw+V3OE9omxp8wFcG3jT+g2BwNp8oSbAyDgNjZ5IR17cWmttJIat5zMir6XndFg41DCZBe1PVkK6H5yXo5DryqSB+bHB+kBh5H2SRFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JaYTVgkK; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/c4GwDE4sb4xQMauEeu//mBLZ0EKFgw2vAvkBNa1Fdd1ce7w4uXKeJTW1gLbItu9anjU6yllWeIbDNCqRP5Ay1CyipTlOZzosKVAN7HdTj9Q2kwEqVn/SFyvcvpUKOXRsAvnVo2XVdzrutOUVWszmwk8o18FzqENfa+H+zGVzAbOUCgAugd80k+USNs7VcKKLoXJVRFgFh8eG3aG22UKCP6daoZGSMDFOEflEN/RO+eNAXHWwKEKD9rGtgzhMcpDmoVc0bDSSBlU8AalpT7UjQ/mqsi8tZNNViU912mYaGArVcqhXBdLXASXLzGaly8i8OZchvnX87gW2B3KM3CEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFza/t+sFv3ukyZKt+452903Ns2igKB151+r8FPV1IM=;
 b=Kdxfq8VNy8GhRRxPwbhXhna3uukQBnSevI6qLHdS3yIqq4WuY58k1ufBoFLHFPkm5M+E19L5i5dr0gpDlpyocDBNXtsa/qC332XWT+qqaSsQmL43rSlheTyGjxF8a0a7MyoVnvmmdjnGPm/KkaiTZgjTBS+IgERedCJeceKzP97lF0OMMUaT3063TL5rLsd78sLHpg31h9OMEvhTdMs8lCQXPdwPoUsGjSjyh94dd0qGToA56wweZXcMRml/OVHtrR/eNO4uIIRI2s8iFWFPs6mMCWAvAvGEw8JacMnFgjGI6bLUwqAiY6C5WPCvUzbcbfacqT+3U+PyXmNnFO+BBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFza/t+sFv3ukyZKt+452903Ns2igKB151+r8FPV1IM=;
 b=JaYTVgkK2H1hWQzAnSY0Bg7dEyon5QsbbP41Ap9gdbu28Cu+HF3OWKQ0Uptz6rfKZnU3bnokO6ZVX3YRnNdd+dBK3y6Tm1aPocQGQyc+XTZA+4z2c5Lxgmi7+ha66zARIKkYGr9/PLELp32dMqJJps76o2gFt+HdgT30FN96YXI=
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.35; Fri, 7 Jun
 2024 21:33:25 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::ad) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.22 via Frontend
 Transport; Fri, 7 Jun 2024 21:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 7 Jun 2024 21:33:24 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 16:33:23 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] MI300 DRAM address translation fixes
Date: Fri, 7 Jun 2024 16:32:58 -0500
Message-ID: <20240607-mi300-dram-xl-fix-v1-0-2f11547a178c@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIp8Y2YC/x2MSQqAMAwAv1JyNpAuKPgV8VDbqAE3WhCh+HeLx
 xmYKZA5CWfoVYHEt2Q5jwq6URBWfyyMEiuDIeOopQ53sUQYk9/x2XCWB2PQE8227Tg4qN2VuOr
 /OYzv+wGztH+4YwAAAA==
To: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Muralidhara M K <muralidhara.mk@amd.com>
CC: <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MN2PR12MB4375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4281cb-9e72-4ed3-88ff-08dc87397667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400017|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aFFvM1dET3VLYVpPeTZqbjhhWkFVMnZjczZremwvUk5KV1NlLy84YmlJSEpt?=
 =?utf-8?B?cEJJeFk2U1AwNjlUc1NXUHpRU1NBMkV2OTJFd3BLR1ZMaEJhMVhhdlQxeU1q?=
 =?utf-8?B?dHZmTVBRSnRnSnZKa0dyU2FrakpBK3R2b2lxZHdjNHkxbHFCdXJtR1QyRyti?=
 =?utf-8?B?cHJoejN3SXNvTk1haEtscmVpbGhYbUFad2todEV1RWNqaE5ROEhOdTMwZEVV?=
 =?utf-8?B?dWNjQ3BHcmlvNDJnKy94Nm1QRDFKaytaVi9Na0tYaS9LZjN1Q2tpRG4rN3Jz?=
 =?utf-8?B?QlhNSjdacElrbHpBcUhGakFjL1JxeGRnaWpJS3YxRXgzQ1RrVWF5R2tha2ts?=
 =?utf-8?B?VTRJRzlSSUdtY2RhM21oYXVDdzVGU3AvZkU2QmFDL0pmdFUzV2FMS1NhRFFD?=
 =?utf-8?B?UFplT0pMM09teUNGd1FhdXMxTjJyT1VHb2dneXVXMGc5RjMyZUFwbkdtMVBn?=
 =?utf-8?B?ZVRHK1dqb1JkOVBWbmVBRWFvWElwU0xFTVQ5Wk5WNnI3dXBMeDRTakJxd2hC?=
 =?utf-8?B?OXZYSUZ0dVRBdzFoc0llTVczMy9NdDlrcnQyd0RsSTBOOC8xMW5LKzdxWU1C?=
 =?utf-8?B?QmNKOTk2S1M3a2FhTjdkcnR4MUQ0dk5kZk5zN0J5VFRlNDA4aVJWQzNTaVRq?=
 =?utf-8?B?MmF4dFV6dlFOZkh6VHduYk1qdDh3a3RoM3N2RCtJMkpIeDRZMnBsSllpUWFT?=
 =?utf-8?B?Ym5IS1dOdUl1dG00OTRKZmZxVVR3MjZHby9maVhLYkhNSTFlQlhLdTVGMzhm?=
 =?utf-8?B?MUtPWjZkTktRVDhMZnRYMVdKTmtuVkxScWZUVTQxaC9oSmpQTUUxbzNNWk1P?=
 =?utf-8?B?c3hUR2pSZ3hjQkZaeHd4V2lLcjZodnV4a0s0aDhuTkNVQi8zc1FNTlM5bU1w?=
 =?utf-8?B?UmtxbzBramtQcWxBNCswaDJCN2cyalRUZXRld0NMeWp5aGNFRzhCU3dBVTRz?=
 =?utf-8?B?d3NENjgyMG04ZU5yMDNydzgrQWNuQVFpN1hrOW9rcExGcnQ2N0lSNlVhQ0tr?=
 =?utf-8?B?UEtBL1FQL2JHWU5ueWFHYWd5djRUM0ZsWnFxaVd4WVVnSkFjUUl6WkxzeHpG?=
 =?utf-8?B?eERvcTFpck9ESjV1MHpBVUFwUWJtQ3FUNlZOczZzblBrTjZVK0RBZm42Wkx5?=
 =?utf-8?B?bW5hT21UUWFUSUdWUmdhcWU0bUZCMFU4UFJWZ2MxMGdkNVlCMHNGVTN3UnpC?=
 =?utf-8?B?ODA0UzZESldTWUttSkdKSkRRbWd4UXoydUpBNENuK1Jhcy84Y3ZCUnB0OXV1?=
 =?utf-8?B?WGZrb1VoSWR2VFUvY2VGUzdjeDN5S0JibGtnRkhTZGxKTWhjbnFPM3U2M0hJ?=
 =?utf-8?B?cXZTak1XNXhIVnVnSjYxZFRWWDZySkNaeG5nVkp6allXRVZWOXdNb2xhN0hh?=
 =?utf-8?B?aEdxUFdlbHYwWjZySnlRSEJwTldRZ0RING5QeXNQdEZadm1rWmlSMlRySCt2?=
 =?utf-8?B?ZTYyN29Rankrd0NrMWVlNktEbG1yUUhrR1hoMWhHUDc5aEE4SWhTanh6aUNJ?=
 =?utf-8?B?RENJbFpxVXprYmJySWpYNTRRVFlDNy9Hc29HM05EKzBaNWYwV3hjV3NHN1Nu?=
 =?utf-8?B?emJkaFZrOFpSUHhsc2ZnWmRxMUp0aTNXaE95amJaZjBSbEljVkhTYWhPYzJx?=
 =?utf-8?B?MzA5SmpmeXFXUi9VMGpJa2VMZ2tzcFIyeXhOVEhxR0o1NEZ2c2VEcFpZTm9O?=
 =?utf-8?B?eHlQNW8zVy9HTjlwOWIwc0Jvb09QWWRyaVJyeFdqNzQ2YUtTcHFJMndLRVRu?=
 =?utf-8?B?b3kvTjJabzZVTS9ldGJWS3ZlS09vQ1c0UjRlcnJRV2pvTW1wanA0dmZ2bjlY?=
 =?utf-8?B?OXpObElLbWgycTd2NVhlU3ZZUW10YW1CcGtYSDlFTnFCVHUwZjhkM1FMUnd3?=
 =?utf-8?B?K3I0b0N2YTF4aS9ReVAzMjJjdC9lWTVrYTNOKzBQeUlGV2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 21:33:24.7431
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4281cb-9e72-4ed3-88ff-08dc87397667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375

Hi all,

This set includes fixes for DRAM address translation on MI300 systems.
These are needed to produce the correct system physical address for a
memory error. The system physical address is need for reporting and
page offlining.

Thanks,
Yazen

To: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
To: Muralidhara M K <muralidhara.mk@amd.com>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Yazen Ghannam (2):
      RAS/AMD/ATL: Fix MI300 bank hash
      RAS/AMD/ATL: Use system settings for MI300 DRAM to normalized address translation

 drivers/ras/amd/atl/internal.h |   2 +-
 drivers/ras/amd/atl/system.c   |   2 +-
 drivers/ras/amd/atl/umc.c      | 160 +++++++++++++++++++++++++++++------------
 3 files changed, 116 insertions(+), 48 deletions(-)

base_commit: dadc295cbd03955cc1ba55af55e23a06713d1a5f
change-id: 20240607-mi300-dram-xl-fix-dc1b0f367ec4



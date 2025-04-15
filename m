Return-Path: <linux-edac+bounces-3542-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 620F6A8A1F8
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 16:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAA41900548
	for <lists+linux-edac@lfdr.de>; Tue, 15 Apr 2025 14:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959A529AAF8;
	Tue, 15 Apr 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/t902Mf"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31482973CA;
	Tue, 15 Apr 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728917; cv=fail; b=pbzyDdcjoPAFeMcVvZ8QnfbPpNt5+Rk/HBN6EgKrw+EPjnvp+U+Ifa2+xJv3ciXwZSEQw2UHK4C/pS29j9HqYWe1OlbusRaAzzZ9YYeVGOEpJUxyRkXaZZYHtCFY4ZNMrOCeyaUJ3fIR9u2cdL/xWwrCKIcO67d54qmQzFWRw/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728917; c=relaxed/simple;
	bh=EC7KrFrXwbWxnFYnIjjltlBl8djEKDYtQnTQYOb8Kwg=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hFQGu7ZHSQ7qg24ZmDCX/Q6/K93XqNoNNIxQpjDsnhKsHrWHzZ5jNLB7URpmmDviiMZ0SC5KMvEG8EF7ej58shiumpb+a4bkCbYLPUCkhAF+NqmWWTZQe3ZCV6SjjQFINaIZ87bakbujp5HMLb0tv/X+97YJu2XMoC2lPEwSBG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/t902Mf; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3Jj0cdoq8dNhWqYwPR0kmmIThEccVvKwfR626R7m9accqpFd6uCq6AXjLwY2xQp+JNcxMgjZy7B2c3ccEbjImIOilZ5fyk29A/4pcQY13R5QgmZchoRCSxBtpCNymwhrsB8ApfzZocxGHQsQZPutwNUAzLXezZnQ8ty5XLstgepckVTMGsajCKhLlv2/hf6Xc09R5oEV20z8GXNtdUKGwI8VpTABrDTHgs5tNSRlWpyf01nvvLvjo/kWgNovcH3NxfiR9F3sqE64VDgsZ+I0I/CemAAymx+eTDnHYB79B00xVudY6tLhsJwgOdw6S+hzEdGC7HsjbaLo0rq1S1jvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdqqKe8XPQXatE/zjn/tKixQ2bIZUvux82ZXNBKUQSw=;
 b=WocEysvEseGXinSDRewk7XFa+8OmlmTtA7TT/i/Mrw/XhqJlmIxOVkIgLCOZiBG281lb4aAJ6M88PG5dtJoOi8QZp5OmW9sYXQzRMqB2ylf3FQtYj6JuxryFbpD3GYDKBnBjyrhI9P3Dj7C6gEBaea3fzQxtGrSX9kK07hrvjm/GwKJ6uyk75YBRO896HyXMvMWNZJRPYY47uTWFcNyCFiCUNhAFcc1q/3nn597H6mgBofyWMu3rZV+tQdaoSr913OQ6DjoN1Yr93Pk5L/2kt4FxW+i0af/n/JWFiBKESnjLNR+9s1d+Sty2BiAJ9/WgLe1awWKjohtIfvx2X6K/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdqqKe8XPQXatE/zjn/tKixQ2bIZUvux82ZXNBKUQSw=;
 b=b/t902Mf+NoacRLrvGd+G12ghc0bGZ5zmXdHol0StSiNimp1l4SVCf18pXMCkJyR4aoAOMa1UER5FEWybzCkvzI6swU0p5jrj4YkIhazglPMK9JsRDD1C/nYnONFv0Q8eGewO67m+GyK1X4fi5RLRzJQglsMGqvzW4lGJgmYDMk=
Received: from CH0PR04CA0102.namprd04.prod.outlook.com (2603:10b6:610:75::17)
 by PH0PR12MB8798.namprd12.prod.outlook.com (2603:10b6:510:28d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Tue, 15 Apr
 2025 14:55:12 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::5b) by CH0PR04CA0102.outlook.office365.com
 (2603:10b6:610:75::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.36 via Frontend Transport; Tue,
 15 Apr 2025 14:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:55:11 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:55:11 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 00/17] AMD MCA interrupts rework
Date: Tue, 15 Apr 2025 14:54:55 +0000
Message-ID: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEBz/mcC/2WOy26DMBREfyXyupf4gU3SVf6j6uJiLuCFDbIpe
 SD+PTZS1UWXI82ZORtLFB0l9nnaWKTVJTeFHNTHidkRw0DgupyZ5FJzKTjc3QzeIvzMHS6UoKV
 Oomns1eqGZWqO1LvHsfj1nXOLiaCNGOxYdhY3nx8Xc/YUByr90aVlis9DYBWFKl8111IJrU0tK
 nnhuhYCBDzxRaEasldAf0PfVXbyrLys8pcsluqf5SqBgzLK6Lrpiev+j973/Q1qCV7MBgEAAA=
 =
X-Change-ID: 20250210-wip-mca-updates-bed2a67c9c57
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH0PR12MB8798:EE_
X-MS-Office365-Filtering-Correlation-Id: 70ee8555-affb-4ef8-4600-08dd7c2d85ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTN2WkFGeERTSjhVNWpLRFBSd2Fvb2JlTmt3RGFSSGg5bzN2UHRPWlV2eVIr?=
 =?utf-8?B?eE85OW9INXFlV0ZpOFZSc2pnNEhtamFPeXB5T1pPdHJlQ1hsQjFMNkoreDdC?=
 =?utf-8?B?SDhBT3l5V2ZGcmJjUUNRaG42NnVZL2hIYmdRT3pyWmdYQ1N2Um9yakM5VjVq?=
 =?utf-8?B?MzR5cEtZSkpKcXZzbDIrMzZjelB6azZVdWZMZjV1YlJaNHl2ckZQQWg4SnF4?=
 =?utf-8?B?b1VNOHVoZ3RQbGpvNUxsQlZnOUhYUW14c3JiVlZ2eDAzSVUyWHJTMW80S0Vs?=
 =?utf-8?B?djVyRW5ncUJ4QURxQjVFYndIUU5wMVdKL1prTE1qd1VseTFjb3JLcnIrNXE1?=
 =?utf-8?B?anZLcnNDK05TbElYQ0JZVndvbGxyU0s0Rmdkb25qbW5xR2lFeklaUXJrdnZ5?=
 =?utf-8?B?emlYeE9yYVFLU2xzcHd5bFBYR1R3cnphc092VVB5U1Jia3hqcElLSnR4SEVw?=
 =?utf-8?B?ZTVNMHlVVGp6UWFUckZKaVZjYTdYNHF5MmdZQ2t5SG5QZ3NhNDQ0dVdLRnl1?=
 =?utf-8?B?bzhCK3B5b2NDZG4zMzdOM2tVNHRGblpLTllzajhVV2QrNWdFR1N3RForWG54?=
 =?utf-8?B?NytzQ25mTHQxNkZhL2ZQZW5ib0hpRThUOHpDNEdYK2RKVHhiUmJFcGxMUjlP?=
 =?utf-8?B?dG94OHpWMXpvM2xVcDZ0VmtIYk1CTE15bDNyelFYUGpYMVN4VU1LNk9zdXBl?=
 =?utf-8?B?Z3RiS2hoRENFL0Vkc3hJUUFhWVBnU011L1hsUzVyOUFHNG5iMnZaZ0dPVCs5?=
 =?utf-8?B?SERWQk02TVhCZ25MeDQ3Mk9DbS9ZeWI1clUzUXpLL3ZBaDdpVEZlZzhXb1d6?=
 =?utf-8?B?T1p0Rnk4ZWQ1SkR6RXdKaDY2Zlk0UStvOVowaEp4ZXlWaTJUcnA0UHZ0SXdO?=
 =?utf-8?B?TTRYVFZGRzAvOW5UaFhwYVpqdm11N0NjeDYrSnExd0RRWkVZWUJTZHNDUUVO?=
 =?utf-8?B?Rm00SkdBUlkvNlptR1Z4T1RLQ0Z0RXFiNXROYktYUm9sWWJSWE1FbkFHcUcz?=
 =?utf-8?B?WkxZY2xoUDJDSFZBNTBMYVFxUEw1emgyeW95cU1EVDdmUk9GTjluaXVqTHJj?=
 =?utf-8?B?UDczUzZmcXhTQVBDVjAvclFIUEkyWUZCOGE0WUtqMnVEaEMyR3BsU2JNVy9E?=
 =?utf-8?B?VVhUanlmcEVSWnhPOG5yNm8rbnAwcWVWVUFubUJ3ZHZmSlBkZmtqVzhMWDZH?=
 =?utf-8?B?VGh2Nk5FQ2dIMXRWdyszR0tQQ0ZyTmF4b1ZOOFNDdlBnOEFsNFl2TkNZMGRP?=
 =?utf-8?B?T20yVDhSSHc1UjlHU3FPWERCNHh2R0RFS1ZCQjVLYjJobDg3NndmMnZGbE1G?=
 =?utf-8?B?M2d5cHdBUVZtelRubGtwY0ZtQm5EbDArdkdjTnFJVU9NdklxZ0NSR0xDMXpm?=
 =?utf-8?B?YkdQMEU3VlE5S3dXUnBFUXFOSWxSYk84VHlEQnJsb0lWTFduRWRoYXhwekRH?=
 =?utf-8?B?MlgrUFB2bTRaWUR5a3VobnkrNlc3NS9Ec2Y4bC9SS2xmN0hTMWIydFRTQVQ2?=
 =?utf-8?B?dkMxRDhCQUx6cDVJQXczeHhnNVVPZGszUTJrWFBmN2QrZk9DUnFZcWJsZVNP?=
 =?utf-8?B?RWtFdnZYWEd4d1ZIR2s3enNjZUJmNi9tRnBVQzJLUndCckNNWWwyRW5PZkRL?=
 =?utf-8?B?ZG9BWDdpK1k4REY3aHRTVkxRL2lVcWZKdjgvMzVyeFZJWHhNQzF5cGpBNzhw?=
 =?utf-8?B?cXo3Y0hqcVBnQ2pRK0kvdk9neHplRmZhdnlCVFZ0VHFrVVN2b2dyYlRmY2pH?=
 =?utf-8?B?WEY3N3lwR3E4V2JWRURQN1lJSVRDajFZdFcralkzbWhRQVlkcmdkUTZiYnRN?=
 =?utf-8?B?VHp1L3hZbERCK3lHbEMydzJhd1VJQmVzY20rczU1eG5IRmpzQkJzazJ3bEhi?=
 =?utf-8?B?YWRKbkhvRmJJcEFtR05hWlkvNDl2L280ZGxPZ0lYaXp6UWl2b0ZsWjhPVkps?=
 =?utf-8?B?b3FhNjJsaGxpSWxmZXdMME5CUlpuVk5TQkNzN0NHWVRicVFhWHRQN0l4OUhS?=
 =?utf-8?B?RlR0enFDQTdUb1E4STVJOStKeXRsUFVuM0RxcURoL1oxSHJ6MThNVS9kSVRK?=
 =?utf-8?B?cWEwcWcxRWRkNk4wUGdVVS94MkNnQVlFUzhDZz09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:55:11.7947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ee8555-affb-4ef8-4600-08dd7c2d85ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8798

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Based on feedback, this revision also include changes to the MCA init
flow.

Patches 1-4:
General fixes and cleanups.

Patches 5-10:
Add BSP-only init flow and related changes.

Patches 11-15:
Updates from v1 set.

Patch 16:
Interrupt storm handling rebased on current set.

Patch 17:
Fix how poll settings are restored after a CMCI storm.

Thanks,
Yazen

---
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

Yazen Ghannam (15):
      x86/mce: Don't remove sysfs if thresholding sysfs init fails
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
      x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
      x86/mce/amd: Support SMCA Corrected Error Interrupt
      x86/mce: Restore poll settings after storm subsides

 arch/x86/include/asm/mce.h          |  11 +-
 arch/x86/kernel/cpu/common.c        |   1 +
 arch/x86/kernel/cpu/mce/amd.c       | 397 +++++++++++++-----------------------
 arch/x86/kernel/cpu/mce/core.c      | 331 +++++++++++++++---------------
 arch/x86/kernel/cpu/mce/intel.c     |  18 ++
 arch/x86/kernel/cpu/mce/internal.h  |  10 +
 arch/x86/kernel/cpu/mce/threshold.c |   3 +
 7 files changed, 347 insertions(+), 424 deletions(-)
---
base-commit: e6090e017e4b1e2a1e461750b7281a05f4e07a76
change-id: 20250210-wip-mca-updates-bed2a67c9c57



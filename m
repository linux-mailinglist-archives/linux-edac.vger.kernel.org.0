Return-Path: <linux-edac+bounces-5065-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 465B0BE49DE
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F19F4E74CE
	for <lists+linux-edac@lfdr.de>; Thu, 16 Oct 2025 16:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B5329C7F;
	Thu, 16 Oct 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QfWOu/is"
X-Original-To: linux-edac@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011053.outbound.protection.outlook.com [52.101.52.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603430EF90;
	Thu, 16 Oct 2025 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760632685; cv=fail; b=SzoDisRe4JzXJrU+v2Mtabbzsmzc3+McGhUQMAEhhDuz7z0uDmPLsTQPwPDZtn63ANv0y5AQ6YwwbIyt5//EkDlCCJ7h1E09ZVPwO37GHrUKE+i3WWW4lLsBlWGsegflBMAfE6oD3aEBKxSQEtskJZxBEzE5eaGFCat/I4fuy00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760632685; c=relaxed/simple;
	bh=2elkcihbndre+KbkIrukPF+29qs0HbcsPPE2O0A8YDk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZUeGmGiziWntMLCc0F+0MqyC/5/z8y9UI2O75bN9A7+5i9+M88kANiJSXrbR3ORQfjueXeY3hJEghvok96e/gr3IdDWcg0GMN9EN4V8RYPqWuEvLLzXvzEwy7BLMkYKAFrI+U59CcQjKMJhk7Gb15kVJvO8BH4h7NXY4bLEzDfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QfWOu/is; arc=fail smtp.client-ip=52.101.52.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8PqwC1OG8njLFF6huXiCTGPEgoRr/weICFkTRvzsRjNNxchUqQalgk4/M9R0jjp3Bzh0Xww+qut+g9CwNoYgbwd0yI+J8oezosy1M+mRSiLCKl27K63dMMu7ygGgLvh9vttdOVezMxHwHM7pAYulpNmTuOC2u7Dmlf4JaZJNk6D3LSRc8W5HB0/OTQw5n7Ixpw0jeE1rybpoFn/+XDdNc0QrIjNK9ST5SfBe1zysbcL70Do1zAfxR5FMzvgrkAop7AttDjoHLtbb/SF/9mluLnRCvhH34L2j+rQpnOJjri1ptCmcb5FTDf7bD4kXMDz2pA/lQ16HseVPzJvY3hF6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5WbXnsLFPRd0GWwwCMuVPmyPqr6vpeyqEBZbgOmxoIs=;
 b=dXpPVz6BkdoUXo1diTu5trRkADbhOoFe7TcNig7DS65ieCsLxU6tuosXu3tL1rsx+CGY90K6GGQ9+whUQJfxgm8Irs2ZZ7gsnPJ4Th9ekBdD+aZJoPrBg1I0LN8sfgshR/+FqEVG8xtHduLPLubMqJwsezWtK/gHawqq+4zCxX0AYt8DPkne4oUUMt6KIPKiF9yrXy4N8bCDYZKdon9+nDXkp8mfVPhJm8pk9sp0Wmm1b+x6wYfOrA1wDhLKy57G5/H7llbrHxTg3EtGArUYiYWRretbEcZdGebvGhjLKNzCg1sUhPOOORTZ6yws0WnNA9BEP+bKsALKwlbJCe6TCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5WbXnsLFPRd0GWwwCMuVPmyPqr6vpeyqEBZbgOmxoIs=;
 b=QfWOu/isTWeZBlO09zsSe/KtDvHsM891vDQPKhCFXROPY64bfJCsohsDx3XHd1LRyLCKdYPzOfAERDP1uhD/NWU88nBfqEUWj7/vbS7os1QLh28IWBZFzhgVbEthKSOfGd3jDZj6hojsa55X/G4ZySlUYBj/uHv5pH044g9atlU=
Received: from BLAP220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::24)
 by LV3PR12MB9356.namprd12.prod.outlook.com (2603:10b6:408:20c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Thu, 16 Oct
 2025 16:37:59 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:32c:cafe::9e) by BLAP220CA0019.outlook.office365.com
 (2603:10b6:208:32c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Thu,
 16 Oct 2025 16:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Thu, 16 Oct 2025 16:37:59 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 09:37:58 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v7 0/8] AMD MCA interrupts rework
Date: Thu, 16 Oct 2025 16:37:45 +0000
Message-ID: <20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFkf8WgC/23Oy27DIBAF0F+JWBeH14CdVf+j6gLDkLDwQ5C6T
 aP8eyFSZbnu8kpz5t47yZgiZnI63EnCJeY4jSWYlwNxFzuekUZfMhFMABOc0c8408FZ+jF7e8V
 Me/TCauM6B4YUNScM8ev58e295N5mpH2yo7vUP9c4H5PNRzclrOeXmK9Tuj37F15RrVIMhOQAW
 vFGtAwU55TTm/3GsTmXWaMdXu3gGzcNpJYs4lfWkXI3chGUUamlBmUCMghbLVetOOy1LLoNwXf
 YK2tBb7VatRZqr1XRQmrvjQpa/e2GVbfin26o3RqMbq1ADO1W61V3rN1rXXRR4LUzqu/cqh+Px
 w/WHrWI/QEAAA==
X-Change-ID: 20250210-wip-mca-updates-bed2a67c9c57
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, Bert Karwatzki <spasswolf@web.de>,
	<linux-acpi@vger.kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|LV3PR12MB9356:EE_
X-MS-Office365-Filtering-Correlation-Id: 450e67e1-8b86-4654-2de2-08de0cd25e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YUxaZVF6OTI1ZThveFZnV2EyTThnSFFndlNDRjZQckIwMVBWY0pHWDlzeWF1?=
 =?utf-8?B?MGtCN2MyeFpaTDMwVnRBSldmTDlPVkpIa1Y3Z1ZjYVlJZHl2eE5YOXBnSEM0?=
 =?utf-8?B?SW1LNnN4TFVpV0YrOUUxZ2p4cWUwZDd5bGVZQVF0cVZPNlBid21nVzU4Rkl2?=
 =?utf-8?B?RHZqU0FzQ1h6SEVIRG9yWWs3RVdFSkNHZzc0Z0w5akNDS3pCRUI2TGVhbzR5?=
 =?utf-8?B?RG9wMXR4RlNaZVRvVElMRGRDU1M0bkdFam9ub1hhbC91b1VCTWJNb3JUeWE4?=
 =?utf-8?B?NzQ4cUZKOElrWnhKNUNKeGZYREwzY0tZVEV0R1FNTThwL01VTkxnZG03L0Zp?=
 =?utf-8?B?VngxUW9kTzhxQXNZREdOaXRvNTlzcGdPeW1BWGsxOEhJME5xYVBZeGVMdW83?=
 =?utf-8?B?ZWpSZUc3WWNNRlc3VmNhN3VudlJiTFkrS3dwa0o4NlI1dzNIc2xkR3RQNVZ4?=
 =?utf-8?B?ZDFBQkhBSGlLaTFxMXVxb2lOM2FoYlJTRUViVSttWjdmVmRwZFVpcG9JVXJZ?=
 =?utf-8?B?bmN1Z01BTjJyaTR4NjhNLzZtS2Y0ejZkSHRGa2J2Ymczc3prYVliR3BLMjhr?=
 =?utf-8?B?N0twbjlpaXRlZGFTZ0lrUktsU0ZuaU9PWVU3SjBGUkJSOHgrUWY4VWllVVU0?=
 =?utf-8?B?TGNNbGxYUzA4Z2xJTnY1b09lWENON0ZydFU2VW9vSFQ3bGh1bzJCWnl6b3VY?=
 =?utf-8?B?cytZc2lsZkpzOUt6R1VaSU1LVHhvdHp3OUx4eTU3VVpuQU5lS2VWTW5BL3NU?=
 =?utf-8?B?R0R3bkhSM1c5N0Y3R0IvcTZNYndQVHQyN3EvY0l0WHNyc24zQW1hdTZ2Z0Za?=
 =?utf-8?B?aDlPUDA1SHdyOWVrMmVQQUprSnNyZmpwc1V2SXZwVVY5QUpROVBGNHJhampC?=
 =?utf-8?B?NXRUWlFyZkZOb1gyQnc2ckdITm1HaGt4SXJJa3lJS00vSTVHeExTRm9lYllz?=
 =?utf-8?B?WU5IRG9KTkxXOWYyQzdZays5VzlXWS9IZDNXZjNiY2xjSkZWc1c0aG01eEQx?=
 =?utf-8?B?Z2F2anpaL29UQk5zUDVYZ2ZvaTJvalVYRkowTDcyN3pMWjJSUEVuS0dNaUlm?=
 =?utf-8?B?RW1HUXM1S1g0eGZIanBxS0pZSXBtck13K3JvdVB5NlZnOS9vNWlHZzFGSzRQ?=
 =?utf-8?B?djdFWllSRThCNWRRRGg0eHJFNXlqbmlVczV4Y0kxY2NJdG9yRk1aZFhGcjZk?=
 =?utf-8?B?YjNEL1NHaCt2TnVUZm9KdG5GWGtaY0FiS04xdXRNNGtvQ0xjUXFML0dEcFZE?=
 =?utf-8?B?KzMzNU9aSE1qVENGOEw2aS8zdmxPcVdNaEpIdElWdEM3dS9DdGhCZ3JFeVdU?=
 =?utf-8?B?SFBjYmdmY3hwdDdGYmYvQkgxNFZuV1N6UlhGajVWNW5XcnYrWEFCVE9BRUxD?=
 =?utf-8?B?cTN5NWEwZTIzQWVXOVloT1c0ZTRaZ3AvcW9QaUM2dFBDdU5PN3RiYVBFd2VK?=
 =?utf-8?B?ZHdLeUNOd1dIQi9FWE1XTDgrYldBZTdDdm9KTDRlSk1hbm1LT0FNejhoaUpP?=
 =?utf-8?B?eWkrYUtTamhuT2ZrTS9JTWNTUEdtK21FTndNWnpWVmNxWmpwSG5ya3pLOGgw?=
 =?utf-8?B?VDlZczZZOGs3d2ZhcFZTamdlUzFTZG9WREVYR0NxRTMzOFgycEJlYjIyMXhE?=
 =?utf-8?B?MG10T0lQUzg1Z2s3MnMrOFVLNEtUVWE3YWFKd09SQWVMbEx0eGRYdXpqY3JE?=
 =?utf-8?B?K1RIM1hjZUdUTTBJT3JZaUN1aWVtNkJVV3E5anJiRWNhd3Y0TzdTRm82b0Vq?=
 =?utf-8?B?eE9VTTBPNUtXaVoxRHQvMW8xS2dBeVlNUXlJNkk4eTZRNEZQZ1NjN0Q2eEZk?=
 =?utf-8?B?R3R1UUdNZnBITU9TM0tzcHJyR1FMWThBYVp3Q3FoM2tudFVSN3ZKMDdVbTNu?=
 =?utf-8?B?VDBKSXRYWlYweHF2dW9uYUZHTVYxQk9NMElDR0lxVlFrTFZnSmNOTlhvUzZq?=
 =?utf-8?B?ZFBrRHV0UTBYaHdrT05MRVBwdmpENTNhVlpYcnY2R01vSGt4RWdQVzJJb1Zu?=
 =?utf-8?B?c3ZRSlN4V3FmSVZFd1ljTmM2eGM5RDFLOEIwV01STmJORmtaLzg4T0pKQnBh?=
 =?utf-8?B?Z1g1SjBONHZ1ZDFVOFA5dlVCRFlhbFY5K1NYY2FkclI2SWRqTGwvaFphZlp2?=
 =?utf-8?Q?mnlpaEON3bGwrg2djvtSTCFov?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:37:59.4713
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450e67e1-8b86-4654-2de2-08de0cd25e22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9356

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Based on feedback, this revision also include changes to the MCA init
flow.

Patches 1-2:
Unify AMD interrupt handlers with common MCE code.

Patches 3-4:
SMCA Corrected Error Interrupt support.

Patches 5-7:
Interrupt storm handling rebased on current set.

Patch 8:
Add support to get threshold limit from APEI HEST.

Thanks,
Yazen

---
Changes in v7:
- Rework DFR error handling to avoid reporting bogus errors.
- Don't modify polling banks for AMD-systems after an interrupt storm.
- Link to v6: https://lore.kernel.org/r/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com
- Link to "spurious errors" thread:
  https://lore.kernel.org/r/20250915010010.3547-1-spasswolf@web.de

Changes in v6:
- Rebase on tip/ras/core.
- Address comments from Boris for patches 1, 8, and 10.
- Link to v5: https://lore.kernel.org/r/20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com

Changes in v5:
- Rebase on v6.17-rc1.
- Add tags and address comments from Nikolay.
- Added back patch that was dropped from v4.
- Link to v4: https://lore.kernel.org/r/20250624-wip-mca-updates-v4-0-236dd74f645f@amd.com

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
Smita Koralahalli (1):
      x86/mce: Handle AMD threshold interrupt storms

Yazen Ghannam (7):
      x86/mce: Unify AMD THR handler with MCA Polling
      x86/mce: Unify AMD DFR handler with MCA Polling
      x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
      x86/mce/amd: Support SMCA Corrected Error Interrupt
      x86/mce/amd: Remove redundant reset_block()
      x86/mce/amd: Define threshold restart function for banks
      x86/mce: Save and use APEI corrected threshold limit

 arch/x86/include/asm/mce.h          |  13 ++
 arch/x86/kernel/acpi/apei.c         |   2 +
 arch/x86/kernel/cpu/mce/amd.c       | 340 ++++++++++++++----------------------
 arch/x86/kernel/cpu/mce/core.c      |  51 +++++-
 arch/x86/kernel/cpu/mce/internal.h  |   4 +
 arch/x86/kernel/cpu/mce/threshold.c |  19 +-
 6 files changed, 216 insertions(+), 213 deletions(-)
---
base-commit: 5c6f123c419b6e20f84ac1683089a52f449273aa
change-id: 20250210-wip-mca-updates-bed2a67c9c57



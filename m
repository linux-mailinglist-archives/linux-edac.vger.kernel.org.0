Return-Path: <linux-edac+bounces-5327-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9948BC31ABC
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 16:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC7A94F3062
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3F330B1E;
	Tue,  4 Nov 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cXZvVAxP"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013010.outbound.protection.outlook.com [40.107.201.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B934325702;
	Tue,  4 Nov 2025 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268160; cv=fail; b=DfDUMZ4exacPM9pAizagWjf34YqOOA3uOC80omGR8ouDOkm2wkgLyce04jv3giP3UIAUJDWytx42wbmVrOOtnfFmB5yrxj04DXZ0KzFCz4ESnuxTsvdnKAYLX4Uaau1fbI5GfbnbVY0KQ50J2/0tNoxl8j2a0s9b6brevTRBCbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268160; c=relaxed/simple;
	bh=h/BGkOpXjPGriCJCq9V56yAm5XvtayjI/hpAKp7kLcY=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=cJ2C5BezssYPS21cEU3ifkebZzdmxls2OJOwOhdIM1zESpzGnS1Ni0QZHZ4iZuFOg9HP4xs5H8jEhnmqvgkPnoGwHVRL/y3bRbJmNC+2hgDwkZXPVi8qsmJJrcDloRn9CH5+smAaFXAr9WKZd+GnkKgngRG6acKDQwnwI5cZPA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cXZvVAxP; arc=fail smtp.client-ip=40.107.201.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ri8sWOmFIj9gUSBpaLA8sKcmy9Y6c1fAS9bkCqtGaaHCyNrOGpURKKrYxJwZxv0kUv8+LKTrIf0+GZ8UJ+A2Rp+/7BNh9+7gUlN8rS6PUIesJBw/Lus4UYFZtwdeN9SAOfzVxXMw+NLJGufRJxLe190PUId+Xht16LGngaseNkSnNrUonKaM2EPaDJP5KWbiOH6mm76BAdMuBoGmbkM9cc1b4wd4FjNe3H7shT2SoXqQJKwdYQwwGGRRJze7S+0brkVG/Zm3DUjWyILYEUwMz2GNWT4odE7mh+jw26pgBlg3Om3JZDLAgShNj9adPcngpThove+bhxT5+mcL0opz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6WnmwqSE/jMCJAEP/telf5fonzpqhjwefOhNYXNrzQ=;
 b=JPhpoQC9Vp524Hk7DIDtQkBKYPqZ4oSpsOYpD6b1redrGRYGuvquKO9xJCgJ3NL/qimtR/Y7h1ShJxK1QD6y+Rg4zhxKG8Fh4WrSioFCoRgntMYjWgEqJ6CKJlRWgjafKmv/qiwAa+hl3Zk2bMBs7b7cTpPBt5aHmKbkgfXSUJ5xoHfX/Fh9yM4YuagP8r2llc8vNcDz81toJPOWa+arjbWs2VbAwZQR2NehI9eGZcbH7XtMo/lJU8Pd3ZQS+/eGXm80DPNt3ZRBMALLuuhw9UU/ST/CpuCxGPPqaKRJFLq+YjaZ22fygOZp2NIdQcAQhx1C9FpzTIoxIOjz6WpKOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6WnmwqSE/jMCJAEP/telf5fonzpqhjwefOhNYXNrzQ=;
 b=cXZvVAxP+yzCJ8LoXl1yzZEoR/IH9hC0PXn2SrLITr9QNv8Zhh4VQZFRNNADfX9v8U50yL8SrbmxBfVVWF619DXziQaQMEmoLmwdFZzYxrDwMJUHtKIw44YH6NI10YXDmSjEcAewxJEqkhjM8JRW02BSwBHe++CUGVVWo6DJys8=
Received: from DM6PR06CA0081.namprd06.prod.outlook.com (2603:10b6:5:336::14)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 14:55:56 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::70) by DM6PR06CA0081.outlook.office365.com
 (2603:10b6:5:336::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 14:55:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 14:55:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 4 Nov
 2025 06:55:50 -0800
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v8 0/8] AMD MCA interrupts rework
Date: Tue, 4 Nov 2025 14:55:37 +0000
Message-ID: <20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOkTCmkC/23Py27DIBAF0F+JWJeE14DdVf+j6gLDkLDwQ+C6T
 aP8eyFSa7nu8kqcuZcbyZgiZvJ8uJGES8xxHEpong7EXexwRhp9yUQwAUxwRj/iRHtn6fvk7Yy
 ZduiF1ca1DgwpakoY4ufj4utbyZ3NSLtkB3epd+Y4nZLNJzcmrM8vMc9juj76F15RrVIMhOQAW
 vGjaBgozimnV/uFw/FcZg22f7G9P7qxJ7VkET+yjpS7kYugjEotNSgTkEHYarlqxWGvZdFNCL7
 FTlkLeqvVqrVQe62KFlJ7b1TQ6m83rLoR/3RD7dZgdGMFYmi2Wq+6Zc1e66KLAq+dUV3rttr8a
 s643mtTNDguW6vK11y36vv9/g1fis8IOwIAAA==
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 11dfa2a9-8cec-424f-9b93-08de1bb241f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEtqSmFqeks5WUtnYWQ5ZUllNXBvVW1XV1FCbzRCVVBKdVFYZDRtUndqaGRh?=
 =?utf-8?B?UkEyVGpIYTIrN1NNbnRsU1F4NlZqUndDUEZLaWpPeEFVUkxNZy93cVJWZkxN?=
 =?utf-8?B?N3NxUWhDLzNzblBBVE1ETXlJcXh2MldaVU13aUFIS0NXZjJidnZlWE5Da3RU?=
 =?utf-8?B?eG1yS2FXZUxXdndydldBQmpCZ0l5czlsaEkxbDh4S0E1azhYdjMrWmtob0JB?=
 =?utf-8?B?NWdFR3EwKzVnalhsRGpuY0xRVVZNWEc3cW9saGlmMTNYVUk3Rnk2dnkzdWd1?=
 =?utf-8?B?cmQzTDY3Yyt6UjQrbzZTaHRGRmI0ZzE0azFVNktyWlo0eThvTXMrUWI1emtn?=
 =?utf-8?B?SXhwcDA5NDI1cEVuTERxZ1BySXQwV0FubEJENXF3QWhQSXBVNFZTNVNOellu?=
 =?utf-8?B?bVMxRW9sQ0V1UHEyU0FRYUJvdnpsQ0k1NUo4VmMyaENhU3VUT0pDUEg3eU43?=
 =?utf-8?B?Mld6ajNVZTlISzJSUG04c1YrNTh1Rm4zcFVldDdxWHZKbTUyZXAvZ2h4aFFM?=
 =?utf-8?B?em81cVM1b085WThKYW5XTm1zS3FDTFZZczc1UmlVZllyekRhQytEMFI3THJk?=
 =?utf-8?B?VWwrNG4xUzhBdjJyWit4b250aStlOWpBN2dyMC9ML2lpNWRIWEgyY0NxUFls?=
 =?utf-8?B?TDJFcWNWM0FTek9IaWMrYXNDZ1R3RmJuU2kvajlBZ255WHJ0Nnh2ODRDTUhj?=
 =?utf-8?B?WTd6MFFSL05xcldOUDV6VFp0Z3JWTkx4RmdGVmRFSEpPOXpTd1B2THdJSlNn?=
 =?utf-8?B?cXFKbWdYM0dzTXR6WU9iRmxMQ2JmSE9LK0w5enlyTWJjQ2UzZ3NjZUIycm1N?=
 =?utf-8?B?a1huaUQ3QzJzSjZSOFdyakFVQXRLOTVjWGhxTnhIWURmVzdDbFZ0QS94YmlV?=
 =?utf-8?B?QTR4aG8wOFE3bWR4dUp0NGJCaDZhbW9IRTJMNVV4NEp4cHlMbWozUjBGQzBX?=
 =?utf-8?B?T3ZrUkhwNEk4ZzY2dE9xVmtMNDRDVElwWVdYSVJRNFlkZVpKdGJ0V2MzdzhY?=
 =?utf-8?B?REp0aDFPN1BwNHoxV0RpM0RsZjFWOEMxdTBaakJUZzFUN1k5VEx1STY1US95?=
 =?utf-8?B?aUxhcXlJY1lnVXpObFVYMTBxNk1pZGErRkRTUzBaYlZKbnJCR3pIM3lUWjZJ?=
 =?utf-8?B?SUYxOU9sUTd4cWc3OXphSGgwSEJoaVFhQkd2L3VvY2c0NEwwMkU0RG44V0xX?=
 =?utf-8?B?V20wREF2K2FvM2pTS2ZYK2VWVGFnTXMySE5LOHlRZUpsY3R5bTYwZXZYVXJx?=
 =?utf-8?B?blFtRWtLTUs4bkdLcGVQOFlmYWlYbHozSHRMU2tZSkZYMC8zU3lmSzFWb2V4?=
 =?utf-8?B?UUdlQUlZYVAxRU13MkhmOXhJek9iTTNOUWc2VU5pNnVHTE51emkza2ZwYjUr?=
 =?utf-8?B?QjNsTElDaCt6TnozelFoZy93N3FjKzBJVFYyYkIwNXJiTDVGZEoxU2xGalRz?=
 =?utf-8?B?bmYxUVRGSk1qbG5UbzJqaVBIbEFWbHlWaXdseFYxM2NHT1RqVmxZR2p1ekU0?=
 =?utf-8?B?UEp2RkphSGdwL1ZmUUNBcWZJZkZkOCtqWHlyNS9VdEc4dFp4R2Z6cU9jVWRF?=
 =?utf-8?B?QmlWWEZ2L0R6M1VuZElpSk1yUlVkT2lPc3hmZDh5ekdjK09RUjdJTk5JOVZU?=
 =?utf-8?B?bFZVTnYwbjNxU01uQ3o0eHBnbjRvV2FkRFU1TnpCaXpNMUsrTFNsY2NHRXZq?=
 =?utf-8?B?TFJlcDR2OW5wSXNtdGR4OXh2a054T2doK2lCWnM1ZExPU0xyUEZXVEpsOGlI?=
 =?utf-8?B?alQwVnVaSEpjL1Rsbk43SXJabDN0Vlp3bUppZTZRM2ZNUXFpS1JZdXk2aWxD?=
 =?utf-8?B?VWU5dU1RL0gzL3hCemFROEdXOW9kUHh6YTZyd2VUdk03RkhFRzhCR0E1RmQz?=
 =?utf-8?B?ZExlR2pMNHpkN1ArdmRJMVp1R3R4TitzWlBFK2ZkSkluVVM3ODN3Z0d2Wllt?=
 =?utf-8?B?RDNCc0VQR3UyMzhRY2ZHTE84b09tb0RpdGtoeUxncHYxdlJrb2N5ZnRhckZw?=
 =?utf-8?B?ZmZnbTg4My9kaktIaGZIcjFuY0l1R1F3YkpmZHo5VzJpMXFhZ253M0pJZkZ6?=
 =?utf-8?B?ME40TmZTN3Z3NVZSaWtNVFRTKzFZL3RLUU9WTER4eWNJOHQrRUI5cnhXaDVu?=
 =?utf-8?Q?eIuU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 14:55:55.7189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11dfa2a9-8cec-424f-9b93-08de1bb241f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

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
Changes in v8:
- Apply "DFR unify" fixups. (Boris)
- Update "HEST threshold limit" string. (Boris)
- Link to v7: https://lore.kernel.org/r/20251016-wip-mca-updates-v7-0-5c139a4062cb@amd.com

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

 arch/x86/include/asm/mce.h          |  12 ++
 arch/x86/kernel/acpi/apei.c         |   2 +
 arch/x86/kernel/cpu/mce/amd.c       | 340 ++++++++++++++----------------------
 arch/x86/kernel/cpu/mce/core.c      |  31 +++-
 arch/x86/kernel/cpu/mce/internal.h  |   4 +
 arch/x86/kernel/cpu/mce/threshold.c |  19 +-
 6 files changed, 195 insertions(+), 213 deletions(-)
---
base-commit: 5c6f123c419b6e20f84ac1683089a52f449273aa
change-id: 20250210-wip-mca-updates-bed2a67c9c57



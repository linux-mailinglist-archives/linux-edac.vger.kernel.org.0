Return-Path: <linux-edac+bounces-4748-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D81B493DC
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB00D3BD0C7
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 15:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F62930FC2D;
	Mon,  8 Sep 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PaHkzdt4"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7730CD80;
	Mon,  8 Sep 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346066; cv=fail; b=b9lHsB5mrLpWa5O94lV+C18SCKLAqgn9wMhdW/ZYawKT/ZHU6LZeRhPG/OzSQz9qAn7RwmRocsbv8e0X8sERfusJIrPrhVIohzhJCO6EnMQjaxuuBdIz3EahqxYU0X1iiziXCPJR2X5uvtE6ALloI412BQWPBjJXPNtDIKjepz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346066; c=relaxed/simple;
	bh=CTlrP0NYKT4V5J4EvbpWcJOMHS0HlT0ASzKa2VO9ry4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=RfAkR1IwXvaaliWuz4L2Bw8z9CsqBN3BVVF4suklfQ1uPtFwpxvFImnTtzERETsGmo7ajoFo/gNbYdDvzvdWkLxIEAq/noyX7iuCOzOptd4kPvVCc3dQIbXGAgXsZiz+4/KWaAhABtJ/N3kGz7EazSPkEdvdV7qdlc4CflNpaOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PaHkzdt4; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wZoHDVz8JgZJl0cz2oQj4o6waJEwRfTCFSEsu0qd5sYFSq/uf3K96V3ibFAWid9+UsnvPGJTwdYOPDjExN0jAish2+gUW7Y5OCbmNKCfk13CDvWcPrjSG8axxquVrQtswEdMjccSmOsa0Ti54Cj1YtkXFNZoVFcRf5E0dgmCOCQuU3SynVYU2PZONADc5sVgolZGrnMYsJUcW2Cem/nIj17m2PgPD/hBcyFhBK3WA/Y7k6/CQozwEJuYGJR/BuoUKXrmtB2G0GsuFqBk8meYVsWCKYf9Rz2FVcVvOqO6XzMHvHlGpjoMFj2vnIERNIu/QogtAggakv+PozbTBe2ocA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LOkSP6y8jnjhQ/Aq20ZtySGZl1xXQy5ko6jB/gh50A=;
 b=i/XFkwIN40v/Im9F0+Gri3W3SqAkX5/Vtf0N0tGR5MirpO6sBS6KXn7jUeRYkiu9/mdfIHRGfbU3t5C1bFa6e4m//F+lUGz3d0xGuUcttfB5bmfLNok9NPUMHf3I3reQaVWvI7tNlkowUmF9c1PLTOx+SU4zLU3qSTqZSIeo26UtQ3OgqTCwxXvv6IgJAd4sswvmlpaDcu38xPMsyoTqFhfR0ylv9iPSZe71r7CRor+eX//WfewW/kSUZe28sawA5lBKlRaUq7R7GfJs9tihUtKiHvS3lTneYKK4i/wvwSB9Aa10brPLF7lT2fIjWmpYnmbVSciqzbQ/JbdNDjzxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LOkSP6y8jnjhQ/Aq20ZtySGZl1xXQy5ko6jB/gh50A=;
 b=PaHkzdt4zk19BN/RBFmb/7RSopBM5nszKtqEnRtmbUIogV4ROTmeEf1dh8FSjWoXEwhpXhYvN+AGxSdLddBAQ4AU5Q+H7EHfTxZlVxWr4DVKTIDRIgqCfd4H9lwbQAkxBe0UhkDPScU0NTDeILtVSNWzHOMWJxG3BTMEI9xNpow=
Received: from CH2PR17CA0029.namprd17.prod.outlook.com (2603:10b6:610:53::39)
 by DS7PR12MB6046.namprd12.prod.outlook.com (2603:10b6:8:85::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:40:55 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::67) by CH2PR17CA0029.outlook.office365.com
 (2603:10b6:610:53::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 15:40:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 15:40:55 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 08:40:54 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v6 00/15] AMD MCA interrupts rework
Date: Mon, 8 Sep 2025 15:40:29 +0000
Message-ID: <20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO34vmgC/23Oy27CMBAF0F9BXtfBr3ECq/5H1cXEHoMXecima
 Sni32sjVRFNl1eaM/feWKYUKbPj7sYSLTHHaSzBvuyYO+N4Ih59yUwJBUJJwT/jzAeH/GP2eKH
 Me/IKbesODlpW1JwoxK/Hx7f3knvMxPuEozvXP5c47xPmvZsS1fNzzJcpXR/9i6yoVhkBSksAa
 2SjOgFGSi75Fb9pbE5l1ojDKw6+cdPAasmifmUdqTcjF8UF11ZbMG0gAeFZ61UbCVuti+5C8Af
 qDSLYZ21WbZXZalO00tb71gRr/nbDqjv1TzfUbgut7VARhW7V9/v9B5hJKzS/AQAA
X-Change-ID: 20250210-wip-mca-updates-bed2a67c9c57
To: <x86@kernel.org>, Tony Luck <tony.luck@intel.com>, "Rafael J. Wysocki"
	<rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, <linux-acpi@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|DS7PR12MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: b18da2e1-9a3a-48d0-ac3f-08ddeeee194e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDZlYXN1K2ZXN0RiOXV4RWN2QnZnWEhaZmVDL0R1UUtPUmdUWU1wKytqSC8r?=
 =?utf-8?B?MkczdUV4ZXVHanlQUWpZMEpsQjVKZmlOQ09COXhqUlg2bWc2OFZKYmNQeXRn?=
 =?utf-8?B?UnV3bS9RcWhaYW16Z25IODhoSWxjNGZUeWlmbmJMWDNZU2F3RjVpSDRLZ3NC?=
 =?utf-8?B?NExVdC9xOVJETnBEVzUxYTNVNUcvbUI3ZmtnYlNQNEd4TllFUHdmUUdjenl2?=
 =?utf-8?B?WTEyRHA3SXYvMlNEQXNnazk5OFRBa2VibmhzZnpkZ3h3UjQ0eWd1OEFsaDEr?=
 =?utf-8?B?MEYram9zYVNTcGVHNm1aL05yMVJWNndxY3l4UTVMUVFPc1BxRzZhak1KSkNa?=
 =?utf-8?B?eW15M0ppb1BEZ0h1N1oxNE5EazVZeHRkdDRyRDJvaDNUMkd0RjNncHRlcitM?=
 =?utf-8?B?cHNhNk9qaGYvUTJCMG9LSEh6NmxYRCt5M282d3VLdHNrdGQ5cU5WcHBLWmpW?=
 =?utf-8?B?Z2p4UlZTemJtR1hFVUtUODM5clJSR0wvNEliRlNlNlRDeFhlK2xJdzR2NVF2?=
 =?utf-8?B?a0ZKeXRrL1hiV0MvV1BlYjdEcHBhVEx6aExIRXBpNWlCVzB3U1Z3RFRCZFhl?=
 =?utf-8?B?NDVUelcvTmNTa0QzNy96VnE3VkE5K0FyQ24xKzdBVGgraldUbDdxZFhBak1J?=
 =?utf-8?B?OXdZQWloU2JMRnNYS29sa0FObDdUZkRBRGNPQ0tJL0orMU82eVdMWW1MdXlC?=
 =?utf-8?B?Y0s1eEJYU2o3bE51cldkOEsxbG85cDFJZGhLOUVvM0ExSTN3U3Z6aG05eUt5?=
 =?utf-8?B?ak1mWm96N1dqall3NnNtTGRha0d0dFJzcXRuSlVqV3RsYkhxanFyOFJxMjBr?=
 =?utf-8?B?eTlJMVFpeUpHZTIxdUNNUW5PVzI2MHRLOVBqSWNCYktIYjFLRk9Gd29kRjFl?=
 =?utf-8?B?cmhjck9xZmdEdXUzTmpqUUh0UW9BeTFyQU1RR2EycDZYOUhwU1JCK1B1SE9D?=
 =?utf-8?B?em1pR3pORzhtVHhKM2tJa3Y4c01tbTdub3h1VGQvN3loakNVNWZ3WG8xb3pL?=
 =?utf-8?B?bkRpdXhYMVZ6MklkdkN2eXNlR2wxUnBvK1Q4cUJQZFZBRDd1TEZEZS9XQ1ZU?=
 =?utf-8?B?TnRmTStJS0ozUXNnOCswdUlGcjJEejBnR05uRnlHcXBVMUR3eDB1dytWM0F5?=
 =?utf-8?B?bGJTZjBpN2FYUWgrUDFYeFBkN3owZXVuME81SjZWQW1CNVhoUHJtT2E2cHov?=
 =?utf-8?B?bGFIM0FiTVlFTHQ4Y012UXVTaHI2b254aExzc3BvaFZ6bW1PWGp1T2VKL0NH?=
 =?utf-8?B?V3A0dWcwNWdCWTd4MnkyZi9Nclc1b3pIWGF6VVlOQVpvMytBYTlmc2VUVjNj?=
 =?utf-8?B?YWRwZlN0QWhrRWt6RGtHYmFEK2k5bDFBS2pMd1g5TExQZjBOYjlHY2pXR0tj?=
 =?utf-8?B?VkhVL0hBaTFjYnd3dmpjSEc4NWEyWi9XT2FVTGEzK2QvM1J6d1ROMC9lZnJT?=
 =?utf-8?B?TGhvWnhVL1NwbXRWa3JyYkwxV0xrQXZoclNQRFB3Q2N1NngycFFIZTRPdjgv?=
 =?utf-8?B?QnIwck01VlZRcTI1SXhVYkZWV2FTN2NCbGExcjkvak53M1cvSmRDT3ZMVTZh?=
 =?utf-8?B?U2M0OEhjTXNXU1pNRHZjaEJYdzF2M0wxazZjQjhzT2M0M2RSQWYyWmY3bFNC?=
 =?utf-8?B?ZUZPZXUrL2pGd1hVVHpVU0pSU1lYdnlWeXIxOFk1VE9xMEZQNHhVSndrTy8r?=
 =?utf-8?B?SW50Vi9XR3FKM0lsdmdiWFhTbFFURkU1dXR1WEdNTHJQUGpkdVVFcW40c3Q3?=
 =?utf-8?B?ekorUnVTVkY2amRoMndJYlViOVk0MWQzOHYyeGFnbnc4NGlGbERKV3VOTmI0?=
 =?utf-8?B?U0JwVk1HVG5oeFEvK1R1THBrSWtjREZpeFI4clBNMVJjVHVCczFVUkxJYWcy?=
 =?utf-8?B?a3c1K2hLTmNDcG9LYmxUL2xrTGFSMGJURUZYd3pOR0M0aEZZbXphSm15KzBx?=
 =?utf-8?B?WWt5dlVmenoyVUR2c1ZxUFVEQTZydTRzaE5rTkRvNGYvbTFGMUNMZ0VFZllp?=
 =?utf-8?Q?snXHHfypEdWvuy5il+6DggJnC8ULMs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:40:55.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18da2e1-9a3a-48d0-ac3f-08ddeeee194e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6046

Hi all,

This set unifies the AMD MCA interrupt handlers with common MCA code.
The goal is to avoid duplicating functionality like reading and clearing
MCA banks.

Based on feedback, this revision also include changes to the MCA init
flow.

Patch 1:
Update MCA init ordering.

Patches 2-5:
Add BSP-only init flow and related changes.

Patches 6-9:
Unify AMD interrupt handlers with common MCE code.

Patches 10-11:
SMCA Corrected Error Interrupt support.

Patches 12-14:
Interrupt storm handling rebased on current set.

Patch 15:
Add support to get threshold limit from APEI HEST.

Thanks,
Yazen

---
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

Yazen Ghannam (14):
      x86/mce: Set CR4.MCE last during init
      x86/mce: Define BSP-only init
      x86/mce: Define BSP-only SMCA init
      x86/mce: Do 'UNKNOWN' vendor check early
      x86/mce: Separate global and per-CPU quirks
      x86/mce: Move machine_check_poll() status checks to helper functions
      x86/mce: Add clear_bank() helper
      x86/mce: Unify AMD THR handler with MCA Polling
      x86/mce: Unify AMD DFR handler with MCA Polling
      x86/mce/amd: Enable interrupt vectors once per-CPU on SMCA systems
      x86/mce/amd: Support SMCA Corrected Error Interrupt
      x86/mce/amd: Remove redundant reset_block()
      x86/mce/amd: Define threshold restart function for banks
      x86/mce: Save and use APEI corrected threshold limit

 arch/x86/include/asm/mce.h          |  14 ++
 arch/x86/kernel/acpi/apei.c         |   2 +
 arch/x86/kernel/cpu/common.c        |   1 +
 arch/x86/kernel/cpu/mce/amd.c       | 367 +++++++++++++++---------------------
 arch/x86/kernel/cpu/mce/core.c      | 280 +++++++++++++++------------
 arch/x86/kernel/cpu/mce/intel.c     |  18 ++
 arch/x86/kernel/cpu/mce/internal.h  |   9 +
 arch/x86/kernel/cpu/mce/threshold.c |  16 ++
 8 files changed, 374 insertions(+), 333 deletions(-)
---
base-commit: 9f34032ec0deef58bd0eb7475f1981adfa998648
change-id: 20250210-wip-mca-updates-bed2a67c9c57



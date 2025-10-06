Return-Path: <linux-edac+bounces-4989-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BC858BBE727
	for <lists+linux-edac@lfdr.de>; Mon, 06 Oct 2025 17:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94EDA4E2D06
	for <lists+linux-edac@lfdr.de>; Mon,  6 Oct 2025 15:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5206B2D6619;
	Mon,  6 Oct 2025 15:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N/Nusk+U"
X-Original-To: linux-edac@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012044.outbound.protection.outlook.com [40.93.195.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AC627FB03;
	Mon,  6 Oct 2025 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759763455; cv=fail; b=U77+/3Q0y5ZPQUIv4fm4rkZifLiIm2Io1shteC5F6+IoHP7v/oeAKts1YnxSsGpMfpXJyfJBo1W6XSSsjo+uerZzNdkAUGLpJlOs/WZSl1Xkqq/a6ngujdtuusQnVhGTz3trVLotOd3n8vSFF62SOqhrenpKoiqsXekvwq21fvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759763455; c=relaxed/simple;
	bh=k5W7A2pCD/6C4TDw+dKEIdeYFVYs9K48BzToF92HJQc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=g7ZgyOFYLyvGleu1luzdDSV41Jfiy4xyutcifryLI9IIrgqM/eYrzaCpx4/8ahVGyZ5Y+rAFhTuhkCi73bDldF1SjnUVVIIAB6DkANcuB7RA3oG/NZhcKUEXr2v3L0uwf+pm8PNZvVceTiAT35zIpTCLBniOHj8SYgvVly6vBUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=N/Nusk+U; arc=fail smtp.client-ip=40.93.195.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n0t8R1cX+i5LlrwtzhrDS/3IUnrx4D5xgsu6ll2X6KDcOoSa8E+Z9nPkogi3n57FkMpi/qp99PI4kbab/q+l26ydgNwTW7rmt0bBK15oMSj7yoW35HBytonDPm7pQllUZ7cMUVIMnqaJywfTvk6roZ7DZFQfS4pyTw16s0cVjt4+yLJ9ZkoV8iqxkSM/1o56QvgN/dZkuZmomq0oKE8MBKK5KqaSbHHzWgTyzdJK6MBkNNhKnqpsA6H9ee5WpVdtT01KfpYTui+exF0aXhcVBDwT3t1TvngPs7YOxV0W/zEsbkW6ENlCK074aVH9OtI3WaFSMdHRIGntfXwsqHByGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxXfrQHb0Fi4D3VXId5Ehnr3g32SrHthy0tN+v0tJzA=;
 b=CW1js5AYBelKvvUQCJDILFrLs+7Fk1S/9XJq6KCDwKJEaKFi+ObnofN5t5m26WGkOPluMG6a5axTf6u+uhbqCoY/bdcvwREKEaYQSLe7USClkxzYNF6X9cUuVjr4/+joyV+ULGYycz8vcdKQp7JbSZ2BYt78iupiWwWe/ZI83nUnHf2Vu0oeaePU5Jc6cuov6n3IE+01R6nFBigU3++BPoRolGsskufhDV1nP7m74k90ox08KuGw+6/VbAdJYiF5xedw9YnEa5SfMVUtORlCEL43w159dXp0l3TACcvW5IrJ0v27stdte6xV8Fwr6QywCeHjmoH6WVfHJ9uHN1KOYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxXfrQHb0Fi4D3VXId5Ehnr3g32SrHthy0tN+v0tJzA=;
 b=N/Nusk+UnIuEmwK6hVC033I7PkHrWe2idMfBaQrwvXsuJGJqEP/4VS1o5twZ++CqkwdI0K222D9pc3X3fuEBp9xOZBWUTi2eTfauzykLIkLT4WROUkdykvP0PzSobZTqKhcXEubnmHFB/ZMgTDcJxxYQbBMb6JQ+pjagop3J42E=
Received: from CH0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:610:e4::29)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 15:10:50 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::a4) by CH0PR03CA0204.outlook.office365.com
 (2603:10b6:610:e4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 15:10:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 15:10:49 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Oct
 2025 08:10:48 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/3] AMD ATL PRM Updates
Date: Mon, 6 Oct 2025 15:10:24 +0000
Message-ID: <20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODb42gC/x3MwQrCMAyA4VcZORtsC1XxVcRDWjMXWGNJxxTG3
 t3q8Tv8/waNTbjBddjAeJUmL+3whwHyRPpklEc3BBeid+6Eb6lIy4zVCuY4XlJMZx+8h15U41E
 +/9vt3p2oMSYjzdPvUUh0FuVjobawwb5/AW/mtsB/AAAA
X-Change-ID: 20251006-wip-atl-prm-c5f8b5b71211
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: e7f17bb2-9a2b-44fd-e891-08de04ea88b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG53OWxxM1VMYzNYMDhDRGc4TkhtTjBBb09PSDdrQkU3aUFUV2U3QmRpOXA3?=
 =?utf-8?B?UVZXanFUQ3dNbHRodURYVFRVVlArYklxY1F0UXlpMkIxc2FLNUFzUXFTeThB?=
 =?utf-8?B?dVVWdlNidFgwdzFuVlNadk9hQkFkZzR5Ni9TY0tNRjFNdzNTbGZFL0lmLzBn?=
 =?utf-8?B?bWF3SGpFdURTazRuNEFoQmUxZHRLNGprQno2bHN0djhwS0NOdzBwWEJwZlFW?=
 =?utf-8?B?WUpGTTVSN3p1WXBsTm1hZ0l1eDl3eVBlRXM0THV4RW9rZ0NGZzlhV1Q4QzI3?=
 =?utf-8?B?MmZmeHlKU2RpQU9oWURZRG93bWoxY251TVpBR2NFQ2o4Y29GN3l5WkQydk5Y?=
 =?utf-8?B?MnE4a3l5YmdzSGJNMnhFd1hDU2lLTm45b0hzcU9pTU1yb2hIbWMxd1Y4ZGhk?=
 =?utf-8?B?aXYwY0d4RXVMRjVaMXVaaW1rMlZjT095SklrNTMwUXkvNTY4TkxMMDZKUW9E?=
 =?utf-8?B?VUM5amROb3FnMU1vaVpMZ1FQYW1DMURjRVRvV04xL1Y1R0gyYUdDemJnMkFh?=
 =?utf-8?B?YThjaEVrZDlZVWRSTk9BbExtQzlDbmtSSkswaFdxNGxvNkJrUHhqNUlDNTlD?=
 =?utf-8?B?S3htcXpnOStycEowK1AyWllPb3ZIUmpWbytUSThaY0k1cVd4bVp6SGRvVXRC?=
 =?utf-8?B?aktTNFQ2d3pHNVpQNHowSm9IanlqdkJaUTFaSHlUa0IvTG5LYW11aEtaMGtq?=
 =?utf-8?B?S1ZGckdtMjZnd1VmQVV5VDU3Wnc2MXd4bzdBNTZOTGRPSkF2cXR0VzdVcGJv?=
 =?utf-8?B?UlN1RFB3SlFoODVtT2czbEs2OFBjTy9BTTQ0eXZtWkhDRE50Y1haZ3FoQ0k4?=
 =?utf-8?B?TUtaQVZjUFdyRWdjNDNVMEtmWUpYOUE0aFRmN0xlbkdRdXNLa2pseWZsMnVU?=
 =?utf-8?B?UkVkVVpCamhxRFVHam5Mc0QwckdVMGdYNzVsWGdmRkl4cDNZWGwwR2dZVkRl?=
 =?utf-8?B?aDM5TDZnNllsTUhUUXV3NGZ1aEFsS1p1aGdyZjZzMUZZZFhKeTE1VC9HNmJ2?=
 =?utf-8?B?MDIyNmJYQzM4eWFsQnVUSkNlMitRK2pWSkljeFBRejBaemRkNXg5WVRaVis0?=
 =?utf-8?B?THNERDMzbENUc3l0RVNxRVpyaFlLSU1UTGw0WGJqOWF2SzJoQXFMUENENDhW?=
 =?utf-8?B?TUlPdTdEbElXYkRtRGJxL3NicHpqaFVjU1ljTjJjcHB6TXc0VGhGT1dxNE53?=
 =?utf-8?B?b2VkK1d1N0hmNlhQYjgvTDh3QmxkM2J4WUk4dWpldCsrbGhrN1FkK2dSRDcw?=
 =?utf-8?B?QmdUaExkRCtZUTAvQ090ZEFiWE9qU2VLT2R0Q2FZZXFSaVp0Zi9MMXRWY21C?=
 =?utf-8?B?ejIwaThlUHF5bGlqN3VOSVJFQnN5T2FWb0VGcG9WSGt3OVRJSC9zYmJYdk1Q?=
 =?utf-8?B?T3RudnF5VVpJSlpTUitrWnl6eWdiWVFLcUo5cHNuZEcrZEp4Um9jVmw1bGZD?=
 =?utf-8?B?cDdvc040bUhRbTdpUWQ1VlV6OUNpTFl2TFNwT2ZtYjZMaHlCU0xQNHErV2Zr?=
 =?utf-8?B?ZXFIaityOXBqU3ZnRHVucDJuZmQ5TFJvbFFtZHlSWHZ3S283aFZXUHBsREVP?=
 =?utf-8?B?Z2hkM1pIQzJQQzcrMktLejYvRnpoQ3Bka3krbk9vOUdaMU1mNGwvb0RJUGM0?=
 =?utf-8?B?cG9qL1poRm1jRjhkcm1lSDBPRjNxRHV2UmxjTWNYR3ZlOHZCZ1JINzROR1Ja?=
 =?utf-8?B?UE8rdjMwTjZzR0pxWTEwRmNvRUxMWWJ4UWU5d1FtTytldnpuMHhsaXltdklX?=
 =?utf-8?B?QUxWZng4bnh1Q00ybGNIUHhFQ3YrSDFqelZMOGo2aGVqaEZQY3JzNHVJV1RK?=
 =?utf-8?B?aFljQlAxRlRiTGVCTHVoMERiYThtRlhSSUpjMTZGMGlDZDNYN3RKb2pHVER1?=
 =?utf-8?B?Nmc4OVYrU2h5eUdYbWFqaTBHV3JaanNJQjQ5eFU3U1p2YXBTOGROWkl0dmV0?=
 =?utf-8?B?OUtqYW5INGxwdWlEMEF0Snd6VElQMm1CMm9QQTR2MWhpcUF2V1VHSmQ4d3k0?=
 =?utf-8?B?amNBbE9jY0RxVTk0bUlvT2pLWU1ibkdIVDdVb2pHdlVSdFFPb2NsNUo0OTZB?=
 =?utf-8?B?eHZIdFhZQWZBazRnbzNBdWc0VDNRSmN4ZnBGMWxYbUQ5dXR3WURiaGZjUnhx?=
 =?utf-8?Q?FxZo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 15:10:49.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f17bb2-9a2b-44fd-e891-08de04ea88b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211

Hi all,

This set updates the AMD Address Translation Library to default to using
PRM handlers.

Patch 1 adds a small helper function in the ACPI PRMT code.

Patch 2 adds the new ATL functionality.

Patch 3 does minor miscellaneous cleanup.

Please note there is a minor conflict with this set from Avadhut:
https://lore.kernel.org/r/20250915212244.886668-1-avadhut.naik@amd.com

Thanks,
Yazen

---
Yazen Ghannam (3):
      ACPI: PRM: Add acpi_prm_handler_available()
      RAS/AMD/ATL: Require PRM support for future systems
      RAS/AMD/ATL: Return error codes from helper functions

 drivers/acpi/prmt.c            |  6 ++++++
 drivers/ras/amd/atl/core.c     |  7 +++++--
 drivers/ras/amd/atl/internal.h | 10 +++++++++-
 drivers/ras/amd/atl/prm.c      | 10 ++++++++++
 drivers/ras/amd/atl/system.c   | 19 +++++++++++--------
 drivers/ras/amd/atl/umc.c      |  2 +-
 include/linux/prmt.h           |  2 ++
 7 files changed, 44 insertions(+), 12 deletions(-)
---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251006-wip-atl-prm-c5f8b5b71211



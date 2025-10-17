Return-Path: <linux-edac+bounces-5115-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0027BE8D52
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A3C3AB455
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807A350D4B;
	Fri, 17 Oct 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ohcmhoV6"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCBA332EA3;
	Fri, 17 Oct 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707622; cv=fail; b=eCA3ytVcifqq+0e/gw6JKVmV0V4/3tjj84QTYx5GAV/qO7yERDQRCaujaXj3jcnC+YsXsz9E/wF+cEXrRgarv8Tkxd99ZbQ1Aux+Hb8k4t9AZ7WzFiOgjhoRU/fK2FTa4e+jDJjcTDKiAbWmYy4TJ7iXHfzw7kpm+nsJdbn5Z/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707622; c=relaxed/simple;
	bh=RA+I7PybVWq6sxTgUrojdoNV9OPE0Z3Q4JzQ3EMU0Ho=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=pOgtkK8EikEaXGadVMtp4BzsQIgWSN8Gn3XwXmjnkH9JhMgKWo9Ox/rJLUQhTFlYvh04FMaSXy3d9cepnPlgZVJZvgTnIHuyBGikHs5st6b/PIhd4vrhafbBZEIFJGMuRUvf9QM3MVR5OEwZYQvRuy3X0Ch3XHayhSDF4eU+S6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ohcmhoV6; arc=fail smtp.client-ip=52.101.193.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeK4xngeOPGuU1GKF4wCf5w+FnyfVK1SSk0IMj38y0ZjRVqnpiJ06DVLEvuMdooaU8rp8dCgNVnvAW8yNdpCerTOoycJmXi6HSXuwsiGZQEOinLG1DY7u6sT0GYBFsbXzy+8WXe8QMVJehgAmTZCHyrLThEhNu3JLnCRj458nhil3HC1lAT/qiZZyPFcHZ9vbGtSK3866m3Rgx4+HBmJH0zE5gztTiQScn9Crt7I13bHm4a0vHaNLiL2N6esrW9hgswHom6RQif6o2Gdjepjs1JYb5Ida46SiU3/ds7gp4TX+QxdZVT1ulOeFEuhl2YttadEVywcwSWjMXV5Qcorkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEmBTGkYK4FdN6HPC2qNTBvlNdcGettaCOfPqLQ73rw=;
 b=ChcuXKp61ll3OrmtEyCf/x6p0kmnt8kX8uyptFgf7YDHYq/0mSTEbCdJA8bs+UQk0gCuXM/Wk7JLZF9/iknzqmsgne8K264m42mCuT4MzX30FY3sHL+HowpaHQVx/lvSWpKL1iBC0unJF/p4ACj55h9nfHsj6U+2pC/STzJ/HstFQ0lIlqHB/+imxqkck/J03tIHsW78aNJHey7GttfRqahXB1rBUuxbqWHqcRLySpaClEXAxl4Db4hfzVYcnedkW47v3VgZqXNWKKtsXqK1g8viQ/Qd/byqSBC8dXh93O5a8IAd2VV6wfBA2OinFOR/B9E06EQUzDp5PQ2PkL10Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEmBTGkYK4FdN6HPC2qNTBvlNdcGettaCOfPqLQ73rw=;
 b=ohcmhoV669OYCaX8mX/TYvntJp1YF6fXdjf9oDdsa/4U7lUipHIZkkEZip4oaxFuNUzZS4gRottc7t8sevoEbLZgSPkVHBZcfssmi44UtDu9qqst9FgTfqsH/Denln6SJRgZ3/JNgPanRsOq592emIYJxh5MnDZuFuLNMXNBQvk=
Received: from BN9PR03CA0328.namprd03.prod.outlook.com (2603:10b6:408:112::33)
 by DS7PR12MB9552.namprd12.prod.outlook.com (2603:10b6:8:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 13:26:56 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:408:112:cafe::1c) by BN9PR03CA0328.outlook.office365.com
 (2603:10b6:408:112::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Fri,
 17 Oct 2025 13:26:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 13:26:56 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Oct
 2025 06:26:53 -0700
From: Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 0/2] AMD ATL PRM Updates
Date: Fri, 17 Oct 2025 13:26:27 +0000
Message-ID: <20251017-wip-atl-prm-v2-0-7ab1df4a5fbc@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANE8mgC/22OQQ6CMBBFr0K6drRtBJSV9zAspmUqTaQlU4IYw
 t0trF2+xXv/ryIRe0qiKVbBNPvkY8igT4WwPYYXge8yCy11qaSs4ONHwOkNIw9gS3czpamVVkp
 kY2RyfjlqzzazwURgGIPt9wZjulCHFlxkCLRMu9P7NEX+HgdmtZv/t2YFEq5Y6XtVO6ONfODQn
 W0cRLtt2w9CmLHTyAAAAA==
X-Change-ID: 20251006-wip-atl-prm-c5f8b5b71211
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, Avadhut Naik <avadhut.naik@amd.com>, John Allen
	<john.allen@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Mario
 Limonciello (AMD)" <superm1@kernel.org>, Yazen Ghannam
	<yazen.ghannam@amd.com>
X-Mailer: b4 0.15-dev-9b767
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS7PR12MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: a476ba86-9168-4d25-0cb8-08de0d80d7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eW0rbnY1WnpnNU44WUFpbVlNMGgrWFhsUHlrdnZaN1J6QzJSaE9rMnRQSDFE?=
 =?utf-8?B?T0hKSmxHMmh6dHBHMjVkMy9RSS9rcFZRN2Y5aUtsU2k2d0M4SjZvWFJ5WlJV?=
 =?utf-8?B?a1dCTzNhVHo1YmpaK3ZxS0xweVJPcXNMc0w2OVVxanQ0NWxlSUNPVU9ZQ2tM?=
 =?utf-8?B?Z3RkYWZuV3FDNzBmZkQ5T284RWN0R2g3T2dmMXVFZjlQeC9hQmZuQis5OUZn?=
 =?utf-8?B?eUd1bnBDdTYvbXg0SENDNGdDamREUzBoMHV5R3JWdkhMTnFZemV5VWl3UVdJ?=
 =?utf-8?B?a1BnaXFiNjc3RGZ1Tmc4N1NkbGtoVFd0cnZsQ0hDMFA1RDA4OWI5SUFzVHhU?=
 =?utf-8?B?Q3pmQTlsTGd6bG5GQUQrMDA1bE11NjM4Y2tPUm1VSk5WdFhaN2JidCtjdHYr?=
 =?utf-8?B?eXlsRE5DUUh1TWxwYW1qQlhIZDBRL3NpSEpmV3U0bkJZa2VBclRkWGZKUExT?=
 =?utf-8?B?MzAydm1sRVdkU2I1bnNJM1lpWE1nalhKQ1orb3pUYVoremlKT1QrUlpDZWN4?=
 =?utf-8?B?K2ZmSzBuVmRTTk4zNy9Wb2pTOGpXT2JmYzVrZkVoR2M4UTlBZGJWc2NrNllN?=
 =?utf-8?B?RjU1SEVMclYzMFVtQjBwN1k3alFEZ3RRUXhPN0t5MGFHVjl5UVdhNjRZdDl4?=
 =?utf-8?B?dk1OSlVHMEZ4Ykh6UnEzbU9RYi9DT3BsWTNINy94NzVxUE5McU5nbCtwQjlN?=
 =?utf-8?B?NGs2UnM2a3FqS0lZS0xrL3BiUCt2eVBuUHBhQnlSTWhNNG0rVzJyd0U5dFll?=
 =?utf-8?B?MXdSdWlEQXMwSWZjYVBLNGFjU3RBMm0rTG9QZm1iNEdhVXJaTVRvUXhIMGl5?=
 =?utf-8?B?UXRmeXJMVGhYMkIwVVczUlhDMDVteTlCcXE0aklrb0Z3L3NwNncySnd6UnM1?=
 =?utf-8?B?c3VES0tac3lrVUl2SXRJR3p5eEdCL1ZnbDJFeTRiblBRU1pac2IyTDFvMXRj?=
 =?utf-8?B?Ym1HZ2hnWXVRdUtYT2tqWmxOSVB3bGFiSk5YN1J4bnVaOEhBeTJrWEtpdHJQ?=
 =?utf-8?B?cjVYdll5K29pL0YwMU5FbHhlOGR2bHVuSUE0anVYVE5YbERzNEZIUlNoY2kw?=
 =?utf-8?B?dU5xYW9rbElkZEhLNUpiKy9PNGViVG1mTDgwc29wNFFONUk2aThYRXd5OWgr?=
 =?utf-8?B?U1pJTXdIRXRjaHArOUFHdnRvdTlCUGJQWGR6ZFB1bFBla2FWMnBLdkp6NE0v?=
 =?utf-8?B?eG9RMFVpSlUzbTFqNDc5L2RZNUt0aXIrSG0ySHFERm5oM0ZGMWhVQ1FPSVJB?=
 =?utf-8?B?ekJ5VktPL1g5elljRHh1QmdBR0JUMGl0aWdFaHFNOUV0c1p3d3B6amtKS2V1?=
 =?utf-8?B?VFplQkpxZVp0d0VUS2FCZ0RIV1BGeXgreG9MYjdZYXliNzM4ZkVlaUFObVZh?=
 =?utf-8?B?UU5aczFyUFY3ZFBqeHB1NERDTmNpcE93NkRxMlVtV3puOExOWEVBSEVXTkZM?=
 =?utf-8?B?a3M5bnNQNVRsbjAxT0ZXbGQ5RXhKTkxKUjRRR1RwdXRpZGZSVEVjTG5ha1Zv?=
 =?utf-8?B?K2xmTzNVSFBQSFdpeVl3L1Q4L3VmaU1wSlplMnVXRzlyNEpQbkRaYUk4Y29P?=
 =?utf-8?B?QmpZSzJ1M0wwc3dZMkdINGV6a1BHdkRnMW5BUCtueFhSK0xMaWtZMzVmZHJU?=
 =?utf-8?B?c05hRnpqTHhZaFVTWktkNjlPd0VSMnFkWlNwWWFuRjhTOUl3OVBqcmRpMG5H?=
 =?utf-8?B?L2orNG10UGVyNEY0YllpVVMwd1NCbVI0UWQ3Z0d3MmlGVWdHaFdPcWlpZEQv?=
 =?utf-8?B?UUNEbitJVzkxeTNQVFNwK3c4U1RjSG0wRFkzQ3pLWFI3UVRMRml6SFRuNEU4?=
 =?utf-8?B?WkJnbGpCREgrV05uUUIrUWNUdDA4RkozVFUveU5yMFVtZldXV05CMjVFRWZX?=
 =?utf-8?B?VHV4UFU3MEx5NnBnK3FITVNxVU1mMi9UR1FKVnhEUitUaXo3RVJFazdxQ1U5?=
 =?utf-8?B?empuOENpbVlvN2JHc21Pc3FpT3RBMnROQnJmY1lrTlhzZGJqWCtza0xzdHF1?=
 =?utf-8?B?WXRMNitUcENSYUVpdW90elV1bUJBY1lTVkFselNwNzVEcWFhbVYwYktzRUZr?=
 =?utf-8?B?Y0FPRVRsZVVvMEFpL0NSdjNoYitNZDlocldVajZsbExVbTFvYVVIR1oxOGps?=
 =?utf-8?Q?cPXs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:26:56.2160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a476ba86-9168-4d25-0cb8-08de0d80d7ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9552

Hi all,

This set updates the AMD Address Translation Library to default to using
PRM handlers.

Patch 1 adds a small helper function in the ACPI PRMT code.

Patch 2 adds the new ATL functionality.

Please note there is a minor conflict with this set from Avadhut:
https://lore.kernel.org/r/20250915212244.886668-1-avadhut.naik@amd.com

Thanks,
Yazen

---
Changes in v2:
- Rebase on ras/edac-for-next.
- Add tags from Rafael and Mario.
- Remove prm_check() helper. (Boris)
- Link to v1: https://lore.kernel.org/r/20251006-wip-atl-prm-v1-0-4a62967fb2b0@amd.com

---
Yazen Ghannam (2):
      ACPI: PRM: Add acpi_prm_handler_available()
      RAS/AMD/ATL: Require PRM support for future systems

 drivers/acpi/prmt.c            |  6 ++++++
 drivers/ras/amd/atl/internal.h |  6 +++++-
 drivers/ras/amd/atl/prm.c      |  4 ----
 drivers/ras/amd/atl/system.c   | 23 +++++++++++++++++------
 drivers/ras/amd/atl/umc.c      |  2 +-
 include/linux/prmt.h           |  2 ++
 6 files changed, 31 insertions(+), 12 deletions(-)
---
base-commit: ea574fadd9fd209f209e4a154d56ae0c9e687d00
change-id: 20251006-wip-atl-prm-c5f8b5b71211



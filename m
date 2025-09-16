Return-Path: <linux-edac+bounces-4815-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D508B5A33C
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 22:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1711A462578
	for <lists+linux-edac@lfdr.de>; Tue, 16 Sep 2025 20:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C89285C90;
	Tue, 16 Sep 2025 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CWL0YHeM"
X-Original-To: linux-edac@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B224284671;
	Tue, 16 Sep 2025 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758054776; cv=fail; b=kD9pfv5ipKbnqoJPGebeNNsrAEBnMnuzLW0bja6HGEfO7r+L2O5kT/NmguMf2aboeuy6QCkKzBEcXIGEHp/ZHl8Xm2WW7tds6QYvKrk5v9mKs33bPWjgir4kL8/XklXZWg4X2LcW6LC3YAqAvwisL+B20D1cIh3RxZAAXIvTK3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758054776; c=relaxed/simple;
	bh=F/IPw3awJRvefmD8xgn2QivR11zrefuy2vISUPuYTdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3Sbrp/gsxNG8U+g6w8l+cY/JVlZGli+eYb4S3piklNe+Gb+WP/cFMI6EC3lfN6aOtJtOl7EErFLe+86Zt9TrJo1MU8CivGwIMqGWa0YdK+MpizCYvgiabyq5e4TWiEGCFLdlOmT6wx4fdGwSMcG1vsgZ/s02b3u4Vza7wcnV3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CWL0YHeM; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbYviWLuWAt8DLSio3OAfKYnz1AIuNdxhHgklYc+FuafrH6mzu7AU06Qn3XL8rQq8QdWCYAJUdLqOCLNQ+R6X00vkAZHbcUNa/G31B2e6q8Z7vjLeLzxzjkYWBDtukHImUvKPkZJFhlcoTUpbBAPSMQBoq1ZageskeqN4hTcAH9Y1nCfUTO5zb4fdng1ehofOsrxqVxh9qnw1FXSvVkgWtmERbmI65sOVNve7nDQMZfXm8ko8GJTmPtRtGjWkHV7v1ZZ2VgteGraVDCR/6NomawLT+tAy+bkQSpasVEKklAwLUWxLNER08siit1WwUO9NdbHA0lJFXTzDcg442SXEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3mXDQ+FifR6YQpdo63pvs+e4jVosOYYEcQZQuZOYS0=;
 b=GPrgyUcrhMZuf/yIdCCaaiapYa+I5dtNgfLiOxdkFyDxTcChIHOtoesD8I+Lf1546NPxR6KTvyCqQKm6gwRpKT0UGrAQZgyOAW+gmGN5vHh/dGVhgQa9dWXvlvP7fv1n7E9lxhcXmFHCq08tak+ja7A+Ys9NSXsey08NhggcqeU1ty8RtgMl7v4Ehfg7Awevhz2y8Em+w211r4MUFYic6A8+7e0xU8YXc1AuSUoLzWrIUhFgbgtKUvHF8k/MCon4d2ds9UY4Zd15Znn3heO/NwPKJggPgKkTU9XQZh8qFR4s+STjCZsDwa/fZCZyL2z+CuZ76m59VvnRGpAJPKUxHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3mXDQ+FifR6YQpdo63pvs+e4jVosOYYEcQZQuZOYS0=;
 b=CWL0YHeMlz5cXvxMkQ/+8pSQn9HY9yxmCmLYNgWprQ4SOHQkwmC9KpIbxoUJ7pSrfMpLoC2OWUnplWkTxy9bgmpcoLUjOxEm7JdKPJELtJ/bhl1hjWUlFLkJ0Ty1Z/mf9//COqSJjfgOZ0aiUFlGh39K2DN8b1ZNixJ9+XZ5yAc=
Received: from BY5PR17CA0003.namprd17.prod.outlook.com (2603:10b6:a03:1b8::16)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Tue, 16 Sep 2025 20:32:49 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::1a) by BY5PR17CA0003.outlook.office365.com
 (2603:10b6:a03:1b8::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 20:32:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Tue, 16 Sep 2025 20:32:49 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 16 Sep 2025 13:32:48 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadnaik@amd.com>
Subject: [PATCH 0/2] Add support for AMD Family 1Ah-based SOCs
Date: Tue, 16 Sep 2025 20:30:15 +0000
Message-ID: <20250916203242.1281036-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: d2423774-91a6-4cac-8fed-08ddf56033f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQfnY9+FctqLfqb60G+9tu8ChhCmqyFDSo8wfvQdApNRqLy8O4RFEbG5qr6f?=
 =?us-ascii?Q?06NoQ+Rc6AccVlhyf4d3HRafr3JLavLLze8BRm93ci3uO/5ZFBCOKegW28rt?=
 =?us-ascii?Q?m8L3FV6y68nMebLY2AOlljEdkLEbAkzIXKGWPUMNmD+SLOoqdkj/ROixKhBM?=
 =?us-ascii?Q?D62we62PCmxyRpXhBfwyCFLk+SKQzmtFgwmMr0Odt9rNyDd6/7y/jzVHuCrU?=
 =?us-ascii?Q?C2dgZyczbkwgU7tnXilJIdF58MEoE23x5ozOXCnJnjdMbFwhCtt0aR0S0rSp?=
 =?us-ascii?Q?VokPn47MBUAyh22LR5kEAj4PfoxKFop+4orpLvmU+ooW3dCnbgg8d1rlCOT+?=
 =?us-ascii?Q?E35ljDESupzFotOcejh5vtOSxo394X3i8SEAdGe79Q2SkHci5gW3MzsKpygT?=
 =?us-ascii?Q?BtJN9VOifBeMLVPJwE0Zw71HrcIIunAabK+1SqtI+9o9ECEynUb5iM77LuYU?=
 =?us-ascii?Q?6GkHYrsHQK2Sn1QHHU8N0C56cB9bcpiOPhm8z/SukQBfeBepdwakfuO0rdOH?=
 =?us-ascii?Q?XMRIcXVQ8iXaQjyzBlpO3SI5erA205bD8rBj1WdpDZSbEeZ3PB2GZQPdO0SY?=
 =?us-ascii?Q?/4IeHKvePOHySQEtn53aCqAGKJqBVP7wRMFBDA51R6DVqUgKylzSmj9N9Odw?=
 =?us-ascii?Q?TMu+HTv4YxqAjZb2zc3qBRrE+XXXaCtAvF3OxUdrg6HMYfefj05Pl3RnVEq0?=
 =?us-ascii?Q?9zgQPHwsSx9wVjGTh9xik0tMgLdRDEOhqwMhR+vwfTIzZI3ZvUVrqIE8c+IH?=
 =?us-ascii?Q?CiSqh2NcjQkAEW/JifyWTAAtacBC/3buEHBnkUw1FBwaCtTaOX64z+1pXUBI?=
 =?us-ascii?Q?4mPoghOVMtDlVQ3aE17taO1EyUk4RKLyizeq/PDdgslxGlgqK2/VuoELqC4h?=
 =?us-ascii?Q?JVqq92ah/Fx+iwGqZaqrdqQRiTfbLWQJbAlrXRrobRWiCUCSLGOIlQA2XNBH?=
 =?us-ascii?Q?9SWwRZAHJwNSeFy/BkKXad9jHDaZXrGqlSDgBsJR/TWPTwocLoGyLZ0aQkSU?=
 =?us-ascii?Q?MsL7JCkxcgX+l1ads53SfHp91QUPfAffDKXRwdY2C8HEkfx5X/atsAeE6i0B?=
 =?us-ascii?Q?PoA+oVXAK30ipoqqa772vt4HNqymPmOqgQhRFMVm70Pr+xgqmdwX9D5LHuE0?=
 =?us-ascii?Q?uXyv//yXaEEB9h2dw9qRjzbZg12pRpOWCsCcq8BvkzxT/gmHz6wyFrCiVZBj?=
 =?us-ascii?Q?53wCcL3KtOZAXdRs0apx+ZtpTeCcPFOG5gDjlTHmdBOtQBwNanrtG0HUuqtA?=
 =?us-ascii?Q?rI9CpMj41ASbWHM3tBkovENmLo8uh33LGosLj8be3WeOp46jJauE0/Cc2xJC?=
 =?us-ascii?Q?xoHLmhK3TnNCyY4SwnXUKahGqo1BOLqI59sXmgGbR0uJhvo6EO3pZlwofRLm?=
 =?us-ascii?Q?IZxrPKpOV6lJzbshp+Ygp6iMDrmF3a8I/0T2T7kAthwuoipl2sm56V3dxy8O?=
 =?us-ascii?Q?A15ciDCjlM8QI+6JdeDSQMakU5GBZnjT7QooeCFROJxiSuJwMLWRZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 20:32:49.2525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2423774-91a6-4cac-8fed-08ddf56033f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349

This patchset adds support for newer AMD's Family 1Ah-based SOCs.

The first patch adds support for these new SOCs in the amd64_edac module.

The second patch modifies the legacy EDAC sysfs interface so that the 16
UMCs supported by some of these new SOCs are appropriately visible through
the interface.

NOTE:
This set was part of the larger EDAC updates and cleanups set sent out
last week.

Link: https://lore.kernel.org/all/20250909185748.1621098-1-avadhut.naik@amd.com/

However, since some cleanups are still being worked on and since these
patches are required for enabling EDAC on Venice, have separated the sets.

The cleanups will now be posted as a separate set.

Avadhut Naik (2):
  EDAC/amd64: Add support for AMD family 1Ah-based newer models
  EDAC/mc_sysfs: Increase legacy channel support to 16

 drivers/edac/amd64_edac.c    | 20 ++++++++++++++++++++
 drivers/edac/amd64_edac.h    |  2 +-
 drivers/edac/edac_mc_sysfs.c | 24 ++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)


base-commit: f55d2af9afe33db61b58e1c5273dfdd8c102e4f9
-- 
2.43.0



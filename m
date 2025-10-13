Return-Path: <linux-edac+bounces-5030-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5D9BD58C1
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BE23AE2FE
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 17:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831F3305051;
	Mon, 13 Oct 2025 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pzvqvmb7"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF602FBDEB;
	Mon, 13 Oct 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760377016; cv=fail; b=YpZzRi5kn5k0dBb5KunKECad3NRh8Df+1yUrfgVeoi0aqU4QUoNoGIO+S5iCBqV8GZiVoXM3LozEOQBSooVJju6ACbuSfKb5n3PsVjMDdc57TE0ykOeln0R+t3lXR6sYjjsS22fZpolQqLgnAQ94FpCPsFRUkglyiDB828YP6B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760377016; c=relaxed/simple;
	bh=unyBbVBZiMH05Tt19pg9MuDRqj/fGcr1Xl/0F141lFY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TVVeBh4C8H5lIGxajOy5nfNNl7Z7f83G27BHjPu6Lv7Fp90SxK8S49VlwediKirTHj2V8NPIw01+FhO93KCptvS5WeConZqNQ1RonxgL1EEntx30ZvsUcOOJrY5qkdBNLYLx5u8OeftBiMSDuNamlu5kuUAXpPSsZkX1nkOVaV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pzvqvmb7; arc=fail smtp.client-ip=52.101.43.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Na4VcDpFzTIjy8OAmGE5LERzGduyLpvWn9gzTK/h4mfFTj914iIl5B+ukoMtnxiiS99Z27N/QcTdyJP1qKRKD64KfH2wdJIFhhDiKEbcQkHgwZUZpdDlY8/OlH0HniwVyTg5uVB+1RoH23swrL3e0mNuIheJaOmNZ33BFu2auhNcj56p0sLpdp2qJXYqbZPljif+JwTP918bXs0sKnRoeQy99gPEBL5USnofgkTmEh8rJzxqSqqXFZoVLzAW+lGkEZcZ+PM3tyIzsB7yNvPZd1m+a9QaSA+fXfSWWkNIL3coHj9QZi3xAT9H3SiLLtjY6Qzh1lWpBu8VlHkBOlCfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep/ExIdJi610zOJ9BfOh2k0DiNxa63GNSxR2SqeVFI8=;
 b=Yy5LGSmiTVnq4uL95kagomUPwu7F8+yHT0T+FV83JoYBhINSGn7OyquNTvy0rMHM31lzqQv6YbhLO+wT68sgdRKLnrEPgySegcYC4y4jRRh//Modo2fmnmgLcLa/SgDX9/iVOScW2tfqn89XyTh67jnurCSylVROIHWGeafT+uikkyeiTk0nYq1gLF4B1PlF9+jVtJI+BdRAJArYULY7HN1jhfI5EC1XNazA5TYx6YOu6QlB+FfhbPVEzV/iQVyRbo0THnf67OnbSFmP6wTmsSFHEC6Ee+zFipaffoUbrZ4rKKVdDHk4rWuw6LtjHVmBRDyYVcIHYBhJUF5UkY77oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ep/ExIdJi610zOJ9BfOh2k0DiNxa63GNSxR2SqeVFI8=;
 b=pzvqvmb7gcXVKwq1iYW28jTTlKBNpJ3yUqbda4BMM8dRfhUrcv1EznB1g8Qbf5huAKpgjxhg98TGz6B33vJvgof8hmdwVIEn8D1NteUsRt8EXGdLU2pMHVOxpc7d/w9VT1JexS9L/G0WZdyu+hHes7SuyOdKdgpbkeKAylnrjDg=
Received: from CH2PR07CA0058.namprd07.prod.outlook.com (2603:10b6:610:5b::32)
 by PH8PR12MB6988.namprd12.prod.outlook.com (2603:10b6:510:1bf::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:36:44 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::9a) by CH2PR07CA0058.outlook.office365.com
 (2603:10b6:610:5b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 17:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 17:36:43 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 13 Oct 2025 10:36:43 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH 0/4] Cleanups in amd64_edac
Date: Mon, 13 Oct 2025 17:30:39 +0000
Message-ID: <20251013173632.1449366-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH8PR12MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 5af79a2e-25c1-481a-28d2-08de0a7f13ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PHtTcN29TiAbAWWxDNrcv1+93dEmJc4gi4ITA81HO0lRnHSvhhSVJYyrlOLP?=
 =?us-ascii?Q?ls67eLITUkCElSk7dClkE9m1sPWnpgOe4/jsSBGl0hKa5iuyAy5039/8X9Ek?=
 =?us-ascii?Q?6w7SxuH9DmrZgUWLI3AVNyTyIhxU4pUZUsZ2VpF/qOuy54z5osMUE8h+LwJu?=
 =?us-ascii?Q?+UFsfP3JJyBT4myoe0J3Q83P4whSixrqYuUx3bPkFkspDE5jP1vNG5IBkh5N?=
 =?us-ascii?Q?R0T1R8QyUvPi+m6H4tNrxAyxSQ6UO43sKmFAAUjFaX9j4byuxSBL+fAL4MjC?=
 =?us-ascii?Q?wLV51K+ACRPnDk9l5dhNgP4DRgMCdCR6mvZXXEH2t0g+kZhYE6EE+JF0cg62?=
 =?us-ascii?Q?ZJdLBst3U8/u8HxY67gq7ocOj5ZNn1Oq0TBKybAPUwFVmK7D7w/BFOaAjmeh?=
 =?us-ascii?Q?P4rNGpIvPcVQRFVl6eQG4OiTVKiISpK90O+jaK9UA4gmcH4i9IDzIlNShgiB?=
 =?us-ascii?Q?JI8ylOz/n4dXLSz4Uk1ic1I/PbZkQwe0zqvS0E6SWmS2MiQ9jnJ70gK0SNhx?=
 =?us-ascii?Q?qqBd8BZIgPi5IijBsRfchl8TrNEZV7aY959SDhPFbvhtLKZMwvw95hGfC85B?=
 =?us-ascii?Q?P6jQ1g8kZMmOM5NGfvZm7dgZ9/cczo1xDGEUpSyklA5Z1NJjEpbR6nQd0wRc?=
 =?us-ascii?Q?aEkGKvZzdyGQYWLHa9TqE74kqvGTO2LKH34/WdAqgXVF9fJ82mSel0AGX5Qo?=
 =?us-ascii?Q?7h6D5xEoZnRAHWPgsbQaG+wdvyKZcQksaMuMgifrIOk64bzp17Ld601KiKCm?=
 =?us-ascii?Q?JTIN3f5CV1SU9wBmBL0USO/9DpfCPKjZxeyDy146JMM5axPwjuZnXDopmDmO?=
 =?us-ascii?Q?61085L+UF4sukxuIwLnnnacxbA1V436Y9nQDNyVkLCsdZLVhoIpaYI8gwww7?=
 =?us-ascii?Q?5ZGaT4bkB+40e1TB3dCzsYd5pEW7qbnj/M6Qqf65fT+tAD51uCfQDXilRZqK?=
 =?us-ascii?Q?f38k6aIoLsgQ49cBR00nDbPT0KsbBkP58OF5DyDgDg8gO0qe9ZeN+h5Mco4k?=
 =?us-ascii?Q?2WIYxzTi4z8B/vVQ/JIrsyGEXoOdT6h/q3C+1NCuq/F/rsge/DoIyQUXbox0?=
 =?us-ascii?Q?Egton/xJRakI6dlWxjhIBXNkIoNayxP5yUTgaDyn096d3Oc0PlnAToTBjeuE?=
 =?us-ascii?Q?3GacgP0xEWCBRoRmZucMD6EfQaPXJMawiZF26mVJf6FfpStZ/sC5uKLx611o?=
 =?us-ascii?Q?EL+udaayG4ghtNwCwTUNeq/2pWamIARnL97OFJvaDClq4rSgSnX0QrKBosuF?=
 =?us-ascii?Q?inh+oWKZdwtpFj8WTA6GnTIALTeC0qjTRZ/Tof2JVzn/fvwXd+zZSYCEwXz7?=
 =?us-ascii?Q?NUuBXziFg9JJZxmFMqtUacYMTws6RfGm0j4xFgek6RdSHmcVG6/YlwNX/PnA?=
 =?us-ascii?Q?ssZOJEqyyTiwkzUx86L1/gO4PIJGV2FtFp1o+EbKdjWr5RX+QRD/7k6oXlTY?=
 =?us-ascii?Q?2vP8/wQ0LIyKs7MnwgrYl+7hDwWfwrJX6n8mQscaz6+pRZgMVfC41Mpl0Rk1?=
 =?us-ascii?Q?Pa7fJUIqgxzDb5f5/k5h1hr23thEXCttWL/oqIthqqX3e7id2OnsOMRoGih4?=
 =?us-ascii?Q?zosPMmc7SeTmY9Nk6Kg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:36:43.9723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af79a2e-25c1-481a-28d2-08de0a7f13ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6988

This patchset undertakes some cleanups in the amd64_edac module.

The first patch removes explicit assignment of the ctl_name string and
instead generates it at runtime using scnprintf.

The second patch removes the NUM_CONTROLLERS macro and instead uses the
max_mcs variable to determine the size of chipselect array.

The third patch sets zn_regs_v2 flag for all SOCs in Family 1Ah and later.

The fourth patch initiates deprecation of the legacy EDAC sysfs interface.

NOTE:
These cleanups were earlier submitted as part of the set adding EDAC
support for AMD's newer Family 1Ah-based SOCs.[1] However, since the
support patches were critical to enabling EDAC on newer AMD SOCs and
since these cleanups were still under review, the set was split up.

[1]: https://lore.kernel.org/all/20250909185748.1621098-1-avadhut.naik@amd.com/

Avadhut Naik (4):
  EDAC/amd64: Generate ctl_name string at runtime
  EDAC/amd64: Remove NUM_CONTROLLERS macro
  EDAC/amd64: Set zn_regs_v2 flag for all AMD Family 1Ah-based SOCs
  EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC interface

 drivers/edac/Kconfig         |  2 +-
 drivers/edac/amd64_edac.c    | 69 +++++++++---------------------------
 drivers/edac/amd64_edac.h    |  9 ++---
 drivers/edac/edac_mc.h       |  5 +++
 drivers/edac/edac_mc_sysfs.c | 16 +++++++++
 5 files changed, 44 insertions(+), 57 deletions(-)


base-commit: 5c4a065eebd70227b51bb2c8d06e9e4c1b313b05
-- 
2.43.0



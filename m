Return-Path: <linux-edac+bounces-2600-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6BD9D5CDE
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8172822E9
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2861CB511;
	Fri, 22 Nov 2024 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cm9kFRYp"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F88DB67F;
	Fri, 22 Nov 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270004; cv=fail; b=moXiPoJa44xxVZiMgIa0VOK1mTrygeJs2hsAeDfjkAEAiWwOvgC5FHOeYi11B9e3DRGdPQq5Y5kiMd+DjwwMJwxc+2VrFf49BQJr30P39eTrK5glwfFX2c/aCK9uw3vILZ0YbMLF7PG5D4n3qncKZZ1zTBAcbHg3zNWuta6x1I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270004; c=relaxed/simple;
	bh=vuDHf2CrrqSpqjSsIasBmss7Tw8Zj7OtsM9G8cI0T0A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J5uCVyZtT2oRG63LpSQOPQ4Ch726yqk0tOC+spHbDd0Q1iOf7hB0EmCPmB+ZZLybUz6BaU4YilMmKnVymmsuHS7z3x7xoQ+gFA7uCya8/Uls4FY6n39zMGEEp2bjVNYzY1Iv6yCKKR2Nioy+HqiactkS03X2bq9JEDwZxFjj/dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cm9kFRYp; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j1oqkWs4icq9mxIhGPrHn0+j8YSLg7XoHRk55a5WEvpM41ynDAr2U5eO7/M4YFrAuwCKm6l2pYPIE0fUqH97NDpyHm+c5YC8lcmgohSuxcEMSmmnr4wJVDoOwEzl9YLX3s21wzV0fi2wqAZGuioGIUFMtWUdv8MuHwt052XMzZrEOMi9U5VvBSqBed2MvEzDxu7KT77fJ14GX3zRveeeEAEBpQiiyBhJp+ZI+gYetKErSEu2ycjR4UOfO2QxIa4xEkoSS+0dQeMASQEIkoqnDDXUqNXkQJnosJy/Euj3Q7+DX6XOE9KhVnbzdZ1LsI18Y4N8n9JcO9DXep6Kvn53CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5tuiXIb8aW2iOyYa8ugP8jbMClrGNlMj1xPzcF5Jfs=;
 b=Kynl0tKlBm2VeBOgXwPWS9+Wn9C0bnX+uTOQNhoUm7HTfSY4eF63xBdLD36pDIbu6dg1399PzG4jLZSCSqpVVBihRMH0ColiejGsnKAdA0xHXJ0wNaUNW5oay0QrtdyYDwwxrJjtCnRtmPGMU/KEYrsXZBFnpvdzfP/jrzsymfeO2XrML2apUwLihoWGCVWUpYC4S/HJ7A4wr7oyB/jt2VIJrc/IzpoQm8w5ZJCj7+hrArIEkJ+18CpXi1gQOH+Sy39kJ13MPtnRvPYX2nwg5WznPv+bWaaNMXYreEiPL7SgTKOMkQZ3nSQUArrjtuq1leCCfc5y5hqOAbP9xB3Tfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5tuiXIb8aW2iOyYa8ugP8jbMClrGNlMj1xPzcF5Jfs=;
 b=Cm9kFRYpQujAMvsX/6W3b7SARpnPlPMnBdCeFdsvMmNVMoHJAZxtPvnkduBvvFLn2s5E0s2aCUBGhFWlqEWcnS5Ew2449G7PKUWJiZ4N1zFDvkPXt/RYNsHmhfFGYHtVuXxo0XiJmoFfUYtIeZu2pXpnLzByvBwuuATOA1kC/Mc=
Received: from SJ0P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::32)
 by BN5PR12MB9464.namprd12.prod.outlook.com (2603:10b6:408:2ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Fri, 22 Nov
 2024 10:06:37 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::38) by SJ0P220CA0024.outlook.office365.com
 (2603:10b6:a03:41b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 10:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:06:36 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:35 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:34 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 04:06:31 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <krzk@kernel.or>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 0/3] EDAC: Versal NET: Add support for error notification
Date: Fri, 22 Nov 2024 15:36:22 +0530
Message-ID: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|BN5PR12MB9464:EE_
X-MS-Office365-Filtering-Correlation-Id: e20342e5-366d-4202-39c1-08dd0add5a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hg0Za3hnrzZliAZ2lq5uChln1eA8J5+adVtL69TbdXOfW/LcOkcNrlOmicn2?=
 =?us-ascii?Q?KDNS2jA/+ka7tVcSO+GLnIx5b8VAV/jwSJNjJSK3En8zn7WBvqO8xuc6OhFz?=
 =?us-ascii?Q?oOCLfvZVW1P04/NOUDuMnBcVL0xVPurPrGsD8DD2/miiPTa/GAqLtbE5h/Tj?=
 =?us-ascii?Q?0nVMmWf7D1qO6+FanuSnnpKcAw6NDR2P9X3oFJShaMOChAwujC0mXVniT6GJ?=
 =?us-ascii?Q?zU2YTch4jJqloAI+QePz+2Qw71TkRuK89C29mJ/kL3IZB1Zi5lvit2t3hEGs?=
 =?us-ascii?Q?oGpyqBYkOHWaVP6HSmJxeoYAy8yj2x3T5krTvMX4X1Z5p0bosj5bZA44qHVi?=
 =?us-ascii?Q?0Yzjsg90qJ2aRwmc+4R2lgpVFxCLAH0b3n5K6jKMHc8/ORay8q5qIeEf3M5U?=
 =?us-ascii?Q?pOnIedn6WgenY3ohCXh3JE52YaMj/vAHB4vNfJpVoc3UlrHEU5555RYao/Ft?=
 =?us-ascii?Q?ZEaXByS/BReDPJKxk9isyfrNHJ5znDsQpI8bd86sLHbChXAETRnih3JIORix?=
 =?us-ascii?Q?ny+0YKQWyd8m7XZqAdmBED6Ncjl0ZcS67VAfNRBTx4R5WsMmXGa9C/jA4cMF?=
 =?us-ascii?Q?aM6VAen9hnIxnUaa33ZplSykwMkvGNQ7L8jMPpBuO8hnSpJ0fC0l6XnZIjLx?=
 =?us-ascii?Q?TKsh+9r+cY1zecReO/lJaUtRl1HUiBJURN6nzay3b7KQOU/poJIBuFmmoUn2?=
 =?us-ascii?Q?+v5lcYO9BolfzZaiBWgDk0A0lmLMYsfSMTWSrd9See2kep83QHPCPCHxM5wR?=
 =?us-ascii?Q?KFOhZ4bbP2rhIO2wPdMy1IU2xu+VNVaz9xYYWQDG0t6FIKf0CKCEGq2J8st6?=
 =?us-ascii?Q?xACQhTIZppw1rQKI4TWgg91cm39avtzEVpVirMS37JKKUSBwJNhHRpG0TK1f?=
 =?us-ascii?Q?zNzE78yysdSeJn3oRJssZEVzY0IWJnl8VgIzfNuabNyVy2/nP4y8pwaMxa5k?=
 =?us-ascii?Q?5GJtAgF4dGolRm7Jeh5Lol/elrTHTYumUPwyMXbGLRUrdp5HfV7+CgXU5vnO?=
 =?us-ascii?Q?RwPK30bGuKihKcBHBY5aID4Bo74oa31S9A+Qirpol8sd8F53s6awgpgIr563?=
 =?us-ascii?Q?156KQMoRpUb6ZJHktpawDuPRiw+PH/6Y/Z5+AjKOE/oooGY0l7hd6RKeORD2?=
 =?us-ascii?Q?TEqTZBCss/Sj9ab5P0/DMMkZ6rn3h7b3eEr/hxNt2CwhQ3ZyImgDOsdFBYPf?=
 =?us-ascii?Q?VRjVtVZTen1OgiKfgjoRNgqRMJ+tmBRYrRFiPC+BCSCHbAoHrB5b5L0NfLCK?=
 =?us-ascii?Q?lsSRPBQ6YdTNJKWin1HaWOh1ZfsSHYpUZU2xpENDRSJ0J7IK7w1qTcBohJ3/?=
 =?us-ascii?Q?1hDdySaqxrw5oI8FQ/9rTrX1uQ6UVr/4b9AB86uHZQXwt4eOczRQox1iJbBu?=
 =?us-ascii?Q?r/YZJCJooJofd5bDA9GqIpT6kLoyXrfosTlvnApVODjlzI+we/1tW0F7oelW?=
 =?us-ascii?Q?OZP506lT08eNIkUnTH4/mYMUUFDhqph6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:06:36.9494
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20342e5-366d-4202-39c1-08dd0add5a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9464

Adds support for the error notification.
Currently 20 errors has been tested.
This driver is receiving events over rpmsg.
It does not access the registers by itself instead the NMC
reads and sends the info by rpmsg

Also we register the edac once and it reports the errors for all the
events including the 8 DDRMC controllers. So while registering we give
the particulars of the 1st controller.


Shubhrajyoti Datta (3):
  dt-bindings: memory-controllers: Add support for Versal NET EDAC
  cdx: add DDRMC commands
  EDAC: Versal NET: Add support for error notification

 .../ABI/testing/sysfs-driver-versalnet-edac   |   11 +
 .../amd,versalnet-edac.yaml                   |   56 +
 drivers/cdx/controller/mc_cdx_pcol.h          |   16 +
 drivers/edac/Kconfig                          |    9 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_rpmsg_edac.c           | 1321 +++++++++++++++++
 6 files changed, 1414 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-versalnet-edac
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-edac.yaml
 create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

-- 
2.17.1



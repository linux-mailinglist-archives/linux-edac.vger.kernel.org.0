Return-Path: <linux-edac+bounces-5527-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70FC820BE
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 19:13:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F9334E2BEB
	for <lists+linux-edac@lfdr.de>; Mon, 24 Nov 2025 18:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56E317715;
	Mon, 24 Nov 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mXCBRfYc"
X-Original-To: linux-edac@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013012.outbound.protection.outlook.com [40.107.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5C32C11F5;
	Mon, 24 Nov 2025 18:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008036; cv=fail; b=gqBDVP9SYy/SnrYD+25du7PZai0pOOwmPsXJiXuCIG7bmDCS37v3iu1/fNv3S5znWmroFbZRKSij2LSEDheSajUALp+hOPgtISJVZ9JICuAyCQkhnuftHBoElOyhCq8zfqmGPtth+L0ivlxcdnyVXN6e9DEuU5Mf8GiP4AMkvb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008036; c=relaxed/simple;
	bh=U4SuZnZ6aHKLR0isRC5RZAdTQsplbqZ18tLDK86hZh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=urkIHC5nluCOq1EF3HEm6vSw6G1erG1F8sSFLKroDGItB6SzFyGie5aKa100zrCxwMQLsUkYbPk5lS4UdD8XMXnYhth1vP+x+0ygn3yQgTQwsL6U1T+7OVX1qnF2VFfiwm/rPNesfQWwsUZK3b74llJph5mP/bMlRqleVskJikI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mXCBRfYc; arc=fail smtp.client-ip=40.107.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IBR1FJhg6gBY/c83Z/cP6gYvxsCHeHgZW2OP4p5zBzGRXT5diF5suWb8yJYJAJJYStxW0u5HJaMfRzjaPgpzjlfeqcShH8gRi2LWhRq5UuTncucFWh1W0VDsRrt5frf+GcyK/mYOHKJ7xcoKgaUnhZCjiE9BWzQkxzErQLhxhERa0EZ1RIsFYn/BLMzWjFdjrs7t1f6D0CamPhM5WKL0mHLs4bWAcXGJf4NfRVHRBUHPVA+LdC8gUT4oB3F6l6Qcqn70q4sD1W8jOzWA+GfNazPTrQ1Ttbidh9vXK/ntOOn6oI12mo+vl1PtEufzCQmwm+Zfkq0hE+sdAKPdZRVrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQ2hElsFwixwHsOTK4yTxfuFZa5wI6YRbZL1lUa1SpY=;
 b=pz9gwc2o4S9PComZ63BBSx5PgO0lC/T00HO/lhL93veIZ1XtXKcaJyQ36m0Qtpe/SlqGJd5i9mpVbHtB3oWKKbESuHcKZqAW2bWr45akrKMDMUtTAkTpJ1nL9sAokB9zokpBmsp1pJEBTWS318wWLSXLm20gLeel3nbZOPahoEu51TGw8Vj7uIv6Xd/5ogkxm2owIKJJjVVs9webNr5zM2G+CngGnBAHHuhpcHxwDqDCGFGO50dZFJhfDDdaUzcAkyBbv/rtax4sb/o9nOzU4iMTjHokJuUjPaHS5ro4Y9bnLBpWjpmGljvJyU51uBRdqNsZbV0Z2KguLCBtTX8jfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQ2hElsFwixwHsOTK4yTxfuFZa5wI6YRbZL1lUa1SpY=;
 b=mXCBRfYcVKFpJCXUfFuv11rECzBRBGM9rDTGLvQNgkAWJ4jT0Pea9ZqrNjGliYNY8+0R4OQAqc7id24OSiGACefFYxkxpTXrTdtQ0TQPARZzmLhYx0wonZVilL1H6IX4qzwHXANkpo6lGuiGw9t0zYECxwOyblsUL6HjlI9gYmc=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by SA5PPFE3F7EF2AE.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 18:13:49 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::b5) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 18:13:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 18:13:45 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 24 Nov
 2025 12:13:44 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Nov
 2025 12:13:44 -0600
Received: from yocto-build.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 24 Nov 2025 10:13:42 -0800
From: Devang Vyas <devangnayanbhai.vyas@amd.com>
To: <yazen.ghannam@amd.com>, <bp@alien8.de>, <tony.luck@intel.com>,
	<linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Devang Vyas <devangnayanbhai.vyas@amd.com>, Ramesh Garidapuri
	<ramesh.garidapuri@amd.com>
Subject: [PATCH] EDAC/amd64: Add support for family 19h, models 40h-4fh
Date: Mon, 24 Nov 2025 23:43:35 +0530
Message-ID: <20251124181335.284780-1-devangnayanbhai.vyas@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: devangnayanbhai.vyas@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|SA5PPFE3F7EF2AE:EE_
X-MS-Office365-Filtering-Correlation-Id: 563257b8-e56d-41f2-e0f1-08de2b853505
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+pCDfd6dLAQ9hlMN06Sea4hUEUZI6nc/6jSFhpYO9NT+pk0Kji0GQdD7A2UY?=
 =?us-ascii?Q?9SgHLKyejA21mWF817im9KhTVBi18EqJlRsflO6bL+F1efXzLDxqxtil2ijQ?=
 =?us-ascii?Q?G8RqMGmk3ixkI4xxJNzqk8n69Ottdmxa2Kpl6D/7gIGQ4/Sj5B+qQLt6PKXT?=
 =?us-ascii?Q?JGw4L3uhnhkPu36dHuUX6qzv4dsazkFdafzUjbvxejYa2iaDw1dLP1a1JRVR?=
 =?us-ascii?Q?CY3Y8+AJeOGiLHWIt6EFDK1AnYaKB/DQA5tiiaerEjy/+UK8ALPd/daj3RTV?=
 =?us-ascii?Q?0PMGCAqG8HaTautxmrIoGB5/r3NY0ZyjZteOYKOY+uOhxnja1T7wtFD6cL+Z?=
 =?us-ascii?Q?40ngsFcjElny7LDFMl1ccne0WPDy3Cw8TGNsjwY0KzDms+IqwjYPwpcUc9Mc?=
 =?us-ascii?Q?IBoDF0srH2ifTQjMRBZAMhBXnk7YTWvusTyKbsyWVuGO2vwT5/K6kA1PqrT4?=
 =?us-ascii?Q?zLdJMsZJUe0/xEjiD9+fNLZTc7586MbqTDrBx7nXqSp1fSBvW82bpX+JpADR?=
 =?us-ascii?Q?v9G/yhyGzNhOZK9GbjYNlI0B7oo8bndTHtOYotXJQDkQRFMjh00GGTqiH2H7?=
 =?us-ascii?Q?BCiEtE43+PNXJAJxZqQlzaeu/PJyhDL+0U/F/WoYRKyyEn9wT2+I/sjLUgDp?=
 =?us-ascii?Q?vcnUOtwVdaOpPRufur/ScoTOhZ87hHWLPIqmt/sAR0SJkSzF37YqlGf5/uXC?=
 =?us-ascii?Q?jzzNGvh4W2MAWfiEqumQvi1oTuzVu3kWjJ8pN30kNpN33n963VHlWgTXQMXN?=
 =?us-ascii?Q?Ab7ojQUjwIYw7M70UdNN8E+y43FQzihY5s7O7bjz1psoElpoihVRmOc3j3qd?=
 =?us-ascii?Q?Be222BoIQnHaUCkx+UTmt96q35eHJIxNSAT4Yh0384phkP4lg+AAKwNsSG7M?=
 =?us-ascii?Q?6wRxrAkg3v0niRMNIFDJdwZlyUEtoklYoHIwZhpfR8JKfnPoIT/DrGnTv5pF?=
 =?us-ascii?Q?551LtM/okfsUXQ3pByFJ1Aw/V/aVZtNfndC3UonXrkwKyTRxWu9hf3kraBVK?=
 =?us-ascii?Q?aWe72p/G7KLh5i3P+5eVOcTfrVQQgEHnOIPjanI8ZT4jD2VJoIgklSYr4Zz6?=
 =?us-ascii?Q?7QhiSyr/KfGIr2kyWExUSUdWxaGq8NxETQEnaVFClk3z4D6GP9bg/Vp66vlp?=
 =?us-ascii?Q?wKQQ7cdFhdqQ5hKdXXwoWakhJtCtcaxFAdCwm/yASue0SiD+bd6Pdj997wrs?=
 =?us-ascii?Q?80enPQq7rZMD4kiH2ChqgDkkrD9FibrAxBox8ei5DwYUJql3nfmnBsfIAcqO?=
 =?us-ascii?Q?kmPKNCc14io6B/xyfjOE/J9GFNe9e+F6ra11vPGWV+0G+FZifBMBmRO9OXU/?=
 =?us-ascii?Q?Lp6XvkMeWo4PaK7Ky2HJChe90K7NeQGsYwYuB4cFw+i/6/VGHwFA2UWlWbQa?=
 =?us-ascii?Q?qT7pRxxJgNEh4tjyX05G51K3u9uFA5yTw0X/sM2ifPiAZgxECFQwizVoMQLK?=
 =?us-ascii?Q?vNhKszOWLrebFUQ5qIYLRQRqpS9mQ/qsRdsuj3NMTSyMF4h4ai+BGb9Rfci7?=
 =?us-ascii?Q?TeUaT2sRlAewLq3/QoU5ATYDo49fSftJMZe/mmVXLiku5iSK4gNB2bk6uSpJ?=
 =?us-ascii?Q?b+erSl/X7sjBdzbiNRw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 18:13:45.2078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 563257b8-e56d-41f2-e0f1-08de2b853505
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFE3F7EF2AE

This patch updates the EDAC driver to include support
for AMD SoC family 19h models 40h-4fh to support
Ryzen 6000 CPUs/APUs ("Rembrandt").

The added changes enhance the ability to detect and
report memory errors on systems that utilize AMD SoCs
from the specified family.

Co-developed-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Signed-off-by: Ramesh Garidapuri <ramesh.garidapuri@amd.com>
Signed-off-by: Devang Vyas <devangnayanbhai.vyas@amd.com>
---
 drivers/edac/amd64_edac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2391f3469961..6cf0b6d7b5ec 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3863,6 +3863,9 @@ static int per_family_init(struct amd64_pvt *pvt)
 				pvt->max_mcs		= 8;
 			}
 			break;
+		case 0x40 ... 0x4f:
+			pvt->max_mcs			= 4;
+			break;
 		case 0x60 ... 0x6f:
 			pvt->flags.zn_regs_v2		= 1;
 			break;
-- 
2.25.1



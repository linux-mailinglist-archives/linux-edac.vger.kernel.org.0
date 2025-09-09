Return-Path: <linux-edac+bounces-4764-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766E0B505A9
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 20:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7A4164F35
	for <lists+linux-edac@lfdr.de>; Tue,  9 Sep 2025 18:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205F22FFDDB;
	Tue,  9 Sep 2025 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="idw+IXic"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736602E2F1A;
	Tue,  9 Sep 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444281; cv=fail; b=opVeWZcqzIlmO5LVsC4SCnvvjNdu7DjvbkKNrmP0Fz+P8Ot6lQvmYelgGda2IhgUvcJtoUzxnZTY5qHB9TS1UZHes/go+QCrBeunWr/z54o0EeQOGU9emqJvxUypMQ+gAsijsS+tymNtm8E55SpcUI68Er516ZP6gJ46eLsf9Z4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444281; c=relaxed/simple;
	bh=4CEQQhZnzFXmMJPD/I5TlKMs1noZbplvpyjVQBKGi1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrkt2gKP8jEPImMs8kVUThTc4XUFjShIUVceUMbn6t4n6COBKg2Gj+KmTuwdH65P37PQm5JEQkXlvNPlwxvxbyJgmxKedgcFSkEBoyHb0mh20mr9EmwX5jqYRC6WdLvp//eTckwHWk+3Sf98K64f5fSTZFlVwdm9TJSVxZ179Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=idw+IXic; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ojl+z35OV2EXaNlB8YPFi8+iFxQmWEUZnPf/oo9UNSrmhiDRIOIO801gzV17Bpvklx5x++8da0WXNrx72iooM7huRwwQAWcPVoUCoIC1B906umZ4aCt2bgeskY5QaZHSf3Qt3SilP0UZlwvIp4ckS9cirDrs2AR6ld5MnlXkPObKBdGdMx6OqZWEW15n++2ZGOnIiWAS5YzXk8eKQVbyPhYr9RhwHBeshfDXE5/s3sFJXqZq5V7WwAO+1WvO0pOCKG9o0SYcTufjO5vkipBcaD/iQ+5PqjwDb3p6SSaEGfZPAIKCzwwklWU7E5Zw2W1GHNltCKbtIpyIPdaV6d29Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXc0xzV9M9kmvigm7XBrg0cc1nwewSke8DSuDNxpPEE=;
 b=UxWPxsAhQcKcsAZRJ1T0JLlih5YEKs2O/3/XZswWTFIU+wCBsMkOGQOTltaPqQwu+ur48jsr9wuTGL1lL5uR9p69bn9cwabznUEBV9Ol1uCLqEX8pV5wzdC7JyABjMKBkblabo2VJ8zmGnLqi1PhMKXQsXSI6a61eUR6+ntP1HNw/IRZaEo8Xg/L2+RpU82zbPuVjT+LtZq3eG83NXwgnD59W4UO40/pu8KBbpxxdg55JQMtbr1a2bGdJWjFJpqBHgRef7JwAzWaZTt4UUJAY6H6p8KOGlNz2dqvAcCXMRc4w76OY++blGWLvQe3csfMB2iAS8Kzbi2rM7umCLb6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXc0xzV9M9kmvigm7XBrg0cc1nwewSke8DSuDNxpPEE=;
 b=idw+IXics2cQP29WaeAGbqWjzRRFCkKSkMMo9cE9frpw1+Bjiy0A19L3vls/XKBA7g+57KkX7L97oD4I7xfBLrvWA4iu14Rkbh1+xUnC/+ykZb/++pzFTVJJ5ufxDFgezM/MxwczC+IsthLFW+wNxtRIwbLf/GenP/2SLPwRWx8=
Received: from MN2PR18CA0008.namprd18.prod.outlook.com (2603:10b6:208:23c::13)
 by DM4PR12MB6086.namprd12.prod.outlook.com (2603:10b6:8:b2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 18:57:55 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::64) by MN2PR18CA0008.outlook.office365.com
 (2603:10b6:208:23c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Tue,
 9 Sep 2025 18:57:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 18:57:54 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 9 Sep 2025 11:57:53 -0700
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <bp@alien8.de>, <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v3 0/5] Cleanup and add support for AMD Family 1Ah-based SOCs
Date: Tue, 9 Sep 2025 18:53:09 +0000
Message-ID: <20250909185748.1621098-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|DM4PR12MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7698021f-3df6-4d9c-88b4-08ddefd2c893
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5ag4yQ9j7t+bAnROajqUJsWC1jHL5nAQvusYzmBB/CEE2WGLRamd4j0Nlfh?=
 =?us-ascii?Q?aeCID8z/28yE+lNPMPZU7kjQimLfO2t8XBvnw2+V/nXWySsCdiyhJDDic6DS?=
 =?us-ascii?Q?8ZEgpn/tMIo94etC0TGJsIBW9KZ36/NgSl5Wgr02zy/8PQb4PAfuQyDwBe6m?=
 =?us-ascii?Q?Dt7/BtoFEWmks1/YdokO6LCFhzhNDZhAHeL+S6xE0jUOzt7kkeyfl2hizCag?=
 =?us-ascii?Q?AW4vRxxu/HtIaC/1IZdNfturnbwGEpYnNZxK5ukXIeNmvWjuLBASVTN6IeZ2?=
 =?us-ascii?Q?Er8uksgHpn6iJ4KsA4cEF8WCqVC7Qw+/5YGdtDuHwBJlgWqpetbPZsEGwldD?=
 =?us-ascii?Q?5DIoZj8Rlfa+SK9Yj7cYe9Jviji9AORHAOIszJRfvt5h3rrb6InXRB23wPxb?=
 =?us-ascii?Q?lOnjueI6yZR5LBgj8Di3vnx6bhcbh+I2MQogX8zqqzehhSNta+F8hJDeTlN/?=
 =?us-ascii?Q?lrRBHErfOI2kn4YrbSlINlGP0vfEISzIeaBVR8Q5cD3IVswDmJ5WSwDW0NJE?=
 =?us-ascii?Q?Iw+UjLmlhOPNAt2EtZw76jjtFoLxdaCyB1y0lR1pcn5Mvl5BGx647wAFLlXe?=
 =?us-ascii?Q?Te3gjmKO8icvBTelzrTZamajWIoxi9onr5jFY5wt/DVE43ZV8L3t1WR4Z1VN?=
 =?us-ascii?Q?ApzTPXxByieKtehiQyZ9OAKlxZ7kv+6ZYQmF54pJjK40PSq7nwHf2Ux9QuNb?=
 =?us-ascii?Q?ApthNZpdMGaLBuIH9wE7q15XUxa5RmsLg7R06WTGd1Uo/zHKrEKFDWbArbK/?=
 =?us-ascii?Q?4gLHDDK1vE4L6pyCiA/2yPzD3HLZqvQrYTpBcq8EMi4poR2Qz0PtSm/X3M55?=
 =?us-ascii?Q?qGPiistxlEQ1rpIjUYPWKpXqQnRmlIe4xFM71cG1IZhd7R2eQo4ik+Q5cWuM?=
 =?us-ascii?Q?HxsELgH36ifYtJv21nTflLYA2MvTp7/sfhHUfBqOJ394AJnKe6TyE2DRJDBP?=
 =?us-ascii?Q?jVZNEeFZ3WAztWuF+vFkhKnL6bWAQAVD7Hh6Vrq7VPx4cbJT2WsS8fbNygqj?=
 =?us-ascii?Q?WF11fw6eO9sJc0sHINDrHCAW4/tfjzw8QIipRhEhy98uIHlUYNTVeV5dSok/?=
 =?us-ascii?Q?R1o5ejlKwMdMmMYhw7ARFab150oan52Fo8+AwRVLT+6dPQIcHORpjYnHgfuj?=
 =?us-ascii?Q?o7XhxwWN7WL1DTJzqQ4KJEm8ZdEFV40fRS3TQ/9MVfzw2dWJ990s9EzzOaR+?=
 =?us-ascii?Q?TiAOZ+aI+RF2EmX0rzny9lYoOqfsq2cW1N+7JV3ESxWwGovbQLooiYx5WJdx?=
 =?us-ascii?Q?M/aFghpyQl+hAlBGkJhhq0tT7KQJLe96TIpsALOLYRFIghAg6QcTRNN2bsFF?=
 =?us-ascii?Q?hQN/SqG7owD8RXKeMZqk4RxW0BKdUDlJG6+91oKeQg3pJLNv5ufl6hKGj4FZ?=
 =?us-ascii?Q?JoaqzRhfyTkL+7khOf3jLqS/hD4NovlqO5zmpxbekWAxpTI+GNWeXJo/cpVg?=
 =?us-ascii?Q?i2Y17601RyRjomD+luhOiIDQv61Ns9j5ff6BV+PVlneC6TZhigLvQqolA0GT?=
 =?us-ascii?Q?Pgo8SN5+LW/dpzI8Zt6fcWVUTUhwvsvVnX1XSHkW9fsVXNvlKsaFw83jbw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:57:54.3332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7698021f-3df6-4d9c-88b4-08ddefd2c893
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6086

This patchset undertakes some cleanups in the amd64_edac module and adds
support for newer AMD's Family 1Ah-based SOCs.

The first patch removes explicit assignment of the ctl_name string and
instead generates it at runtime using scnprintf.

The second patch removes the NUM_CONTROLLERS macro and instead uses the
max_mcs variable to determine the size of chipselect array.

The third patch adds support for new AMD's Family 1Ah-based SOCs.

The fourth patch modifies the legacy EDAC sysfs interface so that the 16
UMCs supported by some of these new SOCs are appropriately visible through
the interface.

The fifth patch initiates deprecation of the legacy EDAC sysfs interface.

Changes in v2:
 - Remove extra tabs.
 - Update the legacy EDAC sysfs interface.

Changes in v3:
 - Remove explicit assignment of the ctl_name string and instead generate
the string at runtime.
 - Remove the NUM_CONTROLLERS macro.
 - Initiate deprecation of legacy EDAC sysfs interface.

Links:

v1: https://lore.kernel.org/all/20250722192855.3108575-1-avadhut.naik@amd.com/

v2: https://lore.kernel.org/all/20250807201843.4045761-1-avadhut.naik@amd.com/

Avadhut Naik (5):
  EDAC/amd64: Generate ctl_name string at runtime
  EDAC/amd64: Remove NUM_CONTROLLERS macro
  EDAC/amd64: Add support for AMD family 1Ah-based newer models
  EDAC/mc_sysfs: Increase legacy channel support to 16
  EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC interface

 drivers/edac/Kconfig         |  2 +-
 drivers/edac/amd64_edac.c    | 73 +++++++++++++++---------------------
 drivers/edac/amd64_edac.h    |  9 +++--
 drivers/edac/edac_mc_sysfs.c | 38 +++++++++++++++++++
 4 files changed, 75 insertions(+), 47 deletions(-)


base-commit: 501973598d05fdb1d1089fbf3cf40b605b836e16
-- 
2.43.0



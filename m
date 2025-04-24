Return-Path: <linux-edac+bounces-3700-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF3FA9AECD
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 15:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EB4442F9D
	for <lists+linux-edac@lfdr.de>; Thu, 24 Apr 2025 13:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B792F27BF61;
	Thu, 24 Apr 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="udc58ogg"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF41D14B06C;
	Thu, 24 Apr 2025 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500891; cv=fail; b=ScquKcO1r6DY438kSWNxyxRR5xfsdBi+mbcesTIMzs7FOb4pgAltco1OPoh+oCnRw8TkYyNf6nWar5jczVHLgHwhvRffYSfM6mhIfkjrNt+wHvFtRA5HOWGGY0brnlzV91IgfeCb5A+l/aVpOtdiu+Hbj4qQAAILsaDiFUI0OAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500891; c=relaxed/simple;
	bh=65iszVhjlDhXObcb8q5qKiNTo1GwC8zHggiEOH/bqWQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=efPl7VoNlCeSL8tamLnk87BAJEJOXEiK/XG15+EctV3FnXMR8MSO8yr+O7bePmdb2emx68zB9nOJdkyYv8FRt0phqyVnWmrETJygWky+Dyo+MtOhYnFlTRpCeaZ+frEECxffmYIsNeo4Gyij/r59GVi8amaWE0z8KxQmCHjUuuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=udc58ogg; arc=fail smtp.client-ip=40.107.96.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eugwn1xZqdzm2LTIBC3kLS+OzZ3r3KrIz2uYXNfyid6nr4bAx1w1oOoXzE3k/0aQoY4kpSRXGRznfQI3eVdvBYpN8isICDvWYhOX/ByCtqon/tdz0814C9BqvwD9TPb9UilBFHKtgQ2ar0QlNnEFxPd6cQ+nXpQo+EhGMVLCBNVoZKqX/TIci81MvearZW1twbisZnGx213x855xJzpiHQlmBW2llzpqvj0BcssbQfbUH0L5iJDCl7dHRmUoAsShyvrZPRIHNJytv2bU27lW/g8M2G6k7Inq8GK08AxR0J+fPnlhnNu3pmx06tcokh5qWTt275vDqKyQ5TfafH/NLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Maip3IdmA/Pes2JdgPEU6J0RTzsYpvu5UEMf0mV9scU=;
 b=l9XstZEdbq1boGb6RMnVstXtgGWHhXY4VZ8h64jUnhQJeKZRg7r2L30YPiR8vr9qbdtaTFrfkAaSITH/C7e//xUaE9rY+Tball05wKvGToF1wIjfqgOpqayopgD3/quz2YsyLbdCNVGr1casHZW30wc9CVnNnJMNbWghznndnEeVyVALdDPglAPqe/Swar2n1NB/Z6kUfoqALEdtzWnxWrlWzq0pYwfHj1Zz9ZwNJHElgx5VDdDb6Cf2fn/fW6mnniixUR7/KjhXcWwSpd8CK0H3IkKQfV9GyxYQK8N++HQS1T1A6t4IUBcDIkWQ79SAHBsNcb0RzBmvgwjcW6OQdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Maip3IdmA/Pes2JdgPEU6J0RTzsYpvu5UEMf0mV9scU=;
 b=udc58oggc2daFnn5e22LRQIo9+cHDN5gJZzDCskS5FoqFRRKoclo6gYepTiWI5hS06HL3pHTNC07E5Y+rSOHqZjXdu36nQPbNoVdXVh7mb4ZIbk8wH7rvLZOm62ymt2On3E2Q0BphyeOM5I/AxBinyIHsPlAS53OfiJBmN+X1w4=
Received: from BN0PR02CA0049.namprd02.prod.outlook.com (2603:10b6:408:e5::24)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 13:21:25 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:e5:cafe::4f) by BN0PR02CA0049.outlook.office365.com
 (2603:10b6:408:e5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Thu,
 24 Apr 2025 13:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 24 Apr 2025 13:21:24 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:24 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Apr
 2025 08:21:22 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 24 Apr 2025 08:21:19 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v6 0/6] EDAC/Versal NET: Add support for error notification
Date: Thu, 24 Apr 2025 18:51:12 +0530
Message-ID: <20250424132118.17074-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d4f294-c8a6-4d2f-1b9c-08dd8332e97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7JkJPhNdMJBeMfyPqs57tS5rAHa30poaYIlmxZY/Jej7II1H8dIhWptJFw/?=
 =?us-ascii?Q?oTfuBMxHWDF4+JmoWZDBZNtsxLuciyglMkn6BG5+FptPlJhXhqlzMq9RW+2s?=
 =?us-ascii?Q?JCk77EcGQS4kQMwlGBP8ASqIi0KvVZUr5Te12Ir+gURpm7IPI2zC6jnNkfSV?=
 =?us-ascii?Q?ZScZQw9OyHM6pN48yM2kESPpBmln64vCZf1rhoc6tFCgBql0zmOBRvfkSzFa?=
 =?us-ascii?Q?2tO5PYrvdayrS0g8N90mvaSpQ3Ig6AUy7ZJYy7Ciz8EOJLyNN6sw99a8/8vQ?=
 =?us-ascii?Q?691uprWJFFYjI0UUg0/z5F0kH4VD2/YykIrpmwrv612JB4lf5A7BxW5iJ/Be?=
 =?us-ascii?Q?cF1TnAWqgVG1x0EnyM4XhldVwwNz4OcWa9v/KQkOTkc7IweD7tsrl1gH6tJH?=
 =?us-ascii?Q?SBMH6+2mre1nVMhfJBRsB+ZQVp+D9UMTGhSbTE8xVnBMceboL5dqRhSy33Oi?=
 =?us-ascii?Q?8DkiUjg+O0w1FMw9S9Z3SU8qnT2E9ArdA+fD7J5NLyG7cUV0sJs/JLrJMT3Z?=
 =?us-ascii?Q?ZivVLatBfmTFgyCUOoMeqIGeA3HDCQAm/HYX4Az2UHaMiu7LijlEJ6d4xbHm?=
 =?us-ascii?Q?4krN1rOEcqmRs5xtIS+efItiOO606E4HU2nOmrBDax/URr5ktVD8Z0ljPP4C?=
 =?us-ascii?Q?OGGgMD2ZPViAp6CuQgvm6N+M3HKe07I6rrb1EyUO/fo7KnkLalHw2leCT6K8?=
 =?us-ascii?Q?i4QXMqxmIMguk4xYyXXBNUnuAJZijvDxlYZ/Sm2lGFMCMkHX+rSc5Knt4KIP?=
 =?us-ascii?Q?jTaeEd5EoSOnHO8bTaJPLB7dWOTijvuVa2hizoGjtmb9mvao0GBhlhun9nWU?=
 =?us-ascii?Q?bjSp+7jEAcgQibfD8khZFYmtmMpAHu+Hpq2U9ID2a6WTzvL9lfyAGsWTUj9+?=
 =?us-ascii?Q?/eJ/ZA8kqfXSZyLONTzh0zAXM2gE6a/2mLyHHnQG7s/3E02cjAM5LVueaB6y?=
 =?us-ascii?Q?jhOznSO4cg0y2Pz66qX3njkjixddPsI4h193op8YGiPCaE4fQLIOTILctwy9?=
 =?us-ascii?Q?0mLgQ9lRFxp75zA5Z+ed308qCk76K8b2hLi3sMBq8udl6cboqb8iq+yyhNiY?=
 =?us-ascii?Q?WK9fNa1CtVrTSY/9VbylEmTjmuq6fhBnWWI2M2iDVSkx49rdjlMaofvAImtE?=
 =?us-ascii?Q?2qxCxXFSdD44iEcFSowbZbuDsQr3fBkxUpXObnAyl3NwWuTjGpKvCa/1bCQD?=
 =?us-ascii?Q?eGQPOqAMsxdpEnWOq0Tf3O+pfxtlHfJqoLPzubo6GewLe9SxmCXUBPmz1ZE7?=
 =?us-ascii?Q?8bvzsqZHKpcWNG86TxVGm+Zq+vynUv8XqwHzvKxf4H2+T+bUztqOlCJKzneB?=
 =?us-ascii?Q?ufMxuef8I49WQMjB0kvGx2sgQfS7L20dgK/c8SZJE+CevVr6IZVBIUvMOYTt?=
 =?us-ascii?Q?Rp24l1o99dVkzLKMmHMki98aBEgwAHaMswtGga58L5SOrukHpT7ZfMQs9Fuc?=
 =?us-ascii?Q?uzQz378NQhGbLPrujBBDUALNpJKVORQcChPMIMhX9dbBB/3NtMKgsK9ptOE4?=
 =?us-ascii?Q?ZOG2gZPsWQknDrwm0QD8B2l2Evo9ZSpDSOmi?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 13:21:24.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d4f294-c8a6-4d2f-1b9c-08dd8332e97f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872

Adds support for the error notification for the Versal NET EDAC driver.
The driver receives error events via RPMsg instead of directly accessing
hardware registers. The NMC((Network management controller), which has
secure access to DDRMC registers, gathers the necessary information and
transmits it through RPMsg.

During probe, the driver registers with RPMsg and retrieves DDR
configuration by scheduling a work item from the NMC.
Once this is completed, it registers the EDAC controller.
When an error occurs, the NMC sends an RPMsg, notifying the driver.
The EDAC driver handles error reporting for all events.
Also we register the EDAC once and it reports the errors for all the
events including the 8 DDRMC controllers. So while registering we give
the particulars of the 1st controller.

Currently 20 errors has been tested.


Changes in v6:
 - Patch added
cdx is compile tested.
 - Updated commit message
- Update commit description
- Update the commit message.
- update to the chip name as xlnx,versal-net
- Correct indentation
- Update to xlnx,versal-net-ddrmc5
- Update the kconfig message
- Make the messages uniform
- Add some more supported events
- rename regval to reglo
- combine/ reformat functions
- remove trailing comments
- Remove unneeded comments
- make the amd_mcdi function void
- rename versalnet_rpmsg_edac to versalnet_edac
- Remove the column bit and use them directly
- Update the comments
- Update the mod_name to versalnet_edac
- remove the global priv col and rows
- rename edac_priv to mc_priv
- Update the comment description for dwidth
- Remove error_id enum
- rename the variable par to parity
- make get_ddr_config void
- Fix memory leak of the mcdi structure
- Update the spelling
- Remove the workqueue

Changes in v5:
- Update the binding
- Update the compatible
- Update the handle_error documentation

Changes in v4:
- Update the compatible
- align the example
- Enhance the description for rproc
- Update the compatible

Changes in v3:
- make remove void

Changes in v2:
- Export the symbols for module compilation
- New patch addition
- rename EDAC to memory controller
- update the compatible name
- Add remote proc handle
- Read the data width from the registers
- Remove the dwidth, rank and channel number the same is
read from the RpMsg.
- remove reset
- Add the remote proc requests
- remove probe_once
- reorder the rpmsg registration
- the data width , rank and number of channel is read from message.

Shubhrajyoti Datta (6):
  cdx: add the cdx headers to include/linux
  cdx: Add DDRMC Commands for DDR Configuration Retrieval
  cdx: Export Symbols for MCDI RPC and Initialization
  ras: Export log_non_standard_event for External Usage
  dt-bindings: memory-controllers: Add support for Versal NET EDAC
  EDAC/VersalNET: Add support for error notification

 .../xlnx,versal-net-ddrmc5.yaml               |   41 +
 drivers/cdx/controller/cdx_controller.c       |    1 -
 drivers/cdx/controller/cdx_rpmsg.c            |    1 -
 drivers/cdx/controller/mcdi.c                 |    7 +-
 drivers/cdx/controller/mcdi_functions.c       |    1 -
 drivers/cdx/controller/mcdi_functions.h       |    2 +-
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_edac.c                 | 1108 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 .../bitfield.h => include/linux/mc_bitfield.h |    0
 .../linux}/mc_cdx_pcol.h                      |   16 +
 .../cdx/controller => include/linux}/mcdi.h   |    4 +-
 13 files changed, 1185 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
 create mode 100644 drivers/edac/versalnet_edac.c
 rename drivers/cdx/controller/bitfield.h => include/linux/mc_bitfield.h (100%)
 rename {drivers/cdx/controller => include/linux}/mc_cdx_pcol.h (97%)
 rename {drivers/cdx/controller => include/linux}/mcdi.h (99%)

-- 
2.17.1



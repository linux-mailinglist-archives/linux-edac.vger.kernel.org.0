Return-Path: <linux-edac+bounces-4032-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 824EEAC794F
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 09:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44D055012F0
	for <lists+linux-edac@lfdr.de>; Thu, 29 May 2025 07:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B7C24A076;
	Thu, 29 May 2025 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhZmnpwD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888637483;
	Thu, 29 May 2025 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748502030; cv=fail; b=Ef8jK9JF1WHSKRjJIeH2qWijQIpc6+7TggHjq8VSC26Uc5RabImboJYTdWsXoWmhfTk2AyUNnArfNtdCXg6vXp//LvlKLNu6XkYuSdriSLd6e5o+UHIusZ4OGw/FSORVtlvXfP4fZFL2vMCkA+1teZ4XtKOUWOQDJ+QclQN9GLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748502030; c=relaxed/simple;
	bh=TDy/xdreTJcGQvYqySD+kTOz7ZRy5jzrTWlSJPuuVX0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aKiEdgn+2UZboY504q8zPmKN4pJA08RzCW43IsAQwVzQQqI9bOF+tVzjKrLiUbtPwBTGgYMY1yDsfvPLKNS1YJQGxb0OlF6JWyizgouf13GP+XKtnXWKLhenmkGMdSbF9zm1Sp2+QnnFmxvzffXlOWNnZ9aBB3sUa9q8qn+TDWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhZmnpwD; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLCYLRlYqAtaxwJ+uk3S58P+1BagPezhimGjZ5JH5s7btbQEt4Bjwz1OERq/1HN6Fpdw/6yh2QxKNAv8HZDFcDfs8/z9d/rQYBklPzhXlnvd6zl6lhqyl8mHDOIDaRfmKzhjk0Xj/ZYi9dhTeAj1iddhFnUfrxzVPHlo8mf858x2GmNnGewaDSDx2UoIaUre9EC/YuJaDdtuQk1khKBNovGvk9/Fcxrv/JVgTzj7Z51b7cCzynqJWDjE5JYbDyDUryCAlkptbB6Xj0+ct6pGtyQsSZYg2kBYeyPGRAoQ0DC+IUkTJywXlJz/Zc7iMlLU2SEeGxM9TGInch6DtN2MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGWoY1AKoR+a6c3HLYm+0k66yDHo5qz/CmMyRlSj1pA=;
 b=Pw4l9nLIdghkKQgrzh9UAgOfzq0uB1Y0jWBNC6fouuf/JoaTR9tDl483hP3TNavRq6m5p4ffBHIUGgLruJoW6yq1Y3c0leVDDOFGY03GeHIRgesMAH7pmUf2ZlVpnBdKsdedQppiOgvUiGlfQsYY+3hOG6YaEc8XkvKKj+qBEXgHMrWEHFfalDji5vZesLq8WMmE/OYIHGoZrNyCIBynpFlaH5DTYeA/wDhKSxNmadLS08Hvb3rJr5M6fsA/yZzujzCu6wbqL/20dGvFqVU1gY5XB6nI4LC5AlgVreOYVs4GEtcZ7vegyPYA6Tl4/4ihfLJ7X4hl5vU5+vs0BtYQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGWoY1AKoR+a6c3HLYm+0k66yDHo5qz/CmMyRlSj1pA=;
 b=vhZmnpwDK3QZBmM1vj+l3YYI+7Mx3D+Bw1ae4ggJ1RE38Uu47JAD/Ya5GEat3UzAhVM/TUqRg2L6m9Uu8eyE71tN4TB+woKELd9pA/gGLzKN+iITa2E4cn21eXecS2p3o2iMyO3m2DTXSzKHo2Vqb+Y4LKHKpi9sVTSQmRS1gFI=
Received: from BL1P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::31)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Thu, 29 May
 2025 07:00:24 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::54) by BL1P221CA0024.outlook.office365.com
 (2603:10b6:208:2c5::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Thu,
 29 May 2025 07:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Thu, 29 May 2025 07:00:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 02:00:21 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 29 May 2025 02:00:18 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>, Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: [PATCH v7 0/5] EDAC/Versal NET: Add support for error notification
Date: Thu, 29 May 2025 12:30:12 +0530
Message-ID: <20250529070017.7288-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: db972e6d-7935-4e6c-2737-08dd9e7e7bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tldoMvw85W+7Azm61JAUF2vbAhrgP2Za6wJjz29jUd5EIP18L/Z8A1R9eBTH?=
 =?us-ascii?Q?JcYpStYFkYFprO1NOG0X3Do0kE0jc2PdIA2uM8N2UhdTF+IfEefRu3JkTa2K?=
 =?us-ascii?Q?tkQzeQ//jUUrw4+pKKSWDv6TFptoGKxu4vAQgwdpyonZCsJAGlU3uFEs6H0L?=
 =?us-ascii?Q?5EsSRdioVc/0gvwzX6BxaB95dzdZDGGg8VR7XiDW3rERM/QbbbG+xGz3p4EK?=
 =?us-ascii?Q?sLEGZgMbDomgsN5A5BLnftJMi4lsx0ZONL7x+VNDewhtVKdu7MhgxOKu0bSH?=
 =?us-ascii?Q?iDhn/+oya8AyBxIsn4MXk6aW9BXVlZL1GVqNDOB/fB0vmtS04bkHTSqNPJLr?=
 =?us-ascii?Q?zM4d21pNDGr69vIIHlJixTMgObZwIPdYkKrGcxdEgW4KrVc/nTAbO93z+lz3?=
 =?us-ascii?Q?08Eb2jGlsP2GPOgJ/UetEwCYLWSOgh2+onxcZXX+M7+TnkwmJHk2QPTzKCfI?=
 =?us-ascii?Q?XE90Wq6SpB0pLjRtdRAJ9GlWkXSGi1hyrlho66Rx3guzUpcfp2r3yHdggPRk?=
 =?us-ascii?Q?twAmVcl7qYb+fa8ba2lcujjpi96YEEzaoIs0vg0fSiiwkfVbkLvywKD1SYps?=
 =?us-ascii?Q?aJcQV/sKRUtN7WnZ6NlRUiB91RDL2csaWZJRKIYNOgckZf+L0Hc1sPk0U0eo?=
 =?us-ascii?Q?w1hBgXCp95IeID70/Qu3bTLWfwmzKDoAe0/USNWxDe+vRm+s+PHB/D3dqROY?=
 =?us-ascii?Q?wpFcgmDitHT+/YePIqtxRb8Id5IRt4GZhu6iHVk/36hzDWcUMjZSGEkSHNx7?=
 =?us-ascii?Q?Eazd8fyB+7kX570pMY9qyaq5/RDB6zVxEvzMj6NWYxFzc4G10P0DkibAwBS3?=
 =?us-ascii?Q?+/XHFxEV1H37YKYk90cfUSQs2qCrxQyi0Fq9OrD7AL4+2SySJBG7XHd+2oV1?=
 =?us-ascii?Q?1uAjlEe8T/NhkMz0c4WtjUA2l5fqb+6jI9VMnQVTOo1bhJ52gCJOcKafsrix?=
 =?us-ascii?Q?tjUxYZln1x5v+REvMGNeMg/e8VyUdBxCGfavM2e6EdBNZylcYKgSPzy2Bs9v?=
 =?us-ascii?Q?bBruZ9Knf/BaOdjYZQEH/G0I5KHYuG78tZ82v/lXHxIEzUEEHXkv5iC8jlW1?=
 =?us-ascii?Q?GF2TgYzR9MfB43klL7lBchrbBxPWP0WoUOwz3XN0iwKKQPqabYKu17pLJJXE?=
 =?us-ascii?Q?2lp8p54HzjbL1nz4o5wvD2u7mmuZIgPD0WTDeAMk1TPlXqfOtj/bwu0XJeNc?=
 =?us-ascii?Q?NaMqWqCcsB3g25yrBvqzdnhdZkkhA5GUYNXKfJjtoYI/aLZlYyx6SMJj8bIE?=
 =?us-ascii?Q?jtJD+HfxAZC9wF6jvhfFcZuPOoAVqGN65KY86jUEr6RDJdVmTMwesfa2l6/K?=
 =?us-ascii?Q?tHcKzwqX/1lblhDYDnwMtBWRXUCVvKqz9UW5XhpqGu8offrzmve6Xf8WPtAK?=
 =?us-ascii?Q?A9qPf2/0+zD6JNhe2tXDoBbDXcySWp799Ek0TM6adXf+CIrhIacz1KFVI4Uk?=
 =?us-ascii?Q?NmTTkBUMvegbNA5DU0qoehNuWBFZDD6sSuHryqbGXa8STJGCCUmc2dXYV61e?=
 =?us-ascii?Q?FxaW0RmgqgIq+Ox1zmlGJ+pn+BTOPZTPhy9W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 07:00:23.7287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db972e6d-7935-4e6c-2737-08dd9e7e7bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437

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


Changes in v7:
- add a minimal header instead moving them
- Add the kernel doc description
- Add the prototype from first patch to export patch
- Add the reviewed by tag
- Update the header paths
- merge edac_cdx_pcol.h

Changes in v6:
 - Patch added
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

Shubhrajyoti Datta (5):
  cdx: add the headers to include/linux
  cdx: Export Symbols for MCDI RPC and Initialization
  ras: Export log_non_standard_event for External Usage
  dt-bindings: memory-controllers: Add support for Versal NET EDAC
  EDAC/VersalNET: Add support for error notification

 .../xlnx,versal-net-ddrmc5.yaml               |   41 +
 drivers/cdx/controller/mcdi.c                 |   29 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_edac.c                 | 1108 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 include/linux/cdx/bitfield.h                  |   78 ++
 include/linux/cdx/edac_cdx_pcol.h             |   28 +
 include/linux/cdx/mcdi.h                      |  198 +++
 9 files changed, 1495 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
 create mode 100644 drivers/edac/versalnet_edac.c
 create mode 100644 include/linux/cdx/bitfield.h
 create mode 100644 include/linux/cdx/edac_cdx_pcol.h
 create mode 100644 include/linux/cdx/mcdi.h

-- 
2.34.1



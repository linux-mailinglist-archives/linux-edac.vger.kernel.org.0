Return-Path: <linux-edac+bounces-4682-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A157AB35352
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 07:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85E434E3C78
	for <lists+linux-edac@lfdr.de>; Tue, 26 Aug 2025 05:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23D92EE619;
	Tue, 26 Aug 2025 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qy4dai7v"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC12EDD41;
	Tue, 26 Aug 2025 05:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756186166; cv=fail; b=YM8XPAmOUU8cj0WCQZ8Jx2JjdVKs1zwOmyEQCzKYks+BnWIRcOhhFWBCFXiLMW+0USsRMo6vHaUWQXH/7EjvMLaFhH24JlZph4txgipWohtH9WynZ/C2TEuuYDztu9MQq06+kWJBBodIMUSQw7MVoTFvvRBSW7DjQb6oNSehhH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756186166; c=relaxed/simple;
	bh=K/LEs6YEgR5rIusa9bO+Y33b3i4ZbvgMQiTulp8+zag=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e3TmpTjDX7VlH7+KItMNewtk157UhXYRPf6HaCscqihFoGAsJKxEYnm0fX7sjjitssbi9j5qfVO1zUK99vtN3PGxUQUhtw4Llld5/U9HfOHJ6/zsu9ZTKLYVN5dlAg2ErZXyyBFTj1nfHC0yYjRulXwC9z+LnuR/N1FxzhppICo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qy4dai7v; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4poUr/ySQQz5ZoY5DkyhJPIImGfHk9BT4b1QTx0ur3sidfQU9i4PrgO4Vz0m+Ox2Vws9DXUJ6bUOQ/AnlXhSadzo1sLOM9/P0O1eaSDqu42P1IVeaj+8wYN1VTgQC5KL1bt9Ux7fRaJpcVwq7lp1g0X3NRrHiX9pKGEHA9EqXQyHRdlXUoaG0AMir+76LUmrgrE5rS6wtrKASpydVJSms3wVv9+B1q7gZfsNLMwHWDbnt64qjmPElQgGDLuMYgWc88mOuuMS0HG5nuY3O1g3YGTs7XenJzFKW/VDYTaJAEFzJ8kTaa4ZE0MbvtNSm4y8LqVkLFHprP9YduhvhA46w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnXA4yLkBh1rt1pI+laF2fio5nBjATe/BM93174oCQY=;
 b=robP+Ij54kdwJb7ZvyKWu+vUZJ5uIV/QQJKXGHIltf8iQl9blnyEgrzWJtiPf5OavhlSpBwjeY1fYGkQo5O9LAPD+baAVkp9N8sevgEdmEBADTSsPvoAMwCGtz1mC3fRXqekWZiefOF74Kqo5+pwqHEY9DCrfTWkMt1gn3nRhW9hoSZLOCwTBxHkKYcN0NE82X5ACvx10giIId/hoSnb+u4CgJjre9K/zOyO3gTOv/3CwZg3f64JfVs5lxaHZf25O0F5A1n1AvHuhkX9cl67dZVCkchyJA+OZE9NRkAjvprZIy7tK4LJjxAiFvqCYz4rMy3HQNeMqR6isrwObbMFDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnXA4yLkBh1rt1pI+laF2fio5nBjATe/BM93174oCQY=;
 b=qy4dai7v3jQS44b0jgBztgnyUHNKcya2vVUrAoxsH6BNjXp47VS3CmhLelZvsJAll6LfHISvgxxNBIgs1uUX3DTGSaZDhZPwFpjhHds2sWUR3lkFDfLWo5I0Zzi3Cywxar52fPAR/h1DYItyH2036MCuNRbesXR/sXoh/bkhojk=
Received: from BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6)
 by BN3PR12MB9570.namprd12.prod.outlook.com (2603:10b6:408:2ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 05:29:20 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::13) by BN9PR03CA0931.outlook.office365.com
 (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Tue,
 26 Aug 2025 05:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Tue, 26 Aug 2025 05:29:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Aug
 2025 00:29:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 25 Aug
 2025 22:29:19 -0700
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 26 Aug 2025 00:29:15 -0500
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <ptsm@linux.microsoft.com>, <srivatsa@csail.mit.edu>,
	<shubhrajyoti.datta@gmail.com>, Shubhrajyoti Datta
	<shubhrajyoti.datta@amd.com>, Krzysztof Kozlowski <krzk@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, James Morse
	<james.morse@arm.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, "Robert
 Richter" <rric@kernel.org>, Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal
	<nikhil.agarwal@amd.com>
Subject: [PATCH v8 0/5] EDAC/Versal NET: Add support for error notification
Date: Tue, 26 Aug 2025 10:59:09 +0530
Message-ID: <20250826052914.2066884-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BN3PR12MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6efb69-cb20-4c23-4062-08dde461824d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6tpRLgLDiYPzgja2Af9KqemVA1i3DBVTIIHczSpn+MR3JaWKeMIXuuEQBxqf?=
 =?us-ascii?Q?3XOXEc84H6rqkiOuIAV9IiyDF1mJ0KiWLaFf8dD3FpzOi/ADjY5H0AEo0OUP?=
 =?us-ascii?Q?2d6KnNZUPzjW/B1ljrXwnjZTZFUFriVbVl7vWhgKBOQzYX7n7VunuYqZ9QON?=
 =?us-ascii?Q?9RBJfrdGH/RKBaZ39gcfu7SVcyGEVu+QI97NuMsR0tmd1J7BFS163DReASf5?=
 =?us-ascii?Q?vRe9vQLswzrr6ApK8qT9JXRutNOWvaTkbjdoBNBjlaebtFrYvf8WGpIW92Oq?=
 =?us-ascii?Q?HM13PL89VBC4XCI2rFUgJeRzTECNDEUOBoL3SDh7Fbtnfy6NlTT7N2m08Xcy?=
 =?us-ascii?Q?ixXNh+n2eFRTOETorqiZLZqplkU1wpuk2i7IYYdhgQ3Icb6Hsbc0zNF//rcC?=
 =?us-ascii?Q?07k/gx/pk9DlKGFg5K3HQrQeNagA8zktZA1oTiI39q/rjF23tlFBzOweONfB?=
 =?us-ascii?Q?vfyHzLNw6RqIRegN83NA7m7wvfTMsL+ydkoZZdibHXP8XdXzyB1xT8Js7Ual?=
 =?us-ascii?Q?qA3uZFODn4nULhHi/slz9HEX4BhWGPrhadva45G2uo4nARVS3/0BtbIngGAo?=
 =?us-ascii?Q?Gfxchg+HzKYE1cHSlhZA8C5YUmjznEscuKP8iUW76lUhvxWvNcKDBUFAgLU8?=
 =?us-ascii?Q?KjZRg3JcFJsYGFEkxflmWNY3N/HjX6TQ0cUUYvrMS4NFNPggXiisSWD32SmO?=
 =?us-ascii?Q?T20mbRJz8RSkcbogUlcAzmbuQQK+cQfECVfTRZFBHtYVpKT69uuLG/Ig0xKg?=
 =?us-ascii?Q?OTWWQnTzL/sgtUaYmNUkL9TbS/sUWNvRJDJazNadkV+yDSBLfRAILwng/NxW?=
 =?us-ascii?Q?5HnKSZdDaer3+hJMf8lBzdO3i9WYRss9w6WpSig4h1MVO77eI25B0avRulxa?=
 =?us-ascii?Q?Kfzt74xPoMsZ768T9sqhEUQl0MZYN85qvCTspnZ2krKCk0osOgGD5lgwQsI8?=
 =?us-ascii?Q?PpN0SBq2ehC/nK8zjbDJU11GIrlXO+9c9xRWUIrCQzuVrMRffPS3yTwworub?=
 =?us-ascii?Q?Q5IQmhbA/30KSAsQ8pZDIHnmXqmQOmAdqhgr37tUErg99ZtYsu2ksBfaUErQ?=
 =?us-ascii?Q?+1YzitDigIG6xwH3OzH3huE3rulsjlEhIZF2sofiIpmCswxCYwswhadmKIt4?=
 =?us-ascii?Q?X6xB8N6fZsuYjnDD+YRsr5bJx0K1/KqCBTR+PjJhI5sOlsAw31lV3IBPh9G+?=
 =?us-ascii?Q?a16/AImFo6zALOMot5BZ0AnbWOKOcOkoRiIvochrw+IWQWeQfclB5cm/mvPA?=
 =?us-ascii?Q?R6ShZIxXYBic/irdfRAMi9NdACJ3/I+hNcQ7GZkiznN+XaEuQxz93e7BuA/t?=
 =?us-ascii?Q?Ho4abWlsvEAJIXz6Kwqa1EsJmDXKKe7L/kd80dJJXFWhJI3cIrtS5tgnOb1Y?=
 =?us-ascii?Q?YpZDpKHAVaMldwxiMVmrd6AtC4xspr8VjCQiVGN87UaaNSKBmMRlEKO3kXUn?=
 =?us-ascii?Q?fBRHVVivgngtj3TwE20yNP5ceXrWGObXUBFB9VBxANPCGernTaqG5eyMMeWt?=
 =?us-ascii?Q?r3npWiUDplUvtX0ZK+2MfcmMwhRljARFx3yX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 05:29:20.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6efb69-cb20-4c23-4062-08dde461824d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9570


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


Changes in v8:
- Split `mcdi.h` into `mcdi.h` and `mcdid.h`
- Removed common code from CDX headers
- Used refactored versions from shared location
- Remove "EDAC" from macros and shoterned them
- Removed redundant parentheses
- Improved the description of the @i field in union ecc_error_info
- Improved logging for memory_failure()
- Merged init_csrows() into mc_init():
- Remove AMD-specific naming for static functions
- Add MAINTAINERS file
- Register all the controllers
- Replace  AMD_ERR use the snprintf in a function

Changes in v7:
- add a minimal header instead moving them
- Add the kernel doc description
- Add the prototype from first patch to here
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
 MAINTAINERS                                   |    7 +
 drivers/cdx/controller/cdx_controller.c       |    2 +-
 drivers/cdx/controller/cdx_rpmsg.c            |    2 +-
 drivers/cdx/controller/mcdi.c                 |   34 +-
 drivers/cdx/controller/mcdi_functions.c       |    1 -
 drivers/cdx/controller/mcdi_functions.h       |    3 +-
 drivers/cdx/controller/mcdid.h                |   65 +
 drivers/edac/Kconfig                          |   11 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_edac.c                 | 1077 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 .../linux/cdx}/bitfield.h                     |    0
 include/linux/cdx/edac_cdx_pcol.h             |   28 +
 .../controller => include/linux/cdx}/mcdi.h   |   46 +-
 15 files changed, 1268 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
 create mode 100644 drivers/cdx/controller/mcdid.h
 create mode 100644 drivers/edac/versalnet_edac.c
 rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
 create mode 100644 include/linux/cdx/edac_cdx_pcol.h
 rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (78%)

-- 
2.34.1



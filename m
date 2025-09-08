Return-Path: <linux-edac+bounces-4738-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 635DCB48C9D
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09DA42000D5
	for <lists+linux-edac@lfdr.de>; Mon,  8 Sep 2025 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696132DE71C;
	Mon,  8 Sep 2025 11:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rnDcol9M"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2074.outbound.protection.outlook.com [40.107.212.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0151229B1F;
	Mon,  8 Sep 2025 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332625; cv=fail; b=I9ypbyl5RWf1BnkdU4EMeYUagp4lg2QLN21y2C1FQMdO6v+EkfyJS6NRD4NJln4vxOhJUNmgRY47eYMmkNn8cuTjLYAx9b6VVrPRZ0wjyM8brPRcKHtUlxql1i/bPbJK9ovU3y6l/KwpUsHUXcPsKGXvCg7uBbV4R7JrGZSG+Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332625; c=relaxed/simple;
	bh=D4ca+L/gPc1Ud6L8+2rMf9YF4LXPfBxTHc11O67TQGQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EiFCGHEjcuTPpwQL5xkbY5ibjV90WZlE6Gvk72Xql++o3TOSgkvTOoGl6mq3M/O+s7ZCT4Rw1N0n0ZHqXsaIdmmz/OSXBjK+YVgSdGxCtGXuFicUbu1sRUnA/ZshXnpQ8yqtkQLXD7ZICQhwTpfLLrBiSUqcUNrDYiJe0UO+bjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rnDcol9M; arc=fail smtp.client-ip=40.107.212.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LC6aLSyeoDv234OAJqNKYhRhPHom3xzpFJnnUY/6pBA0QOEq3v3YE/26UpbYEaVCoLwfwaAgMDXW/5MoY3mBt24BWBsim9XYcarsHGDSaC0MiSapV2cen6sPVMCJSy4AOQARcpRnT4gtbYjoEEqxbUrpv8Xob1zYnrp/LQOsnydkFGk/9Akf7PDfwI8FvzxurEYCo0AcoC63GdlQUau8ulZpxrQ8aBsbEMuDD1nab5CuKwqK4eBF+kbkzVVlKc5NuH75ACizXpCcPMLaCbT0dvnBeHPTZL8bcRJWVTBUxsRfBzoMFKP5l4X7WfAq3HYkoNu5cEw1Zwdi+QXxBVrDrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eD31bo7aSPUhKXutYqObfa8c8jkNEFfHBJoHw1zozaI=;
 b=GXq5raPt5rELUhmueOD7SfF7YtxaSrQmnFQwKTwS7pffcCpb3BV52kdpRd9xfUgKyx3WTuL51v39DVCHk20Mf1sFsn72MSvcUbmP/q6HhmctfSwOC7ViVluOARVewmxubQHLxdBbJwlUVKuGr8isxZQQ4h9sBD8Ng9Hyx+wP0Ewy9s761e7/nLi6VhZ8bZBWQrDvS0+RizGdxqqI5dONzpJVTirBoVAP/MC/k+nswddxW1tl1lxOaEoUw5wVOn7vs7JW7YPP2bI0zLiRZ/A1rMDukelivzgFsuvL291mOB519VFEfI+zuTETaAWW98Dj4DIFXDSd6O0tdZS9DlQUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eD31bo7aSPUhKXutYqObfa8c8jkNEFfHBJoHw1zozaI=;
 b=rnDcol9MaLKtBLOZ2ybRSLf1TxdrhmHPmGEGiN5wlbakxsMxYaRnnp1GtAi4DplgnLuVHbQUnjkjUzZgFfmnWvAeKylrE5+mRvj7I09RVPqJMmCH/eXPXxrohCe1sL3eVMHbgj14WYihH3C54Xvbq/j7l/hPqK8Cwh/vk1t7aQA=
Received: from CH5P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::27)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:56:58 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::6a) by CH5P221CA0002.outlook.office365.com
 (2603:10b6:610:1f2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:56:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 8 Sep
 2025 04:56:57 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Sep
 2025 06:56:56 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 8 Sep 2025 04:56:50 -0700
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
Subject: [PATCH v9 0/5] EDAC/Versal NET: Add support for error notification
Date: Mon, 8 Sep 2025 17:26:44 +0530
Message-ID: <20250908115649.22903-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4c7b89-253f-430f-0960-08ddeeced078
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BHxc54s4hCONv+trymotnMeLjf9NhKkwYG9UzNtcj8Vrsf1U97f6kGA9D9mR?=
 =?us-ascii?Q?l5Awpp8+5tqEJ/FZ9QnQt0DeQyaT/eTQV3V2VsUuZfzbW0f5/FzQfuZFViMu?=
 =?us-ascii?Q?qpNL/i60qJ2Rl4n5AencgpUP6mGg4+scIPHYzKsxVKD4PfhOniBlf74GaZIF?=
 =?us-ascii?Q?VAfkcd/cEYphGlTWlixBxENeAWNeoa8tZ+wchr174o90Oj4Hl3ox4qzEn0OL?=
 =?us-ascii?Q?WQz7ko4kvisGs3BSdNYgHIcx+MyLojRV58YvuP7JCrqANWxqOvdAn8g4r/C/?=
 =?us-ascii?Q?fizFoAI+PRpVOLQwhEs6tWirx05H8zBT35j0wxjnydS2+hbIJR2HXUtPB6D/?=
 =?us-ascii?Q?mh864JXVyEbE3LHGDQUcxpmoRrRJF2tBTk7vQCgHBhsBTLO8bwu1giXRGEP6?=
 =?us-ascii?Q?Wp/IBkxySqCwo0lmYAV95dopcfsbyj6cTBw/8Gh25FEm23qnjw+QlVLGSOhB?=
 =?us-ascii?Q?f6RiBIuFJkFL9teLFmsPOvgq/M/88KH2GI8sIxfyY/uVTP1p95758LLUMSU3?=
 =?us-ascii?Q?/FFKWMDAvnbpiSuoozWGTQSpJJ3YIr7y66iu1wZdUtVQF+gFxilcEoZ9NEap?=
 =?us-ascii?Q?d7zcGP3pEMQMLdEzYo1CnWmejdFXS4qbDjvGgAOFTB+GvB95DZx0n2RyHWj+?=
 =?us-ascii?Q?MGwlrqlIz+Cz8M6WM/p4dKIjzJGXdtOsAHVsNCCzVV2jGnWRsuGmDdmkTUBU?=
 =?us-ascii?Q?t+qugLLyh/TaEIKTe17fj2QkRUS/G0auna3LZ62i2ymjwWUgDHZDqNOfMhI+?=
 =?us-ascii?Q?RaFtczxFOJ6kwJQ7ApixlumCPnsIrl0jGBPzitwyCkG/AlovYC4WwXiswbhW?=
 =?us-ascii?Q?9MoPFlhuQbR+aIJ9vmnfX1KTtZgDw7q7IDBpg3qZ6PWDgzTmLAZJQ/uJ6NgS?=
 =?us-ascii?Q?bsT9DOY0HPYRZbh3wwlVhL3cs1nxpQuHyyG9qt+r8mM/2qUn0eWT+ZV4F54t?=
 =?us-ascii?Q?1lDrixi+sQfWK+Ed0eFdBF0/6fSWyPAyuUD735Qi3DQ0oOqcZmwbuD/2XP6A?=
 =?us-ascii?Q?o5PPVSwUX28c3L/9yS7vJ+mHhZSBTBwaATCOcbb13c9gwpDm+ERKDdGNL991?=
 =?us-ascii?Q?x9Xw9/kygvtU782fqy3IE9vmZZNx4CPLR2k+v78gHhAXO5sJpMnTOtI3NXU0?=
 =?us-ascii?Q?EK90O5iPECpoIDbqYnzoOnTUrtrlLmTnWh6ZIdgMbS65gLNqFn4SJkt48vMa?=
 =?us-ascii?Q?E5IXN9HYepjhDsXw40CVfQGEh/d/qWeANYkV1baXZPUZJjvqp45Nf3x3pJNT?=
 =?us-ascii?Q?Pz3TM4uRwnk1TzKSqBBE1kRJX6YmS2YA8lC3xrbsP0maHpZHZ4VMe/QZT0BL?=
 =?us-ascii?Q?TsaCMMSEnmOBkyDVbsda0fSmVx4R0f+SViIEAT2dyutqnpljEcYaBkL0UUf7?=
 =?us-ascii?Q?5TSxz+IDRvoAmi2wfD1cbsvmcNhZQnWNx3mchvNrDDuhhxqJ84Z+q9tbxR3v?=
 =?us-ascii?Q?TLcIfJsatJ5y0oDm/RAxqOTvoSko2J4DsU2FCtrDpbTIrPOO25TzhgC4oAOT?=
 =?us-ascii?Q?CYPluEHNseZC5cknHEhylodXBSV9of9bJNpZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:56:58.3866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4c7b89-253f-430f-0960-08ddeeced078
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187


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


Changes in v9:
- Add tabs
- Replace "This function allocates" to Allocate
similarly s/This function handles/Handle/
- Export cdx_mcdi_finish
Change the export log_non_standard_event wording
- Fixup title
- Rewrite commit message
- Fixup Kconfig text
- Zap unused defines and align them
- Simplify rpmsg_cb() considerably
- Drop silly double-brackets in conditionals
- Use proper void * type in mcdi_request()
- Do not clear chinfo in rpmsg_probe() unnecessarily
- Fix indentation
- Do a proper err unwind path in init_versalnet()
- Redo the error unwind path in mc_probe() properly
- Fix the ordering in mc_remove()
- call cdx_mcdi_finish

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
  cdx: Split mcdi.h and reorganize headers
  cdx: Export Symbols for MCDI RPC and Initialization
  ras: Export log_non_standard_event for External Usage
  dt-bindings: memory-controllers: Add support for Versal NET EDAC
  EDAC: Add a driver for the AMD Versal NET DDR controller

 .../xlnx,versal-net-ddrmc5.yaml               |  41 +
 MAINTAINERS                                   |   7 +
 drivers/cdx/controller/cdx_controller.c       |   2 +-
 drivers/cdx/controller/cdx_rpmsg.c            |   2 +-
 drivers/cdx/controller/mcdi.c                 |  43 +-
 drivers/cdx/controller/mcdi_functions.c       |   1 -
 drivers/cdx/controller/mcdi_functions.h       |   3 +-
 drivers/cdx/controller/mcdid.h                |  63 ++
 drivers/edac/Kconfig                          |   8 +
 drivers/edac/Makefile                         |   1 +
 drivers/edac/versalnet_edac.c                 | 958 ++++++++++++++++++
 drivers/ras/ras.c                             |   1 +
 .../linux/cdx}/bitfield.h                     |   0
 include/linux/cdx/edac_cdx_pcol.h             |  28 +
 .../controller => include/linux/cdx}/mcdi.h   |  47 +-
 15 files changed, 1154 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-net-ddrmc5.yaml
 create mode 100644 drivers/cdx/controller/mcdid.h
 create mode 100644 drivers/edac/versalnet_edac.c
 rename {drivers/cdx/controller => include/linux/cdx}/bitfield.h (100%)
 create mode 100644 include/linux/cdx/edac_cdx_pcol.h
 rename {drivers/cdx/controller => include/linux/cdx}/mcdi.h (79%)

-- 
2.34.1



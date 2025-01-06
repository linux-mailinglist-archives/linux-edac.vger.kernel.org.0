Return-Path: <linux-edac+bounces-2786-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB8A01ED7
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2111883FA8
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 05:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D649C15622E;
	Mon,  6 Jan 2025 05:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NHyz0MuG"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D5171D2;
	Mon,  6 Jan 2025 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141673; cv=fail; b=OI9WbuQWQsZoJN8j3RL4Zx/jbIIOi//isQSYRIGDuaOAFsnsU4E0fIB6snAV2/DQ6UKHRyKIYigs9D8NAgfrMY8RyQKMbjgWQ7KDszrejWvC0n4xLqohyzJ0M8H2G8RDNNP6/STbWeaiIrCXWEQ90Z8X+lIymCoOprzT1yzfifg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141673; c=relaxed/simple;
	bh=UlLSTZvLpsxApLUmbKN1m3YZ3PchPxN0rbU5uBzWw4I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gXXgn/s2M+8MXHKUrGDr5V4Im4tIVmrjc9lQsLn4KDwrCCubj2P+57uJtSGxpdKXlo8AoK/oRa6wvPnO1yaJq9qh1Iy666SDpuE//Z9mktLobaU5d7UMbDJiyPS4gdD57w9vpWIfJHLVycUWaaWXERwvS1+6dPvA8hdJeTeQ2h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NHyz0MuG; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HL9r3HcFDg2eHDE1/+S2bTOJ9pSQH4g525sium+g87t2+lyvXgRfcpZ4B2QbeGmgIuC5sJjWFsuL/yQANUfaVewsCOdhLtnRUsZO0u2kEb/6C60jGsKPhcUGDF6InvujXOZXdnjlDxB0qhlhSNMVxb4wNOh1aVmrG5jqoV+e1MLbi9aqr2GDCxF9NKmY2YxSq2+tWu/WXaEyS0u4Onh/2OkHumzPJAt/4l8WiKoxZmpV6dTgtSO5UAeQvQC6917XpQQ1sSQKeW5SOecXmwbeKwH9E0b59sTwfbVLiJxNa2ptKG31j0wfaPdEcXao0dZdwGnifDWcKxnQ4spZyLsI6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQEEQNOmShiuiKQgReY5UKFYcNtIhtSyMEdByVPeaUo=;
 b=C94g4KicHqfa4f8I4lnXj5YmTxmc/GVIU44Le6Z+KPUBD2XURn+3ZPYd0BBSU8VbAxkRUjw6fmsEkTRbRyr+6dQVlb+B9HSTdEK+491L3+PC5WegTjbIL0zua/AB/26ssVdUgaMuh65hwykiSoYTgtbEn+912Ks7HaDbDgQp1IIx9zqUf0Sz8x/xrp+vHbkBgn1BRx54hophvzoNlh1osq6mxAVxSJrWHtnlHdga1DHAhp3PKxHO8eoS0rbX9BpIDZLUasZLNsR+S2GRcKOZ1Ko3dzXBW8J+kEPQa2EFtyOD7MhgOHNdkMcGC2KaqWq2ACRfm3EQMsdwxSYEyuJCYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com;
 dmarc=temperror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQEEQNOmShiuiKQgReY5UKFYcNtIhtSyMEdByVPeaUo=;
 b=NHyz0MuGDrremFCasz9OwGpu9S4SmKAXYzenC84wDc0kGYKte63e57pQ8hJE+5DbqEXkFxcW5VuYOsPBtw3Cvc/9U/EA7h8S1egYYUY/Gs697Fj3HHTe8Hd6n4BgeQXqCbuVvxOzl2RchnNXYWfFCz7cr35SMIKXjDRHSMg2iXE=
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by DS7PR12MB6264.namprd12.prod.outlook.com (2603:10b6:8:94::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 05:34:24 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::c6) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.15 via Frontend Transport; Mon,
 6 Jan 2025 05:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=amd.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of amd.com: DNS Timeout)
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:34:23 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:22 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:21 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 5 Jan 2025 23:34:00 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v5 0/5] EDAC: Versal NET: Add support for error notification
Date: Mon, 6 Jan 2025 11:03:53 +0530
Message-ID: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DS7PR12MB6264:EE_
X-MS-Office365-Filtering-Correlation-Id: 87ad2cf2-44d7-4cd0-b1c8-08dd2e13c714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nhjKV1Y8EB/f1dDJmEyrX3vAwa0LwKH+TENTKMmQ8ltSErgU/M2ITDKaumaQ?=
 =?us-ascii?Q?pUrH47pqNzYJPoYxptp92cvIy82l4p4fDlZd25EBUAlzggSCmAqpw0EC60h/?=
 =?us-ascii?Q?EdTKrooWWU/I9p+gkhLcYSnO20iB+s1hHqDQAD6MpsljcZDnGTuuAPGbhEej?=
 =?us-ascii?Q?QRHjsXxibZyUTCmWLDUfH8Kz41BhfGHFuKy1RKebCnly54PXjxIr5gRs+6+V?=
 =?us-ascii?Q?l3HXVNUcgsTYwsbZomuz+t8tGPWwLSo/ySwZuOEkJ3vIfzJyFyrFXXejJXf5?=
 =?us-ascii?Q?FuvSgdXD1qWdkNkrlgY5xoehhwKeQWKw+H77b71bMYDGNppBa5p3CGir6uOR?=
 =?us-ascii?Q?RVEcyibBR/6jekr+ysTEOT6Dseop+niWN8c8ZkBhvo0eAwMQ2NvmO/M8WabP?=
 =?us-ascii?Q?3xD0JpWpQnR83fU31PeeH6QYRQD1Rt0iCRvmUzxEgVqUDazyCunt5f+bxW6p?=
 =?us-ascii?Q?5ehtI8jVTfrhI32t1APVS9S+8m+++Gu2KeUEhrkhyy1v2UktHgtoxxz8521j?=
 =?us-ascii?Q?2g55TxL/Gm6O5piCpaiJMgtK9SopLgO/7ZcBhpJp61GWNNQn1ZWN9bAGUxqU?=
 =?us-ascii?Q?p3WRm5aoNw9t/aQacUtr5+uIxcm91UItmzwaxtGnP3m9w7PEWFV8947bjs4y?=
 =?us-ascii?Q?p251TkkGMF1I8MZtv/SLgK+MTl05wT3ohZFk2+BlzYW/CWm8WTLnLbLnpKts?=
 =?us-ascii?Q?KXf2LMAPuDNce/j7pHMyRlDU5xa0UD/YDws+PkT8Gk9ozRdSQzHUhLLiHSEl?=
 =?us-ascii?Q?KBt/HFtA70+xe3K9rSRLPlvrbdB3gyi2xBG9q4yl+MIpbwIHMTYzU2f4TLrT?=
 =?us-ascii?Q?ET5SjBAgKGq/bfivIMa2zumy4svZxiIyao1vPsYn+/EwhjUETFPIofRr+6mX?=
 =?us-ascii?Q?q3vawHNASs5ktEnm3M1MBbdx5GeP/utw8zBXJOFw1BAr8aQZ6kS7caI3Zs4/?=
 =?us-ascii?Q?YcdDRhTOvN+8fgyx3Dkf3JEzI78UJdfOUvaffIzR7hyO7+XL/x7jTSllSoZf?=
 =?us-ascii?Q?rdCYShqslfkYmE5BNGp0wTLjbG025sm+0LMEcRxFeFZBYWiXrsZGjoRtmDd+?=
 =?us-ascii?Q?FNGLaWoecSIw8NwRuhZNA/e88Nh3K4DFqM7/G5ClZK7HP8/QTx024dLk4dg8?=
 =?us-ascii?Q?82yAwSxIzl00crFxveZlC6FBvyE/ChU66ooyXbz258AdI37BiIEi0zPQW83F?=
 =?us-ascii?Q?m25pxOE5Ga1Ht4byLYB3DE/nMIuEtKOoZp6/VoSRmXBg+0k77YU3PqW57dpR?=
 =?us-ascii?Q?T93ErxYL09BfoFzUWJBySLe2+m3obJRVwzZoIcDbbizd1I7oL5+DVvDPwczT?=
 =?us-ascii?Q?1GUS4U1KUahMXYMB68jDypyEPls0ITFXHkksAZmTcVmMlRbuPIV4tNRI9+15?=
 =?us-ascii?Q?COvLaVURJPSMONCzMeqAnVjJVvMdZfj/nPrm253murKe27xq/nNnFT4Dkd6S?=
 =?us-ascii?Q?qCWmtd4SsV/QSC/7SgIkhcgvKQA4WdrJFgZ3pL5yBsE8lTX5G+cY4cqBHuo7?=
 =?us-ascii?Q?FnpepTUWEP964b7HxklSmOaxajZjUF3r6he6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:34:23.4194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87ad2cf2-44d7-4cd0-b1c8-08dd2e13c714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6264

Adds support for the error notification.
Currently 20 errors has been tested.
This driver is receiving events over rpmsg.
It does not access the registers by itself instead the NMC
reads and sends the info by rpmsg

Also we register the edac once and it reports the errors for all the
events including the 8 DDRMC controllers. So while registering we give
the particulars of the 1st controller.


Changes in v5:
Update the binding
Update the compatible

Changes in v4:
Update the compatible
align the example
Enhance the description for rproc
Update the compatible

Changes in v3:
make remove void

Changes in v2:
- Export the symbols for module compilation
- rename EDAC to memory controller
- update the compatible name
- Add remote proc handle
- Read the data width from the registers
- Remove the dwidth, rank and channel number the same is read from the RpMsg.
- remove reset
- Add the remote proc requests
- remove probe_once
- reorder the rpmsg registration
- the data width , rank and number of channel is read from message.

Shubhrajyoti Datta (5):
  cdx: export the symbols
  ras: export the log_non_standard_event
  cdx: add DDRMC commands
  dt-bindings: memory-controllers: Add support for Versal NET EDAC
  EDAC: Versal NET: Add support for error notification

 .../amd,versal-net-ddrmc5.yaml                |   41 +
 drivers/cdx/controller/mc_cdx_pcol.h          |   16 +
 drivers/cdx/controller/mcdi.c                 |    3 +
 drivers/edac/Kconfig                          |    9 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_rpmsg_edac.c           | 1325 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 7 files changed, 1396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5.yaml
 create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

-- 
2.17.1



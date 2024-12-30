Return-Path: <linux-edac+bounces-2751-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD779FE2BE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 07:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74C743A1C2C
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31172154C1D;
	Mon, 30 Dec 2024 06:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KL+CUx7S"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77524259483;
	Mon, 30 Dec 2024 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735538538; cv=fail; b=eUCCMCpfbMkEgO70sAaJbJJ5NU7rC9ZwmqMYdYUFoCNeHrxGXDckvCLHiov8BTVGH+JUXkqHi9ptUoq+z0xPdaPHn+hGvOx1GmGJiWR2+NsRnFa7XogslTA6akvOfvuOt93UHNTyE240f12GGhnHI2/RFKXHgTdKMYG6wnJYS8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735538538; c=relaxed/simple;
	bh=Ed2H0t8sFojZ2Jts2qrDmc5Ttptu/URM6Mz7279R7VM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c/eXfhpybX7YGe8dPj+dsH7xlore6NhY7WS+vwO9GKIW55PhbG66eXmE5sv5AekZrsHozwI1JQhaw2T2zDC3mypxVThy8yhtRVmL/ZGKbqYvPDaBVXCf1XtDw29xBeuuEXLSW0KVaxKf4l4WTG/iIpOiECGk/KVzNqyrGn2Jpl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KL+CUx7S; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5dseciKBcd9trvDDdsU1pO2ir5eBI9X2V5aDHYRMOMl4Elo4xFfv+8tJX39pAIje8NZga2Jwev+jWzijs4Y3XHCbeZg7Zdru+/okYFdqRDPzS6Y1mse4Ik6Wf4gGws/Wc0M2EgnJJcvfjZG4Y5CH2zQHAHzFnhIuLR/WtksfvQja6c3tdGvekx2iU2MPG/O0yKH1Za7hMYrF0/dNW2ZXDbwGFKZECH/y9TjkuMkcuY6Wb948L1zz/S7CBoYT+QedxarQxt4iN3vZ5H8ffbpJuGt1rSGtWi+juwH36EfCAzN+3AdUMe88xEEtrRhxytqnNkMM2xU8ME+6nUtw71Abg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUdY++t2zqf6V/SGokitpCb3+RcafTa7i4Nx9zXUr8o=;
 b=cxV+OYG3ez7nVdfuw0Mg/vQ+7xALK/ZUULgtjd3opDEWDxzkwVmP4kD2m6IbbKNx4xUXa40JHXSzPBcTS6QuWkmGmk4qpvnC0kLMo9NTEj3AMiUaFdu8Xg97+LodUK1sg88EX4hJZ8TVRBacM7vcyoLXNBF7FgwNQNlQ4oDjDSHzcOcM0qKHO+lS+PGi5kilZWfEqO7Aj+iotjUp5rEVlD9jt6iJADKah7EL14/3GfMGN2uDWjRzD2GYU418exHZZGt6j0/6FdX2fPLWlubnZ4pdyLPrPDpF1t/mpdQOycM9/FFIUKb6yA4xLrg2FflvFZtlfzwXDTnQI9dbQJhabA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUdY++t2zqf6V/SGokitpCb3+RcafTa7i4Nx9zXUr8o=;
 b=KL+CUx7SasoQzfd/g3fPUWVcBjPwz7JBkVLY3FdieMKk10/lOZtkwzhYWYV9iGNBUTavObrgfpbxUht68FHByaGy0OCFSJWoUz5YRYsB7QCCz5qZnZ78KEff4jb3DeUQnWMAijxu5/mNIrHVMtvz6IcvcRUC5UZIh+Ovn9T6ELw=
Received: from MW4P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::27)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.14; Mon, 30 Dec
 2024 06:02:09 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::41) by MW4P222CA0022.outlook.office365.com
 (2603:10b6:303:114::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Mon,
 30 Dec 2024 06:02:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 06:02:08 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:00:53 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 00:00:49 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v2 0/5] EDAC: Versal NET: Add support for error notification
Date: Mon, 30 Dec 2024 11:28:44 +0530
Message-ID: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 85acd401-3476-4cc7-e49f-08dd28977e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5K3PAVjPJiS+pDV6mhkrNQeR/SQ7xNB0SIkR8E+SnFx4lNC0qn65n0iIM8H?=
 =?us-ascii?Q?+7ZIkQ2hVf/6vNW1MquZB+4l7b1p4ZAsbqK+fUVoDYsfyQbOBPK3TdGBNj+v?=
 =?us-ascii?Q?Hv2t0PO+422mTm++VduP7SgKnhO5giUTylme+Mkc2vqIDt4mmItzCwqcnL15?=
 =?us-ascii?Q?jEuTC2EnL34cugXDBzPFdFHSQbFoN61JUrpY7GOxEp44dbPZxUfHy/yvruGc?=
 =?us-ascii?Q?9yYUxxRGKk67yChq3H0y2tnjci0JDmjURiXuekizCvSV5KyM+PQdGJfyyX5r?=
 =?us-ascii?Q?BVYIXUishN310QatBuZpuWWhj6Cb6s+kJkxxwdSb2FqSkhZR/Fz/ZOH6CiAd?=
 =?us-ascii?Q?hYcAAp4ZOjZYwfCRaaT9Zqh7oWauOOTFq5wpPUt9FgWfD3ej/PMan1Xk02Ja?=
 =?us-ascii?Q?eZ4IeFUOFXM+Jn/Inq01FiS586J0bolLq+jHMWgHCJJSdQ1+nnPtVK6PUaZZ?=
 =?us-ascii?Q?vxtl41sTHXuzEAGLpdcUBKgbJ2q8f8p8Sp1LtfB+6S3aB7cCgEpV9RxEK85V?=
 =?us-ascii?Q?AxGTJ7UTWoAjcHh6v0rCYb1q9eBMvLnDn7b7kslUA8S/5Kl8sP0LOE72SFeZ?=
 =?us-ascii?Q?6JXCFgRhO8saBsFEZT25WxFac5VCvrocEe9tAgUi51daz7SlF6fjnt4CNUDT?=
 =?us-ascii?Q?ZA18KbO9hpihnFfNYwKMjscR1qIzApU1NABEg03AcAx/lXf6QQJ1is8G6g9D?=
 =?us-ascii?Q?aJ169qHsvdCC0yWYeRUq3KjXDJzN0/F+SDCfc8o8FZE45iYHwwrOTFa036pP?=
 =?us-ascii?Q?sBi38cNZcfoQUpkVgh707j4BYp2on+fshDEE6cTrGgBLzUDXRMZznbxw1w37?=
 =?us-ascii?Q?1QkPKbAmKLQnOdAuX5mfW8eYynDKb+oosY2V+1PHnaEuv1E1+K4jv8t1ftVr?=
 =?us-ascii?Q?cXiw+R/PKfi0V0Z6J512IxuHv2+uKkIF1ltYxjSMnASqNPKIl84zSC5JPMSs?=
 =?us-ascii?Q?tk/bXKRlTugcT63RZPdevvo0Hk7SphGWz56BqxGMb/Rr9QoxVXyHwQ9EiKHH?=
 =?us-ascii?Q?VZvQXvrU0oPy/4dt9xn/hdiVWMqdUYpVt9uE62n+JpCuDmH25NVRtKdL9cMH?=
 =?us-ascii?Q?UaI6FCcZzWaIAm1tfu8F07OaC4dEGBN922KlDbYVwJDUJFBFn0Q6Ep+KvAfq?=
 =?us-ascii?Q?kMztDdWr2s7mSRJN+4zeqiAUdOO9wZ/tSZV+RCo1DTWfoiolrR4euxgh5dlC?=
 =?us-ascii?Q?7m9eqqj74gclhAZ3rmHRlc8GLBH6N4Rv2bMbpkNlImUhT7oVP2GCePMFDYMW?=
 =?us-ascii?Q?ecEOIiqImejgvF/bGe+io9ALu8fRxGwIvgopACPh8hDjmwpHrJNOrbaOo61K?=
 =?us-ascii?Q?9FO5uReR69KuM5XDrRBTPhMd4KDPBTuktr8kihLO2h1kjuosHkS+q2eb1ke0?=
 =?us-ascii?Q?vaDv8bH8q4Hvd7H/J1xRnHFDaa1HAAlcAs2NebniloDbEgvFo5IfTbs3BYC+?=
 =?us-ascii?Q?I5r7ZX0qjQ0vtn8RFInOLQtLoLVkzuKyic8ZztGxViz5A8YY54LSGKjXNIsC?=
 =?us-ascii?Q?6aC+ZOhnh2frqIq6y6skICFHCIJpGxlbMTMP?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:02:08.4078
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85acd401-3476-4cc7-e49f-08dd28977e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326


Adds support for the error notification.
Currently 20 errors has been tested.
This driver is receiving events over rpmsg.
It does not access the registers by itself instead the NMC
reads and sends the info by rpmsg

Also we register the edac once and it reports the errors for all the
events including the 8 DDRMC controllers. So while registering we give
the particulars of the 1st controller.


Changes in v2:
- Remove the dwidth, rank and channel number the same is read from the RpMsg.
- rename EDAC to memory controller
- update the compatible name
- Add remote proc handle
- remove reset
- Add the remote proc requests
- remove probe_once
- reorder the rpmsg registration
- Export the symbols for module compilation

Shubhrajyoti Datta (5):
  cdx: export the symbols
  ras: export the log_non_standard_event
  cdx: add DDRMC commands
  dt-bindings: memory-controllers: Add support for Versal NET EDAC
  EDAC: Versal NET: Add support for error notification

 .../amd,versalnet-ddrmc.yaml                  |   40 +
 drivers/cdx/controller/mc_cdx_pcol.h          |   16 +
 drivers/cdx/controller/mcdi.c                 |    3 +
 drivers/edac/Kconfig                          |    9 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_rpmsg_edac.c           | 1328 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 7 files changed, 1398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
 create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

-- 
2.17.1



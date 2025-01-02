Return-Path: <linux-edac+bounces-2764-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B86729FFD01
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 18:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A727A3A31F4
	for <lists+linux-edac@lfdr.de>; Thu,  2 Jan 2025 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E814019DF4C;
	Thu,  2 Jan 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQ1QFNJC"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6F18C932;
	Thu,  2 Jan 2025 17:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839909; cv=fail; b=LSbN9OJ5mNcRP0O80tyE89jOKUHVN1gD1Wk6aq5Ht9fdj9xjfukAzmFHPmCtRQ9FPEbLYtMvWEXdXsg8iXvW0IDbavUrFoaAYUPoMahV5P9cuOgdK9Icphi7VBLp+OpFL0Sg2WWjxdy8MXyQzIuzfNYNpght1WHtRetqkrunUcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839909; c=relaxed/simple;
	bh=w6Boiypc2lwSQ237FapQptnMeWQsKdFdmvoDRDz0bEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VpVi1JxUZjUuRDf/McnLdG96UpGgo6LMFy/rZqON3bS7+f0ZFZqYnD2JKGD/he7fiuic/nfBrGKOalsxaqfhvEqyhCd8C+Fk3txn5Ly71Rm6w4ennTrgXetoppDfCabQMsYGnBo8vC5wiP8Sbspt0RoRE14vIiisdJPJ8kdC1JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQ1QFNJC; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSN1Y5K6mP/CWCgWO6kDsmm34LiODyRepZecmBhwUkfNkrGdoLwymRv0DIQba0+RLNc+8hmrhI3bAf+OKuKfEkuu7jq/ekYmNhDW3IFtqmOBGLvN6u/Cw8QTBUCt2xOXMq61IZmp9bmS5w0g2+Gas0Qeqz7S6yC4tiejHFYNGnOzq+RVEl07eQRz+UwJbvl+gK4Sa6tGQXjQ+Na3ElP7rbIPoycFpg5HbDHufjfyVNqlwj1NSTwc1VNy7MoTvI/JN6Rw1bYHlUGi3FqgafmdVfdcdbYEdSY3r6s2r/k7vEb26jcZ4ITlrSgxEVEpGX+D3obcWcLKk4OP/yAjkjhmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWoVTia/QvV9n7R7NJ1XuAg82GCNNwOzcHitG9Kw1QQ=;
 b=H3WH+uVQoy8ONqtNzD5eLTdcYcO24H2JKxM8UitVbkqKcl/kRC4th5IwPb15LmNkLmjJ2NgQkC3y9g/qiVXS1D1XN690P0ViA+gCuSvujeX12fuM0SMr2eAsVeO7qeAvwBHAZyiRRrMVW3jhIRer7+UE2tPBKhXoCefp0//HVrk+NYQ/UGI2kdhOekCqIPV7azwx7svCZPQFmfxk7KYWWRpOglGDtQRoFnmY7Hz7QxF7k0YoSOvCqIKWV/edB1hucAt6iH5mv4diGv+yrafMqbmEzrdpTkgHSzuAGh/n67mlupZ7RBwx1yIT5YwJE4PNJ9BFsK8IDT6akCt/5y9P4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWoVTia/QvV9n7R7NJ1XuAg82GCNNwOzcHitG9Kw1QQ=;
 b=HQ1QFNJCpbMFjh8mmzTCnXtsUUtYv51vhohtqLrvriU7xINgpte0GrgzkYtcCvrGGmHgCG9v+u/qKqNW8ydur1mWwXBMpCgJdX8Vb+hJvz7pFkLO3twbCjIAwP1BvLiF2Ee47vzGimLXJuUDmlGl6wYAfhsZp5Qrf+JJx4JRhzw=
Received: from SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::15)
 by DM6PR12MB4356.namprd12.prod.outlook.com (2603:10b6:5:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 17:44:58 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:124:cafe::f6) by SN7P222CA0017.outlook.office365.com
 (2603:10b6:806:124::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 17:44:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 17:44:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 11:44:56 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 2 Jan 2025 11:44:53 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v4 0/5] EDAC: Versal NET: Add support for error notification
Date: Thu, 2 Jan 2025 23:14:29 +0530
Message-ID: <20250102174434.17677-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|DM6PR12MB4356:EE_
X-MS-Office365-Filtering-Correlation-Id: 135fcaf4-0185-47a7-0cb8-08dd2b552cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WcRku7+SAD6w7+qm40bDP9RIXFl7sUwfm81FtVLjt7l+A1aE9l/EwqD+fFxR?=
 =?us-ascii?Q?QO0ayln/h/fYyO2mhWpuHvLFHOYDd6TqhhU3zlTWhT/hF8/2TD5VRsc83drn?=
 =?us-ascii?Q?/TsXodtmVq+2b0gRDZHygIY7hcg/p0B/NLSHOHYnI8biBCEE52zg6IMSXcQ5?=
 =?us-ascii?Q?A5apGdY6OSodavg4tCqrCtYr7QDcoT3htvJ1SLtGDIiFKx7MUKhugAtIeLfG?=
 =?us-ascii?Q?ft4LHi0vaUMjNQ0KEA7vlKmwm/Cxjc9hx++T7YGjrI0Qobq+RP2gB7nz3g3z?=
 =?us-ascii?Q?1w5+Zq03Y9WWTfQe6bQ3UQcaN7uSRxbzTo4npVEKXz/wgGJdwm3wEQTOrYNx?=
 =?us-ascii?Q?2EpeahyDQJLxEAnPLiEO0E2qeBCYYlhu9jS5uwne4ZDVOl5lIeIWV5nGyQ5+?=
 =?us-ascii?Q?T0ExrSKZC1cGwKzzJFbn7Da0jHrCiefgoIvGFAp/7bdFjoY7sCr/BSzEXQBE?=
 =?us-ascii?Q?ovVfAujU0eHRbFjvvI3aN+UrBo5uvrlglA8V08KBG8U7O58okQKsooWQKH/9?=
 =?us-ascii?Q?aj5rkzHgNYPdhrobjLtwLu0v/zjHKfR5oR8Dzzd3uqHDOhOtLuGCplaH8Hd9?=
 =?us-ascii?Q?l069qlTNOO6Aey0EZsSrdxoIwy1JSM1gUTQ8c/2RQRS8hwwBbR2lsqnd+3s4?=
 =?us-ascii?Q?hVdDaj24NThMXovv/e2TbxIERAlmaHwyEo1aeo9tKLBoYIB7wR5xYVy+ks9L?=
 =?us-ascii?Q?YPcm66CvKpQtZTM1KesFpYywFxezPyEqvCkkIpr5Y2RTNuj0UopfP9NEwRP9?=
 =?us-ascii?Q?6IwqRm9vxmRRE27yGrIqskybrVpN0nZ8dRT8mHNa/8qhdJZdMlUFd4zXN/qZ?=
 =?us-ascii?Q?sdUzIiyIdoIWiYQbOUTqndIhdOsEQ0rqQ+0QZmpxBUp4D9GeVX5zr9gwJpMB?=
 =?us-ascii?Q?j+kbm+khbyPFPR2gZL+vJ5QdK5ccMM4wGY7G6OVX5M2WQRqbzBh6NDM58FpD?=
 =?us-ascii?Q?KckvrG+ppiZ6TweXYLGAXw5PhRHbi9FKdDpqtabx9pKKsWerDeiQ3J8eRfSd?=
 =?us-ascii?Q?SfBjmUjeFXE9fQ33We6dpSHs6EXMEgPwaqu6Ev+5aZPqbdL3yCw22jw+Fc3f?=
 =?us-ascii?Q?KvnCF4gtXxLSGuV1bAhntqnM3h9SYpPgKsMN307I6seWXaRa8ULAZdVBlRsO?=
 =?us-ascii?Q?b6OsbXR6KvNIiw8yOrgd4bW9oeLiO3T/rPqhozYf4qk07su1UqUhlVRSStW2?=
 =?us-ascii?Q?IKQhHUO6Cclwew6lNCoYqOuNm24JvwZBPxlNq/NyLTWSGBnN3jkUL60Nq0oq?=
 =?us-ascii?Q?vDCfo047ovkAuGLJ9+eqiodIMX5Fp61Gso9crgFWFTqBAktt9wAia3tFWRbS?=
 =?us-ascii?Q?SCRWHdAfI+TOnPKwgYKcKt+HzyMl8rLJxk7H7BFmDZSAoVy1WqUsuRbttbHQ?=
 =?us-ascii?Q?Yo3lwNsviYgfk9NGA/i+ECaZ6Y4xXMhkivfe/0vKdI6MvBzQAmSXh0eBG7tz?=
 =?us-ascii?Q?Z2r1fMFzFBvs499Rjmhg9hzUoUafeeJVq5N4YwaprRHJe4+P23qMes5WjS7A?=
 =?us-ascii?Q?3fAhMucuEY9k9h/fhTrhSN2p/HOuOpKJlYbJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 17:44:57.8695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 135fcaf4-0185-47a7-0cb8-08dd2b552cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4356


Adds support for the error notification.
Currently 20 errors has been tested.
This driver is receiving events over rpmsg.
It does not access the registers by itself instead the NMC
reads and sends the info by rpmsg

Also we register the edac once and it reports the errors for all the
events including the 8 DDRMC controllers. So while registering we give
the particulars of the 1st controller.


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

 .../amd,versal-net-ddrmc5-1.0.yaml            |   41 +
 drivers/cdx/controller/mc_cdx_pcol.h          |   16 +
 drivers/cdx/controller/mcdi.c                 |    3 +
 drivers/edac/Kconfig                          |    9 +
 drivers/edac/Makefile                         |    1 +
 drivers/edac/versalnet_rpmsg_edac.c           | 1325 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 7 files changed, 1396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versal-net-ddrmc5-1.0.yaml
 create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

-- 
2.17.1



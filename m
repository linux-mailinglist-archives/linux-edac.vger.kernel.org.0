Return-Path: <linux-edac+bounces-2757-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCA29FED3F
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 07:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480711882D26
	for <lists+linux-edac@lfdr.de>; Tue, 31 Dec 2024 06:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8FF16D9DF;
	Tue, 31 Dec 2024 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gCKZiXzb"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5CA15573F;
	Tue, 31 Dec 2024 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735626889; cv=fail; b=JBc3BAP7K55TRpas/xyz+n6gWgIUMNL6jwdptu6XoFy4LrjNKdnPatfxIhkj5v/GIuwcU6PG8SArCGCqeHFJGG9TSyY/1jVMqZry+ADvCkf7K4tauMzs/vIgTGXB0j0RN7u4a2vYeUFzHe2zWuxA8n9KSjXhBzYZ+VA7NC6JECQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735626889; c=relaxed/simple;
	bh=4HxA0o3G4HZCSszWy92iY6Alrz96l05rc/g17WaZXrM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hZoJ2IHr/mTFAOK3uySxUTb3yvSGPvK3VT3Qi9Vr88g+Oxu3IhoJ96sqjWuxxHT2TjokLU6UfyC/jtT4iQpDH6XO+5cvC/nZU8V9WTvMma8PbGNdxBXyRTVGK3nSFosW9D2NZ1FkK3sWg6MaDJmLLm1aulp5nco48FMsRd5xQg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gCKZiXzb; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J76pTw9wJq8qWmE8KEwkbG+RRCz35qZhsyhANojMO5vFFFu2ZY4w+8PvvKZRNSWiNHTx2v9FXI50lv8eOoLOqnmrl18pQfh0QihzmwfDmAqRT+S66TvoCDO2ov/0LpazJuFtCPHGfpgALT1wVVQQGH4Qh033Omjt3cXPk/4Nb/3NToO5pVAgspB3uqqOY3yYjqooNtYzr0TKbamcgxgkwjWm/LotZLHp+ZB5beQ11ZgUzjQSsaOM5oYeggIStKTrUdLwsfeZMofl6HPBmmeyFIPGHPYT0ujeNlqfe2ziRMrwEMB2NG0nzQQWB5ao7IctLYoWleaMAbJTYw9Y/B5cIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zamqQwE8lhoQPkl1cEKltflAkHWBIdZbtcY9bI0MEmQ=;
 b=UzWNsq81Xv46kE5RVgPe5wIKFqSmdl5oTUEycqhP4eAOXKgSaIuRv2KtslCgE/pBH+TDkYQIshTqEYEFp8VIsxWocX7ruXeMj6SPEhX74UBuSOnkW4Yt5D5csEhPVCgTWvala8NTFrQ9r4p7Oi/el+FetFaq474yYMnDvd6RwtedoEBkQukLwjIUTGTIGDG3HLXAkBYH8aYIkIEF9EGoq70NtjDZ4SdiCofWlUeEKqQkTlFSBnG6ZzF3xbVO5GpaANXn2/gEZBK7fufiXaKZaXlehoY+H18HlnpY5femPL1TSZy8ZqtDhJ8kntuqI4fjrpJ9mT/sFT0OTTMxynFisg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zamqQwE8lhoQPkl1cEKltflAkHWBIdZbtcY9bI0MEmQ=;
 b=gCKZiXzbwc7btsBjyU71Am5oAz2luUJ/vuAooZJ7gpnCF7vkzWfIEH/7+vITrZz3QYr4G0Kf6PR3f66S5bmrKVXRFM6I8C+kwu3ETBlrcNfmmxQzrr7/O3Eh8/DRtawAUj9rdXKnmEXgx79rx1W9tieihyt0g6fQa7sMWAHuGMA=
Received: from SJ0PR03CA0219.namprd03.prod.outlook.com (2603:10b6:a03:39f::14)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Tue, 31 Dec
 2024 06:34:41 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::ee) by SJ0PR03CA0219.outlook.office365.com
 (2603:10b6:a03:39f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.19 via Frontend Transport; Tue,
 31 Dec 2024 06:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Tue, 31 Dec 2024 06:34:40 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 31 Dec
 2024 00:34:38 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 31 Dec 2024 00:34:35 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v3 0/5] EDAC: Versal NET: Add support for error notification
Date: Tue, 31 Dec 2024 12:04:29 +0530
Message-ID: <20241231063434.26998-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ca1ad2-5978-4cf0-5438-08dd296534ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S0+Uikl6QymIN5JrMnY3Amf2k/1a+rn7f/KGlTILWOQgcuT3UmPe5QbGpEsE?=
 =?us-ascii?Q?RjuxKMpaUJW9NaGNWhZ5ZBovwnW6tE4WpL05JNjsDO0I7mxpHfCBeey/fkdn?=
 =?us-ascii?Q?DpGIl0treg//DBHmcWg86Z9gn4KEItf3YNhAekprI63Hhip+zb7Dg2XMxr/9?=
 =?us-ascii?Q?IJNUOp8D/xVqaEaM3TvX0ozbbe/grDYX0iO+UZTVKNsMzZLzjiIY7pox9S91?=
 =?us-ascii?Q?fqCvGenw5CJMsgP6P2rOgrBfVDQtXemIWdyEPspsCx6jW9DbzWTWDnx2mJh8?=
 =?us-ascii?Q?iZS/R8Fx8boTNd50we3r1Pue//tjc2764FnvQSi1iOoxop9ol+2yTqiSLTTA?=
 =?us-ascii?Q?W1p02vk9+64KLbyqfb3YgFtklDZLigUcu0/LywdjtAxS8EP0QlSnOgNLeysN?=
 =?us-ascii?Q?OzlhceJBMogRyNkn92F70iJ0DF0vRu2FAam7hFP+QMa/W3H07jcH2gXQo0Xh?=
 =?us-ascii?Q?joicduhL7VwrM95TQ5jXGWglrThrCqS/7VXPF9yVcA7S9qN9sKNmkFovqTEg?=
 =?us-ascii?Q?ydUzusGeE9ITM142tJ6JaRWJnkHgKYzsFXYbC29FZ8rnFOzAfwv08/h6WHJj?=
 =?us-ascii?Q?RFzwEb584Bem56N//nA2Uj4voD7cMyBvUv762xGLHtZe+doi4Rfu20HNXYDR?=
 =?us-ascii?Q?ZaFWuUXL92sheFc69hnq0N2dQ/OMlZGldOl1oJ7F+mzldNEJLWNZl+XLxTnn?=
 =?us-ascii?Q?dnUmkKW6SxYa8NVLQDwtLKfprX8pyVVUObEO9p7cONk79AbXmOfOR86uRJRs?=
 =?us-ascii?Q?T+4AsVtqLBLypDcj/lOdDtCJgdwMfPOKADumtMo4TD77Tjop/5XHx0cZHyLz?=
 =?us-ascii?Q?MH8//OfHGlKDLtfUuYQaEX9XeJEY//RG+hSFtAaLAzX+iifWNpZ3jVatgQPm?=
 =?us-ascii?Q?kNMS8q2FAxJESdXCVSYsitRlq0AaGm3910a4DaGK5E7EFfLb9liYysP1iifm?=
 =?us-ascii?Q?2pBPxnNUEUKhtxUMqplcO2LsUSLQQsrPt1eJLnB6LlUDT2cEASQpu/TjDHUE?=
 =?us-ascii?Q?2ZPTMVu8X1MomytSv2DW5xmph+TgVrU4mIApoxg7dgMyzPjL1aLvs62GBZA1?=
 =?us-ascii?Q?ZpeSBJJb7RSLPBKKX6ulm2c6Cut7FkSCkPF39sXij8J5STZv5Bf6DM8ohnsg?=
 =?us-ascii?Q?ykqadDbxaHa+o1N5eKWz2GJkc+b7eZisWlpCVwo6jrlbg+kEppjmaagXJiYu?=
 =?us-ascii?Q?M+bUP+mVxsmU6LYNyyKyPw65q5lZNzZzy8rbC8H7L+tMaYtLli30RN7RJHDt?=
 =?us-ascii?Q?xc6oxv50tG7rpLCWf3OIPwgiQH3Z34ReCTmUE5O47zIsOUzdvi9QdGiXCFnq?=
 =?us-ascii?Q?zcRdwQcigWSKOjXxIsXCb4UbMRoolE0GKH5xInne7gI+AaPZfCgE1pBYupKO?=
 =?us-ascii?Q?oNBud3Ulhzf0GZBLd5J2OfoM1liy2JWNR5yAteRRQCZMOTseJMEJYMdoYZNL?=
 =?us-ascii?Q?TzdoOujQyilFcACBhCMaXvb3JZWwiDenc6H2w6NRQYCclK47L4eGAZ9q17kD?=
 =?us-ascii?Q?hd8kOqP4RYafemDCEEPiXFNL/4aXSHxYBZps?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2024 06:34:40.7191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ca1ad2-5978-4cf0-5438-08dd296534ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106


Adds support for the error notification.
Currently 20 errors has been tested.
This driver is receiving events over rpmsg.
It does not access the registers by itself instead the NMC
reads and sends the info by rpmsg

Also we register the edac once and it reports the errors for all the
events including the 8 DDRMC controllers. So while registering we give
the particulars of the 1st controller.


Changes in v3:
make remove void

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
 drivers/edac/versalnet_rpmsg_edac.c           | 1326 +++++++++++++++++
 drivers/ras/ras.c                             |    1 +
 7 files changed, 1396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/amd,versalnet-ddrmc.yaml
 create mode 100644 drivers/edac/versalnet_rpmsg_edac.c

-- 
2.17.1



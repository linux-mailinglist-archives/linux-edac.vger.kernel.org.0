Return-Path: <linux-edac+bounces-2602-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700E39D5CE3
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 11:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF26B221F8
	for <lists+linux-edac@lfdr.de>; Fri, 22 Nov 2024 10:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875F91DE3D9;
	Fri, 22 Nov 2024 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0TwT/8QD"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05911DE2CF;
	Fri, 22 Nov 2024 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270009; cv=fail; b=q6yE0Hmc9V5oPm0OhzJ3eUPIPTTOraXho3gNpY+AtRdhE16vBPYbb7usecIizHesDZMw/Ah3G1WOrc/4DZDywMGm9h5xJMgbmfDuO2x2aa11fWQqV7J+09AmZM0YpVGjsk9JrJMCW300XGUhLmDrTGIfKLB0TVtMGZyn41Qz/Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270009; c=relaxed/simple;
	bh=oBzC2IZNyiBYZWpSoz0ut4drgd/O8uYbPd7lMD/cfNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIdWaiAiz/Hcj1C64OxzxB0vuSmprwheRk47/gfdHNDBYdtVAmLI5UrBV1js4CqMJIifQE5NQqjhNJFMo+5MLI1sXO/Rtlptg9pSzj/cNBcWiDpuKo8TYvHNXqWIo2E0PtHYF327LVJetuF8+ttu4kjmxjtKFebPoNNJyecdmEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0TwT/8QD; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7RYhSOXEmwpqYEYSvT9XV41A2tx4eabvHXlwXZiF5y/Wcs9QFfvx4feJNvadRMS2FAgvvuRzqW4p5D8/sMTZ5YyC+rlG4fwaTMJonVXxC6Sjfx1CNvdvxEp+rj/pl+G4OoNAUpQwynPB/SGMFldBU4Spg6pGDgX8twRibC/VpgNoLXJqxftTy1EM+IguHcDpH9BIcVSe/Ycv8In06bwRjkTG4/6qldvmr96LrDdjKZzax+B9ytjWv4xSD49TeZ5v1mFgv0GdJU6dRtIJ1ALSd1bKxFak4XUlxPjFPnd9zt9IKF99tPg0oxABqBjr3ft24byvvWzp5xOPIk52Z4Iww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAx5zGoJwRwj/TX0P7cfnoWeKfYzrsjk0c96mMaH7y8=;
 b=ZwR1n4wsB5+u4MQlbUo2nPM5bBs0Pr+QHvFqVzqpuAqokRRWfqF1LVqzDJzYK2nv4oAzew9hQZ3phj4aJVS4ZcdiTUrop8VSIv3pru3oB917IfDE+VWCdLz/aIg59IZCAZfuNdQCQPSiIhgi3xjvao6/siXJVAKA0THFsANAU7m5ldmZwYvuM40m/WvChaKaOpBJF/dhk5TVbSczmotqS3IE6R0GeDOHrGC71xVMvAcGXoU6DLoi2ViIUfWpY51yHZEhAns0q3ymY+hXzUFUsay8LcPRipeeXu6BSriAcFl/gw6pcGkR006k5TmoDFdhjJBJcneHpGrilapuiNChLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAx5zGoJwRwj/TX0P7cfnoWeKfYzrsjk0c96mMaH7y8=;
 b=0TwT/8QDKnCkmBXQ2bJyrASwgJUjZizyNyvVdPC65pjIJ6VHFyG4gtArByhSkUs/IyRe8Jllncq2QTHusopB/F3nxF616WkpFPZst4kulUZ5O+yJlUcmsEFQ6kScdBgK5V7CpMaWyZsAqxdHzQqeikNJJw/hzN65KpO4sE+6Wc4=
Received: from BLAPR03CA0116.namprd03.prod.outlook.com (2603:10b6:208:32a::31)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.18; Fri, 22 Nov
 2024 10:06:44 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::3a) by BLAPR03CA0116.outlook.office365.com
 (2603:10b6:208:32a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend
 Transport; Fri, 22 Nov 2024 10:06:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:06:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:43 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 04:06:41 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 04:06:38 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-edac@vger.kernel.org>
CC: <git@amd.com>, <krzk@kernel.or>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
	<mchehab@kernel.org>, <rric@kernel.org>
Subject: [PATCH 2/3] cdx: add DDRMC commands
Date: Fri, 22 Nov 2024 15:36:24 +0530
Message-ID: <20241122100625.24571-3-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
References: <20241122100625.24571-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 74a1195d-f9e4-4538-c8aa-08dd0add5e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5DYAN8zR9F868CrVTYtZTDb4wBQ3xZ8XhwDP7qL/i4CZE0ZJkTSzPgWGcxm?=
 =?us-ascii?Q?38khhuKiNYb//f1HM96y9vCp+9hxXWD5ePZyE8p90yWINkW3gXgn42wRk9Os?=
 =?us-ascii?Q?UtQwOADmwaGdcurOAeL4hlN+YpeHGrS+YbhTFVPTbGfVs5KirN6HwuKxTzdy?=
 =?us-ascii?Q?jeu4bKgm+6E8upmf8YWdWxddN9lMMw1MmSs+gekhArXVCeJcFx92xFxEk26O?=
 =?us-ascii?Q?uMaN9bkngctfiAMzhQcPxa25mqCUOYB4fGLMeVabIuENeuzhB5Vmu4JnFQa7?=
 =?us-ascii?Q?8Lof015xSuTdtTNN7p2pXsqI9oylDcjmTLP+rLEoSnHRk/We2INedwnvFuN3?=
 =?us-ascii?Q?9AiF1z6uZf9vBUnruxU+LHCQZ7IWt6CY1dzAdR6vC5LOvX+tOpXHPEqBVSnR?=
 =?us-ascii?Q?39yj6H0VQo6FVKx0k/0gfKOjiKJWnN8jgtO8CeyZXuFHcoHfGhowxwIH40jv?=
 =?us-ascii?Q?BcTqwmG8NWlICuc67NFJoH4aVrE7x1m1QM6xKM5Y1MQrc4GutO26+/1kUHZ0?=
 =?us-ascii?Q?BRAj3sfFItB59cZjOahoxb4MF4KyLBcE8niBBFlaXfxbQ5zW+LnKD4WNdtfS?=
 =?us-ascii?Q?tV8GlQxnBHh73ZkKpqy0HjkcsZx7TTSIjbSk0t4TaSnPAGc95Y5lx7H9dk14?=
 =?us-ascii?Q?TnqgjJk8o1wIgSZyLoV3TYbLNCVfa1GrjPP8+J1wW5BCiisVfqGv6yzksB83?=
 =?us-ascii?Q?WQB/o5v/w5hrdvEegoaI185YaY7gjXpw2njGeiaJiUQvINW/c9nH8nGzS7cy?=
 =?us-ascii?Q?U8pdWB1Jn2TSExfdu/YnzORdd11VQ96ltwcTU9HEXLBmliJGaQGLpoLzxZye?=
 =?us-ascii?Q?lALHAnqcs/GUctFnrKQWCQ6YU3aH0TkiaD6an3RLbyfMv9ojiHxAoetOKvt6?=
 =?us-ascii?Q?aDsU6x7D1/atWQoxUcW6B1D45bFsXlvQQJ7ztmgBVKq2Txv8ZGn+Pgr2ugPZ?=
 =?us-ascii?Q?4do0G3cXfDecvhAAi5FbMtnynsn85la+7rzcg1nF7DQflrl2uXls6clwrWsn?=
 =?us-ascii?Q?yWJ3+pfNW9Hn0p6A5dgBN1xPt5vcZMXSwYikhwL5zMV0bwRh9Islb+ImF6E6?=
 =?us-ascii?Q?JHLldaUCb3Nbq4fWfDMUBAhZHfoiPI/P4kDbESMb+ySvF3l1sDiXgqNNKU6r?=
 =?us-ascii?Q?fv6OFmFhT2lL87zDppLLgGvhmErql6gqRGgJawab0lN2uA9NXqxXHbrhYJ6o?=
 =?us-ascii?Q?WN3ZLDaqu/pmaq6d91975QF7VzHFFp9VWtgTzZaFEgD/oJqXNP7JtEljkNwB?=
 =?us-ascii?Q?t7NWhF70cciKY6hA5fYXP/usuLLzVNwZIjbTfMO4+4xAb5vUV5HaLorb7J3q?=
 =?us-ascii?Q?Glb4T7XFJ19jQsdtoc1ROBqMgS1wP19Fj0f0HnW0KH1KwvHOXqfLD32cdd+4?=
 =?us-ascii?Q?yH7kaxCWQ76u7jcjFgjd+qtD4dFuZvIYwaEjLHsufByJoB5K4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:06:44.0567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a1195d-f9e4-4538-c8aa-08dd0add5e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

Add the commands for getting the DDRMC properties.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

 drivers/cdx/controller/mc_cdx_pcol.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/cdx/controller/mc_cdx_pcol.h b/drivers/cdx/controller/mc_cdx_pcol.h
index 832a44af963e..174270e148f3 100644
--- a/drivers/cdx/controller/mc_cdx_pcol.h
+++ b/drivers/cdx/controller/mc_cdx_pcol.h
@@ -302,6 +302,12 @@
 #define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_OFST	0
 #define MC_CMD_CDX_BUS_ENUM_DEVICES_OUT_DEVICE_COUNT_LEN	4
 
+/* Number of registers */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_OFST		0
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_WORD_LENGTH_LEN		4
+/* Number of registers for the DDR controller */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES_OFST	4
+#define MC_CMD_EDAC_GET_DDR_CONFIG_OUT_REGISTER_VALUES_LEN	4
 /***********************************/
 /*
  * MC_CMD_CDX_BUS_GET_DEVICE_CONFIG
@@ -587,6 +593,16 @@
 /* MC_CMD_CDX_DEVICE_CONTROL_SET_OUT msgresponse */
 #define MC_CMD_CDX_DEVICE_CONTROL_SET_OUT_LEN				0
 
+/***********************************/
+/* MC_CMD_EDAC_GET_DDR_CONFIG
+ * Provides detailed configuration for the DDR controller of the given index.
+ */
+#define MC_CMD_EDAC_GET_DDR_CONFIG 0x3
+
+/* MC_CMD_EDAC_GET_DDR_CONFIG_IN msgrequest */
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX_OFST		0
+#define MC_CMD_EDAC_GET_DDR_CONFIG_IN_CONTROLLER_INDEX_LEN		4
+
 /***********************************/
 /*
  * MC_CMD_CDX_DEVICE_CONTROL_GET
-- 
2.17.1



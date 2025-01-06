Return-Path: <linux-edac+bounces-2789-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57243A01EE1
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 06:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D7AD7A1818
	for <lists+linux-edac@lfdr.de>; Mon,  6 Jan 2025 05:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14541D5CE3;
	Mon,  6 Jan 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AnFxGV78"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009D51CEEAE;
	Mon,  6 Jan 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736141696; cv=fail; b=WHVnH6ebdwv8URvqgYzsL808YV8LLTx3B/c+5pXInxBcpuFMT6DZCXvJEEZy5v3RBd8VJvg/KqcWtVoGe/vV8mMUG9ypbpUK5W9KkJhFNGiaj541ArRi8DhYgxUuZKlUMb8V7SdNLS4otuHdPBlBojQ1tXbyEnD7ojkovZxIt5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736141696; c=relaxed/simple;
	bh=yvdg//1e8752OL0niSJ/phg7+tUKnrSuQPNjsgpXZsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhjpegO5GUZlKBVBs1cqgyW0tGKZ+I/w3PfOagYCmISsEYhtYkgDNlJ6Xr5Q+atQ8Gr5bx9YxUYTfr6vw6FcYViBRoGLOLaLBEK515fqABUQy+WsPAIMK8MB/7T8pbhuLX7lUcgdrdmTkI1QPyQnMnlEghRsxIDEGR668AkTcxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AnFxGV78; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kv48l0fLt6XAyxBUs/0HzoNk3VQa1+FqvqQegKpbu/zc1BdvyjJRwGX6aNpaJQjGA/TuExR6C667KXTqrSrH1TbB8CYwha2On7dELJM6s9Sz9MM54EDeUxr6HTzF9NoAU1Q2MB1Xn7uCGli8H38TgT1N8hWZLGMdgp+O8z8IKqoB9FONR4MQF3D8qIZPlOQxjLagBUKquBrzE6RqmsoX2X7yYEVXcwutPQhbxAtyXblvaUOmRBeMzp99t4oXBeMqPTk8BvEhBd6bnm47ovIZJfu+13pCJIcychEJ9zekniiqSEfYrZ0kfD31kcxpnZ04YE0tSIqQB/Ip1jZfwGyurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=qjzLCeZmPjXO7xXa1wgrrfg110xFfWhUGB87NYVbyOOfUqoO+ZHXALv6o2mT6ZSrw6VdVwg6SWimWMptEoD212WecmIi8RsDvcwwXfE0CWW074t7twxk9iIwxkAvJYgC806zyc48nv6XDbUci+3MqJ0ADFaOYYgnIO7lryOak4TKXfih3qc16UgPlEt0Cxkk1l82X9l3Q9OP7sy3avecbOVFL9ZL5nig28h1lCbH7/Ny+3GDhmNam6u4uTLQis4v6Tmp3o+e5DQv+kHVXNaQMvnpZY/sL32tvjixqydU0wWrKPLbgWHPJzveLLva3t2D48lVZvPDQBo5P4181Stfww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=AnFxGV78REXSteOLFtDHRBc7Ij5wPx98BjrHYfN45E86U1KGAGoFLwDYTI8xPTTUl7U3GnnrL0PQisFQH8HgnaIhXENh1bYqO35bnCyXgoi4f0O1sIJptjCNZY+YZxrqE2JUpe2b0/FNnChRhgLFXTJP6OPKH3CM+e2dSeKhsPE=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.16; Mon, 6 Jan
 2025 05:34:47 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:8e:cafe::eb) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.15 via Frontend Transport; Mon,
 6 Jan 2025 05:34:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 05:34:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 5 Jan
 2025 23:34:45 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 5 Jan 2025 23:34:41 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v5 3/5] cdx: add DDRMC commands
Date: Mon, 6 Jan 2025 11:03:56 +0530
Message-ID: <20250106053358.21664-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
References: <20250106053358.21664-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d52c5a1-28be-4cd8-4541-08dd2e13d53a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rpoM38W/PWOiuDWV+zhGjguN+Uu8kcP5o1uZg4mnt7FfQgLySNv9EI2poBQ4?=
 =?us-ascii?Q?3PgUz1FJIOo80fwokxKf/Hux5MD3RvKoC2WYqUYi+PEtUHlxIiswE2/Y6Y2d?=
 =?us-ascii?Q?dNw0OPbIE3RA3plzheyGFUKSNP2kKy7ODrEv8iPlPE7c0XVWmwDdA1DSriqW?=
 =?us-ascii?Q?lA+AQ2W4kPTn4GSYuO1qc4LU/yWFfiJ3hUj/5TX5cgzQGVqeKs4cuj9smxL7?=
 =?us-ascii?Q?B1KcpGA49E+Jw3ndcbJczJXUJq3D68PTlfVgz+QG42PiW6BfYqx4xut7zpiG?=
 =?us-ascii?Q?OlurDeIBmhpdWXPEvd7vpPfjGBGl9GG/N6JJ/xrMzgvI/OpqEXgJDXvOMwZ/?=
 =?us-ascii?Q?mL3/Z/8oUv/qTsDbF7snlMN7P4i9rXdwGnKMw40Ow2spXcz5ZdWry+opF1u/?=
 =?us-ascii?Q?PnSAKDaeYiGaK7RrykfhkpVNEL4mVtSSN7Y8KiwhJ6DTVh//dKAen5dGtiAI?=
 =?us-ascii?Q?SZPJ9iGP1F7ousSf+LfPexZx/001qUdlZLQ3vDCUJGIZ/2lZDdHONOpOD572?=
 =?us-ascii?Q?4QT2RmQj3jLP53E7WxQ32LTJODmkRpbtxM7tE8RUAglisMttjQ2TicHNgh9c?=
 =?us-ascii?Q?g0efzcUCI4dXicsiVVBHUhqcNGbCqutrbD77heuhiRIxysWMgGLp6siii9BP?=
 =?us-ascii?Q?n0UqYFT383I2hiw3HuBuLiPzd+jT5K0mdPtiBmczqXtHlBa85iysVoYI9vBP?=
 =?us-ascii?Q?kQZgFfk4/1UdT/SKjQtOFshlP/luzPcViZmKFXtacAIwwTv8eSB/GeR4ubLs?=
 =?us-ascii?Q?zBpc44aVXcVLXdZ4mB4ZCXy5NACQn3RjqPKGzvQ9QrfnlohrpJQpwWPBYw2K?=
 =?us-ascii?Q?Qtf9fgUiwPMPpGWi1Q8Ndgw8IFcxDd6p71piRxTNp30IYQ6knd7qKYfe7aAY?=
 =?us-ascii?Q?N4Z9xmz58PB0iu3qZ56V8GVWSkBDttDhrDBvTDkUFfOEX06MVVNS9Ecy9LsE?=
 =?us-ascii?Q?zin9hqFixdOtVo086BTpJlU7CTXwEbhUFagVSh+/VU/My+0NGcsdUGUmLOEe?=
 =?us-ascii?Q?WEzz4HepMQSCNc3yFfxh3CEtK6ARvQ+uQNq10srEGtAwgXOw0dy0Qr8qlzWF?=
 =?us-ascii?Q?apRW0rUN7zEobCN9EtDuv+d/eoCzM9/7EbEhsDkZWc0Q+aLiaYVviDoYR6qx?=
 =?us-ascii?Q?7EdedT6JxDTg6GDID9gqRebzBDrvRtwQ5RIYBouIsGPle9iknGttwZr80JV0?=
 =?us-ascii?Q?WjKOe7/YXhlGGt3K/iTpEeOX46ZR/teSfGs6wj8QIDTs+4Gb4cVNAl7U2e2T?=
 =?us-ascii?Q?wzzrrOjGHLgmVTJ12Uvzqe0MIaxqpdSsNbqxAQ+cwbgNoZ52WA966JOIW0Xe?=
 =?us-ascii?Q?Th44ASYK5FwGG9BE9a7vi4k6TjDSAUBZhLAJBIlpGFTRN5hx57ehi0ajjaYa?=
 =?us-ascii?Q?pGHRYs0KjUDAqdadg2gflpTwjxo8kC4DlqpdJBaT7vQDkqPkTe1iYY9RhkWS?=
 =?us-ascii?Q?upuA50oZ8Jk9kLcYbpgf4PcYS8eSb3BbvVaMVHe9Pstr3SSO1Bun7rvB7UqB?=
 =?us-ascii?Q?jRCMy+5b/8yYj+A=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 05:34:47.1381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d52c5a1-28be-4cd8-4541-08dd2e13d53a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

Add the commands for getting the DDRMC properties.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

(no changes since v1)

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



Return-Path: <linux-edac+bounces-2754-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A2E9FE2CB
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 07:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965DC7A1101
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2024 06:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A216A189BB1;
	Mon, 30 Dec 2024 06:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2CuE2n0r"
X-Original-To: linux-edac@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E031891A8;
	Mon, 30 Dec 2024 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735538606; cv=fail; b=mTwUnFUh2kU+OAvcYw9ysSr1jjXKDRyyYt/8E6jI9fahewfMuDbap8NrZlSMkAGQCVIvLdn2hpVHbWyeM6hAt5KyiGksyJXJH2JUP0ti2lFHt9ot1kN0hDEXJckQLkkNYBw6fDHEoLfKsosluhRBo9PPiaI9y5Y57korRsB3pOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735538606; c=relaxed/simple;
	bh=yvdg//1e8752OL0niSJ/phg7+tUKnrSuQPNjsgpXZsA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jqiY37O9g8rBuXVqN7lewsxPeX7IOIcxy2i7TXVrv9CyXm1upxmNIDPeeSiKdWVDXBpVtpPGybp1gQSN28cNXUWKiIWwqCTKxkW25Q7Vl9ntamBE85FBxTRBbGlyLxCNc5t0gVFNwk86v6/kP0oFMjCOl+R+cPUGnBnd1oE4wJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2CuE2n0r; arc=fail smtp.client-ip=40.107.220.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=recSX7UAK96N0HHzZFX/DA6pAanbVUj6f/RfkCxu4YIYTIHZKccSpkukYL8bGlHyXBW9rA+6XiJOrq0cOigGWSYH4w30a+o5qnQiy8+gBQwZok/D3L9stL5yQvmkk3d4f60hQDSituCKUBiDy9XQlprMid4yyh6NePofF9MWg8qCSMBPy7lC5Tkx+BRyDvWIDux1pIjWEynKtlk+cNioq9JYy9JtzYow7pcodLodloTkJ7G3JaT6Ac03gEn9mzPE78hoN2p6W6ZVgt5KLp6URS+fQrygVAHGVDuNNEnHfYlseOzR+k4NYFUz9hT3O+WN4bA1p6YfxK+1q6OBH7vrvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=nsVN9LaCSl9iaYle4Jrk99yYBlBVf55FYF6K2mQt2YaP0oLJ3hQHBT+GPXITegZ6b/lG1wBRMzned87WumCPZqSMdHqRT0/rPJQ+eF9WxXeDJkzHpdufkV3Lnr6i690GBkJ4tSKSCWz8IQP1TvCYNhjOIlz0sqNkI70RY9ZGjjicmvjnFqul6dE+pwMBVlOMN1WJcne0iMs8JoTe+AK+xAZdmuef9wkVgurbsJx0f0sIfwrQXUxfrIcjcApLy1mDai6HObBzohGvO9xFS8+uVWClt3VWunbsPrkSySr17yCOfwkBue/0yr/MFz53M5GYke0ul1WvUzZ+m2GxlRfgxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2a08Q2bhaNDRUjwj1vU8qKt9PKCYPk5vvRmYMYUD7A=;
 b=2CuE2n0rot9/oqgRDnUTZXNyFoy7h5loK8+kyTZEkp5rwc3jgtb8BDE/OBCuTsPaWlatiZEJSvGFLbcXGoZ8QnaIOWQXsM0YvwxEzx2pum5EL1IEA4D3Eyw/tU2BsMcuGr8bWopIe9I9BqEpby5VEjJDYSySLq/48p1xcomECWE=
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 06:03:18 +0000
Received: from MWH0EPF000989EA.namprd02.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.10 via Frontend Transport; Mon,
 30 Dec 2024 06:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989EA.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Mon, 30 Dec 2024 06:03:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:03:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 00:02:34 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Dec 2024 00:02:30 -0600
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <git@amd.com>
Subject: [PATCH v2 3/5] cdx: add DDRMC commands
Date: Mon, 30 Dec 2024 11:28:47 +0530
Message-ID: <20241230055849.11183-4-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
References: <20241230055849.11183-1-shubhrajyoti.datta@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EA:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f04d166-e47a-4478-19a6-08dd2897a795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YP+hv9EoBInxn8l6R9jyJAxEKMClr2EDQS3DQmu717xyF8XgUfpryL4DghIh?=
 =?us-ascii?Q?CVFqDuxSEk0OtKkISm2WvXKSFKhfvMo7eZYfDJw6vWWLgJ0qNAJK9N30L70t?=
 =?us-ascii?Q?Is1c8D0yuoCGpvc48O7FWT7fvKMvwm9nJX4XmoNcxu5KhFgpq5VQuEKJ10Rr?=
 =?us-ascii?Q?pC5dJCXV6cMQQGr2N9YWQ/ovn0gMGG0K4WP7xef8c/yuwKx0vnB+em25qNiH?=
 =?us-ascii?Q?4uixmlQIeY2ZiAZzK32RSrwUkMMjfXB73n54N55xcIHoPNaV4NJMC3SZerJu?=
 =?us-ascii?Q?h4z1JHEwei5UXjpFXPQFhwi5UdoiK4MAfJT7DHviGwcWkwqcF3RCL8bVDI20?=
 =?us-ascii?Q?/iWJc2emusEBoik3KCpcpFb5xUwAhIVF0ccT17KP/evG+tWaWme10q+Gr2rt?=
 =?us-ascii?Q?5O/O4m2uvZQiCfJ9ldd2sIlOgFBgoZG7D42d4ckyfpUCTRR3gR8+kdHXgA6A?=
 =?us-ascii?Q?rKZ7C2WELHORArY7WYS+jOi5mA9Fc76Ke9uM79jYW1NICY5hnkfWotNkEL9f?=
 =?us-ascii?Q?uL63mTwVMpEOgdVpaTeBN0n3ksYzlBTaWSiCBmNL/EgigvZJHng3Hqv0o2KC?=
 =?us-ascii?Q?UEyGOAh28Vck/s75kCuTDN1SRP4OntxLEwHsunRw/M3B4ZxwON60wkEgqPAs?=
 =?us-ascii?Q?cgS4adeIc7fvx7JC8O9axey2NYlR2H+UanrVfZY2lV/Z6S6dc/HgjedfuVlo?=
 =?us-ascii?Q?zGNn6imdY+feom6uO/YJSdthYwYX4kKb1uDRZzj5ZmrZfINzIoMORdCEKvVO?=
 =?us-ascii?Q?fjcjrPr2Fe7jYcrnJ5M4DNKgjGgsyVbOM1uLMes/jPs+pfKW/jZdo56fOQkc?=
 =?us-ascii?Q?CQntmus/REejm0SY/CGmIQ2EBCvWVon9iXBnDw9XGAb7WdUwCjzsaUkt1QS2?=
 =?us-ascii?Q?fs0Ak3jWeXj6pyNevrFDCmYRYzXdql6sIOCrLzWUxrlyW5LAEcdikwJ7jHwW?=
 =?us-ascii?Q?YPn819c5H7WjOnnFUXmcIb+mvdmtTjNMzCUGyjPgl69eII2ZK6CbBLG4gobv?=
 =?us-ascii?Q?kf9STZSHeurR2KHBoPgaEEWFVSFLz3pHIEMbZQMKAlPEZqhJrQyWiN66HolY?=
 =?us-ascii?Q?2mbx/CUkBqj0OGbvNSLNO3E3jMkLWijG4OVK2OWoF2M6Yc2tMOp8w2352aVX?=
 =?us-ascii?Q?AbMKPDgbh4cxOVpushlZi6hh+tplb1u+IIz3r72UnfwKJTbCanFfYlXRPAVR?=
 =?us-ascii?Q?zLWCkYUuM3oruqvXPBxyZ8TGpGbTQ5LxUmzdF7aacTvfjDXnHvNhg6nHLVDE?=
 =?us-ascii?Q?qFKECTuTyF1Y8yPkYrLVGnrrX0gB+Mox5JFHAY1wOh8/XPmP741r5TiSj1jJ?=
 =?us-ascii?Q?JKDA2bFqF3p4I/Z4vcHgG537Nk+iu0tygzjdxP9DqXpshHCYqFt3bbgM/WVo?=
 =?us-ascii?Q?EOV+Y9hQmZzWMR+Qti5Psa4INF5dQNU89PFQzmlmskEw6MkRYU+gz2BDOAEW?=
 =?us-ascii?Q?fivnpTMfgIHgK0tB7+4QNBdRUfPBecOZ8AP84bk9hOiH7PvJgXj7pC+epXwd?=
 =?us-ascii?Q?ySnqmmKJS5Jbwlk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 06:03:17.1655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f04d166-e47a-4478-19a6-08dd2897a795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

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



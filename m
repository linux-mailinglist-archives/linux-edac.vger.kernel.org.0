Return-Path: <linux-edac+bounces-5317-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 38425C304E1
	for <lists+linux-edac@lfdr.de>; Tue, 04 Nov 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261FA4E1372
	for <lists+linux-edac@lfdr.de>; Tue,  4 Nov 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3432D061C;
	Tue,  4 Nov 2025 09:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDCTOjVA"
X-Original-To: linux-edac@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028DD1552FD;
	Tue,  4 Nov 2025 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762249183; cv=fail; b=GdViZZDY//nQ+j9jVBowVLYaWmCWo1q+mwENJpfp0nIMZqY7/5M5AUjsRqnZzVhP5ls/vrRdffsEfEosUxhD6uWFhGbZyONSAkkUHP9tW7ZcLD1z5YQW6FFGr+cfbSqEB5FVe7lHP2uzONMhmIb9cQL2/qb+3nYW7nP7ucxb9R8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762249183; c=relaxed/simple;
	bh=9OfNaA9bNWhDvT8G0Ks/szNJjiPyCXiQVMRfteZpVTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uzUvZUQs6WXuQmW9BgyrErp0/uYg25d/JBSUCb+tTTGNLV2yzXYEl8Qtq2cJtw3GduTCVMlAcFALaTYIJYRrZETS6UrKmqTVlqWCtiIoG3OHhVJDuDl6+owlLt3gy+phnXB53mxq8/6EGDOZm4k3gxPFZix/HCDnT1x72+Fz86Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDCTOjVA; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr4UhkyC6KO4JwfRiHpu95xpOAK/ZsQBy7E+x4V0mUKaB15TIT+6r8fkLje2UtMWe5l2KPp+mJsF0mxk7LPPp68zFbT5npOd1i4dt0FTnSYTb0J5CxizKhrgAOjnZTvIFCCzLacDaLq2EZNGoxmoqn0T8Qbm9MzMRLmbLLwoPmG1ZC9zVJ3LYgoVyEyqgaCTPcvdwW0ctXL20KsBEyi/1E0dfFicwiP+3F+BtjlZTHAmAlgwprkaw1PyKDvoqJXjc7SMg1av+TYpW4akToRpWtGm08VxRKRCB9ip3j1UuW5QeF82BgxRb9+WzoWDhnX6blF/3ST9SysdEQqjvla95g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVvna/mChAdoIdgWXHicq/EgZy6Ty85q26+NcQsSevw=;
 b=wkGb7TBPvHgNTHFRRsk6PHEfh6wEPveDGJ3QACN4DPBP8Pf7KpHHxdzeJ71UBnRPfqTPR/wBwY+8W9TwDF5W5pigz6As1mV6hUVgVr4+ex8t2t5gAarClyKYwJrWtWAVUjJx7n4YbXipQ10z1LIDAyXOM0wWDMOfF3S+21EzV1y1wMhJmIy1Ox88FIqFlTdpkT8nlo/AuzbXoXmboh2aUsP1LpR5l0v8jnEOFWOIVOaQLL7sidb038jcJd6wMN5UZGR7W4smUiDDM6ZIGm8982NRk3dfrPwzzDMsGFVUPynHP68UYTWiRh/LhQIKc2Eil+LjON2sYfKCvtnTDCbtug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVvna/mChAdoIdgWXHicq/EgZy6Ty85q26+NcQsSevw=;
 b=uDCTOjVA4i62K8NGYcxPs82wdd3UR1aItx3bnhio0SJkX44A+xQVuc7ncMLuccltoUzNDBsy287GYJlrLm4cEWi4rM2Kmx0R+PtdkJPa+jdRtYxLXgpG5pQUOKC1zvSH5Wmx6bGnEfZmatvqbRwSLZj4Va6hQwbBkoVkNzEjRrc=
Received: from CH2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:5a::38)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 09:39:37 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:5a:cafe::b8) by CH2PR08CA0028.outlook.office365.com
 (2603:10b6:610:5a::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 09:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 09:39:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 4 Nov
 2025 01:39:36 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Nov
 2025 03:39:36 -0600
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 4 Nov 2025 01:39:33 -0800
From: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <shubhrajyoti.datta@gmail.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
	<tony.luck@intel.com>, James Morse <james.morse@arm.com>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, Robert Richter <rric@kernel.org>, "Shubhrajyoti
 Datta" <shubhrajyoti.datta@amd.com>
Subject: [PATCH v2] EDAC/versalnet: Refactor memory controller initialization and cleanup
Date: Tue, 4 Nov 2025 15:09:20 +0530
Message-ID: <20251104093932.3838876-1-shubhrajyoti.datta@amd.com>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: shubhrajyoti.datta@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 69564a0e-28ba-4654-89db-08de1b8611d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5TUOMQR1hl1xcuDE1H3DMxnvVb0g1oU7w7BPzpaVVWvVFai6r76Uyb4s0Exg?=
 =?us-ascii?Q?UbF68iEsed9XSt4Pk7nbeS8VLx8AdTulNmvyUkjLDRJ5cfEUfY8k0t/bmhFV?=
 =?us-ascii?Q?S2jq74sJF9frROqdU1wAbde+FTgzSR2tJ/TcbbuUAToFuDVlRNbdQ2Gyoo7+?=
 =?us-ascii?Q?cjChzyEgv9ZCZkOzwAiPk1l3mLQo32WQuAWKo2EAsyKOgOqtPCwgl1zeTb+k?=
 =?us-ascii?Q?W4cbKjbMhxNzVCTI99e/3fssoi205rADOtN1Uxux/jTqyGJ6CUjnF1pxZBHY?=
 =?us-ascii?Q?r1zUOiHkfkL7zkroyhHM2B7ig5l8uSDuRph00GeOLN4QBoN5P2KkEvPDso8q?=
 =?us-ascii?Q?7RxPeu2bEavZuAkiHRtbxjM2Y2YIImO+df9ZajOk3a/1py5UkBMJu/F2UuYA?=
 =?us-ascii?Q?+cOZRlgBt3YhMsOseT6fWB7/df91MRqrC5nQb29EXuVv0BDFRCHsWyYzd+kk?=
 =?us-ascii?Q?E/Ik3Fmc18sf2EFLbURLncKZVw0weucdtbj8KqOZNKysNe26XXQQiFhWgNYP?=
 =?us-ascii?Q?azkhpA32odsyBMia5e/7OwOfXPge4ShdjkG2JSiHdf1j5gJ3HD2kiow6rRxs?=
 =?us-ascii?Q?+SY9ZrNYB+HOlOd8LhFpxf61Houcdjli2uhMKpe7nhldmOJIcT4yOgGpXJrL?=
 =?us-ascii?Q?vGH70CkzMndEy0I88syUtVQFFg3YiUbAqAQ6VYMuQN9Wl1e6uJRFw8MGQpAN?=
 =?us-ascii?Q?jihnE0GvdYw4XiNjjhJPycT/Rh2R0Z13Cyri1ryHvirSgaBlPdvNy6wQxBjL?=
 =?us-ascii?Q?RPHfD/tfjZ2Kl7l4K8LjTE4IFxeypJ2IyI7VNAhfAgNFIFuNXp1RvB+JmNHI?=
 =?us-ascii?Q?BrOlyvOZu8dXRdb/T/acqLZEHpV/2XaYLBObn7uYdEqHSwTiqCXTRI9LCBnG?=
 =?us-ascii?Q?2Sx92RJROaD/d+0ozXQTvvsn7qegdU1ejg+ZeQUtvOEqqo9mYIkzBmBpVVik?=
 =?us-ascii?Q?ZkoBlslESxspAl6mB3aCA/5QHkvt3jsKOV1gJLbbNgtn+PPb6L0EDVkMZ7ko?=
 =?us-ascii?Q?oNIewf5Ywppm1kjQEaerJAbEbEqb6N+X7MgtLKpHWt+YUE5mMTi9+CMYuBom?=
 =?us-ascii?Q?y4XZgEmEqLysPwDkePhhUDagVMLdKi5kJ0tOh8vDQniK1AXdwt5nyw4Q3t6j?=
 =?us-ascii?Q?MG9iGws7NYFxGc9oz8UvjBKnD6ZC8PVnl7HRM8uHCCoc4o56omamwhpcK242?=
 =?us-ascii?Q?dOirpIkudNQwgxy4vO9V3hoDh8oMrdOiUlns3kvkmm/zsXqMM0e9DAdH+q55?=
 =?us-ascii?Q?iJ0tGUQinmr8bQT7oSDPqzOKY1WF1Kl1uNl0gqKORWqD3HJuUkXhuTsYuHex?=
 =?us-ascii?Q?eqP+KiGVAGmqYP/8kyqd1+gVhAbC2jypRm1lnxS2pKw+x38gRRCHhdoMfxZK?=
 =?us-ascii?Q?FWD292SW141HpZZYCj2lpeL66Ed77uWPCtijJSI3WbuAE+wPnqqZc4JDZVE7?=
 =?us-ascii?Q?H4V8ksGFyWiudYUNmM1hqqqf3YcGjfaObqNUWOXNoQlMiZ9J4xJmqlgC/it4?=
 =?us-ascii?Q?agUD2M2fqmYkq7j4bQR/KUbyWfR7hSwDH/qE2HJNgrmTVuIbpzluEPtDgeXS?=
 =?us-ascii?Q?5b6ZQAtiSrXnsNGD4QI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 09:39:37.1533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69564a0e-28ba-4654-89db-08de1b8611d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671

Simplify the initialization and cleanup flow for Versal Net DDRMC
controllers in the EDAC driver.

Introduce `init_single_versalnet()` for per-controller setup and
  `init_versalnet()` for looping through NUM_CONTROLLERS, also add
rollback logic to handle  partial init failures.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---

Changes in v2:
- Rename init_single_versalnet() to init_mc() for clarity.
- Rename remove_single_versalnet() to remove_mc() to match naming convention.
- Simplify error handling in init_versalnet() by replacing goto with a rollback loop.
- Reduce indentation and consolidate cleanup logic.

 drivers/edac/versalnet_edac.c | 156 ++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 73 deletions(-)

diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
index 1ded4c3f0213..01edc7408a5c 100644
--- a/drivers/edac/versalnet_edac.c
+++ b/drivers/edac/versalnet_edac.c
@@ -758,7 +758,17 @@ static void versal_edac_release(struct device *dev)
 	kfree(dev);
 }
 
-static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
+static void remove_mc(struct mc_priv *priv, int i)
+{
+	struct mem_ctl_info *mci;
+
+	mci = priv->mci[i];
+	device_unregister(mci->pdev);
+	edac_mc_del_mc(mci->pdev);
+	edac_mc_free(mci);
+}
+
+static int init_mc(struct mc_priv *priv, struct platform_device *pdev, int i)
 {
 	u32 num_chans, rank, dwidth, config;
 	struct edac_mc_layer layers[2];
@@ -766,87 +776,90 @@ static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
 	struct device *dev;
 	enum dev_type dt;
 	char *name;
-	int rc, i;
-
-	for (i = 0; i < NUM_CONTROLLERS; i++) {
-		config = priv->adec[CONF + i * ADEC_NUM];
-		num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
-		rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
-		dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
-
-		switch (dwidth) {
-		case XDDR5_BUS_WIDTH_16:
-			dt = DEV_X16;
-			break;
-		case XDDR5_BUS_WIDTH_32:
-			dt = DEV_X32;
-			break;
-		case XDDR5_BUS_WIDTH_64:
-			dt = DEV_X64;
-			break;
-		default:
-			dt = DEV_UNKNOWN;
-		}
+	int rc;
 
-		if (dt == DEV_UNKNOWN)
-			continue;
+	config = priv->adec[CONF + i * ADEC_NUM];
+	num_chans = FIELD_GET(MC5_NUM_CHANS_MASK, config);
+	rank = 1 << FIELD_GET(MC5_RANK_MASK, config);
+	dwidth = FIELD_GET(MC5_BUS_WIDTH_MASK, config);
+
+	switch (dwidth) {
+	case XDDR5_BUS_WIDTH_16:
+		dt = DEV_X16;
+		break;
+	case XDDR5_BUS_WIDTH_32:
+		dt = DEV_X32;
+		break;
+	case XDDR5_BUS_WIDTH_64:
+		dt = DEV_X64;
+		break;
+	default:
+		dt = DEV_UNKNOWN;
+	}
 
-		/* Find the first enabled device and register that one. */
-		layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
-		layers[0].size = rank;
-		layers[0].is_virt_csrow = true;
-		layers[1].type = EDAC_MC_LAYER_CHANNEL;
-		layers[1].size = num_chans;
-		layers[1].is_virt_csrow = false;
+	if (dt == DEV_UNKNOWN)
+		return 0;
 
-		rc = -ENOMEM;
-		mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
-				    sizeof(struct mc_priv));
-		if (!mci) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
-			goto err_alloc;
-		}
+	/* Find the first enabled device and register that one. */
+	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
+	layers[0].size = rank;
+	layers[0].is_virt_csrow = true;
+	layers[1].type = EDAC_MC_LAYER_CHANNEL;
+	layers[1].size = num_chans;
+	layers[1].is_virt_csrow = false;
+
+	rc = -ENOMEM;
+	mci = edac_mc_alloc(i, ARRAY_SIZE(layers), layers,
+			    sizeof(struct mc_priv));
+	if (!mci) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed memory allocation for MC%d\n", i);
+		return rc;
+	}
+	priv->mci[i] = mci;
+	priv->dwidth = dt;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		goto err_mc_free;
+	dev->release = versal_edac_release;
+	name = kmalloc(32, GFP_KERNEL);
+	sprintf(name, "versal-net-ddrmc5-edac-%d", i);
+	dev->init_name = name;
+	rc = device_register(dev);
+	if (rc)
+		goto err_mc_free;
 
-		priv->mci[i] = mci;
-		priv->dwidth = dt;
+	mci->pdev = dev;
 
-		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-		dev->release = versal_edac_release;
-		name = kmalloc(32, GFP_KERNEL);
-		sprintf(name, "versal-net-ddrmc5-edac-%d", i);
-		dev->init_name = name;
-		rc = device_register(dev);
-		if (rc)
-			goto err_alloc;
+	platform_set_drvdata(pdev, priv);
 
-		mci->pdev = dev;
+	mc_init(mci, dev);
+	rc = edac_mc_add_mc(mci);
+	if (rc) {
+		edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
+		goto err_unreg;
+	}
+	return 0;
+err_unreg:
+	device_unregister(mci->pdev);
+err_mc_free:
+	edac_mc_free(mci);
+	return rc;
+}
 
-		platform_set_drvdata(pdev, priv);
+static int init_versalnet(struct mc_priv *priv, struct platform_device *pdev)
+{
+	int rc, i;
 
-		mc_init(mci, dev);
-		rc = edac_mc_add_mc(mci);
+	for (i = 0; i < NUM_CONTROLLERS; i++) {
+		rc = init_mc(priv, pdev, i);
 		if (rc) {
-			edac_printk(KERN_ERR, EDAC_MC, "Failed to register MC%d with EDAC core\n", i);
-			goto err_alloc;
+			while (i--)
+				remove_mc(priv, i);
+			return rc;
 		}
 	}
 	return 0;
-
-err_alloc:
-	while (i--) {
-		mci = priv->mci[i];
-		if (!mci)
-			continue;
-
-		if (mci->pdev) {
-			device_unregister(mci->pdev);
-			edac_mc_del_mc(mci->pdev);
-		}
-
-		edac_mc_free(mci);
-	}
-
-	return rc;
 }
 
 static void remove_versalnet(struct mc_priv *priv)
@@ -857,9 +870,6 @@ static void remove_versalnet(struct mc_priv *priv)
 	for (i = 0; i < NUM_CONTROLLERS; i++) {
 		device_unregister(priv->mci[i]->pdev);
 		mci = edac_mc_del_mc(priv->mci[i]->pdev);
-		if (!mci)
-			return;
-
 		edac_mc_free(mci);
 	}
 }
-- 
2.34.1



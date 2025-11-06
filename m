Return-Path: <linux-edac+bounces-5353-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE4C38C53
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 02:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70B5F4EFDD0
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 01:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0177F23AB95;
	Thu,  6 Nov 2025 01:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vCcuyRZ+"
X-Original-To: linux-edac@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692A2223DE7;
	Thu,  6 Nov 2025 01:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394293; cv=fail; b=lOUIO4PouUFgLraBv4Je7XpP2xkoP7vzWcUdFIDq98wdetUdZw5f0GSiVRY6bAFN8t2ocE++1Fhd+D53hS0HLA22QPv1gntjgTnorBcbwJfaPDHvMniKl+o6fnP4BQYCQkd11zhQXN5oV2bzySRm+UG0XO/yYp8kfk/pFWhMyWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394293; c=relaxed/simple;
	bh=ukcBiMPnSSNdpv8r09MLpqlK7gApSWRur6F7hrnlUGM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h6xgojhrQkGvjj+jn4xIIWtxLr7L/m8cldXEEmeMa8A07Mgwuvzi6qISfodFXe9+9oT60Ul9l6LX2JEuTzxayXob1MjA7sbiLgFz/UF/I/6mvD8W9+OP0CUrfaRFHog3qJ1L6rmpFZZX8BSA6Ws4zcYAfoSbEkRMkE6KOM2shcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vCcuyRZ+; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4uFv4jkMKj6KnrxKIzb7zuVEal40juYJ4zpyfyQA6iAUChCkSPT56JGetDgkCGMxIstuYfO3wi5Xyc0SQET0u+RAmrnBwH1sAKlFC/J+3PB2tB6vdL5mejDzkQJj78uPZL+3yJSiA/czusp41A1FGWq+r3393vYhfnIbBfV6Uip04rBQjavBlMJt8vdWjGg8h+mhLtC0yV9F1EdV1Z5VUC8ERD+cMC0yX/Rwi6SrIl6vbWzHNIdXVr+ILA/EIfYKm9e0UMDyzgC5woeH+6GeZokia6Eu9qaP2BVrInnln55b7zwqYXu3jOnO8NGLJvQU6bjCAw/aFELs0zLoeCD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQixXkCQ3sE2uZG9qdOUmFOpIl8zK/eUoHx2xVxh+ak=;
 b=dSdBnxFhqWK5E4zD/TKg6YPGtwHG5jYO/METPJcfxN4VNv3526hrZq8l4YwatD8x4ldN8bc0UIVwEoDGi9afNEDqJix7o1Zwr+AfQlg9VD9CPUzxPpT8l/feYCyygyxhk5o0vCGg7uDAnsARM8mi3CUUh/b86MrJVl11HgjPBBV6p/uS3ceMf6lVICfZw93IX7sAZ74SYzpAcX3m2RJFpPbadRfRadJvMpqbL6NZVJ0b0mYlf86lXp2XSVA7owHw3tKzTeGjduG3A5QUNGJYRSb6GbTqIzdsuYtkSa5AmOAKzFKHF6FMDHHUBq/WHMlxc2vD8e/jL81HGi4g5AG1aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQixXkCQ3sE2uZG9qdOUmFOpIl8zK/eUoHx2xVxh+ak=;
 b=vCcuyRZ+7qHPZnS+0g+U1Dn5wTDQx+VaqDKPZphICT45mKoj5Ym2Mwf0RSfh2ZKoeAPps+gV/CLO/mTyN3AmrmbDeL6ADyxKQeMuz7/OQN+JJH6m4bGmtHB1M3Huj4KiRUCYDy575VsRVamKrN5+CRsNrWe369YNPs73u0zhlb8=
Received: from BY5PR04CA0022.namprd04.prod.outlook.com (2603:10b6:a03:1d0::32)
 by SN7PR12MB6741.namprd12.prod.outlook.com (2603:10b6:806:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 01:58:06 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::e) by BY5PR04CA0022.outlook.office365.com
 (2603:10b6:a03:1d0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Thu, 6
 Nov 2025 01:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 01:58:05 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 5 Nov 2025 17:58:00 -0800
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-edac@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <bp@alien8.de>, <gregkh@linuxfoundation.org>, <corbet@lwn.net>,
	<chenhuacai@kernel.org>, <mchehab+huawei@kernel.org>,
	<yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
	<avadhut.naik@amd.com>
Subject: [PATCH v2 2/3] EDAC/amd64: Remove NUM_CONTROLLERS macro
Date: Thu, 6 Nov 2025 01:54:45 +0000
Message-ID: <20251106015727.1987246-3-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251106015727.1987246-1-avadhut.naik@amd.com>
References: <20251106015727.1987246-1-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SN7PR12MB6741:EE_
X-MS-Office365-Filtering-Correlation-Id: 277d7889-e52c-44fc-3d50-08de1cd7ed4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YryYJQMFzW3B1XVQb88pegdajAF8k2E5JbHpTMMxKqnfpEdb4RRjul7c8pBT?=
 =?us-ascii?Q?h/HusqF26QTprHRyghjSL05K14Jhd8IEQs5UhfC+mBuidTyeF+aE1Z2ZEuQZ?=
 =?us-ascii?Q?oS17w69QRsxtikjieY909jOO0J0nZlLbByXIg30YVVuaCEewQ+9dI5HOy2w5?=
 =?us-ascii?Q?Hj3UNBRCLPHpaGgaCn64GpnA031r8nwyBddKT1spqm4Q6Uy8LSfovtW8mi36?=
 =?us-ascii?Q?tHOFtrUSjTzOf9RjE1m62YDqY6iYGH/ZjmtHxa0qKDSNRzvBi1opaN/zNPBi?=
 =?us-ascii?Q?wmi4ruoNfSwChNYA0REeJtib6fdKj4LvI4xhJw0ws1lTvO8/keQg5SIr/MRt?=
 =?us-ascii?Q?qLY+ziTGttGHf6UBJPbLNpYRpeLuJ3pTyQWslQVPU6Ilp7G70UmMpTl+t8uS?=
 =?us-ascii?Q?RpKCmVqIpVYpQWEa9KkT63oa31T4TSSWEeQrP/wmNZuVVgwx6dnzb2dbjsL+?=
 =?us-ascii?Q?ko/cvHyGDeChCfEOXYzpVqWrE+XXC/WD4hZBzlVWe8+q/PKlKWsfb2yWVbDG?=
 =?us-ascii?Q?pmacZL+N4MFQFw6FPoRuEr9bCXMZMYb23HAg2cVh0OlMkLuqmaj68Qj86TEX?=
 =?us-ascii?Q?xGl33nEYGC3hIIKuvJBbM4pn5+0sW1LY22aMeSKOA9YAp5FDOVkArKOk4JGq?=
 =?us-ascii?Q?m9eqBL+y6ClZ3X/iKEoIukTyHl84VaxcOg61OdwmSKMOCPGIjGOUJjAV3iuo?=
 =?us-ascii?Q?mmpd1jpDXI3nwCTPhH7lj160/ULGItKejd1HxCKKoIm+vIZhsmWavNj5BJnB?=
 =?us-ascii?Q?XRTicoTkQebXF+XThAl7JGI2ea9oStQ7xuCAwPF5RmoCpQQxSmRsAvpQluU4?=
 =?us-ascii?Q?Tx+lc3SZfGHV0ruipBz3auZGv+xBNOKwj/2pgDvLE/vQ57hGqTjkyY6NhNId?=
 =?us-ascii?Q?26EC9L+QX5i059yJ34Oz26UMpbNLwCFVL1SKU6ysH6HhqkwyTveDKoesMxIH?=
 =?us-ascii?Q?jpLDtyQ06h+wR4pLxPI/XEkGEf9H+kOhCqH+/9lgqli+0rYwnjE/FrM30kLp?=
 =?us-ascii?Q?rHGWJVOLzDXwGk2Yc1JXAWC9LQv9BQr2dOf5sR/70H/iunHOKy1Yeqq51Gih?=
 =?us-ascii?Q?7+1CGC+e20aSM1E2DtZkJUgYDKpJ7yq4aPWbJHLmK74WdNA/hraU3QH0Xi5q?=
 =?us-ascii?Q?U1q/7tvaPhoisdJNvNv0oi87asDhbg4wNM21CRtx4j/zyh9Ra0KW66fQEc3u?=
 =?us-ascii?Q?eIaUt0Ye8Ip90ofOVPejH1I86XjYHiXRTlMXotJH0IDx9/iGI2YI/3Ffuda2?=
 =?us-ascii?Q?PmDvDTnYdi+jox8weBelAzHtJU77+6a8lyeltTDXu87cnlUWGPniiJyhlFsC?=
 =?us-ascii?Q?yUyUE1dDhZcnJIbC4fCk1/3D7yML8KR7x24Xpv3bTDEcniA/ib/oYHy6hzMJ?=
 =?us-ascii?Q?lJHKfwIRq4tLI6ADZuqsgQJZ+5bFB+DrbsF447bxxlOkaAzmEl07rrS00xV2?=
 =?us-ascii?Q?MCWYs+gx8l4URtmvMZUZ2WYbcKh4/0pVx7fEn00WvFNCCyOe5OfqcTazVKSn?=
 =?us-ascii?Q?eMaE92VJWv5oRT/hcTB5qUyovfI9Rfo0J/ftxs4FOWSh81pNH0c+TAK9U022?=
 =?us-ascii?Q?7dXrsm31/oMeMJI/qK4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 01:58:05.6795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 277d7889-e52c-44fc-3d50-08de1cd7ed4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6741

Currently, the NUM_CONTROLLERS macro is used to limit the amount of
memory controllers (UMCs) available per node.

The number of UMCs available per node, however, is already cached by
the max_mcs variable of struct amd64_pvt. Allocate the relevant data
structures dynamically using the variable instead of static allocation
through the macro.

The max_mcs variable is used for legacy systems too. These systems have
a max of 2 controllers. Since the default value of max_mcs, set in
per_family_init(), is 2, these legacy systems are also covered by this
change.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 drivers/edac/amd64_edac.c | 5 +++++
 drivers/edac/amd64_edac.h | 3 +--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 886ad075d222..2391f3469961 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3732,6 +3732,7 @@ static void hw_info_put(struct amd64_pvt *pvt)
 	pci_dev_put(pvt->F1);
 	pci_dev_put(pvt->F2);
 	kfree(pvt->umc);
+	kfree(pvt->csels);
 }
 
 static struct low_ops umc_ops = {
@@ -3915,6 +3916,10 @@ static int per_family_init(struct amd64_pvt *pvt)
 		scnprintf(pvt->ctl_name, sizeof(pvt->ctl_name), "F%02Xh_M%02Xh",
 			  pvt->fam, pvt->model);
 
+	pvt->csels = kcalloc(pvt->max_mcs, sizeof(*pvt->csels), GFP_KERNEL);
+	if (!pvt->csels)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4ec6133d5179..1757c1b99fc8 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,6 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			16
 
 #define ON true
 #define OFF false
@@ -348,7 +347,7 @@ struct amd64_pvt {
 	u32 dbam1;		/* DRAM Base Address Mapping reg for DCT1 */
 
 	/* one for each DCT/UMC */
-	struct chip_select csels[NUM_CONTROLLERS];
+	struct chip_select *csels;
 
 	/* DRAM base and limit pairs F1x[78,70,68,60,58,50,48,40] */
 	struct dram_range ranges[DRAM_RANGES];
-- 
2.43.0



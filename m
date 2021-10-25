Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F243994F
	for <lists+linux-edac@lfdr.de>; Mon, 25 Oct 2021 16:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbhJYOyV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Oct 2021 10:54:21 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:20513
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230268AbhJYOyU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Oct 2021 10:54:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3/iAoyiR+SWt5gHFguci/amgyHxLXXk3F4ojno4XN+1lyK4J/uJ3yd3v200elADVaRaCStFWa+DKUNhOhhtzC46p7CnC+w9Ha3JFBlMnKNz5cOMInX+G8NIAkrCQmbFQPv3TzSR/BvJJwOg7Vyw02xGUdcAHZ9DHQfgFevDmFm+CB/lCslgd7oo0obSEullYsozmWA0k6XcVVvAIUD2nrhhAvAiadmphrSpcYI47zivTvH3TP7KU3W8UM1o+sB7FlyoNd4devfJcUeFpuvaPaW7LyfluYdedBN+u5JK2BluG4q59EMPXb2S7FWaoIg7xVYQ4xsiiq560pKpgSz9NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xpvzbhnMDElmRe5eozH9wLPcTmTjyvWs3lucvykm5s=;
 b=Qbtzw6eGEtH4hxzw7feCNh8bGtFGIuBdfVX7rObViVAo0r5nqK5rMLFQSl8qbqv6F2FJtmf/HPBDgsUIkgRcshjRN2xwxAzROL6+Kpy6l5Q7FYdsT65JLDuwU+Ui/7uSp23vN65jP5Fe0rQBFHzo2nqKndePVJRQKe6L8SC0nQ277ihiW84jZy2lY8Fv8si2Qtp0q/HWijVd3anVYZmwJca5C/7OTEk0uUb8xCdVNnxXBmZHnpyW5MiTLZQs+pTEqGrNajmyozxMZpw0R0RD+BbZaMOXC2Xbe3jEZZB1n6GpORkrbW441itJtiY8rHgQq5z5tyTz1wkl5dYXF08hWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xpvzbhnMDElmRe5eozH9wLPcTmTjyvWs3lucvykm5s=;
 b=C5Ro2rNwdwGcMCWZ18nfx8Tc2XRVHjydynHDJ/JQeZSfsQGhv8XvYtnEsugdoHIKIHApBaAmlWYbigo0+YKBjC7RBQKeAEDH0YsQRVJolIdEh8ycO3044WkzqGgXfCsg91UHDW/gI/46yWBTZBVR8UauAkTOPyZCFoGx9oF6SzA=
Received: from MW4PR04CA0272.namprd04.prod.outlook.com (2603:10b6:303:89::7)
 by BN6PR12MB1873.namprd12.prod.outlook.com (2603:10b6:404:102::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Mon, 25 Oct
 2021 14:51:53 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::ab) by MW4PR04CA0272.outlook.office365.com
 (2603:10b6:303:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Mon, 25 Oct 2021 14:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Mon, 25 Oct 2021 14:51:52 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 25 Oct
 2021 09:51:48 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v5 4/5] EDAC/amd64: Move struct fam_type into amd64_pvt structure
Date:   Mon, 25 Oct 2021 20:20:17 +0530
Message-ID: <20211025145018.29985-5-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211025145018.29985-1-nchatrad@amd.com>
References: <20211025145018.29985-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c3f38f5-24b5-4331-fce8-08d997c6fb6e
X-MS-TrafficTypeDiagnostic: BN6PR12MB1873:
X-Microsoft-Antispam-PRVS: <BN6PR12MB187316A58360ABB0D001C745E8839@BN6PR12MB1873.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tUcJrAnGGaR2WGNfGmKTKGXU2xkM5hUCFK50dQOweGwgMED2+hMqBKw0Zn7pk4XV+Don3AfVvBJtVh6c6etOIIAB9ZK/Sr7I/TsL2X2rv3LhHVGcOKedx/xvhwaP50OnQjyHPXiur/x9xkXH7oXUEv0wrrBqa2JFO7DIO4xJhSXD5M17iUTCIO4Up39FZkJGUzoxD7RJNLT0Gyr9QUdl7TElNzU8R6uCrZZDGkSNQsQ5GFrFX0LJdEFebQXvTYCxmcOk1VSAvp9M70+gSPtU9PnAIJUJd8FVPgDOknDVkLyem5AJslrFd7U9Bz1mGTp8JAaJuMf44p2ljxE+ux/CllK0CRQyUQFvGW8luaDhA3a66xN4nub2P2p0cWp5J7NM3M+ddjj5HjYe52F87V4yuC8W7wMswYmKgMUyyP+78vKU81OiRA3Ox4gOyIZHHt1JKo0zp0bJRvqbFLEMPQ7RjofqA16aoIf2qQ+MxsxeUoXlc7duFdXOfgXq3sokwQYGwI26VhNVgDRgzI2cF7RM7wuXp115gjyVyx9soMTny6kZwxTrDG4vE3AoC57F1wBI+3rgqY0GECOQ/wtLxlLj8RADRVX1Idtst+bfoUkH/YPjupwQz6t4OypoHsLdHQ4Yo8Ob8cmjbbHwjCQc+g2+3Qm9hcY+mVGKajmQlz8bH4MKSq4dNyAUDZHRoD7jAYDiql+/fotgoJN4tHD3hvUoQVQ0lIlUwApZ4wnjZqDnIiU=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6666004)(4326008)(70586007)(70206006)(36860700001)(8676002)(2906002)(426003)(1076003)(81166007)(8936002)(16526019)(83380400001)(336012)(54906003)(356005)(5660300002)(47076005)(316002)(7696005)(508600001)(36756003)(186003)(82310400003)(2616005)(26005)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 14:51:52.5870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c3f38f5-24b5-4331-fce8-08d997c6fb6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1873
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On heterogeneous systems, the GPU nodes are probed after the CPU
nodes and will overwrites the family type set by CPU nodes.

Moving struct fam_type to struct amd64_pvt, instead of using fam_type
as a global variable.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Changes since v4:
New patch, created based on a comment.

 drivers/edac/amd64_edac.c | 58 +++++++++++++++++++--------------------
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 88d38dbb4e7e..fbb1284f3c18 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -13,8 +13,6 @@ module_param(ecc_enable_override, int, 0644);
 
 static struct msr __percpu *msrs;
 
-static struct amd64_family_type *fam_type;
-
 /* Per-node stuff */
 static struct ecc_settings **ecc_stngs;
 
@@ -448,7 +446,7 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt, int csrow, u8 dct,
 	for (i = 0; i < pvt->csels[dct].m_cnt; i++)
 
 #define for_each_umc(i) \
-	for (i = 0; i < fam_type->max_mcs; i++)
+	for (i = 0; i < pvt->fam_type->max_mcs; i++)
 
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Return the
@@ -3637,7 +3635,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-	mci->ctl_name		= fam_type->ctl_name;
+	mci->ctl_name		= pvt->fam_type->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
@@ -3658,64 +3656,64 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
 	switch (pvt->fam) {
 	case 0xf:
-		fam_type	= &family_types[K8_CPUS];
+		pvt->fam_type	= &family_types[K8_CPUS];
 		pvt->ops	= &family_types[K8_CPUS].ops;
 		break;
 
 	case 0x10:
-		fam_type	= &family_types[F10_CPUS];
+		pvt->fam_type	= &family_types[F10_CPUS];
 		pvt->ops	= &family_types[F10_CPUS].ops;
 		break;
 
 	case 0x15:
 		if (pvt->model == 0x30) {
-			fam_type = &family_types[F15_M30H_CPUS];
+			pvt->fam_type = &family_types[F15_M30H_CPUS];
 			pvt->ops = &family_types[F15_M30H_CPUS].ops;
 			break;
 		} else if (pvt->model == 0x60) {
-			fam_type = &family_types[F15_M60H_CPUS];
+			pvt->fam_type = &family_types[F15_M60H_CPUS];
 			pvt->ops = &family_types[F15_M60H_CPUS].ops;
 			break;
 		/* Richland is only client */
 		} else if (pvt->model == 0x13) {
 			return NULL;
 		} else {
-			fam_type	= &family_types[F15_CPUS];
+			pvt->fam_type	= &family_types[F15_CPUS];
 			pvt->ops	= &family_types[F15_CPUS].ops;
 		}
 		break;
 
 	case 0x16:
 		if (pvt->model == 0x30) {
-			fam_type = &family_types[F16_M30H_CPUS];
+			pvt->fam_type = &family_types[F16_M30H_CPUS];
 			pvt->ops = &family_types[F16_M30H_CPUS].ops;
 			break;
 		}
-		fam_type	= &family_types[F16_CPUS];
+		pvt->fam_type	= &family_types[F16_CPUS];
 		pvt->ops	= &family_types[F16_CPUS].ops;
 		break;
 
 	case 0x17:
 		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M10H_CPUS];
+			pvt->fam_type = &family_types[F17_M10H_CPUS];
 			pvt->ops = &family_types[F17_M10H_CPUS].ops;
 			break;
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
-			fam_type = &family_types[F17_M30H_CPUS];
+			pvt->fam_type = &family_types[F17_M30H_CPUS];
 			pvt->ops = &family_types[F17_M30H_CPUS].ops;
 			break;
 		} else if (pvt->model >= 0x60 && pvt->model <= 0x6f) {
-			fam_type = &family_types[F17_M60H_CPUS];
+			pvt->fam_type = &family_types[F17_M60H_CPUS];
 			pvt->ops = &family_types[F17_M60H_CPUS].ops;
 			break;
 		} else if (pvt->model >= 0x70 && pvt->model <= 0x7f) {
-			fam_type = &family_types[F17_M70H_CPUS];
+			pvt->fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			break;
 		}
 		fallthrough;
 	case 0x18:
-		fam_type	= &family_types[F17_CPUS];
+		pvt->fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
 
 		if (pvt->fam == 0x18)
@@ -3724,12 +3722,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
 	case 0x19:
 		if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
-			fam_type = &family_types[F17_M70H_CPUS];
+			pvt->fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
-			fam_type->ctl_name = "F19h_M20h";
+			pvt->fam_type->ctl_name = "F19h_M20h";
 			break;
 		}
-		fam_type	= &family_types[F19_CPUS];
+		pvt->fam_type	= &family_types[F19_CPUS];
 		pvt->ops	= &family_types[F19_CPUS].ops;
 		family_types[F19_CPUS].ctl_name = "F19h";
 		break;
@@ -3753,7 +3751,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		return NULL;
 	}
 
-	return fam_type;
+	return pvt->fam_type;
 }
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
@@ -3770,15 +3768,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
 	int ret;
 
 	if (pvt->fam >= 0x17) {
-		pvt->umc = kcalloc(fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc = kcalloc(pvt->fam_type->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc)
 			return -ENOMEM;
 
-		pci_id1 = fam_type->f0_id;
-		pci_id2 = fam_type->f6_id;
+		pci_id1 = pvt->fam_type->f0_id;
+		pci_id2 = pvt->fam_type->f6_id;
 	} else {
-		pci_id1 = fam_type->f1_id;
-		pci_id2 = fam_type->f2_id;
+		pci_id1 = pvt->fam_type->f1_id;
+		pci_id2 = pvt->fam_type->f2_id;
 	}
 
 	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
@@ -3824,7 +3822,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->fam_type->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -3854,7 +3852,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
 	bool cs_enabled = false;
 	int cs = 0, dct = 0;
 
-	for (dct = 0; dct < fam_type->max_mcs; dct++) {
+	for (dct = 0; dct < pvt->fam_type->max_mcs; dct++) {
 		for_each_chip_select(cs, dct, pvt)
 			cs_enabled |= csrow_enabled(cs, dct, pvt);
 	}
@@ -3884,8 +3882,8 @@ static int probe_one_instance(unsigned int nid)
 	pvt->F3 = F3;
 
 	ret = -ENODEV;
-	fam_type = per_family_init(pvt);
-	if (!fam_type)
+	pvt->fam_type = per_family_init(pvt);
+	if (!pvt->fam_type)
 		goto err_enable;
 
 	ret = hw_info_get(pvt);
@@ -3924,7 +3922,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
+	amd64_info("%s %sdetected (node %d).\n", pvt->fam_type->ctl_name,
 		     (pvt->fam == 0xf ?
 				(pvt->ext_model >= K8_REV_F  ? "revF or later "
 							     : "revE or earlier ")
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index c7aeb2c46dc3..d307df58ea1b 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -389,6 +389,8 @@ struct amd64_pvt {
 	enum mem_type dram_type;
 
 	struct amd64_umc *umc;	/* UMC registers */
+
+	struct amd64_family_type *fam_type;
 };
 
 enum err_codes {
-- 
2.25.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2DE43E18A
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 15:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhJ1NE3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 09:04:29 -0400
Received: from mail-sn1anam02on2048.outbound.protection.outlook.com ([40.107.96.48]:62329
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230367AbhJ1NE2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 09:04:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvFuAt7KajztsTuY4h2GGWpThDqFQLB4IuEyHbdm7Xp08UjnaGs0zxD6NsDcOr2VhRK3MYEXDkjctT7PCPSNDNUObwEypwvdsgpYKLwtRdy21uYlvsXMi42buVnzel0dGCsXmxCw6t3l+7hiSYE43mgDq6dcYSp1fB9FtXHv9joGOfFRFkjKmxpOeS6zMTKb2LnnQ7f7Lp/o6Z1u/pUlwOr4i1lzNWN0cKvGU2pAGlz1BySR4dzdxbLF+mmp9APisaXcK6Y8LpZi3Z87WD4cJ1HrGQ4n0UA6wEz5X4h1UA+9QfogxeNsOzEDCrbkznn0FubHlZMMPkUd1igcpsvilQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t4AcguaiLZlimooZ9MM2RsSUWJ444qGR9PtGTbvK/U=;
 b=mvYwrOGOF5k+c4ACpp5+pLsToO3UkaPxWIJc8C7wy/X2uLkUBj8nQm51QgVetyfE0BJt+0ekuJBJAPflbfUwy2TsxnIoECADkElP9a5E5hIOlmNxX5ezyxZy921FiYKUTJuZWnL0KV7jnVtqZ01NutbO491wnep+DRWF/IlOjUV1+Yol0isfMVY3LbDFs0tyUeCJFFdHkkBl26gs+kMFb8e7XBY4APj4or0J+r4wU9n6xW05nvmV8cj4o1CeG6OiucePB5h5ETEq9SQfstpyIo9GydSF8OKD62sDhAvVaK+lKQyQSTXCQqwKmF6t3x86GhbJOaH2DCxIZWpwYWp5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2t4AcguaiLZlimooZ9MM2RsSUWJ444qGR9PtGTbvK/U=;
 b=uc/GOhpJI4xbV++3NKSHSKupKIpgbjY91pM1qiLmRvBUcD10nyxmTaJ6dwl7T7vclwovVqh6OXy8imb3+iW0bwDarxgBgvFABw2zgt1yqN20UiJHRKqFKZA5tofmwM+DS5i2QVBS/Aekocg9OGsSvwrO4AqpjWiTiaOMXs1SDuY=
Received: from DM5PR06CA0085.namprd06.prod.outlook.com (2603:10b6:3:4::23) by
 DM6PR12MB4530.namprd12.prod.outlook.com (2603:10b6:5:2aa::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.14; Thu, 28 Oct 2021 13:01:59 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::a7) by DM5PR06CA0085.outlook.office365.com
 (2603:10b6:3:4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 13:01:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 13:01:58 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 08:01:55 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v6 4/5] EDAC/amd64: Move struct fam_type into amd64_pvt structure
Date:   Thu, 28 Oct 2021 18:31:05 +0530
Message-ID: <20211028130106.15701-5-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211028130106.15701-1-nchatrad@amd.com>
References: <20211028130106.15701-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2777e88-f8c5-43f7-1526-08d99a132068
X-MS-TrafficTypeDiagnostic: DM6PR12MB4530:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4530CD5E36CAC7B6FA4A1AABE8869@DM6PR12MB4530.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:580;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qiWoOMQlUzpd4tChVe1N7+dka3vO5dAxcL4H4VObC2gtrl2VHljnVSndHc6l/kGkMRvI9C70GO8s/kfduCZrINV1OhbhmzJiHx3W/ch7uoL02r+egBh8V+PLfbXpU55vrfPHSitMu7nWmziCoaCpvT10RB5or6JHR8N4cO0HIh18ejSKQDVwMQywvVVvO1GphRWgW+7uV9aOK3jEhcrln5dUKDeu6ePKPWqagaldVKUnpVKkf0KjpXAAX98iujPVRFBbiH6+sHDbgxNX+lMjih7wBLlYYjtO7PVwoI8xr6TpOUABlbquEnNu39s0InbfNmoTR2dgpowEoLXXv/d/THtbiJPtZR2OnfIXPz35pwlJ4KqL+MmaDjQVXjoPNrH67uMRg10bmWYo4EG1UBiY3AMKjBEYUh+BGBulvlqfpncK+LrcNoaACoNGUU1+l0f7lLDji/h2ZQxGSP60jmpI2AhE1gcWKGe7j7xpT9L8OAFd8IUTHD2drLrAYBdpQITWXoYR98d2FjFQHIA3A9nRrEqs43MEw/zYuidsyohv9tZvkb5lXiEfLGhzosf1kXxTVzLHIdEdOCooaGRs+fbVaUxFBLwpD5HCWEdsJKuXftCxTjem5BRPhfsTQZRbPFrAHrNJUVrC7FYnqBDupxAZbicSJrS3pdngejxWLuW11tmZjOvaf3xkbnH2aMRgls7KmutawddsA5PEkWHo1zFFKNLPuOBtU8VBF12nHgQFS4uJW4Xkj6V+EVm4TfgOhd1UmWmGFA7Pcp84kgyaW8KhDdpC5Oe0m98vE397I/UWnf8ArQH/nVJ5OXg5taxVmCsr
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(70586007)(186003)(16526019)(26005)(36860700001)(336012)(110136005)(70206006)(36756003)(54906003)(2616005)(47076005)(8936002)(83380400001)(966005)(1076003)(426003)(5660300002)(508600001)(356005)(8676002)(81166007)(4326008)(82310400003)(6666004)(2906002)(316002)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 13:01:58.7384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2777e88-f8c5-43f7-1526-08d99a132068
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4530
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
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20211025145018.29985-5-nchatrad@amd.com
---
Changes since v5:
Added reviewed by Yazen

Changes since v4:
New patch, created based on a comment.

 drivers/edac/amd64_edac.c | 58 +++++++++++++++++++--------------------
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1029fe84ba2e..7953ffe9d547 100644
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
@@ -3635,7 +3633,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
-	mci->ctl_name		= fam_type->ctl_name;
+	mci->ctl_name		= pvt->fam_type->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
@@ -3656,64 +3654,64 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
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
@@ -3722,12 +3720,12 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 
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
@@ -3752,7 +3750,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		return NULL;
 	}
 
-	return fam_type;
+	return pvt->fam_type;
 }
 
 static const struct attribute_group *amd64_edac_attr_groups[] = {
@@ -3769,15 +3767,15 @@ static int hw_info_get(struct amd64_pvt *pvt)
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
@@ -3832,7 +3830,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	 * only one channel. Also, this simplifies handling later for the price
 	 * of a couple of KBs tops.
 	 */
-	layers[1].size = fam_type->max_mcs;
+	layers[1].size = pvt->fam_type->max_mcs;
 	layers[1].is_virt_csrow = false;
 
 	mci = edac_mc_alloc(pvt->mc_node_id, ARRAY_SIZE(layers), layers, 0);
@@ -3862,7 +3860,7 @@ static bool instance_has_memory(struct amd64_pvt *pvt)
 	bool cs_enabled = false;
 	int cs = 0, dct = 0;
 
-	for (dct = 0; dct < fam_type->max_mcs; dct++) {
+	for (dct = 0; dct < pvt->fam_type->max_mcs; dct++) {
 		for_each_chip_select(cs, dct, pvt)
 			cs_enabled |= csrow_enabled(cs, dct, pvt);
 	}
@@ -3892,8 +3890,8 @@ static int probe_one_instance(unsigned int nid)
 	pvt->F3 = F3;
 
 	ret = -ENODEV;
-	fam_type = per_family_init(pvt);
-	if (!fam_type)
+	pvt->fam_type = per_family_init(pvt);
+	if (!pvt->fam_type)
 		goto err_enable;
 
 	ret = hw_info_get(pvt);
@@ -3932,7 +3930,7 @@ static int probe_one_instance(unsigned int nid)
 		goto err_enable;
 	}
 
-	amd64_info("%s %sdetected (node %d).\n", fam_type->ctl_name,
+	amd64_info("%s %sdetected (node %d).\n", pvt->fam_type->ctl_name,
 		     (pvt->fam == 0xf ?
 				(pvt->ext_model >= K8_REV_F  ? "revF or later "
 							     : "revE or earlier ")
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 881ff6322bc9..82d9f64aa150 100644
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


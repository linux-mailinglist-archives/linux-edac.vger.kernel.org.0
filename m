Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519667EBF9
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjA0RFc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjA0RFb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:31 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78CE14E85;
        Fri, 27 Jan 2023 09:04:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVGAx4XywkUIDCZdvaWOBxuA7rbi82+XVbj+Ty93HHYR+1PShQMiss9nV65rlwn9GrxXPUM2xS3MBNbtMm2s9djYHLcN591XAHIJWM2FRTCQIF6JbgkNnCFekuvM6/TVsANORcqJY2i8LRVSIFj4mKaT0YkuMy83IuRfNevv169Itj1GvtynN/yV5H6BzYFiYBDmXR2aSi8klpIVyUdyRan37dSVEigwBTJsCoZSwu0r7zWnyC9pEKyUApCtG81hNroTeiWAYtoZ9E0CdqV7i7oqv7sHfRlfhNElxzyN2/KfHnJ2Ptjn25rHpJ0m+aqW3UCDBtNOrnklku35Xg1BAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4HjG9qPbWaKzSUa3tOSKFlbp5OZMjY8m7sQ4WPTUWo=;
 b=ja8WH5L2J/jpI9BaJ5hwES9iPb5tYCkl5xqQLbqm9Km/Ou8AZBP0kAZYz/IGLx2dYaok1HC8ER6XNnhDg6b/+upuGdrs6TwfXXE1OwK0Bo92+C53Gaz/hK5JJR2sJY5fJUzn6jnhWW3rqVaFPpZtU6jZRVGMi7wwiRWy1018j9VvgIerLuEcLXCpDh9cTFTaRgXPkfXNAO0k6GbXTOL83lv480IjCMdwd9KCJ4oSY5YNRBvsuPF9T7GtddOrjJUQiOD+HsbdK+TvzL4FKhUd+mfizOYdMtS3KqvIB0TpSU15k9rg3IdF7KUZCeygfVxYhHFXIZFOfnK2j/OeCmpIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4HjG9qPbWaKzSUa3tOSKFlbp5OZMjY8m7sQ4WPTUWo=;
 b=dgeO5wVS5stexsZI2b0DlklH6h+2QYdr6B9/D77bmGBo1dGqIrOPvQwQefTJY870bep4AmrZn3Kzip9ED0zaEM8l8eJrJstR4StPEj+jXcBfJ7eqSjRMOCnhGqaY4DD1Yr6aLzxq8/rV6zth4oMfJ9AJHhZy5InXpJM+R8fnRfM=
Received: from BN9PR03CA0465.namprd03.prod.outlook.com (2603:10b6:408:139::20)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 17:04:36 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::bc) by BN9PR03CA0465.outlook.office365.com
 (2603:10b6:408:139::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 17:04:36 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:34 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 11/22] EDAC/amd64: Rework hw_info_{get,put}
Date:   Fri, 27 Jan 2023 17:04:08 +0000
Message-ID: <20230127170419.1824692-12-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127170419.1824692-1-yazen.ghannam@amd.com>
References: <20230127170419.1824692-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f6f66f-5c31-4328-b179-08db008891c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FEIwPOI/CLoahNjR4q5CvI1iaeq8v2dcOO7UMu/4hMKMt9z2hcI4KXCqbxfiPOyv7aiewkMf0p54JzHxaZ8ZnvDpg8mxBHAIHgksibR+pzbi+P2Gevm1GgoA2i0jm8RMH0BzBmy7ILRjCLLnUMPhR9SZroFnWuQ2Ly3k+0h/9ECqNNj00kDaMhbTQJYS6h/e2UHMhmuEbqgzl1gtC5NXEX09/OUShWQEASpQi0Swr2XYfovC+fCqvPLz/fKaakJoeKXZ9cr1D3aNn9gsu2AAgBwQVISvdJUuVMf3DRUHDEetOGloXNtL+OMyVw5VBXB1GKTnXB5Dg7VUOykZa7CskxZ2CGKt0XpuBoR+nG4UaCAPIfjXtvC65+HqdR55uOyCagzrnBuQWL/93Ib1hcMY9WHTtnmdjFbbyJ+kHSxbgv6ytCj9I2VYNZZ8cLHqJLoPRs8KyNTCt38yRCV2Ro36ZteL3/z378sCPy2Ih9MNQaDXmNLIIk1WvIkNW45HI34qkFYSSTcCK1N7a4UAWQIZjd6wjWVbUxYc07VExN5fOdE12Rydj65w199XJ4WzQbZG0LITQkyuvwQjJoOL3LL98hKhdfYZY4EaGNeDiinp0H5AUNAHB+zIIIWaZ90jEhc/LFCWnhrBWRP9JG4m1dsntrDHCkj0vE3oS/ifseYRYlx3z7D0vutye4SF+xfsZKkD1c9TAfRe/nPsUNkIfBqtm8OjCmelU2EzoUg2U79QSwujmmJMCpNplKIGbj/cw9g3TVqJtjzAjL92YWFVO9QG9+bNocKvVOtU+6nj3bc9feoc6mLt5YxVSbOO6cWn+k29
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(36840700001)(46966006)(40470700004)(7696005)(6666004)(478600001)(26005)(1076003)(966005)(186003)(16526019)(5660300002)(8676002)(4326008)(70586007)(2906002)(110136005)(36860700001)(2616005)(44832011)(47076005)(316002)(54906003)(356005)(8936002)(86362001)(41300700001)(81166007)(40460700003)(82740400003)(70206006)(82310400005)(336012)(426003)(83380400001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:36.3924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f6f66f-5c31-4328-b179-08db008891c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The bulk of system-specific information is gathered at init time with
hw_info_get(). This function calls a number of helper functions, and
many of these helper functions are split between a modern UMC/DF path
and a legacy DCT path.

Split hw_info_get() into legacy and modern versions. This creates two
separate code paths early on, and legacy and modern helper functions can
be called directly in the appropriate code path.

Also, simplify hw_info_put() and share it between legacy and modern
systems. NULL pointer checks are done in pci_dev_put() and kfree(), so
they can be called unconditionally.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/Yn0a9T9xqAkWnPWt@yaz-fattaah

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 78 +++++++++++++++++----------------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index a9b20bc413af..3830b0a4b5dc 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3045,9 +3045,6 @@ static void decode_umc_error(int node_id, struct mce *m)
 static int
 reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 {
-	if (pvt->umc)
-		return 0;
-
 	/* Reserve the ADDRESS MAP Device */
 	pvt->F1 = pci_get_related_function(pvt->F3->vendor, pci_id1, pvt->F3);
 	if (!pvt->F1) {
@@ -3075,16 +3072,6 @@ reserve_mc_sibling_devs(struct amd64_pvt *pvt, u16 pci_id1, u16 pci_id2)
 	return 0;
 }
 
-static void free_mc_sibling_devs(struct amd64_pvt *pvt)
-{
-	if (pvt->umc) {
-		return;
-	} else {
-		pci_dev_put(pvt->F1);
-		pci_dev_put(pvt->F2);
-	}
-}
-
 static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 {
 	pvt->ecc_sym_sz = 4;
@@ -3671,13 +3658,45 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->get_sdram_scrub_rate = get_scrub_rate;
 }
 
+static int dct_hw_info_get(struct amd64_pvt *pvt)
+{
+	int ret = reserve_mc_sibling_devs(pvt, pvt->f1_id, pvt->f2_id);
+
+	if (ret)
+		return ret;
+
+	read_mc_regs(pvt);
+
+	return 0;
+}
+
+static int umc_hw_info_get(struct amd64_pvt *pvt)
+{
+	pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
+	if (!pvt->umc)
+		return -ENOMEM;
+
+	read_mc_regs(pvt);
+
+	return 0;
+}
+
+static void hw_info_put(struct amd64_pvt *pvt)
+{
+	pci_dev_put(pvt->F1);
+	pci_dev_put(pvt->F2);
+	kfree(pvt->umc);
+}
+
 static struct low_ops umc_ops = {
+	.hw_info_get			= umc_hw_info_get,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
 static struct low_ops dct_ops = {
 	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
 	.dbam_to_cs			= f16_dbam_to_chip_select,
+	.hw_info_get			= dct_hw_info_get,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -3820,37 +3839,6 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
 	NULL
 };
 
-static int hw_info_get(struct amd64_pvt *pvt)
-{
-	u16 pci_id1, pci_id2;
-	int ret;
-
-	if (pvt->fam >= 0x17) {
-		pvt->umc = kcalloc(pvt->max_mcs, sizeof(struct amd64_umc), GFP_KERNEL);
-		if (!pvt->umc)
-			return -ENOMEM;
-	} else {
-		pci_id1 = pvt->f1_id;
-		pci_id2 = pvt->f2_id;
-	}
-
-	ret = reserve_mc_sibling_devs(pvt, pci_id1, pci_id2);
-	if (ret)
-		return ret;
-
-	read_mc_regs(pvt);
-
-	return 0;
-}
-
-static void hw_info_put(struct amd64_pvt *pvt)
-{
-	if (pvt->F1)
-		free_mc_sibling_devs(pvt);
-
-	kfree(pvt->umc);
-}
-
 static int init_one_instance(struct amd64_pvt *pvt)
 {
 	struct mem_ctl_info *mci = NULL;
@@ -3924,7 +3912,7 @@ static int probe_one_instance(unsigned int nid)
 	if (ret < 0)
 		goto err_enable;
 
-	ret = hw_info_get(pvt);
+	ret = pvt->ops->hw_info_get(pvt);
 	if (ret < 0)
 		goto err_enable;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 8eea15546b9f..00b3f32e3cbb 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -466,6 +466,7 @@ struct low_ops {
 				     struct err_info *err);
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
+	int (*hw_info_get)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


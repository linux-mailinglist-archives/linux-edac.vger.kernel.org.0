Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E0B67EC01
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbjA0RFu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234892AbjA0RFn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:43 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5b::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90B3C3C;
        Fri, 27 Jan 2023 09:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSbNQQZ2NqNbBsjmcTaQ6aaQVJN2dS0PsdefXvQaH8WKhGCZsTIAz82b8ZBcI70CL2Xcz9UzZ3Nq6tN4LbUk2bkKA6+MOLXS+gNqKZTQTDQzEObyEODdwHRsEq6jqkmswwAfVxHvoycprKg4Bn5r1ZCccut6ZDu044P3m+xpifi/MqD1+ajduZgoemZ0xQbDo2Yw+Te/SzoebXcQ1ilhaJWVwMjIfiHbeLBU8D4tGgT4jku6FgV6NCdwbA0tD+jc0pxccuTU8mIx7JcUKjFFEKn5awacNgHPR5zLsc1Ns2q9elOBo5Qoa0Zv/Aipo869P8b2hqkkYLqUDqdomPVK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayhba4cEA7/yo1GcA4RjdHbPDbQhVhhgqHmosB+Rqhw=;
 b=TBJBhTmWU4g5LgIXjFV+Ds+mdudhaOJRSyROs01x8wUjrBsXCoonvf/3CsiIFTzL9fsZRt0eRZCWKaqvjxa1w/F4wtP89Qct4mS+P2wBNqoYTB0VnO/UNMlndOaYYUHMHrIr74uNO9qz5Y5M+t8WeH00ityg5xAW8Vcf6NPJlOjsYK7/WlNzlfyXEMq5P7q9dhHsqWpc6nBpMAofZEpMrSCmI3Jph/I9fJAZjfzhnJiVlqErEEMsXX0BRVORe4UPyjurnpVMiEduy9ku8nakKY9FTgfYkgf3J8EHA7l2yoeSe2NbqPbmfpFF79Rv7b5Sknp+AG7/qlZUYl17SM83lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ayhba4cEA7/yo1GcA4RjdHbPDbQhVhhgqHmosB+Rqhw=;
 b=nuxYrSRYXk46LSZa2y662uvgjzNsa8j0qeDeI7e3eAmp2MFAG0mJzYWL4AFCAs3UV3UhdyyDZ55gIb/fmM6QzP9QEGghGALub9qCejwzMlgUD+ndE3REY/2Uxy+fvNPhMSRzstu+4fIJzqdLFWUOwAGZPfV02OrJF4TGHqL235I=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by DM4PR12MB5818.namprd12.prod.outlook.com (2603:10b6:8:62::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:37 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::3e) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 17:04:37 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:36 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 17/22] EDAC/amd64: Split setup_mci_misc_attrs() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:14 +0000
Message-ID: <20230127170419.1824692-18-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|DM4PR12MB5818:EE_
X-MS-Office365-Filtering-Correlation-Id: 9168336e-46f9-4d7c-7eec-08db0088927a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JjTrKWd9KYOmAZsLh3d9hFG7TcTzXa/ddR7Y+OvudkAOuRk2itH389bp7KWKzRlHEWtx+YMGOcKz950fX5RTn3C8Ajyakp3VRquuGPkthtpyC7m0tXax2bPIrdHMWeHnoxglKSmtZAcz8KlAAGGINiyBc62qSaHv36xXuCdOUnGyzGlVFV9D1t3rs91ghlR0w2QpRA9Kw45DPBOIztbeoobYn5y7rOpV4406+hlwpXiOnDcCgvzQdtuNd0wUrmGm7L1E3eQOnYueWNV+M695jhkHYZThjQ23w6I7ogeX6IMa7xCWGAWo3rDU/1ar8jlpJaPomxNa24CisBegKFhHyi2N1y7gq2h2KeeXGU30XKXTA9WzBtN6NfNCGeiq9z6SCSnjqa/lmFhNCLSvuA+B6UdUU8yRUqPEKeUF4T04erzt86iX41qVpnfI2ImeuDBpDV3Njx6rK2m7n04HcbJEHtRF3kUDl/ygKYOuoj+JzeAvOAZCf+UrGxSjMmpcOpUTsyixbJ+9VCNTjoQovDxosv+Jdoq1tjEEuhdu/16fUHNAIWS/t35ESFSOLvRJri4P2l8B/zfeui+8E+tEYHT9RhfyNE2b4hqwrhMOymSkWn2B9Qt0FkrjbbxLEOA8OlkVtfe054sZMDy0dIXOLXVaxa/jcrABCboyzpFotFNvrDTP7nv3iJ8X8lLZGBjK4uYQ1gNwmsAifzSpKiJCOynFrWVQaYsq7/OiwYQkdjlhkGcpIScL41GqPYwl5o5tR2Xn6HoWQm0NYBv2GkivRTqN5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199018)(40470700004)(36840700001)(46966006)(7696005)(16526019)(186003)(26005)(478600001)(966005)(47076005)(2616005)(336012)(82310400005)(426003)(83380400001)(6666004)(316002)(54906003)(41300700001)(8676002)(81166007)(356005)(1076003)(70206006)(82740400003)(110136005)(8936002)(44832011)(40460700003)(86362001)(4326008)(5660300002)(70586007)(36756003)(40480700001)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:37.5642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9168336e-46f9-4d7c-7eec-08db0088927a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5818
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

The init_one_instance() path is shared between legacy and modern
systems. So add the new functions to a function pointer in pvt->ops.

No functional change is intended.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-15-yazen.ghannam@amd.com

v1->v2:
* Split function instead of just defining function pointer.

 drivers/edac/amd64_edac.c | 37 ++++++++++++++++++++++++-------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ecffe2f1ea9a..f9254d8da5a3 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3616,22 +3616,18 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 	}
 }
 
-static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
+static void dct_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 
 	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
-	if (pvt->umc) {
-		f17h_determine_edac_ctl_cap(mci, pvt);
-	} else {
-		if (pvt->nbcap & NBCAP_SECDED)
-			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+	if (pvt->nbcap & NBCAP_SECDED)
+		mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
 
-		if (pvt->nbcap & NBCAP_CHIPKILL)
-			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
-	}
+	if (pvt->nbcap & NBCAP_CHIPKILL)
+		mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
 
 	mci->edac_cap		= determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
@@ -3639,14 +3635,27 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
 
-	if (pvt->fam >= 0x17)
-		return;
-
 	/* memory scrubber interface */
 	mci->set_sdram_scrub_rate = set_scrub_rate;
 	mci->get_sdram_scrub_rate = get_scrub_rate;
 }
 
+static void umc_setup_mci_misc_attrs(struct mem_ctl_info *mci)
+{
+	struct amd64_pvt *pvt = mci->pvt_info;
+
+	mci->mtype_cap		= MEM_FLAG_DDR4 | MEM_FLAG_RDDR4;
+	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
+
+	f17h_determine_edac_ctl_cap(mci, pvt);
+
+	mci->edac_cap		= determine_edac_cap(pvt);
+	mci->mod_name		= EDAC_MOD_STR;
+	mci->ctl_name		= pvt->ctl_name;
+	mci->dev_name		= pci_name(pvt->F3);
+	mci->ctl_page_to_phys	= NULL;
+}
+
 static int dct_hw_info_get(struct amd64_pvt *pvt)
 {
 	int ret = reserve_mc_sibling_devs(pvt, pvt->f1_id, pvt->f2_id);
@@ -3686,6 +3695,7 @@ static void hw_info_put(struct amd64_pvt *pvt)
 static struct low_ops umc_ops = {
 	.hw_info_get			= umc_hw_info_get,
 	.ecc_enabled			= umc_ecc_enabled,
+	.setup_mci_misc_attrs		= umc_setup_mci_misc_attrs,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3694,6 +3704,7 @@ static struct low_ops dct_ops = {
 	.dbam_to_cs			= f16_dbam_to_chip_select,
 	.hw_info_get			= dct_hw_info_get,
 	.ecc_enabled			= dct_ecc_enabled,
+	.setup_mci_misc_attrs		= dct_setup_mci_misc_attrs,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -3856,7 +3867,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	mci->pvt_info = pvt;
 	mci->pdev = &pvt->F3->dev;
 
-	setup_mci_misc_attrs(mci);
+	pvt->ops->setup_mci_misc_attrs(mci);
 
 	if (init_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 103cd38a6302..1fb39d7981a2 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -468,6 +468,7 @@ struct low_ops {
 			   unsigned int cs_mode, int cs_mask_nr);
 	int (*hw_info_get)(struct amd64_pvt *pvt);
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
+	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


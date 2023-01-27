Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9967EC20
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbjA0RI0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjA0RIK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:08:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2048A56B;
        Fri, 27 Jan 2023 09:07:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GWo1EYkOfKTmVap3is1i/9AsuEW+dK3lOIA1T75Bf4TrY8so8SmO1yxHs4wYhA6lZSyRQCGJcHiScEQa137vjTdQRACaGJbdnmeQbc2O4knHLlzTOwq5oFHQOXLbKAOzCgGh+vpmq49yt/bin1WFMerrpmiZJS3BEEPJ9c61iDRG+qTOBuZlZ+Q/IqjnTGqTEwzX8tGlKFAopVXEgLO6+stn2vx0B0PGlWgigk+S9NXWp5JX9/twyW5mD9ADmJWOVfcClSyEK+waroc9GJl3QfPBBR2HiX3D5KIPFU2ruAI6g96V1Liqg19WTASy7FVBerQzjcZn8VS7GTkIBo08wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJcRiDJO6FOk9wacaTHCS1n1XjUQ5/6Bsb1cxdMhFcc=;
 b=ZJ/6lSGy3UZZ5H/INQRC08+ugL00bS0LeazSSUfqwrH/upfrcq0A5P0dfFSi2uARrP2g0QdG9THLHVwuiWArgmlCL47G1BtuSXL3UaUTaTVoLQAAGnJXyX5L4vq6ERyTGRjskgKpiqVEzGMQxqrDrQqDeTBLyTI64y+Cc/VvgBk9Te/S3rPZaNnmb/3lyV1wn0VVSX5nXClo3UBzQUL2PAS2i4eVwWrXR+uN0mv/5hiXL4yca6Tv69V1CB17DF0qDCT6XNOALRZJ/XRQd+Li4eEF0xrHFXTtEorLyJ9zbMGB5Jck2dQErT+thJ06zFNlVFZ2CzvspAcc8uE3D+mYyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJcRiDJO6FOk9wacaTHCS1n1XjUQ5/6Bsb1cxdMhFcc=;
 b=2NlFMv5kUX9pYWGA7ubZKQozYXRvYfjmQ53xtk9okHi3tdVIgjJlcSQd9MjHRgFkpMlfQZvAqI0+9hyOp5fjibJ4OvUIsL9hwmgraWhe3ZX8MBvIaViUVqUeM6tOV2u5hOsc4vOadm2gT1RWJ0/MLLWo92vFVtKYsx0MV7kmEtg=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:38 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::1f) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:38 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:37 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 20/22] EDAC/amd64: Split init_csrows() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:17 +0000
Message-ID: <20230127170419.1824692-21-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 679ea1c0-acea-41b3-aece-08db008892f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c5gp5dBSwMBMg/NeDDngb6QlY4cEUqZAsPg8VAjpSbQaH9Lv6Yy29s+bVa68n1WN+Wxc8+Sgl2H2fQp+XXJ2BJy6JL1rabvOnb4DCwrtkeMXDuV6gsGxHHpOCFIRFxpHBijaKEWUxfHINDvfdzgZ1aIQR0yaSRw5YxlJmrk6n518mSbcxKwiTtNxLxMZUMx6Yfec6HXmFwVPR3faRBkHVOEIz24H3dyi7SjJRwtwdkTFEmnX+hkrdTNWxtsxlUrXpbs6Kvdm+/a/28Yoi6WfB5d5jmDk92KP5jhIFlf1u4QLgVd0zYx6kJ4uHJHu+2XUAYky0Ea+u6SBXEAMWBjrtRkbmlB79ymclFWpLwZD9xCLvt1V/ix+EiuGMnHRaxe1GHtuUpaCq68j4qva16bwzdqBomSUAszEtgpo1/WJ8zN95eB1dM8GN6elbAk7mchFkvqcTg1RqVWpLlLZnHi3ruD+JCwI7MjwDl+QwtX5Jn55N5cp7cV88y2hv3hi+IZDfywR4JcrtXVPtasNygC2dHXnQgGDVRrhwUaJpUj2ITDvOOzdCFVDMIGQvv46ClLYWgATWqLnpTwaPFM3mnfYwpgLb8Bk6qd2MHlQjgJx39GvwAy7goRimhHs7vOSur7dGrZCRGLqBvMjL+ueVR7i6nRcl6C2Bk63T8j0Ni2XAc3D4mr1RZFrAZs4n2L8B+2WNajnp9Vk3xM4e7seDdrsf3D+cHfDIh94e01Ce6KedUKXBplbgA3p61YegHmO9CITUWE4dDgEmzIBC2GbUyPrtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(336012)(70586007)(70206006)(47076005)(5660300002)(4326008)(6666004)(40480700001)(7696005)(44832011)(316002)(8676002)(86362001)(83380400001)(426003)(40460700003)(36756003)(26005)(82310400005)(356005)(1076003)(966005)(81166007)(186003)(16526019)(82740400003)(2906002)(36860700001)(41300700001)(478600001)(110136005)(54906003)(8936002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:38.3584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679ea1c0-acea-41b3-aece-08db008892f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

...and call them from their respective setup_mci_misc_attrs() paths.

Also, drop the check for an "empty" device, i.e. one without memory.
This is redundant and already done in instance_has_memory() earlier in
the init path.

No functional change is intended.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-16-yazen.ghannam@amd.com

v1->v2:
* Call function directly instead of using pointers.
* Clean up redundant code.

 drivers/edac/amd64_edac.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f1c613107a22..ddf2178dabff 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3250,13 +3250,12 @@ static u32 umc_get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_or
 	return nr_pages;
 }
 
-static int init_csrows_df(struct mem_ctl_info *mci)
+static void umc_init_csrows(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 	enum edac_type edac_mode = EDAC_NONE;
 	enum dev_type dev_type = DEV_UNKNOWN;
 	struct dimm_info *dimm;
-	int empty = 1;
 	u8 umc, cs;
 
 	if (mci->edac_ctl_cap & EDAC_FLAG_S16ECD16ED) {
@@ -3277,7 +3276,6 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			if (!csrow_enabled(cs, umc, pvt))
 				continue;
 
-			empty = 0;
 			dimm = mci->csrows[cs]->channels[umc]->dimm;
 
 			edac_dbg(1, "MC node: %d, csrow: %d\n",
@@ -3290,27 +3288,22 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			dimm->grain = 64;
 		}
 	}
-
-	return empty;
 }
 
 /*
  * Initialize the array of csrow attribute instances, based on the values
  * from pci config hardware registers.
  */
-static int init_csrows(struct mem_ctl_info *mci)
+static void dct_init_csrows(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 	enum edac_type edac_mode = EDAC_NONE;
 	struct csrow_info *csrow;
 	struct dimm_info *dimm;
-	int i, j, empty = 1;
 	int nr_pages = 0;
+	int i, j;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -3333,7 +3326,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 			continue;
 
 		csrow = mci->csrows[i];
-		empty = 0;
 
 		edac_dbg(1, "MC node: %d, csrow: %d\n",
 			    pvt->mc_node_id, i);
@@ -3367,8 +3359,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 			dimm->grain = 64;
 		}
 	}
-
-	return empty;
 }
 
 /* get all cores on this DCT */
@@ -3642,6 +3632,8 @@ static void dct_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	/* memory scrubber interface */
 	mci->set_sdram_scrub_rate = set_scrub_rate;
 	mci->get_sdram_scrub_rate = get_scrub_rate;
+
+	dct_init_csrows(mci);
 }
 
 static void umc_setup_mci_misc_attrs(struct mem_ctl_info *mci)
@@ -3658,6 +3650,8 @@ static void umc_setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
 	mci->ctl_page_to_phys	= NULL;
+
+	umc_init_csrows(mci);
 }
 
 static int dct_hw_info_get(struct amd64_pvt *pvt)
@@ -3873,9 +3867,6 @@ static int init_one_instance(struct amd64_pvt *pvt)
 
 	pvt->ops->setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
-		mci->edac_cap = EDAC_FLAG_NONE;
-
 	ret = -ENODEV;
 	if (edac_mc_add_mc_with_groups(mci, amd64_edac_attr_groups)) {
 		edac_dbg(1, "failed edac_mc_add_mc()\n");
-- 
2.25.1


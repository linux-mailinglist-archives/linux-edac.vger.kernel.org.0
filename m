Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D866B67EC1A
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbjA0RGz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbjA0RGX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:06:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7949E2684E;
        Fri, 27 Jan 2023 09:05:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3FYDHJVVpRsLXCyK9lbigfyzPJsO0qunkygXHjBsdgj5xxvL8YW8dpdkQV6PBS9d/ISBHmsQTb/omq7hDCtFfTT2EuisEdankaIqeGl7pQEk8vtjYqNNG0J6NnzfxhzZa8AbCmGJSbzR9eDznhnCwP2Kn5l44ClA+OUaNuG66Xi4cM39+JEjs5izSvlOGDre/VT68zMd+ZHWc/V25ZD9xoISzAdOjv53/+W3azb+AqJxMB+XT/jTSA4l5rBQP7o5PZfvkRZbVP+pPB/L2zpI7bpjTA1CndRCUHscdU7Skw83q80F2eX9E2Cw3q4m8bn8p4N56NroNP/Yexxpu9PzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROeIX5lny5eSt8wgK5KhTZ+Q/2Q2xDc0dJ+L0hd62Zs=;
 b=boOtzy5ECjexxiQv3N5DcWrFWErbeOCeZhHzoFwijs7c5xKLH2Sc6rZaBlirXRWD5fNwHj84bdtW1UHfK+oyRboz4lyOC8goy0Kr7260BoxcweKyUlrGKsvQTFam1qgqcmNUWs2ZsgDttFq9N9cnQmwtdBrpNdq2MuhkidFNDrUjKNqI4HHyKaNVbTqsbJx13pYxmq8clVNBFn1Tz762nn/UFPqb73JbflOBDLS8a84H/AILfLrhY7fu2QcL3GMzxPhToP+3lMbdokusQ0OomFkg4VbYszxtozAdBDZ48oMXadPFl7XGPyEtntIZlM/tJjkETdyCYvnaBCtLV12pWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROeIX5lny5eSt8wgK5KhTZ+Q/2Q2xDc0dJ+L0hd62Zs=;
 b=SN8PFPwhroQwpnYYpgyE+s3KR0L4mt/ffnNCkV9846WrmhbYEF2496NsfM/kwatOalhD77wK1zuJvuM05lXGuzh1mZUAkMDQ4VA/Q5/vQycCictfot6qcQJTS0irTD1KY1uzvCppfvQjQ0EvnFsOBqcDGeB3R0u3cWSRajPoIdA=
Received: from BN8PR04CA0049.namprd04.prod.outlook.com (2603:10b6:408:d4::23)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Fri, 27 Jan
 2023 17:04:37 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::fc) by BN8PR04CA0049.outlook.office365.com
 (2603:10b6:408:d4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:37 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:36 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 15/22] EDAC/amd64: Split read_mc_regs() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:12 +0000
Message-ID: <20230127170419.1824692-16-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c0f837d-8b11-41a2-570b-08db00889256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUc7ppeaMG6Uyfbm9vfnVjWy3YOeieXz0y7fXxZ95W++NbtdvpQDt/XyQ4brEeqQX3eizX+Kfm5Xj0AfGjwwV9RJeG5mzvJrascTi9LHvvW+V7tpShSE3mHJsWYW9qXwyfYbZI95ep0iEeYgIOpcVynBY1crtru9e/uw6/4uOkHA6/XFBpNfmlK202kwzNOvvE5mRA7rjMrKkxbZPX78QyWwJDfqqK+n99ZpuN95jQnBtzoem77Gx1rKbHWdcOly/tfJQZbQvOQ7t3Xqsv+/rpNZDsqCgs9utR4glwxkjZ2yODa6eXQpbcJvq+rCAtttCkRkDeF3bMYie6FtR3WRtUScu0rTApkANoZcx6+VNBF8mL5BjpcUfX5hnOJOQT4nlqvIW8CTo2gvqgaVIpUCxtl0K5PZaNeEbeexNPoLa97Z//IJn4LFuLfctfSkubDEZm41Xq7lMzLutBQ/j3bh1OEDxuC43sXc88z7izBin1FW8QfUItZHwEmIOZEOwbiICUNJQWKRC1wJK4bMtR2D/M4zRHwgaNSMBby9wwtyGsxS9a4iN25gUSQyq85mVpS/lojUZ+K2nPFuaeNCk/hYlH63rCr2kKBBXBUENaIk19VbW2stOFtb5vf5bI3w/d7G6vri02+QJFO7hlWM4+DR0WVBNHypKgSRMau0UcXDyzCrML8aDJ7HUNOhXFWau1aFFxkqu9z4MUZhP11ewqgmrxEmQHDv7ewuKGEZr0rOA+tkcmd1KZ3rHE152TaSzjRr/RVNkKdUP/W5SYvdd+AiZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199018)(36840700001)(46966006)(40470700004)(186003)(86362001)(16526019)(1076003)(26005)(478600001)(6666004)(966005)(70586007)(70206006)(426003)(47076005)(8676002)(5660300002)(44832011)(40460700003)(356005)(40480700001)(41300700001)(8936002)(82740400003)(7696005)(2906002)(36860700001)(36756003)(4326008)(110136005)(82310400005)(81166007)(83380400001)(316002)(54906003)(2616005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:37.3428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0f837d-8b11-41a2-570b-08db00889256
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237
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

...and call them from their respective hw_info_get() paths.

ECC symbol size is not needed on UMC systems, so determine_ecc_sym_sz()
is left out of the UMC path.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-11-yazen.ghannam@amd.com

v1->v2:
* Call functions directly instead of using pointers.

 drivers/edac/amd64_edac.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0d0e563c99db..757d35fad2a6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3089,7 +3089,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 /*
  * Retrieve the hardware registers of the memory controller.
  */
-static void __read_mc_regs_df(struct amd64_pvt *pvt)
+static void umc_read_mc_regs(struct amd64_pvt *pvt)
 {
 	u8 nid = pvt->mc_node_id;
 	struct amd64_umc *umc;
@@ -3113,7 +3113,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
  * Retrieve the hardware registers of the memory controller (this includes the
  * 'Address Map' and 'Misc' device regs)
  */
-static void read_mc_regs(struct amd64_pvt *pvt)
+static void dct_read_mc_regs(struct amd64_pvt *pvt)
 {
 	unsigned int range;
 	u64 msr_val;
@@ -3134,12 +3134,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		edac_dbg(0, "  TOP_MEM2 disabled\n");
 	}
 
-	if (pvt->umc) {
-		__read_mc_regs_df(pvt);
-
-		goto skip;
-	}
-
 	amd64_read_pci_cfg(pvt->F3, NBCAP, &pvt->nbcap);
 
 	read_dram_ctl_register(pvt);
@@ -3180,9 +3174,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 		amd64_read_dct_pci_cfg(pvt, 1, DCHR0, &pvt->dchr1);
 	}
 
-skip:
-
-
 	determine_ecc_sym_sz(pvt);
 }
 
@@ -3658,7 +3649,7 @@ static int dct_hw_info_get(struct amd64_pvt *pvt)
 
 	dct_prep_chip_selects(pvt);
 	dct_read_base_mask(pvt);
-	read_mc_regs(pvt);
+	dct_read_mc_regs(pvt);
 	dct_determine_memory_type(pvt);
 
 	return 0;
@@ -3672,7 +3663,7 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 
 	umc_prep_chip_selects(pvt);
 	umc_read_base_mask(pvt);
-	read_mc_regs(pvt);
+	umc_read_mc_regs(pvt);
 	umc_determine_memory_type(pvt);
 
 	return 0;
-- 
2.25.1


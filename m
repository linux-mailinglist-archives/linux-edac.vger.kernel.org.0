Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE564C7180
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiB1QPX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2627F45069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5v0HdB6Z2ptE8353iviAj0fKdz8jO+T2YE+QHxw8+WuG62GKBMVHn71E51mxZiOvmJzvKTuwhm8PCgUbpZX13WcuVKqWp0rsRDqz6S1NMeo637baOjl0q61F8CEQ51N6R9Hull/jbxzPI6jpvuWHXTMtT5sAUTUbMxDNMdXWogkvV9gFQ/ydUV9xSZ8BNQy01k2pfVNRYqQNahz8RC+KJXL/6QkhKmR9ScNUpsgUZ7f/u3+KCGWft5c6ttpqYA3rq8wBuEaKXMBQndVZBc1FO11D8IKxDy1pkKK75ACUGE/gA/pCQ4tbnRloTsPh3Y7MI7KYlk3OuZ9jT5cEyNjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHbUvSyJcxIuQrF8G38KShuCNooBPb9T3ECjjOGAx7c=;
 b=Fcf6IFvjy4HXSIJN8WqkdgjMnwkhrK6F6G5F7Ww6Wkn8Wo1YOTLMzJOdfJSqrqFgexRQt/oL+0KPXWwXVxvEr6AGwM9aRk8f7u/GmTgu0bZ7/4phSarNgXEru+6TrA0N2+hlVdlx8AVdilY9AqEEoExiKOrykgCWE4Q9MWhOag8C8SL+XMWUGzZ8se212d6tv/cW/NZ2FplCzSaZdT+XNkEUPV43pRotzsipD+cAyZ+8TtpKbDx5bE27WFIQZl7J5X29n8B84fp/yHzfZyVli/xEPQF8qgkpeZZmR+sU5D1m+MdxllTpse6pge4RojQewtlQmgJmQoBVW2OSuXLnEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHbUvSyJcxIuQrF8G38KShuCNooBPb9T3ECjjOGAx7c=;
 b=5JZ3cKMM5Nv1LsF19Sn6whIfIiOb2HL0FOB7a5KfkQas3LX/8PEh+igZNwz/kVuEIq730bIKJsVGMoRIX8sd2Bx2h0/CEs+G47572rm6T53/pGTrrDsQq16mTdSAs3YfMarb/KCjJ+Ev9nj4dMF8FKTbuECkIWIAzSXUJNogeTY=
Received: from BN8PR15CA0018.namprd15.prod.outlook.com (2603:10b6:408:c0::31)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 16:14:39 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::88) by BN8PR15CA0018.outlook.office365.com
 (2603:10b6:408:c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:39 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:36 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 08/14] EDAC/amd64: Add determine_edac_cap() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:48 +0530
Message-ID: <20220228161354.54923-9-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228161354.54923-1-nchatrad@amd.com>
References: <20220228161354.54923-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d014c35-ab02-4119-8b08-08d9fad56bbc
X-MS-TrafficTypeDiagnostic: PH7PR12MB5975:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB597511E6007046E9C75E91FBE8019@PH7PR12MB5975.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 55Lsi8mRBb7vyXtsP8NpwWT8CBWQz4PXTaNbRZ2+KBuos07Cxo8HzO9VSLAOGTdiKEddHLJeCibPlVPEyR3UfayBEIy6xTZPo7z1Vc+ZGX7KD1NRJfrNpaLm6s6M0100E69bZE+iAwIxNy+5q8vACpdQukHlCSghq8MWNzi27vOVoIeT8gPdExKehSyqrdxLSGxfHkMLiZ4mtrRAtK8G6LIgcc3fzu0cUFkqoKzG/Xwy5nGbQRjartBLv1gT38eDLWHqUfIVYLI3EgkTUmuhdhwFoBTLpYMlvWzNdL9+VTVaPP4tOSSgh/rNCtuMSvTjwHThalR97pNAKlAnGnxRqjVvaOjLJ+N0GmO2K4AsaJDZQ1Hp0ygN2seMsPbcV7bk/1I8BJFnsXhEVBm5Cs3tBpbxwiE0jexMEGf/iHUNVhXjc/bNCzKFcPW+J0QgcqTgmKVj6kp2EnahUGZQCtzThdPjJg6epwtTThdJw1Fw+ojNI54cyLjH3nrJqGFC5nGYkYmD3wYLgLfqQZaD+gAk2rD8isc4HL8UrqndVoRrFMJY1GTLqw8dpRvEk6XcRyHlcSvUqxX2vAbmiQYX9ZsH64iFj3Ss4/1P3uIZmKUQiPSrMvgUSB4AN7JsRlGiwxpoKPGB3zFM2xlgzfMXEIu2ASRS2wosqTdbXslE7XY53IGrJFy26pX0ra7PsF6jQ0dMpivaa0GacxfuR02YSJeDLryhQcRVhymxSXrGJ3XqrGTK0ehpKg9PbHIm3VXF2CF9n5NJVGGJW1fSxxZ43zf5onT6FzwgOKQvqQ3dWScrr0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(40460700003)(508600001)(36756003)(83380400001)(47076005)(2906002)(426003)(336012)(36860700001)(186003)(16526019)(26005)(966005)(1076003)(81166007)(5660300002)(7696005)(6666004)(356005)(82310400004)(2616005)(8936002)(316002)(70586007)(70206006)(8676002)(4326008)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:39.1351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d014c35-ab02-4119-8b08-08d9fad56bbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add function pointer for determine_edac_cap() in pvt->ops and assign
family specific determine_edac_cap() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 37 ++++++++++++++++++++++++-------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 15d775a9ce7e..af6711cf03e9 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1267,13 +1267,25 @@ static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
  * Determine if the DIMMs have ECC enabled. ECC is enabled ONLY if all the DIMMs
  * are ECC capable.
  */
-static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
+static unsigned long f1x_determine_edac_cap(struct amd64_pvt *pvt)
 {
 	unsigned long edac_cap = EDAC_FLAG_NONE;
 	u8 bit;
 
-	if (pvt->umc) {
-		u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
+		? 19
+		: 17;
+
+	if (pvt->dclr0 & BIT(bit))
+		edac_cap = EDAC_FLAG_SECDED;
+
+	return edac_cap;
+}
+
+static unsigned long f17_determine_edac_cap(struct amd64_pvt *pvt)
+{
+	u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	unsigned long edac_cap = EDAC_FLAG_NONE;
 
 		for_each_umc(i) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
@@ -1288,14 +1300,6 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 
 		if (umc_en_mask == dimm_ecc_en_mask)
 			edac_cap = EDAC_FLAG_SECDED;
-	} else {
-		bit = (pvt->fam > 0xf || pvt->ext_model >= K8_REV_F)
-			? 19
-			: 17;
-
-		if (pvt->dclr0 & BIT(bit))
-			edac_cap = EDAC_FLAG_SECDED;
-	}
 
 	return edac_cap;
 }
@@ -3759,7 +3763,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
 	}
 
-	mci->edac_cap		= determine_edac_cap(pvt);
+	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
 	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
@@ -3796,6 +3800,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		break;
 
 	case 0x10:
@@ -3811,6 +3816,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		break;
 
 	case 0x15:
@@ -3842,6 +3848,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		break;
 
 	case 0x16:
@@ -3863,6 +3870,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_ecc_sym_sz		= f1x_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= read_mc_regs;
 		pvt->ops->ecc_enabled			= f1x_ecc_enabled;
+		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		break;
 
 	case 0x17:
@@ -3898,6 +3906,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->ecc_enabled			= f17_ecc_enabled;
+		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3939,6 +3948,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_ecc_sym_sz		= f17_determine_ecc_sym_sz;
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->ecc_enabled			= f17_ecc_enabled;
+		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
 		break;
 
 	default:
@@ -3950,7 +3960,8 @@ static int per_family_init(struct amd64_pvt *pvt)
 	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
 	    !pvt->ops->get_base_mask || !pvt->ops->prep_chip_selects ||
 	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
-	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled) {
+	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
+	    !pvt->ops->determine_edac_cap) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 6cc3fc943fcd..9a789cb01f4d 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -470,6 +470,7 @@ struct low_ops {
 	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
 	void (*get_mc_regs)(struct amd64_pvt *pvt);
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
+	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


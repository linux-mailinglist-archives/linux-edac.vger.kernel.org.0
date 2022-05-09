Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E4C520084
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237864AbiEIPAF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237897AbiEIO7z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565F1FD1CF;
        Mon,  9 May 2022 07:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=niiGLknwOx0YVigjb+eeJgbsxBmbf+pStU/IrcJYY2gQSV8s+Zz8tZelVFXRzC0WP28sXkbbWhiwTeDAwirJZ2cpVv2fSgoiimoivNp/anIW+EJGOwYTpSUmgwpdnSsxSY00X2V2t8HPI3DzGo6YkAaQlUNkvDSyzWCWj2T70x+48dkVF8l0xDw1Ioap+8JSnXaFo8/JQysdVc04X2GOAYSItFY5yzDbg24OzKWm4J9PduCzd8pjEzD5pHw/SsLhVLIwQwQcAeTP+mTWesbfWubkgV/MToZ+KD7g4URdy6uupGuwozoit/3Xp8uIhmvO6IdlJ1nSWJ4RImJ+LXT7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QZzpEe7JE7ZHMd3zTf9mjvVpGLyBQqbSi8m7EoLSh0c=;
 b=CQKIX64Dv7iCH7Df7JmAe38xZCSYDHcA83lx0+fYPhV+CywrHEVwYNmsKCLm//Jf7ZXwvECps8YHQHVdcz+einGMEyVFMgEXH63W9e7s57EooC4+5NWX7z8wVPuiEFPz17/cBP83ntnhS3NxK1WNLVvEKnXBV8K0ZAP90LRo4/ZyG0XMjuxHFnqqx2Mf9x6K6UeuXKdu+Bl8QnSS/CBmU0AHoZIGd7r7In0QnfZ46UEp8YRHB8QZbAyLQ8zU/OXFkOyNno7xUn2EsukZBveL5rnCs/df5GXVZk2Hx+AQspEnuU8HBuGgHG6tLqEe1LJCortMyn32J+BPVn9vyU3OkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QZzpEe7JE7ZHMd3zTf9mjvVpGLyBQqbSi8m7EoLSh0c=;
 b=H27G26sbJiGn73qtvFwrSNHn8di6VmPmASla6L/5Emq/5xX8JPIPLj1QapgJaVfLYG0m8LxRWgUU7LDXt621KO5mv8Sx9KhU8q8fO1PUtlyuhuRJuOAlmUhd5c9f0ktg9TwNTkdqDYWdW9qcTULYdBplx8Rm6ES9bRHp1EIzMDE=
Received: from MW4PR03CA0011.namprd03.prod.outlook.com (2603:10b6:303:8f::16)
 by CY4PR12MB1910.namprd12.prod.outlook.com (2603:10b6:903:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:55:57 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ec) by MW4PR03CA0011.outlook.office365.com
 (2603:10b6:303:8f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:57 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:50 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 12/18] EDAC/amd64: Add determine_edac_cap() into pvt->ops
Date:   Mon, 9 May 2022 14:55:28 +0000
Message-ID: <20220509145534.44912-13-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509145534.44912-1-yazen.ghannam@amd.com>
References: <20220509145534.44912-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef5abe70-2572-4008-a370-08da31cc0644
X-MS-TrafficTypeDiagnostic: CY4PR12MB1910:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB19101DBB5E1BB40DD72ACC45F8C69@CY4PR12MB1910.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bi1Hdu3iPuk9U+1CGd59O9xwLwhMQwOjHAJulgXwaivhFDDqFcAPE4Pf9FGNjvd/1T+idoOygxkiXDnUsFJfGPR9Vkops4W2R6zNpZyxr5asR7UnkBKaRO8HmTdmYf7DhAMDUy9ZiGJZOACpEOis2TS9qQ2luxey0kWnxUyNP4noVoGEEQFF141bwdxVfyXsEEBF8dE43tmoaolrg9fvoYHW+SbRGN74Lo58Y3ZSHLVv7i9AvpubruuewOlMDZsADuM6U5ES7Qg3Gh30zQnRUVrSou3isFYPQL4J2X7PIoPSNQ4iPm1taTdQe69vM8j83ZmpFG7DR0BFdfRlcPvOhUKJ63Cbp6KAty8GczCVhs6otV36bMqAHiRnhuCSbplyfAX5zhtImQs377n+jGuUIguz4CIafUjsq7tDqt/6Aa0IfPtSY9TMF4zFzz8phPW7TQU+NgqwSmdF/1GOlVVrtAwkhp+BPBG6ITL/DqUV4+HnBWPAYvM4YmX+b4iQlmV/C2qp/Pij692YoaL7e235AyxBjPpzzFkNCDz/AdJu+WTQkJcr579q5px1HmB6dfKOQB8EQco3ajQtjvxGK2046OQxRT1VsYFU1gxHe+WrmTzCB+2lMtP9H3zMiadSujeAFPTVGFGLCpH4uB7KuZZ9sQJw8pIxHPrLYYzVvPx34LIPpj1GzTPez+1r2Unh90/yGz89TRh5EEVjhbREluPzZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(16526019)(8676002)(4326008)(8936002)(86362001)(70206006)(70586007)(82310400005)(186003)(36756003)(426003)(36860700001)(5660300002)(83380400001)(316002)(508600001)(54906003)(336012)(47076005)(110136005)(44832011)(6666004)(2906002)(81166007)(40460700003)(356005)(7696005)(2616005)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:57.2878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5abe70-2572-4008-a370-08da31cc0644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1910
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

GPU Nodes will have different criteria for checking the EDAC
capabilities of a controller. A function pointer should be used rather
than introduce another branching condition.

Prepare for this by adding determine_edac_cap() to pvt->ops and set it
as needed based on currently supported systems.

Use a "umc" prefix for modern systems, since these use Unified Memory
Controllers (UMCs).

Use a "dct" prefix for newly-defined legacy functions, since these
systems use DRAM Controllers (DCTs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 30 ++++++++++++++++++------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 136f2454a502..0bc9a3846773 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1261,13 +1261,25 @@ static int get_channel_from_ecc_syndrome(struct mem_ctl_info *, u16);
  * Determine if the DIMMs have ECC enabled. ECC is enabled ONLY if all the DIMMs
  * are ECC capable.
  */
-static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
+static unsigned long dct_determine_edac_cap(struct amd64_pvt *pvt)
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
+static unsigned long umc_determine_edac_cap(struct amd64_pvt *pvt)
+{
+	u8 i, umc_en_mask = 0, dimm_ecc_en_mask = 0;
+	unsigned long edac_cap = EDAC_FLAG_NONE;
 
 		for_each_umc(i) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
@@ -1282,14 +1294,6 @@ static unsigned long determine_edac_cap(struct amd64_pvt *pvt)
 
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
@@ -3740,7 +3744,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
 	}
 
-	mci->edac_cap		= determine_edac_cap(pvt);
+	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
 	mci->ctl_name		= pvt->ctl_name;
 	mci->dev_name		= pci_name(pvt->F3);
@@ -3760,6 +3764,7 @@ static struct low_ops umc_ops = {
 	.determine_ecc_sym_sz		= umc_determine_ecc_sym_sz,
 	.read_mc_regs			= umc_read_mc_regs,
 	.ecc_enabled			= umc_ecc_enabled,
+	.determine_edac_cap		= umc_determine_edac_cap,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3773,6 +3778,7 @@ static struct low_ops dct_ops = {
 	.determine_ecc_sym_sz		= dct_determine_ecc_sym_sz,
 	.read_mc_regs			= dct_read_mc_regs,
 	.ecc_enabled			= dct_ecc_enabled,
+	.determine_edac_cap		= dct_determine_edac_cap,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 99b6ffa21ba5..bfe48492a0ba 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -474,6 +474,7 @@ struct low_ops {
 	void (*determine_ecc_sym_sz)(struct amd64_pvt *pvt);
 	void (*read_mc_regs)(struct amd64_pvt *pvt);
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
+	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


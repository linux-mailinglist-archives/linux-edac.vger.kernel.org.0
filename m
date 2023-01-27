Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0AE67EC05
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjA0RGE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjA0RFn (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:43 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDCA77502;
        Fri, 27 Jan 2023 09:05:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXNEkzrEMMoaOPPCDgI5mTPzxfR+vAbGPpL9LN/HkgQvOHGd+5x3A8pNL2GXHd8BPijholVCecGgshejc4r2IszA/n29SCbO4AVWMu9f9dqncpzwK3xsUoWkfI1XBg1Y8xyBw96WPzM1EMBk39NFFPLsFCsYwKXb8IF5a+jLIBLfGJxRFHfgy1xPUz8/O0wCGCJPhzyfX3iO9oPFArryE2XqKbbmGz14Ggyh5mTM+9ilHtcN5PVz0vvMKowkuYBfWFYRmoE29wW9pmCwDGtJ5/hZU5RY+vWSWXmgw33gBIsfCFrJkkRC1dBOkFzPCT2/JS+wYjakZNYgqGuL0JMjwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q161Gkx4OKsPgU/TegAPI0ZEFw1VE8VzRgmq/AUf6n8=;
 b=OZQmdkzOM+tx4UIexRaaEZiURVqtHmNZnNcX6EcMS5Z0VM6mruCD1Dl+L5v1gM8Pgca4pO+FKClS65KsPrjKkQPuM0DGP7hf8mxryu7lPJs/THbJ3T2uwq9rskUOmwpPDjcBXA49b2AuO343OYrWVBoWFPif246Y6ggxcRg8roH2c2nTrz0XvwLn/YfYIa16XxbOqEPpnKnqRiV6OAfvTlKNOdVxqakWA/2L+J+n7vAs8ocgBDKjELR10viqlNVGge8FEraNLrgcQt/kJwM2gTN5Ai0EPkhmz/xbB1Em4Y1u2zrtKtRmYs15ZlOJulHqV53KIDe+jS7MwE5r41Gscw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q161Gkx4OKsPgU/TegAPI0ZEFw1VE8VzRgmq/AUf6n8=;
 b=wrZC0EXrujG5s0bsPv7sI2vBwDwpB8FSCK1MWmy5+OXC+AxM3cpRJSlKC29r3MoQhM/jMYfE/Q5ZfP/5f3909HbIIZW4JiiL8ioGgxept7Rg/oViNni9XpQXP9GB+TkXA9TYQ41s5qKV/bzm4w1WUGlTta7Uh5DSTD3FKJnL8s0=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by PH7PR12MB6587.namprd12.prod.outlook.com (2603:10b6:510:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:39 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::c0) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
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
 2023 11:04:38 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 21/22] EDAC/amd64: Split dump_misc_regs() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:18 +0000
Message-ID: <20230127170419.1824692-22-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|PH7PR12MB6587:EE_
X-MS-Office365-Filtering-Correlation-Id: 85bc5f61-0004-4e79-33ca-08db0088933b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: au85aBI1tlkf/aZA0y+7ldcJT+2t3I76/OBy6Z+7FSRqS90vvAf68mNk+Wk+1A2ZDcxPOkND15X66nFePbJsZFNI/D6JvCPgpg/MXemJQtXh/hyYslO/k0ZwSs/zpboMi2HJp4M9qtgvjspejny/qkZ9XtSVernjszOf3YF1Kp1bJUY1aLBQek8UQ+nR0mlVjbDikzvgi1Bo1tQ896n8js9/mpRQhhkAsgDp9JogXAMjmE+8j6d46lvZ40vqHBO3iQPGZYLBMahueRhWoSvTdr/t3I2/ahyzfPX25P4lN0PjoH4GxapOtTvODhM2O1DsClEnz3sG15cX/6ObmaHeDv6WXIovtEhLh7tyep9NVGwPsEZKP2M9gcjEYv4fuGPBdOcx4oDRMMjuhgyaAHP11eyO2y4nQ4UxpAeTmU4mIfD2kktnAeHMwPz3NXNQlt/8kL+cg6DMu2UUUIfZO9O1szIcsJVigXUAbUGATTSxotpwZsAKsoEpJXz1K/+D3bbDDhFnm5r1SzLleVDWMjptmtHek7NwJtEV5K/9bicbFQzgdE7KZCCTg5B4MqSAcs/6oIZ5Zmlc/MLACrlKDfODTcBFqst91MqqL+qfohsK8LsfizdCoOTKPP9qtu3TAubefJqCYVupSeEpr/sUlIT6At+eBGuvgDoW1bJGu6cJRLU0hGlYF1MslELBmjVJV1P5lvqG6n6ieynsJgFCqAncOaUVAltvosxNnr+U+kzKYkEGiGQAuunLvBC4cIblNfG0f5CrY09zkLBeioeoSrJksw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(36840700001)(46966006)(40470700004)(70586007)(4326008)(8676002)(2616005)(36860700001)(41300700001)(8936002)(54906003)(316002)(110136005)(36756003)(82310400005)(1076003)(356005)(16526019)(26005)(186003)(81166007)(40460700003)(5660300002)(70206006)(2906002)(426003)(83380400001)(82740400003)(336012)(47076005)(966005)(6666004)(7696005)(40480700001)(44832011)(86362001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:38.8271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85bc5f61-0004-4e79-33ca-08db0088933b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

...and add a function pointer to pvt->ops.

No functional change is intended.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-17-yazen.ghannam@amd.com

v1->v2:
* Call function directly instead of using pointers.

 drivers/edac/amd64_edac.c | 19 ++++++-------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ddf2178dabff..6b450544a892 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1525,7 +1525,7 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
-static void __dump_misc_regs_df(struct amd64_pvt *pvt)
+static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
 	u32 i, tmp, umc_base;
@@ -1568,8 +1568,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 	}
 }
 
-/* Display and decode various NB registers for debug purposes. */
-static void __dump_misc_regs(struct amd64_pvt *pvt)
+static void dct_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	edac_dbg(1, "F3xE8 (NB Cap): 0x%08x\n", pvt->nbcap);
 
@@ -1606,15 +1605,6 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
 
-/* Display and decode various NB registers for debug purposes. */
-static void dump_misc_regs(struct amd64_pvt *pvt)
-{
-	if (pvt->umc)
-		__dump_misc_regs_df(pvt);
-	else
-		__dump_misc_regs(pvt);
-}
-
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
@@ -3694,6 +3684,7 @@ static struct low_ops umc_ops = {
 	.hw_info_get			= umc_hw_info_get,
 	.ecc_enabled			= umc_ecc_enabled,
 	.setup_mci_misc_attrs		= umc_setup_mci_misc_attrs,
+	.dump_misc_regs			= umc_dump_misc_regs,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3703,6 +3694,7 @@ static struct low_ops dct_ops = {
 	.hw_info_get			= dct_hw_info_get,
 	.ecc_enabled			= dct_ecc_enabled,
 	.setup_mci_misc_attrs		= dct_setup_mci_misc_attrs,
+	.dump_misc_regs			= dct_dump_misc_regs,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -3953,7 +3945,8 @@ static int probe_one_instance(unsigned int nid)
 
 	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
 
-	dump_misc_regs(pvt);
+	/* Display and decode various registers for debug purposes. */
+	pvt->ops->dump_misc_regs(pvt);
 
 	return ret;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1fb39d7981a2..1c64fd4a14b1 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -469,6 +469,7 @@ struct low_ops {
 	int (*hw_info_get)(struct amd64_pvt *pvt);
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
+	void (*dump_misc_regs)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


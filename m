Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA57452006B
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237942AbiEIPAJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237917AbiEIPAA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 11:00:00 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2045.outbound.protection.outlook.com [40.107.102.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8424BB34;
        Mon,  9 May 2022 07:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsJimNxvvezGR91Y9nhMlCIZZ9EMHtZoim/LDKFOGeW+0vhLysyRL4XMF8avgBCHPrzWLPXGSFDyL/Gpjx3FuaumZAJzwA2YZZo2oEyAyyd/Rkbsd0TDyiVqYF2g5WJmq7d6xKmdsvN7DbaPxbIFtzCn+RsdT3+ADScfH1OosidrMI8K8ViwimO2nEAntq5YLxVJDOQTt5KE4SKFNaLwmjWtz08LaphMndnEW1D17vB59LjRbvPCGewDDvkE3NaP/q/JtBtzFFEyFb3EpTN2gXvbbCVYzWi+F/DJOnEfP6ZJEbrhbyMhFg4Fi9FVVWZSwGdtT+Xoii/uEI7b0Zxdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lk+eGPeI5rDHjsPqUhb9X8LF5O3iDJFT5LZ+MgrAfpQ=;
 b=OIjUoBOlvaho/mZPCtJk/ih575aC3SQ46X0hwOSnpDFvNblYPIBFL1nMBX9dMsmhtG45A5O9mOH1MEXdwqVvLmPhhXoTYDJjgYIb7I4AMcRI8D261lyBeNLfbI+T6IJqutRqlCPEY2/OhjsZZgR9SeMHx2+v2wF6F1hq4Oo87YjACm6myTKr2L24QXdE/8oNHBhzZX0bSos1oe85YoyqslPYHEPzxODGOpvz/jtvLjxAUhXoejBGcrHw5F/E9wf1xzrYq6hqq/CxqaYd9iaEr1DXaykG/tJRL0pXzxxEI4JhJoiYJrdGm/kLRR+Qj2U/2plW3cyOMJiqCakRNg9pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lk+eGPeI5rDHjsPqUhb9X8LF5O3iDJFT5LZ+MgrAfpQ=;
 b=dLZXCOIBKKUxiM4VNTNV5LDtMzFHNkIaAMLcC/l7EgUBMmccHTifJUnaoTXT1pGHoQP7zK63VfZjGqEZelfQLAfluFKXSaFRqxRppan8l5/nIea90SjeBqKLP+Ft9YHm2t4Nvybjk+7cAj3ne7UXprOYEm1vX/SkLc4dLwXvXgM=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 14:55:59 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f::4) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Mon, 9 May 2022 14:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:59 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:52 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 17/18] EDAC/amd64: Add get_cs_mode() into pvt->ops
Date:   Mon, 9 May 2022 14:55:33 +0000
Message-ID: <20220509145534.44912-18-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0e1233f-5005-428d-8f89-08da31cc077a
X-MS-TrafficTypeDiagnostic: BN9PR12MB5082:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5082FC522BC2D9F8091DAD86F8C69@BN9PR12MB5082.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mSuQmF+FyNQ9xVXphbKSqAu5tRdLYnGd22UsuINHSNDqswy3IPbxR5dcvEx39QDbaPaYE/ohfzPACcxWQAlf9aRaJjbIw53N2J+wg5OTRh9bUGBDzI8ALRtaX+9/6epgCOUw2ZfS3BWCwhdKmNXHWFX255sIPr+DgyrJvozu64xbDo7hMWu7bj9aGV5E6efsOugNEEkjUlR32vSsl0KqBGmBfNkWzvv6PKJSBO4Lkqmna6dwv+PcEJZb4gpMF2er53prMN14gC65F8YJze6ngfBdMUZv2bDVw4dT01f1FvPmt116d5KDJcVDtuLb4QtuyIwaPw/fMHUb7FzIivl9nTygm1mjICswHHvAGUCOvwDwtCKRZ+P0sTNpMK2ZqsHVCkmI5xBOrz+MbZkZjv1bnkE3FZEgty5GbzcQf6zJyt+5KfcwT81hRiDt62UHM1DwIx7ql1eYHZ9jJEDngZwgtEusZ5pn87Rr2+eyR3hD7RXcUUow31ahzW9QrsfCBcHFv8YJdpZqTP1JMSqxrfs8vem7cAC6BZucbwQXtJ6WjUGCnzlQRrZ7ehKQ0mmhGckLxx5OKpCygVVjSoqWZLXlv+zZPoR/d2DR0lp07h9IwqlO4zexoxPo+sWiweMXh9gNZpOXDA2MZ4OLOa1/o19ZzcefuWPEQXCwoKRIhuKIOMTl1M/9oa8uEHyMxVKs+i4OAAa8lylfFAIiNrw6lKxKzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(2616005)(8676002)(70586007)(8936002)(1076003)(81166007)(508600001)(426003)(83380400001)(336012)(186003)(70206006)(47076005)(4326008)(26005)(86362001)(6666004)(316002)(82310400005)(54906003)(7696005)(110136005)(40460700003)(356005)(36860700001)(2906002)(44832011)(36756003)(5660300002)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:59.3189
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e1233f-5005-428d-8f89-08da31cc077a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
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

GPU Nodes will use a different method to determine the chip select
mode used on a controller. A function pointer should be used rather
than introduce another branching condition.

Prepare for this by adding get_cs_mode() to pvt->ops and set it as
needed based on currently supported systems.

Use a "umc" prefix for modern systems, since these use Unified Memory
Controllers (UMCs).

Use a "dct" prefix for newly-defined legacy functions, since these
systems use DRAM Controllers (DCTs).

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 21 ++++++++++++---------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b4c9d224f564..248d1082736e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1341,7 +1341,14 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 #define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
 #define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)
 
-static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
+static int dct_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
+{
+	u32 dbam = ctrl ? pvt->dbam1 : pvt->dbam0;
+
+	return DBAM_DIMM(dimm, dbam);
+}
+
+static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	u8 base, count = 0;
 	int cs_mode = 0;
@@ -1383,7 +1390,7 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 		cs0 = dimm * 2;
 		cs1 = dimm * 2 + 1;
 
-		cs_mode = f17_get_cs_mode(dimm, ctrl, pvt);
+		cs_mode = umc_get_cs_mode(dimm, ctrl, pvt);
 
 		size0 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
 		size1 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs1);
@@ -3324,16 +3331,10 @@ static void dct_read_mc_regs(struct amd64_pvt *pvt)
  */
 static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
 {
-	u32 dbam = dct ? pvt->dbam1 : pvt->dbam0;
 	int csrow_nr = csrow_nr_orig;
 	u32 cs_mode, nr_pages;
 
-	if (!pvt->umc) {
-		csrow_nr >>= 1;
-		cs_mode = DBAM_DIMM(csrow_nr, dbam);
-	} else {
-		cs_mode = f17_get_cs_mode(csrow_nr >> 1, dct, pvt);
-	}
+	cs_mode = pvt->ops->get_cs_mode(csrow_nr >> 1, dct, pvt);
 
 	nr_pages   = pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
 	nr_pages <<= 20 - PAGE_SHIFT;
@@ -3755,6 +3756,7 @@ static struct low_ops umc_ops = {
 	.determine_edac_ctl_cap		= umc_determine_edac_ctl_cap,
 	.init_csrows			= umc_init_csrows,
 	.dump_misc_regs			= umc_dump_misc_regs,
+	.get_cs_mode			= umc_get_cs_mode,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
@@ -3773,6 +3775,7 @@ static struct low_ops dct_ops = {
 	.determine_edac_ctl_cap		= dct_determine_edac_ctl_cap,
 	.init_csrows			= dct_init_csrows,
 	.dump_misc_regs			= dct_dump_misc_regs,
+	.get_cs_mode			= dct_get_cs_mode,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 4e7467c285b9..1f64c08ae0ce 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -479,6 +479,7 @@ struct low_ops {
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	int  (*init_csrows)(struct mem_ctl_info *mci);
 	void (*dump_misc_regs)(struct amd64_pvt *pvt);
+	int  (*get_cs_mode)(int dimm, u8 ctrl, struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


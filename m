Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26299520075
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiEIPAP (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237915AbiEIPAA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 11:00:00 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1505624BB3C;
        Mon,  9 May 2022 07:56:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lart38qQF3Ixr4PDpYS9SC61KZpO7TYWLkkDoKfp7e8wglbuJJO5T2zW4cOP83tRWjcJg0MzB6efhJaup+RNauloLSzKbTg77MIMArghDtu5jfPhoEo7xhx9wseBNIznSwzMqeQexZ2tMQyvHawjVd591VS1wFwKp27+v+/cNVdA2Fn5bbsHkWRdYUXNhzmqD7RQLnZyZdMBDkk1cG1jX8kEqkQX4h9swp90G7NzflYoFIqehFQdC24eKpCsse7SR3opgzJ3ce/MtgVLKmT++7G2FCSP7pBfWNZprxanfzoz3/nqtkq1mNEiay8La0pl9kxV1Dr6DK5J2dRdaqYNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/9uipsGXJHM3Xgxbxirb1tYrINsZH6/D+fhAqxkgIc=;
 b=fpuzaLJyZmNHkOFbXTAWC79DVLWR1cvqF1ebGC3T3QTAuOZGiJjyHspE47pq/s2yqXxU0lKauMAxtMD1IQBVha66SBzsEd10l+Daislxqyz2nEoBaCIt8LX5cnzJBmnabwEV2Annlp64blm5ttnunffRjOLdmgEipM/1PamcrrYSSkeR272wp84dRQQk08AaAn1lZZmCoy4Q8grjZTP0fv6WHERSIuQMbpc9QbVqdrXgMX859NIk/jeFOKHD/dUJBxM5cgjEMKKYwBHLUjoiNTKB4IlUVVvAWoBvFJ2wuXUUd6YU1AxkVTDOy2uAq1EndmK+sN6aIpZ0BoX4fQGLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/9uipsGXJHM3Xgxbxirb1tYrINsZH6/D+fhAqxkgIc=;
 b=NdvPJMiAWQxOlX3QpefRpqNZ7sq008Vx7z0KMVnjXGjcz73uZcKjpUCBXdyJlgfU5TcbhpSYyHyK3mrZuuIEqFpw1GIvTKe83AAJX7/Lq1Co7xid2lkvX42pDNz7FRtcPIeopAwVppZb+8CogjWafPrt043wc2PIXlJScWySs3Q=
Received: from MW4PR03CA0221.namprd03.prod.outlook.com (2603:10b6:303:b9::16)
 by CY5PR12MB6276.namprd12.prod.outlook.com (2603:10b6:930:f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 14:55:59 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::7d) by MW4PR03CA0221.outlook.office365.com
 (2603:10b6:303:b9::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Mon, 9 May 2022 14:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:58 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:51 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 16/18] EDAC/amd64: Add dump_misc_regs() into pvt->ops
Date:   Mon, 9 May 2022 14:55:32 +0000
Message-ID: <20220509145534.44912-17-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1773b72f-abe8-4fe4-b29c-08da31cc074a
X-MS-TrafficTypeDiagnostic: CY5PR12MB6276:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB6276CB465E83FF411CEA5D28F8C69@CY5PR12MB6276.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3s/Tep/cilmP+pUCKLZ0kyEdP83Tbbm2e6codtvCcWZvhkSCmkhRuu1QxqAgZbKYw96cFUk/OexZP1b8vP4zKuKebH7JlK7zQKUyhvOLYn0DuQBTmRxjycdHQgE8EBlO++48dXAe6Z/3xmmlusBNxTfTWyjOWLwqmaMN12DDxnf+gpg98d51l+sq1cNA2jp2uFi/fiUh8xlv5B0HRRIkTsDnTk8nPcUbx26shYZ0nuz+q/8jdWvYSBFIoE5yxl+wj+5ctu3yimWKqyCmnaYQ20S4W2olFXBlBPd5yNjbiL87SbXDGmtjhiRaMUsXIEex7L69Uyy9JKEnxjp61I0/VnNxRDpDqirOCwHZ3+esBU3jFFG0jtqXc1ozlrocUqOVrIMlnELtA/IqPi3FNcidJtVeM6/gJ4SYDF9reKBosbPmHz6T5tG08YSk2Q5EcIWmBVf+b5JEKLURvIO19bFtWZqImU76tFWlO4DHQ5P9Ska0cSkq4C+AHo+kLJYM/2FD7kYdEA9yDUZlT+Iz6emnduPyEJ27+JAXEaZGYp4M0QTZlL5VswYQgn/LMnjDa+KF7N+5GhrM7P1Mujz6EhZR3RmSDgTvUj1rI1JZkthNo9jJOSkZgTqCPl86XBpeQOjBCCpN6cO4fosDekbsSkjiajSJTFMPsqoQNft667UAKO4evBoyLmbgdwhpkgNqxnnrsDBU8kWECdyHhnbfs/WScA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(316002)(8936002)(36860700001)(110136005)(16526019)(54906003)(8676002)(356005)(4326008)(86362001)(70206006)(70586007)(44832011)(26005)(83380400001)(6666004)(40460700003)(7696005)(186003)(1076003)(2616005)(426003)(336012)(82310400005)(2906002)(47076005)(36756003)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:58.9896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1773b72f-abe8-4fe4-b29c-08da31cc074a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6276
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

GPU Nodes will print out different information and registers compared to
existing systems. A function pointer should be used rather than
introduce another branching condition.

Prepare for this by adding dump_misc_regs() to pvt->ops and set it as
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
 drivers/edac/amd64_edac.c | 21 ++++++---------------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5beeeb2fd6a8..b4c9d224f564 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1394,7 +1394,7 @@ static void debug_display_dimm_sizes_df(struct amd64_pvt *pvt, u8 ctrl)
 	}
 }
 
-static void __dump_misc_regs_df(struct amd64_pvt *pvt)
+static void umc_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	struct amd64_umc *umc;
 	u32 i, tmp, umc_base;
@@ -1437,8 +1437,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 	}
 }
 
-/* Display and decode various NB registers for debug purposes. */
-static void __dump_misc_regs(struct amd64_pvt *pvt)
+static void dct_dump_misc_regs(struct amd64_pvt *pvt)
 {
 	edac_dbg(1, "F3xE8 (NB Cap): 0x%08x\n", pvt->nbcap);
 
@@ -1473,17 +1472,6 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
 }
 
-/* Display and decode various NB registers for debug purposes. */
-static void dump_misc_regs(struct amd64_pvt *pvt)
-{
-	if (pvt->umc)
-		__dump_misc_regs_df(pvt);
-	else
-		__dump_misc_regs(pvt);
-
-	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
-}
-
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
@@ -3766,6 +3754,7 @@ static struct low_ops umc_ops = {
 	.determine_edac_cap		= umc_determine_edac_cap,
 	.determine_edac_ctl_cap		= umc_determine_edac_ctl_cap,
 	.init_csrows			= umc_init_csrows,
+	.dump_misc_regs			= umc_dump_misc_regs,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
@@ -3783,6 +3772,7 @@ static struct low_ops dct_ops = {
 	.determine_edac_cap		= dct_determine_edac_cap,
 	.determine_edac_ctl_cap		= dct_determine_edac_ctl_cap,
 	.init_csrows			= dct_init_csrows,
+	.dump_misc_regs			= dct_dump_misc_regs,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
@@ -4093,7 +4083,8 @@ static int probe_one_instance(unsigned int nid)
 
 	amd64_info("%s detected (node %d).\n", pvt->ctl_name, pvt->mc_node_id);
 
-	dump_misc_regs(pvt);
+	/* Display and decode various registers for debug purposes. */
+	pvt->ops->dump_misc_regs(pvt);
 
 	return ret;
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1b879c3cfb36..4e7467c285b9 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -478,6 +478,7 @@ struct low_ops {
 	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	int  (*init_csrows)(struct mem_ctl_info *mci);
+	void (*dump_misc_regs)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


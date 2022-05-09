Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDC0520085
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbiEIPAN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237924AbiEIPAB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 11:00:01 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD73826AD96;
        Mon,  9 May 2022 07:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5RhS3GNaFRKxwq0Jeuvl2xK7DN5eu/uTeGDVGUxmWQbJ8E3q+ErJUq01vm9gtZmpa4IYe7G2H98QYXb5lzF66F0Fcn3S0bzYXHUVhxA4azP3rTG+hrFkhfgCoCnRdbS3hVgDHFO72zMaml0sBdsSiMyjUuea4sndxWUOy3Cm4CetzU8bz+5ebeC+LqfT2k8KWYn5e4D2Q7D9etLWzj+RYMsZQjgzKOajF0srN0FPKjNKQkeENOBLj7Vd/hFWorPEcMwyAm4kFT04BNjns/ASrnibQNEYs1sGy+3c1DBagyZ0jE3FlkKlYPUa5f3xybwWn4byqGo8sxZCPgsONnOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcrUouRoDm/a16hih5Lg6+RJB/Zpivee3AE40dDK61Y=;
 b=en7HzdEWlM7vNHesJpxygnL6CB4xss12DaBReby1BvhrUkYi9WZLrIw923gWNeoGwVFOy3heThxojFP1/X2sGvKEpBip0gMZUEZYloe5QwMLamTTjraDH+eTirFDuZLaDdPKiwH87kTObDM86+LGlAXj6iPqjDeh+LvtOnrXIbzb8P+xtjIqqb8y9/3djwYAAEGg19GaHdBue3cPVcBHhcdaan/6QAttM0QkOO900tJPhTy8KbhUqrYTUR9byhrKG8zUb2Glj98M7GnpO02hzv2mq+uMJ1hl5e/rtYySLqSLRBU4CYfFpbyhJ+KUJfVZAMS3GJ76vPy23O7c5IfkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcrUouRoDm/a16hih5Lg6+RJB/Zpivee3AE40dDK61Y=;
 b=1zO8NGXujps/zrcUfnNyz37zcwKnbBejvEQzG/Ybu/SHNQxbe3xqoP6/lbr3rIE5efmc40irKirQFNgN+yxNLuyYl57uIcwhg+wYFQrzRvkmIxJ56Vw62kQ1eOeI34gT1cYhj0wRe6F5VO1tocKpL3K3bUobkDTSNSMM+2ZPw0I=
Received: from MW4PR03CA0001.namprd03.prod.outlook.com (2603:10b6:303:8f::6)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 14:55:59 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::59) by MW4PR03CA0001.outlook.office365.com
 (2603:10b6:303:8f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 14:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
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
Subject: [PATCH 15/18] EDAC/amd64: Add init_csrows() into pvt->ops
Date:   Mon, 9 May 2022 14:55:31 +0000
Message-ID: <20220509145534.44912-16-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3fef4685-f6e9-4721-0c40-08da31cc0714
X-MS-TrafficTypeDiagnostic: BY5PR12MB4163:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4163005F5BC7BE54825F7098F8C69@BY5PR12MB4163.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f3g/Y/+9OjxWa2Q9sSpMp5ey4C9JLrD8Us6uOp4wm9ZpRs4gbuf7au5N5POEytSnp3tObu67/5jql6dATgsSUKF5NWz0n94tJt+Rx5+O5PKPAzICGYEa+ENVkdRoo7XDZJakA+dfuFIvRaLo7OqsfCSIDDJeA6Gm9I/VDHhZEXb8JQ/+2nPY//WVjDlMS433fdS+fYy1++e2UeNKYQZCx/OREvkRi6ldxKeXPaehyRRgGI88nNR0lCkG9BELnRQZYUT7dcp4P5ppGKdKjFQgRBqv6A0FmFHq3CwZ5gK04kkjSIQXHYZ+UdayQ00uclwD4cMM22LoFDLeTiQGtrFtaRAEGqYOrOG/2LUGC5W004SR6mgBE7uaq2fAqJ1tW4oPZgM5uAxVl2LH0wXMjhX9CxCOQYNXmBfFnB9saN69IkAbTuCHdLOA4XsC8JxbOSZQJiib/HHCckSuNIKxoLTvedpKQFOC6LVtUBxm9VPZID2bwGLsOEhdc8X4EwFAHrtQY/11E9FQEoIWlDn+IGmd2gCPY7b7yUbMupwbFASaIA38gqz2GOHYMnxDjKZKU+qyBTOwbrtggjanjT+arV6iXae7aIdl9hWa9SnPkE1fjhgGXHnqeXcvnbxiMhYG4bRpCEbiF517OCXwhbVvKdnBNpkr+u6Wx05BJ+GT/dw7gBk1kwjLE8Rlmt+SV5vYBwDWSrTryR06ptn9NiuXeAdGYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(316002)(508600001)(8936002)(36860700001)(110136005)(16526019)(54906003)(356005)(86362001)(8676002)(4326008)(70206006)(70586007)(2906002)(40460700003)(26005)(44832011)(6666004)(83380400001)(7696005)(1076003)(186003)(2616005)(47076005)(82310400005)(336012)(426003)(36756003)(5660300002)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:58.6315
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fef4685-f6e9-4721-0c40-08da31cc0714
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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

GPU Nodes will use a different method to enumerate the chip select
(struct dimm_info) values. A function pointer should be used rather
than introduce another branching condition.

Prepare for this by adding init_csrows() to pvt->ops and set it as
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
 drivers/edac/amd64_edac.c | 11 +++++------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index f1346416e64d..5beeeb2fd6a8 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3357,7 +3357,7 @@ static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
 	return nr_pages;
 }
 
-static int init_csrows_df(struct mem_ctl_info *mci)
+static int umc_init_csrows(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 	enum edac_type edac_mode = EDAC_NONE;
@@ -3405,7 +3405,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
  * Initialize the array of csrow attribute instances, based on the values
  * from pci config hardware registers.
  */
-static int init_csrows(struct mem_ctl_info *mci)
+static int dct_init_csrows(struct mem_ctl_info *mci)
 {
 	struct amd64_pvt *pvt = mci->pvt_info;
 	enum edac_type edac_mode = EDAC_NONE;
@@ -3415,9 +3415,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages = 0;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -3768,6 +3765,7 @@ static struct low_ops umc_ops = {
 	.ecc_enabled			= umc_ecc_enabled,
 	.determine_edac_cap		= umc_determine_edac_cap,
 	.determine_edac_ctl_cap		= umc_determine_edac_ctl_cap,
+	.init_csrows			= umc_init_csrows,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
@@ -3784,6 +3782,7 @@ static struct low_ops dct_ops = {
 	.ecc_enabled			= dct_ecc_enabled,
 	.determine_edac_cap		= dct_determine_edac_cap,
 	.determine_edac_ctl_cap		= dct_determine_edac_ctl_cap,
+	.init_csrows			= dct_init_csrows,
 	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
@@ -4005,7 +4004,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 
 	pvt->ops->setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
+	if (pvt->ops->init_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	ret = -ENODEV;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 93de7dea516a..1b879c3cfb36 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -477,6 +477,7 @@ struct low_ops {
 	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
 	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
+	int  (*init_csrows)(struct mem_ctl_info *mci);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


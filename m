Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8052006D
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237892AbiEIO7y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbiEIO7w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:52 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311BA268E83;
        Mon,  9 May 2022 07:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jq9qBEpgQQLl72KnPsZD897A+C0Dz4+B55DnBGUnteHL/txFLZjwqIiclxZdKBSOWe/y3UgP01oh7p7wx4bQkZU1VJwHnUe5yCmI+DAMjoWF0E51iLk4BoIDJfXnm/7AYw7tFRbCd5spZw7i/leqHRG7UbrtGZd0l4QVCVKmtpqfaIpnmWD+Qxg9B0r4PzClWfzJqVgNgwdYHDuEGTTpJm33edpmmU5kgnNKlhrnHYjtuVHYl0xsW9/kZPoPTr14FFIQHEw/NSXgRdChLB6nHJgllS6CDQY+W00x7mJe6neZZrq0vnrx0hRuD4TQ5W8nRG0fRGgOqITRh8U126yl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wno+7ls8vQ+7dF5/kXS9PGnb4IuwfO/mvL275OgBPQ=;
 b=bgAIoK7/wcthcaer7DZ0PrAOtAxLlZw/NX9Mbo+YRxX21cxZ68JXhKzZWTn2ADbz9DAvDlPVDOHOPgEDqnabfYJcJk7ZqqE1kxOx9ylhB8dqHCmSdkf/eBxVJWExE4Kg/DmHDL9XlNgBhcj2IOG979YBP6i+FHzjr1nJlo5TbhV0woGLgtRBzv3IMC54U1mz0xYYuhDiY5NFIfqiE+I/loZsbdA9r1DPNSoyXFdNWtkM7o5LpfjTQWHvalxGAhK35Wfo/pmt0I4VXOJaDXOQ1mKin2N2cJsh4jQrTikW0g/diBIswue3feCz1+MaSGlLKctVnYQEOX2wB8aYoALA3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wno+7ls8vQ+7dF5/kXS9PGnb4IuwfO/mvL275OgBPQ=;
 b=BAKeOVORcOPK0j3vQEYiRdUnIVWXYkMoS2MqbWI4rdTf8zqH5RJ+F0HZ2+l67Hq4hm2QTExZorDbEjWbuuqHSEPnBu6c71ps2IA1ZzN7vYyiiTZKgbECk4qGLdiFx0NEeo8uHgqJM+Kh03MSc1Dadn01OXZnXF08nCS5/5L8UDc=
Received: from MW4PR03CA0017.namprd03.prod.outlook.com (2603:10b6:303:8f::22)
 by PH0PR12MB5497.namprd12.prod.outlook.com (2603:10b6:510:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 14:55:54 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::31) by MW4PR03CA0017.outlook.office365.com
 (2603:10b6:303:8f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Mon, 9 May 2022 14:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:52 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:46 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 02/18] EDAC/amd64: Remove scrub rate control for Family 17h and later
Date:   Mon, 9 May 2022 14:55:18 +0000
Message-ID: <20220509145534.44912-3-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: d598095f-5a78-41bc-c0bb-08da31cc0349
X-MS-TrafficTypeDiagnostic: PH0PR12MB5497:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB5497BCF6893671A29E0DB8F3F8C69@PH0PR12MB5497.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZZH8WUXB2RX+LbHjS9OF/X1WhGFy40YpfqWhx7XuNrE+vx3Dxd7OF0EMoazn3Y6UWxAx4KHBZebKbG6PL2mxVdvfm5Eqeb2YhQ6pnzFt7SRMRnXgq5Uf6Pp4IN9GN2Ig1lefsNKkilWwIDIJC4szr/TT7fZ0+dqzbpYc08Jq/+6A5RMgfkjaJpmXweobPKStPaeCmOzNW970VkaOyQMy2qYp84DDnsyRQ0/rqdk6WKQ6j9v+pUqY01dkBMgF/E/7vjt3G5+4Z1J/b18nosRgu9JpjFyt5WulrccLUKsZblhCzSJ+khicMOZ+frfcHQz03iKk/+7W/G6k7rnfoNSawN3VXW6uDHMMwkOpUxtnWn8EavRrw1QbfhC5R/Iy1drLwOHgmDknLAu9Rnv7UQyAx1rq7ExJjX8khHom0hvSfgYStOheAU59tEPFnlBy8pbnnmSHmFsaiakfTYWgJw2L+Q/XeNyeTmJqMOgSIfFO9m47xsR+sAuu12buFH04vS4UdqnmUXV7fy26kbgaVXH8b4oLoE1OCe8GPpSH1aTI1pOdWz4VZJRg/LxKzVxC3+D057xbOoDcOvxgrosTNOEDpP0Wm3FngltUB25M2V6pzj9Kb/PR0G3RM6VwwnuSKA/2L2FFbkEY0GkvvRiYYGmtBddEyVYC/S3AgD2CShxMLlIwubIA6fXFa+iYUrCuX10UUXVbfYrRMkkfTYmtutyvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(82310400005)(1076003)(2906002)(36860700001)(8936002)(44832011)(5660300002)(8676002)(70206006)(4326008)(70586007)(54906003)(16526019)(86362001)(186003)(40460700003)(110136005)(83380400001)(2616005)(26005)(336012)(7696005)(316002)(81166007)(47076005)(426003)(6666004)(356005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:52.2569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d598095f-5a78-41bc-c0bb-08da31cc0349
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The scrub registers on AMD Family 17h and later may be inaccessible to
the OS. Furthermore, hardware designers recommend that the scrubbing
feature is managed by the firmware.

Remove support for the sdram_scrub_rate interface for AMD Family 17h
systems and later. Also, return an -EPERM code for these systems. This
matches the description in Documentation/ABI for this file. Also, this
matches the behavior that the OS is not permitted to modify the scrub
registers.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 31 +++++--------------------------
 drivers/edac/amd64_edac.h |  2 --
 2 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 04fa96592317..3ec7eb4ceb4e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -182,21 +182,6 @@ static inline int amd64_read_dct_pci_cfg(struct amd64_pvt *pvt, u8 dct,
  * other archs, we might not have access to the caches directly.
  */
 
-static inline void __f17h_set_scrubval(struct amd64_pvt *pvt, u32 scrubval)
-{
-	/*
-	 * Fam17h supports scrub values between 0x5 and 0x14. Also, the values
-	 * are shifted down by 0x5, so scrubval 0x5 is written to the register
-	 * as 0x0, scrubval 0x6 as 0x1, etc.
-	 */
-	if (scrubval >= 0x5 && scrubval <= 0x14) {
-		scrubval -= 0x5;
-		pci_write_bits32(pvt->F6, F17H_SCR_LIMIT_ADDR, scrubval, 0xF);
-		pci_write_bits32(pvt->F6, F17H_SCR_BASE_ADDR, 1, 0x1);
-	} else {
-		pci_write_bits32(pvt->F6, F17H_SCR_BASE_ADDR, 0, 0x1);
-	}
-}
 /*
  * Scan the scrub rate mapping table for a close or matching bandwidth value to
  * issue. If requested is too big, then use last maximum value found.
@@ -229,9 +214,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->umc) {
-		__f17h_set_scrubval(pvt, scrubval);
-	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
+	if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
 		pci_write_bits32(pvt->F2, F15H_M60H_SCRCTRL, scrubval, 0x001F);
 		f15h_select_dct(pvt, 1);
@@ -251,6 +234,9 @@ static int set_scrub_rate(struct mem_ctl_info *mci, u32 bw)
 	struct amd64_pvt *pvt = mci->pvt_info;
 	u32 min_scrubrate = 0x5;
 
+	if (pvt->umc)
+		return -EPERM;
+
 	if (pvt->fam == 0xf)
 		min_scrubrate = 0x0;
 
@@ -272,14 +258,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 	u32 scrubval = 0;
 
 	if (pvt->umc) {
-		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
-		if (scrubval & BIT(0)) {
-			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
-			scrubval &= 0xF;
-			scrubval += 0x5;
-		} else {
-			scrubval = 0;
-		}
+		return -EPERM;
 	} else if (pvt->fam == 0x15) {
 		/* Erratum #505 */
 		if (pvt->model < 0x10)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 38e5ad95d010..48f1d97e1274 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -215,8 +215,6 @@
 #define DCT_SEL_HI			0x114
 
 #define F15H_M60H_SCRCTRL		0x1C8
-#define F17H_SCR_BASE_ADDR		0x48
-#define F17H_SCR_LIMIT_ADDR		0x4C
 
 /*
  * Function 3 - Misc Control
-- 
2.25.1


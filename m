Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9032F67EBF5
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbjA0RF2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234861AbjA0RFZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:25 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on20610.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::610])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66224C83;
        Fri, 27 Jan 2023 09:04:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS/rckCalngyuwF+cki+zFC8cqP+LT+v4HnbEXL9iYg9U6oLA0sqki6kok0AOJPGEHzEhxXWRtwlrwYIwjqFfTEIan8ryG2Y4UnBIkhHy7afMOaPk+eInNoOcSgwInPvWEF+sUfl2sfTsmCBW7AApR2Xf/U0Mgf/8M6fC5KWphhSlf+rtnd/VjqF0VfQWnqUF17A4I4xgU1ownvAKf/GsRz0FTvTyrLcFanC3lw4emei2mSniiNRAg7SYEZhle3+2FAkuJMa6sN6KAxX0JZLkk+lUspGAZRIK+4iBIzTurGvNBJBTitGvep2Cg38K3X6w/AtWrJmNY9pfQHh72P9ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNL6Z+KjCS6wq6EclvAAUkPpSaXGXQpokOsEFJYeLng=;
 b=DjG3KyCTw4ufI5iSW1Ghc8xHe4RXTv3Zr51PCUY4EPe6pFiRo20UD02VpklyCaT+JBAOhAWCmAQjEp4YJxmQZwjTn90fqPHVuYtMaiPaPBirM1WJ/jHqAQdvoJo7iPBWkCW3GMgCezu0sAQmf/CXN9amkRcX7Qfz89Dz+Cp2RQYJnjbTW71Farmcn9+9YPiOem39MQAZR6phe4dO1b5YwYinBcK2r4+XLzU6Egs8D8juMyuuJ2c2Zg1PSAlU1QqFU5w4E3Yvy7zpTsOlDOjC3rtA5zc2ymTuZca/+iQTdgbwHxO9iUwqlI1Mt0++PVn4P3UuSlkTqiCsEHSbmhSWSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNL6Z+KjCS6wq6EclvAAUkPpSaXGXQpokOsEFJYeLng=;
 b=VcFuic7DiR2O29U5sUcJEd/AQfMZzSfxNvmCpx/Zq6zuMt/oZwZbS0aP13aJ2QLTOxv1NDHtOQhVYlrRW4+nAQ/Hom+ctOtzzPkdpEsd7WOoVClNRbommNqAhpMr6dF7R6gIsde/1X3wfiwmsJCjpaTEpPtEdZ9UMFlYhonutVc=
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 17:04:34 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::1f) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:34 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:33 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 07/22] EDAC/amd64: Split get_csrow_nr_pages() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:04 +0000
Message-ID: <20230127170419.1824692-8-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|SA3PR12MB7782:EE_
X-MS-Office365-Filtering-Correlation-Id: 32616fba-b9bd-4893-144d-08db00889083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6FYtmI6s+KbIDIkWPLReGPFJfFHVBJEfIVSglakAA/jpmtaLGf3gjZ6pHQpLG6M3GDy+sWDpqa88Ky2yZ/SB6b6K+66/31fBstB6KGQh3pXi6E8fI49EdJ85ysCrsQRZ71FAP85y210SyjL1M456PSVVrlZda7/UX5OPjfD+VZ1EkfCJ7EdD6fzImaKdUvDpkY0PlrWVA6f/0tWCvjRIQIwWGo/u8JME2ikCv7Pg2MV9X+TeWxbLiuSAavjgeui9ppNC3o8+/YYUDdWaCt9IuBqJRfxYK+oDFw8Mbg+LfxkoCcuvIemJeXQqNySAL/I8BywJPtABNXW5OVQlMbn/L4KbIAgTcB/Is1Y6KZivtq9aT3KJuHwrMhjIGOKQTzugjbL9OXS9sVou8YeaP7oFsUqQPYeHhzw/o3FnMF8uDFgbziwiQ+3xHQXlpp9ZrOL5x9MMSHbEfda1bTPbvdBCZl8ryIZMMIu9J/CeUSKVtL72OHJH3BdPYRUlldOuYMgn/DtBj7nKVVTMfo7M3A7JHIAJWqMcXz1xgoIj737wITtqcz9++RE7JAj/t3SJWCZMlXccEslnqAGKvd/wXMZGEWvEHPZLbfN8g1CDP4ESaKfaYbdWN2/Bpy2g9ccWrQ5Oul003VP6xB9aahYp8D7VztkNE1dyEXcKe13IAyuc+9FsxoOQ/Zx7Qb1FsZzFmkF2oRVH6nTAbXHzZzhvYSSF379RoFyoUlL0jtWvF83Xpc3wdrlyUw7Wy1G/u6Ly5bvTJnBmIPuUFyx5aSI4YxaYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(36756003)(40460700003)(82310400005)(966005)(478600001)(2906002)(7696005)(26005)(186003)(16526019)(6666004)(41300700001)(1076003)(8936002)(8676002)(4326008)(70206006)(70586007)(44832011)(316002)(54906003)(5660300002)(110136005)(86362001)(82740400003)(40480700001)(81166007)(426003)(356005)(47076005)(2616005)(36860700001)(83380400001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:34.2650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32616fba-b9bd-4893-144d-08db00889083
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7782
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Split get_csrow_nr_pages() into a legacy and modern versions in preparation
for further legacy/modern refactoring.

Also, rename f17_get_cs_mode() to match the new convention.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-1-yazen.ghannam@amd.com

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 40 +++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2d0558aeca28..5559d05fb15d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1392,7 +1392,7 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 #define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
 #define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)
 
-static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
+static int umc_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	u8 base, count = 0;
 	int cs_mode = 0;
@@ -1434,7 +1434,7 @@ static void umc_debug_display_dimm_sizes(struct amd64_pvt *pvt, u8 ctrl)
 		cs0 = dimm * 2;
 		cs1 = dimm * 2 + 1;
 
-		cs_mode = f17_get_cs_mode(dimm, ctrl, pvt);
+		cs_mode = umc_get_cs_mode(dimm, ctrl, pvt);
 
 		size0 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs0);
 		size1 = pvt->ops->dbam_to_cs(pvt, ctrl, cs_mode, cs1);
@@ -3389,24 +3389,36 @@ static void read_mc_regs(struct amd64_pvt *pvt)
  *	encompasses
  *
  */
-static u32 get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
+static u32 dct_get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr)
 {
 	u32 dbam = dct ? pvt->dbam1 : pvt->dbam0;
-	int csrow_nr = csrow_nr_orig;
 	u32 cs_mode, nr_pages;
 
-	if (!pvt->umc) {
-		csrow_nr >>= 1;
-		cs_mode = DBAM_DIMM(csrow_nr, dbam);
-	} else {
-		cs_mode = f17_get_cs_mode(csrow_nr >> 1, dct, pvt);
-	}
+	csrow_nr >>= 1;
+	cs_mode = DBAM_DIMM(csrow_nr, dbam);
 
 	nr_pages   = pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
 	nr_pages <<= 20 - PAGE_SHIFT;
 
 	edac_dbg(0, "csrow: %d, channel: %d, DBAM idx: %d\n",
-		    csrow_nr_orig, dct,  cs_mode);
+		    csrow_nr, dct,  cs_mode);
+	edac_dbg(0, "nr_pages/channel: %u\n", nr_pages);
+
+	return nr_pages;
+}
+
+static u32 umc_get_csrow_nr_pages(struct amd64_pvt *pvt, u8 dct, int csrow_nr_orig)
+{
+	int csrow_nr = csrow_nr_orig;
+	u32 cs_mode, nr_pages;
+
+	cs_mode = umc_get_cs_mode(csrow_nr >> 1, dct, pvt);
+
+	nr_pages   = pvt->ops->dbam_to_cs(pvt, dct, cs_mode, csrow_nr);
+	nr_pages <<= 20 - PAGE_SHIFT;
+
+	edac_dbg(0, "csrow: %d, channel: %d, cs_mode %d\n",
+		 csrow_nr_orig, dct,  cs_mode);
 	edac_dbg(0, "nr_pages/channel: %u\n", nr_pages);
 
 	return nr_pages;
@@ -3445,7 +3457,7 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			edac_dbg(1, "MC node: %d, csrow: %d\n",
 					pvt->mc_node_id, cs);
 
-			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
+			dimm->nr_pages = umc_get_csrow_nr_pages(pvt, umc, cs);
 			dimm->mtype = pvt->umc[umc].dram_type;
 			dimm->edac_mode = edac_mode;
 			dimm->dtype = dev_type;
@@ -3501,13 +3513,13 @@ static int init_csrows(struct mem_ctl_info *mci)
 			    pvt->mc_node_id, i);
 
 		if (row_dct0) {
-			nr_pages = get_csrow_nr_pages(pvt, 0, i);
+			nr_pages = dct_get_csrow_nr_pages(pvt, 0, i);
 			csrow->channels[0]->dimm->nr_pages = nr_pages;
 		}
 
 		/* K8 has only one DCT */
 		if (pvt->fam != 0xf && row_dct1) {
-			int row_dct1_pages = get_csrow_nr_pages(pvt, 1, i);
+			int row_dct1_pages = dct_get_csrow_nr_pages(pvt, 1, i);
 
 			csrow->channels[1]->dimm->nr_pages = row_dct1_pages;
 			nr_pages += row_dct1_pages;
-- 
2.25.1


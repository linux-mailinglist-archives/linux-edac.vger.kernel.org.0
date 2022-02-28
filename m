Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCC24C7185
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiB1QPh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbiB1QPg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCC74552E
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/un5Aw/GeZ6APvA02BKbtCw+unPbjn+Y8R9BK9fPhm9F9mHQuabJk/s1D/wBd+HzPdzoZmbD7iiCRoBuNRRqk59y+Dm/8nDovMniKUAbYfU77fUTuFVAh/GxtxnFLOzgz6QCcbql6A26mShEQARFzdcLKHrngDXovqhCvXION3wi9Mo1Bz0ZjJ9bS54Bq0d+NKiPLrjovzoeNm1y+UqPbDkA6R4XfeYamayXjZUJ4B4EP0N34XFANmayy/BG3yAspH6UttlKfP3hP5WmVS4CZRPAT3iXpknueE+i3NtFSQ9Ra/5fdcDnKUHyqK7+Xia6N9HikYbV9Jrcm/ZQMSjRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzM3y1lugQiwvIid0rTzIUnwcPcUXw1GVHQxhqtPkro=;
 b=Fm6bYMrhDPY13NT5DiT8s6LYhJ1ZIYSFqL2o63Ry4M0LLYaTZ2x7LRgtTUeouhzBjB7kbdd7QOp0VXoYFIYDbWfhT5EPa27Z7aNmC/zN0wq5CknnSL49PpB/QkRDmf4eOgxjUX2L90Re2oeBkxAUx0dccuE24arRoTdrJ7od86WgnyGdtwS5npwM8Gi1j1AYsODt1nI+xRUOQVowHky0Ta48xzS9lMGGe3WUL4WSCdYTUQ6w5p4dFjmfsKwR3zdsJYE15s94L8uKlmeivoq/VAoPrkXFAhJtOWmyGzdvtkmqwKeOI826YkKQM0GZhajS400OgPWShCGqvpPQhiIQIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzM3y1lugQiwvIid0rTzIUnwcPcUXw1GVHQxhqtPkro=;
 b=swe9Qv7T0FHecCXzS7mg4VyRAiVXGLKOc1BmT2uZXQyuaPf96VaclZm+qJ28Wvrf2ZLi+fXHW3VBD0AHExQ57Bzi+PW1MXS+XSb0M8ycAHenCZ32XviylhtbvCkSl7Vkf22l/3WgI51fXGyhEWBDLCNrpql5hh4W3gWvTUE8N4c=
Received: from BN9PR03CA0980.namprd03.prod.outlook.com (2603:10b6:408:109::25)
 by BY5PR12MB3908.namprd12.prod.outlook.com (2603:10b6:a03:1ae::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 16:14:55 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::6c) by BN9PR03CA0980.outlook.office365.com
 (2603:10b6:408:109::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:54 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:49 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 13/14] EDAC/amd64: Add get_cs_mode() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:53 +0530
Message-ID: <20220228161354.54923-14-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f7e9d6f-4064-4ef2-28de-08d9fad574ff
X-MS-TrafficTypeDiagnostic: BY5PR12MB3908:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39081B871A689E6E671F5BB7E8019@BY5PR12MB3908.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mx97QB+ovPdBgVrUgXeDToZ2fTKVNDgQLznMbIvlMPiANesi/tVInWeivzLzIwUfU+yx+gN+M2DOzvrGsIIa3vvZZrpdkcr5/rEnlmXCTM1H1+K2USVJLYbdkUJEAFTNymNWNtsyxHmryimQG7OUbapIOn5wlK0svXLjjA1sXI5NrXNjpw1SH4ZEN8zkDNwXcATj52SjOtoNb0WucNcyVP+4H7wlDdVIXZ6R3d4aVjn9gDd86oOOi0KZyej0eAoVpJ20Hz/mZiMWbTVFIPQYUCpo8sN/6pKa69KR22q1xuxHep2MMZY95mzGWQzUZnM8CZ1dPior6Rt3ELiXrgf3qCxPnB/zqKlCiByweqQtB9r5wgPAIZ8Q4E1u87MdDFPvC334w4B2uvVLrbazG9af3XsniM6WX7u24nQHd/AJ85nFyb7Sj79WQ86FpPxfUEg94pO4x63OfScZrLzCzcD7xDjnDPCg88QDMWP3MBnTx3blKYs1gJhhNhxz5+5ix7HoP3KkmmIx8P8JP/cV7j8evlfKtJTivZChxV+WHfPPBlNr9hDPxByuAZIOOpjPTurGEqvIcDuQnF3ngcvqBsmbFJ+0hgzYj1yplhIxdBK/KI/Esaw4xunG7+uuXNBRG5/gAJrJTeeJ+qsH2hJ3uCaLExlkZ8H6CkQpgBbbnMDgkZsNKA80XpSESASdK6JTtcdsegalHph0zMNHRg9pEVIvc4V3gPACUPFSybNCn5BczpXUPN2QB/xaWrnmN/vAdz9BzV7KgKgvVDDM3x43m4Sc2OSE052BE4rl5KnElhRAHrg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(1076003)(2616005)(47076005)(83380400001)(82310400004)(186003)(336012)(26005)(5660300002)(8936002)(54906003)(70586007)(426003)(316002)(6916009)(70206006)(36756003)(4326008)(8676002)(2906002)(40460700003)(6666004)(7696005)(508600001)(966005)(356005)(81166007)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:54.6868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7e9d6f-4064-4ef2-28de-08d9fad574ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3908
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

Add function pointer for get_cs_mode() in pvt->ops and assign
family specific get_cs_mode() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 23 +++++++++++++++--------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 1063dda20ce9..7a20f8a696de 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1347,6 +1347,13 @@ static void debug_dump_dramcfg_low(struct amd64_pvt *pvt, u32 dclr, int chan)
 #define CS_EVEN			(CS_EVEN_PRIMARY | CS_EVEN_SECONDARY)
 #define CS_ODD			(CS_ODD_PRIMARY | CS_ODD_SECONDARY)
 
+static int f1x_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
+{
+	u32 dbam = ctrl ? pvt->dbam1 : pvt->dbam0;
+
+	return DBAM_DIMM(dimm, dbam);
+}
+
 static int f17_get_cs_mode(int dimm, u8 ctrl, struct amd64_pvt *pvt)
 {
 	u8 base, count = 0;
@@ -3346,16 +3353,10 @@ static void read_mc_regs(struct amd64_pvt *pvt)
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
@@ -3799,6 +3800,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
 		break;
 
 	case 0x10:
@@ -3819,6 +3821,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
 		break;
 
 	case 0x15:
@@ -3855,6 +3858,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
 		break;
 
 	case 0x16:
@@ -3881,6 +3885,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs;
+		pvt->ops->get_cs_mode			= f1x_get_cs_mode;
 		break;
 
 	case 0x17:
@@ -3921,6 +3926,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
+		pvt->ops->get_cs_mode			= f17_get_cs_mode;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3967,6 +3973,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->dump_misc_regs		= __dump_misc_regs_df;
+		pvt->ops->get_cs_mode			= f17_get_cs_mode;
 		break;
 
 	default:
@@ -3981,7 +3988,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
 	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap ||
 	    !pvt->ops->setup_mci_misc_attrs || !pvt->ops->populate_csrows ||
-	    !pvt->ops->dump_misc_regs) {
+	    !pvt->ops->dump_misc_regs || !pvt->ops->get_cs_mode) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 7b377dba0dc7..2c93f8e0021a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -475,6 +475,7 @@ struct low_ops {
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 	int  (*populate_csrows)(struct mem_ctl_info *mci);
 	void (*dump_misc_regs)(struct amd64_pvt *pvt);
+	int  (*get_cs_mode)(int dimm, u8 ctrl, struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


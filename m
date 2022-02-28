Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2CB4C7183
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbiB1QP3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235727AbiB1QP2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:28 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2050.outbound.protection.outlook.com [40.107.212.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7558245069
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMMeQb2i/qnIqc1gy5vuT18TIXfSsOPnB9K8VsgfB1NCbE3lgKGsCFXIjVQ9kFkSrN8CKUgthXat5gSJG3aonvMMBZ3EFhKnxjIg0vAsJG8RpStyKmrHFQ1OnPXEE0NgDWAoEzIe/GqVXiT9dxJOALgnk6I52XmypO51PRptVC6/RbiXbIMkuTtv6OCcDL+Hbd1g8405MWU43+91s0MnKTj3VclpUq7n+sFa8YlkokOqPVfR4V4p8o9wBjpfE5z369oo83nGS48QGbSC5QUtiP/vD9SfII636/NJlSWbK6jYNgKFFfCZyPXVGIDnGl/2eT0nBFt40/8UNGtAFMoO0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmrf5z296cUqYwW4KioylDDXGG3Ffu9nU4YSZhF8IoU=;
 b=PgBw/qfrIt+jTpNWPxcd3SQ/GriKP7el994wbWzS6LpGhZCk+USCmFdqY+zVHvpxSDHfGK0+YmofipzhwA78R1Gb9wJ0fwEJtv/rfwOo1oxOYbKGyS6ZShB3eDHrGKPt2DwCJyqWocahEnCAN2Sh2mlPElKha8z6Dyglku03GKUoptGTRiBfPELFlu8+NZGbLQ65ipIL3+a5kFujxuxGEp8dVQiCXjaShIrObfXbkPSi2a6ZZJnn0JtMyDVtAAVuu3saxLPFMtO6NDQkzKpWPbXQgbpT5oEYfVH0tfOKc/KWBMA86Ix16wLghmCnkhyOLh7SjRMpbQeCDceFCi+Yjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmrf5z296cUqYwW4KioylDDXGG3Ffu9nU4YSZhF8IoU=;
 b=OGo1/qzqc/unmWHvWg+LA3KMJYSOWvhpIRZ7zE5z77vbIFPa7jyA1NQef855B1HsALI2LQVvjtWwdy5HpLXT5YBvlVIbWHQppxBuJZcKc3ZJy4Ge721Zv++Jga+sYKiRQpBbuWZJPScvRtGQHgioq5SI0sUzyDyntGzu6Bkcx/8=
Received: from BN9PR03CA0966.namprd03.prod.outlook.com (2603:10b6:408:109::11)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Mon, 28 Feb
 2022 16:14:47 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::e5) by BN9PR03CA0966.outlook.office365.com
 (2603:10b6:408:109::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:47 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:44 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 11/14] EDAC/amd64: Add populate_csrows() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:51 +0530
Message-ID: <20220228161354.54923-12-nchatrad@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6799f269-247c-4193-484c-08d9fad5709c
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5485:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5485EA649B0B2590B713C659E8019@SJ0PR12MB5485.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAvLfYXjbblkMfUcQfbtz+rwtuCU5kmOiIp2D/T9QZSXEKcdJ+rXK75UwfQo9WOYRh7funf4mF8pPUvZFvTat8YsnjF9dRkKfThV9TTVidXGsEC2mGLTK/4Wn9ai9y+u71Xs8eyKHIXuotlm6LN/Kb83Q2w4euC3SquuTruNHGpUSNaLzRKfothXLZxAMXbxOY+KnbF6SMn7CSrmbwLjETGc2X4cSQ5bP+NHU1pV83EMcoXwKuKzYZNyEw08p40tX7rwPNzIubzHxG/kFUzM4/nVGSBHYcHZBhZP+PPVP7E8JwTDGpyt4w2ZURFqhKNvfFIy1hlka/zy/yIuhKVWPpdlY8AZ2fP8i9G467/CagKThGl0iK+bDkL28V61s2h6Z7NG5jTFVkNA8Qr/2leQglQd2sKlsppipidoESPOG/+wbbNEjDGmp4uC/IA9HyUx63hoO8DGQSecgR6ycE7BsHCUPtttOEAktAjsaK7eTCLLF5lkYEh+peFjXlI43bih8Sfl4BBuxk8vZH136ECXlroaUM+ei4O2MK8Zgf+B2oCNWSd8Iod/GCKk4SOhqx575cQCZoM5STSZAaTxYy3eTQ6yOsKV56TQJ429n8+kwB2RzqZ5cyknlNkjE+i9VZuGwQWiVIRn93+mlFvyUrijIIvuFTAOcNxMoeFp6I9Prn+YiB9NV6NvUTeZLEVoVG4anPxx58CUhsm9OZY2coaXXxvticA+GsNlZXDT+mwKqw5gZ/VKO7TGvWeAe2Jiv5tb5JmHqNBfFdHCucPove6DS0L32wXwIZLwZNZnh1sMvoM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(2616005)(316002)(1076003)(82310400004)(70206006)(70586007)(8676002)(4326008)(2906002)(16526019)(186003)(26005)(36756003)(7696005)(81166007)(356005)(6666004)(966005)(508600001)(54906003)(6916009)(426003)(336012)(83380400001)(36860700001)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:47.3279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6799f269-247c-4193-484c-08d9fad5709c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485
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

Add function pointer for populate_csrows() in pvt->ops and assign
family specific populate_csrows() definitions appropriately

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 13 ++++++++-----
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c86674c3238d..a799594c9574 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3430,9 +3430,6 @@ static int init_csrows(struct mem_ctl_info *mci)
 	int nr_pages = 0;
 	u32 val;
 
-	if (pvt->umc)
-		return init_csrows_df(mci);
-
 	amd64_read_pci_cfg(pvt->F3, NBCFG, &val);
 
 	pvt->nbcfg = val;
@@ -3805,6 +3802,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x10:
@@ -3823,6 +3821,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x15:
@@ -3857,6 +3856,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x16:
@@ -3881,6 +3881,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_cap		= f1x_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f1x_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->populate_csrows		= init_csrows;
 		break;
 
 	case 0x17:
@@ -3919,6 +3920,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->populate_csrows		= init_csrows_df;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3963,6 +3965,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->determine_edac_cap		= f17_determine_edac_cap;
 		pvt->ops->determine_edac_ctl_cap	= f17_determine_edac_ctl_cap;
 		pvt->ops->setup_mci_misc_attrs		= f1x_setup_mci_misc_attrs;
+		pvt->ops->populate_csrows		= init_csrows_df;
 		break;
 
 	default:
@@ -3976,7 +3979,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	    !pvt->ops->determine_memory_type || !pvt->ops->determine_ecc_sym_sz ||
 	    !pvt->ops->get_mc_regs || !pvt->ops->ecc_enabled ||
 	    !pvt->ops->determine_edac_cap || !pvt->ops->determine_edac_ctl_cap ||
-	    !pvt->ops->setup_mci_misc_attrs) {
+	    !pvt->ops->setup_mci_misc_attrs || !pvt->ops->populate_csrows) {
 		edac_dbg(1, "Common helper routines not defined.\n");
 		return -EFAULT;
 	}
@@ -4073,7 +4076,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 
 	pvt->ops->setup_mci_misc_attrs(mci);
 
-	if (init_csrows(mci))
+	if (pvt->ops->populate_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
 
 	ret = -ENODEV;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1ffee0009a53..c762b341650f 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -473,6 +473,7 @@ struct low_ops {
 	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
 	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
 	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
+	int  (*populate_csrows)(struct mem_ctl_info *mci);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


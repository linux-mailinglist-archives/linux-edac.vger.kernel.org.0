Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C8D520073
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbiEIO7z (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbiEIO7w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:52 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2049.outbound.protection.outlook.com [40.107.100.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A64018368;
        Mon,  9 May 2022 07:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B+PUUheyhJHGxZgI8l5HqIqOBeQBvxgdK5pdfxZp7gBV2T4SS/0n6IuIMKTp6jhsPWywqTg+ldjdWuti88qNotKQW2lQcl7w99uYVWQcy/H+ZquQcq+DT+CCm8D4X3tJTQNCC+s7iQhZbPAMhbPQGvTQiO7uNK7VMIkZE9ervCS/hbFglFDNBTWaa1AJ6bZ3C1itpadCQh/DJKbpc5tIfolkf/K/pzgoVORDbasDpaz7RgKKgaudiu5tTsUxerUx3SOCO0ufSiljVadWeLYgUODjKn63YBH5ICfkGAAjA+qUKhaVGqsXoFEb+XUYDCjxyjdwWnFrtR1z0x8GTZ006A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vd+tx1HV8TBhEFCi2OUpe8LwXMdrzIk+C9eZWBM6IL0=;
 b=EsNflnegwZ8WtIbdMq6g0A+t36Cq5W7HMnCPvhJwxuFBHLZF82fXDQuDnDd/6uBXeIwAsMYlu5DX/5aDX/lmI1UxLXzu9Ol+UDberGnyNIb4qlfzFr71YikhM3KU0b46X+/Ewrd8gUlfML6VmOuWgpCAs+5tnw3jmgbSu3SA5Yz+R07DB6pD9L9o4G+5ofSc6UYj/HhAqKzi8HppVzE7EhntyQ6XLtxhnum6OsOsnx/p+nWYHyDUto9C104oAOEAZ+YIKFFGXH3SBCvgo3gr7eWcj92ohw4ZPBqlkCHg5XHFTPNAdLW84roK3uf3bZ3lHxDa+CoVD7ZLDvOW4Iy+Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vd+tx1HV8TBhEFCi2OUpe8LwXMdrzIk+C9eZWBM6IL0=;
 b=fH2gcdHUBivje+avS/TzHJ6Ad7xhKpBSYAbnvoEcCK9JWZ9qlgTHkK91qbQ+UvT03THSGxR65ceJCzdrAZyrqS4yrFQpAUH485gVmOFX9xLlEKCOH6hisL6yQPl9seMA3spdLdZY7CwW3PzmgVXXinz7DAqUbK6D+ZcVg1IbyMI=
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by BL0PR12MB4691.namprd12.prod.outlook.com (2603:10b6:208:84::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Mon, 9 May
 2022 14:55:56 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::9b) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Mon, 9 May 2022 14:55:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:55 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:48 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 07/18] EDAC/amd64: Add read_base_mask() into pvt->ops
Date:   Mon, 9 May 2022 14:55:23 +0000
Message-ID: <20220509145534.44912-8-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7528b3a-4d69-4d4b-c5d4-08da31cc055f
X-MS-TrafficTypeDiagnostic: BL0PR12MB4691:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4691FE40932F65F46B907FE0F8C69@BL0PR12MB4691.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qFLGaqJu5jIFC7t7iQzxIdUACCvAmGOLqvXYYqVg/DuzPZk6HhfMzIBqe3wE9CE+/Vkl7zKzvx/hOe8xcWPOMDBI60ayKTkhBBoVraNtiVdpZHdGz7KZXc3h++wjdgnUZlMlsT1KMFas38DrN7jbo0j1af6nTKkAS2CD1NnBkhd/9WHEy70Ct7QOy6eBpsAq77vQiiHa/ADapJLBvf4bzv1nL6zASqNSM+P7PWQJmMuq4QaO1LCHUI2HhpFe3vBe9ScD4WkPHh85/4YnssenWHkESnIfqXq/dBeAmMlReYpQasOg0eLCyDIl20NTp+xh3tgXuC5GMRgTVuFE25vLpS1Ssim8isoYvuJzCX3KGzAc+ugDfi3KjpcWNLeGuQWCDtLRkn5Oekdd7immDHSJlHyXwHG+JqX0CQSqVerdBvhv0+5DFRzAqVTcUyKRAy55RxPZv7Mh43b80mj+UGKnoh7FhTodCsd8MwqorXz6mDs4fgGW9iSITScUveyyn/ggxEAfDUgxPHSi5GAvtffNEG8t9z33Tlfjyu8QdOkkY8BC6meorkmZXlTqR3urvdevvGY8dD+FgvSVeYRT8at0w0rNW/4WjD3V02pEbF9k/5cIbAfz9dxT45cAxOBpm1LPQj1hL1Xsj8PlNGiNN8El/ZoMaNM8tjWkQIvPyXEYyr8mR5YcKmiUQAxJSFcsCx1us21+s0RgymYjf2xxzpe8bA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70206006)(316002)(426003)(47076005)(508600001)(70586007)(44832011)(186003)(7696005)(16526019)(81166007)(2906002)(36860700001)(110136005)(40460700003)(54906003)(8676002)(4326008)(336012)(6666004)(26005)(356005)(82310400005)(2616005)(83380400001)(8936002)(1076003)(5660300002)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:55.7879
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7528b3a-4d69-4d4b-c5d4-08da31cc055f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4691
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

GPU Nodes will need to set the read the Base and Mask values differently
than existing systems. A function pointer should be used rather than
introduce another branching condition.

Prepare for this by adding read_base_mask() to pvt->ops and set it as
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
index f8cd89278753..6e26bbb73f81 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1507,7 +1507,7 @@ static void umc_prep_chip_selects(struct amd64_pvt *pvt)
 	}
 }
 
-static void read_umc_base_mask(struct amd64_pvt *pvt)
+static void umc_read_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
 	u32 umc_mask_reg, umc_mask_reg_sec;
@@ -1561,13 +1561,10 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
 /*
  * Function 2 Offset F10_DCSB0; read in the DCS Base and DCS Mask registers
  */
-static void read_dct_base_mask(struct amd64_pvt *pvt)
+static void dct_read_base_mask(struct amd64_pvt *pvt)
 {
 	int cs;
 
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
-
 	for_each_chip_select(cs, 0, pvt) {
 		int reg0   = DCSB0 + (cs * 4);
 		int reg1   = DCSB1 + (cs * 4);
@@ -3303,7 +3300,7 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 skip:
 	pvt->ops->prep_chip_selects(pvt);
 
-	read_dct_base_mask(pvt);
+	pvt->ops->read_base_mask(pvt);
 
 	determine_memory_type(pvt);
 
@@ -3765,6 +3762,7 @@ static struct low_ops umc_ops = {
 	.early_channel_count		= umc_early_channel_count,
 	.dbam_to_cs			= umc_addr_mask_to_cs_size,
 	.prep_chip_selects		= umc_prep_chip_selects,
+	.read_base_mask			= umc_read_base_mask,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3773,6 +3771,7 @@ static struct low_ops dct_ops = {
 	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
 	.dbam_to_cs			= f16_dbam_to_chip_select,
 	.prep_chip_selects		= dct_prep_chip_selects,
+	.read_base_mask			= dct_read_base_mask,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 0a7738df396f..c81cc7f5fc96 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -469,6 +469,7 @@ struct low_ops {
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
 	void (*prep_chip_selects)(struct amd64_pvt *pvt);
+	void (*read_base_mask)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


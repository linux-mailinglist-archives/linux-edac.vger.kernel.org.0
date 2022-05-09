Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8944520068
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiEIO74 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237884AbiEIO7w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73471E029C;
        Mon,  9 May 2022 07:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SueeOEINKJnnJjtoCM+ZjGMWQcFzh8A2hb41cLWHGJclJTsIZd75+zbmSseOeGcwaYL3/knPMONPYLqMf9ORWzaCyOTZDw8jzQGwbYM5yrETEdB7Oh+L+UnT1li+4rhTSmsJvII+Sz2mUhY04rTMRRE7ymUkD+flTqHsmJIuJlXyKqDPsRS72BHf4uXY0qWf+mdEPWJh87KBZYo/s/kyJ2Vzgvf5km3ViQJ6O1u3+jDxzTkmfM6YU9nOQpUKI2qegPHClHUZuJOu+edFmMXKhNrcYkUZjfXJKx/moz5+ZXzJrRpyp5nj5emJExLpzX73N5mygQN13hiyVv6odYq//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6viuKJ5ijqFe/qBbXl8RLDjPmH2QQGrl51fM07ApIGo=;
 b=dgvGV9LIvHLOeI64JoxpSZqRsukK7+FDo7Hw8BStAoak8mlAiTB4eEQyDUjyFDHtN9lInhFFiwpQiShOFuyWNVPpPRzgInnT+GoSqPJad6RDYQqzCLPZgUSI7wHgTBR+kcr02OWUH74xaa5sPcCsZC465mMGmRtDVfTUOzppc6eYfFEwP2YVzfT58Cdl0XNMQuduqKNk6833QmImuWRd/LHnFe79IeaUsQYnlt+YTYlEdjyGbyPD+s5GiykH3qSqBJA7Z7s6SA/frztTr8XWkfkTFj5uLm+3h5mddrJIwYnEcuTZKR6P1rPLFABW+HhGfqBNkB7HY9JE3nCK9EMjoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6viuKJ5ijqFe/qBbXl8RLDjPmH2QQGrl51fM07ApIGo=;
 b=b8BDAVfUkwxsVGnf/D8yM4F9mp7nzXLPsqFdDGF6ru9mpQateuSaeICtqI6vvNeSEycGKUp8Ui/ja6EIRPqZkOPRVZ9JzF/v+WJ8mnJhTSffXYLeRUmo1atNBO9pN/4zLReKy8CKwaxVCyYM+fuomgoxSKk1cO6vbjVSShWGgd8=
Received: from MW4PR03CA0312.namprd03.prod.outlook.com (2603:10b6:303:dd::17)
 by BYAPR12MB3573.namprd12.prod.outlook.com (2603:10b6:a03:df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:55:55 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::43) by MW4PR03CA0312.outlook.office365.com
 (2603:10b6:303:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Mon, 9 May 2022 14:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
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
Subject: [PATCH 06/18] EDAC/amd64: Add prep_chip_selects() into pvt->ops
Date:   Mon, 9 May 2022 14:55:22 +0000
Message-ID: <20220509145534.44912-7-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6f4a49c8-21cb-4b07-9c88-08da31cc04ee
X-MS-TrafficTypeDiagnostic: BYAPR12MB3573:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35732C5812A8AE06FD43F830F8C69@BYAPR12MB3573.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pI8m5LIG4W6dNXwq2WMATFt6GyQiu76EQ/LyarHY1MEBNI9tQYakmJ4RJvXNNvWIMVQi9vVjEti2pmzXpmY9UYtcXEm2svA3poUGFsOzLFslNyWdc3c3v3nXVSFXnhEoV6CgGewBj9IA6R5JCaDlOHV0gdKzSf718Xs31ZsyDgueizxhCxQHsVO8/gLI+xsZ6wGO7az3YzghWXsSU+LwOdGSx1C5kS+K/iN8+YVM8XadxUyDztF/iKlsgS8F5Z3SQk0GHs6Q7AlGOOdgSVltJqeVmtS5HYRZrQcl/CbAvJ76HGcX8jNyQi4UuoLEWF6C6kIjFyQKhS+Rs5+NHSwpIWB8YB7qYEULhifMh8C9IZK+IQHrFFlYtnJrfOyiiyLPboZ40Wkv3gpeKvCGcbJsRUS2Tymo0BMFjL8Rm93uYmVjlVNNN6UPs4PWIj1OFwYdPcEFKLz6Afdgby5GVsRKSPvBJKCcMSQbye1wPJIcSOhtL3FH/9DyfwhiVTM8Df4clTxDKoYnr0267EPa5QnuHcSb+RW9v8YFft209611v+WnxL3n54NS95fWc1UkZ4ufKM2g68SKiImHSC6SXtwCxnPrdSsENfZ+1PclOo5OIXdi7mpUl4gbKzRqDLE907H7sOvWxXQAERw4oZ2M/vbuZY7LUOvy/m/3mdSrx1Gg+MuZCQ2zNQL2URwB1K6Y676gJzm9cD4Tm12o8JF7OPv1rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(186003)(508600001)(16526019)(36860700001)(2906002)(1076003)(110136005)(44832011)(26005)(2616005)(36756003)(47076005)(82310400005)(40460700003)(336012)(426003)(6666004)(356005)(7696005)(86362001)(5660300002)(8936002)(70586007)(54906003)(70206006)(8676002)(81166007)(4326008)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:55.0307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f4a49c8-21cb-4b07-9c88-08da31cc04ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3573
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

GPU Nodes will need to set the number of available Chip Selects, i.e.
Base and Mask values, differently than existing systems. A function
pointer should be used rather than introduce another branching condition.

Prepare for this by adding prep_chip_selects() to pvt->ops and set it
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
 drivers/edac/amd64_edac.c | 26 +++++++++++++++-----------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3d569290d4cf..f8cd89278753 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1483,7 +1483,7 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 /*
  * See BKDG, F2x[1,0][5C:40], F2[1,0][6C:60]
  */
-static void prep_chip_selects(struct amd64_pvt *pvt)
+static void dct_prep_chip_selects(struct amd64_pvt *pvt)
 {
 	if (pvt->fam == 0xf && pvt->ext_model < K8_REV_F) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
@@ -1491,20 +1491,22 @@ static void prep_chip_selects(struct amd64_pvt *pvt)
 	} else if (pvt->fam == 0x15 && pvt->model == 0x30) {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 4;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 2;
-	} else if (pvt->fam >= 0x17) {
-		int umc;
-
-		for_each_umc(umc) {
-			pvt->csels[umc].b_cnt = 4;
-			pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
-		}
-
 	} else {
 		pvt->csels[0].b_cnt = pvt->csels[1].b_cnt = 8;
 		pvt->csels[0].m_cnt = pvt->csels[1].m_cnt = 4;
 	}
 }
 
+static void umc_prep_chip_selects(struct amd64_pvt *pvt)
+{
+	int umc;
+
+	for_each_umc(umc) {
+		pvt->csels[umc].b_cnt = 4;
+		pvt->csels[umc].m_cnt = pvt->flags.zn_regs_v2 ? 4 : 2;
+	}
+}
+
 static void read_umc_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
@@ -1563,8 +1565,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
 	int cs;
 
-	prep_chip_selects(pvt);
-
 	if (pvt->umc)
 		return read_umc_base_mask(pvt);
 
@@ -3301,6 +3301,8 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	}
 
 skip:
+	pvt->ops->prep_chip_selects(pvt);
+
 	read_dct_base_mask(pvt);
 
 	determine_memory_type(pvt);
@@ -3762,6 +3764,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 static struct low_ops umc_ops = {
 	.early_channel_count		= umc_early_channel_count,
 	.dbam_to_cs			= umc_addr_mask_to_cs_size,
+	.prep_chip_selects		= umc_prep_chip_selects,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3769,6 +3772,7 @@ static struct low_ops dct_ops = {
 	.early_channel_count		= f1x_early_channel_count,
 	.map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow,
 	.dbam_to_cs			= f16_dbam_to_chip_select,
+	.prep_chip_selects		= dct_prep_chip_selects,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index a4a27208532c..0a7738df396f 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -468,6 +468,7 @@ struct low_ops {
 				     struct err_info *err);
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
+	void (*prep_chip_selects)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


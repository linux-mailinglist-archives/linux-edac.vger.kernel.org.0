Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0DE480CF1
	for <lists+linux-edac@lfdr.de>; Tue, 28 Dec 2021 21:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhL1UGe (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Dec 2021 15:06:34 -0500
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:4302
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237215AbhL1UGe (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Dec 2021 15:06:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TihtZ9k47+6C4YRvXERp5oMWotGTvKnfwaFalR7LPO3ufaqyaPXdwvkoG+JctZcfZ4kux4qs8vblzlDgPNNeZSSPjjqzuE5hP0h/3oDWHxSOW6GomeaZ0OEwo44yzmksMCjwsKMCkSK8uL+OwkG3RJ9bpR0hvANYkez5I2mTAjeSBiR7XH0z1kXHJZgav7IPhc9FGSL5ZKJhSSL3zb0OlwnfSnKUeuVZO3ZYKTNU8FYs/X78BEg2HahkcjpcED4WJDo0q61cWxlGwf1nTDqJSDWitsvO9zjwVJzv+CwKGTNLQSnhImI/7KYfBr/0W27XkB2nShLsoOQxEWtdeIy74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfnzpBiDrcO2j1o6SQfHzzWNK4guRrHo1MexXKf0pL4=;
 b=EaRYYw8W7OOhN7bG+Cds6KoGP7dZdBh68a5x3bdogF4fJ4eNhUk6GzBJnrQSs6QgaMVkLxZxM1TH2DfU/fEmxuqdWt1eziJUMzMafVl468iVkohkdfc40cvquXJ/OtNO/Zv7lS0bP0daEhHPksGcrMp7QzLCAWj4799Iie5S5ttF/5x+Gx+JKqMBBhiJbmgDSXqyB0PWWhPfPggNJWoP1gYIGOzvfLbhCEBAw5hyroq3A4ch5EIw0SydNCLQ40ss/hLkgXNCPX9jdJUf5DMBFcVv4gmBeeZdqlg9Qs9CEM3Gf5e5DRLQtuUkEooYcqk6TvxU5848nZyHA6kyCkusKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfnzpBiDrcO2j1o6SQfHzzWNK4guRrHo1MexXKf0pL4=;
 b=U4zfQ3EtPMFsw94uPfWpLwCUSTV73WaYZu01+SRoLoOoVbITxvBSNktHt/IEUSESjbq9A1CDlvAfywFIcssyZUPnsD5vnNsX9dGikLRdw3V42t9k4OGVdKTK30Qvdj0DDVdNwdczb+70MdZNLbW3EkaQkkL4bER3QoGrSrhp8m4=
Received: from BN0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:408:ea::34)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Tue, 28 Dec
 2021 20:06:32 +0000
Received: from BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::a5) by BN0PR04CA0089.outlook.office365.com
 (2603:10b6:408:ea::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19 via Frontend
 Transport; Tue, 28 Dec 2021 20:06:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT039.mail.protection.outlook.com (10.13.177.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Tue, 28 Dec 2021 20:06:31 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 28 Dec
 2021 14:06:31 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v3 1/2] EDAC/amd64: Set memory type per DIMM
Date:   Tue, 28 Dec 2021 20:06:14 +0000
Message-ID: <20211228200615.412999-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228200615.412999-1-yazen.ghannam@amd.com>
References: <20211228200615.412999-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 360f4765-3d77-4431-2314-08d9ca3d8ac0
X-MS-TrafficTypeDiagnostic: MW3PR12MB4412:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4412BE4C33006506C2E39B2BF8439@MW3PR12MB4412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AlT2g7uCu06ZT5OxE08lOWQujDDP4AGASLk93ruBLeH9NnfZ/0WXyrbFp6yKQNFvr90z09CqkOhtBlk7Aa4vs7wZxcbi9tNGrT5HDG1e7LBosXmbzde+jRAT/XVwA5+e17lR1/XhYh2K/9FeTi5mth8Jj0wMlDRSvo3MyuIFuUlaR1Ox87oSOxa0JcZZKooZZf/9KlzNd+wbZ4GkfgON22syu3yuYp7Ea6Ju5T3Ls5nWQGD195LVpGh96i75586rR+h3bxSPRL741G1ejKU8AqLy72VCg9X8liIJyfNornrqNwYHB7KFyeYJezBw9BHm4jPGtgMgnNbqAbonv+6nk+cqR30vBivXaMwy5w0i9WDc/F46Ctw9/aljmeylcLC6Dj978cj+eacDC9NzOfohsWmTTevjLiocWdLJwl+YJeSWp3YbB7gKavkVwz8s8x8zG7Ymuq4zMTw8jJj468PTShKTC794W4Es9BSQQqZ5htvdX7+1NeJYsbYdBX50Dbt0z83bPiYfZj1GnMZoXHnQ+4Plu6OxkyMm+bZ5eIrR7tlWY+oLA/Qv9QgMO1Kby83Bvu1MUddrgvEZymzd0Ve0uDHMP/qkHIOtXPvsIBMakSmUzm5k5To2Ziuj2tEeFfJm+ozvryVEisow+Yt2IZA5tPACubvvaAf+hzCrB3e2wGY85GJ79nPU7weoU7Z2jBIRNQ+5e7t/WPRD5wBJTWAYs2cg8aU6ZHJdtiuSU2djG4VknaiuHvLbpJ4sfewjPPYVu8lZZUw16GfN6WtZroT/KX44vOFIrw053bsnfNTa2DstEHaBRHi6Q/LxKRp1gEHJAIvRvEOYAQ+IgV062rDfVbpMP6UwMBrLlbYy4ktaBtMmEk7OLlSHCv4GH229o60W
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(356005)(81166007)(5660300002)(2906002)(4326008)(8936002)(86362001)(2616005)(54906003)(966005)(508600001)(44832011)(1076003)(186003)(36756003)(6666004)(16526019)(8676002)(426003)(36860700001)(47076005)(6916009)(83380400001)(70586007)(26005)(40460700001)(316002)(336012)(7696005)(82310400004)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 20:06:31.8830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 360f4765-3d77-4431-2314-08d9ca3d8ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Current AMD systems allow mixing of DIMM types within a system. However,
DIMMs within a channel, i.e. managed by a single Unified Memory
Controller (UMC), must be of the same type.

Handle this possible configuration by checking and setting the memory
type for each individual EDAC "DIMM" structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20211215155309.2711917-2-yazen.ghannam@amd.com

v2->v3:
* Change patch to properly handle systems with different DIMM types.

v1->v2:
* Was patch 3 in v1.
* Update commit message.

 drivers/edac/amd64_edac.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fba609ada0e6..4db92c77276f 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1616,19 +1616,23 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 	}
 }
 
+static enum mem_type determine_memory_type_df(struct amd64_umc *umc)
+{
+	if (umc->dimm_cfg & BIT(5))
+		return MEM_LRDDR4;
+
+	if (umc->dimm_cfg & BIT(4))
+		return MEM_RDDR4;
+
+	return MEM_DDR4;
+}
+
 static void determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
-	if (pvt->umc) {
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
-			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
-			pvt->dram_type = MEM_RDDR4;
-		else
-			pvt->dram_type = MEM_DDR4;
+	if (pvt->umc)
 		return;
-	}
 
 	switch (pvt->fam) {
 	case 0xf:
@@ -3547,8 +3551,8 @@ static int init_csrows_df(struct mem_ctl_info *mci)
 			edac_dbg(1, "MC node: %d, csrow: %d\n",
 					pvt->mc_node_id, cs);
 
+			dimm->mtype = determine_memory_type_df(&pvt->umc[umc]);
 			dimm->nr_pages = get_csrow_nr_pages(pvt, umc, cs);
-			dimm->mtype = pvt->dram_type;
 			dimm->edac_mode = edac_mode;
 			dimm->dtype = dev_type;
 			dimm->grain = 64;
-- 
2.25.1


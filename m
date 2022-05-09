Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A2A520066
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbiEIPAH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237922AbiEIPAA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 11:00:00 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2087.outbound.protection.outlook.com [40.107.100.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7D26A73F;
        Mon,  9 May 2022 07:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yvtf1H0ezYMqjyQuKPJCAFZJx5/GGbzqiaYDtc1oGRSvFRwKBTC6yxu6SodmNNH7Erf/3BEAOVA/LrjS9BXM1BZ10/RE9D1lchHxk1PCAcFCiZPZrmmfTqj9EeipTMHh9sDDsTO1ur9Ih4izMh3ug8I+85ejPuvOA/Nh3eUYgvqqWc60xg/coLuzxGcuCjDz0d8kFfpGbVRG624D9oMDVzKjG1I5kas9IA5I1pQi+OFUUq62rZVEpSGNOP6P3f/poe37mAdYBSm71p96iHAq2U6u9PiNNb++KH2+kvy/MoQHWRjEgvD52UYA3Fjol2EDxrSgTUt18rrtaUO0wQhI8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlhqmtsNBlT3tPtZdfyxOgpgqWHeKNQvXc6wS0JeOvw=;
 b=WuJhr1wdkJlFMj7SEXyR83e0lb+2SOYOvARQwUH8dHr2uKsmxt7dqpYuKxA9AIVF+ywwhGlG2DbkNUD+PNHRnnYdx18poT9ADCF8Cd41VLvQdRmMWLyhR2/3oQc6T0aUMkZ09VW2ukC464Wia9c2/RvTIg1WewAN323VBVLcqjDw+S5EIAaZRO8MjRqsQIwu3fJWArAlezAtvyo4ibj3kopOausOcjm4KKZUxzbMLeUmgwiZoQUDuVNlIBK1cm0nlJECCX/EzwCOfXuSUfmJzbZr1cic4p0L3+WxcSzxc80Q0SLqxbGDAUtbdrcIb1yUGwllp1jCyuvEQIToThgVMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlhqmtsNBlT3tPtZdfyxOgpgqWHeKNQvXc6wS0JeOvw=;
 b=l0+PIgTzslS+7/lJ/zcVKDOJxM+Eaz4Yh3fPci46d2bX8d2oyADYfiXz+I6j6c0qyRCSf2jOHH/Q+McoRjwBHlvop7MQUj8UnCBuvfYI6t/gZ9amPrumqXzU6AdovRlSGzN2p6aL0q2HGo9Govx7Ob+gI4khuskikz73E9X+0Ys=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by BN6PR12MB1409.namprd12.prod.outlook.com (2603:10b6:404:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Mon, 9 May
 2022 14:55:58 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::6) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20 via Frontend
 Transport; Mon, 9 May 2022 14:55:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:57 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:50 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 13/18] EDAC/amd64: Add determine_edac_ctl_cap() into pvt->ops
Date:   Mon, 9 May 2022 14:55:29 +0000
Message-ID: <20220509145534.44912-14-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: e54ee8e9-0352-4282-47ba-08da31cc0686
X-MS-TrafficTypeDiagnostic: BN6PR12MB1409:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1409B76C26BC1C77D7BD8CCDF8C69@BN6PR12MB1409.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 74dcrw/GEWcBid7bwDUycjNM8/NU/FZuzB4FJuB6kQ0iiPUN9jA2peVbpHD7mU+DS0JTtBBfyCj0KHi+NJsft/NN8/QVIf/p8EE3i/H60gCcT1WCVaiCILwNJ9BOuNYCY+u2kt6Yd5Rc7bJ7nsuPs6m/3DjtkwrxXJ3e8sajGC4AGY18CoR5tqJNDjR6MSt+kEQs3P6pTO2Tx2uaqOWkSZIXGi7spP07gVdPjP/uFypr8lGg/bSYsieAxxUthjiEhadEc4nM8+XmmePO5tTEKkkIHD8yRikssBhZF1VWI0ycCz3w6HMeEmQu2S/+QzNOGhPGnoP5MIBqJkOid2D0XdRi+ABv50H2r6tMDLmKsUwO/vFzT1GmF9u25kAoMJmE1Bb3Annc7sPeuX3KHNQesIsGt95OO2KVP99Mq+luyqwPlJzZ+UQKviZFlc6MevZJXaKwfPv4cnYaHRlFC4SMhHJ+LqKj4zlDVSNbfKBcz67PurPrvA+hRLhT9rlezXGPjtApDVwNKh8LZ5bzVwrBE5qhcb7odB+a5gOgpEamhit1k6V9l/VOBxzg7LxFVuj/0U8zhomPoUdpM3JQ3MviBwNbh0sUNEC+tKzJEta+jFQ7QDb8WgL84uMh2rglxlPOii9psWkxeCY7ZdjOOx4Pyw/TS4yDLOv88qcFigQPVj1EIjKt7dAQ0xTtJEsxIMsn7PMsyPlwQI8nFlsLiwxChA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(40460700003)(7696005)(26005)(44832011)(6666004)(83380400001)(36756003)(81166007)(5660300002)(1076003)(2616005)(186003)(336012)(82310400005)(47076005)(2906002)(426003)(8676002)(508600001)(8936002)(316002)(356005)(70206006)(70586007)(86362001)(4326008)(54906003)(36860700001)(110136005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:57.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e54ee8e9-0352-4282-47ba-08da31cc0686
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1409
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

GPU Nodes will have different criteria for checking the EDAC
capabilities of a controller. A function pointer should be used rather
than introduce another branching condition.

Prepare for this by adding determine_edac_ctl_cap() to pvt->ops and set it
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
 drivers/edac/amd64_edac.c | 24 ++++++++++++++----------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0bc9a3846773..b99eaa73131e 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3697,7 +3697,17 @@ static bool umc_ecc_enabled(struct amd64_pvt *pvt)
 }
 
 static inline void
-f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+dct_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
+{
+	if (pvt->nbcap & NBCAP_SECDED)
+		mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
+
+	if (pvt->nbcap & NBCAP_CHIPKILL)
+		mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
+}
+
+static inline void
+umc_determine_edac_ctl_cap(struct mem_ctl_info *mci, struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en = 1, cpk_en = 1, dev_x4 = 1, dev_x16 = 1;
 
@@ -3734,15 +3744,7 @@ static void setup_mci_misc_attrs(struct mem_ctl_info *mci)
 	mci->mtype_cap		= MEM_FLAG_DDR2 | MEM_FLAG_RDDR2;
 	mci->edac_ctl_cap	= EDAC_FLAG_NONE;
 
-	if (pvt->umc) {
-		f17h_determine_edac_ctl_cap(mci, pvt);
-	} else {
-		if (pvt->nbcap & NBCAP_SECDED)
-			mci->edac_ctl_cap |= EDAC_FLAG_SECDED;
-
-		if (pvt->nbcap & NBCAP_CHIPKILL)
-			mci->edac_ctl_cap |= EDAC_FLAG_S4ECD4ED;
-	}
+	pvt->ops->determine_edac_ctl_cap(mci, pvt);
 
 	mci->edac_cap		= pvt->ops->determine_edac_cap(pvt);
 	mci->mod_name		= EDAC_MOD_STR;
@@ -3765,6 +3767,7 @@ static struct low_ops umc_ops = {
 	.read_mc_regs			= umc_read_mc_regs,
 	.ecc_enabled			= umc_ecc_enabled,
 	.determine_edac_cap		= umc_determine_edac_cap,
+	.determine_edac_ctl_cap		= umc_determine_edac_ctl_cap,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3779,6 +3782,7 @@ static struct low_ops dct_ops = {
 	.read_mc_regs			= dct_read_mc_regs,
 	.ecc_enabled			= dct_ecc_enabled,
 	.determine_edac_cap		= dct_determine_edac_cap,
+	.determine_edac_ctl_cap		= dct_determine_edac_ctl_cap,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index bfe48492a0ba..15521adec9b5 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -475,6 +475,7 @@ struct low_ops {
 	void (*read_mc_regs)(struct amd64_pvt *pvt);
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
+	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


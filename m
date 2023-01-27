Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70AED67EBFD
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjA0RFn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbjA0RFe (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:34 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD6F35BB;
        Fri, 27 Jan 2023 09:05:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IFT1Blqqg7Sam7KXDhEC7vS+onRm58z1Js5Rn19XO/qTjzNVDv1e7cdmheya3CU8jqeI0VC+R60TAgoWZB39etQVTNyrIj4zv6fAWmRo75lJJDHC2pCmVYtyodQeeSm6gSvPTMOaJR6Wso2Q4so7nJa1tccwCAy49vthSBvp7oGu/G+uLAPb/i/Q2JVJs9cYumTy7vTVFEoYMFe5lHvvaYgIbW9yP5IkH5DYEHDHPsVPJUnF5aguHrwNX7J6/pwR0RDiox14ZRwX0l4doz8buerf6jsTn13shZWZVNTWC4A3oG8FmAEBDlA0HvGezzek1WSJqhixUGYvdNXd8I6V4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20xyv3oSjovdoFNK1bVJ3cgFaYMjTVDQb8G2b+Qq5KM=;
 b=Z9EIZLy9eMP6xW2323psYJKgF52ptVamHEHFrCWa+xdAo28mm+jHKAmn81r3rAScm/qDFcMiKKW4ppC8Avytz/YWYleQ61Bqkrvm9/GqbqpMX0EpiGJj1UkoHPs3NiSAdiNn/TViAC6pWlLSnduOrn4FBGiy2LfWRQ3fJaGXhG8rmKQTj7jgXERmdTVjQVIhm0tfUSBQh8oFbQNLWgVdxavnPYt1kk8tiwmaDuMXYbUT194p5JJ+v7wsX9b78ZmJ4FBRwOfZprnmND7I9f1wTpbiime87Ph7xeEFsXZh/UwRBFmnwpkWhjGak4hbBg85DznI0nEbBWX4R5gyYCkKGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20xyv3oSjovdoFNK1bVJ3cgFaYMjTVDQb8G2b+Qq5KM=;
 b=0Po1cnhwIURBJOPNO4KmTpBUXkS1gYDvGGQ4rwnXsuGxC4QPI+FioTp2507DjzDIbY6V4oGyVEhokfeWqHp1dRkqYNdgnLFKAKspDevcbqicOajlEQXMCt+oEDMughS3qS32k5/4y8B8R6ChYrdHY+CGBCE2Rc3wdCG8dBRcJS8=
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23; Fri, 27 Jan
 2023 17:04:37 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::70) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 17:04:36 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:35 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 13/22] EDAC/amd64: Split read_base_mask() into dct/umc functions
Date:   Fri, 27 Jan 2023 17:04:10 +0000
Message-ID: <20230127170419.1824692-14-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ace436-b59a-4a89-c01a-08db00889218
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2tEj60B2Y7thbgWyEHnmLs+ObLgYxtAe3Y9OuKTljQzfzT24RXJ2PJlVEmkIMqiP/FL5GUDyNGvqD4pNQfMO/IPCJbHPKcvi/BcouoldgO81L4acBbfx9CgLW5MLr+CIZvfk0DGAMZOL+vr3Hr17py7uYvYzdw9E/dGDNYrX12qP0xOkD8jhEd+WngRdy20fLooZzoz2H+cOY/SFRDSmNmbgnEUc37bt2rcDr6LSxMGQP8NYi5r9qtIM7LcMpN556drG2VWOf2eQT2a1h5OnG3W/Mm36pYx1wQXYzlEWWFphj7/0zc3oqF9z+TSWzu082G//VsVj2pKOO0/D/+HPwaR+P/j1LHjehpTmFaK1Jt+rVyK1Q7U+4KSwPtnBAeUdQHxhKBWFkPy9dyDfIHs9muARKMQ4Ktsq2VVCSs0GvQaMuMaKrBNvvOmZJhIHM8DIV2OxqCMO766VKpy6l9FoMndN0bU3dt+UiltvX3oKHnAGOxgp4pgRCCXKbXwYhlejY3pIt0oq4Yh5tntcqXuhp4gfVS/OUhrCObSU/MbQ2/7Yg4cWjco+x1I7PVoOicIgT5SuZgohmtU0QWW2mVRr2L0wN8DPijy2a6It6ZQx0hLzxVmHkbBq271WxPsaJ57NHMSM6k2XzxBE8tO1CjTGMGCHaNuNMAe8ZgA8LeN54ug7eIGVpOooVCalazhqqP5I0lba4Ut8RhqFH1m7XwjeX1xhsgh9WWZjP2doB/SEF/bPz50/6gGd0AlxlGwvdrsAgjEDSYxoUZORXPmZNtpA28cYIqPhDEyjMfFDohbVMsNSjyKnGpe/G28N7fCk6gGi
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199018)(46966006)(36840700001)(40470700004)(70586007)(41300700001)(70206006)(83380400001)(4326008)(8676002)(316002)(8936002)(40460700003)(36756003)(26005)(16526019)(186003)(356005)(44832011)(47076005)(36860700001)(426003)(40480700001)(2906002)(110136005)(5660300002)(54906003)(336012)(6666004)(7696005)(1076003)(82740400003)(478600001)(81166007)(82310400005)(966005)(86362001)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:36.9236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ace436-b59a-4a89-c01a-08db00889218
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

...and call them from their respective hw_info_get() paths.

Call the new functions after the setting the chip select base and mask
counts, since those are need to read the correct number of chip select
base and mask registers. And call the new functions before the remaining
set up, because the base and mask register values will be needed later.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Co-developed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-8-yazen.ghannam@amd.com

v1->v2:
* Call functions directly instead of using pointers.

 drivers/edac/amd64_edac.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index fc15b6dea177..9310c0fdeb22 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1638,7 +1638,7 @@ static void umc_prep_chip_selects(struct amd64_pvt *pvt)
 	}
 }
 
-static void read_umc_base_mask(struct amd64_pvt *pvt)
+static void umc_read_base_mask(struct amd64_pvt *pvt)
 {
 	u32 umc_base_reg, umc_base_reg_sec;
 	u32 umc_mask_reg, umc_mask_reg_sec;
@@ -1692,13 +1692,10 @@ static void read_umc_base_mask(struct amd64_pvt *pvt)
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
@@ -3185,7 +3182,6 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	}
 
 skip:
-	read_dct_base_mask(pvt);
 
 	determine_memory_type(pvt);
 
@@ -3666,6 +3662,7 @@ static int dct_hw_info_get(struct amd64_pvt *pvt)
 		return ret;
 
 	dct_prep_chip_selects(pvt);
+	dct_read_base_mask(pvt);
 	read_mc_regs(pvt);
 
 	return 0;
@@ -3678,6 +3675,7 @@ static int umc_hw_info_get(struct amd64_pvt *pvt)
 		return -ENOMEM;
 
 	umc_prep_chip_selects(pvt);
+	umc_read_base_mask(pvt);
 	read_mc_regs(pvt);
 
 	return 0;
-- 
2.25.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEC967EBF7
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjA0RFa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234825AbjA0RF3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984C7144A8;
        Fri, 27 Jan 2023 09:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcMdcS1v8JvcJFcnkngxFzwXIlL6bRbmGE++bDiwKe3q/hm/CoGdyZ0sCGo1mmYbXLJe0lKggXFxbr4bpTJE5+6rRKWdYFPcGis52h6b61bq7PHWusLGeQYAhylugil7dg7NnCyq80jg7LfK03PpwfFHTrhfHCOBpmtMQk0uXHdJfNPCm+TzTdOToFXJ5NzIlYgkHFOppfqyTqsj9mToSQ1pg4A7O3HfGOvrV4Lxvej9p7497B8sqwESQpHgNXcPpTX390//hxmyySBhK/ufvbGBbBQMhoh7CVRJGUPXMYb4BTK4Zt5pNFD6amkM+h44UQyYIDxWEQ9iKHX3JHzH9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqfDyt7MfWXaSyKocltOflslxdf/hgjpUusQrjhCL+g=;
 b=NvBd/jkPW56FfRg3XYwZ+i0wDBdGgKw4INhoXv7r73mRU9y50Hf8nPlogaSHQfjP21hbz53xAOX0TKL73qPQ1b3rJPFKRyHzibyNsbrT0zqFad40xl3vTmD0I/L3zatLRTtWgignLMaBNg6zgsEgVIHgxb4SV5D1SkI+JWcXKYno2Pti6JJ42uhEmsR3Jnsp6COU4CgvUG4Gx0mWKd/TajSr+Vw41ArgZ+QJJ/71QUGTnZCdIs6UDCx3y/qKayav6R2MYSpyQ1My8Kv5Bbvypr+YeGfU4vuXgXHgFWRkJNz395ebjAdEbWEHM9rK3ei3yLk8CEuEOYrntebRodXFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqfDyt7MfWXaSyKocltOflslxdf/hgjpUusQrjhCL+g=;
 b=My2dD4otBwn8KZyiDVbPiBKKMcsUzWdx+GWbXzjxmAFuv14cCBXtTe4Wn3mQP6iaJkNKfkVc/eYsOI6n96pb+9mHq50AI21trzuvLGW17e5ckS0q2AJcJ9JEyPt4tkko2lWErBzu8FA+C+AgdZdL9UrNUu+acdzF0ZZo4u14a5c=
Received: from BN9PR03CA0480.namprd03.prod.outlook.com (2603:10b6:408:139::35)
 by CH0PR12MB5299.namprd12.prod.outlook.com (2603:10b6:610:d6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Fri, 27 Jan
 2023 17:04:36 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::27) by BN9PR03CA0480.outlook.office365.com
 (2603:10b6:408:139::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.23 via Frontend
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
 15.20.6043.23 via Frontend Transport; Fri, 27 Jan 2023 17:04:35 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:33 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 09/22] EDAC/amd64: Don't find ECC symbol size for Family 17h and later
Date:   Fri, 27 Jan 2023 17:04:06 +0000
Message-ID: <20230127170419.1824692-10-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT016:EE_|CH0PR12MB5299:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e3eca4-691b-413d-9437-08db00889125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: elrb2NdNWaBQSvCiQc3qNDPgG9C1cOhrIl36I8fUNo13ynvh2us90Dl4OUkoxwtkpLMWHI4EnI5W/1+LOTRiwHXvMH+vjgL7LOEj++ai4PkgpNN9iyg34h/Iwbgtm6bnohd11/Vx++F1Pt6SatdmgGIL6JLU+2KKEw/eEmWcQUkj/wifm8N/+1tWAfwckHBkW2HKpmxpS0IGSgPT6Hj+VRvcIRCTqUZ5p0/lS5cLpRGmtIgmtQOiJ/uPekhZ/2uAyeMdtCaCnl0nLkyG8aBhmdhS0fz2l93Zma4MbWt2uc8vKG7l4/eSzJQwJrQPocaEpxvZuHznaG5MqEFkbwLU2UjfU6b71RVDUPwedS92pns1oAruettYyHqrgQraLiOweHGmFKoBrMWNhdcjQGjjdylALrkEKbsXsyF/PYkN700vLLs2YJpb3RXVY5vZ6YM01FiW9MQDF8jNzUX70trnJDlZHgiTWzaq2jsbq01qyNRYWe20cFaGvtFZhge79Gzy6rJhbsQZV620pZScwcqr4GwP/Hb5tinTNXD5SOm9W/Mjw09q03fE4QJRs21NlT39U/dK8AR5aAUUOm/Ne6zZp8PULweJ2yBYH2TE4mcNTIeoVYGDUkXYHLumG+JSWwtHXdQX4CLn4IB6idZq7voJxTZWNUwhoEe7e3ZlUM3lVSlRLMcOHDKiwPMHaJSUk+5JOvfeU1qCdbr8naCRIgEvUre8kk0MSib0MxqXMoeLWpx8QzTc3dlMyje6pTdPWF6+5pae7JKkMhoEUk8yjpITWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(39860400002)(451199018)(36840700001)(46966006)(40470700004)(186003)(26005)(336012)(16526019)(6666004)(1076003)(7696005)(2616005)(966005)(316002)(54906003)(47076005)(110136005)(426003)(2906002)(4326008)(41300700001)(83380400001)(8676002)(70206006)(70586007)(478600001)(36860700001)(5660300002)(44832011)(8936002)(82740400003)(36756003)(40480700001)(81166007)(356005)(86362001)(82310400005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:35.3299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e3eca4-691b-413d-9437-08db00889125
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5299
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The ECC symbol size was needed on legacy system to lookup the ECC syndrome.
This is not needed on modern systems because the ECC syndrome is explicitly
provided in the MCA information.

Remove the ECC symbol size discovery code for modern UMC-based systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-10-yazen.ghannam@amd.com

v1->v2:
* New in v2.
* Replaces v1 patch 9.

 drivers/edac/amd64_edac.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e13fe400bad5..1d5c2c97d563 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1600,6 +1600,8 @@ static void __dump_misc_regs(struct amd64_pvt *pvt)
 		debug_dump_dramcfg_low(pvt, pvt->dclr1, 1);
 
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
+
+	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
 
 /* Display and decode various NB registers for debug purposes. */
@@ -1609,8 +1611,6 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
 		__dump_misc_regs_df(pvt);
 	else
 		__dump_misc_regs(pvt);
-
-	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
 
 /*
@@ -3197,22 +3197,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pvt)
 {
 	pvt->ecc_sym_sz = 4;
 
-	if (pvt->umc) {
-		u8 i;
-
-		for_each_umc(i) {
-			/* Check enabled channels only: */
-			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
-				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
-					pvt->ecc_sym_sz = 16;
-					return;
-				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
-					pvt->ecc_sym_sz = 8;
-					return;
-				}
-			}
-		}
-	} else if (pvt->fam >= 0x10) {
+	if (pvt->fam >= 0x10) {
 		u32 tmp;
 
 		amd64_read_pci_cfg(pvt->F3, EXT_NB_MCA_CFG, &tmp);
-- 
2.25.1


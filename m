Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECAB52008E
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237765AbiEIPAM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 11:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237931AbiEIPAB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 11:00:01 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2041.outbound.protection.outlook.com [40.107.212.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5C21683FC;
        Mon,  9 May 2022 07:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkbF3tKHwr1UFujdQpCvP73wjEwO8Jab+UgOBlHJT/aQyDv433yBlfJlbWAu3ircQZNKD2hFkknL1KaJ11HgvRd312MWZpxO2IAW1Ohcvu95vd9m15fs6IV3HAOsHjFjgFdSOM88OOGNNfQje+NhyNkeiPYXe/8UOMJ8zBacDxnEoDwLQNvQ2N4WuM4T6HN9b6JfT6wa4ZQlDY3YM4zjbqGv0QYB3aRpAL2sG+XJEvPTH5OKsrWJC32KV/zPpoBeSqC/8eCKBdbpqS+oIQtIQmyx1iOeI9+lQmPPqierB/IJoQPwzg5Hk0nkBQ7YMcpOvHTbgsjV20QvX4XKlWXxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8tayhatuj8M//w0xxmlIemqmC3IGAGwMXg9BunPyG4=;
 b=FfZFFbVEYO28KF8CT4E4TfXRPMXRHpGhwAqTYn5VzUAoQyp6Fc/ySj4yRwkwDoE6YBRjA/i+M39D+AaMu+WIan4r3N/CmtWko2Xd0VKSk862Lq01RRPJEsJtumHXcgz6Oz1z+IOQ/B4BIZXfUKurr+5LFYlHpHpnsFCfQ31nFQAdz4IBz8Dm9PrRGxnqcBwrRnwVB4d47AkuY5tOVAap3nedGP2rmDVU3VYbuvZCM975mJAODLCENDkenNxUGt8mRkwk5onBJxzz4RJ8QuIpJVLhoqFjsezEfR1gpNXqUk1UE86wawBmr7etH4ChPo8U97tCKXkY7BwfyloK4kKH1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8tayhatuj8M//w0xxmlIemqmC3IGAGwMXg9BunPyG4=;
 b=AOpTPP+gr53At8fYzMQb1njct+xh4KK41gpYAWrh+Udv83ACm7UFWVopD7Kseg7jj9b2ba1BmI6D+onA6/sO2AYsoM+pE+ZFNGnt2QZ4v6jZ5s61bKujIjv5ktvgYFEFHyyfyL9gM0Ftl/kyAA3aih/7tBKfuc9+Ap8PIEo9Uc8=
Received: from MW4PR03CA0020.namprd03.prod.outlook.com (2603:10b6:303:8f::25)
 by CY4PR1201MB0214.namprd12.prod.outlook.com (2603:10b6:910:25::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:55:58 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::92) by MW4PR03CA0020.outlook.office365.com
 (2603:10b6:303:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23 via Frontend
 Transport; Mon, 9 May 2022 14:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:58 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:51 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 14/18] EDAC/amd64: Add setup_mci_misc_attrs() into pvt->ops
Date:   Mon, 9 May 2022 14:55:30 +0000
Message-ID: <20220509145534.44912-15-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2eebd783-105e-463b-1239-08da31cc06b7
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0214:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB02143F2C0EAB737D7C966F3CF8C69@CY4PR1201MB0214.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3pAZ8L7uo2+j+xyIZcOBwSLq2TcqIhg17qxD4Gc+CEc5rUmOqqA7AK3KzSJhxo8gzip3F0Dn0MiYs4jv9GCEEctEE1NinqL/aVAy/YQ1U72pi8Q70A3e0vxJBOzH+BNWk6p8Tf2fE3pvZI4j7HE9jt9jJNDmfRtmpd2M1GmbhYaKrgdqyP6msJ443wzEAwRzxWjvS/Yl0CgSfI0NZPBfWikuC7Hd/XaqAPW+ar4wnf0NkUoF+b7AcJgs9LDUAFgJ136KStTBX75E+RqtSiWYZxSFVO//uVlfq/xaiNAlA0Ndxh2xIWo6gsTL6IVQxZBM97lYyQh2wzpVCYpQHXHcX72ulGERpZQTYf9hbRZaBcGMQDFteaG3yd9WX6aPDJTjgFeYbUTv2Wk9KNMPEZVlEyrkKm1t4Y/EsA4FCGCL1cYHyI6LskQEVQWohzPuLKamnzdZWO4O9g5QcQdcKB3RO2Yf+EAqk0Xgx+Oj4lBCA/6nj3qljYfut15fjDieFWMV3CZj0me83SIKfKm4uQR9nYjCytxRzvN7VPhJpQnu09nEnpk05t8f0vq309E7It/UyZDp51C/Y04LHGPWn6x4/BqZaw6oJYCuejo3LR7ZTJAapCzUaf6NMV0DvAnbka8ODPMsK3u78UcTl2ujebJKNGkFY/VejSkIhD0HzPdkwRekKj97AjoPtJjbU5B2YLZyqz8n7nd0DY3sv3DRhPltw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(16526019)(8936002)(4326008)(8676002)(70206006)(86362001)(70586007)(82310400005)(186003)(36756003)(426003)(54906003)(5660300002)(36860700001)(508600001)(83380400001)(316002)(336012)(47076005)(110136005)(44832011)(6666004)(2906002)(81166007)(40460700003)(356005)(7696005)(2616005)(26005)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:58.0378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eebd783-105e-463b-1239-08da31cc06b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0214
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

GPU Nodes will expose the memory controller attributes differently than
current systems. A function pointer should be used rather than introduce
another branching condition.

Prepare for this by adding setup_mci_misc_attrs() to pvt->ops. Legacy and
modern systems use the same function. A new function will be added for
GPU Nodes.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
[Rebased/reworked patch and reworded commit message]
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 4 +++-
 drivers/edac/amd64_edac.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b99eaa73131e..f1346416e64d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -3768,6 +3768,7 @@ static struct low_ops umc_ops = {
 	.ecc_enabled			= umc_ecc_enabled,
 	.determine_edac_cap		= umc_determine_edac_cap,
 	.determine_edac_ctl_cap		= umc_determine_edac_ctl_cap,
+	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
 /* Use Family 16h versions for defaults and adjust as needed below. */
@@ -3783,6 +3784,7 @@ static struct low_ops dct_ops = {
 	.ecc_enabled			= dct_ecc_enabled,
 	.determine_edac_cap		= dct_determine_edac_cap,
 	.determine_edac_ctl_cap		= dct_determine_edac_ctl_cap,
+	.setup_mci_misc_attrs		= setup_mci_misc_attrs,
 };
 
 static int per_family_init(struct amd64_pvt *pvt)
@@ -4001,7 +4003,7 @@ static int init_one_instance(struct amd64_pvt *pvt)
 	mci->pvt_info = pvt;
 	mci->pdev = &pvt->F3->dev;
 
-	setup_mci_misc_attrs(mci);
+	pvt->ops->setup_mci_misc_attrs(mci);
 
 	if (init_csrows(mci))
 		mci->edac_cap = EDAC_FLAG_NONE;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 15521adec9b5..93de7dea516a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -476,6 +476,7 @@ struct low_ops {
 	bool (*ecc_enabled)(struct amd64_pvt *pvt);
 	unsigned long (*determine_edac_cap)(struct amd64_pvt *pvt);
 	void (*determine_edac_ctl_cap)(struct mem_ctl_info *mci, struct amd64_pvt *pvt);
+	void (*setup_mci_misc_attrs)(struct mem_ctl_info *mci);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


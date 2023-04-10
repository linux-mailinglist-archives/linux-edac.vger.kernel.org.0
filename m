Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5EE6DCB57
	for <lists+linux-edac@lfdr.de>; Mon, 10 Apr 2023 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjDJTKS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Apr 2023 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJTKR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Apr 2023 15:10:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33311718;
        Mon, 10 Apr 2023 12:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CHpzpo6tAu04d3UzoGOU3S4Gi1ljCykq2WXUrjmLLndbMPqLhSw5IfIZm/5LFWVESl8lLJ4I0UXPj2Vj4COXDFg5tGNqI2x9RrHMO2sCZB0h8qniep8MvdZMOdA0NfIp2NHqCSg6NIerXt9VWc9mIerZp/14EU9SnWqgSi5GAskdDzq7vWlpFFBI1qmsoR3QCMhX60Jjvzf+r5Ri1LIs2WH78/U+b+ZjNfuWhd22PnavKw0rRKtppQ1aQoCfQTZ2rcaNePb8PdNjsQzUQzHhE6PIMjLWGKi4L1pRNxE553zGC6RCF1NnS2jSLwPqbVUgaUcfqrEDxYiYWQnZm30G8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MMsd9A1dbk/TDkm86T+7yWZhP6qJ5ZFOGYNFqqWoz0=;
 b=WjnVEjh8bCjpd11epZm6fGEz2NWXj0RGN646sY6F12gQx6Q+4nt/hunw3Qv94e5WlqBxPL6tOeuZpfUoJmXkMFse90fOSdVoDb3X/E86fw6c6QYCnCNDmeBCNtuoKBFwhc3vyFpUCYtO3PwOKYUrB6gTILizpPVqTOamiELJ+ty3A3VrN/mhV4c9T1Vf5EhR/zKNbMauWsof0dt6ZzrqBbQQoKFJC4mVjYSeNlajZLgAXMt78J1oeDoVSya1fGCT6mgVcioAGRSrR4e2HOY0p1wxlitU6YmqBQMMofO3kwlpoMlWUrzYamdRojW1LfdMvsCBj1lauI9i7mLTYDhBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MMsd9A1dbk/TDkm86T+7yWZhP6qJ5ZFOGYNFqqWoz0=;
 b=LXm3EMMaCiIwP8u+7H4n59M4/xCclJCV1TszOKoFD4XrwW76Y6UyTx+zV8iJpsrtxCKjhZKcGVHgLIHgLY5D+sqZWL17Q6qTVPUSTPCkBofrE0O8HzYduY9nUp/jwM7wo/JTLG6YUV0Oa2JeI25I5lLSaB6yOf7ljKi4DO1u05s=
Received: from BN9PR03CA0495.namprd03.prod.outlook.com (2603:10b6:408:130::20)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 19:10:12 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:130:cafe::fd) by BN9PR03CA0495.outlook.office365.com
 (2603:10b6:408:130::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 19:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.28 via Frontend Transport; Mon, 10 Apr 2023 19:10:11 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 14:10:10 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/amd64: Remove module version string
Date:   Mon, 10 Apr 2023 14:09:59 -0500
Message-ID: <20230410190959.3367528-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT060:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 55910ace-de74-4691-8472-08db39f73575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHmMeSKpEfFtTnKQluI6Y/azpYnSEwy1T/HDTyHdHEWQWQ7G7h40NunGyFtRzz7wu1ymoVxt+yvGXE8YUb/OASs6smxeQCyudjOAwQkaS+Ec1MUBE88SDNzsb/BH7flJ8k3zTbdm9LksG7OZFUtrFWmX3XJYbJhG4a/vnkXFCnX2eDITqgOPH0dv+xt/bXRzl4G4q1lINKkpzIiDk6x3a93S7tQ9aoRVCrtvj/lBbO/6AmAJqIRSkXvYBQ8+tmx0LmSFPGGWo9JwIsSAlfoJLMnz0Ie3K9sJbQ4Da7PhsvPq4EJMdE1FTn6XXgJejqMlmjnp35zm1wlRlNTtNlmhTeTKZubjWGvEEVR7ZeCeGPRJzpgafhMuHnK8nzhT08YyjblZ2UcJxItjXGVn1YrNwndw9aP5Vnoajh4uggBTyRavhZpfvUDpXtlAZ5Bi615bxxf9xaRBGDydjKsNbLLOBeeQ1arm2WGhfYuhLBBTGyMJ7DW10rkia/hkOCUoAq5V7e9J2iqquwj1u2qL9uoPqkK2q8wqzSjsal2drGvF/2UTPmXe1Q1l33anPc8fY2PhaVJZ8l5M+ZgH1lRY/n6b/4Lp0tu4DA+SpQZSoELf3ptZPzZawnd0eHXPYPAld+lHEvt/MHWJxzsq4BN+zcuhmANWPuIXK/E2WATC3Rqn42waENgZaGLSHldMKFHbvJJhYDktT9l+juqrwufjH4v4lK5Z3P77k+CiduANJMPzV0A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(40470700004)(46966006)(36840700001)(70586007)(70206006)(4326008)(26005)(86362001)(1076003)(316002)(110136005)(186003)(40460700003)(16526019)(36756003)(6666004)(7696005)(54906003)(82310400005)(40480700001)(478600001)(36860700001)(8676002)(8936002)(2616005)(5660300002)(356005)(41300700001)(81166007)(47076005)(2906002)(83380400001)(44832011)(426003)(336012)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 19:10:11.9187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55910ace-de74-4691-8472-08db39f73575
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The AMD64 EDAC module version information is not exposed through ABI
like MODULE_VERSION(). Instead it is printed during module init.

Version numbers may be confusing in cases where module updates are
partly backported resulting in a difference between upstream and
backported module versions.

Remove the AMD64 EDAC module version information to avoid user
confusion.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 4 +---
 drivers/edac/amd64_edac.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 5c4292e65b96..37b1a6127d0b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4074,8 +4074,6 @@ static int __init amd64_edac_init(void)
 	amd64_err("%s on 32-bit is unsupported. USE AT YOUR OWN RISK!\n", EDAC_MOD_STR);
 #endif
 
-	printk(KERN_INFO "AMD64 EDAC driver v%s\n", EDAC_AMD64_VERSION);
-
 	return 0;
 
 err_pci:
@@ -4121,7 +4119,7 @@ module_exit(amd64_edac_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("SoftwareBitMaker: Doug Thompson, Dave Peterson, Thayne Harbaugh; AMD");
-MODULE_DESCRIPTION("MC support for AMD64 memory controllers - " EDAC_AMD64_VERSION);
+MODULE_DESCRIPTION("MC support for AMD64 memory controllers");
 
 module_param(edac_op_state, int, 0444);
 MODULE_PARM_DESC(edac_op_state, "EDAC Error Reporting state: 0=Poll,1=NMI");
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index e84fe0d4120a..0bde0db76f7a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -85,7 +85,6 @@
  *         sections 3.5.4 and 3.5.5 for more information.
  */
 
-#define EDAC_AMD64_VERSION		"3.5.0"
 #define EDAC_MOD_STR			"amd64_edac"
 
 /* Extended Model from CPUID, for CPU Revision numbers */
-- 
2.34.1


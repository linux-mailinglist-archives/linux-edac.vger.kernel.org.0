Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECE967EBF3
	for <lists+linux-edac@lfdr.de>; Fri, 27 Jan 2023 18:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjA0RFR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 27 Jan 2023 12:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjA0RFQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 27 Jan 2023 12:05:16 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E29A84B68;
        Fri, 27 Jan 2023 09:04:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ieisQBa9MuN9u9e0X1+WM/D0d3DyX32gyNymSuT0/3fxSLTB0Uwie2xYtOMUOSVqK8gqB8Gk/QY2spUfNLBWah7OsKaJRoVD01ZXpXb8YSi4/AaSnM2YdIGPaU3x+7Cfm1FieinFkznnd/VFvlEXyTMRs+V2pemgwGc3ihA+MF82gP2G3dOPYgamQ3bPhijSuwO3cXDCCwGkZRaw5qLu2dHOBmeN/Rw1SjiuUpIJ433BWWGky1jbQOTwTP8/AB+KRu83A5bHB7rc65sf1D48w3TRzbBtIaeCKmKBHPRUxtkd88gnDv6JwGW5gI8QSSS2NxovjCzLdEBnMzkHZGDWNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6Rx5/VLRGVhr43ZfQpk8+vFs/yVdqMjfvHz9iJaGCc=;
 b=nb2/XLVxQWzY5AgTPZsjzW6G6IUhiDw4o31XQ0P41gvxBpUpwBGDuY5QjvTxQol6fQWcnUOP011e7cRPilXvUbirOTm5WsQ8JrgZPN9GuOh+oVhSUZdKZHDJoO/BAIfz2OVqDiqcFH4J+Z2MlDfEftuq2xaXuxv25F3twRHN45eLSI3Kgyz3IILpQfymIqIMo+HClR1XQsY4S3FhBVEIzYTNO/xTWQmx5pRXfV59IdFbEKjRo8faGRCuZZ+NYVCb6vrgMB6qII3YH006q4dfNaElMcNE6eecTzp2M38g6Yo1MxhA6w7pYRh/9M0yRRqrDclt5z9m5FzNWgb3aDyxsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6Rx5/VLRGVhr43ZfQpk8+vFs/yVdqMjfvHz9iJaGCc=;
 b=Ki7nDaaUb9QbrqvxtmQTVr+GeecVp+ddsruvNAf2fv4g7bQ8lHycjTE/sMbBN5OzXQyJKv2nBAW76hoWAbljBNCsSMfdF20niv9ruG8YMF3Q1+GsuComlyoK1UykpCIwuw/iO/IJa53vYzu89QzKABolvjr3mq9tjohA9d64R2o=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Fri, 27 Jan
 2023 17:04:32 +0000
Received: from BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::e8) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22 via Frontend
 Transport; Fri, 27 Jan 2023 17:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT089.mail.protection.outlook.com (10.13.176.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6023.16 via Frontend Transport; Fri, 27 Jan 2023 17:04:32 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 27 Jan
 2023 11:04:30 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2 01/22] EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
Date:   Fri, 27 Jan 2023 17:03:58 +0000
Message-ID: <20230127170419.1824692-2-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT089:EE_|MN0PR12MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: efb76abf-be8f-45b2-a034-08db00888f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/oK0NRvlA+kT27RN3AwCdApPIPnOPAQ98FDMtHZFv00VmrV6xP2ZFwEtK9dFq5ikgsEXA716XWj4RJ4qYtUNEu7LsoItM7d7el+u3suvwnfIfNs1QGt8Vgi5lSuNl1/5/HXwQex3gsxAXe17D9VN2sFgpQATiAeYT+kN/dHWjseORJVqQIuUSd51njUiOHo7CT+n9HS8fzOZZIJwdpHUoYgW1A/eCkkL/YkwDnppqwz3j3k85zq7IpzEKyI/OO9RP5F5OgXSHNDjfUZkj0laS7uDrPIvHfCrVLMVv1bcev1NIPY1kwtTomcBWkYhaENcSLc9n+OAFHG9v4pEN1WMk4oahR36FBdXGS4fp4xRRThlROor7WEv95tiHE8qP8HIXTkoeS1n3jcjxfxNTHvrqJeKkYMUx88HETTUKxaFXvywVgRe7HcFAecmCBy/6PCk689rReKuMWpuO4FwIziFyS60Csq78/zBgkTJ9Q+YEll285MvEsULvx4g236HEHYGCrx+5Z0MX8Qu5uFej7loEOTRCHBv9XNQGEjV2Ia+sv3wYstiHH2tcIA6sz0hJibVb7lzmxnRx/TmQfnI6cA3XxkkS5HeWGgXQLl9efdQVKfG2sleCioosBT9NvC58Fp49OsJ12jCxTfMIQeoqcoBw7aQUzzY/1R8Z11t8FlWt2G1yawPLA8phHqNyFqhyCanGom1KrbopsJN43zR9j2+cu5Nd9tL+gpPkfS5X+s/otH2N0lWgWGLwEBceJxEgg4N3n/KtxBDBsvNKmUn1p7hA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199018)(46966006)(36840700001)(40470700004)(6666004)(356005)(110136005)(54906003)(41300700001)(81166007)(70206006)(8676002)(70586007)(40480700001)(4326008)(86362001)(40460700003)(36756003)(44832011)(8936002)(5660300002)(36860700001)(2906002)(1076003)(316002)(82740400003)(16526019)(26005)(966005)(186003)(7696005)(478600001)(426003)(83380400001)(82310400005)(47076005)(336012)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2023 17:04:32.1714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efb76abf-be8f-45b2-a034-08db00888f43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6103
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

EDAC PCI control is used to detect/report legacy PCI errors like
"Parity" and "SERROR". Modern AMD systems use PCIe Advanced Error
Reporting (AER), and legacy PCI errors should not be reported.

Remove EDAC PCI control setup on AMD Family 17h and later systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20220509145534.44912-2-yazen.ghannam@amd.com

v1->v2:
* No change

 drivers/edac/amd64_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index e3318e5575a3..2cc7336a5121 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4370,12 +4370,12 @@ static int __init amd64_edac_init(void)
 	}
 
 	/* register stuff with EDAC MCE */
-	if (boot_cpu_data.x86 >= 0x17)
+	if (boot_cpu_data.x86 >= 0x17) {
 		amd_register_ecc_decoder(decode_umc_error);
-	else
+	} else {
 		amd_register_ecc_decoder(decode_bus_error);
-
-	setup_pci_device();
+		setup_pci_device();
+	}
 
 #ifdef CONFIG_X86_32
 	amd64_err("%s on 32-bit is unsupported. USE AT YOUR OWN RISK!\n", EDAC_MOD_STR);
-- 
2.25.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12845520078
	for <lists+linux-edac@lfdr.de>; Mon,  9 May 2022 16:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiEIO7t (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 9 May 2022 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiEIO7t (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 May 2022 10:59:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76781DF675;
        Mon,  9 May 2022 07:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekq0wtNNriMq51s9Tu0xdpqkc8lv+QG0vqWFR5WfTvAFd+dJqPGh9NoNdw4LUEblBGaQ7YyUi1L1dVMOtjDvL0uEQA9KzHOPMegXd3nB2DfHKfxVJiBGE+4oi6U2Z+nD3QewL2nGg15v7vsyFb+w5dLoswIE4Iyd64w0XZxIf+CQpew26n1dwtJyP74SGZ8tDbLfjLmpggWNZVP7iMC+Tlq27eSoIHMWgosAJcqE/cGeIvlzT8DKlFQ/WPnODIvTvUP9HQPrOm6I3TjXRBaDVw/1rBpoOL6dfQ4DuF+4e3Ecr9XHBk1u6LxbMgIJclE5JeaZ0cgNwIob17fFTuYXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbGAXCK+O2dJVvdKuux7MSmdl1vdRXcaLqBnjew0oOk=;
 b=fVV/6QY25oy3VdfSr7c41q/bAhVa0PVsCzs6kuCkJwFG1lPlB92im8RsJ8/Ze2v5c4mvoniGfQF9QqwPoE4ekKrGrLdthPMim8o9QSIs56MzDJAdS3uMv+nuwcYo0ttXc/7foKod86GV+RCbdzBwKvSysO+eTKnUqHD3euECCIw5FGjt/ZGo7HhVBysQsCPCESJlv1U+v3q/uv2A3zD/PJ+2Z3pKuX2VKH6u6NoBu2U78DHIJBxsZSEf1olsZoo8z0BfdYeLkwPNzGDyMcPYOreVEiw0cUDjLY5d0S255LD5eU2JSnNHZW8F8NI9TWjMGRmRG3AhfZJ1cRZ2w6i3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbGAXCK+O2dJVvdKuux7MSmdl1vdRXcaLqBnjew0oOk=;
 b=j8t/yS/eWNL4hRHewn1dqRJ4VVcMo8NQyQXXb1sSyqUDUCiHIHVt7X8gkHsF+yQNRXo09UWSaltjQlCVYHr85mu75snrgjiZZp5z9CBRMPZ/qdPzHDDZzNStg9pJyS7p6DQwX5+E/kimiieKG8/TFBPv5WA/JlAacykAA0HLXdA=
Received: from MW4PR03CA0326.namprd03.prod.outlook.com (2603:10b6:303:dd::31)
 by DM6PR12MB4761.namprd12.prod.outlook.com (2603:10b6:5:75::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 14:55:50 +0000
Received: from CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::c2) by MW4PR03CA0326.outlook.office365.com
 (2603:10b6:303:dd::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22 via Frontend
 Transport; Mon, 9 May 2022 14:55:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT064.mail.protection.outlook.com (10.13.175.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Mon, 9 May 2022 14:55:49 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 09:55:46 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <Smita.KoralahalliChannabasappa@amd.com>, <muralidhara.mk@amd.com>,
        <naveenkrishna.chatradhi@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 01/18] EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
Date:   Mon, 9 May 2022 14:55:17 +0000
Message-ID: <20220509145534.44912-2-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 13df4b73-d5d2-41f6-e3c3-08da31cc01bc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4761:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4761E29C090AF08C6FCEF9B4F8C69@DM6PR12MB4761.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29nVO/YQSqBXRmUIgu5T+SESzaoSve4KaOgOvBKwdJbqaZTZZyUryUiH+w31YlezjO39uszsX48Of+VKXznhyL/mH32J10ex1Ng/xO9h84e8EHFd5YwLqRKkhdkqAxH9pUh9mk7ojn1qLA3xXFAeiSINf7+4AnV3bxwmqDboIJ4u2SYBpNVVT++bEVFlnfGjP0WzRA0cVELoQzPm4BGET4k9pXuKlYKL5IUfxPXmn8+UiYTskSYA22TRKoWGBgu1kXpOfgkIFt7fEyJ1mLL2hysjAW/+Et2ao3zRT9tBci4c+SC3zXt/LjnTPVWOopfCs3UsKW9yvXLu2fwAaUAkRSCv9fmwBrlIjh44kyiSPJ6JdxNFH0qMfX41lhtq7rEmv3V9ZTJh/VsskMrLcJvSfXYPfvfFsxvP1piQR0mn1Yolxc/bXVHzAqkXBs2d1dPjMWDHDsqW8kXjc3ZLq3beuspT2P7WxXlcasC+/cT7huZIqopf6oRpCHgynav3I//ej0rvdIkWdWZ778P/GwiqQBawT8dH8dTBakDaeZTiH3GR8GdLesv1MYqtZefnqtXm4QDojgTVDgrw/uyLBaRpAEE4YfLgvtm4NdB1EhmGZLjy2X4TjL/Sk0CyZLNHt8IY5nzv9ly70zVrlUCn2QLAGm3nKZuxr4iWfqKUHiTph96onFlxf4HhxruaBQNH9QAMZ0vQWxX8R0jrKxKTDR4lNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(83380400001)(186003)(16526019)(36860700001)(2616005)(2906002)(1076003)(110136005)(44832011)(26005)(36756003)(47076005)(82310400005)(426003)(40460700003)(336012)(6666004)(356005)(86362001)(508600001)(5660300002)(8936002)(7696005)(70206006)(70586007)(54906003)(8676002)(4326008)(81166007)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 14:55:49.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13df4b73-d5d2-41f6-e3c3-08da31cc01bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4761
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/edac/amd64_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2f854feeeb23..04fa96592317 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4367,12 +4367,12 @@ static int __init amd64_edac_init(void)
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


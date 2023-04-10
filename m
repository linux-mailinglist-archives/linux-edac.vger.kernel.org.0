Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800766DCC33
	for <lists+linux-edac@lfdr.de>; Mon, 10 Apr 2023 22:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDJUeR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Apr 2023 16:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDJUeQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Apr 2023 16:34:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C50D19A0;
        Mon, 10 Apr 2023 13:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBuNpTAjqnrHEFEPjsMENLxZlsJd1BZ8b1CbywfZAYopkux/gwNYNPf9fhJ3siNusyVEK1BaInRMsxflNPF2nRwfv3X0ofefOs5Zp9797KtrzZqgLC8qa2a8HrjOzb65wgyQWPB0A2wUMyXtc6+dVXuOgkLT6vYCpLtR5+3JVs8OuH6AduQwYuORQai1SyxpJ9qL7Gqm+tyKinS/2LhnCVq2x4XtK9w3V25exmMlUXJrXkKpiQrDIXdv3Pz95q0I1xqFJiQRcUH8zJRzaEz8IvERFv4bT3PWtItJscqP4cC1k5dVvB432mSxYcuziRE5yvVIvR3KglyNI28bWEJPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBEzmAUJ8rzdy4ODc/dznDm+GA86XkYtLXfeDaCVNhY=;
 b=ga4CRiG2dnfVZOAHuclSeq17Reu5JnSULJiUOmiAfQDrfgkmyYmCN9Vpcjx7Y//EZOok2NEETJHBgNspZuThtB1VQLOX0xf37msDtS9KrHZtIU0mKY16t4KQs7WPOtzykparnbq4c80vPQInWr2a5Z4PaWIvxhH9zLIC/kSkzyCumxpLiT/mxNoPZsnyTZKNUnzR9lVvIjnKChE5FBWbjlMdFSoUaHJaMCl1C60h02tz/HZupHo5JarhHfXC2aTM7VsDUvU7mpXcelpCDD8t8ruk+LRqqLPQqNkYJ3/rg9jKqpGCJPnljeL0zRnAbwI43IXcoQ3IkprBoKc98PIStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBEzmAUJ8rzdy4ODc/dznDm+GA86XkYtLXfeDaCVNhY=;
 b=PA/nyumqEj+GZvyAmM7vVT/tBhvnBFxEXrOK7JKaSzhrqzHH2zRNrkIdq3lCCtOM6JE6bhk5/rYJzlx0/ACKoNRpe4Xu5T0IABdyozJKdUa5X1znkyzLi0MIkvr0Od1XH/LEjZPs3DaXvpAP5d1gPNodpDOreSgU0crrt+kDok4=
Received: from BL0PR0102CA0025.prod.exchangelabs.com (2603:10b6:207:18::38) by
 SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Mon, 10 Apr 2023 20:34:11 +0000
Received: from BL02EPF0000EE3E.namprd05.prod.outlook.com
 (2603:10b6:207:18:cafe::88) by BL0PR0102CA0025.outlook.office365.com
 (2603:10b6:207:18::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.39 via Frontend
 Transport; Mon, 10 Apr 2023 20:34:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000EE3E.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 20:34:10 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 10 Apr
 2023 15:34:09 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <bp@alien8.de>, <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] EDAC/mce_amd: Decode Cache Level "L0" Error Code
Date:   Mon, 10 Apr 2023 15:33:57 -0500
Message-ID: <20230410203357.17704-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000EE3E:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: f240aca0-ce3b-471c-71d1-08db3a02f0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNvR0oVtU+Hs5hJ0EgZmvDMLdM87eXFcn78ur3M6/d3IWD3gkEQEZQwxpnDV1K0/XZgPECb//MyZ5ZWM+sir8gIW+CG8DgzRagpQ1HWkq3hIRUXHZHru39CFV1ZzLX9wVJis9NTSZcxxAgYdhPFf/cNsatSsz4qLbPaTTR3egSaeQ7JZqVHWtw35xomHaHZxcMiiy4Ekww2yJ5IDIfp09S+xz4QdQMUM49L9n/25qDiUBgrFPU6xmHPHhDGnz91SaqnxgvXOX0jeBXT3BjFxeTGRQCc/Sg686wKzFxGqToMVANxiPRhvytaXeZoPEN8qv+4mS+aQkA7yBPDZk8eEY55wyKxSNaT8MPxyWPYO260OVi7+LLSSCbBQSCOfbtJSJcwPWQuEAQowyPiSfjnUjRZPWZoM8htT9jy6L/vEN1Vb+/LsLAzhn/DXfFWDereyoF+Y0ypH6YAawpUsPSDJO12Dk5kUV2EB6Emfmb2RZy0YDAd/z3lU0O3VrzufaiSwlU3bGjAodqsNfzBD9Tym3U0cn9KUe/vI6eGcy9I8eBjLcreFGasN4MMGxO4WaVFUUEV9U5Qt5wfes4odYzVlvxGiKt7ycFiBLClfcZmfR/wT7Q/0yII4A0Xlo0/Ukf27bNH2RLVvLn9L3lhDeQ0XXF9VJHT8saGqdhkJNzSxtOzsPWZXd15/EF4b5djz7vrXah3xd+WgpByIPHS5CzhghhKKEGv3mHtO5pmUN11vDyo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(36756003)(41300700001)(110136005)(316002)(478600001)(70206006)(70586007)(8676002)(4326008)(7696005)(54906003)(40480700001)(82310400005)(5660300002)(44832011)(2906002)(8936002)(4744005)(47076005)(81166007)(82740400003)(356005)(36860700001)(16526019)(186003)(6666004)(1076003)(26005)(2616005)(336012)(426003)(83380400001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 20:34:10.6340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f240aca0-ce3b-471c-71d1-08db3a02f0c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000EE3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The "L0" cache level is listed as "reserved" in legacy documentation.
This has now been defined as "Core" in current documentation for
Zen-based systems.

Update the cache level strings to include this new definition.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63feb26a..1d1b9da3b9bd 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -37,7 +37,7 @@ EXPORT_SYMBOL_GPL(amd_unregister_ecc_decoder);
 static const char * const tt_msgs[] = { "INSN", "DATA", "GEN", "RESV" };
 
 /* cache level */
-static const char * const ll_msgs[] = { "RESV", "L1", "L2", "L3/GEN" };
+static const char * const ll_msgs[] = { "CORE", "L1", "L2", "L3/GEN" };
 
 /* memory transaction type */
 static const char * const rrrr_msgs[] = {
-- 
2.34.1


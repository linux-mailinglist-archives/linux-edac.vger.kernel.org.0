Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED268517C3F
	for <lists+linux-edac@lfdr.de>; Tue,  3 May 2022 05:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiECDcW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 2 May 2022 23:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiECDcR (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 2 May 2022 23:32:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9FA3BBD6;
        Mon,  2 May 2022 20:28:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXuL8XL+A0ivbRsYJPiANvABlTanFUnC2lLTmavety2+GciqLpa065u6p6WGU0Ak4+2w5N6QL8ZcBZsjQ6rk1idotu6JTBvfjBb9yw3sbdDjeHPRBROiGSvvjuXmBn2wQMVt63NZYJVEk/Kj80VYbO7RL7Z4Jhqse4RF5NcmMspNFXxVkThoGMK2CCGPsAmjhnaUWETZfZIoCgU+4Uv66e4DoSQGTLf62nVYyaSjFu3C9+kpKWRNO0usnHdeLVtTGoJrhezftZEKgFyrP7IlNZP1t2ns1qQ9frgnb9aItFxNpj+qcqTMRdq2pz+2NrQU3OKe8283oDC6TyDep37MCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DNVer+iZ3uu8jD3k7MmsjSTkie//ihrOvOEMhtT/XAc=;
 b=Pt/yvPcZyAKobaiVtepAi2hNixIRj/r5JlYMtk6Y4zmgIN1xkqximM9iXWwhQa88fMRgPoIxNEP0x9wP4HIzuxlUASOTWSPif5DNxHNlHcpLoyihqHGxg6OOtn3SFn6IBKqCPYjbbWK0j61TLgQNKk4K4XmHjiI7cEhTDT5RVpUeQ8cCXtiwneqKsGyfLx0hE3KRh+fp+BCPO34/5KdxVe4nNobI/MdyZ8kaNhWvEPH+K9NhTxt2Bs897+rT7iOsTctHd11Evz5iVegKbimCdqpk448ROnzC8nDERGLmxGdfRtnFgQuTZM2w+Y7DHFh6bQ1hd/WwC6qLFsODrFtBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DNVer+iZ3uu8jD3k7MmsjSTkie//ihrOvOEMhtT/XAc=;
 b=kgK8V+b3PYdSWmIZh89sz/410Xzxx0eJhAhtHAiUBgTxdZN47xjMbCYK5Sh3eMIuo+wzqoOBgK98AjUrN3jQhKr84TkqS/qO1tF2aM7Lrm6LNaxYOkWd+9H8574f9LuQKCQbZeTQTNLXXriPTbsAnWhZTHgndbUDbzsZDVBGTUM=
Received: from BN0PR08CA0030.namprd08.prod.outlook.com (2603:10b6:408:142::9)
 by DM6PR12MB3804.namprd12.prod.outlook.com (2603:10b6:5:1cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 03:28:38 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::fe) by BN0PR08CA0030.outlook.office365.com
 (2603:10b6:408:142::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Tue, 3 May 2022 03:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 03:28:37 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 22:28:37 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v5 3/3] x86/mce/mce-inject: Return appropriate error code if CPUs are offline
Date:   Mon, 2 May 2022 22:28:19 -0500
Message-ID: <20220503032820.61667-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220503032820.61667-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220503032820.61667-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20fa8cab-f851-4204-9ef3-08da2cb50331
X-MS-TrafficTypeDiagnostic: DM6PR12MB3804:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB38047A0BF4560183FA62042790C09@DM6PR12MB3804.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MAYCz7qQXDAJLzH5RvivBeuiPg6sibVrJSA5RjF2ZD7Y9LneTbfSjJqEALdymbIuIhOg61rsrs9AwN4xa3uJqD3LxGi7cHKms+g3n2wXghPI1yXDxYbyxq3bRkR1rzXlBPl20UvcjCdIO/enmgR5dNiVIe1wc/rPcWD7dDClsgYefePnNrEb84pUImq0ESoY4+rCKvNqZP2fwHet5VPsnjRMpWKfX6UHAsfbBjU+NzAdWabIZubfow74Lx33RWS7+dRiSXch36xwGgRrjpI4G0Foh4N/k5BrX8TA2dJT/gEIlKrAGuZ7ajC2MJhy7ghMCUDFXEoX1ZroA8VS13Lf7gXAr/MH4OW4Nu+gY3h/+AmELbdVf6A4EZNtWjiWibEgWeL81YpqtaO16xyBbSlQOBhR7YVxAs75RxqN5P7yeV4Z9dlIQbxz+R8BW3YRTFbRpZ1/Q81I5isQDcP/9WuZMgyd/rmlebzXT0rpeJaeHJ36zO+JMTfRXmQWgieAWsDyj18AFjqgTnugPWPq179qMskgqarkUTX8EctEwQCG9CGDHB1bbhiqjg4kxQlQZU+xL5NnWn1DpCjpX1MY7OU6WHc9LqMw0icxHAx9X5/qQrnuLytQ/jTboF9/q5A/xeFayYsGNWcc9zq2OuEVH5Ssz2n7eKMoip6KMZsMxHYcXWdnzQTp4KG8wWpzXyRdMFQq2rFMKoxWNW0uQSzH+dMrx5aUIlx0rJvqkc1EsvOYcXVn+XhqwxQDLdx89buF8NoMUuyPPLj9pU9C82l4ZjoXZ7F112stphML38V1NnXZB9U=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(966005)(7696005)(336012)(81166007)(36756003)(356005)(2616005)(426003)(186003)(26005)(1076003)(6666004)(508600001)(40460700003)(83380400001)(36860700001)(16526019)(47076005)(8676002)(70586007)(4326008)(70206006)(54906003)(2906002)(86362001)(8936002)(5660300002)(82310400005)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 03:28:37.9851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fa8cab-f851-4204-9ef3-08da2cb50331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3804
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Assign appropriate error code when no CPUs are available online.

Return this error code with appropriate message to user when injection
fails.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20220214233640.70510-3-Smita.KoralahalliChannabasappa@amd.com

v2:
	Added pr_err() along with error code.
v3:
	Rephrased the statement: No online CPUs available for error
	injection -> Chosen CPU is not online.
v4:
	Prefixed "mce-inject" so the user knows that the message is
	coming from this module.
	Printed CPU number along with the error message.
v5:
	Used the new descriptor for writing errors.
---
 arch/x86/kernel/cpu/mce/inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index cce068a4478c..efae0e938293 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -575,8 +575,11 @@ static int do_inject(void)
 	}
 
 	cpus_read_lock();
-	if (!cpu_online(cpu))
+	if (!cpu_online(cpu)) {
+		pr_err("mce-inject: Chosen CPU %d is not online\n", cpu);
+		inj_desc.err = -ENODEV;
 		goto err;
+	}
 
 	toggle_hw_mce_inject(cpu, true);
 
-- 
2.17.1


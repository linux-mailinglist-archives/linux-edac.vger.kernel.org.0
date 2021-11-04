Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25998445BEA
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbhKDWBw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:52 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:62305
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232266AbhKDWBu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGpKe/InHcviNWcdIRU9tR8uwWOqQA4+USpE3NoBRigYop7MtC9pkaUA+gj/VwmhEPVMmDC1tps0lM3YWbbfNsgShFJu1BGZ4/RvsjlckMVMCBlEWbq5udrTdfeceVoLFlrBDtYoSz8z0sb3TGaGtEcqYPbPnn2ED0V+tl3eXzNILHBv+ZfvkSEczBEqyA5HRvNwdmDI7sjAxutpqCUba3IGhJf9uZq4C8/IEuLyeSYczaBC2NT5P01rb402F15P6lGyA4FxMAN8lJfnbmQOb8sfzv5wXuGZgn1HIB1bg0k69WiJIknYTLMT9s8chT36faUM+QLFEteWFvO5HGs1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dADTAyJShjeY3qr73FxxBshERa39424+y6Ay9MnLFkc=;
 b=L4xxlxd/w8lcdzE+IyyRYe5XmYbRNEI4Nkxi7kBDD3YPYkd662VJrdgc+E0h6YOafWTUjFE9h7GcEvN9Mq3GlpC0w25TKEji6IKlQ+UIo19j5F51o6cxNiAoPtinEr1z2xeWxZv0w+neMZi73Zu+rU+WSzOiu0cnGrsIMr4VF8VPfE3aImwXNgPCgLMYhbU30d9e4yzNg0n4Wi5q4XX+wTt7FyY3Ln+9PaR/tf0471fGQygUn+/pc8Qy60fIn0tkZqVJWy8nmqPCUy0AcYldHxmX9eoHYrzp9oENEjfxJKayS+Q33yZev0/lIaIVJWQUl5/A85kHbM8scad6STbgZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dADTAyJShjeY3qr73FxxBshERa39424+y6Ay9MnLFkc=;
 b=qYpuSK3nb6ciRYLI6URBSuhgEydM2MR+qpwtLEM7Z9oBYq22mtVbFxko6lmE0DiR13zLUyIM7cau9K1lBkQY4eL0/stlNIdAA0xxZB1Ncaszsq4zLHo/aS/DzWVUgtUBVsuCz1AumpVMBnEyD+j8BCQsUl/eX1HK0y4rW7hlaH8=
Received: from MW4PR04CA0191.namprd04.prod.outlook.com (2603:10b6:303:86::16)
 by BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 21:59:10 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::30) by MW4PR04CA0191.outlook.office365.com
 (2603:10b6:303:86::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:10 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:08 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 4/6] x86/mce/inject: Simplify evaluation of writes ignored in status registers
Date:   Thu, 4 Nov 2021 16:58:44 -0500
Message-ID: <20211104215846.254012-5-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f0a5088-3d9c-4f02-d695-08d99fde54c7
X-MS-TrafficTypeDiagnostic: BL0PR12MB4948:
X-Microsoft-Antispam-PRVS: <BL0PR12MB4948FDF763B5443394E76238908D9@BL0PR12MB4948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PkSjU2Tu5wPddNePxgi0iatqi+Yg6tVp2JaGCV/OW2VSyeEkhyt8w7ZZWkXzlFs8KzDr4LP7byybWbTMMay0rNcjjfdTAHLtVOoQBfN2ZyWeFky8A2JyNVo3YFxhJ4s/9Oja1XiuUAkK8+bNnnq7E+IreBYr6LFypRTOaZ7GKDsKY+JShKzucDyHZWYGYdNaf+nu5rUUa+gRBWyEdXlg7TLpsZ6XWF7F+AJZ4SgBZggp8Gh2vrDVF0sginvmRieWBN2/AyuYJjNm27kaXJqrbbby//pTuk9C66PscUnnuLr0Q6Jk8yIu9AXR2VxKRmhrgDqXS/Dl3Y7K6kFrCVNMiail0a3yL7FKtdGi3CK6oUVEbYWRd7tMDgmPD7GWH76NpMpgy44itMvGJAgeNZ5Ll2P9w48xRquyFqAhbP0JVzG2oRB5ZT3LJaDYd0U38hKzQZpOjGz4y3zJkT9jgIWFuV/TfMUmAphJJ5zDY/3TpOE+CFe7M78EiYZv+JsrGFoePt3S22Mc1eZmwUsstK4mD3EmTkDywfddbfb/Y/5biz+cfbj41b5+IzVeRQNhuVH5zks2ymozWrPbXJ5IpSwAVaI6lhCTolPpwJ/qe0bBHAwax650S0Q1BNcHMWIdz0zEDSckO/lEQSDtBUrrAN4o9xCqazYqdYjTn/ifGb3XYxepeB2saK5H49RvCasWkKr4wfRyQDu6l5UnAVsYcs+ugYfXXCOJir3+XxXppX9uKtY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(316002)(36860700001)(336012)(26005)(426003)(54906003)(8936002)(110136005)(186003)(2616005)(16526019)(36756003)(2906002)(47076005)(82310400003)(4326008)(1076003)(7696005)(81166007)(83380400001)(70206006)(70586007)(6666004)(5660300002)(86362001)(8676002)(356005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:10.1695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0a5088-3d9c-4f02-d695-08d99fde54c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4948
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Clean up code in prepare_msrs() and avoid reading the status variable
and checking for writes ignored each time for SMCA, legacy and deferred
case.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 arch/x86/kernel/cpu/mce/inject.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 4d5689342384..8772d8820994 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -483,41 +483,34 @@ static void prepare_msrs(void *info)
 	struct mce m = *i_mce_err->mce;
 	u8 b = m.bank;
 
+	u32 status_reg = MSR_IA32_MCx_STATUS(b);
+
 	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		if (m.inject_flags == DFR_INT_INJ) {
-			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			rdmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			if (!m.status)
-				goto out;
-
+			status_reg = MSR_AMD64_SMCA_MCx_DESTAT(b);
 			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
 		} else {
-			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			rdmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			if (!m.status)
-				goto out;
-
+			status_reg = MSR_AMD64_SMCA_MCx_STATUS(b);
 			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
 		}
 
 		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
 		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
 	} else {
-		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		rdmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		if (!m.status)
-			goto out;
-
 		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
 		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
 	}
 
-out:
-	pr_err("Error injection is not available\n");
-	i_mce_err->err = -EINVAL;
-	return;
+	wrmsrl(status_reg, m.status);
+	rdmsrl(status_reg, m.status);
+
+	if (!m.status) {
+		pr_err("Error injection is not available\n");
+		i_mce_err->err = -EINVAL;
+		return;
+	}
 }
 
 static void do_inject(void)
-- 
2.17.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA2E434227
	for <lists+linux-edac@lfdr.de>; Wed, 20 Oct 2021 01:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhJSXj1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 Oct 2021 19:39:27 -0400
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62]:21040
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229977AbhJSXjW (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 Oct 2021 19:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYmYfwStMa8tmskF23S67i49+Ei/whavj9W23IAUqsuzKN3VaFnvAN1aqDL4vSc5QClzw7KuMfmsCxoqm4qvgzJoipWuI3gxiE03i8jeUo1QqcKVn/EsX8Ij9603MB5fMsEHHPAZ7I1+lZtGdZpHDOgCgOUjRAauRzgNIiIVvY+JzrTQXoyC+A3G9l3HPaTUFzX9zVWZxPDKlAnJtj9tfHrG44cZf5j/z3fwRMVC/9j+RzoZ8OFuyu9otmKGgCnlq/Ika1oywpgsQ05lVrvfSb+DGu9LBom4b80iW/QmXY/0ZWco1qee7ehmCXk6d8VqelWQSxFo7r6OsKnS8zqFVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aql1conarYYcOMMGPeZ8KzZEgRk0tWw7BKujuOwA64g=;
 b=nvPl9pZgTK+Idh9i1gH+6tWpqq1o3k3dVjsn8Paol1dfkMYcS88HI8rEnOn3pGSokB3qPZaQI2ijipX9q37EjKt0X+bOLFy2FXdQ6exnscSqSboEq9ZQ5eziz3MvrzT16O+M2vcYu7K2pRqWL4TnmkIcQn0kurZ32JybeEKFYj/Jivf9mgSCF6/BSz5xF3fasloNA2+N/Q1H0BF8IJQKO83Mdm4ndzgH2xVQ1AFK/GXmSvmMsCXTfx27yzcjt3MYGUaVDNq8/ngM2WEBK1TPEydnEcid88i5ja9VDBucz5IbPXLwkTJPAp15qUWHm11/CogM6YXxmotOfRmyJlVnZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aql1conarYYcOMMGPeZ8KzZEgRk0tWw7BKujuOwA64g=;
 b=tA78vf8Kw/xZePDCxeLvQMGQXYEYWIdMOR+wxUEAnyJdpqbUpZWmHlbL/ZQ2nGj5BMNgwhLI14snmtaehJINqYr/6l4LD1rZ+cl3Rj5wY9BqVxCcfCdfSqit4uIh/d+vzYKnuYCm+ZxIeRnqejGLWqJFyulsuBIENGvCE5Dj24c=
Received: from DM5PR2201CA0009.namprd22.prod.outlook.com (2603:10b6:4:14::19)
 by BN8PR12MB3425.namprd12.prod.outlook.com (2603:10b6:408:61::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 23:37:07 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::1f) by DM5PR2201CA0009.outlook.office365.com
 (2603:10b6:4:14::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Tue, 19 Oct 2021 23:37:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.16 via Frontend Transport; Tue, 19 Oct 2021 23:37:07 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 19 Oct
 2021 18:37:06 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 3/5] x86/mce: Use mca_msr_reg() in prepare_msrs()
Date:   Tue, 19 Oct 2021 18:36:39 -0500
Message-ID: <20211019233641.140275-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211019233641.140275-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad346f4-366d-448c-22af-08d993595d3c
X-MS-TrafficTypeDiagnostic: BN8PR12MB3425:
X-Microsoft-Antispam-PRVS: <BN8PR12MB3425F735E4F1E66FA4C5EE0C90BD9@BN8PR12MB3425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lD9O3wosDHO+zwSpn/rKdMuiEYN4mw8o/+d3wBhv3TvtXh/e8p8dLOxi/GhjdLqvQN1VKGzMijGXYsk4hOgu4sL7JrThyf7YtEdEJU6GYa3HJjq2Xfp1EY9MwN19OdKcaeOPvF2NA4+/JUel/NK1h/TrZ+JTvKAUSCfxQvI5fdSkcFOTq6tL9C9Boyvti/N7ULnEeOVjT/waLxH44lB3FH4JBxyBarhaAQ45x+c/tRNYIQjGWss9U0haSRAqP6CC9cc0FV447TmRrFpi6Z0684y5weaXEVBFPS8D5cBb6TfpJaCHGiZiQAEoFyRh5S4GB1zU0B8lD0x3j2YZ8mehfS68B3huc2D3L31JpAL9vVuxcnucgppaA2l3jqk0M6T61mZscIK68JXg8iTTp6R5UilUTJyHlksYU4XfTAVWS9R4U8fHXXZFEnxNzJthTKu2tEVzK/XAF8b3J87KiHWvoY0xuvz/xefhWSvmDDhYKO83c8e5iLhTerMA9WHPWFXVxVKchAn5IGwK+xHSBtmp5Ix1Ng4YZuIqKDPIXPz5mjt1UQ0166hi4ADn0W6kCC3wwfmCmpeayHyfFp7WqPPV3YeLscxCkuHamK1ZTEJymNrjbXlwjdFsRkiUJXfd1bJJsG26palh51q4RVc+WYZ/rQEoCX/oJlzasllS6ZLly+K33LlsKxi2hyITipjLmza3wxJ1jpwm5tq8ePFnJNf4TYY6z/VGrH16FT+ZIWdAqng=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(356005)(86362001)(81166007)(83380400001)(316002)(186003)(7696005)(16526019)(26005)(70206006)(336012)(54906003)(110136005)(70586007)(426003)(2616005)(8936002)(5660300002)(6666004)(8676002)(36860700001)(1076003)(2906002)(508600001)(47076005)(36756003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2021 23:37:07.4240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad346f4-366d-448c-22af-08d993595d3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3425
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Replace MCx_{STATUS, ADDR, MISC} macros with mca_msr_reg().

Also, restructure the code to avoid multiple initializations for MCA
registers. SMCA machines define a different set of MSRs for MCA registers
and mca_msr_reg() returns the proper MSR address for SMCA and legacy
processors.

Initialize MCA_MISC and MCA_SYND registers at the end after initializing
MCx_{STATUS, DESTAT} which is further explained in the next patch.

Make mca_msr_reg() exportable in order to be accessible from mce-inject
module.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Replaced msr_ops -> mca_msr_reg().
---
 arch/x86/kernel/cpu/mce/core.c   |  1 +
 arch/x86/kernel/cpu/mce/inject.c | 27 +++++++++++++--------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6ed365337a3b..fb4d8ac1cb4f 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -194,6 +194,7 @@ u32 mca_msr_reg(int bank, enum mca_msr reg)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mca_msr_reg);
 
 static void __print_mce(struct mce *m)
 {
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index a993dc3d0333..40d0bebe0cd2 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -461,22 +461,21 @@ static void prepare_msrs(void *info)
 
 	wrmsrl(MSR_IA32_MCG_STATUS, m.mcgstatus);
 
-	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		if (m.inject_flags == DFR_INT_INJ) {
-			wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
-		} else {
-			wrmsrl(MSR_AMD64_SMCA_MCx_STATUS(b), m.status);
-			wrmsrl(MSR_AMD64_SMCA_MCx_ADDR(b), m.addr);
-		}
+	if (boot_cpu_has(X86_FEATURE_SMCA) &&
+	    m.inject_flags == DFR_INT_INJ) {
+		wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(b), m.status);
+		wrmsrl(MSR_AMD64_SMCA_MCx_DEADDR(b), m.addr);
+		goto out;
+	}
+
+	wrmsrl(mca_msr_reg(b, MCA_STATUS), m.status);
+	wrmsrl(mca_msr_reg(b, MCA_ADDR), m.addr);
 
-		wrmsrl(MSR_AMD64_SMCA_MCx_MISC(b), m.misc);
+out:
+	wrmsrl(mca_msr_reg(b, MCA_MISC), m.misc);
+
+	if (boot_cpu_has(X86_FEATURE_SMCA))
 		wrmsrl(MSR_AMD64_SMCA_MCx_SYND(b), m.synd);
-	} else {
-		wrmsrl(MSR_IA32_MCx_STATUS(b), m.status);
-		wrmsrl(MSR_IA32_MCx_ADDR(b), m.addr);
-		wrmsrl(MSR_IA32_MCx_MISC(b), m.misc);
-	}
 }
 
 static void do_inject(void)
-- 
2.17.1


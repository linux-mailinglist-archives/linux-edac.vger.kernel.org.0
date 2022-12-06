Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EA7644A6A
	for <lists+linux-edac@lfdr.de>; Tue,  6 Dec 2022 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbiLFRhC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Dec 2022 12:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiLFRgi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Dec 2022 12:36:38 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2077.outbound.protection.outlook.com [40.107.100.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7EA3C6CD;
        Tue,  6 Dec 2022 09:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwVouJ79/r23e3rP0/D9xtFymij5qx1fPq+iVNmW5KBfaCDq4Gr9wzfGO7+RJCEXyZ2LVhiRw9OMql6safW5qmJqyOuM+uvgJY/WLrkzKGol2Kj9vItdLncFGUK7yon609sPIBQfkGYTxKjAG/JbE6dtL8f5/ej7CY7ua8/Dhbk8T4p9sIMMHcDzV5qc5yJGij5nLFEe7kqAj8KEURGAylD+s9HNjtSxDfVXbsnLqMPd53YPaPgsH3akxtnOJ0UkjTL9YBZFkCDJQihevNG0tDu0ehdyfugcc8/aOOsM2dE5SGqF67BCP/5y4SIaVLUTgj6rjWvGgun8tx4BT/bGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMF2H8/NQVQsNoyo2bC9s59caUM3T+h9DODdJ//at0k=;
 b=cQHhiW7qQeCvjU6qu8MsIgGSd82bC1XW/PWSKNX8ebnL7Kl0GP58HkJawdZCWcZkC8DRg+nINSzpYQPUOL963IUgnCpOPUlWMNJWzLQLCodjsDBxNBPuZgcnxneTdzqwpJsP5k8sNTwAKh8/hxn7waOm03+qDbV48WcSVYwb85bjiIZ7qzcgk6hwJDoVlLL1BEqRmCL1L0E9MdCegGqwQtaSr485a3R2TYX8+HoD4Vgcca7IiJu3uaet1yr+NiYCVtP31dUtrb/MD55xW9CG6uPs0WtNryJ7mOhq3p5fwoYKtrM8lxh0e2Prg/itXIYw+9kw7axz6CUXu00exiBapA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMF2H8/NQVQsNoyo2bC9s59caUM3T+h9DODdJ//at0k=;
 b=yQ2ee0l/NwJPSYWwObTCRaxpBmh29v9Vec5pJ++be0ApNp9h2AxKrwGz8VdSue1353hZJ4TtTwqlIJ98s3Tq53rMurm2BIrXZxgBwhPZA3OVNlqzm3oUskdSazzn2C2qOW2tWwz/m2Wm2Uyy0mYG0NuxAR8OBPVoOwDcLj7O1yI=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 6 Dec
 2022 17:36:22 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::8e) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 17:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Tue, 6 Dec 2022 17:36:21 +0000
Received: from titanite-35bahost.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 11:36:18 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v6 2/4] x86/mce: Remove __mcheck_cpu_init_early()
Date:   Tue, 6 Dec 2022 11:36:05 -0600
Message-ID: <20221206173607.1185907-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206173607.1185907-1-yazen.ghannam@amd.com>
References: <20221206173607.1185907-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: eccb75f5-beaa-42e9-5f93-08dad7b063f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kRiIJgoJoxvsVqanxf0L/Bs2PxkN0kNwZCHEd8cAEWfAv/9AGo9P3ggIddUAXapF03UVvOSg8lZ0UY1+WjqsSUJ/LhuRQhQy6tnmTd1aBNv9rfLB2QueQgVC1Bu+VJLV1NfrVH9l+faDvqniBoYdb2yezwnjqQu1pV6ZrEyNTMNflJtHLPk6K1RLba6KxmBB2aTF4VopRM5xnVaMgMrQiXTXStD4kgSwBZHUmMd4CUmjeP3vfqBTACg8soxn5YxcghEIgRSaoLqDwPJdOGQ+zf4S7zzOW43ctluwjPYVsYHXN+zGWy1ptdTRDNAzornyIjRNzLdl+xXkDnCy8hXlfy8+DeCj4vM0ihNjeLF6pAl1BfvVNQ7qmElIOlx8AAq2YmAx9YOWcc5Xf4vcihNxBwRdqtmN3Ul2UJ21C4Dk1IXcRIv89kDeWiSI5CqET/7Ls2Oqhe/NzsWLnzgi0aIkNy6dl8S41nOgC9dpaj4Ba7Z8YPAm50RCcP1+M250ft6rT4MRBcJY7Fwx5mQ8fL9omPINGr4zF+xHPbxuCv1QwaYT0Xg1kV4FZH8n9P1HFfKuo4d06A3ouWRix7TfJ+ntXJH5NJ/1LCE30avfh5VEiD8bZqef8brc5yU+8jmjqRbsE/QPRSaodHCmtD8owInp1wk17RJMh7GMItp7aybbotgeDeeaETTZq6ePFa6bbOljHcer2sorUivxVFet/o6r0ZAW9fUvYxcSTMXZXpipXkjrYPp1WDm07vr8UjZ+lbaWRHAirHVly6n5SkcAZgyaTkDBzhja4MsU9NpXx8L4M+Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(6916009)(54906003)(47076005)(478600001)(26005)(6666004)(81166007)(316002)(70206006)(70586007)(4326008)(8676002)(7696005)(966005)(44832011)(1076003)(2906002)(36860700001)(336012)(41300700001)(83380400001)(186003)(5660300002)(16526019)(40480700001)(36756003)(2616005)(82740400003)(40460700003)(356005)(426003)(8936002)(82310400005)(86362001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 17:36:21.5959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eccb75f5-beaa-42e9-5f93-08dad7b063f4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event
done in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().
Also, move __mcheck_cpu_init_generic() after
__mcheck_cpu_init_prepare_banks() so that MCA is enabled after the first
MCA polling event.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Link:
https://lore.kernel.org/r/YqJHwXkg3Ny9fI3s@yaz-fattaah

v6:
	New.

 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 20 +++-----------------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 10fb5b5c9efa..b80472a52ad8 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -681,6 +681,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low = 0, high = 0, address = 0;
 	int offset = -1;
 
+	mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
+	mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
+	mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 = 1;
 
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5f406d135d32..9efd6d010e2d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1906,19 +1906,6 @@ static int __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 	return 0;
 }
 
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor == X86_VENDOR_AMD || c->x86_vendor == X86_VENDOR_HYGON) {
-		mce_flags.overflow_recov = !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 = 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg = &mca_cfg;
@@ -2139,10 +2126,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 
 	mca_cfg.initialized = 1;
 
-	__mcheck_cpu_init_early(c);
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2308,9 +2294,9 @@ static void mce_syscore_shutdown(void)
  */
 static void mce_syscore_resume(void)
 {
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2327,8 +2313,8 @@ static void mce_cpu_restart(void *data)
 {
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
-	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_prepare_banks();
+	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_timer();
 }
 
-- 
2.34.1


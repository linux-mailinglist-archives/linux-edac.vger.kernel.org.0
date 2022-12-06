Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B53644A68
	for <lists+linux-edac@lfdr.de>; Tue,  6 Dec 2022 18:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbiLFRhA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 6 Dec 2022 12:37:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbiLFRgi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 6 Dec 2022 12:36:38 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5873C6CA;
        Tue,  6 Dec 2022 09:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drYZGP/b+JmzZEHEGKwIK91yQ4nDPEcO2MEztxA74ZXk0mLLgQ2ER6fX2r6EUeTPlK9v1hAby8SfrP5JNE6oKK1HGYBb1Qm7IXjhAB1mHmPaBWwTxuYVdsOEbd18sSEmuJK4vlQRCIKvEDZTEaJ7nWSVicOATslqnbZxwEDrp8hrZBSkTqn89V3Qiwo76baHGUeT0V4YmXjFZAveAWviRsfzzOlIBRXw4HuXGSaDJtwENQCoTSe4NrWhUzQUFAPuGgiHJAUtKYec57O1lgNy9DwZVjtw4HU2v+B8OLD5n8M7s3pnz7FkIN7X/xFgV1CFl+c2H997yLLP5v5EATPrjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Auldu/nWsyb20QAB4PBQ5TaoIOsv5m3Y/qhsz9Ke73E=;
 b=Tc5qO+exwUXlF0vB60OJEB5Du93YltBllijMm30yxxmcAl9cnQaSEl+PTiMVIizNYq3vLf3TA5jZQguPlypYuLxcAlPHaoKxlaK74M990vfWQOfipCCVBRC8+INvhbsWDneeVTwLX/J+2Jq1KtZxzNq0+AZv5zXGEiiWVNn3Ob5ukwOnfRZh9+zGr1/pq4Qz5Nf4ltpHSn9QbA87yQtLh2kazV5xrqcHj474z7kP7usoOjr92kn2jq19JASmuvmBsXKo4lLNYgQWOqKtialGDIdGcIlPKahDKUafiOag4wtDeECWO8ygoQu41MYG8qEQChFu0JGAReYfe2VOTWg+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Auldu/nWsyb20QAB4PBQ5TaoIOsv5m3Y/qhsz9Ke73E=;
 b=GaFfyksUsEfcYe+ObUvC5cjRi08GBm1Tc5ZOflqUzgsPF7VS89slmenO7Pkn4cYs0zzQb6o5K5GtxD2YESoJ8W8x0ZikqKHTuP/CSsLk2Kuj8wsGVF3DvNwaefxvvdOt0W1fzuoMBo4FmV3R2W06oY5hfmDGN9Amav5IGCK3u/U=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by DS0PR12MB8367.namprd12.prod.outlook.com (2603:10b6:8:fd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 17:36:21 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::93) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Tue, 6 Dec 2022 17:36:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.14 via Frontend Transport; Tue, 6 Dec 2022 17:36:20 +0000
Received: from titanite-35bahost.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 6 Dec 2022 11:36:17 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v6 1/4] x86/mce: Cleanup bank processing on init
Date:   Tue, 6 Dec 2022 11:36:04 -0600
Message-ID: <20221206173607.1185907-2-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|DS0PR12MB8367:EE_
X-MS-Office365-Filtering-Correlation-Id: 30760b8b-1ea5-4bdf-1986-08dad7b0636a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5sdEwfMtjLXdNpUeqOh/9zj0+X5KPnnL3lTR6YeiJuJz4K2BuY2SDx6R+CzDuQBceyejU198TLzjQ+3BCrHnN4RKwu7G47k+pKzBaW6k17Q1CtyR/8EpREb71jkH+zvIUdajCfW9EQDoSn9nEJv2Sk7QAlapJZWEbFyHPTqThxFuQtwS63nfq9hpmJz/B8sBE6Y1OD1kzDtX18u/b0+7C1g5KpmMyT5KTKTOLLjFwh2e82GTxUNv1nh54rRxerAxo8Xi9Bnds00PDmzQ40li94Zo/87eR931JeDvN171Q0GyipDSpQ2fzc/G4HSZk/DZAQ8S8urrwBTURxlksb1RCibNUVqr23XlxbBQQiASYTv4fVFkDddrUulE8v29pYCWGJ3k9keoocbVM7c4P/RDZBqIXdkxCkFOQeDuepiIjhUQVAYn0c8/HFP1OxtZHsEMbt+qB0A37T8ZV6OxcYCIV4+nZk38nCiE7g5FT9uLHSrMkugkaHhxPWoRscPOW92HS2g9H8VpeollOuBzHAoiFNsJF0skDD6N3zX8giA1E3W/ZIvOH7b5XjFduoL7ghOahf72VQrOjE7VBRt34dxB79ZM8qm4fAf1TfcbdzSe9Dxllm/hwWFEF44ZxQQOZvHibdJPxNDdkhk1d2X8LRmsP9xkESXzkxVsEnnStC4tGd4pGBE5xjE/D+xm47IrAEBSoUPVYvaRu99+GUkp/M4BS0iLRBkt2nZQKoZN35CxfvAroyiypfzFJw964v4YOCb7CGLWkiWjHLVIl7phEbSzefk2c2dyeZWo+2Co0AqeK0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(426003)(47076005)(40460700003)(86362001)(7696005)(478600001)(966005)(40480700001)(81166007)(36756003)(8676002)(82740400003)(82310400005)(16526019)(186003)(2616005)(36860700001)(1076003)(336012)(44832011)(5660300002)(41300700001)(4326008)(26005)(6666004)(83380400001)(356005)(70206006)(15650500001)(54906003)(70586007)(316002)(8936002)(2906002)(6916009)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2022 17:36:20.6897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30760b8b-1ea5-4bdf-1986-08dad7b0636a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8367
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Unify the bank preparation into __mcheck_cpu_init_clear_banks(), rename
that function to what it does now - prepares banks. Do this so that
generic and vendor banks init goes first so that settings done during
that init can take effect before the first bank polling takes place.

Move __mcheck_cpu_check_banks() into __mcheck_cpu_init_prepare_banks()
as it already loops over the banks.

Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Link:
https://lore.kernel.org/r/Ylb3/4oi6KAjdsJW@zn.tnic

v6:
	New. Added Yazen's Reviewed-by.

 arch/x86/include/asm/mce.h     |  3 +-
 arch/x86/kernel/cpu/mce/core.c | 64 ++++++++++------------------------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6e986088817d..0dd7752345ec 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -253,8 +253,7 @@ DECLARE_PER_CPU(mce_banks_t, mce_poll_banks);
 enum mcp_flags {
 	MCP_TIMESTAMP	= BIT(0),	/* log time stamp */
 	MCP_UC		= BIT(1),	/* log uncorrected errors */
-	MCP_DONTLOG	= BIT(2),	/* only clear, don't log */
-	MCP_QUEUE_LOG	= BIT(3),	/* only queue to genpool */
+	MCP_QUEUE_LOG	= BIT(2),	/* only queue to genpool */
 };
 bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b);
 
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 2c8ec5c71712..5f406d135d32 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -738,9 +738,6 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 log_it:
 		error_seen = true;
 
-		if (flags & MCP_DONTLOG)
-			goto clear_it;
-
 		mce_read_aux(&m, i);
 		m.severity = mce_severity(&m, NULL, NULL, false);
 		/*
@@ -1707,7 +1704,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		/*
 		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
 		 * the required vendor quirks before
-		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
+		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
 		b->init = true;
@@ -1746,21 +1743,8 @@ static void __mcheck_cpu_cap_init(void)
 
 static void __mcheck_cpu_init_generic(void)
 {
-	enum mcp_flags m_fl = 0;
-	mce_banks_t all_banks;
 	u64 cap;
 
-	if (!mca_cfg.bootlog)
-		m_fl = MCP_DONTLOG;
-
-	/*
-	 * Log the machine checks left over from the previous reset. Log them
-	 * only, do not start processing them. That will happen in mcheck_late_init()
-	 * when all consumers have been registered on the notifier chain.
-	 */
-	bitmap_fill(all_banks, MAX_NR_BANKS);
-	machine_check_poll(MCP_UC | MCP_QUEUE_LOG | m_fl, &all_banks);
-
 	cr4_set_bits(X86_CR4_MCE);
 
 	rdmsrl(MSR_IA32_MCG_CAP, cap);
@@ -1768,36 +1752,22 @@ static void __mcheck_cpu_init_generic(void)
 		wrmsr(MSR_IA32_MCG_CTL, 0xffffffff, 0xffffffff);
 }
 
-static void __mcheck_cpu_init_clear_banks(void)
+static void __mcheck_cpu_init_prepare_banks(void)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
+	mce_banks_t all_banks;
+	u64 msrval;
 	int i;
 
-	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
-		struct mce_bank *b = &mce_banks[i];
-
-		if (!b->init)
-			continue;
-		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
-		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+	/*
+	 * Log the machine checks left over from the previous reset. Log them
+	 * only, do not start processing them. That will happen in mcheck_late_init()
+	 * when all consumers have been registered on the notifier chain.
+	 */
+	if (mca_cfg.bootlog) {
+		bitmap_fill(all_banks, MAX_NR_BANKS);
+		machine_check_poll(MCP_UC | MCP_QUEUE_LOG, &all_banks);
 	}
-}
-
-/*
- * Do a final check to see if there are any unused/RAZ banks.
- *
- * This must be done after the banks have been initialized and any quirks have
- * been applied.
- *
- * Do not call this from any user-initiated flows, e.g. CPU hotplug or sysfs.
- * Otherwise, a user who disables a bank will not be able to re-enable it
- * without a system reboot.
- */
-static void __mcheck_cpu_check_banks(void)
-{
-	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	u64 msrval;
-	int i;
 
 	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
 		struct mce_bank *b = &mce_banks[i];
@@ -1805,6 +1775,9 @@ static void __mcheck_cpu_check_banks(void)
 		if (!b->init)
 			continue;
 
+		wrmsrl(mca_msr_reg(i, MCA_CTL), b->ctl);
+		wrmsrl(mca_msr_reg(i, MCA_STATUS), 0);
+
 		rdmsrl(mca_msr_reg(i, MCA_CTL), msrval);
 		b->init = !!msrval;
 	}
@@ -2169,8 +2142,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
 	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
-	__mcheck_cpu_init_clear_banks();
-	__mcheck_cpu_check_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_setup_timer();
 }
 
@@ -2338,7 +2310,7 @@ static void mce_syscore_resume(void)
 {
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(raw_cpu_ptr(&cpu_info));
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 }
 
 static struct syscore_ops mce_syscore_ops = {
@@ -2356,7 +2328,7 @@ static void mce_cpu_restart(void *data)
 	if (!mce_available(raw_cpu_ptr(&cpu_info)))
 		return;
 	__mcheck_cpu_init_generic();
-	__mcheck_cpu_init_clear_banks();
+	__mcheck_cpu_init_prepare_banks();
 	__mcheck_cpu_init_timer();
 }
 
-- 
2.34.1


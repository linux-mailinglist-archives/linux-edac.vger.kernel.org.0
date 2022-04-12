Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A934FE4FB
	for <lists+linux-edac@lfdr.de>; Tue, 12 Apr 2022 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357212AbiDLPnk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Apr 2022 11:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357234AbiDLPnh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Apr 2022 11:43:37 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2081.outbound.protection.outlook.com [40.107.101.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6747A5EBC0;
        Tue, 12 Apr 2022 08:41:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ma/54x0gjN9Wl0AR8CXFPEOD1HYaYzvLqVNlgxWKzfXUSKh6hDuC3ITRrxqFBXFl0ESsp+iM188nOOM74QPKA3FQjPP6ymWjEIHeJT32Tu1vplgHvnnhJInQaA7VY/sCaFI6toPGWHyxa1IfgWSEAcIjAd2EADZ7OeBu1DAvDMp+QXYMoebSdYRbvh/3Yc2GovZgs3asvLpnAZeR7CWaW5qmNeixo6/9rHdt+P/xqzh1hyNHoxiL7+v1gjM1uOH+PF49Gob+/IAApPHtuJihCNkSO6G/HOhe4eVk5EBhRWfQYU3AMPGKqJtyXowWdIz3nKCKxXgJq1h14HMEAibHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9PQ59TSscRf3tO6llEJb1LV+fjoiheEe7Rxr8Fce/Q=;
 b=ipqC9lPhUBLLcJ+gcMe2zk9WCWQVEXajSIpK/BA+hNaoUUJwYNR6JscmgpubXED0yuq2ibtcsaBtkw7hzKnWatfU47h0m32UOsgboSY4HzTeNExRn/8xHr3VgU0BXgOF2M+KdvhQvHxSqMG6B5Ymm/+xEmUFwGOFUq8v2lLsYrd3EmTh0+BQj4/ZUyXBcEvAGiwGHr6Y7FTziMY6+twIKy2eeQHxPX0jhR3RX9y6UcnER3ul5MaxPaiq0CJ5tCh+p0y2YjqlEPw9pPU3Io0+/1U2JCT5DpJreY0AT/yba6TB+5RHlcl6OoAtPUyrI7YV8lBlpjpr6oYMnHdwiWC7kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9PQ59TSscRf3tO6llEJb1LV+fjoiheEe7Rxr8Fce/Q=;
 b=O9i0eUrX6v31X/JnPU4u8ZNjW5MnbkrTdp6SPgoaO9kLK6nDMiPgd/Wz7pDXRqOIC4Emw8TXBuC5/2CapDKXXp8IG/oiKFGdKmMsmIPRf4lDDD4OJjBqOivnlY+W4slhFdLTc/9yyF7RZ9+DUhIVv+etPRHJN907oj/KW4Yjppg=
Received: from MW4PR03CA0234.namprd03.prod.outlook.com (2603:10b6:303:b9::29)
 by MN2PR12MB3567.namprd12.prod.outlook.com (2603:10b6:208:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 12 Apr
 2022 15:41:04 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::9c) by MW4PR03CA0234.outlook.office365.com
 (2603:10b6:303:b9::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Tue, 12 Apr 2022 15:41:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 15:41:03 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 10:41:01 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v5 2/2] x86/mce: Add support for Extended Physical Address MCA changes
Date:   Tue, 12 Apr 2022 10:40:38 -0500
Message-ID: <20220412154038.261750-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1e2ad81-a90a-45fb-aa2c-08da1c9ada0a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3567:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3567EE2F348DBF1F3A97038C90ED9@MN2PR12MB3567.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ONXVqCzuRbPQvVDqThyOiLfR9YsDf418XSCm9zMAYUjTvSkpG5UIS6AXrPlVw73qOBd5Mu5jeMLBludoI3dB164fZlxxy6H86no7EGaixjlSb5Kbar4FcQuHcp51mJ/Dt3gwxTttBMvFu82Q41sNuxML4gNjzi9RjMwrijdI/IWcjqbmjhS9gqYtznHXVqdA0YSuWjnTAzLY1Cr9RfI/LP4nTEDi4IK1mwSIX+KltIJhaTbWhJg32w4LXRflBmlGxwCizzHFybRbbog70oSS5M0/Ame2EJpdR1b6wi5Lhhfc1gxb0Ugtwe/LSpJIIvVXBAaV6PEHjvJToZ4heWTV7Zgs+XwtcyTYQSfU5K0s2eTXb8qdbm6h0gkLL8aM3fpt1A6JgvBVqeUaXNb8o0Dcrevy4Xpg/SjrWkbvAiguKt4BZOFYHFHkf34Xx1yrmpnGy7O+7xja7/juWJRzVhjOrVdR20/dpC3KsuV0FqI+9DpfXBw8fQ8OLlE0laQ02DWLSuUyg0C3ybXNvU4qeMe/MdFAv7LUx9fMGGlBodUgTDjO2IHD83H5QmfKpJB59R0cJ9o+UQHyb5/TBvLn3qJOA7sIBBBf1ETBQ2Ei5AuSlyvQy9cz92cUKF+ANOJDneVsYcaTDbaM5DDoMqCFTVHjs3d0PK8vBkERAyZGb9845Ww8QWsSA4HIUS8lPBCt/8aM5cmu9Wl0fCiTzTBWSfyF1lXruN7bV/sb6VuRMVIu83qw9RRKaH2q5LoxFW72MKl6L4oqG6vtBGRotCKHfh690m8kad05b6v7w/YmH8Vi/MfUJlp5K9mzM1gkYsru+gjIO0Kqc989ugzdHt67NgF95w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(54906003)(8676002)(36756003)(2906002)(40460700003)(81166007)(316002)(82310400005)(110136005)(4326008)(70586007)(356005)(70206006)(7696005)(26005)(508600001)(966005)(8936002)(83380400001)(6666004)(5660300002)(36860700001)(336012)(186003)(426003)(16526019)(2616005)(86362001)(47076005)(1076003)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 15:41:03.3301
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e2ad81-a90a-45fb-aa2c-08da1c9ada0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3567
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Newer AMD CPUs support more physical address bits.

That is the MCA_ADDR registers on Scalable MCA systems contain the
ErrorAddr in bits [56:0] instead of [55:0]. Hence the existing LSB field
from bits [61:56] in MCA_ADDR must be moved around to accommodate the
larger ErrorAddr size.

MCA_CONFIG[McaLsbInStatusSupported] indicates this change. If set, the
LSB field will be found in MCA_STATUS rather than MCA_ADDR.

Each logical CPU has unique MCA bank in hardware and is not shared with
other logical CPUs. Additionally on SMCA systems, each feature bit may be
different for each bank within same logical CPU.

Check for MCA_CONFIG[McaLsbInStatusSupported] for each MCA bank and for
each CPU.

Additionally, all MCA banks do not support maximum ErrorAddr bits in
MCA_ADDR. Some banks might support fewer bits but the remaining bits are
marked as reserved.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20220225193342.215780-4-Smita.KoralahalliChannabasappa@amd.com
---
v2:
	Declared lsb_in_status in existing mce_bank[] struct.
	Moved struct mce_bank[] declaration from core.c -> internal.h
v3:
	Rebased on the latest tip tree. No functional changes.
v4:
	No change.
v5:
	Extend comment for smca_extract_err_addr if AddrLsb is found in
	MCA_STATUS registers.
---
 arch/x86/kernel/cpu/mce/amd.c      | 11 ++++++++++
 arch/x86/kernel/cpu/mce/core.c     | 11 ++++------
 arch/x86/kernel/cpu/mce/internal.h | 32 +++++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index f809eacac523..4f2744324d9b 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -722,6 +722,17 @@ bool amd_mce_is_memory_error(struct mce *m)
 	return m->bank == 4 && xec == 0x8;
 }
 
+void smca_feature_init(void)
+{
+	unsigned int bank;
+	u64 mca_cfg;
+
+	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
+		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
+		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
+	}
+}
+
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
 {
 	struct mce m;
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 39614c19da25..99e3ff9607a3 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -67,13 +67,7 @@ DEFINE_PER_CPU(unsigned, mce_exception_count);
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned int, mce_num_banks);
 
-struct mce_bank {
-	u64			ctl;			/* subevents to enable */
-
-	__u64 init			: 1,		/* initialise bank? */
-	      __reserved_1		: 63;
-};
-static DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+DEFINE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
 
 #define ATTR_LEN               16
 /* One object for each MCE bank, shared by all CPUs */
@@ -1935,6 +1929,9 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 		mce_flags.amd_threshold	 = 1;
+
+		if (mce_flags.smca)
+			smca_feature_init();
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 64dbae6b8a09..0f4934fb3d93 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -177,6 +177,22 @@ struct mce_vendor_flags {
 
 extern struct mce_vendor_flags mce_flags;
 
+struct mce_bank {
+	u64			ctl;			/* subevents to enable */
+
+	__u64 init			: 1,		/* initialise bank? */
+
+	/*
+	 * (AMD) MCA_CONFIG[McaLsbInStatusSupported]: This bit indicates
+	 * the LSB field is found in MCA_STATUS, when set.
+	 */
+	      lsb_in_status		: 1,
+
+	      __reserved_1		: 62;
+};
+
+DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
+
 enum mca_msr {
 	MCA_CTL,
 	MCA_STATUS,
@@ -190,7 +206,9 @@ extern bool filter_mce(struct mce *m);
 #ifdef CONFIG_X86_MCE_AMD
 extern bool amd_filter_mce(struct mce *m);
 
-/* Extract [55:<lsb>] where lsb is the LS-*valid* bit of the address bits. */
+/* If MCA_CONFIG[McaLsbInStatusSupported] is set, extract ErrAddr in bits
+ * [56:0], else in bits [55:0] of MCA_ADDR.
+ */
 static __always_inline void smca_extract_err_addr(struct mce *m)
 {
 	u8 lsb;
@@ -198,14 +216,22 @@ static __always_inline void smca_extract_err_addr(struct mce *m)
 	if (!mce_flags.smca)
 		return;
 
-	lsb = (m->addr >> 56) & 0x3f;
+	if (this_cpu_ptr(mce_banks_array)[m->bank].lsb_in_status) {
+		lsb = (m->status >> 24) & 0x3f;
 
-	m->addr &= GENMASK_ULL(55, lsb);
+		m->addr &= GENMASK_ULL(56, lsb);
+	} else {
+		lsb = (m->addr >> 56) & 0x3f;
+
+		m->addr &= GENMASK_ULL(55, lsb);
+	}
 }
 
+void smca_feature_init(void);
 #else
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }
+static inline void smca_feature_init(void) { }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE
-- 
2.17.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BC24B30BF
	for <lists+linux-edac@lfdr.de>; Fri, 11 Feb 2022 23:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354119AbiBKWfg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Feb 2022 17:35:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354229AbiBKWf1 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Feb 2022 17:35:27 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2044.outbound.protection.outlook.com [40.107.212.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF63D6E;
        Fri, 11 Feb 2022 14:35:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRrpGbz695lx9PVXZBL33ge8n4jf7UYaPgJb0U1bRXoDvKjcTE4ClkWSmmEwWbPYIn96CG4nr2GzYi1HmuhT5bgPKjb3rhl/xLsRDwBzzysvIkIGw/Rrt+jS+KdDpzMduikCjR33OQ361bmll7CaJpsbPbf27H02GgZod2CqMJXiWdr8JhVEt+8BPoUU1wSp2pXwPJXuhGf/0wAMCKQ7c12qGHzx6XsCUwfuBQZB/dTlofa/EwB0plJ3KRiuYolLBG/fU7SyV7T0YDZX1nTrc9UXFBJW2hKsTJ9VooQ6A+6EfGtysK+sQAHsOETnoUfcHlpkn+lFPgC+aSBnAud6Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qpu5zWTnkArGD7Ak7ac78BkaYIkvJMFK3iKhXCpi1uI=;
 b=c9PxbGNTyMP5rh8EnALtJY3tWPMlZetlPVoe2+Lw3fPhzCMxy+opnFFQG/Y1B6cgOAm7w5UCVqeahsmwCWdsKxF+8OzbqRD5tiQiSLx8RzmlpXOJ1qbz5zFXHDnmfsBPsMaNdABf6i/n1OKedxT+2B0GydhP2n0Vuqnazh4UvgdYvwvkffukSmAqsX+xrvoGHpJJsvBZ7qKaeGU0FLy8jPUod1G5TWDMgSzl/WJqbvgtWy7cUT4+h9vatRtk8F+u3ic3+dVWBP9s6GyFaNUqnV2vRJ8HV0rc0ZxR7EBCFk27XnSE0D6ovuAbXZTbbHv3rQ8vlEGHsZopVc/kbpGkqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qpu5zWTnkArGD7Ak7ac78BkaYIkvJMFK3iKhXCpi1uI=;
 b=ZhK9UJzlbgUZzOFSx5F5AcTlLGKR9rmaqmGoUHHAbVjfLR2tOk8dM+O1PftCkGMLry3APC8ZpoeCoznw6uf55s9ZmMzWu3X+LV7Zrehc6owcT6J3n0/gB8Zf5K503LrE+NNVL0xOEM6Yo/kxokQYDdYA9KhMjuNSCsODfKU66C4=
Received: from DM6PR10CA0028.namprd10.prod.outlook.com (2603:10b6:5:60::41) by
 MW2PR12MB2522.namprd12.prod.outlook.com (2603:10b6:907:f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.18; Fri, 11 Feb 2022 22:35:16 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::2e) by DM6PR10CA0028.outlook.office365.com
 (2603:10b6:5:60::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Fri, 11 Feb 2022 22:35:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 22:35:15 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 16:35:14 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 3/4] x86/mce, EDAC/mce_amd: Cache MCA_CONFIG[McaX] in struct mce_bank
Date:   Fri, 11 Feb 2022 16:34:41 -0600
Message-ID: <20220211223442.254489-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ba6cebb-057a-4019-162d-08d9edaec677
X-MS-TrafficTypeDiagnostic: MW2PR12MB2522:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB252209EC10485C259634675D90309@MW2PR12MB2522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 75uO81gqaP2sPau8HtsNczR47xCcR/h4Wf9/ItTOdN62t8ef0IULbseNmrOQq0yl+d4mkh9rI8m+4uvh+xV2Dsg5LCw8IwSwNc6+RgIYyKby64DD1ZFakcKlJhy1wGvUw/uaaM1D3PRRBBFIYO7xhmrFFLfvv04BTnvyuzg2TRIGacA3sTpL7hKeZsbFHjwcsOuhK6WZeg17UMQ7myHARrIpbAL+IswAg+adjlAzioVBD6jbUbarsKkCTqqXc4BPSb38KxOGX1oaayaScRjvm9fXQQ/vlyUPCjHCyn4acTBLmqvc54q8WcpMYsP0yk2XJBabdTvVWwDV5RLYflxHDBWkbrJCPzrmMjDSrcldoLk83+o7JIsRU6zbwmMjhYlH/47IW60mxrW8do23fvZRvJr743wYKq2JQxJ4y0loeaBmT1Emli5UWBah665fMYoIOV+HEO1GZ8CqR1K821eL6Ywa1zSt4eGicZ2LFImwEiMXocHYTVMX6jeE/fSx3+OscrasbcB2YFBn3KjZ6WpbZPvoPnt+4KuqpIlaHCYkNrRVRVhRZ13eeKlL/Mkq8HLl/hybYVkbGyslLa5+WXzgDSaMnhWpRdyKox7FJX/9L33z1VMBeYZFcjQquK+xYsTm4/xye1Rp/735sf++JaLwPzAS2vWiqpGA6i7ayX4EY42mf+z2tZnr6f4LFg8tBiy//pbizXi+ZJ7Ljl5U/sXAWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(86362001)(2616005)(7696005)(70206006)(36860700001)(356005)(110136005)(8676002)(36756003)(70586007)(5660300002)(4326008)(8936002)(40460700003)(1076003)(82310400004)(6666004)(81166007)(26005)(336012)(186003)(426003)(2906002)(508600001)(316002)(47076005)(54906003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 22:35:15.8327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ba6cebb-057a-4019-162d-08d9edaec677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2522
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Cache the value of MCA_CONFIG[McaX] in the existing mce_bank struct
similar to MCA_CONFIG[McaLsbInStatusSupported].

This simplifies and eliminates the need to read MCA_CONFIG register each
time to check McaX.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h         | 10 ++--------
 arch/x86/kernel/cpu/mce/amd.c      | 24 ++++++++++++++++++++----
 arch/x86/kernel/cpu/mce/internal.h | 13 ++++++++++++-
 arch/x86/kernel/cpu/mce/severity.c |  6 +-----
 drivers/edac/mce_amd.c             |  5 +----
 5 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc67c74e8b46..bb2d45b0bb89 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -50,14 +50,6 @@
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
 #define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub operation */
 
-/*
- * McaX field if set indicates a given bank supports MCA extensions:
- *  - Deferred error interrupt type is specifiable by bank.
- *  - MCx_MISC0[BlkPtr] field indicates presence of extended MISC registers,
- *    But should not be used to determine MSR numbers.
- *  - TCC bit is present in MCx_STATUS.
- */
-#define MCI_CONFIG_MCAX		0x1
 #define MCI_IPID_MCATYPE	0xFFFF0000
 #define MCI_IPID_HWID		0xFFF
 
@@ -339,6 +331,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 void smca_extract_err_addr(struct mce *m);
 void smca_feature_init(void);
+bool smca_config_get_mcax(struct mce *m);
 #else
 
 static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0; };
@@ -347,6 +340,7 @@ static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 static inline void smca_extract_err_addr(struct mce *m) { }
 static inline void smca_feature_init(void) { }
+static inline bool smca_config_get_mcax(struct mce *m) { return false; };
 #endif
 
 static inline void mce_hygon_feature_init(struct cpuinfo_x86 *c)	{ return mce_amd_feature_init(c); }
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index ed75d4bd2aff..4ec644611f33 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -257,10 +257,7 @@ static void smca_set_misc_banks_map(unsigned int bank, unsigned int cpu)
 	 * For SMCA enabled processors, BLKPTR field of the first MISC register
 	 * (MCx_MISC0) indicates presence of additional MISC regs set (MISC1-4).
 	 */
-	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_CONFIG(bank), &low, &high))
-		return;
-
-	if (!(low & MCI_CONFIG_MCAX))
+	if (!(this_cpu_ptr(mce_banks_array)[bank].mcax))
 		return;
 
 	if (rdmsr_safe(MSR_AMD64_SMCA_MCx_MISC(bank), &low, &high))
@@ -735,6 +732,24 @@ void smca_extract_err_addr(struct mce *m)
 	}
 }
 
+bool smca_config_get_mcax(struct mce *m)
+{
+	struct mce_bank *mce_banks;
+
+	/*
+	 * Check if the bank number is valid. It could be possible for the
+	 * user to input unavailable bank number when doing SW error injection
+	 * or to get an invalid bank number like with APEI memory handling.
+	 */
+	if (m->bank >= per_cpu(mce_num_banks, m->extcpu))
+		return false;
+
+	mce_banks = per_cpu_ptr(mce_banks_array, m->extcpu);
+
+	return mce_banks[m->bank].mcax;
+}
+EXPORT_SYMBOL_GPL(smca_config_get_mcax);
+
 void smca_feature_init(void)
 {
 	unsigned int bank;
@@ -743,6 +758,7 @@ void smca_feature_init(void)
 	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(bank), mca_cfg);
 		this_cpu_ptr(mce_banks_array)[bank].lsb_in_status = !!(mca_cfg & BIT(8));
+		this_cpu_ptr(mce_banks_array)[bank].mcax          = !!(mca_cfg & BIT(0));
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 39dc37052cb9..422387f8699d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -184,7 +184,18 @@ struct mce_bank {
 	 * the LSB field is found in MCA_STATUS, when set.
 	 */
 	__u64 lsb_in_status		: 1,
-	      __reserved_1		: 63;
+
+	/*
+	 * (AMD) MCA_CONFIG[McaX]: This bit when set indicates a given
+	 * bank supports MCA extensions:
+	 *  - Deferred error interrupt type is specifiable by bank.
+	 *  - MCx_MISC0[BlkPtr] field indicates presence of extended MISC registers,
+	 *    But should not be used to determine MSR numbers.
+	 *  - TCC bit is present in MCx_STATUS.
+	 */
+	      mcax			: 1,
+
+	      __reserved_1		: 62;
 };
 
 DECLARE_PER_CPU_READ_MOSTLY(struct mce_bank[MAX_NR_BANKS], mce_banks_array);
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 7aa2bda93cbb..95030a162f61 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -303,8 +303,6 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 
 static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 {
-	u64 mcx_cfg;
-
 	/*
 	 * We need to look at the following bits:
 	 * - "succor" bit (data poisoning support), and
@@ -314,10 +312,8 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
 	if (!mce_flags.succor)
 		return MCE_PANIC_SEVERITY;
 
-	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
-
 	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
-	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
+	if ((smca_config_get_mcax(m)) &&
 	    (m->status & MCI_STATUS_TCC) &&
 	    (err_ctx == IN_KERNEL))
 		return MCE_PANIC_SEVERITY;
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index cc5c63feb26a..415201ce35c7 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1254,11 +1254,8 @@ amd_decode_mce(struct notifier_block *nb, unsigned long val, void *data)
 		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
 
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
-		u32 low, high;
-		u32 addr = MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
 
-		if (!rdmsr_safe(addr, &low, &high) &&
-		    (low & MCI_CONFIG_MCAX))
+		if (smca_config_get_mcax(m))
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
 
 		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
-- 
2.17.1


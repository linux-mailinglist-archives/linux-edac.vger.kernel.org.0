Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881194D205B
	for <lists+linux-edac@lfdr.de>; Tue,  8 Mar 2022 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348659AbiCHSof (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 8 Mar 2022 13:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345544AbiCHSoc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 8 Mar 2022 13:44:32 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3F64706A;
        Tue,  8 Mar 2022 10:43:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv++3CHQzRoCgzv4qvamulLd6E9oo+VMIe9BzPMBFHDxSRcIeT3fh/t0Jxg1kYQUFwTsgaSwZ+X6TzxPjj74aEO0gka6tauTWVl3iTvEYHjMp3HWjDJCpy1v6WAlJBjEKOizaaejNrSeHq705j3FW5CefWDS4h+3UIusxes4NfVGaawUzIFPxCSlBt8RwyfyCgteR6QyScMh9N0ulsfpTrgnKZmdiFRMQviToOYrIC9lB+MBtCVMZS2HFd29NA2kje09TrUwAHBsYy1IhurtgkSLjn5rqV27ygOCvIIJ7iDFLQRyzaS9nSsUxbaQQkOXXQSET6XX3u0EI+NGt8XBBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wimDKDD/Z9El0xUjTnODbdMGwrtyQ9dRzobO+2H/LZ8=;
 b=ImR/chQp6iBTTNczZScs6S15xq7SIDD7bztJN4BG3QqPa7x3hs23gBGsaW3hVvdpArGiv06Tr7jqPPZ++/04P1DIOaHoAR5d+yQVUEEAp3CUqDhNY3QLDLnd661Fvd6xh+heNJghP3UYDsyUbONONp19trme45hDlGAd38WGn7FCjm5v4xU+FXtaYGTEcwbPYw+snT6L5NTW3np/F88ulfptgRJ4ta/ttHIh8YT1/py1wxWk7IeYgbMxjKglV/0yhuJaUimnL+7tjxNH/Hx//EPs9di7Mkwg/0dirqU5BA6d1sKdMz2VzyzunzZ9aGoju05H6sjybgP6rj/fTIIw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wimDKDD/Z9El0xUjTnODbdMGwrtyQ9dRzobO+2H/LZ8=;
 b=A9X7VvQ0TDoVhvOrUnabxyaHvCAXNT2wlF+eN1VkqY1GxeEX0d/1HnCGrw3VFC5y69+FYIZwYPvtw/RQhM0rWuYzR+mUzpgB3X6QrA/T0mhaKhJO+99hxbrN0Pvgfn2TncEOTBuXwPMb2+vrzKn4zapqcgvnL/w6E9HBXnKWIUE=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Tue, 8 Mar
 2022 18:43:32 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::d1) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 18:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 18:43:30 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Mar 2022 12:43:29 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] x86/mce: Unify vendors grading logic and provide AMD machine error checks
Date:   Tue, 8 Mar 2022 12:41:34 -0600
Message-ID: <20220308184133.712761-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70b3887e-f4de-464d-1264-08da01338ad8
X-MS-TrafficTypeDiagnostic: PH7PR12MB5902:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB59021E61F2F0CE5272793F61F8099@PH7PR12MB5902.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6itcW1Ss03uIVwR4tgPUIhE0W7gnKj9pabVqGLVGSsxEoPdYbqKgBVE+eP7fPiTN0bjoexRFhx5IqQGLxlLdDKqqLOK+yq82ksQIOrGppK3QPINrQoS0khRoKYVtphfaMKVvUCFusH7hcrsUyEC7LBA0IYxqBFzHZeoqxfQLUkEZoPEnrNl3skUSgKdCZuTq55Tqbi068palEhZWPRUiefToGbyll/tjqN6/dsKOGxtz7fRrmImRRkHBZZyf22giSxvjmP6SodUlucSJwTPX8XGe3/vzg4JboDC0JCv6AbM1wkEFEgng9Ad6JYdvantwiUG+hZEfblpAmtT2v53wIUD1TmXArrPgsmY5hxgBXk/yB2rKPLytw4zlaly/DJy7Y8fQMaUdDKDx8gzDM8WJm2f5rz9FYHEqrfsG7Y7zzTCk1TwoNDwJMbNidGoAhgxsRgM5LEmqPau09xvI45hm0bcn/cR2p/RFwqKmeguojsx/L1tc25rba9YGHKuGIOIiyfzf2nutx25NFjBhJWfvFl/6vqIGa7hU21c9sBrWKgluL+mfqj2Qrzl8zu3txdjd1H4HRLrf98Tfur2e8F1mtWdjeClUt4ylwbm/cUbZODvBcMImGp5jQC4XuBZfch9it6D+Yamdf0MErIeB5aapd1Y6OqcglbZoi2BFjezPbdfhQmv8jnGgvyGpv0BqSi+0vFaO+kHinpIvkBMGeJIRKA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(508600001)(54906003)(36756003)(7696005)(6916009)(316002)(6666004)(44832011)(30864003)(356005)(81166007)(2906002)(26005)(186003)(16526019)(47076005)(8676002)(4326008)(5660300002)(336012)(426003)(2616005)(1076003)(83380400001)(82310400004)(40460700003)(70586007)(70206006)(86362001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 18:43:30.8847
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70b3887e-f4de-464d-1264-08da01338ad8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5902
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD's severity grading covers very few machine errors. In the graded cases
there are no user-readable messages, complicating debugging of critical
hardware errors. Furthermore, with the current implementation AMD MCEs have
no support for the severities-coverage file. Adding new severities for AMD
with the current logic would be too convoluted.

Fix the above issues including AMD severities to the severity table, in
combination with Intel MCEs. Unify the severity grading logic of both
vendors. Label the vendor-specific cases (e.g. cases with different
registers) where checks cannot be implicit with the available features.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/include/asm/mce.h         |   7 ++
 arch/x86/kernel/cpu/mce/severity.c | 188 +++++++++++++++--------------
 2 files changed, 103 insertions(+), 92 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..d83adc2da522 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -50,6 +50,13 @@
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
 #define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub operation */
 
+/* AMD error codes from PPR(s) section 3.1 Machine Check Architecture */
+#define ERRORCODE_T_MSK GENMASK(3, 2)  /* Mask for transaction type bits */
+#define ERRORCODE_T_DATA 0x4  /* Transaction type of error is Data */
+
+#define ERRORCODE_M_MSK GENMASK(7, 4)  /* Mask for memory transaction type */
+#define ERRORCODE_M_FETCH  0x50  /* Memory transaction type of error is Instruction Fetch */
+
 /*
  * McaX field if set indicates a given bank supports MCA extensions:
  *  - Deferred error interrupt type is specifiable by bank.
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1add86935349..b0fd3feb1b74 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -34,6 +34,7 @@
 enum context { IN_KERNEL = 1, IN_USER = 2, IN_KERNEL_RECOV = 3 };
 enum ser { SER_REQUIRED = 1, NO_SER = 2 };
 enum exception { EXCP_CONTEXT = 1, NO_EXCP = 2 };
+enum vendor { INTEL_VENDOR = 1, AMD_VENDOR = 2 };
 
 static struct severity {
 	u64 mask;
@@ -48,6 +49,9 @@ static struct severity {
 	unsigned char cpu_model;
 	unsigned char cpu_minstepping;
 	unsigned char bank_lo, bank_hi;
+	unsigned char vendor;
+	unsigned char succor;
+	unsigned char overflow_recov;
 	char *msg;
 } severities[] = {
 #define MCESEV(s, m, c...) { .sev = MCE_ ## s ## _SEVERITY, .msg = m, ## c }
@@ -60,6 +64,9 @@ static struct severity {
 #define  NOSER		.ser = NO_SER
 #define  EXCP		.excp = EXCP_CONTEXT
 #define  NOEXCP		.excp = NO_EXCP
+#define  AMD_MCE	.vendor = AMD_VENDOR
+#define  SUCCOR		.succor = 1
+#define  OVERF_RECOV	.overflow_recov = 1
 #define  BITCLR(x)	.mask = x, .result = 0
 #define  BITSET(x)	.mask = x, .result = x
 #define  MCGMASK(x, y)	.mcgmask = x, .mcgres = y
@@ -77,6 +84,14 @@ static struct severity {
 		NO, "Not enabled",
 		EXCP, BITCLR(MCI_STATUS_EN)
 		),
+	MCESEV(
+		AR, "Action required: Error detected on a scrub operation",
+		BITSET(MCI_STATUS_SCRUB | MCI_STATUS_DEFERRED), AMD_MCE
+		),
+	MCESEV(
+		DEFERRED, "Deferred",
+		BITSET(MCI_STATUS_DEFERRED), AMD_MCE
+		),
 	MCESEV(
 		PANIC, "Processor context corrupt",
 		BITSET(MCI_STATUS_PCC)
@@ -103,6 +118,35 @@ static struct severity {
 		KEEP, "Corrected error",
 		NOSER, BITCLR(MCI_STATUS_UC)
 		),
+	MCESEV(
+		AR, "Action required: Attempt to consume poisoned data from user process",
+		BITSET(MCI_STATUS_POISON), AMD_MCE, USER
+		),
+	MCESEV(
+		PANIC,
+		"Attempt to consume poisoned memory in kernel context",
+		MASK(MCI_STATUS_POISON | MCI_STATUS_TCC, MCI_STATUS_POISON),
+		AMD_MCE, KERNEL
+		),
+
+#ifdef	CONFIG_MEMORY_FAILURE
+	MCESEV(
+		AR,
+		"Action required: Attempt to consume poisoned memory in recoverable kernel area",
+		MASK(MCI_STATUS_POISON | MCI_STATUS_TCC, MCI_STATUS_POISON),
+		AMD_MCE, KERNEL_RECOV, SUCCOR
+		),
+#endif
+	MCESEV(
+		PANIC,
+		"Attempt to consume poisoned memory in recoverable kernel area",
+		MASK(MCI_STATUS_POISON | MCI_STATUS_TCC, MCI_STATUS_POISON),
+		AMD_MCE, KERNEL_RECOV
+		),
+	MCESEV(
+		PANIC, "Uncorrectable error in kernel context",
+		KERNEL, BITSET(MCI_STATUS_UC), AMD_MCE
+		),
 	/*
 	 * known AO MCACODs reported via MCE or CMC:
 	 *
@@ -163,16 +207,31 @@ static struct severity {
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		KERNEL_RECOV
 		),
+	MCESEV(
+		AR, "Action required: data load in error recoverable area of kernel",
+		MASK(MCI_STATUS_UC | ERRORCODE_T_MSK, MCI_STATUS_UC | ERRORCODE_T_DATA),
+		KERNEL_RECOV, AMD_MCE, SUCCOR
+		),
 	MCESEV(
 		AR, "Action required: data load error in a user process",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
 		USER
 		),
+	MCESEV(
+		AR, "Action required: data load error in a user process",
+		MASK(MCI_STATUS_UC | ERRORCODE_T_MSK, MCI_STATUS_UC | ERRORCODE_T_DATA),
+		USER, AMD_MCE
+		),
 	MCESEV(
 		AR, "Action required: instruction fetch error in a user process",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_INSTR),
 		USER
 		),
+	MCESEV(
+		AR, "Action required: instruction fetch in a user process",
+		MASK(MCI_STATUS_UC | ERRORCODE_M_MSK, MCI_STATUS_UC | ERRORCODE_M_FETCH),
+		USER, AMD_MCE
+		),
 	MCESEV(
 		PANIC, "Data load in unrecoverable area of kernel",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR|MCI_ADDR|MCACOD, MCI_UC_SAR|MCI_ADDR|MCACOD_DATA),
@@ -184,6 +243,21 @@ static struct severity {
 		KERNEL
 		),
 #endif
+	MCESEV(
+		PANIC, "Instruction fetch error in kernel",
+		MASK(MCI_STATUS_UC | ERRORCODE_M_MSK, MCI_STATUS_UC | ERRORCODE_M_FETCH),
+		KERNEL, AMD_MCE
+		),
+	MCESEV(
+		PANIC, "Data load in urecoverable area of kernel",
+		MASK(MCI_STATUS_UC | ERRORCODE_T_MSK, MCI_STATUS_UC | ERRORCODE_T_DATA),
+		KERNEL, AMD_MCE
+		),
+	MCESEV(
+		PANIC, "Uncorrectable error: Data load in error recoverable area of kernel",
+		MASK(MCI_STATUS_UC | ERRORCODE_T_MSK, MCI_STATUS_UC | ERRORCODE_T_DATA),
+		KERNEL_RECOV, AMD_MCE
+		),
 	MCESEV(
 		PANIC, "Action required: unknown MCACOD",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR, MCI_UC_SAR)
@@ -197,7 +271,16 @@ static struct severity {
 		SOME, "Action optional with lost events",
 		SER, MASK(MCI_STATUS_OVER|MCI_UC_SAR, MCI_STATUS_OVER|MCI_UC_S)
 		),
-
+	/*
+	 * On newer AMD systems where overflow_recov is present, we should
+	 * not panic right away when an error overflow occurs. Instead, we
+	 * can try to at least kill the process to prolong system operation.
+	 */
+	MCESEV(
+		AR, "Uncorrected Recoverable Error",
+		BITSET(MCI_STATUS_OVER|MCI_STATUS_UC),
+		SUCCOR, OVERF_RECOV
+		),
 	MCESEV(
 		PANIC, "Overflowed uncorrected",
 		BITSET(MCI_STATUS_OVER|MCI_STATUS_UC)
@@ -301,94 +384,24 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 	}
 }
 
-static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
-{
-	u64 mcx_cfg;
-
-	/*
-	 * We need to look at the following bits:
-	 * - "succor" bit (data poisoning support), and
-	 * - TCC bit (Task Context Corrupt)
-	 * in MCi_STATUS to determine error severity.
-	 */
-	if (!mce_flags.succor)
-		return MCE_PANIC_SEVERITY;
-
-	mcx_cfg = mce_rdmsrl(MSR_AMD64_SMCA_MCx_CONFIG(m->bank));
-
-	/* TCC (Task context corrupt). If set and if IN_KERNEL, panic. */
-	if ((mcx_cfg & MCI_CONFIG_MCAX) &&
-	    (m->status & MCI_STATUS_TCC) &&
-	    (err_ctx == IN_KERNEL))
-		return MCE_PANIC_SEVERITY;
-
-	 /* ...otherwise invoke hwpoison handler. */
-	return MCE_AR_SEVERITY;
-}
-
-/*
- * See AMD Error Scope Hierarchy table in a newer BKDG. For example
- * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
- */
-static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
-{
-	enum context ctx = error_context(m, regs);
-
-	/* Processor Context Corrupt, no need to fumble too much, die! */
-	if (m->status & MCI_STATUS_PCC)
-		return MCE_PANIC_SEVERITY;
-
-	if (m->status & MCI_STATUS_UC) {
-
-		if (ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
-
-		/*
-		 * On older systems where overflow_recov flag is not present, we
-		 * should simply panic if an error overflow occurs. If
-		 * overflow_recov flag is present and set, then software can try
-		 * to at least kill process to prolong system operation.
-		 */
-		if (mce_flags.overflow_recov) {
-			if (mce_flags.smca)
-				return mce_severity_amd_smca(m, ctx);
-
-			/* kill current process */
-			return MCE_AR_SEVERITY;
-		} else {
-			/* at least one error was not logged */
-			if (m->status & MCI_STATUS_OVER)
-				return MCE_PANIC_SEVERITY;
-		}
-
-		/*
-		 * For any other case, return MCE_UC_SEVERITY so that we log the
-		 * error and exit #MC handler.
-		 */
-		return MCE_UC_SEVERITY;
-	}
-
-	/*
-	 * deferred error: poll handler catches these and adds to mce_ring so
-	 * memory-failure can take recovery actions.
-	 */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return MCE_DEFERRED_SEVERITY;
-
-	/*
-	 * corrected error: poll handler catches these and passes responsibility
-	 * of decoding the error to EDAC
-	 */
-	return MCE_KEEP_SEVERITY;
-}
-
-static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
+int noinstr mce_severity(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
 	enum context ctx = error_context(m, regs);
+	enum vendor cpu_vendor = INTEL_VENDOR;
 	struct severity *s;
 
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		cpu_vendor = AMD_VENDOR;
+
 	for (s = severities;; s++) {
+		if (s->vendor && s->vendor != cpu_vendor)
+			continue;
+		if (s->succor && !mce_flags.succor)
+			continue;
+		if (s->overflow_recov && !mce_flags.overflow_recov)
+			continue;
 		if ((m->status & s->mask) != s->result)
 			continue;
 		if ((m->mcgstatus & s->mcgmask) != s->mcgres)
@@ -418,15 +431,6 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char
 	}
 }
 
-int noinstr mce_severity(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
-{
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return mce_severity_amd(m, regs, msg, is_excp);
-	else
-		return mce_severity_intel(m, regs, msg, is_excp);
-}
-
 #ifdef CONFIG_DEBUG_FS
 static void *s_start(struct seq_file *f, loff_t *pos)
 {

base-commit: 7f1b8e0d6360178e3527d4f14e6921c254a86035
-- 
2.27.0


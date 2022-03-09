Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A894D3701
	for <lists+linux-edac@lfdr.de>; Wed,  9 Mar 2022 18:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbiCIRm0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 9 Mar 2022 12:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiCIRmZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 9 Mar 2022 12:42:25 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4085710E05F;
        Wed,  9 Mar 2022 09:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtAYKsOKd4RpTYVTd/5cTzJ8Rs2Uc6M/91d+hTPDJXv/pFaelS7AamlBZ0oNISDSiHhrHAb6taKTKPjXA6poeutJm3Jc8gdZYKeOMKD3NxZyB7s5lyke3NI4TL+Af1rLuDBqOrlB3uguBXMJKjqXVPDBM8J966hPT14fXds3FlaD9uWnGS7rcCeQ96Svs3hzOI0ZujSeJcMQvNkiER+9d/0xzerpH2N3pYxa5quq1mhY9nKZXXQWZXi0th7zn5lDYgVYgUSne/mFxspUxMvCoEUebDTzmQoYOJ6UeQK7qcFcUlqdgs0aCXCKgsgHgffOKXBmblGqUw1cj03J7o5Xrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCV9iZfMU0Umm/A0C9lE5BNEFZUXnPTwJPhrq++V8n4=;
 b=Q98+oD8p3gWI2epW3iuDDCXBWjVJ9iqRJoDikWCd0Ps7f6UGb3Aof+OF0e/rpA64QFoCpkWrFE5GUiJJ/99LpleUtce4dew7TikG5WkGHfsanFroyY2f8uw60WEbwTGno+Sq/ZYAE5S6VyUCACsQI/77AoKAh0n7TSUEQDKxKBQTVuChPmA7lzsv+8eWWBLdWv/mPCEf3mKuZ3s52SdYOynpZQLYsrDJgztbQaoq6HI0HErg4LfBfFdf6CELzitWo8Bt9/FwmoqPajkMZ5u4PnGe1VGxJyicCHo/lxCPU94CShLZjmuku4AxQ71O07S/7Rr1wzK/hIIZj25/SA/orQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCV9iZfMU0Umm/A0C9lE5BNEFZUXnPTwJPhrq++V8n4=;
 b=kamb3Iw5D0A6k9WX/Nj/TWy8yNqzJLh+m+Uy9fnO54nMp83s6Yd8MdGIoeFuYA+oN6IugKlFFsVr/tTkVXQu67rrRrUmPVTU0b+EpGb5CC41r4lGVfjc4vKJDEI/mLHphswOEHTQbEHqpVROFvTM7+/YLLjcITb9gFnWyYfsf58=
Received: from MW4PR04CA0148.namprd04.prod.outlook.com (2603:10b6:303:84::33)
 by BN6PR1201MB0081.namprd12.prod.outlook.com (2603:10b6:405:4f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 17:41:22 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::f6) by MW4PR04CA0148.outlook.office365.com
 (2603:10b6:303:84::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16 via Frontend
 Transport; Wed, 9 Mar 2022 17:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 17:41:21 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 9 Mar 2022 11:41:19 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] x86/mce: Cover grading of AMD machine error checks
Date:   Wed, 9 Mar 2022 11:41:07 -0600
Message-ID: <20220309174107.6113-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b664bd2c-8453-4236-e850-08da01f40612
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0081:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0081FA150082573B73E59A55F80A9@BN6PR1201MB0081.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxtLQbxqA04ZF/3Odhfw4Au4GjxO5MBa25vnl2aQMeURJbVtm/e8HtIJcO+9dZk+LIFX6Zuw1ghT5J/OIa75OROfyZrQNA2QficK7jAcS+fhw8qd7TKiGpgE/ubR28da5w2K6E01delgMiYaQB1NAkPnLkXfPvpZR4wQfpLRyxQH5IWaAlaNTRjoR3AJp6B+O0YNQVXzongczZcJ5j/60hGButO1N9smT9GuoU8bDc/wpJfC5mJ1PO5twW8CYlhJLr6s1uLpAUmF16ivWdy6UhptQu4SfhqNfMEe0bfToDazrJsPl98anrzy3Pv6iL36EiIE6Kid8B4PY81+hU4oUrDF5n2z8gn5onj43Ssfwlor1y1RFd0lAMJaBqi2DNe351P/lAw8Ufy3w1yGf6lKSwGNS9UeJAOiJbZ3KI0i2k/1uEJOLb8NOdUt5Ao2FZ3xkgP4rG7Pxg4eWo9NoBHPbJRrybCoDFnbsA1aBfzhpoLJRi6KjgSth///7fJY8ncKLcVLfRxl481zxwyf0NKlhRZrJLw/Ss8ecF/wpfoE9CVs0k2Hn1sTVkPftjqD5hILD6TObvMNIvHLlDnZvXHS0nZyI44sMveLbghzGacMwAvRQiQ8F/FfWPmMOyIE/OsmiBwpFwafkG3SbOaTmrVzYP9B7mas22nZ4AvFZeBA1Ii/pT8y04HSsRFRZ8qNUB8e3cmJSqFqTdOeftuQaJUULw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(316002)(426003)(54906003)(336012)(6916009)(4326008)(70586007)(8676002)(82310400004)(70206006)(508600001)(83380400001)(86362001)(40460700003)(5660300002)(26005)(186003)(6666004)(2906002)(8936002)(16526019)(7696005)(36860700001)(36756003)(44832011)(47076005)(1076003)(356005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 17:41:21.0022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b664bd2c-8453-4236-e850-08da01f40612
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0081
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
hardware errors.

Fix the above issues extending the current grading logic for AMD with cases
not previously considered and their corresponding messages.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/include/asm/mce.h         |   6 +
 arch/x86/kernel/cpu/mce/severity.c | 232 +++++++++++++++++++++++++----
 2 files changed, 205 insertions(+), 33 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index cc73061e7255..6b1ef40f8580 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -50,6 +50,12 @@
 #define MCI_STATUS_POISON	BIT_ULL(43)  /* access poisonous data */
 #define MCI_STATUS_SCRUB	BIT_ULL(40)  /* Error detected during scrub operation */
 
+/* AMD Error codes from PPR(s) section 3.1 Machine Check Architecture */
+#define ERRORCODE_T_MSK GENMASK(3, 2) /* Mask for transaction type bits */
+#define ERRORCODE_M_MSK GENMASK(7, 4) /* Mask for memory transaction type */
+#define ERRORCODE_T_DATA  0x4  /* Transaction type of error is Data */
+#define ERRORCODE_M_FETCH 0x50 /* Memory transaction type of error is Instruction Fetch */
+
 /*
  * McaX field if set indicates a given bank supports MCA extensions:
  *  - Deferred error interrupt type is specifiable by bank.
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1add86935349..764c6caf4bfe 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -327,59 +327,225 @@ static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err
 }
 
 /*
- * See AMD Error Scope Hierarchy table in a newer BKDG. For example
- * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
+ * Evaluate the severity of a data load error for AMD systems, depending
+ * on the context in which the MCE happened.
  */
-static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
+static inline int mce_grade_data_amd(enum context ctx, char **severity_msg)
 {
-	enum context ctx = error_context(m, regs);
+	WARN_ON(!severity_msg);
+
+	switch (ctx) {
+	case IN_USER:
+		*severity_msg = "Action required: data load error in user process";
+		return MCE_AR_SEVERITY;
+	case IN_KERNEL_RECOV:
+		*severity_msg = "Action required: data load in kernel recoverable area";
+		return MCE_AR_SEVERITY;
+	case IN_KERNEL:
+		*severity_msg = "Data load in unrecoverable area of kernel";
+		return MCE_PANIC_SEVERITY;
+	default:
+		*severity_msg = "Data load in unknown context";
+		return MCE_PANIC_SEVERITY;
+	}
+}
 
-	/* Processor Context Corrupt, no need to fumble too much, die! */
-	if (m->status & MCI_STATUS_PCC)
+/*
+ * Evaluate the severity of an instruction fetch error for AMD systems,
+ * depending on the context in which the MCE happened.
+ */
+static inline int mce_grade_fetch_amd(enum context ctx, char **severity_msg)
+{
+	WARN_ON(!severity_msg);
+
+	switch (ctx) {
+	case IN_USER:
+		*severity_msg = "Action required: instruction fetch in user process";
+		return MCE_AR_SEVERITY;
+	case IN_KERNEL_RECOV:
+		*severity_msg = "Instruction fetch in kernel recoverable area";
+#ifdef CONFIG_MEMORY_FAILURE
+		return MCE_AR_SEVERITY;
+#else /* !MCE_PANIC_SEVERITY */
 		return MCE_PANIC_SEVERITY;
+#endif
+	case IN_KERNEL:
+		*severity_msg = "Instruction fetch error in kernel";
+		return MCE_PANIC_SEVERITY;
+	default:
+		*severity_msg = "Instruction fetch error in unknown context";
+		return MCE_PANIC_SEVERITY;
+	}
+}
 
-	if (m->status & MCI_STATUS_UC) {
+/*
+ * Evaluate the severity of a memory poison error for AMD systems,
+ * depending on the context in which the MCE happened.
+ */
+static inline int mce_grade_poison_amd(enum context ctx, char **severity_msg)
+{
 
-		if (ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
+	WARN_ON(!severity_msg);
+
+	switch (ctx) {
+	case IN_USER:
+		*severity_msg = "Attempt to consume poisoned data in user process";
+		return MCE_AR_SEVERITY;
+	case IN_KERNEL_RECOV:
+		*severity_msg = "Attempt to consume poisoned memory in kernel recoverable area";
+#ifdef CONFIG_MEMORY_FAILURE
+		return MCE_AR_SEVERITY;
+#else /* !CONFIG_MEMORY_FAILURE */
+		return MCE_PANIC_SEVERITY;
+#endif
+	case IN_KERNEL:
+		*severity_msg = "Attempt to consume poisoned data in kernel context";
+		return MCE_PANIC_SEVERITY;
+	default:
+		*severity_msg = "Poisoned data consumption in unknown context";
+		return MCE_PANIC_SEVERITY;
+	}
+}
+
+/*
+ * Evaluate the severity of deferred errors for AMD systems, for which only
+ * scrub error is interesting to notify an action requirement.
+ */
+static noinstr int mce_grade_deferred_amd(struct mce *m, enum context ctx, char **msg)
+{
+	int ret;
+
+	WARN_ON(!msg);
 
+	if (m->status & MCI_STATUS_SCRUB) {
+		ret = MCE_AR_SEVERITY;
+		*msg = "Action required: Error detected on a scrub operation";
+	} else {
 		/*
-		 * On older systems where overflow_recov flag is not present, we
-		 * should simply panic if an error overflow occurs. If
-		 * overflow_recov flag is present and set, then software can try
-		 * to at least kill process to prolong system operation.
+		 * deferred error: poll handler catches these and adds to mce_ring so
+		 * memory-failure can take recovery actions.
 		 */
-		if (mce_flags.overflow_recov) {
-			if (mce_flags.smca)
-				return mce_severity_amd_smca(m, ctx);
+		ret = MCE_DEFERRED_SEVERITY;
+		*msg = "Deferred";
+	}
 
-			/* kill current process */
-			return MCE_AR_SEVERITY;
+	return ret;
+}
+
+/*
+ * Evaluate the severity of an overflow error for AMD systems, dependent on
+ * the recoverable features available.
+ */
+static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx, char **msg)
+{
+	int ret;
+
+	WARN_ON(!msg);
+
+	if (ctx == IN_KERNEL) {
+		*msg = "Uncorrectable error in kernel context";
+		return MCE_PANIC_SEVERITY;
+	}
+
+	/*
+	 * On older systems where overflow_recov flag is not present, we
+	 * should simply panic if an error overflow occurs. If
+	 * overflow_recov flag is present and set, then software can try
+	 * to at least kill process to prolong system operation.
+	 */
+	if (mce_flags.overflow_recov) {
+		*msg = "Uncorrected recoverable error";
+		if (mce_flags.smca) {
+			ret = mce_severity_amd_smca(m, ctx);
+			if (ret == MCE_PANIC_SEVERITY)
+				*msg = "Uncorrected unrecoverable error";
 		} else {
-			/* at least one error was not logged */
-			if (m->status & MCI_STATUS_OVER)
-				return MCE_PANIC_SEVERITY;
+			/* kill current process */
+			ret = MCE_AR_SEVERITY;
 		}
+		return ret;
+	}
 
-		/*
-		 * For any other case, return MCE_UC_SEVERITY so that we log the
-		 * error and exit #MC handler.
-		 */
-		return MCE_UC_SEVERITY;
+	/* at least one error was not logged */
+	if (m->status & MCI_STATUS_OVER) {
+		*msg = "Overflow uncorrected";
+		return MCE_PANIC_SEVERITY;
 	}
 
 	/*
-	 * deferred error: poll handler catches these and adds to mce_ring so
-	 * memory-failure can take recovery actions.
+	 * For any other case, return MCE_UC_SEVERITY so that we log the
+	 * error and exit #MC handler.
 	 */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return MCE_DEFERRED_SEVERITY;
+	*msg = "Uncorrected overflow error";
+	return MCE_UC_SEVERITY;
+}
+
+/*
+ * See AMD PPR(s) section 3.1 Machine Check Architecture
+ */
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
+{
+	enum context ctx = error_context(m, regs);
+	char *severity_msg;
+	int ret;
 
 	/*
-	 * corrected error: poll handler catches these and passes responsibility
-	 * of decoding the error to EDAC
+	 * Default return values. The poll handler catches these and passes
+	 * responsibility of decoding them to EDAC
 	 */
-	return MCE_KEEP_SEVERITY;
+	ret = MCE_KEEP_SEVERITY;
+	severity_msg = "Corrected error";
+
+	if (m->status & MCI_STATUS_DEFERRED) {
+		ret = mce_grade_deferred_amd(m, ctx, &severity_msg);
+		goto amd_severity;
+	}
+
+	/* If the UC bit is not set, the error has been corrected */
+	if (!(m->status & MCI_STATUS_UC)) {
+		ret = MCE_KEEP_SEVERITY;
+		severity_msg = "Corrected error";
+		goto amd_severity;
+	}
+
+	if (m->status & MCI_STATUS_POISON) {
+		ret = mce_grade_poison_amd(ctx, &severity_msg);
+		goto amd_severity;
+	}
+
+	/* Processor Context Corrupt, no need to fumble too much, die! */
+	if (m->status & MCI_STATUS_PCC) {
+		severity_msg = "Processor Context Corrupt";
+		ret = MCE_PANIC_SEVERITY;
+		goto amd_severity;
+	}
+
+	if ((m->status & ERRORCODE_T_MSK) == ERRORCODE_T_DATA) {
+		ret = mce_grade_data_amd(ctx, &severity_msg);
+		goto amd_severity;
+	}
+
+	if ((m->status & ERRORCODE_M_MSK) == ERRORCODE_M_FETCH) {
+		ret = mce_grade_fetch_amd(ctx, &severity_msg);
+		goto amd_severity;
+	}
+
+	if (m->status & MCI_STATUS_OVER) {
+		ret = mce_grade_overflow_amd(m, ctx, &severity_msg);
+		goto amd_severity;
+	}
+
+	if (ctx == IN_KERNEL) {
+		ret = MCE_PANIC_SEVERITY;
+		severity_msg = "Uncorrectable error in kernel context";
+	}
+
+amd_severity:
+
+	if (msg)
+		*msg = severity_msg;
+
+	return ret;
 }
 
 static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)

base-commit: 7f1b8e0d6360178e3527d4f14e6921c254a86035
-- 
2.27.0


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CDD4D66D7
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 17:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiCKQxr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 11:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245020AbiCKQxq (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 11:53:46 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1939C15A25;
        Fri, 11 Mar 2022 08:52:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij05ENpznerHlsn/iP5bbHhrBaTHrW4F5HVRSUgeWXNs1QpIEEV8Yo0c2adUin2HmadcKYM6qkCtXByE3Bp5Q6rJAF7vJelq/k9PZF7ggvit9AGtNny7xDItvtTftvE6Fx/WU/7ZbtIWkHFjEnyxj1+E//z+T+Eh7EcWU7PZFlPvQ3TEETt6IjnCrr5sOltLsU//qPAXbaE9aN5yxq6SZuE3wZjW4/NqNX/iJdjUM5lRH+eGWk7Rz/6NR2NlSSHNm4m2dbfRvLmm+kTxVbNvscHAfEcaevXg26t7vTMxPnmNH+WvSrNmfvY+oEL/E1BCSaaEVFuSKpm2D7y3QrmDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wj/9UZ0IFoTWkEBmg5jHbrIW411uRXM2Th1XQvbQXVc=;
 b=e8KiVwolkWzHT2DXHadm08ihctuqhPd4RCCharboqd4OF7JOYTMB8aC1qtX/aYaw8+SP5C2durTu9KgkB7MWdVpRdXGM8x/UfPkdf9mlomPTNFIijTCuooDnQr/Kdwhj9kzvBCaDEqVPlWpdbDX3s790dKg/SRuPAFRdNsFLUsdL2vPagTv5q47g5rUTJmqbIDAPj794JYzvthgSeW2PCle4rpOaYNvDTLM6P0tC4WSckFYnIFhibARF+UitbFfNy8BoU89uAoug5nropIQBJ7d6kZ6gJTcnMoc2U7aEGrrIeswi6HBDZHxmhC778A3gEA4hLkJ8oM7tEkOJtSPOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wj/9UZ0IFoTWkEBmg5jHbrIW411uRXM2Th1XQvbQXVc=;
 b=xXVI/vGom05xWFVWBIcU5RiwSNYb1CHFC9sboEvcCLppyvbvQLQkHWbTxrWWhdGFficx/w7Wl8Ow4P769qwTkmr8NTmfcEquNMHOUFNkarHJ2d/fZssVevETiO0/kiBw7tmqvk6UXURa2ORM7aJhIrboQFeyVbQI9DV3smwCzw4=
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 BL0PR12MB5505.namprd12.prod.outlook.com (2603:10b6:208:1ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22; Fri, 11 Mar 2022 16:52:39 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::6a) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Fri, 11 Mar 2022 16:52:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 16:52:38 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 11 Mar 2022 10:52:37 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 1/2] x86/mce: Extend AMD severity grading function with new types of errors
Date:   Fri, 11 Mar 2022 10:51:15 -0600
Message-ID: <20220311165114.482074-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220311165114.482074-1-carlos.bilbao@amd.com>
References: <20220311165114.482074-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0d2ec6b-5125-4795-898d-08da037f8cb5
X-MS-TrafficTypeDiagnostic: BL0PR12MB5505:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5505D2FADC0EAC497299282FF80C9@BL0PR12MB5505.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajwKqy5l57LF/6b3XIn0lWJlxv84gVWzczeHyep0BI1zSvNwfOvl40lnsDiNWxnFvYJbbrhmYiKTpLvaAXyaKrvAdUxaXiO8RVzhvNUpsNCRfATgjbTHqMDsjq0XY8cupKnIJ6cVGGjDEPkmvB1Cf4L5U2E3oU0362axMuP71B6oXjD2obnwuSvU0JesFjf17/h/aSiPT5ybKBLJuf6zA/BmqUReqBOvt4Eqq1vwSb2PPekZwfChDpw0VrFFzJ8jUXDBkgGf7UyMyC8+aZRYp9kzwA7gunOulPwaD7/uGexywLbTAMi84kkkvtGOfAFDTDl+y1zAkDGeDRwyaMH2qQA5gxQlbqp5XHtlGgOKXpayLET6JjUinmeHhSZsT5PbvSMZPBDAkw7V/8r7NLqlGRV1gl/iG+Md+bI/nN957YxAnddJlu3q951ZLFb2Xzvw1Hhb+Z8FvWNaCKOTx+zpWBhUmWnqki+gU672VDcfHcI2VPVFa6GlD044KNdp1YBC1bTpUtBVI937KGBudPrzuqhV05fn3DBZm58BM7rOnrT8mN3Bn0nLm1q5/Jn9UGsSmP8qB/34VttBcWDeof2poOqZwI0U7vkveARXuydYqlv2XlhpZDkLGPl19Fq4AWMXPpVd9Lx4LLSZx3S4Zpq0oh2x8ZmrHVF9KbeaE8HOOGAkps3pUwH0I+qqkH73mMcOGT8JK/nH3882G0XVmh+l9g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(186003)(26005)(8936002)(7696005)(40460700003)(316002)(4326008)(1076003)(83380400001)(336012)(426003)(8676002)(36756003)(70586007)(508600001)(70206006)(356005)(6666004)(82310400004)(2616005)(5660300002)(6916009)(54906003)(47076005)(81166007)(86362001)(44832011)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:52:38.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d2ec6b-5125-4795-898d-08da037f8cb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The MCE handler needs to understand the severity of the machine errors to
act accordingly. In the case of AMD, very few errors are covered in the
grading logic.

Extend the MCEs severity grading of AMD to cover new types of machine
errors.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/include/asm/mce.h         |   6 +
 arch/x86/kernel/cpu/mce/severity.c | 180 +++++++++++++++++++++++------
 2 files changed, 150 insertions(+), 36 deletions(-)

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
index 1add86935349..4a089e9dbbaf 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -327,59 +327,167 @@ static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err
 }
 
 /*
- * See AMD Error Scope Hierarchy table in a newer BKDG. For example
- * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
+ * Evaluate the severity of an overflow error for AMD systems, dependent on
+ * the recoverable features available.
  */
-static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
+static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
 {
-	enum context ctx = error_context(m, regs);
+	int ret;
 
-	/* Processor Context Corrupt, no need to fumble too much, die! */
-	if (m->status & MCI_STATUS_PCC)
+	/*
+	 * On older systems where overflow_recov flag is not present, we
+	 * should simply panic if an error overflow occurs. If
+	 * overflow_recov flag is present and set, then software can try
+	 * to at least kill process to prolong system operation.
+	 */
+	if (mce_flags.overflow_recov) {
+		if (mce_flags.smca) {
+			ret = mce_severity_amd_smca(m, ctx);
+		} else {
+			/* kill current process */
+			ret = MCE_AR_SEVERITY;
+		}
+		return ret;
+	}
+
+	/* at least one error was not logged */
+	if (m->status & MCI_STATUS_OVER)
 		return MCE_PANIC_SEVERITY;
 
-	if (m->status & MCI_STATUS_UC) {
+	/*
+	 * For any other case, return MCE_UC_SEVERITY so that we log the
+	 * error and exit #MC handler.
+	 */
+	return MCE_UC_SEVERITY;
+}
 
-		if (ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
+/*
+ * See AMD PPR(s) section 3.1 Machine Check Architecture
+ */
+static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
+{
+	enum context ctx = error_context(m, regs);
+	int ret;
 
-		/*
-		 * On older systems where overflow_recov flag is not present, we
-		 * should simply panic if an error overflow occurs. If
-		 * overflow_recov flag is present and set, then software can try
-		 * to at least kill process to prolong system operation.
-		 */
-		if (mce_flags.overflow_recov) {
-			if (mce_flags.smca)
-				return mce_severity_amd_smca(m, ctx);
+	/*
+	 * Default return values. The poll handler catches these and passes
+	 * responsibility of decoding them to EDAC
+	 */
+	ret = MCE_KEEP_SEVERITY;
 
-			/* kill current process */
-			return MCE_AR_SEVERITY;
-		} else {
-			/* at least one error was not logged */
-			if (m->status & MCI_STATUS_OVER)
-				return MCE_PANIC_SEVERITY;
+	/*
+	 * Evaluate the severity of deferred errors for AMD systems, for which only
+	 * scrub error is interesting to notify an action requirement.
+	 */
+	if (m->status & MCI_STATUS_DEFERRED) {
+		if (m->status & MCI_STATUS_SCRUB)
+			ret = MCE_AR_SEVERITY;
+		else {
+			/*
+			 * deferred error: poll handler catches these and adds to mce_ring so
+			 * memory-failure can take recovery actions.
+			 */
+			ret = MCE_DEFERRED_SEVERITY;
 		}
+		goto amd_severity;
+	}
 
-		/*
-		 * For any other case, return MCE_UC_SEVERITY so that we log the
-		 * error and exit #MC handler.
-		 */
-		return MCE_UC_SEVERITY;
+	/* If the UC bit is not set, the error has been corrected */
+	if (!(m->status & MCI_STATUS_UC)) {
+		ret = MCE_KEEP_SEVERITY;
+		goto amd_severity;
 	}
 
 	/*
-	 * deferred error: poll handler catches these and adds to mce_ring so
-	 * memory-failure can take recovery actions.
+	 * Evaluate the severity of memory poison for AMD systems,
+	 * depending on the context in which the MCE happened.
 	 */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return MCE_DEFERRED_SEVERITY;
+	if (m->status & MCI_STATUS_POISON) {
+		switch (ctx) {
+		case IN_USER:
+			ret = MCE_AR_SEVERITY;
+			break;
+		case IN_KERNEL_RECOV:
+#ifdef CONFIG_MEMORY_FAILURE
+			ret = MCE_AR_SEVERITY;
+#else
+			ret = MCE_PANIC_SEVERITY;
+#endif
+			break;
+		case IN_KERNEL:
+			ret = MCE_PANIC_SEVERITY;
+			break;
+		default:
+			ret = MCE_PANIC_SEVERITY;
+		}
+
+		goto amd_severity;
+	}
+
+	/* Processor Context Corrupt, no need to fumble too much, die! */
+	if (m->status & MCI_STATUS_PCC) {
+		ret = MCE_PANIC_SEVERITY;
+		goto amd_severity;
+	}
 
 	/*
-	 * corrected error: poll handler catches these and passes responsibility
-	 * of decoding the error to EDAC
+	 * Evaluate the severity of data load error for AMD systems,
+	 * depending on the context in which the MCE happened.
 	 */
-	return MCE_KEEP_SEVERITY;
+	if ((m->status & ERRORCODE_T_MSK) == ERRORCODE_T_DATA) {
+		switch (ctx) {
+		case IN_USER:
+		case IN_KERNEL_RECOV:
+			ret = MCE_AR_SEVERITY;
+			break;
+		case IN_KERNEL:
+			ret = MCE_PANIC_SEVERITY;
+			break;
+		default:
+			ret = MCE_PANIC_SEVERITY;
+		}
+
+		goto amd_severity;
+	}
+
+
+	/*
+	 * Evaluate the severity of an instruction fetch error for AMD systems,
+	 * depending on the context in which the MCE happened.
+	 */
+	if ((m->status & ERRORCODE_M_MSK) == ERRORCODE_M_FETCH) {
+		switch (ctx) {
+		case IN_USER:
+			ret = MCE_AR_SEVERITY;
+			break;
+		case IN_KERNEL_RECOV:
+#ifdef CONFIG_MEMORY_FAILURE
+			ret = MCE_AR_SEVERITY;
+#else
+			ret = MCE_PANIC_SEVERITY;
+#endif
+			break;
+		case IN_KERNEL:
+			ret = MCE_PANIC_SEVERITY;
+			break;
+		default:
+			ret = MCE_PANIC_SEVERITY;
+		}
+
+		goto amd_severity;
+	}
+
+	if (m->status & MCI_STATUS_OVER) {
+		ret = mce_grade_overflow_amd(m, ctx);
+		goto amd_severity;
+	}
+
+	if (ctx == IN_KERNEL)
+		ret = MCE_PANIC_SEVERITY;
+
+amd_severity:
+
+	return ret;
 }
 
 static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
-- 
2.27.0


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1A4EDEF3
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiCaQlJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240092AbiCaQlI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:41:08 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88E21BFDF7;
        Thu, 31 Mar 2022 09:39:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqXK7RcmcM1vm5VNnw9HAMkwMudLkQKOfBgIZLmodAD1FGZKVMzm6kOY8UYF5GaAjrCPetwlyh/qKvtfV0dZsCY8MWLezo/aSgGEQYivbLgW9eU0RBH9/Il4xPvIWuU7oYC4KzZTlc3QqPHPVzk1Z9IjWXlO/3UmMQZZfVt3pZ6lPaxqxkYOu1WoiphmC1nNGQ5vPaqXjEVbttyGKB+9lWK4zSIti0AVnBFnRJWo9UWPX8NqovWeEVnQmuILFs5q+TCENAA3Vevaqc5L3Io/nTwNyMc0gE2INnQWtg1SXjd5rPsUIGWkAcKFjtVHtpRDVrn0VLhONCUjAWdZUTxrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa0ZQl0TNS8pZGJNHJqLUxm/Ig1YNNgT7PQCawjSb00=;
 b=FdLaIRQ3yWL9OLY9vEsVzmu587WThBsAE7pFZN/8NglY0CvNN5qG+jKfWi/5cI0juJ5RPhemx0K5ODhqprPKbHwbvV0mKlUaLAHBEuh8BwZVeO6cKOLZhVSS37vSQEFYrzh1hqGsLUUql37QkqSa5cgGiU2ryj1dj352Tw3YGuSyxCI/ED4pVfIIVzTVLUL9AnSfyG/w6eCCUpzAc3FRXj1UkQQnS5l4GJZh181uCReJounadhEvLCv+vLar3MHqFxAnpBOWIarR6uQjkaHpvlGMFY7WtRLvKeq7mg8p/N8RFblpMh0WdOM6ZmhXs2P5aZFItqVjjM5oJHS5B12vCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa0ZQl0TNS8pZGJNHJqLUxm/Ig1YNNgT7PQCawjSb00=;
 b=Y+zgdgV6W00gBI1Moo/rycCwxU2TzGsHZKhipXRoPptxCVU/nHDPeIxQyYjpI7kYWIVLaoCFy+VazqA13vR7KGKXEeOww21If/tsVgeALd5scySWNh/OFtWExtpm23I+CVmLL1AvbAJMgF17wn+Ryq5abhpfwXnHnNZh+MHzB3c=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by DM5PR12MB1737.namprd12.prod.outlook.com (2603:10b6:3:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 16:39:16 +0000
Received: from BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::e9) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Thu, 31 Mar 2022 16:39:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT042.mail.protection.outlook.com (10.13.177.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:39:14 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 11:39:13 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 1/2] x86/mce: Extend AMD severity grading function with new types of errors
Date:   Thu, 31 Mar 2022 11:38:49 -0500
Message-ID: <20220331163849.6850-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220331163849.6850-1-carlos.bilbao@amd.com>
References: <20220331163849.6850-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72e56935-09a3-40fb-177f-08da1334fe15
X-MS-TrafficTypeDiagnostic: DM5PR12MB1737:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB17372DBCE7CC19E0E19E43DBF8E19@DM5PR12MB1737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CZbFMnVNLuPOY2RfzkkB7a0EUsDBezLlGbYdV0hBKnf2Tst5XYAjW6htZVEW+Avl/KFDaPFHg4/uyGlnK1O9Bw5WcoAWSE2ItZ4XRc2rURkTcfqt2E6bLgWVNfXTuDVLflkOvqDE3bkRoGYPT/y3YNTQ0SC5y6MLFk1gWBLZRnUQwDnkjc7MwnCzExoTUiZ4wBNz+cVX7iHAcz4jsHjdsy8ZtRLYb56y93NTMIConjrheXM49Ukvn7Lpow+/QDgQxgkzaaYVm8YPS1+BkcCFBgxIj4Ik7lT8cSxXIZrpMnWtSwQaD+tbQ9S7JFhNVHZ8v0nAZqBzzqamZVQxcA7gqy4X45WXPCz3KE+LL9VZjn6dLfrF7Y8N3XCXl0x+jOihq2fD/xF24YDZqtC+VtkbeP1dF7V0afP3lQIBZORamRJTNNDIDrwjCQmLheavGXSoNSMb7K60IGz8fkds0+NjccZj8UjhLjZEXwDfYKQ2FjnHd4wN/rd+s3bsSVziBZasuwtaVFkAOa4XswO3yu1zGzhBfL9At9q7wpSvtnordBYqv1usfFmu+DlDP5v2K40swuoVwBHrv2OOBFDtLufNRQkyaB7IEsoXqxTmZwJQppD7ZOz9uxHq2jfl91GyqyaOqLtjxFUUhQ1MSE6nLCB6JCapDb9as6SLn+7GYEY51H+rKlPuUA0SItChnHMKhCXA7ZKcBXcsU60Al/T3WMk50xQwl/wh+VueG8qIrMHoU8z30aQ76muSCt+gYnlztBKryylWmKlenlzqex7LwByDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(7696005)(6666004)(86362001)(8936002)(508600001)(6916009)(356005)(54906003)(4326008)(8676002)(70206006)(70586007)(44832011)(82310400004)(81166007)(5660300002)(316002)(16526019)(186003)(26005)(83380400001)(36756003)(36860700001)(2616005)(1076003)(2906002)(426003)(336012)(47076005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:39:14.7587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e56935-09a3-40fb-177f-08da1334fe15
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/kernel/cpu/mce/severity.c | 104 ++++++++++-------------------
 1 file changed, 37 insertions(+), 67 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1add86935349..4d52eef21230 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -301,85 +301,55 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
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
 /*
- * See AMD Error Scope Hierarchy table in a newer BKDG. For example
- * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
+ * See AMD PPR(s) section 3.1 Machine Check Architecture
  */
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
-	enum context ctx = error_context(m, regs);
+	int ret;
+
+	/*
+	 * Default return value: Action required, the error must be handled
+	 * immediately.
+	 */
+	ret = MCE_AR_SEVERITY;
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
-	if (m->status & MCI_STATUS_PCC)
-		return MCE_PANIC_SEVERITY;
+	if (m->status & MCI_STATUS_PCC) {
+		ret = MCE_PANIC_SEVERITY;
+		goto amd_severity;
+	}
 
-	if (m->status & MCI_STATUS_UC) {
+	/*
+	 * Evaluate the severity of deferred errors for AMD systems, for which only
+	 * scrub error is interesting to notify an action requirement. The poll
+	 * handler catches deferred errors and adds to mce_ring so memorty-failure
+	 * can take recovery actions.
+	 */
+	if (m->status & MCI_STATUS_DEFERRED) {
+		ret = MCE_DEFERRED_SEVERITY;
+		goto amd_severity;
+	}
 
-		if (ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
+	/* If the UC bit is not set, the error has been corrected */
+	if (!(m->status & MCI_STATUS_UC)) {
+		ret = MCE_KEEP_SEVERITY;
+		goto amd_severity;
+	}
 
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
+	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
+	     || !mce_flags.succor) {
+		ret = MCE_PANIC_SEVERITY;
+		goto amd_severity;
 	}
 
-	/*
-	 * deferred error: poll handler catches these and adds to mce_ring so
-	 * memory-failure can take recovery actions.
-	 */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return MCE_DEFERRED_SEVERITY;
+	if (error_context(m, regs) == IN_KERNEL) {
+		ret = MCE_PANIC_SEVERITY;
+	}
 
-	/*
-	 * corrected error: poll handler catches these and passes responsibility
-	 * of decoding the error to EDAC
-	 */
-	return MCE_KEEP_SEVERITY;
+amd_severity:
+
+	return ret;
 }
 
 static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
-- 
2.31.1


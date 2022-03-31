Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B639E4EDEDB
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiCaQeu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbiCaQep (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:34:45 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D821FF437;
        Thu, 31 Mar 2022 09:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4czB1ZnQhxHloQMSWXFAUvWHdTk2X8G4V0RG6vqoxrqrvnbIfgO6IeCuJvsRWfqqp0DWvuDdeztIBLxB7NCMK54PzzmimL9Boewr5v25AACrX2KcMwQl0NQJGshN4nuTNMisN4cAfsmXF4OsPH2zOtnlomPJfwNJg7iANv/EbWzUP2gEsRgo5Qqp+D3xneDdME66uo1vL7khY4d8f5P1km/bH6tdVkCsz4jgIq23mxbL3OY6c4P9/NMfhDQsbrYxupD0+keZFbhv+zLRf0ydhB9uzVeeo8A67XHhnoUW4LXsSZJtLAjSjXfWXltPYn1dSL6V/uJve6PSP2SPEs4JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa0ZQl0TNS8pZGJNHJqLUxm/Ig1YNNgT7PQCawjSb00=;
 b=dXp2ruZnOrMXpbeytMS9EX+tnHDujm4KnKqS9wgF9W6U9R44P1F2+NNGtXYlePPmGpeycJTumIbos3q2oQOsYc5vBFPdM0eKH7iJIlJM83psjCh8GYYXWzCvcPfIM7naixZFivoRRCa64o3tfvrVykCpFAFiFdMfBlciRgzCG3Ira7uRm8m4M70rnETVsGq/9Q3VzlTGw+jv+Xqi+lKOXX2VgjPQWBkFZnoHcBd5y2NCMiHaNGyi+8mPbiKsAr0gsAPYqz1qKImI6mayCCA6lZxuAI7m5jUnF7JPEpGdI4yTSrj0bq7Pj8g04aZuFjVD5aXVwnLMrAf+p+1qOJm93A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa0ZQl0TNS8pZGJNHJqLUxm/Ig1YNNgT7PQCawjSb00=;
 b=ql8wOtr3AW/XFZqLN9VFfjYYdc9fATeYMsG1X9ChyEFBZzZlFgXG1L8NnFCYH1jna8/uR7GmXqh0AiL+wiwSDYwaDNmpV6xeK1LQIu+ZqQJ6SiPoiAsctaJzcWTI6QurTXgzY8a9yKpUrvpHca3M2kiljeLM1tM6kLe033Zma+s=
Received: from DM6PR05CA0065.namprd05.prod.outlook.com (2603:10b6:5:335::34)
 by MN2PR12MB3711.namprd12.prod.outlook.com (2603:10b6:208:161::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 16:32:55 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::82) by DM6PR05CA0065.outlook.office365.com
 (2603:10b6:5:335::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 16:32:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:32:53 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 11:32:52 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 1/2] x86/mce: Extend AMD severity grading function with new types of errors
Date:   Thu, 31 Mar 2022 11:32:12 -0500
Message-ID: <20220331163211.5994-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220331163211.5994-1-carlos.bilbao@amd.com>
References: <20220331163211.5994-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 049e4df1-191c-4f53-e93d-08da13341aba
X-MS-TrafficTypeDiagnostic: MN2PR12MB3711:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB37116DF872A58A53FAEE37A9F8E19@MN2PR12MB3711.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EtuYSwsg6iYItYUh5JYkjM948l4oiqOhGWfUuFt3BOiBjRpQ8LeXX3/d1T68lVpP2IbjMckbQEXnlo7/l//AM5Bh+cPatJbyDhvEjZ4nSmXiETm9c8mZ1SLt7kAg8wHP6NZUjBpxqfoQwRtmqXko24TY2dDNA4RBno0AHn3BgbL3m8QG7xHVSkoPGBo6Ait0lAhfYtajNvUfUghnspjdlkc0TzsFOlcW+y+gDnS8zdAKXDxFZe+G3BEW1Zr5YrXhjt6+IACDB+IUf7LjyQHv6ELmSCQd0E9ToWn1d2/wiyKr/JCA+QFuIdy3Gljt8/IDwZBPg6pfmYyEkPEyU3qtJFA2SGPw272cjx+KU/D5KlJ8zJbZ8BcPWZG3e+Fq1JcM4mVHJDX0PuEi9u5CYbIh1GjPxqo70S1AqPl7OSr06NAS8b4obUtn6tdwF+LNe8DhiJIwgGErMhNcAbsQosbZK/bjTur2bbmLYy+aux7W9afR/g3xi5VUYkUEEvbB9on3j48KidAEfG4gCOKaJNsHD/RfTGenWplFmuBbc5qx4h1NyX3nGCmCQZmciayChYTfR4xP32pD5hW1RMPOHh9UR+H1MMCu1pAnOm5uUM+1deMx0sqzIgaQ9LGyjZR5JuiA/WcE9wx7WpOHf0lIGFMicwZwsR2mhTJnbMYDNIDrQo1nLD5Cgni9sMmWYdnp2anj6OuL5khJJdxqChlng0bOZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(83380400001)(6666004)(47076005)(70586007)(70206006)(8676002)(4326008)(40460700003)(86362001)(2906002)(82310400004)(54906003)(508600001)(356005)(426003)(16526019)(336012)(316002)(6916009)(2616005)(5660300002)(36756003)(36860700001)(7696005)(1076003)(81166007)(44832011)(186003)(26005)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:32:53.3093
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 049e4df1-191c-4f53-e93d-08da13341aba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3711
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


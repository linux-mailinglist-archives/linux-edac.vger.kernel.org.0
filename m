Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5104B4F53D8
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiDFEGz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573255AbiDESew (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 14:34:52 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6829F13F6F;
        Tue,  5 Apr 2022 11:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWy+GzOghRMYh3C17nDjGUREBHSnItuTKy27X8d/a6wU3f+pvrI/Ab89ayXTTSpnU3JpXWDQZx0J1XKoaMRlg8tqhff/SpzDcmTtbPQZkJ7HYIhs8N3cTHwSOaYuriwXrZ/B8f+ESIuFJ/bbYbDqcmOJwiBNCe01+rF2Ov3cn+yPyds7rPLiWSccWAO9QyU3fFXIjoNySPz8BIJeEnITK/NvanL0p7fFFejLANa8JZN1kNJD5ZsmQdnQ6oj+fPZD4qhcL+mpnX/dBaumhkZUSHrZHoiIQgGk+tKhOEl2ol9k32LkB3PgKqgwWk2fTM9msUSlXyt5AmoFOMICd0TC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euSGxN3ZvYTXh7cehJAOhjg95Ru9b9b4HTUZodH1ejE=;
 b=ezcJnBR8ycqXnKTakP35E61V7laeBMhu6qjykIXK/JpTSWoZ1yuXFCGhY6IBVIqnH5nbsnCgASFEI7G7V/SkNkPctwhUEvZn417zFIeHlmZIT4OgNitRjSjVYUaJnRX58DEWGaVT+X+rk5i5Al8FaQYu+/Mnzp78x5QQ86UXhNcgx1EhOZr6TZyvTgOkgTjeUEbC9k6GS6K9ECtQVZrt93YBjK4RvZGU8kF5PgVMH7XqatBJd1LC0C9KJ8HNzqtIGjsXc09VJsGAvaFXyKi9zrr0aHokM3V8t7mzz5iEyoMf4+pVzPeEUPOokvQTg/f99WWGE47mq1yJL6TnbDZFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euSGxN3ZvYTXh7cehJAOhjg95Ru9b9b4HTUZodH1ejE=;
 b=0tiFeLmXtHERFquUMen1nrGryZW9Km6YmiTgAqfRgUjIEN01WlUJWH1LSgfGwzYSu7LkA8t0QIlCL/P+metInZl7+Cu4nT4o9dWtrLpeheYjmpd6yuKWodTbwWEbNnoNcIbkS39QeN+meoj+GG61zYzi9GRQ/XYCg7I2I8HtvOs=
Received: from BN0PR04CA0097.namprd04.prod.outlook.com (2603:10b6:408:ec::12)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 18:32:50 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::e2) by BN0PR04CA0097.outlook.office365.com
 (2603:10b6:408:ec::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 18:32:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 18:32:49 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 13:32:48 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>, <yazen.ghannam@amd.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 1/2] x86/mce: Simplify AMD severity grading logic
Date:   Tue, 5 Apr 2022 13:32:13 -0500
Message-ID: <20220405183212.354606-2-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220405183212.354606-1-carlos.bilbao@amd.com>
References: <20220405183212.354606-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b059b13-5bde-4a8a-f748-08da1732afe4
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:EE_
X-Microsoft-Antispam-PRVS: <DM8PR12MB5477340DA4DB0890A6EB5D69F8E49@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S1kqUT8CDGDPXkSB1XZNqYrUZpnIGycyolSk0IK1tT9t2+AwHny+3WPo56tO8TVtaeVn/RGuAet6kVMpSoclDifFOJEHl7nernM3JRy25sLiLBwf+10rzyrQv5Bp4IVAATzjEKg0or9dZZx9I9yOT04qTCO/EMgaeb4z5Zr/5BAP88acbVbC/mY3N+YZxcoy+sYIVjs3hrvpp9jTw5LTZI5LpT6OyNx9i8RkyT4WPonK1u21pX/PnHJ+1Flgskva0l0oNwm8fifYv5zyhPq0vzwEkzsLFeYfFzI1UXs4IAOeC0x9pUn5Cp2OkFZkR/K+PByDRxAXlHnJiVtEryvPxBUWhXtyyspDmHyXvB6SHRKs5i4Pfr7vT1s+4hHtru0dUngH8p3FuBFKzLY2hYL0tiRHQshr1dwsTCxeqLZ5ICqwfmGr/R3SYWF/WiNmroa7CLXIhKAR9wYw7ATQwFyBy35Lxcjhcepl2HOcVmwbwIirIji/emQc7x/So6gPNXLlAOZ+iVDqZWm+3ds85CqVLbmtuwIHjswLHHqsbZT+o7tE8iz/P8g4F+Bt0SGKBi6soygv8//hKSdyV+e7B9obwkIzIeH68/KmI3jA+1QMKuorQAzsZVQqI5ZfO9PAnr7lZ3FmbqevcHebh3/p04+buYWlA7OvmG9JQo2o9WGgzlZLiWgIN4l9ILwOQu74BRnh+NtiqadGs4RONjzdaVoNFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(26005)(336012)(16526019)(186003)(1076003)(426003)(47076005)(110136005)(4326008)(54906003)(8676002)(36756003)(6636002)(70586007)(70206006)(83380400001)(316002)(86362001)(508600001)(82310400005)(8936002)(5660300002)(2616005)(81166007)(356005)(36860700001)(7696005)(2906002)(44832011)(6666004)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 18:32:49.2543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b059b13-5bde-4a8a-f748-08da1732afe4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
act accordingly. Simplify the AMD grading logic following a logic that
closely resembles the descriptions of the public PPR documents. This will
help include more fine-grained grading of errors in the future.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 104 +++++++++++------------------
 1 file changed, 39 insertions(+), 65 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1add86935349..25aec5a27899 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -301,85 +301,59 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
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
+ * See AMD PPR(s) section Machine Check Error Handling
  */
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
-	enum context ctx = error_context(m, regs);
-
-	/* Processor Context Corrupt, no need to fumble too much, die! */
-	if (m->status & MCI_STATUS_PCC)
-		return MCE_PANIC_SEVERITY;
+	int ret;
 
-	if (m->status & MCI_STATUS_UC) {
+	/*
+	 * Default return value: Action required, the error must be handled
+	 * immediately.
+	 */
+	ret = MCE_AR_SEVERITY;
 
-		if (ctx == IN_KERNEL)
-			return MCE_PANIC_SEVERITY;
+	/* Processor Context Corrupt, no need to fumble too much, die! */
+	if (m->status & MCI_STATUS_PCC) {
+		ret = MCE_PANIC_SEVERITY;
+		goto out_amd_severity;
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
+	if (m->status & MCI_STATUS_DEFERRED) {
+		ret = MCE_DEFERRED_SEVERITY;
+		goto out_amd_severity;
 	}
 
 	/*
-	 * deferred error: poll handler catches these and adds to mce_ring so
-	 * memory-failure can take recovery actions.
+	 * If the UC bit is not set, the system either corrected or deferred
+	 * the error. No action will be required after logging the error.
 	 */
-	if (m->status & MCI_STATUS_DEFERRED)
-		return MCE_DEFERRED_SEVERITY;
+	if (!(m->status & MCI_STATUS_UC)) {
+		ret = MCE_KEEP_SEVERITY;
+		goto out_amd_severity;
+	}
 
 	/*
-	 * corrected error: poll handler catches these and passes responsibility
-	 * of decoding the error to EDAC
+	 * On MCA Overflow, without the MCA Overflow recovery feature the
+	 * system will not be able to recover.
 	 */
-	return MCE_KEEP_SEVERITY;
+	if ((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov) {
+		ret = MCE_PANIC_SEVERITY;
+		goto out_amd_severity;
+	}
+
+	if (!mce_flags.succor) {
+		ret = MCE_PANIC_SEVERITY;
+		goto out_amd_severity;
+	}
+
+	if (error_context(m, regs) == IN_KERNEL)
+		ret = MCE_PANIC_SEVERITY;
+
+out_amd_severity:
+
+	return ret;
 }
 
 static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
-- 
2.31.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FA24D66D9
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 17:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241338AbiCKQyC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 11:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345058AbiCKQyB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 11:54:01 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA8CA9E2D;
        Fri, 11 Mar 2022 08:52:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmQW98YI6DlvwqWXIyMi7QcV9KFICsSFd/nJvWgTWOHwNzCtXGVDN0afbCfC/fsOuqnCELDGcz1N+f6TicNV9njR/1G0GEHUDyeY36XBTpJGN4d8fTFQYibVEKXPUmrlNlVvAo+sU1akIINkBh6VG5CVwZBfS1tATSP1uIb4TZHemjXEAOpxkKTXG6e2dhlxEVRlBWbv/Il/cfjPZUUUaLLVMIq5u6sULZFTAEkPIbQIZ1XxU3+jkx2fm72ug15OoTQCgeeX6TkIGcR0h0wnkqFqSRbu4jonyQkv/1ptbzUmeTZZjN9KD4u9OkQ+Njn14w3yXED+cvKPELaNccym9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZteyEXqBRIKqXdNDV3sJusL9+V+WIS4yuBBDTbzMIJU=;
 b=gqe3jfc7aQ/RuEMeGpy4xGHyaQIjHNUKlqWE3N2it1192QVVFIY5R8ZTL6+FuSVTs/4Nk6X42JJOoboufXWTe6hN3OQ/MckivbI1bfRx9WIdtAABt4A4h9C4xWToWwGHsXt70WqV2K6UzoYfuiWnxe4ody4xTBddikLFffpU4bTyH/AnpToL5HuPoZ2LPiwoF81T6Dlh8BCHjhQLAYMp9ocGcDSou7AykLisKjBTdLtrHJc5YQbeHJajzsAw0CqU5oV6deobBGZqlBh+aTAVMV37eN4+kxmsdIhP9Rf3kR/fWeQrgCkFXELJYGMp+vcfBLTuZ9x/wetcVhUzg94a/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZteyEXqBRIKqXdNDV3sJusL9+V+WIS4yuBBDTbzMIJU=;
 b=S5ZSHj+dyeaaBm+Yvg7D8v1c1QC+yt6F+5EHHVl7xLNkyeocYMHSEuS5jAo0Z+tcmJTf6RxQ9XLMAfrWmRTwlU+6IsZkl0s+0oJTVd0DDpQwm5vdws02yDCrx3m4lL3Wb/2pHb0bM8Sou03Yz4DC6W7/1AAi1buXqUAvcs/tOX0=
Received: from DS7PR03CA0019.namprd03.prod.outlook.com (2603:10b6:5:3b8::24)
 by DM6PR12MB3707.namprd12.prod.outlook.com (2603:10b6:5:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Fri, 11 Mar
 2022 16:52:52 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::27) by DS7PR03CA0019.outlook.office365.com
 (2603:10b6:5:3b8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Fri, 11 Mar 2022 16:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 16:52:50 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 11 Mar 2022 10:52:49 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 2/2] x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
Date:   Fri, 11 Mar 2022 10:51:17 -0600
Message-ID: <20220311165114.482074-3-carlos.bilbao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbe3b87e-34da-4fc4-c400-08da037f9440
X-MS-TrafficTypeDiagnostic: DM6PR12MB3707:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3707A48D92E7B1A4AE1F264AF80C9@DM6PR12MB3707.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OjyZy79JIAXjhuKpDwoUGbQJd/fN3XHh94SmlFJMVJ8IYCyxZ4v64Z/nPgO+hm1RpkvbK+Ml9uldWiVC9yTWnaLragVk0+Fr8VOt7gRjIpwVe9YKw1CtSlabFefSbj82zR5K0IIWHbQG//QHBlLj8eci9/OPXdR0JktYdlortZaSqruQV8xizRnHvyNt5iRof3hhdDWGSTwvtf+KU4y3Jme4CL/lYhQnO9o8+Z1P6JX/QuPhROFH7ZvUuR+HQKzBOwNHPQEmzaFoct9aZScCR4dCuOXXYN/849UBxMiqakm9RMYrdf1k4otYCoXUOwN0oNpQLBpYW//xmOSnPkedJaL203j7ai3eDtRJcB//wKBt8oLKybSrs8VltHUSYDG6ck1K7KkDvOvBXqKfyRFzARRoCnMsJ1OccvvmkZD/aVV/nVHdaYAKKTlqU5wRP9kBXwOHzEbiJCjDFnL+JSVvd4+8DTgUWnxCB9Rn48A4tURt7yTWZRoZ+lsAZwHewQpOaqJA6eE1gDEKdbIDNBN98SDaqxuvVEWIvNGQ1O9xVTvTj5XCXWEReSZItfVolyLEbuyxWshRAAaExApFc39LRSI8IaPlCr11ithBaL2T7TV/tk7b2POJWjSPqCLff5BT/pd8JdPO3la+FbcBKOPxFXE+C7Y7QNn63c3TKt+C8FtZs5WdpK/BqKNjhDtLm9zrnww5lW0Zjt9NN6TuBFvo7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(26005)(81166007)(426003)(336012)(186003)(16526019)(2616005)(1076003)(83380400001)(36860700001)(47076005)(356005)(86362001)(40460700003)(82310400004)(70206006)(70586007)(316002)(36756003)(6916009)(54906003)(15650500001)(2906002)(4326008)(8676002)(8936002)(5660300002)(44832011)(6666004)(508600001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:52:50.8255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe3b87e-34da-4fc4-c400-08da037f9440
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3707
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When a machine error is graded as PANIC by AMD grading logic, the MCE
handler calls mce_panic(). The notification chain does not come into effect
so the AMD EDAC driver does not decode the errors. In these cases, the
messages displayed to the user are more cryptic and miss information
that might be relevant, like the context in which the error took place.

Fix the above issue including messages on AMD's grading logic for machine
errors graded as PANIC.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/kernel/cpu/mce/severity.c | 33 ++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 4a089e9dbbaf..11be63eaf7e5 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -330,10 +330,12 @@ static __always_inline int mce_severity_amd_smca(struct mce *m, enum context err
  * Evaluate the severity of an overflow error for AMD systems, dependent on
  * the recoverable features available.
  */
-static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
+static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx, char **msg)
 {
 	int ret;
 
+	WARN_ON(!msg);
+
 	/*
 	 * On older systems where overflow_recov flag is not present, we
 	 * should simply panic if an error overflow occurs. If
@@ -343,6 +345,8 @@ static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
 	if (mce_flags.overflow_recov) {
 		if (mce_flags.smca) {
 			ret = mce_severity_amd_smca(m, ctx);
+			if (ret == MCE_PANIC_SEVERITY)
+				*msg = "Uncorrected unrecoverable error";
 		} else {
 			/* kill current process */
 			ret = MCE_AR_SEVERITY;
@@ -351,8 +355,10 @@ static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
 	}
 
 	/* at least one error was not logged */
-	if (m->status & MCI_STATUS_OVER)
+	if (m->status & MCI_STATUS_OVER) {
+		*msg = "Overflow uncorrected";
 		return MCE_PANIC_SEVERITY;
+	}
 
 	/*
 	 * For any other case, return MCE_UC_SEVERITY so that we log the
@@ -367,6 +373,7 @@ static noinstr int mce_grade_overflow_amd(struct mce *m, enum context ctx)
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	enum context ctx = error_context(m, regs);
+	char *severity_msg;
 	int ret;
 
 	/*
@@ -411,13 +418,16 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 #ifdef CONFIG_MEMORY_FAILURE
 			ret = MCE_AR_SEVERITY;
 #else
+			severity_msg = "Consumed poisoned data in kernel recoverable area";
 			ret = MCE_PANIC_SEVERITY;
 #endif
 			break;
 		case IN_KERNEL:
+			severity_msg = "Attempt to consume poisoned data in kernel context";
 			ret = MCE_PANIC_SEVERITY;
 			break;
 		default:
+			severity_msg = "Attempt to consume poisoned data in unknown context";
 			ret = MCE_PANIC_SEVERITY;
 		}
 
@@ -426,6 +436,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC) {
+		severity_msg = "Processor Context Corrupt";
 		ret = MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
@@ -441,9 +452,11 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 			ret = MCE_AR_SEVERITY;
 			break;
 		case IN_KERNEL:
+			severity_msg = "Data load error in unrecoverable kernel context";
 			ret = MCE_PANIC_SEVERITY;
 			break;
 		default:
+			severity_msg = "Data load error in unknown context";
 			ret = MCE_PANIC_SEVERITY;
 		}
 
@@ -464,13 +477,16 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 #ifdef CONFIG_MEMORY_FAILURE
 			ret = MCE_AR_SEVERITY;
 #else
+			severity_msg = "Instruction fetch error in kernel recoverable area";
 			ret = MCE_PANIC_SEVERITY;
 #endif
 			break;
 		case IN_KERNEL:
+			severity_msg = "Instruction fetch error in kernel context";
 			ret = MCE_PANIC_SEVERITY;
 			break;
 		default:
+			severity_msg = "Instruction fetch error in unknown context";
 			ret = MCE_PANIC_SEVERITY;
 		}
 
@@ -478,15 +494,24 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 	}
 
 	if (m->status & MCI_STATUS_OVER) {
-		ret = mce_grade_overflow_amd(m, ctx);
+		ret = mce_grade_overflow_amd(m, ctx, &severity_msg);
 		goto amd_severity;
 	}
 
-	if (ctx == IN_KERNEL)
+	if (ctx == IN_KERNEL) {
+		severity_msg = "Uncorrectable error in kernel context";
 		ret = MCE_PANIC_SEVERITY;
+	}
 
 amd_severity:
 
+	/*
+	 * It only makes sense to provide a message on panic scenarios,
+	 * as otherwise EDAC will be notified and conduct the decoding.
+	 */
+	if (msg && ret == MCE_PANIC_SEVERITY)
+		*msg = severity_msg;
+
 	return ret;
 }
 
-- 
2.27.0


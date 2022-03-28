Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0743E4E9882
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 15:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiC1NoX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243378AbiC1NoW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 09:44:22 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B965EBCD;
        Mon, 28 Mar 2022 06:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RILOosgLowaHN/J4Q7gEIbaRcqSjO9QTqKPCPC4f9Y/UtWxZU346VeJ4lP2Puy7YBKvDyf+m9htmWUpvAw0rLIw4SdXIeCvVshKZxjtAzHJ2t2uHmyw3BNJWqw9xxGgMjsTPmdD69g1LFleHfxdjsnP4IyVi4dCIBrqcie6FrOrimABRAetjMRLbWHvhWWUsqAXzCA1NpWAi8bKuEHgLcUR9ab2+dU/L3RvU0YoGku6aIDcJzj3OZlVPwaDqF9hif8ZpNeIKhBMFKv1bQAxCCgcZ5rFdduCS2Er1JN2ob+J1QGMa9dPlqZuZLQeCVpZZP7mo70OCd0K+OXTuo5L/GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZteyEXqBRIKqXdNDV3sJusL9+V+WIS4yuBBDTbzMIJU=;
 b=JVZC5IuhwxhrCCKYShplSrSBSmsj85RT8hAfc7tMJVK4dF6MYMR5Y4ZflcbKH35HF2GJHtsTYIXSsw+1F9LMbey2kYKEM1O6FaVW8fFzgyp1Ae8r/lyAirXmqiLZAHzbJwYw0PeqzNMZmP9SOBNH+g77XomUaFwfLKEeQN3vuTZUyUt0l6qIL12/9xTwcBROyMgKP1zul2sX/tVs0T9ik3PZ5Zu1WUPJa0F5PUccRvx9DnM5Yi1s9DJSqkgoiWlcX0aSjIDy5bd+Sri1zDQLizC0sgf4fG9n7g2rbkfJsGN7cyNkEu20680DuGtOvoEMnbPp1ioHKXHBNg+GM+sCZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZteyEXqBRIKqXdNDV3sJusL9+V+WIS4yuBBDTbzMIJU=;
 b=rl6MiFibypDZ+jMWTGMY2nnuTjo2jNA3bpeECsz3J+3bk08IxpAqgLx8hKUMyM8M4xcKpt9204mZFdkWV9GKMVpTgS5xCMVMUrzBWvU0qtWzPSKDuchw5gTkfCU3cLBhfvNDbxbyseh4zRazX1M1zzIJVVkqvJt2rMV6f003C3g=
Received: from DM5PR2001CA0004.namprd20.prod.outlook.com (2603:10b6:4:16::14)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 13:42:38 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:16:cafe::3e) by DM5PR2001CA0004.outlook.office365.com
 (2603:10b6:4:16::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:42:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:42:37 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 28 Mar 2022 08:42:36 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 2/2] x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
Date:   Mon, 28 Mar 2022 08:41:34 -0500
Message-ID: <20220328134131.736572-3-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220328134131.736572-1-carlos.bilbao@amd.com>
References: <20220328134131.736572-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2b5ac85-a678-4216-555a-08da10c0d259
X-MS-TrafficTypeDiagnostic: SA1PR12MB5670:EE_
X-Microsoft-Antispam-PRVS: <SA1PR12MB5670A7F4A9F8EE0DA2604D64F81D9@SA1PR12MB5670.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gaagimj1HTvqcTqFuXrJVFfV3nw8KpQLtu0ncjvqyHdZbKBI7iPo/NKNEfRPTv/KCgKrc6z1Wk4k/gygfXsexuqGY1vHuZaUZQ8eeVHVWSg7r3YAQa+qxoWIHz1lEEsQJsR+pn9YCOiMqsOMpymdIMgVLd+u3CQ9vaJVjhpRrliRaAZpkMG1sTeyFBWUnXaXm1GH09kjcGaCCCpX2hl1oZ2Z4VRTDjo12w5VhSxu9FK6oojGy5kF9VviEm/r66VXPJjQuTGpKuSov+mNTYMEC9NDl1MZKwCIEe8MXVympoby7pOgnT6sRfV1XJMRbUxJgc+/1u5NcnIzomoUmwkQyZeLFlCOY144D/j2kTOHkbPveeNxQuacFaSLj65Jr88bllIa4MG9S4Dwo3IzxPcYEPORTYaUlX7A3PREHBDYKReLZlyCNoalMp+pUeSSRWjAiwyIvoMN1Di478fAa8MimYxuJtLYk5qURRPRy1V2TIjtxaWly+gIbj9Q5ZH+EUhX0WxcD2D3CrVn1W3koYX6ro+7y+Alun5u0shn6J7DJWEBKJGlOf9q6gr+c/XI3yjcvYiH29iT9NygGel1Bnoac0R7qE/b6hh4L48gZmNSTUymelKeklIqzBys9X9nScKtW7q6KPtKWuCHpQnVhanFaAuTrjU7f9Ya1ecuAqg9V1RhbE9qp0+xSve80aLmQWY+qBmE5fnnMJ/Z/t2zQznsbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(16526019)(40460700003)(86362001)(186003)(54906003)(6916009)(81166007)(8676002)(316002)(508600001)(36756003)(47076005)(5660300002)(4326008)(70206006)(15650500001)(8936002)(2906002)(70586007)(2616005)(426003)(7696005)(336012)(82310400004)(44832011)(1076003)(83380400001)(36860700001)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:42:37.4087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b5ac85-a678-4216-555a-08da10c0d259
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670
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


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B474EDEF2
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240099AbiCaQlL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240101AbiCaQlK (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:41:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEDC1C16CF;
        Thu, 31 Mar 2022 09:39:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6TveahTxafTaV4//vfFMWXSdhrdnNAfNKS4t51T6UWKO+ckvKugIBJVRlMmgu5eWRV8Mz0QkZpFkxp4sYT0aWctHwEob73VQvfQOn4hPn3Faew7RutFXBJtjB2XLUUg8q2kma1krC7+THqwTPXYcarT4znEBbvSvIMxY5jSD7EEjvNYHt+4GMUBNgrxVJ8Je2MPyRl6y1RMGjKnyPQhOifZF+In0Dm2YPNHJUdeNQB7vOok48FJtReV43Kq2I3E3gmVpk2GXkh5IwWGEIAvpOBn/j6ShWNheWsogTvvNRRZXWxeV+dDErB3fk/zcX4rFjRvxdEfR7fMUOBzoc9nzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpsQ3P7GLY5eeC0LjnMTlMF06VsykEnUUDgRshVxjqM=;
 b=e5GJnCj6+v6Q2fBTOaZF4HY9Egts3n4euxbHeUQMId9RX5Pz9Nncfx/5nqanvheTKGH90z+us04bH37FVy0cnJZ5Ri9NTsurfLjy3Md+RKPSBizI23565NhOPaIvwAufOm6ryoO/OGGkaPrXb/YvPnsDVsKbkVk5LmcZTGrpGOCpA2ToT4VfyMACo/PEOMpgKsVK41+P5pDX7dqUdcrBxN4iBJ4MlppWmtkpSYspaMkCpQ2YSNVShlq7G3eBqDMijyIOEXQofBXpvu1QqmluI6XWxEebavuyLwhYKmq9ECD0LFXcz/d9fzXeM6RBOkHvJlFNFkrE9j1aiiAYqRS+lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpsQ3P7GLY5eeC0LjnMTlMF06VsykEnUUDgRshVxjqM=;
 b=I+scbzlrMkoKZT6LaWbJXFOWeCe2dqButvIPQ2kg9FjGXzSe3kwbAGjz4e3DPqW5Alk8oMrjxD3vFfL1wBoS6w0z3iUVv9cs2BdGrDdQHBqytcTUorsnPUfCFuAcEFw+mrooUwOi6860EjDDR0y6enLdZ2evP9P+F1vllopbAVw=
Received: from BN8PR16CA0016.namprd16.prod.outlook.com (2603:10b6:408:4c::29)
 by BL0PR12MB5524.namprd12.prod.outlook.com (2603:10b6:208:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 16:39:18 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::3f) by BN8PR16CA0016.outlook.office365.com
 (2603:10b6:408:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Thu, 31 Mar 2022 16:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:39:16 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 11:39:15 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 2/2] x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
Date:   Thu, 31 Mar 2022 11:38:50 -0500
Message-ID: <20220331163849.6850-3-carlos.bilbao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4f8d9132-4783-43de-8d13-08da1334ff31
X-MS-TrafficTypeDiagnostic: BL0PR12MB5524:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55243F6A740B8210088A6B21F8E19@BL0PR12MB5524.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P7/fKEwCfqVqY7sPeHohNnrMBwl70jH2XAFrYJkVpQ9N5nWYiCSiFPY6qg0isCxfGr+xje6g/rQRfhe/8cTbT28dXGGbxoUeMFdbuIGQuTFlMR8ORyzZdp02edI1p9NOudlVIuC+GLBYli6xGVLCI3v6xIZ2BRPW3tY5VBL7LaiTn5DiazEG2TCZYTKyPzSoCv/8pLYJ4XeGzj8LYmLrpgd+R5iYsacCSJQxcFy5Ju9Nvlavu4KzP2L1yrMEMCJmwGJeDFRBvVQTP/u9mNZBAQGojH7CEKm981+Uq0ZB1WI/ItrE3sz47GaBd6egf8xKgGNKlDWqxaX3UgVbPnwSZCQkmO8QyNJUbAJzi4Pyp201up2CY936IrDb3NFERJhJPgLt9Iyq9Vwp9VY3chNN+q+6U2bOWYjPi3Ltygv17EMEpnpG/zVw/0QIZn8K09xSJI6qpWcCe5BhdkyQpVWHfUWmM+GFQqaxFHTg9t5EJ0nG4c5Xo8MP1TRJ44rddSvUDiUrW0HoHGT8rUsqEetL/B9eHR9EeqiEYaM2jCq7+dfC6Fa/Qy6COipMZNQJc/ngSa7GyDEFEp52AXcLExtDG/fxpImHgoxBXG96fw1dnQET0OhRaiLmGV9jb6dJoR6u6FUc211M9pPL7n6UxmZmD6uIXcwC17MksawuM3E++r7aJ40UDf2D2/iEIlN7X1OP9lw0E0W/kCy2NnDH1j8wbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(356005)(70206006)(8936002)(5660300002)(2906002)(8676002)(82310400004)(316002)(44832011)(6916009)(54906003)(81166007)(70586007)(83380400001)(47076005)(6666004)(336012)(2616005)(426003)(15650500001)(7696005)(1076003)(186003)(36860700001)(508600001)(16526019)(36756003)(86362001)(26005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:39:16.6229
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8d9132-4783-43de-8d13-08da1334ff31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5524
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 arch/x86/kernel/cpu/mce/severity.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 4d52eef21230..ea4b9407bbad 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -307,6 +307,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
 	int ret;
+	char *panic_msg;
 
 	/*
 	 * Default return value: Action required, the error must be handled
@@ -316,6 +317,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC) {
+		panic_msg = "Processor Context Corrupt";
 		ret = MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
@@ -339,16 +341,21 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	if (((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov)
 	     || !mce_flags.succor) {
+		panic_msg = "Uncorrected unrecoverable error";
 		ret = MCE_PANIC_SEVERITY;
 		goto amd_severity;
 	}
 
 	if (error_context(m, regs) == IN_KERNEL) {
+		panic_msg = "Uncorrected error in kernel context";
 		ret = MCE_PANIC_SEVERITY;
 	}
 
 amd_severity:
 
+	if (msg && panic_msg)
+		*msg = panic_msg;
+
 	return ret;
 }
 
-- 
2.31.1


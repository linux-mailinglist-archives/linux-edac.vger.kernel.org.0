Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1B9553733
	for <lists+linux-edac@lfdr.de>; Tue, 21 Jun 2022 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353274AbiFUQBZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 21 Jun 2022 12:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353660AbiFUQAx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 21 Jun 2022 12:00:53 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2040.outbound.protection.outlook.com [40.107.93.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A52E9F8;
        Tue, 21 Jun 2022 08:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIu+06I/PCruDFpzw4QpMyyYONbv3q8Gj/tMbfVIBJicXgeLLE4+KmRiSf+rEaljv3y898eaSNx70AgXSNZ12WNWVOh/S7gE7aJvPlS+t18UAc1Kw6/7u5jnV+wMNjV+IcTAYU/IMZ9V2a73X79IJwbrw+CBTMZPzAWvFsN/l1BEKPJgjkJhEcrazPBStK4Jzwx/fJrq8ZaMvqvisjDtTgB7/MNRU5loGSFR8VzOBsdSXxFSrWQBLdshBZ9HOJ1UyS0yri6vruXc23M3/6fy1S/z08LjoEH7T+XizDVGEMDoz7YuSdDZ52u2hee5AKKEDfYIglDQCjaNwz0lpq8gjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IP3QwUbRlaaXD99p/IiCne1lveJ2Hq3oPcSZbp0EAuU=;
 b=lFMsjzTB4LOIOYogCpsNP1afuH7Ml+ezCzTlz/Dm4B8X23+vvTvcSD7g4pIv5shidOeOy5sYVyVO2MHmwiU8+zF2xXslAcS4r0m0wFZzJ4Fx6tCL4pl9Swxv6BcKiel0u6p/Y6Mthd8rP7GTZ+yIzF+oZqIaUq8S7Q0bTwQB8ISqvld/o4ORlOxiRrmi9p/0fsLyNjfQ5fTxyp2cUjlUZUcaJQj8zrGU/k4u2xx41jPBVzmUnbfC9qsH29JgQ+V3kbdodOGIEWDsL2vFfsQnpf1ZYPil5bbjLDx2ctaD7P5mMecrVwdJwPvVUtNDy/WeOlSU+cAk9tcs3zqt7B94zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IP3QwUbRlaaXD99p/IiCne1lveJ2Hq3oPcSZbp0EAuU=;
 b=304pXtx/gB/WEuF0hwsvRIUoa/SlpA00hnwzDnNKFnDjnoIwV6oF9GS1aub81FLb/Pm7HsiFW/jrz5cm5wNbnoFka4ABNIroUqfVLRvifcIwz1v6UfLCNv8qwUIfexq/JZxffA3nauzd5NlkGcioEmkCMzMtucNCgD61bUN+YTA=
Received: from CO2PR07CA0069.namprd07.prod.outlook.com (2603:10b6:100::37) by
 BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 15:59:55 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:100:0:cafe::1) by CO2PR07CA0069.outlook.office365.com
 (2603:10b6:100::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Tue, 21 Jun 2022 15:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 15:59:54 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 10:59:52 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/MCE/AMD: Clear DFR errors found in THR handler
Date:   Tue, 21 Jun 2022 15:59:43 +0000
Message-ID: <20220621155943.33623-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13db9519-2c52-4e9f-9fcb-08da539f150c
X-MS-TrafficTypeDiagnostic: BN9PR12MB5338:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB5338D6887E6708859FE51775F8B39@BN9PR12MB5338.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jcxLIqrA/qQQmQMvaTJAnli2YTPV2mIm3fCO8Yv0TupBRX7ZjQVs0jFmBspgn6uFaxQd5TfysVx1SXA62c/dk1Q2ET/RVh9eWn/QK/b5gfYMtUN9k1YWotUnQhDcWMCN2dSmHEQQRQQeb0Ja9B0K5dU6f+SrPTB3Cq8kNIxde2oMlzXNwGcmbYrfXRwI2wxNmhzuNfJ53NXPvXLrOeflbcNGVmGPnyJzkT8lYyBxZgpWctYZ2piIdREoKMf3Bx/TPvunZ8cBhlQONedgjyUxlPd6Z/6VzhsyhE/wXYpubTZlqElZkJTCsV+hyzHDBZ0Y0pspJevcp050aRfnGr7pks+/USQjeMsnIb5nst4e94zlK3Kpu1qTIc3AVsFcaHu2k5r2JolyFnKsXjtZncOisUbub7rjBcscvpB+Tr9FVoCPYExcEM3iA0vIK/lEXfQTRbXJ7WlF+md8hE09WuHw6uUWPp/z3BUhfI3B4DIGe901NrtrW9QEjN54C/r63aF/pMknxajGsUfDANFNzsLMvu12yV1jq9/BXoLTFYO+INo+KRUfltgeVLNeqQtGss+868CuK71a0h5ZzJ7/yw0D6T4zesz7fb9iHAwW6utDnwiOYgSi4/pAuiwMpHLSHSPa57JzTVj970CxXZNbjBXjoverki+Pomle0daAZYCioZpxeIv04YFTx6QgUumGLfBiYhjCtgkuvX7FP+2B+IpCJd6ceyLNrzX9hWT/Wb0rOn98B0D2wVZVBcwMcAjdgMos
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(2616005)(16526019)(40480700001)(47076005)(336012)(83380400001)(70206006)(426003)(2906002)(82310400005)(1076003)(186003)(316002)(8676002)(70586007)(4326008)(54906003)(8936002)(86362001)(5660300002)(36860700001)(6916009)(7696005)(478600001)(44832011)(26005)(81166007)(40460700003)(82740400003)(356005)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 15:59:54.2526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13db9519-2c52-4e9f-9fcb-08da539f150c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

AMD's MCA Thresholding feature counts errors of all severites not just
correctable errors. If a deferred error causes the threshold limit to be
reached (it was the error that caused the overflow), then both a
deferred error interrupt and a thresholding interrupt will be triggered.

The order of the interrupts is not guaranteed. If the threshold
interrupt handler is executed first, then it will clear MCA_STATUS for
the error. It will not check or clear MCA_DESTAT which also holds a copy
of the deferred error. When the deferred error interrupt handler runs it
will not find an error in MCA_STATUS, but it will find the error in
MCA_DESTAT. This will cause two errors to be logged.

Check for deferred errors when handling a threshold interrupt. If a bank
contains a deferred error, then clear the bank's MCA_DESTAT register.

Define a new helper function to do the deferred error check and clearing
of MCA_DESTAT.

Fixes: 37d43acfd79f ("x86/mce/AMD: Redo error logging from APIC LVT interrupt handlers")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/amd.c | 37 +++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 1c87501e0fa3..ab1145cf8328 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -788,6 +788,28 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
 	return status & MCI_STATUS_DEFERRED;
 }
 
+static bool _log_error_deferred(unsigned int bank, u32 misc)
+{
+	bool defrd;
+
+	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
+				mca_msr_reg(bank, MCA_ADDR), misc);
+
+	if (!defrd)
+		return false;
+
+	/*
+	 * Non-SMCA systems don't have MCA_DESTAT/MCA_DEADDR registers.
+	 * Return true here to avoid accessing these registers.
+	 */
+	if (!mce_flags.smca)
+		return true;
+
+	/* Clear MCA_DESTAT if we logged the deferred error from MCA_STATUS. */
+	wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
+	return true;
+}
+
 /*
  * We have three scenarios for checking for Deferred errors:
  *
@@ -799,19 +821,8 @@ _log_error_bank(unsigned int bank, u32 msr_stat, u32 msr_addr, u64 misc)
  */
 static void log_error_deferred(unsigned int bank)
 {
-	bool defrd;
-
-	defrd = _log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS),
-				mca_msr_reg(bank, MCA_ADDR), 0);
-
-	if (!mce_flags.smca)
-		return;
-
-	/* Clear MCA_DESTAT if we logged the deferred error from MCA_STATUS. */
-	if (defrd) {
-		wrmsrl(MSR_AMD64_SMCA_MCx_DESTAT(bank), 0);
+	if (_log_error_deferred(bank, 0))
 		return;
-	}
 
 	/*
 	 * Only deferred errors are logged in MCA_DE{STAT,ADDR} so just check
@@ -832,7 +843,7 @@ static void amd_deferred_error_interrupt(void)
 
 static void log_error_thresholding(unsigned int bank, u64 misc)
 {
-	_log_error_bank(bank, mca_msr_reg(bank, MCA_STATUS), mca_msr_reg(bank, MCA_ADDR), misc);
+	_log_error_deferred(bank, misc);
 }
 
 static void log_and_reset_block(struct threshold_block *block)
-- 
2.25.1


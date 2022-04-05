Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4A54F5341
	for <lists+linux-edac@lfdr.de>; Wed,  6 Apr 2022 06:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiDFEH0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Apr 2022 00:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573254AbiDESew (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 5 Apr 2022 14:34:52 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6891513F81;
        Tue,  5 Apr 2022 11:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar5DTNrfsVDpzJ18qat7gw05iLeMuePCjNwY0DPcmmmaJyXcRcaJanXQyXARWRzX2vxPRQDLYZQZVyHADmHj7jcY7qIwVf3E5Ec/O5i2JBhswKXlp+T4p8vEkBL99JLiyNfUHMlFHAN85U71ZLluxPyeEh68pNYbK2Xy/Fu0Zlv4aDWP3+L+aefHVlZnU4YgIGuu5xTNEVqETiMroyhMoqxcW2mTI21DASq2eoP4/RCdb3c1afRAsJfG9TiZU/v7JZYBgCyVqaxzYGXncyF1ho0avPiuqU6iWEM9Do0HzpMrLA51dzyVOKH6c8eqcaR15J/ZQ41dFfknrTWBnfkQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XvWXcsd/ooj2GETJGzB2GyQWI/90H3qlgjd33qld+c=;
 b=W8Y3A0N9V649sOL46bs1P+fg3kVnuE7JDrBAy5qrdfA8Oe74soi7vtouGH4SZW1Foeh81tM0Yt94nZlAERKeU/DWyD2lsi86Ok0dPkSHKpUABg09vXf49YZlBB93EQiyvy+YPihWhnXcGCFYf4Euvu1+igDSPEqVdAtvL3NmxnqHul7JFt1F5DEHfT3Z/LhBorWAkCxw/U5vdaMojbSiXpCqvyNGI2RBSAQxXeCUwR3IFvcyRUfks+Cj1qRpdyAX+JgD9BZ7roN04Y23pnEoIkvjmRnyIVEp5ts2al333l93+ovmMNkl3hCcR6R6s2SHfIfZ/bw7b0fL6EZiOVTJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XvWXcsd/ooj2GETJGzB2GyQWI/90H3qlgjd33qld+c=;
 b=LvMi6IC8D6uHyD1SVPu5PqSHTw0pfgWy/O8KQEHInF6P5VaJWeEGYHHw8GijqtEf33uvQGDY9MLjM0biMqfp4kFolPgJIXz1/xxtShIYljEArh1z4AdeTsptiW4VEpKG4Zi6uzmvgQUVfbbUNvNYq+Te8sG7kRx0MAN67y2vOoE=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by MN2PR12MB3934.namprd12.prod.outlook.com (2603:10b6:208:167::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 18:32:51 +0000
Received: from BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::f0) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Tue, 5 Apr 2022 18:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT065.mail.protection.outlook.com (10.13.177.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Tue, 5 Apr 2022 18:32:50 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 5 Apr 2022 13:32:50 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>, <yazen.ghannam@amd.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <bilbao@vt.edu>, Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 2/2] x86/mce: Add messages for panic errors in AMD's MCE grading
Date:   Tue, 5 Apr 2022 13:32:14 -0500
Message-ID: <20220405183212.354606-3-carlos.bilbao@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 52dd1b1f-a28e-4436-3879-08da1732b0eb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3934:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB393454F781F13B3AFE2C80C4F8E49@MN2PR12MB3934.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SG2SV/JYvAuZTr5hhPvombDGGcU1RMermtJEQghiBZZnEnZcBXeShw4ayQBjBlm3hjHToMTwNPEnUO0EgsfCwDUn+ipnrDomEfjAbP+flH8f+WNGtLqOw2477Lyhx8MFauSSs1NAMTlunM+HTnJyPSkMcp1mXrCak6CQhtRoewwKWB6FJ1xuc/Kb/C2r8/oMvPc3Pla3BPbK8O5hgCTaqyt+9we7UsGazExSWrh0tVBd1zbzIjmPyf2PSBoMM5VkM9JJbK15MvMzMfL0to59wwaWwCKJsGEf1SLBNA2tApPtRGFhxJAYfvv44x6a/Zn3tJUPRg93ltEjmXjFN/f485x7RhYm36TGyBvF2TxP/ZewtWg9xuiQXIhlu9vzsVBfbKW7vr4tL3RNwQaa9P8wRyLZF++WwkiNbzPHqXo1dHcZsr5ZeqrBPs/ZeFY0afHTbxqv0xHfLOrCA90yOCcRPMucWT4HF6hcmY7QsaPqjjkaJ51rSWL3+56T0s+CUbZy4Nx2yPXe+IKpzU21UecasDDblxg4DZ6u0ZC8RCbMuk2q9F7aGkuDjt4FUNoC6IicXgjPakeKLyl/pAsHXgb5ZyjB9wBuXWXech4AZ8oJEcgXJM5GnBk3DW5U3WlObj3HHPNVofENJHPPZIpcRVIyghSG25zTcEuAqhgJtFVWUaiWM1tVIUblvTk4Jm3E7RzAbBM0ldnLv6LCaiN/7anTGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6636002)(40460700003)(15650500001)(47076005)(110136005)(54906003)(8676002)(83380400001)(508600001)(8936002)(86362001)(316002)(2906002)(4326008)(44832011)(81166007)(356005)(26005)(82310400005)(1076003)(7696005)(16526019)(186003)(2616005)(70586007)(36860700001)(70206006)(426003)(5660300002)(336012)(6666004)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 18:32:50.9730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dd1b1f-a28e-4436-3879-08da1732b0eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3934
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
 arch/x86/kernel/cpu/mce/severity.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 25aec5a27899..c09fa4f01616 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -306,6 +306,7 @@ static noinstr int error_context(struct mce *m, struct pt_regs *regs)
  */
 static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **msg, bool is_excp)
 {
+	char *panic_msg = NULL;
 	int ret;
 
 	/*
@@ -316,6 +317,7 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC) {
+		panic_msg = "Processor Context Corrupt";
 		ret = MCE_PANIC_SEVERITY;
 		goto out_amd_severity;
 	}
@@ -339,20 +341,27 @@ static noinstr int mce_severity_amd(struct mce *m, struct pt_regs *regs, char **
 	 * system will not be able to recover.
 	 */
 	if ((m->status & MCI_STATUS_OVER) && !mce_flags.overflow_recov) {
+		panic_msg = "Overflowed uncorrected error without MCA Overflow Recovery";
 		ret = MCE_PANIC_SEVERITY;
 		goto out_amd_severity;
 	}
 
 	if (!mce_flags.succor) {
+		panic_msg = "Uncorrected error without MCA Recovery";
 		ret = MCE_PANIC_SEVERITY;
 		goto out_amd_severity;
 	}
 
-	if (error_context(m, regs) == IN_KERNEL)
+	if (error_context(m, regs) == IN_KERNEL) {
+		panic_msg = "Uncorrected unrecoverable error in kernel context";
 		ret = MCE_PANIC_SEVERITY;
+	}
 
 out_amd_severity:
 
+	if (msg && panic_msg)
+		*msg = panic_msg;
+
 	return ret;
 }
 
-- 
2.31.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DABE505DA4
	for <lists+linux-edac@lfdr.de>; Mon, 18 Apr 2022 19:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347215AbiDRRrn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 18 Apr 2022 13:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347210AbiDRRrm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 18 Apr 2022 13:47:42 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2088.outbound.protection.outlook.com [40.107.95.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA8766B;
        Mon, 18 Apr 2022 10:45:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuKMf5kdWRsC0VRrmwiL1cNvMD8AhBC01s5aVIxyl9rl7Awa3Njx8/67hxgBqTZ/rE442ori72dIKwGW4Qju2zk0edwM9B1vnQFDadDKepNclYCWUdzg5L0pN8UhpYIxuS78RoZlQ+yY/wrUNkworqj46Fl7prnzf/PJndtjFMzyYXzX0DAq7ri2DneER/qRDtIwsHS4f8lEaaZBcS6fYSm2bwEnTkiXS2ZzXrJZaeDjwrajTyFADr5IMuBlMUY+pNKl4NcrLa/qV4bjQZyA5NXiLlzxv4oQwFWCs/lRG9p0xLp2hq9wyjocGGobvEc3w1jXsOryigkoU8v+8K7+Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gIChpC7HV36n0xWQYmCOdNrAC+EcF1BAsYkj1cVRmVo=;
 b=himiimoI8Mn1s4kx/jH087tmseFJa7MM8feu65mJPxstPFYhtfkeTlrqEIi7IOUJRAwE03IPeIhVkKyusXyhjJv2cbQGeuIdhhGWAB49Glz/KHzFLBFUMR7f2djmhJjvrtskmH4b1b9faZuR72RrufGXedkKOs4nSzHffQSePZnmD+EH1sKdPn6paLGf8zoDLEaJUbnKFjEOGWicvsCE84ZbExRvjw6iiuuyzLeExgXgAQIMHB73dZ1XECm9Swl3p5lNSqQ7Th+K+tuLvCF38GfLkStidLim2qwz5jsD48Pkp5qiv1V7vtnPDtHeUcpCQqAh0+meLkFJu9uCQkU02w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gIChpC7HV36n0xWQYmCOdNrAC+EcF1BAsYkj1cVRmVo=;
 b=fy109sK1MBtMrijUHhgFbsQ2mknCm0UnNDaRpbnB0d0hulCCjbvpovNRmzqNeXKPVsGmAQh/ADRqbS+Ynu+VApQyXmDOvE3A/pnUeO9hkC4yflT6O40fMX1pXly262Eqoa5FVUWJgL5y5rBMpsdqfyTxgRfmqq1r/vjHiws8GPA=
Received: from MW4PR03CA0052.namprd03.prod.outlook.com (2603:10b6:303:8e::27)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 17:44:59 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::d8) by MW4PR03CA0052.outlook.office365.com
 (2603:10b6:303:8e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20 via Frontend
 Transport; Mon, 18 Apr 2022 17:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5164.19 via Frontend Transport; Mon, 18 Apr 2022 17:44:58 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Apr
 2022 12:44:57 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/3] x86/MCE/APEI: Handle variable register array size
Date:   Mon, 18 Apr 2022 17:44:39 +0000
Message-ID: <20220418174440.334336-3-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418174440.334336-1-yazen.ghannam@amd.com>
References: <20220418174440.334336-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74791122-840d-4458-2a16-08da21632839
X-MS-TrafficTypeDiagnostic: MN2PR12MB4374:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB43742815A7715132B1A8CBB3F8F39@MN2PR12MB4374.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOyAGwzZcIKTByD8NHHVWVWT7nn7hGvzHAEIFYlzeLn9PcP12vJPLrQ7A1fbBxqvFGR36Y+laW+uyf+T23hFqw0axZc3QdE9i9f5suShECnxtP5fUlQOMs2sSBnJJMMzO3j3Hog+lW1tsIfEUG08sn+6JGAoEOLqYunWR9afDzGbkLFra7Ow2ijbvBwFylojhsINcyjnaCtq5AlUwpMDvJBd4ihmxlLrtVVGm5yMeO2+Hgc5+JswofApB/I00gUGFHJCHFdDU2FGGtK+bwE+sHZaS7eoygOGxEBIZC2+ePlNcrH5DOHZepygu4Lk4CLFmtuIReZTcEI8pVx6kMnBus1+4L1Wg0OaukQ8XFtonWJBr3pEqLRaMdtKP9A647lBkEhtxbRm6bAevZbKwIZJjNaWIx/GREgyZRKhbChAbB7shL8U37RNLP9T3S/qVI3NJpkj++u7J6wNXw6qjQQcrdkSOPKoX7rnre4MdIDBZOp/5whpp8k7WakW4ZywTWHce+0/szkNAabAPrrkkSgM3yTmjRNUsxcu6LeMDof1+LcZUICMuVayoSETZXSreyfzHy1BeN3LPqICxA4/0+GT+pqpRfuk1ByPoxz+/hPmE09U+wyt5P848z9Dl0QGfbj4rxTEVmlEBqNv/DzWpN1/BgfoZM6O8LWZxOtty5mmP6VQn4NWCw2eOoTd6dTTQkK872NN+N4cL7rG/aLD0KteXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(2616005)(83380400001)(8676002)(1076003)(4326008)(70206006)(70586007)(82310400005)(6666004)(8936002)(26005)(36756003)(16526019)(186003)(44832011)(426003)(336012)(5660300002)(7696005)(508600001)(356005)(2906002)(81166007)(54906003)(6916009)(316002)(47076005)(40460700003)(36860700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 17:44:58.4785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74791122-840d-4458-2a16-08da21632839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Recent AMD systems may provide an x86 Common Platform Error Record
(CPER) for errors reported in the ACPI Boot Error Record Table (BERT).
The x86 CPER may contain one or more Processor Context Information
Structures. The context structures may represent an x86 MSR range where
a starting address is given, and the data represents a contiguous set of
MSRs starting from, and including, the starting address.

It's common, for AMD systems that implement this behavior, that the MSR
range represents the MCAX register space used for the Scalable MCA
feature. The apei_smca_report_x86_error() function decodes and passes
this information through the MCE notifier chain. However, this function
assumes a fixed register size based on the original HW/FW
implementation.

This assumption breaks with the addition of two new MCAX registers:
MCA_SYND1 and MCA_SYND2. These registers are added at the end of the
MCAX register space, so they won't be included when decoding the CPER
data.

Rework apei_smca_report_x86_error() to support a variable register array
size. This covers any case where the MSR context information starts at
the MCAX address for MCA_STATUS and ends at any other register within
the MCAX register space.

Add code comments indicating the MCAX register at each offset.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/apei.c | 73 +++++++++++++++++++++++++++-------
 1 file changed, 59 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 0e3ae64d3b76..7510cd88f7eb 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
-	unsigned int cpu;
+	unsigned int cpu, num_registers;
 	struct mce m;
 
 	if (!boot_cpu_has(X86_FEATURE_SMCA))
@@ -74,16 +74,12 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 		return -EINVAL;
 
 	/*
-	 * The register array size must be large enough to include all the
-	 * SMCA registers which need to be extracted.
-	 *
 	 * The number of registers in the register array is determined by
 	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
-	 * The register layout is fixed and currently the raw data in the
-	 * register array includes 6 SMCA registers which the kernel can
-	 * extract.
+	 * Ensure that the array size includes at least 1 register.
 	 */
-	if (ctx_info->reg_arr_size < 48)
+	num_registers = ctx_info->reg_arr_size >> 3;
+	if (!num_registers)
 		return -EINVAL;
 
 	mce_setup(&m);
@@ -101,12 +97,61 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 
 	m.apicid = lapic_id;
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
-	m.status = *i_mce;
-	m.addr = *(i_mce + 1);
-	m.misc = *(i_mce + 2);
-	/* Skipping MCA_CONFIG */
-	m.ipid = *(i_mce + 4);
-	m.synd = *(i_mce + 5);
+
+	/*
+	 * The SMCA register layout is fixed and includes 16 registers.
+	 * The end of the array may be variable, but the beginning is known.
+	 * Switch on the number of registers. Cap the number of registers to
+	 * expected max (15).
+	 */
+	if (num_registers > 15)
+		num_registers = 15;
+
+	switch (num_registers) {
+	/* MCA_SYND2 */
+	case 15:
+		m.synd2 = *(i_mce + 14);
+		fallthrough;
+	/* MCA_SYND1 */
+	case 14:
+		m.synd1 = *(i_mce + 13);
+		fallthrough;
+	/* MCA_MISC4 */
+	case 13:
+	/* MCA_MISC3 */
+	case 12:
+	/* MCA_MISC2 */
+	case 11:
+	/* MCA_MISC1 */
+	case 10:
+	/* MCA_DEADDR */
+	case 9:
+	/* MCA_DESTAT */
+	case 8:
+	/* reserved */
+	case 7:
+	/* MCA_SYND */
+	case 6:
+		m.synd = *(i_mce + 5);
+		fallthrough;
+	/* MCA_IPID */
+	case 5:
+		m.ipid = *(i_mce + 4);
+		fallthrough;
+	/* MCA_CONFIG */
+	case 4:
+	/* MCA_MISC0 */
+	case 3:
+		m.misc = *(i_mce + 2);
+		fallthrough;
+	/* MCA_ADDR */
+	case 2:
+		m.addr = *(i_mce + 1);
+		fallthrough;
+	/* MCA_STATUS */
+	case 1:
+		m.status = *i_mce;
+	}
 
 	mce_log(&m);
 
-- 
2.25.1


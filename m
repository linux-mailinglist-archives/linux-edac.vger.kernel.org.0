Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A76C4BFDF8
	for <lists+linux-edac@lfdr.de>; Tue, 22 Feb 2022 17:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiBVQAa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 22 Feb 2022 11:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiBVQA3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 22 Feb 2022 11:00:29 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C57163073;
        Tue, 22 Feb 2022 07:59:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9eyvJT1EjW8UXS0BOlVtkUQAbjut74O0Av4JMAhKe33tYrAjsHvqcws0n0mKKpjbwU3Yz00b+tNohaNx3feipC+sB84QSOfjYk0iPS/IoVa/UMtdY7xqHFOUv2ab6xzw4117YTrKNtofqpTD7k6wACYjMiNKdyU0+CQUE1ph6yJHnTQY5nL1WXftuiKKtgI9XxSaw9MrfMsKL3RV1WuuZTfIwdrurorqBLRPCZw8iuDHVlRGJd5LyTfH6IH6keBshvn9FRV4bOWFX5P3BSPyxWFqGcgoSU3YOta/lYrVzyfv6y6BJ4OsOnGZMDOUVUJlFIEo59N5DtL+bOU5/rcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWOOiUxWAiLtmWdSoudeV/JlGU7/Jk7CAlLEalJlTJI=;
 b=U7YDeThD4s+VOERXft0nYZqiuW/leS/LrjEuE5XPLReDMWVluHjBrwiGWEgk3M6LI+/bVf3OQdCckm9LUnr4tQKCQ+unpyVfCCLPbuYakUBUAEIO0FVzEg9gAfRyUf4yPenXUEhUJtBpqwqgU65O95l0NpEXJOhanHrodFTi4yWmF9LgDZusMVOiLIDfwYDV72EgFYbjvIO+2TJ2/qvU5Ts5YlkBFv0CAfCmJ39GisCIvoa3lZe4e7vdv0h4uh3aCcYg4jfyMORswZXxWdHl4ZR0XnJlxqthNFbseslSmpR2Vxp/Wwq3iHq4+qYDFELxVbFTGCfdBKVce4dxVdIdaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWOOiUxWAiLtmWdSoudeV/JlGU7/Jk7CAlLEalJlTJI=;
 b=sbGoGQ4RTm9TPwl6o0kZLBQR1jHNdWnYjazyq/18xy2TCZfv5o7JgTlTr7PLH04Ae0yLEr5WbvQXh2/VwwU44swF02uqG/ejDgGAW+ruRLbDgW5vO5HKRftxmwg/BPNQ59ugG55ahl0AMYnlqRMjLGEDV+pdB2qaOzSo5oUSayI=
Received: from DM3PR03CA0008.namprd03.prod.outlook.com (2603:10b6:0:50::18) by
 MN2PR12MB4344.namprd12.prod.outlook.com (2603:10b6:208:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Tue, 22 Feb
 2022 15:59:54 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::c2) by DM3PR03CA0008.outlook.office365.com
 (2603:10b6:0:50::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22 via Frontend
 Transport; Tue, 22 Feb 2022 15:59:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 15:59:53 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 22 Feb 2022 09:59:43 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>, <tony.luck@intel.com>, <bp@suse.de>
CC:     <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH] x86/mce: Simplify CPU vendor checks for AMD/Hygon and Intel/Zhaoxin
Date:   Tue, 22 Feb 2022 09:58:58 -0600
Message-ID: <20220222155857.276286-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce84cd6a-9446-4299-67fd-08d9f61c5d9a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4344:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4344588DF12FB5DA492A4B9CF83B9@MN2PR12MB4344.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkPOMdV1QMJsVEitMvdj90am/Ub3vsWKBzXEh3NFvMQ8VFCYS5dXgsuAySY1msCEQd3l4aHM1gojoTGDVqbyCvokdvDCH01aOnc/5O8ibFih4/uHWAwZvzFbnb7jG2lp2Vm7NwvJEZ/AhEgNWKXrpw1NhCP2Lb7ZkR+uRlf7GjVaWSSXBnOxCQ36IXtfk8je7q9CvSXhR+QzSF2l9ts5Bp4eOKP96/KJUpOBiELTLQg3x83SuxFqM/rOFLm1QfJ/+EzpnIPiiVG2kEirVGK+lB+wImrS1vXoAfLejWT7VMCH+IJskSdh7wa91F9i6/2wq3D00Z557XfKVnHap6PMjR5ElGY3GpVNopPMfDqDpx8qqgNJ/k46IGIJwONs9vKtlGRquo0xGjwKxRBn5VwVMA1jEz2bewKaiNoGYaQW4nQxNiwOJd0pr+WEw937B4ewwbh/9iKusgx6YKvPGHPlNQZ8uV2RW+qBmhSLzMCYe3de52HUXcU1QQRl0JePzL4fdNBV4QKHCZg4ArvR6qrSlPqSIT1LbOo3LQHZElXTySABFo0uEYNjPNg4NFEk8hVidtogwyaxEJ7oVePvWgZ9PhHwP9qqIGbmIK75mx3mMD9jOAeJRgO2mOU9OV9WtmVCWfMr+eeYuXghcTwhXgbtrcujPZdIFvSl4Fst63hn1FUoUJ2Psj1TR6QuQsEMxDJdsb4XMp+QhqAsdDyCupe+rDHgI7ggDJImCL7XBiZ9Xvd1NHhKaZs3/ob1AgmJqdpq
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(70586007)(336012)(36860700001)(36756003)(356005)(44832011)(26005)(2906002)(70206006)(426003)(81166007)(186003)(83380400001)(16526019)(5660300002)(316002)(2616005)(86362001)(82310400004)(8936002)(1076003)(54906003)(8676002)(4326008)(6666004)(7696005)(110136005)(508600001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 15:59:53.8459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce84cd6a-9446-4299-67fd-08d9f61c5d9a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4344
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In a number of places across the MCE subsystem we check if we are running
an x86 processor from AMD/Hygon or Intel/Zhaoxin vendors. Simplify these
checks with two mce_flags updated at CPU MCE initialization.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 22 ++++++++--------------
 arch/x86/kernel/cpu/mce/intel.c    |  3 +--
 arch/x86/kernel/cpu/mce/internal.h |  8 +++++++-
 arch/x86/kernel/cpu/mce/severity.c |  3 +--
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5818b837fd4d..d88c7ba7f67a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -241,7 +241,7 @@ static void print_mce(struct mce *m)
 {
 	__print_mce(m);
 
-	if (m->cpuvendor != X86_VENDOR_AMD && m->cpuvendor != X86_VENDOR_HYGON)
+	if (!mce_flags.amd_compatible)
 		pr_emerg_ratelimited(HW_ERR "Run the above through 'mcelog --ascii'\n");
 }
 
@@ -503,8 +503,7 @@ int mce_usable_address(struct mce *m)
 		return 0;
 
 	/* Checks after this one are Intel/Zhaoxin-specific: */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
+	if (!mce_flags.intel_compatible)
 		return 1;
 
 	if (!(m->status & MCI_STATUS_MISCV))
@@ -562,10 +561,7 @@ static bool whole_page(struct mce *m)
 
 bool mce_is_correctable(struct mce *m)
 {
-	if (m->cpuvendor == X86_VENDOR_AMD && m->status & MCI_STATUS_DEFERRED)
-		return false;
-
-	if (m->cpuvendor == X86_VENDOR_HYGON && m->status & MCI_STATUS_DEFERRED)
+	if (mce_flags.amd_compatible && m->status & MCI_STATUS_DEFERRED)
 		return false;
 
 	if (m->status & MCI_STATUS_UC)
@@ -1450,8 +1446,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 	 * Check if this MCE is signaled to only this logical processor,
 	 * on Intel, Zhaoxin only.
 	 */
-	if (m.cpuvendor == X86_VENDOR_INTEL ||
-	    m.cpuvendor == X86_VENDOR_ZHAOXIN)
+	if (mce_flags.intel_compatible)
 		lmce = m.mcgstatus & MCG_STATUS_LMCES;
 
 	/*
@@ -1910,7 +1905,9 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
 		mce_flags.succor	 = !!cpu_has(c, X86_FEATURE_SUCCOR);
 		mce_flags.smca		 = !!cpu_has(c, X86_FEATURE_SMCA);
 		mce_flags.amd_threshold	 = 1;
-	}
+		mce_flags.amd_compatible = 1;
+	} else if (c->x86_vendor == X86_VENDOR_INTEL || c->x86_vendor == X86_VENDOR_ZHAOXIN)
+		mce_flags.intel_compatible = 1;
 }
 
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
@@ -2277,10 +2274,7 @@ static void vendor_disable_error_reporting(void)
 	 * the socket like the last level cache (LLC), the integrated memory
 	 * controller (iMC), etc.
 	 */
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_ZHAOXIN)
+	if (mce_flags.intel_compatible || mce_flags.amd_compatible)
 		return;
 
 	mce_disable_error_reporting();
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index bb9a46a804bf..169064fa12a9 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -85,8 +85,7 @@ static int cmci_supported(int *banks)
 	 * initialization is vendor keyed and this
 	 * makes sure none of the backdoors are entered otherwise.
 	 */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
+	if (!mce_flags.intel_compatible)
 		return 0;
 
 	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 52c633950b38..562c768ceaf5 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -170,7 +170,13 @@ struct mce_vendor_flags {
 	/* SandyBridge IFU quirk */
 	snb_ifu_quirk		: 1,
 
-	__reserved_0		: 57;
+	/* CPUs are from AMD or Hygon */
+	amd_compatible		: 1,
+
+	/* CPUs are from Intel or Zhaoxin */
+	intel_compatible	: 1,
+
+	__reserved_0		: 55;
 };
 
 extern struct mce_vendor_flags mce_flags;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 7aa2bda93cbb..21aa31bd17a2 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -423,8 +423,7 @@ static noinstr int mce_severity_intel(struct mce *m, struct pt_regs *regs,
 int noinstr mce_severity(struct mce *m, struct pt_regs *regs, int tolerant, char **msg,
 			 bool is_excp)
 {
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+	if (mce_flags.amd_compatible)
 		return mce_severity_amd(m, regs, tolerant, msg, is_excp);
 	else
 		return mce_severity_intel(m, regs, tolerant, msg, is_excp);
-- 
2.27.0


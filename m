Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC60546D37
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jun 2022 21:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346491AbiFJTZg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jun 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241580AbiFJTZd (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 10 Jun 2022 15:25:33 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3D41B1994;
        Fri, 10 Jun 2022 12:25:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DutfFkL4zrCO2BuiqjQYxnfzJrN5gH108LVk/X0Xu7HteECVXnAZMO4seTEjrsHEva1iVwRV9Fl0BHqj37nFSL426K+WiUTaDfCH4FfcAMjMbf1LjxpAfPzKsanpgPP/6Gm4lXraKybydBVy6dlfllZwGaSowicgxWFTot1WKggilkZ6X/7fDc2b9831EGdk/Z71mUB1aIGnZmBI7uB+gBI7LxQVweJWr1eNdj4bEyB+g0F3TaWWyTJb8xtJwQ2sC81lKFZlHr0JBCJ1TinF2dLUgF1n6RLqJpFCDMoD3ZmHq2rjuqre/TQHOrWv6863hIb04hYnaFEcGrji8VTM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeatT6JL6A31aLzAF0SkdgOX0N3zEa13oPHs6b5dDeg=;
 b=efvd7g+lWRmmBSo4R264P0wXtBNSU+MqzoW2gr9pvQjGylo8s2Y5wnBsAQvIICGBez0KsHevlHiExfpbPJfHj0oXIbZK8Vh+jNy5xoR0cadAskhB8fVWltn/zPbbDqNqpiMv62+ioZnrQ+D7RNDTwKqOY2Y+yU02GRL5iCkHRYYzsCwAIHoF9LfTYb9XwUgfkiZ7choHQvRGl7LTVasSHZm5ldhAQCXEymTKYQv5mSFGuPB1tQ4Swz5yLPU0JPkbn2No1W1AU7uPGAhqzFC23er1d1XOrFe7KovmqUp0v+fcDpAvst6/ablvZn0HXdvc61ZopbubZkxWxSkkYWGxdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EeatT6JL6A31aLzAF0SkdgOX0N3zEa13oPHs6b5dDeg=;
 b=2J/+QHNVHQxeJu82PNOjjHyFaRUVV40aQUygmVXcFPLZ0zOwFYEdw7IVlAfkkcWuboZ/oYsZWGnvUOcO6fnMWhkKSX1xe41XnZSV5JOO7DAF96PV6l7k9hb97L7cxEaRLVjbaSuO2B96FN9RrrDQQYdTIIYrNawhOBwXZylYuXg=
Received: from MWHPR19CA0074.namprd19.prod.outlook.com (2603:10b6:320:1f::12)
 by BL0PR12MB4737.namprd12.prod.outlook.com (2603:10b6:208:8d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Fri, 10 Jun
 2022 19:25:29 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:1f:cafe::18) by MWHPR19CA0074.outlook.office365.com
 (2603:10b6:320:1f::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Fri, 10 Jun 2022 19:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 19:25:28 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 14:25:27 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Yazen Ghannam" <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5] x86/mce: Check for writes ignored in MCA_STATUS register
Date:   Fri, 10 Jun 2022 19:25:15 +0000
Message-ID: <20220610192515.98540-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 421965ae-3d90-4652-2bd2-08da4b16fa86
X-MS-TrafficTypeDiagnostic: BL0PR12MB4737:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB4737E45CB1BC0C468D0E4C7490A69@BL0PR12MB4737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VshlL2BvHesT5ZcK5qATEFu9/WT1SIsXzut5t5Bz6PDmX9QFiFZ41e0/miYckrK/ITqytgsOWJ4tpFPHu/9JBXN2spnHB0sQo5dGGYcJL0qUbYVC+GQ6t6CrigVdRX2xHJ5d+Mav/NbRG574Z8stQYC0JZE3Ak3XjBpcml35dEFrM1EMFulYj/JXAFvSxD0b9kwSQNbTLfFNeJPUAf+1X5GgT0uZqr2qWUH+sujb2thawRt/o6AilgmsDERgcU5JGke/55cs03F6Tg3N+GIsUDe99M+nTOJJbxUBPGshnoU2/NFjZPMyElauIBiG9xv5aX7BKKiKh+6f+WVands9V+Twqmj/fYdVEGP1gBSaQYOC73slFBKgiWCc7XaYWZkExX4NOhop1YDdU0WwlCQMEWpNxAnk7lQ/oDUagM7oHG11EJxwgH+IGNqCFcLSGmYlaPhFc7Zi12Zljd6aumIM6dMQn5Fy4Mk4fToOFrN0UAejkMBljsNMILnEgbkMH/+tyt0cZsa7sEDjBwkWm0TrLsyg1dxA+KAoq/Q+PB4Cja2FN0hdD8aQCkk0QijNkVFC70mDnEBiF0lKjU20kunhtX0cAXxP1RpzJiIt2bkNCCzBHLQyUU7qQMTgoxxStJWRMXEZuxa1T+7SwHG3lD73vYyeigVTUV+ICQOiKvYmeBXij51NyJsUTU0I4SwiKwLPNPK9I5+fQKk7uqFxojEp0exFjO/P4A323x5dFYo+e7UlnLB0sEmphPToH1rt9hw6XZSSodkf1WNpqTmFzj/nVJqJEpqvlThdPwv5d7WPFM30dotEGScYd2ixq17iysp6XedYK5sthKudxOw7rMtW6vLR6MLxEy4hvhVbnfRDskI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(36756003)(356005)(82310400005)(70586007)(70206006)(8676002)(316002)(5660300002)(54906003)(81166007)(110136005)(4326008)(36860700001)(2906002)(7696005)(6666004)(26005)(336012)(86362001)(186003)(1076003)(8936002)(83380400001)(47076005)(16526019)(40460700003)(508600001)(966005)(426003)(2616005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 19:25:28.8932
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 421965ae-3d90-4652-2bd2-08da4b16fa86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4737
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

According to Section 2.1.16.3 under HWCR[McStatusWrEn] in "PPR for AMD
Family 19h, Model 01h, Revision B1 Processors - 55898 Rev 0.35 - Feb 5,
2021", the status register may sometimes enforce write ignored behavior
independent of the value of HWCR[McStatusWrEn] depending on the platform
settings.

Hence, evaluate for writes ignored for MCA_STATUS to determine if hardware
error injection is possible. Perform this evaluation early during module
init and store the result in the static "hw_injection_possible" variable.
Query this variable for subsequent error injections and limit checking for
MCA_STATUS only once on driver init.

Avoid exporting mce_flags into modules and check for smca feature from
'X86_FEATURE_SMCA' flag directly.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
Link:
https://lkml.kernel.org/r/20220214233640.70510-2-Smita.KoralahalliChannabasappa@amd.com
v2:
	msr_ops -> mca_msr_reg().
	simulation -> injection.
	pr_info() -> pr_err().
	Aligned on ",".
v3:
	Removed "x86/mce: Use mca_msr_reg() in prepare_msrs()" patch.
	and made changes on the existing MCx_{STATUS, ADDR, MISC} macros.
v4:
	Simplified the code by just checking for writes ignored behavior in
	MCA_STATUS register.
	Introduced prepare_mca_status() and performed writes ignored checks
	inside the function.
	Rephrased error message.
v5:
	Evaluated for writes ignored early and only once during module init.
	Introduced "hw_injection_possible" variable to store the result of
	writes ignored behavior of MCA_STATUS. This variable is checked
	before performing subsequent hw error injections.
---
 arch/x86/kernel/cpu/mce/inject.c   | 50 +++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/internal.h |  2 +-
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 5fbd7ffb3233..ac5582691530 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -33,6 +33,8 @@
 
 #include "internal.h"
 
+static bool hw_injection_possible = true;
+
 /*
  * Collect all the MCi_XXX settings
  */
@@ -339,6 +341,8 @@ static int __set_inj(const char *buf)
 
 	for (i = 0; i < N_INJ_TYPES; i++) {
 		if (!strncmp(flags_options[i], buf, strlen(flags_options[i]))) {
+			if (i > SW_INJ && !hw_injection_possible)
+				continue;
 			inj_type = i;
 			return 0;
 		}
@@ -376,7 +380,11 @@ static ssize_t flags_write(struct file *filp, const char __user *ubuf,
 
 	err = __set_inj(__buf);
 	if (err) {
-		pr_err("%s: Invalid flags value: %s\n", __func__, __buf);
+		pr_err("%s: Invalid flags value: %s: %s\n", __func__,
+			(!hw_injection_possible
+			  ? " (SW-only injection possible on this platform)"
+			  : ""),
+		       __buf);
 		return err;
 	}
 
@@ -501,6 +509,8 @@ static void do_inject(void)
 	unsigned int cpu = i_mce.extcpu;
 	u8 b = i_mce.bank;
 
+	pr_info("Using '%s' error injection method", flags_options[inj_type]);
+
 	i_mce.tsc = rdtsc_ordered();
 
 	i_mce.status |= MCI_STATUS_VAL;
@@ -717,11 +727,49 @@ static void __init debugfs_init(void)
 				    &i_mce, dfs_fls[i].fops);
 }
 
+static void check_hw_inj_possible(void)
+{
+	u8 bank;
+
+	/*
+	 * This behavior exists only on SMCA systems though its not directly
+	 * related to SMCA.
+	 */
+	if (!cpu_feature_enabled(X86_FEATURE_SMCA))
+		return;
+
+	get_cpu();
+
+	for (bank = 0; bank < MAX_NR_BANKS; ++bank) {
+		u64 status = MCI_STATUS_VAL, ipid;
+
+		rdmsrl(MSR_AMD64_SMCA_MCx_IPID(bank), ipid);
+
+		if (!ipid)
+			continue;
+
+		wrmsrl(mca_msr_reg(bank, MCA_STATUS), status);
+		rdmsrl(mca_msr_reg(bank, MCA_STATUS), status);
+
+		if (!status) {
+			hw_injection_possible = false;
+			pr_warn("Platform does not allow error injection, try using APEI EINJ instead.\n");
+		}
+
+		/* Exit after the check for first available MCA bank */
+		break;
+	}
+
+	put_cpu();
+}
+
 static int __init inject_init(void)
 {
 	if (!alloc_cpumask_var(&mce_inject_cpumask, GFP_KERNEL))
 		return -ENOMEM;
 
+	check_hw_inj_possible();
+
 	debugfs_init();
 
 	register_nmi_handler(NMI_LOCAL, mce_raise_notify, 0, "mce_notify");
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 4ae0e603f7fa..7e03f5b7f6bd 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -211,7 +211,7 @@ noinstr u64 mce_rdmsrl(u32 msr);
 
 static __always_inline u32 mca_msr_reg(int bank, enum mca_msr reg)
 {
-	if (mce_flags.smca) {
+	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		switch (reg) {
 		case MCA_CTL:	 return MSR_AMD64_SMCA_MCx_CTL(bank);
 		case MCA_ADDR:	 return MSR_AMD64_SMCA_MCx_ADDR(bank);
-- 
2.17.1


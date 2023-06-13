Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9757972E574
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jun 2023 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242463AbjFMONX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 10:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbjFMONP (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 10:13:15 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77121171D;
        Tue, 13 Jun 2023 07:12:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0+iO20cVOmgERwuUNwJYKKYuqHJPcowOK3cnjlqL5TNjqm0FPd+NgSskpPl+xfptCc2B661zm+UMdzoI7gT12cK32bPYsJWt6ootPRXHAN/LztrJGdFlCs4g9uGTXhvGfwo8gxKU/8F28lzZD6KkSHQKgKiB3jbmY8L5yzvQy5Gm6Y+8t17kF7ZBC03iXQm8KBvX9FTfyt8oDy1Hf5TCvy7heZgBNm3PRoo0LU7IF+B93UxXnHq1IPPb9Kt5pq3KPpX7AV3ytcFvl4CqT7tW/E4ID2lARk4vrDJtXRkVZwr+RD2Ibu0mXO1hV9ZkTaoBlNrcg3D1oLLJLayYjPNvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OknFUpUS6NV3oSK+Q5pt3OHk6ugygcYsNI6Yrx1Ldqc=;
 b=VGg38zn96HrqQzhYInZYhx+AZtX55svkU97doygYfuu/NnUZJV0s3JB3EynuCV53lEg+PzbW+82Y3a0GAiUFU69ZVS46EP5YSOkyXFhJ/OZbE2Ccvry3reI4GUxPkhDw76l53Irm9GiOIu2dqfJaErHoOt2Ihn75VuK4TetbVrdVGuM/14sGd+JvVVx0V316vbQSpCSayZkgcLY95hNNUfo4rGhBjbJhdmUtScDslFlEb4OfcWlQWKLevBqC7O0NOggIPXeAUPn1NQmgZiiCY5PwtbRfS+SQ+rsoI1HKuW60rePqdg4iLh3MGQw5w8A9HukBm78r1sQAU0yWi7eC3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OknFUpUS6NV3oSK+Q5pt3OHk6ugygcYsNI6Yrx1Ldqc=;
 b=oltlhZRwh9k58c3aip2hBs49s5PDXNek6B23RSuPitqgrd0RhErFn2AFtdqSZt7oD2fRDwhchixuc51julySkwJCScoyXzCNW99+D4J6UPnI4p75tOFS1lFJ3P0d9oTuMGZo4c05oiq9yrkQtVNJXUNFKL4qdA7Q+gMqtg6bHoA=
Received: from CY5PR15CA0235.namprd15.prod.outlook.com (2603:10b6:930:66::7)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.42; Tue, 13 Jun
 2023 14:12:40 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::1) by CY5PR15CA0235.outlook.office365.com
 (2603:10b6:930:66::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 14:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 14:12:40 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:12:37 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <muralidhara.mk@amd.com>,
        <joao.m.martins@oracle.com>, <william.roche@oracle.com>,
        <boris.ostrovsky@oracle.com>, <john.allen@amd.com>,
        <xueshuai@linux.alibaba.com>, <baolin.wang@linux.alibaba.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 3/3] x86/mce: Fixup mce_usable_address()
Date:   Tue, 13 Jun 2023 09:11:42 -0500
Message-ID: <20230613141142.36801-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613141142.36801-1-yazen.ghannam@amd.com>
References: <20230613141142.36801-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: eff67e79-7c29-47ca-82f6-08db6c183fb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iWmorLm9h0RpcA3WaU66TsHRwsmipw1dHH3kL0jk9/Zmb64a9r2/IaH2HWyLEt+xLujDj2W0xB3ruSHhXw/bXslRW5BYM523AxSdxv2ZbcC/WhQ+jZWT+trXpEd/8kbUfGs98pIP0KtZ0KdlPzf19mhIKE8nTQ+6PofYkJzg0cp2SDj2sVzZ3+41MTZiUxy1nvJCwCk3CD8MQov9NLB19U8/QAuxlclCin1LoUDnQ7yqNm2UKk1RRiTdiFjrbebfO6MDi3TRCRxTa1M9etfHP4WHbxT3yqcjJVQAX9I0uVcH/QCDtpkkttI4WATSsWQAfTyHiKuLVMjn4p8mEZUlQ8z+h1/iKI4ev5Cwl/77+Vj6h3Exr85AJ1Mdg3G+3hNIlRhFPbjKm6gabQobctBu37H+1w6GyYLiREYGQWZoFT8KrptbUuSJIepoCqNfYPamyLu1YMMKN8vEA9HviafrIRzuJMtsya9lyQ+4pR0CxAcl9cDyKlclZ3xuCbmy+QBlQOc74GCmhIIwHsZKqmFeZsz3tMvWGGm4G1GKrqv5Sd01FDY8vtXsgyLswVGs8ENZ3VbwejeRb6sk9aoY38Fo1iRVSD5+EmEzjMz3MAnKsG/5Dk6Fd22XiPUPE5jI4TDscr+dw/R580n0xohL7A2T5z8gxorN927B63C6rXKyU0iQB1AGm02WJSP6HfSkf6235HOieQJeRV+Nkz79glSmBFed8bAvbSsiIHmUMDkz/3MuZswFMQ7T0j9SmEocXJzvxKeZCT/laW2JQdn0H186Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(451199021)(40470700004)(36840700001)(46966006)(8936002)(8676002)(44832011)(5660300002)(4326008)(70586007)(70206006)(6916009)(316002)(54906003)(2906002)(41300700001)(36860700001)(40460700003)(6666004)(478600001)(7696005)(356005)(81166007)(40480700001)(426003)(336012)(36756003)(186003)(16526019)(83380400001)(1076003)(47076005)(2616005)(26005)(82740400003)(86362001)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:12:40.6100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eff67e79-7c29-47ca-82f6-08db6c183fb9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Move Intel-specific checks into a helper function.

Explicitly use "bool" for return type.

No functional change intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h         |  2 +-
 arch/x86/kernel/cpu/mce/core.c     | 33 +++++++++---------------------
 arch/x86/kernel/cpu/mce/intel.c    | 20 ++++++++++++++++++
 arch/x86/kernel/cpu/mce/internal.h |  2 ++
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 180b1cbfcc4e..6de6e1d95952 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -245,7 +245,7 @@ static inline void cmci_recheck(void) {}
 int mce_available(struct cpuinfo_x86 *c);
 bool mce_is_memory_error(struct mce *m);
 bool mce_is_correctable(struct mce *m);
-int mce_usable_address(struct mce *m);
+bool mce_usable_address(struct mce *m);
 
 DECLARE_PER_CPU(unsigned, mce_exception_count);
 DECLARE_PER_CPU(unsigned, mce_poll_count);
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 859ce20dd730..c17e2b54853b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -453,35 +453,22 @@ static void mce_irq_work_cb(struct irq_work *entry)
 	mce_schedule_work();
 }
 
-/*
- * Check if the address reported by the CPU is in a format we can parse.
- * It would be possible to add code for most other cases, but all would
- * be somewhat complicated (e.g. segment offset would require an instruction
- * parser). So only support physical addresses up to page granularity for now.
- */
-int mce_usable_address(struct mce *m)
+bool mce_usable_address(struct mce *m)
 {
 	if (!(m->status & MCI_STATUS_ADDRV))
-		return 0;
+		return false;
 
-	if (m->cpuvendor == X86_VENDOR_AMD)
+	switch (m->cpuvendor) {
+	case X86_VENDOR_AMD:
 		return amd_mce_usable_address(m);
 
-	/* Checks after this one are Intel/Zhaoxin-specific: */
-	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
-	    boot_cpu_data.x86_vendor != X86_VENDOR_ZHAOXIN)
-		return 1;
-
-	if (!(m->status & MCI_STATUS_MISCV))
-		return 0;
-
-	if (MCI_MISC_ADDR_LSB(m->misc) > PAGE_SHIFT)
-		return 0;
-
-	if (MCI_MISC_ADDR_MODE(m->misc) != MCI_MISC_ADDR_PHYS)
-		return 0;
+	case X86_VENDOR_INTEL:
+	case X86_VENDOR_ZHAOXIN:
+		return intel_mce_usable_address(m);
 
-	return 1;
+	default:
+		return true;
+	}
 }
 EXPORT_SYMBOL_GPL(mce_usable_address);
 
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 95275a5e57e0..56ecf128a534 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -519,3 +519,23 @@ bool intel_filter_mce(struct mce *m)
 
 	return false;
 }
+
+/*
+ * Check if the address reported by the CPU is in a format we can parse.
+ * It would be possible to add code for most other cases, but all would
+ * be somewhat complicated (e.g. segment offset would require an instruction
+ * parser). So only support physical addresses up to page granularity for now.
+ */
+bool intel_mce_usable_address(struct mce *m)
+{
+	if (!(m->status & MCI_STATUS_MISCV))
+		return false;
+
+	if (MCI_MISC_ADDR_LSB(m->misc) > PAGE_SHIFT)
+		return false;
+
+	if (MCI_MISC_ADDR_MODE(m->misc) != MCI_MISC_ADDR_PHYS)
+		return false;
+
+	return true;
+}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 0d4c5b83ed93..962b3134991d 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -49,6 +49,7 @@ void intel_init_cmci(void);
 void intel_init_lmce(void);
 void intel_clear_lmce(void);
 bool intel_filter_mce(struct mce *m);
+bool intel_mce_usable_address(struct mce *m);
 #else
 # define cmci_intel_adjust_timer mce_adjust_timer_default
 static inline bool mce_intel_cmci_poll(void) { return false; }
@@ -58,6 +59,7 @@ static inline void intel_init_cmci(void) { }
 static inline void intel_init_lmce(void) { }
 static inline void intel_clear_lmce(void) { }
 static inline bool intel_filter_mce(struct mce *m) { return false; }
+static inline bool intel_mce_usable_address(struct mce *m) { return false; }
 #endif
 
 void mce_timer_kick(unsigned long interval);
-- 
2.34.1


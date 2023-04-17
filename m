Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4446E4E22
	for <lists+linux-edac@lfdr.de>; Mon, 17 Apr 2023 18:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjDQQUZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 17 Apr 2023 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjDQQUW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 17 Apr 2023 12:20:22 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5B5BBAB;
        Mon, 17 Apr 2023 09:20:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmTe2xcbqvvHsZMed+uMiCjZ/GpZEsBVhsGIIkOWB+1j7ZQ3iOLj8A17MEidMQxCDUZtRNPTPpC7xBBJHIXzbIsqL+wSy1kFxb6NpKaY5aLjt+cSpaLjCYsTV1r1iqQxxPF2T4IjSKBUOUJM+YmjEjshLjQ5I0G9SOFoMtl0AlijuNZfRGbUmbLG9ueFAaGnQcEg0p8bwmHRxJRwZV6z7xLHcItTzdzQZ0SIFza3YydLEyWHeQ/LS3fb0j+93FNEXkNv9gpoRTE5E6elCaF4zFzXUSh5yA7lNoSCaYV4r3jyOsTqHItFeALUMDFUtgvmzMFujdj49R9d4eqTcA2WpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rXbNWqoHQVVOhENPCS8LPsH+PPNV3qqgVEdZ7MIjpQ=;
 b=FquI/lX73P+vQtWd8m0vCOfA2HMEkFZXqtRZpRoqCnTE5712kKS38USAEiAxrpjtPfjejmMWegi5HMOkJ01SO2RHOv37LA0o8lTABZPS8upMUYLeuywXZIopaXSUnS2cVnpHpSX9QyOwFKW8gunFZy4off0LXqJBtGKdTBlb3x97yrzHrCFs0TO8RffeDiwDnKP+Kwi3hKDWrnDyaMYVYdg+bO7lJ3PERirNXi3nPEA4h6TXjPb0p2vhJ95UfXjEK9U4y7kiTGARW/ulGIfS5U6YgvnRnb6xB2ji/02kujyVU4v+wP1f6IBPAB+SgRJLb7k7YxPjm3urrZ6U4194YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rXbNWqoHQVVOhENPCS8LPsH+PPNV3qqgVEdZ7MIjpQ=;
 b=EBvPRCipGxvq99rPJHqhQN3DStDI7RS1FdoLFgruFbbhEdYXiarbujOkXFgn2qUjkt2Dn/sorlhX0Ue1dMqYOkkZ802EH7gRZ6fzOQXW2FI1XSqaIfgtqovRKB6n4Js4aPv98xP9lN7SwtZxaF3jQg6kA9uyzJTHgvJoYoTg4V4=
Received: from BN0PR04CA0124.namprd04.prod.outlook.com (2603:10b6:408:ed::9)
 by MN6PR12MB8541.namprd12.prod.outlook.com (2603:10b6:208:47a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Mon, 17 Apr
 2023 16:20:17 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::f3) by BN0PR04CA0124.outlook.office365.com
 (2603:10b6:408:ed::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Mon, 17 Apr 2023 16:20:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.19 via Frontend Transport; Mon, 17 Apr 2023 16:20:16 +0000
Received: from ethanolx80b6host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 17 Apr
 2023 11:20:16 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH] x86/mce: Schedule mce_setup() on correct CPU for CPER decoding
Date:   Mon, 17 Apr 2023 16:20:06 +0000
Message-ID: <20230417162006.3292715-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|MN6PR12MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b50614-ac05-4361-89c1-08db3f5fa1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IxrNbZ4Q4Q7/jeEmdtRUSz482E9qyt/Z29hN9/y1zFnm/vWaX/yG0bR7gjcW6FvLmXb61426/ZDcniGhdTwzVtsIC2yzL5jeFlspqNe6K/YHuR6ACPLhvGEimfmkhm0XmRCJcIddwYJHmjU6kGqMdQVYWCqH/dk0rUCmdbZtUbihOmEbWm0YsEq190gROkHNZmRcSuzemNYgANVnHbwoeKsHsD2KzNfjbXO5wpb86rg+t/v9pmem4QEJNmii5i1cRHi/WMxAtF7c560/xAZa+oqo8rNkzj5QS+rens/L+jmHQH7CXRiPQMk3BvsRkVoue7gLmyj5uPcpkh0V+LiP+i6IwQ4Fae9grXwbZWtqV+SD/UfXzdHiWJtyZlVdo9l1n5hmczqpCx620psVTKEZTqxeNWKv6pSIP2sRLH4EsTxdUirDw0235KaI4+V6NGJc3gsiFvG/bvvRH5uZKLaAQ1Qgxu244KUYPoMurLGauUBk/g77CZ423hqBVItnezWTymwVHAfRqjzVTb2//Y72DfxzXjqL3mjfavmOs0rUrBC1lvoxY4RaV1zWF9MuOPKWlykHcim1DDiF3PFvoWGqwItM2pcP6BJzz1cM6H8QGhF3cpWBigUp3+uaoy5chMeQMSpOrqFDOIMesFD1BOSEAUsbCXl0zBX1WQ/CbZXhF5li/4AiXEdOB3X1ZW+S49AfZbS7x6Ohd11oGedYhEBKpH3at4tHOn14PDuWvFHcgUI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(46966006)(40470700004)(36840700001)(356005)(82740400003)(7696005)(6666004)(40460700003)(54906003)(2906002)(81166007)(478600001)(40480700001)(83380400001)(336012)(426003)(47076005)(16526019)(186003)(2616005)(1076003)(26005)(82310400005)(36860700001)(4326008)(5660300002)(316002)(44832011)(6916009)(70586007)(70206006)(86362001)(41300700001)(36756003)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 16:20:16.9470
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b50614-ac05-4361-89c1-08db3f5fa1ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8541
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Scalable MCA systems may report errors found during boot-time polling
through the ACPI Boot Error Record Table (BERT). The errors are logged
in an "x86 Processor" Common Platform Error Record (CPER). The format of
the x86 CPER does not include a logical CPU number, but it does provide
the logical APIC ID for the logical CPU. Also, it does not explicitly
provide MCA error information, but it can share this information using
an "MSR Context" defined in the CPER format.

The MCA error information is parsed by
1) Checking that the context matches the Scalable MCA register space.
2) Finding the logical CPU that matches the logical APIC ID from the
   CPER.
3) Filling in struct mce with the relevant data and logging it.

All the above is done when the BERT is processed during late init. This
can be scheduled on any CPU, and it may be preemptible.

This results in two issues.
1) mce_setup() includes a call to smp_processor_id(). This will throw a
   warning if preemption is enabled.
2) mce_setup() will pull info from the executing CPU, so some info in
   struct mce may be incorrect for the CPU with the error. For example,
   in a dual-socket system, an error logged in socket 1 CPU but
   processed by a socket 0 CPU will save the PPIN of the socket 0 CPU.

Fix both issues by scheduling mce_setup() to run on the logical CPU
indicated in the error record. Preemption is disabled when calling
smp_call_function_*() resolving issue #1. And the error info is gathered
from the proper logical CPU resolving issue #2.

Furthermore, smp_call_function_*() handles calls with invalid CPU
numbers, etc. So extra checking by the caller is not necessary.

Fixes: 4a24d80b8c3e ("x86/mce, cper: Pass x86 CPER through the MCA handling chain")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/apei.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8ed341714686..5c0381a4a66f 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -63,6 +63,11 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+static void __mce_setup(void *info)
+{
+	mce_setup((struct mce *)info);
+}
+
 int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 {
 	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
@@ -97,20 +102,13 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
-	mce_setup(&m);
-
-	m.extcpu = -1;
-	m.socketid = -1;
-
-	for_each_possible_cpu(cpu) {
-		if (cpu_data(cpu).initial_apicid == lapic_id) {
-			m.extcpu = cpu;
-			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+	for_each_possible_cpu(cpu)
+		if (cpu_data(cpu).initial_apicid == lapic_id)
 			break;
-		}
-	}
 
-	m.apicid = lapic_id;
+	if (smp_call_function_single(cpu, __mce_setup, &m, 1))
+		return -EINVAL;
+
 	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
 	m.status = *i_mce;
 	m.addr = *(i_mce + 1);
-- 
2.34.1


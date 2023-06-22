Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9267D73A1C9
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjFVNS6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFVNS5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 09:18:57 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E9A198;
        Thu, 22 Jun 2023 06:18:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6vxBYZN+rdE7ad220YvGz+/JjJnGHcjlZ/CrTddC/rNsKdsSdrefASFKQ5gYYopR/5bAQgnC42ADJ8CDheUJT27LaKMR4mZO3DaqYfnF9jj8zqJHkEshXVUNYfjQN3TiajAfpk+KftpuCOat2DMjmPWWhiTzR/34+Yw9/VYdoHHnMOYGr6yysQ6tLXLhKrM8LQlJ/k9f5ByfQ7O7jSEJe7Q3oLhaRT2ktJczde3cDaqtRu//46Ece84cCqeAG2zWwQ2aHWspN8h3M46KoeU4EIT8TW7ZK6n/8HaEoZfTWaTO+AVoOAeInLqrtFFB+r3c2vOURRbsQzo1vcikl63yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KmocMG7BBQNO6Tdd3y0QzNKlMi08DyAx0t25guv2SU=;
 b=Of/i0N3LRt0neAKn/ILKDZVuSUl5xSaCHzQ8C9/OVaTrx0oQ/hVwOTHL6k48frzM5nqSdzRFQ8IsckSPPBowtcVT/oly8swi6pT3C+HTrMhtdv8mQl3K2lcu3aelakuwbjxo9+6yiStpLCEjbR2ZzXceU/Jr5NHkCUzfteuowpXVBwvMCd8zPixB5Dt+7gNgH0NhfRXVoD3+8jyL4mO4mXCQCrqxzkuZslHWpwtzCJess5fcuat7ANFGqxM85R4IyaxKL1BXlyGGUShRBLhr6qZxl0UCjKiEOVJy2s5x5ZuPrXYq/DQMzJABrDOkaHaZEj8i0zBvKCsRz+tVrrdpKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KmocMG7BBQNO6Tdd3y0QzNKlMi08DyAx0t25guv2SU=;
 b=q/VmTcLrQ/hy1cNd0cpt6aZCEnKdkJCEniLlx8cxvZuQPFeozDRvD/CG9KgsRJ675RZEMMa9zbfim8CNyT6kOwk9gy29pRPrhaL0ZXjmH58OfJNC+mSU6fYTOgXvWf5t3WB6UbIxFsG+WoW9bT2LeR40LP9iE+TfokMp/VeL6LQ=
Received: from DM5PR08CA0041.namprd08.prod.outlook.com (2603:10b6:4:60::30) by
 LV8PR12MB9081.namprd12.prod.outlook.com (2603:10b6:408:188::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 13:18:55 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::40) by DM5PR08CA0041.outlook.office365.com
 (2603:10b6:4:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:18:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 13:18:54 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 08:18:53 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/2] x86/mce: Disable preemption for CPER decoding
Date:   Thu, 22 Jun 2023 08:18:40 -0500
Message-ID: <20230622131841.3153672-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622131841.3153672-1-yazen.ghannam@amd.com>
References: <20230622131841.3153672-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|LV8PR12MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: e4939043-1299-49f5-0a02-08db73233a9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lqk8tB0rvuM/VmSA+Y5OEJ5GjRL3UqHKxkh0hOC0gQdS5uVbMpi8qMPlvZ4Ndtne98aPhPhaSPitrBE1YFcfxotYXkWjI733TkkTBL7tniZ3QOdpTCbgPuPilWvzRnEa/MfI7LUU2wenhkI6P8ESvCJnggE9uLXwWGUz665wP2mzyRmnAGWTRLvwU8F6rwoxOykxQ0+gRMKxDS4ozSoD8Qch27n5WSy3mr6ucCzUJeGDCZjMVPWVued4vq8F48TsWdC3hse9PDvsgped1eYF9oavNffDRXgXpCdofHgL2n1jOCaDlsv69xdVCaVWAEjI20Wa39Qh6LEYsDqNq12Ev8BRgugCkLIXeF/g00Kmsr9i9hl/40fzzHT4oDGublDAtAnKCf2KpAAvA6+RBhvxNLBjGrmFgYYoE2cQ1eHLIx0+xkgFXL4MC5367JeN1XlAyknvirtOLEIqzsIJfWNQpygRzQ9CyqZ7wqCfHCREtnMXWv4W+j4xOdiZimyBacaotPsBWRE6Bhh/+O7smPNfZJ03oQqCA3SiqYPXvb8ZImbb/QBExGuacS1GqVaVxZ6muWwYKtIh/AOIdnLU/n3kjYmKI1PKz42GrUs1GX/LxzA8JTDLkzrl0MYI9Pl77EWQXZn9bJz8QzK/BZ1XjbHXMHu1ke2V0L7vR9OoTONV/yW3utIKfenI2lSSCz+GHHNr7fKNSPRQSuYt5l9y2sSm/mqFpdcUn1fDj24wUJcweL5htRjZTpTOg9OuMDfbIuULbd177Pg8KF96qb0nad9yaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(70206006)(70586007)(4326008)(316002)(8676002)(8936002)(6916009)(16526019)(41300700001)(26005)(186003)(2616005)(1076003)(54906003)(40460700003)(6666004)(426003)(336012)(7696005)(82310400005)(2906002)(5660300002)(478600001)(40480700001)(44832011)(81166007)(356005)(82740400003)(47076005)(36860700001)(83380400001)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:18:54.6917
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4939043-1299-49f5-0a02-08db73233a9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9081
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

Fix the first issue by locally disabling preemption before calling
mce_setup().

Fixes: 4a24d80b8c3e ("x86/mce, cper: Pass x86 CPER through the MCA handling chain")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/apei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 8ed341714686..2a7a51ca2995 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -97,7 +97,9 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 	if (ctx_info->reg_arr_size < 48)
 		return -EINVAL;
 
+	get_cpu();
 	mce_setup(&m);
+	put_cpu();
 
 	m.extcpu = -1;
 	m.socketid = -1;
-- 
2.34.1


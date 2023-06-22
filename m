Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164273A1CB
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjFVNTB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjFVNS7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 09:18:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2049.outbound.protection.outlook.com [40.107.95.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE5BC;
        Thu, 22 Jun 2023 06:18:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9YVQ5J/PI867Dorf441zVSiT31GyjrfkJjV0W5LjBpR9KmuEl9zzrL0RC0x2IADWGVZcDYSiRSvfQmvuuVHBHFs9LgljdjWkC76u90W+IwbX2wZUPAmP/3DiyRyjr9eJHTSOn6eUhjL8XerGWurhrXXP/TkYrP0lcCXmshpFKSUZxb0TR5yadlJ9JJ0TSxDX756NP4WeAK05FTyZlThu9QmlDigeil2XOgXpmKilMMkINZK4DVvBP7RBFjjruvpdif+vrVGaLArQaLGPjI/ldC08gOi4bSwuzLauTw9e37ELXGDjD/7P7sAala2fuvROOPQXQRCT14l0OiVRIMe8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRWB/4kf1oZTznE/Bfp3f7eaqvkTVSds9z5xT02HmdM=;
 b=Gv7okqGPuaz1Ad+YhHzjDNW75LrnGXNOyP3LSDkzhY660s7ZujS90VbssF4DFYAqftZ/h1EKgmzDjLuTrJxmOVwsz18VtvUOymwXuE2P8EGivsLYODqKBukDdIh3iGSZnbxOuDxYz9hqdVsfz2Yn1yHKD8HClN+tCi/Dr9tuoRfMbOjQ+s2cno/m356RckiNAsVJ63sjn5frHEPifdinPJzAjbr6wgXXMWVJ/8ralSn5KzHRnmHF2tMY3L3o4frtSTixN90VHty053s27lez0FQUoMpLjk1OPr6it9xp6HfOzelhrxr3ZTBEuKXkM6qH79IvKoueo6gtGitzkGlxew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRWB/4kf1oZTznE/Bfp3f7eaqvkTVSds9z5xT02HmdM=;
 b=bne8DJYM3sNjzL6II+MnTojE1VdtWXYRVMmpdXXwxfu6dFOAz3bmAdhxmLlog5jzN1YPWOEkLfQioqKfj8sPKgHqk0s2sfpuFApFyG/K+Z9I5dlTPIDNpHQ9eBqo0ec2LzM/Mo7sQB3ak2e5VQpnJZG2yKj7gRd1IVeyfyVlkoE=
Received: from DM5PR08CA0045.namprd08.prod.outlook.com (2603:10b6:4:60::34) by
 SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Thu, 22 Jun 2023 13:18:55 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::e2) by DM5PR08CA0045.outlook.office365.com
 (2603:10b6:4:60::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 13:18:55 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 08:18:53 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 2/2] x86/mce: Set correct PPIN for CPER decoding
Date:   Thu, 22 Jun 2023 08:18:41 -0500
Message-ID: <20230622131841.3153672-3-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: abfb3bc5-c35d-4d96-a35b-08db73233af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uX97pphwtIRCnQ42yLp/LqB2a0isyP3KrTskwLz+N/vY1/HpKO2aM9wLUbEgHfNe+PdXZfxNkj+zPXG56CeITw8Y5zHogsVMywd9uqa4dCbLwagPts35fdtVnLQ2jB+HZVyeeplL0z5dZdLL67QTkLgOqLEwwrB+JMLugeOJR+Zo+fIFiZGOZzVxmqA+/A+HtjooTpZjI7HeoyE4icAxz096w83a7SyaBeOoLPDxcAZNQYtz8MlmvqexJL3tLgDOKepvZO4nanRIaQRa9vkDl3RkgOvTk5BQuLnvglscuzC9glNNBgsWx0+ossl10EwWRVlAvCwsEUC2zQN4oumHupF5ERoVtuZ3CFcSV+vpIvdL3ptoxU0FmayX8IINLPOMN8dsEY20YKIih1lveS0owcx7j6SWrWhu6P7/F+kMaICyQvsk9zc3pd/PL9ljROSVGfJ3xb2CF813ndGIGCxRNjdf80e5iEWlR/q2oz8BJN1OyL61xda2sEldd/YdGKs0DnrX7w4z54SmyvaRzGvGX3QvJmrQ6SZ5MoRMrHCmQXnKoZXvzV2K/4nKgkx5ClGR4Q1FgKHttVjTsiWCNGekWxyk5HZpcv7PGwLj1T8JmSpbDCBQ8gguI7RhDyJhE5UEaHPodNrsm6N5rXDPZqLtwGMHoEH2P6j2JqFK+Qc7J9DB2vTBpxQlbzlHSpcewli/jJeWKkTjrOI5xBfmVHaYG7QcZsbpxWzetd9cq38emuC0fwwoalHn5OxtK6kzLUj0mp+omhU0kadLWWCJZFVFDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(186003)(26005)(16526019)(1076003)(40460700003)(478600001)(2906002)(44832011)(40480700001)(81166007)(86362001)(41300700001)(36860700001)(8936002)(8676002)(356005)(47076005)(2616005)(426003)(336012)(36756003)(82310400005)(54906003)(316002)(82740400003)(4326008)(6916009)(6666004)(7696005)(5660300002)(70586007)(70206006)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:18:55.2855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abfb3bc5-c35d-4d96-a35b-08db73233af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446
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

Fix the second issue by using the PPIN value cached during CPU init.

Fixes: 4a24d80b8c3e ("x86/mce, cper: Pass x86 CPER through the MCA handling chain")
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/kernel/cpu/mce/apei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index 2a7a51ca2995..db16dc3c7b03 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -103,11 +103,13 @@ int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
 
 	m.extcpu = -1;
 	m.socketid = -1;
+	m.ppin = 0;
 
 	for_each_possible_cpu(cpu) {
 		if (cpu_data(cpu).initial_apicid == lapic_id) {
 			m.extcpu = cpu;
 			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			m.ppin = cpu_data(m.extcpu).ppin;
 			break;
 		}
 	}
-- 
2.34.1


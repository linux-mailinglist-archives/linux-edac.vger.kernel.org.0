Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B50872E573
	for <lists+linux-edac@lfdr.de>; Tue, 13 Jun 2023 16:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242625AbjFMONG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Jun 2023 10:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240096AbjFMONF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 13 Jun 2023 10:13:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068B51FC7;
        Tue, 13 Jun 2023 07:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwjsj4Sg/AVspNUwRDpWgEgkQRLsQ2zNm45i/fvsFu9o0vm6rpvqjoBjrKFTwM7vCDbkXOBXhoh6RCpZR3WpPfA++guJEQR8bkkwSrYpnfXoYh6S6ia5xtYgIg+xYx3GtzUxbgyeFdJNURewj9aX1dJ1Ld8swZawHGPrhSwKUgw1F03o4/b6Kry+LiV3siBLXF0Y1S5i06MJQ4ycjOnlJ6qKCXtODavnqDTQlhXBwBmwzcejKbkrSrSu8fd8oe1NGK2aZu+F0Y2zDw+NYxjMZGKP/jWzpg82af8sEP85WGcZks+MiQ01M0yv03xERGSz11gdspvr65BJoKV0KHj9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSGSuSUfPbgAosqwYAkkTvmKixRTcHEZbBjGA/GNoXM=;
 b=glxd4Q6fkWDN1+XkGgEu+TIgzqPE7xlVwY0H5O2VyWM0jx4X+zruaT5iS2zjOgHZgH4R76qzKxFF96DDxRPZtNX+5qjEm1y8big39pH6sGnLD+oWkpzEp+ErWJILBVlfgaj/l1iCpLUqpm96MfymAIGzU8LhkkfMsigvCRlBkdeOVQyCqW5cCqbVIQEKD4OWJdLd18Ygc2fyFRt9eizeHgtRTOMDy5PrnmWxwJZ4q0E4ogPR0Fhop4ece4TB9Go4JJBHdUpJp3tmlg5vMwMnGCAoxlBah8XvU4udN2vXykNn6r+i9PctulS6W/+VXyeKqUeimBN4KBc4JBu50zirIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSGSuSUfPbgAosqwYAkkTvmKixRTcHEZbBjGA/GNoXM=;
 b=EgG56qXImGvqs5dh4WbB86wlPS4biP6BT9qJYfszmPs+RN/A4CS00Vd875/SbIIysKsHTFjNQDuM+Fqeo9xVX299QXnS1LVA4vEhscvxefaeL6Q/OnEP82CdXgHBbXA/oW6ihl0Nhy41AisV08LMrAxR85kBadVC3t9kZ6bM+aU=
Received: from CY5PR15CA0254.namprd15.prod.outlook.com (2603:10b6:930:66::28)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.37; Tue, 13 Jun
 2023 14:12:38 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:66:cafe::b8) by CY5PR15CA0254.outlook.office365.com
 (2603:10b6:930:66::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 14:12:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 14:12:38 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 09:12:35 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <muralidhara.mk@amd.com>,
        <joao.m.martins@oracle.com>, <william.roche@oracle.com>,
        <boris.ostrovsky@oracle.com>, <john.allen@amd.com>,
        <xueshuai@linux.alibaba.com>, <baolin.wang@linux.alibaba.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 1/3] x86/MCE/AMD: Split amd_mce_is_memory_error()
Date:   Tue, 13 Jun 2023 09:11:40 -0500
Message-ID: <20230613141142.36801-2-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c1c540b-b785-49ae-0ac5-08db6c183e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dr0S08dREXQY6IH/iGxYLQRP7J0EctZHi7egOw8Qvvs25ZaH3nCXRl7Uk7+BQ/oYRYlm5lr1M0IWR7bFpXrmkRPyO4i5m9NvtiqbXa+XcueQKfeW/tO+xiRIJtmZ6dJvsm1/fpVaxpwzLBH9h2i0Mv1Km9uh5eb9mjLBETqTVU39Rdbop+Bb824asYc7xp6vLH3Y7z/QqaQM45jeGLKGkyib/uEWcYrF2/3e/0NQbqB12bM7dXyfBzenyYjQVBeOghzLfWeuUpQqxgz8PFpSuzp5a1d8SmHeMMw7mYken5S5/MMxFdjq3UzJll+Hlyzpdt5yUYFSmb+y6HD0SiYEGaJB1VoJ/DX/Ch6M0z7b+LdNGJkn+JGXE+KXzoX1PukZDTS0qUrtRyhkATYpjKD+pi05Ec0THmT8iBefMR6hs+6c9DopedIEiCAlBy+V36d42mU/kUysfkGysK2o9NoL2vcTvWOj1ylyxlYFuiU+HqrCf/YSMJB23b7zQtY9UoORvVqJlB9zq9S0H8FeZY/0yu7yM80K4ZeyNVIUYLwlj+njKPTdf6vcWP9fKfFc6aBQ8s5ROQqew+HnJ3V/6/qasQ8MSu5xWtq1eRuy5sRNMJ5qfuok/klUfxvlJWJghdFCwyGVhCZECe38oKbX/0W8dtJCFdR1h6hELNCWz9pfyzNZ51yXinfi+cR5gK2sHlnc5QAAIquW8aQmHBqfn0fKrS1DTlos9KDmaEYYqvFQGdByNX8Caizz56OT6gFtdittoRQI+FuzjTlHyVqCjiZTLQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(41300700001)(7696005)(6666004)(81166007)(356005)(70586007)(82740400003)(70206006)(2906002)(8936002)(36756003)(8676002)(5660300002)(54906003)(44832011)(6916009)(316002)(86362001)(40480700001)(4326008)(478600001)(40460700003)(336012)(426003)(2616005)(1076003)(16526019)(26005)(186003)(82310400005)(47076005)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:12:38.1100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c1c540b-b785-49ae-0ac5-08db6c183e3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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

Define helper functions for legacy and SMCA systems in order to reuse
individual checks in later changes.

Describe what each function is checking for, and correct the XEC bitmask
for SMCA.

No functional change intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 5e74610b39e7..1ccfb0c9257f 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -713,17 +713,37 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 		deferred_error_interrupt_enable(c);
 }
 
-bool amd_mce_is_memory_error(struct mce *m)
+/*
+ * DRAM ECC errors are reported in the Northbridge (bank 4) with
+ * Extended Error Code 8.
+ */
+static bool legacy_mce_is_memory_error(struct mce *m)
+{
+	return m->bank == 4 && XEC(m->status, 0x1f) == 8;
+}
+
+/*
+ * DRAM ECC errors are reported in Unified Memory Controllers with
+ * Extended Error Code 0.
+ */
+static bool smca_mce_is_memory_error(struct mce *m)
 {
 	enum smca_bank_types bank_type;
-	/* ErrCodeExt[20:16] */
-	u8 xec = (m->status >> 16) & 0x1f;
+
+	if (XEC(m->status, 0x3f))
+		return false;
 
 	bank_type = smca_get_bank_type(m->extcpu, m->bank);
+
+	return bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2;
+}
+
+bool amd_mce_is_memory_error(struct mce *m)
+{
 	if (mce_flags.smca)
-		return (bank_type == SMCA_UMC || bank_type == SMCA_UMC_V2) && xec == 0x0;
+		return smca_mce_is_memory_error(m);
 
-	return m->bank == 4 && xec == 0x8;
+	return legacy_mce_is_memory_error(m);
 }
 
 static void __log_error(unsigned int bank, u64 status, u64 addr, u64 misc)
-- 
2.34.1


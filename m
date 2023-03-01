Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C956A76A9
	for <lists+linux-edac@lfdr.de>; Wed,  1 Mar 2023 23:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCAWOh (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 1 Mar 2023 17:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCAWOg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 1 Mar 2023 17:14:36 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD8D4392E;
        Wed,  1 Mar 2023 14:14:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HrDlQuIUV/XE1K1H3qVZjMk0Ah+EFBM5U1K8avZm0plsBEAwBkgz2ZLUEs0k5sI/vFm7+CA1kitYa0c5NubOFy40rSDknXmg3nTAMEC0desQZqSbAaF2Zfrks8RKTVuO2DqjuyZz0bmbZRzRa9n5rBeCzu1RggzVHA0uD28nCpyNvfeO0w8jQhoK/4nUqk0n5E8teEREkeCkqDjy6JiUq6WB+k7jdWerXVvyoaqn0ZJWSvPR+k38/GmXSa8a+vYpZE3tsaLGYXMv3ILaOoEe8bOv4jwQTgpjG7wcMi+EUb4d8ockLRIm1y6I4d16q4f9v3PfKYJMrPU2sLj9WaZviA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIIs7J4ikaeZk6ki8Ci/PnQREADdnADwzcj6SVAg3pc=;
 b=T1JOhgWGHafY9Ye8KQq/IvAWGtIx01Z8DhNxd8iBsDlB0zQwks45SaqDlftFp4wvceaqSSoUplSTCXtIhOajMya/2Gpt6tIUpYkroPch/YPREArghCi12p1E8UxYvs1OUCKCTeeFf6wMaNUlv0XvB5IThJ/cDlNG3c3fRdnWkE9BDvVNVXAM4Rsbp1F4TNIv1W8HwJBJJXwNnfZ8EthSU8YlsAhbxhJZkA2Qju2mCwXy6SmVMA53c+4iEhxU04IGtUODpAb4mJHDnQTZrpY1k1DOcmZ8aIim1s3VxkkELzL3i1PWw/GHfEG4pxLLh4iTkEEDb0kU3G81PFdQjWdE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIIs7J4ikaeZk6ki8Ci/PnQREADdnADwzcj6SVAg3pc=;
 b=3hea4znY3+1C7WVye2RFUVnxjtePLYwFfj26KHWXBs10vxZYZdLbt+JwyP9LETr3G/EOwHuWlS/Oy0SPtDZZrJJW3NTzJMjlGAEYx5mQbinY3OniswB60ax/FbyoEJAaemOWfWWlkhDb3rnjXpDnkU3C9iysRcS/yXLnL+qIyrE=
Received: from MW4PR04CA0256.namprd04.prod.outlook.com (2603:10b6:303:88::21)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 22:14:32 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::c0) by MW4PR04CA0256.outlook.office365.com
 (2603:10b6:303:88::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18 via Frontend
 Transport; Wed, 1 Mar 2023 22:14:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6156.12 via Frontend Transport; Wed, 1 Mar 2023 22:14:32 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 1 Mar
 2023 16:14:31 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v2] x86/mce: Schedule work after restart from sysfs update
Date:   Wed, 1 Mar 2023 22:14:20 +0000
Message-ID: <20230301221420.2203184-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac8a115-f164-418d-448b-08db1aa25576
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygf3aoYCbkbN3msN8lEiJyeMdfV+005mKEKh9+gFxwqSJBi09S8rGMKI6KPnfpCAQWcXVfDjnnhAax+DnZc2uH8Eb+epjDg9iNNhjqcypOtt2NKHa2rWvXZzyX8UXSlQ2+u+axRFgc0tQF23gzjh4UJILy3UjN5YuBwe+8kqKKdIhX6uUF2WcUQWFkEAcYTX/IkqLnX9JBrzdqOlseEwo3c9EEcRFbxIuwI23op74G10i74UrIGHC7Fg5LZ2rIWqPNy3A+s5V+VDgv5AMsKRNJdmeUTrzoPDTrUSs6uoI7zvwAbFpbDgMF1k5XfdYzULTMS5GVtHCVV+hTOZEnaXklU9pxFGr7jNukIQY5GBqB93s/bEJE+U0yyXU/drZD60xWA6s9D3orA/MfABVXLHtGQ4iPj+NK8uo2isHyrcGq01yWsaCjpzC1pDLHuyT7y4LwkvJt2MTh1hqfwTiQ54rm5gdM40GIVxv3UgvPaieTcjCeAXhmwwjznEJyiRYuW5HJFZWNbZf18WwCTfPw+kUmt2d9dJl0tUvJ63ORtPlDk/kBz/WFs7xTR3SLMRQxB6NdbYrrsUmOtfP3Yhg5UJwX8uuxcP/esgbhlkCi4Gp55NpqJFqt2imuHwrGRicKYrKl+EqTJhQCMk3kB92BwbvqqWp2JcfIN5HKEF/HOs/EDzcBwu6qIGTLDeBiTET3XC5S1+ZNEXvbdin1YOauciRAK+aRvuICs+9gI7a+bM3mE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199018)(40470700004)(36840700001)(46966006)(36860700001)(82740400003)(81166007)(86362001)(70206006)(356005)(7696005)(2906002)(44832011)(6916009)(4326008)(5660300002)(41300700001)(8936002)(40480700001)(15650500001)(8676002)(70586007)(82310400005)(40460700003)(336012)(2616005)(16526019)(1076003)(26005)(186003)(47076005)(83380400001)(426003)(316002)(478600001)(54906003)(966005)(36756003)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 22:14:32.2489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac8a115-f164-418d-448b-08db1aa25576
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

A recent change introduced a flag to queue up errors found during
boot-time polling. These errors will be processed during late init once
the MCE subsystem is fully set up.

A number of sysfs updates call mce_restart() which goes through a subset
of the CPU init flow. This includes polling MCA banks and logging any
errors found. Since the same function is used as boot-time polling,
errors will be queued. However, the system is now past late init, so the
errors will remain queued until another error is found and the workqueue
is triggered.

Call mce_schedule_work() at the end of mce_restart() so that queued
errors are processed.

Fixes: 3bff147b187d ("x86/mce: Defer processing of early errors")
Cc: stable@vger.kernel.org
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20230301202623.2092271-1-yazen.ghannam@amd.com

v1->v2:
* Refer to correct function in commit message.

 arch/x86/kernel/cpu/mce/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7832a69d170e..2eec60f50057 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2355,6 +2355,7 @@ static void mce_restart(void)
 {
 	mce_timer_delete_all();
 	on_each_cpu(mce_cpu_restart, NULL, 1);
+	mce_schedule_work();
 }
 
 /* Toggle features for corrected errors */
-- 
2.34.1


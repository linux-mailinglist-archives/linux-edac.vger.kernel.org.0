Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F44445BEF
	for <lists+linux-edac@lfdr.de>; Thu,  4 Nov 2021 22:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhKDWB4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Nov 2021 18:01:56 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:64778
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232318AbhKDWBz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Nov 2021 18:01:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pgtrkz8WEq3115Tfd9ZEwQ+WgTxmHqn2fsh95Vv+Omz7eW2L+j8NZXuXk1EE6C5BGSpacE97xqAF9gJ3bLEOkbOREYTGw8lXkrnNtpAGhe6kw9mVv1SfaDmJ/2CpPLvcLHQLp0C6Of1lrGzjjSo1qppqKrm9BDw955oyPJmo9Gy+K/YaIAgQ32py+b0e9bUc4uZaPEif5RMjQv8gvRYfIp3Df410MAuk7oq3Njx/JjWNPvcHQqwHKj1giRHnxRQHBjmZF2UgCq3qJXf0fPDngupn+dpbforvfTe2R3+BGZZktjwElHUV5VYYcb9hOgHgUdiZtj1pbpz6AYwIcimMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/zdrYucSuwtgZKV6P8AFwtzs1S4Pjy1FDt7PgAuuWs=;
 b=jv9kpsUWYfTTqURfQvoHD2r2Ru72wBPY4BruRfg7F3SsIkgh4SbNarXhnNEr1nkcfbhov6isKyuNltBSA/Tu8Td5O5jHr5OtX+dsFNfbHp8AlyZa2mF6I3JTIimIdNMDIQvvVgwkvZS2P/vdkRmcnEJ0ycHfubixJIKr2jg9ecJMJdRBKUNe+jqZGw2HboWZdSwTHs1AXS4DrBmSYxwhh8gChDH0v1sy6tdHK7dIVyU1JQPzVZgDsNnJwvVwk1YrqtdE8vKsqvJA5JNjGkMgsstiXExvPD6QimXMuMuwXi3xx2ztY6aLcjJ3gVNYWPsiAICBjnfevRqFEjzkwoAjww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/zdrYucSuwtgZKV6P8AFwtzs1S4Pjy1FDt7PgAuuWs=;
 b=Jei1IpiwTU6MJEtdGJZB7B5rvSdBuuZIREt7VkD5eY4Vam5q7+AuaJdmO7L5ZZOpXGia/J/PWNzDUTOQOb1MdQzpxCwo4+KVBqsCFmgI6KAGIJxVUEsbVjbiYmcVK1gjAd3uR7yAdABq6MVuwYAk7ErHskNlS+N1FWAEynKU88w=
Received: from CO2PR04CA0114.namprd04.prod.outlook.com (2603:10b6:104:7::16)
 by DM5PR12MB1771.namprd12.prod.outlook.com (2603:10b6:3:110::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 21:59:14 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::a2) by CO2PR04CA0114.outlook.office365.com
 (2603:10b6:104:7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 21:59:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 21:59:14 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 16:59:12 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        <yazen.ghannam@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 6/6] x86/mce/mce-inject: Return error code to userspace from mce-inject module
Date:   Thu, 4 Nov 2021 16:58:46 -0500
Message-ID: <20211104215846.254012-7-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20211104215846.254012-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f66d58-da61-47f6-05be-08d99fde573d
X-MS-TrafficTypeDiagnostic: DM5PR12MB1771:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1771A981DFD9585AD511529D908D9@DM5PR12MB1771.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VljK5NVenoGnlFLQP2nV9v58qIOOIdlGyoK/1QGz2tLuXdDlhMxYAA/h0P/8Tf1MYrYEZETdaTwp/FIrdcIyunVTRGpI0EMj7XRfG5gm3o0PIbwKZCZYsCynKQT4KAxxvNVLswsUCMFSrCvFbXlBY4oO5zcGJzsx8ehdhRgl0r1eWeD9hGcWvZ8+5eNgDhOH3ySq3XBa1x5nrdJ5bc6eW3UivRRqZSDpYv8L2Bl24RVRGDzgKqreARJ+zonvDrv1v9MJe5EYlPSpEZ8AvuulNAKBOgjs/GhSnTA92NPnP7e90vLGGSe4g8Khprr8FneUIgyFFwJfFTVzN1X/XFduCWRQRo0OffqDGd+k8DpHqjM5BxtUA21OemwCxcDPUlrEgnYWzFwEmZWSMdJQcELpS7zhuCXj6WsO744WpyAILfnV/4wI7rS1NGSYpk8aEzzb6NLnpHGsYawlCqTAEz7CQvjE6PTnb/XYgtnMS3lTHQ0UdLPlI2m+Rvlek8d7wOxCMD2opIsjdQIMikLB9Eo19UGH0ylmCg+WFdkuRWPFQGYImnhEE44BYZ5azlIHnQfWkAC1IcYroh1rgE+nG/piYN2Q4m/cdWXxc778Kp93rJCBeuJc0Isdh1QhPdZKgLsPmTeT/paljy5oLAqPc55gG1jR8HT5QW+hqussz2KEo6NXZT1OpHkh8wsH8r9AwR27L+E6EavmSkQMmqZxD9YJKZgNyPHJsRLiZ67OLanZ2cYJ2302dPvkkeqXOklCTvDrE92ZqZnVIfeqdLYMK93bjJN23URzzDyg9pfWK8c1pr0RduSEk/P+8D0TH3ttQmb3
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(2906002)(36756003)(2616005)(8936002)(54906003)(110136005)(36860700001)(5660300002)(316002)(82310400003)(16526019)(47076005)(86362001)(336012)(83380400001)(1076003)(186003)(6666004)(81166007)(426003)(70586007)(8676002)(508600001)(966005)(26005)(356005)(4326008)(70206006)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 21:59:14.2989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f66d58-da61-47f6-05be-08d99fde573d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1771
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Currently, the mce-inject module fails silently and user must look for
kernel logs to determine if the injection has succeeded.

Save time for the user and return error code from the module with
appropriate error statements if error injection fails.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Link: https://lkml.kernel.org/r/20211019233641.140275-6-Smita.KoralahalliChannabasappa@amd.com
---
v2:
	Added pr_err() along with error code.
v3:
	Rephrased the statement: No online CPUs available for error
	injection -> Chosen CPU is not online.
---
 arch/x86/kernel/cpu/mce/inject.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index d4e6d753018f..09f46d213cf5 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -569,8 +569,11 @@ static void do_inject(void)
 	}
 
 	cpus_read_lock();
-	if (!cpu_online(cpu))
+	if (!cpu_online(cpu)) {
+		pr_err("Chosen CPU is not online\n");
+		mce_err.err = -ENODEV;
 		goto err;
+	}
 
 	toggle_hw_mce_inject(cpu, true);
 
@@ -653,7 +656,7 @@ static int inj_bank_set(void *data, u64 val)
 	/* Reset injection struct */
 	setup_inj_struct(&i_mce);
 
-	return 0;
+	return mce_err.err;
 }
 
 MCE_INJECT_GET(bank);
-- 
2.17.1


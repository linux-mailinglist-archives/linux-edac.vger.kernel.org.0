Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9504243E7DD
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 20:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhJ1SC2 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:02:28 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:5910
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231598AbhJ1SBQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:01:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+35Gn5rVG3aH7J6bLouAy7uBZrjRf1VHL9d6ayq1SDIGEait2Q+otcuWP7hvuNGVwsqO3WVkL38cs6dRUNt+mK8IBbF3jKFYZdHtz/WX6NIWmq9chxUQciYnyY++ydYMhr/DJCXctlGQ8NWz9SVOCtbmDeWI13QTOB8txLdiwjGKgxs9rtSmW4gtls+Bd3dENYNn9skshVWzWROuOpDPyilNz0p6GSnALyKUS5axwervAwUvhH7rOkMiM+nq5nHllWG1F2E0r67t2tpVni+xix9uJwTZULxTrCxjAlVLwVne4DQshJWbbjdo0DWdOBmK5TJxQcoRurqp2bup4MfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpwo+CNAem24+cbsmoRdGBhEJ4Kh4Q1pBX5treMhQ0c=;
 b=QlSvMIbfjS+8Iecii9mTOtBU5m81FbzrFHadC41XsT73bNu+ptPGAYg1cfz6/dnV7z6ujMnuHgLpDGgTCH1pxXz5EiohxnTgehLQc8bpIEfhOHC+unua5MxDGqaHLYpa1sQPYgrMixgCuJ3mRnH/lGRIw9OgKuA0nnbOX7YsTWc5TRvBmKNkthplYeERChTTr4PJzD73DkCuZxPlWAK+Ee4+AwSeZkJU1GrgmAXrV14oP74CfFmCf/o25Xg38ChaVcQNWi2lQJpG+H5s+aMsOkzox2Thbd+NCG8uuCCho4vzKfewm/TDqcEhKmRXc+5owGX2MbrjiJxn4g54JEvGZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpwo+CNAem24+cbsmoRdGBhEJ4Kh4Q1pBX5treMhQ0c=;
 b=k2gNEwJagf+HCNjsuAlmxZzoTGQv3WuvX50GmfxgYYOMM17pWaNdGuBWzjXhB0ROzmHafdA2XavbRsitPY6bbvv6lmgPzleNMru/PNg+lLA3PrHAvJwgXdLBdqHrHAfrrQaL9h8MMfpufiSGs0aEadr0TBGxfb0yGxGQrUGRflQ=
Received: from MW4PR03CA0094.namprd03.prod.outlook.com (2603:10b6:303:b7::9)
 by DM6PR12MB4895.namprd12.prod.outlook.com (2603:10b6:5:1bc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 28 Oct
 2021 17:58:47 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::5c) by MW4PR03CA0094.outlook.office365.com
 (2603:10b6:303:b7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:46 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:44 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 30/33] EDAC/amd64: Add glossary of acronyms for address translation
Date:   Thu, 28 Oct 2021 17:57:25 +0000
Message-ID: <20211028175728.121452-31-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a74a867-cd14-4c3b-fb1b-08d99a3c96d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4895:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4895321BCBE0C4327A7507E9F8869@DM6PR12MB4895.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfKvcAJy4XCq27xlaLjoCmYPCosHva41ZpPMjoVkOeWUmdNXtsPWM9F5mM1vD+2E2uVANTVUytuvRaJASuDZpo1HXi+GALifzBUYh+377Bi8bmI15nu9LD864zIZxz5PluBazATtOFycaNEtjs1NSviZx1wk7T1ufGTJYez/sVlGdAr54kv/QrAqp/psy3FDgsZcQA1DfZgAD4N/7EBuB7BskDp8Kaxl4LamsxpmxSjIQu4WC13SJ8EIhr5fIqp1FcqA/kugxxBmuCxsoPugEkGvONvK4xQblv0LaCt84d1NP5mDzn3pgQSoKcrJxOkFFYJOBHb+hC3eCMULJRVTF7lw/za5UCDpRnsP7c7TpJFPrGUFqDC1mf3zOUEkIa7+RKgsrh8f2G6zlWN+NWa+uPy6xpCmy4jFvFbnczrCKGk8U7aXGql8bObkVu2GcnzvT+qMqy30JCsSTNjPQ7k3mAvu4hgXnM6vzcM5p/YWTRpcrg/rFEdUYgYEfrf1t9HBaETtNcjQfsxyP0YBMm48yAO9J4dacC1nhyGnXpIaol+4TZ5UL0i53CRtXgfdGxtMz3AaQyVtd9Czso7sxOBIw0GS7KY1QsvxyyuUl0idD0JGjwwHwD/zSrMJ0NZBpzblTWwTNsmjKwcxapNCMR6ZXzMGxWeyqBDOuKFlJBY8P/jlbTOO9HIZ2h0AR6qz3ItuOFur7SlJOUhH/IZ2PWYnVDztGW7KXSodFYodgUM4r0VtdMZ48QTmzHHKpvr81m8+jBeryeESQ8/O1jfpo0VKv3AQ7f/P+I8ypRDayBr+kVQO2B5iGcxNXd5HHMlW/g61
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36756003)(1076003)(47076005)(336012)(966005)(426003)(8676002)(16526019)(4326008)(36860700001)(6916009)(54906003)(7696005)(316002)(186003)(2906002)(44832011)(82310400003)(356005)(86362001)(6666004)(70206006)(70586007)(83380400001)(508600001)(8936002)(2616005)(26005)(81166007)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:46.7312
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a74a867-cd14-4c3b-fb1b-08d99a3c96d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4895
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a short glossary of the acronyms used for address translation. Some
terms may be seen with other AMD code, and some are only used within the
translation code.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-32-yazen.ghannam@amd.com

v2->v3:
* Was patch 31 in v2.

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index c97b336361bc..5dacd7e03202 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -986,6 +986,15 @@ static int sys_addr_to_csrow(struct mem_ctl_info *mci, u64 sys_addr)
 	return csrow;
 }
 
+/*
+ * Glossary of acronyms used in address translation for Zen-based systems
+ *
+ * COD		=	Cluster-on-Die
+ * CS		=	Coherent Slave
+ * DF		=	Data Fabric
+ * UMC		=	Unified Memory Controller
+ */
+
 /* Protect the PCI config register pairs used for DF indirect access. */
 static DEFINE_MUTEX(df_indirect_mutex);
 
-- 
2.25.1


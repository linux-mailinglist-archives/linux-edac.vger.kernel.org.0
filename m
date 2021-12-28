Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404CB480CEF
	for <lists+linux-edac@lfdr.de>; Tue, 28 Dec 2021 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbhL1UGc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Dec 2021 15:06:32 -0500
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:62433
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237215AbhL1UGc (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 28 Dec 2021 15:06:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEDcGKcavTrIfCz9NFca497GD6GCQZ9o7AYiDYvxeTuIR6bxblHVSVjD1DQ+9tM4NInwBJK81jtMPtEwAYNFWJ1G7b3tyPJMGCbl4EqJx2F7rP7Dc1AVpXNZM58GAkqM2kvmxhd7OsHNdXsvuilCruJAPaFCCEOXXHTlNuyPCMX9TQXls5k6V4J7NmBOA4J5w6J+LStcsaobuAaNwIDtb1VifS2o496cLaxBLfc5PXgFvuWW/JkFDgsiFXdYTUfvpQ9CcN20Ximk6h1X5Ql7CW1OeS8jZZkv5iJRQV49/9RjJQNzV1K8yfxTvxeCtsydT/vV9M+WJa2r8X/vWedYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKeUNXP00agblJP+YGFvghjP1D1NpzBYO67ad8WlaHw=;
 b=GPbNiRbVf8yn6OG9dKcd+nA1aVD+Lq56z2S+op+VNsbTOBBBskUa1Y3Tket+C01LzZPJCNOBlInc2JOXs6lpTFOK6WXsS1try5So5iOI/tPfo4soY+ksPklD/YYy1wAGYmZs4E2VMpkFaNqROlDs1ffFIlcTNzUHZnjMMJ8X4xOcn1MYpKdDIR53qDZ8MphFi7ETmaSXfdVy7NKFSQtNieQK2uYiKT6+Q3MBseg56YZ+cZAMbaMdFdlvCqqYBCEErVsNVxFJid0IlPv9DXEJdiFhUh+MsfJfm2sqnh9FqwQusYqMgTkE7pCqeb48zillZ6//6gYPxKkDSSgTpbxuHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKeUNXP00agblJP+YGFvghjP1D1NpzBYO67ad8WlaHw=;
 b=jk0VT50RlyTc5YnqtDXeC3f8huu9kXtdqYv7F7ncDSnsL6C9wkR/Oisdug3YkvwL9lEp+P18dOo2Wcv8KXjOOZK4DqHSgR0Ptxwd2vFF//2CiGdgRfD6SULTTFYrzdD8B1vdUQgJvhEDSj98bt36kb0HRfxWDST6AH20V1TnMLk=
Received: from BN6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:405:75::15)
 by SJ0PR12MB5488.namprd12.prod.outlook.com (2603:10b6:a03:3ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.14; Tue, 28 Dec
 2021 20:06:30 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::d5) by BN6PR17CA0026.outlook.office365.com
 (2603:10b6:405:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.18 via Frontend
 Transport; Tue, 28 Dec 2021 20:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Tue, 28 Dec 2021 20:06:30 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 28 Dec
 2021 14:06:29 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH v3 0/2] AMD Family 19h Models 10h-1Fh Updates
Date:   Tue, 28 Dec 2021 20:06:13 +0000
Message-ID: <20211228200615.412999-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1518b14e-9d1d-4d30-5824-08d9ca3d89ba
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5488:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5488B54E1A3E0ED229918FA4F8439@SJ0PR12MB5488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjeRWzukOYo6Ao1mk8qdvAg3zW8+OClYDo7HnZ18qi9Hww8TV6HNX50+rQvUSN9Tb0BIPWRv4BunLZtfybwGjxZxIt9+FkwOtxpC0vyonEXjzkuzmDPClVgI3Yh/YdB1Ly7yuYEWOpuUUaDj6rYLXZeO85nZc7TUSLkjZNkrLCh8EFdKHap4v3m4hmwrn6FPbHzKpdtiIS/TgYgtzLFum0jsiy73iDx9c6AJmI7KEVq+fW/LGBVBAa+16OxR19vhaIvHLBqPdX259G04kRDqEqfJEG3cXQIwna4a0FYkda+8zs5GNTyaskqS6J+7EtxbT14tn8dc3p1+1Ge6mCWQLSUXfvOWJ3T7G8mh4bEql1gNCRs20aYgVsiy6ZyvH0ZQePSHcnCMylbPeyCqOEry6SjY6UnoH7bBnUscbAGp/ue+HEgctquSKLEvG4i8UUUTatamUm8OW6xtpwAusuZt4Svds7CPkl5juE2PcOqLKFmxkXGP/192cav1QCq70lPt9bzXUVMabamjPEKR8mluIflVMAObYsz/R+rVIgPu0wIZ3Js3LUxhf2XExDNRk7qwqdP3iRDEDvWW8GfZk4QLV4R5wuJhzZFynBVMQAfy6vAikamv7V/sJgofqj9XIzRRhWqQYOybYug0BZ+AHwraSeLipUboE2G0G7skUPgvnzKD4xvV9ZDBmSHspiAvLsnZrV9LmOjCaCvGIG8ZMaXHOlEvPm45vM4F464YXj4bYtzHhIBPZlto+x5FpAFu7UJA9t2z2DHPPNJ8BuhmjTXpH7TQj+j5doAjvrzQapoieoO67AxN7btsZQ5YMjKWTrzcXb1MclV9OOjVq8P3s/yN9Zx1Mo7xMtLaLJknmt1nIjp6UNfVaXUZHnOX1h/rhCzc
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700002)(46966006)(4326008)(81166007)(36860700001)(82310400004)(508600001)(186003)(16526019)(36756003)(54906003)(26005)(966005)(6666004)(8936002)(15650500001)(86362001)(8676002)(316002)(2906002)(70586007)(70206006)(6916009)(1076003)(336012)(426003)(2616005)(5660300002)(44832011)(356005)(40460700001)(47076005)(83380400001)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2021 20:06:30.1673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1518b14e-9d1d-4d30-5824-08d9ca3d89ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5488
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set adds support for AMD Family 19h Models 10h-1Fh and A0h-AFh.

This set is based on the following branches:
  - tip/master
  - ras/edac-for-next
  - groeck/linux-staging/hwmon-next

The following commit in hwmon-next is needed for functional support of
this set.

  49e90c39d0be ("x86/amd_nb: Add AMD Family 19h Models (10h-1Fh) and (A0h-AFh) PCI IDs")

Patch 1 has been completely reworked into a new patch to support setting
the "memory type" per DIMM rather than assuming all DIMMs are the same. 

Patch 2 adds register offset and other minor changes introduced with
these new models.

Thanks,
Yazen

Link:
https://lkml.kernel.org/r/20211215155309.2711917-1-yazen.ghannam@amd.com

v2->v3:
* Patch 1 completely reworked.
* Patch 2 updated based on comments from William.

Yazen Ghannam (2):
  EDAC/amd64: Set memory type per DIMM
  EDAC/amd64: Add new register offset support and related changes

 drivers/edac/amd64_edac.c | 101 ++++++++++++++++++++++++++++++--------
 drivers/edac/amd64_edac.h |  14 ++++++
 2 files changed, 95 insertions(+), 20 deletions(-)

-- 
2.25.1


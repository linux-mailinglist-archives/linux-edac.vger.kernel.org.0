Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909C54EDED8
	for <lists+linux-edac@lfdr.de>; Thu, 31 Mar 2022 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiCaQeo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Mar 2022 12:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbiCaQek (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 31 Mar 2022 12:34:40 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384F820034D;
        Thu, 31 Mar 2022 09:32:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvxJ5UmSKse/vBIYzumbPbSZjQaRoS36lfW04RoJv3Kl9Gu3NILRrzVeXk6Wm2HHeMcwjTZQteWlFKHwknGnqXOkMCWO7u+VjYuAk9ocjBvMqQ9dett9KF2aU5+u0yffltR7zV5YOrdP8odPRAgOtSgFqVC/VG1Wl/r+aJY/QPFfjsZuvvp5CZAMbwXcZuu9VFOa3uEQqTm5vpn6xk6JeZztVS2zcOT/9S02vxg1/pDvty7107FGTdgguApUM8j1z9195FJuZTyHpsci05VLHJk3FZ+rnrdyQFkCHJiicqD6rOm1jELF89BOlaqfLFxWsjSokFaTtw9F43SmZn4DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lsrXe+hzau9wUYuDaaCX1Nux+Hbeg1V9W3iOYAafmh8=;
 b=gbu6azJy98pFrrsc6PvkolH7vLDIiofZARAYIP+S7cQz93Dk6JQk8PQLZPTJOoe7d4xmsl0CCarsBAXJMkjhG0Ip1zC/rW4IjErfIMIi9q0YXy1/TDORj6IK0m5vxIQqcyRcheIyxl5V1umokXpgSLn84m3liMFVxkZ00uTQe8cObb3nv2EzfQnfCHtIXys/G8gKogHmUT4j/5KGlXDFkR9TQIIP4OL11jeSHOjxHrFGdE1g9l4AV9XxMWV7U/2ahzJQY14VUsiuNORa/49Xxlaq3Tw/lK+OZf9uwJabxP+bdk9N3bMrn4TFfxhQ3q85vqABcFZnxLzD590XuiWCoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lsrXe+hzau9wUYuDaaCX1Nux+Hbeg1V9W3iOYAafmh8=;
 b=0/se3sLwgInp+a2Hh69cKUevoC0hwPCzOvxD0y0H+RlQovRDVhLZ8x2cLL85n5V9EgGcx2lvYW1EDPfVC8ac6VgzrIOCs4sVHIOFDCIBgP58ww1ta8mCuRB44xo02vuFSShFjlAkqN8tA0SS8xqQGHcR/hfii7djK7PlsTysK5g=
Received: from DS7PR06CA0008.namprd06.prod.outlook.com (2603:10b6:8:2a::15) by
 DM5PR12MB2520.namprd12.prod.outlook.com (2603:10b6:4:b9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.16; Thu, 31 Mar 2022 16:32:44 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::a2) by DS7PR06CA0008.outlook.office365.com
 (2603:10b6:8:2a::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 16:32:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 16:32:42 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 31 Mar 2022 11:32:38 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH v2 0/2] x86/mce: Grade new machine errors for AMD MCEs and include messages for panic cases
Date:   Thu, 31 Mar 2022 11:32:10 -0500
Message-ID: <20220331163211.5994-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5b2ad07-dafc-4942-1d44-08da13341498
X-MS-TrafficTypeDiagnostic: DM5PR12MB2520:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2520810EF9243D1E5F9538EBF8E19@DM5PR12MB2520.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lzq6E31MUumSk3winmwLvF5JYJ+I0SMDz68Hk+28Aw9Px8I/laVDx0Y7HVXpfIfjtMHuq8i1NrBRT52HWBhV3SnYLjGdR+z0xqMK+PTjfMyLD/27N9u+2sGOOgnlzNIr1uyjG3aX7ez3jxCWPL3+9auXYI5JYJx7KPnYs3+pg7IlJUHOCcotG9zS39SI3CdiFeyLtivwSQLM6E80pTvErYBPtQHyiVU2VelseUykYPZ44ncklgsA7/A+vX3VnGwa9pJ8TYzfYystYcBVvWvVvmh5KdQcFUgG5bTR4EiBiRndMEaegPrsYb8f3uHrIb8T2rkZxdKN/6tU3szMF4ffDxC0ycrAAqn/D/ihJpQcnky63nOJ26KJvRlnjnOv3ftPa6qkTzekyklXwq7ZNQaKzZFduTkBcAUFo+/wzt32PotACwj/21lc7G+FqAWWdmobn2lfyZ7TVPBdgE6hky3wfVIoIpNRTR3cysDfBYiMDKjZpBbVgFyJEAKvLb861CsFvRtNwWgcOE0jL7gNJcoSWAVwS9+p/7M/qZBRrknk2gBbSRsL1HBX/t1l0o7g93cqdX2E+dOtLBtmtmsEFfz4y1ix0/J6nXl3fOgFL+x7LzoYrM4csZssDewGVhF+n77beZ+tqWGPGfWr/LiX224uLBtJSOB6ZNhWPO1rXv4zrsmNQrlS0SAptmfjxFOUdU/PzuBJqbWo9A0lMEndbQgQTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(316002)(54906003)(7696005)(6666004)(6916009)(70586007)(70206006)(82310400004)(36860700001)(508600001)(86362001)(40460700003)(8676002)(26005)(4326008)(36756003)(16526019)(1076003)(2616005)(83380400001)(336012)(426003)(186003)(356005)(2906002)(81166007)(47076005)(44832011)(4744005)(8936002)(15650500001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 16:32:42.9993
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5b2ad07-dafc-4942-1d44-08da13341498
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2520
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This patchset includes grading of new types of machine errors on AMD's MCE
grading logic mce_severity_amd(), which helps the MCE handler determine
what actions to take. If the error is graded as a PANIC, the EDAC driver
will not decode; so we also include new error messages to describe the MCE
and help debugging critical errors.

Changes since v1:
  On patch 1/2, follow a simplified approach for severity.c, that resembles
  the available PPR more closely. This also simplifies patch 2/2, as less 
  panic error messages are added.

Carlos Bilbao (2):
  x86/mce: Extend AMD severity grading function with new types of errors
  x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
 
 arch/x86/include/asm/mce.h         |   6 +
 arch/x86/kernel/cpu/mce/severity.c | 203 ++++++++++++++++++++++++-----
 2 files changed, 174 insertions(+), 35 deletions(-)

-- 
2.27.0


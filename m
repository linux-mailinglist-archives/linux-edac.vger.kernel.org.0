Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E64BA2B4
	for <lists+linux-edac@lfdr.de>; Thu, 17 Feb 2022 15:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241075AbiBQOQk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Feb 2022 09:16:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiBQOQk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Feb 2022 09:16:40 -0500
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833E1E5F1D;
        Thu, 17 Feb 2022 06:16:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqOXYAfgk1h4ceiEAv+/jOm8x1ksXrbHFEEYvm60y276n5fqNCqmlkLRn5wEbEskbMwEz0BG1P8wi1D6fMAwCk+eIqrFb9VrVstKi6/mN/HV8gx+EU665gZNwZqmIDba5b8rfylIL+L88xb+sDVhqLa1R6cuz2QRAnU1/DUtCGdb0iNiXVDhHlihsYbrclq26+ZxcoSyA+Ue5U4jp/1jZHOhRMR7YAuUrdSP56TDlxR9KuzLFmoWRtGBATBMOAcVv/a5FhhacY0Gx9b9gvWarp8LvMS7wT/HFGVAt8jca0fY5qIrUI9JWVGQoOi9dlpIE0jdqIje5eVMa09XWxa8OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQ6Xvk2sZBqMLshy3FBTov6sXiHdMX4/S1BqopCF5I8=;
 b=mFMh54i1KfgJ7Ydk7RHfN88xfPt5xVx2hduEQe1gQRX93ThbSZp2L2Ghv8CFCqNru8Og1Xt9UqpGrL6+kCZ17g8AQPUUGu0HBNWzT0WVZ0DXDzJzyuseagdeFMqJD8KfA8zchzoXzVO0QO+NYW9tk9qo9dYgfURy6x6sfD4KxoSY/aJE7O8KOKKTk+T1my50Q1QH414KgW1yNoxrLXvr+CZFK/bVv2nw2/zzKiRVgNIZL1Or+Frghy/pkYfFRMoXpmMqBB5UHqDR488Rgoxxy3qGnSgxFAP+5yYToFphWBQxdRB0KOpG8CF/M+Op0HgSEws+1o+vWOBnHxblVYPkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQ6Xvk2sZBqMLshy3FBTov6sXiHdMX4/S1BqopCF5I8=;
 b=YIIwuWFi+rapyZp3o4AtJ6OsULQ4DCrZ7bycZzeuFSs04aK/eE4QcmV3+5mFWZQ2Vy9fFBNx5iU0K7DBYofHsANJbp808K9oSOBERxGmKvkuVbMdRHPmpOtq5c2DE+TjtWXnwyO96Ae6QlbykQtatclLqKtsGMkW4SA3erE4b0w=
Received: from BN9PR03CA0248.namprd03.prod.outlook.com (2603:10b6:408:ff::13)
 by DM6PR12MB4185.namprd12.prod.outlook.com (2603:10b6:5:216::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 14:16:23 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::62) by BN9PR03CA0248.outlook.office365.com
 (2603:10b6:408:ff::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Thu, 17 Feb 2022 14:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 14:16:22 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 08:16:21 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [RFC PATCH 0/2] Handle AMD threshold interrupt storms 
Date:   Thu, 17 Feb 2022 08:16:07 -0600
Message-ID: <20220217141609.119453-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1865a77d-30af-4fd8-3482-08d9f2201303
X-MS-TrafficTypeDiagnostic: DM6PR12MB4185:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB41859443A43B32C0426D5D8690369@DM6PR12MB4185.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbM+UEzCZD8oDDVuio8Zn151Zm8IFDDDCt1hKPIV/JreshrgxLOTejyuwKx6n7h0Jr6lnn182fhFZgqPPlntunoaVe1b5+wdjhvrNfw8QziSC33wCNUD7HRvvi2p3MNyncewq0h2wqLKg0FiT50ky3ZtvzUTneuk/EA4AfEHU7O2geIGtQIcCfyQ3HraiQJJz8S17u7zjZxafQ0NsSpMCKUH6atLO+MlXSJpGHCSInPaLaNAMGFA58KU4UNcEpYUdza6spWULWU5IVczM7/R4rATItLAu9hp8/QLgmjRJ3cTZ60r9E8nXQeT6RXSWjK8SQYKrc5im1dYkZjCU2Jgik5Bsz8UDleLoyeUdrFkLD6QvI218XiqlGRq4tnTm61gcTtIPuTd89RKjso19pP/tHzQ/JDGPgEPrFxygXAcBHzNJ/EnntOhODMvLeVtwxe7lJzunq3JvPNET2lVnCNZm5t1OekmTzw5v1NorDWOg9cWzoaZ3t9Au74lp1uYXLzxW2paK6CZ3oN6EF4tnvUY/JYvHdXOiERynT1YxtJpOCXT5WR9Urz7pnxlEuxGzCSTsVwtU9CcX7fbPZmCVrD/xJk7kiYcUgIILVM/Y7OVz7wBcNi/jb6mvcXMlse0agMgOSSdJ+ywtwPBeqRqIBk1upyL5uOJznOGr+khSUcwXevXlNPVg9PMs8ChxmgupTdySWVSyALA2VEFrx4Nwkj5sQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(86362001)(110136005)(54906003)(47076005)(508600001)(6666004)(36860700001)(5660300002)(7696005)(316002)(426003)(4743002)(82310400004)(2906002)(336012)(8936002)(40460700003)(356005)(1076003)(70206006)(70586007)(16526019)(2616005)(26005)(186003)(4744005)(36756003)(83380400001)(8676002)(4326008)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 14:16:22.0863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1865a77d-30af-4fd8-3482-08d9f2201303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4185
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches handles interrupt storms in AMD threshold interrupt
handler. Patch 1 takes care of handling the storms and Patch 2 does some
refactoring and simplification to reuse the existing function.

Smita Koralahalli (2):
  x86/mce: Handle AMD threshold interrupt storms
  x86/mce: Simplify code in log_and_reset_block()

 arch/x86/kernel/cpu/mce/amd.c      | 131 ++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/mce/core.c     |  16 +++-
 arch/x86/kernel/cpu/mce/intel.c    |   2 +-
 arch/x86/kernel/cpu/mce/internal.h |   8 +-
 4 files changed, 148 insertions(+), 9 deletions(-)

-- 
2.17.1


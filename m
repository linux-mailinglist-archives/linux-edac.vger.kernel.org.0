Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154664D66D5
	for <lists+linux-edac@lfdr.de>; Fri, 11 Mar 2022 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242094AbiCKQxd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Mar 2022 11:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbiCKQxc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Mar 2022 11:53:32 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0214418C790;
        Fri, 11 Mar 2022 08:52:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMzDxB6MsNXwm9XiwhdYSC/oWX2AqSraezjag9UeO2uUwCbZac7XNIB3depAFKRjF6ifrgjHdAlbBH8lIhfujLAOFvWi1BiJyCOvuHCAEY+fgcqyOB7IkfvbS75as2IT1pBVMbDRf8DlV8TEOF25xE0WV5uHC++dug3bmLtwMS8JxlN3eSXtov1k4S1kJkmUVF62BJFXRIf3P/Vw8b6DE6K0IlXjNmWZbLRac2uqoM9XBVo7j+iiEK0h3Ulpuj19BaemB8zAcrg4SIjO+AYPiMxQm+D+9Xvj+Idv5fGoItKDDc3hZhi0a9nuMtj2eoytXJm3f/ia7vYAGBltJf/sPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZXLVIVbqF4RbQOI4q+BsXI7fhdCVIQq1TyR3gB0j8Y=;
 b=a+RMe0MxIT+nl948xh3UfhITkQCeoHvOC8uEl0nOlup2kgSthnF+O5UvuGr7pJISqEUr+413Vu+Tn4EnGvVfnpNnaFaPi+y4OTZJPoBLpYmEmX4nBRUc/9rxJ1H1bhVjiJlvZDSTN4FpxhKnJkE77QIPtI390WKSu9f2w4CSbZoStjOPWP4RxUplrT5Vfy2axXKd6Hyp+NSUv/9TRPKFPSEkMc+GYd7Y8gE6NBFtGqo6S0gaI/PgskByZYvbhst66Ca+R2kWwWO6ZcO7Qlfinqz25sJKNrNSNRcWaAeaPo6Swq5cT8qE+ljP5vnQTrHpA8BUc9rXnzQo8lKs5ul7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZXLVIVbqF4RbQOI4q+BsXI7fhdCVIQq1TyR3gB0j8Y=;
 b=a/jCPeqffXoQtmswdYwdyyRO2XKKPMvoNkOZrR0j5WiKg4CyfI7SNFeLLDOwt2sVoSLJwoMl46gfs2msiW4xedKzIJo6lJ+yOIMGVSr4Y/pWdZLLOeT3kr2hO8wsf01q13Z7Lj6r7yjdb7UmwHBDuSl/4Znzj1q5S3KXWffnCK4=
Received: from DM5PR06CA0094.namprd06.prod.outlook.com (2603:10b6:3:4::32) by
 LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 16:52:25 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::d5) by DM5PR06CA0094.outlook.office365.com
 (2603:10b6:3:4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21 via Frontend
 Transport; Fri, 11 Mar 2022 16:52:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Fri, 11 Mar 2022 16:52:24 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 11 Mar 2022 10:52:23 -0600
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and include messages for panic cases
Date:   Fri, 11 Mar 2022 10:51:13 -0600
Message-ID: <20220311165114.482074-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e9a888b-e8ad-443a-149f-08da037f8467
X-MS-TrafficTypeDiagnostic: LV2PR12MB5776:EE_
X-Microsoft-Antispam-PRVS: <LV2PR12MB5776ABB30DDED231FBB900CCF80C9@LV2PR12MB5776.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E4ErUWQAFlTirrotxW1Knp28zzfR5eJfwjEsmGPsf8U9KmLeCwSVCABrRYpRbVZya8mfhdW8CBRgYBvrqt5rqUsaIIWzZybwtg3enNhQk5dm0XReRYKmBXkIC80DuSCnDa7Za/DFoWg9KYeCu9+aboE4r7A4WiOmVe2tvA4yNwg8nGjxfn858hjKpzJPWwPClkkOjQYNPkpd0gWQXVaPw09skrwgl9bTzCoQfLitppOhLt4oxzlKpiefLe++M37yy2Rj1TbziUFAbM5xFWHi32jkvYFjd09AumrTKXtBwIDTMyKAFUpeX8OI0ae7tCTVdko2b4EN6Fxq78ns9HknWjWOb49AkM2XstT9d/43SvRPs1omLaqgM1LfQNdeLUyU1f5a5obhXeGHw0xDyjdFLMxEK5gUU3+81m7YYY5sw/eU1w/w3a3Pxf48kB722J7W5sSdmAzSvi0p0Joj4PzmH+w4GcN14xKWrIJxqUxG125zECQ+cvxAPtA5jv8zkkiffxjCbh71lWTjngCPMDvL4pSdyuCj/UevhQYv6SpJ5PqkM9a4BWTMovbBIHRvIetT8nVrRyJvKJhTO34UQwYcfRglkuKSw+lguyyL5KicCSZmTwtbM1MYZ96aTnda91awV/+vLRSKVWBEYWSLM7Be6BE5mEzV1Lowc1xE8vCz7GZEXIGyRAXTMMiS0gdmXAV4DPs600XLgirLrcFW4c64Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(316002)(47076005)(1076003)(4326008)(70206006)(82310400004)(356005)(336012)(6916009)(81166007)(54906003)(426003)(8676002)(40460700003)(83380400001)(4744005)(26005)(508600001)(186003)(36756003)(2616005)(16526019)(6666004)(5660300002)(8936002)(15650500001)(2906002)(86362001)(7696005)(44832011)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 16:52:24.2486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e9a888b-e8ad-443a-149f-08da037f8467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776
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

Carlos Bilbao (2):
  x86/mce: Extend AMD severity grading function with new types of errors
  x86/mce: Add messages to describe panic machine errors on AMD's MCEs grading
 
 arch/x86/include/asm/mce.h         |   6 +
 arch/x86/kernel/cpu/mce/severity.c | 203 ++++++++++++++++++++++++-----
 2 files changed, 174 insertions(+), 35 deletions(-)

-- 
2.27.0


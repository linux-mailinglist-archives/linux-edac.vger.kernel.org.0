Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B511D4C4EDD
	for <lists+linux-edac@lfdr.de>; Fri, 25 Feb 2022 20:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234966AbiBYTed (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Feb 2022 14:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbiBYTec (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Feb 2022 14:34:32 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C51AAFF8;
        Fri, 25 Feb 2022 11:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CEMk03BZQe67r53HWoFHCLoLYS+4zRATtukxGwO3vn/+2YkkQKq4WCks/tNNm95/ao5kLx+mnS+4t9fD/ZaHgxwSTOySDXBHuqXR3afLBaAQPR+3jWaSxe1s4K2S70olwLdb2fk2r9KPttQZ/oXMXMK+uaS19aV5WU7TnaIKDgoejKmWme5h+NjIbxe+OUP3Ts39U9gK141e2XVJ/KzRMiAnkHWUsyEGrtKXP+p8Uoqr8adNTAWOLiqit4ElrPQQVghmAtfty9iV/AlvNcujybf/w9MUr7CQ7zC9AgB0YouZSwH85cWY0INBKx/IsQvZG4rxB5hajd5frUQU/emSwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o7yKMABXxPpKvxXaRqp5aI/TBJJ+C05ER1L2I1lWVbc=;
 b=h543PgptTATuzzZdtc/1z5zcqCwZ/ZlDQ25DwSoqzplak9RSihPB0GleoMt7zq/5htC3rbzJC2nN5LGph/67FVDpGLB49L1Njwnv2fl0YdWS5ltaVu/qwQafHaoFku+FaLqeQuORSst6ypWy/DUApC3xl5uKbHmRJT32LY2NVXiwcv5rePl6clxzVIREeM6WeCWg5QZgELUNB00M6FfQMqvfpmOPD2FZGVtFS4w3C1NpYpTP3Ja1QL4nwQhG+JDkgD/hO9HQzXlqdKG7eHsTBrEU8FH5AOam2DsaX+bbYsJUStdxZ8kgskJxniTe86stTbuwi9YPQB1M2IKiutISxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7yKMABXxPpKvxXaRqp5aI/TBJJ+C05ER1L2I1lWVbc=;
 b=rTYwGLGRTJtu4c9fz5Xx557Ocn6U4KE9NelpFfMRbokbm3gOVqgzx21XOlX446TjDYAKy0eJaZ53XNFL8s+PS8SFOWL4IyTm6ogH2jPcJFypseShG89KvpoNi6/LUZqx4USY2DRC/wB6v8Pd4vDFYBTNqXsXWPIpmvUvhl63Of8=
Received: from MW4PR04CA0203.namprd04.prod.outlook.com (2603:10b6:303:86::28)
 by BY5PR12MB3956.namprd12.prod.outlook.com (2603:10b6:a03:1ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 25 Feb
 2022 19:33:56 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::60) by MW4PR04CA0203.outlook.office365.com
 (2603:10b6:303:86::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Fri, 25 Feb 2022 19:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Fri, 25 Feb 2022 19:33:55 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 25 Feb
 2022 13:33:54 -0600
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <x86@kernel.org>, <linux-edac@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tony Luck <tony.luck@intel.com>, "H . Peter Anvin" <hpa@zytor.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 0/3] x86/mce: Support extended MCA_ADDR address on SMCA systems
Date:   Fri, 25 Feb 2022 13:33:39 -0600
Message-ID: <20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26ec3fcd-a1d1-4d80-fa6b-08d9f895c362
X-MS-TrafficTypeDiagnostic: BY5PR12MB3956:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB39568CCB3093AA3D0823C390903E9@BY5PR12MB3956.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i04IAXOn2cIXUIZLy0Uk78jhNVRQo2VwO/LeH4+Pd1siXlRMzgB1WoJYtw5++jJnIIviTVWoWgohBmrCPyCG4D01W8RxV2ttasR3YN7W9+9bNaQMviYavB81tGWBa0DMWZqH9YG2nAp8KGvChIZAsZgxOXMQxkyzscG1ElkGKVa1hYGHlf8tQ4nlWEHMHFHf0AbyVL3SfckEQ9YLBHBsQsNbEeCCgeAH7B0/G1bOGSKwKmOmGar1lj25Tu7xBwOKPNlVF11P0qyef7CKZ9X6TtfSB4QFGqTCLsNXFe/0aiPUxmQkV8dp0m+a/oDHqlYG9r4qkOVaWtu3oujdKj/Nw9tlNEqoSngbY0MaXwoTtK1sEzQzKeGuu0l7D/YDtsdq0dTk8rqfnbJqpXWx/yxaGl7UjD82m8fzdBhq1d2BFw0qlcC8xwjRe8Df54EHVlhvdXEBcsRQSshRexGk3SF2up8ZcW0KmgXIDAPklMPDMqwI23mE4x55kEsl1C1PZVRrf5VzP5XXJzgqmeazJMpZOXJFNEVWG6EANYxj+2uA6gtei+iXKP2kXm0TPDq+77LRdYJPgRnHGwoQwOnusKOEOtaWrD8phU7TWFCIyON4iSoKODlE6c1pvEtaVIEvq0cyAv511aZZOjwmrq6cYBfl+WJ3bS/Rsj146M+yNooMaplHmbgK0h5CrYvu+vII6xvowYXkRZj2JZxfHxIAzcs+BNypiPNY4TxQaprTtpF4lkMlTFCwOynbcnzZIP2Y8a3Q1kWSh1UGVWZ0GtY9QkQJAt1tB3g4rk1q3rwnVAnfRyE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(1076003)(336012)(426003)(186003)(26005)(2616005)(4744005)(36860700001)(2906002)(83380400001)(16526019)(8676002)(8936002)(70586007)(508600001)(70206006)(316002)(82310400004)(86362001)(40460700003)(110136005)(54906003)(4326008)(356005)(36756003)(81166007)(6666004)(7696005)(966005)(5660300002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 19:33:55.9463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ec3fcd-a1d1-4d80-fa6b-08d9f895c362
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3956
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This series of patches adds support for extended physical address on newer
AMD processors such as AMD 'Milan'.

The first patch provides a fix to avoid unnecessary padding in mce_bank
struct.

The second patch defines a separate helper function to extract
MCA_ADDR[ErrorAddr].

Finally, the last patch adds support for extended ErrorAddr bits in
MCA_ADDR.

Link:
https://lkml.kernel.org/r/20220211223442.254489-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (3):
  x86/mce: Avoid unnecessary padding in struct mce_bank
  x86/mce: Define function to extract ErrorAddr from MCA_ADDR
  x86/mce: Add support for Extended Physical Address MCA changes

 arch/x86/include/asm/mce.h         |  4 ++++
 arch/x86/kernel/cpu/mce/amd.c      | 35 ++++++++++++++++++++++--------
 arch/x86/kernel/cpu/mce/core.c     | 20 +++++------------
 arch/x86/kernel/cpu/mce/internal.h | 16 ++++++++++++++
 4 files changed, 52 insertions(+), 23 deletions(-)

-- 
2.17.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795774FE4FA
	for <lists+linux-edac@lfdr.de>; Tue, 12 Apr 2022 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiDLPnj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Apr 2022 11:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357205AbiDLPnf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 12 Apr 2022 11:43:35 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7029B5FF0E;
        Tue, 12 Apr 2022 08:41:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ji9p3k+DZNSkPSFRD4DA1jqza+5s1gUPzla0dzs1tqGPMolaV8uvDVblnk+XcCxYwm5sIOzBagqMRDd4kS422e507Rdtf+jS061xuZnbj5L6ZJOt7LQw9frYm6kKIEiCE1XhMY2gXrKZ9LxzEOZVOnF17/X8vA5EZFMVQ3H+fvlZ6+B3PGNskvL4ruBdPzkCdwvYDCpLzdnjZeNn24P8AH8ooKn6h+4uzp4Tr49qGSDnQRapdHdbGTjGDwmNkMYVlpdyguF3z1Gr1WWYSynEjGhoanJqniTRTgAAokJcecS/IaZ+5dUmIuKdyppWJoqM/GpRLyQR9zcCTN4p+3mjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwS8/y7TLBaZ8jiuFYLOUTUxrfzCDNkakjMKigS8Qqs=;
 b=iherAi5NAfFKTI2BkSsmtZuAAOswch9C8Zz09KvDHcelpuW99niyf7izIy2x2SY7jjrT++id44i8HN5lFtw3L7wAsmT8YxcT1q88QzEHeYy2JNOdFi1eOwho4zfviVcQhwuZwy6p8EYiOxbn0sxq9g3JYvR89C/vZk6X57xnF75op/nq1Kv2YpsSydPeCQfh3BT36J88wdAHnzzqYAZJX/Dt0x7u82cScfON2dlXGaX/0UZ/ROTuqfPbLCA//ZN8x+1GAod31ib4+Zud+uLd7LGhlXWoJ/QzoyVFtws8anfBfKovWFduFAlz5H8onpryHdSdIVMM5KEgvOQ5z1XMrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwS8/y7TLBaZ8jiuFYLOUTUxrfzCDNkakjMKigS8Qqs=;
 b=AaYSB4JvUGRW6SpqKA0KS+MqECYQFde44pjMcmunKem/KFu7HEZVnCkYOhTxjK5YM7dz/f5Co7XO/AwXLfZgSZUODWKglQDWEpuqI6HXu6O9PScirlPwy8+m3BXQuPOyZVCOjeJiyOlO6mBUxyl4x5snZSBmWB9Df4BrQPv39sk=
Received: from MW4PR04CA0376.namprd04.prod.outlook.com (2603:10b6:303:81::21)
 by CY4PR12MB1541.namprd12.prod.outlook.com (2603:10b6:910:7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 15:41:02 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::53) by MW4PR04CA0376.outlook.office365.com
 (2603:10b6:303:81::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18 via Frontend
 Transport; Tue, 12 Apr 2022 15:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Tue, 12 Apr 2022 15:41:01 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 12 Apr
 2022 10:40:57 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <x86@kernel.org>
CC:     Tony Luck <tony.luck@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        <hpa@zytor.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v5 0/2] x86/mce: Support extended MCA_ADDR address on SMCA systems
Date:   Tue, 12 Apr 2022 10:40:36 -0500
Message-ID: <20220412154038.261750-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 454b51a0-977c-46bd-c359-08da1c9ad92b
X-MS-TrafficTypeDiagnostic: CY4PR12MB1541:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB154151116CFE83BD53AB7A9090ED9@CY4PR12MB1541.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkpTMFgzQCDTGA4JQbGSPUg3thEU1/R//MoWeMBg/6kMTrzcDEnirHK7m+D/DhFluLPb0BfeDt8aTPIhPDRylrYE2y88LUz2+MquOejTcUKONbmfB5XYaBClduN7NG8b2mHAdX/nTYXBpD9/+0k+8HrM1ACP5MiJXvVr7iDYGCLMkdKg8KraXYUPADYqRxrFtjTD4sOYcCEbw0Lsadiu4I3Zx7GmTfpHS2w5Qh2ql3d4MnADUrezjIKoBrGyYlAI0D2y7qt14mv5QZYZ60zHoFo8ySPeOIJQRelJ+VHr3UMdCodETJr78JJo7WmfJMUo/vrR753GCQ0D91U7OShS0foqAhu5XdvEbRFM1Enk0hm2vA/ivrIzfYQiSJX9lEr8kSSpJKW8ienf/CexpfJ2QAdO69+nQ9ZKH2nfgwlSsjxXnsofJqY+89gawEw595ySvzwPYOMdXkKtSvRztxYeOgaVGHMV82Gc5y5Jz0u23yCFjhu53X+nnuaGNoiQcoOVCzHjF+RoSGbJJVVvbIA3o1+vWmYDUrpo455RtYPYM8usvmYX5Uy030zKnK+XRUHfrZIpStvqkkTYxqYDL3Bq6iGTBYjUTaEU4/yXEyMCvFta66QEqfpJEa3S/emt+d5Ts0xI+xBVtDK5hkZTqKtMI1/B4dqgdTKjh9IaMNZj0a6z//5JCsqmNDP+StMQWx2FXb2y4WCXQB6JN2N+5CfiUnDd1ZQvxE/QdT+9Sd/abKygoYQ2OxyPfYpm684dJnkJ4Ae1dkAHsFIgVS53SI6DBWrjIIEX8flrw25LjUyXzK8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(1076003)(8676002)(70206006)(70586007)(2616005)(83380400001)(4326008)(16526019)(26005)(47076005)(336012)(426003)(86362001)(5660300002)(36756003)(508600001)(54906003)(966005)(110136005)(8936002)(82310400005)(186003)(4744005)(81166007)(316002)(7696005)(36860700001)(40460700003)(6666004)(2906002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 15:41:01.8536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 454b51a0-977c-46bd-c359-08da1c9ad92b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1541
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
AMD CPUs.

The first patch defines a separate helper function to extract
MCA_ADDR[ErrorAddr]. And the second patch adds support for extended
ErrorAddr bits in MCA_ADDR.

Link:
https://lkml.kernel.org/r/20220225193342.215780-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (2):
  x86/mce: Define function to extract ErrorAddr from MCA_ADDR
  x86/mce: Add support for Extended Physical Address MCA changes

 arch/x86/kernel/cpu/mce/amd.c      | 21 ++++++++-------
 arch/x86/kernel/cpu/mce/core.c     | 21 ++++-----------
 arch/x86/kernel/cpu/mce/internal.h | 41 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 25 deletions(-)

-- 
2.17.1


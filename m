Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2474E987C
	for <lists+linux-edac@lfdr.de>; Mon, 28 Mar 2022 15:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243346AbiC1NoA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Mar 2022 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242534AbiC1Nn7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Mar 2022 09:43:59 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F4431532;
        Mon, 28 Mar 2022 06:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G4Xj+gH77sZpP3rD//WqX/YbeerQNgQQ/gbhE9bA8gFAYEgtgbhb6eZwmQ7lI7WONaJjSR/akm8OAyjAM7LmmTLvp+xX9DtQ6UszKcOMJgq7x8AKlSXhya4mTRzx4ezvu6bPEQCiHfb0EXDJDfJS2kqXldM9FN4Xb5XzkfkFBbgmzKdBHBiCSjkyszEm9SuZsFHP6fAslYsUDZnbhWVtTQ+dKQUZE5QY7h/+f3bmQmtHvdWpZDWuTKBqjDeJLiZhSFQI++SBRvsadsJqZAwCJTsEIwStMhw/ao/KD8Qfxnj4oxcGgwQpqf6gZyDW9VmuZV/UvN5OnXs2M2dXzAg0Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZXLVIVbqF4RbQOI4q+BsXI7fhdCVIQq1TyR3gB0j8Y=;
 b=dfxmrp4ZRIFp+WsDdBMQo6yGN06gQP3918Br0wgoyeFxaEls0Ht1tWsG2Dyp43mcHgFuDho4qd1VscCTq0K7oiomqMJhrgeaQkiDH1blL/H6Qv/lG84FsKFTFo/m9ID35GircfaOC+p1a6QTPA3iSb9QfdJNRwBi7bykqTKqrU4tR4KMbb7oEiCN2X+cxWx7Wure6Rc/BdD1bjx5Yu7X2wnIgf9xlc8l0K/hpO7gEIBOob0WCoxK0WpYEsKVyyR23ufynD2wd/RA3z3XBRkhoAz4KJiAiT8RjrBvLQbmRC+cBmM8neVliWlFpxdICF89L83oog/7T2THi6c/LZORpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZXLVIVbqF4RbQOI4q+BsXI7fhdCVIQq1TyR3gB0j8Y=;
 b=2/UOhbkUZwajChTvp9srFakG//ZmnQY+XMlyy2z+tfWSR7V6ojP72/i8XQaR8nKD3i2aGl5YesCw9qXPiThEvkgRU7GQUemd1QVJs3xzdBSoa/r+WeU+5q8iI8DuG3sXW2lqBGyipctji1iBba3z4Vy1dMmuWC2dIX2lhEcRt0w=
Received: from DM5PR12CA0024.namprd12.prod.outlook.com (2603:10b6:4:1::34) by
 DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Mon, 28 Mar 2022 13:42:12 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::b9) by DM5PR12CA0024.outlook.office365.com
 (2603:10b6:4:1::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Mon, 28 Mar 2022 13:42:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 13:42:11 +0000
Received: from ethanolx1ade-milan-genesis.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 28 Mar 2022 08:42:10 -0500
From:   Carlos Bilbao <carlos.bilbao@amd.com>
To:     <bp@alien8.de>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        <yazen.ghannam@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <bilbao@vt.edu>,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: [PATCH 0/2] x86/mce: Grade new machine errors for AMD MCEs and include messages for panic cases
Date:   Mon, 28 Mar 2022 08:41:30 -0500
Message-ID: <20220328134131.736572-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 560adef2-ce4e-49a0-f03c-08da10c0c2b3
X-MS-TrafficTypeDiagnostic: DS7PR12MB6007:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6007373A2F57FE61BFC003F1F81D9@DS7PR12MB6007.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A7ABP0wFddJrCRQy4igQaUPFiDCEnVn6aDAAZPWgg67a+3SNF7GG4A1K0810n+VIW4wwSMQ79GUchOxPKKsB5NXgKiFBO+kpyeXsrY6VrD3LXECxC/Tkpf1kFewZ8JIma7T0vFsZjdmbvBXL97KPYdkNcJm+l31c4XzdRRlOGUlKXygLNDj2EuUgC7JQfFtCn26MbnejDaHqRRuqD06uAneVLMLH5BT+h6lAt1ymnYxP1FPMib9NpIe0uF0IKh/uiZ5Jp3LRjRObPuo0xRf2OTVaUj7xtUsu5Jugh5I5IMIRYUBoDzBfmmvYTQOoD8T/NDTB3UDb0JMYZDKYUVWRi+CFreEGnlFmHfzlApeflG1vFHGEJDn5/xR1/7TvsIqT3NlI0AWmrdOUY2xtPia2iILhCOO7Alm8ckx5B4kDmANxhYBj5uIPqSJbUAxTR7KoSmrQ/KP+7Izzs8NIb0YulZswE7Dc7BPozNgxvhtmGryssoq09CNaEiw6TdIoREKazyqU1Gb0zgu0DgyfkVHSDLlTAObzgAkTAsymH7ZflRu3ufxiPV8H4H2sq4xlEn9YfONHnQd9OuQ0w3ONETcYwhxykwtE0CJqoXRYEDD6Hrv6FVeSmU+i8k9lKEfLHjJu9EOcMc3Am7TqCo4I8AZfd5GGBbO6fnMHea+YGjxufEUMzprlIawi7mrXLTfL/UwUlMlMHLenXgnnjsAiAgCccg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(36860700001)(86362001)(82310400004)(2616005)(6666004)(4744005)(40460700003)(15650500001)(44832011)(356005)(2906002)(508600001)(5660300002)(81166007)(83380400001)(6916009)(47076005)(7696005)(26005)(1076003)(186003)(16526019)(336012)(426003)(70586007)(4326008)(36756003)(8676002)(54906003)(316002)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 13:42:11.1590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 560adef2-ce4e-49a0-f03c-08da10c0c2b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
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


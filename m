Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A5673A1CC
	for <lists+linux-edac@lfdr.de>; Thu, 22 Jun 2023 15:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjFVNTB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 22 Jun 2023 09:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjFVNTA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 22 Jun 2023 09:19:00 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87EB198;
        Thu, 22 Jun 2023 06:18:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZZRSICMeZLBOWzrL0IwA2W9PtQp3R51/9sqMHW1whF9JvaQtxl9gF715BrxPCsc+WbzVHYmw45T61KSWk4khXqWCvf7wN1PPIpRTzYiJsYSVvuCAj42OZpjkJEW01MFeErzxfueURCbwux8sMZB7sQsthfYJHj+qyMGm9wkCDIQM+kJFX8BlD2P1+pKTqp/py4R2WkTYKKlklwd4RM4b4Ei42TPlVY4d7Em64fDdehxHRxEhX8zFwdIuZktpn6kEMFF3qeHlQ+CIx/JbCt28jccYcBsYlLyq9ui3E5tWsohc62Jas6qCEPPMuLfdkeZ512IKkkl1QstKKwdUpXAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlrOmfLn+NvAlllmMzMQNKC5r8v74GWx86kAp1hxfQk=;
 b=YPa+6P9IHqvoCFr2CG2mDUB7zbQzuI9ZwTWFoaRUWuIWYBB11T4uSquz23/N5teKzaWdUW8EWFn2iu7I3c2fyJyUu+3ua5P9MwsOiM852Xr6NeQUt9niiM+hKXI7LOdjBhGlbmczd6BtcKLlK3LlKqpDrMlST5CIrgblnL1pQ7VUYw2IhMqo1HkYC0OS40kWAQonapf7p3dQ4TVUufDlpnWGxlyIcpRj7o0HqL+zvWG2mqHnImXVpZkFVSSdP9rX/nJJA7L/JXeZp9XeuH2A+9MSV6P4RejOSmHlPmEvo9WCmeF4G+uEeJiv78a791qm4pkQdM0GURlhlIF83yaUZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlrOmfLn+NvAlllmMzMQNKC5r8v74GWx86kAp1hxfQk=;
 b=e4TioGywxP6uYo+VnnaOcKtvYIhnYU8EFnrXqkxaidYIufcRc8PKm2JMN1HrGKpHkT02N0HU16M5a9CBO8Knxx3hSpsb3g4SAufK1QhGattRbbyNXO+oz5XjvC5HyC3sJT82sV1CZPXvy+OHbjuBxA3CjOJg03dBgV9wxkRWSdk=
Received: from DM5PR08CA0047.namprd08.prod.outlook.com (2603:10b6:4:60::36) by
 MN2PR12MB4486.namprd12.prod.outlook.com (2603:10b6:208:263::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 13:18:54 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:4:60:cafe::84) by DM5PR08CA0047.outlook.office365.com
 (2603:10b6:4:60::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 13:18:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 13:18:53 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 08:18:52 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH 0/2] SMCA CPER Fixes
Date:   Thu, 22 Jun 2023 08:18:39 -0500
Message-ID: <20230622131841.3153672-1-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MN2PR12MB4486:EE_
X-MS-Office365-Filtering-Correlation-Id: 112c9394-045d-4c28-fe55-08db732339ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iAcBc/nOVTm2C77kIryU2T/KQi0A5+vqoH/Mxci0B0kjFhhG846tQZhEZ5P+q0rLPdQZaZSp8hOzd2cIaHe/Oul/GIPH5Ixor+/1LK+C1Qd9eAQksV5lO2bEgVn4l9HWPvW0067VKeVjN2oAAlmQ275B50rJRedfvgfbt+2a87d7auSrcyu5MvRkcyN/Nge5nM8yI9AHgsQeny6bQTYIKAOishR6Ie3UPrORGhi9HZSKrw9rjdiyN/OSZhxm60aCrvONQFZyE26bgeswZECK3csKJWrxgzgyHF9i9Sa1vl5HkAlKIOV0t/dphk/oPkiUOzu6cCDWKz7LfZjJ9zjCbSCw84HctzEzJhDbP+ki1OrTb9dYigbc9dNVf4fSdKbkE3MadvegBKAHgvGVOIQrwwtoPpEUgoBb8Md19jydMS7n5XBiDuidhlkk+AzVqmi4kW0MmBfG0iokQxS7auxWwElgeZaUe9c+uSD9HwUIC4To2ZRIg5Wm8PNPb+z9+fAcZXrJVshhs1jU5Bnxs1XCyyidHKXRsVjeY4KmjV9Vz0a75U24TRB3r+xLYrJZbOMLTjAClQaU+5pzjiZdQiwP0J89j1TOsdNjiaDYwdfKyv7voUGevMhTv7UQSyT2u5JR07CYWVqRRATnMqHlLvzbJmaskL5h9/4M0qMrIDrQ3zIgovlUS23LZv8rV1sME2WdtQg1glQ9ns65r4HwstKctPv7i+7NbpSg8+ZjvrKk44YRkktSpU9kJ47qr6RTehrtUNz0NRix1EFqGECGdaVX/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(7696005)(6666004)(966005)(426003)(336012)(47076005)(83380400001)(16526019)(2616005)(186003)(26005)(1076003)(40480700001)(36860700001)(86362001)(5660300002)(40460700003)(44832011)(36756003)(2906002)(4744005)(70586007)(4326008)(6916009)(70206006)(478600001)(82740400003)(54906003)(81166007)(8676002)(8936002)(41300700001)(316002)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 13:18:53.5511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 112c9394-045d-4c28-fe55-08db732339ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4486
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi all,

This set is a follow up to the patch linked below. It fixes two issues
in SMCA CPER decoding. The original patch attempted to address both
issues, but those changes may cause issues during runtime CPER decoding.

I reused the commit message between the two patches in this set, since
the context is almost identical.

Thanks,
Yazen

Link:
https://lore.kernel.org/r/20230417162006.3292715-1-yazen.ghannam@amd.com

Yazen Ghannam (2):
  x86/mce: Disable preemption for CPER decoding
  x86/mce: Set correct PPIN for CPER decoding

 arch/x86/kernel/cpu/mce/apei.c | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.34.1


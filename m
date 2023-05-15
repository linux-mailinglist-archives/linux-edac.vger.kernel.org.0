Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24D3E702BA8
	for <lists+linux-edac@lfdr.de>; Mon, 15 May 2023 13:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbjEOLkC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 May 2023 07:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbjEOLiA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 15 May 2023 07:38:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1809A1FEA;
        Mon, 15 May 2023 04:36:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B6CBTETQ27yBgZ0pTOXSjqP/ctNiItV0laByrxriEWQDJ3qMD9v4eVBDqHXRXjVdAnabU4eiOi+l+i0pfYfsrUTj0RH+znO36gNyGK/gpUcUWXGVTxS1WZbyLNyd6gh+PKE7IyyAC8TRGUfmChraRKZRfjj8MbmRpHmlqGQjxwL/alck/DZUMgqPXzUdTNODjzcv6Ft2Ql2H3xqwDAFaEkhuhiC6lyYTQfRJIQj9F8LMFTCaKTjXUv4KxkJFFfjSAv5f/3UfGwYL6DAa2CDw6llhfvieSx/f+AhTo60lW1omliV3gdQtP+Z9wzEnvagdWK7F+4knhIPmcSk70aYncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyX2vk4DIeH85+YwVNj4EKx5H+HbzveaWJthZjp1SrM=;
 b=MD8+3hkTl+gc7t97nSerx02aJJoVxHxsYepcE5sPiQUjQxhjMgqX+SErNDJWKnhoQE1m7DBeu2S3br9SxIAgrjmItyTP87TPUmqh5XEWxjA9AC6R0px+WKfgykyltKr+a7rpItZ4uPlYLivJqhrRc3+38JXYcpltbcipiI0KO+2L6ZQSgdceU7uFxnDGKEserSFL8baeMGw7DBDpwEPl5hoaNbcfIGmWBOyI5XxNfT6WSkudIyN3gOXnU8CbkZ8UdH3zHFR+UmGy5BQDi94C+318JXHy8JUGLeuDenH1E8I6R19huzWgZ1ApU0DK76xvTSrFZktA6k23a7qpBNIIFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyX2vk4DIeH85+YwVNj4EKx5H+HbzveaWJthZjp1SrM=;
 b=0CEB3DzbXwiyzPYDlGpiIleQMuat3mHMVeLOQHNjTTFx2yIAAg+2xM9IMeBO5nJbYWo8e29vBopgqyAAzMDdYVZoyt4dG5i9IWAgfoiU5O1zXwcTso9aXFdSk61p503icPQRxre6TrL/4+kGMpLTC96SJ9eGxW+bUq7uypbCl+A=
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.29; Mon, 15 May
 2023 11:36:00 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33f:cafe::d8) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.14 via Frontend
 Transport; Mon, 15 May 2023 11:36:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.14 via Frontend Transport; Mon, 15 May 2023 11:35:59 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 15 May
 2023 06:35:56 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>, <nchatrad@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 1/5] x86/amd_nb: Add MI200 PCI IDs
Date:   Mon, 15 May 2023 11:35:33 +0000
Message-ID: <20230515113537.1052146-2-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515113537.1052146-1-muralimk@amd.com>
References: <20230515113537.1052146-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT014:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 34b6fcc0-6485-4b05-bf2a-08db55388e6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bai6wU4+SewpNXxpfCS6cqTuYsSBOOKMlD7cAG2cpbPNNKKjuAU5FZHnH3AbcTZd0bAhK7eN8nKVNhOXdzbTuWkXTHPNA1X+K6SC9CF5Pp6+6UcJyNx54oOrmROdih/23wZupVQdNXWaeP+j0AOBH1cs3b7N5FYnRb4ZeiAJH/gwwMUNvhPI+r1oCmckhkNHSeYVGYI/aal6f13zCHKeFnx8O0PT0UfEofhJpbkUn+U9+QKxie1csjLWPkbe536lwm2DhJM2XSeKriwHOkclb0KbTpXZaMq0SLaW0EFQunQ0coeV0FpAIt0iZUwRumqUzX06cX9gkH/e0QcyuXHn4DypOPOkYJKf0aWlal2z00ZQuTQW+cAsa48gT5K4XCjMFoelzSA+RekSCdLqqmgbFdSOCNMeM6QQlB+FoHkz1/kvyoygDqI5NVpcraM/L8WyGmE3wvKiNyNPPE4pZTZ0x9reXGosLZ5UWbF+YsFm5DXXo7yV0injExV70c8/6Ogy0gUWCk94lC4GYgX4g9svdQ6TyJOZhwNCgVLjMEGKTiB6BaScbJLPqHguukP1gSWmFgwQWM3/+OWwxKmY0vxhthtzOtjwLkXM7GFkUaSZyIEE9n3DaijFQmVWK/Qc1yXJOKkidTzC3JCXQM0HFC9RXWn8XJej+Dc0Mhp0WoCNbMbDVlzGT6XYlVsk6dt5d7AqsDHS3J2fb4OhlB1ktnYl8tHg/sFp+Y1Jg1hrcKjo7vykurRu9gqITVolApVzkSQOGMzVge1NzGQjNRRhdFK6rQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(356005)(81166007)(82310400005)(82740400003)(36756003)(40460700003)(41300700001)(4326008)(316002)(5660300002)(8936002)(8676002)(54906003)(26005)(186003)(1076003)(16526019)(40480700001)(47076005)(336012)(426003)(2616005)(2906002)(70586007)(70206006)(7696005)(110136005)(478600001)(6666004)(83380400001)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 11:35:59.8493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b6fcc0-6485-4b05-bf2a-08db55388e6f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The AMD Instinct™ MI200 series accelerators are the data center GPUs.
The MI200 (Aldebaran) series of accelerator devices include Unified
Memory Controllers and a data fabric similar to those used in AMD x86
CPU products. The memory controllers report errors using MCA, though
these errors are generally handled through GPU drivers that directly
manage the accelerator device.

In some configurations, memory errors from these devices will be
reported through MCA and managed by x86 CPUs. The OS is expected to
handle these errors in similar fashion to MCA errors originating from
memory controllers on x86 CPUs. In Linux, this flow includes passing MCA
errors to a notifier chain that with handlers in the EDAC subsystem.

The AMD64 EDAC module requires information from the memory controllers
and data fabric in order to provide detailed decoding of memory errors.
The information is read from hardware registers accessed through
interfaces in the data fabric.

The accelerator data fabrics are visible to the host x86 CPUs as PCI
devices just like x86 CPU data fabrics are already. However, the
accelerator fabrics have new and unique PCI IDs.

Add PCI IDs for the MI200 (Aldebaran) series of accelerator devices in
order to enable EDAC support. The data fabrics of the accelerator
devices will be enumerated as any other fabric already supported.
System-specific implementation details will be handled within the AMD64
EDAC module.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Co-developed-by: Muralidhara M K <muralidhara.mk@amd.com>
Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 7e331e8f3692..8fd955414b08 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -23,6 +23,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_ROOT	0x14a4
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT	0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT	0x14e8
+#define PCI_DEVICE_ID_AMD_MI200_ROOT	0x14bb
 #define PCI_DEVICE_ID_AMD_17H_DF_F4	0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
@@ -37,6 +38,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F4 0x14e4
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4 0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4 0x12fc
+#define PCI_DEVICE_ID_AMD_MI200_DF_F4	0x14d4
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -53,6 +55,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
 	{}
 };
 
@@ -81,6 +84,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
 	{}
 };
 
@@ -101,6 +105,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 95f33dadb2be..a99b1fcfc617 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -568,6 +568,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_DF_F3 0x14e3
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
+#define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1


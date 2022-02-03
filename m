Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C354A8ABC
	for <lists+linux-edac@lfdr.de>; Thu,  3 Feb 2022 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353149AbiBCRui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 3 Feb 2022 12:50:38 -0500
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:37942
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353106AbiBCRub (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 3 Feb 2022 12:50:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzDvuTKYvAQgyW6mwRv9jfgjm+hhDJmWmUidKUhDpKoNmJR0lpxQ0mSxcfXLTgiKgRePYV/f2CTZcGABSGvhsWwX+2LPKjx9fhWQ3UVFel/wgU1BSOfoblfJ9/SwYNStRjUjWt4RCyfGzbH9tRBgVtw/+uzCQfajG0PpubaEAWKLqfrUMVpipYX10idTG+gABL4pgISqye0+SwpToewUQGvKy+oGu5Fe1+Wj4yDk1JA5TKRWQiGe6L7/yrDzmV/cgfQCjnkAiv7ge5US6zUuCzPfr15I4CoWQUC85LiO+1r69ckOz5X3278+SFCmNFWPFYRlH2bP+63XfrNLG4/cXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHcmQDJY382Etk+UetJPyuSWyfrvCxqg1WVaZTwszDQ=;
 b=ZGkG5fiesmDlcA3zOqr7Mg1dDVBunl/x6Hi5p+cmsa5InpkCPfbnaoueOc4FKOoFfyciMIqk6SZATN9O93FdOl1FoKZsR8X5rDSUe+5+RIYrSq5oT7NxWjqOLOj8Bq6j2bc1FP+Y1U09bcoIn4ERPJXKrGa3p3P14UIJtXxs9AEozYD3YK2JwHdLLTphPxvERbDytrXvSQpgt3cam0XeTJ81dK3EU1BpOUApDgr1C6gtOtk7fctUdjTIRi4GAPJYFY5o6UmOl3F1dloDKgJbIn4c+C5INYRc95tUiHteafF6qMbJOsrbARsUzt6Q7pxQKQPjMHXQ1sFrWBFb4W9CuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHcmQDJY382Etk+UetJPyuSWyfrvCxqg1WVaZTwszDQ=;
 b=Rlryp28nF7bA5wi7yfYdWGmKYPhQ5M6kp/xQ/lo6O6RwNiJ2CKPz8j42utrh8WKYUL7qDhK1YdT5DYXpiCFimjut00Uts3zVOC+4HG4kG5k6vYzNrEUrAemSeLG7vfo8xRON8xXSU4D88sQLCD44c2Kv4ftfBMxqlsKczAW1zu8=
Received: from MW4PR02CA0021.namprd02.prod.outlook.com (2603:10b6:303:16d::31)
 by CY4PR1201MB0149.namprd12.prod.outlook.com (2603:10b6:910:1c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 3 Feb
 2022 17:50:29 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::d7) by MW4PR02CA0021.outlook.office365.com
 (2603:10b6:303:16d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Thu, 3 Feb 2022 17:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Thu, 3 Feb 2022 17:50:29 +0000
Received: from node-bp128-r03d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Feb
 2022 11:50:25 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: [PATCH v7 06/12] EDAC/amd64: Add AMD heterogeneous family 19h Model 30h-3fh
Date:   Thu, 3 Feb 2022 11:49:36 -0600
Message-ID: <20220203174942.31630-7-nchatrad@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203174942.31630-1-nchatrad@amd.com>
References: <20220203174942.31630-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a2762de-1ebf-456d-7d3a-08d9e73daaf9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0149:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0149C7C9A72E8D9553B58787E8289@CY4PR1201MB0149.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50LxJqP7LsH+49Ko0cEzbocPiNptKtHT2k+BCClEUXmzTYOkFQQt4S9JUrkYoNG/mgsAysWe+9IeW6dj2luBEb/uUMBx/9u1V2AdQD+trxSXL0goIv8g8XbVXjFU6dcR/qAXz4kwqQVHZtKwXoaX8kmoh8FyNr/9dKTGUI5dGdJE2cQ5F5UlwjZxmhpclarhtzpUg/MDJLqCSl+Hti0rFmh+YA3z2Y5uqI+yrvPpZ+0Wf7tAN1zUrmio8ml2lkCsVPwyS9RDgVEsK3dZ1EmiCG9RqvuOstyLV0VgKuZ8zXRVqgIEUyi2atLMF/Bsi1egfvm5IdTScx+ONfsu7e9Q4JYLp9q+QSDS7wqm+0Z7Exl3HJATF0DS1YsJ8sxONT4kWPnl8v8jNAd19BmJgTcNiSEzviBMVWpytgEDDkMhRYIIUocWP+jJ7ZO3/q957EyHRY2RqB3NMg2D/P997OCfocCtEM6W1LCJAtXbSXIgD7zTdUz3nZvsDkyD5FZxfrqIpv14VCZsrEw5/iTslUNdwayt9vabAsSD+s6ixN/tDJcruCdlWID2Wc6VG2O9HTDxVTvdwb3SnV1JMqjn+LrEkjt3PT+GqCAlNSJUWxiVQLJLGJhoiHLvD8eRsRP+7XraoP2IGBv417DyPs5cytYrQUleOAsRVE/2M8/n98hEkvEfYYsQtMoPHVMyQ4N5AXPp7dPScOdZNwo7uujJoBC8XGO2wzcmhGbx0BpObP9wriNC1KFCOMvkR3EBUf0vy+nkA4ymFIDyv6Bu7g1Dy6rnt0/1vicbXihzuI0MiOyAmRM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(966005)(82310400004)(316002)(81166007)(356005)(40460700003)(2906002)(110136005)(54906003)(83380400001)(6666004)(7696005)(36756003)(47076005)(336012)(186003)(26005)(1076003)(8936002)(426003)(2616005)(5660300002)(16526019)(508600001)(70206006)(70586007)(36860700001)(4326008)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 17:50:29.5259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2762de-1ebf-456d-7d3a-08d9e73daaf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

On heterogeneous systems with AMD CPUs, the data fabrics of the GPUs
are connected directly via custom links.

One such system, where Aldebaran GPU nodes are connected to the
Family 19h, model 30h family of CPU nodes.

Aldebaran GPU support was added to DRM framework
https://lists.freedesktop.org/archives/amd-gfx/2021-February/059694.html

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Link:
https://lkml.kernel.org/r/20211028130106.15701-6-nchatrad@amd.com

v6->v7:
* split the model specific assignments in patch 5 of v6 series
  


 drivers/edac/amd64_edac.c | 14 ++++++++++++++
 drivers/edac/amd64_edac.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index babd25f29845..54af7e38d26c 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -4454,6 +4454,19 @@ static void per_family_init(struct amd64_pvt *pvt)
 			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F0;
 			pvt->f6_id			= PCI_DEVICE_ID_AMD_19H_M10H_DF_F6;
 			pvt->max_mcs			= 2;
+		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
+			if (pvt->mc_node_id >= amd_nb_num()) {
+				pvt->ctl_name		= "ALDEBARAN";
+				pvt->f0_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0;
+				pvt->f6_id		= PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6;
+				pvt->max_mcs		= 4;
+				goto end_fam;
+			} else {
+				pvt->ctl_name		= "F19h_M30h";
+				pvt->f0_id		= PCI_DEVICE_ID_AMD_19H_DF_F0;
+				pvt->f6_id		= PCI_DEVICE_ID_AMD_19H_DF_F6;
+				pvt->max_mcs		= 8;
+			}
 		} else {
 			pvt->ctl_name			= "F19h";
 			pvt->f0_id			= PCI_DEVICE_ID_AMD_19H_DF_F0;
@@ -4476,6 +4489,7 @@ static void per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->get_mc_regs			= __read_mc_regs_df;
 		pvt->ops->populate_csrows		= init_csrows_df;
 		pvt->ops->get_umc_err_info		= update_umc_err_info;
+ end_fam:
 		break;
 
 	default:
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 07ff2c6c17c5..66f7b5d45a37 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -130,6 +130,8 @@
 #define PCI_DEVICE_ID_AMD_19H_M10H_DF_F6 0x14b3
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F0 0x166a
 #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F6 0x1670
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F0 0x14d0
+#define PCI_DEVICE_ID_AMD_ALDEBARAN_DF_F6 0x14d6
 
 /*
  * Function 1 - Address Map
-- 
2.25.1


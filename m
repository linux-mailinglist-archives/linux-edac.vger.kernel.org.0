Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5209136520
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgAJB5U (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 9 Jan 2020 20:57:20 -0500
Received: from mail-dm6nam12on2062.outbound.protection.outlook.com ([40.107.243.62]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730720AbgAJB5L (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 9 Jan 2020 20:57:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC6U2jWxqTVzHxJS0sozdz0S1PZbMqbr/a8b2pn/yTJOiPN1KQjlmz0Go50ENHApd2syfCaxUpNpMs4yqRmgCJnxI0PCl32fvSUKjejQBu49EJ+kVieORgtGMGxC0O1z4qDhkY9bW5DBmCOzsAfg54HF4/dhQEXjRIc4dV1P9YMKo+PYi+eT74hA07bg+fQeUlkXVVC9Fj6XQnzcq7zn4iVsxpWAVbuShUpfYY/UqaPRt05Gk/x3u/DPiYxrS4cj6rW9sq1R92+w8H3UNfXcDBIDIMgaAeVVE9O7tSXf80Yz3XiW8R9Bm8uf5sGqPq/Ldkic+Z2aRhrj1DGUV7DsFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amgV/rbCurvFii8a+KVAVoiymxxkS28rRoDdXPoSTnc=;
 b=U3xcGBjLUNWHqz+XqqJCvUvEAiQ27ebAtWF30OxSbTRvbrOSWSuWIvTOka4mKbw9wQ/M+94/+PlwswbmCjnyuWRsEQNYfAQZs9YEvRZ++afgg8mhdqcq3q7JNp9Zz86p+xOXn9IN25kqhXpac0TbQZ4kn6lGZn0PQ1g0aHFLGxfjUFCDkHoxX8AqvlBQgD+221n04fR+FblvhV7zyPff/ZClV0c2zcA5/1UgmgNtRpOvTGh0urG5xwcEKUj0MxCKKMSl/lAxSej1z+SRpfBRRVBOcTUGZ0DheJwGqRx+8NOdE9oOQmwEAh1Q43Fg46HQAdx0QWjq5GFOGARRs4IFmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amgV/rbCurvFii8a+KVAVoiymxxkS28rRoDdXPoSTnc=;
 b=kum/8V4X7857TxEg8wKTMq0bN5rFceb/TBcbyLEvG0ZcUAWZlJjm5fYUPJq7PVhd8KSeqU4qJWUIBUYrK4AiGw/KOHlhMhyq/UbBsyp1QCPtcVETe2Ob8L9Eh6ydDyBULzlDe+Xs/vqeQjfq86qHlqfb+ycqdtCbtW62E0RDyzc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
Received: from BN6PR12MB1667.namprd12.prod.outlook.com (10.172.18.18) by
 BN6PR12MB1378.namprd12.prod.outlook.com (10.168.228.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.11; Fri, 10 Jan 2020 01:57:06 +0000
Received: from BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe]) by BN6PR12MB1667.namprd12.prod.outlook.com
 ([fe80::d536:f1cd:c8d1:fe%12]) with mapi id 15.20.2602.017; Fri, 10 Jan 2020
 01:57:06 +0000
From:   Yazen Ghannam <Yazen.Ghannam@amd.com>
To:     linux-edac@vger.kernel.org
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>,
        linux-kernel@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org
Subject: [PATCH 3/5] x86/amd_nb: Add Family 19h PCI IDs
Date:   Fri, 10 Jan 2020 01:56:49 +0000
Message-Id: <20200110015651.14887-4-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-1-Yazen.Ghannam@amd.com>
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To BN6PR12MB1667.namprd12.prod.outlook.com
 (2603:10b6:405:4::18)
MIME-Version: 1.0
Received: from ethanolx80b6host.amd.com (165.204.78.1) by SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.12 via Frontend Transport; Fri, 10 Jan 2020 01:57:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4a36bfce-6412-4585-9102-08d795706564
X-MS-TrafficTypeDiagnostic: BN6PR12MB1378:|BN6PR12MB1378:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1378F2E74EEE030E08FC5E83F8380@BN6PR12MB1378.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(189003)(199004)(66556008)(2616005)(6916009)(5660300002)(8676002)(86362001)(66946007)(956004)(36756003)(4326008)(1076003)(81166006)(478600001)(26005)(316002)(186003)(8936002)(66476007)(52116002)(16526019)(2906002)(7696005)(6486002)(81156014)(6666004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1378;H:BN6PR12MB1667.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nWwUjysdSOmAB3VVF75XtVSsibpHWkKiOhNeN3f9WBkTs/9Q6aFFSziGpbKs2Fz+vFkHREJ9dbxlr2bGPSseRd+qzxsOyGD/hyR96ztT3bqm8Y/deoGgDfa661FNylRH6MyvGSV9pUegolwtjrp3tNi4aw3Hs2m/wkOJyXi3LFML0ynW/g8NwCdv4bZnVY0wkolL1MpuFVZmglrYqjS3RO28q/YAMWkQ20xJALgLYMguK+lzqZ9vuN3FrRf2S6XqYF3XoKg0zJpyxCnjmQcOxr/YygnynaTpzhR4zUNmp9isADYNvVrOmaqWFnJoPfd9mk5his09ES8oqWC1ftiV9WdPAWDKU7VAbfO2MGnK5Aytt29vsbzlwzOROJ6TMz6NCbNeL/LyVpc+5lUcMoM3jPTbERwVVVNkFcFjHJpBBwnPMrEBylkceyZqdshXN5Br
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a36bfce-6412-4585-9102-08d795706564
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 01:57:06.8308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+SAmHlf4C1Gp2SzWbqr4aAQtcVRGRKXqHxbe0ZIsE0EEkd2xCfZMJzgYp49plq8vn+MwhVICF/Ff+Rqd1LUug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1378
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Add the new PCI Device 18h IDs for AMD Family 19h systems.

Note that Family 19h systems will not have a new PCI root device ID.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/amd_nb.c | 3 +++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 251c795b4eb3..69aed0ebbdfc 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -22,6 +22,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4 0x15ec
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F4 0x1494
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
+#define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
 
 /* Protect the PCI config register pairs used for SMN and DF indirect access. */
 static DEFINE_MUTEX(smn_mutex);
@@ -52,6 +53,7 @@ const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{}
 };
 EXPORT_SYMBOL_GPL(amd_nb_misc_ids);
@@ -66,6 +68,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{}
 };
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2302d133af6f..352c0d708720 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -549,6 +549,7 @@
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F3 0x15eb
 #define PCI_DEVICE_ID_AMD_17H_M30H_DF_F3 0x1493
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
+#define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.17.1


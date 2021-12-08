Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BC46DA42
	for <lists+linux-edac@lfdr.de>; Wed,  8 Dec 2021 18:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235376AbhLHRrt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Dec 2021 12:47:49 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:10624
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230036AbhLHRrs (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Dec 2021 12:47:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO1q7YA+xZl9FzPolaQuZ08+Suah9NIHluer8Tk2VuGx/4PwjBfWSHOQwlRvN0QYI4O6ycyqsQ9vHGRB+FM7SMXEdkOKsixRqpjEBeXnpsSK6lv+ARBYt6XtWveDfAG/ptDqrZs5N3YG97R6Uc8yfoTz2AuRYFmmZ3PMmDCwlMvX20T7VpazTHeOHURqTh17kF8vfP/S3v6V0JKl+2z3Q3sudPH/YOh9WQYytw1Qx/dN5cwHfD89Gs+XLuhjLK1N3nDi7tAV1udSkDnuZWScS5pPMCIGKDZkt4Plad8n6//WdHD6g27atfmysWAjTKA4tV6nQqCwPTLxME8uRlJlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JR/SEZdvJzi+3FY5uGp0t4r7nXvw1QA+QhXHcQolTg=;
 b=ijJIlWRh51zV1SawMMHn7XsqztjyZySIDw9WPGigRee6JI7Y96CT6AjG8QX6RJL1WwrEdENz1Z2KQ66JVFS2Xx4TDK5bZyn37nJucVksaJWjkYh0Y4IabQLGB0GwPsoTNV1yPAVUySZL05ghkvT4NkR45LRTRB4UW61XpqZbCmsEq6notjM5db8JikcghIQGDfiiWyqDZBfiKLeIQYrQZKRhad++bwxTbcMiJdMtJHjeYNTJIw8zfCmHepVSyDzu3GziCrMSiN13WvZaeBZRaE4pO1fN5Nep5fyYR9Dt9NP2SHtrIuylJZmUk5ykfkc8YWYYaUaxTK//2xRvRjtEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JR/SEZdvJzi+3FY5uGp0t4r7nXvw1QA+QhXHcQolTg=;
 b=m5QSLfcfCNaNU1MEbHq6Sl/kEDQ9NmdKqG/WDrBSpl19Q6IHPdysZvB63KSb3H0wPibHC9GWJ7wbVRBpIi0adsWwOO2qZfZEqLTQZ7e63i+48ANR64BUdQgNmzDti70ap6+XvabyRaDE1MLfgwqfHCMJv8in2z1qThik9T9HLmE=
Received: from CO2PR18CA0051.namprd18.prod.outlook.com (2603:10b6:104:2::19)
 by DM6PR12MB4810.namprd12.prod.outlook.com (2603:10b6:5:1f7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 17:44:13 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::72) by CO2PR18CA0051.outlook.office365.com
 (2603:10b6:104:2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Wed, 8 Dec 2021 17:44:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 17:44:13 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 11:44:12 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 1/4] EDAC: Add RDDR5 and LRDDR5 memory types
Date:   Wed, 8 Dec 2021 17:43:53 +0000
Message-ID: <20211208174356.1997855-2-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208174356.1997855-1-yazen.ghannam@amd.com>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80710411-ae93-4b3b-0a86-08d9ba725955
X-MS-TrafficTypeDiagnostic: DM6PR12MB4810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4810BD04D5DFF1BFE71A379FF86F9@DM6PR12MB4810.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tOol6rsw7ZmWe3XJIKgN81IfbnF3q1tvyz4Tr7tNUeerPVc+UmRIOewy7QzCB8+Hxb3d0AdvzepduVlXxrEZ67dePxGOHZyOSXggL68scIJbZYGP6l/QGua7JGB4rY4iOCJcRiOqQVRgcLYTPj+fhqMseGqM5d/IsrrnoaczRhdJwgMkmVZU5l2vo9nf1H2stsN3b4gnSePzDOfXrXQloWP+7lYihMAmDQofKxTV1X9z94XdXVzN//Vg6swrUgU8J1Xnpa12zWn/Gb9cha9HyVn4P4gIW4pUYNmoPLSFm4+Y0ieaVu46lkTmdqOpNCW10hHVUe6BpwbMi8KoeQfsZt4pr0Hc1jBUVHzLMm0AY+IRdWerNiXtF8wFSvzFDuIkMKEEcWRE8wXU7YAMn+eBJyYwsyfo+sxmN4JDw+47tBFY9HV44GhMS8TGKnJfFu9gY+6c9YhodWfFrtW4JF+P/Uqlj1aIgZuA1UtBZyGiv2jTB7HWMFi3GnR5H5sVJFwjw77oy0SN/+3z1l+LWX+dW/HN7BuK4buF1UfGFvliRLXsVZtDxL3FgdzMbao8TUm5TyGRO/FLjJmCQJsuW0dxbod8fmcvvGkjolYDuu3e/WrHU7kT34jch0vbhwiErPmBt2httswUie7hjg9JlxhpLS57bm/3aWnZAUL2ehRumvZqAqSqrnkEnqYlaAb8Ei0H/QzSLFeERF8vAl34o3vAzFT94hrdGPsnDopMXC+Lq0XQqrf5i10RsltWsnRyszbTWPOzV1K/GQtmfp3dX8UZzUhj5mIxgJuUuteI8BsUP+M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(1076003)(508600001)(36860700001)(336012)(426003)(6666004)(4326008)(44832011)(54906003)(2906002)(316002)(86362001)(47076005)(5660300002)(36756003)(2616005)(16526019)(82310400004)(8676002)(6916009)(81166007)(26005)(8936002)(186003)(356005)(40460700001)(7696005)(70206006)(70586007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:44:13.5857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80710411-ae93-4b3b-0a86-08d9ba725955
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4810
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Include Registered-DDR5 and Load-Reduced DDR5 in the list of memory
types.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/edac_mc.c | 2 ++
 include/linux/edac.h   | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 9f82ca295353..9d9aabdec96b 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -162,6 +162,8 @@ const char * const edac_mem_types[] = {
 	[MEM_LPDDR4]	= "Low-Power-DDR4-RAM",
 	[MEM_LRDDR4]	= "Load-Reduced-DDR4-RAM",
 	[MEM_DDR5]	= "Unbuffered-DDR5",
+	[MEM_RDDR5]	= "Registered-DDR5",
+	[MEM_LRDDR5]	= "Load-Reduced-DDR5-RAM",
 	[MEM_NVDIMM]	= "Non-volatile-RAM",
 	[MEM_WIO2]	= "Wide-IO-2",
 	[MEM_HBM2]	= "High-bandwidth-memory-Gen2",
diff --git a/include/linux/edac.h b/include/linux/edac.h
index 4207d06996a4..e730b3468719 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -182,6 +182,8 @@ static inline char *mc_event_error_type(const unsigned int err_type)
  * @MEM_LRDDR4:		Load-Reduced DDR4 memory.
  * @MEM_LPDDR4:		Low-Power DDR4 memory.
  * @MEM_DDR5:		Unbuffered DDR5 RAM
+ * @MEM_RDDR5:		Registered DDR5 RAM
+ * @MEM_LRDDR5:		Load-Reduced DDR5 memory.
  * @MEM_NVDIMM:		Non-volatile RAM
  * @MEM_WIO2:		Wide I/O 2.
  * @MEM_HBM2:		High bandwidth Memory Gen 2.
@@ -211,6 +213,8 @@ enum mem_type {
 	MEM_LRDDR4,
 	MEM_LPDDR4,
 	MEM_DDR5,
+	MEM_RDDR5,
+	MEM_LRDDR5,
 	MEM_NVDIMM,
 	MEM_WIO2,
 	MEM_HBM2,
@@ -239,6 +243,8 @@ enum mem_type {
 #define MEM_FLAG_LRDDR4         BIT(MEM_LRDDR4)
 #define MEM_FLAG_LPDDR4         BIT(MEM_LPDDR4)
 #define MEM_FLAG_DDR5           BIT(MEM_DDR5)
+#define MEM_FLAG_RDDR5          BIT(MEM_RDDR5)
+#define MEM_FLAG_LRDDR5         BIT(MEM_LRDDR5)
 #define MEM_FLAG_NVDIMM         BIT(MEM_NVDIMM)
 #define MEM_FLAG_WIO2		BIT(MEM_WIO2)
 #define MEM_FLAG_HBM2		BIT(MEM_HBM2)
-- 
2.25.1


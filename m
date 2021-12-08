Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C14246DA44
	for <lists+linux-edac@lfdr.de>; Wed,  8 Dec 2021 18:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235579AbhLHRrw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 8 Dec 2021 12:47:52 -0500
Received: from mail-bn1nam07on2059.outbound.protection.outlook.com ([40.107.212.59]:47033
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235401AbhLHRru (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 8 Dec 2021 12:47:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLQZoor/meOkMJxfvhDAHsIojHEX1C0Jqiqx4KL2tcnnQ04ftWua74eqMMyWi/d5FZ+UxQBmscNs8ZOlIpw5K5DZtFBLYLaBaAp4mMtUXwBlkEygclnZzVpmpST1NoJZk2qdhi9F1bNACyR3yktGfwQqQvJv3YqywLyX2nCMu87fMTTiGPlYIaL5DfagqUAqCfPeij7U31oa9iskJddI5/FgekVp2KDUt7I2N9A4yK9hFoPc3l64MJq1LVLgqAUP0rifQAfOHeSAjmaDW2+u6U+YKc6q2DW/Ekg0LUNoJpzcnDrRwy8q3/MlEBFZxfcT5pSa9WVjXA75NTiOs6Zffw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Goj+uuPDq57eLxDkaIDopv5EBx5amguObWJizmWPw=;
 b=JHq3vzjiptG4ltUgpFioCKxWZjSiYttZTb5lCmOz+8fsWq2AhCfQOe5F/m8hQSesykzkZi/rsvY6DSan81JLOzlfCTz6I7rhi9X9PjxYtHBDcARVqqNHgxgiQLhikEjBgCi2SRwIozygt0oHX5Pi9LSH9WLeUCU52wUOau+d7iNo+BFoi0IXxs9vV026e/di4XzX6oeaoxWfoEZX/1US1KTV5cFynWxvsBlYaJ9SwP9NORwi1DRvbfsSPlaG83uDk4GKzMKPNtW9TZY/++7uDl4SsnWg8OXd3TuGnJf5HPjNQwDEeYJOMXI/RstrV4mGxlWwpGCNQb4f4c+xnLi11w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Goj+uuPDq57eLxDkaIDopv5EBx5amguObWJizmWPw=;
 b=oByEJ/vuc0LFQje1GHkD7DLA3MipUcXgC0g+8b28sxYwjEhD+85+cdlwnYqC7YgTb6AExbDUfSFDNnZjxISLS3pQjiesUvK9U7G3KifhZnubGlZndJP69tOybPndGJW+pIRaqmxUW3O3NIimqqWdpiEnk3HRJ5wjjxuCOt9gmjI=
Received: from CO2PR18CA0059.namprd18.prod.outlook.com (2603:10b6:104:2::27)
 by MN2PR12MB4375.namprd12.prod.outlook.com (2603:10b6:208:24f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Wed, 8 Dec
 2021 17:44:16 +0000
Received: from CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::2a) by CO2PR18CA0059.outlook.office365.com
 (2603:10b6:104:2::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20 via Frontend
 Transport; Wed, 8 Dec 2021 17:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT058.mail.protection.outlook.com (10.13.174.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Wed, 8 Dec 2021 17:44:15 +0000
Received: from yaz-ethanolx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Wed, 8 Dec
 2021 11:44:15 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <william.roche@oracle.com>, "Yazen Ghannam" <yazen.ghannam@amd.com>
Subject: [PATCH 2/4] EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh
Date:   Wed, 8 Dec 2021 17:43:54 +0000
Message-ID: <20211208174356.1997855-3-yazen.ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8ab5cb03-c45a-42b8-1b01-08d9ba725ab1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4375:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4375DBF43F949E53887365A6F86F9@MN2PR12MB4375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNEtb6s0BfAYRiUbGMflavER6V9e7J7S/sgoHdffhkRVHLR2SdbuB59ix+HuHDK5pWsp/q9p43/AFYahdhD/Xdez801MrpO744YR+a1B+RJTjAoquw/UYkbA9xsXbhiSLuyEEgAAY4m2LI+tT3GgTvAiw1pvdNs+6KkIH621erO0DLkoQx7ca98IxPhgZ3+3KIOGqPlFMppcLRp6NKsxBWU9pY89kspqDCisL2QAYgxqAUPDUqaxQYNTGqyhV/5s4YwKlT7y7vH6ajKIMwenfphqfs4TN4rhm9lg/MNy5b0cr7eLHSCGcqIeAEhMeaPRuueRN53Fmx8UOn+6uclacD3HlvU71QbGrxucH4Xq1ZcgFLVed+oZgNlFOcn47HdkSxF0EkeLU6n1XHy2D7cXr5JGecMt5Jxtm/TZNZnIpSAifu4SGbP3wN8FsMqHHy7OWs8VLbY+PByOOIECI3C88iRzhaYrqFpwExaN8mitZ5QkWtpa7rDoY5SptCIpGLkoxyfrLiljN/RrQHSb56JOxzlJvcVDXw0tR2lhzOuEp4PMIcn+SjCX2Q0v8ohTZo9N7nZKFZdZfw5a+nwjIWB4oTGNS8EGbFHzvdTM1j1K/NP21fZS+Ugyip3duqaXY9rj3yAKj4GLKkPdcb1eRXXPFTYp2sloRIUokEil9iscQrXW5xo4UXUgiZlSamh6t6dDiW08AqtIofiqpY+07X6Z0OI5VKiH/nJEZSZ7RTZI7LthLoMWsUDhzpD2nSNp4mpl7Fww33rmyQVv7b/2Rf9u5Bt2/cMrWKRQ05Wn5cFTLHs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(6666004)(356005)(44832011)(86362001)(81166007)(40460700001)(8936002)(2906002)(36756003)(82310400004)(8676002)(4326008)(316002)(1076003)(2616005)(47076005)(70206006)(336012)(7696005)(16526019)(186003)(36860700001)(426003)(26005)(5660300002)(70586007)(508600001)(83380400001)(54906003)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:44:15.8667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab5cb03-c45a-42b8-1b01-08d9ba725ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4375
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Add a new family type for AMD Family 19h Models 10h to 1Fh. Use this new
family type for Models A0h to AFh also.

Increase the maximum number of controllers from 8 to 12.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 21 ++++++++++++++++++++-
 drivers/edac/amd64_edac.h |  5 ++++-
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index ca0c67bc25c6..ff29267e46a6 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -2925,6 +2925,16 @@ static struct amd64_family_type family_types[] = {
 			.dbam_to_cs		= f17_addr_mask_to_cs_size,
 		}
 	},
+	[F19_M10H_CPUS] = {
+		.ctl_name = "F19h_M10h",
+		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
+		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
+		.max_mcs = 12,
+		.ops = {
+			.early_channel_count	= f17_early_channel_count,
+			.dbam_to_cs		= f17_addr_mask_to_cs_size,
+		}
+	},
 };
 
 /*
@@ -3962,11 +3972,20 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		break;
 
 	case 0x19:
-		if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
+		if (pvt->model >= 0x10 && pvt->model <= 0x1f) {
+			fam_type = &family_types[F19_M10H_CPUS];
+			pvt->ops = &family_types[F19_M10H_CPUS].ops;
+			break;
+		} else if (pvt->model >= 0x20 && pvt->model <= 0x2f) {
 			fam_type = &family_types[F17_M70H_CPUS];
 			pvt->ops = &family_types[F17_M70H_CPUS].ops;
 			fam_type->ctl_name = "F19h_M20h";
 			break;
+		} else if (pvt->model >= 0xa0 && pvt->model <= 0xaf) {
+			fam_type = &family_types[F19_M10H_CPUS];
+			pvt->ops = &family_types[F19_M10H_CPUS].ops;
+			fam_type->ctl_name = "F19h_MA0h";
+			break;
 		}
 		fam_type	= &family_types[F19_CPUS];
 		pvt->ops	= &family_types[F19_CPUS].ops;
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 85aa820bc165..650cab401e21 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -96,7 +96,7 @@
 /* Hardware limit on ChipSelect rows per MC and processors per system */
 #define NUM_CHIPSELECTS			8
 #define DRAM_RANGES			8
-#define NUM_CONTROLLERS			8
+#define NUM_CONTROLLERS			12
 
 #define ON true
 #define OFF false
@@ -126,6 +126,8 @@
 #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F6 0x1446
 #define PCI_DEVICE_ID_AMD_19H_DF_F0	0x1650
 #define PCI_DEVICE_ID_AMD_19H_DF_F6	0x1656
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F0 0x14ad
+#define PCI_DEVICE_ID_AMD_19H_M10H_DF_F6 0x14b3
 
 /*
  * Function 1 - Address Map
@@ -298,6 +300,7 @@ enum amd_families {
 	F17_M60H_CPUS,
 	F17_M70H_CPUS,
 	F19_CPUS,
+	F19_M10H_CPUS,
 	NUM_FAMILIES,
 };
 
-- 
2.25.1


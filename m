Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609BA43E7A4
	for <lists+linux-edac@lfdr.de>; Thu, 28 Oct 2021 19:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhJ1SAo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 28 Oct 2021 14:00:44 -0400
Received: from mail-bn8nam11on2049.outbound.protection.outlook.com ([40.107.236.49]:1315
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231216AbhJ1SAh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 28 Oct 2021 14:00:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsPdhPn8zQnnlFcZGWnK8+I4L5al1r8UDX5VlulpQwQm6Mk9w+vj0d5NQzwnY57l12opt/OG7sW5v8MZWrQXCMu5+YGV+splsbt/WmjNCFPkBQb0nXJSca35vANutSKAxjXF75/acS7VWQICN/xmaw6s2kZXIuYSGaBdCe17Ln2Zu0/I8IKoa39aq1ZEe8R+0QC9+OfKsPAWCCvW1HwCfu85Y8zrqwu5GQcnmpVX4HV7JSf+cDRlNwssgqBkDD4+lqwd51n7N7/Q5L56f6sZG51GbfFJgT9R/aCl8VB+P5jaLWEDR7X/PXm2U5XavHXHikm4J3EaLlj1HtZOh7lOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZL6fznkQaBtyOT1nZdyKHEQu3UrQMvRmNHMk6CzGNQ=;
 b=k6F45KyNWOJTjRTlhQfVz3NYbmbf9b7DBTW0JPpAPOQ2m+GzSGq1Szf3x9l5GGPI6giCE+cOkTd8bF7MtfDtgSjdOxBFlasEfGmRXb2xrkD/fs5Vh6lyQLjQn+jgz2BcxDaUgo2nHTn8kPNA8taZFrE0IVP33GF71REjcDfaMR7SmfcZctj6wLuNSijig204t6yA70Mv2l65+DpEBC3KcS+c7uZgH0docLKQ2nfS1QMkUqMxqcnEIDEdOqyw2XsmSjc4puhFBR8HMus0XqNNbPZEb0BXgJx4gxVsiPGS9yYLUo/ukrX/jnchu1VFSKVzaEEHo//c7gC/O+vHrngNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZL6fznkQaBtyOT1nZdyKHEQu3UrQMvRmNHMk6CzGNQ=;
 b=sttid3tzJItiOZ7jGgbfyPRhvD4qUv/Va/St4n5kTYmTbU+AXibHq5i9U4xSwI56QvnxrNnARsurotXEfMoX7jaib8+G9Nj1wPpjv9Y4kgT7C/3GJqs4+hCdr1OrqfnPlTw2vgx1Oikz8SHydiJn0JhZuk/2oMwnjlKjCdnNtRA=
Received: from CO2PR05CA0069.namprd05.prod.outlook.com (2603:10b6:102:2::37)
 by MW2PR12MB2444.namprd12.prod.outlook.com (2603:10b6:907:11::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 28 Oct
 2021 17:58:07 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::73) by CO2PR05CA0069.outlook.office365.com
 (2603:10b6:102:2::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.5 via Frontend
 Transport; Thu, 28 Oct 2021 17:58:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4649.14 via Frontend Transport; Thu, 28 Oct 2021 17:58:06 +0000
Received: from yaz-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 12:58:05 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
        <mchehab@kernel.org>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <rric@kernel.org>, <Smita.KoralahalliChannabasappa@amd.com>,
        <NaveenKrishna.Chatradhi@amd.com>, <Muralidhara.MK@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 05/33] EDAC/amd64: Define Data Fabric operations
Date:   Thu, 28 Oct 2021 17:57:00 +0000
Message-ID: <20211028175728.121452-6-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028175728.121452-1-yazen.ghannam@amd.com>
References: <20211028175728.121452-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e6cc2e98-c6bb-4447-a408-08d99a3c7ee2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2444:
X-Microsoft-Antispam-PRVS: <MW2PR12MB2444ED365C3390DA9BA56076F8869@MW2PR12MB2444.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VdnbHPMHO9jFBieplFicXrn0kpyezMKPB+3mLUK4NVkH70SFbZAjj683B0a6KAOr2sINp/E/jXAOG10za7i9ZNWXjtMJNYsaG7+g1PrWWK6r4Arc04WSpxWUR2H3lPzW6sJLBGoqr3XHJ6Sh2beTzXflm7YLzEmLyIQuNjXQNrj4V2dKHZ3a9Vy/tXbq4CYG11h5A6GJIZCArzkFb1pko/89I2HupsxM3y586145UZPk8POCt7Ixe7eHFjWqS/xJZBPdSpfaXjsTeFhBlrlESpv8hzEbhBy8T2v+8vZGTMpV92uB8oGhS//he0wLC8cWkFAuo03OgbhRZcUIM5wBo07Dt+YmsVFGZnYVDNYx84tKa1EyZurws+1NGQmag0nu4xKndCeUKnwWuJ9y5mo3/7xt7lTJfka7bY5LlEROT1AqdrPCg2ZuyHx2Zc2MEfT8SdDVD3sZe4p88l0T5VQ4/POLcZK8ttAQGp0Y9kS5ADcuDVMKx/v/kfAWjFlPlOGisKjfM6KpSv20IICHZcRNFRqwXGp9Js+59XijM3Pyq0NbZ5RoHUcbiMV1SUkbEheCiv4bpKuwLc3Amjkkt5WpHdgEmR700Xh5GaoI/g6jOWzTrUQixmpB4XPzpiHwhLYpF1pwMetoJgVvFkLFOULDXjO8friG2SZiAgtTLq5+bW8r0HV1gb6D78BkqLotrFeNvpg7VzBjxgGX8dCq8Yylw2iq2R9wwpJRAR5dukbMvEY5XxVZmD0pQ3vgpd4m8uvZda0TfDj/ZEJdQSeji/nQdqcEiHSaKrz8APxmUEFnFZH3VOLsuhwyx56NITbQpzbx
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(54906003)(83380400001)(316002)(47076005)(6666004)(44832011)(336012)(70206006)(356005)(70586007)(966005)(81166007)(6916009)(2906002)(7696005)(5660300002)(36756003)(16526019)(2616005)(186003)(426003)(8676002)(86362001)(1076003)(4326008)(36860700001)(8936002)(26005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2021 17:58:06.5554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cc2e98-c6bb-4447-a408-08d99a3c7ee2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2444
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Define a stub to hold operations for different Data Fabric versions.
This will be filled in following patches.

Set the operations at init-time as appropriate for each model/family
group.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20210623192002.3671647-7-yazen.ghannam@amd.com

v2->v3:
* Was patch 6 in v2.
* "df_ops" is set at init time.

v1->v2:
* New in v2.

 drivers/edac/amd64_edac.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 3fb137ea74b3..f83f9813294d 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1056,6 +1056,14 @@ struct addr_ctx {
 	u8 inst_id;
 };
 
+struct data_fabric_ops {
+};
+
+struct data_fabric_ops df2_ops = {
+};
+
+struct data_fabric_ops *df_ops;
+
 static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr)
 {
 	u64 dram_base_addr, dram_limit_addr, dram_hole_base;
@@ -1070,6 +1078,9 @@ static int umc_normaddr_to_sysaddr(u64 norm_addr, u16 nid, u8 umc, u64 *sys_addr
 
 	struct addr_ctx ctx;
 
+	if (!df_ops)
+		return -EINVAL;
+
 	memset(&ctx, 0, sizeof(ctx));
 
 	/* We start from the normalized address */
@@ -4190,6 +4201,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 		if (pvt->model >= 0x10 && pvt->model <= 0x2f) {
 			pvt->fam_type = &family_types[F17_M10H_CPUS];
 			pvt->ops = &family_types[F17_M10H_CPUS].ops;
+			df_ops	 = &df2_ops;
 			break;
 		} else if (pvt->model >= 0x30 && pvt->model <= 0x3f) {
 			pvt->fam_type = &family_types[F17_M30H_CPUS];
@@ -4208,6 +4220,7 @@ static struct amd64_family_type *per_family_init(struct amd64_pvt *pvt)
 	case 0x18:
 		pvt->fam_type	= &family_types[F17_CPUS];
 		pvt->ops	= &family_types[F17_CPUS].ops;
+		df_ops		= &df2_ops;
 
 		if (pvt->fam == 0x18)
 			family_types[F17_CPUS].ctl_name = "F18h";
-- 
2.25.1


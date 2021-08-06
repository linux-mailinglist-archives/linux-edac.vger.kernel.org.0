Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476F13E23AE
	for <lists+linux-edac@lfdr.de>; Fri,  6 Aug 2021 09:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbhHFHE3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Aug 2021 03:04:29 -0400
Received: from mail-dm3nam07on2082.outbound.protection.outlook.com ([40.107.95.82]:36640
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243526AbhHFHE2 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Aug 2021 03:04:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNXaDEJVe06teuCfrva1s54UKQtwRXub1pHF3ZsuJD/COtyR/xGtju8lpEpBgAd0zhEGKP/L89QXxGjOMQA8bnrdcsU8p+Pz+UfxHgJ4eIenhoJ06sKp/AlAz3bVbH9G55eExFWN9lAgpMJ44cN765HQb6tIPHnFz/bhku3iQjBMbY+XCV6bUlZtoHf6XsmNf/SZfeGZzbVyHLEIAgRFTrBjdRN6yO/oIN7NQ3/ByxKufua+PUy9R4UubSbomuwuvHM0p6mVd5KA5koNVEUUurxnmO0s7i6WEPBgyn8VcFteiAN+KSF88YXqWmgLSfNBDbeRLxqRBQnvFoCAEVyXxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+ZUTriV9I9HO2oEZCiX9i73SP5WPlJ0et4JKh47xPo=;
 b=mRqH8AksUmEHA2HbhkZU7kG0uDo2BHYIHvDETPaoFXHnw1t/d5bESOONaIQfdmoyD5D6eMsYm+EsS2vk8Y7qca0Aq+9x7GR2NALS8q8mVKGKKIfE/ohNtSDVoO/t/IJEWUDiqNyzTm7wm1oAx3NFcqgRGvUVgeoPZq3EHKyPZp5GnCRpK749JSzf0kES19KRQGrXSkqWO7s2wthkTXu8RhIUMdGBxS5nQhs9ZKA+mvABEKh3VJY5VvaJLP6VcdhRbTjKmDECBGLS2QqzCemHHVlnR+0/lVrarwjTAuQ/uAWoNou24Aw0n8poNPL0csCq9703UMNC+bnl9WQU5MsA+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+ZUTriV9I9HO2oEZCiX9i73SP5WPlJ0et4JKh47xPo=;
 b=fc7JJPiiSf7n4m16QPZKA6Qu7IQA1Ja+WNcOdrRokY0vMkAQKMSEjvgCqow3khXj2o0ybPWKiHJfHRUUgrf7iByOvufw7G72hVMzkK/q0UFvUJZgtp2mAQgcaGfhFNbWPYVzYGTvV1S1XEmrqOkr1uE0w70CMePJUDFT697NMB8=
Received: from DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) by
 BYAPR12MB3525.namprd12.prod.outlook.com (2603:10b6:a03:13b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Fri, 6 Aug
 2021 07:04:11 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::3d) by DM5PR21CA0032.outlook.office365.com
 (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.1 via Frontend
 Transport; Fri, 6 Aug 2021 07:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 07:04:10 +0000
Received: from SLES15.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Fri, 6 Aug
 2021 02:04:06 -0500
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mchehab@kernel.org>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>,
        Muralidhara M K <muralimk@amd.com>
Subject: [PATCH v2 2/3] EDAC/mce_amd: Extract node id from InstanceHi in IPID
Date:   Fri, 6 Aug 2021 13:13:49 +0530
Message-ID: <20210806074350.114614-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210806074350.114614-1-nchatrad@amd.com>
References: <20210630152828.162659-1-nchatrad@amd.com>
 <20210806074350.114614-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bf0e619-ee42-46c4-aea0-08d958a86457
X-MS-TrafficTypeDiagnostic: BYAPR12MB3525:
X-Microsoft-Antispam-PRVS: <BYAPR12MB352522DBA7A7267F7968D274E8F39@BYAPR12MB3525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:407;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vWuQV1Or9UHq+mv+LPdV4hZFcnI5D1cnqKwhRNnPcOknclgPKL6UELVRjFfw3csqZ6kRLamDc5uh9g6++Uz0uDVu8Ec666OLJZt4DBrAKqaIkgTahZs8+Hbo2bpmOldlLcw+DPVfWDPZPH1khEs0vM6R4Snh8UJzUn2lkBK7CQFAknppm9+CqM8uzgqwBx2WqgNs5jgHqlr/TBKUQnNhPNUl+UoWsRbtyX/wihdFooJReNVhdvTNMGXNLCxtZhQ9gSNvvQA+CTrM0nzpxT83MX+F9fP0rjxrrnmmz7jtDbscisXj1LmKL8Z2054unvgUI4VHiorF5A1WuQ1j61eE52K+qi8Ab19lRbrBXc660P56InQ4UURPIQO6lrqBGtEEYvmwP6jg3HhuDmHU05eqBNkvTcSCse4aOyPfMGTrHvPRpvTZS1xTyonnQkqivEHGhGNyH4/uRl8CtuTPoAhzta6kvDyhFdY4HxTDKnetrXoBbwC4d8DQoBAnzCq/rlKeMmsyu/WL/qxyjiVPT5wmPwI599Ae8mwjpMhlAPeO7vmqfqQdPgX3exW6oVmtuCO/e96jMYDmAZsOpRSbyoe25bwP81FIo9gTvKzmFbnsyZnFdq55Mhbj2dMswvT4/BsgKSXCb1JQmF2wcs2S9kr8Cih3N56QeWRq7edcLbdOm3DpYy6yV20+/jQrp6C2VG6ZdxRFrOpxFTIpWchZvuJEl4BasSxemrGUmaH4Ju2NsJw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(46966006)(36840700001)(47076005)(83380400001)(81166007)(36860700001)(82740400003)(356005)(2906002)(82310400003)(70586007)(336012)(70206006)(8936002)(4326008)(6666004)(1076003)(54906003)(7696005)(316002)(8676002)(478600001)(110136005)(426003)(2616005)(5660300002)(36756003)(16526019)(186003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 07:04:10.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf0e619-ee42-46c4-aea0-08d958a86457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3525
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On AMD systems with SMCA banks on NONCPU nodes, the node id
information is available in MCA_IPID[47:44](InstanceIdHi).

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
Changes since v1:
1. Modified the commit message
2. rearranged the conditions before calling decode_dram_ecc()

 drivers/edac/mce_amd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 27d56920b469..318b7fb715ff 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1072,8 +1072,23 @@ static void decode_smca_error(struct mce *m)
 	if (xec < smca_mce_descs[bank_type].num_descs)
 		pr_cont(", %s.\n", smca_mce_descs[bank_type].descs[xec]);
 
-	if (bank_type == SMCA_UMC && xec == 0 && decode_dram_ecc)
-		decode_dram_ecc(topology_die_id(m->extcpu), m);
+	if (xec == 0 && decode_dram_ecc) {
+		int node_id = 0;
+
+		if (bank_type == SMCA_UMC) {
+			node_id = topology_die_id(m->extcpu);
+		} else if (bank_type == SMCA_UMC_V2) {
+			/*
+			 * SMCA_UMC_V2 is used on the noncpu nodes, extract
+			 * the node id from MCA_IPID[47:44](InstanceIdHi)
+			 */
+			node_id = ((m->ipid >> 44) & 0xF);
+		} else {
+			return;
+		}
+
+		decode_dram_ecc(node_id, m);
+	}
 }
 
 static inline void amd_decode_err_code(u16 ec)
-- 
2.25.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F1B4C7179
	for <lists+linux-edac@lfdr.de>; Mon, 28 Feb 2022 17:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbiB1QPG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 28 Feb 2022 11:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiB1QPF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 28 Feb 2022 11:15:05 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7A64552E
        for <linux-edac@vger.kernel.org>; Mon, 28 Feb 2022 08:14:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jI5bM2lPibC/w6rvC1S4yra2TCMi0UGh+AZbQUVTz2jDREd+7sQCmqRgSWtwqhBk/QjNqeZnKGbeCl/X0iHK7dTgOlM5UCC9F6GiTtfR3FiyRv07/vh1bAl/jPM5xaNUaJNzHBjUsaAmIypdKE73KfpuxdUhtepzMuwhWUJNOpsyV2TzuMjrcSXenBdA9SDojZ/7WMl6MXHmXdJzJvKfAtiMPzWEsmeUKbPlrd4prIzqUnp3k0RIcPtmYeBGODQRra88Y+aQ8JrM2jLj4HyHXn9UWE4VKAJmpburMScuD0cxGBQVHq7F5SGOJf15H3S/hXUn4SnIPSdyWlKnT/NeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Un1NLaEnvFNM+yqpWNLslpG87ftLdyPXpMrf6EFS/Y4=;
 b=EeQHpAMUr6F81hKlPfOoT4Ye8APdPaHDDyhr2CKEzOfHqqQrGVe1sIWxBuW8HTYPoNLoHjTEoJF6e9RuM7I1mELxqSf2wdlPfMt1+htGLPl1A4nA0KdhIw7tQi/agT92H9TtfYu6MDZsrQ4L+yd0eKn0NAxyUjofUb8xSrF63u+v72fCI8oY0RLbgiZJ6jfXsPFlNp6Q3kzy39qgSMI41Anv2IOt7osOkZKuIsdmqCOEDWs6HAuG9Ve4v9Hm849BfKzfys0t+bQK7kIAlnBBo2N8u7bv9mgkrAdxc5soRScooKJZV5NLL8+KGMY8ToZpPZnOSfQ0XDk3LXkawkqiVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Un1NLaEnvFNM+yqpWNLslpG87ftLdyPXpMrf6EFS/Y4=;
 b=X3sbCKoWCQIKsxrhavxBsKe+YkW+1wsWfdPHIasTnC6PQFM/WKFm9kOftF6LEx+QsbqHxNMTvdM9iC1VXixpcJ5mI+dwLObD5NNAT8dIBNEF59SLd8lrdwEfKJq3jBhyrByoAzoHMfSaIJZO/+Umdqt4QFHG7vuPrYvmhrnXuGA=
Received: from BN0PR04CA0154.namprd04.prod.outlook.com (2603:10b6:408:eb::9)
 by BYAPR12MB4695.namprd12.prod.outlook.com (2603:10b6:a03:a4::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 16:14:24 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:eb:cafe::9) by BN0PR04CA0154.outlook.office365.com
 (2603:10b6:408:eb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Mon, 28 Feb 2022 16:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 16:14:24 +0000
Received: from milan-ETHANOL-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 10:14:20 -0600
From:   Naveen Krishna Chatradhi <nchatrad@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <bp@alien8.de>, <mingo@redhat.com>, <mchehab@kernel.org>,
        <yazen.ghannam@amd.com>, Muralidhara M K <muralimk@amd.com>,
        "Naveen Krishna Chatradhi" <nchatrad@amd.com>
Subject: [PATCH 02/14] EDAC/amd64: Add get_base_mask() into pvt->ops
Date:   Mon, 28 Feb 2022 21:43:42 +0530
Message-ID: <20220228161354.54923-3-nchatrad@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220228161354.54923-1-nchatrad@amd.com>
References: <20220228161354.54923-1-nchatrad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daeed23f-9c72-4b05-2599-08d9fad562b7
X-MS-TrafficTypeDiagnostic: BYAPR12MB4695:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46951CE0B155E518DA80020BE8019@BYAPR12MB4695.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vaBXbtiFZcN2rn3nThNZ4DxPVvpV7efqOrwkzncTLSEHhuEPVDTvBDzAQlfzuS2Fy5KCvdrnyA4+k3EuRj2XASjtL6C8+aXZWQtptUe3L1OnTUuQ8/DJHNKAX3Un1wtsbpNAr5QBhzrIO8UQ+77WMnQT8gH3JR8oFWvbjv3bPzrY00Tvm97pfbVr2eEaAUUErP00nYLKW/Fhxuoa3R0f7dOsTjtYw1pHo4gcfsdcHC4DUSRSl9tO84T9b3QEGegGbaRac2VVUxS1rXqycvezh2/N87WSBlI+2bHoWJXa3qGPmDRcrg2Z7q3kE85DoqPEkdhDW/ae3GFAGhUovNczd+WvgacnFK/jumloRZ1NoPPOCCgoGA+v8n0eAjWtQKRnmjqiLgPqStY6wCMFnmmICe0fr2svabnZbVyJBnhfwUg3exto0vZ2iWBTSqWLHYwhyE1WgprxKhl1guGo3Yvt9XRHCKOGoH2DVJEB6lDyzUq3kltkHX0gi3HOaAiacQ8IvkSxDYyhmEvqI9OYqlSILonzXf9iI4GljHFEGQzwPKPBzw6bzvhrdaL9Z4lTcupF32oCsOqOZnY8X9pFVnWbtjh945EQECju8xj5Aa6uQ+VUL+xEOEpjnX6Xivc0s3wHnJ9nD6iIXsYlmyXuSaFFgH1XyI+lGAWtnE738LDJD8sjfmWwBxf3PtBDYFhoPXDMgx1pGLpGb9xfrJ3HTWH1Ptj4Q5HD2LLx7j3djknZ9QgfjgyEFdrr5SWtmi3eYFmyT8ahs3QIwzKzni9MIyr2dOLE/JHYyDWjSymMjG16k7A=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8676002)(336012)(6916009)(316002)(426003)(186003)(70586007)(70206006)(966005)(1076003)(4326008)(2616005)(54906003)(16526019)(356005)(8936002)(5660300002)(508600001)(26005)(40460700003)(47076005)(82310400004)(81166007)(36860700001)(7696005)(6666004)(36756003)(2906002)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 16:14:24.0002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daeed23f-9c72-4b05-2599-08d9fad562b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4695
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Muralidhara M K <muralimk@amd.com>

Add function pointer for get_base_mask() in pvt->ops
and assign family specific get_base_mask() definitions appropriately.

Signed-off-by: Muralidhara M K <muralimk@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
---
This patch is created by splitting the 5/12th patch in series
[v7 5/12] https://patchwork.kernel.org/project/linux-edac/patch/20220203174942.31630-6-nchatrad@amd.com/

 drivers/edac/amd64_edac.c | 22 ++++++++++++++++------
 drivers/edac/amd64_edac.h |  1 +
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index b21f43a3ec98..985c59d23a20 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -1570,11 +1570,6 @@ static void read_dct_base_mask(struct amd64_pvt *pvt)
 {
 	int cs;
 
-	prep_chip_selects(pvt);
-
-	if (pvt->umc)
-		return read_umc_base_mask(pvt);
-
 	for_each_chip_select(cs, 0, pvt) {
 		int reg0   = DCSB0 + (cs * 4);
 		int reg1   = DCSB1 + (cs * 4);
@@ -3287,7 +3282,9 @@ static void read_mc_regs(struct amd64_pvt *pvt)
 	}
 
 skip:
-	read_dct_base_mask(pvt);
+	prep_chip_selects(pvt);
+
+	pvt->ops->get_base_mask(pvt);
 
 	determine_memory_type(pvt);
 	edac_dbg(1, "  DIMM type: %s\n", edac_mem_types[pvt->dram_type]);
@@ -3763,6 +3760,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= k8_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= k8_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= k8_dbam_to_chip_select;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
 		break;
 
 	case 0x10:
@@ -3772,6 +3770,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= f10_dbam_to_chip_select;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
 		break;
 
 	case 0x15:
@@ -3796,6 +3795,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		}
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
 		break;
 
 	case 0x16:
@@ -3811,6 +3811,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		pvt->ops->early_channel_count		= f1x_early_channel_count;
 		pvt->ops->map_sysaddr_to_csrow		= f1x_map_sysaddr_to_csrow;
 		pvt->ops->dbam_to_cs			= f16_dbam_to_chip_select;
+		pvt->ops->get_base_mask			= read_dct_base_mask;
 		break;
 
 	case 0x17:
@@ -3840,6 +3841,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 	case 0x18:
 		pvt->ops->early_channel_count		= f17_early_channel_count;
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
+		pvt->ops->get_base_mask			= read_umc_base_mask;
 
 		if (pvt->fam == 0x18) {
 			pvt->ctl_name			= "F18h";
@@ -3875,6 +3877,7 @@ static int per_family_init(struct amd64_pvt *pvt)
 		}
 		pvt->ops->early_channel_count		= f17_early_channel_count;
 		pvt->ops->dbam_to_cs			= f17_addr_mask_to_cs_size;
+		pvt->ops->get_base_mask			= read_umc_base_mask;
 		break;
 
 	default:
@@ -3882,6 +3885,13 @@ static int per_family_init(struct amd64_pvt *pvt)
 		return -ENODEV;
 	}
 
+	/* ops required for all the families */
+	if (!pvt->ops->early_channel_count || !pvt->ops->dbam_to_cs ||
+	    !pvt->ops->get_base_mask) {
+		edac_dbg(1, "Common helper routines not defined.\n");
+		return -EFAULT;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 1b2055af26b9..cf38367e3aa1 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -464,6 +464,7 @@ struct low_ops {
 				     struct err_info *err);
 	int  (*dbam_to_cs)(struct amd64_pvt *pvt, u8 dct,
 			   unsigned int cs_mode, int cs_mask_nr);
+	void (*get_base_mask)(struct amd64_pvt *pvt);
 };
 
 int __amd64_read_pci_cfg_dword(struct pci_dev *pdev, int offset,
-- 
2.25.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4429A17C16B
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCFPOC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:30734 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgCFPOB (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6JME006238;
        Fri, 6 Mar 2020 07:13:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=7vvbemzeXW6z84duz1OT7XUCadhPpTzOaDm6vEXPzWc=;
 b=tKRzQ3l1AHtBOySK92LtWOnllGJ1Wyfg5D2xOlChj5d5sDpZGMF0Z3zSZwP9VtHv5hG8
 rvTKVHsN5sMnkA9dVUplu139iwOYOWLgESJMhb9y8iaEts4YsU95AfnTwlIIE6AfROHK
 LX3RdQDY7swuTWOjKkSznVrXJpHC3ih7mPa6XfOtkTqoGCxt48wwt5dLDQVi6l6pEEoU
 1wA2NAwLl/PraVnSqefHCLmvQOaJqOnLAnORNqEE841J8FslzWwRrjdr8zgTslApiwS2
 bPhMEIaedEQsv6tEQk72WUYEIs2qInGWijkNgZUN+/5Ug9RRIewz1tAa2qZctD6+vznp 9A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfw7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:53 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:51 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJY3KltGzSUYG1zi5b026bTl93B9+YUzpi/zEp93PlGgcSEZh3+ib/fv5PMDEB1svTA4pQaoBx4cENumb1KfYIdkVlDBoRkJnpMkYYjEHY2/1bPrvlzcbuiwQ1Rea543YCJWsX6GjRVWiNIjtj9ieSsOc1zyNj8+6VNdqgbQFlorEmj8MK/lvfMlZ5rkW1HtgG9B1Mo2NOQun43m11aQ0d3GRZKyx2QSsKsgBmfrNIvMMknv1oWafouN88KLxZC9UdsS6vPAIe1wEDwKXhIY9YvDNWGmuWkcsgDeIaJrAoASGQbM3HQ5odVf4Xj4Uedy9LYzpaPoRzEqc+cfptIcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vvbemzeXW6z84duz1OT7XUCadhPpTzOaDm6vEXPzWc=;
 b=oR8rWG+KiSmYAKsKxLbLx62caloKbxxITBiDPCYgkLD4KVtmih9imlL112fhAd5JcgD4ENaWoi+Upkm6vRHuNtsyLSqg64SqnBJF+ILvuZtLHDZlAkvd+dj8jyuT/LncMdsqfyVtQqRBYCnREkrQzA7bNIuoTIo1nkz8B+pDsw1xfQuBX8z6dDBzte+qLbQr0Zh2znW4SRIg4U/xAJXXQion2kq0BSD/anvF9lh4HbA9725ua2wO3MRuVNjSQLq+S4xauu84EQREez+9F2RqT3y1c2nE9fnK0Vize/dGQHVhUOhNmxfBIMnc96JJV895ViWjsYQ7VK1xPv9zD2QtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7vvbemzeXW6z84duz1OT7XUCadhPpTzOaDm6vEXPzWc=;
 b=KxS3YLQ+1cWeKWgv83ccRoCZZYqQzSPLuleCdPdbgduWVkL5Xh0cumpFTOKE1vdjvQ4loCEjqhl2I7jBduHN9PP751Qf1BOHGXv2+Ud1u1hYWUy3FUxahg638oqkKbiyD93Phro0RdQOSfurKn8UGh+GMLKGRU74Vf+XJs2UvF0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:50 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:50 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/11] EDAC/ghes: Carve out MC device handling into separate functions
Date:   Fri,  6 Mar 2020 16:13:13 +0100
Message-ID: <20200306151318.17422-7-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200306151318.17422-1-rrichter@marvell.com>
References: <20200306151318.17422-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0102CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:7d::36) To MN2PR18MB3408.namprd18.prod.outlook.com
 (2603:10b6:208:165::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:48 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50b644b1-5fe1-4ecc-1d7a-08d7c1e0f9b8
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2400CAF28DA879C20FB11F6DD9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKH/0zBfsjJfOOmnGJlRaoJVVf5UJZK2TqebEHzA8u7bEpgInQoMM4aBliEN7nTMerH8WKfYv//V4PYJk28zjOvWsiSlY7k0Araig2L7L7+Y8ti/yXxD9YRCcdVSDiPqByKC7WoFu2FyuyfFyfpXzsZdozEaT7AWwvxeqSF8RNDur++AGf7Mzwr4+GBeXGICjK/czbSwKrUQVHo5kIwxJyK9ElfHCM8r/TkgSs3jXqoeLjOc0WeXwUH9dUnutO1yJ5Q/x9RQgDRD09Dxfa5OH/U1N6EwNYqxcNPfE/llDVdH4UW3OFMcyKNxlwbDjSpL00olDi7LnXk3q17OCv51guktRP9eufqLCmFhUdSOAPdARg0WdZyehcSDVY0ja5ZMlAprhIYBbJWfn3DGy6/N9EteCtN9RICgpqq72EL2BI8PhzomzKkJYYin3jVbSoLT
X-MS-Exchange-AntiSpam-MessageData: X9KcYpRLXvmnFl0f80zGo5wbwhptx7C0Y7ByufgsveoYDyfp7CKguPSszflKSWfyouOTMmeeH6kvEQz4rvqzxSxhEyWK49sVaP3hVj+RiM/ETZm8+fo0n2rY9I5YLGZqfQvxm7coDYq/aG2p31fAiA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b644b1-5fe1-4ecc-1d7a-08d7c1e0f9b8
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:50.4941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTvdJcbIU05528O/kP7ODXMRMol3zcjb9AuwOQq/kZh64cM8OsGnevo/vRiLjH2iPoPh6OoK6l409kPJrvBUdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The functions are too long, carve out code that handles MC devices
into the new functions ghes_mc_create(), ghes_mc_add_or_free() and
ghes_mc_free(). Apart from better code readability the functions can
be reused and the implementation of the error paths becomes easier.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 133 +++++++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 54 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 358519e8c2e9..5a4c9694bbff 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -462,16 +462,81 @@ static struct acpi_platform_list plat_list[] = {
 	{ } /* End */
 };
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
+					int num_dimm)
 {
-	bool fake = false;
-	int rc = 0, num_dimm = 0;
+	struct edac_mc_layer layers[1];
 	struct mem_ctl_info *mci;
 	struct ghes_mci *pvt;
-	struct edac_mc_layer layers[1];
-	struct ghes_dimm_fill dimm_fill;
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = num_dimm;
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	if (!mci)
+		return NULL;
+
+	pvt		= mci->pvt_info;
+	pvt->mci	= mci;
+
+	mci->pdev = dev;
+	mci->mtype_cap = MEM_FLAG_EMPTY;
+	mci->edac_ctl_cap = EDAC_FLAG_NONE;
+	mci->edac_cap = EDAC_FLAG_NONE;
+	mci->mod_name = "ghes_edac.c";
+	mci->ctl_name = "ghes_edac";
+	mci->dev_name = "ghes";
+
+	return mci;
+}
+
+static int ghes_mc_add_or_free(struct mem_ctl_info *mci)
+{
 	unsigned long flags;
-	int idx = -1;
+	int rc;
+
+	rc = edac_mc_add_mc(mci);
+	if (rc < 0) {
+		edac_mc_free(mci);
+		return rc;
+	}
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	ghes_pvt = mci->pvt_info;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return 0;
+}
+
+static void ghes_mc_free(void)
+{
+	struct mem_ctl_info *mci;
+	unsigned long flags;
+
+	/*
+	 * Wait for the irq handler being finished.
+	 */
+	spin_lock_irqsave(&ghes_lock, flags);
+	mci = ghes_pvt ? ghes_pvt->mci : NULL;
+	ghes_pvt = NULL;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	if (!mci)
+		return;
+
+	mci = edac_mc_del_mc(mci->pdev);
+	if (mci)
+		edac_mc_free(mci);
+}
+
+int ghes_edac_register(struct ghes *ghes, struct device *dev)
+{
+	struct ghes_dimm_fill dimm_fill;
+	int rc = 0, num_dimm = 0;
+	struct mem_ctl_info *mci;
+	bool fake = false;
+	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
@@ -500,28 +565,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		num_dimm = 1;
 	}
 
-	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
-	layers[0].size = num_dimm;
-	layers[0].is_virt_csrow = true;
-
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	mci = ghes_mc_create(dev, 0, num_dimm);
 	if (!mci) {
-		pr_info("Can't allocate memory for EDAC data\n");
 		rc = -ENOMEM;
 		goto unlock;
 	}
 
-	pvt		= mci->pvt_info;
-	pvt->mci	= mci;
-
-	mci->pdev = dev;
-	mci->mtype_cap = MEM_FLAG_EMPTY;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE;
-	mci->edac_cap = EDAC_FLAG_NONE;
-	mci->mod_name = "ghes_edac.c";
-	mci->ctl_name = "ghes_edac";
-	mci->dev_name = "ghes";
-
 	if (fake) {
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
@@ -549,22 +598,17 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		dimm->edac_mode = EDAC_SECDED;
 	}
 
-	rc = edac_mc_add_mc(mci);
-	if (rc < 0) {
-		pr_info("Can't register at EDAC core\n");
-		edac_mc_free(mci);
-		rc = -ENODEV;
+	rc = ghes_mc_add_or_free(mci);
+	if (rc)
 		goto unlock;
-	}
-
-	spin_lock_irqsave(&ghes_lock, flags);
-	ghes_pvt = pvt;
-	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
 unlock:
+	if (rc)
+		pr_err("Can't register at EDAC core: %d\n", rc);
+
 	mutex_unlock(&ghes_reg_mutex);
 
 	return rc;
@@ -572,29 +616,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 void ghes_edac_unregister(struct ghes *ghes)
 {
-	struct mem_ctl_info *mci;
-	unsigned long flags;
-
 	mutex_lock(&ghes_reg_mutex);
 
-	if (!refcount_dec_and_test(&ghes_refcount))
-		goto unlock;
-
-	/*
-	 * Wait for the irq handler being finished.
-	 */
-	spin_lock_irqsave(&ghes_lock, flags);
-	mci = ghes_pvt ? ghes_pvt->mci : NULL;
-	ghes_pvt = NULL;
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
-	if (!mci)
-		goto unlock;
-
-	mci = edac_mc_del_mc(mci->pdev);
-	if (mci)
-		edac_mc_free(mci);
+	if (refcount_dec_and_test(&ghes_refcount))
+		ghes_mc_free();
 
-unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
-- 
2.20.1


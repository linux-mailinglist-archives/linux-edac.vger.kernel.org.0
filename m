Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DDC1D949F
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 12:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgESKpk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 06:45:40 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46826 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728686AbgESKpj (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 06:45:39 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JAedar031351;
        Tue, 19 May 2020 03:45:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=6mh5/15VVIazqil+75t5NdX7QulhHezbMe2gqlPiFeU=;
 b=BJBCx8ueq9yF/0xdGIv8HF3UvUL2mHBhNM5amvsoMCN0OUqMNFV8sLgdo8knBMMguEWJ
 +1jXDZwlmBNW/5oOHYxwAQjglIu2tWcuwBzcWcUvLQb3Ss/RQVEFdQe03qU9xFPMj03e
 n5N6bjXLkw+SmDmrNbHsLJ2T/L3YxEdrVKeuZgrYSG5rVTpNd/gjPXQswZ/bQXWDjN/u
 CePgn3rbZvxEIfqWturvWfhXcXX78DUKs0gaCBwKcllpEHb38OWJ2AFQDMf3SxP7+x99
 ppy1t1HN5sTmrGrMc25FoEP0SPGEIjPCZVQ2E6brrHwMaAnSP4UVG3WmcEFEkG1x2aCy fg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 312dhqkgnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 03:45:27 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 03:45:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6pYZDx/H3m6umFuCDhIpZCYN/BnUqZh8qqGT8FcC1T+pad78WVLuP5T7ur7CKNeFxLIScbCHSIoefp1CaOInsjpF5qKP0AvsFMrDpXQVGyyG2QYdr+SE6b+9nu4Ew72YOqKam+Js5hmDVtV9ll8jcnqaRZOQZ6ZfX4df/G5wAfYbkH8J1QdimobJ96jzDzviyljQUNfUSp4nOL4bGsNs4QODOtACFjEIKgk+iGQKYLcffxBRb/W5wPAt+6u/N46QENWW6+W2d4z4Rc22+DhSSBOj+I9ZCBARYEOxGclbBQk5wxjCQS+1T1TUcbKZQM8R5+427mJy3b9ou17WoPdVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mh5/15VVIazqil+75t5NdX7QulhHezbMe2gqlPiFeU=;
 b=JkqsoCjNkVpJ7semhyupQlczM1B5sJqL7elO+/g0L8+FZwfwafyeetSF5+U2trE9tlBV/8owJXLfyhwlvDIGnyiHmIxEA6xmaeGhClCwPE/R5j5d7CWbhGDaGDtwaEmd6mF1MONSNNwzLYGIUajP4sDRCqk2q49S/H1ozul55KMSwaiK0A8FyYTSd4yz3q3friOBI4g3i0bOaR8oLZ47qhrQWJF5nBT6/fw0ZMKUfrdD0vnAv6RhrJ1Uxm35TKvFNQztIV7hg0QpPAX4aEWv0Xhk7aU5qjjuOWZM+CD9SQb8rnwztw5IuXrdgFWKgBE5t5xQSeqkfQeG6iX8fAfMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mh5/15VVIazqil+75t5NdX7QulhHezbMe2gqlPiFeU=;
 b=CfrvRA4mnjnYLXXJWH0w5w3qgj5qQbtmk/f+UMiXVJWU31jODl/2jGc7bAmUqsFsS6+kPTPQV/RWFgUW6DCOLWRjOvbYwIcCUIyT5cv6KMm3xwobU/WEsXN6Z6cFQVmP5L31sQNf/7715V9SiLLyRGYv0g0UuDs3btV9/X/Q8oM=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2455.namprd18.prod.outlook.com (2603:10b6:a03:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 10:45:25 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 10:45:25 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/5] EDAC/ghes: Carve out MC device handling into separate functions
Date:   Tue, 19 May 2020 12:44:41 +0200
Message-ID: <20200519104443.15673-4-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519104443.15673-1-rrichter@marvell.com>
References: <20200519104443.15673-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 10:45:23 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6935bb9-7bc2-4a38-71fe-08d7fbe1bcf2
X-MS-TrafficTypeDiagnostic: BYAPR18MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2455AAF5000A714FD5237627D9B90@BYAPR18MB2455.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:843;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pWfwayL+SJtGhz0CJt46wmZCWDv8TR5wDQntmrrpBMZLkLsv7X41puqe5EIDN3U22T2Fvw7FFMNx7AVYmuKMo/4zj0DoukdSUf+Kal5TdXSUIkbmNPTqPrXFvjS5PONGKNuPunxt8Jf7dgAuPaMYjrsKpHPUy1rjb5Jr9R7kc5zQrHVe5OhuqT7J1RQAztcyH0+n21Z2iv7x9RA41MNXxa04z2+Y8WznJ/QYsL+45+9akUgqk+80gioWrw8pL8kYtAwHL0xC7DeG/59hSQb4jXCLfgb6txQgZBrs7QVgIufejAGeSK4HObLQja6Zw5tO2Ob0iqHzWXeWnLuIs182bGtlPXowPCwKQ1WiBqewnA/yO4FhtFsBfIWLLPb28kMRLPMRKI7RvOxSGkK9A9lZ2R1iS6FNNduUq0tBNgxkyDbAuu4y+wTxKMMFlTyuN3HD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(316002)(16526019)(6666004)(956004)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(6486002)(54906003)(26005)(5660300002)(6506007)(66556008)(6512007)(66476007)(52116002)(478600001)(8676002)(1076003)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kpKyRSV9fn5SPmzrPurz4OR06EmxPTbs8VToT6Ack4FwTY18vQpxeXQprORg83E61QEffGmB+7i2qboX7To6b4ftMCm0x/abiCZKI0BYE3acGwaw4CuomphRmDzAXgqCVOZMgDuYiY94CBerlRhuNTxuIi9NQm8WlhUdTGxWMuQyKhdlYV5IlPFUHMMCxWtBQAPpwWMr7YRDpMw0ZcI3WX6KOc2oZsT6nPV1rMUbF1x1WVjEYD9aLM2mk5TNoxEr61IT0OSqEsjCFSslwf/nZL+HHhEGB8blhLzKCekKpTKucLnK3ScBsYAB+yFM7F76UugCYgiBZKENLqtu9XFyrtN+Nfbf0zPhrAVzDHCM6kQdp1lL6MhNXt5LLtBlsvgnfJ2xPxoOYQCxK9JUTAblDTj/la4mgxw1tOyPzQbnUcc4C4w8fWbM/kiZh2iUHrrezcMa4gYSelWrLaJxUG0edgeB0r6yHh3uHWAoTQJPV5I=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6935bb9-7bc2-4a38-71fe-08d7fbe1bcf2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:45:25.4772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mb1KoDnftiAfB2PS2niKoIP9dCRvWAqdFOEEbjTzo/NEwGfWZEfLRyLYlX7SplyLn5GJBNsAdnlAYPElDhOTwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2455
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
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
 drivers/edac/ghes_edac.c | 128 ++++++++++++++++++++++++---------------
 1 file changed, 80 insertions(+), 48 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index b72fe10b84d4..8329af037fbe 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -461,16 +461,83 @@ static struct acpi_platform_list plat_list[] = {
 	{ } /* End */
 };
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
+					   int num_dimm)
 {
-	bool fake = false;
-	int rc = 0, num_dimm = 0;
+	struct edac_mc_layer layers[1];
 	struct mem_ctl_info *mci;
 	struct ghes_pvt *pvt;
-	struct edac_mc_layer layers[1];
-	struct dimm_fill dimm_fill;
+
+	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
+	layers[0].size = num_dimm;
+	layers[0].is_virt_csrow = true;
+
+	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(struct ghes_pvt));
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
+static void ghes_mc_destroy(struct mem_ctl_info *mci)
+{
+	if (mci)
+		edac_mc_free(mci);
+}
+
+static int ghes_mc_add(struct mem_ctl_info *mci)
+{
 	unsigned long flags;
-	int idx = -1;
+	int rc;
+
+	rc = edac_mc_add_mc(mci);
+	if (rc < 0)
+		return rc;
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	ghes_pvt = mci->pvt_info;
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return 0;
+}
+
+static struct mem_ctl_info *ghes_mc_del(void)
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
+	if (mci)
+		mci = edac_mc_del_mc(mci->pdev);
+
+	return mci;
+}
+
+int ghes_edac_register(struct ghes *ghes, struct device *dev)
+{
+	struct dimm_fill dimm_fill;
+	int rc = 0, num_dimm = 0;
+	struct mem_ctl_info *mci;
+	bool fake = false;
+	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
@@ -499,28 +566,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		num_dimm = 1;
 	}
 
-	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
-	layers[0].size = num_dimm;
-	layers[0].is_virt_csrow = true;
-
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_pvt));
+	mci = ghes_mc_create(dev, 0, num_dimm);
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
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
@@ -548,18 +600,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		dimm->edac_mode = EDAC_SECDED;
 	}
 
-	rc = edac_mc_add_mc(mci);
+	rc = ghes_mc_add(mci);
 	if (rc < 0) {
 		pr_info("Can't register at EDAC core\n");
-		edac_mc_free(mci);
-		rc = -ENODEV;
+		ghes_mc_destroy(mci);
 		goto unlock;
 	}
 
-	spin_lock_irqsave(&ghes_lock, flags);
-	ghes_pvt = pvt;
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
@@ -572,28 +619,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 void ghes_edac_unregister(struct ghes *ghes)
 {
 	struct mem_ctl_info *mci;
-	unsigned long flags;
 
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
+	if (refcount_dec_and_test(&ghes_refcount)) {
+		mci = ghes_mc_del();
+		ghes_mc_destroy(mci);
+	}
 
-unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
-- 
2.20.1


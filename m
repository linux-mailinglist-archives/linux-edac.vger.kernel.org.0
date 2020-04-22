Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B071B43A6
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDVL72 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:28 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:34454 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728059AbgDVL70 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:26 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBppmw002236;
        Wed, 22 Apr 2020 04:59:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=Z474HLBQpSxyuynsKsN/EtOH2r1lKy1dIpQCpDfc6Ks=;
 b=x66HuhxNx/0EtTmbQM3LE0ujo7dw4Y62vJIbnu8GumyZJEqX92wbj+zniCAxa1LeBP2A
 Qbw/yvoyFtYzdUOGwAUlrell/DJCsFtjdWdY2Qq7hcDNULKewZoOmYxIKPblPluqxgXw
 BhJkxm7QUVeWldlRZVhgJNuNf1htl8d/0p3JBlpNOYVzv6XOHh8NpZmxrcAfiow8RSF9
 /560H3r8cjAcsKIguBMdiibkk/9y1PT+mdagaGu3jsgNkDdfy/q7Pad0MtmY/V+rTRUG
 3Bk04irzB4bFIDIO+1LVLAOcX0fVIJ0O/oHK0nhI9NNnaYoRpl3qL4kvsdcZWHVWHzZq hw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 30fxwph9e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:59:11 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:10 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:59:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo92V9+ml8pJ17upoWDEStaHQ7/b8HZWnfBSgt+CLOVdFpbWDndDOgvMJvNDD75VzXOg05g5AHEQKmK1MxNttu3gxr9Uf8mw+hDYgxxDIT9RFIjZAid87Ard7KwuzRDrPGzFVBoIqXObQOnE8LaejBLf8ogKhynGR64bpqmGuoLqOc6U6xuNRpCb6IeB6ji/IYZW3gjRDHolPJN8/MZYNnFxKIHzz9At99H2XYEWYTzPR8mXbKgqscY4NqmOhqmJCSHMg6QgGjbwCAv6Bbi3zKJjGe0J1mGDRsUUYqDXsfYBt7o6QK6+MOLPEIf+HQoIktLHxyvxEPqJf30UxP+oig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z474HLBQpSxyuynsKsN/EtOH2r1lKy1dIpQCpDfc6Ks=;
 b=k4Kdxa2XacLXove/BXtxG/BBH3QsinVACs3zlwM7TqG9gFXZplXLrwUJZDSjF4LNlxluwW+HHBklQXD4C7Kw7tcjjBr4zPvw8TV7/WH/rHkNzM47av+VEyGhp0xKXY1jt7Wjs9vaWdcRJ2CpgouWH8CpfTTw9Shtmh1k/5ZnjpXsdxA0WoaQQWDtYEcz7jg20DvPoCSK9j1iCpGNhdlPGpaFoVkzP3/JPSSNxyc2hudnwRRJDG+yYr12X5kUm04lYzRzDU6k4lYfle+o10GgbfO0OFcTYnhGHgS++H6Ldo5VIord1h6qyYJ/C6etgJSEUC6DEZ7qzf8kDHodcv/9wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z474HLBQpSxyuynsKsN/EtOH2r1lKy1dIpQCpDfc6Ks=;
 b=rhD+NAV2JZkANO2Phfye2Ls+43Q8a1WyY0Rp9Cj404t1Z5+LeMjqnaKxyBKRZ0A/whKOT86zChv7yPs9WtwLpGkGj1t0KGXsBQ9XayI3ThBpBuqHo1eDFn5U2ytASYZ9hn5g0SOKo6lB8Yn6hDFr44YiipYoePlmQqOmBVcHLN4=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:59:09 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:59:09 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 08/10] EDAC/ghes: Carve out MC device handling into separate functions
Date:   Wed, 22 Apr 2020 13:58:12 +0200
Message-ID: <20200422115814.22205-9-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422115814.22205-1-rrichter@marvell.com>
References: <20200422115814.22205-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0701CA0076.eurprd07.prod.outlook.com
 (2603:10a6:3:64::20) To BYAPR18MB2661.namprd18.prod.outlook.com
 (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:59:06 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59b08fd7-b6e2-4aad-e039-08d7e6b4907b
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2933B7BDFE184BC2D20EC145D9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:335;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sA9p7/4VBnOum09MiqSHvaNE7OtgWK/zYVY/SfdweDeJow8kMyKycG1hePVDqwyyPA/dLx9qy//OnYYHaEvvnU1qbCfQDE8ReSSQrsByvd35i805bAcwQRRcTlhW7XOA8oNMVT5wrXtSba8ZQbbmpCZX4on9hriSZcPs0DtbmXkUWT4CkDGHKjqUw6qF5Dl7eSvwPPuUIVaIlGTmg92bWCFfBrxFZTq2vYcWDGlOh61p0GpW812e/ugO3wjIIT6Rw7UIlFyHbfS8rKFsj9B6hmS4S2t0IXYvls2JVG4I0DN3VmlaNNBfi5v6/b7f+mG1aYMhGoKMWFZ4WjCaDtRug+fBPY0Nnf7qfOL1mSUAtJ38GylSXS7tlBORg5h9LLbl1L2vXSKKXsC9tS5OonhjenJya/0kDkjCc7pBPD6nWSL+KrGce+fjIDWjJXwdWcw/
X-MS-Exchange-AntiSpam-MessageData: XMhzQXKl6BlGOgiABWvPeHA+ofJcD6vMeVAwyEDCLca3BqiCn/vpNY7JcN62iSt/oNA2qPa5xqbILBbwrSfBY8ihkG01n4i2hLZN2OM+sAgIG3+jHTf/+Slt+m+2zZRPz5hBrK6CQxsfiWoclFeLfQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b08fd7-b6e2-4aad-e039-08d7e6b4907b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:59:09.1801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApQK3/r+fle7kmMDG45Ze41BK/YPHYB5sC3H4cmyX5ATBI/Z0MyeexHnLxQKYLx6uBecUiuFL4HjiVwfyEptSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
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
 drivers/edac/ghes_edac.c | 141 +++++++++++++++++++++++----------------
 1 file changed, 83 insertions(+), 58 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 4eadc5b344c8..af0a769071f4 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -535,16 +535,88 @@ static struct acpi_platform_list plat_list[] = {
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
-	struct dimm_fill dimm_fill;
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
+static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
+			struct list_head *dimm_list)
+{
 	unsigned long flags;
-	int idx = -1;
+	int rc;
+
+	rc = edac_mc_add_mc(mci);
+	if (rc < 0) {
+		ghes_dimm_release(dimm_list);
+		edac_mc_free(mci);
+		return rc;
+	}
+
+	spin_lock_irqsave(&ghes_lock, flags);
+	ghes_pvt = mci->pvt_info;
+	list_splice_tail(dimm_list, &ghes_dimm_list);
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	return 0;
+}
+
+static void ghes_mc_free(void)
+{
+	struct mem_ctl_info *mci;
+	unsigned long flags;
+	LIST_HEAD(dimm_list);
+
+	/*
+	 * Wait for the irq handler being finished.
+	 */
+	spin_lock_irqsave(&ghes_lock, flags);
+	mci = ghes_pvt ? ghes_pvt->mci : NULL;
+	ghes_pvt = NULL;
+	list_splice_init(&ghes_dimm_list, &dimm_list);
+	spin_unlock_irqrestore(&ghes_lock, flags);
+
+	ghes_dimm_release(&dimm_list);
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
+	struct dimm_fill dimm_fill;
+	int rc = 0, num_dimm = 0;
+	struct mem_ctl_info *mci;
+	bool fake = false;
+	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
 		/* Check if safe to enable on this system */
@@ -577,27 +649,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		num_dimm = 1;
 	}
 
-	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
-	layers[0].size = num_dimm;
-	layers[0].is_virt_csrow = true;
-
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
+	mci = ghes_mc_create(dev, 0, num_dimm);
 	if (!mci) {
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
@@ -627,18 +684,9 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		dimm->edac_mode = EDAC_SECDED;
 	}
 
-	rc = edac_mc_add_mc(mci);
-	if (rc < 0) {
-		ghes_dimm_release(&dimm_fill.dimms);
-		edac_mc_free(mci);
-		rc = -ENODEV;
+	rc = ghes_mc_add_or_free(mci, &dimm_fill.dimms);
+	if (rc < 0)
 		goto unlock;
-	}
-
-	spin_lock_irqsave(&ghes_lock, flags);
-	ghes_pvt = pvt;
-	list_splice_tail(&dimm_fill.dimms, &ghes_dimm_list);
-	spin_unlock_irqrestore(&ghes_lock, flags);
 
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
@@ -656,35 +704,12 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 
 void ghes_edac_unregister(struct ghes *ghes)
 {
-	struct mem_ctl_info *mci;
-	unsigned long flags;
-	LIST_HEAD(dimm_list);
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
-	list_splice_init(&ghes_dimm_list, &dimm_list);
-	spin_unlock_irqrestore(&ghes_lock, flags);
-
-	ghes_dimm_release(&dimm_list);
-
-	if (!mci)
-		goto unlock;
-
-	mci = edac_mc_del_mc(mci->pdev);
-	if (mci) {
-		edac_mc_free(mci);
+	if (refcount_dec_and_test(&ghes_refcount)) {
+		ghes_mc_free();
 		ghes_dimm_pool_destroy();
 	}
 
-unlock:
 	mutex_unlock(&ghes_reg_mutex);
 }
-- 
2.20.1


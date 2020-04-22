Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F24C1B43A2
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgDVL7K (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:10 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:56564 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727782AbgDVL7J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:09 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBqNri003094;
        Wed, 22 Apr 2020 04:58:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=Xy5jsoBOkC1Icj9iza/OgH4TD4RCI1kU7Vb1PQNU3wM=;
 b=I8KhAKI+YwA5LQtMoyJJVx2aNOlBy24BtWaIdQcmycNC7WmFpYWo72mRlu9azraNygon
 DM1frGftqWKitDL0dFdsYaVlpdJZGCOfnpAUsltOrRZfYbsnWUTUdxt02vp4xcAM5i6U
 We51naqkxTA0rI6OZz1ez/rIsTdessc+oRws9k7jyUQD9or1g1U+3t2Wsv/pXeWZHAAO
 aARt2Qiwf0ZjFuDAnh8/6Xjt0B/wV1endSt9CqSwf2yCWlfLSEApTTE1+JMf2KLTCRMp
 TtwmUHTVyYz7w+EAMNv5KG7odDxFUPcaO0OevLoThP1ppuKZsC/x4Jzb6eimTxvXguGM iQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 30fxwph9df-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:58:55 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:58:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxgdR2pktWgOWZQfe4GX4Zle5zvDh9+n0w4fdYHEttAkyqkZaJsWA/VS4NlvyALl064TXlXBg4wAjVJ84PvPXu+7MuRAqo57H9n+wepLg+23raT9XJeV9ORQdGNe1lzXe4ZCnQk1ZxMpMTwlEKSvJsUUBP1/LDJ9UdathPxG5kflS2sSPC24Q2CTKV1Sozc6cmBwdPUW70xIiatZaq9zSzV31v8oo1TFOfuNHWNOqIMENrkH39LfTVuE3ALOKcCca07O9Yv/lRFfrtYbItdanjWokLzH/MM70IKJWPhHEQ2JFZH+NAdCk3zDSFlLBMYTd0gjiXgF421n7fEBzpOrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy5jsoBOkC1Icj9iza/OgH4TD4RCI1kU7Vb1PQNU3wM=;
 b=AZ53N0hf6dvnauyUC73xm1kIv57ABzdZPQChWfA2s0qrTEWqA+f+5RTs0RjDye6BtxbQg5o/GQfyoUjcXXnOIo6JC0wtgU1t2QPikmaVCq09mBo+AiUk8d+KT7GhcYL+7sJDZM2WHYBbBRRKbqEUZZpjIptRExizpT6kHnueNdQyl629UYH1S1ne2fbEv0Ur8m6eEkpseOSwv+vd+X6hGbc+4Rhg2GJj/Ac2NDaAnG2lKU05u0vmAv4lLnRFbNRJJk+pCulRv+zYgyk4xljp1L5ji1QoXA9DsWdZ3H2H9ZiVm3JR6OHF7IVU7zT/0dhER+D2on0y8/EBuV6l6mrzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy5jsoBOkC1Icj9iza/OgH4TD4RCI1kU7Vb1PQNU3wM=;
 b=JMMObG+0PUb9jreWDH89zt/KoKKmYrDU4M/ScUxK4V6ZmR0EVJN0aKf1m5b5+2RIRKOfTzP434NLjrFbPbfw2oW1t1wgZM+aVb+p/wL0knz6wR+38JbTGpSh1w8Xr74XQ2dulpBKuKXwPkLZDrr7Oul9zmdCq857yXO15DzyW0s=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:58:53 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:58:53 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 03/10] EDAC/ghes: Remove unused members of struct ghes_edac_pvt, rename it to ghes_mci
Date:   Wed, 22 Apr 2020 13:58:07 +0200
Message-ID: <20200422115814.22205-4-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:58:51 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d78359de-5a6e-43a1-00e4-08d7e6b4872a
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB29334DFF866020F1C7C33C4ED9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1dw/1MqtY8h4cxaWb6zwg/sMQb2CP0LH02g7jo6UXzrVZvT7htwtNxvf5uj7IkHiLaPn2Vf9l/5hUmDzlcMbf6uQLteAbbvgpERBi+KxPNY9la5/9vsdBtFXjtGCTR3An2BJVTV5/2XQQuTeANLNNpVX51Shq70N8ieGjddspoXeYjNTK5xcKoeCF7NbiNu8Lhm0a4Je89Ck+wYHQsOxqtUtUu39wXG1/XKE2VTW2XXdDNwprqx4als1qRY/Bg9dIAs4LfAFtf5Zk2d7gK4Yqn7k/dXsJgT0tL4V3Kdqu95D0lP7AeX5hGnBsc1Qjxebp7+xSFCvVWZcMM53xwXsmTQWcXuzTWW+FkC1WoBSrIdLwbvC/zbrATdicqNT7+P2aA8Vq/BGctALg5uDhwuw47SckMNnYq8h/8+98vNtfBEmGFsENeJVn/ThyiCxTCi3
X-MS-Exchange-AntiSpam-MessageData: wQTuGfBraoUvnCy3D7cYVpLnjD+FN8I3FO/56b6p54Y3DE7bYZSJdqakcVCVVZattsh3xDLClKFSLnGan3xFAqBMDd0hW/1Cr1oWoHez9rXUMr6P4zx9MLx3YENehtcqTsTkYryYEFUlScXoFUarbw==
X-MS-Exchange-CrossTenant-Network-Message-Id: d78359de-5a6e-43a1-00e4-08d7e6b4872a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:58:53.5581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/N7DQmEUxIYkGiCqU3SJa9DyyQZvdJ/Or/QKqawOUNlbLEb080fWZ95CR4t5nhq4zqFr8LoGvsNec4B65PgFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The struct members list and ghes of struct ghes_edac_pvt are unused,
remove them. On that occasion, rename it to struct ghes_mci. This is
shorter and aligns better with the current naming scheme.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index cb3dab56a875..39efce0df881 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -15,9 +15,7 @@
 #include "edac_module.h"
 #include <ras/ras_event.h>
 
-struct ghes_edac_pvt {
-	struct list_head list;
-	struct ghes *ghes;
+struct ghes_mci {
 	struct mem_ctl_info *mci;
 
 	/* Buffers for the error handling routine */
@@ -32,7 +30,7 @@ static refcount_t ghes_refcount = REFCOUNT_INIT(0);
  * also provides the necessary (implicit) memory barrier for the SMP
  * case to make the pointer visible on another CPU.
  */
-static struct ghes_edac_pvt *ghes_pvt;
+static struct ghes_mci *ghes_pvt;
 
 /* GHES registration mutex */
 static DEFINE_MUTEX(ghes_reg_mutex);
@@ -203,7 +201,7 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 {
 	struct edac_raw_error_desc *e;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_mci *pvt;
 	unsigned long flags;
 	char *p;
 
@@ -457,7 +455,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	bool fake = false;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	struct ghes_edac_pvt *pvt;
+	struct ghes_mci *pvt;
 	struct edac_mc_layer layers[1];
 	struct ghes_edac_dimm_fill dimm_fill;
 	unsigned long flags;
@@ -494,7 +492,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	layers[0].size = num_dimm;
 	layers[0].is_virt_csrow = true;
 
-	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
+	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(*pvt));
 	if (!mci) {
 		pr_info("Can't allocate memory for EDAC data\n");
 		rc = -ENOMEM;
@@ -502,7 +500,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	}
 
 	pvt		= mci->pvt_info;
-	pvt->ghes	= ghes;
 	pvt->mci	= mci;
 
 	mci->pdev = dev;
-- 
2.20.1


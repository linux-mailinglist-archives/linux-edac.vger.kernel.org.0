Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C71B43B6
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 14:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgDVL7x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:53 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:39926 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728228AbgDVL7b (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:31 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpH1i031933;
        Wed, 22 Apr 2020 04:58:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=JGX6tt0ew2crDOsj0H/XjraC++kVsKN9IeEIeGx9I1I=;
 b=LMSVV4MWg4B3ICwFKSm94OWGv+oAH7bDpdajE7pujY0rkMgGeknaxJLa3zechKOFMJFo
 cuCojWVJIORBFqG4qA0IMHW/AmOb3j+9nsmDtNuUhboiPoMasqDP1BTNlBMrViG6x25W
 7P+Q+t5MezLsoPkJ9BE3KPEl0IE2IQwxJNlXbJZ1KKsaHaD0GJHQ45Hpy46GUfBe/UDY
 PBfEAaHVFp51woeVBz17lN50rNk5LCmZNgSWq8h3azDTVTU2o49OTcJuXj2VkpQ0pHk6
 zkYipXuCyiNuYtbIlabgBy4eeXRAoNbZd4Tuyiv6A7yuxkAEj3Idmw9K5Cj5/yU8qsUl rQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 30jd011w47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:58:53 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:58:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:58:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KislZ0VCMKXqBw3q+Mb+MRXZpjNPkaSmNgA/KfQAHUfNG2zrDwHIg0RYoOGcxbu7NSixcBCdwpOipFYxDhEXwQhsy8xz3bIJqtRoqudjeTLVPxgi0UiGkqw8AhtMHiVnINisjWwb94wSV9iTDtw1tTRellqEotjyjdLJxpfdumw5Nl3EElbMEgXGNC/psopZSFlN/FYln3hxNBO7BrgpJySCOUnst3HKpuoqWcJYZD9x2fwmiOAyJEwMVT6Z5CuCXIs4EkGEEng3PPL6+umqX3P+35u5HbYg3eG+f6P3pRDgzRto8i9X0W00eRBeIGFo3YBoGf2LPWajgwVhm1sX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGX6tt0ew2crDOsj0H/XjraC++kVsKN9IeEIeGx9I1I=;
 b=gFlw0zDP92lJ1YtMynyjx7qv/Bczc5fx1E4vbRZ3ec6wA8IJ0XcF6Eb+E8KVaWBd0IPxUvqwwrYi8wdOx6zXvVSyTAP+uM1FqAN8Zn0ClMvpmqHyuCkNDWQX/sovkDSzlqYzeOBgiFoU/sJKZIL49l//O8UeLFVQf4+y7BnaAu7/2piJ2bgcXYCbqDd5vFlaZ8vxWaQaaMHxFdyArYP4inJPgwugBosatzGmAOnqB+grm6eaPWi2QaavBw86BkbLFzPceaf7UAmJUCwo7Qqri78rrseqHBaDhvby+YKkwk5agUb89MeJNottiTJCQJsMcKZTstEXlficcy23xvWSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGX6tt0ew2crDOsj0H/XjraC++kVsKN9IeEIeGx9I1I=;
 b=JnOBa09nU9ARsjyGrMpf2dXgHcGbFvGGQ5e+GQ720sXDDcdTRKh0owU81YLkM+PYAFXKF1095a+mPYPLHlx7DQJF/kJzEQthkmYkTpaDTDqgORq0uN9QNjgrIHHLBAsrS1eoOjlJcdCitEvkhMjq/8E2on5N80HIpPwXLMfIZLU=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:58:50 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:58:50 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 02/10] EDAC/mc: Use int type for parameters of edac_mc_alloc()
Date:   Wed, 22 Apr 2020 13:58:06 +0200
Message-ID: <20200422115814.22205-3-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:58:47 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 430a66eb-e9ee-46f7-7dd0-08d7e6b48547
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2933FF5D5C02E4D641A04287D9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(6666004)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vh2BQzG5HdBMQ3LmrRV+KCtk3BNZ13GqsvCrWUv31o4zegMqs0l8RHtt7jMFCnJrEfo0u9hVm7f4JKYeqYMr7gHQkYPAkMbsqBif1QOU6olOmiPXiZLZvyw94+31h3DD3InGMZxCXJZ6v8+Vhj58jUOc+cxwGhGdiVhE9eXxNhlu7FlU2kHYm89Y7ILr1AELgwZtNebjFEz642qp5LL+hG0BX4VVgU3HyWYiULXQPaADWrHAVGyus4IEKpKn9YJHn8KkC/kehGb88nPp7qIOcNRFIVh7LVUXue/9cJwO6JvroGcZ1T/a2+2kBJQTy/It6I+J4mBcVijlvGYng+j2tN1jIjsZJHpXmCM22I+N8LYSiTPqe7ZtXiXhYXFUq6VnhwttC4UXOqXYqG5Glomx+FN680EaW1FMbKzw7bleGh1R6kaQFWBNDMBcugPq2iIo
X-MS-Exchange-AntiSpam-MessageData: icFgKIg5UBw3RAw/pPhM48IE7Xq1KofYSQ6muEJ/LtR+v/fskiAxyD8kEvfDxMgOXjvDnZtcUeUjaCiAnsc7JjPKzCRshuDQ1Aa0pVn/r55eE2nuJ6Fip65ByYLZTHd2hfi9W7KTQir91KzESBYSyA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 430a66eb-e9ee-46f7-7dd0-08d7e6b48547
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:58:50.5428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6fV2H0cMRlrN5Wgc1DlAPiUNsiddtIgEApxwpDJ/YVgXgdXgp8V3wgUjvQlRLZxJqbYN+uz/6+7TT2+HnF132A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Most iterators use int type as index. mci->mc_idx is also type int. So
use int type for parameters of edac_mc_alloc(). Extend the range check
to check for negative values. There is a type cast now when assigning
variable n_layers to mci->n_layer, it is safe due to the range check.

While at it, rename the users of edac_mc_alloc() to mc_idx as this
fits better here.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/edac_mc.c | 7 +++----
 drivers/edac/edac_mc.h | 6 +++---
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
index 107d7c4de933..57d1d356d69c 100644
--- a/drivers/edac/edac_mc.c
+++ b/drivers/edac/edac_mc.c
@@ -444,8 +444,7 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
 	return 0;
 }
 
-struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
-				   unsigned int n_layers,
+struct mem_ctl_info *edac_mc_alloc(int mc_idx, int n_layers,
 				   struct edac_mc_layer *layers,
 				   unsigned int sz_pvt)
 {
@@ -456,7 +455,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	void *pvt, *ptr = NULL;
 	bool per_rank = false;
 
-	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
+	if (WARN_ON(mc_idx < 0 || n_layers < 1 || n_layers > EDAC_MAX_LAYERS))
 		return NULL;
 
 	/*
@@ -505,7 +504,7 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
 	pvt = sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
 
 	/* setup index and various internal pointers */
-	mci->mc_idx = mc_num;
+	mci->mc_idx = mc_idx;
 	mci->tot_dimms = tot_dimms;
 	mci->pvt_info = pvt;
 	mci->n_layers = n_layers;
diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
index 881b00eadf7a..4815f50afea0 100644
--- a/drivers/edac/edac_mc.h
+++ b/drivers/edac/edac_mc.h
@@ -98,7 +98,7 @@ do {									\
 /**
  * edac_mc_alloc() - Allocate and partially fill a struct &mem_ctl_info.
  *
- * @mc_num:		Memory controller number
+ * @mc_idx:		Memory controller number
  * @n_layers:		Number of MC hierarchy layers
  * @layers:		Describes each layer as seen by the Memory Controller
  * @sz_pvt:		size of private storage needed
@@ -122,8 +122,8 @@ do {									\
  *	On success, return a pointer to struct mem_ctl_info pointer;
  *	%NULL otherwise
  */
-struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
-				   unsigned int n_layers,
+struct mem_ctl_info *edac_mc_alloc(int mc_idx,
+				   int n_layers,
 				   struct edac_mc_layer *layers,
 				   unsigned int sz_pvt);
 
-- 
2.20.1


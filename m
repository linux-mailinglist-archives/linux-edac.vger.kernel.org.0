Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABA17C173
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgCFPN4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:13:56 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:40364 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgCFPN4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:13:56 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6W5c002687;
        Fri, 6 Mar 2020 07:13:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=J7SWVWlBw1QXNKX9qKg+QOUhvPBQ9BRg78EcEtmHywI=;
 b=qWytuvprC+eVXOxMcruA5HMLm6sOLhuYpIteWgfcTt7XFMmwxUa/OEj9ZVLPwTz128ab
 JEQr92kaE1I0YyusQ/3LCiVOFMvs25We4nOenZPXQB34jYdzS2jDuMpHzrub5h3xTVEO
 UymcXt1+R7CMRyGjybSD4OnPjry+Y4F/ii5wA6DqifFCTmG9aKjxTcpwJcTav1wGqC5e
 Vnqzt5/fWjDgvyD7q+gWOn2M8Xob/5I7RY9XmxMHr+oLFt61ieuaP0EUIV4ir/XYsA1m
 Alzm06vgqoOzmR4ekGm0dcqtlYSMxYSr+h1jcdz/f1bdni+sdXzc8IMRTEwMqXOmQzGg mQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2yjnjhb2cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:43 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:42 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIAwjxnHgjmuz+Th3HCQdvtICYtS4e+L7tNI46exbh5cn8HEVEgYvQtpaXdT1GlEojoIeLbymnShKpgI2RYe9HrvcboZniUZr74YQxyEtrX+yDP+lXBflbGq/pjPld8ijg6TJm3imEtf5bnBdwyqodyFJGuIEqgKHXM2Q5/n29OG3hgYqMeKXVDMSMWLAmT0b0MfSd/rM9kfUyyFETNmUsJ41E3jvUIpLmpa6WTgp12EGHCGzKP/n2HV3ayiHnLRAPIutED22j4Nb4HkX0HEDzRpSi5xTysf9Dlv8V1U1cFbjeF8oqrMRtvZ2X8Kbjx2Rp01xjIAdGJwcHifvEEfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7SWVWlBw1QXNKX9qKg+QOUhvPBQ9BRg78EcEtmHywI=;
 b=N03t0Gn78M86wZtD09bUcUdsf5AMEHbH6p1CfbJ8RCOWOwHll8z44S4Jk7VzJIkwfVs5CCvFf4niNivVmh0B+OUro6CHXvRpaREnp8iANqPQRhgjJBj+eCZPgsV7kBF4BPfRQYoHI6z7VROQ3fvR3YsVQ0iBPQhP+06T/v3e3yjCNJwiZgXHtkZw/+EiulkqVPjQWcEaOl2si7UXOobQ+j6/W+9QpTuMNK0yW+5jmUnrgAFqIMGDbnigt6BWeWJuUiQyoXwWxKic0vAFejyDjwEQdjqKQ0lgB/GKSGpxnbfHJh1WgqMaavNVyMOP4qeLyk/odGOWDRXJ768V3riIvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J7SWVWlBw1QXNKX9qKg+QOUhvPBQ9BRg78EcEtmHywI=;
 b=o66gOzy8ozcALgxWWi6VRCTVKmN25EDq41iS5+yu8EnoHLlIfRukGB0hzSG+N9Lbc/wbcgdWbt9WS3IOuUDmfSklmLLI4HXxrO280WVWvqFtXLMPKHYUAJsMd6IR6MEARcNPDDREHzrBwAzXdhP8o+JD2TlzB1H0yooDHEjFpO4=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:39 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:39 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/11] EDAC/mc: Use int type for parameters of edac_mc_alloc()
Date:   Fri,  6 Mar 2020 16:13:08 +0100
Message-ID: <20200306151318.17422-2-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:38 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc70ac9e-ab64-4835-f3dd-08d7c1e0f338
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB24002F2709384200E9FB6331D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPAwJnH/JhOG4EwIHSVlXI4oMrAIP67FMjDLYrrl+uNALJaC43TrORbJGMY72flgTJa5CwqQqpvLoFnjqcGxWlx3WnYhA4uMC9am19xH3Uf6u6KYv5Cq6LNQSkTjoB7p3xHffpX3YRj/JXzIWMSwb+kcaB+ckPEhjXyY6pH3zWvF0webdlNeNtktzV9/rhHk782m1CxLMUHkUIGowXLUU5GPGXa2IPE8LAHPcuJkpSHH0Wf3W8nGyYvUnwvF2MiIzDFeGnaF5LpVH/CO3DFtQCT4HZNRY7d9u3/WcfeG6fESk+1S815PoDlVKSbJm7TdoO9mQqnBrd/NumdpFHlaoETVdxNq5JKJrTYvHxlbyicF5ByrJ2y0DvQ9QXAhgX1Ubj2RBiv7gb2hHTEKjkHmvgGIGNRC7Fy5wvuLclsk3Va6eU/WxA3Dumxw1nQIGGpo
X-MS-Exchange-AntiSpam-MessageData: wBWrl1iwieMUWeURw1tk40nsM66iR4yp106Em72wTKuCX8h/g24XEh2jjL6JDes8GjLYE9eVM+MX88tvmy/4u2XIWJtCZz322khN1uKg8NN0jMJOYlcxhbw9ZtS3vc7uFb7sc0r5nO4uFSreSbYS7A==
X-MS-Exchange-CrossTenant-Network-Message-Id: cc70ac9e-ab64-4835-f3dd-08d7c1e0f338
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:39.6783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkOFz+2ZYbbjv2U8AW+z98DcgqSbhm4OvpJCql1fDBB1IQWgUUnmuulRlpuvL45O+u4bSLjReCAWUXRTlIg6cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
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
index 75ede27bdf6a..8bd3d00b4385 100644
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


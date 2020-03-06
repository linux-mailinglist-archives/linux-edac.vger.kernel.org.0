Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9C1C17C17F
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCFPOY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:24 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16350 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726974AbgCFPOA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:00 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6JCU006235;
        Fri, 6 Mar 2020 07:13:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=bApS63iUcSfIYWU+pdaEJ8aTOAhZt10nEy1htK5Pyz4=;
 b=Iamtm3+V6sJcQOX7N0dApog954jXIFQ7yEqDXMjIvilD25snwkOoPOBJQKLRY/AFr4XA
 JYAE/cGncCdmFduEKhpN67ima/99/1bkey8MPv0wCsLooVINsTLP8xV7/DqSiW1uub8J
 M8NcG1Bk096yEIaSjH5ZEUrQXks/ApZhBhWDxKkaegZPlhyp+rAKYsY+xe4fu9y1z6AN
 bJqXrghqxdlPQIPMlqkliIbQd1Eyc2C8mDmJZJqPlsGgQLN6CUm2lBkkn8dkbn23gYZp
 CWXZAgdTtfesip3uQvhChy79byPw32rtzdt6ns/N6SodtHOlhVT0qjdB9a5IY9WNH8Wc Ww== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:47 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:44 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VS8osrqEYTUZmBsReE1ud6iX3tyq6/t6POTJZiKtsrkUolZ2QPTyWgu9z7vj6/MX/eTJ6UYrrPyrJvBk6Bhr2LRq2vJq+aEvsP6VMp2qSkaZBrGyet0FiE8rhNT3cqSM8iScAvusb3kNedwIae5DwkRHmNq/AdQl3kn5I4nqaA1TaR1cZDz7F/4lZlowemAwk5k4njL63G1QEPKLSh3angig9hVwmYr4SG3aXzTD2spoPYejpSklXosJBYejj2cIKOw3Ig/hQ3ifnSqmcrWjfhc29lSnucR/SuEKfErzwZFQz08ReB/N5NbVE/uuxV0Z97sAfdw8RKTnP5pF7557CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bApS63iUcSfIYWU+pdaEJ8aTOAhZt10nEy1htK5Pyz4=;
 b=A51ODSJLjVf6B6lDdKVxI12EPfacM7sU7j18cBQ6XmY0f8gQoxwOX8ePr5cWFmj2QcN4kgtAtvGe8fIhnFlvz6U0a2zPsqTtqty5pOeBc5cVrryAs11mIkV/8gXAc/g6GTwMNVe1+tvD/FxUW2cg7qSkU3haUmteLw7Js2Ve89A/R8vbmx/oV4Bnz9wTKNSR++p4Dn5vUqoz448fetVtGOWWYKknSDeVW9a8Xfs4btsbIJ2pZ2QcsBDNW2gcSTSTM7r/Ooi/oApMqKf0LZDyk6SwDmMPltnfBhgLTaro9BBE3XaBRQaHGFnjfJGfpBWfCWtoT1Axr+i2n+8wn+hunA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bApS63iUcSfIYWU+pdaEJ8aTOAhZt10nEy1htK5Pyz4=;
 b=AIVgLzfRmIg6/5DjemUFc3EsGyHQfs7hF+EmOBWd+6YnUqShqgm9WULbtTKEg7zvOWh/QX2geBTJLr6m799e4oWhXVfVezdQYFISR/4s6qOwOt8s8v3ZedlI6IlXQBbMC+0TLOJDM3mrjvABeGbz5FryGRV8NYI3DTsVVJnau+A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:44 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:44 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/11] EDAC/ghes: Remove local variable rdr_mask in ghes_edac_dmidecode()
Date:   Fri,  6 Mar 2020 16:13:10 +0100
Message-ID: <20200306151318.17422-4-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:42 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 169d4005-b3c5-4fe0-c068-08d7c1e0f5cb
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2400CEC2256CB10792C84B09D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39850400004)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 39+2AwtqijigaV8D1BZ1mmn5ySx9vnsuWMXPeU1ZVmRs46OZ/aI2W6FDTlEwe2wvnYdC2b8vUtSXK5j28GnZw8igLQkAu5H+Xu6Du+tKUx4KcxrvnhQqih6GlccdZ3x1/wpFsdhvMHRY96ukcCJIZyUhJoyePcjhXvFmtRrKiU6tL+71UKdHG/H15oIN2KMXPVCcTOL7Tdfz6S6rtpe0F47TOSACl4g0OSusmIf9CJGH1lIC62BgWEn7C3pGoJ495b+go/dhs+6e5s/9G/5dSVRC2r7wuBbm736C1yANg5g6Du6n7YHkFDnfx3j2f5xMzwhZbuXHU6PJ1lJ0vzZNCpDKbnBiQsfRmnXbPPmh+hDoN+0XwkhH19AwaxVC+mRSy98Fqp9Itl6SzDIRu43O8y1qLWUDs1rQmmP7qn0T0WTVz8OQsb5guNAp3kwgoWM+
X-MS-Exchange-AntiSpam-MessageData: PZMiSLfvaFFjjEHt45YH6bAKEV6abottcqFkDXWylI1kW5vPkQaNtRAHo7ixfi56rtmfsUl6QaRgbHdWMmJiVgUfuce277BR2DWIa40CWZpKZ8raMUACe4cuX2dwmw5quX8KIsjeBOv26ds0hGxyYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 169d4005-b3c5-4fe0-c068-08d7c1e0f5cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:44.0658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpH0GTC9ZEVaVhKz0yT7dPLCXBkmBkfpvgYgxy37aCJGlgXoXxuifIgh+3ssuIxzxruP6WgBB90uAb+vtb6d1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The local variable rdr_mask serves as a static constant here. It hides
what the code is doing. Remove it and replace it with the actual logic
that checks some bits.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 07fa3867cba1..fce53893731a 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -123,7 +123,6 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
 		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
 		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
-		u16 rdr_mask = BIT(7) | BIT(13);
 
 		if (entry->size == 0xffff) {
 			pr_info("Can't get DIMM%i size\n",
@@ -173,7 +172,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
 		default:
 			if (entry->type_detail & BIT(6))
 				dimm->mtype = MEM_RMBS;
-			else if ((entry->type_detail & rdr_mask) == rdr_mask)
+			else if ((entry->type_detail & BIT(7)) &&
+				 (entry->type_detail & BIT(13)))
 				dimm->mtype = MEM_RDR;
 			else if (entry->type_detail & BIT(7))
 				dimm->mtype = MEM_SDR;
-- 
2.20.1


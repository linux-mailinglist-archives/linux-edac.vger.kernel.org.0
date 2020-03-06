Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D5A17C170
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCFPOH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:07 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:28844 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbgCFPOG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:06 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6VCq006307;
        Fri, 6 Mar 2020 07:13:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=Fj17BIJtDBQffoaL+FMmtv8P3pMpVzXK26quhx1Xnpo=;
 b=XVIeKo5w49PqLyhedVFEMUYjD2hg42vHuifIYeg9JgTpaGiGSr066nfuf+h4970LokkJ
 WFvTBLAmpHwV8KE+qBPfjEmB6d6R3cjwvfDEC/BEydnUlbDe8t7n/5mH7pUx4hjNGfDY
 Yr8Xw99VhMj7LOfvmkXyhR0k03zU+HrwauQMQNTSlPsCt7WHS/sBFFlkwU1vBlI3EcS8
 BanrKricx8Mcn1s39pX/dcKyEpOE7s6aInrr85AKpH1MUAr3dzjde/ZyCJSaaR3ihmDC
 3G5QDVorCRarieinsZi9BVnLXAWtJca3UN1Mxs74F7zRbTvthZh2fSputcyL9TnMqdgQ vA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfwe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:57 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:55 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oT8V8LfxZKNd9j0timnCdd6jWapphFEF3cDUf/I/DyzT4PDqikFT3KGLFTVurYqpXMZbqTVTkBaSuv8aCoy//foWcrf5TNkOy5/YGWXmR147ZJ7QU2VLDmAH4q3N2VJQ5uUNpiAsHyxTIsY9dZcuoz5WuFSJG2xlO9XSmzQQlqJEECnTg2UMc17gDOyJpGrcdIK+z4FZKJjOhf/J5Q/2fmbtrd13VNLwSkRf/N2W8r4LT/xAKsA8nW6ugFLlxUraplhFda2e0xyvSfmqengA8EKGvPT1ZGP98mTEH0Kc7W5xJrPIiiwL0d3hV8f3zKiBbGtOosQdExjFxjBOZBE2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj17BIJtDBQffoaL+FMmtv8P3pMpVzXK26quhx1Xnpo=;
 b=INNA7ttW2Nv6vXg2VIxrXcj+k2bliZC7uwoBeDUUATQpUhCw1B7eWLVEKYY0nOU3wIKAjS8V70BrpdYlt7OZ2ki4erswYtgqll+nXQ/UCnRJdZA8djw4nNR3SLNh5WFczwzjslGUoXVNhE3in0/n3RYVtduZ5TGkOUSIz+qSgcgr6atBl4laQMFUA3sCfnQj/3ISXw8NIZj8N25qkKNLuo4lHJ/8xdrb4PbNOnaOhdi+H+xOGf8n520CATpQTT0Hvuck5M1OmraISx2SZarCXlfq/y4UhMFCzJmLTYH5gQqkP2k8m5wRahoP1sUQoFWovfvPfuxZq9igF7kvolXZ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj17BIJtDBQffoaL+FMmtv8P3pMpVzXK26quhx1Xnpo=;
 b=i4+xjZ3Y4ITdOaARwmQIo3MChPD4T8WBuskHl1JszVchP9IzHqt1X/O3t2G7pDGFxJCYH/rZFzIzsGLcypsdjBq2UEv3xY56Cm+T3N8Ki/A/vJIwe89MD9W5Rn4Mz4TpmAcyB6GDcDR18orogUk0e89x0+NQVTVbuie2/HjclP0=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:54 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:54 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 08/11] EDAC/ghes: Carve out code into ghes_edac_register_{one,fake}()
Date:   Fri,  6 Mar 2020 16:13:15 +0100
Message-ID: <20200306151318.17422-9-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:53 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4a183b11-8fd8-4192-e25f-08d7c1e0fc3c
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB2400C01253BCC53FAE6EA671D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oc6+lXAXdVIiMJV3zBRxyhKA94Dgd79bncgMrSL9HJww17xfiKfFeD6cJUav8LYMTTHESzNilAQmFE3pbR+/8GMqAdvVwMxDWANQf4CBru7Yr6vI9amjDLHVIT8mwvOw5vv3WJzLCbb9bk/+Mg3UZ+eOVQdUYrFaEcsbS0koQZLkZp3/5Dq1PLlrySc4dh8AvrLE3C8I4tYk6hQcTlc9BjN9nAMhcysXLORk4xLRWktH3G/iG5RGoo2kv5/LWQ8App+wjH9wzMGnvt7i9CGbEEQie04HtKxnTjygN1E03ZDhCA0qOxg3ZLnAM6nF7vV3Qz9xQtbhws5/e7N0xrI1LmRdlBdfhYlKZp79G19NTmNChhO7LPZlxd85DbuZHLtLvSpw13Rm+GPHKlD47Nh3WDV2mifVc/s4BBre+ajzPA5GY3pZbXUkfYlpOI0fKkB9pzsgozZyVG49xOsMd3HLPLn8+CexNJsVvy497f1yx2box7FrklYM+n3WgmCy4lKD
X-MS-Exchange-AntiSpam-MessageData: Qinqh5Q0QClvSn59GFonHhZMbC4A8MVKiyZcFgFN6dBoyy95mQeXixIpiU67mbG4+Rd4+DP8fE1ImKcoMNhRhl/7/QaUcd96X6Rq/PKMa/AgxHwGvo5Fy6ge+82lAefCpINIzPbkInMwf9/ZCL462g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a183b11-8fd8-4192-e25f-08d7c1e0fc3c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:54.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHT0PgCBkHwDLjEbkDag8mO+be0he3Shk9pPJDa6VYnb6TBfTwGquWjhQDYDppW/LpLj+CstFaB8xicuaGZLrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Factor out code to register a memory controller including DIMMs. Do
this for standard and fake memory controller in the two functions
ghes_edac_register_one() and ghes_edac_register_fake().

Function ghes_edac_register_one() could be reused to register multiple
*mci structs.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 72 ++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 32 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 7ead5667ed73..0af7f6a988a9 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -530,11 +530,47 @@ static void ghes_mc_free(void)
 		edac_mc_free(mci);
 }
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static int ghes_edac_register_fake(struct device *dev)
+{
+	struct mem_ctl_info *mci;
+	struct dimm_info *dimm;
+
+	mci = ghes_mc_create(dev, 0, 1);
+	if (!mci)
+		return -ENOMEM;
+
+	dimm = edac_get_dimm_by_index(mci, 0);
+
+	dimm->nr_pages = 1;
+	dimm->grain = 128;
+	dimm->mtype = MEM_UNKNOWN;
+	dimm->dtype = DEV_UNKNOWN;
+	dimm->edac_mode = EDAC_SECDED;
+
+	snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
+
+	return ghes_mc_add_or_free(mci);
+}
+
+static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 {
 	struct ghes_dimm_fill dimm_fill;
-	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
+
+	mci = ghes_mc_create(dev, mc_idx, num_dimm);
+	if (!mci)
+		return -ENOMEM;
+
+	dimm_fill.index = 0;
+	dimm_fill.mci = mci;
+	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+
+	return ghes_mc_add_or_free(mci);
+}
+
+int ghes_edac_register(struct ghes *ghes, struct device *dev)
+{
+	int rc = 0, num_dimm = 0;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -564,25 +600,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		 * with only one DIMM for the whole address range to
 		 * catch all errros.
 		 */
-		struct dimm_info *dimm;
-
-		mci = ghes_mc_create(dev, 0, 1);
-		if (!mci) {
-			rc = -ENOMEM;
-			goto unlock;
-		}
-
-		dimm = edac_get_dimm_by_index(mci, 0);
-
-		dimm->nr_pages = 1;
-		dimm->grain = 128;
-		dimm->mtype = MEM_UNKNOWN;
-		dimm->dtype = DEV_UNKNOWN;
-		dimm->edac_mode = EDAC_SECDED;
-
-		snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
-
-		rc = ghes_mc_add_or_free(mci);
+		rc = ghes_edac_register_fake(dev);
 		if (rc)
 			goto unlock;
 
@@ -602,17 +620,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has %d DIMM sockets.\n", num_dimm);
 	}
 
-	mci = ghes_mc_create(dev, 0, num_dimm);
-	if (!mci) {
-		rc = -ENOMEM;
-		goto unlock;
-	}
-
-	dimm_fill.index = 0;
-	dimm_fill.mci = mci;
-	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-
-	rc = ghes_mc_add_or_free(mci);
+	rc = ghes_edac_register_one(dev, 0, num_dimm);
 	if (rc)
 		goto unlock;
 
-- 
2.20.1


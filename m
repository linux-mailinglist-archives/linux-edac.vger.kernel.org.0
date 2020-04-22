Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D306B1B43AB
	for <lists+linux-edac@lfdr.de>; Wed, 22 Apr 2020 13:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgDVL7c (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 22 Apr 2020 07:59:32 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1332 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbgDVL7a (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Wed, 22 Apr 2020 07:59:30 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MBpH1k031933;
        Wed, 22 Apr 2020 04:59:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=6bZMa9OFDw6qIGMoEgf9SrLzVCWwZUnKd3XeIxGW3S8=;
 b=GaiLwRPk06+qVjtdVr/8QyhI1FCc5MYk8grIe8vHJtDn/guQ4Sak6HC2L9N2B1qXObi5
 I5JyICJC4EQo/oSTlsbtQgxEAbt+hGg6yf0gJO2WpM+57eKx3/U5Vl2dg7LQmbIpvTOz
 9R/xtSxgMgU7mN+qdCvOd4cL1Wa78znE0nV+h478JiyIKtcHNMZWKn4ZnztXI1Yqq08c
 T2uOWjTMpy1Mvz6nR4CoKB7WcRD26j8rzJD/e2SJWkFgSesoJT72PGQpJbCWfz3eO3l+
 wXlM1a9n6OMfLVr70emArp6QOKtN9Hp1MxKjubtCeaW/4VcjTRnkurPqRsI4QZ9yb3Vb kQ== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 30jd011w5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Apr 2020 04:59:19 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:17 -0700
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Apr
 2020 04:59:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 22 Apr 2020 04:59:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF464J7dcxOYryPBXWxoxXAtauZXrwHzajYNC5CqDFk2KL9EmpC5Xa40KXqYj03am3kCfm0y6dIVtjPIS1h3SLtWFWyy3rdYjlHhJrHxyZjHNp6vmfzPfXvpOsnou+o6abCHFS6zqFGs59Y2kEvdNaDVfBHJY2ihd6jysQSVEJ6Z7ZSUvsfq1IavEn2IBK79W79NWoSmmx06SKiDdE5EToGibT6IqCMRoCFwUIf8BmTRatdWESsvZGa/+qFFVap5TTovJOZR0qAazZm1A7fx479SiDrS1aSwhDYiihkDpwEHLQ/BZhQTsUDl4VEJ8913UNI1YCiU0tjvXY3ay8CsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bZMa9OFDw6qIGMoEgf9SrLzVCWwZUnKd3XeIxGW3S8=;
 b=NfYWNFmP9rDPBk+NIl37MvxgOR1Vji5heuSEevcX5zGRdYQ7tu1/fJxtao1fHVd/u/k/hHG9HsO/vhc+Si54yklWkA2KnKPs7NkO/hBlqH5Y+bnvfHX0daaXzDKZm5HzYuLXhLg1xTC7Em5KDcyNtWSnjg3fP+sliWUJe6DmEKawtKw3UsvnQTzw0aBdWwKK83UVPbnY1DAZzJzgMVN7trcHUeWy6f7owEmMPFgKIhrP26h6X8hwynitzQAQ0tdi0WW1pru5MrpfAOsCfL11bmkfmvdRnUP61SzrLYDpR528ig+90hbbUZqbUFpt31Abel4KfGRORuvT+cmkp+/wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bZMa9OFDw6qIGMoEgf9SrLzVCWwZUnKd3XeIxGW3S8=;
 b=nHFU2OWa4lwTF4NnO6cJ4mOZ9gqfl/wy5RG31r5QEjhUEfdjmd2pgT9AB7G7m7LrhsRV2DSdC6MkMXNVxEqkZLKXWW5WTAgF0Wqrk1he5Wz5KVcbC5oTX31plaQvnRQlMR5RhE/8HCfw6qcCHp/jHrZz7Rq8bwEuSW2us4pBK8U=
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2933.namprd18.prod.outlook.com (2603:10b6:a03:10e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 11:59:15 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 11:59:15 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/10] EDAC/ghes: Carve out code into ghes_edac_register_{one,fake}()
Date:   Wed, 22 Apr 2020 13:58:14 +0200
Message-ID: <20200422115814.22205-11-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0701CA0076.eurprd07.prod.outlook.com (2603:10a6:3:64::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Wed, 22 Apr 2020 11:59:12 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a24f55c-5507-4988-078e-08d7e6b49418
X-MS-TrafficTypeDiagnostic: BYAPR18MB2933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB29339E9BA110092716090454D9D20@BYAPR18MB2933.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(366004)(396003)(39850400004)(376002)(136003)(6512007)(1076003)(81156014)(8936002)(4326008)(6486002)(8676002)(2616005)(110136005)(52116002)(186003)(16526019)(86362001)(956004)(6506007)(66476007)(2906002)(66946007)(54906003)(26005)(66556008)(36756003)(5660300002)(478600001)(316002)(142933001);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xq4iZsAznlgD7IaRDP0z0aPD1wn22Iit69XVTdk1r5JU3WjV2LVXQ3vCevCqUGwSTcEYMslcj/jsKHoGx7I85s0+3YCR2bE+Mpl10iU22xMZwbnnGvG5Tdhl5sPPo6yUw4KYwgAZHHObBy5LOQ5w5wpbItaNzzo4S2i+PyqD3HSBKkq15XRDrYzMwPyiMsx9Z6CjL7vxpcqm1ZmhbotFDneReV2mz1u27Fw0x4fWgJo2pYKiXZ9H2lRIQXJSSUJ9kOrs8SanaG4ldlUMNYWfzrm48hcO9twFkm0H09N/m2rgeW//7aZm87mIGB9AEVPoSnm+ZVQxdtR+aTwAdbZNf6xUEE3fQb8zTDYE5y3zMCxUxuVQjvfIOtSzD7NuNtodVKD8jpgdiZ95pXQ+gXk0PKEJ7z0iptAtc+yc32RoYbA9npzBtwEIghfRqtjg17U300nkkYw2+BT0VpQc4+G/wn9NPj0Yp4MQO8kFtiR6E0mahmYXgK4MKjdRKQxHjzot
X-MS-Exchange-AntiSpam-MessageData: 3BXofJt8R7mSXnO2h0mfOsrliQ4mC2KLsKfOsXBetBRAk0/Xcq+kmrmwYqZH+t8wRihCSsI/6MYT1I9B13jDELz0c3LwZJTcagvAdvY86KK9BPLd/Csz7UdvJIs6lVbbcAZ0C+685M6HbnVeviQ12g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a24f55c-5507-4988-078e-08d7e6b49418
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 11:59:15.2667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIPxa57bCk2ziiZQkT2dL6YRNjZwG9kbiv1Ldeh7UYHoHSY8jO5bHx6dBSsflMEA4u8uJ6jAH9yQJfGNKWEiJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2933
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-22_03:2020-04-22,2020-04-22 signatures=0
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
 drivers/edac/ghes_edac.c | 80 ++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index af72da156696..ee1e95e9b59b 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -610,11 +610,50 @@ static void ghes_mc_free(void)
 		edac_mc_free(mci);
 }
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static int ghes_edac_register_fake(struct device *dev)
+{
+	struct mem_ctl_info *mci;
+	struct dimm_info *dimm;
+	LIST_HEAD(empty);
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
+	return ghes_mc_add_or_free(mci, &empty);
+}
+
+static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 {
 	struct dimm_fill dimm_fill;
-	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
+
+	mci = ghes_mc_create(dev, mc_idx, num_dimm);
+	if (!mci)
+		return -ENOMEM;
+
+	dimm_fill.index = 0;
+	dimm_fill.mci = mci;
+	INIT_LIST_HEAD(&dimm_fill.dimms);
+
+	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+
+	return ghes_mc_add_or_free(mci, &dimm_fill.dimms);
+}
+
+int ghes_edac_register(struct ghes *ghes, struct device *dev)
+{
+	int rc = 0, num_dimm = 0;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -648,27 +687,8 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		 * with only one DIMM for the whole address range to
 		 * catch all errros.
 		 */
-		struct dimm_info *dimm;
-		LIST_HEAD(empty);
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
-		rc = ghes_mc_add_or_free(mci, &empty);
-		if (rc)
+		rc = ghes_edac_register_fake(dev);
+		if (rc < 0)
 			goto unlock;
 
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
@@ -687,19 +707,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
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
-	INIT_LIST_HEAD(&dimm_fill.dimms);
-
-	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-
-	rc = ghes_mc_add_or_free(mci, &dimm_fill.dimms);
+	rc = ghes_edac_register_one(dev, 0, num_dimm);
 	if (rc < 0)
 		goto unlock;
 
-- 
2.20.1


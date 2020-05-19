Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDF71D949D
	for <lists+linux-edac@lfdr.de>; Tue, 19 May 2020 12:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgESKp4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 19 May 2020 06:45:56 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:43060 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728733AbgESKpr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Tue, 19 May 2020 06:45:47 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04JAeaW8030400;
        Tue, 19 May 2020 03:45:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=s1V3Liiq1EnrziFxJrIeqdKByYPhjiOM9qxgg3deTyc=;
 b=Hy18dqwig8kmfTIHwDMnhCYJAgmyw++jKnvucpXi2XAIpz13Mx2pr2muOisu5zV+kZ6m
 BAFOZtUgXropcmQl9mPHws3qbEimk/hY7QfK12hT8Hf4yQGhEFpITu6zMVHdVQxImh9q
 t027J9FVnzh7fBuY8zDWuolU26C693VzCapVTY32mCOGjJA5q3pQqqdddAeOvx+IPuLJ
 jH92e+Ki2kM3eoc5gfFwPrR3/XA9NB/l6oK78lY0l5qkgjv3NyM534UXV6S76Ntjzjiu
 I9+DEeJtclcihc79sx3LbFJjESJfugGm+OeP1LBRJ0Y9ou3gM30FJiEILbeagHpo60L5 VA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 312fpp2ybx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 19 May 2020 03:45:35 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:33 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 19 May
 2020 03:45:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 19 May 2020 03:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZ+jD1Qu7AR3jbgbZhwQ073ywKxTpx6YAdm887U7+YytwXtn34O3CaQHNm5fMVhipHl1CLEUQdVZiH/Fw+VB8ww3BnAcrD7JWI6A1ZAxMbJ2PTBxFeURqLGuLQgsFNBcdgwLj70JkmKHgFjT/J+C6ZK5yl1F294unE6gez8Nk6I0/MsrG2NMc1HtlEdcYl+2aaVT3nmJMJmDyDpDOVMTmwlB4ku8MCuwNd2bNfkNa9wM0m2AXR1cz27ngeqxoSbw5juyORaU7Y4fFGc90xIcAdh3duzLxb5w4ECzkPtgiXpa75E7vETQox9XTCGJsCBhfzisW2ti6LLiWHXioXN/GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1V3Liiq1EnrziFxJrIeqdKByYPhjiOM9qxgg3deTyc=;
 b=cT9XaWtI0+pl0+lF5X32mDs4exOhU2ELcXkz4S1fTIaAbgaRisss/5aIpyS2Uy4hfFYawrr5NHciwBahlrQFQi1PjjrOtkcX8GsuHDpbgdeRSl1upRCQ/CDjhlLCLhTRezUSFUMfgOtgIgrfYT7JmBwejRfR3/QlYENEQr51IrQtpo31+7vdrWNaSGY6/H33sdllx7F7RQ49bDpYhRaP6iWPQEDRFCsO/Ez2+vQqviadb8m1I+FgicmCpPtwOURsQL4xhddSOnIY78471tjVJgjiyf1bU550eNqe/iyg/akuuF0MmjSMcDURs2Y/TN06x7W+7sGzZHLTTHg2BMwbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1V3Liiq1EnrziFxJrIeqdKByYPhjiOM9qxgg3deTyc=;
 b=aFviab6Ze0mueWW0w3G7cuzwUeHE0W6oc/+2pIb/m9c0qH9YxTQJmTqr9o4U0lr0RhJGl5Q2/hcJlYwKTuqGc+WAvFL4EBE91gmZlgpRq0fsUk47tojpBnGXwI4LGbEtue4G71JA6i2hBPAanAlYskfO8fSL/aA3c1yC0gI1BJY=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=marvell.com;
Received: from BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
 by BYAPR18MB2455.namprd18.prod.outlook.com (2603:10b6:a03:132::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Tue, 19 May
 2020 10:45:31 +0000
Received: from BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d]) by BYAPR18MB2661.namprd18.prod.outlook.com
 ([fe80::a165:ffa5:f3eb:d62d%7]) with mapi id 15.20.3021.020; Tue, 19 May 2020
 10:45:31 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Matthias Brugger <mbrugger@suse.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/5] EDAC/ghes: Carve out code into ghes_edac_register_{one,fake}()
Date:   Tue, 19 May 2020 12:44:43 +0200
Message-ID: <20200519104443.15673-6-rrichter@marvell.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519104443.15673-1-rrichter@marvell.com>
References: <20200519104443.15673-1-rrichter@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36)
 To BYAPR18MB2661.namprd18.prod.outlook.com (2603:10b6:a03:136::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rric.localdomain (31.208.96.227) by HE1P189CA0023.EURP189.PROD.OUTLOOK.COM (2603:10a6:7:53::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Tue, 19 May 2020 10:45:29 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9ffd946-8380-49a3-6a12-08d7fbe1c080
X-MS-TrafficTypeDiagnostic: BYAPR18MB2455:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR18MB2455713C9FB66C0CD2CFB76BD9B90@BYAPR18MB2455.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 040866B734
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qCoUeHOJHl3JgWUVu8OpPdTE7O8MwNYPu+4aSvaOm6XSxeAB9+5Udk+Mz3jm2cw9Nw9Q3hzD9MgrkWAK+5/cmY0gtXGeFQC490SIqTjpK/bJ3EnbPcsyYKXemf1L/BHGlWnmNRNMwYyeL2+Rvgb7Q7Ie+/wjI9KUaqtD+N7NfUeUEU87h1FtoajCd9bz0OeuHNx9SPyu3RLwntOtaYgi1rocijQ9OtFOuQdHpYrgdRgbVos/h6kjrAcQYm2/CC+Rxe1DZjuAh/s6Jk6tk4wqd0Qwr6h0Neaf/47LjmeOWiJFlBMJLhO/PcTRM+QkJhJz6uaBBPGz6/mu/6QFb80ZiRj3Kvlnhkuqk9qQlDLhrzyTz7tmMjQQMYUaOpnCL37f60fe6u9VkhatqCssgI/lFz2Nc9HIUfuNSBALnjQTx9ywW+TAHMRCOdmJ8eJZO+f8wkkEMJAtK76U/ymaOLOr/zZ70NH7X5aGIUKPtFW6M23jYPTLvWawiOWoYBANO03b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR18MB2661.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(186003)(316002)(16526019)(6666004)(956004)(2616005)(36756003)(8936002)(110136005)(86362001)(66946007)(6486002)(54906003)(26005)(5660300002)(6506007)(66556008)(6512007)(66476007)(52116002)(478600001)(8676002)(1076003)(4326008)(2906002)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5Ig+CT2yfMC+whWcG8KQOXi8Du3kc3Z/MSfd5/NqLlyHeUfX2CuEtEmb8ZQdSykby5rzaWs6DV59/qC9FwMBYATW+zEDUYEgzI3LGwkMtB64wtOXqQxY6/PKWUhuHqoSEeysz6AJNJWPr+0r6d7IcLDeKR6WLq8CXAp6wIgOAUWKyny/LTgnV35GbkQPeKSHYW6M6WLZCyhIeRlFFfSRXFFVKHaGMTcKI2caPW5i7MlUKUJ5Xpvqhe5gg+GnUxOmob6ql3jsTn31NauhkPXiLhHkf6Va61h1HvYjXGqu+PINIixdv3XtfN2U1u/AqgOFZg00EKBUrtFmfq7+qmzXr0+MG38JUxquJjZTHRC55FZN58vEkYRCHqoSOc6sl3s98azmZryY6k/jvJVW2Kjz6l5rlFQ5qQqu21rI9iXlGMaM5mX6UW6+iVoQLqPGQUA/x7AnQ4VbAF7uoh2EMtOL6H5dqLArUiQ9LpDp7dusNFQ=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ffd946-8380-49a3-6a12-08d7fbe1c080
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2020 10:45:31.5067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLEHjdPKMRYh0mqd0rA6oLVc0m0l9p4O0b3Ceu94Cuy6jffGI/oonpgORFO8efSLK2Hvz0JLowTr2BKYq8r06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2455
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-19_03:2020-05-19,2020-05-19 signatures=0
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
 drivers/edac/ghes_edac.c | 94 +++++++++++++++++++++++-----------------
 1 file changed, 55 insertions(+), 39 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 47b99e0fea6d..b68cd22e68bf 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -531,11 +531,60 @@ static struct mem_ctl_info *ghes_mc_del(void)
 	return mci;
 }
 
-int ghes_edac_register(struct ghes *ghes, struct device *dev)
+static int ghes_edac_register_fake(struct device *dev)
+{
+	struct mem_ctl_info *mci;
+	struct dimm_info *dimm;
+	int rc;
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
+	rc = ghes_mc_add(mci);
+
+	if (rc < 0)
+		ghes_mc_destroy(mci);
+
+	return rc;
+}
+
+static int ghes_edac_register_one(struct device *dev, int mc_idx, int num_dimm)
 {
 	struct dimm_fill dimm_fill;
-	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
+	int rc;
+
+	mci = ghes_mc_create(dev, mc_idx, num_dimm);
+	if (!mci)
+		return -ENOMEM;
+
+	dimm_fill.index = 0;
+	dimm_fill.mci = mci;
+
+	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+
+	rc = ghes_mc_add(mci);
+
+	if (rc < 0)
+		ghes_mc_destroy(mci);
+
+	return rc;
+}
+
+int ghes_edac_register(struct ghes *ghes, struct device *dev)
+{
+	int rc = 0, num_dimm = 0;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -565,29 +614,9 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		 * with only one DIMM for the whole address range to
 		 * catch all errros.
 		 */
-		struct dimm_info *dimm;
-
-		mci = ghes_mc_create(dev, 0, 1);
-		if (!mci) {
-			rc = -ENOMEM;
+		rc = ghes_edac_register_fake(dev);
+		if (rc < 0)
 			goto unlock;
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
-		rc = ghes_mc_add(mci);
-		if (rc) {
-			ghes_mc_destroy(mci);
-			goto unlock;
-		}
 
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
@@ -605,22 +634,9 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
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
-
-	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-
-	rc = ghes_mc_add(mci);
-	if (rc < 0) {
-		ghes_mc_destroy(mci);
+	rc = ghes_edac_register_one(dev, 0, num_dimm);
+	if (rc < 0)
 		goto unlock;
-	}
 
 out:
 	/* only set on success */
-- 
2.20.1


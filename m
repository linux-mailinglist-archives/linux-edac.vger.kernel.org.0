Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24DCF17C16D
	for <lists+linux-edac@lfdr.de>; Fri,  6 Mar 2020 16:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgCFPOF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Mar 2020 10:14:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:58354 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727201AbgCFPOE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 6 Mar 2020 10:14:04 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026F6VCp006307;
        Fri, 6 Mar 2020 07:13:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=pfpt0818;
 bh=jZ7LljTnMMrbDgenvXBu8SaqZlLmP6LBya/NiZt/2yM=;
 b=n4Ttm5m0QOe6TumBatrDQmn09pzYcrzH2Se5FrBWQQd2+EaX96wQyfVWSxhI0DFGwEiE
 SyIlTy/oBTm6HV4+efLpm62yyo3J70Jwju+zznPaY3kauG5MYW52ipmJq83SrvhgkIjj
 E2coxgeK9IIJI0F0qxW/XmaXxNM2TH5cP2zXHDnVXgnc7MnQyeXDVBAH8HbcKXLjwVJN
 AqNKhqv73S1hEDGa+GXXZ3Dcxrtodj8kHaBaIspBZ1QtM4UUktzaKxVkiYOJImFSO9Fn
 drdPnw14PZvhcyKgnlzvNx40dIn2QZPDkyzaL6G3b5Y/bGorMCXRVRXYNObDd9GYRfSu /g== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2yhn0ydfwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 07:13:56 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:54 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 6 Mar
 2020 07:13:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 6 Mar 2020 07:13:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WMgjx8zEXmSkYva/w14A126GzYNuxyj5RF3wiaT2dl+4MQ8uJgwLDi+rSHu18efJHQh2apvypm+oqZU+ZPa87C9PT9SAYdM1f0x/Ja5TmKXy5kMdUJ4xnC4MMuh1WqNOOx13mn62KsI875+9b1X+xHcy+6RFkXRW+CP/CeRIMGAOTX/uScXD08UsP2r3r5HqaM/DeN8xPTqFEB2cSij8Sk0/4gy/FmoiCbZpT2+k+imCjGVpTyljbM+Q3iTHLj5qnIgmKm3L7uFYE39TAJVl1ycZSMoanCWWwRoEtRcqj7uqBtejxBgh93LI54qO02vcyPU2VE0QSE7wPUJVxWIP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ7LljTnMMrbDgenvXBu8SaqZlLmP6LBya/NiZt/2yM=;
 b=OxsJP38hXxvoiLBMwC2eUcqEGw+MP6t3WCJ5pK+dYqItbT5aujUet27HRSF5ZBU9sLqnNI7uaUAWslBMdfkG8/BsvMxg3FIOcAhOds4E7TtVsyKmUuPcwYvCMVifOgYoOXcJdEcgYUJ5FmDEfKnSbpmlcpc1MbTt+/tEwRe2RXr1NhBzNutl2k6CmpAS3gFSwvIdm9gG57lg0HFQIoguPHFHyusfzSenWTcftZgpxNyA5L+Dmz+oZpgiBT9my79isoNp9+hCT2GAN93N9kowUgOEPhYLU0pQLqMnBbjyrrkbCKFelHrzyqJWNdp2LmqcwFXGZAWv3BH0wnbMWj89IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZ7LljTnMMrbDgenvXBu8SaqZlLmP6LBya/NiZt/2yM=;
 b=cu1Yby0Q2dSgdBONnbRUwBnsTAPJJ2BFQCrRqbgikWIMVEHSXNREcgE7n9tKmZ6bCVKKl7x0p7TpmUT8WoFlJCSlgf0ok5sV048kIuRlkdCu6E5XlYuGuQrPmbSxGx1jn55eMhW2Sf3CFaDcA+5upZneHzl+HRkZUQOCAPAXK+A=
Received: from MN2PR18MB3408.namprd18.prod.outlook.com (2603:10b6:208:165::10)
 by MN2PR18MB2400.namprd18.prod.outlook.com (2603:10b6:208:ab::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 6 Mar
 2020 15:13:52 +0000
Received: from MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff]) by MN2PR18MB3408.namprd18.prod.outlook.com
 ([fe80::30c4:52fe:fdf8:faff%7]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 15:13:52 +0000
From:   Robert Richter <rrichter@marvell.com>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
CC:     James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/11] EDAC/ghes: Have a separate code path for creating the fake MC
Date:   Fri,  6 Mar 2020 16:13:14 +0100
Message-ID: <20200306151318.17422-8-rrichter@marvell.com>
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
Received: from rric.localdomain (31.208.96.227) by HE1PR0102CA0059.eurprd01.prod.exchangelabs.com (2603:10a6:7:7d::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Fri, 6 Mar 2020 15:13:51 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [31.208.96.227]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9437661a-b314-493e-b465-08d7c1e0faf4
X-MS-TrafficTypeDiagnostic: MN2PR18MB2400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR18MB24001B54FFB83120ADE8E138D9E30@MN2PR18MB2400.namprd18.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:619;
X-Forefront-PRVS: 0334223192
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(199004)(189003)(81156014)(81166006)(5660300002)(8676002)(6666004)(54906003)(26005)(956004)(2616005)(4326008)(16526019)(316002)(110136005)(186003)(2906002)(8936002)(86362001)(6512007)(36756003)(478600001)(6486002)(1076003)(66556008)(52116002)(66946007)(66476007)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2400;H:MN2PR18MB3408.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4snqTg+sKYa0WEqsDgQ+Zp1otGS9N3eQvJTiZx+i9KTyc8BbkHB+rdFvf25VeAEYWf8FQbO3RaBberJElFLyDAJX1Wyq8x18Y9QKua5pAXmOIh+wGIoLm58fWpUbrPgmidxvokN8FNnLdXlQCh+xPe6VSMYFCpUSV49QDdBcO8aj6cghI6QlpWMvSepIRmEq09NpgfEax9cvmKeanSZV0/thN05BSp/ugb3tFSrDv8P3EbNjdhwCQMr+/ddiHQRqAOD7X7Csvps9UlJKTASOHDd0PwuUJKmZnErYGgv0PntkmkL3CTV4LkDRgVxHJI9/0QwUKnc5aFOvIOYQf9ZeJP3cA/AZgEeohDXeRTjmOBOxB25CEmR3XpfU0tvmZFBiTz4MbWoo21KF10mlzt8iIcwFQ52y9zYR0bMEUDvE8GMSPRqCswfo28CMoPcMEQE
X-MS-Exchange-AntiSpam-MessageData: VG/q9cyhdz74+ibMnG4g1MO8ruwGN9JUPl1mPoPnnpI0GbbJ42F4MQAMHmcSHVNvMoTAudeMt+p2lcEj3Qc0TXjhF2ZqsZgFK/a9EK1nCKNZNufg2LMcIFsV990SLVg8iq96qTsPKA8aZvc0G7OGBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9437661a-b314-493e-b465-08d7c1e0faf4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2020 15:13:52.5809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +UUMy+u4podCtpV70Yb+bSqQbTNTFG4wBNBUl9TQub1TW5n13VatAzZF7FxY4EHeFJRcvt2sWX1dLXrz1s5A5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2400
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_04:2020-03-06,2020-03-06 signatures=0
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The code in ghes_edac_register() switches back and forth between
standard and fake controller creation. Do one thing only and separate
the code path that creates the fake MC.

Note: For better review the code is not yet carved out in separate
functions.

Signed-off-by: Robert Richter <rrichter@marvell.com>
---
 drivers/edac/ghes_edac.c | 65 ++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
index 5a4c9694bbff..7ead5667ed73 100644
--- a/drivers/edac/ghes_edac.c
+++ b/drivers/edac/ghes_edac.c
@@ -535,7 +535,6 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	struct ghes_dimm_fill dimm_fill;
 	int rc = 0, num_dimm = 0;
 	struct mem_ctl_info *mci;
-	bool fake = false;
 	int idx;
 
 	if (IS_ENABLED(CONFIG_X86)) {
@@ -559,23 +558,42 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 	/* Get the number of DIMMs */
 	dmi_walk(ghes_edac_count_dimms, &num_dimm);
 
-	/* Check if we've got a bogus BIOS */
-	if (num_dimm == 0) {
-		fake = true;
-		num_dimm = 1;
-	}
+	if (!num_dimm) {
+		/*
+		 * Bogus BIOS: Ignore DMI topology and use a single MC
+		 * with only one DIMM for the whole address range to
+		 * catch all errros.
+		 */
+		struct dimm_info *dimm;
 
-	mci = ghes_mc_create(dev, 0, num_dimm);
-	if (!mci) {
-		rc = -ENOMEM;
-		goto unlock;
-	}
+		mci = ghes_mc_create(dev, 0, 1);
+		if (!mci) {
+			rc = -ENOMEM;
+			goto unlock;
+		}
+
+		dimm = edac_get_dimm_by_index(mci, 0);
+
+		dimm->nr_pages = 1;
+		dimm->grain = 128;
+		dimm->mtype = MEM_UNKNOWN;
+		dimm->dtype = DEV_UNKNOWN;
+		dimm->edac_mode = EDAC_SECDED;
+
+		snprintf(dimm->label, sizeof(dimm->label), "unknown memory");
+
+		rc = ghes_mc_add_or_free(mci);
+		if (rc)
+			goto unlock;
 
-	if (fake) {
 		pr_info("This system has a very crappy BIOS: It doesn't even list the DIMMS.\n");
 		pr_info("Its SMBIOS info is wrong. It is doubtful that the error report would\n");
 		pr_info("work on such system. Use this driver with caution\n");
-	} else if (idx < 0) {
+
+		goto out;
+	}
+
+	if (idx < 0) {
 		pr_info("This EDAC driver relies on BIOS to enumerate memory and get error reports.\n");
 		pr_info("Unfortunately, not all BIOSes reflect the memory layout correctly.\n");
 		pr_info("So, the end result of using this driver varies from vendor to vendor.\n");
@@ -584,24 +602,21 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
 		pr_info("This system has %d DIMM sockets.\n", num_dimm);
 	}
 
-	if (!fake) {
-		dimm_fill.index = 0;
-		dimm_fill.mci = mci;
-		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
-	} else {
-		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
-
-		dimm->nr_pages = 1;
-		dimm->grain = 128;
-		dimm->mtype = MEM_UNKNOWN;
-		dimm->dtype = DEV_UNKNOWN;
-		dimm->edac_mode = EDAC_SECDED;
+	mci = ghes_mc_create(dev, 0, num_dimm);
+	if (!mci) {
+		rc = -ENOMEM;
+		goto unlock;
 	}
 
+	dimm_fill.index = 0;
+	dimm_fill.mci = mci;
+	dmi_walk(ghes_edac_dmidecode, &dimm_fill);
+
 	rc = ghes_mc_add_or_free(mci);
 	if (rc)
 		goto unlock;
 
+out:
 	/* only set on success */
 	refcount_set(&ghes_refcount, 1);
 
-- 
2.20.1


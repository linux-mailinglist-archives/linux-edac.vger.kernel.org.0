Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2F8222BD5
	for <lists+linux-edac@lfdr.de>; Thu, 16 Jul 2020 21:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGPTYc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 16 Jul 2020 15:24:32 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:63004 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728788AbgGPTYb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>);
        Thu, 16 Jul 2020 15:24:31 -0400
X-Greylist: delayed 989 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Jul 2020 15:24:31 EDT
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.42/8.16.0.42) with SMTP id 06GIE2m5016660;
        Thu, 16 Jul 2020 19:32:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id; s=jan2016.eng;
 bh=mJWk1msa5bXNtY79l547bsHSpzevc8f1+D0rPmjrpFU=;
 b=NX0d7I67x54frelgbNJrmkYvBk6LdK1gQKDDevNezZ4wY9jIsNVO4K42Lt8vL/9o7kfx
 gLMs2LeLuKTVRve4Ba8wA79mxkaFu/YU9i9RdoN+eQ+qObDXQQcEBHj9Zia2rjAVJzzB
 KuihUZ+q2e4vGMvK2Wj5uU0m73SZUsuXuZ516J1cL21Ihx6FLzti17eQHEPVBwPFtahg
 /Bd8Ab9ec7A0eNutu97wSMPoo9UGOHnOUBxVjY/SJRxjZ84cRThINoiHSThQfRUeegVu
 ztxVF9I5QEQRQvZ9d9IYcmmjozwSZRpT5Z6hjBFNt8GqhecCPl98wv8qsveqPF/jwqXS Bw== 
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 328kcd3hsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 19:32:29 +0100
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
        by prod-mail-ppoint2.akamai.com (8.16.0.42/8.16.0.42) with SMTP id 06GIFx01015869;
        Thu, 16 Jul 2020 14:32:28 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
        by prod-mail-ppoint2.akamai.com with ESMTP id 3278rxf0ya-1;
        Thu, 16 Jul 2020 14:32:28 -0400
Received: from bos-lpjec.145bw.corp.akamai.com (bos-lpjec.145bw.corp.akamai.com [172.28.3.71])
        by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 3575922C29;
        Thu, 16 Jul 2020 18:32:28 +0000 (GMT)
From:   Jason Baron <jbaron@akamai.com>
To:     bp@suse.de
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: [PATCH] EDAC/ie31200: fallback if host bridge device is already initialized
Date:   Thu, 16 Jul 2020 14:25:11 -0400
Message-Id: <1594923911-10885-1-git-send-email-jbaron@akamai.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_07:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160128
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-16_08:2020-07-16,2020-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 suspectscore=1 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007160130
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The Intel uncore driver may claim some of the pci ids from ie31200 which
means that the ie31200 edac driver will not initialize them as part of
pci_register_driver().

Let's add a fallback for this case to 'pci_get_device()' to get a
reference on the device such that it can still be configured. This is
similar in approach to other edac drivers.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
---
 drivers/edac/ie31200_edac.c | 50 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index d68346a..ebe5099 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -170,6 +170,8 @@
 	(n << (28 + (2 * skl) - PAGE_SHIFT))
 
 static int nr_channels;
+static struct pci_dev *mci_pdev;
+static int ie31200_registered = 1;
 
 struct ie31200_priv {
 	void __iomem *window;
@@ -538,12 +540,16 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
 static int ie31200_init_one(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
-	edac_dbg(0, "MC:\n");
+	int rc;
 
+	edac_dbg(0, "MC:\n");
 	if (pci_enable_device(pdev) < 0)
 		return -EIO;
+	rc = ie31200_probe1(pdev, ent->driver_data);
+	if (rc == 0 && !mci_pdev)
+		mci_pdev = pci_dev_get(pdev);
 
-	return ie31200_probe1(pdev, ent->driver_data);
+	return rc;
 }
 
 static void ie31200_remove_one(struct pci_dev *pdev)
@@ -552,6 +558,8 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 	struct ie31200_priv *priv;
 
 	edac_dbg(0, "\n");
+	pci_dev_put(mci_pdev);
+	mci_pdev = NULL;
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (!mci)
 		return;
@@ -593,17 +601,53 @@ static struct pci_driver ie31200_driver = {
 
 static int __init ie31200_init(void)
 {
+	int pci_rc, i;
+
 	edac_dbg(3, "MC:\n");
 	/* Ensure that the OPSTATE is set correctly for POLL or NMI */
 	opstate_init();
 
-	return pci_register_driver(&ie31200_driver);
+	pci_rc = pci_register_driver(&ie31200_driver);
+	if (pci_rc < 0)
+		goto fail0;
+
+	if (!mci_pdev) {
+		ie31200_registered = 0;
+		for (i = 0; ie31200_pci_tbl[i].vendor != 0; i++) {
+			mci_pdev = pci_get_device(ie31200_pci_tbl[i].vendor,
+						  ie31200_pci_tbl[i].device,
+						  NULL);
+			if (mci_pdev)
+				break;
+		}
+		if (!mci_pdev) {
+			edac_dbg(0, "ie31200 pci_get_device fail\n");
+			pci_rc = -ENODEV;
+			goto fail1;
+		}
+		pci_rc = ie31200_init_one(mci_pdev, &ie31200_pci_tbl[i]);
+		if (pci_rc < 0) {
+			edac_dbg(0, "ie31200 init fail\n");
+			pci_rc = -ENODEV;
+			goto fail1;
+		}
+	}
+	return 0;
+
+fail1:
+	pci_unregister_driver(&ie31200_driver);
+fail0:
+	pci_dev_put(mci_pdev);
+
+	return pci_rc;
 }
 
 static void __exit ie31200_exit(void)
 {
 	edac_dbg(3, "MC:\n");
 	pci_unregister_driver(&ie31200_driver);
+	if (!ie31200_registered)
+		ie31200_remove_one(mci_pdev);
 }
 
 module_init(ie31200_init);
-- 
2.7.4


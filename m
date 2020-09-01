Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97950259CB2
	for <lists+linux-edac@lfdr.de>; Tue,  1 Sep 2020 19:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbgIAPNu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 1 Sep 2020 11:13:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728964AbgIAPNr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 1 Sep 2020 11:13:47 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 682E9206EB;
        Tue,  1 Sep 2020 15:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973226;
        bh=Y38FgM6FIMzwLyhy++yolAWrK7vhSWYLo5N1TXIn1mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1XmZT8Hs84+ORIukfI7uGLenC6d/Ko0e7WzIoFXqHNaDqtF8keTxu5u9oXYe/jU2C
         8qm99dqZJiSdA/2Xk+7CHLynBeg2NDA5pS75sqSGEnJ7n9vGjhmSOeDsP/C3EMgwHB
         ieifLcWEdvA9wXzj3wRwZlJKFs+kSuZGMqSauV8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jason Baron <jbaron@akamai.com>,
        Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 28/62] EDAC/ie31200: Fallback if host bridge device is already initialized
Date:   Tue,  1 Sep 2020 17:10:11 +0200
Message-Id: <20200901150922.134155406@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Jason Baron <jbaron@akamai.com>

[ Upstream commit 709ed1bcef12398ac1a35c149f3e582db04456c2 ]

The Intel uncore driver may claim some of the pci ids from ie31200 which
means that the ie31200 edac driver will not initialize them as part of
pci_register_driver().

Let's add a fallback for this case to 'pci_get_device()' to get a
reference on the device such that it can still be configured. This is
similar in approach to other edac drivers.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/1594923911-10885-1-git-send-email-jbaron@akamai.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/edac/ie31200_edac.c | 50 ++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
index 18d77ace4813c..30f83fb6b145a 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -131,6 +131,8 @@
 #define IE31200_PAGES(n)		(n << (28 - PAGE_SHIFT))
 
 static int nr_channels;
+static struct pci_dev *mci_pdev;
+static int ie31200_registered = 1;
 
 struct ie31200_priv {
 	void __iomem *window;
@@ -456,12 +458,16 @@ fail_free:
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
@@ -470,6 +476,8 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 	struct ie31200_priv *priv;
 
 	edac_dbg(0, "\n");
+	pci_dev_put(mci_pdev);
+	mci_pdev = NULL;
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (!mci)
 		return;
@@ -515,17 +523,53 @@ static struct pci_driver ie31200_driver = {
 
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
2.25.1




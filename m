Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7930624DA85
	for <lists+linux-edac@lfdr.de>; Fri, 21 Aug 2020 18:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgHUQU4 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Aug 2020 12:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728376AbgHUQUd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 21 Aug 2020 12:20:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26D5822BF3;
        Fri, 21 Aug 2020 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026777;
        bh=MFA31vlUz/wgJDKoSVzaaPhDNaXOMuJ6Cmer3jlUlVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rL8z82wU0F4Bc4cW5yCZjO5sfJ8cG45XsZqSjxsY7k5M0cAu0dcA4xhwx1P/BLjfQ
         uNjtWxNfu6yshlpJcMfJnO/ojP2AfA9j5YGkZeVsJL/GuyQPYuPnesCrgERDwEuU83
         VtJ74XUnH4AFTYu0EaapQbg2fADtcMia53zISKJU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 30/30] EDAC/ie31200: Fallback if host bridge device is already initialized
Date:   Fri, 21 Aug 2020 12:18:57 -0400
Message-Id: <20200821161857.348955-30-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161857.348955-1-sashal@kernel.org>
References: <20200821161857.348955-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index aac9b9b360b80..9e4781a807cfa 100644
--- a/drivers/edac/ie31200_edac.c
+++ b/drivers/edac/ie31200_edac.c
@@ -147,6 +147,8 @@
 	(n << (28 + (2 * skl) - PAGE_SHIFT))
 
 static int nr_channels;
+static struct pci_dev *mci_pdev;
+static int ie31200_registered = 1;
 
 struct ie31200_priv {
 	void __iomem *window;
@@ -518,12 +520,16 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
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
@@ -532,6 +538,8 @@ static void ie31200_remove_one(struct pci_dev *pdev)
 	struct ie31200_priv *priv;
 
 	edac_dbg(0, "\n");
+	pci_dev_put(mci_pdev);
+	mci_pdev = NULL;
 	mci = edac_mc_del_mc(&pdev->dev);
 	if (!mci)
 		return;
@@ -583,17 +591,53 @@ static struct pci_driver ie31200_driver = {
 
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


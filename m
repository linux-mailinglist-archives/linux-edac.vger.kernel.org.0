Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF446374F06
	for <lists+linux-edac@lfdr.de>; Thu,  6 May 2021 07:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhEFFun (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 6 May 2021 01:50:43 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:58929 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhEFFun (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 6 May 2021 01:50:43 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d79 with ME
        id 1Hpd2500H21Fzsu03Hpdmo; Thu, 06 May 2021 07:49:44 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 06 May 2021 07:49:44 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     rric@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, s.temerkhanov@gmail.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] EDAC/thunderx: Fix an error message
Date:   Thu,  6 May 2021 07:49:34 +0200
Message-Id: <0c046ef5cfb367a3f707ef4270e21a2bcbf44952.1620280098.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

'ret' is known to be 0 here.
No error code is available, so just remove it from the error message.

Fixes: 41003396f932 ("EDAC, thunderx: Add Cavium ThunderX EDAC driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/edac/thunderx_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/thunderx_edac.c b/drivers/edac/thunderx_edac.c
index 0eb5eb97fd74..f13674081cb6 100644
--- a/drivers/edac/thunderx_edac.c
+++ b/drivers/edac/thunderx_edac.c
@@ -1368,7 +1368,7 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
 					      name, 1, "CCPI", 1,
 					      0, NULL, 0, idx);
 	if (!edac_dev) {
-		dev_err(&pdev->dev, "Cannot allocate EDAC device: %d\n", ret);
+		dev_err(&pdev->dev, "Cannot allocate EDAC device\n");
 		return -ENOMEM;
 	}
 	ocx = edac_dev->pvt_info;
@@ -1380,7 +1380,7 @@ static int thunderx_ocx_probe(struct pci_dev *pdev,
 
 	ocx->regs = pcim_iomap_table(pdev)[0];
 	if (!ocx->regs) {
-		dev_err(&pdev->dev, "Cannot map PCI resources: %d\n", ret);
+		dev_err(&pdev->dev, "Cannot map PCI resources\n");
 		ret = -ENODEV;
 		goto err_free;
 	}
-- 
2.30.2


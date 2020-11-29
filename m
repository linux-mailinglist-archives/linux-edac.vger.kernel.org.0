Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C72C7869
	for <lists+linux-edac@lfdr.de>; Sun, 29 Nov 2020 08:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgK2HxM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Nov 2020 02:53:12 -0500
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:41800 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgK2HxM (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 29 Nov 2020 02:53:12 -0500
Received: from localhost.localdomain ([81.185.163.10])
        by mwinf5d13 with ME
        id y7rS2300C0DmPsp037rTkN; Sun, 29 Nov 2020 08:51:28 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 29 Nov 2020 08:51:28 +0100
X-ME-IP: 81.185.163.10
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     talel@amazon.com, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] EDAC/al-mc-edac: Slighly simplify code
Date:   Sun, 29 Nov 2020 08:51:26 +0100
Message-Id: <20201129075126.1450573-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Use 'devm_add_action_or_reset()' instead of open coding it.
This makes the error handling code look more consistent.
This also save a few LoC.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/edac/al_mc_edac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
index 7d4f396c27b5..178b9e581a72 100644
--- a/drivers/edac/al_mc_edac.c
+++ b/drivers/edac/al_mc_edac.c
@@ -238,11 +238,9 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 	if (!mci)
 		return -ENOMEM;
 
-	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_free, mci);
-	if (ret) {
-		edac_mc_free(mci);
+	ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_free, mci);
+	if (ret)
 		return ret;
-	}
 
 	platform_set_drvdata(pdev, mci);
 	al_mc = mci->pvt_info;
@@ -293,11 +291,9 @@ static int al_mc_edac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
-	if (ret) {
-		edac_mc_del_mc(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
+	if (ret)
 		return ret;
-	}
 
 	if (al_mc->irq_ue > 0) {
 		ret = devm_request_irq(&pdev->dev,
-- 
2.27.0


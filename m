Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD911A6881
	for <lists+linux-edac@lfdr.de>; Mon, 13 Apr 2020 17:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgDMPLm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 13 Apr 2020 11:11:42 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:35868 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727959AbgDMPLl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 13 Apr 2020 11:11:41 -0400
Received: from localhost.localdomain ([93.22.151.169])
        by mwinf5d63 with ME
        id SFBR2200E3fYTYl03FBR00; Mon, 13 Apr 2020 17:11:38 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 Apr 2020 17:11:38 +0200
X-ME-IP: 93.22.151.169
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     jlu@pengutronix.de, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] EDAC/armada_xp: Fix some log messages
Date:   Mon, 13 Apr 2020 06:15:56 +0200
Message-Id: <20200413041556.3514-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Fix some spelling (s/Aramda/Armada/) in 1 log message and in 1 comment.

While at it, add some trailing '\n' in some other log message.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/edac/armada_xp_edac.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index a7502ebe9bdc..e3e757513d1b 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -78,7 +78,7 @@ struct axp_mc_drvdata {
 	char msg[128];
 };
 
-/* derived from "DRAM Address Multiplexing" in the ARAMDA XP Functional Spec */
+/* derived from "DRAM Address Multiplexing" in the ARMADA XP Functional Spec */
 static uint32_t axp_mc_calc_address(struct axp_mc_drvdata *drvdata,
 				    uint8_t cs, uint8_t bank, uint16_t row,
 				    uint16_t col)
@@ -160,12 +160,12 @@ static void axp_mc_check(struct mem_ctl_info *mci)
 		if (cnt_sbe)
 			cnt_sbe--;
 		else
-			dev_warn(mci->pdev, "inconsistent SBE count detected");
+			dev_warn(mci->pdev, "inconsistent SBE count detected\n");
 	} else {
 		if (cnt_dbe)
 			cnt_dbe--;
 		else
-			dev_warn(mci->pdev, "inconsistent DBE count detected");
+			dev_warn(mci->pdev, "inconsistent DBE count detected\n");
 	}
 
 	/* report earlier errors */
@@ -304,7 +304,7 @@ static int axp_mc_probe(struct platform_device *pdev)
 
 	config = readl(base + SDRAM_CONFIG_REG);
 	if (!(config & SDRAM_CONFIG_ECC_MASK)) {
-		dev_warn(&pdev->dev, "SDRAM ECC is not enabled");
+		dev_warn(&pdev->dev, "SDRAM ECC is not enabled\n");
 		return -EINVAL;
 	}
 
@@ -532,9 +532,9 @@ static int aurora_l2_probe(struct platform_device *pdev)
 
 	l2x0_aux_ctrl = readl(base + L2X0_AUX_CTRL);
 	if (!(l2x0_aux_ctrl & AURORA_ACR_PARITY_EN))
-		dev_warn(&pdev->dev, "tag parity is not enabled");
+		dev_warn(&pdev->dev, "tag parity is not enabled\n");
 	if (!(l2x0_aux_ctrl & AURORA_ACR_ECC_EN))
-		dev_warn(&pdev->dev, "data ECC is not enabled");
+		dev_warn(&pdev->dev, "data ECC is not enabled\n");
 
 	dci = edac_device_alloc_ctl_info(sizeof(*drvdata),
 					 "cpu", 1, "L", 1, 2, NULL, 0, 0);
@@ -618,7 +618,7 @@ static int __init armada_xp_edac_init(void)
 
 	res = platform_register_drivers(drivers, ARRAY_SIZE(drivers));
 	if (res)
-		pr_warn("Aramda XP EDAC drivers fail to register\n");
+		pr_warn("Armada XP EDAC drivers fail to register\n");
 
 	return 0;
 }
-- 
2.20.1


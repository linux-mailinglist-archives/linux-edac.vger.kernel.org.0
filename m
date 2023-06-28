Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9255D740A44
	for <lists+linux-edac@lfdr.de>; Wed, 28 Jun 2023 10:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjF1IA7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 28 Jun 2023 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjF1H5z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 28 Jun 2023 03:57:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A483619B0
        for <linux-edac@vger.kernel.org>; Wed, 28 Jun 2023 00:56:48 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEPNL-0006qG-NW; Wed, 28 Jun 2023 09:14:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEPNG-00AcM7-1r; Wed, 28 Jun 2023 09:13:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qEPNF-000SZ8-3b; Wed, 28 Jun 2023 09:13:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     kernel@pengutronix.de, Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Marvin Lin <kflin@nuvoton.com>,
        Stanley Chu <yschu@nuvoton.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, openbmc@lists.ozlabs.org,
        linux-edac@vger.kernel.org
Subject: [PATCH] EDAC/npcm: Convert to platform remove callback returning void
Date:   Wed, 28 Jun 2023 09:13:54 +0200
Message-Id: <20230628071354.665300-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Z5VlEYFVTMCKv6py0+3EUoJZ7CM3olvJ56dcIZC7FCk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkm92xkCKLPLRWSJk3lLBZPSoINkyY/w5Wh9S/R N6CTstpJ4aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZJvdsQAKCRCPgPtYfRL+ TsExB/0f9C8Eq/t/mXoP1dH07/J1aNIWngw63zKEny/Z7dxC9/9OjUAA8JL0OVNCrROt55/4snH AZYYbIIIi0E5LVrX7JNaUJM7KsuFr9i93TQHCDcnmpozaFnXZMl7uh54txehthNnnrmLLOJxtP4 I9gpMO68r0d53INizCbHjeO1jRAOjQ5txssPlUiE2akh0EH7hEsJa6xsHdN7n/WZSHDEB3z8q1Q B2VVHMulh0Z/LBu7ewfQdh+g7ne1zH7iQpwTwJUu80mTDMCfhj79lxmRNgooFnvGpNVd5Ao6Jy7 6YVXv8LwEUxIAg31vUmziyg3ZSy/yVTCeHdTHHAPjGpjpUZo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/edac/npcm_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
index 12b95be3e989..2edd13dc5c3b 100644
--- a/drivers/edac/npcm_edac.c
+++ b/drivers/edac/npcm_edac.c
@@ -409,7 +409,7 @@ static int edac_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int edac_remove(struct platform_device *pdev)
+static void edac_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct priv_data *priv = mci->pvt_info;
@@ -425,8 +425,6 @@ static int edac_remove(struct platform_device *pdev)
 	regmap_write(npcm_regmap, pdata->ctl_int_mask_master,
 		     pdata->int_mask_master_global_mask);
 	regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask, 0);
-
-	return 0;
 }
 
 static const struct npcm_platform_data npcm750_edac = {
@@ -532,7 +530,7 @@ static struct platform_driver npcm_edac_driver = {
 		.of_match_table = npcm_edac_of_match,
 	},
 	.probe = edac_probe,
-	.remove = edac_remove,
+	.remove_new = edac_remove,
 };
 
 module_platform_driver(npcm_edac_driver);

base-commit: d244c610f1d9a9d2976192c1d7e114a59fba02e0
-- 
2.39.2


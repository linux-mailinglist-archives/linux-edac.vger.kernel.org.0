Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E202D7B805B
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbjJDNNb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbjJDNNb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7B3A9
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gc-000752-RQ; Wed, 04 Oct 2023 15:13:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gc-00B2hg-DD; Wed, 04 Oct 2023 15:13:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gc-008zCo-3P; Wed, 04 Oct 2023 15:13:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Marvin Lin <kflin@nuvoton.com>,
        Stanley Chu <yschu@nuvoton.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, openbmc@lists.ozlabs.org,
        linux-edac@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 11/21] EDAC/npcm: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:44 +0200
Message-Id: <20231004131254.2673842-12-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=9elwnacy4hC51ienj2Z+Us36weEmvKfpBXTgQQ+HOVA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSoRSWmM+3hSszD29TcULhrXY9FdJYJ6VvqT 9fuIDTZMdeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kqAAKCRCPgPtYfRL+ TnWHB/9mCD0nPuvxj1FdGxP1d161RTZjGuin2+lSXOh0ky5nwM0cbu0UPdlq6hWl/CIHXnbLhgE QMcUeiyA/ERmTe3O8AQgNmtMpCQGa+U6a2mtrHv3Y6+rsMV0E5vikf+EK44zTPWKa6L8OqUcQCG mhhhzfQ5NjWY5Ry9OdrbmRIOmNPi+xedSWOiuNrT8Un7d/ilQgU7hqHvSQ2ConDzSdf2U8HzKd0 cNs7uqpIF6LYJSM93kZXE2s+Um7Ku4v43Lk4BKenPlUd3KcT4CQs0fZGzFWAE6goC4MBip0Gios 6mXWpdWwMTiamaNfOkPS91hVkNV9YIsIIfBgL3kUafA/iKwn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/edac/npcm_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/npcm_edac.c b/drivers/edac/npcm_edac.c
index 6d15c1550263..2e2133b784e9 100644
--- a/drivers/edac/npcm_edac.c
+++ b/drivers/edac/npcm_edac.c
@@ -410,7 +410,7 @@ static int edac_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int edac_remove(struct platform_device *pdev)
+static void edac_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct priv_data *priv = mci->pvt_info;
@@ -426,8 +426,6 @@ static int edac_remove(struct platform_device *pdev)
 	regmap_write(npcm_regmap, pdata->ctl_int_mask_master,
 		     pdata->int_mask_master_global_mask);
 	regmap_update_bits(npcm_regmap, pdata->ctl_ecc_en, pdata->ecc_en_mask, 0);
-
-	return 0;
 }
 
 static const struct npcm_platform_data npcm750_edac = {
@@ -533,7 +531,7 @@ static struct platform_driver npcm_edac_driver = {
 		.of_match_table = npcm_edac_of_match,
 	},
 	.probe = edac_probe,
-	.remove = edac_remove,
+	.remove_new = edac_remove,
 };
 
 module_platform_driver(npcm_edac_driver);
-- 
2.40.1


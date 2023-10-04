Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9817B8059
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242565AbjJDNN3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjJDNN2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9234DD
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gj-0007QF-UE; Wed, 04 Oct 2023 15:13:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gj-00B2i1-Bx; Wed, 04 Oct 2023 15:13:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gj-008zDE-2S; Wed, 04 Oct 2023 15:13:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 16/21] EDAC/ppc4xx: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:49 +0200
Message-Id: <20231004131254.2673842-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1860; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7+K7V4ko+U58e0DBSK68jv/Fh+kpvJt5AHEDnEQkN/8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWS9he3+XRHXCdhspvtmVKDvJI2XFXG3yCVT7 gEStxJCdFaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kvQAKCRCPgPtYfRL+ TrDWCACTYiBv5ClFdbPJsqjFncsEthxDxnoL1y2R5xirdcoyucSK+JII3gW+ImcdZO/wDugcMZn 9Vmp4kWIVw/41NGQy3Vn5+fjKPyd6CS/axVGBC6l6t6F2aDbkdgL+oufseNQgQ8irPmuExWPSaY 8d3YVvBtOh5DAY6yiUHoi0GqTk+hjqGbJTu1ZfOJvmx9bK0em6Pudu85vs8tAqikaVHymzuRhqC laiqG1KFCt1edGih1Qf2bQX++fD/+vfagdyPEUXYq8Dm5mfhzG0aLmNFAzjYMG97eQFltc/dMMw Z+u6sDTZrV6N8oTMZOxRwSrK8349QUsD6rk/ECLEiLmXHFQk
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
 drivers/edac/ppc4xx_edac.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 046969b4e82e..1eea3341a916 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -1329,8 +1329,7 @@ static int ppc4xx_edac_probe(struct platform_device *op)
  *
  * Unconditionally returns 0.
  */
-static int
-ppc4xx_edac_remove(struct platform_device *op)
+static void ppc4xx_edac_remove(struct platform_device *op)
 {
 	struct mem_ctl_info *mci = dev_get_drvdata(&op->dev);
 	struct ppc4xx_edac_pdata *pdata = mci->pvt_info;
@@ -1344,8 +1343,6 @@ ppc4xx_edac_remove(struct platform_device *op)
 
 	edac_mc_del_mc(mci->pdev);
 	edac_mc_free(mci);
-
-	return 0;
 }
 
 /**
@@ -1379,7 +1376,7 @@ ppc4xx_edac_opstate_init(void)
 
 static struct platform_driver ppc4xx_edac_driver = {
 	.probe			= ppc4xx_edac_probe,
-	.remove			= ppc4xx_edac_remove,
+	.remove_new		= ppc4xx_edac_remove,
 	.driver = {
 		.name = PPC4XX_EDAC_MODULE_NAME,
 		.of_match_table = ppc4xx_edac_match,
-- 
2.40.1


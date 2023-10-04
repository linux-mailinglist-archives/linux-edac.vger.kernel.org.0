Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6A67B805E
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242579AbjJDNNd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242435AbjJDNNc (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A419398
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gk-0007Sj-Se; Wed, 04 Oct 2023 15:13:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gk-00B2i9-EL; Wed, 04 Oct 2023 15:13:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gk-008zDR-4b; Wed, 04 Oct 2023 15:13:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Michal Simek <michal.simek@amd.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 18/21] EDAC/synopsys: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:51 +0200
Message-Id: <20231004131254.2673842-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CJrOzZ4Epmcu9ncmtBzFKO841eFe5RbToqeeSvPnONA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWTJBXkK6dxGqC8eBMIDUkYYEEe2CxcW0Au28 m8prJMZoSKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kyQAKCRCPgPtYfRL+ Ts+SCACHe2VLH3zElk+lbr6yAKmtuhLd+60Ahb/M3YC4G+codJZlOVIatZaL4Z3+Ihz1f+arJg0 +/OSYlhrXMfEk1SLOXFGrIetNTM0W1jl9ekXKasPqll7TF/nCvAcl65+WzmPRU50HrXaOAVimYe /jEl5ku9Nf7JaVJHEbVzzrlnVLVTXLv5sxYPmfXXJ6dd81SEqmwa8XBKUrk+h+zmaFkQyYU0T68 kJpkZZxDY121T/7J5fSy6GciS9+v23+K+5oWB9t5liOjE86QLXgwdRmnEIgTMo7P6CG4E1GTdzN 48n25zZqTEl6Qzi3WlKjUxPzW2CiywznT/iDnbWT5l8KOJSs
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
 drivers/edac/synopsys_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c4fc64cbecd0..709babce43ba 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1410,7 +1410,7 @@ static int mc_probe(struct platform_device *pdev)
  *
  * Return: Unconditionally 0
  */
-static int mc_remove(struct platform_device *pdev)
+static void mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct synps_edac_priv *priv = mci->pvt_info;
@@ -1425,8 +1425,6 @@ static int mc_remove(struct platform_device *pdev)
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-
-	return 0;
 }
 
 static struct platform_driver synps_edac_mc_driver = {
@@ -1435,7 +1433,7 @@ static struct platform_driver synps_edac_mc_driver = {
 		   .of_match_table = synps_edac_match,
 		   },
 	.probe = mc_probe,
-	.remove = mc_remove,
+	.remove_new = mc_remove,
 };
 
 module_platform_driver(synps_edac_mc_driver);
-- 
2.40.1


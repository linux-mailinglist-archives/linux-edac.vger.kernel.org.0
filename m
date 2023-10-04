Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA857B8052
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242564AbjJDNN0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjJDNNZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:25 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412F8B0
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gZ-0006vL-SK; Wed, 04 Oct 2023 15:13:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gZ-00B2hN-9p; Wed, 04 Oct 2023 15:13:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gZ-008zCP-0X; Wed, 04 Oct 2023 15:13:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 06/21] EDAC/cpc925: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:39 +0200
Message-Id: <20231004131254.2673842-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=jY58XnDPJ50uKl8qv1rIt1AmbxZGPnBKWALunQb2G4s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSYnbEjpyqoZQf83FOAwTRPJ79NwPHqgS9sk gYaxCsnmbSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kmAAKCRCPgPtYfRL+ TiEbB/43kWNtomA9QOZBCGDMAnu1MikIs7dqhN1yvcAKbJL4m5lYbw/QaZCslolQKvyE2zMGFAF yQkTUkR1Vls9Loasur3IjRPxuBU9F/VAYK/jqce08mNWJAtShtN3cEHg225P/FobWNuu2G5JwMq f61ZWTTWWJHaYJdYR5i8cwagIV0f4N4M2jrYC8fXHGqnAEgfMAek0WGfK0rodO953EC0JSyP2w5 1q2OFgCyMgSWd3FnzYQwotGuclynJz6YGqI7rksQRobbZN7oJnRIDJ/BSyMmw+nbvTnxX5J5CBY ZRZbhuF2a7wKJS4Km+rz5OGiBHZCwGYTwWtCF6iPbSuAnaiJ
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
 drivers/edac/cpc925_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/cpc925_edac.c b/drivers/edac/cpc925_edac.c
index 9797e6d60dde..5075dc7526e3 100644
--- a/drivers/edac/cpc925_edac.c
+++ b/drivers/edac/cpc925_edac.c
@@ -1010,7 +1010,7 @@ static int cpc925_probe(struct platform_device *pdev)
 	return res;
 }
 
-static int cpc925_remove(struct platform_device *pdev)
+static void cpc925_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
@@ -1023,13 +1023,11 @@ static int cpc925_remove(struct platform_device *pdev)
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-
-	return 0;
 }
 
 static struct platform_driver cpc925_edac_driver = {
 	.probe = cpc925_probe,
-	.remove = cpc925_remove,
+	.remove_new = cpc925_remove,
 	.driver = {
 		   .name = "cpc925_edac",
 	}
-- 
2.40.1


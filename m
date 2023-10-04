Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925D7B805C
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242580AbjJDNNc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbjJDNNb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA9ABD
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gl-0007TU-Hj; Wed, 04 Oct 2023 15:13:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gk-00B2iC-Va; Wed, 04 Oct 2023 15:13:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gk-008zDV-M1; Wed, 04 Oct 2023 15:13:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Tero Kristo <kristo@kernel.org>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 19/21] EDAC/ti: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:52 +0200
Message-Id: <20231004131254.2673842-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1601; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=q5rXU2mPNVI4wA00lScfFSSYu8XeTfkri0g8tkt1Rc8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWTLyks/pI1WJFUh5fwn/LySzAeHltcbFJbZv MBjWsadJUWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kywAKCRCPgPtYfRL+ TsvvCACk8eS6ZoDP3MGbFdz/noD0gy+KKYsCCxToqljjqNr+9YbWRlaMDytwKVSHKcjFi6ul9Oi IyhoKYJrkJZpGCOzaBrmvlrWAr9CXri5nB6HCi8U21ldOpax8nUgAMaIJrwTNPUt8WqT31dSwXy 0LnCanwjrhQpFaByxeunZEXDERjnKfbmhfFNOd8Cj0r2F2tPt5578N86YLCy5qQgOu/it6knDgm pbGY1K7gOdbeRNy8QhK9C5KWymsBByVQZxEDaexx9aNHlP63Jfqrga3ta394W5a4Nk3wG1N59lB C1l//Xr0M3saDKTZ07ZiYuIJmgYxCaQYS71ekzyBdQwMoL6D
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
 drivers/edac/ti_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 6971ded598de..29723c9592f7 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -312,19 +312,17 @@ static int ti_edac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_edac_remove(struct platform_device *pdev)
+static void ti_edac_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-
-	return 0;
 }
 
 static struct platform_driver ti_edac_driver = {
 	.probe = ti_edac_probe,
-	.remove = ti_edac_remove,
+	.remove_new = ti_edac_remove,
 	.driver = {
 		   .name = EDAC_MOD_NAME,
 		   .of_match_table = ti_edac_of_match,
-- 
2.40.1


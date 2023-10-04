Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005F77B8050
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242555AbjJDNN0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbjJDNNY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3695EBD
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gd-00075S-04; Wed, 04 Oct 2023 15:13:11 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gc-00B2hk-JU; Wed, 04 Oct 2023 15:13:10 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gc-008zCr-9Y; Wed, 04 Oct 2023 15:13:10 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-mips@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 12/21] EDAC/octeon-l2c: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:45 +0200
Message-Id: <20231004131254.2673842-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1660; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/oxSfhZRyaW18TQk8AIKutuEaVuwdk8d9mYnUs1gLFI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSpCV0ixeHYKds16TQH/glMuzn/dwynFhU04 IVra+HghyaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kqQAKCRCPgPtYfRL+ Tvg2B/wM9EEVqqcjv5qPwWrDsi1/lLqy0bCAsesTlv2R3+QSPcEko0jz/9+a+KCDW1ZRYIiRIOS IF+0eDYMZctHK37HdKyy4iuK/66JXmcafa4kuGZfLWEVemEodEEv2EDqZao8rkJVNXHkogx4ERJ bKN+x/TvjxSpOjUfEMMzIVMU49KKYrR3PEEwz9B4z3jB2XGdbnuQT85SES9GsJirld0Es3l+wOS d7UBFW5RJwupdaincp1cDiqdzQDeDf9mWQaouyz0PyPCufjUo59/z4nF2KH1Q6sthhrSfNLDZrJ tsgRX1/9CDsYiKPDHqxBPOI5wGiYg32RogI1LLM75Vao0nyb
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
 drivers/edac/octeon_edac-l2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/octeon_edac-l2c.c b/drivers/edac/octeon_edac-l2c.c
index c33059e9b0be..4015eb9af6fe 100644
--- a/drivers/edac/octeon_edac-l2c.c
+++ b/drivers/edac/octeon_edac-l2c.c
@@ -184,19 +184,17 @@ static int octeon_l2c_probe(struct platform_device *pdev)
 	return -ENXIO;
 }
 
-static int octeon_l2c_remove(struct platform_device *pdev)
+static void octeon_l2c_remove(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *l2c = platform_get_drvdata(pdev);
 
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(l2c);
-
-	return 0;
 }
 
 static struct platform_driver octeon_l2c_driver = {
 	.probe = octeon_l2c_probe,
-	.remove = octeon_l2c_remove,
+	.remove_new = octeon_l2c_remove,
 	.driver = {
 		   .name = "octeon_l2c_edac",
 	}
-- 
2.40.1


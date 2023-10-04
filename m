Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE477B8051
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbjJDNN0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbjJDNNY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1838198
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:21 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gZ-0006vM-TN; Wed, 04 Oct 2023 15:13:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gZ-00B2hQ-G4; Wed, 04 Oct 2023 15:13:07 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gZ-008zCX-6c; Wed, 04 Oct 2023 15:13:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Lei Wang <lewan@microsoft.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 07/21] EDAC/dmc520: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:40 +0200
Message-Id: <20231004131254.2673842-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=k1Kzh0qSpovLvELPe0ysXEHi7N+aWjG0Q/a5F2bqakk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSeM7qrt93yeAc7dCnrqPNKUv2R3BCD3X66G 2nkWLkmhU2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kngAKCRCPgPtYfRL+ TvKMB/4tzgb+EDeFVskfyHpRpJHfw7PYzZq2b6kehpadLgwl+/+n60gWQnXAjq31b050q1bBw1v MBFMR4/VvtM5K9ISt4cdoVShzPEq0rd06uRGq1VsQd4zy90X0LMH31rK9tjsRTaGEIRHvhkXQFu NTmbuNyzy9PB4eAar/b8OAjSnyBNqVFK8hn2jgMHVfoQk9wwWQE7qNIvkUTI/T8tHrV9RchgYmk J8hF7MBz1BEJsZFb+R1AE7fPWCTCwi29edaFcSqJP+RCIVIeFCjMRMsKLWAVG6vc3Htg3KZYmMM SDdcG20M+tRP34ZDf7X6l1HGT1WsJrxFV9MpzaLuOuqWLfYP
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
 drivers/edac/dmc520_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 1fa5ca57e9ec..4e30b989a1a4 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -602,7 +602,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int dmc520_edac_remove(struct platform_device *pdev)
+static void dmc520_edac_remove(struct platform_device *pdev)
 {
 	u32 reg_val, idx, irq_mask_all = 0;
 	struct mem_ctl_info *mci;
@@ -626,8 +626,6 @@ static int dmc520_edac_remove(struct platform_device *pdev)
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-
-	return 0;
 }
 
 static const struct of_device_id dmc520_edac_driver_id[] = {
@@ -644,7 +642,7 @@ static struct platform_driver dmc520_edac_driver = {
 	},
 
 	.probe = dmc520_edac_probe,
-	.remove = dmc520_edac_remove
+	.remove_new = dmc520_edac_remove
 };
 
 module_platform_driver(dmc520_edac_driver);
-- 
2.40.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC17B804C
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbjJDNNZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbjJDNNX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C663E4
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gV-0006nP-FW; Wed, 04 Oct 2023 15:13:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gU-00B2gx-Hg; Wed, 04 Oct 2023 15:13:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gU-008zC5-89; Wed, 04 Oct 2023 15:13:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Dinh Nguyen <dinguyen@kernel.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 01/21] EDAC/altera: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:34 +0200
Message-Id: <20231004131254.2673842-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2628; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oy4IAj9MLr9U5T1p6VUQW6y6sfNQWyNYMdkG/zPkpik=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSN4Q1qphM/c0fgnjHycf/3nXdlKrQtNA20O 6CKogaM8eeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kjQAKCRCPgPtYfRL+ TrQyCACMg+N3yvr9VErRg/qjkm4YqCOPn8kC9MZ+tTyH85O+rcW3trS84e9cwZHB+T4LTAvDkjJ DQTehZJOBSuacc8oempSM3kSgzUGDhC4ydhLErFIJ7bLneSDf0gnlKZXw+PHW/qGCqVZ3wdvTlh RoDEZ4tXgJjtuK6Wt8cE6wplMO6XUzOtEUKDrrChHyU3os3JUGcD53SZHovE/nDMlQ+2VATK76K 9b0qcHtbAITYwxs/giuTRpMv97lRYEatLsVlLMBENNh1u91VXEUJD1Ufh76RjVRCaSUqfzABIe/ 7t3eU7T/3aidUmRgWrtyiwiitk5BV/zghmZ+kY4jE2a0vPgU
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
 drivers/edac/altera_edac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 8b31cd54bdb6..09169f3726f4 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -459,15 +459,13 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	return res;
 }
 
-static int altr_sdram_remove(struct platform_device *pdev)
+static void altr_sdram_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 /*
@@ -489,7 +487,7 @@ static const struct dev_pm_ops altr_sdram_pm_ops = {
 
 static struct platform_driver altr_sdram_edac_driver = {
 	.probe = altr_sdram_probe,
-	.remove = altr_sdram_remove,
+	.remove_new = altr_sdram_remove,
 	.driver = {
 		.name = "altr_sdram_edac",
 #ifdef CONFIG_PM
@@ -812,7 +810,7 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	return res;
 }
 
-static int altr_edac_device_remove(struct platform_device *pdev)
+static void altr_edac_device_remove(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
 	struct altr_edac_device_dev *drvdata = dci->pvt_info;
@@ -820,13 +818,11 @@ static int altr_edac_device_remove(struct platform_device *pdev)
 	debugfs_remove_recursive(drvdata->debugfs_dir);
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(dci);
-
-	return 0;
 }
 
 static struct platform_driver altr_edac_device_driver = {
 	.probe =  altr_edac_device_probe,
-	.remove = altr_edac_device_remove,
+	.remove_new = altr_edac_device_remove,
 	.driver = {
 		.name = "altr_edac_device",
 		.of_match_table = altr_edac_device_of_match,
-- 
2.40.1


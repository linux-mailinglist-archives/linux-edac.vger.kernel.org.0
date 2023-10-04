Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F647B8048
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242552AbjJDNNX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242555AbjJDNNW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EECD8
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gb-0006zw-6j; Wed, 04 Oct 2023 15:13:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1ga-00B2hV-KV; Wed, 04 Oct 2023 15:13:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1ga-008zCc-BG; Wed, 04 Oct 2023 15:13:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 08/21] EDAC/highbank_l2: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:41 +0200
Message-Id: <20231004131254.2673842-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1723; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=1EAv6PepNkeInYp+c7czYEYF2N0Uzxxw7rLNNX7w3Mw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSg+2nWfz1Pf41627/b4xQpkJ/MpPM8PweNs mTmUEJGqKyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1koAAKCRCPgPtYfRL+ Tg5FB/0f2mZLgYspvRkAXfu9CjXLgUvtfyC5wFDJwo5F1H9P02Ra8pSomwIyLXs5hyOx5ldqRX3 2Nkk9ZlxR7a6ssCgOrwbMoau0pNhPgRIYj+szxsYcYGEzm750nn+pVmyoIQ32zprwBe9n0itB2P CoDHhDAKGoMI0IB5ftwbJTVKtQ/Xogu4TIDzKZt+TNack9//VeTx1h3G3MVvKdcX4viCZaMSfHa govoXawnIws5prs4m3c4kYE78DUmdtvfVCGQQO49rytivVcO893miCQxwLgTmWd15ZSBFdN9nyt Ow4JHigjnk9jmjSbdcID9SsJMf23rQuoVzqgPF+sWel6PEAv
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
 drivers/edac/highbank_l2_edac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index 140d4431bd0d..5646c049a934 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -118,18 +118,17 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 	return res;
 }
 
-static int highbank_l2_err_remove(struct platform_device *pdev)
+static void highbank_l2_err_remove(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
 
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(dci);
-	return 0;
 }
 
 static struct platform_driver highbank_l2_edac_driver = {
 	.probe = highbank_l2_err_probe,
-	.remove = highbank_l2_err_remove,
+	.remove_new = highbank_l2_err_remove,
 	.driver = {
 		.name = "hb_l2_edac",
 		.of_match_table = hb_l2_err_of_match,
-- 
2.40.1


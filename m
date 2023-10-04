Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934C47B8049
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242553AbjJDNNX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242554AbjJDNNW (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD40C4
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gV-0006nv-ME; Wed, 04 Oct 2023 15:13:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gV-00B2h0-7T; Wed, 04 Oct 2023 15:13:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gU-008zC9-U8; Wed, 04 Oct 2023 15:13:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Jan Luebbe <jlu@pengutronix.de>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 02/21] EDAC/armada_xp: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:35 +0200
Message-Id: <20231004131254.2673842-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2464; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FRztW3eivwDxjzN9/3jMRMZwfESZ8EFnfLBPbbErm0M=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlTZlP6Om1aMCmu2MxmVLeh69LelYOfW9PgaM467HzknF EbYlUzpZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAiaZvZ/3BkhbXsnDSbfdmz BCftg731i9ftkFXKVv5o9D5b4mJ/Q+zyZDsL1jmHFx9zX7J6VWnChpUMFpU/ohNLbj5VV7FNivD /vCVut02exYbdO5fHmZ2KMEsvnN5ttVvw98ozvx85vcp0O577YINP9BV+hkbbHa59fo98FZ8oGz tbNBwV5N+g4dnxuIozf+nNQGv9pY7VzlVKT9idJErXikWvW2+3StBatG7rF+0r/CYq0uVn1r/Wl NG8y/f29+/ku+KLtllqL0xsuVizX+jNd8e3OlpTntyWTYtTE74pduRlTuS73uUV1y+bREpf6+y/ eMI97N7fBZW629L/s+qJCgYX8B+vmXa097JokkiqaaQqAA==
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
 drivers/edac/armada_xp_edac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/armada_xp_edac.c b/drivers/edac/armada_xp_edac.c
index c4bd2fb9c46b..5bcd34f23baf 100644
--- a/drivers/edac/armada_xp_edac.c
+++ b/drivers/edac/armada_xp_edac.c
@@ -351,20 +351,18 @@ static int axp_mc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int axp_mc_remove(struct platform_device *pdev)
+static void axp_mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_driver axp_mc_driver = {
 	.probe = axp_mc_probe,
-	.remove = axp_mc_remove,
+	.remove_new = axp_mc_remove,
 	.driver = {
 		.name = "armada_xp_mc_edac",
 		.of_match_table = of_match_ptr(axp_mc_of_match),
@@ -564,7 +562,7 @@ static int aurora_l2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int aurora_l2_remove(struct platform_device *pdev)
+static void aurora_l2_remove(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
 #ifdef CONFIG_EDAC_DEBUG
@@ -575,13 +573,11 @@ static int aurora_l2_remove(struct platform_device *pdev)
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(dci);
 	platform_set_drvdata(pdev, NULL);
-
-	return 0;
 }
 
 static struct platform_driver aurora_l2_driver = {
 	.probe = aurora_l2_probe,
-	.remove = aurora_l2_remove,
+	.remove_new = aurora_l2_remove,
 	.driver = {
 		.name = "aurora_l2_edac",
 		.of_match_table = of_match_ptr(aurora_l2_of_match),
-- 
2.40.1


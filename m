Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B97B8062
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjJDNNj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242584AbjJDNNi (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:38 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3619D9
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gm-0007W3-G4; Wed, 04 Oct 2023 15:13:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gl-00B2iL-Qk; Wed, 04 Oct 2023 15:13:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gl-008zDc-HP; Wed, 04 Oct 2023 15:13:19 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 21/21] EDAC/zynqmp: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:54 +0200
Message-Id: <20231004131254.2673842-22-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XCQfjQ8VouZfr8MiUFp8q3/YTDxh/atvIhopZVzSTp8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWTSkjeFLkxVUEadUtq/txnaVH9wcGeB6Agy4 3V1ek85hqSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1k0gAKCRCPgPtYfRL+ TqWMB/9UzqB4fvybjGXXWTeYBXy5B0xJ+lIjcYcZMELF/T+4VeFqF86ILUczkFPQXH+trrjuACP 8HuOhVL+wQVemPtz5ch2zbAI2kQyr+GbIibAktAIAGtMv6/gpBb3EkDqRnygAZ9QgVLmKboHgw1 AmkWXW4ANt8IFH5ccf5F2O5XORNoD3VnflkdCQBLnCPuRw6faOHOBmAzAYxNPlcnLeNPEkGBcK5 bPs7VveY0dXTcs+DRqSahwfS3QmqfFGq0ooMbh/gnTSqtcfVnG4L88f69TOQzPeWdkP8gUJyRxS IlYGz8EIESQw1zT7mdRA4vuvaF5+5qCmbRP+HW0l+lZ2axFk
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
 drivers/edac/zynqmp_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/zynqmp_edac.c b/drivers/edac/zynqmp_edac.c
index ac7d1e0b324c..2d9a5cfd8931 100644
--- a/drivers/edac/zynqmp_edac.c
+++ b/drivers/edac/zynqmp_edac.c
@@ -426,7 +426,7 @@ static int edac_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int edac_remove(struct platform_device *pdev)
+static void edac_remove(struct platform_device *pdev)
 {
 	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
 	struct edac_priv *priv = dci->pvt_info;
@@ -440,8 +440,6 @@ static int edac_remove(struct platform_device *pdev)
 
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(dci);
-
-	return 0;
 }
 
 static const struct of_device_id zynqmp_ocm_edac_match[] = {
@@ -457,7 +455,7 @@ static struct platform_driver zynqmp_ocm_edac_driver = {
 		   .of_match_table = zynqmp_ocm_edac_match,
 		   },
 	.probe = edac_probe,
-	.remove = edac_remove,
+	.remove_new = edac_remove,
 };
 
 module_platform_driver(zynqmp_ocm_edac_driver);
-- 
2.40.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914657B8057
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242571AbjJDNN3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbjJDNN2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A441C9
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gf-0007Cc-W8; Wed, 04 Oct 2023 15:13:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gf-00B2hs-JH; Wed, 04 Oct 2023 15:13:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gf-008zD4-9n; Wed, 04 Oct 2023 15:13:13 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-mips@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 14/21] EDAC/octeon-pc: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:47 +0200
Message-Id: <20231004131254.2673842-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Kv+oSDldLimsQ+obk3163v8KjC/6IlZzGOXY4OqLu1c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWS2YgBHlU2fxMuYOXKv4Y3zI1LlwWvwS8VBB MyF2/GGhaCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1ktgAKCRCPgPtYfRL+ TjHOB/sHXJbG6Z1fO7fKTadgyHISwyepIHW7uYtX/j/4hdO7mb4hoKCcbPoeAtDZYzcensQK9Eh /86CV103QpIK483XNVQGlwVxI81hrORTKGck0H040RAlMhsWaAqv08eQd5/5gEo7TTNPU3j24dC eGgxdn948+Hv4zM4B8S+K+rSiTCFy3qf2S3HaDIJpbRpTSvOOAvqV/LvsmqWsSzAMGj9oUUcKZn gXFU/ALtaBocT4BSvHhLHNwmOskGJqLv6J/+oKc5coBymG1sTSKZ+H7mhnp2qZko5YRNlZP+pob xp1nR4I82+GHpdwGzHxJIOV6WJRWr2YhIpDu9KU9TD0raqqj
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
 drivers/edac/octeon_edac-pc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/octeon_edac-pc.c b/drivers/edac/octeon_edac-pc.c
index 754eced59c32..ea8a8e337b1e 100644
--- a/drivers/edac/octeon_edac-pc.c
+++ b/drivers/edac/octeon_edac-pc.c
@@ -119,19 +119,18 @@ static int co_cache_error_probe(struct platform_device *pdev)
 	return -ENXIO;
 }
 
-static int co_cache_error_remove(struct platform_device *pdev)
+static void co_cache_error_remove(struct platform_device *pdev)
 {
 	struct co_cache_error *p = platform_get_drvdata(pdev);
 
 	unregister_co_cache_error_notifier(&p->notifier);
 	edac_device_del_device(&pdev->dev);
 	edac_device_free_ctl_info(p->ed);
-	return 0;
 }
 
 static struct platform_driver co_cache_error_driver = {
 	.probe = co_cache_error_probe,
-	.remove = co_cache_error_remove,
+	.remove_new = co_cache_error_remove,
 	.driver = {
 		   .name = "octeon_pc_edac",
 	}
-- 
2.40.1


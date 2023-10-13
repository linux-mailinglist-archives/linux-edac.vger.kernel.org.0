Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80927C82B5
	for <lists+linux-edac@lfdr.de>; Fri, 13 Oct 2023 12:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjJMKFI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Oct 2023 06:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjJMKFH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 13 Oct 2023 06:05:07 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5EA9
        for <linux-edac@vger.kernel.org>; Fri, 13 Oct 2023 03:05:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrF1w-0000nW-0M; Fri, 13 Oct 2023 12:04:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrF1v-001Mgr-0X; Fri, 13 Oct 2023 12:04:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrF1u-00FUQJ-NH; Fri, 13 Oct 2023 12:04:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     York Sun <york.sun@nxp.com>, James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 22/21] EDAC/fsl_ddr: Convert to platform remove callback returning void
Date:   Fri, 13 Oct 2023 12:04:23 +0200
Message-ID: <20231013100422.1382040-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3167; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=x2jlLq6LTLkrDyKaAuEkuwwmOdIX/lfOC/9NfAOJ0yc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKRYnx9BbuKmQzTOTJiCP5Wo8F0UJOrewvTDlX SxyEzHnpFKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSkWJwAKCRCPgPtYfRL+ TvrMB/4wpfX1iMkdNeMuC072bDt7XUixD8B6oSk5XYPGcJ9NV/z3SSmO2/TVmnhxj6OwGlp3Tvx 7pGSL0oMDOHeC3NpMn1muaPTX78/zvdUdhmxGqGnjsnxomYu7qfj+nAmss2H1GjJwrL1Y7Y6YS2 CQWN/0pCzDyXB9BpZbs6WZpucINUXhz+lfQU9H0er0cahJjK7R9WJByRyObGkczO4t9nSHQliz+ 5Dpr21TGSYctQqWK3TqQarQreH7mJHVh08W/0SDADzSm4kdkZtTZC64TLNoCsZlaxKQaqjuuh3v 8/AqdFXJMe+L6jCoaHhIjLEKUh4M/59aismS/qQQ/B2ir7Dr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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

fsl_mc_err_remove() is used as callback in two drivers. So these have to
be converted together to the void returning remove callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I found another two drivers to convert that my coccinelle recipe missed.

Best regards
Uwe

 drivers/edac/fsl_ddr_edac.c    | 3 +--
 drivers/edac/fsl_ddr_edac.h    | 2 +-
 drivers/edac/layerscape_edac.c | 2 +-
 drivers/edac/mpc85xx_edac.c    | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index b81757555a8a..d148d262d0d4 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -612,7 +612,7 @@ int fsl_mc_err_probe(struct platform_device *op)
 	return res;
 }
 
-int fsl_mc_err_remove(struct platform_device *op)
+void fsl_mc_err_remove(struct platform_device *op)
 {
 	struct mem_ctl_info *mci = dev_get_drvdata(&op->dev);
 	struct fsl_mc_pdata *pdata = mci->pvt_info;
@@ -629,5 +629,4 @@ int fsl_mc_err_remove(struct platform_device *op)
 
 	edac_mc_del_mc(&op->dev);
 	edac_mc_free(mci);
-	return 0;
 }
diff --git a/drivers/edac/fsl_ddr_edac.h b/drivers/edac/fsl_ddr_edac.h
index 332439d7b2d9..c0994a2a003c 100644
--- a/drivers/edac/fsl_ddr_edac.h
+++ b/drivers/edac/fsl_ddr_edac.h
@@ -72,5 +72,5 @@ struct fsl_mc_pdata {
 	int irq;
 };
 int fsl_mc_err_probe(struct platform_device *op);
-int fsl_mc_err_remove(struct platform_device *op);
+void fsl_mc_err_remove(struct platform_device *op);
 #endif
diff --git a/drivers/edac/layerscape_edac.c b/drivers/edac/layerscape_edac.c
index 7c5e2b3c0daa..d2f895033280 100644
--- a/drivers/edac/layerscape_edac.c
+++ b/drivers/edac/layerscape_edac.c
@@ -27,7 +27,7 @@ MODULE_DEVICE_TABLE(of, fsl_ddr_mc_err_of_match);
 
 static struct platform_driver fsl_ddr_mc_err_driver = {
 	.probe = fsl_mc_err_probe,
-	.remove = fsl_mc_err_remove,
+	.remove_new = fsl_mc_err_remove,
 	.driver = {
 		.name = "fsl_ddr_mc_err",
 		.of_match_table = fsl_ddr_mc_err_of_match,
diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index e0d702cef66f..c1bc53f4e184 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -656,7 +656,7 @@ MODULE_DEVICE_TABLE(of, mpc85xx_mc_err_of_match);
 
 static struct platform_driver mpc85xx_mc_err_driver = {
 	.probe = fsl_mc_err_probe,
-	.remove = fsl_mc_err_remove,
+	.remove_new = fsl_mc_err_remove,
 	.driver = {
 		.name = "mpc85xx_mc_err",
 		.of_match_table = mpc85xx_mc_err_of_match,
-- 
2.42.0


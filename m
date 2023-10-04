Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD207B804B
	for <lists+linux-edac@lfdr.de>; Wed,  4 Oct 2023 15:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbjJDNNY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 4 Oct 2023 09:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbjJDNNX (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 4 Oct 2023 09:13:23 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EBAC6
        for <linux-edac@vger.kernel.org>; Wed,  4 Oct 2023 06:13:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gc-00072V-DT; Wed, 04 Oct 2023 15:13:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gb-00B2hd-RC; Wed, 04 Oct 2023 15:13:09 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qo1gb-008zCk-Hb; Wed, 04 Oct 2023 15:13:09 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 10/21] EDAC/mpc85xx: Convert to platform remove callback returning void
Date:   Wed,  4 Oct 2023 15:12:43 +0200
Message-Id: <20231004131254.2673842-11-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
References: <20231004131254.2673842-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=lzciHbAe3ZS7W7FRMv6H90prLSo29pk0PdXKqElwutc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlHWSn4xAn8Yb/H6SJI6rx+InIriiAFGkzAmANU NrnSYVdPLGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZR1kpwAKCRCPgPtYfRL+ TimZCACkb81iY+CnT2Xijp0/y+VMG+Kyi2Jw8Uf8G9CXDo6hLV87kcPjSxMAXFw3JnvlGOYTx3z QOgCyf5vgjyYzBPDF+A/1W7X2rirBb3TFtPkBMVjIFZoprCAFnRvRzIXzm709y+TO8+34CHOMzj uLv7YBcZcaW23Yl+TcvsrLkZGMtHMj1DKKHeB+5xnmB8dccInnR1T3G18mAWK/EwLZXbH+2g/km TUnrTD+YdEt5lyh8EP3ullW15LZGfj4HUGAbQqHHeKC/q0r3qlBL3LFoJekOJM5U8i8gMgZ6hh9 EtH3qNWmtFEaw0XyTXYNGJf0MTKC1ydmuLzz5AjO8HVaFw8m
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
 drivers/edac/mpc85xx_edac.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/mpc85xx_edac.c b/drivers/edac/mpc85xx_edac.c
index 2b5703e5066e..e0d702cef66f 100644
--- a/drivers/edac/mpc85xx_edac.c
+++ b/drivers/edac/mpc85xx_edac.c
@@ -300,7 +300,7 @@ static int mpc85xx_pci_err_probe(struct platform_device *op)
 	return res;
 }
 
-static int mpc85xx_pci_err_remove(struct platform_device *op)
+static void mpc85xx_pci_err_remove(struct platform_device *op)
 {
 	struct edac_pci_ctl_info *pci = dev_get_drvdata(&op->dev);
 	struct mpc85xx_pci_pdata *pdata = pci->pvt_info;
@@ -312,8 +312,6 @@ static int mpc85xx_pci_err_remove(struct platform_device *op)
 
 	edac_pci_del_device(&op->dev);
 	edac_pci_free_ctl_info(pci);
-
-	return 0;
 }
 
 static const struct platform_device_id mpc85xx_pci_err_match[] = {
@@ -325,7 +323,7 @@ static const struct platform_device_id mpc85xx_pci_err_match[] = {
 
 static struct platform_driver mpc85xx_pci_err_driver = {
 	.probe = mpc85xx_pci_err_probe,
-	.remove = mpc85xx_pci_err_remove,
+	.remove_new = mpc85xx_pci_err_remove,
 	.id_table = mpc85xx_pci_err_match,
 	.driver = {
 		.name = "mpc85xx_pci_err",
@@ -591,7 +589,7 @@ static int mpc85xx_l2_err_probe(struct platform_device *op)
 	return res;
 }
 
-static int mpc85xx_l2_err_remove(struct platform_device *op)
+static void mpc85xx_l2_err_remove(struct platform_device *op)
 {
 	struct edac_device_ctl_info *edac_dev = dev_get_drvdata(&op->dev);
 	struct mpc85xx_l2_pdata *pdata = edac_dev->pvt_info;
@@ -606,7 +604,6 @@ static int mpc85xx_l2_err_remove(struct platform_device *op)
 	out_be32(pdata->l2_vbase + MPC85XX_L2_ERRDIS, orig_l2_err_disable);
 	edac_device_del_device(&op->dev);
 	edac_device_free_ctl_info(edac_dev);
-	return 0;
 }
 
 static const struct of_device_id mpc85xx_l2_err_of_match[] = {
@@ -630,7 +627,7 @@ MODULE_DEVICE_TABLE(of, mpc85xx_l2_err_of_match);
 
 static struct platform_driver mpc85xx_l2_err_driver = {
 	.probe = mpc85xx_l2_err_probe,
-	.remove = mpc85xx_l2_err_remove,
+	.remove_new = mpc85xx_l2_err_remove,
 	.driver = {
 		.name = "mpc85xx_l2_err",
 		.of_match_table = mpc85xx_l2_err_of_match,
-- 
2.40.1


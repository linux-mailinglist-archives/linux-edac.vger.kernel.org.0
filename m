Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D85BBAF7
	for <lists+linux-edac@lfdr.de>; Sun, 18 Sep 2022 01:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQXVF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Sep 2022 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQXVE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Sep 2022 19:21:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC826578
        for <linux-edac@vger.kernel.org>; Sat, 17 Sep 2022 16:21:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZh78-0003t7-TV; Sun, 18 Sep 2022 01:20:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZh73-001MeL-Ed; Sun, 18 Sep 2022 01:20:40 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZh71-001bve-9O; Sun, 18 Sep 2022 01:20:39 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>
Cc:     James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
Subject: [PATCH] EDAC/ppc_4xx: Reorder symbols to get rid of a few forward declarations
Date:   Sun, 18 Sep 2022 01:20:13 +0200
Message-Id: <20220917232013.489931-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Y8QcBD4loAyk1wJEysGCZ6PxinejNLQzcd1oiGzfRSg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjJlYjoUc4kPj6zGg/lWDXKedUN4+a6OA+WNDKBB8f l9//kGiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYyZWIwAKCRDB/BR4rcrsCQ1TB/ 9O/ON8lj0TtOVlO38wdGp0yEP0nqvv7oKvvJG9LOJ7YqNA+4rUP8tHwmtQLekQ3rW5+dOzinBABe4a nuKMCV3AklMsHwXKTg8Mlf9MVn5bJr3h0aOgRddveTSN/dkP5NmYjyEdMt23HNm/4qNgkTFL+QkeOG qKreguEP7/hMTRthIuR2L6rmsdqekGNGP0zGs1MOnQhUnDJULzkKl/aolQ5ZIEPqnzalcK2oF7CmdU eD80D2WqgPKul4LzujB7WflEqQpOhReuVWBBPWJo56MAEYRAl0skjCTuWOqiZFPxDhDgNA3biYl/r2 RALVdEPxcws5IkCv0U45AeVju1ilLy
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

When moving the definition of ppc4xx_edac_driver further down, the
forward declarations can just be dropped.

Do this to reduce line needless repetition.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/edac/ppc4xx_edac.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/edac/ppc4xx_edac.c b/drivers/edac/ppc4xx_edac.c
index 0bc670778c99..046969b4e82e 100644
--- a/drivers/edac/ppc4xx_edac.c
+++ b/drivers/edac/ppc4xx_edac.c
@@ -178,11 +178,6 @@ struct ppc4xx_ecc_status {
 	u32 wmirq;
 };
 
-/* Function Prototypes */
-
-static int ppc4xx_edac_probe(struct platform_device *device);
-static int ppc4xx_edac_remove(struct platform_device *device);
-
 /* Global Variables */
 
 /*
@@ -197,15 +192,6 @@ static const struct of_device_id ppc4xx_edac_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ppc4xx_edac_match);
 
-static struct platform_driver ppc4xx_edac_driver = {
-	.probe			= ppc4xx_edac_probe,
-	.remove			= ppc4xx_edac_remove,
-	.driver = {
-		.name = PPC4XX_EDAC_MODULE_NAME,
-		.of_match_table = ppc4xx_edac_match,
-	},
-};
-
 /*
  * TODO: The row and channel parameters likely need to be dynamically
  * set based on the aforementioned variant controller realizations.
@@ -1391,6 +1377,15 @@ ppc4xx_edac_opstate_init(void)
 			     EDAC_OPSTATE_UNKNOWN_STR)));
 }
 
+static struct platform_driver ppc4xx_edac_driver = {
+	.probe			= ppc4xx_edac_probe,
+	.remove			= ppc4xx_edac_remove,
+	.driver = {
+		.name = PPC4XX_EDAC_MODULE_NAME,
+		.of_match_table = ppc4xx_edac_match,
+	},
+};
+
 /**
  * ppc4xx_edac_init - driver/module insertion entry point
  *

base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.37.2


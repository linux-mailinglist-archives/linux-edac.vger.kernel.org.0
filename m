Return-Path: <linux-edac+bounces-744-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554F876044
	for <lists+linux-edac@lfdr.de>; Fri,  8 Mar 2024 09:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB641F279D6
	for <lists+linux-edac@lfdr.de>; Fri,  8 Mar 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7C54BE3;
	Fri,  8 Mar 2024 08:52:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCAA51005
	for <linux-edac@vger.kernel.org>; Fri,  8 Mar 2024 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887928; cv=none; b=pKFfCrexQQ8eIBIeP3yefspI0L5iNKvOABZk9LfTK2XbusjhV4F23lHhjP7LGFzZ6aui+20kHtVI5F6W8Yjx7wEjUbb299kGzsrWKZ7viyc9VSfbG/3HxsDlN7R6FHqdi4B+5xbe0l/T5cytho72TGINnx7IR5F6oUL74IdLkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887928; c=relaxed/simple;
	bh=sI9hMknmZv1lagGTe+7lNNnStfimvsnSaNduUFuwG3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uz64o2Hr5GI2serI5ElB2tKN/K54cQeEiD9EPeXQEFIY71jjgKesqJ1L7l6JggsjwZI4kJ/GV3deOGlDjDZhbemNYirHLfg9sePfai0tnWWakwF9zQcSvk5H1bdJ+qbLHKFBYvq5b9BuhnLitp2+g4XHR7AsHHkh5gfqBFdVeos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0006vN-RB; Fri, 08 Mar 2024 09:51:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxF-0056N3-2k; Fri, 08 Mar 2024 09:51:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1riVxE-00245Q-3D;
	Fri, 08 Mar 2024 09:51:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] EDAC/versal: Convert to platform remove callback returning void
Date: Fri,  8 Mar 2024 09:51:06 +0100
Message-ID:  <83deca1ce260f7e17ff3cb106c9a6946d4ca4505.1709886922.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1936; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=sI9hMknmZv1lagGTe+7lNNnStfimvsnSaNduUFuwG3c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl6tF8JZD2lQ7ejfSCGXLvKHl1r5c9Ih6oLAsXp dxzh7yf8QuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZerRfAAKCRCPgPtYfRL+ TvdUB/wKZeSqUf1n++YbWBEPmdy2ew5RLzF7X2A5pKKyPVCrUXEHjwYaAMfrXUZLIFr/RXgSwbF ECmP+crd0dvfvm5vR4kuCU1JZVztDNWy5B20nrGfNZIGKp4sHsZZQP7xba7F4ueP+6degYZDNNN yXCGlkK0LR9czir2Qu7+av7lJ//fsp1v2bwopA+3m5P5X2Kb+xFuHnGV82F2OeVdRndfl6BBIYE gLFaBAdeZE09VnW0/9oBiy1YcMxCAzQFo/pThTmJeuaHImn46lpkIZwZAtILcWVXolKFvz3h47S 3m1z3DMxJpP7sazAUBDvOZnNflNcS8jMqsiiQan13F0LMGkZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-edac@vger.kernel.org

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
 drivers/edac/versal_edac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
index 3016870689f1..1688a5050f63 100644
--- a/drivers/edac/versal_edac.c
+++ b/drivers/edac/versal_edac.c
@@ -1160,7 +1160,7 @@ static int mc_probe(struct platform_device *pdev)
 	return rc;
 }
 
-static int mc_remove(struct platform_device *pdev)
+static void mc_remove(struct platform_device *pdev)
 {
 	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
 	struct edac_priv *priv = mci->pvt_info;
@@ -1178,8 +1178,6 @@ static int mc_remove(struct platform_device *pdev)
 			      XPM_EVENT_ERROR_MASK_DDRMC_NCR, err_callback, mci);
 	edac_mc_del_mc(&pdev->dev);
 	edac_mc_free(mci);
-
-	return 0;
 }
 
 static struct platform_driver xilinx_ddr_edac_mc_driver = {
@@ -1188,7 +1186,7 @@ static struct platform_driver xilinx_ddr_edac_mc_driver = {
 		.of_match_table = xlnx_edac_match,
 	},
 	.probe = mc_probe,
-	.remove = mc_remove,
+	.remove_new = mc_remove,
 };
 
 module_platform_driver(xilinx_ddr_edac_mc_driver);

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0



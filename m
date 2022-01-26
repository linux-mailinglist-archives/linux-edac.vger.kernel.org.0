Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328A049D30B
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiAZUD7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:03:59 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:33944 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiAZUD7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:03:59 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 9798D2078F66
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 2/5] edac: altera: add IRQ check for Arria10
Date:   Wed, 26 Jan 2022 23:03:50 +0300
Message-ID: <20220126200353.14582-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220126200353.14582-1-s.shtylyov@omp.ru>
References: <20220126200353.14582-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The driver neglects to check the result of platform_get_irq()'s call
and blithely passes the negative error codes to devm_request_irq()
(which takes *unsigned* IRQ #), causing it to fail with -EINVAL,
overriding the original error.  Stop calling devm_request_irq()
with the invalid IRQ #s.

While at it, move the call to platform_get_irq() to the place where
it makes more sense...

Fixes: 73bcc942f427 ("EDAC, altera: Add Arria10 EDAC support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/altera_edac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3b6a2650cf5b..21b5d2fac9be 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -353,9 +353,6 @@ static int altr_sdram_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	/* Arria10 has a 2nd IRQ */
-	irq2 = platform_get_irq(pdev, 1);
-
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
 	layers[0].size = 1;
 	layers[0].is_virt_csrow = true;
@@ -406,6 +403,12 @@ static int altr_sdram_probe(struct platform_device *pdev)
 		if (res < 0)
 			goto err2;
 
+		/* Arria10 has a 2nd IRQ */
+		irq2 = platform_get_irq(pdev, 1);
+		if (irq2 < 0) {
+			res = irq2;
+			goto err2;
+		}
 		res = devm_request_irq(&pdev->dev, irq2,
 				       altr_sdram_mc_err_handler,
 				       IRQF_SHARED, dev_name(&pdev->dev), mci);
-- 
2.26.3


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2485C49D30F
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiAZUEB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:04:01 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:35046 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAZUD7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:03:59 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 1159120ACBF1
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
Subject: [PATCH 1/5] edac: altera: add IRQ checks for L2 cache and OCRAM
Date:   Wed, 26 Jan 2022 23:03:49 +0300
Message-ID: <20220126200353.14582-2-s.shtylyov@omp.ru>
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

The driver neglects to check the result of platform_get_irq()'s calls
and blithely passes the negative error codes to devm_request_irq()
(which takes *unsigned* IRQ #), causing it to fail with -EINVAL,
overriding the original error.  Stop calling devm_request_irq()
with the invalid IRQ #s.

Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/altera_edac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3a6d2416cb0f..3b6a2650cf5b 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -776,6 +776,10 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 	}
 
 	drvdata->sb_irq = platform_get_irq(pdev, 0);
+	if (drvdata->sb_irq < 0) {
+		res = drvdata->sb_irq;
+		goto fail1;
+	}
 	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
 			       altr_edac_device_handler,
 			       0, dev_name(&pdev->dev), dci);
@@ -783,6 +787,10 @@ static int altr_edac_device_probe(struct platform_device *pdev)
 		goto fail1;
 
 	drvdata->db_irq = platform_get_irq(pdev, 1);
+	if (drvdata->db_irq < 0) {
+		res = drvdata->db_irq;
+		goto fail1;
+	}
 	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
 			       altr_edac_device_handler,
 			       0, dev_name(&pdev->dev), dci);
-- 
2.26.3


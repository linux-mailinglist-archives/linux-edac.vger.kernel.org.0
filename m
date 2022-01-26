Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B00649D30C
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiAZUEA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:04:00 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:37092 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiAZUEA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:04:00 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru A0780209BFBD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 4/5] edac: highbank_l2: add IRQ checks
Date:   Wed, 26 Jan 2022 23:03:52 +0300
Message-ID: <20220126200353.14582-5-s.shtylyov@omp.ru>
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

Fixes: 69154d069869 ("edac: add support for Calxeda highbank L2 cache ecc")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/highbank_l2_edac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/edac/highbank_l2_edac.c b/drivers/edac/highbank_l2_edac.c
index c4549cec788b..e58c84f8e624 100644
--- a/drivers/edac/highbank_l2_edac.c
+++ b/drivers/edac/highbank_l2_edac.c
@@ -94,6 +94,10 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 		goto err;
 
 	drvdata->db_irq = platform_get_irq(pdev, 0);
+	if (drvdata->db_irq < 0) {
+		res = drvdata->db_irq;
+		goto err2;
+	}
 	res = devm_request_irq(&pdev->dev, drvdata->db_irq,
 			       highbank_l2_err_handler,
 			       0, dev_name(&pdev->dev), dci);
@@ -101,6 +105,10 @@ static int highbank_l2_err_probe(struct platform_device *pdev)
 		goto err2;
 
 	drvdata->sb_irq = platform_get_irq(pdev, 1);
+	if (drvdata->sb_irq < 0) {
+		res = drvdata->sb_irq;
+		goto err2;
+	}
 	res = devm_request_irq(&pdev->dev, drvdata->sb_irq,
 			       highbank_l2_err_handler,
 			       0, dev_name(&pdev->dev), dci);
-- 
2.26.3


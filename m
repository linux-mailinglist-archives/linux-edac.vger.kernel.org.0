Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8CF49D30E
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiAZUEA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:04:00 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:53862 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiAZUD7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:03:59 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 227AE20763EF
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
CC:     York Sun <york.sun@nxp.com>
Subject: [PATCH 3/5] edac: fsl_ddr: add IRQ check
Date:   Wed, 26 Jan 2022 23:03:51 +0300
Message-ID: <20220126200353.14582-4-s.shtylyov@omp.ru>
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

Fixes: 55764ed37eec ("EDAC, fsl_ddr: Fix IRQ dispose warning when module is removed")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/fsl_ddr_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/fsl_ddr_edac.c b/drivers/edac/fsl_ddr_edac.c
index 6d8ea226010d..64f1108726b0 100644
--- a/drivers/edac/fsl_ddr_edac.c
+++ b/drivers/edac/fsl_ddr_edac.c
@@ -586,6 +586,10 @@ int fsl_mc_err_probe(struct platform_device *op)
 
 		/* register interrupts */
 		pdata->irq = platform_get_irq(op, 0);
+		if (pdata->irq < 0) {
+			res = pdata->irq;
+			goto err2;
+		}
 		res = devm_request_irq(&op->dev, pdata->irq,
 				       fsl_mc_isr,
 				       IRQF_SHARED,
-- 
2.26.3


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6E049D310
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:04:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiAZUEB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:04:01 -0500
Received: from mxout04.lancloud.ru ([45.84.86.114]:35066 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiAZUEA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:04:00 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 2DDBA20ACBE3
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
Subject: [PATCH 5/5] edac: highbank_mc: add IRQ check
Date:   Wed, 26 Jan 2022 23:03:53 +0300
Message-ID: <20220126200353.14582-6-s.shtylyov@omp.ru>
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

Fixes: a1b01edb2745 ("edac: add support for Calxeda highbank memory controller")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/highbank_mc_edac.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/edac/highbank_mc_edac.c b/drivers/edac/highbank_mc_edac.c
index 61b76ec226af..36931cafcab0 100644
--- a/drivers/edac/highbank_mc_edac.c
+++ b/drivers/edac/highbank_mc_edac.c
@@ -230,6 +230,10 @@ static int highbank_mc_probe(struct platform_device *pdev)
 		goto err;
 
 	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		res = irq;
+		goto err;
+	}
 	res = devm_request_irq(&pdev->dev, irq, highbank_mc_err_handler,
 			       0, dev_name(&pdev->dev), mci);
 	if (res < 0) {
-- 
2.26.3


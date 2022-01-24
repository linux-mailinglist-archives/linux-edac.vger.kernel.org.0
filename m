Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4CF498990
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jan 2022 19:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343633AbiAXS5L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jan 2022 13:57:11 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:47914 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbiAXSzJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jan 2022 13:55:09 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru F1A1E20747E6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
To:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, <linux-edac@vger.kernel.org>
CC:     Khuong Dinh <khuong@os.amperecomputing.com>
Subject: [PATCH 2/2] edac: xgene: fix deferred probing
Date:   Mon, 24 Jan 2022 21:55:03 +0300
Message-ID: <20220124185503.6720-3-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20220124185503.6720-1-s.shtylyov@omp.ru>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The driver overrides error codes returned by platform_get_irq_optional()
to -EINVAL for some strange reason, so if it returns -EPROBE_DEFER, the
driver will fail the probe permanently instead of the deferred probing.
Switch to propagating the error codes upstream.

Fixes: 0d4429301c4 ("EDAC: Add APM X-Gene SoC EDAC driver")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/xgene_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 2ccd1db5e98f..7197f9fa0245 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1919,7 +1919,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 			irq = platform_get_irq_optional(pdev, i);
 			if (irq < 0) {
 				dev_err(&pdev->dev, "No IRQ resource\n");
-				rc = -EINVAL;
+				rc = irq;
 				goto out_err;
 			}
 			rc = devm_request_irq(&pdev->dev, irq,
-- 
2.26.3


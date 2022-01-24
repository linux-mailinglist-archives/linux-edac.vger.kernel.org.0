Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A51498992
	for <lists+linux-edac@lfdr.de>; Mon, 24 Jan 2022 19:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343825AbiAXS5N (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Jan 2022 13:57:13 -0500
Received: from mxout02.lancloud.ru ([45.84.86.82]:47904 "EHLO
        mxout02.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiAXSzJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Jan 2022 13:55:09 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 4B72120747D7
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
Subject: [PATCH 1/2] edac: altera: fix deferred probing
Date:   Mon, 24 Jan 2022 21:55:02 +0300
Message-ID: <20220124185503.6720-2-s.shtylyov@omp.ru>
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

The driver overrides the error codes returned by platform_get_irq() to
-ENODEV for some strange reason, so if it returns -EPROBE_DEFER, the
driver will fail the probe permanently instead of the deferred probing.
Switch to propagating the error codes upstream.

Fixes: 71bcada88b0f ("edac: altera: Add Altera SDRAM EDAC support")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
 drivers/edac/altera_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3a6d2416cb0f..5dd29789f97d 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -350,7 +350,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	if (irq < 0) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "No irq %d in DT\n", irq);
-		return -ENODEV;
+		return irq;
 	}
 
 	/* Arria10 has a 2nd IRQ */
-- 
2.26.3


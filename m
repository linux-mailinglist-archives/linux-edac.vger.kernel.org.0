Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BF049D385
	for <lists+linux-edac@lfdr.de>; Wed, 26 Jan 2022 21:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiAZUfG (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Jan 2022 15:35:06 -0500
Received: from mxout03.lancloud.ru ([45.84.86.113]:55392 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiAZUfG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 26 Jan 2022 15:35:06 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 03DC8208D301
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
Subject: [PATCH] Revert "EDAC/xgene: Do not print a failure message to get an IRQ twice"
Date:   Wed, 26 Jan 2022 23:35:03 +0300
Message-ID: <20220126203503.16759-1-s.shtylyov@omp.ru>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

This reverts commit e26124cd5f7099949109608845bba9e9bf96599c.

Calling platform_get_irq_optional() doesn't make sense if you then bail out
on any error it returns.  Switch back to calling platform_get_irq(); note
that calling dev_err_probe() from there is being discussed currently...

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---
This patch is against the 'edac-for-next' branch of the 'ras.git' repo.

drivers/edac/xgene_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/xgene_edac.c b/drivers/edac/xgene_edac.c
index 2ccd1db5e98f..1d2c27a00a4a 100644
--- a/drivers/edac/xgene_edac.c
+++ b/drivers/edac/xgene_edac.c
@@ -1916,7 +1916,7 @@ static int xgene_edac_probe(struct platform_device *pdev)
 		int i;
 
 		for (i = 0; i < 3; i++) {
-			irq = platform_get_irq_optional(pdev, i);
+			irq = platform_get_irq(pdev, i);
 			if (irq < 0) {
 				dev_err(&pdev->dev, "No IRQ resource\n");
 				rc = -EINVAL;
-- 
2.26.3


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4983E8F86
	for <lists+linux-edac@lfdr.de>; Wed, 11 Aug 2021 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbhHKLgg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 11 Aug 2021 07:36:36 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:9303 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237154AbhHKLgg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 11 Aug 2021 07:36:36 -0400
X-Greylist: delayed 568 seconds by postgrey-1.27 at vger.kernel.org; Wed, 11 Aug 2021 07:36:35 EDT
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66113b3bef0d-63f44; Wed, 11 Aug 2021 19:25:50 +0800 (CST)
X-RM-TRANSID: 2ee66113b3bef0d-63f44
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76113b3b87fe-3c7c3;
        Wed, 11 Aug 2021 19:25:50 +0800 (CST)
X-RM-TRANSID: 2ee76113b3b87fe-3c7c3
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     kristo@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>
Subject: [PATCH] EDAC/ti: Remove redundant error messages
Date:   Wed, 11 Aug 2021 19:26:26 +0800
Message-Id: <20210811112626.27848-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

In the function ti_edac_probe, devm_ioremap_resource() and
platform_get_irq() have already contains error message, so
remove the redundant error messages.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 drivers/edac/ti_edac.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
index 169f96e51..6971ded59 100644
--- a/drivers/edac/ti_edac.c
+++ b/drivers/edac/ti_edac.c
@@ -245,11 +245,8 @@ static int ti_edac_probe(struct platform_device *pdev)
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(dev, res);
-	if (IS_ERR(reg)) {
-		edac_printk(KERN_ERR, EDAC_MOD_NAME,
-			    "EMIF controller regs not defined\n");
+	if (IS_ERR(reg))
 		return PTR_ERR(reg);
-	}
 
 	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
 	layers[0].size = 1;
@@ -281,8 +278,6 @@ static int ti_edac_probe(struct platform_device *pdev)
 	error_irq = platform_get_irq(pdev, 0);
 	if (error_irq < 0) {
 		ret = error_irq;
-		edac_printk(KERN_ERR, EDAC_MOD_NAME,
-			    "EMIF irq number not defined.\n");
 		goto err;
 	}
 
-- 
2.20.1.windows.1




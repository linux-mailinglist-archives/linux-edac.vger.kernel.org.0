Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8734963323E
	for <lists+linux-edac@lfdr.de>; Tue, 22 Nov 2022 02:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231747AbiKVBjM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 21 Nov 2022 20:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbiKVBjL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 21 Nov 2022 20:39:11 -0500
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.216.63.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43E3AB0C5;
        Mon, 21 Nov 2022 17:39:10 -0800 (PST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4NGRkP39Vrz8RV5L;
        Tue, 22 Nov 2022 09:39:09 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.40.50])
        by mse-fl1.zte.com.cn with SMTP id 2AM1d2t0028295;
        Tue, 22 Nov 2022 09:39:02 +0800 (+08)
        (envelope-from ye.xingchen@zte.com.cn)
Received: from mapi (xaxapp02[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 22 Nov 2022 09:39:03 +0800 (CST)
Date:   Tue, 22 Nov 2022 09:39:03 +0800 (CST)
X-Zmail-TransId: 2afa637c2837328fa23d
X-Mailer: Zmail v1.0
Message-ID: <202211220939032286231@zte.com.cn>
Mime-Version: 1.0
From:   <ye.xingchen@zte.com.cn>
To:     <lewan@microsoft.com>
Cc:     <bp@alien8.de>, <tony.luck@intel.com>, <james.morse@arm.com>,
        <mchehab@kernel.org>, <rric@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chi.minghao@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBFREFDOiB1c2UgZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKQ==?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 2AM1d2t0028295
X-Fangmail-Gw-Spam-Type: 0
X-FangMail-Miltered: at cgslv5.04-192.168.250.137.novalocal with ID 637C283D.001 by FangMail milter!
X-FangMail-Envelope: 1669081149/4NGRkP39Vrz8RV5L/637C283D.001/10.5.228.132/[10.5.228.132]/mse-fl1.zte.com.cn/<ye.xingchen@zte.com.cn>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 637C283D.001/4NGRkP39Vrz8RV5L
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

Convert platform_get_resource(), devm_ioremap_resource() to a single
call to devm_platform_get_and_ioremap_resource(), as this is exactly
what this function does.

Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/edac/dmc520_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 1fa5ca57e9ec..77756b5b811f 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -480,7 +480,6 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	struct mem_ctl_info *mci;
 	void __iomem *reg_base;
 	u32 irq_mask_all = 0;
-	struct resource *res;
 	struct device *dev;
 	int ret, idx, irq;
 	u32 reg_val;
@@ -505,8 +504,7 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	}

 	/* Initialize dmc520 edac */
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	reg_base = devm_ioremap_resource(dev, res);
+	reg_base = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(reg_base))
 		return PTR_ERR(reg_base);

-- 
2.25.1

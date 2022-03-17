Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98764DD139
	for <lists+linux-edac@lfdr.de>; Fri, 18 Mar 2022 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiCQXiq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 17 Mar 2022 19:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCQXip (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 17 Mar 2022 19:38:45 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9D22986F6;
        Thu, 17 Mar 2022 16:37:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0V7TGI0g_1647560243;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V7TGI0g_1647560243)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 18 Mar 2022 07:37:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     dinguyen@kernel.org
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rric@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] EDAC/altera: Remove unnecessary print function dev_err()
Date:   Fri, 18 Mar 2022 07:37:22 +0800
Message-Id: <20220317233722.109036-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The print function dev_err() is redundant because platform_get_irq()
already prints an error.

Eliminate the follow coccicheck warnings:
./drivers/edac/altera_edac.c:2153:2-9: line 2153 is redundant because
platform_get_irq() already prints an error
./drivers/edac/altera_edac.c:2188:2-9: line 2188 is redundant because
platform_get_irq() already prints an error

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/edac/altera_edac.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..47dc35938fa8 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2149,10 +2149,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 
 	edac->sb_irq = platform_get_irq(pdev, 0);
-	if (edac->sb_irq < 0) {
-		dev_err(&pdev->dev, "No SBERR IRQ resource\n");
+	if (edac->sb_irq < 0)
 		return edac->sb_irq;
-	}
 
 	irq_set_chained_handler_and_data(edac->sb_irq,
 					 altr_edac_a10_irq_handler,
@@ -2184,10 +2182,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	}
 #else
 	edac->db_irq = platform_get_irq(pdev, 1);
-	if (edac->db_irq < 0) {
-		dev_err(&pdev->dev, "No DBERR IRQ resource\n");
+	if (edac->db_irq < 0)
 		return edac->db_irq;
-	}
 	irq_set_chained_handler_and_data(edac->db_irq,
 					 altr_edac_a10_irq_handler, edac);
 #endif
-- 
2.20.1.7.g153144c


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD665B2E31
	for <lists+linux-edac@lfdr.de>; Fri,  9 Sep 2022 07:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIIFjt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 9 Sep 2022 01:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiIIFjs (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 9 Sep 2022 01:39:48 -0400
Received: from mail.nfschina.com (unknown [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF2E733A30;
        Thu,  8 Sep 2022 22:39:45 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 926061E80D75;
        Fri,  9 Sep 2022 13:38:13 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dw_JlD1y_0aY; Fri,  9 Sep 2022 13:38:11 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 764C41E80D06;
        Fri,  9 Sep 2022 13:38:10 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     dinguyen@kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com, rric@kernel.org
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, liqiong@nfschina.com,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] EDAC/altera: add platform_get_irq error checking
Date:   Fri,  9 Sep 2022 13:38:38 +0800
Message-Id: <20220909053839.2293-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The platform_get_irq() function returns negative error codes on error,
check it.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 drivers/edac/altera_edac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index e7e8e624a436..79c7c97c7a46 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -355,6 +355,8 @@ static int altr_sdram_probe(struct platform_device *pdev)
 
 	/* Arria10 has a 2nd IRQ */
 	irq2 = platform_get_irq(pdev, 1);
+	if (irq2 < 0)
+		return irq2;
 
 	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
 	layers[0].size = 1;
-- 
2.11.0


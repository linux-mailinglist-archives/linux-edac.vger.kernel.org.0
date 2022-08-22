Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8935559C805
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiHVTHw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiHVTHu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:07:50 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDAE715725;
        Mon, 22 Aug 2022 12:07:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 899D9DA8;
        Mon, 22 Aug 2022 22:10:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 899D9DA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195450;
        bh=q91DyqQ/SWqxDFLeUL7pohnhto4DoB586/Hk37Kf6kQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=S1umW41wIp1rQsBrGlOtfMMhHqGNLJQtB3CRTn1QaaoAGJopLXwb234+76+BhN6wq
         jDafWdPn5w7jMdJdtB6ZR9IOyQMNYRuG+fIuHc4eOLwtB50Ia5USFaxUZvo2MK4LO8
         MMZnwjgkXN0Z+HLu9AeGsdYnx20rsUzPY7mC8hZE=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:36 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/20] EDAC/synopsys: Use platform device devm ioremap method
Date:   Mon, 22 Aug 2022 22:07:16 +0300
Message-ID: <20220822190730.27277-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822190730.27277-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

DW DDRs CSRs resource descriptor is used by the devm_ioremap_resource()
function invocation only in the driver probe method. Thus we can freely
convert the platform_get_resource() and devm_ioremap_resource() couple to
just a single devm_platform_ioremap_resource() method call.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 14653b799901..f38c326f2cf5 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -1336,11 +1336,9 @@ static int mc_probe(struct platform_device *pdev)
 	struct synps_edac_priv *priv;
 	struct mem_ctl_info *mci;
 	void __iomem *baseaddr;
-	struct resource *res;
 	int rc;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	baseaddr = devm_ioremap_resource(&pdev->dev, res);
+	baseaddr = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(baseaddr))
 		return PTR_ERR(baseaddr);
 
-- 
2.35.1


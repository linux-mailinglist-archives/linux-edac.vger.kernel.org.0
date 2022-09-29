Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2245F1811
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbiJABOc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbiJABO0 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:26 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7341F31F;
        Fri, 30 Sep 2022 18:14:19 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id BEEEAE0EC3;
        Fri, 30 Sep 2022 02:27:27 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=VTnTBaf8SZoYktoiik88SyslcQq7bZrctG4k3i8eYzw=; b=kS8PoxbawGvb
        zLrZ/gj56cJgdGRBpEBfOAEDxXRMjCwj9bp0mTjYOcK5X2gAXAc96U7aj1hCNcIg
        gfW2jVbE/a+B51YZMZR4YlGsx3KLtnV5ORUIbn9HGOcHjkK7vSABfG2e106/yXoA
        +4ueu6BXViwlh4PWsFbV9EScgaJvqF0=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id AE843E0E6B;
        Fri, 30 Sep 2022 02:27:27 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:28 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v3 05/17] EDAC/synopsys: Fix reading errors count before ECC status
Date:   Fri, 30 Sep 2022 02:27:00 +0300
Message-ID: <20220929232712.12202-6-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [192.168.168.10]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Aside with fixing the errors count CSR usage the commit e2932d1f6f05
("EDAC/synopsys: Read the error count from the correct register") all of
the sudden has also changed the order of the errors status check
procedure. So now the errors handler method first reads the number of CE
and UE and only then makes sure that any of these errors have actually
happened. It doesn't make much sense. Let's fix that by getting back the
procedures order: first check the ECC status, then read the number of
errors.

Fixes: e2932d1f6f05 ("EDAC/synopsys: Read the error count from the correct register")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
---
 drivers/edac/synopsys_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index da1d90a87778..558d3b3e6864 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -423,18 +423,18 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	base = priv->baseaddr;
 	p = &priv->stat;
 
-	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
-	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
-	if (!p->ce_cnt)
-		goto ue_err;
-
 	regval = readl(base + ECC_STAT_OFST);
 	if (!regval)
 		return 1;
 
 	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
 
+	regval = readl(base + ECC_ERRCNT_OFST);
+	p->ce_cnt = regval & ECC_ERRCNT_CECNT_MASK;
+	p->ue_cnt = (regval & ECC_ERRCNT_UECNT_MASK) >> ECC_ERRCNT_UECNT_SHIFT;
+	if (!p->ce_cnt)
+		goto ue_err;
+
 	regval = readl(base + ECC_CEADDR0_OFST);
 	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_CEADDR1_OFST);
-- 
2.37.3



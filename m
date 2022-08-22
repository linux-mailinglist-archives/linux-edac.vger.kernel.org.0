Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF97059C7EB
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiHVTIE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238061AbiHVTH6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:07:58 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 750E9140DA;
        Mon, 22 Aug 2022 12:07:47 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id D11C3DA7;
        Mon, 22 Aug 2022 22:10:49 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com D11C3DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195449;
        bh=lHezRdyu8CznbTal0UlOdDCCHEtJN3WwOIX4vnqwe4w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dw8fcb6Wqyum8u/X0R5V17/ks6znp9nOdFJTRGSryN8YSJJ9Vbc72Qvjczli+Zblz
         f4XiBSFurKs2Jjw+gLrkKc9gA2tL+FvQygJL0sEwKTumWjdFqiKKGnB0GYDi9H3vV4
         XEOrG+iiEPRyIpkcshK8wDCgpzt7Ec+UrrGaQjnc=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
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
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 05/20] EDAC/synopsys: Fix reading errors count before ECC status
Date:   Mon, 22 Aug 2022 22:07:15 +0300
Message-ID: <20220822190730.27277-6-Sergey.Semin@baikalelectronics.ru>
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
---
 drivers/edac/synopsys_edac.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 873dbc684fe6..14653b799901 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -422,18 +422,18 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
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
2.35.1


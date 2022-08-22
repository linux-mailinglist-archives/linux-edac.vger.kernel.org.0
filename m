Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB659C7FC
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238028AbiHVTHz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiHVTHy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:07:54 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 821E2140D9;
        Mon, 22 Aug 2022 12:07:42 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 603A6DA5;
        Mon, 22 Aug 2022 22:10:48 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 603A6DA5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195448;
        bh=ptM9XFNDsBhxLUpxhVwAQyi2/yGaD7fTmIWrRW1Y7BQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nihIQXoFRpNxp74eAPWxT3n73FnYfjUIKkR1ORPJ4hx12ltGMA9zaJyNtQECxSk4h
         dLWdOC5DwIM/ep0+pH7hWuEtjaZB/3ZQ7G+4A0ZfY/4Jv3PpdJwk/B070Bio4agre1
         4KaIlrtUp9JaAbG7AP/Ey956t+8k7m7LLmwg/9as=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:34 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Manish Narani <manish.narani@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 03/20] EDAC/synopsys: Fix mci->scrub_cap field setting
Date:   Mon, 22 Aug 2022 22:07:13 +0300
Message-ID: <20220822190730.27277-4-Sergey.Semin@baikalelectronics.ru>
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

The mem_ctl_info.scrub_cap field is supposed to be set with the ECC
scrub-related flags while the driver initializes it with the SCRUB_HW_SRC
flag ID. It's definitely wrong, though hasn't caused any problem since the
structure field isn't used by the EDAC core. Let's fix it anyway by using
the SCRUB_FLAG_HW_SRC macro to initialize the field.

Fixes: ae9b56e3996d ("EDAC, synps: Add EDAC support for zynq ddr ecc controller")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 39c63dd1b9be..b9b68f3ecf52 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -857,7 +857,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
 	/* Initialize controller capabilities and configuration */
 	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
 	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_HW_SRC;
+	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
 	mci->scrub_mode = SCRUB_NONE;
 
 	mci->edac_cap = EDAC_FLAG_SECDED;
-- 
2.35.1


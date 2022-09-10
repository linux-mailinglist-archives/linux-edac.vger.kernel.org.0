Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B15B4840
	for <lists+linux-edac@lfdr.de>; Sat, 10 Sep 2022 21:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiIJToA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 10 Sep 2022 15:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIJTnh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 10 Sep 2022 15:43:37 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A19FF4A112;
        Sat, 10 Sep 2022 12:43:21 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 0A652DBE;
        Sat, 10 Sep 2022 22:46:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 0A652DBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1662839198;
        bh=jZl4LFCCJHqUzmC0B1mzH2VxWHws8KHONWhMao5yJb8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=oUU9aPLObFomzOyptiSZlPMSKs9IlR9PhTvqcdQCvwMbIuIe37NkS86a0BNYzdHvb
         6Lrr1EK+s0Cda3LQx+PmGzodNigz8D42P7ZhiYPcCxNDBtbpwx9JTgXN6CwFo9z1PO
         pbUX5KeAbl1vXH9/wuywIzKxVBm0wKlST61SPrlE=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 10 Sep 2022 22:42:47 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 10/19] EDAC/synopsys: Shorten out struct ecc_error_info.bankgrpnr field name
Date:   Sat, 10 Sep 2022 22:42:28 +0300
Message-ID: <20220910194237.10142-11-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
References: <20220910194237.10142-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

None of the ecc_error_info structure fields has "nr" suffix even though
each of them do re-present some number (row number, column number, bank
number). Let's drop the suffix from the bankgrpnr field name for the sake
of unification. While at it drop the word "Number" from the CE/UE error
messages too since it doesn't give any helpful info there.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 3a863c012eb6..2740f6c8c249 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -273,17 +273,17 @@
  * @row:	Row number.
  * @col:	Column number.
  * @bank:	Bank number.
+ * @bankgrp:	Bank group number.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
- * @bankgrpnr:	Bank group number.
  */
 struct ecc_error_info {
 	u32 row;
 	u32 col;
 	u32 bank;
+	u32 bankgrp;
 	u32 bitpos;
 	u32 data;
-	u32 bankgrpnr;
 };
 
 /**
@@ -434,7 +434,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	regval = readl(base + ECC_CEADDR1_OFST);
 	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
+	p->ceinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
@@ -448,7 +448,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 	regval = readl(base + ECC_UEADDR0_OFST);
 	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
 	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
+	p->ueinfo.bankgrp = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
@@ -484,9 +484,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "DDR ECC error type:%s Row %d Col %d Bank %d Bank Group %d Bit Position: %d Data: 0x%08x",
 				 "CE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
+				 pinf->bankgrp, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -503,9 +503,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "DDR ECC error type :%s Row %d Col %d Bank %d Bank Group %d",
 				 "UE", pinf->row, pinf->col, pinf->bank,
-				 pinf->bankgrpnr);
+				 pinf->bankgrp);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.37.2


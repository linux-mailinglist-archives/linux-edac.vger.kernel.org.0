Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA6959C7F5
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbiHVTIN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbiHVTIG (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:08:06 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C40A215835;
        Mon, 22 Aug 2022 12:07:58 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 8E576DAC;
        Mon, 22 Aug 2022 22:10:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 8E576DAC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661195452;
        bh=qReJ10qrM7by7bv31HV+hTtpdBkPXv9W01NZ0N4AzZk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iUEp2gx43+4rqqBhXp8yz51s7xBTN4wYl2VpwiyBaCXkUTr9nmV96HJ29eIz72+Wj
         PLcfKgdL5iHTRcZA0+su9T9RAecrGD9yeiqb73fuSWPDD+RUaQm8ybnmCid0rPSdTE
         IetHWxcxw3+srmLtbwCho3fXSHxtl797M7QrixrU=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:07:38 +0300
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
Subject: [PATCH 09/20] EDAC/synopsys: Drop struct ecc_error_info.blknr field
Date:   Mon, 22 Aug 2022 22:07:19 +0300
Message-ID: <20220822190730.27277-10-Sergey.Semin@baikalelectronics.ru>
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

Even though the ECC(C|U)ADDR1 CSR description indeed says it's a "Block
number" in the DW uMCTL2 DDRC hw reference manuals, the corresponding
register field name (ECC(C|U)ADDR1.ecc_(un)corr_col) and the rest of the
hw documentation refer to the field as the SDRAM address column. Thus
let's use the already available ecc_error_info.col field to read the
column number to and drop the questionable ecc_error_info.blknr field for
good.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index c51a25a28835..843d2717c72b 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -177,7 +177,7 @@
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
 #define ECC_CEADDR1_BNKGRP_MASK		0x3000000
 #define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_COL_MASK		0xFFF
 #define ECC_CEADDR1_BNKGRP_SHIFT	24
 #define ECC_CEADDR1_BNKNR_SHIFT		16
 
@@ -275,7 +275,6 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @bankgrpnr:	Bank group number.
- * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -284,7 +283,6 @@ struct ecc_error_info {
 	u32 bitpos;
 	u32 data;
 	u32 bankgrpnr;
-	u32 blknr;
 };
 
 /**
@@ -437,7 +435,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
@@ -453,7 +451,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 
 out:
@@ -485,10 +483,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ceinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d BankGroup Number %d Block Number %d Bit Position: %d Data: 0x%08x",
-				 "CE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr,
-				 pinf->bitpos, pinf->data);
+				 "DDR ECC error type:%s Row %d Col %d Bank %d BankGroup Number %d Bit Position: %d Data: 0x%08x",
+				 "CE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr, pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type:%s Row %d Bank %d Col %d Bit Position: %d Data: 0x%08x",
@@ -505,9 +502,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 		pinf = &p->ueinfo;
 		if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d BankGroup Number %d Block Number %d",
-				 "UE", pinf->row, pinf->bank,
-				 pinf->bankgrpnr, pinf->blknr);
+				 "DDR ECC error type :%s Row %d Col %d Bank %d BankGroup Number %d",
+				 "UE", pinf->row, pinf->col, pinf->bank,
+				 pinf->bankgrpnr);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-- 
2.35.1


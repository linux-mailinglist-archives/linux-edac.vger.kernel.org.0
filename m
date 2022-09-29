Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1241D5F1806
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbiJABOX (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiJABOU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:20 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87A3E1B9C3;
        Fri, 30 Sep 2022 18:14:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 4FC26E0EC7;
        Fri, 30 Sep 2022 02:27:30 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=sP/91KMd3AknZQ6PYaDkaWEp8kyLDM1XvKv7Fl4OhwA=; b=Jkn31ib01hGt
        HN8oYUH8hBBCaTBFrLRwRM5ru42dQbwcSWaLseiUaRxbl051KkozGTPd6b8XSfhV
        TBUXO3oI2veIOcl1oqWbkqHOWNz+4ArlY98uTT1cReFiXjOwmXOD0/2jMW7z3LJ9
        2J8Gu87uG+JfCfZfKl6k54LfLvMa6L4=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 4257EE0E6B;
        Fri, 30 Sep 2022 02:27:30 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:31 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
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
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND v3 09/17] EDAC/synopsys: Drop struct ecc_error_info.blknr field
Date:   Fri, 30 Sep 2022 02:27:04 +0300
Message-ID: <20220929232712.12202-10-Sergey.Semin@baikalelectronics.ru>
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
index 9a039aa0c308..3a863c012eb6 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -178,7 +178,7 @@
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
 #define ECC_CEADDR1_BNKGRP_MASK		0x3000000
 #define ECC_CEADDR1_BNKNR_MASK		0x70000
-#define ECC_CEADDR1_BLKNR_MASK		0xFFF
+#define ECC_CEADDR1_COL_MASK		0xFFF
 #define ECC_CEADDR1_BNKGRP_SHIFT	24
 #define ECC_CEADDR1_BNKNR_SHIFT		16
 
@@ -276,7 +276,6 @@
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @bankgrpnr:	Bank group number.
- * @blknr:	Block number.
  */
 struct ecc_error_info {
 	u32 row;
@@ -285,7 +284,6 @@ struct ecc_error_info {
 	u32 bitpos;
 	u32 data;
 	u32 bankgrpnr;
-	u32 blknr;
 };
 
 /**
@@ -438,7 +436,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
 					ECC_CEADDR1_BNKGRP_SHIFT;
-	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ceinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
 	edac_dbg(2, "ECCCSYN0: 0x%08X ECCCSYN1: 0x%08X ECCCSYN2: 0x%08X\n",
 		 readl(base + ECC_CSYND0_OFST), readl(base + ECC_CSYND1_OFST),
@@ -454,7 +452,7 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKGRP_SHIFT;
 	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
 					ECC_CEADDR1_BNKNR_SHIFT;
-	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
+	p->ueinfo.col = (regval & ECC_CEADDR1_COL_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
 
 out:
@@ -486,10 +484,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
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
@@ -506,9 +503,9 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
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
2.37.3



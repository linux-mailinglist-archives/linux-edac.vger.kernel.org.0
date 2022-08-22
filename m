Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F959C89E
	for <lists+linux-edac@lfdr.de>; Mon, 22 Aug 2022 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238349AbiHVTVs (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Aug 2022 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238706AbiHVTU6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Aug 2022 15:20:58 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADB2013D45;
        Mon, 22 Aug 2022 12:20:28 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 8E82FDA9;
        Mon, 22 Aug 2022 22:23:34 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 8E82FDA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1661196214;
        bh=hvldx64g2L6X+9yrJcqAyNeVPAaiuKHUOlWSlc8zeO8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WeZ2BLvqXNo+AAaS9wfvHlBXhL/wXkZbhSJmII9yFzjov6etCql5ZVFpn3RuuSGT6
         NrxbCP9tUBlLyRql4JPWTOIBGx3ey1A9QxTSoVb6T9LZX2tvZmXeNpo+7efoEscA7K
         66k/JH38zRBdJhAB8Sau+lpBRDvVMJ6+qy1mbFTk=
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 22 Aug 2022 22:20:20 +0300
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
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/13] EDAC/synopsys: Split up ECC UE/CE IRQs handler
Date:   Mon, 22 Aug 2022 22:19:50 +0300
Message-ID: <20220822191957.28546-8-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
References: <20220822191957.28546-1-Sergey.Semin@baikalelectronics.ru>
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

DW uMCTL2 DDRC IP-core doesn't have common IRQ line. Instead it provides
individual IRQ output signals for each controller event like: corrected
error, uncorrected error, DFI parity error, address protection, scrubber
done, and so on. So the common IRQ handler implemented in the Synopsys
EDAC driver isn't device-specific but is a particular platform specific.
Obviously it won't be suitable for the generic devices which are added to
the platforms with the original individual IRQs as it has happened in our
case.

So let's split up the common IRQ handler into two ones handling ECC
corrected and uncorrected errors. It won't be that hard since both
sub-methods it calls are already logically divided into two CE/UE parts.
What we need to do is to move these parts into the dedicated methods and
redefine the local variables a bit. The new methods will be simply called
from the common IRQs handler if one is utilized on the particular
platform. Otherwise each new IRQ handler will be called on particular
interrupt request (the IRQ handlers registration will be added a bit
later). Note we now can discard the snps_ecc_status structure as unneeded
since the error data is collected and reported now within a single method.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 272 +++++++++++++++++------------------
 1 file changed, 135 insertions(+), 137 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 028a9ad70d49..ac0123ff4595 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -143,7 +143,6 @@
 #define DDR_QOS_IRQ_STAT_OFST		0x20200
 #define DDR_QOSUE_MASK			BIT(2)
 #define DDR_QOSCE_MASK			BIT(1)
-#define ECC_CE_UE_INTR_MASK		(DDR_QOSUE_MASK | DDR_QOSCE_MASK)
 #define DDR_QOS_IRQ_EN_OFST		0x20208
 #define DDR_QOS_IRQ_DB_OFST		0x2020C
 
@@ -372,31 +371,19 @@ struct snps_sdram_addr {
 /**
  * struct snps_ecc_error_info - ECC error log information.
  * @sdram:	SDRAM address.
+ * @ecnt:	Number of detected errors.
  * @bitpos:	Bit position.
  * @data:	Data causing the error.
  * @syndrome:	Erroneous data syndrome.
  */
 struct snps_ecc_error_info {
 	struct snps_sdram_addr sdram;
+	u16 ecnt;
 	u32 bitpos;
 	u64 data;
 	u32 syndrome;
 };
 
-/**
- * struct snps_ecc_status - ECC status information to report.
- * @ce_cnt:	Correctable error count.
- * @ue_cnt:	Uncorrectable error count.
- * @ceinfo:	Correctable error log information.
- * @ueinfo:	Uncorrectable error log information.
- */
-struct snps_ecc_status {
-	u32 ce_cnt;
-	u32 ue_cnt;
-	struct snps_ecc_error_info ceinfo;
-	struct snps_ecc_error_info ueinfo;
-};
-
 /**
  * struct snps_edac_priv - DDR memory controller private data.
  * @info:		DDR controller config info.
@@ -406,7 +393,6 @@ struct snps_ecc_status {
  * @baseaddr:		Base address of the DDR controller.
  * @lock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
- * @stat:		ECC status information.
  */
 struct snps_edac_priv {
 	struct snps_ddrc_info info;
@@ -416,7 +402,6 @@ struct snps_edac_priv {
 	void __iomem *baseaddr;
 	spinlock_t lock;
 	char message[SNPS_EDAC_MSG_SIZE];
-	struct snps_ecc_status stat;
 };
 
 /**
@@ -688,130 +673,178 @@ static inline u32 snps_get_bitpos(u32 bitnum, enum snps_dq_width dq_width)
 }
 
 /**
- * snps_get_error_info - Get the current ECC error info.
- * @priv:	DDR memory controller private instance data.
+ * snps_ce_irq_handler - Corrected error interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
  *
- * Return: one if there is no error otherwise returns zero.
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
  */
-static int snps_get_error_info(struct snps_edac_priv *priv)
+static irqreturn_t snps_ce_irq_handler(int irq, void *dev_id)
 {
-	struct snps_ecc_status *p;
-	u32 regval, clearval;
+	struct mem_ctl_info *mci = dev_id;
+	struct snps_edac_priv *priv = mci->pvt_info;
+	struct snps_ecc_error_info einfo;
 	unsigned long flags;
-	void __iomem *base;
+	u32 qosval, regval;
+	dma_addr_t sys;
 
-	base = priv->baseaddr;
-	p = &priv->stat;
+	/* Make sure IRQ is caused by a corrected ECC error */
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
+		qosval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		if (!(qosval & DDR_QOSCE_MASK))
+			return IRQ_NONE;
 
-	regval = readl(base + ECC_STAT_OFST);
-	if (!regval)
-		return 1;
+		qosval &= DDR_QOSCE_MASK;
+	}
 
-	p->ceinfo.bitpos = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
+	regval = readl(priv->baseaddr + ECC_STAT_OFST);
+	if (!FIELD_GET(ECC_STAT_CE_MASK, regval))
+		return IRQ_NONE;
 
-	regval = readl(base + ECC_ERRCNT_OFST);
-	p->ce_cnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
-	p->ue_cnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
-	if (!p->ce_cnt)
-		goto ue_err;
+	/* Read error info like bit position, SDRAM address, data, syndrome */
+	einfo.bitpos = FIELD_GET(ECC_STAT_BITNUM_MASK, regval);
+	einfo.bitpos = snps_get_bitpos(einfo.bitpos, priv->info.dq_width);
 
-	p->ceinfo.bitpos = snps_get_bitpos(p->ceinfo.bitpos, priv->info.dq_width);
+	regval = readl(priv->baseaddr + ECC_ERRCNT_OFST);
+	einfo.ecnt = FIELD_GET(ECC_ERRCNT_CECNT_MASK, regval);
 
-	regval = readl(base + ECC_CEADDR0_OFST);
-	p->ceinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
-	p->ceinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	regval = readl(priv->baseaddr + ECC_CEADDR0_OFST);
+	einfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	einfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
-	regval = readl(base + ECC_CEADDR1_OFST);
-	p->ceinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ceinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ceinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	regval = readl(priv->baseaddr + ECC_CEADDR1_OFST);
+	einfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	einfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	einfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
-	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
+	einfo.data = readl(priv->baseaddr + ECC_CSYND0_OFST);
 	if (priv->info.dq_width == SNPS_DQ_64)
-		p->ceinfo.data |= (u64)readl(base + ECC_CSYND1_OFST) << 32;
-
-	p->ceinfo.syndrome = readl(base + ECC_CSYND2_OFST);
+		einfo.data |= (u64)readl(priv->baseaddr + ECC_CSYND1_OFST) << 32;
 
-ue_err:
-	if (!p->ue_cnt)
-		goto out;
+	einfo.syndrome = readl(priv->baseaddr + ECC_CSYND2_OFST);
 
-	regval = readl(base + ECC_UEADDR0_OFST);
-	p->ueinfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
-	p->ueinfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
+	/* Report the detected errors with the corresponding sys address */
+	snps_map_sdram_to_sys(priv, &einfo.sdram, &sys);
 
-	regval = readl(base + ECC_UEADDR1_OFST);
-	p->ueinfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
-	p->ueinfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
-	p->ueinfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
+	snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
+		 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Bit %d Data 0x%08llx",
+		 einfo.sdram.row, einfo.sdram.col, einfo.sdram.bank,
+		 einfo.sdram.bankgrp, einfo.sdram.rank,
+		 einfo.bitpos, einfo.data);
 
-	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
-	if (priv->info.dq_width == SNPS_DQ_64)
-		p->ueinfo.data |= (u64)readl(base + ECC_UESYND1_OFST) << 32;
-
-	p->ueinfo.syndrome = readl(base + ECC_UESYND2_OFST);
+	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, einfo.ecnt,
+			     PHYS_PFN(sys), offset_in_page(sys),
+			     einfo.syndrome, einfo.sdram.rank, 0, -1,
+			     priv->message, "");
 
-out:
+	/* Make sure the CE IRQ status is cleared */
 	spin_lock_irqsave(&priv->lock, flags);
 
-	clearval = readl(base + ECC_CLR_OFST) |
-		   ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
-		   ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
-	writel(clearval, base + ECC_CLR_OFST);
+	regval = readl(priv->baseaddr + ECC_CLR_OFST) |
+		 ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
+	writel(regval, priv->baseaddr + ECC_CLR_OFST);
 
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	return 0;
+	if (priv->info.caps & SNPS_CAP_ZYNQMP)
+		writel(qosval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+
+	return IRQ_HANDLED;
 }
 
 /**
- * snps_handle_error - Handle Correctable and Uncorrectable errors.
- * @mci:	EDAC memory controller instance.
- * @p:		Synopsys ECC status structure.
+ * snps_ue_irq_handler - Uncorrected error interrupt handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
  *
- * Handles ECC correctable and uncorrectable errors.
+ * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
  */
-static void snps_handle_error(struct mem_ctl_info *mci, struct snps_ecc_status *p)
+static irqreturn_t snps_ue_irq_handler(int irq, void *dev_id)
 {
+	struct mem_ctl_info *mci = dev_id;
 	struct snps_edac_priv *priv = mci->pvt_info;
-	struct snps_ecc_error_info *pinf;
+	struct snps_ecc_error_info einfo;
+	unsigned long flags;
+	u32 qosval, regval;
 	dma_addr_t sys;
 
-	if (p->ce_cnt) {
-		pinf = &p->ceinfo;
+	/* Make sure IRQ is caused by an uncorrected ECC error */
+	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
+		qosval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+		if (!(regval & DDR_QOSUE_MASK))
+			return IRQ_NONE;
+
+		qosval &= DDR_QOSUE_MASK;
+	}
 
-		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Bit %d Data 0x%08llx",
-			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
-			 pinf->sdram.bankgrp, pinf->sdram.rank,
-			 pinf->bitpos, pinf->data);
+	regval = readl(priv->baseaddr + ECC_STAT_OFST);
+	if (!FIELD_GET(ECC_STAT_UE_MASK, regval))
+		return IRQ_NONE;
 
-		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+	/* Read error info like SDRAM address, data and syndrome */
+	regval = readl(priv->baseaddr + ECC_ERRCNT_OFST);
+	einfo.ecnt = FIELD_GET(ECC_ERRCNT_UECNT_MASK, regval);
 
-		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci, p->ce_cnt,
-				     PHYS_PFN(sys), offset_in_page(sys),
-				     pinf->syndrome, pinf->sdram.rank, 0, -1,
-				     priv->message, "");
-	}
+	regval = readl(priv->baseaddr + ECC_UEADDR0_OFST);
+	einfo.sdram.rank = FIELD_GET(ECC_CEADDR0_RANK_MASK, regval);
+	einfo.sdram.row = FIELD_GET(ECC_CEADDR0_ROW_MASK, regval);
 
-	if (p->ue_cnt) {
-		pinf = &p->ueinfo;
+	regval = readl(priv->baseaddr + ECC_UEADDR1_OFST);
+	einfo.sdram.bankgrp = FIELD_GET(ECC_CEADDR1_BANKGRP_MASK, regval);
+	einfo.sdram.bank = FIELD_GET(ECC_CEADDR1_BANK_MASK, regval);
+	einfo.sdram.col = FIELD_GET(ECC_CEADDR1_COL_MASK, regval);
 
-		snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
-			 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Data 0x%08llx",
-			 pinf->sdram.row, pinf->sdram.col, pinf->sdram.bank,
-			 pinf->sdram.bankgrp, pinf->sdram.rank,
-			 pinf->data);
+	einfo.data = readl(priv->baseaddr + ECC_UESYND0_OFST);
+	if (priv->info.dq_width == SNPS_DQ_64)
+		einfo.data |= (u64)readl(priv->baseaddr + ECC_UESYND1_OFST) << 32;
 
-		snps_map_sdram_to_sys(priv, &pinf->sdram, &sys);
+	einfo.syndrome = readl(priv->baseaddr + ECC_UESYND2_OFST);
 
-		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, p->ue_cnt,
-				     PHYS_PFN(sys), offset_in_page(sys),
-				     pinf->syndrome, pinf->sdram.rank, 0, -1,
-				     priv->message, "");
-	}
+	/* Report the detected errors with the corresponding sys address */
+	snps_map_sdram_to_sys(priv, &einfo.sdram, &sys);
+
+	snprintf(priv->message, SNPS_EDAC_MSG_SIZE,
+		 "Row %hu Col %hu Bank %hhu Bank Group %hhu Rank %hhu Data 0x%08llx",
+		 einfo.sdram.row, einfo.sdram.col, einfo.sdram.bank,
+		 einfo.sdram.bankgrp, einfo.sdram.rank,
+		 einfo.data);
+
+	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci, einfo.ecnt,
+			     PHYS_PFN(sys), offset_in_page(sys),
+			     einfo.syndrome, einfo.sdram.rank, 0, -1,
+			     priv->message, "");
+
+	/* Make sure the UE IRQ status is cleared */
+	spin_lock_irqsave(&priv->lock, flags);
+
+	regval = readl(priv->baseaddr + ECC_CLR_OFST) |
+		 ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	writel(regval, priv->baseaddr + ECC_CLR_OFST);
 
-	memset(p, 0, sizeof(*p));
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	if (priv->info.caps & SNPS_CAP_ZYNQMP)
+		writel(qosval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * snps_com_irq_handler - Interrupt IRQ signal handler.
+ * @irq:        IRQ number.
+ * @dev_id:     Device ID.
+ *
+ * Return: IRQ_NONE, if interrupts not set or IRQ_HANDLED otherwise.
+ */
+static irqreturn_t snps_com_irq_handler(int irq, void *dev_id)
+{
+	irqreturn_t rc = IRQ_NONE;
+
+	rc |= snps_ce_irq_handler(irq, dev_id);
+
+	rc |= snps_ue_irq_handler(irq, dev_id);
+
+	return rc;
 }
 
 static void snps_enable_irq(struct snps_edac_priv *priv)
@@ -854,41 +887,6 @@ static void snps_disable_irq(struct snps_edac_priv *priv)
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-/**
- * snps_irq_handler - Interrupt Handler for ECC interrupts.
- * @irq:        IRQ number.
- * @dev_id:     Device ID.
- *
- * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
- */
-static irqreturn_t snps_irq_handler(int irq, void *dev_id)
-{
-	struct mem_ctl_info *mci = dev_id;
-	struct snps_edac_priv *priv;
-	int status, regval;
-
-	priv = mci->pvt_info;
-
-	if (priv->info.caps & SNPS_CAP_ZYNQMP) {
-		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
-		if (!(regval & ECC_CE_UE_INTR_MASK))
-			return IRQ_NONE;
-	}
-
-	status = snps_get_error_info(priv);
-	if (status)
-		return IRQ_NONE;
-
-	snps_handle_error(mci, &priv->stat);
-
-
-	if (priv->info.caps & SNPS_CAP_ZYNQMP)
-		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-
-	return IRQ_HANDLED;
-}
-
 /**
  * snps_create_data - Create private data.
  * @pdev:	platform device.
@@ -1538,7 +1536,7 @@ static int snps_setup_irq(struct mem_ctl_info *mci)
 		return irq;
 	}
 
-	ret = devm_request_irq(&priv->pdev->dev, irq, snps_irq_handler,
+	ret = devm_request_irq(&priv->pdev->dev, irq, snps_com_irq_handler,
 			       0, dev_name(&priv->pdev->dev), mci);
 	if (ret < 0) {
 		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
-- 
2.35.1


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741ED5F180E
	for <lists+linux-edac@lfdr.de>; Sat,  1 Oct 2022 03:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbiJABO1 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 30 Sep 2022 21:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbiJABOY (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 30 Sep 2022 21:14:24 -0400
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C2421B9CC;
        Fri, 30 Sep 2022 18:14:12 -0700 (PDT)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 2508DE0EBB;
        Fri, 30 Sep 2022 02:27:25 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=U+7CjhwpbjiIIOfODLWwzstc/ZqbWDmexGEbDxuL8KY=; b=NF2Y0OrXkT2l
        gQ/o4VVYUiD0zM3VnPTrI+K3vVaEk2/I8CYZ20m2o4CKVW14wTRD7u1cRvbHj6GR
        d3UbYNChe6iTdY200QdExvzfOnEIPSOQ/hk3J6EF0mSjS0eKxz0ZEWLYqv4wSlnT
        4+rXEpvUwPtEf/inIhuTXUtpzq0AgrI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 15ABFE0E6B;
        Fri, 30 Sep 2022 02:27:25 +0300 (MSK)
Received: from localhost (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 30 Sep 2022 02:27:25 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Michail Ivanov <Michail.Ivanov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH RESEND v3 01/17] EDAC/synopsys: Fix native uMCTL2 IRQs handling procedure
Date:   Fri, 30 Sep 2022 02:26:56 +0300
Message-ID: <20220929232712.12202-2-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
References: <20220929232712.12202-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

The generic DW uMCTL2 DDRC v3.x support was added in commit f7824ded4149
("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR"). It
hasn't been done quiet well there with respect to the IRQs handling
procedure. An attempt to fix that was introduced in the recent commit
4bcffe941758 ("EDAC/synopsys: Re-enable the error interrupts on v3 hw").
Alas again it didn't provide quite complete solution.

First of all the commit f7824ded4149 ("EDAC/synopsys: Add support for
version 3 of the Synopsys EDAC DDR") log says that v3.80a "has UE/CE auto
cleared". They aren't in none of the IP-core versions. The IRQ status can
be cleared by means of setting the ECCCLR/ECCCTL register self-cleared
flags 0-3. The pending IRQ clearance is done in the respective
get_error_info() method of the driver. Thus defining a quirk flag with the
"DDR_ECC_INTR_SELF_CLEAR" name was at least very inaccurate if not to say
misleading. So was adding the comments about the "ce/ue bits automatically
cleared".

Second, disabling the being handled IRQ in the handler doesn't make sense
in Linux since the IC line is masked during that procedure anyway. So
disabling the IRQ in one part of the handler and enabling it at the end of
the method is simply redundant. (See, the ZynqMP-specific code with the
QoS IRQ CSR didn't do that originally.)

Finally calling the zynqmp_get_error_info() method concurrently with the
enable_irq()/disable_irq() functions causes the IRQs mask state race
condition. Starting from DW uMCTL2 DDRC IP-core v3.10a [1] the ECCCLR
register has been renamed to ECCCTL and has been equipped with CE/UE IRQs
enable/disable flags [2]. So the CSR now serves for the IRQ status and
control functions used concurrently during the IRQ handling and the IRQ
disabling/enabling. Thus the corresponding critical section must be
protected with the IRQ-safe spin-lock.

So let's fix all the problems noted above. First the
DDR_ECC_INTR_SELF_CLEAR flag is renamed to SYNPS_ZYNQMP_IRQ_REGS. Its
semantic is now the opposite: the quirk means having the ZynqMP IRQ CSRs
available on the platform. Second the DDR_UE_MASK and DDR_CE_MASK macros
are renamed to imply being used in the framework of the ECCCLR/ECCCTL CSRs
accesses. Third all the misleading comments are removed. Finally the
ECC_CLR_OFST register IOs are now protected with the IRQ-safe spin-lock
taken in order to prevent the IRQ status clearance and IRQ enable/disable
race condition.

[1] DesignWare Cores Enhanced Universal DDR Memory and Protocol
Controllers (uMCTL2/uPCTL2), Release Notes, Version 3.91a, October 2020,
p. 27.
[2] DesignWare® Cores Enhanced Universal DDR Memory Controller (uMCTL2),
Databook Version 3.91a, October 2020, p.818-819.

Fixes: f7824ded4149 ("EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 drivers/edac/synopsys_edac.c | 76 +++++++++++++++++++++++-------------
 1 file changed, 48 insertions(+), 28 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index f7d37c282819..c78fb5781ff9 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -9,6 +9,7 @@
 #include <linux/edac.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -88,7 +89,7 @@
 /* DDR ECC Quirks */
 #define DDR_ECC_INTR_SUPPORT		BIT(0)
 #define DDR_ECC_DATA_POISON_SUPPORT	BIT(1)
-#define DDR_ECC_INTR_SELF_CLEAR		BIT(2)
+#define SYNPS_ZYNQMP_IRQ_REGS		BIT(2)
 
 /* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
 /* ECC Configuration Registers */
@@ -133,11 +134,13 @@
 
 #define ECC_ADDRMAP0_OFFSET		0x200
 
-/* Control register bitfield definitions */
+/* ECC control/clear register definitions */
 #define ECC_CTRL_BUSWIDTH_MASK		0x3000
 #define ECC_CTRL_BUSWIDTH_SHIFT		12
 #define ECC_CTRL_CLR_CE_ERRCNT		BIT(2)
 #define ECC_CTRL_CLR_UE_ERRCNT		BIT(3)
+#define ECC_CTRL_EN_CE_IRQ		BIT(8)
+#define ECC_CTRL_EN_UE_IRQ		BIT(9)
 
 /* DDR Control Register width definitions  */
 #define DDRCTL_EWDTH_16			2
@@ -164,10 +167,6 @@
 #define DDR_QOS_IRQ_EN_OFST		0x20208
 #define DDR_QOS_IRQ_DB_OFST		0x2020C
 
-/* DDR QOS Interrupt register definitions */
-#define DDR_UE_MASK			BIT(9)
-#define DDR_CE_MASK			BIT(8)
-
 /* ECC Corrected Error Register Mask and Shifts*/
 #define ECC_CEADDR0_RW_MASK		0x3FFFF
 #define ECC_CEADDR0_RNK_MASK		BIT(24)
@@ -300,6 +299,7 @@ struct synps_ecc_status {
 /**
  * struct synps_edac_priv - DDR memory controller private instance data.
  * @baseaddr:		Base address of the DDR controller.
+ * @lock:		Concurrent CSRs access lock.
  * @message:		Buffer for framing the event specific info.
  * @stat:		ECC status information.
  * @p_data:		Platform data.
@@ -314,6 +314,7 @@ struct synps_ecc_status {
  */
 struct synps_edac_priv {
 	void __iomem *baseaddr;
+	spinlock_t lock;
 	char message[SYNPS_EDAC_MSG_SIZE];
 	struct synps_ecc_status stat;
 	const struct synps_platform_data *p_data;
@@ -409,7 +410,8 @@ static int zynq_get_error_info(struct synps_edac_priv *priv)
 static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 {
 	struct synps_ecc_status *p;
-	u32 regval, clearval = 0;
+	u32 regval, clearval;
+	unsigned long flags;
 	void __iomem *base;
 
 	base = priv->baseaddr;
@@ -452,11 +454,16 @@ static int zynqmp_get_error_info(struct synps_edac_priv *priv)
 					ECC_CEADDR1_BNKNR_SHIFT;
 	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
 	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
+
 out:
-	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
-	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
+	spin_lock_irqsave(&priv->lock, flags);
+
+	clearval = readl(base + ECC_CLR_OFST) |
+		   ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT |
+		   ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
 	writel(clearval, base + ECC_CLR_OFST);
-	writel(0x0, base + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
@@ -516,24 +523,42 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 
 static void enable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Enable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(DDR_UE_MASK | DDR_CE_MASK,
-		       priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
 
+		return;
+	}
+
+	/* IRQs Enable/Disable feature has been available since v3.10a */
+	spin_lock_irqsave(&priv->lock, flags);
+
+	writel(ECC_CTRL_EN_CE_IRQ | ECC_CTRL_EN_UE_IRQ,
+	       priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 static void disable_intr(struct synps_edac_priv *priv)
 {
+	unsigned long flags;
+
 	/* Disable UE/CE Interrupts */
-	if (priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)
-		writel(0x0, priv->baseaddr + ECC_CLR_OFST);
-	else
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		writel(DDR_QOSUE_MASK | DDR_QOSCE_MASK,
 		       priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
+
+		return;
+	}
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	writel(0, priv->baseaddr + ECC_CLR_OFST);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
 /**
@@ -553,11 +578,7 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 	priv = mci->pvt_info;
 	p_data = priv->p_data;
 
-	/*
-	 * v3.0 of the controller has the ce/ue bits cleared automatically,
-	 * so this condition does not apply.
-	 */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR)) {
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS) {
 		regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
 		regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
 		if (!(regval & ECC_CE_UE_INTR_MASK))
@@ -574,11 +595,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
 
 	edac_dbg(3, "Total error count CE %d UE %d\n",
 		 priv->ce_cnt, priv->ue_cnt);
-	/* v3.0 of the controller does not have this register */
-	if (!(priv->p_data->quirks & DDR_ECC_INTR_SELF_CLEAR))
+
+	if (priv->p_data->quirks & SYNPS_ZYNQMP_IRQ_REGS)
 		writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
-	else
-		enable_intr(priv);
 
 	return IRQ_HANDLED;
 }
@@ -900,7 +919,7 @@ static const struct synps_platform_data zynqmp_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT
+	.quirks         = (DDR_ECC_INTR_SUPPORT | SYNPS_ZYNQMP_IRQ_REGS
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
@@ -912,7 +931,7 @@ static const struct synps_platform_data synopsys_edac_def = {
 	.get_mtype	= zynqmp_get_mtype,
 	.get_dtype	= zynqmp_get_dtype,
 	.get_ecc_state	= zynqmp_get_ecc_state,
-	.quirks         = (DDR_ECC_INTR_SUPPORT | DDR_ECC_INTR_SELF_CLEAR
+	.quirks         = (DDR_ECC_INTR_SUPPORT
 #ifdef CONFIG_EDAC_DEBUG
 			  | DDR_ECC_DATA_POISON_SUPPORT
 #endif
@@ -1360,6 +1379,7 @@ static int mc_probe(struct platform_device *pdev)
 	priv = mci->pvt_info;
 	priv->baseaddr = baseaddr;
 	priv->p_data = p_data;
+	spin_lock_init(&priv->lock);
 
 	mc_init(mci, pdev);
 
-- 
2.37.3



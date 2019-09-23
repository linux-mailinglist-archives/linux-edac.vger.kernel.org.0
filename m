Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C53BB9EB
	for <lists+linux-edac@lfdr.de>; Mon, 23 Sep 2019 18:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388566AbfIWQuf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 Sep 2019 12:50:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32824 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387750AbfIWQuf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 23 Sep 2019 12:50:35 -0400
Received: from zn.tnic (p200300EC2F06040028E0D43BC962B311.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:400:28e0:d43b:c962:b311])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 60A481EC06F3;
        Mon, 23 Sep 2019 18:50:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1569257433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F6YVbKOBUea7dpsJpSgt+YnYBCbsXyOOVpXcm79JlKg=;
        b=FzI0QsNiE3RsRK9vvEEl129PTx0U8wI02Y4qVdXbOVMABNcGFlDc3DBIUKIzHp3LM/g5Ex
        BeCIA4hXm8gxIlQqltK/LFeV48HMdA1sex7YrCHDxqiaLsB1NY7vtmcefXKlzg0muK7xIk
        uFUtC1V647GckBPJYlPW+Z0tjkxdlLc=
Date:   Mon, 23 Sep 2019 18:50:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "james.morse@arm.com" <james.morse@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>,
        "scott.branden@broadcom.com" <scott.branden@broadcom.com>,
        "yuqing.shen@broadcom.com" <yuqing.shen@broadcom.com>,
        "ray.jui@broadcom.com" <ray.jui@broadcom.com>
Subject: Re: [PATCH v6 2/2] EDAC: add EDAC driver for DMC520
Message-ID: <20190923165034.GJ15355@zn.tnic>
References: <BY5PR04MB65990410B5B26C11DBE9C9B186890@BY5PR04MB6599.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BY5PR04MB65990410B5B26C11DBE9C9B186890@BY5PR04MB6599.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Sep 19, 2019 at 06:37:18PM +0000, Lei Wang wrote:
> New driver supports error detection and correction on the devices with ARM
> DMC-520 memory controller.
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>     Changes in v6:
>         - Refactored dmc520_edac_probe to move most hw initialization before
>           edac_mc_alloc.
>         - Fixed patch format.
>         - Addressed several other misc comments from Borislav Petkov.
> ---
>  MAINTAINERS                |   6 +
>  drivers/edac/Kconfig       |   7 +
>  drivers/edac/Makefile      |   1 +
>  drivers/edac/dmc520_edac.c | 661 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 675 insertions(+)
>  create mode 100644 drivers/edac/dmc520_edac.c

...

> +/* Get the memory data bus width, in number of bytes. */

With the return variable properly named, that comment is useless. You're
returning a "mem_width_in_bytes" - can't be clearer than that.

In any case, I took your patch and did some cleanups ontop:

 - align function args on opening braces
 - shorten too long member names
 - do not break long strings
 - why do the loops use the pre-increment "++intr_index" instead of the
 usual post-increment "intr_index++"?

Please have a look, integrate them in your patch and redo it ontop of
the edac-for-next branch here:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next

but *after* the merge window is over and once that branch has been
updated to 4.5-rc1.

Thx.

---
diff --git a/drivers/edac/dmc520_edac.c b/drivers/edac/dmc520_edac.c
index 41c41efaaaf2..ab1ab19890d3 100644
--- a/drivers/edac/dmc520_edac.c
+++ b/drivers/edac/dmc520_edac.c
@@ -110,16 +110,15 @@ struct ecc_error_info {
 struct dmc520_edac {
 	void __iomem *reg_base;
 	u32 nintr;
-	u32 interrupt_mask_all;
+	u32 irq_mask_all;
 	spinlock_t ecc_lock;
-	u32 interrupt_masks[0];
+	u32 irq_masks[0];
 };
 
 static int dmc520_mc_idx;
 
 static irqreturn_t
-dmc520_edac_dram_all_isr(
-	int irq, struct mem_ctl_info *mci, u32 interrupt_mask);
+dmc520_edac_dram_all_isr(int irq, struct mem_ctl_info *mci, u32 interrupt_mask);
 
 #define DECLARE_ISR(index) \
 static irqreturn_t dmc520_isr_##index(int irq, void *data) \
@@ -128,8 +127,7 @@ static irqreturn_t dmc520_isr_##index(int irq, void *data) \
 	struct dmc520_edac *edac; \
 	mci = data; \
 	edac = mci->pvt_info; \
-	return dmc520_edac_dram_all_isr( \
-		irq, mci, edac->interrupt_masks[index]); \
+	return dmc520_edac_dram_all_isr(irq, mci, edac->irq_masks[index]); \
 }
 
 DECLARE_ISR(0)
@@ -235,7 +233,7 @@ static enum scrub_type dmc520_get_scrub_type(struct dmc520_edac *edac)
 	scrub_cfg = FIELD_GET(SCRUB_TRIGGER0_NEXT_MASK, reg_val);
 
 	if (scrub_cfg == DMC520_SCRUB_TRIGGER_ERR_DETECT ||
-		scrub_cfg == DMC520_SCRUB_TRIGGER_IDLE)
+	    scrub_cfg == DMC520_SCRUB_TRIGGER_IDLE)
 		type = SCRUB_HW_PROG;
 
 	return type;
@@ -347,7 +345,6 @@ static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
 	dmc520_get_dram_ecc_error_info(edac, is_ce, &info);
 
 	cnt = dmc520_get_dram_ecc_error_count(edac, is_ce);
-
 	if (!cnt)
 		return;
 
@@ -364,8 +361,8 @@ static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
 	spin_unlock(&edac->ecc_lock);
 }
 
-static irqreturn_t dmc520_edac_dram_ecc_isr(
-	int irq, struct mem_ctl_info *mci, bool is_ce)
+static irqreturn_t dmc520_edac_dram_ecc_isr(int irq, struct mem_ctl_info *mci,
+					    bool is_ce)
 {
 	struct dmc520_edac *edac;
 	u32 i_mask;
@@ -381,8 +378,8 @@ static irqreturn_t dmc520_edac_dram_ecc_isr(
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t dmc520_edac_dram_all_isr(
-	int irq, struct mem_ctl_info *mci, u32 interrupt_mask)
+static irqreturn_t dmc520_edac_dram_all_isr(int irq, struct mem_ctl_info *mci,
+					    u32 interrupt_mask)
 {
 	irqreturn_t irq_ret = IRQ_NONE;
 	struct dmc520_edac *edac;
@@ -435,8 +432,8 @@ static void dmc520_init_csrow(struct mem_ctl_info *mci)
 
 static int dmc520_edac_probe(struct platform_device *pdev)
 {
-	int ret, intr_index, nintr, nintr_registered = 0;
-	struct dmc520_edac *edac, *edac_local;
+	int ret, idx, nintr, nintr_registered = 0;
+	struct dmc520_edac *edac, edac_local;
 	struct mem_ctl_info *mci = NULL;
 	struct edac_mc_layer layers[1];
 	void __iomem *reg_base;
@@ -444,22 +441,20 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct device *dev;
 
-	/* Parsing the device node */
+	/* Parse the device node */
 	dev = &pdev->dev;
 
 	nintr = of_property_count_u32_elems(dev->of_node, "interrupt-config");
 	if (nintr <= 0) {
 		edac_printk(KERN_ERR, EDAC_MOD_NAME,
-			"Invalid device node configuration:\n"
-			"At least one interrupt line/config is expected.\n");
+			    "Invalid device node configuration: At least one interrupt line/config is expected.\n");
 		return -EINVAL;
 	}
 
 	if (nintr > ARRAY_SIZE(dmc520_isr_array)) {
 		edac_printk(KERN_ERR, EDAC_MOD_NAME,
-			"Invalid device node configuration:\n"
-			"# of intr config elements(%d) can not exceed %ld.\n",
-			nintr, ARRAY_SIZE(dmc520_isr_array));
+			    "Invalid device node configuration: # of intr config elements(%d) can not exceed %ld.\n",
+			    nintr, ARRAY_SIZE(dmc520_isr_array));
 		return -EINVAL;
 	}
 
@@ -477,42 +472,35 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	layers[0].is_virt_csrow = true;
 
 	edac_size = sizeof(struct dmc520_edac) + sizeof(u32) * nintr;
-	edac_local = kmalloc(edac_size, GFP_KERNEL);
-	if (!edac_local)
-		return -ENOMEM;
-	memset(edac_local, 0, edac_size);
 
 	ret = of_property_read_u32_array(dev->of_node, "interrupt-config",
-			edac_local->interrupt_masks, nintr);
+					 edac_local.irq_masks, nintr);
 	if (ret) {
 		edac_printk(KERN_ERR, EDAC_MOD_NAME,
-			"Failed to get interrupt-config arrays.\n");
+			    "Failed to get interrupt-config arrays.\n");
 		goto err;
 	}
 
-	for (intr_index = 0; intr_index < nintr; ++intr_index) {
-		if (edac_local->interrupt_mask_all &
-			edac_local->interrupt_masks[intr_index]) {
+	for (idx = 0; idx < nintr; idx++) {
+		if (edac_local.irq_mask_all &
+		    edac_local.irq_masks[idx]) {
 			edac_printk(KERN_ERR, EDAC_MC,
-				"Interrupt-config error:\n"
-				"Element %d's intr mask %d has overlap.\n",
-				intr_index,
-				edac_local->interrupt_masks[intr_index]);
+				    "Interrupt-config error: Element %d's intr mask %d has overlap.\n",
+				    idx, edac_local.irq_masks[idx]);
 			ret = -ENXIO;
 			goto err;
 		}
 
-		edac_local->interrupt_mask_all |=
-			edac_local->interrupt_masks[intr_index];
+		edac_local.irq_mask_all |= edac_local.irq_masks[idx];
 	}
 
-	if ((edac_local->interrupt_mask_all | ALL_INT_MASK) != ALL_INT_MASK) {
+	if ((edac_local.irq_mask_all | ALL_INT_MASK) != ALL_INT_MASK) {
 		edac_printk(KERN_WARNING, EDAC_MOD_NAME,
-			"Interrupt-config warning:\n"
-			"Interrupt mask (0x%x) is not supported.(0x%lx).\n",
-			edac_local->interrupt_mask_all, ALL_INT_MASK);
+			    "Interrupt-config warning: Interrupt mask (0x%x) is not supported.(0x%lx).\n",
+			    edac_local.irq_mask_all, ALL_INT_MASK);
 	}
-	edac_local->interrupt_mask_all &= ALL_INT_MASK;
+
+	edac_local.irq_mask_all &= ALL_INT_MASK;
 
 	mci = edac_mc_alloc(dmc520_mc_idx++, ARRAY_SIZE(layers), layers,
 			    edac_size);
@@ -524,9 +512,8 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	}
 
 	edac = mci->pvt_info;
-	memcpy(edac, edac_local, edac_size);
-	kfree(edac_local);
-	edac_local = NULL;
+	memcpy(edac, &edac_local, edac_size);
+
 	edac->reg_base = reg_base;
 	edac->nintr = nintr;
 	spin_lock_init(&edac->ecc_lock);
@@ -534,15 +521,14 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, mci);
 
 	mci->pdev = dev;
-	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
-	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
-	mci->edac_cap = EDAC_FLAG_SECDED;
-	mci->scrub_cap = SCRUB_FLAG_HW_SRC;
-	mci->scrub_mode = dmc520_get_scrub_type(edac);
-	mci->ctl_name = EDAC_CTL_NAME;
-	mci->dev_name = dev_name(mci->pdev);
-	mci->mod_name = EDAC_MOD_NAME;
-	mci->ctl_page_to_phys = NULL;
+	mci->mtype_cap		= MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
+	mci->edac_ctl_cap	= EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
+	mci->edac_cap		= EDAC_FLAG_SECDED;
+	mci->scrub_cap		= SCRUB_FLAG_HW_SRC;
+	mci->scrub_mode		= dmc520_get_scrub_type(edac);
+	mci->ctl_name		= EDAC_CTL_NAME;
+	mci->dev_name		= dev_name(mci->pdev);
+	mci->mod_name		= EDAC_MOD_NAME;
 
 	edac_op_state = EDAC_OPSTATE_INT;
 
@@ -550,24 +536,24 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 
 	/* Clear interrupts, not affecting other unrelated interrupts */
 	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
-	dmc520_write_reg(edac, reg_val & (~(edac->interrupt_mask_all)),
+	dmc520_write_reg(edac, reg_val & (~(edac->irq_mask_all)),
 			 REG_OFFSET_INTERRUPT_CONTROL);
-	dmc520_write_reg(edac, edac->interrupt_mask_all,
+	dmc520_write_reg(edac, edac->irq_mask_all,
 			 REG_OFFSET_INTERRUPT_CLR);
 
-	for (intr_index = 0; intr_index < nintr; ++intr_index) {
-		int irq_id = platform_get_irq(pdev, intr_index);
+	for (idx = 0; idx < nintr; idx++) {
+		int irq_id = platform_get_irq(pdev, idx);
 
 		if (irq_id < 0) {
 			edac_printk(KERN_ERR, EDAC_MC,
-				    "Failed to get irq #%d\n", intr_index);
+				    "Failed to get irq #%d\n", idx);
 			ret = -ENODEV;
 			goto err;
 		}
 
 		ret = devm_request_irq(&pdev->dev, irq_id,
-				dmc520_isr_array[intr_index], IRQF_SHARED,
-				dev_name(&pdev->dev), mci);
+				       dmc520_isr_array[idx], IRQF_SHARED,
+				       dev_name(&pdev->dev), mci);
 		if (ret < 0) {
 			edac_printk(KERN_ERR, EDAC_MC,
 				    "Failed to request irq %d\n", irq_id);
@@ -578,14 +564,14 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	}
 
 	/* Reset DRAM CE/UE counters */
-	if (edac->interrupt_mask_all & DRAM_ECC_INT_CE_BIT)
+	if (edac->irq_mask_all & DRAM_ECC_INT_CE_BIT)
 		dmc520_get_dram_ecc_error_count(edac, true);
 
-	if (edac->interrupt_mask_all & DRAM_ECC_INT_UE_BIT)
+	if (edac->irq_mask_all & DRAM_ECC_INT_UE_BIT)
 		dmc520_get_dram_ecc_error_count(edac, false);
 
 	/* Enable interrupts, not affecting other unrelated interrupts */
-	dmc520_write_reg(edac, reg_val | edac->interrupt_mask_all,
+	dmc520_write_reg(edac, reg_val | edac->irq_mask_all,
 			 REG_OFFSET_INTERRUPT_CONTROL);
 
 	ret = edac_mc_add_mc(mci);
@@ -598,9 +584,8 @@ static int dmc520_edac_probe(struct platform_device *pdev)
 	return 0;
 
 err:
-	kfree(edac_local);
-	for (intr_index = 0; intr_index < nintr_registered; ++intr_index) {
-		int irq_id = platform_get_irq(pdev, intr_index);
+	for (idx = 0; idx < nintr_registered; idx++) {
+		int irq_id = platform_get_irq(pdev, idx);
 
 		devm_free_irq(&pdev->dev, irq_id, mci);
 	}
@@ -614,19 +599,19 @@ static int dmc520_edac_remove(struct platform_device *pdev)
 {
 	struct dmc520_edac *edac;
 	struct mem_ctl_info *mci;
-	u32 reg_val, intr_index;
+	u32 reg_val, idx;
 
 	mci = platform_get_drvdata(pdev);
 	edac = mci->pvt_info;
 
 	/* Disable interrupts */
 	reg_val = dmc520_read_reg(edac, REG_OFFSET_INTERRUPT_CONTROL);
-	dmc520_write_reg(edac, reg_val & (~(edac->interrupt_mask_all)),
-			REG_OFFSET_INTERRUPT_CONTROL);
+	dmc520_write_reg(edac, reg_val & (~(edac->irq_mask_all)),
+			 REG_OFFSET_INTERRUPT_CONTROL);
 
 	/* free irq's */
-	for (intr_index = 0; intr_index < edac->nintr; ++intr_index) {
-		int irq_id = platform_get_irq(pdev, intr_index);
+	for (idx = 0; idx < edac->nintr; idx++) {
+		int irq_id = platform_get_irq(pdev, idx);
 
 		devm_free_irq(&pdev->dev, irq_id, mci);
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B91638D52
	for <lists+linux-edac@lfdr.de>; Fri, 25 Nov 2022 16:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKYPNd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Nov 2022 10:13:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiKYPNF (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Nov 2022 10:13:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFEEDF86;
        Fri, 25 Nov 2022 07:12:35 -0800 (PST)
Received: from zn.tnic (p200300ea9733e784329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e784:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC6A21EC06C1;
        Fri, 25 Nov 2022 16:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1669389154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=rVEQyioX76e1Krz//vgbmskkjqTQxQLd+YY18bCkllE=;
        b=XmzofibNhRxqAPHf7dCJd+dJs1IfZJ+yktESA6lDCDI8m07n8hd3rx6NKfU3aNAVR7vrJw
        ixEj9t/xBPWCOS82/k8Z13E5w6bNmNBvBagawytTXssx4EeQBiV53xMLw1uyDUMz80qwP/
        /ioC0mcFyqnMyN6rOsxfNQ/FuLSYEKA=
Date:   Fri, 25 Nov 2022 16:12:29 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v6 2/2] EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP
 OCM
Message-ID: <Y4DbXaan258cZK+q@zn.tnic>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221102070655.247511-3-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Nov 02, 2022 at 12:36:55PM +0530, Sai Krishna Potthuri wrote:
> Add EDAC support for Xilinx ZynqMP OCM Controller,

So this:

> this driver reports CE and UE errors upon interrupt generation, and
> also creates UE/CE debugfs entries for error injection when EDAC_DEBUG
> config is enabled.

I can see in the patch itself.

Do not talk about what your patch does - that should hopefully be
visible from the diff. Rather, talk about *why* you're doing what you're
doing.

Like, for example, you can explain here how this driver is going to
co-exist with the other EDAC driver, i.e., the Synopsys one or the
DDRMC.

> Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

What exactly was reported by the robot?

Pls put that in the commit message as

"Fix issue <BLA> as reported by the robot."

so that it is clear what that Reported-by: refers to.

> ---
>  MAINTAINERS                    |   7 +
>  drivers/edac/Kconfig           |   9 +
>  drivers/edac/Makefile          |   1 +
>  drivers/edac/zynqmp_ocm_edac.c | 485 +++++++++++++++++++++++++++++++++
>  4 files changed, 502 insertions(+)
>  create mode 100644 drivers/edac/zynqmp_ocm_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index edc96cdb85e8..7a40caf536c2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21692,6 +21692,13 @@ F:	Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml
>  F:	drivers/dma/xilinx/xilinx_dpdma.c
>  F:	include/dt-bindings/dma/xlnx-zynqmp-dpdma.h
>  
> +XILINX ZYNQMP OCM EDAC DRIVER
> +M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
> +F:	drivers/edac/zynqmp_ocm_edac.c
> +
>  XILINX ZYNQMP PSGTR PHY DRIVER
>  M:	Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
>  M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 58ab63642e72..bc30b7d02062 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -539,4 +539,13 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_ZYNQMP_OCM
> +	tristate "Xilinx ZynqMP OCM Controller"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  This driver is targeted for Xilinx ZynqMP OCM (On Chip Memory)

"This driver supports ...."

> +	  controller to support for error detection and correction.
> +	  This driver can also be built as a module. If so, the module
> +	  will be called zynqmp_ocm_edac.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 2d1641a27a28..634c1cec1588 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
>  obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> +obj-$(CONFIG_EDAC_ZYNQMP_OCM)		+= zynqmp_ocm_edac.o

Is there going to be another ZynqMP EDAC driver?

If not, this one could be simply called zynqmp_edac.c or?

> diff --git a/drivers/edac/zynqmp_ocm_edac.c b/drivers/edac/zynqmp_ocm_edac.c
> new file mode 100644
> index 000000000000..32f025b72380
> --- /dev/null
> +++ b/drivers/edac/zynqmp_ocm_edac.c

> +/* Interrupt masks */
> +#define OCM_CEINTR_MASK		BIT(6)
> +#define OCM_UEINTR_MASK		BIT(7)
> +#define OCM_ECC_ENABLE_MASK	BIT(0)
> +#define OCM_CEUE_MASK		GENMASK(7, 6)

Drop that one and use

	OCM_CEINTR_MASK | OCM_UEINTR_MASK

everywhere.

> +#define OCM_FICOUNT_MASK	GENMASK(23, 0)
> +#define OCM_NUM_UE_BITPOS	2
> +#define OCM_BASEVAL		0xFFFC0000
> +#define EDAC_DEVICE		"ZynqMP-OCM"
> +
> +/**
> + * struct ecc_error_info - ECC error log information
> + * @addr:	Fault generated at this address
> + * @data0:	Generated fault data (lower 32-bit)
> + * @data1:	Generated fault data (upper 32-bit)
> + */
> +struct ecc_error_info {
> +	u32 addr;
> +	u32 data0;
> +	u32 data1;

What's wrong with calling those fault_lo and fault_hi then?

> +/**
> + * get_error_info - Get the current ECC error info
> + * @base:	Pointer to the base address of the OCM memory controller
> + * @p:		Pointer to the OCM ECC status structure
> + * @mask:	Status register mask value
> + *
> + * Determines there is any ECC error or not
> + *
> + */
> +static void get_error_info(void __iomem *base, struct ecc_status *p, int mask)
> +{
> +	if (mask & OCM_CEINTR_MASK) {
> +		p->ce_cnt++;
> +		p->ceinfo.data0 = readl(base + CE_FFD0_OFST);
> +		p->ceinfo.data1 = readl(base + CE_FFD1_OFST);
> +		p->ceinfo.addr = (OCM_BASEVAL | readl(base + CE_FFA_OFST));
> +		writel(ECC_CTRL_CLR_CE_ERR, base + OCM_ISR_OFST);
> +	} else {

I guess you need to check OCM_UEINTR_MASK here?

> +		p->ue_cnt++;
> +		p->ueinfo.data0 = readl(base + UE_FFD0_OFST);
> +		p->ueinfo.data1 = readl(base + UE_FFD1_OFST);
> +		p->ueinfo.addr = (OCM_BASEVAL | readl(base + UE_FFA_OFST));
> +		writel(ECC_CTRL_CLR_UE_ERR, base + OCM_ISR_OFST);
> +	}

No, I didn't mean for you to drop that block. See comment in
intr_handler() below.

> +/**
> + * handle_error - Handle controller error types CE and UE
> + * @dci:	Pointer to the EDAC device controller instance
> + * @p:		Pointer to the OCM ECC status structure
> + *
> + * Handles the controller ECC correctable and uncorrectable error.

s/controller// - we know it is the controller. You probably should go
through all text in here and tone down all the "controller" mentions.

> + */
> +static void handle_error(struct edac_device_ctl_info *dci, struct ecc_status *p)
> +{
> +	struct edac_priv *priv = dci->pvt_info;
> +	struct ecc_error_info *pinf;
> +
> +	if (p->ce_cnt) {
> +		pinf = &p->ceinfo;
> +		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
> +			 "\nOCM ECC error type :%s\nAddr: [0x%x]\nFault Data[0x%08x%08x]",
> +			 "CE", pinf->addr, pinf->data1, pinf->data0);
> +		edac_device_handle_ce(dci, 0, 0, priv->message);
> +	}
> +
> +	if (p->ue_cnt) {
> +		pinf = &p->ueinfo;
> +		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
> +			 "\nOCM ECC error type :%s\nAddr: [0x%x]\nFault Data[0x%08x%08x]",
> +			 "UE", pinf->addr, pinf->data1, pinf->data0);
> +		edac_device_handle_ue(dci, 0, 0, priv->message);
> +	}
> +
> +	memset(p, 0, sizeof(*p));
> +}
> +
> +/**
> + * intr_handler - ISR routine
> + * @irq:        irq number
> + * @dev_id:     device id pointer
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
> + */
> +static irqreturn_t intr_handler(int irq, void *dev_id)
> +{
> +	struct edac_device_ctl_info *dci = dev_id;
> +	struct edac_priv *priv = dci->pvt_info;
> +	int regval;
> +
> +	regval = readl(priv->baseaddr + OCM_ISR_OFST);
> +	if (!(regval & OCM_CEUE_MASK))
> +		return IRQ_NONE;

What is that check for?

If neither of the masks are set but the device still raises an error
interrupt, then you need to WARN_ONCE() here so that people look at this
and debug it as to why it still raised an interrupt.

> +	get_error_info(priv->baseaddr, &priv->stat, regval);
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	handle_error(dci, &priv->stat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * get_eccstate - Return the controller ECC status
> + * @base:	Pointer to the OCM memory controller base address
> + *
> + * Get the ECC enable/disable status for the controller
> + *
> + * Return: ECC status 0/1.
> + */
> +static bool get_eccstate(void __iomem *base)
> +{
> +	return readl(base + ECC_CTRL_OFST) & OCM_ECC_ENABLE_MASK;
> +}
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +/**
> + * inject_fault_count - write fault injection count
> + * @priv:	Pointer to the EDAC private struct
> + *
> + * Update the fault injection count register, once the counter reaches
> + * zero, it injects errors
> + */
> +static void inject_fault_count(struct edac_priv *priv)
> +{
> +	u32 ficount = priv->fault_injection_cnt;
> +
> +	ficount &= OCM_FICOUNT_MASK;
> +	if (ficount != priv->fault_injection_cnt)

Do this:

	if (ficount & ~OCM_FICOUNT_MASK) {
		ficount &= OCM_FICOUNT_MASK;
		edac_printk(KERN_INFO, EDAC_DEVICE, "Fault injection count value truncated to: %d\n", ficount);
	}

i.e., mask it *only* when it is larger.

> +
> +	writel(ficount, priv->baseaddr + OCM_FIC_OFST);
> +}
> +
> +/**
> + * inject_cebitpos - Set CE bit position
> + * @priv:	Pointer to the EDAC private struct
> + *
> + * Set any one bit to inject CE error
> + */
> +static void inject_cebitpos(struct edac_priv *priv)
> +{
> +	if (priv->ce_bitpos <= UE_MAX_BITPOS_LOWER) {
> +		writel(BIT(priv->ce_bitpos), priv->baseaddr + OCM_FID0_OFST);
> +		writel(0, priv->baseaddr + OCM_FID1_OFST);
> +	} else {
> +		writel(BIT(priv->ce_bitpos - UE_MIN_BITPOS_UPPER),
> +		       priv->baseaddr + OCM_FID1_OFST);
> +		writel(0, priv->baseaddr + OCM_FID0_OFST);

I had to stare at this a bit to figure out what you're doing: the
injection registers are two 32-bit quantities and depending on where you
inject, you need to select into which offset to write it.

But looking more at this, all the proper range checks should happen in
the debugfs callbacks, i.e., inject_ce_write() in this case.

The actual injection function should only inject - that's it.

And come to think of it, you don't need inject_cebitpos() or
inject_uebitpos().

Your debugfs callbacks should:

1. check the range, error out and print a warning if range wrong
2. inject otherwise.

and that's it.

...

> +static ssize_t inject_ue_write(struct file *file, const char __user *data,
> +			       size_t count, loff_t *ppos)
> +{
> +	struct edac_device_ctl_info *edac_dev = file->private_data;
> +	struct edac_priv *priv = edac_dev->pvt_info;
> +	char buf[6];
> +	u8 pos0, pos1, len;
> +	int ret;

The EDAC tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

You're pretty much doing it but some functions' local vars still need
re-sorting.

> +
> +	if (!data)
> +		return -EFAULT;
> +
> +	len = min_t(size_t, count, sizeof(buf));
> +	if (copy_from_user(buf, data, len))
> +		return -EFAULT;
> +
> +	for (pos0 = 0; buf[pos0] != ' ' && pos0 <= len; pos0++)
> +		;
> +
> +	if (pos0 > len)
> +		return -EINVAL;
> +
> +	ret = kstrtou8_from_user(data, pos0, 0, &priv->ue_bitpos[0]);
> +	if (ret)
> +		return ret;
> +
> +	for (pos1 = pos0 + 1; buf[pos1] != '\n' && pos1 <= len; pos1++)
> +		;
> +
> +	if (pos1 > count)
> +		return -EINVAL;
> +
> +	ret = kstrtou8_from_user(&data[pos0 + 1], pos1 - pos0 - 1, 0,
> +				 &priv->ue_bitpos[1]);

This looks like it is composing multiple values. I guess the two bits
for an UE since UE is a two-bit error.

No documentation?

IOW, you need to document how this injection works. In a comment here
somewhere, pls explain what the user is supposed to do when she wants to
inject errors.

Example:

Documentation/firmware-guide/acpi/apei/einj.rst

You don't have to do a separate file and go too much into detail but at
least a simple injection recipe/example would be prudent to have.

> +static int edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_priv *priv;
> +	struct edac_device_ctl_info *dci;
> +	void __iomem *baseaddr;
> +	struct resource *res;
> +	int irq, ret;
> +
> +	baseaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(baseaddr))
> +		return PTR_ERR(baseaddr);
> +
> +	if (!get_eccstate(baseaddr)) {
> +		edac_printk(KERN_INFO, EDAC_DEVICE,
> +			    "ECC not enabled\n");

No need to break that line.

> +		return -ENXIO;
> +	}
> +
> +	dci = edac_device_alloc_ctl_info(sizeof(*priv), ZYNQMP_OCM_EDAC_STRING,
> +					 1, ZYNQMP_OCM_EDAC_STRING, 1, 0, NULL, 0,
> +					 edac_device_alloc_index());
> +	if (!dci)
> +		return -ENOMEM;
> +
> +	priv = dci->pvt_info;
> +	platform_set_drvdata(pdev, dci);
> +	dci->dev = &pdev->dev;
> +	priv->baseaddr = baseaddr;
> +	dci->mod_name = pdev->dev.driver->name;
> +	dci->ctl_name = ZYNQMP_OCM_EDAC_STRING;
> +	dci->dev_name = dev_name(&pdev->dev);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		ret = irq;
> +		goto free_dev_ctl;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, intr_handler, 0,
> +			       dev_name(&pdev->dev), dci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE, "Failed to request Irq\n");
> +		goto free_dev_ctl;
> +	}
> +
> +	/* Enable UE, CE interrupts */
> +	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IEN_OFST);
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +	setup_debugfs(dci);
> +#endif

Do this instead:

diff --git a/drivers/edac/zynqmp_ocm_edac.c b/drivers/edac/zynqmp_ocm_edac.c
index 32f025b72380..a2b8cf1eb986 100644
--- a/drivers/edac/zynqmp_ocm_edac.c
+++ b/drivers/edac/zynqmp_ocm_edac.c
@@ -428,9 +428,8 @@ static int edac_probe(struct platform_device *pdev)
 	/* Enable UE, CE interrupts */
 	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IEN_OFST);
 
-#ifdef CONFIG_EDAC_DEBUG
-	setup_debugfs(dci);
-#endif
+	if (IS_ENABLED(CONFIG_EDAC_DEBUG))
+		setup_debugfs(dci);
 
 	ret = edac_device_add_device(dci);
 	if (ret)

below too.

> +
> +	ret = edac_device_add_device(dci);
> +	if (ret)
> +		goto free_dev_ctl;
> +
> +	return 0;
> +
> +free_dev_ctl:
> +	edac_device_free_ctl_info(dci);
> +
> +	return ret;
> +}
> +
> +static int edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *dci = platform_get_drvdata(pdev);
> +	struct edac_priv *priv = dci->pvt_info;
> +
> +	/* Disable UE, CE interrupts */
> +	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IDS_OFST);
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +	debugfs_remove_recursive(priv->debugfs_dir);
> +#endif
> +
> +	edac_device_del_device(&pdev->dev);
> +	edac_device_free_ctl_info(dci);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id zynqmp_ocm_edac_match[] = {
> +	{ .compatible = "xlnx,zynqmp-ocmc-1.0"},
> +	{ /* end of table */ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, zynqmp_ocm_edac_match);
> +
> +static struct platform_driver zynqmp_ocm_edac_driver = {
> +	.driver = {
> +		   .name = "zynqmp-ocm-edac",
> +		   .of_match_table = zynqmp_ocm_edac_match,
> +		   },
> +	.probe = edac_probe,
> +	.remove = edac_remove,
> +};
> +
> +module_platform_driver(zynqmp_ocm_edac_driver);
> +
> +MODULE_AUTHOR("Advanced Micro Devices, Inc");
> +MODULE_DESCRIPTION("Xilinx ZynqMP OCM ECC driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

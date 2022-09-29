Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F9A5EF998
	for <lists+linux-edac@lfdr.de>; Thu, 29 Sep 2022 17:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235924AbiI2P4L (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 29 Sep 2022 11:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235197AbiI2P4J (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 29 Sep 2022 11:56:09 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6285C11E952;
        Thu, 29 Sep 2022 08:56:06 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e75e329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e75e:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A72891EC068B;
        Thu, 29 Sep 2022 17:56:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1664466960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XUNkkkaowOXYcdw6T5tpIHL8eJPeyLNR/8BrxrdaX1w=;
        b=iY11XLOCWe67jg7H8KNUrYVfpaT8X5O1hFykmYt+JVcP+F5BXQV3Xw99Tnev7jCk4PPPFy
        DGIIxvqO29jpM3RzZIDisoKXrehiNGUAUEFCLwBYkzAxyfaWaEqke4IGpfwNMQe8KqEGmx
        3b4oam45ZtFV3OaeoHaojkhJzvEjsFo=
Date:   Thu, 29 Sep 2022 17:55:56 +0200
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
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Subject: Re: [PATCH v5 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM
Message-ID: <YzXADLZHEd1xF1LX@zn.tnic>
References: <20220909060548.24694-1-sai.krishna.potthuri@amd.com>
 <20220909060548.24694-3-sai.krishna.potthuri@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220909060548.24694-3-sai.krishna.potthuri@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Sep 09, 2022 at 11:35:48AM +0530, Sai Krishna Potthuri wrote:
> Subject: Re: [PATCH v5 2/2] edac: zynqmp_ocm: Add EDAC support for ZynqMP OCM

"EDAC/zynqmp: Add ..."

> Add EDAC support for Xilinx ZynqMP OCM Controller, this driver
> reports CE and UE errors based on the interrupts,

Based on the interrupts? Do you mean, it raises an interrupt in order to
report errors vs polling?

> and also creates ue/ce

s/ue/UE/g
s/ce/CE/g

> sysfs entries for error injection.

All the injection logic needs to be behind CONFIG_EDAC_DEBUG. You don't
want to have injection functionality present in production.

> Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  MAINTAINERS                    |   7 +
>  drivers/edac/Kconfig           |   9 +
>  drivers/edac/Makefile          |   1 +
>  drivers/edac/zynqmp_ocm_edac.c | 622 +++++++++++++++++++++++++++++++++
>  4 files changed, 639 insertions(+)
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
> diff --git a/drivers/edac/zynqmp_ocm_edac.c b/drivers/edac/zynqmp_ocm_edac.c
> new file mode 100644
> index 000000000000..a8da94f3e067
> --- /dev/null
> +++ b/drivers/edac/zynqmp_ocm_edac.c
> @@ -0,0 +1,622 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx ZynqMP OCM ECC Driver
> + *
> + * Copyright (C) 2022 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_module.h"
> +
> +#define ZYNQMP_OCM_EDAC_MSG_SIZE	256
> +
> +#define ZYNQMP_OCM_EDAC_STRING	"zynqmp_ocm"
> +
> +/* Controller registers */
> +#define CTRL_OFST			0x0
> +#define OCM_ISR_OFST		0x04
> +#define OCM_IMR_OFST		0x08
> +#define OCM_IEN_OFST		0x0C
> +#define OCM_IDS_OFST		0x10
> +
> +/* ECC control register */
> +#define ECC_CTRL_OFST		0x14
> +
> +/* Correctable error info registers */
> +#define CE_FFA_OFST			0x1C
> +#define CE_FFD0_OFST		0x20
> +#define CE_FFD1_OFST		0x24
> +#define CE_FFD2_OFST		0x28
> +#define CE_FFD3_OFST		0x2C
> +#define CE_FFE_OFST			0x30
> +
> +/* Uncorrectable error info registers */
> +#define UE_FFA_OFST			0x34
> +#define UE_FFD0_OFST		0x38
> +#define UE_FFD1_OFST		0x3C
> +#define UE_FFD2_OFST		0x40
> +#define UE_FFD3_OFST		0x44
> +#define UE_FFE_OFST			0x48
> +
> +/* ECC control register bit field definitions */
> +#define ECC_CTRL_CLR_CE_ERR	0x40
> +#define ECC_CTRL_CLR_UE_ERR	0x80
> +
> +/* Fault injection data and count registers */
> +#define OCM_FID0_OFST		0x4C
> +#define OCM_FID1_OFST		0x50
> +#define OCM_FID2_OFST		0x54
> +#define OCM_FID3_OFST		0x58
> +#define OCM_FIC_OFST		0x74
> +
> +#define UE_MAX_BITPOS_LOWER	31
> +#define UE_MIN_BITPOS_UPPER	32
> +#define UE_MAX_BITPOS_UPPER	63
> +
> +/* Interrupt masks */
> +#define OCM_CEINTR_MASK		BIT(6)
> +#define OCM_UEINTR_MASK		BIT(7)
> +#define OCM_ECC_ENABLE_MASK	BIT(0)
> +#define OCM_CEUE_MASK		GENMASK(7, 6)
> +
> +#define OCM_FICOUNT_MASK	GENMASK(23, 0)
> +#define OCM_BASEVAL			0xFFFC0000
> +#define EDAC_DEVICE			"ZynqMP-OCM"

Align those vertically properly.

> +
> +/**
> + * struct ecc_error_info - ECC error log information
> + * @addr:	Fault generated at this address
> + * @data0:	Generated fault data
> + * @data1:	Generated fault data

What's the difference?

> + */
> +struct ecc_error_info {
> +	u32 addr;
> +	u32 data0;
> +	u32 data1;
> +};
> +
> +/**
> + * struct zynqmp_ocm_ecc_status - ECC status information to report
> + * @ce_cnt:	Correctable error count
> + * @ue_cnt:	Uncorrectable error count
> + * @ceinfo:	Correctable error log information
> + * @ueinfo:	Uncorrectable error log information
> + */
> +struct zynqmp_ocm_ecc_status {
> +	u32 ce_cnt;
> +	u32 ue_cnt;
> +	struct ecc_error_info ceinfo;
> +	struct ecc_error_info ueinfo;
> +};
> +
> +/**
> + * struct zynqmp_ocm_edac_priv - DDR memory controller private instance data
> + * @baseaddr:	Base address of the DDR controller
> + * @message:	Buffer for framing the event specific info
> + * @stat:	ECC status information
> + * @p_data:	Pointer to platform data
> + * @ce_cnt:	Correctable Error count
> + * @ue_cnt:	Uncorrectable Error count
> + * @ce_bitpos:	Bit position for Correctable Error
> + * @ue_bitpos0:	First bit position for Uncorrectable Error
> + * @ue_bitpos1:	Second bit position for Uncorrectable Error
> + */
> +struct zynqmp_ocm_edac_priv {

Why do those structs have a "zynqmp_ocm_" prefix if they're going to be
used only in this driver?

> +	void __iomem *baseaddr;
> +	char message[ZYNQMP_OCM_EDAC_MSG_SIZE];
> +	struct zynqmp_ocm_ecc_status stat;
> +	const struct zynqmp_ocm_platform_data *p_data;
> +	u32 ce_cnt;
> +	u32 ue_cnt;
> +	u8 ce_bitpos;
> +	u8 ue_bitpos0;
> +	u8 ue_bitpos1;
> +};
> +
> +/**
> + * zynqmp_ocm_edac_geterror_info - Get the current ecc error info

s/ecc/ECC/g

> + * @base:	Pointer to the base address of the ddr memory controller

s/ddr/DDR/g

> + * @p:		Pointer to the ocm ecc status structure
> + * @mask:	Status register mask value
> + *
> + * Determines there is any ecc error or not
> + *
> + */
> +static void zynqmp_ocm_edac_geterror_info(void __iomem *base,
> +					  struct zynqmp_ocm_ecc_status *p, int mask)

Drop the "zynqmp_ocm_edac_" prefix from all static functions. That's
just useless naming. And it is a lot more readable this way:

static void get_error_info(void __iomem *base, struct ecc_status *p, int mask)
{
	...

nice and simple.

> +{
> +	if (mask & OCM_CEINTR_MASK) {
> +		p->ce_cnt++;
> +		p->ceinfo.data0 = readl(base + CE_FFD0_OFST);
> +		p->ceinfo.data1 = readl(base + CE_FFD1_OFST);
> +		p->ceinfo.addr = (OCM_BASEVAL | readl(base + CE_FFA_OFST));
> +		writel(ECC_CTRL_CLR_CE_ERR, base + OCM_ISR_OFST);
> +	} else if (mask & OCM_UEINTR_MASK) {
> +		p->ue_cnt++;
> +		p->ueinfo.data0 = readl(base + UE_FFD0_OFST);
> +		p->ueinfo.data1 = readl(base + UE_FFD1_OFST);
> +		p->ueinfo.addr = (OCM_BASEVAL | readl(base + UE_FFA_OFST));
> +		writel(ECC_CTRL_CLR_UE_ERR, base + OCM_ISR_OFST);
> +	}

	else {
		WARN_ON_ONCE(...);
	}

or does the hardware always give a correct mask?

:)

> +}
> +
> +/**
> + * zynqmp_ocm_edac_handle_error - Handle controller error types CE and UE
> + * @dci:	Pointer to the edac device controller instance
> + * @p:		Pointer to the ocm ecc status structure
> + *
> + * Handles the controller ECC correctable and uncorrectable error.
> + */
> +static void zynqmp_ocm_edac_handle_error(struct edac_device_ctl_info *dci,
> +					 struct zynqmp_ocm_ecc_status *p)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +	struct ecc_error_info *pinf;
> +
> +	if (p->ce_cnt) {
> +		pinf = &p->ceinfo;
> +		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
> +			 "\nOCM ECC error type :%s\n"
> +			 "Addr: [0x%X]\nFault Data[31:0]: [0x%X]\n"
> +			 "Fault Data[63:32]: [0x%X]",

Do not break the strings in lines for easier grepping. IOW:

			"OCM ECC error type :%s Addr: [0x%X] Fault Data[31:0]: [0x%X] Fault Data[63:32]: [0x%X]\n"

And you can do:

		"... Fault Data[0x%08x%08x]\n",
		pinf->data1, pinf->data0);

and dump the whole 64-bit value.

> +			 "CE", pinf->addr, pinf->data0, pinf->data1);
> +		edac_device_handle_ce(dci, 0, 0, priv->message);
> +	}
> +
> +	if (p->ue_cnt) {
> +		pinf = &p->ueinfo;
> +		snprintf(priv->message, ZYNQMP_OCM_EDAC_MSG_SIZE,
> +			 "\nOCM ECC error type :%s\n"
> +			 "Addr: [0x%X]\nFault Data[31:0]: [0x%X]\n"
> +			 "Fault Data[63:32]: [0x%X]",
> +			 "UE", pinf->addr, pinf->data0, pinf->data1);

Ditto.

> +		edac_device_handle_ue(dci, 0, 0, priv->message);
> +	}
> +
> +	memset(p, 0, sizeof(*p));
> +}
> +
> +/**
> + * zynqmp_ocm_edac_intr_handler - isr routine

s/isr/ISR/

> + * @irq:        irq number
> + * @dev_id:     device id pointer
> + *
> + * This is the ISR routine called by edac core interrupt thread.

This is simply not true.

Also,

s/edac/EDAC/g

You get the idea - all acronyms in all-caps.

> + * Used to check and post ECC errors.
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise
> + */
> +static irqreturn_t zynqmp_ocm_edac_intr_handler(int irq, void *dev_id)
> +{
> +	struct edac_device_ctl_info *dci = dev_id;
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +	int regval;
> +
> +	regval = readl(priv->baseaddr + OCM_ISR_OFST);
> +	if (!(regval & OCM_CEUE_MASK))
> +		return IRQ_NONE;
> +
> +	zynqmp_ocm_edac_geterror_info(priv->baseaddr,
> +				      &priv->stat, regval);

No need to break that line.

> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	zynqmp_ocm_edac_handle_error(dci, &priv->stat);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * zynqmp_ocm_edac_get_eccstate - Return the controller ecc status
> + * @base:	Pointer to the ddr memory controller base address
> + *
> + * Get the ECC enable/disable status for the controller
> + *
> + * Return: ecc status 0/1.
> + */
> +static bool zynqmp_ocm_edac_get_eccstate(void __iomem *base)
> +{
> +	return readl(base + ECC_CTRL_OFST) & OCM_ECC_ENABLE_MASK;
> +}

As already mentioned

#ifdef CONFIG_EDAC_DEBUG

...

> +
> +/**
> + * zynqmp_ocm_edac_inject_fault_count_show - Shows fault injection count
> + * @dci:        Pointer to the edac device struct
> + * @data:       Pointer to user data
> + *
> + * Shows the fault injection count, once the counter reaches
> + * zero, it injects errors
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_fault_count_show(struct edac_device_ctl_info *dci,
> +						       char *data)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	return sprintf(data, "FIC: 0x%x\n",

"FIC"?

Maybe make it human readable:

"Fault injection count: "

> +			readl(priv->baseaddr + OCM_FIC_OFST));
> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_fault_count_store - write fi count
> + * @dci:	Pointer to the edac device struct
> + * @data:	Pointer to user data
> + * @count:	read the size bytes from buffer
> + *
> + * Update the fault injection count register, once the counter reaches
> + * zero, it injects errors

How does the counter reach zero?

I guess I'm unclear on how this is supposed to be used: you write some
fault injection count value and what happens then?

> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_fault_count_store(struct edac_device_ctl_info *dci,
> +							const char *data, size_t count)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +	u32 ficount;
> +
> +	if (!data)
> +		return -EFAULT;
> +
> +	if (kstrtouint(data, 0, &ficount))
> +		return -EINVAL;
> +
> +	ficount &= OCM_FICOUNT_MASK;

Perhaps issue a printk to say that the user value is truncated if the &
is not 0.

> +	writel(ficount, priv->baseaddr + OCM_FIC_OFST);
> +
> +	return count;
> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_cebitpos_show - Shows CE bit position
> + * @dci:        Pointer to the edac device struct
> + * @data:       Pointer to user data
> + *
> + * Shows the Correctable error bit position,
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_cebitpos_show(struct edac_device_ctl_info
> +							*dci, char *data)

Align arguments on the opening brace.

> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	if (priv->ce_bitpos <= UE_MAX_BITPOS_LOWER)
> +		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",

So this is not really intuitive: how does "Fault Injection Data Reg"
mean the CE bit position?

> +			((readl(priv->baseaddr + OCM_FID0_OFST))));
> +
> +	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
> +			((readl(priv->baseaddr + OCM_FID1_OFST))));

What's in FID1 then?

> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_cebitpos_store - Set CE bit position
> + * @dci:	Pointer to the edac device struct
> + * @data:	Pointer to user data
> + * @count:	read the size bytes from buffer
> + *
> + * Set any one bit to inject CE error
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_cebitpos_store(struct edac_device_ctl_info *dci,
> +						     const char *data, size_t count)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	if (!data)
> +		return -EFAULT;
> +
> +	if (kstrtou8(data, 0, &priv->ce_bitpos))
> +		return -EINVAL;
> +
> +	if (priv->ce_bitpos <= UE_MAX_BITPOS_LOWER) {
> +		writel(1 << priv->ce_bitpos, priv->baseaddr + OCM_FID0_OFST);

BIT(priv->ce_bitpos)

and so on.

> +		writel(0, priv->baseaddr + OCM_FID1_OFST);
> +	} else if (priv->ce_bitpos <= UE_MAX_BITPOS_UPPER) {
> +		writel(1 << (priv->ce_bitpos - UE_MIN_BITPOS_UPPER),
> +		       priv->baseaddr + OCM_FID1_OFST);
> +		writel(0, priv->baseaddr + OCM_FID0_OFST);
> +	} else {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Bit number > 64 is not valid\n");

					>=

and you can do that checking above, after the kstrtou8() where you don't
return count but an error code.

> +	}
> +
> +	return count;
> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_uebitpos0_show - Shows UE bit postion0
> + * @dci:        Pointer to the edac device struct
> + * @data:       Pointer to user data
> + *
> + * Shows the one of bit position for UE error
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_uebitpos0_show(struct edac_device_ctl_info *dci,
> +						     char *data)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER)
> +		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
> +			((readl(priv->baseaddr + OCM_FID0_OFST))));
> +
> +	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
> +			((readl(priv->baseaddr + OCM_FID1_OFST))));
> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_uebitpos0_store - set UE bit position0
> + * @dci:	Pointer to the edac device struct
> + * @data:	Pointer to user data
> + * @count:	read the size bytes from buffer
> + *
> + * Set the first bit position for UE Error generation,we need to configure
> + * any two bit positions to inject UE Error
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_uebitpos0_store(struct edac_device_ctl_info *dci,
> +						      const char *data, size_t count)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	if (!data)
> +		return -EFAULT;
> +
> +	if (kstrtou8(data, 0, &priv->ue_bitpos0))
> +		return -EINVAL;
> +
> +	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER)
> +		writel(1 << priv->ue_bitpos0, priv->baseaddr + OCM_FID0_OFST);
> +	else if (priv->ue_bitpos0 <= UE_MAX_BITPOS_UPPER)
> +		writel(1 << (priv->ue_bitpos0 - UE_MIN_BITPOS_UPPER),
> +		       priv->baseaddr + OCM_FID1_OFST);
> +	else
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Bit position > 64 is not valid\n");
> +	edac_printk(KERN_INFO, EDAC_DEVICE,
> +		    "Set another bit position for UE\n");
> +
> +	return count;
> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_uebitpos1_show - Shows UE bit postion1
> + * @dci:        Pointer to the edac device struct
> + * @data:       Pointer to user data
> + *
> + * Shows the second bit position configured for UE error
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_uebitpos1_show(struct edac_device_ctl_info *dci,
> +						     char *data)
> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +
> +	if (priv->ue_bitpos1 <= UE_MAX_BITPOS_LOWER)
> +		return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
> +			((readl(priv->baseaddr + OCM_FID0_OFST))));
> +
> +	return sprintf(data, "Fault Injection Data Reg: [0x%x]\n",
> +			((readl(priv->baseaddr + OCM_FID1_OFST))));
> +}
> +
> +/**
> + * zynqmp_ocm_edac_inject_uebitpos1_store - Set UE second bit position
> + * @dci:	Pointer to the edac device struct
> + * @data:	Pointer to user data
> + * @count:	read the size bytes from buffer
> + *
> + * Set the second bit position for UE Error generation,we need to configure
> + * any two bit positions to inject UE Error
> + * Return: Number of bytes copied on success else error code.
> + */
> +static ssize_t zynqmp_ocm_edac_inject_uebitpos1_store(struct edac_device_ctl_info *dci,
> +						      const char *data, size_t count)

This is clumsy: you wanna have this

echo <uebitpos0>,<uebitpos1> > /sys/kernel/debug/...

and then a *single* function parses those, picks them apart and programs
the hardware.

Not two pretty much independent functions.

> +{
> +	struct zynqmp_ocm_edac_priv *priv = dci->pvt_info;
> +	u32 mask;
> +
> +	if (!data)
> +		return -EFAULT;
> +
> +	if (kstrtou8(data, 0, &priv->ue_bitpos1))
> +		return -EINVAL;
> +
> +	if (priv->ue_bitpos0 == priv->ue_bitpos1) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Bit positions should not be equal\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * If both bit positions are referring to 32 bit data, then configure
> +	 * only FID0 register or if it is 64 bit data, then configure only
> +	 * FID1 register.
> +	 */
> +	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER &&
> +	    priv->ue_bitpos1 <= UE_MAX_BITPOS_LOWER) {
> +		mask = (1 << priv->ue_bitpos0);
> +		mask |= (1 << priv->ue_bitpos1);
> +		writel(mask, priv->baseaddr + OCM_FID0_OFST);
> +		writel(0, priv->baseaddr + OCM_FID1_OFST);
> +	} else if ((priv->ue_bitpos0 >= UE_MIN_BITPOS_UPPER &&
> +		    priv->ue_bitpos0 <= UE_MAX_BITPOS_UPPER) &&
> +		   (priv->ue_bitpos1 >= UE_MIN_BITPOS_UPPER &&
> +		    priv->ue_bitpos1 <= UE_MAX_BITPOS_UPPER)) {
> +		mask = (1 << (priv->ue_bitpos0 - UE_MIN_BITPOS_UPPER));
> +		mask |= (1 << (priv->ue_bitpos1 - UE_MIN_BITPOS_UPPER));
> +		writel(mask, priv->baseaddr + OCM_FID1_OFST);
> +		writel(0, priv->baseaddr + OCM_FID0_OFST);
> +	}
> +
> +	/*
> +	 * If one bit position is referring a bit in 32 bit data and other in
> +	 * 64 bit data, just configure FID0/FID1 based on uebitpos1.
> +	 */
> +	if (priv->ue_bitpos0 <= UE_MAX_BITPOS_LOWER &&
> +	    (priv->ue_bitpos1 >= UE_MIN_BITPOS_UPPER &&
> +	     priv->ue_bitpos1 <= UE_MAX_BITPOS_UPPER)) {
> +		writel(1 << (priv->ue_bitpos1 - UE_MIN_BITPOS_UPPER),
> +		       priv->baseaddr + OCM_FID1_OFST);
> +	} else if ((priv->ue_bitpos0 >= UE_MIN_BITPOS_UPPER &&
> +		    priv->ue_bitpos0 <= UE_MAX_BITPOS_UPPER) &&
> +		   (priv->ue_bitpos1 <= UE_MAX_BITPOS_LOWER)) {
> +		writel(1 << priv->ue_bitpos1,
> +		       priv->baseaddr + OCM_FID0_OFST);
> +	} else {
> +		edac_printk(KERN_ERR, EDAC_DEVICE,
> +			    "Bit position > 64 is not valid, Valid bits:[63:0]\n");
> +	}
> +
> +	edac_printk(KERN_INFO, EDAC_DEVICE,
> +		    "UE at Bit Position0: %d Bit Position1: %d\n",
> +		    priv->ue_bitpos0, priv->ue_bitpos1);
> +
> +	return count;
> +}
> +
> +static struct edac_dev_sysfs_attribute zynqmp_ocm_edac_sysfs_attributes[] = {

debugfs ofc - not sysfs.

> +	{
> +		.attr = {
> +			.name = "inject_cebitpos",
> +			.mode = (0644)
> +		},
> +		.show = zynqmp_ocm_edac_inject_cebitpos_show,
> +		.store = zynqmp_ocm_edac_inject_cebitpos_store},
> +	{
> +		.attr = {
> +			.name = "inject_uebitpos0",
> +			.mode = (0644)
> +		},
> +		.show = zynqmp_ocm_edac_inject_uebitpos0_show,
> +		.store = zynqmp_ocm_edac_inject_uebitpos0_store},
> +	{
> +		.attr = {
> +			.name = "inject_uebitpos1",
> +			.mode = (0644)
> +		},
> +		.show = zynqmp_ocm_edac_inject_uebitpos1_show,
> +		.store = zynqmp_ocm_edac_inject_uebitpos1_store},
> +	{
> +		.attr = {
> +			.name = "inject_fault_count",
> +			.mode = (0644)
> +		},
> +		.show = zynqmp_ocm_edac_inject_fault_count_show,
> +		.store = zynqmp_ocm_edac_inject_fault_count_store},
> +	/* End of list */
> +	{
> +		.attr = {.name = NULL}
> +	}
> +};
> +
> +/**
> + * zynqmp_set_ocm_edac_sysfs_attributes - create sysfs attributes
> + * @edac_dev:	Pointer to the edac device struct
> + *
> + * Creates sysfs entries for error injection
> + */
> +static void zynqmp_set_ocm_edac_sysfs_attributes(struct edac_device_ctl_info
> +						*edac_dev)
> +{
> +	edac_dev->sysfs_attributes = zynqmp_ocm_edac_sysfs_attributes;
> +}
> +
> +static int zynqmp_ocm_edac_probe(struct platform_device *pdev)
> +{
> +	struct zynqmp_ocm_edac_priv *priv;
> +	struct edac_device_ctl_info *dci;
> +	void __iomem *baseaddr;
> +	struct resource *res;
> +	int irq, ret;
> +
> +	baseaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(baseaddr))
> +		return PTR_ERR(baseaddr);
> +
> +	if (!zynqmp_ocm_edac_get_eccstate(baseaddr)) {
> +		edac_printk(KERN_INFO, EDAC_DEVICE,
> +			    "ECC not enabled\n");
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
> +	ret = devm_request_irq(&pdev->dev, irq,
> +			       zynqmp_ocm_edac_intr_handler,
> +			       0, dev_name(&pdev->dev), dci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, EDAC_DEVICE, "Failed to request Irq\n");
> +		goto free_dev_ctl;
> +	}
> +
> +	writel(OCM_CEUE_MASK, priv->baseaddr + OCM_IEN_OFST);

Now that wants to be a separate function or at least have a comment
above it about what it does.

> +
> +	zynqmp_set_ocm_edac_sysfs_attributes(dci);

<-- newline

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

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

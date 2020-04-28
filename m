Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9B91BBC92
	for <lists+linux-edac@lfdr.de>; Tue, 28 Apr 2020 13:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD1Lj7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 28 Apr 2020 07:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgD1Lj7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 28 Apr 2020 07:39:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED55C03C1A9;
        Tue, 28 Apr 2020 04:39:59 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0EA50005F31991FCF74C40.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:a500:5f3:1991:fcf7:4c40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 287E91EC0212;
        Tue, 28 Apr 2020 13:39:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588073997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=s8l5aad0wEgJZDLL7WT5VAuqUSYzmqEeCV4+SZ5DRFg=;
        b=WN/Nc6oczHK0p/qaG323YC405IblVT8MtVh/9HiwPY4lipmGctwXBGc2rF2kKFLN9rls0z
        XbWyUoiSjUSYr2YlhMbz/rmrJYuUfH+fC7pmaPvIj+pT7QHZCgqqtj3sqmw7z0TwU2Nm9g
        ezXvQpvGIe4Rjjb6IW7RHOsEf7hmDaY=
Date:   Tue, 28 Apr 2020 13:39:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Talel Shenhar <talel@amazon.com>
Cc:     mchehab@kernel.org, james.morse@arm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will@kernel.org, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, eitan@amazon.com
Subject: Re: [PATCH v6 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
Message-ID: <20200428113950.GB11272@zn.tnic>
References: <20200224134132.23924-1-talel@amazon.com>
 <20200224134132.23924-3-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224134132.23924-3-talel@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 24, 2020 at 03:41:32PM +0200, Talel Shenhar wrote:
> The Amazon's Annapurna Labs Memory Controller EDAC supports ECC capability
> for error detection and correction (Single bit error correction, Double
> detection). This driver introduces EDAC driver for that capability.
> 
> Signed-off-by: Talel Shenhar <talel@amazon.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> ---
>  MAINTAINERS               |   7 +
>  drivers/edac/Kconfig      |   7 +
>  drivers/edac/Makefile     |   1 +
>  drivers/edac/al_mc_edac.c | 355 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 370 insertions(+)
>  create mode 100644 drivers/edac/al_mc_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 296de2b51c83..ecd591d84bdf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -757,6 +757,13 @@ F:	drivers/tty/serial/altera_jtaguart.c
>  F:	include/linux/altera_uart.h
>  F:	include/linux/altera_jtaguart.h
>  
> +AMAZON ANNAPURNA LABS MEMORY CONTROLLER EDAC
> +M:	Talel Shenhar <talel@amazon.com>
> +M:	Talel Shenhar <talelshenhar@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
> +F:	drivers/edac/al_mc_edac.c
> +
>  AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
>  M:	Talel Shenhar <talel@amazon.com>
>  S:	Maintained
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 417dad635526..8c7fb7338e75 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -100,6 +100,13 @@ config EDAC_AMD64_ERROR_INJECTION
>  	  In addition, there are two control files, inject_read and inject_write,
>  	  which trigger the DRAM ECC Read and Write respectively.
>  
> +config EDAC_AL_MC
> +	tristate "Amazon's Annapurna Lab EDAC Memory Controller"
> +	depends on (ARCH_ALPINE || COMPILE_TEST)
> +	help
> +	  Support for error detection and correction for Amazon's Annapurna
> +	  Labs Alpine chips which allows 1 bit correction and 2 bits detection.
> +
>  config EDAC_AMD76X
>  	tristate "AMD 76x (760, 762, 768)"
>  	depends on PCI && X86_32
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index d77200c9680b..528832910ec4 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -22,6 +22,7 @@ obj-$(CONFIG_EDAC_GHES)			+= ghes_edac.o
>  edac_mce_amd-y				:= mce_amd.o
>  obj-$(CONFIG_EDAC_DECODE_MCE)		+= edac_mce_amd.o
>  
> +obj-$(CONFIG_EDAC_AL_MC)		+= al_mc_edac.o
>  obj-$(CONFIG_EDAC_AMD76X)		+= amd76x_edac.o
>  obj-$(CONFIG_EDAC_CPC925)		+= cpc925_edac.o
>  obj-$(CONFIG_EDAC_I5000)		+= i5000_edac.o
> diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
> new file mode 100644
> index 000000000000..64a2ee8406f4
> --- /dev/null
> +++ b/drivers/edac/al_mc_edac.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/edac.h>
> +#include <linux/of_irq.h>
> +#include <linux/platform_device.h>
> +#include <linux/spinlock.h>
> +#include "edac_module.h"
> +
> +/* Registers Offset */
> +#define AL_MC_MSTR		0x00

That define looks unused, pls remove. Check the others too - I found a
couple more unused at a quick scan.

> +#define AL_MC_ECC_CFG		0x70
> +#define AL_MC_ECC_CLEAR		0x7c
> +#define AL_MC_ECC_ERR_COUNT	0x80
> +#define AL_MC_ECC_CE_ADDR0	0x84
> +#define AL_MC_ECC_CE_ADDR1	0x88
> +#define AL_MC_ECC_UE_ADDR0	0xa4
> +#define AL_MC_ECC_UE_ADDR1	0xa8
> +#define AL_MC_ECC_CE_SYND0	0x8c
> +#define AL_MC_ECC_CE_SYND1	0x90
> +#define AL_MC_ECC_CE_SYND2	0x94
> +#define AL_MC_ECC_UE_SYND0	0xac
> +#define AL_MC_ECC_UE_SYND1	0xb0
> +#define AL_MC_ECC_UE_SYND2	0xb4

...

> +#define AL_MC_EDAC_MSG(message, buffer_size, type,			\
> +		       rank, row, bg, bank, column, syn0, syn1, syn2)	\
> +	snprintf(message, buffer_size,					\
> +		 "%s rank=0x%x row=0x%x bg=0x%x bank=0x%x col=0x%x "	\
> +		 "syn0: 0x%x syn1: 0x%x syn2: 0x%x",			\
> +		 type == HW_EVENT_ERR_UNCORRECTED ? "UE" : "CE",	\
> +		 rank, row, bg, bank, column, syn0, syn1, syn2)

Yuck, why is that a macro and not a normal function?

...

> +static void al_mc_edac_check(struct mem_ctl_info *mci)
> +{
> +	struct al_mc_edac *al_mc = mci->pvt_info;
> +
> +	if (al_mc->irq_ue <= 0)
> +		al_mc_edac_handle_ue(mci);
> +
> +	if (al_mc->irq_ce <= 0)
> +		al_mc_edac_handle_ce(mci);
> +}
> +
> +static irqreturn_t al_mc_edac_irq_handler_ue(int irq, void *info)
> +{
> +	struct platform_device *pdev = info;
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	if (al_mc_edac_handle_ue(mci))
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}
> +
> +static irqreturn_t al_mc_edac_irq_handler_ce(int irq, void *info)
> +{
> +	struct platform_device *pdev = info;
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	if (al_mc_edac_handle_ce(mci))
> +		return IRQ_HANDLED;
> +	return IRQ_NONE;
> +}

Why do you need two interrupt handlers? You can have only one and call
al_mc_edac_check() in it and it will do all the work needed.

Or does the thing fire two independent IRQs - one for CEs and another
for UEs - and they can fire in parallel?

> +
> +static enum scrub_type al_mc_edac_get_scrub_mode(void __iomem *mmio_base)
> +{
> +	u32 ecccfg0;
> +
> +	ecccfg0 = readl(mmio_base + AL_MC_ECC_CFG);
> +
> +	if (FIELD_GET(AL_MC_ECC_CFG_SCRUB_DISABLED, ecccfg0))
> +		return SCRUB_NONE;
> +	else
> +		return SCRUB_HW_SRC;
> +}
> +
> +static void devm_al_mc_edac_free(void *data)
> +{
> +	edac_mc_free(data);
> +}
> +
> +static void devm_al_mc_edac_del(void *data)
> +{
> +	edac_mc_del_mc(data);
> +}
> +
> +static int al_mc_edac_probe(struct platform_device *pdev)

Drop the "al_mc_edac_" prefix from most of the static functions. You can
leave it in the probe function or the IRQ handler so that it is visible
in stack traces but all those small functions don't need that prefix.

> +{
> +	void __iomem *mmio_base;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct al_mc_edac *al_mc;
> +	int ret;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

Check your other functions too pls.

> +
> +	mmio_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio_base)) {
> +		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
> +			PTR_ERR(mmio_base));
> +		return PTR_ERR(mmio_base);
> +	}
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = false;
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct al_mc_edac));

You can let that line stick out.

> +	if (!mci)
> +		return -ENOMEM;
> +
> +	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_free, mci);
> +	if (ret) {
> +		edac_mc_free(mci);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, mci);
> +	al_mc = mci->pvt_info;
> +
> +	al_mc->mmio_base = mmio_base;
> +
> +	al_mc->irq_ue = of_irq_get_byname(pdev->dev.of_node, "ue");
> +	if (al_mc->irq_ue <= 0)
> +		dev_dbg(&pdev->dev,
> +			"no irq defined for ue - falling back to polling\n");

s/irq/IRQ/g in user-visible strings.

Also,

s/ue/UE/g
s/ce/CE/g

> +
> +	al_mc->irq_ce = of_irq_get_byname(pdev->dev.of_node, "ce");
> +	if (al_mc->irq_ce <= 0)
> +		dev_dbg(&pdev->dev,
> +			"no irq defined for ce - falling back to polling\n");
> +
> +	if (al_mc->irq_ue <= 0 || al_mc->irq_ce <= 0)

Shouldn't this be && here?

I mean, you want to poll when neither of the IRQs can be found. But then
if you find one of them and not the other, what do you do? Poll and
interrupt? Is that case even possible?

> +		edac_op_state = EDAC_OPSTATE_POLL;
> +	else
> +		edac_op_state = EDAC_OPSTATE_INT;
> +
> +	spin_lock_init(&al_mc->lock);
> +
> +	mci->edac_check = al_mc_edac_check;

Set the ->edac_check pointer only when you poll, i.e. EDAC_OPSTATE_POLL.

> +	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->mod_name = DRV_NAME;
> +	mci->ctl_name = "al_mc";
> +	mci->pdev = &pdev->dev;
> +	mci->scrub_mode = al_mc_edac_get_scrub_mode(mmio_base);
> +
> +	ret = edac_mc_add_mc(mci);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"fail to add memory controller device (%d)\n",
> +			ret);
> +		return ret;

I'm assuming here devm_al_mc_edac_free() will be called eventually so
that mci is freed?

> +	}
> +
> +	ret = devm_add_action(&pdev->dev, devm_al_mc_edac_del, &pdev->dev);
> +	if (ret) {
> +		edac_mc_del_mc(&pdev->dev);
> +		return ret;

Here too?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

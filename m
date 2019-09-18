Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB3B0B69D3
	for <lists+linux-edac@lfdr.de>; Wed, 18 Sep 2019 19:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbfIRRrj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 18 Sep 2019 13:47:39 -0400
Received: from foss.arm.com ([217.140.110.172]:45954 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbfIRRrj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 18 Sep 2019 13:47:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E9921000;
        Wed, 18 Sep 2019 10:47:38 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22B8A3F59C;
        Wed, 18 Sep 2019 10:47:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] EDAC: al-mc-edac: Introduce Amazon's Annapurna
 Labs Memory Controller EDAC
To:     Talel Shenhar <talel@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, dwmw@amazon.co.uk,
        benh@kernel.crashing.org, hhhawa@amazon.com, ronenk@amazon.com,
        jonnyc@amazon.com, hanochu@amazon.com, amirkl@amazon.com,
        barakw@amazon.com
References: <1568529835-15319-1-git-send-email-talel@amazon.com>
 <1568529835-15319-3-git-send-email-talel@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <4f6cd17c-c56f-b9d2-d6e0-1711de415f47@arm.com>
Date:   Wed, 18 Sep 2019 18:47:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1568529835-15319-3-git-send-email-talel@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Talel,

On 15/09/2019 07:43, Talel Shenhar wrote:
> The Amazon's Annapurna Labs Memory Controller EDAC supports ECC capability
> for error detection and correction (Single bit error correction, Double
> detection). This driver introduces EDAC driver for that capability.

Is there any documentation for this memory controller?


> diff --git a/drivers/edac/al_mc_edac.c b/drivers/edac/al_mc_edac.c
> new file mode 100644
> index 0000000..f9763d4
> --- /dev/null
> +++ b/drivers/edac/al_mc_edac.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
> + */
> +#include <linux/bitfield.h>

#include <linux/bitops.h> for hweight_long()

> +#include <linux/edac.h>
> +#include <linux/of_irq.h>

#include <linux/platform_device.h> for platform_get_resource()

> +#include "edac_module.h"

> +/* Registers Values */
> +#define AL_MC_MSTR_DEV_CFG_X4	0
> +#define AL_MC_MSTR_DEV_CFG_X8	1
> +#define AL_MC_MSTR_DEV_CFG_X16	2
> +#define AL_MC_MSTR_DEV_CFG_X32	3

> +#define AL_MC_MSTR_RANKS_MAX 4

Is this a fixed property of the memory controller, or is it a limit imposed from somewhere
else. (Does it need to come from the DT?)


> +#define AL_MC_MSTR_DATA_BUS_WIDTH_X64	0
> +
> +#define DRV_NAME "al_mc_edac"
> +#define AL_MC_EDAC_MSG_MAX 256
> +#define AL_MC_EDAC_MSG(message, buffer_size, type,			\
> +		       rank, row, bg, bank, column, syn0, syn1, syn2)	\
> +	snprintf(message, buffer_size,					\
> +		 "%s rank=0x%x row=0x%x bg=0x%x bank=0x%x col=0x%x "	\
> +		 "syn0: 0x%x syn1: 0x%x syn2: 0x%x",			\
> +		 type == HW_EVENT_ERR_UNCORRECTED ? "UE" : "CE",	\
> +		 rank, row, bg, bank, column, syn0, syn1, syn2)
> +
> +struct al_mc_edac {
> +	void __iomem *mmio_base;
> +	int irq_ce;
> +	int irq_ue;
> +};
> +
> +static int al_mc_edac_handle_ce(struct mem_ctl_info *mci)
> +{
> +	struct al_mc_edac *al_mc = mci->pvt_info;
> +	u32 eccerrcnt;
> +	u16 ce_count;
> +	u32 ecccaddr0;
> +	u32 ecccaddr1;
> +	u32 ecccsyn0;
> +	u32 ecccsyn1;
> +	u32 ecccsyn2;
> +	u8 rank;
> +	u32 row;
> +	u8 bg;
> +	u8 bank;
> +	u16 column;
> +	char msg[AL_MC_EDAC_MSG_MAX];

(Some of these could go on the same line, same with UE below)


> +	eccerrcnt = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_ERR_COUNT);
> +	ce_count = FIELD_GET(AL_MC_ECC_ERR_COUNT_CE, eccerrcnt);
> +	if (!ce_count)
> +		return 0;
> +
> +	ecccaddr0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_CE_ADDR0);
> +	ecccaddr1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_CE_ADDR1);
> +	ecccsyn0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND0);
> +	ecccsyn1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND1);
> +	ecccsyn2 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND2);
> +
> +	writel(AL_MC_ECC_CLEAR_CE_COUNT | AL_MC_ECC_CLEAR_CE_ERR,
> +	       al_mc->mmio_base + AL_MC_ECC_CLEAR);
> +
> +	dev_dbg(mci->pdev, "eccuaddr0=0x%08x eccuaddr1=0x%08x\n",
> +		ecccaddr0, ecccaddr1);
> +
> +	rank = FIELD_GET(AL_MC_ECC_CE_ADDR0_RANK, ecccaddr0);
> +	row = FIELD_GET(AL_MC_ECC_CE_ADDR0_ROW, ecccaddr0);
> +
> +	bg = FIELD_GET(AL_MC_ECC_CE_ADDR1_BG, ecccaddr1);
> +	bank = FIELD_GET(AL_MC_ECC_CE_ADDR1_BANK, ecccaddr1);
> +	column = FIELD_GET(AL_MC_ECC_CE_ADDR1_COLUMN, ecccaddr1);
> +
> +	AL_MC_EDAC_MSG(msg, sizeof(msg), HW_EVENT_ERR_CORRECTED,
> +		       rank, row, bg, bank, column,
> +		       ecccsyn0, ecccsyn1, ecccsyn2);
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +			     ce_count, 0, 0, 0, 0, 0, -1, mci->ctl_name, msg);

You used active_ranks as the layer size in al_mc_edac_probe(). Can't you supply the rank here?

(If its not useful, why is it setup like this in al_mc_edac_probe()?)

(applies to UE below too)


> +
> +	return ce_count;
> +}
> +
> +static int al_mc_edac_handle_ue(struct mem_ctl_info *mci)
> +{
> +	struct al_mc_edac *al_mc = mci->pvt_info;
> +	u32 eccerrcnt;
> +	u16 ue_count;
> +	u32 eccuaddr0;
> +	u32 eccuaddr1;
> +	u32 eccusyn0;
> +	u32 eccusyn1;
> +	u32 eccusyn2;
> +	u8 rank;
> +	u32 row;
> +	u8 bg;
> +	u8 bank;
> +	u16 column;
> +	char msg[AL_MC_EDAC_MSG_MAX];
> +
> +	eccerrcnt = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_ERR_COUNT);
> +	ue_count = FIELD_GET(AL_MC_ECC_ERR_COUNT_UE, eccerrcnt);
> +	if (!ue_count)
> +		return 0;
> +
> +	eccuaddr0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_ADDR0);
> +	eccuaddr1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_ADDR1);
> +	eccusyn0 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND0);
> +	eccusyn1 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND1);
> +	eccusyn2 = readl_relaxed(al_mc->mmio_base + AL_MC_ECC_UE_SYND2);
> +
> +	writel(AL_MC_ECC_CLEAR_UE_COUNT | AL_MC_ECC_CLEAR_UE_ERR,
> +	       al_mc->mmio_base + AL_MC_ECC_CLEAR);
> +
> +	dev_dbg(mci->pdev, "eccuaddr0=0x%08x eccuaddr1=0x%08x\n",
> +		eccuaddr0, eccuaddr1);
> +
> +	rank = FIELD_GET(AL_MC_ECC_UE_ADDR0_RANK, eccuaddr0);
> +	row = FIELD_GET(AL_MC_ECC_UE_ADDR0_ROW, eccuaddr0);
> +
> +	bg = FIELD_GET(AL_MC_ECC_UE_ADDR1_BG, eccuaddr1);
> +	bank = FIELD_GET(AL_MC_ECC_UE_ADDR1_BANK, eccuaddr1);
> +	column = FIELD_GET(AL_MC_ECC_UE_ADDR1_COLUMN, eccuaddr1);
> +
> +	AL_MC_EDAC_MSG(msg, sizeof(msg), HW_EVENT_ERR_UNCORRECTED,
> +		       rank, row, bg, bank, column,
> +		       eccusyn0, eccusyn1, eccusyn2);
> +
> +	edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +			     ue_count, 0, 0, 0, 0, 0, -1, mci->ctl_name, msg);


What happens when this code runs at the same time as the corrected error handler calling
edac_mc_handler_error() with this same mci?

This could happen on a second CPU, or on one cpu if the corrected handler is polled.

edac_mc_handle_error() memset's the edac_raw_error_desc in mci, so it can't be called in
parallel, or twice on the same cpu.

I think you need an irqsave spinlock around the calls to edac_mc_handle_error().


> +	return ue_count;
> +}
> +
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
> +	int ue_count;
> +
> +	ue_count = al_mc_edac_handle_ue(mci);
> +	if (ue_count)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}

As you don't use ue_count, wouldn't this be clearer:

| if (al_mc_edac_handle_ue(mci))
| 	return IRQ_HANDLED;
| return IRQ_NONE;

?


> +static int al_mc_edac_probe(struct platform_device *pdev)
> +{
> +	struct resource *resource;
> +	void __iomem *mmio_base;
> +	unsigned int active_ranks;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct al_mc_edac *al_mc;
> +	int ret;
> +
> +	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);

platform_get_resource() can fail, returning NULL.


> +	mmio_base = devm_ioremap_resource(&pdev->dev, resource);
> +	if (IS_ERR(mmio_base)) {
> +		dev_err(&pdev->dev, "failed to ioremap memory (%ld)\n",
> +			PTR_ERR(mmio_base));
> +		return PTR_ERR(mmio_base);
> +	}
> +
> +	active_ranks = al_mc_edac_get_active_ranks(mmio_base);
> +	if (!active_ranks || active_ranks > AL_MC_MSTR_RANKS_MAX) {
> +		dev_err(&pdev->dev,
> +			"unsupported number of active ranks (%d)\n",
> +			active_ranks);
> +		return -ENODEV;
> +	}
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = active_ranks;
> +	layers[0].is_virt_csrow = false;
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct al_mc_edac));
> +	if (!mci)
> +		return -ENOMEM;
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
> +
> +	al_mc->irq_ce = of_irq_get_byname(pdev->dev.of_node, "ce");
> +	if (al_mc->irq_ce <= 0)
> +		dev_dbg(&pdev->dev,
> +			"no irq defined for ce - falling back to polling\n");
> +
> +	if (al_mc->irq_ue <= 0 || al_mc->irq_ce <= 0)
> +		edac_op_state = EDAC_OPSTATE_POLL;
> +	else
> +		edac_op_state = EDAC_OPSTATE_INT;
> +
> +	mci->edac_check = al_mc_edac_check;
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
> +		goto err_add_mc;
> +	}
> +
> +	if (al_mc->irq_ue > 0) {
> +		ret = devm_request_irq(&pdev->dev,
> +				       al_mc->irq_ue,
> +				       al_mc_edac_irq_handler_ue,

> +				       0,

As you know when your device has triggered the interrupt from the error counter, could
these be IRQF_SHARED?


> +				       pdev->name,
> +				       pdev);

> +}
> +
> +static int al_mc_edac_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);

What stops your interrupt firing here? You've free'd the memory it uses.

I think you need to devm_free_irq() the interrupts before you free the memory.


> +	return 0;
> +}


> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Talel Shenhar");
> +MODULE_DESCRIPTION("Amazon's Annapurna Lab's Memory Controller EDAC Driver");

(Kconfig says this is 'bool', so it can't be built as a module, having these is a bit odd)



Thanks,

James

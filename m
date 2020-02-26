Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98C8B1705AF
	for <lists+linux-edac@lfdr.de>; Wed, 26 Feb 2020 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgBZRMn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 26 Feb 2020 12:12:43 -0500
Received: from foss.arm.com ([217.140.110.172]:39404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbgBZRMn (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 26 Feb 2020 12:12:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6014630E;
        Wed, 26 Feb 2020 09:12:42 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 53B833F881;
        Wed, 26 Feb 2020 09:12:39 -0800 (PST)
Subject: Re: [PATCH 3/3] EDAC: synopsys: Add edac driver support for i.MX8MP
To:     sherry sun <sherry.sun@nxp.com>
Cc:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        rrichter@marvell.com, michal.simek@xilinx.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, frank.li@nxp.com
References: <1582267156-20189-1-git-send-email-sherry.sun@nxp.com>
 <1582267156-20189-4-git-send-email-sherry.sun@nxp.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <23a40435-8b18-2924-a1b1-635c2a4b446b@arm.com>
Date:   Wed, 26 Feb 2020 17:12:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1582267156-20189-4-git-send-email-sherry.sun@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sherry,

On 21/02/2020 06:39, sherry sun wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> Since i.MX8MP use synopsys ddr controller IP, so add edac support
> for i.MX8MP based on synopsys edac driver. i.MX8MP use LPDDR4 and
> support interrupts for corrected and uncorrected errors.

> The main
> difference between ZynqMP and i.MX8MP ddr controller is the interrupt
> registers. So add another interrupt handler function, enable/disable
> interrupt function to distinguish with ZynqMP.

Same, but different! Is there any more information on how this difference comes about?

It looks like the existing users of this driver all used DDR_QOS_IRQ, but yours uses
DDR_CE_INTR and DDR_UE_INTR. I note you didn't add a new register offset, so this must be
a feature of the IP that i.MX8MP uses, but others don't.

Is it possible to describe the feature in the DT instead of quirking based on the compatible?

Ideally someone else with the same configuration in a different SoC should be able to use
the new parts of this driver without changing the code to quirk their platform too.


> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index 2d263382d797..66c801502212 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c

> @@ -524,6 +530,54 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)

> +static void enable_intr_imx8mp(struct synps_edac_priv *priv)
> +{
> +	int regval;
> +
> +	regval = readl(priv->baseaddr + ECC_CLR_OFST);
> +	regval |= (DDR_CE_INTR_EN_MASK | DDR_UE_INTR_EN_MASK);
> +	writel(regval, priv->baseaddr + ECC_CLR_OFST);
> +}

I assume these two interrupts are combined as one line. i.e. this driver can't race with
itself.

Was this an integration choice? Could someone else use wire the DDR_CE_INTR and
DDR_UE_INTR interrupts separately so that two CPUs take them in parallel?


ECC_CLR_OFST looks mighty like one of these write-only 'clear pending irqs' register. I'm
surprised you read it, then write to it to enable interrupts... but I don't have the
documentation!


> +/* Interrupt Handler for ECC interrupts on imx8mp platform. */
> +static irqreturn_t intr_handler_imx8mp(int irq, void *dev_id)
> +{
> +	const struct synps_platform_data *p_data;
> +	struct mem_ctl_info *mci = dev_id;
> +	struct synps_edac_priv *priv;
> +	int status, regval;
> +
> +	priv = mci->pvt_info;
> +	p_data = priv->p_data;


> +	regval = readl(priv->baseaddr + ECC_STAT_OFST);
> +	if (!(regval & ECC_INTR_MASK))
> +		return IRQ_NONE;

zynqmp_get_error_info(), which you call via p_data->get_error_info() does this too, so
this is redundant.


> +	status = p_data->get_error_info(priv);
> +	if (status)
> +		return IRQ_NONE;
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count CE %d UE %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);

This is the same as the existing intr_handler()...


> +	enable_intr_imx8mp(priv);

Is this because zynqmp_get_error_info() wrote 0 to ECC_CLR_OFST, so now you have to
re-enable the interrrupts?

It looks like you are hacking round the problem!


> +
> +	return IRQ_HANDLED;
> +}

> @@ -541,6 +595,9 @@ static irqreturn_t intr_handler(int irq, void *dev_id)
>  	priv = mci->pvt_info;
>  	p_data = priv->p_data;
>  
> +	if (p_data->quirks & DDR_ECC_IMX8MP)
> +		return intr_handler_imx8mp(irq, dev_id);
> +
>  	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
>  	regval &= (DDR_QOSCE_MASK | DDR_QOSUE_MASK);
>  	if (!(regval & ECC_CE_UE_INTR_MASK))

As this driver has struct synps_platform_data for some function calls (that are all the
same today), you could add this as one that differs. This would let you pass the right one
to devm_request_irq() at setup_irq() time. If there is a third type of intr_handler, it
avoids chaining these quirk/features in the intr_handler().


> @@ -817,7 +874,7 @@ static void mc_init(struct mem_ctl_info *mci, struct platform_device *pdev)
>  	platform_set_drvdata(pdev, mci);
>  
>  	/* Initialize controller capabilities and configuration */
> -	mci->mtype_cap = MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
> +	mci->mtype_cap = MEM_FLAG_LRDDR4 | MEM_FLAG_DDR3 | MEM_FLAG_DDR2;
>  	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
>  	mci->scrub_cap = SCRUB_HW_SRC;
>  	mci->scrub_mode = SCRUB_NONE;

You haven't updated zynq_get_mtype(), is it possible to use the new memory type?


I think this would be cleaner if you moved the existing parts of the driver that aren't
needed when using DDR_CE_INTR and DDR_UE_INTR to the platform data as a preparatory patch.
You can then add support for these interrupts by adding the bits that are different.
This should avoid things like trying to undo what zynq_get_error_info() did. Things like
this are a maintenance headache.

As it is, you're hooking in the differences, then working round some of the things you
didn't want to happen. (e.g. ECC_CLR_OFST being written as zero)



Thanks,

James

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCC3218D60E
	for <lists+linux-edac@lfdr.de>; Fri, 20 Mar 2020 18:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbgCTRlT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Mar 2020 13:41:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36754 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgCTRlT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Mar 2020 13:41:19 -0400
Received: from zn.tnic (p200300EC2F0A5A004424DBD353F9EEF5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:4424:dbd3:53f9:eef5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 343311EC071C;
        Fri, 20 Mar 2020 18:41:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584726076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3N7ils9V/kgcAqXA/mpkHqLVkxW/1DHs+TnEvNW+oHE=;
        b=ktIEgfVyBDp9hX+KEMFqJRL+yhNyfF02uPoy+HoMVPmXJN0iEe5C5Ed7CRp/n6PhVqx4sz
        yX6fzjMzImIHIfxySeP5ZrMAm9sNBUq4fdM7xqs6ZinyLD3Aj0flIcuPdpqdNPrI9IR+xF
        z42qVxJnT3HW7iSgc8HzatbZ915NnEw=
Date:   Fri, 20 Mar 2020 18:41:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, mchehab@kernel.org,
        tony.luck@intel.com, james.morse@arm.com,
        linux-kernel@vger.kernel.org, mparab@cadence.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] EDAC/Cadence:Add EDAC driver for cadence memory
 controller
Message-ID: <20200320174122.GC23532@zn.tnic>
References: <20200228094322.13617-1-dkangude@cadence.com>
 <20200228094322.13617-2-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228094322.13617-2-dkangude@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Feb 28, 2020 at 10:43:21AM +0100, Dhananjay Kangude wrote:
> Added edac platform driver for Cadence DDR controller which
> notify the ecc events based on the single or double bit errors
> during memory operations.
> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> ---
>  drivers/edac/Kconfig        |   7 +
>  drivers/edac/Makefile       |   1 +
>  drivers/edac/cadence_edac.c | 615 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 623 insertions(+)
>  create mode 100644 drivers/edac/cadence_edac.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index fe2eb892a1bd..4bea37900e5d 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -530,4 +530,11 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_CADENCE
> +	tristate "Candence DDR Memory Controller ECC"

I'm guessing this is ARM hardware? If so, it needs to have the proper
ARCH dependency - see this file - drivers/edac/Kconfig - for examples.

> +	help
> +	  Support for error detection and correction on the Cadence DDR
> +	  memory controller. The driver provide the statistics  for single bit(CE)

I think you wanna say something like:

"The driver reports correctable and uncorrectable memory errors."

> +	  and double bit(UE) error correction.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 269e15118cea..a56cf2ec6043 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
>  obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> +obj-$(CONFIG_EDAC_CADENCE)		+= cadence_edac.o
> diff --git a/drivers/edac/cadence_edac.c b/drivers/edac/cadence_edac.c
> new file mode 100644
> index 000000000000..0a96de7708b0
> --- /dev/null
> +++ b/drivers/edac/cadence_edac.c
> @@ -0,0 +1,615 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cadence DDR4-ECC EDAC Driver.
> + *
> + * * Copyright (C) 2018-2019 Cadence Design Systems.
> + *
> + * * Authors: Dhananjay Kangude <dkangude@cadence.com>,
> + */
> +#include <linux/init.h>
> +#include <linux/edac.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <linux/delay.h>
> +#include "edac_module.h"
> +
> +#define CDNS_EDAC_MOD_NAME "cadence-edac"

Align that one vertically too.

> +#define FORCED_ECC_ERR_EVENT_SUPPORT	1

What's that for?

> +/* Number of cs_rows needed per memory controller */
> +#define CDNS_EDAC_NR_CSROWS		2

Unused. Remove pls. Audit your whole driver for unused defines like that
and drop them.

> +
> +/* Number of channels per memory controller */
> +#define CDNS_EDAC_NR_CHANS		1

That one too.

> +
> +/* Granularity of reported error in bytes */
> +#define CDNS_EDAC_ERR_GRAIN		1
> +
> +#define MEM_TYPE_DDR4			0xA
> +/* CDNS DDR4 Controller Registers */
> +#define DDR_CTL_MEM_TYPE_REG		0x000
> +#define DDR_CTL_MEM_WIDTH_REG		0x00c
> +#define DDR_CTL_CONTROLLER_BUSY		0x2f0
> +
> +/* ECC Controller Registers */
> +#define ECC_CTL_CONTROL_0_REG		0x254
> +#define ECC_CTL_CONTROL_1_REG		0x258
> +
> +#define ECC_CTL_SCRUB_CONTROL_0		0x280
> +#define ECC_CTL_SCRUB_CONTROL_1		0x284
> +#define ECC_CTL_SCRUB_CONTROL_2		0x288
> +#define ECC_CTL_SCRUB_START_ADDR_L	0x28c
> +#define ECC_CTL_SCRUB_START_ADDR_H	0x290
> +#define ECC_CTL_SCRUB_END_ADDR_L	0x294
> +#define ECC_CTL_SCRUB_END_ADDR_H	0x298
> +
> +#define ECC_SIG_ECC_C_ADDR_L		0x26c
> +#define ECC_SIG_ECC_C_ADDR_H		0x270
> +#define ECC_SIG_ECC_C_DATA_L		0x274
> +#define ECC_SIG_ECC_C_DATA_H		0x278
> +#define ECC_SIG_ECC_C_ID		0x27c
> +#define ECC_SIG_ECC_C_SYND		0x270
> +#define ECC_SIG_ECC_U_ADDR_L		0x25c
> +#define ECC_SIG_ECC_U_ADDR_H		0x25c
> +#define ECC_SIG_ECC_U_DATA_L		0x264
> +#define ECC_SIG_ECC_U_DATA_H		0x268
> +#define ECC_SIG_ECC_U_ID		0x27c
> +#define ECC_SIG_ECC_U_SYND		0x260
> +
> +#define ECC_CTL_INT_STATUS		0x310
> +#define ECC_CTL_INT_ACK			0x330
> +#define ECC_CTL_INT_MASK		0x350
> +
> +/*ECC Scrub Macros */

Add a space between the '*' and the first letter. Check all comments.

> +#define ECC_SCRUB_IN_PROGRESS		BIT(8)
> +#define ECC_SCRUB_MODE			BIT(0)
> +#define ECC_SCRUB_START			BIT(0)
> +#define ECC_SCRUB_LEN_SHIFT		(16)
> +#define ECC_SCRUB_IDLE_CNT		GENMASK(15, 0)
> +#define ECC_SCRUB_LEN			GENMASK(27, 16)
> +#define ECC_CTL_SCRUB_ADDR_L_MASK	GENMASK(31, 0)
> +#define ECC_CTL_SCRUB_ADDR_H_MASK	GENMASK(1, 0)
> +
> +/* Control register width definitions */
> +#define WDTH_16				(2)
> +#define WDTH_32				(1)
> +#define WDTH_64				(0)
> +#define CTL_REG_WIDTH_SHIFT		(32)
> +#define USER_WORD_SPLIT_WIDTH		(8)
> +#define CTL_CONTROLLER_BUSY_FLAG	BIT(16)
> +#define CTL_MEM_MAX_WIDTH_MASK		GENMASK(4, 0)
> +
> +/* ECC Control Macros */
> +#define ECC_CTL_FORCE_WC		BIT(16)
> +#define ECC_CTL_AUTO_CURRUPT_DISABLE	BIT(16)
> +#define ECC_CTL_AUTO_WRITEBACK_EN	BIT(24)
> +#define ECC_CTL_ECC_ENABLE		GENMASK(9, 8)
> +#define ECC_CTL_MTYPE_MASK		GENMASK(11, 8)
> +#define ECC_CTL_XOR_BITS_MASK		GENMASK(15, 0)
> +
> +/* ECC Status Macros */
> +
> +/* ECC IRQ Macros */
> +#define ECC_INT_CE_EVENT		BIT(0)
> +#define ECC_INT_SECOND_CE_EVENT		BIT(1)
> +#define ECC_INT_UE_EVENT		BIT(2)
> +#define ECC_INT_SECOND_UE_EVENT		BIT(3)
> +#define ECC_INT_WRITEBACK_UNHANDLED	BIT(6)
> +#define ECC_INT_SCRUB_DONE		BIT(7)
> +#define ECC_INT_SCRUB_CE_EVENT		BIT(8)
> +#define ECC_INT_MASK_ALL_H		BIT(8)
> +#define ECC_INT_CE_UE_MASK		GENMASK(3, 0)
> +#define ECC_CE_INTR_MASK		GENMASK(1, 0)
> +#define ECC_UE_INTR_MASK		GENMASK(3, 2)
> +#define ECC_CTL_INT_ENABLE_MASK		GENMASK(15, 0)
> +/* ECC Signature Macros */
> +#define ECC_SIG_ECC_C_ID_SHIFT		8
> +#define ECC_SIG_ECC_C_SYND_SHIFT	8
> +#define ECC_SIG_ECC_C_ADDR_H_MASK	GENMASK(1, 0)
> +#define ECC_SIG_ECC_C_ID_MASK		GENMASK(31, 16)
> +#define ECC_SIG_ECC_C_SYND_MASK		GENMASK(15, 8)
> +
> +#define ECC_SIG_ECC_U_ID_SHIFT		0
> +#define ECC_SIG_ECC_U_SYND_SHIFT	8
> +#define ECC_SIG_ECC_U_ADDR_H_MASK	GENMASK(1, 0)
> +#define ECC_SIG_ECC_U_ID_MASK		GENMASK(15, 0)
> +#define ECC_SIG_ECC_U_SYND_MASK		GENMASK(15, 8)
> +
> +/* Syndrome values */
> +#define ECC_DOUBLE_MULTI_ERR_SYND	0x03
> +
> +static char data_synd[] = {
> +			0xf4, 0xf1, 0xec, 0xea, 0xe9, 0xe6, 0xe5, 0xe3,
> +			0xdc, 0xda, 0xd9, 0xd6, 0xd5, 0xd3, 0xce, 0xcb,
> +			0xb5, 0xb0, 0xad, 0xab, 0xa8, 0xa7, 0xa4, 0xa2,
> +			0x9d, 0x9b, 0x98, 0x97, 0x94, 0x92, 0x8f, 0x8a,
> +			0x75, 0x70, 0x6d, 0x6b, 0x68, 0x67, 0x64, 0x62,
> +			0x5e, 0x5b, 0x58, 0x57, 0x54, 0x52, 0x4f, 0x4a,
> +			0x34, 0x31, 0x2c, 0x2a, 0x29, 0x26, 0x25, 0x23,
> +			0x1c, 0x1a, 0x19, 0x16, 0x15, 0x13, 0x0e, 0x0b
> +		  };
> +
> +static char check_synd[] = {0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x80};
> +
> +/**
> + * struct cdns_platform_data -  cadence platform data structure.
> + * @quirks:             To differentiate IP features.

This reads strange: you have a struct member called "quirks" which is
used to differentiate features? Why not call it

	u64 ip_features;

and turn it into a proper bitfield with proper member names which would
make the code a lot more readable:

	if (p->forced_ecc_event_support)
		...

Or

	if (p->ip_features & FEAT_FORCED_ECC_ERR_EVENT)

?

p->quirks testing for features looks strange.

> + */
> +struct cdns_platform_data {
> +	int quirks;
> +};
> +
> +/**
> + * struct cdns_edac_priv_data - edac device private instance data.
> + * @reg:	        Base address of the DDR controller.
> + * @ce_cnt:             Correctable Error count.
> + * @ue_cnt:             Uncorrectable Error count.
> + */
> +struct cdns_edac_priv_data {

This is only used in this driver so you can just as well call it simply
"priv_data" - no need for prefixes and the like.

> +	void __iomem *reg;
> +	u32 ce_cnt;
> +	u32 ue_cnt;
> +#ifdef CONFIG_EDAC_DEBUG
> +	struct cdns_platform_data *p;
> +#endif
> +};
> +
> +/**
> + * init_mem_layout -  Set address Map as per the mc design.
> + * @mci:   memory controller information.
> + *
> + * Set Address Map as per mc instance .
> + *
> + * Return: none.
> + */
> +static void init_mem_layout(struct mem_ctl_info *mci)
> +{
> +	struct cdns_edac_priv_data *priv = mci->pvt_info;
> +	struct csrow_info *csi;
> +	struct dimm_info *dimm;
> +	struct sysinfo inf;
> +	enum mem_type mtype;
> +	u32 val, width;
> +	u32 size, row;
> +	u8 j;
> +
> +	dimm = edac_get_dimm(mci, 0, 0, 0);

Check return value.

> +
> +	si_meminfo(&inf);
> +	for (row = 0; row < mci->nr_csrows; row++) {
> +		csi = mci->csrows[row];
> +		size = inf.totalram * inf.mem_unit;
> +
> +		for (j = 0; j < csi->nr_channels; j++) {
> +			dimm            = csi->channels[j]->dimm;
> +			dimm->edac_mode = EDAC_FLAG_SECDED;
> +			/* Get memory type by reading hw registers*/
> +			val = readl(priv->reg + DDR_CTL_MEM_TYPE_REG);
> +			mtype = val & ECC_CTL_MTYPE_MASK;
> +
> +			if (mtype == MEM_TYPE_DDR4)
> +				dimm->mtype = MEM_DDR4;
> +			else
> +				dimm->mtype = MEM_EMPTY;
> +
> +			/*Get EDAC devtype width for the current mc*/
> +			width = (readl(priv->reg + DDR_CTL_MEM_WIDTH_REG) &
> +				       CTL_MEM_MAX_WIDTH_MASK);
> +			switch (width) {
> +			case WDTH_16:
> +				dimm->dtype  = DEV_X2;
> +				break;
> +			case WDTH_32:
> +				dimm->dtype  = DEV_X4;
> +				break;
> +			case WDTH_64:
> +				dimm->dtype  = DEV_X8;
> +				break;
> +			default:
> +				dimm->dtype = DEV_UNKNOWN;
> +			}
> +
> +			dimm->nr_pages  = (size >> PAGE_SHIFT) /
> +					   csi->nr_channels;
> +			dimm->grain     = CDNS_EDAC_ERR_GRAIN;

Carve the loop body out into a separate function called something like
__init_dimm() or so for improved readability.

> +		}
> +	}
> +}
> +
> +/**
> + * edac_ecc_isr - Interrupt Handler for ECC interrupts.
> + * @irq:        IRQ number.
> + * @dev_id:     Device ID.
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
> + */
> +static irqreturn_t edac_ecc_isr(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct cdns_edac_priv_data *priv;
> +	u32 intr_status;
> +	u32 val;
> +	u32 sig_val_l, sig_val_h;
> +	u32 err_c_id, err_u_id;
> +	u32 err_c_synd, err_u_synd;
> +	u64 err_c_addr = 0x0, err_u_addr = 0x0;
> +	u64 err_c_data = 0x0, err_u_data = 0x0;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	priv = mci->pvt_info;
> +
> +	/* Check the intr status and confirm ECC error intr */
> +	intr_status = readl(priv->reg + ECC_CTL_INT_STATUS);
> +
> +	edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);
> +	val = intr_status & (ECC_INT_CE_UE_MASK);
> +	if (!((val & ECC_CE_INTR_MASK) || (val & ECC_UE_INTR_MASK)))
> +		return IRQ_NONE;
> +
> +	if (val & ECC_CE_INTR_MASK) {
> +		sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_ADDR_L);
> +		sig_val_h = (readl(priv->reg + ECC_SIG_ECC_C_ADDR_H) &
> +			     ECC_SIG_ECC_C_ADDR_H_MASK);
> +		err_c_addr = (((err_c_addr | sig_val_h) <<
> +				CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +		sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_DATA_L);
> +		sig_val_h = readl(priv->reg + ECC_SIG_ECC_C_DATA_H);
> +		err_c_data = (((err_c_data | sig_val_h) <<
> +				CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +		err_c_id = ((readl(priv->reg + ECC_SIG_ECC_C_ID) &
> +			     ECC_SIG_ECC_C_ID_MASK) >>
> +			     ECC_SIG_ECC_C_ID_SHIFT);
> +
> +		err_c_synd = ((readl(priv->reg + ECC_SIG_ECC_C_SYND) &
> +			       ECC_SIG_ECC_C_SYND_MASK) >>
> +			       ECC_SIG_ECC_C_SYND_SHIFT);
> +		priv->ce_cnt = priv->ce_cnt + 1;
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +				     1,
> +				     err_c_addr >> PAGE_SHIFT,
> +				     err_c_addr & ~PAGE_MASK,
> +				     err_c_synd, 0, 0, -1,
> +				     mci->ctl_name, "");
> +
> +		/* Clear the interrupt source */
> +		if (val & ECC_INT_CE_EVENT)
> +			writel(ECC_INT_CE_EVENT, priv->reg + ECC_CTL_INT_ACK);
> +		else if (val & ECC_INT_SECOND_CE_EVENT)
> +			writel(ECC_INT_SECOND_CE_EVENT,
> +			       priv->reg + ECC_CTL_INT_ACK);
> +		else
> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");

That could be a separate function: handle_ec()

> +	}
> +
> +	if (val & ECC_UE_INTR_MASK) {
> +		sig_val_l = readl(priv->reg + ECC_SIG_ECC_U_ADDR_L);
> +		sig_val_h = (readl(priv->reg + ECC_SIG_ECC_U_ADDR_H) &
> +			     ECC_SIG_ECC_U_ADDR_H_MASK);
> +		err_u_addr = (((err_u_addr | sig_val_h) <<
> +				CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +		sig_val_l = readl(priv->reg + ECC_SIG_ECC_U_DATA_L);
> +		sig_val_h = readl(priv->reg + ECC_SIG_ECC_U_DATA_H);
> +		err_u_data = (((err_u_data | sig_val_h) <<
> +				CTL_REG_WIDTH_SHIFT) | sig_val_l);
> +
> +		err_u_id = ((readl(priv->reg + ECC_SIG_ECC_U_ID) &
> +			     ECC_SIG_ECC_U_ID_MASK) >>
> +			     ECC_SIG_ECC_U_ID_SHIFT);
> +
> +		err_u_synd = ((readl(priv->reg + ECC_SIG_ECC_U_SYND) &
> +			       ECC_SIG_ECC_U_SYND_MASK) >>
> +			       ECC_SIG_ECC_U_SYND_SHIFT);
> +		priv->ue_cnt = priv->ue_cnt + 1;
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +				     1,
> +				     err_u_addr >> PAGE_SHIFT,
> +				     err_u_addr & ~PAGE_MASK,
> +				     err_u_synd, 0, 0, -1,
> +				     mci->ctl_name, "");
> +
> +		/* Clear the interrupt source */
> +		if (val & ECC_INT_UE_EVENT)
> +			writel(ECC_INT_UE_EVENT, priv->reg + ECC_CTL_INT_ACK);
> +		else if (val & ECC_INT_SECOND_UE_EVENT)
> +			writel(ECC_INT_SECOND_UE_EVENT,
> +			       priv->reg + ECC_CTL_INT_ACK);
> +		else
> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");

That could be a separate function: handle_ue()

> +	}
> +
> +	edac_dbg(3, "Total error count CE %d UE %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +/**
> + * forced_ecc_error_show/store - Sysfs atrribute functions.
> + * @dev: Pointer to device structure.
> + * @mattr: Pointer to device attributes.
> + * @data : Data send by User space and stored in file.
> + * Return: as SUCCESS,Total number of characters written otherwise
> + *         negative value.
> + */
> +static ssize_t forced_ecc_error_show(struct device *dev,
> +				     struct device_attribute *mattr,
> +				     char *data)
> +{
> +	return sprintf(data, "CDNS-DDR4 Force Injection Help:\n"
> +		       "CE/UE: Corrected/Uncorrected\n"
> +		       "checkcode/data:source\n"
> +		       "user_word [0-1]:subpart of data\n"
> +		       "bit [0-31]:bit number\n");
> +}
> +
> +static ssize_t forced_ecc_error_store(struct device *dev,
> +				      struct device_attribute *mattr,
> +				      const char *data, size_t count)
> +{
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct cdns_edac_priv_data *priv = mci->pvt_info;
> +	int	args_cnt;
> +	int	ret;
> +	char	**args;
> +	char buf[1000];

Srsly? 1kB on the stack?

> +	u32	regval;
> +	u8	user_word;
> +	u8	bit_no;
> +
> +	/* Read sysfs params into buffer*/
> +	snprintf(buf, min_t(size_t, sizeof(buf) - 1, count), "%s\n", data);
> +	/*Split string buffer into separate parameters*/
> +	args = argv_split(GFP_KERNEL, buf, &args_cnt);

Why can't you split data directly?

> +
> +	ret = kstrtou8(args[2], 0, &user_word);
> +	if (ret)
> +		return ret;
> +
> +	ret = kstrtou8(args[3], 0, &bit_no);
> +	if (ret)
> +		return ret;
> +
> +	/* Check ecc enabled */
> +	if (readl(priv->reg + ECC_CTL_CONTROL_0_REG) & ECC_CTL_ECC_ENABLE) {

Save an indentation level:

 	if (!readl(priv->reg + ECC_CTL_CONTROL_0_REG) & ECC_CTL_ECC_ENABLE)
		return count;

	/* Check ... */


> +		/* Check no write operation pending to controller*/
> +		while (readl(priv->reg + DDR_CTL_CONTROLLER_BUSY) &
> +			     CTL_CONTROLLER_BUSY_FLAG) {
> +			usleep_range(1000, 10000);
> +		}
> +		/* Write appropriate syndrome to xor_check_bit*/
> +		if (!strcmp(args[0], "CE")) {
> +			if (!strcmp(args[1], "checkcode")) {
> +				regval = readl(priv->reg +
> +					       ECC_CTL_CONTROL_1_REG);
> +				regval = (regval & ~(ECC_CTL_XOR_BITS_MASK)) |
> +					(check_synd[bit_no] <<
> +					(USER_WORD_SPLIT_WIDTH * user_word));
> +				writel(regval,
> +				       priv->reg + ECC_CTL_CONTROL_1_REG);
> +			} else if (!strcmp(args[1], "data")) {
> +				regval = readl(priv->reg +
> +					       ECC_CTL_CONTROL_1_REG);
> +				regval = (regval & ~(ECC_CTL_XOR_BITS_MASK)) |
> +					(data_synd[bit_no] <<
> +					(USER_WORD_SPLIT_WIDTH * user_word));
> +				writel(regval,
> +				       priv->reg + ECC_CTL_CONTROL_1_REG);
> +			}
> +			/* Enable the ECC writeback_en for corrected error */
> +			regval = readl(priv->reg + ECC_CTL_CONTROL_1_REG);
> +			writel((regval | ECC_CTL_AUTO_WRITEBACK_EN),
> +			       priv->reg + ECC_CTL_CONTROL_1_REG);
> +		} else if (!strcmp(args[0], "UE")) {
> +			writel(ECC_DOUBLE_MULTI_ERR_SYND,
> +			       priv->reg + ECC_CTL_CONTROL_1_REG);
> +		}
> +
> +		/* Assert fwc */
> +		writel((ECC_CTL_FORCE_WC |
> +			readl(priv->reg + ECC_CTL_CONTROL_0_REG)),
> +			priv->reg + ECC_CTL_CONTROL_0_REG);
> +	}

This whole thing needs a serious massaging because it is highly
unreadable. Let those long lines stick out, think about using helper
functions, etc.

> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(forced_ecc_error);
> +static int edac_create_sysfs_attributes(struct mem_ctl_info *mci)

Drop the "edac_" prefix from driver-local functions. Audit the whole
driver pls.

> +{
> +	int rc;
> +
> +	rc = device_create_file(&mci->dev, &dev_attr_forced_ecc_error);
> +	if (rc < 0)
> +		return rc;
> +	return 0;
> +}
> +
> +static void edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
> +{
> +	device_remove_file(&mci->dev, &dev_attr_forced_ecc_error);
> +}
> +
> +#endif
> +
> +static const struct cdns_platform_data cdns_edac = {
> +#ifdef CONFIG_EDAC_DEBUG
> +	.quirks = FORCED_ECC_ERR_EVENT_SUPPORT,
> +#endif
> +};
> +
> +static const struct of_device_id cdns_edac_of_match[] = {
> +	{ .compatible = "cdns,cadence-ddr4-mc-edac", .data = &cdns_edac },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, cdns_edac_of_match);
> +
> +/**
> + * cdns_edac_mc_probe - bind cdns mc controller driver to framework.
> + * @pdev:  platform device.
> + *
> + * Probe a memory controller for binding with the driver.
> + *
> + * Return: 0 if binding of the controller instance is successful;
> + * otherwise, < 0 on error.
> + */
> +

<---- newline here.

> +static int cdns_edac_mc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res;
> +	void __iomem *reg;
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer layers[1];
> +	const struct of_device_id *id;
> +	struct cdns_edac_priv_data *priv_data;
> +	int irq, ret = -ENODEV;
> +#ifdef CONFIG_EDAC_DEBUG
> +	const struct cdns_platform_data *p;
> +#endif

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +	id = of_match_device(cdns_edac_of_match, &pdev->dev);
> +	if (!id)
> +		return -ENODEV;
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +	p = of_device_get_match_data(&pdev->dev);
> +	if (!p)
> +		return -ENODEV;
> +#endif
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Unchecked retval.

> +	reg = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(reg)) {
> +		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +			    "cdns DDR4 mc regs are not defined\n");
> +		return PTR_ERR(reg);
> +	}
> +
> +	edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +		    "IO mapped reg addr: %p\n", reg);
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct cdns_edac_priv_data));
> +	if (!mci) {
> +		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +			    "Failed memory allocation for mc instance\n");
> +		return -ENOMEM;
> +	}
> +	mci->pdev = &pdev->dev;
> +	priv_data = mci->pvt_info;
> +	priv_data->reg = reg;
> +	priv_data->ce_cnt = 0;
> +	priv_data->ue_cnt = 0;
> +	platform_set_drvdata(pdev, mci);
> +	/* Initialize controller capabilities */
> +	mci->mtype_cap = MEM_FLAG_DDR4;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	mci->scrub_cap = SCRUB_UNKNOWN;
> +	mci->scrub_mode = SCRUB_HW_PROG;
> +	mci->edac_cap = EDAC_FLAG_SECDED;
> +	mci->ctl_name = id->compatible;
> +	mci->dev_name = dev_name(&pdev->dev);
> +	mci->mod_name = CDNS_EDAC_MOD_NAME;
> +	mci->ctl_page_to_phys = NULL;
> +
> +	/* Interrupt feature is supported by cadence mc */
> +	edac_op_state = EDAC_OPSTATE_INT;
> +	init_mem_layout(mci);
> +
> +	/* Setup Interrupt handler for ECC */
> +	irq = platform_get_irq(pdev, 0);
> +	if (!irq) {
> +		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +			    "irq number not defined for ecc.\n");

s/ecc/ECC/g

For the whole driver.

> +		goto err;
> +	}
> +	ret = devm_request_irq(dev, irq, edac_ecc_isr, 0,
> +			       "cdns-edac-mc-ecc-irq", mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +			    "request_irq fail for CDNS_EDAC irq\n");
> +		goto err;
> +	}
> +	ret = edac_mc_add_mc(mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +			    "Failed to register with EDAC core\n");
> +		goto err;
> +	}
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +	if (p->quirks && FORCED_ECC_ERR_EVENT_SUPPORT) {
> +		if (edac_create_sysfs_attributes(mci)) {
> +			edac_printk(KERN_ERR, CDNS_EDAC_MOD_NAME,
> +				    "Failed to create sysfs entries\n");
> +			goto err;

After you've done edac_mc_add_mc(), you need to do edac_mc_del_mc().
Look at how the other drivers do it and test your driver with
CONFIG_KASAN and CONFIG_DEBUG_TEST_DRIVER_REMOVE.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1F1CE1EF
	for <lists+linux-edac@lfdr.de>; Mon, 11 May 2020 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEKRoV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 11 May 2020 13:44:21 -0400
Received: from foss.arm.com ([217.140.110.172]:36920 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgEKRoT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 11 May 2020 13:44:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2AAD631B;
        Mon, 11 May 2020 10:44:18 -0700 (PDT)
Received: from [192.168.0.14] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51A33F305;
        Mon, 11 May 2020 10:44:16 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] EDAC/Cadence:Add EDAC driver for cadence memory
 controller
To:     Dhananjay Kangude <dkangude@cadence.com>
Cc:     linux-edac@vger.kernel.org, bp@alien8.de, mchehab@kernel.org,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        mparab@cadence.com, robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20200424083155.30918-1-dkangude@cadence.com>
 <20200424083155.30918-3-dkangude@cadence.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <19035f9e-442b-68d0-cc19-d8185f09cd3b@arm.com>
Date:   Mon, 11 May 2020 18:44:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200424083155.30918-3-dkangude@cadence.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Dhananjay,

On 24/04/2020 09:31, Dhananjay Kangude wrote:
> Added edac platform driver for Cadence DDR controller which
> notify the ecc events based on the single or double bit errors
> during memory operations.

Is there any public documentation for this device?


The way you're using syfs here is a problem. Surely this compile time debug option for
error injection is only going to get used by Soc integrators?, not by people with
platforms that have this device...
Its going to be much simpler to remove it.


> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index fe2eb89..d5bb399 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -530,4 +530,12 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_CADENCE

> +	tristate "Candence DDR Memory Controller ECC"
Typo:               ^^


> +	depends on ARM
> +	help
> +	  Support for error detection and correction on the Cadence DDR
> +	  memory controller. The driver reports correctable and uncorrectable
> +	  memory errors.
> +
>  endif # EDAC

> diff --git a/drivers/edac/cadence_edac.c b/drivers/edac/cadence_edac.c
> new file mode 100644
> index 0000000..3aecc9a
> --- /dev/null
> +++ b/drivers/edac/cadence_edac.c
> @@ -0,0 +1,641 @@

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
> +#define FORCED_ECC_ERR_EVENT_SUPPORT	BIT(1)
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
> +/* ECC Scrub Macros */
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

Sure?

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

(you use these with a user controlled value and no bounds checking.

But I'm not convinced this error injection is going to get used upstream, and I don't
think you can use sysfs to move argv[] around!).


> +/**
> + * struct cdns_platform_data -  cadence platform data structure.
> + * @ip_features:	To differentiate IP features.

> + */
> +struct cdns_platform_data {
> +	int ip_features;
> +};

You only read/write a constant value if CONFIG_EDAC_DEBUG is defined.

Isn't this struct redundant?


> +
> +/**
> + * struct priv_data - edac device private instance data.
> + * @reg:	        Base address of the DDR controller.
> + * @ce_cnt:             Correctable Error count.
> + * @ue_cnt:             Uncorrectable Error count.
> + */
> +struct priv_data {
> +	void __iomem *reg;


> +	u32 ce_cnt;
> +	u32 ue_cnt;

edac exists to provide these counters. Please don't duplicate them for a debug message
no-one will ever see.


> +#ifdef CONFIG_EDAC_DEBUG
> +	struct cdns_platform_data *p;
> +#endif

Isn't this struct redundant?


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
> +	struct priv_data *priv = mci->pvt_info;
> +	struct csrow_info *csi;
> +	struct dimm_info *dimm;
> +	struct sysinfo inf;
> +	enum mem_type mtype;
> +	u32 val, width;
> +	u32 size, row;
> +	u8 j;
> +
> +	dimm = edac_get_dimm(mci, 0, 0, 0);
> +	if (!dimm) {

Returning 'if (dimm)' would avoid some indenting here.

But can this actually happen?

From the one caller we know this will return the dimm allocated by edac_mc_alloc_dimms().
You have one layer, of size 1. My reading of edac_mc_alloc() gives tot_dimms = 1, and
tot_csrows = 1... in what circumstances does this code run?


> +		si_meminfo(&inf);
> +		for (row = 0; row < mci->nr_csrows; row++) {
> +			csi = mci->csrows[row];
> +			size = inf.totalram * inf.mem_unit;
> +
> +			for (j = 0; j < csi->nr_channels; j++) {
> +				dimm            = csi->channels[j]->dimm;
> +				dimm->edac_mode = EDAC_FLAG_SECDED;
> +				/* Get memory type by reading hw registers*/
> +				val = readl(priv->reg + DDR_CTL_MEM_TYPE_REG);
> +				mtype = val & ECC_CTL_MTYPE_MASK;
> +
> +				if (mtype == MEM_TYPE_DDR4)
> +					dimm->mtype = MEM_DDR4;
> +				else
> +					dimm->mtype = MEM_EMPTY;
> +
> +				/*Get EDAC devtype width for the current mc*/
> +				width = readl(priv->reg + DDR_CTL_MEM_WIDTH_REG)
> +					      & CTL_MEM_MAX_WIDTH_MASK;
> +				switch (width) {
> +				case WDTH_16:
> +					dimm->dtype  = DEV_X2;
> +					break;
> +				case WDTH_32:
> +					dimm->dtype  = DEV_X4;
> +					break;
> +				case WDTH_64:
> +					dimm->dtype  = DEV_X8;
> +					break;
> +				default:
> +					dimm->dtype = DEV_UNKNOWN;
> +				}
> +				dimm->nr_pages  = (size >> PAGE_SHIFT) /
> +					csi->nr_channels;
> +				dimm->grain     = CDNS_EDAC_ERR_GRAIN;
> +			}
> +		}
> +	}
> +}
> +
> +/**
> + * handle_ce - Handle corrected errors and notify to
> + *             edac layer by reading appropriate hw registers
> + * @mci:   memory controller information.
> + * Return: void.
> + */
> +static void handle_ce(struct mem_ctl_info *mci)
> +{
> +	struct priv_data *priv;
> +	u64 err_c_addr = 0x0;
> +	u64 err_c_data = 0x0;
> +	u32 err_c_synd, err_c_id;
> +	u32 sig_val_l, sig_val_h;
> +
> +	priv = mci->pvt_info;
> +
> +	sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_ADDR_L);
> +	sig_val_h = (readl(priv->reg + ECC_SIG_ECC_C_ADDR_H) &
> +			ECC_SIG_ECC_C_ADDR_H_MASK);


> +	err_c_addr = (((err_c_addr | sig_val_h) <<
> +				CTL_REG_WIDTH_SHIFT) | sig_val_l);

err_c_addr was initialised to 0,... isn't this the same as:
| err_c_addr = (sig_val_h << CTL_REG_WIDTH_SHIFT) | sig_val_l;



> +	sig_val_l = readl(priv->reg + ECC_SIG_ECC_C_DATA_L);
> +	sig_val_h = readl(priv->reg + ECC_SIG_ECC_C_DATA_H);

> +	err_c_data = (((err_c_data | sig_val_h) <<
> +				CTL_REG_WIDTH_SHIFT) | sig_val_l);

err_c_data was initialised to 0....


> +	err_c_id = ((readl(priv->reg + ECC_SIG_ECC_C_ID) &
> +				ECC_SIG_ECC_C_ID_MASK) >>
> +			ECC_SIG_ECC_C_ID_SHIFT);

Would the FIELD_GET() macros make this clearer?
| FIELD_GET(ECC_SIG_ECC_C_ID_MASK, readl(priv->reg + ECC_SIG_ECC_C_ID));


> +	err_c_synd = ((readl(priv->reg + ECC_SIG_ECC_C_SYND) &
> +				ECC_SIG_ECC_C_SYND_MASK) >>
> +			ECC_SIG_ECC_C_SYND_SHIFT);

FIELD_GET()?

> +
> +	priv->ce_cnt = priv->ce_cnt + 1;

Please don't duplicate edac for debug messages.


> +	edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +			     1,
> +			     err_c_addr >> PAGE_SHIFT,
> +			     err_c_addr & ~PAGE_MASK,
> +			     err_c_synd, 0, 0, -1,
> +			     mci->ctl_name, "");
> +}
> +
> +/**
> + * handle_ue -	Handle uncorrected errors and notify to
> + *		edac layer by reading appropriate hw registers
> + * @mci:   memory controller information.
> + * Return: void.
> + */
> +static void handle_ue(struct mem_ctl_info *mci)
> +{

[as above]

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
> +	struct priv_data *priv;
> +	u32 intr_status;
> +	u32 val;
> +
> +	priv = mci->pvt_info;
> +
> +	/* Check the intr status and confirm ECC error intr */
> +	intr_status = readl(priv->reg + ECC_CTL_INT_STATUS);
> +
> +	edac_dbg(3, "InterruptStatus : 0x%x\n", intr_status);
> +	val = intr_status & (ECC_INT_CE_UE_MASK);

> +	if (!((val & ECC_CE_INTR_MASK) || (val & ECC_UE_INTR_MASK)))

|	if (!val)
?

> +		return IRQ_NONE;


> +	if (val & ECC_CE_INTR_MASK) {
> +		handle_ce(mci);
> +
> +		/* Clear the interrupt source */
> +		if (val & ECC_INT_CE_EVENT)
> +			writel(ECC_INT_CE_EVENT, priv->reg + ECC_CTL_INT_ACK);
> +		else if (val & ECC_INT_SECOND_CE_EVENT)
> +			writel(ECC_INT_SECOND_CE_EVENT,
> +			       priv->reg + ECC_CTL_INT_ACK);
> +		else


> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");

Please ensure this is rate limited!


> +	}
> +
> +	if (val & ECC_UE_INTR_MASK) {
> +		handle_ue(mci);
> +
> +		/* Clear the interrupt source */
> +		if (val & ECC_INT_UE_EVENT)
> +			writel(ECC_INT_UE_EVENT, priv->reg + ECC_CTL_INT_ACK);
> +		else if (val & ECC_INT_SECOND_UE_EVENT)
> +			writel(ECC_INT_SECOND_UE_EVENT,
> +			       priv->reg + ECC_CTL_INT_ACK);
> +		else

> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to clear IRQ\n");

Please ensure this is rate limited!


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

Multiple values, and multiple lines in sysfs are, frowned on. There is a
"one value per sysfs file" rule:
https://lore.kernel.org/linux-pci/20190621072911.GA21600@kroah.com/

(the attributes section in 'Documentation/filesystems/sysfs.rst' also has some stuff on this)


Its not clear to me from this help text what I'd have to write in here to inject an error.
This is for debug? Who is expected to use it? Is it really needed upstream?

Can we remove this #ifdeffery and heavily-frowned-on use of sysfs? You are abusing it to
move an argv[] into the kernel.


> +static const struct of_device_id cdns_edac_of_match[] = {
> +	{ .compatible = "cdns,ddr4-mc-edac", .data = &cdns_edac },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, cdns_edac_of_match);

> +/**
> + * cdns_edac_mc_probe - bind cdns mc controller driver to framework.
> + * @pdev:  platform device.
> + *
> + * Probe a memory controller for binding with the driver.
> + *
> + * Return: 0 if binding of the controller instance is successful;
> + * otherwise, < 0 on error.
> + */
> +static int cdns_edac_mc_probe(struct platform_device *pdev)
> +{

[...]

> +	/* Enable & set CE/UE Interrupts for DDR4 Controller */
> +	writel((unsigned int)(~(ECC_CTL_INT_ENABLE_MASK)),
> +	       priv_data->reg + ECC_CTL_INT_MASK);
> +
> +	/* Start capturing the correctable and uncorrectable errors.
> +	 * Write 1 to enable.
> +	 */
> +	writel(ECC_CTL_ECC_ENABLE, priv_data->reg + ECC_CTL_CONTROL_0_REG);
> +	return 0;
> +
> +err1:

(giving these names will make the code more readable)


> +	edac_mc_del_mc(&pdev->dev);
> +
> +err:
> +	edac_mc_free(mci);
> +	return ret;
> +}
> +
> +/**
> + * cdns_edac_mc_remove - Unbind driver from controller.
> + * @pdev:  Platform device.
> + *
> + * Return: 0
> + */
> +static int cdns_edac_mc_remove(struct platform_device *pdev)
> +{
> +	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct priv_data *priv = mci->pvt_info;

Could another CPU be running in edac_ecc_isr() when this is called....

> +	/* Disable All ECC Interrupts for DDR4 Controller */
> +	writel(ECC_CTL_INT_ENABLE_MASK, priv->reg + ECC_CTL_INT_MASK);
> +
> +	/* Disable ecc feature before removing driver by writing 0 */
> +	writel((unsigned int)(~(ECC_CTL_ECC_ENABLE)),
> +	       priv->reg + ECC_CTL_CONTROL_0_REG);
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +	remove_sysfs_attributes(mci);
> +#endif
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);

... and now you've free()d the private data from underneath it.


I think you need an irqsave spinlock and a call to platform_set_drvdata(pdev, NULL).
edac_ecc_isr() would need to take the lock when using the private data, (nd return if its
NULL).


> +	return 0;
> +}


Thanks,

James

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1444A4EC6C
	for <lists+linux-edac@lfdr.de>; Fri, 21 Jun 2019 17:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfFUPpQ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Jun 2019 11:45:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35084 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbfFUPpQ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 21 Jun 2019 11:45:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88DA0344;
        Fri, 21 Jun 2019 08:45:14 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66C043F575;
        Fri, 21 Jun 2019 08:45:13 -0700 (PDT)
Subject: Re: [PATCH v5 1/1] EDAC, mellanox: Add ECC support for BlueField DDR4
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1560786127.git.sramani@mellanox.com>
 <845196f9d86581efdf0d7fce001a8b1894e97c78.1560786127.git.sramani@mellanox.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <1d5c4b17-3fcf-e439-a3d1-2a7a217a5447@arm.com>
Date:   Fri, 21 Jun 2019 16:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <845196f9d86581efdf0d7fce001a8b1894e97c78.1560786127.git.sramani@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shravan,

On 17/06/2019 19:41, Shravan Kumar Ramani wrote:
> Add ECC support for Mellanox BlueField SoC DDR controller.

> This requires SMC to the running Arm Trusted Firmware to report
> what is the current memory configuration.

> ---

For a single patch, the changelog would usually be in here:

> Changes since v4:
> Shorten long macro names.
>
> Changes since v3:
> Replace bitfields with shifts and masks.

(but not all of them!)

> Make use of SZ_ and PAGE_ macros.
> Read DIMM count from the ACPI table instead of hard-coding the info in
> the driver.


> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> new file mode 100644
> index 0000000..d4a29ba
> --- /dev/null
> +++ b/drivers/edac/bluefield_edac.c

> +#define MLXBF_SYNDROM 0x35c
> +#define MLXBF_SYNDROM__DERR_SHIFT 0
> +#define MLXBF_SYNDROM__DERR_MASK 0x1
> +#define MLXBF_SYNDROM__SERR_SHIFT 1
> +#define MLXBF_SYNDROM__SERR_MASK 0x1
> +#define MLXBF_SYNDROM__SYN_SHIFT 16
> +#define MLXBF_SYNDROM__SYN_MASK 0x3ff
> +
> +#define MLXBF_ADD_INFO 0x364
> +#define MLXBF_ADD_INFO__ERR_PRANK_SHIFT 8
> +#define MLXBF_ADD_INFO__ERR_PRANK_MASK 0x3

Thanks for changing these to shifts/masks, this is one fewer dependency on the compiler's
implementation choices being exactly as you expect.


> +#define MLXBF_EDAC_MAX_DIMM_PER_MC	2
> +#define MLXBF_EDAC_ERROR_GRAIN		8
> +
> +/*
> + * Request MLNX_SIP_GET_DIMM_INFO
> + *
> + * Retrieve information about DIMM on a certain slot.
> + *
> + * Call register usage:
> + * a0: MLNX_SIP_GET_DIMM_INFO
> + * a1: (Memory controller index) << 16 | (Dimm index in memory controller)
> + * a2-7: not used.
> + *
> + * Return status:
> + * a0: dimm_info_smc union defined below describing the DIMM.
> + * a1-3: not used.
> + */
> +#define MLNX_SIP_GET_DIMM_INFO		0x82000008
> +
> +/* Format for the SMC response about the memory information */
> +union dimm_info_smc {
> +	struct {
> +		unsigned long size_GB : 16;
> +		unsigned long is_rdimm : 1;
> +		unsigned long is_lrdimm : 1;
> +		unsigned long is_nvdimm : 1;
> +		unsigned long __reserved0 : 2;
> +		unsigned long ranks : 3;
> +		unsigned long package_X : 8;	/* Bits per memory package */
> +		unsigned long __reserved1 : 32;
> +	};
> +	unsigned long val;
> +};

But this is still fragile. The compiler is allowed to pack this thing as it likes. You
must have your firmware and kernel built with the same compiler. If firmware/kernel differ
in endian-ness (which is entirely possible on arm64), this could go haywire. (the value is
only passed via registers, which might save you, but its not clear to me)


> +/*
> + * Gather the ECC information from the External Memory Interface registers
> + * and report it to the edac handler.
> + */
> +static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
> +					int error_cnt,
> +					int is_single_ecc)
> +{
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	u32 dram_additional_info, err_prank;
> +	u32 ecc_latch_select = 0, dram_syndrom = 0, serr, derr, syndrom;
> +	enum hw_event_mc_err_type ecc_type;
> +	unsigned long ecc_dimm_addr;
> +	int ecc_dimm;
> +	u32 edea0;
> +	u32 edea1;
> +
> +	ecc_type = is_single_ecc ? HW_EVENT_ERR_CORRECTED :
> +				   HW_EVENT_ERR_UNCORRECTED;
> +
> +	/*
> +	 * Tell the External Memory Interface to populate the relevant
> +	 * registers with information about the last ECC error occurrence.
> +	 */
> +	ecc_latch_select |= 1 << MLXBF_ECC_LATCH_SEL__START_SHIFT;
> +	writel(ecc_latch_select, priv->emi_base + MLXBF_ECC_LATCH_SEL);
> +
> +	/*
> +	 * Verify that the ECC reported info in the registers is of the
> +	 * same type as the one asked to report. If not, just report the
> +	 * error without the detailed information.
> +	 */
> +	dram_syndrom = readl(priv->emi_base + MLXBF_SYNDROM);
> +	serr = (dram_syndrom >> MLXBF_SYNDROM__SERR_SHIFT) &
> +		MLXBF_SYNDROM__SERR_MASK;
> +	derr = (dram_syndrom >> MLXBF_SYNDROM__DERR_SHIFT) &
> +		MLXBF_SYNDROM__DERR_MASK;
> +	syndrom = (dram_syndrom >> MLXBF_SYNDROM__SYN_SHIFT) &
> +		MLXBF_SYNDROM__SYN_MASK;
> +
> +	if ((is_single_ecc && !serr) || (!is_single_ecc && !derr)) {
> +		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
> +				     0, 0, -1, mci->ctl_name, "");
> +		return;
> +	}
> +
> +	dram_additional_info = readl(priv->emi_base + MLXBF_ADD_INFO);
> +	err_prank = (dram_additional_info >> MLXBF_ADD_INFO__ERR_PRANK_SHIFT) &
> +		MLXBF_ADD_INFO__ERR_PRANK_MASK;


> +	ecc_dimm = err_prank >= 2 && priv->dimm_ranks[0] <= 2;

You are relying on this only generating 0 or 1, whereas the expression gives false/true.
The compiler may pick a value of true that isn't 1.

Something like?:
| ecc_dimm = err_prank;
| if (ecc_dimm > priv->dimm_ranks[0])
| 	ecc_dimm = 0;


> +	edea0 = readl(priv->emi_base + MLXBF_ERR_ADDR_0);
> +	edea1 = readl(priv->emi_base + MLXBF_ERR_ADDR_1);
> +
> +	ecc_dimm_addr = ((unsigned long)edea1 << 32) | edea0;
> +
> +	edac_mc_handle_error(ecc_type, mci, error_cnt,

> +			     PFN_DOWN(ecc_dimm_addr), ecc_dimm_addr & PAGE_MASK,

Don't you want ~PAGE_MASK here? arm64 has:
| #define PAGE_MASK                (~(PAGE_SIZE-1))

so this is all the high bits.

I've recently learnt mm.h has offset_in_page() which is going to be the best thing to use
here.


> +			     syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
> +}


> +/* Initialize the DIMMs information for the given memory controller. */
> +static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
> +{
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	int mem_ctrl_idx = mci->mc_idx;
> +	union dimm_info_smc smc_info;
> +	struct dimm_info *dimm;
> +	unsigned long smc_arg;
> +	int is_empty = 1;
> +	int i;
> +
> +	for (i = 0; i < priv->dimm_per_mc; i++) {
> +		dimm = mci->dimms[i];
> +
> +		smc_arg = mem_ctrl_idx << 16 | i;
> +		smc_info = (union dimm_info_smc) {
> +			.val = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg),
> +		};
> +		if (!smc_info.size_GB) {
> +			dimm->mtype = MEM_EMPTY;
> +			continue;
> +		}
> +
> +		is_empty = 0;
> +
> +		dimm->edac_mode = EDAC_SECDED;
> +
> +		if (smc_info.is_nvdimm)
> +			dimm->mtype = MEM_NVDIMM;
> +		else if (smc_info.is_lrdimm)
> +			dimm->mtype = MEM_LRDDR4;
> +		else if (smc_info.is_rdimm)
> +			dimm->mtype = MEM_RDDR4;
> +		else
> +			dimm->mtype = MEM_DDR4;
> +
> +		dimm->nr_pages = smc_info.size_GB * (SZ_1G / PAGE_SIZE);
> +		dimm->grain = MLXBF_EDAC_ERROR_GRAIN;
> +
> +		/* Mem controller for BlueField only supports x4, x8 and x16 */
> +		if (smc_info.package_X == 4)
> +			dimm->dtype = DEV_X4;
> +		else if (smc_info.package_X == 8)
> +			dimm->dtype = DEV_X8;
> +		else if (smc_info.package_X == 16)
> +			dimm->dtype = DEV_X16;
> +		else
> +			dimm->dtype = DEV_UNKNOWN;
> +
> +		priv->dimm_ranks[i] = smc_info.ranks;

dimm_ranks[] has size MLXBF_EDAC_MAX_DIMM_PER_MC, but dimm_per_mc is a number from
firmware. Where do you check dimm_per_mc < MLXBF_EDAC_MAX_DIMM_PER_MC?


> +	}
> +
> +	if (is_empty)
> +		mci->edac_cap = EDAC_FLAG_NONE;
> +	else
> +		mci->edac_cap = EDAC_FLAG_SECDED;
> +}



> +static int bluefield_edac_mc_probe(struct platform_device *pdev)
> +{
> +	struct bluefield_edac_priv *priv;
> +	struct device *dev = &pdev->dev;
> +	struct edac_mc_layer layers[1];
> +	struct mem_ctl_info *mci;
> +	struct resource *emi_res;
> +	unsigned int mc_idx, dimm_count;
> +	int rc, ret;


> +	/* Read the MSS (Memory SubSystem) index from ACPI table. */
> +	if (device_property_read_u32(dev, "mss_number", &mc_idx)) {
> +		dev_warn(dev, "bf_edac: MSS number unknown\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Read the MSS (Memory SubSystem) index from ACPI table. */
> +	if (device_property_read_u32(dev, "dimm_per_mc", &dimm_count)) {
> +		dev_warn(dev, "bf_edac: DIMMs per MC unknown\n");
> +		return -EINVAL;
> +	}

These two have the same comment, but do different things.

> +	emi_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!emi_res)
> +		return -EINVAL;
> +
> +	layers[0].type = EDAC_MC_LAYER_SLOT;
> +	layers[0].size = dimm_count;
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*priv));
> +	if (!mci)
> +		return -ENOMEM;
> +
> +	priv = mci->pvt_info;
> +
> +	priv->dimm_per_mc = dimm_count;
> +	priv->emi_base = devm_ioremap_resource(dev, emi_res);
> +	if (IS_ERR(priv->emi_base)) {
> +		dev_err(dev, "failed to map EMI IO resource\n");
> +		ret = PTR_ERR(priv->emi_base);
> +		goto err;
> +	}
> +
> +	mci->pdev = dev;
> +	mci->mtype_cap = MEM_FLAG_DDR4 | MEM_FLAG_RDDR4 |
> +			 MEM_FLAG_LRDDR4 | MEM_FLAG_NVDIMM;
> +	mci->edac_ctl_cap = EDAC_FLAG_SECDED;
> +
> +	mci->mod_name = DRIVER_NAME;
> +	mci->ctl_name = "BlueField_Memory_Controller";
> +	mci->dev_name = dev_name(dev);
> +	mci->edac_check = bluefield_edac_check;
> +
> +	/* Initialize mci with the actual populated DIMM information. */
> +	bluefield_edac_init_dimms(mci);
> +
> +	platform_set_drvdata(pdev, mci);
> +
> +	/* Register with EDAC core */
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		dev_err(dev, "failed to register with EDAC core\n");
> +		ret = rc;
> +		goto err;
> +	}
> +
> +	/* Only POLL mode supported so far. */
> +	edac_op_state = EDAC_OPSTATE_POLL;


> +	return 0;
> +
> +err:
> +	edac_mc_free(mci);
> +
> +	return ret;
> +
> +}

With the MLXBF_EDAC_MAX_DIMM_PER_MC check and offset_in_page()/~PAGE_MASK:

Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James


[0]
https://static.docs.arm.com/den0028/b/ARM_DEN0028B_SMC_Calling_Convention.pdf

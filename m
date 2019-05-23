Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B3E284F1
	for <lists+linux-edac@lfdr.de>; Thu, 23 May 2019 19:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfEWR3q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 23 May 2019 13:29:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51476 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730957AbfEWR3q (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 23 May 2019 13:29:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DF7F374;
        Thu, 23 May 2019 10:29:45 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020A63F5AF;
        Thu, 23 May 2019 10:29:43 -0700 (PDT)
Subject: Re: [PATCH v3] EDAC, mellanox: Add ECC support for BlueField DDR4
To:     Junhan Zhou <Junhan@mellanox.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1553178667-21073-1-git-send-email-Junhan@mellanox.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d0d3ee30-8f9c-521f-9915-50d8ac3913dc@arm.com>
Date:   Thu, 23 May 2019 18:29:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553178667-21073-1-git-send-email-Junhan@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Junhan,

On 21/03/2019 14:31, Junhan Zhou wrote:
> Add ECC support for Mellanox BlueField SoC DDR controller.
> This requires SMC to the running Arm Trusted Firmware to report
> what is the current memory configuration.

Sorry for the delay on this, it slipped through the cracks. (Please don't reply with new
patches to the discussion of an old patch/series, this makes it look like ongoing
discussion on a v1, and v2 never arrives!)


> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 47eb4d1..404d853 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -504,4 +504,11 @@ config EDAC_ASPEED
>  	  First, ECC must be configured in the bootloader. Then, this driver
>  	  will expose error counters via the EDAC kernel framework.
>  
> +config EDAC_BLUEFIELD
> +	tristate "Mellanox BlueField Memory ECC"
> +	depends on ARM64 && ((MELLANOX_PLATFORM && ACPI) || COMPILE_TEST)

What is the MELLANOX_PLATFORM needed for? Is it just to turn off a set of drivers in one
go? I can't see what other infrastructure you depend on.


> +	help
> +	  Support for error detection and correction on the
> +	  Mellanox BlueField SoCs.
> +
>  endif # EDAC


> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> new file mode 100644
> index 0000000..88f51f7
> --- /dev/null
> +++ b/drivers/edac/bluefield_edac.c
> @@ -0,0 +1,396 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Bluefield-specific EDAC driver.
> + *
> + * Copyright (c) 2019 Mellanox Technologies.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
> +#include <linux/edac.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +#include "edac_module.h"
> +
> +#define DRIVER_NAME		"bluefield-edac"
> +
> +/*
> + * Mellanox BlueField EMI (External Memory Interface) register definitions.
> + * Registers which have individual bitfields have a union defining the
> + * bitfields following the address define.
> + */
> +
> +#define MLXBF_EMI_DRAM_ECC_COUNT 0x340
> +
> +union mlxbf_emi_dram_ecc_count {
> +	struct {
> +		u32 single_error_count : 16;
> +		u32 double_error_count : 16;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ECC_ERROR 0x348
> +
> +union mlxbf_emi_dram_ecc_error {
> +	struct {
> +		u32 dram_ecc_single : 1;
> +		u32 __reserved_0    : 15;
> +		u32 dram_ecc_double : 1;
> +		u32 __reserved_1    : 15;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT 0x354
> +
> +union mlxbf_emi_dram_ecc_latch_select {
> +	struct {
> +		u32 dram_ecc_first : 1;
> +		u32 __reserved_0   : 15;
> +		u32 edge_sel       : 4;
> +		u32 __reserved_1   : 4;
> +		u32 start          : 1;
> +		u32 __reserved_2   : 7;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_0 0x358
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_1 0x37c
> +
> +#define MLXBF_EMI_DRAM_SYNDROM 0x35c
> +
> +union mlxbf_emi_dram_syndrom {
> +	struct {
> +		u32 derr         : 1;
> +		u32 serr         : 1;
> +		u32 __reserved_0 : 14;
> +		/* ECC syndrome (error bit according to the Hamming code). */
> +		u32 syndrom      : 10;
> +		u32 __reserved_1 : 6;
> +	};
> +
> +	u32 word;
> +};
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0 0x364
> +
> +union mlxbf_emi_dram_additional_info_0 {
> +	struct {
> +		u32 err_bank     : 4;
> +		u32 err_lrank    : 2;
> +		u32 __reserved_0 : 2;
> +		u32 err_prank    : 2;
> +		u32 __reserved_1 : 6;
> +		u32 err_edge     : 8;
> +		u32 __reserved_2 : 8;
> +	};
> +
> +	u32 word;
> +};

... you're expecting the compiler to pack this bitfield in exactly the same way your
hardware did. I don't think that's guaranteed.
It evidently works for your current compiler, but another compiler may pack this structure
differently. Toggling endianness will break this, (arm64 supports both). If your platform
supports aarch32, someone may want to get 32bit arm running, which may have different
compiler behaviour.

You are also using bitfields between hardware and firmware, so its currently possible the
firmware requires the kernel to be built with a compiler that means it can't interact with
the hardware...

When this has come up in the past, the advice was not to use bitfields:
https://lore.kernel.org/lkml/1077080607.1078.109.camel@gaston/

Please use shifts and masks.


> +#define MLXBF_EDAC_DIMM_PER_MC		2
> +#define MLXBF_EDAC_ERROR_GRAIN		8

If these numbers changed, would it still be a BlueField SoC?
(if next years made-up:BlueField2 supports more Dimms per MC, it would be better to make
this a property in the firmware table).


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

Have Mellanox published these call numbers/arguments in a document somewhere? If they
differ with the firmware, it would be good to know which side needs fixing.

It is a little odd that you read the number of memory controllers from the ACPI table, but
use an SMC call to read the DIMM information.
Is it too-late to describe the DIMMs in the ACPI table too? (this would let firmware
hard-code it on platforms where it could never change, instead of having to support a
runtime call)

The DIMM information should also be in the SMBIOS table. See ghes_edac.c for some code
that uses this. SMBIOS isn't popular in the arm world: but edac already uses this, and we
want to match DIMM numbers with the text on the board's silk-screen so the user can
replace the correct DIMM.


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

If your firmware and the kernel were built with different compilers, this isn't guaranteed
to work. Please use shifts and masks.


> +struct bluefield_edac_priv {
> +	int dimm_ranks[MLXBF_EDAC_DIMM_PER_MC];
> +	void __iomem *emi_base;
> +};
> +
> +static unsigned long smc_call1(unsigned long smc_op, unsigned long smc_arg)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(smc_op, smc_arg, 0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +/*
> + * Gather the ECC information from the External Memory Interface registers
> + * and report it to the edac handler.
> + */
> +static void bluefield_gather_report_ecc(struct mem_ctl_info *mci,
> +					int error_cnt,
> +					int is_single_ecc)
> +{
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	union mlxbf_emi_dram_additional_info_0 edai0;
> +	union mlxbf_emi_dram_ecc_latch_select edels;
> +	union mlxbf_emi_dram_syndrom eds;
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
> +	edels.word = 0;
> +	edels.start = 1;


> +	writel(edels.word, priv->emi_base + MLXBF_EMI_DRAM_ECC_LATCH_SELECT);
> +
> +	/*
> +	 * Verify that the ECC reported info in the registers is of the
> +	 * same type as the one asked to report. If not, just report the
> +	 * error without the detailed information.
> +	 */
> +	eds.word = readl(priv->emi_base + MLXBF_EMI_DRAM_SYNDROM);

Does the device need to have seen the write to MLXBF_EMI_DRAM_ECC_LATCH_SELECT before it
sees this read?

Will Deacon gave a presentation on this stuff at ELCE:
https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf

(I don't understand this stuff, so may have it totally wrong here:)

From the arch code's definitions of these:
| #define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
| #define readl(c)	({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })

This means you've got back-to-back writel_relaxed()/readl_relaxed() here, and probably
need an mb() between them.

(slides 17 and 19 of that pdf are handy).

As an example,
drivers/edac/cell.c::cell_edac_check() has this out_be64(); mb(); in_be64() sequence,
which I think is the same.


> +	if ((is_single_ecc && !eds.serr) || (!is_single_ecc && !eds.derr)) {
> +		edac_mc_handle_error(ecc_type, mci, error_cnt, 0, 0, 0,
> +				     0, 0, -1, mci->ctl_name, "");
> +		return;
> +	}
> +
> +	edai0.word = readl(priv->emi_base + MLXBF_EMI_DRAM_ADDITIONAL_INFO_0);
> +
> +	ecc_dimm = edai0.err_prank >= 2 && priv->dimm_ranks[0] <= 2;
> +
> +	edea0 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_0);
> +	edea1 = readl(priv->emi_base + MLXBF_EMI_DRAM_ERR_ADDR_1);
> +
> +	ecc_dimm_addr = ((unsigned long)edea1 << 32) | edea0;
> +
> +	edac_mc_handle_error(ecc_type, mci, error_cnt,

> +			     ecc_dimm_addr / 0x1000,

Please use PFN_DOWN() to take account of the (configurable!) kernel PAGE_SIZE.


> 			     ecc_dimm_addr & 0xfff,
Please use something like PAGE_MASK, to take account of the PAGE_SIZE.


> +			     eds.syndrom, ecc_dimm, 0, 0, mci->ctl_name, "");
> +}
> +
> +static void bluefield_edac_check(struct mem_ctl_info *mci)
> +{
> +	union mlxbf_emi_dram_ecc_error edee = { .word = 0 };
> +	struct bluefield_edac_priv *priv = mci->pvt_info;
> +	union mlxbf_emi_dram_ecc_count edec;
> +
> +	/*
> +	 * The memory controller might not be initialized by the firmware
> +	 * when there isn't memory, which may lead to bad register readings.
> +	 */
> +	if (mci->edac_cap == EDAC_FLAG_NONE)
> +		return;
> +
> +	edec.word = readl(priv->emi_base + MLXBF_EMI_DRAM_ECC_COUNT);
> +
> +	if (edec.single_error_count) {
> +		edee.dram_ecc_single = 1;
> +
> +		bluefield_gather_report_ecc(mci, edec.single_error_count, 1);
> +	}
> +
> +	if (edec.double_error_count) {
> +		edee.dram_ecc_double = 1;
> +
> +		bluefield_gather_report_ecc(mci, edec.double_error_count, 0);
> +	}
> +
> +	/* Write to clear reported errors. */
> +	if (edec.word)
> +		writel(edee.word, priv->emi_base + MLXBF_EMI_DRAM_ECC_ERROR);
> +}
> +
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
> +	for (i = 0; i < MLXBF_EDAC_DIMM_PER_MC; i++) {
> +		dimm = mci->dimms[i];
> +
> +		smc_arg = mem_ctrl_idx << 16 | i;
> +		smc_info = (union dimm_info_smc) {
> +			.val = smc_call1(MLNX_SIP_GET_DIMM_INFO, smc_arg),
> +		};
> +
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
> +		dimm->nr_pages = smc_info.size_GB * 256 * 1024;

How come PAGE_SIZE doesn't appear here?
You may want to use SZ_1G and friends as part of the calculation to make it more readable.


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
> +	}
> +
> +	if (is_empty)
> +		mci->edac_cap = EDAC_FLAG_NONE;
> +	else
> +		mci->edac_cap = EDAC_FLAG_SECDED;
> +}


Thanks,

James

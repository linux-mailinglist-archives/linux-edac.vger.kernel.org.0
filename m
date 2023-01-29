Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A82680227
	for <lists+linux-edac@lfdr.de>; Sun, 29 Jan 2023 23:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjA2WLJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Jan 2023 17:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjA2WLJ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 29 Jan 2023 17:11:09 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1911C33D;
        Sun, 29 Jan 2023 14:11:04 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D25D41EC0513;
        Sun, 29 Jan 2023 23:11:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675030262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hEE3etqCxFjPAKFas1zS76ikeOSRqUC1N58ZfnfEbGg=;
        b=Q9WzbXPvmLVtYQS78yAepKQrT+pxuWNpeQZ4W8+VxxW4Fk96jBGS+S90R1tjnWc+9YEL7u
        x6dR/aLV3S9hzfN71YZS6Td5QY2E06YaF2qYj2GbQqjNe1VC8vELbE1JY3looucmSv2w4X
        OSS4rz170KBfdvwgwrnpdNW4n5lK9m8=
Date:   Sun, 29 Jan 2023 23:10:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc:     linux-edac@vger.kernel.org, git@amd.com, michal.simek@xilinx.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, mchehab@kernel.org, tony.luck@intel.com
Subject: Re: [PATCH v3 2/2] edac: xilinx: Added EDAC support for Xilinx DDR
 controller
Message-ID: <Y9bu8CpiVKvFS1d+@zn.tnic>
References: <20230117054100.8377-1-shubhrajyoti.datta@amd.com>
 <20230117054100.8377-3-shubhrajyoti.datta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230117054100.8377-3-shubhrajyoti.datta@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 17, 2023 at 11:11:00AM +0530, Shubhrajyoti Datta wrote:

> Subject: Re: [PATCH v3 2/2] edac: xilinx: Added EDAC support for Xilinx DDR  controller

The subject format in the EDAC subsystem is:

EDAC/<driver>: <Verb> ...

Yours should be something like:

EDAC/versal: Add a Xilinx Versal memory controller driver

Please don't be afraid to do

$ git log -p drivers/edac/

and look at previous patches to get an idea.

> Add EDAC support for Xilinx DDR Controller, this driver
> reports Correctable and Uncorrectable errors , and also creates

No need to write error types capitalized.

> debugfs entries for error injection.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v3:
> Rebased and resent.
> 
> Changes in v2:
> Update a missed out file
> remove edac from compatible name
> rename ddrmc_noc_base and ddrmc_base
> 
>  MAINTAINERS                          |    7 +
>  drivers/edac/Kconfig                 |   11 +
>  drivers/edac/Makefile                |    1 +
>  drivers/edac/xilinx_ddrmc_edac.c     | 1251 ++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h |   10 +
>  5 files changed, 1280 insertions(+)
>  create mode 100644 drivers/edac/xilinx_ddrmc_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cf0f18502372..cfeece1d75c5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22631,6 +22631,13 @@ S:	Maintained
>  F:	drivers/soc/xilinx/xlnx_event_manager.c
>  F:	include/linux/firmware/xlnx-event-manager.h
>  
> +XILINX VERSAL DDRMC EDAC DRIVER

I wanna say that "DDRMC" needs to go. What's the poignancy of this "DDR Memory
Controller" and why does it have to be there?

> +M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
> +F:	drivers/edac/xilinx_ddrmc_edac.c
> +
>  XILLYBUS DRIVER
>  M:	Eli Billauer <eli.billauer@gmail.com>
>  L:	linux-kernel@vger.kernel.org
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 456602d373b7..6c32fa4b980d 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -541,4 +541,15 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
>  
> +config EDAC_XILINX_DDR

EDAC_VERSAL and so on.

Please check all your nomenclature, choose a special naming and stick with it -
not a row of abbreviations which don't mean a whole lot to users. See how the
other drivers are called - that might give you a good idea.

> +	tristate "Xilinx Versal DDR Memory Controller"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  Support for error detection and correction on the Xilinx Versal DDR
> +	  memory controller.
> +
> +	  Report both Single Bit Errors (CE) and Double Bit Errors (UE).
> +	  Support injecting both Correctable and UnCorrectable errors for debug
> +	  purpose using sysfs entries.

No need for capitalized words - this is not vendor documentation. Please check
all your strings.

>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 2d1641a27a28..2f20e0f53ca6 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -83,4 +83,5 @@ obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
> +obj-$(CONFIG_EDAC_XILINX_DDR)		+= xilinx_ddrmc_edac.o

This is what I mean: there's "Xilinx", "DDR", "ddrmc", "Versal" and so on.

>  obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> diff --git a/drivers/edac/xilinx_ddrmc_edac.c b/drivers/edac/xilinx_ddrmc_edac.c
> new file mode 100644
> index 000000000000..a5ea6ce0fe63
> --- /dev/null
> +++ b/drivers/edac/xilinx_ddrmc_edac.c

Why can't this simply be called

versal_edac.c

?

We already have a ZynqMP one which is called zynqmp_edac...

> @@ -0,0 +1,1251 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Versal DDRC ECC Driver

I guess this "DDRC" is supposed to mean "DDRMC". And can you folks pls dial down
on the abbreviations? Why can't you simply say:

"Xilinx Versal memory controller driver"

?


> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/edac.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/sizes.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/firmware/xlnx-event-manager.h>
> +#include <linux/debugfs.h>
> +
> +#include "edac_module.h"
> +
> +/* Granularity of reported error in bytes */
> +#define XDDR_EDAC_ERR_GRAIN			1
> +
> +#define XDDR_EDAC_MSG_SIZE			256
> +
> +#define XDDR_PCSR_OFFSET			0xC
> +#define XDDR_ISR_OFFSET				0x14
> +#define XDDR_IRQ_EN_OFFSET			0x20
> +#define XDDR_IRQ1_EN_OFFSET			0x2C
> +#define XDDR_IRQ_DIS_OFFSET			0x24
> +#define XDDR_IRQ_CE_MASK			GENMASK(18, 15)
> +#define XDDR_IRQ_UE_MASK			GENMASK(14, 11)
> +
> +#define XDDR_REG_CONFIG0_OFFSET			0x258
> +#define XDDR_REG_CONFIG0_BUS_WIDTH_MASK		GENMASK(19, 18)
> +#define XDDR_REG_CONFIG0_BUS_WIDTH_SHIFT	18
> +#define XDDR_REG_CONFIG0_NUM_CHANS_MASK		BIT(17)
> +#define XDDR_REG_CONFIG0_NUM_CHANS_SHIFT	17
> +#define XDDR_REG_CONFIG0_NUM_RANKS_MASK		GENMASK(15, 14)
> +#define XDDR_REG_CONFIG0_NUM_RANKS_SHIFT	14
> +#define XDDR_REG_CONFIG0_SIZE_MASK		GENMASK(10, 8)
> +#define XDDR_REG_CONFIG0_SIZE_SHIFT		8
> +
> +#define XDDR_REG_PINOUT_OFFSET			0x25C
> +#define XDDR_REG_PINOUT_ECC_EN_MASK		GENMASK(7, 5)
> +
> +#define ECCW0_FLIP_CTRL				0x109C
> +#define ECCW0_FLIP0_OFFSET			0x10A0
> +#define ECCW1_FLIP_CTRL				0x10AC
> +#define ECCW1_FLIP0_OFFSET			0x10B0
> +#define ECCR0_CERR_STAT_OFFSET			0x10BC
> +#define ECCR0_CE_ADDR_LO_OFFSET			0x10C0
> +#define ECCR0_CE_ADDR_LO_OFFSET			0x10C0

Oh look, those are repeated.

Please check them *all* for duplicates.

> +#define ECCR0_CE_ADDR_HI_OFFSET			0x10C4
> +#define ECCR0_CE_DATA_LO_OFFSET			0x10C8
> +#define ECCR0_CE_DATA_HI_OFFSET			0x10CC
> +#define ECCR0_CE_DATA_PAR_OFFSET		0x10D0
> +
> +#define ECCR0_UERR_STAT_OFFSET			0x10D4
> +#define ECCR0_UE_ADDR_LO_OFFSET			0x10D8
> +#define ECCR0_UE_ADDR_HI_OFFSET			0x10DC
> +#define ECCR0_UE_DATA_LO_OFFSET			0x10E0
> +#define ECCR0_UE_DATA_HI_OFFSET			0x10E4
> +#define ECCR0_UE_DATA_PAR_OFFSET		0x10E8
> +
> +#define ECCR1_CERR_STAT_OFFSET			0x10F4
> +#define ECCR1_CE_ADDR_LO_OFFSET			0x10F8
> +#define ECCR1_CE_ADDR_HI_OFFSET			0x10FC
> +#define ECCR1_CE_DATA_LO_OFFSET			0x1100
> +#define ECCR1_CE_DATA_HI_OFFSET			0x110C
> +#define ECCR1_CE_DATA_PAR_OFFSET		0x1108
> +
> +#define ECCR1_UERR_STAT_OFFSET			0x110C
> +#define ECCR1_UE_ADDR_LO_OFFSET			0x1110
> +#define ECCR1_UE_ADDR_HI_OFFSET			0x1114
> +#define ECCR1_UE_DATA_LO_OFFSET			0x1118
> +#define ECCR1_UE_DATA_HI_OFFSET			0x111C
> +#define ECCR1_UE_DATA_PAR_OFFSET		0x1120
> +
> +#define XDDR_NOC_REG_ADEC4_OFFSET		0x44
> +#define RANK_0_MASK				GENMASK(5, 0)
> +#define RANK_1_MASK				GENMASK(11, 6)
> +#define RANK_1_SHIFT				6
> +#define LRANK_0_MASK				GENMASK(17, 12)
> +#define LRANK_0_SHIFT				12
> +#define LRANK_1_MASK				GENMASK(23, 18)
> +#define LRANK_1_SHIFT				18
> +#define LRANK_2_MASK				GENMASK(29, 24)
> +#define LRANK_2_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC5_OFFSET		0x48
> +#define ROW_0_MASK				GENMASK(5, 0)
> +#define ROW_1_MASK				GENMASK(11, 6)
> +#define ROW_1_SHIFT				6
> +#define ROW_2_MASK				GENMASK(17, 12)
> +#define ROW_2_SHIFT				12
> +#define ROW_3_MASK				GENMASK(23, 18)
> +#define ROW_3_SHIFT				18
> +#define ROW_4_MASK				GENMASK(29, 24)
> +#define ROW_4_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC6_OFFSET		0x4C
> +#define ROW_5_MASK				GENMASK(5, 0)
> +#define ROW_6_MASK				GENMASK(11, 6)
> +#define ROW_6_SHIFT				6
> +#define ROW_7_MASK				GENMASK(17, 12)
> +#define ROW_7_SHIFT				12
> +#define ROW_8_MASK				GENMASK(23, 18)
> +#define ROW_8_SHIFT				18
> +#define ROW_9_MASK				GENMASK(29, 24)
> +#define ROW_9_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC7_OFFSET		0x50
> +#define ROW_10_MASK				GENMASK(5, 0)
> +#define ROW_11_MASK				GENMASK(11, 6)
> +#define ROW_11_SHIFT				6
> +#define ROW_12_MASK				GENMASK(17, 12)
> +#define ROW_12_SHIFT				12
> +#define ROW_13_MASK				GENMASK(23, 18)
> +#define ROW_13_SHIFT				18
> +#define ROW_14_MASK				GENMASK(29, 24)
> +#define ROW_14_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC8_OFFSET		0x54
> +#define ROW_15_MASK				GENMASK(5, 0)
> +#define ROW_16_MASK				GENMASK(11, 6)
> +#define ROW_16_SHIFT				6
> +#define ROW_17_MASK				GENMASK(17, 12)
> +#define ROW_17_SHIFT				12
> +#define ROW_18_MASK				GENMASK(23, 18)
> +#define ROW_18_SHIFT				18
> +#define COL_0_MASK				GENMASK(29, 24)
> +#define COL_0_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC9_OFFSET		0x58
> +#define COL_1_MASK				GENMASK(5, 0)
> +#define COL_2_MASK				GENMASK(11, 6)
> +#define COL_2_SHIFT				6
> +#define COL_3_MASK				GENMASK(17, 12)
> +#define COL_3_SHIFT				12
> +#define COL_4_MASK				GENMASK(23, 18)
> +#define COL_4_SHIFT				18
> +#define COL_5_MASK				GENMASK(29, 24)
> +#define COL_5_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC10_OFFSET		0x5C
> +#define COL_6_MASK				GENMASK(5, 0)
> +#define COL_7_MASK				GENMASK(11, 6)
> +#define COL_7_SHIFT				6
> +#define COL_8_MASK				GENMASK(17, 12)
> +#define COL_8_SHIFT				12
> +#define COL_9_MASK				GENMASK(23, 18)
> +#define COL_9_SHIFT				18
> +#define BANK_0_MASK				GENMASK(29, 24)
> +#define BANK_0_SHIFT				24
> +
> +#define XDDR_NOC_REG_ADEC11_OFFSET		0x60
> +#define BANK_1_MASK				GENMASK(5, 0)
> +#define GRP_0_MASK				GENMASK(11, 6)
> +#define GRP_0_SHIFT				6
> +#define GRP_1_MASK				GENMASK(17, 12)
> +#define GRP_1_SHIFT				12
> +#define CH_0_MASK				GENMASK(23, 18)
> +#define CH_0_SHIFT				18
> +
> +#define XDDR_NOC_REG_ADEC12_OFFSET		0x71C
> +#define XDDR_NOC_REG_ADEC13_OFFSET		0x720
> +
> +#define XDDR_NOC_REG_ADEC14_OFFSET		0x724
> +#define XDDR_NOC_ROW_MATCH_MASK			GENMASK(17, 0)
> +#define XDDR_NOC_COL_MATCH_MASK			GENMASK(27, 18)
> +#define XDDR_NOC_COL_MATCH_SHIFT		18
> +#define XDDR_NOC_BANK_MATCH_MASK		GENMASK(29, 28)
> +#define XDDR_NOC_BANK_MATCH_SHIFT		28
> +#define XDDR_NOC_GRP_MATCH_MASK			GENMASK(31, 30)
> +#define XDDR_NOC_GRP_MATCH_SHIFT		30
> +
> +#define XDDR_NOC_REG_ADEC15_OFFSET		0x728
> +#define XDDR_NOC_RANK_MATCH_MASK		GENMASK(1, 0)
> +#define XDDR_NOC_LRANK_MATCH_MASK		GENMASK(4, 2)
> +#define XDDR_NOC_LRANK_MATCH_SHIFT		2
> +#define XDDR_NOC_CH_MATCH_MASK			BIT(5)
> +#define XDDR_NOC_CH_MATCH_SHIFT			5
> +#define XDDR_NOC_MOD_SEL_MASK			BIT(6)
> +#define XDDR_NOC_MATCH_EN_MASK			BIT(8)
> +
> +#define ECCR_UE_CE_ADDR_LO_BP_MASK		GENMASK(2, 0)
> +#define ECCR_UE_CE_ADDR_LO_LRANK_MASK		GENMASK(5, 3)
> +#define ECCR_UE_CE_ADDR_LO_LRANK_SHIFT		3
> +#define ECCR_UE_CE_ADDR_LO_RANK_MASK		GENMASK(7, 6)
> +#define ECCR_UE_CE_ADDR_LO_RANK_SHIFT		6
> +#define ECCR_UE_CE_ADDR_LO_GRP_MASK		GENMASK(9, 8)
> +#define ECCR_UE_CE_ADDR_LO_GRP_SHIFT		8
> +#define ECCR_UE_CE_ADDR_LO_BANK_MASK		GENMASK(11, 10)
> +#define ECCR_UE_CE_ADDR_LO_BANK_SHIFT		10
> +#define ECCR_UE_CE_ADDR_LO_COL_MASK		GENMASK(21, 12)
> +#define ECCR_UE_CE_ADDR_LO_COL_SHIFT		12
> +#define ECCR_UE_CE_ADDR_LO_ROW_MASK		GENMASK(31, 22)
> +#define ECCR_UE_CE_ADDR_LO_ROW_SHIFT		22
> +#define ECCR_UE_CE_ADDR_HI_ROW_MASK		GENMASK(7, 0)
> +#define ECCR_UE_CE_ADDR_HI_ROW_SHIFT		10
> +
> +#define XDDR_EDAC_NR_CSROWS			1
> +#define XDDR_EDAC_NR_CHANS			1
> +
> +#define XDDR_BUS_WIDTH_64			0
> +#define XDDR_BUS_WIDTH_32			1
> +#define XDDR_BUS_WIDTH_16			2
> +
> +#define ECC_CEPOISON_MASK			0x1
> +#define ECC_UEPOISON_MASK			0x3
> +
> +#define XDDR_MAX_ROW_CNT			18
> +#define XDDR_MAX_COL_CNT			10
> +#define XDDR_MAX_RANK_CNT			2
> +#define XDDR_MAX_LRANK_CNT			3
> +#define XDDR_MAX_BANK_CNT			2
> +#define XDDR_MAX_GRP_CNT			2
> +
> +#define PCSR_UNLOCK_VAL				0xF9E8D7C6
> +#define XDDR_ERR_TYPE_CE			0
> +#define XDDR_ERR_TYPE_UE			1
> +
> +#define XILINX_DRAM_SIZE_4G			0
> +#define XILINX_DRAM_SIZE_6G			1
> +#define XILINX_DRAM_SIZE_8G			2
> +#define XILINX_DRAM_SIZE_12G			3
> +#define XILINX_DRAM_SIZE_16G			4
> +#define XILINX_DRAM_SIZE_32G			5

Oh wow, that's a *lot* of defines!

How about unifying them?

All those rank masks look the same.

> +#define XDDR_CE_TRIGGER_CHAR            'C'

<---- newline here.

And trigger character?

> +/**
> + * struct ecc_error_info - ECC error log information.
> + * @rank:		Rank number.
> + * @lrank:		Logical Rank number.
> + * @row:		Row number.
> + * @col:		Column number.
> + * @bank:		Bank number.
> + * @group:		Group number.
> + * @burstpos:		Burst position.
> + */
> +struct ecc_error_info {
> +	u32 rank;
> +	u32 lrank;
> +	u32 row;
> +	u32 col;
> +	u32 bank;
> +	u32 group;
> +	u32 burstpos;
> +};
> +
> +/**
> + * struct ecc_status - ECC status information to report.
> + * @ceinfo:	Correctable error log information.
> + * @ueinfo:	Uncorrectable error log information.
> + * @channel:	Channel number.
> + * @error_type:	Error type information.
> + */
> +struct ecc_status {
> +	struct ecc_error_info ceinfo[2];
> +	struct ecc_error_info ueinfo[2];
> +	u32 channel;
> +	u8 error_type;
> +};
> +
> +/**
> + * struct edac_priv - DDR memory controller private instance data.
> + * @ddrmc_baseaddr:	Base address of the DDR controller.
> + * @ddrmc_noc_baseaddr:	Base address of the DDRMC NOC.
> + * @message:		Buffer for framing the event specific info.
> + * @mc_id:		Memory controller ID.
> + * @ce_cnt:		Correctable error count.
> + * @ue_cnt:		UnCorrectable error count.
> + * @stat:		ECC status information.
> + * @lrank_bit:		Bit shifts for lrank bit.
> + * @rank_bit:		Bit shifts for rank bit.
> + * @row_bit:		Bit shifts for row bit.
> + * @col_bit:		Bit shifts for column bit.
> + * @bank_bit:		Bit shifts for bank bit.
> + * @grp_bit:		Bit shifts for group bit.
> + * @ch_bit:		Bit shifts for channel bit.
> + * @err_inject_addr:	Data poison address.
> + * @debugfs:		Debugfs handle.
> + */
> +struct edac_priv {
> +	void __iomem *ddrmc_baseaddr;
> +	void __iomem *ddrmc_noc_baseaddr;
> +	char message[XDDR_EDAC_MSG_SIZE];
> +	u32 mc_id;
> +	u32 ce_cnt;
> +	u32 ue_cnt;
> +	struct ecc_status stat;
> +	u32 lrank_bit[3];
> +	u32 rank_bit[2];
> +	u32 row_bit[18];
> +	u32 col_bit[10];
> +	u32 bank_bit[2];
> +	u32 grp_bit[2];
> +	u32 ch_bit;
> +#ifdef CONFIG_EDAC_DEBUG
> +	u32 err_inject_addr;
> +#endif
> +	struct dentry *debugfs;

All your debugfs code should be behind CONFIG_EDAC_DEBUG. Audit your whole
driver.

> +};
> +
> +static struct dentry *xddr_debugfs;

No, this is not how this is done. See how drivers/edac/zynqmp_edac.c does it.

> +
> +/**
> + * get_error_info - Get the current ECC error info.
> + * @priv:	DDR memory controller private instance data.
> + *
> + * Return: one if there is no error otherwise returns zero.

Let's look at the callsite:

        status = get_error_info(priv);
        if (status)
                return IRQ_NONE;

This is far from intuitive.

So this function wants to be bool:

bool get_error_info()

and you do

	if (!get_error_info(priv))
		return IRQ_NONE;

> + */
> +static int get_error_info(struct edac_priv *priv)
> +{
> +	u32 eccr0_ceval, eccr1_ceval, eccr0_ueval, eccr1_ueval, regval;
> +	void __iomem *ddrmc_base;
> +	struct ecc_status *p;
> +
> +	ddrmc_base = priv->ddrmc_baseaddr;
> +	p = &priv->stat;
> +
> +	eccr0_ceval = readl(ddrmc_base + ECCR0_CERR_STAT_OFFSET);
> +	eccr1_ceval = readl(ddrmc_base + ECCR1_CERR_STAT_OFFSET);
> +	eccr0_ueval = readl(ddrmc_base + ECCR0_UERR_STAT_OFFSET);
> +	eccr1_ueval = readl(ddrmc_base + ECCR1_UERR_STAT_OFFSET);
> +
> +	if (!eccr0_ceval && !eccr1_ceval && !eccr0_ueval && !eccr1_ueval)
> +		return 1;
> +	else if (!eccr0_ceval && !eccr1_ceval)
> +		goto ue_err;
> +	else if (!eccr0_ceval)
> +		p->channel = 1;
> +	else
> +		p->channel = 0;

This looks weird. Why don't you test directly?

	if (eccr0_ceval || eccr1_ceval)
		return get_ce_error_info()
	else if (eccr0_ueval || eccr1_ueval)
		return get_ue_error_info();

and the rest you handle in those helpers where you put all those humongous
picking apart of values from registers.

> +
> +	p->error_type = XDDR_ERR_TYPE_CE;
> +	regval = readl(ddrmc_base + ECCR0_CE_ADDR_LO_OFFSET);
> +	p->ceinfo[0].burstpos = (regval & ECCR_UE_CE_ADDR_LO_BP_MASK);
> +	p->ceinfo[0].lrank = (regval & ECCR_UE_CE_ADDR_LO_LRANK_MASK) >>
> +					ECCR_UE_CE_ADDR_LO_LRANK_SHIFT;
> +	p->ceinfo[0].rank = (regval & ECCR_UE_CE_ADDR_LO_RANK_MASK) >>
> +					ECCR_UE_CE_ADDR_LO_RANK_SHIFT;
> +	p->ceinfo[0].group = (regval & ECCR_UE_CE_ADDR_LO_GRP_MASK) >>
> +					ECCR_UE_CE_ADDR_LO_GRP_SHIFT;
> +	p->ceinfo[0].bank = (regval & ECCR_UE_CE_ADDR_LO_BANK_MASK) >>
> +					ECCR_UE_CE_ADDR_LO_BANK_SHIFT;
> +	p->ceinfo[0].col = (regval & ECCR_UE_CE_ADDR_LO_COL_MASK) >>
> +					ECCR_UE_CE_ADDR_LO_COL_SHIFT;
> +	p->ceinfo[0].row = (regval & ECCR_UE_CE_ADDR_LO_ROW_MASK) >>
> +					ECCR_UE_CE_ADDR_LO_ROW_SHIFT;
> +	regval = readl(ddrmc_base + ECCR0_CE_ADDR_HI_OFFSET);
> +	p->ceinfo[0].row |= ((regval & ECCR_UE_CE_ADDR_HI_ROW_MASK) <<
> +					ECCR_UE_CE_ADDR_HI_ROW_SHIFT);

Seeing how this regval is split into fields, this is begging to be a u32
bitfield where you can read in the register value and the compiler would do the
splitting for you.

And then you won't need all those defines and unreadable manipulations.

...

> +
> +/**
> + * convert_to_physical - Convert to physical address.
> + * @priv:	DDR memory controller private instance data.
> + * @pinf:	ECC error info structure.
> + *
> + * Return: Physical address of the DDR memory.
> + */
> +static ulong convert_to_physical(struct edac_priv *priv,

Please stick to one type - there's "ulong" and "unsigned long" in this driver.
I'd advise against that typedef and simply use "unsigned long".

> +				 struct ecc_error_info pinf)
> +{
> +	ulong err_addr = 0;
> +	u32 index;
> +
> +	for (index = 0; index < XDDR_MAX_ROW_CNT; index++) {
> +		err_addr |= (pinf.row & BIT(0)) << priv->row_bit[index];
> +		pinf.row >>= 1;
> +	}
> +
> +	for (index = 0; index < XDDR_MAX_COL_CNT; index++) {
> +		err_addr |= (pinf.col & BIT(0)) << priv->col_bit[index];
> +		pinf.col >>= 1;
> +	}
> +
> +	for (index = 0; index < XDDR_MAX_BANK_CNT; index++) {
> +		err_addr |= (pinf.bank & BIT(0)) << priv->bank_bit[index];
> +		pinf.bank >>= 1;
> +	}
> +
> +	for (index = 0; index < XDDR_MAX_GRP_CNT; index++) {
> +		err_addr |= (pinf.group & BIT(0)) << priv->grp_bit[index];
> +		pinf.group >>= 1;
> +	}
> +
> +	for (index = 0; index < XDDR_MAX_RANK_CNT; index++) {
> +		err_addr |= (pinf.rank & BIT(0)) << priv->rank_bit[index];
> +		pinf.rank >>= 1;
> +	}
> +
> +	for (index = 0; index < XDDR_MAX_LRANK_CNT; index++) {
> +		err_addr |= (pinf.lrank & BIT(0)) << priv->lrank_bit[index];
> +		pinf.lrank >>= 1;
> +	}

Oh wow, 6 loops!

I'm wondering if you could "unroll" those loops and work on each component with
a single mask and such...

> +
> +	err_addr |= (priv->stat.channel & BIT(0)) << priv->ch_bit;
> +
> +	return err_addr;
> +}
> +
> +/**
> + * handle_error - Handle Correctable and Uncorrectable errors.
> + * @mci:	EDAC memory controller instance.
> + * @stat:	ECC status structure.
> + *
> + * Handles ECC correctable and uncorrectable errors.
> + */
> +static void handle_error(struct mem_ctl_info *mci, struct ecc_status *stat)
> +{
> +	struct edac_priv *priv = mci->pvt_info;
> +	struct ecc_error_info pinf;
> +
> +	if (stat->error_type == XDDR_ERR_TYPE_CE) {
> +		priv->ce_cnt++;
> +		pinf = stat->ceinfo[stat->channel];

That ->channel thing is u32 but the ceinfo array says there can be only two
channels. Why the waste?

> +		snprintf(priv->message, XDDR_EDAC_MSG_SIZE,
> +			 "Error type:%s MC ID: %d Addr at %lx Burst Pos: %d\n",
> +			 "CE", priv->mc_id,
> +			 convert_to_physical(priv, pinf), pinf.burstpos);
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
> +				     priv->ce_cnt, 0, 0, 0, 0, 0, -1,
> +				     priv->message, "");
> +	}
> +
> +	if (stat->error_type == XDDR_ERR_TYPE_UE) {
> +		priv->ue_cnt++;
> +		pinf = stat->ueinfo[stat->channel];

Ditto.

> +		snprintf(priv->message, XDDR_EDAC_MSG_SIZE,
> +			 "Error type:%s MC ID: %d Addr at %lx Burst Pos: %d\n",
> +			 "UE", priv->mc_id,
> +			 convert_to_physical(priv, pinf), pinf.burstpos);
> +
> +		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
> +				     priv->ue_cnt, 0, 0, 0, 0, 0, -1,
> +				     priv->message, "");
> +	}
> +
> +	memset(stat, 0, sizeof(*stat));
> +}
> +
> +/**
> + * intr_handler - Interrupt Handler for ECC interrupts.
> + * @irq:	IRQ number
> + * @dev_id:	Device ID
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise.
> + */
> +static irqreturn_t intr_handler(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct edac_priv *priv;
> +	int status, regval;
> +
> +	priv = mci->pvt_info;
> +	regval = readl(priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);

<---- newline here.

> +	regval &= (XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK);
> +	if (!regval)
> +		return IRQ_NONE;
> +
> +	/* Unlock the PCSR registers */
> +	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> +
> +	/* Clear the ISR */
> +	writel(regval, priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);

Does that ISR clearing reenable the interrupt? If so, you can't do that here.

> +
> +	/* Lock the PCSR registers */
> +	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> +
> +	status = get_error_info(priv);
> +	if (status)
> +		return IRQ_NONE;
> +
> +	handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count CE %d UE %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * err_callback - Handle Correctable and Uncorrectable errors.

handle_error() does the same. What's the difference?

Why is this thing registered with some Xilinx event manager thing and yet you
have error interrupts too?

> + * @payload:	payload data.
> + * @data:	mci controller data.
> + *
> + * Handles ECC correctable and uncorrectable errors.
> + */
> +static void err_callback(const u32 *payload, void *data)
> +{
> +	struct mem_ctl_info *mci = (struct mem_ctl_info *)data;
> +	struct edac_priv *priv;
> +	struct ecc_status *p;
> +	int status, regval;
> +
> +	priv = mci->pvt_info;
> +	p = &priv->stat;
> +
> +	regval = readl(priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
> +	regval &= (XDDR_IRQ_CE_MASK | XDDR_IRQ_UE_MASK);
> +	if (!regval)
> +		return;
> +
> +	/* Unlock the PCSR registers */
> +	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> +
> +	/* Clear the ISR */
> +	writel(regval, priv->ddrmc_baseaddr + XDDR_ISR_OFFSET);
> +	/* Lock the PCSR registers */
> +

Wrong newline

> +	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);

That unlock-clear-lock sequence appears here again. Make that a separate
function to not have code duplication.

> +	if (payload[2] == XPM_EVENT_ERROR_MASK_DDRMC_CR)
> +		p->error_type = XDDR_ERR_TYPE_CE;
> +	if (payload[2] == XPM_EVENT_ERROR_MASK_DDRMC_NCR)

2? A magic number?

> +		p->error_type = XDDR_ERR_TYPE_UE;
> +
> +	status = get_error_info(priv);
> +	if (status)
> +		return;
> +
> +	handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count CE %d UE %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);
> +}
> +
> +/**
> + * get_dwidth - Return the controller memory width.
> + * @base:	DDR memory controller base address.
> + *
> + * Get the EDAC device type width appropriate for the controller
> + * configuration.
> + *
> + * Return: a device type width enumeration.
> + */
> +static enum dev_type get_dwidth(const void __iomem *base)
> +{
> +	enum dev_type dt;
> +	u32 regval;
> +
> +	regval = readl(base + XDDR_REG_CONFIG0_OFFSET);
> +	regval = (regval & XDDR_REG_CONFIG0_BUS_WIDTH_MASK) >>
> +				XDDR_REG_CONFIG0_BUS_WIDTH_SHIFT;

Split that for better readability:

	regval   = readl(base + XDDR_REG_CONFIG0_OFFSET);
	regval  &= XDDR_REG_CONFIG0_BUS_WIDTH_MASK;
	regval >>= XDDR_REG_CONFIG0_BUS_WIDTH_SHIFT;

and do the same for the others below.

> +	switch (regval) {
> +	case XDDR_BUS_WIDTH_16:
> +		dt = DEV_X2;
> +		break;
> +	case XDDR_BUS_WIDTH_32:
> +		dt = DEV_X4;
> +		break;
> +	case XDDR_BUS_WIDTH_64:
> +		dt = DEV_X8;
> +		break;
> +	default:
> +		dt = DEV_UNKNOWN;
> +	}
> +
> +	return dt;
> +}
> +
> +/**
> + * get_ecc_state - Return the controller ECC enable/disable status.
> + * @base:	DDR memory controller base address.
> + *
> + * Get the ECC enable/disable status for the controller.
> + *
> + * Return: a ECC status boolean i.e true/false - enabled/disabled.
> + */
> +static bool get_ecc_state(void __iomem *base)
> +{
> +	enum dev_type dt;
> +	u32 ecctype;
> +
> +	dt = get_dwidth(base);
> +	if (dt == DEV_UNKNOWN)
> +		return false;
> +
> +	ecctype = readl(base + XDDR_REG_PINOUT_OFFSET);
> +	ecctype &= XDDR_REG_PINOUT_ECC_EN_MASK;

Exactly, like here.

> +	if (ecctype)
> +		return true;
> +
> +	return false;

Simplify that to:

	return !!ecctype;

> +}
> +
> +/**
> + * get_memsize - Get the size of the attached memory device.
> + * @priv:	DDR memory controller private instance data.
> + *
> + * Return: the memory size in bytes.
> + */
> +static u64 get_memsize(struct edac_priv *priv)
> +{
> +	u32 regval;
> +	u64 size;
> +
> +	regval = readl(priv->ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET) &
> +				XDDR_REG_CONFIG0_SIZE_MASK;
> +	regval >>= XDDR_REG_CONFIG0_SIZE_SHIFT;
> +	switch (regval) {
> +	case XILINX_DRAM_SIZE_4G:
> +		size = (4U * SZ_1G);
		       ^^^^^^^^^^^^^^

No need for the brackets in all those.

> +		break;
> +	case XILINX_DRAM_SIZE_6G:
> +		size = (6U * SZ_1G);
> +		break;
> +	case XILINX_DRAM_SIZE_8G:
> +		size = (8U * SZ_1G);
> +		break;
> +	case XILINX_DRAM_SIZE_12G:
> +		size = (12U * SZ_1G);
> +		break;
> +	case XILINX_DRAM_SIZE_16G:
> +		size = (16U * SZ_1G);
> +		break;
> +	case XILINX_DRAM_SIZE_32G:
> +		size = (32U * SZ_1G);
> +		break;
> +	default:
> +		/* Invalid configuration */
> +		size = 0;
> +		break;
> +	}

You can make that a lot simpler and easier to read:

        switch (regval) {
        case XILINX_DRAM_SIZE_4G:       size = 4U;      break;
        case XILINX_DRAM_SIZE_6G:       size = 6U;      break;  
        case XILINX_DRAM_SIZE_8G:       size = 8U;      break;  
        case XILINX_DRAM_SIZE_12G:      size = 12U;     break;  
        case XILINX_DRAM_SIZE_16G:      size = 16U;     break;
        case XILINX_DRAM_SIZE_32G:      size = 32U;     break;
        /* Invalid configuration */
        default: break; 
        }       

        size *= SZ_1G;

        return size;


> +
> +	return size;
> +}
> +
> +/**
> + * init_csrows - Initialize the csrow data.
> + * @mci:	EDAC memory controller instance.
> + *
> + * Initialize the chip select rows associated with the EDAC memory
> + * controller instance.
> + */
> +static void init_csrows(struct mem_ctl_info *mci)
> +{
> +	struct edac_priv *priv = mci->pvt_info;
> +	struct csrow_info *csi;
> +	struct dimm_info *dimm;
> +	unsigned long size;
> +	u32 row;
> +	int ch;
> +
> +	size = get_memsize(priv);
> +	for (row = 0; row < mci->nr_csrows; row++) {
> +		csi = mci->csrows[row];
> +		for (ch = 0; ch < csi->nr_channels; ch++) {
> +			dimm = csi->channels[ch]->dimm;
> +			dimm->edac_mode	= EDAC_SECDED;
> +			dimm->mtype = MEM_DDR4;
> +			dimm->nr_pages = (size >> PAGE_SHIFT) /
> +						csi->nr_channels;

Let that line stick out.

> +			dimm->grain = XDDR_EDAC_ERR_GRAIN;
> +			dimm->dtype = get_dwidth(priv->ddrmc_baseaddr);
> +		}
> +	}
> +}

...

> +static int setup_irq(struct mem_ctl_info *mci, struct platform_device *pdev)
> +{
> +	int ret, irq;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "No IRQ %d in DT\n", irq);
> +		return irq;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, irq, intr_handler,
> +			       IRQF_SHARED, dev_name(&pdev->dev), mci);
> +	if (ret < 0) {
> +		edac_printk(KERN_ERR, EDAC_MC, "Failed to request IRQ\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +#define to_mci(k) container_of(k, struct mem_ctl_info, dev)

I'd like to have the injection algorithm documented here, in a comment at
least. See the zynqmp_edac driver for an example.

...

> +static int mc_probe(struct platform_device *pdev)
> +{
> +	void __iomem *ddrmc_baseaddr, *ddrmc_noc_baseaddr;
> +	struct edac_mc_layer layers[2];
> +	struct mem_ctl_info *mci;
> +	u8 num_chans, num_csrows;
> +	struct edac_priv *priv;
> +	u32 edac_mc_id, regval;
> +	int rc;
> +
> +	ddrmc_baseaddr = devm_platform_ioremap_resource_byname(pdev, "base");
> +	if (IS_ERR(ddrmc_baseaddr))
> +		return PTR_ERR(ddrmc_baseaddr);
> +
> +	ddrmc_noc_baseaddr = devm_platform_ioremap_resource_byname(pdev, "noc");
> +	if (IS_ERR(ddrmc_noc_baseaddr))
> +		return PTR_ERR(ddrmc_noc_baseaddr);
> +
> +	if (!get_ecc_state(ddrmc_baseaddr))
> +		return -ENXIO;
> +
> +	/* Allocate ID number for our EMIF controller */
> +	edac_mc_id = emif_get_id(pdev->dev.of_node);
> +	if (edac_mc_id < 0)
> +		return -EINVAL;
> +
> +	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
> +	num_chans = (regval & XDDR_REG_CONFIG0_NUM_CHANS_MASK) >>
> +			XDDR_REG_CONFIG0_NUM_CHANS_SHIFT;
> +	num_chans++;
> +
> +	num_csrows = (regval & XDDR_REG_CONFIG0_NUM_RANKS_MASK) >>
> +			XDDR_REG_CONFIG0_NUM_RANKS_SHIFT;
> +	num_csrows *= 2;
> +	if (!num_csrows)
> +		num_csrows = 1;
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = num_csrows;
> +	layers[0].is_virt_csrow = true;
> +	layers[1].type = EDAC_MC_LAYER_CHANNEL;
> +	layers[1].size = num_chans;
> +	layers[1].is_virt_csrow = false;
> +
> +	mci = edac_mc_alloc(edac_mc_id, ARRAY_SIZE(layers), layers,
> +			    sizeof(struct edac_priv));
> +	if (!mci) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed memory allocation for mc instance\n");
> +		return -ENOMEM;
> +	}
> +
> +	priv = mci->pvt_info;
> +	priv->ddrmc_baseaddr = ddrmc_baseaddr;
> +	priv->ddrmc_noc_baseaddr = ddrmc_noc_baseaddr;
> +	priv->ce_cnt = 0;
> +	priv->ue_cnt = 0;
> +	priv->mc_id = edac_mc_id;
> +
> +	mc_init(mci, pdev);
> +
> +	rc = edac_mc_add_mc(mci);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to register with EDAC core\n");
> +		goto free_edac_mc;
> +	}
> +
> +#ifdef CONFIG_EDAC_DEBUG
> +	if (edac_create_debugfs_attributes(mci)) {
> +		edac_printk(KERN_ERR, EDAC_MC,
> +			    "Failed to create debugfs entries\n");
> +		goto del_edac_mc;

I don't think you have to fail if it cannot allocate debugfs nodes - the driver
is functional - you just can't inject.

> +	}
> +
> +	setup_address_map(priv);
> +#endif
> +
> +	rc = xlnx_register_event(PM_NOTIFY_CB, EVENT_ERROR_PMC_ERR1,
> +				 XPM_EVENT_ERROR_MASK_DDRMC_CR | XPM_EVENT_ERROR_MASK_DDRMC_NCR,
> +				 false, err_callback, mci);
> +	if (rc == -ENODEV) {
> +		rc = setup_irq(mci, pdev);
> +		if (rc)
> +			goto del_edac_debugfs;
> +	}
> +	if (rc) {
> +		if (rc == -EACCES)
> +			rc = -EPROBE_DEFER;
> +
> +		goto del_edac_debugfs;
> +	}
> +
> +	enable_intr(priv);
> +	return rc;
> +
> +del_edac_debugfs:
> +	edac_debugfs_remove_recursive(xddr_debugfs);
> +#ifdef CONFIG_EDAC_DEBUG
> +del_edac_mc:
> +#endif
> +	edac_mc_del_mc(&pdev->dev);
> +free_edac_mc:
> +	edac_mc_free(mci);
> +
> +	return rc;
> +}

...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

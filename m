Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A65F2ECF10
	for <lists+linux-edac@lfdr.de>; Thu,  7 Jan 2021 12:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbhAGLuo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 7 Jan 2021 06:50:44 -0500
Received: from disco-boy.misterjones.org ([51.254.78.96]:55422 "EHLO
        disco-boy.misterjones.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbhAGLun (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Thu, 7 Jan 2021 06:50:43 -0500
X-Greylist: delayed 2682 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jan 2021 06:50:42 EST
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@misterjones.org>)
        id 1kxT6Q-005orL-Rd; Thu, 07 Jan 2021 11:05:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 Jan 2021 11:05:14 +0000
From:   Marc Zyngier <maz@misterjones.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-edac@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Richter <rrichter@marvell.com>,
        James Morse <james.morse@arm.com>, kernel@pengutronix.de,
        Borislav Petkov <bp@alien8.de>, York Sun <york.sun@nxp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/1] drivers/edac: Add L1 and L2 error detection for A53
 and A57
In-Reply-To: <20210107103819.13552-2-s.hauer@pengutronix.de>
References: <20210107103819.13552-1-s.hauer@pengutronix.de>
 <20210107103819.13552-2-s.hauer@pengutronix.de>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <87bfbf704e4c2f13b30fe7055b8dec40@misterjones.org>
X-Sender: maz@misterjones.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: s.hauer@pengutronix.de, linux-edac@vger.kernel.org, tony.luck@intel.com, robh+dt@kernel.org, rrichter@marvell.com, james.morse@arm.com, kernel@pengutronix.de, bp@alien8.de, york.sun@nxp.com, mchehab@kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On 2021-01-07 10:38, Sascha Hauer wrote:
> The Cortex A53 and A57 cores have error detection capabilities for the
> L1/L2 Caches, this patch adds a driver for them.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version of this driver
> found here: https://lkml.org/lkml/2018/3/14/1203. For reasons stated
> in this thread the error injection code is not suitable for mainline,
> so it is removed from the driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/edac/Kconfig              |   6 +
>  drivers/edac/Makefile             |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c | 218 ++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 81c42664f21b..116ad56534a4 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -539,4 +539,10 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.
> 
> +config EDAC_CORTEX_ARM64_L1_L2
> +	tristate "ARM Cortex A57/A53"
> +	depends on ARM64
> +	help
> +	  Support for L1/L2 cache error detection on ARM Cortex A57 and A53.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 464d3d8d850a..a324fbc1693e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -89,3 +89,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
>  obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o
> diff --git a/drivers/edac/cortex_arm64_l1_l2.c
> b/drivers/edac/cortex_arm64_l1_l2.c
> new file mode 100644
> index 000000000000..3b1e2f3ccab6
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_l1_l2.c
> @@ -0,0 +1,218 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A57 and A53 EDAC L1 and L2 cache error detection
> + *
> + * Copyright (c) 2020 Pengutronix, Sascha Hauer 
> <s.hauer@pengutronix.de>
> + *
> + * Based on Code from:
> + * Copyright (c) 2018, NXP Semiconductor
> + * Author: York Sun <york.sun@nxp.com>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/bitfield.h>
> +#include <asm/smp_plat.h>
> +
> +#include "edac_module.h"
> +
> +#define DRVNAME				"cortex-arm64-edac"
> +
> +#define CPUMERRSR_EL1_RAMID		GENMASK(30, 24)
> +
> +#define CPUMERRSR_EL1_VALID		BIT(31)
> +#define CPUMERRSR_EL1_FATAL		BIT(63)
> +
> +#define L1_I_TAG_RAM			0x00
> +#define L1_I_DATA_RAM			0x01
> +#define L1_D_TAG_RAM			0x08
> +#define L1_D_DATA_RAM			0x09
> +#define L1_D_DIRTY_RAM			0x14
> +#define TLB_RAM				0x18
> +
> +#define L2MERRSR_EL1_VALID		BIT(31)
> +#define L2MERRSR_EL1_FATAL		BIT(63)
> +
> +struct merrsr {
> +	u64 cpumerr;
> +	u64 l2merr;
> +};
> +
> +#define MESSAGE_SIZE 64
> +
> +#define SYS_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
> +#define SYS_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)

Oh, IMPDEF registers...

This means that a kernel with this driver running in a virtualized
environment is likely to just take an UNDEF and die. Not great.

Also, how does it work if EL3 implements the same functionality?

         M.
-- 
Who you jivin' with that Cosmik Debris?

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7469467B1
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbfFNSmC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 14:42:02 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36162 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfFNSmC (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 14:42:02 -0400
Received: from zn.tnic (p200300EC2F097F008D9D08C27DC27982.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:8d9d:8c2:7dc2:7982])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 046161EC0B6E;
        Fri, 14 Jun 2019 20:41:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560537720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8jNYmU8ZmV5gIwr4Ka310b7ILZ/kXzFHtNRzAOhuJl0=;
        b=C0NQsVZPSMQOsCQZIePl1XYxgcK+EV36NlMfVp2C0KbXgKRltAuIR0ItTT4RQmKqFeOGE8
        JXa/UD6y8HGv4nOaRFf0vbY1qWZg0yPvhZyZztQQ4W960cP7PhqRSQfHBDD7NxWWHWzRRH
        K0iGHS6zCKoE72Ir8VmyUEjtfxxtsbc=
Date:   Fri, 14 Jun 2019 20:41:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shravan Kumar Ramani <sramani@mellanox.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Liming Sun <lsun@mellanox.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] EDAC, mellanox: Add ECC support for BlueField DDR4
Message-ID: <20190614184151.GP2586@zn.tnic>
References: <cover.1560536708.git.sramani@mellanox.com>
 <f320d7926e2a87449c99ca43e8ac2ff52996a6c0.1560536708.git.sramani@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f320d7926e2a87449c99ca43e8ac2ff52996a6c0.1560536708.git.sramani@mellanox.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 14, 2019 at 02:35:53PM -0400, Shravan Kumar Ramani wrote:
> Add ECC support for Mellanox BlueField SoC DDR controller.
> This requires SMC to the running Arm Trusted Firmware to report
> what is the current memory configuration.
> 
> Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
> ---
>  MAINTAINERS                   |   5 +
>  drivers/edac/Kconfig          |   7 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/bluefield_edac.c | 404 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 417 insertions(+)
>  create mode 100644 drivers/edac/bluefield_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496c..9d04cc4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5669,6 +5669,11 @@ S:	Supported
>  F:	drivers/edac/aspeed_edac.c
>  F:	Documentation/devicetree/bindings/edac/aspeed-sdram-edac.txt
>  
> +EDAC-BLUEFIELD
> +M:	Shravan Kumar Ramani <sramani@mellanox.com>
> +S:	Supported
> +F:	drivers/edac/bluefield_edac.c
> +
>  EDAC-CALXEDA
>  M:	Robert Richter <rric@kernel.org>
>  L:	linux-edac@vger.kernel.org
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 5e2e034..43df551 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -504,4 +504,11 @@ config EDAC_ASPEED
>  	  First, ECC must be configured in the bootloader. Then, this driver
>  	  will expose error counters via the EDAC kernel framework.
>  
> +config EDAC_BLUEFIELD
> +	tristate "Mellanox BlueField Memory ECC"
> +	depends on ARM64 && ((MELLANOX_PLATFORM && ACPI) || COMPILE_TEST)
> +	help
> +	  Support for error detection and correction on the
> +	  Mellanox BlueField SoCs.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 89ad4a84..0294a67 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -84,3 +84,4 @@ obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
> +obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> new file mode 100644
> index 0000000..9c69033
> --- /dev/null
> +++ b/drivers/edac/bluefield_edac.c
> @@ -0,0 +1,404 @@
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
> + */
> +
> +#define MLXBF_EMI_DRAM_ECC_COUNT 0x340
> +#define MLXBF_EMI_DRAM_ECC_COUNT__LENGTH 0x0001
> +
> +#define MLXBF_EMI_DRAM_ECC_COUNT__SINGLE_ERROR_COUNT_SHIFT 0
> +#define MLXBF_EMI_DRAM_ECC_COUNT__SINGLE_ERROR_COUNT_RMASK 0xffff
> +
> +#define MLXBF_EMI_DRAM_ECC_COUNT__DOUBLE_ERROR_COUNT_SHIFT 16
> +#define MLXBF_EMI_DRAM_ECC_COUNT__DOUBLE_ERROR_COUNT_RMASK 0xffff
> +
> +#define MLXBF_EMI_DRAM_ECC_ERROR 0x348
> +
> +#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_SINGLE_SHIFT 0
> +#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_SINGLE_RMASK 0x1
> +
> +#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_DOUBLE_SHIFT 16
> +#define MLXBF_EMI_DRAM_ECC_ERROR__DRAM_ECC_DOUBLE_RMASK 0x1
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT 0x354
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__DRAM_ECC_FIRST_SHIFT 0
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__DRAM_ECC_FIRST_RMASK 0x1
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__EDGE_SEL_SHIFT 16
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__EDGE_SEL_RMASK 0xf
> +
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__START_SHIFT 24
> +#define MLXBF_EMI_DRAM_ECC_LATCH_SELECT__START_RMASK 0x1
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_0 0x358
> +
> +#define MLXBF_EMI_DRAM_ERR_ADDR_1 0x37c
> +
> +#define MLXBF_EMI_DRAM_SYNDROM 0x35c
> +#define MLXBF_EMI_DRAM_SYNDROM__LENGTH 0x0001
> +
> +#define MLXBF_EMI_DRAM_SYNDROM__DERR_SHIFT 0
> +#define MLXBF_EMI_DRAM_SYNDROM__DERR_RMASK 0x1
> +
> +#define MLXBF_EMI_DRAM_SYNDROM__SERR_SHIFT 1
> +#define MLXBF_EMI_DRAM_SYNDROM__SERR_RMASK 0x1
> +
> +#define MLXBF_EMI_DRAM_SYNDROM__SYNDROM_SHIFT 16
> +#define MLXBF_EMI_DRAM_SYNDROM__SYNDROM_RMASK 0x3ff
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0 0x364
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_BANK_SHIFT 0
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_BANK_RMASK 0xf
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_LRANK_SHIFT 4
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_LRANK_RMASK 0x3
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_PRANK_SHIFT 8
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_PRANK_RMASK 0x3
> +
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_EDGE_SHIFT 16
> +#define MLXBF_EMI_DRAM_ADDITIONAL_INFO_0__ERR_EDGE_RMASK 0xff

So those are *excessively* long macro names. So long that they impair
reading the code properly. Please shorten excessively.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

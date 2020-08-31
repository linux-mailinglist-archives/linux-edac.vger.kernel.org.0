Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8805A2575DB
	for <lists+linux-edac@lfdr.de>; Mon, 31 Aug 2020 10:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgHaIwO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 31 Aug 2020 04:52:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:52078 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgHaIwN (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 31 Aug 2020 04:52:13 -0400
Received: from zn.tnic (p200300ec2f085000813a34d1eba5207f.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:5000:813a:34d1:eba5:207f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C27221EC02F2;
        Mon, 31 Aug 2020 10:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598863927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2FzP/LvkqUgFGgtj8Jdm6U/F975hJtQOcYmgKmxdTew=;
        b=f6Bmje31otGkvraw5KTpsx4FRsRfwx8yvp2U8CfixJu6w2daX7PKI70wy6ktlQJakpMJGE
        SvPG660bCO0X5LAxbQHfEbYbcui6cRng5yj3PCltWtTga0uSzRY1A0PeIF+S1pJdm3DA7r
        zFeYYwTxuxv+SJat3BZg1DoX4Ct+aK8=
Date:   Mon, 31 Aug 2020 10:52:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     robh+dt@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        mchehab@kernel.org, tony.luck@intel.com, aou@eecs.berkeley.edu,
        james.morse@arm.com, rrichter@marvell.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        sachin.ghadi@sifive.com
Subject: Re: [PATCH 3/3] edac: sifive: Add EDAC support for Memory Controller
 in SiFive SoCs
Message-ID: <20200831085203.GB27517@zn.tnic>
References: <1598357182-4226-1-git-send-email-yash.shah@sifive.com>
 <1598357182-4226-4-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598357182-4226-4-git-send-email-yash.shah@sifive.com>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> Subject: Re: [PATCH 3/3] edac: sifive: Add EDAC support for Memory Controller in SiFive SoCs

Fix subject prefix: "EDAC/sifive: ..."

On Tue, Aug 25, 2020 at 05:36:22PM +0530, Yash Shah wrote:
> Add Memory controller EDAC support in exisiting SiFive platform EDAC

s/in exisiting/to the/

> driver. It registers for notifier events from the SiFive DDR controller
> driver for DDR ECC events.

Simplify:

"It registers for ECC notifier events from the memory controller."

> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  drivers/edac/Kconfig       |   2 +-
>  drivers/edac/sifive_edac.c | 117 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7b6ec30..f8b3b53 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -462,7 +462,7 @@ config EDAC_ALTERA_SDMMC
>  
>  config EDAC_SIFIVE
>  	bool "Sifive platform EDAC driver"
> -	depends on EDAC=y && SIFIVE_L2
> +	depends on EDAC=y && (SIFIVE_L2 || SIFIVE_DDR)
>  	help
>  	  Support for error detection and correction on the SiFive SoCs.
>  
> diff --git a/drivers/edac/sifive_edac.c b/drivers/edac/sifive_edac.c
> index 3a3dcb1..cf032685 100644
> --- a/drivers/edac/sifive_edac.c
> +++ b/drivers/edac/sifive_edac.c
> @@ -11,14 +11,120 @@
>  #include <linux/platform_device.h>
>  #include "edac_module.h"
>  #include <soc/sifive/sifive_l2_cache.h>
> +#include <soc/sifive/sifive_ddr.h>
>  
>  #define DRVNAME "sifive_edac"
> +#define SIFIVE_EDAC_MOD_NAME "Sifive ECC Manager"

s/SIFIVE_EDAC_MOD_NAME/EDAC_MOD_NAME/g

like the other EDAC drivers.

...

> +static int ecc_mc_register(struct platform_device *pdev)
> +{
> +	struct sifive_edac_mc_priv *p;
> +	struct edac_mc_layer layers[1];
> +	int ret;
> +
> +	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	p->notifier.notifier_call = ecc_mc_err_event;
> +	platform_set_drvdata(pdev, p);
> +
> +	layers[0].type = EDAC_MC_LAYER_CHIP_SELECT;
> +	layers[0].size = 1;
> +	layers[0].is_virt_csrow = true;
> +
> +	p->mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, 0);
> +	if (!p->mci) {
> +		dev_err(&pdev->dev, "Failed mem allocation for mc instance\n");
> +		return -ENOMEM;
> +	}
> +
> +	p->mci->pdev = &pdev->dev;
> +	/* Initialize controller capabilities */
> +	p->mci->mtype_cap = MEM_FLAG_DDR4;
> +	p->mci->edac_ctl_cap = EDAC_FLAG_NONE | EDAC_FLAG_SECDED;
> +	p->mci->edac_cap = EDAC_FLAG_SECDED;
> +	p->mci->scrub_cap = SCRUB_UNKNOWN;
> +	p->mci->scrub_mode = SCRUB_HW_PROG;
> +	p->mci->ctl_name = dev_name(&pdev->dev);
> +	p->mci->dev_name = dev_name(&pdev->dev);
> +	p->mci->mod_name = SIFIVE_EDAC_MOD_NAME;
> +	p->mci->ctl_page_to_phys = NULL;
> +
> +	/* Interrupt feature is supported by cadence mc */
> +	edac_op_state = EDAC_OPSTATE_INT;
> +
> +	ret = edac_mc_add_mc(p->mci);
> +	if (ret) {
> +		edac_printk(KERN_ERR, SIFIVE_EDAC_MOD_NAME,
> +			    "Failed to register with EDAC core\n");
> +		goto err;
> +	}
> +
> +#ifdef CONFIG_SIFIVE_DDR

It seems all that ifdeffery can be replaced with

	if (IS_ENABLED(CONFIG_...))

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

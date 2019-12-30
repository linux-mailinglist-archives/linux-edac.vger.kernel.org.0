Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC0F812CFBA
	for <lists+linux-edac@lfdr.de>; Mon, 30 Dec 2019 12:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfL3Luo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Dec 2019 06:50:44 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59948 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727359AbfL3Lun (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 30 Dec 2019 06:50:43 -0500
Received: from zn.tnic (p200300EC2F008100794E84A6AD7DE589.dip0.t-ipconnect.de [IPv6:2003:ec:2f00:8100:794e:84a6:ad7d:e589])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D66B1EC05DE;
        Mon, 30 Dec 2019 12:50:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1577706641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=qJEp1zf5++y0M/fbvkAvwA4TkpQ2f7meEDTCFWylBkY=;
        b=Ql3iwTKSBrXu9PNwzPkWQ8G5wcfRjsmkHFiqxx0il73ZhI0VMZPr3aIAkoC97eal8oB3Cj
        sJxDJEmPXo3oImdFyyzqQk3qoJ6nDM6E2MdM48xdWp+XYW9/kK+YhiU/lU13UJzygTPT55
        hRyP5i1FmBVydMRID5+iaEbdTZPX1lI=
Date:   Mon, 30 Dec 2019 12:50:30 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        James Morse <james.morse@arm.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org
Subject: Re: [PATCH 2/2] drivers: edac: Add EDAC support for Kryo CPU caches
Message-ID: <20191230115030.GA30767@zn.tnic>
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a6559-46c6c649-db28-4945-a11c-7441b8e9ac5b-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0101016ed57a6559-46c6c649-db28-4945-a11c-7441b8e9ac5b-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Dec 05, 2019 at 09:53:18AM +0000, Sai Prakash Ranjan wrote:
> Kryo{3,4}XX CPU cores implement RAS extensions to support
> Error Correcting Code(ECC). Currently all Kryo{3,4}XX CPU
> cores (gold/silver a.k.a big/LITTLE) support ECC via RAS.

via RAS what? ARM64_RAS_EXTN?

In any case, this needs James to look at and especially if there's some
ARM-generic functionality in there which should be shared, of course.

> This adds an interrupt based driver for those CPUs and

s/This adds/Add/

> provides an optional polling of error recording system
> registers.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  MAINTAINERS                   |   7 +
>  drivers/edac/Kconfig          |  20 +
>  drivers/edac/Makefile         |   1 +
>  drivers/edac/qcom_kryo_edac.c | 679 ++++++++++++++++++++++++++++++++++
>  4 files changed, 707 insertions(+)
>  create mode 100644 drivers/edac/qcom_kryo_edac.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c2d80079dccc..f58c93f963f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6049,6 +6049,13 @@ L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/qcom_edac.c
>  
> +EDAC-KRYO-QCOM
> +M:	Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> +L:	linux-arm-msm@vger.kernel.org
> +L:	linux-edac@vger.kernel.org
> +S:	Maintained
> +F:	drivers/edac/qcom_kryo_edac.c
> +
>  EDIROL UA-101/UA-1000 DRIVER
>  M:	Clemens Ladisch <clemens@ladisch.de>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 417dad635526..cd78ac2917c9 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -508,6 +508,26 @@ config EDAC_QCOM
>  	  For debugging issues having to do with stability and overall system
>  	  health, you should probably say 'Y' here.
>  
> +config EDAC_QCOM_KRYO
> +	tristate "QCOM Kryo EDAC for CPU L1/L2/L3-SCU caches"
> +	depends on ARCH_QCOM && ARM64_RAS_EXTN
> +	help
> +	  Support for Error detection and correction on Kryo Gold and Silver CPU
> +	  cores with RAS extensions. Currently it detects and reports all Single
> +	  Bit Errors (SBEs) and Double Bit Errors (DBEs).
> +
> +	  For debugging issues having to do with stability and overall system
> +	  health, you should probably say 'Y' here.
> +
> +config EDAC_QCOM_KRYO_POLL
> +	depends on EDAC_QCOM_KRYO
> +	bool "Poll on Kryo ECC registers"
> +	help
> +	  This option chooses whether or not you want to poll on the Kryo ECC
> +	  registers. When this is enabled, the polling rate can be set as a
> +	  module parameter. By default, it will call the polling function every
> +	  second.

Why is this a separate option and why should people use that?

Can the polling/irq be switched automatically?

> +
>  config EDAC_ASPEED
>  	tristate "Aspeed AST 2500 SoC"
>  	depends on MACH_ASPEED_G5
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index d77200c9680b..29edcfa6ec0e 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -85,5 +85,6 @@ obj-$(CONFIG_EDAC_SYNOPSYS)		+= synopsys_edac.o
>  obj-$(CONFIG_EDAC_XGENE)		+= xgene_edac.o
>  obj-$(CONFIG_EDAC_TI)			+= ti_edac.o
>  obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
> +obj-$(CONFIG_EDAC_QCOM_KRYO)		+= qcom_kryo_edac.o

What is the difference between this new driver and the qcom_edac one? Can
functionality be shared?

Should this new one be called simply kryo_edac instead?

>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
> diff --git a/drivers/edac/qcom_kryo_edac.c b/drivers/edac/qcom_kryo_edac.c
> new file mode 100644
> index 000000000000..05b60ad3cb0e
> --- /dev/null
> +++ b/drivers/edac/qcom_kryo_edac.c
> @@ -0,0 +1,679 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cpu_pm.h>
> +#include <linux/of_irq.h>
> +#include <linux/smp.h>
> +
> +#include <asm/cputype.h>
> +#include <asm/sysreg.h>
> +
> +#include "edac_device.h"
> +#include "edac_mc.h"
> +
> +#define DRV_NAME		"qcom_kryo_edac"
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.3

Chapter? Where? URL?

> + * ARM DSU TRM Chapter B2.3
> + * CFI = Corrected Fault Handling interrupt, FI = Fault handling interrupt
> + * UI = Uncorrected error recovery interrupt, ED = Error Detection
> + */
> +#define KRYO_ERRXCTLR_ED	BIT(0)
> +#define KRYO_ERRXCTLR_UI	BIT(2)
> +#define KRYO_ERRXCTLR_FI	BIT(3)
> +#define KRYO_ERRXCTLR_CFI	BIT(8)
> +#define KRYO_ERRXCTLR_ENABLE	(KRYO_ERRXCTLR_CFI | KRYO_ERRXCTLR_FI | \
> +				 KRYO_ERRXCTLR_UI | KRYO_ERRXCTLR_ED)
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.4
> + * ARM DSU TRM Chapter B2.4
> + */
> +#define KRYO_ERRXFR_ED		GENMASK(1, 0)
> +#define KRYO_ERRXFR_DE		GENMASK(3, 2)
> +#define KRYO_ERRXFR_UI		GENMASK(5, 4)
> +#define KRYO_ERRXFR_FI		GENMASK(7, 6)
> +#define KRYO_ERRXFR_UE		GENMASK(9, 8)
> +#define KRYO_ERRXFR_CFI		GENMASK(11, 10)
> +#define KRYO_ERRXFR_CEC		GENMASK(14, 12)
> +#define KRYO_ERRXFR_RP		BIT(15)
> +#define KRYO_ERRXFR_SUPPORTED	(KRYO_ERRXFR_ED | KRYO_ERRXFR_DE | \
> +				 KRYO_ERRXFR_UI | KRYO_ERRXFR_FI | \
> +				 KRYO_ERRXFR_UE | KRYO_ERRXFR_CFI | \
> +				 KRYO_ERRXFR_CEC | KRYO_ERRXFR_RP)
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.5
> + * ARM DSU TRM Chapter B2.5
> + */
> +#define KRYO_ERRXMISC0_CECR	GENMASK_ULL(38, 32)
> +#define KRYO_ERRXMISC0_CECO	GENMASK_ULL(46, 40)
> +
> +/* ARM Cortex-A76 TRM Chapter B3.5 */
> +#define KRYO_ERRXMISC0_UNIT	GENMASK(3, 0)
> +#define KRYO_ERRXMISC0_LVL	GENMASK(3, 1)
> +
> +/* ARM Cortex-A76 TRM Chapter B3.10 has SERR bitfields 4:0
> + * but Cortex-A55, Cortex-A75 and DSU TRM has SERR bitfields 7:0.
> + * Since max error record is 21, we can use bitfields 4:0 for
> + * Kryo{3,4}XX CPUs.
> + */
> +#define KRYO_ERRXSTATUS_SERR	GENMASK(4, 0)
> +#define KRYO_ERRXSTATUS_DE	BIT(23)
> +#define KRYO_ERRXSTATUS_CE	GENMASK(25, 24)
> +#define KRYO_ERRXSTATUS_MV	BIT(26)
> +#define KRYO_ERRXSTATUS_UE	BIT(29)
> +#define KRYO_ERRXSTATUS_VALID	BIT(30)
> +
> +/* ARM Cortex-A76 TRM Chapter B3.5
> + * IC = Instruction Cache, DC = Data Cache
> + */
> +#define KRYO_L1_UNIT_IC		0x1
> +#define KRYO_L2_UNIT_TLB	0x2
> +#define KRYO_L1_UNIT_DC		0x4
> +#define KRYO_L2_UNIT		0x8
> +
> +/*
> + * ARM Cortex-A55 TRM Chapter B2.36
> + * ARM Cortex-A75, Cortex-A76 TRM Chapter B2.37
> + */
> +#define KRYO_ERR_RECORD_L1_L2	0x0
> +#define KRYO_ERR_RECORD_L3	0x1
> +
> +/* ARM DSU TRM Chapter B2.10 */
> +#define BUS_ERROR		0x12
> +
> +/* QCOM Kryo CPU part numbers */
> +#define KRYO3XX_GOLD		0x802
> +#define KRYO4XX_GOLD		0x804
> +#define KRYO4XX_SILVER_V1	0x803
> +#define KRYO4XX_SILVER_V2	0x805
> +
> +#define KRYO_EDAC_MSG_MAX	256
> +
> +static int poll_msec = 1000;
> +module_param(poll_msec, int, 0444);
> +
> +enum {
> +	KRYO_L1 = 0,
> +	KRYO_L2,
> +	KRYO_L3,
> +};
> +
> +/* CE = Corrected Error, UE = Uncorrected Error, DE = Deferred Error */
> +enum {
> +	KRYO_L1_CE = 0,
> +	KRYO_L1_UE,
> +	KRYO_L1_DE,
> +	KRYO_L2_CE,
> +	KRYO_L2_UE,
> +	KRYO_L2_DE,
> +	KRYO_L3_CE,
> +	KRYO_L3_UE,
> +	KRYO_L3_DE,
> +};
> +
> +struct error_record {
> +	u32 error_code;
> +	const char *error_msg;
> +};
> +
> +struct error_type {
> +	void (*fn)(struct edac_device_ctl_info *edev_ctl,
> +		   int inst_nr, int block_nr, const char *msg);
> +	const char *msg;
> +};
> +
> +/*
> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.10
> + * ARM DSU TRM Chapter B2.10
> + */
> +static const struct error_record serror_record[] = {
> +	{ 0x1,	"Errors due to fault injection"		},
> +	{ 0x2,	"ECC error from internal data buffer"	},
> +	{ 0x6,	"ECC error on cache data RAM"		},
> +	{ 0x7,	"ECC error on cache tag or dirty RAM"	},
> +	{ 0x8,	"Parity error on TLB data RAM"		},
> +	{ 0x9,	"Parity error on TLB tag RAM"		},
> +	{ 0x12,	"Error response for a cache copyback"	},
> +	{ 0x15,	"Deferred error not supported"		},
> +};
> +
> +static const struct error_type err_type[] = {
> +	{ edac_device_handle_ce, "Kryo L1 Corrected Error"	},
> +	{ edac_device_handle_ue, "Kryo L1 Uncorrected Error"	},
> +	{ edac_device_handle_ue, "Kryo L1 Deferred Error"	},
> +	{ edac_device_handle_ce, "Kryo L2 Corrected Error"	},
> +	{ edac_device_handle_ue, "Kryo L2 Uncorrected Error"	},
> +	{ edac_device_handle_ue, "Kryo L2 Deferred Error"	},
> +	{ edac_device_handle_ce, "L3 Corrected Error"		},
> +	{ edac_device_handle_ue, "L3 Uncorrected Error"		},
> +	{ edac_device_handle_ue, "L3 Deferred Error"		},
> +};
> +

All that is not really needed - you can put the whole error type
detection and dumping in kryo_check_err_type() in nicely readable
switch-case statement. No need for the function pointers and special
structs.

> +static struct edac_device_ctl_info __percpu *edac_dev;
> +static struct edac_device_ctl_info *drv_edev_ctl;
> +
> +static const char *get_error_msg(u64 errxstatus)
> +{
> +	const struct error_record *rec;
> +	u32 errxstatus_serr;
> +
> +	errxstatus_serr = FIELD_GET(KRYO_ERRXSTATUS_SERR, errxstatus);
> +
> +	for (rec = serror_record; rec->error_code; rec++) {
> +		if (errxstatus_serr == rec->error_code)
> +			return rec->error_msg;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void dump_syndrome_reg(int error_type, int level,
> +			      u64 errxstatus, u64 errxmisc,
> +			      struct edac_device_ctl_info *edev_ctl)
> +{
> +	char msg[KRYO_EDAC_MSG_MAX];
> +	const char *error_msg;
> +	int cpu;
> +
> +	cpu = raw_smp_processor_id();

Why raw_?

> +
> +	error_msg = get_error_msg(errxstatus);
> +	if (!error_msg)
> +		return;
> +
> +	snprintf(msg, KRYO_EDAC_MSG_MAX,
> +		 "CPU%d: %s, ERRXSTATUS_EL1:%#llx ERRXMISC0_EL1:%#llx, %s",
> +		 cpu, err_type[error_type].msg, errxstatus, errxmisc,
> +		 error_msg);
> +
> +	err_type[error_type].fn(edev_ctl, 0, level, msg);
> +}

...

> +static int kryo_l1_l2_setup_irq(struct platform_device *pdev,
> +				struct edac_device_ctl_info *edev_ctl)
> +{
> +	int cpu, errirq, faultirq, ret;
> +
> +	edac_dev = devm_alloc_percpu(&pdev->dev, *edac_dev);
> +	if (!edac_dev)
> +		return -ENOMEM;
> +
> +	for_each_possible_cpu(cpu) {
> +		preempt_disable();
> +		per_cpu(edac_dev, cpu) = edev_ctl;
> +		preempt_enable();
> +	}

That sillyness doesn't belong here, if at all.

...

> +static void kryo_poll_cache_error(struct edac_device_ctl_info *edev_ctl)
> +{
> +	if (!edev_ctl)
> +		edev_ctl = drv_edev_ctl;

That's silly.

> +
> +	on_each_cpu(kryo_check_l1_l2_ecc, edev_ctl, 1);
> +	kryo_check_l3_scu_ecc(edev_ctl);
> +}

...

> +static int qcom_kryo_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edev_ctl;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	qcom_kryo_edac_setup();

This function needs to have a return value saying whether it did setup
the hw properly or not and the probe function needs to return here if
not.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

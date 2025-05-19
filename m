Return-Path: <linux-edac+bounces-3936-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE98ABB7E1
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 10:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA021886E6B
	for <lists+linux-edac@lfdr.de>; Mon, 19 May 2025 08:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9297268FE4;
	Mon, 19 May 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H6KHD67x"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3533920E314;
	Mon, 19 May 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644730; cv=none; b=GseaC4zZ2vK91zTSrbAK18IrsIuF3MiSL911+12pGu9i/w8dfI2S2DMw/t+nbEJLmJ4wRZM2TmMrfr6uLzx+mfxY7lJs4mifkc3WNuYrkpGxPhc9iV1ZuZaBedT/gBweMO4tg4GgCRyLY0gDEmNZWvJEROVTX89alntlkH6ndqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644730; c=relaxed/simple;
	bh=q7dnLFf6kxJfpCghs26+SPYkdIcYU8faAbnHQgdOfwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+hQDxMS5dIP74uyV999sA9CsHjW7G7pkHAAzo2/ruSsZlUceNWbxzvdgD/e1mJ1tawc9LCiZniQ40Hln1XAElVEbtGd5uy/BAVr1fiTXfzV/JKRNURlyQUOhXyW745KVWC/Lo4g/BhU7llYlGni94Lx8OHGjYgnDtrztibk3Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=H6KHD67x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D77440E0238;
	Mon, 19 May 2025 08:51:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TUoEEvZbuIj3; Mon, 19 May 2025 08:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1747644712; bh=H1Dbx+jlVuY40/17dX2Qjsfgczw/R7D5OBHWT8mp4p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H6KHD67xN/ODLnFhuA1OlWrFuYNJL4tray6Od+ZB+yD60rXqyuRvU6ZMu94qvjh8M
	 let3GSm0c7+VsOALw8ZxOS205J5Npd0GsV89A2xlIFNwg32F+y3w2m2ZMFg87qjo95
	 Udc6koTzMP8iwxRLFfhd1ftdHSnYL1ancr+X0jfNZpJ8tcxFOgpT5ZHopw3or+Yozj
	 s/AVFq+3G1InczVfKQC8b1G2Gjq8QHCH0o9ov6RCuDDmO1fdm3xNl7HGNlo1/vE8H7
	 J0JKEn5nbNbh/xbvkMEwR7ZVfTJ/5lzoZse7OWr5gGY8C6OnpnOG4D4VJLgHScg0qG
	 RrGTBLJaRTVb8ND8cwvkgg9T/ItCbaHthMoL0rNWadx1MAm/aSMbDAHjjCz9Qmeka1
	 80zpoMliBvzoAZ9/jUUzL6dbLj45YzVnmcAlLpCUGnM6EHKo8C/TMPu2CE2iQCrcq1
	 sm/mI1ruxoSp2u/3d50z9gcoUxipLARxQd00hEPFi0jFfrq9ZxohyxsBGA4uw7PPol
	 uPPiJ0oMTIELKHvjVK+gRcmi/CVz6115yhAeqroUoPpnI2hxKNdO8KcS9odFcxveMv
	 2QGO4uZwSMI7Kkw4Yx3IAaRYPa+4s3a8eMPfWtaMOqwkLF80awOw/iRiAdhk4PtdPD
	 cusshacPCogQ5YC3mSGDILQs=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5367740E015E;
	Mon, 19 May 2025 08:51:37 +0000 (UTC)
Date: Mon, 19 May 2025 10:51:30 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Tony Luck <tony.luck@intel.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
	Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72
Message-ID: <20250519085130.GFaCrxEnZvaoETKrao@fat_crate.local>
References: <1747353973-4749-1-git-send-email-vijayb@linux.microsoft.com>
 <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1747353973-4749-2-git-send-email-vijayb@linux.microsoft.com>

On Thu, May 15, 2025 at 05:06:11PM -0700, Vijay Balakrishna wrote:
> Subject: Re: [PATCH 1/3] drivers/edac: Add L1 and L2 error detection for A72

git log drivers/edac/

to get inspired about proper commit titles and prefix.

> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The Cortex A72 cores have error detection capabilities for
> the L1/L2 Caches, this patch adds a driver for them. The selected errors

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> to detect/report are by reading CPU/L2 memory error syndrome registers.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version [1] of this
> driver.  For reasons stated in thread [1], the error injection code is
> not suitable for mainline, so it is removed from the driver.
> 
> [1] https://lore.kernel.org/all/1521073067-24348-1-git-send-email-york.sun@nxp.com/#t
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Co-developed-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> ---
>  drivers/edac/Kconfig    |   8 ++
>  drivers/edac/Makefile   |   1 +
>  drivers/edac/edac_a72.c | 233 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 242 insertions(+)
>  create mode 100644 drivers/edac/edac_a72.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 19ad3c3b675d..7c99bb04b0c4 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -576,4 +576,12 @@ config EDAC_LOONGSON
>  	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
>  	  are compatible.
>  
> +config EDAC_CORTEX_A72
> +	tristate "ARM Cortex A72"
> +	depends on ARM64
> +	help
> +	  Support for L1/L2 cache error detection for ARM Cortex A72 processor.
> +	  The detected and reported erros are from reading CPU/L2 memory error

+         The detected and reported erros are from reading memory error
Unknown word [erros] in Kconfig help text.
Suggestions: ['errors', 'Eros', 'errs', 'euros'...

> +	  syndrome registers.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index a8f2d8f6c894..835539b5d5af 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
>  obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_A72)	+= edac_a72.o

I don't know what tree you are preparing your patches against - it should be
this one:

https://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git/log/?h=edac-for-next

but the indentation level here is wrong:

obj-$(CONFIG_EDAC_ZYNQMP)^I^I+= zynqmp_edac.o$
obj-$(CONFIG_EDAC_VERSAL)^I^I+= versal_edac.o$
obj-$(CONFIG_EDAC_LOONGSON)^I^I+= loongson_edac.o$
obj-$(CONFIG_EDAC_CORTEX_A72)^I+= edac_a72.o$
			     ^^^

after I apply your patch.

> diff --git a/drivers/edac/edac_a72.c b/drivers/edac/edac_a72.c
> new file mode 100644
> index 000000000000..13acd7e7cef0
> --- /dev/null
> +++ b/drivers/edac/edac_a72.c
> @@ -0,0 +1,233 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A72 EDAC L1 and L2 cache error detection
> + *
> + * Copyright (c) 2020 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
> + *
> + * Based on Code from:
> + * Copyright (c) 2018, NXP Semiconductor
> + * Author: York Sun <york.sun@nxp.com>
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/bitfield.h>
> +#include <asm/smp_plat.h>
> +
> +#include "edac_module.h"
> +
> +#define DRVNAME				"edac-a72"
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
> +#define TLB_RAM				0x18
> +
> +#define L2MERRSR_EL1_CPUID_WAY	GENMASK(21, 18)
> +
> +#define L2MERRSR_EL1_VALID		BIT(31)
> +#define L2MERRSR_EL1_FATAL		BIT(63)
> +
> +struct merrsr {
> +	u64 cpumerr;
> +	u64 l2merr;
> +};

That struct naming needs some making the names more understandable. "merrsr"
doesn't tell me anything.

> +
> +#define MESSAGE_SIZE 64
> +
> +#define SYS_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
> +#define SYS_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)

Please group all defines together, align them vertically and then put other
definitions below. Look at other drivers for inspiration.

> +
> +static struct cpumask compat_mask;
> +
> +static void report_errors(struct edac_device_ctl_info *edac_ctl, int cpu,
> +			  struct merrsr *merrsr)
> +{
> +	char msg[MESSAGE_SIZE];
> +	u64 cpumerr = merrsr->cpumerr;
> +	u64 l2merr = merrsr->l2merr;

The edac-tree preferred ordering of variable declarations at the
beginning of a function is reverse fir tree order::

	struct long_struct_name *descriptive_name;
	unsigned long foo, bar;
	unsigned int tmp;
	int ret;

The above is faster to parse than the reverse ordering::

	int ret;
	unsigned int tmp;
	unsigned long foo, bar;
	struct long_struct_name *descriptive_name;

And even more so than random ordering::

	unsigned long foo, bar;
	int ret;
	struct long_struct_name *descriptive_name;
	unsigned int tmp;

Please check all your functions.

> +
> +	if (cpumerr & CPUMERRSR_EL1_VALID) {
> +		const char *str;
> +		bool fatal = cpumerr & CPUMERRSR_EL1_FATAL;
> +
> +		switch (FIELD_GET(CPUMERRSR_EL1_RAMID, cpumerr)) {
> +		case L1_I_TAG_RAM:
> +			str = "L1-I Tag RAM";
> +			break;
> +		case L1_I_DATA_RAM:
> +			str = "L1-I Data RAM";
> +			break;
> +		case L1_D_TAG_RAM:
> +			str = "L1-D Tag RAM";
> +			break;
> +		case L1_D_DATA_RAM:
> +			str = "L1-D Data RAM";
> +			break;
> +		case TLB_RAM:
> +			str = "TLB RAM";
> +			break;
> +		default:
> +			str = "Unspecified";
> +			break;
> +		}
> +
> +		snprintf(msg, MESSAGE_SIZE, "%s %s error(s) on CPU %d",
> +			 str, fatal ? "fatal" : "correctable", cpu);
> +
> +		if (fatal)
> +			edac_device_handle_ue(edac_ctl, cpu, 0, msg);
> +		else
> +			edac_device_handle_ce(edac_ctl, cpu, 0, msg);
> +	}
> +
> +	if (l2merr & L2MERRSR_EL1_VALID) {
> +		bool fatal = l2merr & L2MERRSR_EL1_FATAL;
> +
> +		snprintf(msg, MESSAGE_SIZE, "L2 %s error(s) on CPU %d CPUID/WAY 0x%lx",
> +			 fatal ? "fatal" : "correctable", cpu,
> +			 FIELD_GET(L2MERRSR_EL1_CPUID_WAY, l2merr));
> +		if (fatal)
> +			edac_device_handle_ue(edac_ctl, cpu, 1, msg);
> +		else
> +			edac_device_handle_ce(edac_ctl, cpu, 1, msg);
> +	}
> +}
> +
> +static void read_errors(void *data)
> +{
> +	struct merrsr *merrsr = data;
> +
> +	merrsr->cpumerr = read_sysreg_s(SYS_CPUMERRSR_EL1);
> +	if (merrsr->cpumerr & CPUMERRSR_EL1_VALID) {
> +		write_sysreg_s(0, SYS_CPUMERRSR_EL1);
> +		isb();
> +	}
> +	merrsr->l2merr = read_sysreg_s(SYS_L2MERRSR_EL1);
> +	if (merrsr->l2merr & L2MERRSR_EL1_VALID) {
> +		write_sysreg_s(0, SYS_L2MERRSR_EL1);
> +		isb();
> +	}
> +}
> +
> +static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)

All static functions don't need a prefix "cortex_arm64_".

> +{
> +	struct merrsr merrsr;
> +	int cpu;

I'd venture a guess you need to protect here against CPU hotplug...

> +	for_each_cpu_and(cpu, cpu_online_mask, &compat_mask) {
> +		smp_call_function_single(cpu, read_errors, &merrsr, true);
> +		report_errors(edac_ctl, cpu, &merrsr);
> +	}
> +}
> +
> +static int cortex_arm64_edac_probe(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_ctl;
> +	struct device *dev = &pdev->dev;
> +	int rc;
> +
> +	edac_ctl = edac_device_alloc_ctl_info(0, "cpu",
> +					      num_possible_cpus(), "L", 2, 1,
> +					      edac_device_alloc_index());
> +	if (!edac_ctl)
> +		return -ENOMEM;
> +
> +	edac_ctl->edac_check = cortex_arm64_edac_check;
> +	edac_ctl->dev = dev;
> +	edac_ctl->mod_name = dev_name(dev);
> +	edac_ctl->dev_name = dev_name(dev);
> +	edac_ctl->ctl_name = DRVNAME;
> +	dev_set_drvdata(dev, edac_ctl);
> +
> +	rc = edac_device_add_device(edac_ctl);
> +	if (rc)
> +		goto out_dev;
> +
> +	return 0;
> +
> +out_dev:
> +	edac_device_free_ctl_info(edac_ctl);
> +
> +	return rc;
> +}
> +
> +static void cortex_arm64_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
> +
> +	edac_device_del_device(edac_ctl->dev);
> +	edac_device_free_ctl_info(edac_ctl);
> +}
> +
> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> +	{ .compatible = "arm,cortex-a72" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
> +
> +static struct platform_driver cortex_arm64_edac_driver = {
> +	.probe = cortex_arm64_edac_probe,
> +	.remove = cortex_arm64_edac_remove,
> +	.driver = {
> +		.name = DRVNAME,
> +	},
> +};
> +
> +static int __init cortex_arm64_edac_driver_init(void)
> +{
> +	struct device_node *np;
> +	int cpu;
> +	struct platform_device *pdev;
> +	int err;
> +
> +	for_each_possible_cpu(cpu) {
> +		np = of_get_cpu_node(cpu, NULL);
> +

^ Superfluous newline.

> +		if (!np) {
> +			pr_warn("failed to find device node for cpu %d\n", cpu);

In visible strings s/cpu/CPU/g

> +			continue;
> +		}
> +		if (!of_match_node(cortex_arm64_edac_of_match, np))
> +			continue;
> +		if (!of_property_read_bool(np, "edac-enabled"))
> +			continue;
> +		cpumask_set_cpu(cpu, &compat_mask);
> +		of_node_put(np);
> +	}
> +
> +	if (cpumask_empty(&compat_mask))
> +		return 0;
> +
> +	err = platform_driver_register(&cortex_arm64_edac_driver);
> +	if (err)
> +		return err;
> +
> +	pdev = platform_device_register_simple(DRVNAME, -1, NULL, 0);
> +	if (IS_ERR(pdev)) {
> +		pr_err("failed to register cortex arm64 edac device\n");

That driver is called edac_a72 now.

"cortex arm64 edac" is too broad.

> +		platform_driver_unregister(&cortex_arm64_edac_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


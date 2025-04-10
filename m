Return-Path: <linux-edac+bounces-3511-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EEDAA84DD9
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 22:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 828BB3BD6EC
	for <lists+linux-edac@lfdr.de>; Thu, 10 Apr 2025 20:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA6028F928;
	Thu, 10 Apr 2025 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b="oivZCN9Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rt05rOmy"
X-Original-To: linux-edac@vger.kernel.org
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7E202F70;
	Thu, 10 Apr 2025 20:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744315487; cv=none; b=cBF5ezOfi3RcbUW1O7qcBXloKzhMboicauikxBMk93ElkD9o4IrgreXsfmtRQAU8lWHetLpL7gHCxBW9QG6maexSygM0B8t1GC1P3Grd5iVbs0CWkeIbRbBO5K87SVKGEjwvktDoAGdGQf3TVlJJ/5xkbhFjFd/20sTbs5atPxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744315487; c=relaxed/simple;
	bh=wjZJUrZbnrSvAwdEOrspdz/xMaW1SemoQ019FHE4J40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQjW+Xt90TFn9eYT3HSfwBL1EV6g89Kyrw77QXmTkDYLaUjrCNJ89F/tmiix1zg7RTifC8tr5GDHpIHJYqNXl28oFfkTQkqTxjQvcksoUK9U3s2gAKainNJ6smsxjizKdU3CJurNcufknMOzfU6X4MvFVdL0kZM/iQabApxCfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com; spf=pass smtp.mailfrom=tyhicks.com; dkim=pass (2048-bit key) header.d=tyhicks.com header.i=@tyhicks.com header.b=oivZCN9Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rt05rOmy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tyhicks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tyhicks.com
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id D34BD11400A4;
	Thu, 10 Apr 2025 16:04:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 10 Apr 2025 16:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744315483; x=1744401883; bh=xsMm0bCGVS
	J+nqDyct8nfa/ZHdaCCYkJPG5jDmGQg4s=; b=oivZCN9Qt4XQSWJBEE3IRrEP2A
	d73Q9hsi54QSzHbJwQh7iGOjcUftOad5jR6QxAw8XWdlyUntLgPBz5UU3Ni+vV2m
	W7GygnYTdB1X5cl7/T2N/vDGDeaxtzoH3/0TRuvi7TrfBJkqU0oNy47QUNEUQtdt
	KrKtprPQtsnnc3xg+NSJBpIzSue4OcCgCejuylyxsUQ3fjO3tDEAIZ4ceXshFR76
	e+i74x+6iVWfcEuuboGshv/KnQG9iqRux6ZaGuGYdyns1oMlGr1PBPJHzpTVXK0X
	BQWMktYWt33EnZasgUc++TqLWk8jqZPq55tXg5jReeFJgr17/pZoGsovKfXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744315483; x=1744401883; bh=xsMm0bCGVSJ+nqDyct8nfa/ZHdaCCYkJPG5
	jDmGQg4s=; b=rt05rOmykUDqmA/mEct5Y0ZkM4bPPmAa+sahW7h92xR+541D3u4
	UW5kaL4jVYBonbb2/I92ULbcO9lWCfAdFiTcdA+Zne5iohK+R2OWSP7F9KahEcE0
	m5vL3a/0XJUxC/xmH3AwCM2LNrk59kx+h43CPVFp56e3wqxEqrnYh3KnuaFW6/kU
	4Nw7uZ8n0j7UzBRYsGfJrvuwPZcxu+ynMXbCv8cjZ97/4o99dOH/OGgWjsl8oyGm
	xMmWCd9mtR2Ke3ObfhEXTkz9hlk6dCKg4ODJWjOJWyeEhPS4IUiXkMnHXcLkiufA
	KheAU4xZj3RqWz3yYVxvuJP9gtCgljMcXNQ==
X-ME-Sender: <xms:WyT4Zwk5JPJgivWe_6VQ7-vDIh8Q4BNhos3GrRnI5cgtTEYK8-hR6Q>
    <xme:WyT4Z_167E7eJ9cbxcHAyitF8pQeU1qfYVHUB5O6mV48TbT8l70k8SQuipcHMLAp_
    EydmLweKxQwpEYrkPc>
X-ME-Received: <xmr:WyT4Z-oDzM8Rg_x4IR_lYK4kxTe2Nyh_nTcg73TTuZgTRAEE9b6Qzcud-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdelkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepfdfvhihlvghrucfjihgtkhhsucdlofhitghrohhsohhfthdmfdcuoe
    gtohguvgesthihhhhitghkshdrtghomheqnecuggftrfgrthhtvghrnhepgfevhfeutedt
    fedtteffleevhfevhefgvedtleffvdetkeetleehteejfeekkeetnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtghomhdpnhgspghrtghpthhtohepud
    dtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehvihhjrgihsgeslhhinhhugidr
    mhhitghrohhsohhfthdrtghomhdprhgtphhtthhopegsphesrghlihgvnhekrdguvgdprh
    gtphhtthhopehtohhnhidrlhhutghksehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgr
    mhgvshdrmhhorhhsvgesrghrmhdrtghomhdprhgtphhtthhopehmtghhvghhrggssehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehrrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtoheplhhinhhugidqvggurggtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepmhgriieskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WyT4Z8lS_ZH7ddIemiEsYpUPXaZ7PolYKwFy8VuFCHdTpTB92hharg>
    <xmx:WyT4Z-2ZzJw19KEVhl9TaBnsWQCg27c205x1U_QDUg4r3vtQzrk3Vw>
    <xmx:WyT4ZzsUy4IcRX2EhbcupRa7XpRC_2KQi-m4aHIvg3lnGCTKX7HP3Q>
    <xmx:WyT4Z6UwpmcwWGDQA0_bPrDV4a520rscMGNQn0anDQtOiyAAc3kjOg>
    <xmx:WyT4Z3YNGCwmjgZLfolVksaPtJRzM5dXF1lrmRFE5cACphMU1l0o6ln2>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Apr 2025 16:04:42 -0400 (EDT)
Date: Thu, 10 Apr 2025 15:04:40 -0500
From: "Tyler Hicks (Microsoft)" <code@tyhicks.com>
To: Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc: Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/2] drivers/edac: Add L1 and L2 error detection for A53,
 A57 and A72
Message-ID: <Z/gkWCiveESbvdxS@redbud>
References: <1744241785-20256-1-git-send-email-vijayb@linux.microsoft.com>
 <1744241785-20256-2-git-send-email-vijayb@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744241785-20256-2-git-send-email-vijayb@linux.microsoft.com>

On 2025-04-09 16:36:24, Vijay Balakrishna wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The Cortex A53, A57 and A72 cores have error detection capabilities for
> the L1/L2 Caches, this patch adds a driver for them. The selected errors
> to detect/report have compatible bit assignments concerning CPU/L2 memory
> error syndrome registers.
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
>  drivers/edac/Kconfig              |   9 ++
>  drivers/edac/Makefile             |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c | 225 ++++++++++++++++++++++++++++++
>  3 files changed, 235 insertions(+)
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 19ad3c3b675d..20c15a18437f 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -576,4 +576,13 @@ config EDAC_LOONGSON
>  	  errors (CE) only. Loongson-3A5000/3C5000/3D5000/3A6000/3C6000
>  	  are compatible.
>  
> +config EDAC_CORTEX_ARM64_L1_L2
> +	tristate "ARM Cortex A72/A57/A53"
> +	depends on ARM64
> +	help
> +	  Support for L1/L2 cache error detection is provided for ARM Cortex
> +	  A72, A57, and A53 processors. The selected subset of errors is common
> +	  across these three MPCore processors, featuring compatible bit
> +	  assignments in their CPU/L2 memory error syndrome registers.
> +
>  endif # EDAC
> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index a8f2d8f6c894..157062410e61 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_NPCM)			+= npcm_edac.o
>  obj-$(CONFIG_EDAC_ZYNQMP)		+= zynqmp_edac.o
>  obj-$(CONFIG_EDAC_VERSAL)		+= versal_edac.o
>  obj-$(CONFIG_EDAC_LOONGSON)		+= loongson_edac.o
> +obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o
> diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
> new file mode 100644
> index 000000000000..2ffe20212acb
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_l1_l2.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A72, A57 and A53 EDAC L1 and L2 cache error detection
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
> +
> +#define MESSAGE_SIZE 64
> +
> +#define SYS_CPUMERRSR_EL1			sys_reg(3, 1, 15, 2, 2)
> +#define SYS_L2MERRSR_EL1			sys_reg(3, 1, 15, 2, 3)
> +
> +static struct cpumask compat_mask;
> +
> +static void report_errors(struct edac_device_ctl_info *edac_ctl, int cpu,
> +			  struct merrsr *merrsr)
> +{
> +	char msg[MESSAGE_SIZE];
> +	u64 cpumerr = merrsr->cpumerr;
> +	u64 l2merr = merrsr->l2merr;
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
> +
> +		write_sysreg_s(0, SYS_CPUMERRSR_EL1);
> +		isb();

I think the register writes and barriers should happen much closer to the
register reads, in read_errors(). Looking back at Marc's feedback on v5, I
think his most important piece of feedback was to only clear the register when
the valid bit is set to avoid accidentally clobbering an error that came in
between the register read and write.

By moving the register writes into report_errors() in this v6 series, there's
now a much larger window where new errors could occur between the register
read and the register write. Those new errors would be silently lost/ignored.
Reducing the window to the least number of cycles seems important for accurate
reporting.

> +	}
> +
> +	if (l2merr & L2MERRSR_EL1_VALID) {
> +		bool fatal = l2merr & L2MERRSR_EL1_FATAL;
> +
> +		snprintf(msg, MESSAGE_SIZE, "L2 %s error(s) on CPU %d CPUID/WAY 0x%x",
> +			 fatal ? "fatal" : "correctable", cpu,
> +			 FIELD_GET(L2MERRSR_EL1_CPUID_WAY, l2merr));
> +		if (fatal)
> +			edac_device_handle_ue(edac_ctl, cpu, 1, msg);
> +		else
> +			edac_device_handle_ce(edac_ctl, cpu, 1, msg);
> +
> +		write_sysreg_s(0, SYS_L2MERRSR_EL1);
> +		isb();
> +	}
> +}
> +
> +static void read_errors(void *data)
> +{
> +	struct merrsr *merrsr = data;
> +
> +	merrsr->cpumerr = read_sysreg_s(SYS_CPUMERRSR_EL1);
> +	merrsr->l2merr = read_sysreg_s(SYS_L2MERRSR_EL1);
> +}
> +
> +static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
> +{
> +	struct merrsr merrsr;
> +	int cpu;
> +
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
> +					      num_possible_cpus(), "L", 2, 1, NULL, 0,
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
> +static int cortex_arm64_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_ctl = dev_get_drvdata(&pdev->dev);
> +
> +	edac_device_del_device(edac_ctl->dev);
> +	edac_device_free_ctl_info(edac_ctl);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> +	{ .compatible = "arm,cortex-a53" },
> +	{ .compatible = "arm,cortex-a57" },
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

Copilot correctly points out that we don't check np for NULL here. I think
of_match_node() handles that fine but we get fairly deep into the call stack
before it is caught. Let's go ahead and proactive check the return value.

More importantly, it pointed out that we don't call of_node_put(np) before
moving onto the next CPU. This would result in a refcount issue and will need
to be fixed.

Thanks!

Tyler

> +
> +		if (!of_match_node(cortex_arm64_edac_of_match, np))
> +			continue;
> +		if (!of_property_read_bool(np, "edac-enabled"))
> +			continue;
> +		cpumask_set_cpu(cpu, &compat_mask);
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
> +		platform_driver_unregister(&cortex_arm64_edac_driver);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;
> +}
> +
> +device_initcall(cortex_arm64_edac_driver_init);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Sascha Hauer <s.hauer@pengutronix.de>");
> +MODULE_DESCRIPTION("Cortex A72, A57 and A53 L1 and L2 cache EDAC driver");
> -- 
> 2.49.0
> 


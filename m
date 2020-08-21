Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9923224D465
	for <lists+linux-edac@lfdr.de>; Fri, 21 Aug 2020 13:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHULrC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 21 Aug 2020 07:47:02 -0400
Received: from foss.arm.com ([217.140.110.172]:58018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728577AbgHULjv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 21 Aug 2020 07:39:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 915C41063;
        Fri, 21 Aug 2020 04:38:58 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5919B3F6CF;
        Fri, 21 Aug 2020 04:38:57 -0700 (PDT)
Subject: Re: [PATCH] edac: nxp: Add L1 and L2 error detection for A53 and A72
 cores
To:     Alison Wang <alison.wang@nxp.com>, bp@alien8.de,
        tony.luck@intel.com
Cc:     mchehab@kernel.org, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200709082215.12829-1-alison.wang@nxp.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <92811e33-2f57-244b-4b50-c2831b09b835@arm.com>
Date:   Fri, 21 Aug 2020 12:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709082215.12829-1-alison.wang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Alison,

On 09/07/2020 09:22, Alison Wang wrote:
> Add error detection for A53 and A72 cores. Hardware error injection is
> supported on A53. Software error injection is supported on both.

> For hardware error injection on A53 to work, proper access to
> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware.

Not just hardware error injection, any access to these registers needs to be granted by
each higher exception level. If you run as a KVM guest, all access to these
implementation-defined registers is disabled.

This means your driver doesn't work on:
| compatible = "arm,cortex-a53-edac" or "arm,cortex-a72-edac",

as it also depends on firmware settings.


Writing to CPUACTLR_EL1 isn't something we can do in linux. The TRM has this clanger:
| The CPU Auxiliary Control Register can be written only when the system is idle. ARM
| recommends that you write to this register after a powerup reset, before the MMU is
| enabled, and before any ACE or ACP traffic begins.

We can't make the system idle from linux. Only firmware can do this.

The same goes for L2ACTLR.


> This is
> done by making an SMC call in the driver. Failure to enable access
> disables hardware error injection. For error detection to work, another
> SMC call enables access to L2ECTLR_EL1.

Ewww. Surely this should either be enabled, or disabled. What is the point of letting the
OS toggle it?

Using these registers, you can do dangerous things like turn the L2 cache off. Does your
platform have any resident secure-world software?


> It is for NXP's Layerscape family LS1043A, LS1046A, LS2088A and LX2160A.

Please ensure your driver probes from the top-level platform compatible. This is the only
way to know the platform has your firmware, with the special settings and magic SMC call
that the driver depends on.


> Signed-off-by: York Sun <york.sun@nxp.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>

Who is the author of this patch?

If the first Signed-of-by tag isn't for the person posting the patch, there should be a
'From:' line in the patch so that git picks up the author properly when the maintainer
applies the patch.
If you set the author of the patch correctly in git, git format-patch will do the right
thing for you.


> diff --git a/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt> new file mode 100644
> index 000000000000..41c840993814
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt

Binding patches should be in a separate patch, that appears first in the series. The whole
series should be copied to the devicetree mailing list: devicetree@vger.kernel.org

You should also run get-maintainers.pl to ensure you copy the devicetree maintainers.


> @@ -0,0 +1,40 @@
> +ARM Cortex A53 and A72 L1/L2 cache error reporting
> +
> +CPU Memory Error Syndrome and L2 Memory Error Syndrome registers can be
> +used for checking L1 and L2 memory errors. However, only A53 supports
> +double-bit error injection to L1 and L2 memory. This driver uses the
> +hardware error injection when available, but also provides a way to
> +inject errors by software.
> +
> +To use hardware error injection and the interrupt, proper access needs
> +to be granted in ACTLR_EL3 (and/or ACTLR_EL2) register by EL3 firmware SMC call.

Please describe this as "on $platforms this is done by".
On others it may be enabled already, or not possible to enable at all.


> +Correctable errors do not trigger such interrupt.

What interrupt?


> This driver uses
> +dynamic polling internal to check for errors. The more errors detected,
> +the more frequently it polls. Combining with interrupt, this driver can
> +detect correctable and uncorrectable errors. However, if the
> +uncorrectable errors cause system abort exception, this driver is not able to
> +report errors in time.

The driver isn't involved in correct-ing the errors, this was already  done, or not-done,
by the hardware.
Please describe this as 'corrected and uncorrected', as the state is pretty final.


> +The SIP-specific SMC calls are only for NXP's Layerscape family LS1043A,
> +LS1046A, LS2088A and LX2160A.
> +
> +The following section describes the Cortex A53/A72 EDAC DT node binding.
> +
> +Required properties:
> +- compatible: Should be "arm,cortex-a53-edac" or "arm,cortex-a72-edac"
> +- cpus: Should be a list of compatible cores
> +
> +Optional properties:
> +- interrupts: Interrupt number if supported
> +
> +Example:
> +	edac {
> +		compatible = "arm,cortex-a53-edac";
> +		cpus = <&cpu0>,
> +		       <&cpu1>,
> +		       <&cpu2>,
> +		       <&cpu3>;
> +		interrupts = <0 108 0x4>;
> +
> +	};

Because this depends on firmware, please make this depend on the top-level compatible for
the whole platform.

It might be worth describing the SMC calls in the binding if its likely anyone else will
use the driver. (matching a platform, but no SMC defined would imply the access is always
enabled).

But the DT people will have the best view on what is best here.


> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7b6ec3014ba2..6317cebf0a95 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -530,4 +530,11 @@ config EDAC_DMC520
>  	  Support for error detection and correction on the
>  	  SoCs with ARM DMC-520 DRAM controller.


> +config EDAC_CORTEX_ARM64_L1_L2
> +	tristate "ARM Cortex A53/A72"

Please pick a name that indicates this driver is for layerscape socs.


> +	depends on ARM64 && ARCH_LAYERSCAPE

> +	help
> +	  Support for error detection on ARM Cortex A53 and A72 with Layerscape
> +	  SoC family LS1043A, LS1046A, LS2088A and LX2160A.
> +
>  endif # EDAC


> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
> index 269e15118cea..3edba6bea350 100644
> --- a/drivers/edac/Makefile
> +++ b/drivers/edac/Makefile
> @@ -88,3 +88,4 @@ obj-$(CONFIG_EDAC_QCOM)			+= qcom_edac.o
>  obj-$(CONFIG_EDAC_ASPEED)		+= aspeed_edac.o
>  obj-$(CONFIG_EDAC_BLUEFIELD)		+= bluefield_edac.o
>  obj-$(CONFIG_EDAC_DMC520)		+= dmc520_edac.o

> +obj-$(CONFIG_EDAC_CORTEX_ARM64_L1_L2)	+= cortex_arm64_l1_l2.o

'cortex' is a large number of CPUs. There is no guarantee these implementation-defined
registers behave in the same way on other versions. (we'd have to check each and every TRM)

The driver depends on your platform firmare, and doesn't build unless you select
ARCH_LAYERSCAPE.

Can I suggest naming it a53a72, or layerscape_cpu... ?


> diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
> new file mode 100644
> index 000000000000..0443384bd656
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_l1_l2.c
> @@ -0,0 +1,738 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Cortex A53 and A72 EDAC L1 and L2 cache error detection
> + *
> + * Copyright 2018-2020 NXP
> + * Author: York Sun <york.sun@nxp.com>
> + *
> + * Partially take from a similar driver by
> + * Brijesh Singh <brijeshkumar.singh@amd.com>
> + * Copyright (c) 2015, Advanced Micro Devices
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_device.h>
> +#include <linux/arm-smccc.h>
> +#include <asm/barrier.h>
> +#include <asm/cacheflush.h>
> +#include <asm/smp_plat.h>
> +
> +#include "edac_module.h"
> +#include "cortex_arm64_l1_l2.h"
> +
> +static int poll_msec = 1024;
> +static long l1_ce_sw_inject_count, l1_ue_sw_inject_count;
> +static long l2_ce_sw_inject_count, l2_ue_sw_inject_count;
> +static struct cpumask compat_mask;
> +static struct cpumask l1_ce_cpu_mask, l1_ue_cpu_mask;
> +static struct cpumask l2_ce_cpu_mask, l2_ue_cpu_mask;

> +static DEFINE_PER_CPU(unsigned long, actlr_en);
> +static DEFINE_PER_CPU(unsigned long, l2ectlr_en);
> +static DEFINE_PER_CPU(u64, cpumerr);
> +static DEFINE_PER_CPU(u64, cpuactlr);
> +static DEFINE_PER_CPU(u64, l2actlr);
> +static DEFINE_PER_CPU(u64, l2merr);

There are already per-cpu copies of all these in the hardware. Why would you need to read
it from another CPU?


> +static DEFINE_PER_CPU(call_single_data_t, csd_check);
> +static DEFINE_SPINLOCK(cortex_edac_lock);


> +static inline void read_cpuactlr(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();

> +	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));

There are versions of binutils that choke on this. See 72c583951526 for the story.

Please define a SYS_CPUACTLR_EL1 for this using the sys_reg() macro. It may as well be
private in this file.
Please use the read_sysreg() acessors as this makes for more readable code.


> +	per_cpu(cpuactlr, cpu) = val;

Why not return the value? We already have a per cpu copy of this register: in the register.


> +}

With the right macros, this is nothing more than:
| return read_sysreg_s(SYS_CPUACTLR_EL1)


> +static inline void write_cpuactlr(int *mem)

We can't write to CPUACTLR_EL1 when the system is running.
I don't think we can have this code.

(and write_cpuactlr() is a terrible name! it does lots more than that!)

> +{
> +	u64 val;
> +	int cpu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cortex_edac_lock, flags);
> +	cpu = smp_processor_id();
> +	__flush_dcache_area(mem, 8);
> +	asm volatile("mrs %0, S3_1_C15_C2_0" : "=r" (val));

> +	val |= L1_ERR_INJ_EN;

The TRM calls this 'L1DEIEN', using the same name as the TRM makes it a lot easier to find
what this does:
| Double-bit errors are injected on all writes to the L1 D-cache data RAMs for the first
| word of each 32-byte region.

What happens if your firmware takes an interrupt? Now the CPU will report faults for the
work firmware is doing.
What happens if the compiler decides to write to the stack while you have this set?


The TRM says not to write to this register unless the system is idle and the MMU is off.
We really can't do this in Linux.


> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
> +	asm volatile("isb sy");

> +	/* make cache dirty */
> +	*mem = 0xDEADBEEF;	/* write to L1 data causes error right away */
> +	__flush_dcache_area(mem, 8);
> +	val &= ~L1_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C2_0, %0" :: "r" (val));
> +	asm volatile("isb sy");
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);
> +}


For where they appear elsewhere, please use the macros in asm/barrier.h.
For DSB, please add a comment to describe what you need it for.



> +static inline void read_l2actlr(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
> +	per_cpu(l2actlr, cpu) = val;
> +}

return read_sysreg_s(SYS_L2ACTLR_EL1)


> +
> +static inline void write_l2actlr(int *mem)
> +{
> +	u64 val;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&cortex_edac_lock, flags);
> +	__flush_dcache_area(mem, 8);
> +	asm volatile("mrs %0, S3_1_C15_C0_0" : "=r" (val));
> +	val |= L2D_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
> +	asm volatile("isb sy");
> +	/* make cache dirty */
> +	*mem = 0xDEADBEEF;	/* Error will be reported when L2 is accessed. */
> +	__flush_dcache_area(mem, 8);
> +	val &= ~L2D_ERR_INJ_EN;
> +	asm volatile("dsb sy");
> +	asm volatile("msr S3_1_C15_C0_0, %0" :: "r" (val));
> +	asm volatile("isb sy");
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);
> +}

We can't do this in Linux.


> +static inline void write_l2ectlr_el1(void *info)
> +{
> +	u64 val;
> +	int cpu = smp_processor_id();
> +
> +	asm volatile("mrs %0, S3_1_C11_C0_3" : "=r" (val));
> +	if (val & L2_ERR_INT) {
> +		pr_debug("l2ectlr_el1 on cpu %d reads 0x%llx\n", cpu, val);
> +		val &= ~L2_ERR_INT;
> +		asm volatile("msr S3_1_C11_C0_3, %0" :: "r" (val));
> +	}
> +}
> +
> +static inline void write_cpumerrsr_el1(u64 val)
> +{
> +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (val));
> +}
> +
> +static void a53_allow_l1l2_err_inj(void *info)
> +{
> +	int cpu = smp_processor_id();
> +	struct arm_smccc_res res;
> +	unsigned long flags;
> +
> +	pr_debug("%s: cpu is %d\n", __func__, cpu);
> +	spin_lock_irqsave(&cortex_edac_lock, flags);

> +	arm_smccc_smc(NXP_SIP_SVC_ALLOW_L1L2_ERR, 0, 0, 0, 0, 0, 0, 0, &res);
> +	per_cpu(actlr_en, cpu) = res.a0;
> +	spin_unlock_irqrestore(&cortex_edac_lock, flags);

How do you know firmware implements this SMC? Your driver compatible was jut for the CPU.

This returns something. Please document what in the binding as someone else may implement
it for their A53/A72.

If you're returning a CPUACTLR_EL1 value, the OS can just read it from the register, which
should make the SMC call (and its description) simpler.



> +	pr_debug("%s: return is %ld\n", __func__, res.a0);
> +}

As we can't safely write to these registers from linux, so I think this means all the
error injection and maybe SMC stuff can disappear.


(I've not read past here..)



Thanks,

James


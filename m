Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4623434EAA
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2019 19:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbfFDRXT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jun 2019 13:23:19 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48490 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfFDRXT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Jun 2019 13:23:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A407315A2;
        Tue,  4 Jun 2019 10:23:18 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C4FD3F5AF;
        Tue,  4 Jun 2019 10:23:17 -0700 (PDT)
Subject: Re: [PATCH] EDAC/altera: Warm Reset option for Stratix10 peripheral
 DBE
To:     thor.thayer@linux.intel.com
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <9de1152b-25e0-3fb1-bf96-c8e45363942c@arm.com>
Date:   Tue, 4 Jun 2019 18:23:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Thor,

(CC: +Mark, Lorenzo and Sudeep for PSCI.
How should SYSTEM_RESET2 be used for a vendor-specific reset?

The original patch is:
lore.kernel.org/r/1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com
)

On 03/06/2019 21:37, thor.thayer@linux.intel.com wrote:
> From: Thor Thayer <thor.thayer@linux.intel.com>
> 
> The Stratix10 peripheral FIFO memories can recover from double
> bit errors with a warm reset instead of a cold reset.
> Add the option of a warm reset for peripheral (USB, Ethernet)
> memories.
> 
> CPU memories such as SDRAM and OCRAM require a cold reset for
> DBEs.
> Filter on whether the error is a SDRAM/OCRAM or a peripheral
> FIFO memory to determine which reset to use when the warm
> reset option is configured.

... so you want to make different SMC calls on each CPU after panic()?


> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 8816f74a22b4..179601f14b48 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -2036,6 +2036,19 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
>  /* panic routine issues reboot on non-zero panic_timeout */
>  extern int panic_timeout;
>  
> +#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
> +/* EL3 SMC call to setup CPUs for warm reset */
> +void panic_smp_self_stop(void)
> +{
> +	struct arm_smccc_res result;
> +
> +	__cpu_disable();
> +	cpu_relax();
> +	arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, S10_WARM_RESET_WFI_FLAG,
> +		      S10_WARM_RESET_WFI_FLAG, 0, 0, 0, 0, 0, &result);
> +}
> +#endif

Oooer!

panic_smp_self_stop() isn't for drivers to override: only the arch code.
__cpu_disable() is only for the cpu-hotplug machinery. Nothing else should touch it.

Isn't this thing only called if another CPU out there is panic()ing too?


I think one of the problems here is arm64 leaves secondary CPUs running after panic().
This would be better fixed by using the appropriate cpu_ops[]->cpu_die() call in arm64's
ipi_cpu_stop().


As for passing platform-specific options, PSCI[0] has a 'reset_type' for SYSTEM_RESET2,
which looks suspiciously like what you want here. I'm not sure how its expected to be
used... hopefully the PSCI maintainers can give us some pointers.

(The existing support is commit 4302e381a870 ("firmware/psci: add support for SYSTEM_RESET2"))


Is it possible for firmware to do both the cold/warm reset work when SYSTEM_RESET is
called? This would mean you don't have to care here and there are fewer choices to be made
overall.
If not, is there anything left behind that can give it the hint? Like non-zero error
counters for the USB/Ethernet devices?


> @@ -2067,14 +2080,28 @@ static int s10_edac_dberr_handler(struct notifier_block *this,
>  			regmap_write(edac->ecc_mgr_map,
>  				     S10_SYSMGR_UE_ADDR_OFST, err_addr);
>  			edac_printk(KERN_ERR, EDAC_DEVICE,
> -				    "EDAC: [Fatal DBE on %s @ 0x%08X]\n",
> -				    ed->edac_dev_name, err_addr);
> +				    "EDAC: [Fatal DBE on %s [CPU=%d] @ 0x%08X]\n",
> +				    ed->edac_dev_name, raw_smp_processor_id(),
> +				    err_addr);
>  			break;
>  		}
>  		/* Notify the System through SMC. Reboot delay = 1 second */
> +#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
> +		/* Handle peripheral FIFO DBE as Warm Resets */
> +		if (dberror & S10_COLD_RESET_MASK) {


> +			panic_timeout = 1;

Isn't this value supposed to be provided on the kernel commandline? Surely this prevents
debug using the commandline option to increase the delay?

(I see you already change it)


> +			arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0,
> +				      0, 0, 0, &result);
> +		} else {
> +			arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE,
> +				      S10_WARM_RESET_WFI_FLAG | dberror, 0, 0,
> +				      0, 0, 0, 0, &result);
> +		}
> +#else
>  		panic_timeout = 1;
>  		arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0, 0,
>  			      0, 0, &result);
> +#endif
>  	}
>  
>  	return NOTIFY_DONE;

What do these SMC do? Are they equivalent to the PSCI CPU online/offline calls?

panic() notifiers aren't robust as they can be skipped if kdump is loaded.


Thanks,

James


[0]
https://static.docs.arm.com/den0022/d/Power_State_Coordination_Interface_PDD_v1_1_DEN0022D.pdf

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1535202
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2019 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfFDVj5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jun 2019 17:39:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:40868 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFDVj5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Jun 2019 17:39:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 14:39:56 -0700
X-ExtLoop1: 1
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2019 14:39:55 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] EDAC/altera: Warm Reset option for Stratix10 peripheral
 DBE
To:     James Morse <james.morse@arm.com>
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com>
 <9de1152b-25e0-3fb1-bf96-c8e45363942c@arm.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <82108412-2f63-aebb-2526-fc6e71a04048@linux.intel.com>
Date:   Tue, 4 Jun 2019 16:42:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9de1152b-25e0-3fb1-bf96-c8e45363942c@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

On 6/4/19 12:23 PM, James Morse wrote:
> Hi Thor,
> 
> (CC: +Mark, Lorenzo and Sudeep for PSCI.
> How should SYSTEM_RESET2 be used for a vendor-specific reset?
> 
> The original patch is:
> lore.kernel.org/r/1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com
> )
> 

Thank you for reviewing my patch and bringing in additional expertise.

> On 03/06/2019 21:37, thor.thayer@linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> The Stratix10 peripheral FIFO memories can recover from double
>> bit errors with a warm reset instead of a cold reset.
>> Add the option of a warm reset for peripheral (USB, Ethernet)
>> memories.
>>
>> CPU memories such as SDRAM and OCRAM require a cold reset for
>> DBEs.
>> Filter on whether the error is a SDRAM/OCRAM or a peripheral
>> FIFO memory to determine which reset to use when the warm
>> reset option is configured.
> 
> ... so you want to make different SMC calls on each CPU after panic()?
> 
Yes. The registers needed for a warm reset need to be setup in EL3 
(U-Boot). As part of this, I needed the other CPUs (3 of the 4) to idle 
in WFI.

> 
>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>> index 8816f74a22b4..179601f14b48 100644
>> --- a/drivers/edac/altera_edac.c
>> +++ b/drivers/edac/altera_edac.c
>> @@ -2036,6 +2036,19 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
>>   /* panic routine issues reboot on non-zero panic_timeout */
>>   extern int panic_timeout;
>>   
>> +#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
>> +/* EL3 SMC call to setup CPUs for warm reset */
>> +void panic_smp_self_stop(void)
>> +{
>> +	struct arm_smccc_res result;
>> +
>> +	__cpu_disable();
>> +	cpu_relax();
>> +	arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, S10_WARM_RESET_WFI_FLAG,
>> +		      S10_WARM_RESET_WFI_FLAG, 0, 0, 0, 0, 0, &result);
>> +}
>> +#endif
> 
> Oooer!
> 
> panic_smp_self_stop() isn't for drivers to override: only the arch code.
> __cpu_disable() is only for the cpu-hotplug machinery. Nothing else should touch it.
> 
> Isn't this thing only called if another CPU out there is panic()ing too?
> 
OK. I wasn't aware of that intention. Thanks.

On an SError, all the CPUs except the first one end up calling 
panic_smp_self_stop().

All the CPUs are calling the panic routine which follows this path:
arm64_serror_panic() -> nmi_panic()

In nmi_panic()
	If this is the first CPU to reach nmi_panic(), call panic()
	otherwise, call nmi_panic_self_stop() -> panic_smp_self_stop()

panic_smp_self_stop() is a while(1) cpu_relax() which is a yield but I 
needed a WFI.

> 
> I think one of the problems here is arm64 leaves secondary CPUs running after panic().
> This would be better fixed by using the appropriate cpu_ops[]->cpu_die() call in arm64's
> ipi_cpu_stop().
> 
Yes. I will look into this.

> 
> As for passing platform-specific options, PSCI[0] has a 'reset_type' for SYSTEM_RESET2,
> which looks suspiciously like what you want here. I'm not sure how its expected to be
> used... hopefully the PSCI maintainers can give us some pointers.
> 
> (The existing support is commit 4302e381a870 ("firmware/psci: add support for SYSTEM_RESET2"))
> 
> 
> Is it possible for firmware to do both the cold/warm reset work when SYSTEM_RESET is
> called? This would mean you don't have to care here and there are fewer choices to be made
> overall.
> If not, is there anything left behind that can give it the hint? Like non-zero error
> counters for the USB/Ethernet devices?
> 

Hmm. I'll look into this. I was trying to handle more in Linux so that I 
could do a best effort of printout notification of the error, etc for 
the logs (even though I know getting this far or printing out isn't 
guaranteed)

> 
>> @@ -2067,14 +2080,28 @@ static int s10_edac_dberr_handler(struct notifier_block *this,
>>   			regmap_write(edac->ecc_mgr_map,
>>   				     S10_SYSMGR_UE_ADDR_OFST, err_addr);
>>   			edac_printk(KERN_ERR, EDAC_DEVICE,
>> -				    "EDAC: [Fatal DBE on %s @ 0x%08X]\n",
>> -				    ed->edac_dev_name, err_addr);
>> +				    "EDAC: [Fatal DBE on %s [CPU=%d] @ 0x%08X]\n",
>> +				    ed->edac_dev_name, raw_smp_processor_id(),
>> +				    err_addr);
>>   			break;
>>   		}
>>   		/* Notify the System through SMC. Reboot delay = 1 second */
>> +#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
>> +		/* Handle peripheral FIFO DBE as Warm Resets */
>> +		if (dberror & S10_COLD_RESET_MASK) {
> 
> 
>> +			panic_timeout = 1;
> 
> Isn't this value supposed to be provided on the kernel commandline? Surely this prevents
> debug using the commandline option to increase the delay?
> 
> (I see you already change it)

I see your point but I only override the value when I have an ECC DBE panic.
> 
> 
>> +			arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0,
>> +				      0, 0, 0, &result);
>> +		} else {
>> +			arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE,
>> +				      S10_WARM_RESET_WFI_FLAG | dberror, 0, 0,
>> +				      0, 0, 0, 0, &result);
>> +		}
>> +#else
>>   		panic_timeout = 1;
>>   		arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, dberror, 0, 0, 0, 0,
>>   			      0, 0, &result);
>> +#endif
>>   	}
>>   
>>   	return NOTIFY_DONE;
> 
> What do these SMC do? Are they equivalent to the PSCI CPU online/offline calls?
> 
> panic() notifiers aren't robust as they can be skipped if kdump is loaded.
> 
These are calling into the firmware to 1) notify the firmware of an 
upcoming cold reset in the case of cold reset or 2) call the warm reset 
handler in the firmware.

I missed that limitation of the panic() notifiers.

Thanks for the insightful comments!

Thor
> 
> Thanks,
> 
> James
> 
> 
> [0]
> https://static.docs.arm.com/den0022/d/Power_State_Coordination_Interface_PDD_v1_1_DEN0022D.pdf
> 


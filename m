Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1976035238
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2019 23:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfFDVuE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jun 2019 17:50:04 -0400
Received: from mga11.intel.com ([192.55.52.93]:41447 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbfFDVuE (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Jun 2019 17:50:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jun 2019 14:50:04 -0700
X-ExtLoop1: 1
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga004.jf.intel.com with ESMTP; 04 Jun 2019 14:50:03 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH] EDAC/altera: Warm Reset option for Stratix10 peripheral
 DBE
To:     Sudeep Holla <sudeep.holla@arm.com>,
        James Morse <james.morse@arm.com>
Cc:     bp@alien8.de, mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>
References: <1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com>
 <9de1152b-25e0-3fb1-bf96-c8e45363942c@arm.com>
 <20190604173848.GA28613@e107155-lin>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <45390f41-9b8c-de83-a092-befa3d1f7f0f@linux.intel.com>
Date:   Tue, 4 Jun 2019 16:52:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604173848.GA28613@e107155-lin>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sudeep,

On 6/4/19 12:38 PM, Sudeep Holla wrote:
> On Tue, Jun 04, 2019 at 06:23:15PM +0100, James Morse wrote:
>> Hi Thor,
>>
>> (CC: +Mark, Lorenzo and Sudeep for PSCI.
>> How should SYSTEM_RESET2 be used for a vendor-specific reset?
>>
> 
> Initially it was indented to be used by passing command line argument
> "reboot=w" or "reboot=warm" as specified in kernel document[1]
> 
> However it was enhanced and enabled specifically for panic by
> Commit b287a25a7148 ("panic/reboot: allow specifying reboot_mode for panic only")
> 
> IIUC you can now pass "reboot=panic_warm" to just set reboot_mode to
> WARM when there's a panic. SYSTEM_RESET2 gets called whenever reboot_mode
> is set to WARM/SOFT
> 
Thanks. I missed that SYSTEM_RESET2 had been implemented.

>> The original patch is:
>> lore.kernel.org/r/1559594269-10077-1-git-send-email-thor.thayer@linux.intel.com
>> )
>>
>> On 03/06/2019 21:37, thor.thayer@linux.intel.com wrote:
>>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>>
>>> The Stratix10 peripheral FIFO memories can recover from double
>>> bit errors with a warm reset instead of a cold reset.
>>> Add the option of a warm reset for peripheral (USB, Ethernet)
>>> memories.
>>>
>>> CPU memories such as SDRAM and OCRAM require a cold reset for
>>> DBEs.
>>> Filter on whether the error is a SDRAM/OCRAM or a peripheral
>>> FIFO memory to determine which reset to use when the warm
>>> reset option is configured.
>>
>> ... so you want to make different SMC calls on each CPU after panic()?
>>
>>
>>> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
>>> index 8816f74a22b4..179601f14b48 100644
>>> --- a/drivers/edac/altera_edac.c
>>> +++ b/drivers/edac/altera_edac.c
>>> @@ -2036,6 +2036,19 @@ static const struct irq_domain_ops a10_eccmgr_ic_ops = {
>>>   /* panic routine issues reboot on non-zero panic_timeout */
>>>   extern int panic_timeout;
>>>
>>> +#ifdef CONFIG_EDAC_ALTERA_ARM64_WARM_RESET
>>> +/* EL3 SMC call to setup CPUs for warm reset */
>>> +void panic_smp_self_stop(void)
>>> +{
>>> +	struct arm_smccc_res result;
>>> +
>>> +	__cpu_disable();
>>> +	cpu_relax();
>>> +	arm_smccc_smc(INTEL_SIP_SMC_ECC_DBE, S10_WARM_RESET_WFI_FLAG,
>>> +		      S10_WARM_RESET_WFI_FLAG, 0, 0, 0, 0, 0, &result);
> 
> Please use SYSTEM_RESET2 or let us know why it can't be used to understand
> the requirement better. There are options to use vendor extentions with
> the SYSTEM_RESET2 PSCI command if you really have to. However the mainline
> supports only architectural warm reset.
> 
I need to decide between warm reset and cold reset based on the 
peripheral type but maybe that decision can be done by firmware as James 
pointed out.

Thanks for the links and the comments!

Thor
> --
> Regards,
> Sudeep
> 
> [1] Documentation/admin-guide/kernel-parameters.txt
> 


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA966C08A
	for <lists+linux-edac@lfdr.de>; Wed, 17 Jul 2019 19:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfGQRlv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 17 Jul 2019 13:41:51 -0400
Received: from foss.arm.com ([217.140.110.172]:49536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfGQRlv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 17 Jul 2019 13:41:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C29328;
        Wed, 17 Jul 2019 10:41:50 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A26D43F71F;
        Wed, 17 Jul 2019 10:41:47 -0700 (PDT)
Subject: Re: [PATCH RFC 2/4] arm64: mm: Add RAS extension system register
 check to SEA handling
To:     Tyler Baicar OS <baicar@os.amperecomputing.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matteo.Carlini@arm.com" <Matteo.Carlini@arm.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "guohanjun@huawei.com" <guohanjun@huawei.com>,
        "Andrew.Murray@arm.com" <Andrew.Murray@arm.com>,
        Open Source Submission <patches@amperecomputing.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <1562086280-5351-1-git-send-email-baicar@os.amperecomputing.com>
 <1562086280-5351-3-git-send-email-baicar@os.amperecomputing.com>
 <df262b97-eda2-0556-d6ef-532a0d697131@arm.com>
 <BYAPR01MB39754DFAF8130743448FDEC6E3F00@BYAPR01MB3975.prod.exchangelabs.com>
 <BYAPR01MB3975FB635454503D3BFBBD53E3F30@BYAPR01MB3975.prod.exchangelabs.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <80d7ad43-5426-3117-0445-0add5bc008f5@arm.com>
Date:   Wed, 17 Jul 2019 18:41:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BYAPR01MB3975FB635454503D3BFBBD53E3F30@BYAPR01MB3975.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Tyler,

On 11/07/2019 05:14, Tyler Baicar OS wrote:
> On Tue, Jul 9, 2019 at 8:52 PM Tyler Baicar OS <baicar@os.amperecomputing.com> wrote:
>> On Mon, Jul 8, 2019 at 10:10 AM James Morse <james.morse@arm.com> wrote:
>>> On 02/07/2019 17:51, Tyler Baicar OS wrote:
>>>> @@ -632,6 +633,8 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
>>>>
>>>>       inf = esr_to_fault_info(esr);
>>>>
>>>> +     arch_arm_ras_report_error();
>>>> +
>>>>       /*
>>>>        * Return value ignored as we rely on signal merging.
>>>>        * Future patches will make this more robust.
>>>>
>>>
>>> If we interrupted a preemptible context, do_sea() is preemptible too... This means we
>>> can't know if we're still running on the same CPU as the one that took the external-abort.
>>> (until this series, it hasn't mattered).
>>>
>>> Fixing this means cramming something into entry.S's el1_da, as this may unmask interrupts
>>> before calling do_mem_abort(). But its going to be ugly because some of do_mem_abort()s
>>> ESR values need to be preemptible because they sleep, e.g. page-faults calling
>>> handle_mm_fault().
>>> For do_sea(), do_exit() will 'fix' the preempt count if we kill the thread, but if we
>>> don't, it still needs to be balanced. Doing all this in assembly is going to be unreadable!
>>>
>>> Mark Rutland has a series to move the entry assembly into C [0]. Based on that that it
>>> should be possible for the new el1_abort() to spot a Synchronous-External-Abort ESR, and
>>> wrap the do_mem_abort() with preempt enable/disable, before inheriting the flags. (which
>>> for synchronous exceptions, I think we should always do)
>>>
>>> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=arm64/entry-deasm

>> Good catch! I didn't think the synchronous route was preemptible.

>> I wasn't seeing this issue when testing this on emulation, but I was able to
>> test and prove the issue on a Neoverse N1 SDP:
>>
>> root@genericarmv8:~# echo 0x100000000 > /proc/cached_read
>> [   42.985622] Reading from address 0x100000000
>> [   42.989893] WARNING: CPU: 0 PID: 2812 at /home/tyler/neoverse/arm-reference-
>> platforms/linux/arch/arm64/kernel/cpufeature.c:1940 this_cpu_has_cap+0x68/0x78

[...]

>> [   43.175647] Internal error: synchronous external abort: 96000410 [#1]
>> PREEMPT SMP

[...]

>> I'll pull Mark's series in and add the preempt enable/disable around the call
>> to do_mem_abort() in el1_abort() and test that out!
> 
> I was able to pull in the series mentioned [0] and add a patch to wrap
> do_mem_abort with preempt disable/enable and the warning has gone away.

Great.

I spoke to Mark who commented he hadn't had the time to finish rebasing it onto
for-next/core. (which I guess is why it didn't get posted!).

I've taken a stab at picking out the 'synchronous' parts and rebasing it onto arm64's
for-next/core. That tree is here:
http://www.linux-arm.org/git?p=linux-jm.git;a=shortlog;h=refs/heads/deasm_sync_only/v0

(this should save you doing the rebase)

I'll aim to rebase/retest and post it next week.


> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index 43aa78331e72..26cdf7db511a 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -118,7 +118,25 @@ static void el1_abort(struct pt_regs *regs, unsigned long esr)

el0_ia/da will have the same problem.


>  	unsigned long far = read_sysreg(far_el1);
>  	local_daif_inherit(regs);
>  	far = untagged_addr(far);
> -	do_mem_abort(far, esr, regs);
> +
> +	switch (esr & ESR_ELx_FSC) {
> +	case ESR_ELx_FSC_EXTABT:	// Synchronous External Abort
> +	case 0x14:			// SEA level 0 translation table walk
> +	case 0x15:			// SEA level 1 translation table walk
> +	case 0x16:			// SEA level 2 translation table walk
> +	case 0x17:			// SEA level 3 translation table walk
> +	case 0x18:			// Synchronous ECC error
> +	case 0x1c:			// SECC level 0 translation table walk
> +	case 0x1d:			// SECC level 1 translation table walk
> +	case 0x1e:			// SECC level 2 translation table walk
> +	case 0x1f:			// SECC level 3 translation table walk

Hex numbers, lovely. KVM has a helper for this, can we move/clean that so we can use it here?


> +		preempt_disable();

This is still too late. You can take an interrupt between local_daif_inherit() and be
migrated, before you call preempt_disable() here.

The local_daif_inherit() may need to move into the switch() too.

It may be simpler to fold the 'is_extabt(esr)' check into el1_sync, so that these bypass
el1_abort() and call do_sea() directly, which could then handle the far-read,
preempt-count and daif-inherit itself. I prefer ... whichever looks cleanest!


> +		do_mem_abort(far, esr, regs);
> +		preempt_enable();
> +		break;
> +	default:
> +		do_mem_abort(far, esr, regs);
> +	};
>  }


Thanks,

James

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81B6A5FC94
	for <lists+linux-edac@lfdr.de>; Thu,  4 Jul 2019 19:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfGDRiS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 4 Jul 2019 13:38:18 -0400
Received: from foss.arm.com ([217.140.110.172]:46810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbfGDRiS (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 4 Jul 2019 13:38:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F01C82B;
        Thu,  4 Jul 2019 10:38:16 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59ACF3F703;
        Thu,  4 Jul 2019 10:38:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] EDAC: add EDAC driver for DMC520
To:     Lei Wang <leiwang_git@outlook.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "hangl@microsoft.com" <hangl@microsoft.com>,
        "lewan@microsoft.com" <lewan@microsoft.com>,
        "ruizhao@microsoft.com" <ruizhao@microsoft.com>
References: <BN6PR04MB11075E9070EE1A263E099A7386E60@BN6PR04MB1107.namprd04.prod.outlook.com>
 <65439e51-5356-ae93-dffb-5a87279f6c8b@arm.com>
 <BN6PR04MB1107E018F29465B68EE708C786FA0@BN6PR04MB1107.namprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <d82e6187-4a3d-1dc2-298a-0748ef0a7136@arm.com>
Date:   Thu, 4 Jul 2019 18:38:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB1107E018F29465B68EE708C786FA0@BN6PR04MB1107.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On 04/07/2019 01:16, Lei Wang wrote:
>> #include <linux/spinlock.h> ?
>>
>> It's best to keep this list sorted, it makes it easier for the maintainer to resolve
>> conflicts when header files get split/moved-around.
> 
> It builds fine in our distro. The header seems to have been inherited 
> from some other header files.

Heh, you can't rely on this! Someone will disturb the header-soup, and inexplicably your
driver will stop building. If your using a thing, you need to include the headers that
define it.


>>> +#define DMC520_BUS_WIDTH	8  /* Data bus width is 64bits/8Bytes */

>> Can you point me to where this comes from in the datasheet[0]?
>> I see it talk in "1.3 Features" of "either a 32-bit wide data SDRAM interface or a 64-bit
>> wide data SDRAM interface".
>>
>> If this is a choice that was made on your platform it needs to be described in the DT.
>>
>> (I may be confused between SDRAM/DDR/DRAM, as 2.3.3. "PHY interface" seems to describe one
>> connecting to the other.)

( a bit more reading shows these are all terms for pretty much the same thing )


> I didn't find a configuration for bus width from the dmc520 doc. I 
> search online and it seems like more than one places state 64-bit as 
> DDR's data bus width, e.g. this one 
> (https://en.wikipedia.org/wiki/DDR_SDRAM) mentions "DDR memory bus width 
> per channel is 64 bits (72 for ECC memory)." So I took it as a define 
> here for 8 bytes.

Ooer. Your platform might not be the same as wikipedia's!
From the datasheet it looks like this is configurable for DMC520, if so we shouldn't
hard-code the value in the driver...

~ (more datasheet digging) ~

Bingo: 'format_control' can be read in all states and has a 'memory_width' field that
indicates if the PHY is connected to a 'x32 DDR device' or 'x64 DDR device'. (I'm guessing
those double bit values are for address + data)

This probably affects the 'grain' too.


>>> +static void dmc520_handle_dram_ecc_errors(struct mem_ctl_info *mci,
>>> +					  bool is_ce)
>>> +{
>>> +	struct ecc_error_info info;
>>> +	struct dmc520_edac *edac;
>>> +	u32 cnt;
>>> +	char message[EDAC_MSG_BUF_SIZE];
>>> +	unsigned long flags;
>>> +
>>> +	edac = mci->pvt_info;
>>> +	dmc520_get_dram_ecc_error_info(edac, is_ce, &info);
>>> +
>>> +	cnt = dmc520_get_dram_ecc_error_count(edac, is_ce);
>>> +
>>> +	if (cnt > 0) {
>>> +		snprintf(message, ARRAY_SIZE(message),
>>> +			 "rank:%d bank:%d row:%d col:%d",
>>> +			 info.rank, info.bank,
>>> +			 info.row, info.col);
>>> +
>>> +		spin_lock_irqsave(&edac->ecc_lock, flags);
>> irqsave/irqrestore is overkill as this function is only called from an interrupt handler.
>> There is no way for this to be called with interrupts unmasked.

> Still feel spin_lock_irqsave and spin_unlock_irqstore are the safest. If 
> a processor is on isr for interrupt line 1 and calls 
> dmc520_handle_dram_ecc_errors, only line 1 is disabled and and other 
> lines can still interrupt calling dmc520_handle_dram_ecc_errors again. 

But not on the same CPU, (which is the problem the irqsave helpers solve).

When the CPU takes an interrupt the hardware sets a status bit to prevent this CPU taking
any other interrupt. On armv8, this is PSTATE.I, its set automatically by the hardware. If
CPUs didn't do this, you could never guarantee that any interrupt would ever be handled.

You are right a second interrupt may occur, but it can't interrupt this CPU until it
returns from the Interrupt, or clears the status bit. If the second interrupt is taken at
the same time its because it was routed to a different CPU. A regular spin_lock() stops
any problems here, the second CPU has to wait for the first CPU to release the lock.

spin_lock_irqsave() is for a more complicated problem. If you used the spinlock in process
context, (e.g. your probe function), as well as interrupt context, then its possible the
interrupt is taken while the lock is held in process context on the same CPU. This causes
your interrupt handler to wait forever for the lock. The irqsave helpers stop this by
masking interrupts when taking the lock, so that this 'same CPU' sequence can't happen.

Because you don't take the lock in process context, you don't need the irqsave variants.


>>> +	for (intr_index = 0; intr_index < nintr; ++intr_index) {
>>> +		if (edac->interrupt_mask_all & edac->interrupt_masks[intr_index]) {
>>> +			edac_printk(KERN_ERR, EDAC_MC,
>>> +				"interrupt-config error: "
>>> +				"element %d's interrupt mask %d has overlap.\n",
>>> +				intr_index, edac->interrupt_masks[intr_index]);
>>> +			goto err_free_mc;
>>> +		}
>>> +
>>> +		edac->interrupt_mask_all |= edac->interrupt_masks[intr_index];
>>> +	}

>> Ah, so the driver doesn't support overlapping masks... but wasn't this the reason for
>> describing the interrupts with these masks in the first place?
>> (It looks like the DT-folk want this as named interrupts)
>>
>> lore.kernel.org/r/BYAPR21MB1319BC4D079B918AB038A4D590010@BYAPR21MB1319.namprd21.prod.outlook.com
>>
>> Would this driver support the configuration you gave there?

> The interrupt line to mask mapping is to solve how to flexibly adapting 
> to possible hardware implementations. dmc520 supports multiple 
> interrupts (3.3.169 interrupt_control). And these interrupts may have 
> different ways to be wired to physical interrupt lines. As in the above 
> link, in this particular brcm implementation:
> 
> Line 841: source dram_ecc_errc_int
> Line 843: source dram_ecc_errd_int
> Line 839: source dram_ecc_errc_int and dram_ecc_errd_int
> 
> Two straightforward possibilities for implementing ecc counts for ce/ue: 
> 1. We chose to use the single source line. 2. It's possible to implement 
> using the combined-source line too. Our implementation would support 
> either of these cases.
> 
> Of course there might be other possibilities that involve overlapping, 
> such as including all above 3 interrupt lines into the DT. But this 
> unlikely is of any real value of use. Our implementation does not 
> support this case.

Right, so the driver does support this, but not at the same time as independant interrupts.


>> With the bool/enum and interrupt-disabling things fixed:
>> Reviewed-by: James Morse <james.morse@arm.com>
>>
> New to the upstreaming review process. Does this last comment mean we're 
> closer? :)

Heh, yes. This translates as: If you post a subsequent version with those two issues
fixed, please include that Reviewed-by tag next to your Signed-off-by.

{
If you could also summarise the changes you make next to the diffstat, it allows people
who have given tags to only look at the bits you changed, (instead of playing spot the
difference).

As an example:
https://lore.kernel.org/r/20190521172139.21277-3-julien.grall@arm.com

git knows to discard the changes-between-versions and diffstat bits when the patch is
applied, they don't end up in the log.
}

What happens next? Your series gets more review and collects tags. This will include the
maintainers of each tree you're touching either giving tags, or queueing the series. From
there it sits in linux-next until the next merge-window, when the maintainer will send a
pull-request to Linus. Eventually it ends up in the release-candidates, and finally a
released kernel.


(N.B: your mail is still coming base64 encoded, so its very unlikely the maintainer can
pick it up.)


Thanks,

James

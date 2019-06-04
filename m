Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2934E81
	for <lists+linux-edac@lfdr.de>; Tue,  4 Jun 2019 19:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfFDRNz (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Jun 2019 13:13:55 -0400
Received: from foss.arm.com ([217.140.101.70]:48350 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfFDRNz (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 4 Jun 2019 13:13:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9A980D;
        Tue,  4 Jun 2019 10:13:53 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C9413F5AF;
        Tue,  4 Jun 2019 10:13:52 -0700 (PDT)
Subject: Re: [PATCH v3] EDAC, mellanox: Add ECC support for BlueField DDR4
To:     Junhan Zhou <Junhan@mellanox.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liming Sun <lsun@mellanox.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shravan Ramani <sramani@mellanox.com>
References: <e59276b6f3dc165703ddcb47a8a006d8a62d9c95.1551216637.git.Junhan@mellanox.com>
 <1553178667-21073-1-git-send-email-Junhan@mellanox.com>
 <d0d3ee30-8f9c-521f-9915-50d8ac3913dc@arm.com>
 <DB6PR0501MB2709C0B8F6F750FC7EB4D00DB3180@DB6PR0501MB2709.eurprd05.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <cb0de489-650b-31a0-7cf6-20181dd28e2b@arm.com>
Date:   Tue, 4 Jun 2019 18:13:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DB6PR0501MB2709C0B8F6F750FC7EB4D00DB3180@DB6PR0501MB2709.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Junhan,

On 30/05/2019 19:48, Junhan Zhou wrote:
>> -----Original Message-----
>> From: James Morse <james.morse@arm.com>
>> Sent: Thursday, May 23, 2019 1:30 PM
>> To: Junhan Zhou <Junhan@mellanox.com>

>>> +union mlxbf_emi_dram_additional_info_0 {
>>> +	struct {
>>> +		u32 err_bank     : 4;
>>> +		u32 err_lrank    : 2;
>>> +		u32 __reserved_0 : 2;
>>> +		u32 err_prank    : 2;
>>> +		u32 __reserved_1 : 6;
>>> +		u32 err_edge     : 8;
>>> +		u32 __reserved_2 : 8;
>>> +	};
>>> +
>>> +	u32 word;
>>> +};
>>
>> ... you're expecting the compiler to pack this bitfield in exactly the same way
>> your hardware did. I don't think that's guaranteed.
>> It evidently works for your current compiler, but another compiler may pack
>> this structure differently. Toggling endianness will break this, (arm64
>> supports both). If your platform supports aarch32, someone may want to get
>> 32bit arm running, which may have different compiler behaviour.
>>
>> You are also using bitfields between hardware and firmware, so its currently
>> possible the firmware requires the kernel to be built with a compiler that
>> means it can't interact with the hardware...
>>
>> When this has come up in the past, the advice was not to use bitfields:
>> https://lore.kernel.org/lkml/1077080607.1078.109.camel@gaston/
>>
>> Please use shifts and masks.
>>
> Okay if you insist. I do see this kind of style used elsewhere, e.g. in pnd2_edac.h.

Yup, and that is fragile. It can only work if the toolchain for firmware, the kernel and
hardware have only one configuration between them. I don't think we have enough control of
the platform to assert this.


> And this driver is only used on the BlueField SoC which our bootloader would
> configure it to be only running at Aarch64 little endian.

(endian-ness is something the kernel configures during boot. I can happily kexec a
big-endian kernel on my Juno, even though the bootloader chokes and splutters when its
asked to do this.)

This stuff is 'implementation defined' for the compiler, we can't complain to the compiler
people if it doesn't do what we wanted.


>>> +#define MLXBF_EDAC_DIMM_PER_MC		2
>>> +#define MLXBF_EDAC_ERROR_GRAIN		8
>>
>> If these numbers changed, would it still be a BlueField SoC?
>> (if next years made-up:BlueField2 supports more Dimms per MC, it would be

> BTW, how did you ever guess that the next gen chip would be called BlueField2?
> Did you search for "BlueField" in the registered PCI IDs and accidentally
> found it? (https://fossies.org/linux/systemd/hwdb/pci.ids)

Ha! The 'made-up:' was to indicate I really know nothing about this. I should have gone
for Bluefield++


>>> +/*
>>> + * Request MLNX_SIP_GET_DIMM_INFO
>>> + *
>>> + * Retrieve information about DIMM on a certain slot.
>>> + *
>>> + * Call register usage:
>>> + * a0: MLNX_SIP_GET_DIMM_INFO
>>> + * a1: (Memory controller index) << 16 | (Dimm index in memory
>>> +controller)
>>> + * a2-7: not used.
>>> + *
>>> + * Return status:
>>> + * a0: dimm_info_smc union defined below describing the DIMM.
>>> + * a1-3: not used.
>>> + */
>>
>> Have Mellanox published these call numbers/arguments in a document
>> somewhere? If they differ with the firmware, it would be good to know
>> which side needs fixing.
>>
>> It is a little odd that you read the number of memory controllers from the
>> ACPI table, but use an SMC call to read the DIMM information.
>> Is it too-late to describe the DIMMs in the ACPI table too? (this would let
>> firmware hard-code it on platforms where it could never change, instead of
>> having to support a runtime call)
>>
>> The DIMM information should also be in the SMBIOS table. See ghes_edac.c
>> for some code that uses this. SMBIOS isn't popular in the arm world: but
>> edac already uses this, and we want to match DIMM numbers with the text
>> on the board's silk-screen so the user can replace the correct DIMM.
>>
> 
> No we haven't. But, we publish the source code to our firmware so anybody can edit
> and boot their own version.

Cool!
(With a different compiler that does the bitfields differently? *cough* *cough*)

[..]

> So the issue here is that ATF does the memory training, but UEFI is in charge
> of publishing the ACPI tables (which is where the SMBIOS table would be located
> correct?).

Yes, edk2-platforms has a "Platform/ARM/JunoPkg/SmbiosPlatformDxe/SmbiosPlatformDxe.c"
which I assume is relevant to this.


> And the BlueField SoC are used both on boards with soldered DRAMs chips (which doesn’t
> have SPDs) and sockets to insert DIMMs on.

Do you ship the same firmware image for both variants? I bet this isn't the only
difference. The SMC is overhead on the soldered-DRAM boards as its returning a constant
you could have baked into UEFI.

This is the sort of thing that platform firmware can just know.


> So it would be a real mess for UEFI to figure
> out what is the DIMM configuration, and the most obvious way it to communicate through SMCs.

If it really is variable yes, but in your soldered-DRAM chips case, surely its all numbers
you could bake into the tables.

If you add the DIMMs to the SMBIOS tables then this information is useful to other tools
in user-space too. The whole edac-facade is only useful if someone can put their paw in
the enclosure to replace the faulty dimm. Ultimately we need to correlate the errors with
something replaceable, and what we really want to know is what is the label on the
silk-screen next to the faulty dimm. This is what the SMBIOS tables are for.

Once the information is in the smbios tables, we don't want to duplicate it.
Only firmware can generate the smbios tables.


> So why go through this extra complicity when Linux can directly do the SMC?

From my view? Because these 'firmware tables' are where we expect to find all the
information from firmware. If the number of DIMMs changed while the system was running,
then an SMC would be the only choice. Having a mix of firmware-tables and runtime calls is
a bit odd.


> Or are you
> concerned about making this a standard so Windows can also figure out the DIMM configuration?

No, I'm just curious that you have some information in static firmware tables, and other
static information via a firmware runtime call.


> The number of memory controller as well as which physical address correspond to which
> memory controller is a fixed fact for the BlueField SoC, so this can be added to the
> ACPI table very easily without needing to dynamically patching it. Or do you rather
> this also be an SMC? This number can vary between the current BlueField and "BlueField2".

Number of memory-controllers? This was just to check this hard-coded number really is
fixed. Its almost always better to shove things in the firmware table, even if you don't
think they're going to change. This way you don't need to change the driver when the
hardware people 'make it better'.

As it sounds like BlueField2 is going to be a thing, and it doesn't have the same memory
controller, this isn't a problem.


>>> +/* Format for the SMC response about the memory information */ union
>>> +dimm_info_smc {
>>> +	struct {
>>> +		unsigned long size_GB : 16;
>>> +		unsigned long is_rdimm : 1;
>>> +		unsigned long is_lrdimm : 1;
>>> +		unsigned long is_nvdimm : 1;
>>> +		unsigned long __reserved0 : 2;
>>> +		unsigned long ranks : 3;
>>> +		unsigned long package_X : 8;	/* Bits per memory package
>> */
>>> +		unsigned long __reserved1 : 32;
>>> +	};
>>> +	unsigned long val;
>>> +};
>>
>> If your firmware and the kernel were built with different compilers, this isn't
>> guaranteed to work. Please use shifts and masks.

> Okay if you insist. I would think if one would tinker with the kernel driver
> code for BlueField, one might as well also build the firmware code which
> source we already provided.

Its just a case of avoiding dependencies across exception boundaries, and with other projects.


>>> +	writel(edels.word, priv->emi_base +
>>> +MLXBF_EMI_DRAM_ECC_LATCH_SELECT);
>>> +
>>> +	/*
>>> +	 * Verify that the ECC reported info in the registers is of the
>>> +	 * same type as the one asked to report. If not, just report the
>>> +	 * error without the detailed information.
>>> +	 */
>>> +	eds.word = readl(priv->emi_base + MLXBF_EMI_DRAM_SYNDROM);
>>
>> Does the device need to have seen the write to
>> MLXBF_EMI_DRAM_ECC_LATCH_SELECT before it sees this read?
>>
>> Will Deacon gave a presentation on this stuff at ELCE:
>> https://elinux.org/images/a/a8/Uh-oh-Its-IO-Ordering-Will-Deacon-Arm.pdf
>>
>> (I don't understand this stuff, so may have it totally wrong here:)
>>
>> From the arch code's definitions of these:
>> | #define writel(v,c)	({ __iowmb(); writel_relaxed((v),(c)); })
>> | #define readl(c)	({ u32 __v = readl_relaxed(c); __iormb(__v); __v; })
>>
>> This means you've got back-to-back writel_relaxed()/readl_relaxed() here,
>> and probably need an mb() between them.
>>
>> (slides 17 and 19 of that pdf are handy).
>>
>> As an example,
>> drivers/edac/cell.c::cell_edac_check() has this out_be64(); mb(); in_be64()
>> sequence, which I think is the same.

> This is of no concern for the BlueField SoC. For accessing device memory, the hardware
> enforces a strict memory ordering. The next register access won't be issued before the
> previous instruction have been retired. So there won't be a case on the BlueField SoC
> (which is the only platform this driver is valid for) where the latter read happens
> before the previous write.

Did I mention I may have it totally wrong? I've found some more on this to read...

This was tripped by your comment:
> Verify that the ECC reported info in the registers is of the same type as the one asked
> to report.

Was this determined experimentally, or is it expected/documented behaviour? If it seems
like that write doesn't always complete we should get to the bottom of this.


Thanks,

James

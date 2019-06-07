Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1A8738E9F
	for <lists+linux-edac@lfdr.de>; Fri,  7 Jun 2019 17:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbfFGPLr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 11:11:47 -0400
Received: from foss.arm.com ([217.140.110.172]:42296 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbfFGPLr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 11:11:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84117C0A;
        Fri,  7 Jun 2019 08:11:46 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F8053F718;
        Fri,  7 Jun 2019 08:11:44 -0700 (PDT)
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     "Shenhar, Talel" <talel@amazon.com>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>, Borislav Petkov <bp@alien8.de>,
        "Herrenschmidt, Benjamin" <benh@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
 <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
 <20190531051400.GA2275@cz.tnic>
 <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
 <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
 <71da083e-1a74-cf86-455d-260a34ee01fd@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <25efb27c-b725-137d-5735-b3ab88323846@arm.com>
Date:   Fri, 7 Jun 2019 16:11:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <71da083e-1a74-cf86-455d-260a34ee01fd@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi guys,

On 06/06/2019 12:37, Shenhar, Talel wrote:
>>> Disagree. The various drivers don't depend on each other.
>>> I think we should keep the drivers separated as they are distinct and independent IP
>>> blocks.
>> But they don't exist in isolation, they both depend on the integration-choices/firmware
>> that makes up your platform.
>>
>> Other platforms may have exactly the same IP blocks, configured differently, or with
>> different features enabled in firmware. This means we can't just probe the driver based on
>> the presence of the IP block, we need to know the integration choices and firmware
>> settings match what the driver requires.
>>
>> (Case in point, that A57 ECC support is optional, another A57 may not have it)
>>
>> Descriptions of what firmware did don't really belong in the DT. Its not a hardware
>> property.
>>
>> This is why its better to probe this stuff based on the machine-compatible/platform-name,
>> not the presence of the IP block in the DT.
>>
>>
>> Will either of your separate drivers ever run alone? If they're probed from the same
>> machine-compatible this won't happen.
>>
>>
>> How does your memory controller report errors? Does it send back some data with an invalid
>> checksum, or a specific poison/invalid flag? Will the cache report this as a cache error
>> too, if its an extra signal, does the cache know what it is?
>>
>> All these are integration choices between the two IP blocks, done as separate drivers we
>> don't have anywhere to store that information. Even if you don't care about this, making
>> them separate drivers should only be done to make them usable on other platforms, where
>> these choices may have been different.

> From our perspective, l1/l2 has nothing to do with the ddr memory controller.

I understand you're coming from the position that these things have counters, you want
something to read and export them.

I'm coming at this from somewhere else. This stuff has to be considered all the way
through the system. Just because each component supports error detection, doesn't mean you
aren't going to get silent corruption. Likewise if another platform picks up two piecemeal
edac drivers for hardware it happens to have in common with yours, it doesn't mean we're
counting all the errors. This stuff has to be viewed for the whole platform.


> Its right that they both use same edac subsystem but they are using totally different APIs
> of it.
> 
> We also even want to have separate control for enabling/disabling l1/l2 edac vs memory
> controller edac.

Curious, what for? Surely you either care about counting errors, or you don't.


> Even from technical point-of-view L1/L2 UE collection method is totally different from
> collecting memory-controller UE. (CPU exception vs actual interrupts).
> 
> So there is less reason why to combine them vs giving each one its own file, e.g.
> al_mc_edac, al_l1_l2_edac (I even don't see why Hanna combined l1 and l2...)

> As we don't have any technical relation between the two we would rather avoid this
> combination.
> 
> Also, Lets assume we have different setups with different memory controllers, having a dt
> binding to control the difference is super easy and flexible.

If the hardware is different you should describe this in the DT. I'm not suggesting you
don't describe it.

The discussion here is whether we should probe the driver based on a dummy-node
compatible, (which this 'edac_l1_l2' is) or based on the machine compatible.

At the extreme end: you should paint the CPU and cache nodes with a compatible describing
your integration. (I've mangled Juno's DT here:)
| A57_0: cpu@0 {
| 	compatible = "amazon-al,cortex-a57", "arm,cortex-a57";
| 	reg = <0x0 0x0>;
| 	device_type = "cpu";
| 	next-level-cache = <&A57_L2>;
| };
|
[...]
|
| A57_L2: l2-cache0 {
| 	compatible = "amazon-al,cache", "cache";
|	cpu_map = <A57_0, A57_1>
| };


This is the most accurate way to describe what you have here. The driver can use this to
know that this integration of CPU and Cache support the edac registers. (This doesn't tell
us anything about whether firmware enabled this stuff, or made/left it all secure-only)

But this doesn't give you a device you can bind a driver to, to kick this stuff off.
This (I assume) is why you added a dummy 'edac_l1_l2' node, that just probes the driver.
The hardware is to do with the CPU and caches, 'edac_l1'_l2' doesn't correspond to any
distinct part of the soc.

The request is to use the machine compatible, not a dummy node. This wraps up the firmware
properties too, and any other platform property we don't know about today.

Once you have this, you don't really need the cpu/cache integration annotations, and your
future memory-controller support can be picked up as part of the platform driver.
If you have otherwise identical platforms with different memory controllers, OF gives you
the API to match the node in the DT.


> Would having a dedicated folder for amazon ease the move to separate files?

I don't think anyone cares about the number of files. Code duplication and extra
boiler-plate, maybe.


Thanks,

James

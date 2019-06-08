Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0C93399E1
	for <lists+linux-edac@lfdr.de>; Sat,  8 Jun 2019 02:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbfFHAQv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 7 Jun 2019 20:16:51 -0400
Received: from gate.crashing.org ([63.228.1.57]:54884 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbfFHAQv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 7 Jun 2019 20:16:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x580GC9H007617;
        Fri, 7 Jun 2019 19:16:14 -0500
Message-ID: <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>, Borislav Petkov <bp@alien8.de>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Shenhar, Talel" <talel@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "Hanoch, Uri" <hanochu@amazon.com>
Date:   Sat, 08 Jun 2019 10:16:11 +1000
In-Reply-To: <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
         <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
         <DB09EE2A-7397-4063-B925-66658D0105A5@alien8.de>
         <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
         <20190531051400.GA2275@cz.tnic>
         <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
         <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, 2019-06-06 at 11:33 +0100, James Morse wrote:

> > Disagree. The various drivers don't depend on each other.
> > I think we should keep the drivers separated as they are distinct and independent IP blocks.
> 
> But they don't exist in isolation, they both depend on the integration-choices/firmware
> that makes up your platform.

What do you mean ? They are exposing counters from independent IP
blocks. They are independent drivers. You argument could be use to
claim the entire SoC depends on "integration choices / firmware" ... I
don't get it.

> Other platforms may have exactly the same IP blocks, configured differently, or with
> different features enabled in firmware.

Sure, like every other IP block on the planet. That has never been a
good reason to bring back the ugly spectre of myboard.c file...

>  This means we can't just probe the driver based on
> the presence of the IP block, we need to know the integration choices and firmware
> settings match what the driver requires.

Such as ? I mean none of that differs between these EDAC drivers and
any other IP block, and we still probe them individually.

> (Case in point, that A57 ECC support is optional, another A57 may not have it)

So what ? That belongs in the DT.

> Descriptions of what firmware did don't really belong in the DT. Its not a hardware property.

Since when ? I'm tired of people coming up over and over about that
complete fallacy that the DT should for some obscure religious reason
be strictly limited to "HW properties". ACPI isn't. The old Open
Firmware which I used as a basis for creating the FDT wasn't.

It is perfectly legitimate for the DT to contain configuration
information and firmware choices.

What's not OK is to stick there things that are essentially specific to
the Linux driver implementation but that isn't what we are talking
about here.

> This is why its better to probe this stuff based on the machine-compatible/platform-name,
> not the presence of the IP block in the DT.

No. No no no no. This is bringing back the days of having board files
etc... this is wrong.

Those IP blocks don't need any SW coordination at runtime. The drivers
don't share data nor communicate with each other. There is absolultely
no reason to go down that path.

> Will either of your separate drivers ever run alone? If they're probed from the same
> machine-compatible this won't happen.

They should be probed independently from independent DT nodes, what's
the problem you are trying to fix here ?

> How does your memory controller report errors? Does it send back some data with an invalid
> checksum, or a specific poison/invalid flag? Will the cache report this as a cache error
> too, if its an extra signal, does the cache know what it is?

That's ok, you get the error from both sides, power has done it that
way for ever. It's not always possible to correlate anyways and it's
certainly not the job of the EDAC drivers to try.

> All these are integration choices between the two IP blocks, done as separate drivers we
> don't have anywhere to store that information.

We do, it's called the DT.

>  Even if you don't care about this, making
> them separate drivers should only be done to make them usable on other platforms, where
> these choices may have been different.

That wouldn't make the drivers unusable on other platforms at all.

Cheers,
Ben.



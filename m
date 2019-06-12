Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF76E447A0
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 19:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730181AbfFMRA6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 13:00:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:42212 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729754AbfFLXyx (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 19:54:53 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5CNsIen016686;
        Wed, 12 Jun 2019 18:54:19 -0500
Message-ID: <2a53690aa81a406b9a6290f70e47470d0f698f00.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Date:   Thu, 13 Jun 2019 09:54:18 +1000
In-Reply-To: <20190612104238.GG32652@zn.tnic>
References: <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
         <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
         <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
         <20190608090556.GA32464@zn.tnic>
         <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
         <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
         <20190611115651.GD31772@zn.tnic>
         <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
         <20190612034813.GA32652@zn.tnic>
         <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
         <20190612104238.GG32652@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2019-06-12 at 12:42 +0200, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 06:29:26PM +1000, Benjamin Herrenschmidt wrote:
> > I tend to disagree here. We've been down that rabbit hole in the past
> > and we (Linux in general) are trying to move away from that sort of
> > "platform" overarching driver as much as possible.
> 
> Why is a "platform" driver like that so bad?

It tends to be a slippery slope. Also in the ARM world, most SoC tend
to re-use IP blocks, so you get a lot of code duplication, bug fixed in
one and not the other etc...

I don't necessarily mind having a "platform" component that handles
policies in case where userspace is really not an option, but it
shouldn't be doing it by containing the actual drivers for the
individual IP block error collection. It could however "use" them via
in-kernel APIs.

> > This is a policy. It should either belong to userspace,
> 
> For some errors you can't do userspace as it is too late for it - you
> wanna address that before you return to it.

Those are rare. At the end of the day, if you have a UE on memory, it's
a matter of luck. It could have hit your kernel as well. You get lucky
it only hit userspace but you can't make a general statement you "can't
trust userspace".

Cache errors tend to be the kind that tend to have to be addressed
immediately, but even then, that's often local to some architecture
machine check handling, not even in EDAC.

Do you have a concrete example of a type of error that

 - Must be addressed in the kernel

 - Relies on coordinating drivers for more than one IP block

?

Even then though, my argument would be that the right way to do that,
assuming that's even platform specific, would be to have then the
"platform RAS driver" just layout on top of the individual EDAC drivers
and consume their output. Not contain the drivers themselves.

> > or be in some generic RAS code in the kernel, there's no reason why
> > these can't be abstracted.
> 
> Yes, we have this drivers/ras/cec.c thing which collects correctable
> DRAM errors on x86. :-)

Using machine checks, not EDAC. It's completely orghogonal at this
point at least.

That said, it would make sense to have an EDAC API to match that
address back into a DIMM location and give user an informational
message about failures happening on that DIMM. But that could be done
via core EDAC MC APIs.

Here too, no need for having an over-arching platform driver.

> > Also in your specific example, it could be entirely local to the MC
> > EDAC / DRAM controller path, we could have a generic way for EDAC to
> > advertise that a given memory channel is giving lots of errors and
> > have memory controller drivers listen to it but usually the EDAC MC
> > driver *is* the only thing that looks like a MC driver to begin with,
> > 
> > so again, pretty much no overlap with L1/L2 caches RAS or PCIe RAS
> > etc...
> > 
> > Unless I'm mistaken, that amd64 EDAC is just an MC one... but I only
> > had a cursory glance at the code.
> 
> EDAC has historically been concentrating on DRAM errors as that is
> what people have been paying attention to. But it isn't limited to
> DRAM errors - there is some basic PCI errors functionality behind
> edac_pci_create_generic_ctl() which polls for PCI parity errors.

Right, somebody whacked the PCI stuff in the same driver. So what ?
There's no coordination here not particular reason it has to be so.
Those PCI bits could have moved to a sepatate driver easily. Maybe they
didn't bcs they didn't have a good way to probe the two separately via
ACPI ? I don't know. But it doesn't matter nor does it affect the
situation with ARM.

That said, x86 platforms tend to be less diverse in their selection of
IP blocks, and tend to have more integrated chipsets where the
distinction between the memory controller and PCI may be a bit less
obvious. This isn't the case on ARM.

I still think that doesn't prove or disprove anything.

> So it still makes sense to me to have a single driver which takes care
> of all things RAS for a platform. You just load one driver and it does
> it all, including recovery actions.

Why ? Because one or two historical drivers mix MC and PCI then "it
makes sense" to do that for everybody ?

And then you have 20 platforms and 20 drivers, with 50% or more code
duplication, bugs fixed in one and not the other, gratuituous behaviour
differences to confuse users etc... No. that doesn't make sense.

> > Maybe because what you are promoting might not be the right path
> > here... seriously, there's a reason why all vendors want to go down
> > that path and in this case I don't think they are wrong.
> > 
> > This isn't about just another ARM vendor, in fact I'm rather new to the
> > whole ARM thing, I used to maintain arch/powerpc :-)
> 
> What happened? :-P

Long story :-) I handed it over to mpe a while ago, I left IBM earlire
this year.

> > The point is what you are trying to push for goes against everything
> > we've been trying to do in Linux when it comes to splitting drivers to
> > individual IP blocks.
> 
> Please do explain why is a driver-per-IP-block better and please don't
> give me the DT argument - I've heard that one more than enough now.

I have no idea what "the DT argument" is, and that's from the guy who
created the FDT....

I have difficulties understanding how you cannot see that having re-
usable single drivers for a single piece of HW makes sense. If anything
in term of avoiding duplication, bitrot, bugs being fixed in some and
not others, etc etc... It also means more eyes on a given piece of code
which is a good thing.

Also you "have heard more than enough" is again a sign that a whole lot
of people are trying to tell you something that you seem to refuse to
hear. Whatever that "DT argument" is, did you just ignore it or had
some good and solid arguments of your own to refute it ?

> Like, for example, how do you deal with the case where you have a
> platform which has a bunch of IP blocks with RAS functionality and they
> all have a separate driver. Now, you want to do recovery and failover
> actions depending on certain error count from a certain group of IP
> blocks.
>
> You export those counts through sysfs from the separate drivers and you
> have a userspace agent doing that policy?

So mostly yes. Works fine for POWER9 :-) That said, you'll have to be
more precise, because so far this is very hypothetical.

> That cannot always fly because recovery actions for some errors need to
> happen before we return to userspace - i.e., memory-failure.c types of
> scenarios.

How come ? Most memory failure type scenario tend to be handled via
MCEs anyway and don't go through EDAC. Additionally, if they do, that
can generally be constrained to the MC driver. But even then, what kind
should be handled "before we return to userspace" ?

However, if we want to create some overall policy then we should create
some in-kernel APIs so that your magic "platform driver" can talk to
the indidual EDAC drivers (or get notifed by them).

Mangling everything together is definitely NOT the way to go here.

However, what I see above is a lot of hand waving and hypothetical
examples, nothing really concrete.

> You add another "counting" layer which is yet another driver which
> collects those errors and applies policy actions?

No. Individual drivers count and report. Not sure what you mean here.

> But then that layer needs to be made generic enough to be shared by the
> other EDAC IP block drivers, otherwise every platform would need its own
> counter layer driver. Which basically puts the problem somewhere else
> but doesn't make it go away.

Not sure what you mean by a "counter layer driver"...

> Another way I'm not thinking of at the moment?
> 
> A single driver solves that problem as it has all the required
> information in one place and deals with it then and there.

We could also have the entire BSP of a platform as one giant driver
that does all the RAS, netowrking, serial, and video .. why not ? That
would make your policies a lot easier :-) Not seriously I really fail
to see your points, and it looks like I'm not the only one.

> I hear you that platform drivers are frowned upon but connecting it all
> in one place for such purposes makes sense to me in this particular
> case.

What makes some amount of sense *if necessary* (and I yet have to be
convinced it is) is to have the platform policy driver use internal
kernel APIs to communicate with the individual IP block drivers via
something reasonably standard.

But even then, I yet have to see an actual need for this.

> Btw, what is your final goal with these drivers? Dump decoded error
> information in dmesg? Or something more sophisticated?

I'll let Hanna respond to that one.

Cheers,
Ben.



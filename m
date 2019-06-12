Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 666AA41F0F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436862AbfFLI3y (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 04:29:54 -0400
Received: from gate.crashing.org ([63.228.1.57]:59839 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405127AbfFLI3y (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 04:29:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5C8TQFV008979;
        Wed, 12 Jun 2019 03:29:28 -0500
Message-ID: <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
Cc:     "Hawa, Hanna" <hhhawa@amazon.com>,
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
Date:   Wed, 12 Jun 2019 18:29:26 +1000
In-Reply-To: <20190612034813.GA32652@zn.tnic>
References: <bfbc12fb68eea9d8d4cc257c213393fd4e92c33a.camel@amazon.com>
         <20190531051400.GA2275@cz.tnic>
         <ce01a2bc-7973-5978-b033-a6bdc61b9d4b@amazon.com>
         <32431fa2-2285-6c41-ce32-09630205bb54@arm.com>
         <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
         <20190608090556.GA32464@zn.tnic>
         <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
         <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
         <20190611115651.GD31772@zn.tnic>
         <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
         <20190612034813.GA32652@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, 2019-06-12 at 05:48 +0200, Borislav Petkov wrote:
> On Wed, Jun 12, 2019 at 08:25:52AM +1000, Benjamin Herrenschmidt wrote:
> > Yes, we would be in a world of pain already if tracepoints couldn't
> > handle concurrency :-)
> 
> Right, lockless buffer and the whole shebang :)

Yup.

> > Sort-of... I still don't see a race in what we propose but I might be
> > missing something subtle. We are talking about two drivers for two
> > different IP blocks updating different counters etc...
> 
> If you do only *that* you should be fine. That should technically be ok.

Yes, that' the point.

> I still think, though, that the sensible thing to do is have one
> platform driver which concentrates all RAS functionality. 

I tend to disagree here. We've been down that rabbit hole in the past
and we (Linux in general) are trying to move away from that sort of
"platform" overarching driver as much as possible.

> It is the
> more sensible design and takes care of potential EDAC shortcomings and
> the need to communicate between the different logging functionality,
> as in, for example, "I had so many errors, lemme go and increase DRAM
> scrubber frequency." For example. And all the other advantages of having
> everything in a single driver.

This is a policy. It should either belong to userspace, or be in some
generic RAS code in the kernel, there's no reason why these can't be
abstracted. Also in your specific example, it could be entirely local
to the MC EDAC / DRAM controller path, we could have a generic way for
EDAC to advertise that a given memory channel is giving lots of errors
and have memory controller drivers listen to it but usually the EDAC MC
driver *is* the only thing that looks like a MC driver to begin with,
so again, pretty much no overlap with L1/L2 caches RAS or PCIe RAS
etc...

> And x86 already does that - we even have a single driver for all AMD
> platforms - amd64_edac. Intel has a couple but there's still a lot of
> sharing.

Unless I'm mistaken, that amd64 EDAC is just an MC one... but I only
had a cursory glance at the code.

> But apparently ARM folks want to have one driver per IP block. And we
> have this discussion each time a new vendor decides to upstream its
> driver. And there's no shortage of vendors in ARM-land trying to do
> that.

For good reasons :-)

> James and I have tried to come up with a nice scheme to make that work
> on ARM and he has an example prototype here:
> 
> http://www.linux-arm.org/git?p=linux-jm.git;a=shortlog;h=refs/heads/edac_dummy/v1
>
> to show how it could look like.
> 
> But I'm slowly growing a serious aversion against having this very same
> discussion each time an ARM vendor sends a driver. And that happens
> pretty often nowadays.

Maybe because what you are promoting might not be the right path
here... seriously, there's a reason why all vendors want to go down
that path and in this case I don't think they are wrong.

This isn't about just another ARM vendor, in fact I'm rather new to the
whole ARM thing, I used to maintain arch/powerpc :-) The point is what
you are trying to push for goes against everything we've been trying to
do in Linux when it comes to splitting drivers to individual IP blocks.

Yes, in *some* cases coordination will be needed in which case there
are ways to do that that don't necessarily involve matching a driver to
the root of the DT, and a pseudo-device is in fact a very reasonable
way to do it, it was a common practice in IEEE1275 before I invented
the FDT, and we do that for a number of other things already.

Cheers,
Ben.



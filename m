Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 181944441C
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 18:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfFMQey (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 12:34:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55032 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730746AbfFMHrR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 03:47:17 -0400
Received: from zn.tnic (p4FED33E6.dip0.t-ipconnect.de [79.237.51.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 41E811EC0467;
        Thu, 13 Jun 2019 09:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560412035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=cLB+4gRke9C3b3E7syS14drpp+imhytrTs84H2cq9QA=;
        b=EuWG6v2v9iwz/FPBTrezV2bIJ67quXws3z4Ak4mdc40Tguqu7d/8Wh4Mwn6do7y4ZLCCPe
        rMVMT//1awaGZ8QuWP6Nop4PcSac6TPtYoQFWFPQpUjMSkeGY1GoKQKQT0NChLNqK08ZeT
        oBMn1cwYRyY7P8z6+XauL4qptEUOVmA=
Date:   Thu, 13 Jun 2019 09:44:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
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
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
Message-ID: <20190613074457.GB11598@zn.tnic>
References: <9a2aaf4a9545ed30568a0613e64bc3f57f047799.camel@kernel.crashing.org>
 <20190608090556.GA32464@zn.tnic>
 <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
 <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
 <20190611115651.GD31772@zn.tnic>
 <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
 <20190612034813.GA32652@zn.tnic>
 <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
 <20190612104238.GG32652@zn.tnic>
 <2a53690aa81a406b9a6290f70e47470d0f698f00.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a53690aa81a406b9a6290f70e47470d0f698f00.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jun 13, 2019 at 09:54:18AM +1000, Benjamin Herrenschmidt wrote:
> It tends to be a slippery slope. Also in the ARM world, most SoC tend
> to re-use IP blocks, so you get a lot of code duplication, bug fixed in
> one and not the other etc...

Yes, I'd like to be able to reuse EDAC drivers if they're for single IP
blocks and those IP blocks get integrated by multiple vendors.

> I don't necessarily mind having a "platform" component that handles
> policies in case where userspace is really not an option, but it
> shouldn't be doing it by containing the actual drivers for the
> individual IP block error collection. It could however "use" them via
> in-kernel APIs.

Ok, sounds good.

> Those are rare. At the end of the day, if you have a UE on memory, it's
> a matter of luck. It could have hit your kernel as well. You get lucky
> it only hit userspace but you can't make a general statement you "can't
> trust userspace".

I'm not saying that - I'm saying that if we're going to do a
comprehensive solution we better address all possible error severities
with adequate handling.

> Cache errors tend to be the kind that tend to have to be addressed
> immediately, but even then, that's often local to some architecture
> machine check handling, not even in EDAC.

That's true.

> Do you have a concrete example of a type of error that
> 
>  - Must be addressed in the kernel
> 
>  - Relies on coordinating drivers for more than one IP block
> 
> ?

My usual example at the end of the #MC handler on x86, do_machine_check():

        /* Fault was in user mode and we need to take some action */
        if ((m.cs & 3) == 3) {
                ist_begin_non_atomic(regs);
                local_irq_enable();

                if (kill_it || do_memory_failure(&m))
                        force_sig(SIGBUS, current);

we try to poison and if we fail or have to kill the process anyway, off
it goes.

Yes, this is not talking to EDAC drivers yet but is exemplary for a more
involved recovery action.

> Even then though, my argument would be that the right way to do that,
> assuming that's even platform specific, would be to have then the
> "platform RAS driver" just layout on top of the individual EDAC drivers
> and consume their output. Not contain the drivers themselves.

Ok, that's a fair point and I like the design of that.

> Using machine checks, not EDAC. It's completely orghogonal at this
> point at least.

No, it is using errors reported through the Machine Check Architecture.
EDAC uses the same DRAM error reports. They all come from MCA on x86. It
is a whole notifier chain which gets to see those errors but they all
come from MCA.

PCI errors get reported differently, of course.

EDAC is just a semi-dumb layer around some of those error reporting
mechanisms.

> That said, it would make sense to have an EDAC API to match that
> address back into a DIMM location and give user an informational
> message about failures happening on that DIMM. But that could be done
> via core EDAC MC APIs.

That's what the EDAC drivers on x86 do. All of them :-)

> Here too, no need for having an over-arching platform driver.

Yes, the EDAC drivers which implement all the memory controller
functionality, already do that mapping back. Or at least try to. There's
firmware doing that on x86 too but that's a different story.

<will reply to the rest later in another mail as this one is becoming
too big anyway>.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

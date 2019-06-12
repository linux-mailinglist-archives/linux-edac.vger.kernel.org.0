Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E82BA422D0
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391659AbfFLKmq (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 06:42:46 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53062 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390614AbfFLKmq (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 06:42:46 -0400
Received: from zn.tnic (p200300EC2F0A6800D18ACEC6DD65F264.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:d18a:cec6:dd65:f264])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E0B31EC09C0;
        Wed, 12 Jun 2019 12:42:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560336164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=hOEFIAw9XcSzBtb/Fr26Hy0vNVTA+TQQcZbOP9wRQyk=;
        b=Zda/avllAsPqwaIKzP6OnpqVroW8ftpt2cs8AVWYpu/CV2W+2HsPGpZFswfJQGK5iXxYE+
        f+zWKQKMpHqHVsj/RdbR+75BDnVLIJYgLRXHh0e3jSnYFGLLekSUwcLEwjUzWPOmcKoYZg
        uVgr/PChF3mUbt/Vho+2YgHbuzkLG5Q=
Date:   Wed, 12 Jun 2019 12:42:38 +0200
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
Message-ID: <20190612104238.GG32652@zn.tnic>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 12, 2019 at 06:29:26PM +1000, Benjamin Herrenschmidt wrote:
> I tend to disagree here. We've been down that rabbit hole in the past
> and we (Linux in general) are trying to move away from that sort of
> "platform" overarching driver as much as possible.

Why is a "platform" driver like that so bad?

> This is a policy. It should either belong to userspace,

For some errors you can't do userspace as it is too late for it - you
wanna address that before you return to it.

> or be in some generic RAS code in the kernel, there's no reason why
> these can't be abstracted.

Yes, we have this drivers/ras/cec.c thing which collects correctable
DRAM errors on x86. :-)

> Also in your specific example, it could be entirely local to the MC
> EDAC / DRAM controller path, we could have a generic way for EDAC to
> advertise that a given memory channel is giving lots of errors and
> have memory controller drivers listen to it but usually the EDAC MC
> driver *is* the only thing that looks like a MC driver to begin with,
>
> so again, pretty much no overlap with L1/L2 caches RAS or PCIe RAS
> etc...
>
> Unless I'm mistaken, that amd64 EDAC is just an MC one... but I only
> had a cursory glance at the code.

EDAC has historically been concentrating on DRAM errors as that is
what people have been paying attention to. But it isn't limited to
DRAM errors - there is some basic PCI errors functionality behind
edac_pci_create_generic_ctl() which polls for PCI parity errors.

So it still makes sense to me to have a single driver which takes care
of all things RAS for a platform. You just load one driver and it does
it all, including recovery actions.

> Maybe because what you are promoting might not be the right path
> here... seriously, there's a reason why all vendors want to go down
> that path and in this case I don't think they are wrong.
> 
> This isn't about just another ARM vendor, in fact I'm rather new to the
> whole ARM thing, I used to maintain arch/powerpc :-)

What happened? :-P

> The point is what you are trying to push for goes against everything
> we've been trying to do in Linux when it comes to splitting drivers to
> individual IP blocks.

Please do explain why is a driver-per-IP-block better and please don't
give me the DT argument - I've heard that one more than enough now.

Like, for example, how do you deal with the case where you have a
platform which has a bunch of IP blocks with RAS functionality and they
all have a separate driver. Now, you want to do recovery and failover
actions depending on certain error count from a certain group of IP
blocks.

You export those counts through sysfs from the separate drivers and you
have a userspace agent doing that policy?

That cannot always fly because recovery actions for some errors need to
happen before we return to userspace - i.e., memory-failure.c types of
scenarios.

You add another "counting" layer which is yet another driver which
collects those errors and applies policy actions?

But then that layer needs to be made generic enough to be shared by the
other EDAC IP block drivers, otherwise every platform would need its own
counter layer driver. Which basically puts the problem somewhere else
but doesn't make it go away.

Another way I'm not thinking of at the moment?

A single driver solves that problem as it has all the required
information in one place and deals with it then and there.

I hear you that platform drivers are frowned upon but connecting it all
in one place for such purposes makes sense to me in this particular
case.

Btw, what is your final goal with these drivers? Dump decoded error
information in dmesg? Or something more sophisticated?

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

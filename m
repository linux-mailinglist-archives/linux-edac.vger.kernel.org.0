Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 420D04258A
	for <lists+linux-edac@lfdr.de>; Wed, 12 Jun 2019 14:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfFLMZO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 12 Jun 2019 08:25:14 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39014 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727079AbfFLMZO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 12 Jun 2019 08:25:14 -0400
Received: from zn.tnic (p200300EC2F0A68007943916066B63355.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:6800:7943:9160:66b6:3355])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EC4A1EC0997;
        Wed, 12 Jun 2019 14:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560342312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=gi/Aj6c8mOFcV7aCIIIQ6awXYflOyKeKgs4zOZSR1Gg=;
        b=hkGN/gxLvBDDeN2/dthWOwVSqcQr7cbO08nBiSouqNBUDNSo6FN9E75mDRlQfmb1TUMQSW
        f60AzaJR9J8u0qrz0qP86tcyQZhGKvXvHk6842x/JFCws8NmX7mh86lPBnAjWM68rluWfQ
        /R7uZ405Cnz6m0R9ecxSQQq+x1nP+gc=
Date:   Wed, 12 Jun 2019 14:25:04 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
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
Message-ID: <20190612122504.GI32652@zn.tnic>
References: <1ae5e7a3464f9d8e16b112cd371957ea20472864.camel@kernel.crashing.org>
 <68446361fd1e742b284555b96b638fe6b5218b8b.camel@kernel.crashing.org>
 <20190611115651.GD31772@zn.tnic>
 <6df5a17bb1c900dc69b991171e55632f40d9426f.camel@kernel.crashing.org>
 <20190612034813.GA32652@zn.tnic>
 <08bd58dc0045670223f8d3bbc8be774505bd3ddf.camel@kernel.crashing.org>
 <20190612074242.53a4cf56@coco.lan>
 <20190612110039.GH32652@zn.tnic>
 <20190612084213.4fb9e054@coco.lan>
 <7705227ea831793cc9e45af32e0da8f5547cb14d.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7705227ea831793cc9e45af32e0da8f5547cb14d.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jun 12, 2019 at 09:57:40PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2019-06-12 at 08:42 -0300, Mauro Carvalho Chehab wrote:
> > > Yes, we do have different error reporting facilities but I still
> > > think
> > > that concentrating all the error information needed in order to do
> > > proper recovery action is the better approach here. And make that
> > > part
> > > of the kernel so that it is robust. Userspace can still configure
> > > it and
> > > so on.
> > 
> > If the error reporting facilities are for the same hardware "group"
> > (like the machine's memory controllers), I agree with you: it makes
> > sense to have a single driver. 
> > 
> > If they are for completely independent hardware then implementing
> > as separate drivers would work equally well, with the advantage of
> > making easier to maintain and make it generic enough to support
> > different vendors using the same IP block.
> 
> Right. And if you really want a platform orchestrator for recovery in
> the kenrel, it should be a separate one, that consumes data from the
> individual IP block drivers that report the raw errors anyway.

Yap, I think we're in agreement here. I believe the important question
is whether you need to get error information from multiple sources
together in order to do proper recovery or doing it per error source
suffices.

And I think the actual use cases could/should dictate our
drivers/orchestrators design.

Thus my question how you guys are planning on tying all that error info
the drivers report, into the whole system design?

> But for the main case that really needs to be in the kernel, which is
> DRAM, the recovery can usually be contained to the MC driver anyway.

Right, if that is enough to handle the error properly.

The memory-failure.c example I gave before is the error reporting
mechanism (x86 MCA) calling into the mm subsystem to poison and isolate
page frames which are known to contain errors. So you have two things
talking to each other.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

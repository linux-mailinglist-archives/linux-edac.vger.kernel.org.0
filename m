Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B58C9F4E0
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2019 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbfH0VQI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 27 Aug 2019 17:16:08 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45138 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfH0VQI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 27 Aug 2019 17:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BNQgl8BXmDinA3/U5qi90mgN02ztpsNcfJjDKC7Jswk=; b=eo2x2tz3u+pHlB2Uk761ZEgQe
        hOUhU0oDfXDzrQh5Ow4isbPRbctYV/QTHIPCdlkGF8v6IJBtNDWppbeFwBq3TXYqh5G6uSjbJFtDw
        HL9SOsUw/41VrBvdBEgF1bRKE5um63SBrhyTvje70W3XYmJBSBlNg1119PrQfybSQ6jycpnoWf/Iz
        IZNR63vpGwrh2kHQj77V8FK5be474OckRHvY2rxUZEhCstLANTUN97jU16pGoJEiqu/xZBiXptItJ
        qv/6MRPCyJ9zAKpl8gOMAbnXwTegmyVouWJkCUvks63rGtTrpT9/EjEvWp/VrrLqtWBqvIh/5ZFgY
        CEI3D5siA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:55352)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i2ios-0006nH-B5; Tue, 27 Aug 2019 22:16:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i2ion-00063o-Pz; Tue, 27 Aug 2019 22:15:57 +0100
Date:   Tue, 27 Aug 2019 22:15:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "gregory.clement@free-electrons.com" 
        <gregory.clement@free-electrons.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jlu@pengutronix.de" <jlu@pengutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "patches@armlinux.org.uk" <patches@armlinux.org.uk>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Message-ID: <20190827211557.GP13294@shell.armlinux.org.uk>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
 <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
 <20190823104621.GY13294@shell.armlinux.org.uk>
 <20190823105020.GZ13294@shell.armlinux.org.uk>
 <836653f04f526333e8dbd45361329731f8dfe2ea.camel@alliedtelesis.co.nz>
 <20190827091336.GI13294@shell.armlinux.org.uk>
 <b1e2e5b325b3c4453e2ed63c17e1e11d6b24f099.camel@alliedtelesis.co.nz>
 <20190827210713.GO13294@shell.armlinux.org.uk>
 <0e9c7c7cb17b6fdea8d49b06925badb0b3d2ff8b.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e9c7c7cb17b6fdea8d49b06925badb0b3d2ff8b.camel@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Aug 27, 2019 at 09:13:11PM +0000, Chris Packham wrote:
> On Tue, 2019-08-27 at 22:07 +0100, Russell King - ARM Linux admin
> wrote:
> > On Tue, Aug 27, 2019 at 08:56:05PM +0000, Chris Packham wrote:
> > > On Tue, 2019-08-27 at 10:13 +0100, Russell King - ARM Linux admin
> > > wrote:
> > > > Just send the single patch to the patch tracker - having it against
> > > > 5.3-rc is fine (I don't think anything has changed for a long time
> > > > with that file.)
> > > 
> > > Done 
> > > https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=8902/1
> > > 
> > > I'm still not entirely sure what to put for the KernelVersion tag. In
> > > hindsight think I misinterpreted your comment above and set it to 5.3rc
> > > (where you meant a series based on 5.3-rcX should apply cleanly). It
> > > probably should have been next or master because it's way past the
> > > merge window for 5.3.
> > 
> > Think about it as "which kernel version was _this_ patch generated
> > against" - it's a guide for me to know which kernel version it
> > should be applied to.  The nearest Linus release (rc or final) is
> > generally sufficient.
> > 
> > If it doesn't apply to my current base, then I might check out that
> > version, apply it there, and then merge it in, resolving any
> > conflicts during the merge.
> > 
> > It started off with a different purpose: when we had the older
> > development system, such as the 2.x series kernels, we would have
> > even x being the current stable kernels, and concurrently we'd
> > also have x+1 as the development series.  When someone sent me a
> > patch back then, it was important to know which kernel series it
> > was meant for.
> > 
> > I decided not to get rid of it because it provides useful
> > information when patches don't apply, and gives more options
> > than me just discarding the patch with a comment saying it
> > doesn't apply.
> > 
> 
> Thanks for the info. So 5.3-rc is not as wrong as I thought it was.
> 
> One could even summarize the above as.
> 
>   git format-patch --add-header \
>       "KernelVersion: $(git describe --abbrev=0 HEAD)"

Yep, I should probably update the patch system help with that, and
actually strip out everything about the old diff and patch way of
working.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

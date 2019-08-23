Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D1F9AD9F
	for <lists+linux-edac@lfdr.de>; Fri, 23 Aug 2019 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392331AbfHWKui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 23 Aug 2019 06:50:38 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:58354 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390368AbfHWKuh (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 23 Aug 2019 06:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WkOQCblr80QvbCUn50ub1k7R9QW4QXimQCrstjhJulY=; b=k4J1jLt5xf5Toe+k9bx1wwguJ
        vYlPNgJrJp7Xj6lXdkaSZp0zW62cVygjuvPjUtNzwK8aaZK1N0u0FadQyAIeqLP0mOGgnYHcLetlG
        TOo8DaK5OvHqipsTSTfwPqSnjyqWl+QYpdKWm/xKpwlzcWReb+8Q4PWf4j0MW7h5hVZ1mo7Rw5bzR
        xx9ClQNRWKxgB5LvwGo4YlI3K7mnoDuQ/y8Vv1eTHN8OLb09sX/rsVUl1qEqNPoWsUQxPbJSjzjc/
        HFpJ8CYTvTc7S2oWL5Zlul/F72cyK/yPX1BUZPiTX24VSUl4I80o0potbMpKuZ2XFO3sixXngqmB4
        35GAnc6Fg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:55914)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1i179G-0004B2-0g; Fri, 23 Aug 2019 11:50:26 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1i179A-0000B7-JJ; Fri, 23 Aug 2019 11:50:20 +0100
Date:   Fri, 23 Aug 2019 11:50:20 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     bp@alien8.de, robh+dt@kernel.org, mark.rutland@arm.com,
        patches@armlinux.org.uk, mchehab@kernel.org, james.morse@arm.com,
        jlu@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH v9 1/8] ARM: aurora-l2: add prefix to MAX_RANGE_SIZE
Message-ID: <20190823105020.GZ13294@shell.armlinux.org.uk>
References: <20190712034904.5747-1-chris.packham@alliedtelesis.co.nz>
 <20190712034904.5747-2-chris.packham@alliedtelesis.co.nz>
 <20190823104621.GY13294@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823104621.GY13294@shell.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 23, 2019 at 11:46:21AM +0100, Russell King - ARM Linux admin wrote:
> On Fri, Jul 12, 2019 at 03:48:57PM +1200, Chris Packham wrote:
> > From: Jan Luebbe <jlu@pengutronix.de>
> > 
> > The macro name is too generic, so add a AURORA_ prefix.
> > 
> > Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >  arch/arm/include/asm/hardware/cache-aurora-l2.h | 2 +-
> 
> I can't apply this series - this file does not exist in my tree, and
> from what git tells me, it never has existed.  Maybe it's in someone
> elses tree?

I think the file is in my tree, just as arch/arm/mm/cache-aurora-l2.h
which is where it has been since it was originally submitted in 2012.

> 
> >  arch/arm/mm/cache-l2x0.c                        | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/include/asm/hardware/cache-aurora-l2.h b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> > index c86124769831..dc5c479ec4c3 100644
> > --- a/arch/arm/include/asm/hardware/cache-aurora-l2.h
> > +++ b/arch/arm/include/asm/hardware/cache-aurora-l2.h
> > @@ -41,7 +41,7 @@
> >  #define AURORA_ACR_FORCE_WRITE_THRO_POLICY	\
> >  	(2 << AURORA_ACR_FORCE_WRITE_POLICY_OFFSET)
> >  
> > -#define MAX_RANGE_SIZE		1024
> > +#define AURORA_MAX_RANGE_SIZE	1024
> >  
> >  #define AURORA_WAY_SIZE_SHIFT	2
> >  
> > diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> > index 428d08718107..83b733a1f1e6 100644
> > --- a/arch/arm/mm/cache-l2x0.c
> > +++ b/arch/arm/mm/cache-l2x0.c
> > @@ -1352,8 +1352,8 @@ static unsigned long aurora_range_end(unsigned long start, unsigned long end)
> >  	 * since cache range operations stall the CPU pipeline
> >  	 * until completion.
> >  	 */
> > -	if (end > start + MAX_RANGE_SIZE)
> > -		end = start + MAX_RANGE_SIZE;
> > +	if (end > start + AURORA_MAX_RANGE_SIZE)
> > +		end = start + AURORA_MAX_RANGE_SIZE;
> >  
> >  	/*
> >  	 * Cache range operations can't straddle a page boundary.
> > -- 
> > 2.22.0
> > 
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up

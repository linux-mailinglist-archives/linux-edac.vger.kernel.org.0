Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868D94A0036
	for <lists+linux-edac@lfdr.de>; Fri, 28 Jan 2022 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiA1ShD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 28 Jan 2022 13:37:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:46250 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236970AbiA1ShD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 28 Jan 2022 13:37:03 -0500
Received: from zn.tnic (dslb-088-067-221-104.088.067.pools.vodafone-ip.de [88.67.221.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D4B71EC0541;
        Fri, 28 Jan 2022 19:36:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1643395018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UTed4USXY3nxzXuzbu+s/mzqv1DYGJhfhz7WzX15cqs=;
        b=lLOExE5BCtqaoojoywH+hD6VLpZH+nO3Q2HPFtjNY6x6Y8/OASNic0L94kOFufc04h6toT
        3FM+hBCfrPW6ZGMALUR8JNk7m9YjUsaD5GN4t/jf47dLUsajg3t8EFB9zUv3sHj+54h3P3
        udRLAF2eG0zVG+ImAl9Di5EARRBb700=
Date:   Fri, 28 Jan 2022 19:36:53 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/2] edac: altera: fix deferred probing
Message-ID: <YfQ3xUpLOPvDu5W+@zn.tnic>
References: <20220124185503.6720-1-s.shtylyov@omp.ru>
 <20220124185503.6720-2-s.shtylyov@omp.ru>
 <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b964ac0-6356-9330-a745-b43e620d051b@kernel.org>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 26, 2022 at 10:52:20AM -0600, Dinh Nguyen wrote:
> On 1/24/22 12:55, Sergey Shtylyov wrote:
> > The driver overrides the error codes returned by platform_get_irq() to
> > -ENODEV for some strange reason, so if it returns -EPROBE_DEFER, the
> > driver will fail the probe permanently instead of the deferred probing.
> > Switch to propagating the error codes upstream.
> > 
> > Fixes: 71bcada88b0f ("edac: altera: Add Altera SDRAM EDAC support")
> > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > ---
> >   drivers/edac/altera_edac.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> > index 3a6d2416cb0f..5dd29789f97d 100644
> > --- a/drivers/edac/altera_edac.c
> > +++ b/drivers/edac/altera_edac.c
> > @@ -350,7 +350,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
> >   	if (irq < 0) {
> >   		edac_printk(KERN_ERR, EDAC_MC,
> >   			    "No irq %d in DT\n", irq);
> > -		return -ENODEV;
> > +		return irq;
> >   	}
> >   	/* Arria10 has a 2nd IRQ */
> 
> 
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

It sounds to me like we want this CC: stable@ too?

If so, looking at

  2043727c2882 ("driver core: platform: Make use of the helper function dev_err_probe()")

that added that dev_err_probe() call, which was in Nov. 2021, which
would mean, even if stable, only 5.15 and not in all stable trees
judging by the Fixes: tag which is a patch from 3.17, i.e., 2014.

Right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77579847D5
	for <lists+linux-edac@lfdr.de>; Wed,  7 Aug 2019 10:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbfHGIqB (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Aug 2019 04:46:01 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42486 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387452AbfHGIqB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 7 Aug 2019 04:46:01 -0400
Received: from zn.tnic (p200300EC2F0D5000E5DBE4FCCFA1B2C9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:5000:e5db:e4fc:cfa1:b2c9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 685841EC090E;
        Wed,  7 Aug 2019 10:45:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565167559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7bkTN/F57Ckbh6FRBfVDlrj4muQsV+izdGSF2OhAXvM=;
        b=aXrtZnRDMAHncqTsuM2Z5bE+1W7GPXLW+FWKp5/KerQYQuusr5+ZTbS08B6Xdfu1yxJqX4
        LZTlTGUz9Za+8o71LTA5z2AkfPLWK88vMQyyAZatWNcH2wN1lUOVZjpiejIQlBt2cu/PH/
        7W7Wi50AIGchAWK6Y/VeNZ2qrTMMWxw=
Date:   Wed, 7 Aug 2019 10:46:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>, linux-edac@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] EDAC/altera: Silence an endian warning
Message-ID: <20190807084643.GA18207@zn.tnic>
References: <20190624134717.GA1754@mwanda>
 <2baa5124-f0b0-a33e-256b-6a17867862c9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2baa5124-f0b0-a33e-256b-6a17867862c9@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:27:55PM -0500, Thor Thayer wrote:
> Hi Dan,
> 
> On 6/24/19 8:47 AM, Dan Carpenter wrote:
> > Smatch complains that we're casting a u32 pointer to unsigned long.
> > 
> >      drivers/edac/altera_edac.c:1878 altr_edac_a10_irq_handler()
> >      warn: passing casted pointer '&irq_status' to 'find_first_bit()'
> > 
> > This code wouldn't work on a 64 bit big endian system because we would
> > read past the end of &irq_status.
> > 
> > Fixes: 13ab8448d2c9 ("EDAC, altera: Add ECC Manager IRQ controller support")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > Static analysis obviously and I don't know this subsystem at all.
> > Probably we're never going to run this on a 64 bit big endian system...
> > Feel free to ignore this if you want.
> > 
> >   drivers/edac/altera_edac.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> > index c2e693e34d43..bf024ec0116c 100644
> > --- a/drivers/edac/altera_edac.c
> > +++ b/drivers/edac/altera_edac.c
> > @@ -1866,6 +1866,7 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
> >   	struct altr_arria10_edac *edac = irq_desc_get_handler_data(desc);
> >   	struct irq_chip *chip = irq_desc_get_chip(desc);
> >   	int irq = irq_desc_get_irq(desc);
> > +	unsigned long bits;
> >   	dberr = (irq == edac->db_irq) ? 1 : 0;
> >   	sm_offset = dberr ? A10_SYSMGR_ECC_INTSTAT_DERR_OFST :
> > @@ -1875,7 +1876,8 @@ static void altr_edac_a10_irq_handler(struct irq_desc *desc)
> >   	regmap_read(edac->ecc_mgr_map, sm_offset, &irq_status);
> > -	for_each_set_bit(bit, (unsigned long *)&irq_status, 32) {
> > +	bits = irq_status;
> > +	for_each_set_bit(bit, &bits, 32) {
> >   		irq = irq_linear_revmap(edac->domain, dberr * 32 + bit);
> >   		if (irq)
> >   			generic_handle_irq(irq);
> > 
> You are correct that we shouldn't use this on a 64 bit machine but this is a
> good fix. Thank you!
> 
> Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

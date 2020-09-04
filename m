Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C366B25D494
	for <lists+linux-edac@lfdr.de>; Fri,  4 Sep 2020 11:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgIDJTr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 4 Sep 2020 05:19:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38022 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730017AbgIDJTh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 4 Sep 2020 05:19:37 -0400
Received: from zn.tnic (p2e584a6e.dip0.t-ipconnect.de [46.88.74.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D72771EC0407;
        Fri,  4 Sep 2020 11:19:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599211175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KxTBrDiwxYh5BQZ1cs6kMKlODsllL3PGcIaID8vccUg=;
        b=LmK+uKDr4XpT0WfjrtCXs5WiQ1DsXYEpaIgKEugy7mNLvMnRVWpTlVEmWPnKDHIZRd6AUs
        GYUCbgrZZL0Df7/NFeqCk2uLfJ0CSYvmE1gMisKAfk2mKYdXZC1EZxjPZDk0fm/wpC3RU0
        ucGOcpWegj2LkoI8U5a9XJhLTa9StG4=
Date:   Fri, 4 Sep 2020 11:17:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Gregor Herburger <Gregor.Herburger@ew.tq-group.com>
Cc:     "york.sun@nxp.com" <york.sun@nxp.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: (EXT) Re: [PATCH v2 1/1] edac: fsl_ddr_edac: fix expected data
 message
Message-ID: <20200904091718.GC21499@zn.tnic>
References: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kcEE.e0qfoTd8SOOr3lTVWaXz/A.AASg8YeC1gE@vtuxmail01.tq-net.de>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Your mail client broke threading...

On Fri, Sep 04, 2020 at 06:52:24AM +0000, Gregor Herburger wrote:

> The cap_low, cap_high and syndrome are used in the printk following the if-Block.
> This will make expected data / captured data look the same.

Right.

> @@ -334,18 +337,32 @@ static void fsl_mc_check(struct mem_ctl_info *mci)
>                 sbe_ecc_decode(cap_high, cap_low, syndrome,
>                                 &bad_data_bit, &bad_ecc_bit);
> 
> +               exp_high = cap_high;
> +               exp_low = cap_low;
> +               exp_syndrome = syndrome;
> +
>                 if (bad_data_bit != -1)
> +               {

Opening brace is on the same line for if-statements.

>                         fsl_mc_printk(mci, KERN_ERR,
>                                 "Faulty Data bit: %d\n", bad_data_bit);
> +
> +                       if (bad_data_bit < 32)
> +                               exp_low = cap_low ^ (1 << bad_data_bit);
> +                       else
> +                               exp_high = cap_high ^ (1 << (bad_data_bit - 32));
> +               }
> +
>                 if (bad_ecc_bit != -1)
> +               {

Ditto.

>                         fsl_mc_printk(mci, KERN_ERR,
>                                 "Faulty ECC bit: %d\n", bad_ecc_bit);
> 
> +                       exp_syndrome = syndrome ^ (1 << bad_ecc_bit);
> +               }
> +
>                 fsl_mc_printk(mci, KERN_ERR,
>                         "Expected Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
> -                       cap_high ^ (1 << (bad_data_bit - 32)),
> -                       cap_low ^ (1 << bad_data_bit),
> -                       syndrome ^ (1 << bad_ecc_bit));
> +                       exp_high, exp_low, exp_syndrome);
>         }
> 
>           fsl_mc_printk(mci, KERN_ERR,
>                           "Captured Data / ECC:\t%#8.8x_%08x / %#2.2x\n",
>                           cap_high, cap_low, syndrome);
> 
> How about something like this?

My only concern here is that you'll be printing "Expected Data ..."
unconditionally even if either or both - bad_data_bit and bad_ecc_bit
- are -1.

If the driver cannot decode the data and/or ECC syndrome bits, then it
should say so - not dump expected data and claim that it is a valid
information.

So maybe in addition to the above:

	if (bad_data_bit != -1) {
		...
	} else {
		fsl_mc_printk(..., "Unable to decode the Faulty Data bit");
	}

and the same for the ECC bit.

And then print only the expected data for the bit which sbe_ecc_decode()
found correctly and not say anything otherwise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

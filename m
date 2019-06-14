Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD79D459FD
	for <lists+linux-edac@lfdr.de>; Fri, 14 Jun 2019 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFNKJa (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 14 Jun 2019 06:09:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:36520 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfFNKJa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 14 Jun 2019 06:09:30 -0400
Received: from zn.tnic (p200300EC2F097F002DB642DF7EFF7228.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:7f00:2db6:42df:7eff:7228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F39571EC08BF;
        Fri, 14 Jun 2019 12:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1560506969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=IQFZNxGDDog7n91wTOlHnkpmQS/cFnbsCmQ+ZaKMhl0=;
        b=njaXCL17WLcEA0GaPTFUv/8mGFFNZCfzSJ68i+IorkerK6LnAo96JStVcxFhMrtpVhiSV8
        MUvtEb+96ZjBO3U5VsAdo5UhVDt5DyHusXPRZ7q4gHYuMaNkLho8qCcQYtOeJDoiMONY4D
        Hs/YgoN1vTiBPJuOdj6oJmsF8ApMwHs=
Date:   Fri, 14 Jun 2019 12:09:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Toshi Kani <toshi.kani@hpe.com>
Subject: Re: [PATCH] EDAC, ghes: Fix grain calculation
Message-ID: <20190614100918.GA2586@zn.tnic>
References: <20190529152232.187580-1-james.morse@arm.com>
 <20190612043410.GE32652@zn.tnic>
 <9bda9613-09b3-aa6d-183f-3668ef9a99c6@arm.com>
 <20190613191843.GG11598@zn.tnic>
 <20190613210731.mehosgbqn2yak4ut@rric.localdomain>
 <20190613224130.GI11598@zn.tnic>
 <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190614072139.vzet6t5erl6uz6st@rric.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 14, 2019 at 07:21:47AM +0000, Robert Richter wrote:
> On 14.06.19 00:41:30, Borislav Petkov wrote:
> > On Thu, Jun 13, 2019 at 09:07:38PM +0000, Robert Richter wrote:
> > >  grain_bits = fls_long(e->grain) + 1;
> > 
> > For 4K grain this makes grain_bits == 12.
> 
> fls(0) == 0
> fls(1) == 1
> fls(2) == 2
> fls(4) == 3
> ...
> fls(0x1000) == 13

I believe the intent of the "+ 1" above is that e->grain was a mask of
the type 0xfff so you have to + 1 since we count from bit 0.

> Correct for edac_mc is:
> 
>  grain_bits = fls_long(e->grain ? e->grain - 1 : 0);

First of all, you don't wanna do fls(0).

Then, we don't want to use PAGE_MASK for grain computation because as
James showed, it causes problems.

> James' calculation for ghes is correct in this particular case
> (assuming a bit mask with (power of 2 - 1)).

And this is the question that needs to be clarified first: from what do
we compute the grain.

ghes_edac uses ~physical_addr_mask which can basically be:

	grain_bits = hweight_long(physical_addr_mask);

which, in the 0xfff case gives you the correct 12 bits. It is assuming
it is a contiguous mask though. It better be...

Now, if you look at how the grain gets read out in edac_mc_handle_error(), it
comes from dimm->grain. And that is defined as:

        u32 grain;              /* granularity of reported error in bytes */

in bytes!

Now, if you grep for "grain" in drivers/edac/ you see most (if not all)
initialized as bytes:

i82975x_edac.c:415:                     dimm->grain = 1 << 7;   /* 128Byte cache-line resolution */
pnd2_edac.c:1260:               dimm->grain = 32;
skx_common.c:313:       dimm->grain = 32;
highbank_mc_edac.c:223: dimm->grain = 8;
...

and so on.

So actually I think that

	grain_bits = fls_long(e->grain) + 1;

is wrong in that case. It should simply hand down e->grain as it is
already the number of bytes.

Which we should simply dump in the tracepoint too - the number of bytes
and not that silly shifting there:

	1 << __entry->grain_bits,

And once we've said that the grain is going to *everywhere* be the
granularity of the error in number of bytes, then we should stick to
that and fix all those drivers which don't do that.

Ok?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

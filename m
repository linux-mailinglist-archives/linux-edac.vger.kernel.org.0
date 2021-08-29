Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA093FAD08
	for <lists+linux-edac@lfdr.de>; Sun, 29 Aug 2021 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbhH2QQM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 29 Aug 2021 12:16:12 -0400
Received: from mout.gmx.net ([212.227.15.18]:59759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhH2QQM (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Sun, 29 Aug 2021 12:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1630253700;
        bh=TeQCmbA6UBUYq482Yvt+3gAyQYG1q6f8JlPSefpnBkw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NB74S1rQiWQxiP52z0VCU4sKhotaB4dfP5CQunT3KrBDfF5QuJhFjsmL3EtbJLc2o
         JzsJUXwPaHQyKJFtoSnd/V2ux+XZc2y8dW4wRU5qecuzUiyArzagBpYb8U5mcuHLGR
         spjLVswel7uIMZh2twYkGHhWKi7z9HBXR5zQYN48=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MwwZd-1nCTDk45KF-00yTku; Sun, 29
 Aug 2021 18:15:00 +0200
Date:   Sun, 29 Aug 2021 18:14:55 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Borislav Petkov <bp@alien8.de>, Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] EDAC/mc: Prefer strscpy over strcpy
Message-ID: <20210829150223.GB2185@titan>
References: <20210814075527.5999-1-len.baker@gmx.com>
 <YSPbOo90alPsv4vL@zn.tnic>
 <20210824090338.GB7999@titan>
 <YSU5wp/ZpsXuDgmu@zn.tnic>
 <20210827173633.GA3040@titan>
 <YSkmv8kz2z3OBHVe@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSkmv8kz2z3OBHVe@zn.tnic>
X-Provags-ID: V03:K1:b39EmhTf6gVZrCE8NTjIlRMFPdD7EpsM39zVcjWMHlB8k3tPyyf
 R1S58BvFfnXrco7SfURFinVIvGEBnjzFezrVA3yUZ1lmPVGK+Dn9JESYH/iW65LbesCjlJg
 +NOzdMduFXPeDcKl/L9AhLEv/wLb3+hRQtXMY9DrNZc3t6g1CH2iwgjfFyXjaEgocf/wyvI
 hnHwUQEm3b2AB83WvrIEQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:uY9XXNDou1s=:5W4+vz8LLVWYiyxYoATXcU
 N8idQgDDEfbNRJ+oYDKesXamrGd6dCgIXefOKiNYEfQiWjUohQRTTELg0jNqjTuJcdHqCHsSt
 SlrYHRB/WqX12y2oK3/Ue0wsvfyqn1tr2xC9j4eb40uxvZ2JjhGoeFfLLFcxb3NNw6CkGe8WP
 DtcaODTsCKezPK26EB6ByfzJ11jpgk5xO2BsGH0XUl2ovHeEKPCThugm4NJYHqOELR798GMms
 LdGKpJed2vPhf5jrUr7yLDdi1qm/t/4UWig+J4O13SS2kRGEPSp3y6jiQ7K9waS0LAwWyMxap
 Ksk79kUvfDhQrOaFtornT8MgMDWxtQiJpFvAworcLKLQ/NLcrQr4yvUmsBeChSxMYc2T2hXRH
 A9UEIA/OgPaUqBBWO6AQ7bdFnGRCer/iFlk+Ew9/X0CEFIwjVZuvOVJakkR/POpRyUW0taEpd
 OlZNVX1FoQFhuJCNPvlzx8IeSAvbnHTJfl2cGeSDigN/x6JkWIY6wKqqiEFu5jX8yek2j1vjA
 gFcQcK545BaOlh9HHsQ+xQUZr5QXs7vuDIZC7V/mxVMJwXDrFetcvpY8aO/LNUSEuj5jxW6cu
 vRmgwZM9xNVu5yDemx96R4v2bGf9vQoLK/vbrX5MOyBfxcnIahfc+ijISGcoWRO/bmZGS/N1+
 etpI7jBelGZwFXVQl7DkZdgJUv7/n9ka/LcYiBACAh+UUit/aES8ZDfCGL6nIJI8RNuHb5psa
 Ha4/TWZx/PnZYGNPePTVnZUSJbB4KtJBgP1vh1WaWl31Rd7F7TUhV1nUYqgfBgrj/0jIlNjPC
 nDLR61ftyX9rx7YJDHdEE1hTjgJh0dB+uKa4oSj8uaM322y6dZNUNJl9slvAlWGOnv0C6Y4rv
 egRP5jvV4r9324kGOACt2zHqQsteV9hXNu9SObrXEFLMokP+gVdHZDDec+D4/vL5D95fTeI+Y
 y4kygIqFHdtrrG2tGCGiyfjEnYv+oTjDKfvCx+T9A/X++W3N8efEjhHbMW5K9RHqZHCUTquv4
 0VWbgyRA7nTIhoMna75eTxgNKPtlhxoZQw86TDVbIlbUQlnyjROwO/HLT8IKa3MahqUo1ZXGx
 bvQfPLZwQLMDR/3R5CiT3Hu+/oSBa84pp0V/+BVkmiP3P0n2PIYt/tT3g==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi,

On Fri, Aug 27, 2021 at 07:54:07PM +0200, Borislav Petkov wrote:
> On Fri, Aug 27, 2021 at 07:36:33PM +0200, Len Baker wrote:
> > Well, the main purpose is to clean up the proliferation of str*cpy fun=
ctions.
> > One task is to remove the strcpy uses: The first step (previous step) =
would
> > be to remove all the strcpy uses. Then, as a second step remove all th=
e
> > strcpy implementations.
> >
> > I hope that this clarify your question.
>
> Yes, it does.
>
> Now lemme clarify why I'm asking: when your patch is committed to the
> kernel tree and someone reads its commit message months or even years
> from now - and those who do that are mostly maintainers trying to figure
> out why stuff was done the way it was - they will read:
>
> "This is a previous step in the path to remove the strcpy() function
> entirely from the kernel."
>
> and wonder what previous step that is what the following step is...
>
> So, long story short, your commit message should be complete on its own
> and understandable without any references to things which might not be
> as clear and self-evident in the future as they are now.
>
> Makes sense?

Ok, understood. Thanks for the advise and guidance.

>
> Also, if you're wondering if you should send the patch with the error
> checking of strscpy() added, as I requested, even if it might look
> superfluous now, yes you should.
>
> Even if it looks impossible now, we might change some of those defines
> in the future and forget to touch the logic which generates e->label and
> we might end up exhausting that string.
>
> So it would be a lot more robust if something would catch that change,
> albeit seemingly redundant now.
>
> I sincerely hope that clears up things.

Yes, it clears up things. However I think the same that Joe:

=46rom Joe Perches:

[...]
I still think scnprintf is _way_ more common and intelligible as
a construct than this odd strscpy with required error checking.
[...]

So, I will send a new version for review with the commit message updated
and using the scnprintf. This way we can discuss using a real patch.
Anyway thanks for the review.

Regards,
Len

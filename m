Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD0B325F06
	for <lists+linux-edac@lfdr.de>; Fri, 26 Feb 2021 09:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhBZIab (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Feb 2021 03:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhBZIaa (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Feb 2021 03:30:30 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D255C061574;
        Fri, 26 Feb 2021 00:29:45 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id a7so8809010iok.12;
        Fri, 26 Feb 2021 00:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wv9SyvXPStH1HbSiyrd6dLJkIu8R0cmO6gcv4tLTSvQ=;
        b=Rhl08QI0pfGUZYq6eTciDwuN89KLIIALSh8uKopiHPcUrfyNcHVdR0Y6PGJQ1Aw1Xp
         vPXZjJhOIbKvkPRAco2v2VKNnyYBYI7anNnDxXs0xiSFo7fx91n4XiggVGMHNhhKvu4k
         VOo44XIZnSglXqVUOvLckvmbXB7NqIerp5578rZZ7Kkq5DtCOVgLsBTzfYkva3pS5MmR
         BAfHatL1uy5ftOMq0kGxA8XxXWQPdMPnpdScblfP9jVupdhUCn3EriJZ5//VUNid5wyo
         f/ATH0swlnaPmd0JLN4HAMbgaAspgJBsV4EsG8vx1D8YainfyvDQL/PiOgyXGYZppUzS
         m9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wv9SyvXPStH1HbSiyrd6dLJkIu8R0cmO6gcv4tLTSvQ=;
        b=eB7w4SrEh/UrtC8zeHrlQCVjDDWFPyXAvn1IO1w4ABpiJk9vUEQXrt5WzCYYQ15iij
         VPbaWpiB+Fo0eF2cBVXkkpIv756TpG2ufOSV/DZ55llt95nN2sPSOS4Rn4K/yagiPdE/
         b6+a+sPAuqxtgEZOt5eA+8VncJFssTLrutXC3N9HGzm0yf2uzEan7OLdI2EuMOna8ZFO
         T+VLBcWiM41u/d2xg+CFwUGTvIN/SVLgEH0i4IfYbDw2rkSRmeWzgCYXrcTKJZxt66Ln
         p+ZTEuSvHVmzb9ZV3hADIfmAABObMB0G2GslzUYE5LclhZ5l/hr4zVTZfXlZQgpwSKkk
         zT2A==
X-Gm-Message-State: AOAM531uSRRNbprZ5yxFh0qKgEsdXrMmXHI8gXuiO2bb+jvwjWLlpr/I
        7yOWLs36t3mOaoQ9MHHxr6TbpvDXBn6CEzOTuZXLu9BVCxA=
X-Google-Smtp-Source: ABdhPJzPdTp9oMZ+w5xch1v6D5+MMN1OxBLOqz/HNnorcjnd11QqrnQ4bhDhT4DYAfQxcYgPBGykY+glXt4wVghUZ0A=
X-Received: by 2002:a05:6602:2bd5:: with SMTP id s21mr1906817iov.189.1614328185042;
 Fri, 26 Feb 2021 00:29:45 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
 <20210222161905.1153-3-lukas.bulwahn@gmail.com> <CAAdtpL4egZYCGS+2K5FQSFYcPKomosuvvrunpDskkiif5Ma5Uw@mail.gmail.com>
In-Reply-To: <CAAdtpL4egZYCGS+2K5FQSFYcPKomosuvvrunpDskkiif5Ma5Uw@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 26 Feb 2021 09:29:34 +0100
Message-ID: <CAKXUXMygO2caTv9D1dMv9dxJSgC8=CpcT3hYsNm_ko4HXdNmeg@mail.gmail.com>
Subject: Re: [PATCH 2/5] MAINTAINERS: remove linux-mips.org references
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 23, 2021 at 10:48 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> On Mon, Feb 22, 2021 at 5:22 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> w=
rote:
> >
> > The domain lookup for linux-mips.org fails for quite some time now. Hen=
ce,
> > webpages, the patchwork instance and Ralf Baechle's email there is not
> > reachable anymore.
> >
> > Remove all references of webpages from linux-mips.org in MAINTAINERS, a=
nd
> > refer to the kernel.org's linux-mips patchwork instance instead.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  MAINTAINERS | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index e949e561867d..703a50183301 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4980,7 +4980,6 @@ DECSTATION PLATFORM SUPPORT
> >  M:     "Maciej W. Rozycki" <macro@orcam.me.uk>
> >  L:     linux-mips@vger.kernel.org
> >  S:     Maintained
> > -W:     http://www.linux-mips.org/wiki/DECstation
>
> Why not use the web archive? The information is still valuable.
> https://web.archive.org/web/20190704000315/https://www.linux-mips.org/wik=
i/DECstation
>

If that information is valuable, how about adding that into the kernel
documentation page?

If linux-mips.org wiki is back, we will keep this link; if not, we
should get a copy of that information into the documentation (where it
can survive some time) or we simply drop it.

Putting a web.archive.org link into MAINTAINERS sounds like a really
bad idea to me.

Lukas

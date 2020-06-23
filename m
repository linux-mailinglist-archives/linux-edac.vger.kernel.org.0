Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD1D2046D2
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jun 2020 03:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgFWBmN (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Jun 2020 21:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731934AbgFWBmN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Jun 2020 21:42:13 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED633C061573
        for <linux-edac@vger.kernel.org>; Mon, 22 Jun 2020 18:42:12 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i25so21939334iog.0
        for <linux-edac@vger.kernel.org>; Mon, 22 Jun 2020 18:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SctcyhsRxemfH4y0momDALozOu0UsCbqYPy1zQAY9zg=;
        b=OTHlSkXrgcUxGw9oKHexpo6edXTDFTpN4Li52ZISWVhDQzHK5padxramubiVmYUciq
         6vvbavUuC/8A8y8b9QsRxYdTT5qAiJQxREMvcm5k5gcq+OymuW5iI5vxxfOPw2XGwiAJ
         ylkavrCo1/z4xh+M6L2Zkvdkwaawe8QEbTEtNUri1QUK43Qh7+j1az75KxSOGw1fOulJ
         KBKC/IOrX4fGfgNruj6uSvM3x+hIEQyFi+nsS4A19lPAr/3gRcELWXB2DHJLA4ykSvHs
         XveeMNHnro409oVE6di+flPrf0y7SYN8yz4tDV2TA5H2ZEbUNl9pVPq43ZnVOFa06i/H
         /vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SctcyhsRxemfH4y0momDALozOu0UsCbqYPy1zQAY9zg=;
        b=VSPLHyriupvHBcslqvPfkVI3M58n6lxnAAASpt5nHxqQKfAzL7OgkF+AqT8XqPTAoN
         XjX/FfZ1P8qe9VclxcW7hJwDLt3Gk3/lfvRL+17WH9YZ3ZnOAatmTCSxYdfoJ1AiDdn7
         IYp27rqDxccPzfO6Esuwv0NHpXvkMXs5HbSCkx/gqOkcazNgYj9hgwt8WtE8MOxWezhn
         lLSh1+lpZCZIUN18tHkS+3ONN8fl5u4X22WxhtPgxGBUpV1NRrYH2g2VsoE3/7hO47FG
         3pRB3UV3Wc3jDDGz77FVTE/3ZgSGZFrcxPRsYqlxHLuWPFiOaOsRmZwQYyu66QQ7IPPV
         haRQ==
X-Gm-Message-State: AOAM531c9pnWyH0TOuzdBwYCXHSYC3e5BLHAIYEOFY10wTeeiap1F7Kf
        zTl0yOqbvdDGVNe93wzozkQWBpsjjL/Bbe0/0a0D0jU0
X-Google-Smtp-Source: ABdhPJzhMZmPCEPtTWnUvxbEif72fypmsG8VCN0HVE5chzpmCpp5MKHaXBpCSI7c9Y6lyYGo/zcMaN0vMqnknwZA4l4=
X-Received: by 2002:a05:6602:15c8:: with SMTP id f8mr22587084iow.183.1592876532104;
 Mon, 22 Jun 2020 18:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com>
 <20200618175646.GD27951@zn.tnic> <20200618184041.GE27951@zn.tnic> <20200622151305.GD32200@zn.tnic>
In-Reply-To: <20200622151305.GD32200@zn.tnic>
From:   Anders Andersson <pipatron@gmail.com>
Date:   Tue, 23 Jun 2020 03:41:35 +0200
Message-ID: <CAKkunMZLhou+T1xdOBi717Jk3JrREd5AHLKk3vK8rqSrvFuAew@mail.gmail.com>
Subject: Re: [PATCH] EDAC/amd64: Read back the scrub rate PCI register on F15h
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 22, 2020 at 5:13 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jun 18, 2020 at 08:40:41PM +0200, Borislav Petkov wrote:
> > On Thu, Jun 18, 2020 at 07:56:46PM +0200, Borislav Petkov wrote:
> > > Oh, you're manipulating it alright but there's a bug in reporting it.
> > > Wanna test a patch?
> >
> > Here it is:
> >
> > ---
> > From: Borislav Petkov <bp@suse.de>
> >
> > Commit:
> >
> >   da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")
> >
> > added support for F15h, model 0x60 CPUs but in doing so, missed to read
> > back SCRCTRL PCI config register on F15h CPUs which are *not* model
> > 0x60. Add that read so that doing
> >
> >   $ cat /sys/devices/system/edac/mc/mc0/sdram_scrub_rate
> >
> > can show the previously set DRAM scrub rate.
> >
> > Fixes: da92110dfdfa ("EDAC, amd64_edac: Extend scrub rate support to F15hM60h")
> > Reported-by: Anders Andersson <pipatron@gmail.com>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: <stable@vger.kernel.org> #v4.4..
> > Link: https://lkml.kernel.org/r/CAKkunMbNWppx_i6xSdDHLseA2QQmGJqj_crY=NF-GZML5np4Vw@mail.gmail.com
> > ---
> >  drivers/edac/amd64_edac.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> > index ef90070a9194..6262f6370c5d 100644
> > --- a/drivers/edac/amd64_edac.c
> > +++ b/drivers/edac/amd64_edac.c
> > @@ -269,6 +269,8 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
> >
> >               if (pvt->model == 0x60)
> >                       amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
> > +             else
> > +                     amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
> >       } else {
> >               amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
> >       }
> > --
>
> Queued into edac-urgent.
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette


Ok, finally tested the patch on my machine, and (no surprise)
everything now works as expected, thanks!

// Anders

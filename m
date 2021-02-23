Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF1D322B88
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 14:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhBWNeh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Tue, 23 Feb 2021 08:34:37 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:43757 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbhBWNeg (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 08:34:36 -0500
Received: by mail-ot1-f51.google.com with SMTP id l23so15508657otn.10;
        Tue, 23 Feb 2021 05:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W1FTBNiyBbbmPU7r9FwLGrJDR2sXQdMfcOeR069zcPk=;
        b=TRwmgpdFuphVAuVf8CMl9ZH9MMr1gOHJheBmTtHHAbcUk6jYOIp4TrUhiKKXjTAtmM
         EIE3SvWgnTNu5cizvinWqpsz5V+Z9Jp5QJVrElp6CNRq6cvAJJoSnq3/pl78FoEKx6Fi
         vcojHUO62BybC3KZRlDPf9rziLd4W7KlDRU1Z6B3Kb4pZjPjwRddo8NROxR0n7ZhUERY
         SoWxmCe2UohR3YtVwSi++N3t4eQtJrCsoay51XS/aYNdf345267FDa2dNWHLdc9eheJm
         pGv9YVW1F22DTiHjDg28nX/6FQkWPUA7V3/KndhvTNKNczdtfcGPtaEDXfS6V4Vp5nzy
         3qrQ==
X-Gm-Message-State: AOAM532OSytx5N8Qld6OzZ2DyMUPmIc+sSZlROP3mJzM/+IUjXh0brfO
        xYyAvNN2NAHiFPdLLsZJl8cG9kjLHK2ySfEYlDg=
X-Google-Smtp-Source: ABdhPJxjkNrWvxSoaC7JsMeEuhHWcisA7wpJjF/HrLOxSfP7dHYrKwtA5+I3iEpYSkzSOYmRV5MKU5jJZwIg36sU74U=
X-Received: by 2002:a9d:4a8e:: with SMTP id i14mr20834879otf.37.1614087235498;
 Tue, 23 Feb 2021 05:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
 <20210222161905.1153-6-lukas.bulwahn@gmail.com> <CAAdtpL5yU0-0hR76zV5hDHWd7NOxa1E0g5=eteHvman1f7cWhQ@mail.gmail.com>
 <alpine.DEB.2.21.2102231330410.1900@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2102231330410.1900@angie.orcam.me.uk>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Tue, 23 Feb 2021 14:33:44 +0100
Message-ID: <CAAdtpL4M68ton_YkEYPZPL-+Onm5+LL35pbtpRA4U6oA2gC-TA@mail.gmail.com>
Subject: Re: [PATCH 5/5] MIPS: SGI-IP27: fix spelling in Copyright
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Feb 23, 2021 at 1:33 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
> On Tue, 23 Feb 2021, Philippe Mathieu-Daudé wrote:
>
> > > diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> > > index 79c434fece52..444b5e0e935f 100644
> > > --- a/arch/mips/sgi-ip27/ip27-timer.c
> > > +++ b/arch/mips/sgi-ip27/ip27-timer.c
> > > @@ -1,7 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /*
> > > - * Copytight (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
> > > - * Copytight (C) 1999, 2000 Silicon Graphics, Inc.
> > > + * Copyright (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
> >
> > If the email isn't valid anymore, why keep it?
>
>  As I noted in an earlier reply and Kurt further confirmed site recovery
> is under way.

Great. Alternatively the authorship is preserved without the author
email (but IANAL):

Copyright (C) 1999, 2000, 05, 06 Ralf Baechle

>
>   Maciej

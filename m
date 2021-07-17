Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 079A83CC18A
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jul 2021 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhGQGz3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Jul 2021 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhGQGz2 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Jul 2021 02:55:28 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815A8C06175F;
        Fri, 16 Jul 2021 23:52:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k184so18513238ybf.12;
        Fri, 16 Jul 2021 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fj4r/axWRIO6jSTkcRS6R08Hk59RDdA00RhrYBvWubg=;
        b=PTmyJ9xuIut1vhuWMO/d0Zk/gcwgE0m2uYvkM3OcYBxo1lK07xxCASqH6KPVdIcbwB
         O5X1X9we+GG4MGX+Wdp/or8XRYjo3q88MNgI67HDI2by+Mh3QJpei/OZFn61YSk2fU/d
         OmnIlWWyBx4DVKy9zYNBRPd0NZEKVnTIdOYjPHJaGBQKvBWwzrjmXOsGiJs19pMP+iD6
         qje39jgGTUS/wa2WY0VJV3hizLG961fQ43YXLd19dnhxa4KEJ2ZBhMkvaG0k3o/MC2+W
         SGvANFiHZRzkqHjSYDIA61hBZUw8bNaVomP/aQZgJJ9gFTaOKqtKb61t61r2qm8LZimc
         m9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fj4r/axWRIO6jSTkcRS6R08Hk59RDdA00RhrYBvWubg=;
        b=qDQU5uiSRxhQjCgR7c1L5T6spjeaKvkigckb1d6ewm26iUF06MVsGNwhj0dw15+VZd
         UZU0NVoM1jDkx2lBcP1zrWUS9kjwc2D+9R6XKnB4+DaXrvEocna0zy3tLlOJ0NMhHHU5
         cn1NtAE4OQ2ZF2jVsrhdi/5hkPEngOdWgx0+9g7Vvz5MLwoOkUOyHsJs3HieqY9HJsAI
         +cGb9SiBcY/zokX35XuyF3bf8z+fxhwL0pAiDhA6afwiUhiq/g30oA2cbotsG9/GR0GU
         8J1SI2JxFhzsbcgOq7oCsejI/Fd8PKu2R1bet/EAgd+1gfkt5zwzJidsxfBoGfTo8Zrj
         dYeA==
X-Gm-Message-State: AOAM532urc/3LQMcBoJirD4xO9lmouKunsPOrtvwD3LGX5oGPI5fLrXI
        hCn5VBDxAMEN4CCHJcCbPQ6zlZ4++tfNklNHddA=
X-Google-Smtp-Source: ABdhPJxBC15IDzQUHtW2/hmOwt6Vr+EC9eCrxIa0dfDCiEk87DOwUJW5i36noGZM43J5WJiMKdkZqyxphaBBISA9G9M=
X-Received: by 2002:a25:ab26:: with SMTP id u35mr18449800ybi.151.1626504751445;
 Fri, 16 Jul 2021 23:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
 <20210625110419.24503-4-lukas.bulwahn@gmail.com> <CAAdtpL6CMAbBPJr3La31Y3AYY48TjLZhDHjKWjUJxXdBS--Xmw@mail.gmail.com>
In-Reply-To: <CAAdtpL6CMAbBPJr3La31Y3AYY48TjLZhDHjKWjUJxXdBS--Xmw@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 17 Jul 2021 08:52:20 +0200
Message-ID: <CAKXUXMxJS-H7ZtM0deSN493aQACTtbHH+y8C-f3XKANsH3UCHg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch: mips: remove dead references
To:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Sat, Jun 26, 2021 at 6:52 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>
> On Fri, Jun 25, 2021 at 1:05 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> w=
rote:
> >
> > The domain lookup for linux-mips.org fails for quite some time now.
> > Further, the two links:
> >
> >   http://decstation.unix-ag.org/
>
> https://web.archive.org/web/20061010210936/http://decstation.unix-ag.org/
>
> >   http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/Tri=
Add/
>
> https://web.archive.org/web/20050205114151/ftp.digital.com/pub/DEC/TriAdd=
/
>
> > refer to old webpages or contain no further technical information.
>
> FWIW the information is still online somewhere.

Thanks, I prefer not to reference archive.org links, because I do not
think that is generally a good practice. But maybe somebody with some
mild interest in this architecture can support scanning through the
archived web pages and we store any information still worth mentioning
in the kernel Documentation?

Lukas

>
> > Remove all those dead references.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> >  arch/mips/Kconfig             |  8 +-------
> >  arch/mips/jazz/Kconfig        | 12 +++---------
> >  tools/include/nolibc/nolibc.h |  3 +--
> >  3 files changed, 5 insertions(+), 18 deletions(-)

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782563CC194
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jul 2021 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhGQG4x (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Jul 2021 02:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhGQG4w (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Jul 2021 02:56:52 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC67CC06175F;
        Fri, 16 Jul 2021 23:53:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id r132so18580050yba.5;
        Fri, 16 Jul 2021 23:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7g1basq9FIMEpxZHyAA7wCvpnCVvOwjerdE9BRFHgr4=;
        b=jx2mOZGG/9NAOBxuu+ImUitJqa/QecCGWQ2n/a+OaVrhni/m6bAT+dLEAV5p4xDTtQ
         1wCnldiCQMzzE8TEP71/J0qWgJiiimwpRwzt9XfVyL/NWWJTsukjCkAM6VLOn+OgMMQY
         PjayFSCUHZG3ScrB5X38+V/7xGbZJv/09cSd5yeUc5lixwu6sTL8jK5VqEXpS+faz2RU
         5VoDAE4uSvYorO3I9T4Iq+SglZ3SGO5biixnFxPg3byx6luGl8wklN47LJLqj186kxhg
         mup+Be9QlHYVrhKGVKOJ3CkVmkha11cgFzgQ1y9epECo7u3CO6bSiBQ9l8P9QqOOEyAg
         piHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7g1basq9FIMEpxZHyAA7wCvpnCVvOwjerdE9BRFHgr4=;
        b=HvhMu6gdgGZ0V4783Bl7ZY6BmYMAkcWRWZNeuBKeLHDfVkKNMtL7vrmWw5aZpxsGHz
         8/Rhq9mWC8YcYgWoJY5q4YKzchyfWa0weGjB4ZHL6LDHOP4LbBCIZlJRDiPcVD3Q3uuV
         +ZuP9x1ukqUGC2glDUGwHMKbXHlTvRcoZQnAT6SW6RCU5d1VPmQ2QyjAm68AG5wOlNWo
         eJHFJfGcEt7GbVxJ1/sOG4LEMl0n2NU+//N3nht9o33R1zZxKORem/1YM/RnnDQO5dk7
         o/QWPYdVKcXlfQzEx6WaW3Pg/p+29Bmx5VR61JEkFsk4G0Nkv+YaS4nS9M59bPaTdMVf
         enZw==
X-Gm-Message-State: AOAM531CMAOxLZzkL1zWsu4beFiVAB6S1mz+2bNppLlYcbQ4CZXyKCRL
        EMA9mM6hezqTc4EXzIQP6BZli4cbcAkF5suKb7A=
X-Google-Smtp-Source: ABdhPJyEr8R3tdbDULeEJeCfuC4XeVSmEmoHn3grGBCxXWcZhr/V1VsfgufnVDaLI1QFGDA3AxYDRqpjU0wREEqN+hI=
X-Received: by 2002:a25:f0b:: with SMTP id 11mr17705020ybp.518.1626504834998;
 Fri, 16 Jul 2021 23:53:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
 <20210625110419.24503-4-lukas.bulwahn@gmail.com> <CAAdtpL6CMAbBPJr3La31Y3AYY48TjLZhDHjKWjUJxXdBS--Xmw@mail.gmail.com>
 <alpine.DEB.2.21.2106261919300.37803@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2106261919300.37803@angie.orcam.me.uk>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 17 Jul 2021 08:53:44 +0200
Message-ID: <CAKXUXMwsiOMX0CismKBhcopkNtCUTmwDxQTC9KOBYQ2VfK6q-g@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch: mips: remove dead references
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
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

On Sat, Jun 26, 2021 at 7:22 PM Maciej W. Rozycki <macro@orcam.me.uk> wrote=
:
>
> On Sat, 26 Jun 2021, Philippe Mathieu-Daud=C3=A9 wrote:
>
> > >   http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/T=
riAdd/
> >
> > https://web.archive.org/web/20050205114151/ftp.digital.com/pub/DEC/TriA=
dd/
>
>  I suggest: <ftp://ftp.hp.com/pub/alphaserver/archive/triadd/> as the
> canonical reference nowadays.  If that goes offline sometime, we can thin=
k
> of an alternative.
>

Thanks, Maciej. I will update the reference to that location, when I
come across to send the next version of this patch set.

Lukas

>   Maciej

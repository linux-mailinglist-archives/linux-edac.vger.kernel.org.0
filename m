Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2809D3B4FAE
	for <lists+linux-edac@lfdr.de>; Sat, 26 Jun 2021 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFZQzE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 26 Jun 2021 12:55:04 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:41584 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhFZQzE (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 26 Jun 2021 12:55:04 -0400
Received: by mail-oi1-f173.google.com with SMTP id t40so15415941oiw.8;
        Sat, 26 Jun 2021 09:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RjZxnCKisu/yuzm/zETycG8rc5tC3RzprLyQlbTug+k=;
        b=Isftq1UNErzdesqAEC5Xpl6aw+KheApI5VPBxaacd0pDFZ5gIow9ns7L6D1Uvo6cKG
         nL3QVSKLtRpfBTKW6Qrl+q7vgIdObvvF8s7FQIcbQq6GvPqSNnvEgWqfICwhJcn/6tYG
         RYlENqDVpCvt/nT9f8Bp1THsHgGBEGqbthe3KAyFy+KnAwiBfmCQCp3of9rwE9HJUb1r
         ZRiurocZejtE9Z4GopvXYMZVpN7ojGGYGdIxqGxlFCAcY/NJem1Yc586aTL6gb8GZKv8
         jo2yBxYgxkplYtyGpkgxv78pJBZxmg3JA8VD4sMSzjHoMf21PFr6EiFlJWP6OMAGPsvg
         RRKg==
X-Gm-Message-State: AOAM53386eepEm5CnR07snW7zwT9u+H8t8F6g2Bm3/6O/c5tgLmaDAPH
        pd6OYU5/2Q3pMMm3ngCu3YXd03M6YbN3rmovj1k=
X-Google-Smtp-Source: ABdhPJyC5a301nKdQKjA2vzaDvUaVKdwf4Qr5aWApiVCV+yMVGfkYFXsZGAJvjRNQhA8AeUHlFWL/Eit5p59ZFQn3tk=
X-Received: by 2002:aca:c60c:: with SMTP id w12mr15647925oif.46.1624726359841;
 Sat, 26 Jun 2021 09:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com> <20210625110419.24503-4-lukas.bulwahn@gmail.com>
In-Reply-To: <20210625110419.24503-4-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Sat, 26 Jun 2021 18:52:28 +0200
Message-ID: <CAAdtpL6CMAbBPJr3La31Y3AYY48TjLZhDHjKWjUJxXdBS--Xmw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arch: mips: remove dead references
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 25, 2021 at 1:05 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The domain lookup for linux-mips.org fails for quite some time now.
> Further, the two links:
>
>   http://decstation.unix-ag.org/

https://web.archive.org/web/20061010210936/http://decstation.unix-ag.org/

>   http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/

https://web.archive.org/web/20050205114151/ftp.digital.com/pub/DEC/TriAdd/

> refer to old webpages or contain no further technical information.

FWIW the information is still online somewhere.

> Remove all those dead references.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/Kconfig             |  8 +-------
>  arch/mips/jazz/Kconfig        | 12 +++---------
>  tools/include/nolibc/nolibc.h |  3 +--
>  3 files changed, 5 insertions(+), 18 deletions(-)

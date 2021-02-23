Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 326C1322383
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 02:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhBWBU7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 20:20:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBWBU5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Feb 2021 20:20:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AC6960232;
        Tue, 23 Feb 2021 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614043217;
        bh=DrhhhxquQa9mMMAlVDZt621WhowL2G0QRwZ1oprjFoY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0L7HNxZpkuc4vsHzjuYh7yIaejq5QIw6JuRdXjNKD0/Gn64F21CXixIszhcuYx9y
         ED1+P/xk5eOPdiGNKServB7o6OGs4Vint0c1D2M0rYi/ssdYNQsz5DsM+bShMlJx9x
         YOIOhGkTkNs/ygf+H06eHctMm2t0Saw0axjPJ/J9KHcM9j2YqzuL8b61dasurDDAnd
         xI9snoLrknDGPxkBtAkNy605tiJeidtTsOujz4Mt2hepw+usuCUzx+tgbcQ35jw0Z4
         fCSx4hKrSVbRkrwMZ0D/GNq9ADPx3l0S865ekxn065Xv8BitJX2EfuB4moYa5zCSbi
         h8+peInvB92/A==
Received: by mail-io1-f46.google.com with SMTP id u8so15378153ior.13;
        Mon, 22 Feb 2021 17:20:17 -0800 (PST)
X-Gm-Message-State: AOAM532pXArxnXvabKWs7aB0fS/BWzdVtb68JnpHDf45B3n4oH9dFumu
        VrjZ3AoL/J93jMlHDgnpftGOge9ovwmEPayfOOw=
X-Google-Smtp-Source: ABdhPJyTSKQB8sQM5y9f2DjeXYE9RykFsxqlJ4lMOwJSXDAOHhRiNVZL1/oDf9dXcqwVBFhbmtT4cpVfkilz/86CfdQ=
X-Received: by 2002:a6b:6603:: with SMTP id a3mr17360502ioc.148.1614043216618;
 Mon, 22 Feb 2021 17:20:16 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-6-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-6-lukas.bulwahn@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 Feb 2021 09:20:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5rmym9_5X9uxAHvAJasNrVCgQSE23tv3XULE60iwMnUw@mail.gmail.com>
Message-ID: <CAAhV-H5rmym9_5X9uxAHvAJasNrVCgQSE23tv3XULE60iwMnUw@mail.gmail.com>
Subject: Re: [PATCH 5/5] MIPS: SGI-IP27: fix spelling in Copyright
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@kernel.org>

On Tue, Feb 23, 2021 at 12:22 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> This is a Copyright line, and just a typo slipped through.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/sgi-ip27/ip27-timer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/sgi-ip27/ip27-timer.c b/arch/mips/sgi-ip27/ip27-timer.c
> index 79c434fece52..444b5e0e935f 100644
> --- a/arch/mips/sgi-ip27/ip27-timer.c
> +++ b/arch/mips/sgi-ip27/ip27-timer.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copytight (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
> - * Copytight (C) 1999, 2000 Silicon Graphics, Inc.
> + * Copyright (C) 1999, 2000, 05, 06 Ralf Baechle (ralf@linux-mips.org)
> + * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
>   */
>  #include <linux/bcd.h>
>  #include <linux/clockchips.h>
> --
> 2.17.1
>

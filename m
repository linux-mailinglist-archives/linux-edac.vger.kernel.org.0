Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6789332236B
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 02:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhBWBRc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 20:17:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:36912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229863AbhBWBRa (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Feb 2021 20:17:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A40E960232;
        Tue, 23 Feb 2021 01:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614043009;
        bh=kDwba0vVgoevzJZ1ejp9aIx55kGXux65+VE5+XPArvQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dA0KMovrh4BCRgSKtyWZoXGvYaCHiHdqidrfcXpCsgCrKKGraOYgOGjlR87xeK9qV
         w9kDmHR0Wgs1Hclsrb0kvsQTHtLGB/XGkgZF5cKW07ejaibXyE6Kgif5hGJvZrmhht
         rUpJ8+IJBD8cBEYpwp472yOW71w9lomxM4kSoBttML7MiRDODkvV1/YFVPQSn9I5Pw
         YHY3tJPjXtMI2DObywS+ZHRVjMQ5NT5CD5eVKOwZA9DaZYcPJD6g+KQ0v87UdsXxBW
         jBaQIxpw6JKXvG9iEVtPlMxMCW+ljIV3M0v1IgOxIv7hdzYaol45Fy8YhZtyZNooLK
         pjtKMQW08QPSg==
Received: by mail-io1-f49.google.com with SMTP id k17so7582216ioc.5;
        Mon, 22 Feb 2021 17:16:49 -0800 (PST)
X-Gm-Message-State: AOAM531TNgWIYBpib6uTfp/JobczAEA/lQ3GzFHf3jGURHI5b0g92W49
        yR9WHGbUqwlxCzNs/Gx6+hUlHYKNm1LtToDLTjM=
X-Google-Smtp-Source: ABdhPJz7+GwyctOMH/oDlyMU8gM2QH44bFdcRoMYUvEOB/ALHXlwc5LneLHjIs6q9qKW0qDTbUKcXjoS+cBpMdiJhb8=
X-Received: by 2002:a6b:6603:: with SMTP id a3mr17348843ioc.148.1614043009025;
 Mon, 22 Feb 2021 17:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-3-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-3-lukas.bulwahn@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 Feb 2021 09:16:37 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5aKEOFr32G3BZJofUQaRtqM7zsy6fX-gPCwxFhKBqa2w@mail.gmail.com>
Message-ID: <CAAhV-H5aKEOFr32G3BZJofUQaRtqM7zsy6fX-gPCwxFhKBqa2w@mail.gmail.com>
Subject: Re: [PATCH 2/5] MAINTAINERS: remove linux-mips.org references
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
> The domain lookup for linux-mips.org fails for quite some time now. Hence,
> webpages, the patchwork instance and Ralf Baechle's email there is not
> reachable anymore.
>
> Remove all references of webpages from linux-mips.org in MAINTAINERS, and
> refer to the kernel.org's linux-mips patchwork instance instead.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e949e561867d..703a50183301 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4980,7 +4980,6 @@ DECSTATION PLATFORM SUPPORT
>  M:     "Maciej W. Rozycki" <macro@orcam.me.uk>
>  L:     linux-mips@vger.kernel.org
>  S:     Maintained
> -W:     http://www.linux-mips.org/wiki/DECstation
>  F:     arch/mips/dec/
>  F:     arch/mips/include/asm/dec/
>  F:     arch/mips/include/asm/mach-dec/
> @@ -11932,7 +11931,6 @@ MIPS
>  M:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>  L:     linux-mips@vger.kernel.org
>  S:     Maintained
> -W:     http://www.linux-mips.org/
>  Q:     https://patchwork.kernel.org/project/linux-mips/list/
>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git
>  F:     Documentation/devicetree/bindings/mips/
> @@ -18248,10 +18246,9 @@ F:     arch/um/os-Linux/drivers/
>
>  TURBOCHANNEL SUBSYSTEM
>  M:     "Maciej W. Rozycki" <macro@orcam.me.uk>
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-mips@vger.kernel.org
>  S:     Maintained
> -Q:     http://patchwork.linux-mips.org/project/linux-mips/list/
> +Q:     https://patchwork.kernel.org/project/linux-mips/list/
>  F:     drivers/tc/
>  F:     include/linux/tc.h
>
> --
> 2.17.1
>

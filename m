Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3998F32237B
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 02:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbhBWBUS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 20:20:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:37348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhBWBUR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 22 Feb 2021 20:20:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 836BA64E61;
        Tue, 23 Feb 2021 01:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614043176;
        bh=yKEez1y1qrdFSuFXWvWFRklOulWdPewFMVZ5ph48XiA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uiNBAClTYVe5Yrm7DpLxh9jHhEleL/jm0UKCYvybv5gsN7nfOSTtGK/XFpW+UJFs5
         kmIj13GIp/U3lXoGMp7LuUVAJb80oqwgOPQvyiddysHbiWz8NiM74oxwfz991wHWVL
         CoJvqxpHfzeoSNaark5K3GF4CjjWslwDZFevnZajfkECzQD3I0wRxedkSDSg1T/Q6d
         ltkSnWeooqA/SFN/0I9AASBZXN4ceADUJMBYeZNwyAKvrSaQggksSxWwTaXPwR3+2W
         S4BgYv/lHaZmj2GS3AUNMfs73unOK17BBTO9olHf3yS6xpStGXXUQIGdZwwcBx2X6R
         EP2h9cDWaBihg==
Received: by mail-il1-f175.google.com with SMTP id w1so12624762ilm.12;
        Mon, 22 Feb 2021 17:19:36 -0800 (PST)
X-Gm-Message-State: AOAM5326zJmHu3SPqC/g+BFV5ECVmlwRMUE9IrYTDOkkFrDcW20ZyAef
        aRSWQcXgWQnGv1aNK+P0lfLW3lIAJ4TMaZb+Tac=
X-Google-Smtp-Source: ABdhPJy1rIUzQUUQ0ucyrRK0DtcwPjSCTwvfva5k8GmFoPBHZ+QXxbPjB8QhY4S41TtpiCAHzfbOOE8UYmpRldumaME=
X-Received: by 2002:a92:8e0c:: with SMTP id c12mr17745423ild.35.1614043175772;
 Mon, 22 Feb 2021 17:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-5-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-5-lukas.bulwahn@gmail.com>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 23 Feb 2021 09:19:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6VHA3jsFt-9GjXt4zc3v8TcW3q-j6xyF4VwR3Sv7zRZA@mail.gmail.com>
Message-ID: <CAAhV-H6VHA3jsFt-9GjXt4zc3v8TcW3q-j6xyF4VwR3Sv7zRZA@mail.gmail.com>
Subject: Re: [PATCH 4/5] arch: mips: remove dead references
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
> The domain lookup for linux-mips.org fails for quite some time now.
> Further, the two links:
>
>   http://decstation.unix-ag.org/
>   http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/
>
> refer to old webpages or contain no further technical information.
>
> Remove all those dead references.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/Kconfig             |  8 +-------
>  arch/mips/jazz/Kconfig        | 12 +++---------
>  tools/include/nolibc/nolibc.h |  3 +--
>  3 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index d89efba3d8a4..8cb1e2be5999 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -375,9 +375,7 @@ config MACH_DECSTATION
>         select SYS_SUPPORTS_1024HZ
>         select MIPS_L1_CACHE_SHIFT_4
>         help
> -         This enables support for DEC's MIPS based workstations.  For details
> -         see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
> -         DECstation porting pages on <http://decstation.unix-ag.org/>.
> +         This enables support for DEC's MIPS based workstations.
>
>           If you have one of the following DECstation Models you definitely
>           want to choose R4xx0 for the CPU Type:
> @@ -3263,10 +3261,6 @@ config TC
>           processors.  TURBOchannel programming specifications are available
>           at:
>           <ftp://ftp.hp.com/pub/alphaserver/archive/triadd/>
> -         and:
> -         <http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/>
> -         Linux driver support status is documented at:
> -         <http://www.linux-mips.org/wiki/DECstation>
>
>  config MMU
>         bool
> diff --git a/arch/mips/jazz/Kconfig b/arch/mips/jazz/Kconfig
> index 42932ca98db9..162d11670c75 100644
> --- a/arch/mips/jazz/Kconfig
> +++ b/arch/mips/jazz/Kconfig
> @@ -5,9 +5,7 @@ config ACER_PICA_61
>         select DMA_NONCOHERENT
>         help
>           This is a machine with a R4400 133/150 MHz CPU. To compile a Linux
> -         kernel that runs on these, say Y here. For details about Linux on
> -         the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
> -         <http://www.linux-mips.org/>.
> +         kernel that runs on these, say Y here.
>
>  config MIPS_MAGNUM_4000
>         bool "Support for MIPS Magnum 4000"
> @@ -16,9 +14,7 @@ config MIPS_MAGNUM_4000
>         select SYS_SUPPORTS_BIG_ENDIAN
>         help
>           This is a machine with a R4000 100 MHz CPU. To compile a Linux
> -         kernel that runs on these, say Y here. For details about Linux on
> -         the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
> -         <http://www.linux-mips.org/>.
> +         kernel that runs on these, say Y here.
>
>  config OLIVETTI_M700
>         bool "Support for Olivetti M700-10"
> @@ -26,6 +22,4 @@ config OLIVETTI_M700
>         select DMA_NONCOHERENT
>         help
>           This is a machine with a R4000 100 MHz CPU. To compile a Linux
> -         kernel that runs on these, say Y here. For details about Linux on
> -         the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
> -         <http://www.linux-mips.org/>.
> +         kernel that runs on these, say Y here.
> diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
> index 8b7a9830dd22..754e64c4a1d1 100644
> --- a/tools/include/nolibc/nolibc.h
> +++ b/tools/include/nolibc/nolibc.h
> @@ -1027,8 +1027,7 @@ struct sys_stat_struct {
>   *   - arguments are in a0, a1, a2, a3, then the stack. The caller needs to
>   *     leave some room in the stack for the callee to save a0..a3 if needed.
>   *   - Many registers are clobbered, in fact only a0..a2 and s0..s8 are
> - *     preserved. See: https://www.linux-mips.org/wiki/Syscall as well as
> - *     scall32-o32.S in the kernel sources.
> + *     preserved. See: scall32-o32.S in the kernel sources.
>   *   - the system call is performed by calling "syscall"
>   *   - syscall return comes in v0, and register a3 needs to be checked to know
>   *     if an error occured, in which case errno is in v0.
> --
> 2.17.1
>

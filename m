Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD777322815
	for <lists+linux-edac@lfdr.de>; Tue, 23 Feb 2021 10:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhBWJva (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 23 Feb 2021 04:51:30 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:39588 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhBWJtZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 23 Feb 2021 04:49:25 -0500
Received: by mail-oi1-f172.google.com with SMTP id z126so1359707oiz.6;
        Tue, 23 Feb 2021 01:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UAweoN6eUtAsuvPXmS5XNF8LZggD1kVsY6H4x3efuu4=;
        b=fZv1OMHHRl3grwGBdFtw7n2yDshUqcSE3T7zO1kDi6miwEczZ0eL2xHqkQYHDuLaC5
         beevs9VyGB/rSkkxPrWtyCh0KmqRSpxQNHq+La9y14UMQiILoJGU7ZbbQnWdpO4V/DSs
         iGL/fzvXoGbP//YhdD9keRvfEolu42cJHHwduks9m39fHaRdneL+rvSs9Ql9tBv1aBxn
         dPmMae/ZnER4Wedws77aDEVNxT6X3az451BuLs/0DaVbaYh8OmSX9X/Ku6r8IiPBDEOt
         iYNXCa8ojAcjC7ZTlWYpA4qeP2WRib/GyXCV+J0zIy6Gzd7cm639X0tVuVf2s33h7OuZ
         RG8g==
X-Gm-Message-State: AOAM5330OadTDp5Iq0X3e+RrplJOkt0sR4DpmOwdVUqrIYdSHWyXw4S3
        xK2390J0d/Qs8Wb3WF69mp47fbMOvJRmIeJLV/M=
X-Google-Smtp-Source: ABdhPJwU9GCzduzw7dt7nUQZfXrlBnfCpmG43OLUcL8UJ9UtQa8drjZtHc3yDw24+LDKbQIv0j4WKI6HX5iVRNJlMmQ=
X-Received: by 2002:aca:5e84:: with SMTP id s126mr18807216oib.175.1614073717156;
 Tue, 23 Feb 2021 01:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com> <20210222161905.1153-3-lukas.bulwahn@gmail.com>
In-Reply-To: <20210222161905.1153-3-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date:   Tue, 23 Feb 2021 10:48:26 +0100
Message-ID: <CAAdtpL4egZYCGS+2K5FQSFYcPKomosuvvrunpDskkiif5Ma5Uw@mail.gmail.com>
Subject: Re: [PATCH 2/5] MAINTAINERS: remove linux-mips.org references
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Feb 22, 2021 at 5:22 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
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

Why not use the web archive? The information is still valuable.
https://web.archive.org/web/20190704000315/https://www.linux-mips.org/wiki/DECstation

>  F:     arch/mips/dec/
>  F:     arch/mips/include/asm/dec/
>  F:     arch/mips/include/asm/mach-dec/
...

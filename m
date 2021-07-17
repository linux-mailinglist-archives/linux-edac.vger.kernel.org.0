Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552EC3CC1A2
	for <lists+linux-edac@lfdr.de>; Sat, 17 Jul 2021 09:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhGQHGO (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 17 Jul 2021 03:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbhGQHGN (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 17 Jul 2021 03:06:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1DC06175F;
        Sat, 17 Jul 2021 00:03:17 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i18so18509640yba.13;
        Sat, 17 Jul 2021 00:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbroIoc7LDtT2txrNFS/xQy0xFSErdRqfHllOcQwfc0=;
        b=veDKEL0V1E9DYQKQwEiDEO8pT6hoq0f2y/gkCJ9RRHfNh2Bn89LaQUxOpvKIU0KNmX
         iKy2eTMA8MC5117W/aPOjZb+j593/l67cyg1Be12DWoYffLn70hZUegYZ4yOcNewzlYk
         DOUv8X2izPqpmX7Fp/51mAtv3F6/dTP6ZHVNH1bGQkkHIYM49Iqqh5j0u5Kv6DLmtuyh
         ANTfnh9d20Sh6ojb6vTbN8+7GBLspqIj9MGehH8jVmp+dM77Bo5gCxirTGc917L+BGvP
         nFJFEJfAJCouiQkfv9pcPedicDawz4bDZD+gRTC39I0CNVOth+YUw6j5ZfvJ6qZc5xtT
         sJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbroIoc7LDtT2txrNFS/xQy0xFSErdRqfHllOcQwfc0=;
        b=tyws3OktXhM/ItjAGZpe5I3E+s0dMIFufFFRI88RcQBPaz8f+icsH8SPPlwk/m/ysK
         f3mQhaGPetaRswalKzdnlAyyFQTy57k7eOrfesUcVdCE3PDYS6CHI8Hio7X23t0C7DZS
         KATviw6nszWWgPyLbbaPG6YHbAPccTBLOgaWa/sOF3WHzaof6FmhlSJmB60AsJko83LF
         Vso0x9CLd4EfiK8/ZvWqLKbz2ZUUWOAhLA98VIPRs1ihzXRXoAV/J0tQYdzg7WdZMhZY
         7t8q1oL3V3QlaPiB2w6oMabOSeQnsqs87kbpOC3qkYpKXkKvpE6WS7tvbU3lvPQSm6Q3
         67Kw==
X-Gm-Message-State: AOAM531WpuXtdWDcU8ZIh+OA/sIOZthdp0K4YvTx6mjVWvMcefa85zNr
        ALY7wxS8wHyArkTOfce0frwg5BGGIfp/e7L8fIo=
X-Google-Smtp-Source: ABdhPJxwybjMmQrU+IM/ucdw+ZVNb6wGCViKshplkSCt/ZkghNPRfSWREa6iuYeAEeQXiwkC453s3dPhNc6x8a3NwJk=
X-Received: by 2002:a25:8b86:: with SMTP id j6mr16900370ybl.470.1626505396299;
 Sat, 17 Jul 2021 00:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com> <20210625110419.24503-2-lukas.bulwahn@gmail.com>
In-Reply-To: <20210625110419.24503-2-lukas.bulwahn@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Sat, 17 Jul 2021 09:03:05 +0200
Message-ID: <CAKXUXMxFBaBneVZf3WCCYJ8Theu55Nf-gFe=hs5u3mMVd41mTw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] MAINTAINERS: mark sections from Ralf Baechle orphan
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jun 25, 2021 at 1:04 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> The domain lookup for linux-mips.org fails for quite some time now. Hence,
> webpages, the patchwork instance and Ralf Baechle's email there is not
> reachable anymore.
>

There has not been any specific comment on marking kernel parts solely
"maintained" by Ralf Baechle as Orphan.

So, given the feedback on this overall patch set from Maciej and Kurt:
- the domain lookup for linux-mips.org does resolve again.
- the patchwork instance moved.
- Ralf Baechle's email now does at least forward somewhere.

However, it still holds that:

Ralf Baechle has not been active since February 2018; so, set all
MAINTAINERS sections with Ralf as sole maintainer to Orphan, and give
others a chance to claim maintainership if these sections are still of
interest.

I suggest that independent of the other patches in this patch set, I
rework the commit message of this patch here (basically dropping the
first sentence) and send out a final patch for this subject that
Thomas can then pick.

Any comments or rejections to that suggestion?

Lukas

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3d657e1fe359..eb9110c756f7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3094,9 +3094,8 @@ F:        Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
>  F:     drivers/iio/adc/hx711.c
>
>  AX.25 NETWORK LAYER
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  W:     http://www.linux-ax25.org/
>  F:     include/net/ax25.h
>  F:     include/uapi/linux/ax25.h
> @@ -6575,10 +6574,9 @@ S:       Maintained
>  F:     drivers/edac/highbank*
>
>  EDAC-CAVIUM OCTEON
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-edac@vger.kernel.org
>  L:     linux-mips@vger.kernel.org
> -S:     Supported
> +S:     Orphan
>  F:     drivers/edac/octeon_edac*
>
>  EDAC-CAVIUM THUNDERX
> @@ -9654,9 +9652,8 @@ F:        Documentation/devicetree/bindings/iio/gyroscope/invensense,mpu3050.yaml
>  F:     drivers/iio/gyro/mpu3050*
>
>  IOC3 ETHERNET DRIVER
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-mips@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  F:     drivers/net/ethernet/sgi/ioc3-eth.c
>
>  IOMAP FILESYSTEM LIBRARY
> @@ -12832,9 +12829,8 @@ F:      net/bridge/br_netfilter*.c
>  F:     net/netfilter/
>
>  NETROM NETWORK LAYER
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  W:     http://www.linux-ax25.org/
>  F:     include/net/netrom.h
>  F:     include/uapi/linux/netrom.h
> @@ -16007,9 +16003,8 @@ F:      include/linux/mfd/rohm-generic.h
>  F:     include/linux/mfd/rohm-shared.h
>
>  ROSE NETWORK LAYER
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  W:     http://www.linux-ax25.org/
>  F:     include/net/rose.h
>  F:     include/uapi/linux/rose.h
> --
> 2.17.1
>

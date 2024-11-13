Return-Path: <linux-edac+bounces-2523-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0669C6C66
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 11:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6706EB20433
	for <lists+linux-edac@lfdr.de>; Wed, 13 Nov 2024 10:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294501FB892;
	Wed, 13 Nov 2024 10:05:46 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB411F9A8E;
	Wed, 13 Nov 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492346; cv=none; b=ByuJsB6HDrzwPSRdpMN0EaBciD7hccDKFN1W6qxwlO2x7SWlkx4ti5GWsWUgApF+BmFZlxXPpovb12yM7rr/7ShhRswZUQVhgUme0WMzG+w8gwm5Rx3+3r6eoCqThzyhqsDUXZnhUHUvKcuU82Bzw2jAfI6Ke+fFprRmG9ttFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492346; c=relaxed/simple;
	bh=hfBrQJvC8AN+nHLouReIxHBNH9WwzWBzRRgrwIvPnik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u5WWYU0I/ZB1PBioUmoiqTYvNWRpHVkpuVgqOx7U+irqx0K/iEAt+dW4PHwXnMydpwJ83PxTiTnClLH2QYCgyBn7ngqs/MI/wB56QINmRRvB+BBU4AuWnbF7xP3OZVoqGEkSYrBJv9Jp6QDshF4ijj987AK8lU83DsxzmiONWYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6e9ba45d67fso62898787b3.1;
        Wed, 13 Nov 2024 02:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731492342; x=1732097142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+9Zu5f9a7YdmZdcq/cBwsvzywMKEtYbFdDVk0n7J6R0=;
        b=sqw0pQePt1c1EvB1tI5lfHauQcVjpp/fA+yF589+PfLTarWwjhF7wdHwcMV0dQ3TNo
         BFvgJi9etdQSCFU6yopzSPxp3AvEhLz5YWTwYb+TS9PPQ7wWdFh+TSMbPhymEL5VmGUE
         v6AM0EEBx6KXcauXC2IbeX4ybUIiaLg/jAsMJQTMYI+KpbRPuh3K0/T8vXbc/pd9GOdF
         eW+Np+ybyN6Hy7tyz+xzMVjCEsgze2ONrInZaJcD6bu6AqW2nHwzMf9DMh1X5xvOXNVE
         fhuJSqfAXYIic6vNqmFvpo56O4ElY0J5AxuTQ96j/Sn1Bg1AeT4RBtykZV4DSPLJ1B8o
         RM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUx0pAjYL6hzGwRTRZWo6Ui1GADCEUTCcSjFxCHnaV2ZylxwKlQZlau4/B9v1mmWS6q4Umc8D9PdHzg6w==@vger.kernel.org, AJvYcCVu+/CRxdIMwqbLrnC+no1jdTovUKc8MYawfhyft1Ngz9mdZDZpaR2OKHmjFJnmduc7a0pnNA/johtV@vger.kernel.org, AJvYcCXkJ9vEsyMPNlyfzFXwfBsYImxQlK9EiVdRl3SxJfuk7kBJwobk9+6rYj6k1TpYJK47BFpkxRk7dawddoSs@vger.kernel.org, AJvYcCXmevQIpoNicSZV3C89UOUE70MM28pWE+pmmHNpkExM5elAXPHWaGe492N1v6tGyNQ6YaXmfaz0lOw+CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTMiE9mpa4jG/7fewoS5vMQ0DxP6HdubxbTf1PM4d4rF663yXN
	qTxT4A4MqIF6nkccikU2iCq2lYeOfSANPvxD0csmVyyu+Pf01zFBTphvUIay
X-Google-Smtp-Source: AGHT+IEPYu69YGquKTx5EWTomsi+CORpAQ0x0W2MqSTPmmoPsANt62hyEupadhcsRaGMcGb3GtwauQ==
X-Received: by 2002:a05:690c:243:b0:6ec:b194:efe7 with SMTP id 00721157ae682-6ecb194f106mr26014977b3.30.1731492342039;
        Wed, 13 Nov 2024 02:05:42 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eaceb7a6fdsm30793577b3.103.2024.11.13.02.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 02:05:41 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6e9ba45d67fso62898637b3.1;
        Wed, 13 Nov 2024 02:05:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU+SiQvLzl4NW3tn2L0+1h8UVoj+vDwiF8sNvOIiVkJdI8R0Y9ZUFZn9u0aM8sVvwaen2z/uwREpjmEbjCQ@vger.kernel.org, AJvYcCUhfkF1zIZiXNd+sd4SMJJEW7BXCHqr/Ezi2PB2wAO11hSaHNZkFYXOybI510Q+1hy7CnDWqrMdw109/Q==@vger.kernel.org, AJvYcCUj824H4teq1n4uj+vTWA4c47KpawBnaSG3zL1BFn6ioWEAAqQ0GZGHtElNZywKYVs/mlNDxRUHI0of@vger.kernel.org, AJvYcCVcCqZSZoOUyiezOVZye1Yqf016YgkiEGxSBWd+GcWL+vdj3id8xlSzVIAGY1ldUzo8zbr3eqTT8jQKZQ==@vger.kernel.org
X-Received: by 2002:a05:690c:6ac3:b0:6e2:12e5:35a2 with SMTP id
 00721157ae682-6eca4643368mr59764137b3.4.1731492341087; Wed, 13 Nov 2024
 02:05:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.DEB.2.21.2411121327130.9262@angie.orcam.me.uk> <alpine.DEB.2.21.2411121342220.9262@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2411121342220.9262@angie.orcam.me.uk>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Nov 2024 11:05:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdViAoHPnWUK3tvwP8VdPwHxfHjZY63zaVhCSWqk=SMkWw@mail.gmail.com>
Message-ID: <CAMuHMdViAoHPnWUK3tvwP8VdPwHxfHjZY63zaVhCSWqk=SMkWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] MAINTAINERS: Retire Ralf Baechle
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-edac@vger.kernel.org, 
	linux-hams@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ralf Baechle <ralf.baechle@gmail.com>, ralf@gnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maciej,

CC Ralf

On Tue, Nov 12, 2024 at 2:47=E2=80=AFPM Maciej W. Rozycki <macro@orcam.me.u=
k> wrote:
> Ralf Baechle has been inactive for years now and the linux-mips.org site
> has gone down.  No replacement contact information is available.  Thomas
> has been kind enough to step up as a maintainer for EDAC-CAVIUM OCTEON
> and IOC3 ETHERNET DRIVER.
>
> Update MAINTAINERS, CREDITS, and .get_maintainer.ignore accordingly.
>
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thanks for your patch, which is now commit 495cc28f8e6b5396
("MAINTAINERS: Retire Ralf Baechle") in next-20241113.

> Index: linux-macro/.get_maintainer.ignore
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/.get_maintainer.ignore
> +++ linux-macro/.get_maintainer.ignore
> @@ -3,3 +3,4 @@ Alan Cox <root@hraefn.swansea.linux.org.
>  Christoph Hellwig <hch@lst.de>
>  Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>  Marc Gonzalez <marc.w.gonzalez@free.fr>
> +Ralf Baechle <ralf@linux-mips.org>
> Index: linux-macro/CREDITS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/CREDITS
> +++ linux-macro/CREDITS
> @@ -185,6 +185,11 @@ P: 1024/AF7B30C1 CF 97 C2 CC 6D AE A7 FE

Actually there is another contact address above, out of context...

>  D: Linux/MIPS port
>  D: Linux/68k hacker
>  D: AX25 maintainer
> +D: EDAC-CAVIUM OCTEON maintainer
> +D: IOC3 ETHERNET DRIVER maintainer
> +D: NETROM NETWORK LAYER maintainer
> +D: ROSE NETWORK LAYER maintainer
> +D: TURBOCHANNEL SUBSYSTEM maintainer
>  S: Hauptstrasse 19
>  S: 79837 St. Blasien
>  S: Germany
> Index: linux-macro/MAINTAINERS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-macro.orig/MAINTAINERS
> +++ linux-macro/MAINTAINERS
> @@ -8061,10 +8061,10 @@ S:      Maintained
>  F:     drivers/edac/highbank*
>
>  EDAC-CAVIUM OCTEON
> -M:     Ralf Baechle <ralf@linux-mips.org>
> +M:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>  L:     linux-edac@vger.kernel.org
>  L:     linux-mips@vger.kernel.org
> -S:     Supported
> +S:     Maintained
>  F:     drivers/edac/octeon_edac*
>
>  EDAC-CAVIUM THUNDERX
> @@ -11885,7 +11885,7 @@ F:      Documentation/devicetree/bindings/iio
>  F:     drivers/iio/gyro/mpu3050*
>
>  IOC3 ETHERNET DRIVER
> -M:     Ralf Baechle <ralf@linux-mips.org>
> +M:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>  L:     linux-mips@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/sgi/ioc3-eth.c
> @@ -15993,9 +15993,8 @@ F:      net/netfilter/
>  F:     tools/testing/selftests/net/netfilter/
>
>  NETROM NETWORK LAYER
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  W:     https://linux-ax25.in-berlin.de
>  F:     include/net/netrom.h
>  F:     include/uapi/linux/netrom.h
> @@ -20035,9 +20034,8 @@ F:      include/linux/mfd/rohm-generic.h
>  F:     include/linux/mfd/rohm-shared.h
>
>  ROSE NETWORK LAYER
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> -S:     Maintained
> +S:     Orphan
>  W:     https://linux-ax25.in-berlin.de
>  F:     include/net/rose.h
>  F:     include/uapi/linux/rose.h
> @@ -23555,7 +23553,6 @@ F:      drivers/net/tun.c
>
>  TURBOCHANNEL SUBSYSTEM
>  M:     "Maciej W. Rozycki" <macro@orcam.me.uk>
> -M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-mips@vger.kernel.org
>  S:     Maintained
>  Q:     http://patchwork.linux-mips.org/project/linux-mips/list/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


Return-Path: <linux-edac+bounces-5287-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDD3C299DA
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 00:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947E93AD74E
	for <lists+linux-edac@lfdr.de>; Sun,  2 Nov 2025 23:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EED0254B09;
	Sun,  2 Nov 2025 23:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="veGqDOkc"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519CF253B64
	for <linux-edac@vger.kernel.org>; Sun,  2 Nov 2025 23:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762125306; cv=none; b=Yg8z8AxLlUgE6EPZnT8J7Xkk/PCIs31gWFByHyee4QAH3Tzq3EFOTeQZT5VtaOV+rYM4b8FYyWKN7WuVDhEbJdOSWw1tY1zgnG/BQL2vBBvOYMukZmVX51OFbn1viQVPhKHVAaL6/ftpwn55qG9+SpRxXAhYybQRH4Rt7WTd5d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762125306; c=relaxed/simple;
	bh=gJ+z+fSwzGRoLTASac48Xt/red+jojCgmvvYT9GdSRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pikhI/q1RX9mtyndULHBzgd+0MTYVUpPbYXMR0KMr3/0XsdYPObzclad+KgkqHEtLBKwuyEkLHC0mZQOF8bdcH9JTNtryJHt6LYatOExYlGQJeTA7dFa7AQFETz7Y+madehktcepLmHCAiRynUK4nUwx+5d9q+rwBdMRF+QX7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=veGqDOkc; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-37a38e56dd5so1498381fa.0
        for <linux-edac@vger.kernel.org>; Sun, 02 Nov 2025 15:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762125301; x=1762730101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
        b=veGqDOkc2KbhhYjsZ6lnbXmmedGeZoZMglsu3m9z2Ag0Z0bdrOYId3GZuEWhYWx0wI
         QEl0Q9LXRGXaHhR55y8x6ETnqRedFkOF1K1RR49+BaYHgSdEqcTfNCnEhQt7o6Je59Cf
         KVvfDY/Kk/QDbmSmB9l2fTmu3WGrWtGh5AOzwj9esPRfhpfNIkiz3MlTjJg+M+N/ndpa
         geV2axmVI2rxVLB6HmhRYF8WTJ7KIFl1p7BcApKDg8NPbtSvw53jfFdBap4gPtbQ0+Hb
         QYdytI+Gj6ya4I1KUy/71GBHTtwcAGNq9roNc6o/vDW32qf0M8U5G9RKh2EfePP2Cxni
         qfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762125301; x=1762730101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhefXJf25nlZX433BsR2ypBCZ8ChrLrkfTMoigu+ucU=;
        b=fSKb/HU7/po27viX2rQU0Umd0yRFZJyPly3vI64MnFfgjELEjVwGOL624oc1T7sW3n
         TCjy0zqLQJCBXqL/mF8n2eCpIF2NIk1Zu55F6ZZ/z0f7vdVdZQG0U8hvGRw1u/gMbPEH
         m0W8aCxSbka4+/YiiYc+XVj6Is47zhJRBih0YQ/+UH7NJHKxsRHocOdm64s3kxbsyzGF
         0yXMd1mSFkS1dnhBmafIijS28WaI4KNvcanCykSVsoh74qrkb+gqRtrtiYe/GMeiONoz
         62PUDYx9/MKDUsgjFKZ4AcM81fovNSEZ5/ZWy0kLkoBwsrhqD5oHA6o/NJ26qAtoZi1e
         bpkw==
X-Forwarded-Encrypted: i=1; AJvYcCVkimwQfuR2tZf3mIvJdJC3RPdQ9XNVYjMsjwk9s8+UZHt9oZvhfdU7CvvRLxlAmecXusrKrQ4dWESA@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTM3C6SIuKhM38aaW1/1HQwMvX0WylIwMjM4WdwXrnNLohuQo
	9gkh0LuVrdxTOFheU6JqdaJG3jhIpUXwVtSZ00u+bH3TEMKu8wrf2Izf1yiYgRkSNmwgXoGczfK
	syc5v6tzZvdUat5+m02vlVxoSGMd7TuVEWrZUOJUCcA==
X-Gm-Gg: ASbGncvdyCyu/6Ums8A9iFpbY4VxUp1iGvC1A+Raoufm+vFPnMyW4K+9dbJK3KHdZIb
	tymuBwiFEaTEYMNvIYwm91/3OdJrXcMj66EQ9Tt6WP0+CaHeUa9fUjF6rP6wGsU9CZnQmuBgLCk
	3tHL+2QC+TDqgLv+cRErk+xiQkFRNH69DFxDbpJa6dEse8dXH7wPHT5xajVercZkD8WjsyGtAkM
	MkJ+Xq5vymfcbnnOAMqdaNJCDzKJsxDulF6a0GEt1Bwj35VbmTyDseCOyyucE35SaZiu5CbfzdL
	F9djhg==
X-Google-Smtp-Source: AGHT+IHNOSftU4LA4kaZ2zit5fbsUjeer+Cqtnxd6HV9vMAwCSf0ZxvdazFj8kc8iFBA+Oyhy9hRt9pMH+krWfgjY8s=
X-Received: by 2002:a05:6512:1453:20b0:594:2646:2350 with SMTP id
 2adb3069b0e04-594264628f8mr1107502e87.21.1762125301355; Sun, 02 Nov 2025
 15:15:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
In-Reply-To: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 3 Nov 2025 00:14:50 +0100
X-Gm-Features: AWmQ_bkG07aYa3yfLgn8mo--U0KGtThYfcOHYFtKUjSupbZy0y5m0bQWTypUrbs
Message-ID: <CACRpkdbR+5jh+OqYAU4vyUP-aQSjgMG3RRBkUTWnWz=VEy2Oew@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 3:59=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> >
> > > Prepare for the advent of globally available common field_get() and
> > > field_prep() macros by undefining the symbols before defining local
> > > variants.  This prevents redefinition warnings from the C preprocesso=
r
> > > when introducing the common macros later.
> > >
> > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Do you want me to just merge this patch to the pinctrl tree or do
> > you have other plans?
>
> My plan (cfr. cover letter) was to take it myself, as this is a hard
> dependency for 11/23.

OK go ahead:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see there are other review comments, I trust you will fix them up
and merge the result nicely.

Yours,
Linus Walleij


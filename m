Return-Path: <linux-edac+bounces-5403-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB7C3C761
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 17:35:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18764189F3C2
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 16:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0473502A6;
	Thu,  6 Nov 2025 16:25:52 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1334CFD1
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762446352; cv=none; b=jeQiShFaD3jBxPcFL7oZxiT0Gm/UbMH9ZneiqALyc/LOS8MJ631SvmbOXNtFnGgRffvgBMd+ySlJL0iMZcB93hk4shAlWaSKWS0ytoMe97Upcky2HuGby1UM6tVgk3dR3jFlbN9VH309vqM7xVBJrxBbsVdqvn0kKA6V8t7ARQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762446352; c=relaxed/simple;
	bh=3N1qJZ6LWFBTfpoRaZzcBCl8k2fr4s1S594WsHSwxm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8su6KID/qT2nhxBNHk/9YMMhWoevqrQvg7ztz0QkvJjOs5YtT8Xe7rqZDFieHywDWxP+/wUcHM2x4NhKCt/YuLOrfUthPC+J1VbR3OqkI3Jhmm9KsVVBea3DDoWSq9X/kibW/L3UDV4J5iu/rJdp+9GC1tXdqCtpRGYPGw0ji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592ff1d80feso1192171e87.2
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 08:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762446348; x=1763051148;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=plp2F71zo3wke225yJ4Ea1I1OPDOMxgAH1RlngZdvGo=;
        b=E/Ck2lciPe5F4fbzygNBpfU/566zaYlzbPljVuN2viOaUNmm5yblPXoNNhiQ/XFKuC
         BNIxVHI5eqFim9N3uarsMbz5+HHmRymSExs/0VZ3jiv9AY2JNrgsPoVFgiHmsk7Aw+4T
         ZmF8GeDVmDwtmiMBWv0uYRZ1/XmTWY607TiWgGtig6eYnIv1Yr3QTiwUgJ2S43PF2UMS
         52b4kpwHrbp0BFLOyWE136wxHFp8r2d4ms0FRDvDnEMOq7UR3ms4WzU2gndiLdiykzv8
         1MPXHC8uUxOvax1EqscvibpndPWe8Ud7Q2PqikHceoAljLUpCVXlsxbRVSNCW8XcpPOH
         1d2A==
X-Forwarded-Encrypted: i=1; AJvYcCXb623o2SXfjzq0bK7wYbv9jk3lbY4o1qtL9hzhqig7SFhswNpovDWFL3Q7jxFWNA/YBjFIX4gmP3rz@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkCXZIsWNEIORPms7/mX9/JgUOBpBgTSGrvokxBuzWFG/4ZSl
	dRZZdsUO1GSAWa0IjHq30J/MDAKMgPwoTVaQyOXrcnMauKPlNV3e/T2EgvPByxWSpjU=
X-Gm-Gg: ASbGncve4p6DuctMhSSZ/XJIxJAtDtACxii4Xln90lQuf56op7efif4HWtA8k3hoAhP
	osIBZ5+WqNiJ6a4bCu6m53tBbaeSru0MH2CdsbNtwE3pAp6hzrjTlrcxXXI5zqFpT9PY3ThazzA
	oNd8iLXMGCFdpGlvvLQUriZ2lNzIfOuKkY4wZ0Tdy7OiT+9ws6uv6yKLrLe6+4j8ok641Kdk/Dn
	RuiL76AzWqtZ0tA5/XeK2XV37aHZoAGzM58mFu1eOeHjRWCKFJOll+Vkef8E/IhTFvCbT9v8oSx
	Qu3wfeAIfRzQCUezpAk4xvTjo7gvwWUjo+KL+nNLFyUCMHQvev0QvCkroctKTHkbLm0Erlz4RK7
	Xg3jFY/cgY2rjgIKt/84MLGt3PI1PKvSPQu6spemNI/NVWCoi8oncb9KdgS+Uvke9L23Szkbc6Q
	He0vzcNoOjkNqPLLR4+oAb2LDeiFj4DQ0Dk8pFRg==
X-Google-Smtp-Source: AGHT+IFwI3O8bNwIJ25QyrVB6aiuVpOJMhHLcKqgy0qTPq2Npoa9rn5WHtqgPBugMoK9rFAhDGAqOw==
X-Received: by 2002:a05:6512:141c:b0:594:4ff1:52df with SMTP id 2adb3069b0e04-5944ff155c6mr866669e87.5.1762446347743;
        Thu, 06 Nov 2025 08:25:47 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a1b231fsm830212e87.74.2025.11.06.08.25.47
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 08:25:47 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5943b62c47dso1167585e87.1
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 08:25:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUqYbYuNIUCvi5TKu63zDscZ/V56TKTeUpNvTT6Sk6sV5is0xusU8Tw7gvNvsYpOAqjALGlu0g27Mcj@vger.kernel.org
X-Received: by 2002:a05:6402:3590:b0:640:fa38:7e4a with SMTP id
 4fb4d7f45d1cf-6410588d45bmr7763851a12.8.1762446022573; Thu, 06 Nov 2025
 08:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com>
In-Reply-To: <aQzIIqNnTY41giH_@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 17:20:09 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
X-Gm-Features: AWmQ_blD_P8L06tcYy5Zd39ODOkLvksucIxy1SkcdgHAnKwygGve4Lbclr5ZO9k
Message-ID: <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Ping-Ke Shih <pkshih@realtek.com>, linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > > > (long) long" _mask types.  For constant masks, that condition is usually
> > > > met, as GENMASK() yields an UL value.  The few places where the
> > > > constant mask is stored in an intermediate variable were fixed by
> > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > >
> > > > However, for non-constant masks, smaller unsigned types should be valid,
> > > > too, but currently lead to "result of comparison of constant
> > > > 18446744073709551615 with expression of type ... is always
> > > > false"-warnings with clang and W=1.
> > > >
> > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > > > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > > > used in the fully non-const variants later.

> > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > > > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > > > +                      pfx "type of reg too small for mask")
> > >
> > > Perhaps we may convert this (and others?) to static_assert():s at some point?
> >
> > Nick tried that before, without success:
> > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com
>
> Ah, this is unfortunate.

Of course, it might be an actual bug in the i915 driver...

The extra checking in field_prep() in case the compiler can
determine that the mask is a constant already found a possible bug
in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():

    rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);

drivers/net/wireless/realtek/rtw89/reg.h:

    #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
    #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)

so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
this operation...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


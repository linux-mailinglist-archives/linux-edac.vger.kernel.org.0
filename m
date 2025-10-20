Return-Path: <linux-edac+bounces-5128-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B1DBF11DF
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB3334F3F16
	for <lists+linux-edac@lfdr.de>; Mon, 20 Oct 2025 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F54304967;
	Mon, 20 Oct 2025 12:19:58 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A32303A27
	for <linux-edac@vger.kernel.org>; Mon, 20 Oct 2025 12:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962798; cv=none; b=BxIoYDIn+26y3wLMUveWC+VQK2KfUeOyUjz4qatoUM83w7UXdixzMp8kZrQiMCIyYoms6UW6LXMQH3mVFHPVgsK4uiC3k8vTRt+HW1Tr6Lg4bX7BzsoR69l2Wi40ExWZshFd6SRgbJn61BtHaZ1eAopnVbNuwk5Nl7Gt5qyUnM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962798; c=relaxed/simple;
	bh=zQJyABbFIFRgraIjRfB4Kv0edNHngRx2HTU3PnrqMSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRPP8LMHmmJ1bAO9P651NoItiCL4gW2N4/g871dtcs7566ZZHv1cOlcoKVkfkDkhXLbr1VwnO2QGcr6vN8w8VbxdO3pcWgXAEYg9z5I5Z1PH50umWOcXSXfbJ7yYGSYfcMEnofYA+2JThoW3p6uu0iaD2ZFzn7eHYDC4X4BHDCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso25345425ab.2
        for <linux-edac@vger.kernel.org>; Mon, 20 Oct 2025 05:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760962796; x=1761567596;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pomt2ITXhIHlFit8dq3w5svz3PMdwi8h98cx9ZzxHC0=;
        b=gG65oHguXh3NUmu3/PepysUsnzzLIXWgz5rnzXvjZoUxdKwkyjId8fWsrcQanO8D5f
         kldDaCF3R1aMoMOOo5Rlzv6+us5UC6PIULi9/A+/FyWaDU1LuV6yUEpBMCitYf9lk5kV
         CDvjgFEws5zeZkxjSJSrEBM5ckq6GDFbnbtJ1V7tAZFd21di2K/S3ZR/nMWtkRI9Jn39
         naqRMuD5wEZDSxVxRM39p4mtUndYYZeNvqmUXvvWL6Re3ci59I5j/Ah5XVDdOXqjUOwL
         bOZr67Xnt+hsXPclbVI/2XZdE97whPVq1ea07LO3+mCEf7jZWCE63gyAwKDQ2x+yAcJj
         ghJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjoQ0RT6oXesPkKG5hH7m1ORDVsEUIkXSEotdLwL7JcvnojbGmMxkQYdaRibNIRAAZAVBXk+PaK4cT@vger.kernel.org
X-Gm-Message-State: AOJu0YwCg5IqY7lBBe0whrmxuYel0ybgBKksVi5YZrw5BOM/6oW6OxBA
	YXB0FzoSR29hMTDd/ybVdsM2GU5nKz1kjzqMuJgh7nmJDbK3hlmiVASX8x7tght0
X-Gm-Gg: ASbGncsGrRb+00dOobnP7qV6tL7GKJLEM4WVVLLMERaBpZc3L4dmQM4Yk+W0y1c2fx9
	odHqXsGx4MpsPdeUpNXbfJwcSJMnT+fBUg0Z4u4JOcQWgVjd3L9/CCk/Ul319rZYlroaXT5I/gw
	j9nkNRz6sL++8HHwaoimuM2NPM4mytu8scdU38JHvSfi3lFmkQoVFLr9PsUWl3ee5DGzEvHr6NG
	sWpd54brVFHI6RXT78G0gE22RrmXWc/NLT0Y7Y3Sr8kUJqYRyA+KCI749bSNg7S1gjAtHUKuEWC
	w5sUdCAf4J9qbMC/A8CFKkripHBnim6rm3bX9jvGVxxDKpPaSnsZFbwhmw4tm1KZ9nDZfRn4j8Z
	HmnPaxCf8tT+O3ZaIMeIYHqZZHJNJmbxL2iHB9dzrcT17UDEgUcq9EW8wGnV3f01iWZ6nw6I4Ta
	goDeqzjoIgHIwH77Lu8HQCRkyotsGaSPb4mEQZaQzyJzeSB1Y9
X-Google-Smtp-Source: AGHT+IGWpoXWTEaqHUmfwLME5aktyqUaqT9dZQwFbyWW0zXHHDvcOrM4OS8SHcXyn0S8FWl6M2ffIQ==
X-Received: by 2002:a05:6e02:158b:b0:42b:2a51:f50a with SMTP id e9e14a558f8ab-430c532bf2dmr197481075ab.31.1760962795537;
        Mon, 20 Oct 2025 05:19:55 -0700 (PDT)
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com. [209.85.166.51])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-430d070a509sm29412455ab.11.2025.10.20.05.19.54
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 05:19:54 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-93e7e87c21bso290397939f.3
        for <linux-edac@vger.kernel.org>; Mon, 20 Oct 2025 05:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5xBpZl0Q7dRg+vGwgb8Pl30dFaT1iw1aTCVK474QQ7CvkGjq6dPIV2tmFqN7m9SYOCmCbGJ1//k+6@vger.kernel.org
X-Received: by 2002:a05:6102:50a2:b0:5d5:f6ae:38ca with SMTP id
 ada2fe7eead31-5d7dd6f4c27mr3609494137.41.1760962417639; Mon, 20 Oct 2025
 05:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760696560.git.geert+renesas@glider.be> <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
 <aPJwtZSMgZLDzxH8@yury>
In-Reply-To: <aPJwtZSMgZLDzxH8@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Oct 2025 14:13:26 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
X-Gm-Features: AS18NWDS1vbUG4-z_--VlQ3gjSspwjijy0fs8EPqX7O88cWCZQUNQKHTmAYei1k
Message-ID: <CAMuHMdXCoqZmSqRAfujib=2fk0Ob1FiPYWBj8vMXfuXNoKhfVg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
To: Yury Norov <yury.norov@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
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
	Jianping Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, 
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

On Fri, 17 Oct 2025 at 18:37, Yury Norov <yury.norov@gmail.com> wrote:
> On Fri, Oct 17, 2025 at 12:54:09PM +0200, Geert Uytterhoeven wrote:
> > There is no need to prefix macro parameters with underscores.
> > Remove the underscores.
> >
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v4:
> >   - Update recently introduced FIELD_MODIFY() macro,

> > --- a/include/linux/bitfield.h
> > +++ b/include/linux/bitfield.h
> > @@ -60,68 +60,68 @@
> >
> >  #define __bf_cast_unsigned(type, x)  ((__unsigned_scalar_typeof(type))(x))
> >
> > -#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                    \
> > +#define __BF_FIELD_CHECK(mask, reg, val, pfx)                                \
> >       ({                                                              \
> > -             BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
> > -                              _pfx "mask is not constant");          \
> > -             BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
> > -             BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
> > -                              ~((_mask) >> __bf_shf(_mask)) &        \
> > -                                     (0 + (_val)) : 0,               \
> > -                              _pfx "value too large for the field"); \
> > -             BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
> > -                              __bf_cast_unsigned(_reg, ~0ull),       \
> > -                              _pfx "type of reg too small for mask"); \
> > -             __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
> > -                                           (1ULL << __bf_shf(_mask))); \
> > +             BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),           \
> > +                              pfx "mask is not constant");           \
> > +             BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");      \
> > +             BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?            \
> > +                              ~((mask) >> __bf_shf(mask)) &  \
> > +                                     (0 + (val)) : 0,                \
> > +                              pfx "value too large for the field"); \
> > +             BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >       \
> > +                              __bf_cast_unsigned(reg, ~0ull),        \
> > +                              pfx "type of reg too small for mask"); \
> > +             __BUILD_BUG_ON_NOT_POWER_OF_2((mask) +                  \
> > +                                           (1ULL << __bf_shf(mask))); \
> >       })
>
> I agree that underscored parameters are excessive. But fixing them has
> a side effect of wiping the history, which is a bad thing.
>
> I would prefer to save a history over following a rule that seemingly
> is not written down. Let's keep this untouched for now, and if there
> will be a need to move the code, we can drop underscores as well.

Fair enough.
So I assume you are fine with not having underscored parameters in
new code, like in [PATCH v4 2/4]?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


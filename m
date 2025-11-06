Return-Path: <linux-edac+bounces-5395-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B90C3BF17
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 16:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC25542199A
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 14:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CDA3446A2;
	Thu,  6 Nov 2025 14:57:42 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C5E19D07E
	for <linux-edac@vger.kernel.org>; Thu,  6 Nov 2025 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762441062; cv=none; b=A/OeOi+vJ5Zfo4wTzmRjGKFZeUFll5UIuQh8GRMCCew/6wCUK7FxXk7tA1IZo68W4zMTR7nmhb/fXtNgE7LlcpBW3B/VmxWYQFd4JfgYvUyar3TmyV6wgLzylSPZrXI4vX9Tp61VfRfuc9SAdV9oupkKYMs16sdRIGqPoamq+Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762441062; c=relaxed/simple;
	bh=HaefBq/9gx/xpe6H9SR+jXE6I2U49/Bi4dkyZMOckp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XUNGNUEXQCUHyxmL+Lxk1kvvdiGEGe3BG1gH53QV1t5eIKdQAmrMdLan01kBrZkkSg2fsS1tFq778BT7nLuf7SBfnqzSOMuxsfgJP0104QOFCziA6awbd2UTm+3PEYNGQbIXmN6paycXVFe3RVERK36dairn6bpZNjuK1cGjRPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5943d1d6471so1064115e87.0
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 06:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762441058; x=1763045858;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZxZVtMOHoNocoyXPFvfejRTHivuCeFc8a9lYqiVNw1Y=;
        b=wkhOzhNjkSHxGd92NoH9fB1EGl6W3puJAPzLee6Xy2yZyis0k7XXVwi8NdVqiyTVWJ
         XMUtvt0dWp9yA7vhFSRs0lb4W4lkko8fZWZobiSLi6puhkw7tD/vTzWPtlDdqMqM7bDG
         mNjzHc5cuX69Q8RH40dCEKQVr+gjpdSwO6LdGDGod4wX3m4rUeTMsX84GYoESjFvLv1T
         GPsA0InBwmjR/KlIS2bg7G2zPm/G45lpymG0vkra0qD3rZHhHb/vxlN9WkkXGjdBkG1u
         s/Vn8sGdCBRInuQWaChdZ2KX0ewXHnhby4xRKsJqI4dmB7Gy7BTkzkrCkTaQ00yJYD/c
         I7vA==
X-Forwarded-Encrypted: i=1; AJvYcCXztxLxpZWvN/GwWA3Y5ReOodyiuqyiRiQavDFpxzYmhLGZSeVByxm4WJr16M/JO+NK14XX+Uyx4mkq@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhiWQivbjYJrOLVlvi4XSRfqqlRwDNwoEki0WvJgQjHk6pSOm
	X3dlmjZrETAJbZ0uDBBiY6jkyQeYbh8D/IACcuypBgeK3P/nfBY8YP3BBDwDsCK20s8=
X-Gm-Gg: ASbGncs31rIRUl3IqG+0EbT4NkjSiasYnz4ZNg4NJca8jQHEO2rsNsOZP0x2W1lHdFC
	j5UeR/sQ9yCBGslb2OfCQTB87TynHqiUDSCby63CF017fkTFuI0U9CnQaeKIO3HO9HPSntxgPXq
	128xOn0+oz7GISArbdGt01m62dNbyUYfJQdP9grj2EvJ6b2/CRyeFb9sq4dB15w7jIJ2dKZMFJK
	1H0KuTT7mAB1Kovnfyhm2EyJS+Cc+HptqKDzbLFPHG4/aguXcnfHQ49r7LvxBpfdw0NdTf/rhw6
	HC53FgaE1ZSlEEPA9bC4h03BUH1oxltDi336MPP5h29/zNhT4yIRh8jrkaM36abRQkI3wzX1hS9
	Hc9OnRsnKjtsQAhs5Pc+iim+yYWj7oA/59AjWrTRBNGmbD0LMJeIJy9IPE+WswwdYcAZG1tAcPr
	nuEzI0RGwMpZhXtBRFYqZY6aSHpvjNYEnRXXs5uQ==
X-Google-Smtp-Source: AGHT+IG/p2W/cPKX85tHTnbNodK6CxkhJd8FrQoaZvnzKnHV5Um0UHgDFlYpPL/OHiUmorMSZCceeA==
X-Received: by 2002:a05:6512:398d:b0:592:f2fc:51f0 with SMTP id 2adb3069b0e04-5943d7c09bfmr2566701e87.30.1762441057816;
        Thu, 06 Nov 2025 06:57:37 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a03459bsm776635e87.48.2025.11.06.06.57.34
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 06:57:35 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59431cce798so1168864e87.1
        for <linux-edac@vger.kernel.org>; Thu, 06 Nov 2025 06:57:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVZ+cjU/aF3/v9/N2vEh1vOJM8t2jnFSkyEqqaxQGILP+ysk0XpVLQuNcO8k3OEMC7Lm61NYis1R3z6@vger.kernel.org
X-Received: by 2002:a05:6402:1ed5:b0:640:b643:f3c5 with SMTP id
 4fb4d7f45d1cf-641058cf323mr7301623a12.16.1762440555932; Thu, 06 Nov 2025
 06:49:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
In-Reply-To: <aQy0T2vUINze_6_q@smile.fi.intel.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 6 Nov 2025 15:49:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
X-Gm-Features: AWmQ_bnZOzLGAFcWzxKh1EIKjH4MNs7moeVCtN8xGb6mN65nYBliBYrABdUBf0M
Message-ID: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
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
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andy,

On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
> On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > (long) long" _mask types.  For constant masks, that condition is usually
> > met, as GENMASK() yields an UL value.  The few places where the
> > constant mask is stored in an intermediate variable were fixed by
> > changing the variable type to u64 (see e.g. [1] and [2]).
> >
> > However, for non-constant masks, smaller unsigned types should be valid,
> > too, but currently lead to "result of comparison of constant
> > 18446744073709551615 with expression of type ... is always
> > false"-warnings with clang and W=1.
> >
> > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > used in the fully non-const variants later.
> >
> > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> >     HWM_FIELD_PREP()")
> > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> >     warnings from clang")
>
> Also can be made as
>
> Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]

Nooooh... torvalds might click on it, and complain ;-)

> > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > +                      pfx "type of reg too small for mask")
>
> Perhaps we may convert this (and others?) to static_assert():s at some point?

Nick tried that before, without success:
https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


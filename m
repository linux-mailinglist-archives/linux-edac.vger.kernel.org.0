Return-Path: <linux-edac+bounces-5152-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 409EDBFB513
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 12:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7BD05024BD
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BD3195E9;
	Wed, 22 Oct 2025 10:08:23 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663F32FF660
	for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 10:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127703; cv=none; b=AJf/oGiNeu1anWiZNM49edP23x87M+FRP9q65PAVxu0VDun0pdXV0BkH4LXSwbJ7lCenT7Jm/GMva+bkyow8/PyLqevY6pmgB9gbnKeT1AP2Lf+KAUbvY0ET6arP9/95C4Wn7s8HeGNO7XQb74D7qqwYkV3Q7HMZhRLazR6iNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127703; c=relaxed/simple;
	bh=n8auG5eKlZyr31ot6Kp1D+Gj8aLD/n7p+Qqeh5TWnJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W4eem4l0ahBnyDiVl7lnyxoiCnT3KfU40qRBUIEz+TPciHdPWVUdmGbN8MC+WnM/HgO9di2JWo/Na5yOP4U1yhAIK8NNy+B/IWZYoexmEqgDvW55SQsBFmf+ytAO4J2UYGbHlKkSWSCAMl2+T20S1w0Wls01p8wNTNtAgBBSfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-85a4ceb4c3dso879375985a.3
        for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 03:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127700; x=1761732500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rEJ/AcXuMMrQoXRwb6HmCfF3LFX3cn+TJWCKJF/dV3w=;
        b=ovKBqedgdX18CSYWQ6nTE23bTqIrlyJqjhq8z3lC2m7tUZ1TmzEzz+T/h5S97DAGr4
         wZ2mau/LvURRnDHMwGLqLYqev5bfuJl+gGXFsm6bZg99lxVYO0OCUGUe5kTvvL/vE+7F
         s9tReM/Y7jXxCioYiS4q+/ws4xCBMxzisZxG7Alc8fzeOluO+/uSXNCWs+s31Aqa0Q6V
         ny7ODOfh2OWuIh2y78RyEamMcF+5Qn3XFocIV6FT5aawrDMwhDWfkaAF7vTF0NUcTyKs
         KmgDrSnnde8dkqm8X0qqJJK1sEJdm+cAd4XYuBNumrmkUA8Lt5mrMHluUuONVOkoxn/t
         iiGw==
X-Forwarded-Encrypted: i=1; AJvYcCXd+YotiPw8G57hcSRdhTHQkNk1JI30A2uCKn68+krGtVc8vVAlaFYiJfPmP5mP2qM+zV6ewaXuld49@vger.kernel.org
X-Gm-Message-State: AOJu0YyFF2JiXSwfToIHuU4g0Cmx9SZOrHS8TyP4ox8OaK3fbY8e47bD
	AlfORjAFDyVwp4rm0whDH3caGw+jm1HhzVeLGbDi6Q5cAN28gksQirU9NcP5OKwR
X-Gm-Gg: ASbGncvEfk3JcjKhpyCdZ8r3k01Qb6GzNpfQXFp+RTxNkbd5QnceyJCieNEQjmgazc4
	KkVmcp1GV3nPT7GR66tI6VH7Sq23qJMSLZWEYJKQPdlUS3oSftQXrxRC+QaRQYYzbD+9YmwrPCo
	u7EmVVv2ACburrrdUn53tjFbVuN+GC74QVKtnBK8ltBvJ3Lcy3/t9IJT0bVR9s0LDiwn5fYTO46
	h33tGOp7X90WeJfvzetrGL+m78A9GSHG2G4/y5Hab5Fb+wLX+fW7WjtR9f4EZ95JQ1suy/GwTWv
	JLS/x0z6xuL73z21682t1bF/CZT3r36+ar2KlywTozT0W1rOEeLoQpY2f4JTnJhdqBWZFgyCwbB
	Bi1H5JncBcY/Sa4Sw8ZfpHSsD8a6CeOiObH1rW8SUkoXcB8VCuuEvbjBuxYpVIueAqnfWyp0/Er
	A3ARyOMS2DP++U7YdMF0ZjtHP0t6noevfel6golZAUl7SenMHZ4lFa
X-Google-Smtp-Source: AGHT+IE75SLZWKaJhyw8uZ8DkG0LmuoOTFdUmZ68+NWdtokeOK6GTG8A5pN3j1UlZjwMbCYHCD+YzQ==
X-Received: by 2002:a05:6214:1249:b0:82d:f77f:28c3 with SMTP id 6a1803df08f44-87c2076889dmr251642636d6.30.1761127699928;
        Wed, 22 Oct 2025 03:08:19 -0700 (PDT)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com. [209.85.222.171])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d01efa7e0sm86267396d6.36.2025.10.22.03.08.19
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 03:08:19 -0700 (PDT)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-88fa5974432so880091285a.2
        for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 03:08:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXO2dRUp8TXacsi0ZaxNsNmWXXqjbMAFN1jkwVuIyT8p9a6pgSmYt8MBWQaRxgrMautDWUbCT+8AzGK@vger.kernel.org
X-Received: by 2002:a05:6102:3f49:b0:5d6:615:a687 with SMTP id
 ada2fe7eead31-5d7dd5544d6mr5930459137.7.1761127308820; Wed, 22 Oct 2025
 03:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760696560.git.geert+renesas@glider.be> <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury> <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
 <aPhbhQEWAel4aD9t@yury>
In-Reply-To: <aPhbhQEWAel4aD9t@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 22 Oct 2025 12:01:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
X-Gm-Features: AS18NWAJp5tYw_pRqlFhPyJqRT3wi5ZG4jspqrcr0Xp9hgyi6lbaoTACOgNkevQ
Message-ID: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}() helpers
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
	linux-kernel@vger.kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"

Hi Yury,

On Wed, 22 Oct 2025 at 06:20, Yury Norov <yury.norov@gmail.com> wrote:
> On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> > On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > > constants.  However, it is very common to prepare or extract bitfield
> > > > elements where the bitfield mask is not a compile-time constant.
> > > >
> > > > To avoid this limitation, the AT91 clock driver and several other
> > > > drivers already have their own non-const field_{prep,get}() macros.
> > > > Make them available for general use by consolidating them in
> > > > <linux/bitfield.h>, and improve them slightly:
> > > >   1. Avoid evaluating macro parameters more than once,
> > > >   2. Replace "ffs() - 1" by "__ffs()",
> > > >   3. Support 64-bit use on 32-bit architectures.
> > > >
> > > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > > macros, as people expressed the desire to keep stricter variants for
> > > > increased safety, or for performance critical paths.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Acked-by: Crt Mori <cmo@melexis.com>
> > > > ---
> > > > v4:
> > > >   - Add Acked-by,
> > > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > > >     power management debugfs helper APIs") in v6.17-rc1,
> > > >   - Convert more recently introduced upstream copies:
> > > >       - drivers/edac/ie31200_edac.c
> > > >       - drivers/iio/dac/ad3530r.c
> > >
> > > Can you split out the part that actually introduces the new API?
> >
> > Unfortunately not, as that would cause build warnings/failures due
> > to conflicting redefinitions.
> > That is a reason why I want to apply this patch ASAP: new copies show
> > up all the time.
>
> In a preparation patch, for each driver:
>
>  +#ifndef field_prep
>  #define field_prep() ...
>  +#endif
>
> Or simply
>
>  +#undef field_prep
>  #define field_prep() ...
>
> Then add the generic field_prep() in a separate patch. Then you can drop
> ifdefery in the drivers.
>
> Yeah, more patches, but the result is cleaner.

And we need 3 kernel releases, as the addition of the macros to
the header file now has a hard dependency on adding the #undefs?
Unless I still apply all of them to an immutable branch, but then what
is the point?

> > > > --- a/include/linux/bitfield.h
> > > > +++ b/include/linux/bitfield.h
> > > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > > >  #undef __MAKE_OP
> > > >  #undef ____MAKE_OP
> > > >
> > > > +/**
> > > > + * field_prep() - prepare a bitfield element
> > > > + * @mask: shifted mask defining the field's length and position
> > > > + * @val:  value to put in the field
> > > > + *
> > > > + * field_prep() masks and shifts up the value.  The result should be
> > > > + * combined with other fields of the bitfield using logical OR.
> > > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > > + */
> > > > +#define field_prep(mask, val)                                                \
> > > > +     ({                                                              \
> > > > +             __auto_type __mask = (mask);                            \
> > > > +             typeof(mask) __val = (val);                             \
> > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > > +             (__val << __shift) & __mask;    \
> > >
> > > __ffs(0) is undef. The corresponding comment in
> > > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > > against 0 first".
> >
> > An all zeroes mask is a bug in the code that calls field_{get,prep}().
>
> It's a bug in FIELD_GET() - for sure. Because it's enforced in
> __BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
> mention that in the comment.
>
> I'm not fully convinced that empty runtime mask should be a bug.

Getting (and using) data from nowhere is a bug.
Storing data where there is no space to store is also a bug.

I will add a comment.

> Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
> soon as the pointers are valid. If you _think_ it's a bug - please
> enforce it.

memcpy() with a fixed size of zero is probably a bug.
memcpy() with a variable size is usually used to copy "as much as is
needed", so zero is usually not a bug.

> > > I think mask = 0 is a sign of error here. Can you add a code catching
> > > it at compile time, and maybe at runtime too? Something like:
> > >
> > >  #define __field_prep(mask, val)
> > >  ({
> > >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> > >         (val << __shift) & mask;
> > >  })
> > >
> > >  #define field_prep(mask, val)
> > >  ({
> > >         unsigned int __shift;
> > >         __auto_type __mask = (mask), __ret = 0;
> > >         typeof(mask) __val = (val);
> > >
> > >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> >
> > Futile, as code with a constant mask should use FIELD_PREP() instead.
>
> It's a weak argument. Sometimes compiler is smart enough to realize
> that something is a constant, while people won't. Sometimes code gets
> refactored. Sometimes people build complex expressions that should
> work both in run-time and compile time cases. Sometimes variables are
> compile- or run-time depending on config (nr_cpu_ids is an example).
>
> The field_prep() must handle const case just as good as capitalized
> version does.

OK, I will add the (build-time) check.

> > >         if (WARN_ON_ONCE(mask == 0))
> > >                 goto out;
> > >
> > >         __ret = __field_prep(__mask, __val);
> > >  out:
> > >         ret;
> > >  })
> >
> > Should we penalize all users (this is a macro, thus inlined everywhere)
> > to protect against something that is clearly a bug in the caller?
>
> No. But we can wrap it with a config:
>
>  #ifdef CONFIG_BITFIELD_HARDENING
>          if (WARN_ON_ONCE(mask == 0))
>                  goto out;
>  #endif

That can be done later, when hardening other bitfield functions
and macros.

> > These new macros are intended for the case where mask is not a constant.
> > So typically it is a variable of type u32 or u64.
>
> You never mentioned that. Anyways, it's again a weak argument.

I'll add more comments ;-)

> > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > >
> > > Can you use BITS_PER_TYPE() here?
> >
> > Yes, I could use BITS_PER_TYPE(unsigned long) here, to match the
> > parameter type of __ffs() (on 64-bit platforms, __ffs() can be used
> > unconditionally anyway), at the expense of making the line much longer
> > so it has to be split.  Is that worthwhile?
>
> Not sure I understand... The
>
>         "unsigned int __shift = BITS_PER_TYPE(mask) < 64 ?"
>
> is 49 chars long vs 42 in your version. Even if you add two tabs, it's
> still way below limits. And yes,

Oh, you meant instead of the size check.
I thought you objected to the hardcoded number 4.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


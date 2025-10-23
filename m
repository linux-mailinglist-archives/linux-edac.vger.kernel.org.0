Return-Path: <linux-edac+bounces-5162-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E1AC00CD5
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 13:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4CC11A61932
	for <lists+linux-edac@lfdr.de>; Thu, 23 Oct 2025 11:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118E330DD34;
	Thu, 23 Oct 2025 11:39:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763E27054C
	for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219551; cv=none; b=XxVTLRitrdtz5HYtGV52zw5Ze63VjONOYwNIbdsuslwCcCI2lrkbI2E8dqlQThO/1fbhu23eEF99V0RKaCiuRi19oA/IgNxDpPluXc86fBm55b8VQ3dXF9xniLvhm3UeXq5bTJO2hWuiUJqqJdSfZiaNQrK3gcqoO6QBRIHwICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219551; c=relaxed/simple;
	bh=t2b3ao92xy0ESrIeC6f3Ix11H+BajiEZp3Qjq0JyHMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObSNuIGAvcaV10quIPtw5F7CEQKXnVZPxDeNPlkvA/+nV2X0qTTPCSq3GsvqdRJp1fo4j7D0KdHtrBumQ3g03J5M55l5szTLC25WZp6abyyv1RvvqmoSEu/gFyt/lbrVHc67TfVLKFgrg1CB2dTAYc9tnJ7r2NLsBWODqxk/CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db37a935f1so77060137.1
        for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 04:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219548; x=1761824348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YGr3v7S6fzDOU9nQBXt6OSyvvunrcw7Wuu74VRCbNxc=;
        b=wmuwgElgku9G1ks11Zv46jDAQ9x35rRLIL0a2YG7Jv+pllXAZNFnSFRzUg3cJAcAIr
         RjCxdg8Z0Gb72umYZUa48whwUfe/H9Qj0ltqqkwSoyUC2iQ3HZy+xC4KdPGjBJqsugF3
         jofsvuVo4Ek/r08aE6iVbXkyOPJ8baug1uH0/dxS5spBTcPvSGzBgpUoFZpA4cdnpeZp
         oLLOkL7VvvcOMXpinMp2JH9ULQh9iA5D8knSrAHir8Iq5BopXmmThN0C/UK7BvdRtG9P
         1npLjGFM+M6bVlZYeXcaRor+G4dkeW0WYuwdLFwZD9WGORwk5x/XSPa9d65ROert0jgw
         qcZg==
X-Forwarded-Encrypted: i=1; AJvYcCWa6dbbZzCHFs8bjuERw9JT7Ev4UH+OOLHK5ojFn67KMVB0z2YtVCsZxveaRhUD36RA4QrFUeDmqKBQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzF0bOs2J1c5xEz/YtXp7t9Gxy7ak2BQ1055Qwir3T1gLWkb3JT
	7HRYasMQvlXeJhufHBm1txigfYXdBQiU8IrLP+/gaGMX/Ox8BeksNwh5FXClzroh
X-Gm-Gg: ASbGnctULmWhL0XUqQlTP0RRqx+mMT1mVYQmQu6TpznpS8i37s4rA1fqUNk7LSLLJ3p
	q1qisRHc525K3RNUrcj6M0NlOQ9NRroGKypUywjnfvZYv/vot/FdwsJmBXgFziGUtcP3h7kXCrS
	jXjbxw2P87bLAHnEAtwJ5Os3+8StKmQxkNchf2OLAy4/UEjdqpbj6QNKbV1+p0cB2NhqAx31fPq
	MQQzbGEHIyK9tzej38A0VtqwLL+r28JZnfqvtQ0jH2wI+9nZYXbOiJHjeJ+qZ3qpA4DkmSfQAWi
	d/376VZ6XFOr/Y4nSl3jegNbZFBESplUDrl+RwWavvboysYoLkZ1Ui4i6lSHwqeJoJrj95UoiE7
	VG3DvL/MFgnTPQQ45WpD3HkqCmY8fRGKz+EsbzvAPl19nfGmlfz1/XTs+nEKDRoQz8AtrODkerT
	iuyg9tHOpCrLc3KDH4ajUgRDN2A98T+JbkLEwNuU5AwYKLDfqY
X-Google-Smtp-Source: AGHT+IGrWyN0Zi3G9z23ZJpO7V7L6EdUOUKLSjqiEPLd2uoAX7P9z0gBTHQZhK8Ry8+PfEwKGgjHMA==
X-Received: by 2002:a05:6102:c09:b0:5db:3935:1636 with SMTP id ada2fe7eead31-5db393518f0mr40050137.26.1761219547888;
        Thu, 23 Oct 2025 04:39:07 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd8e11a3sm657196e0c.10.2025.10.23.04.39.06
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 04:39:06 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5db1aa8c93eso349144137.2
        for <linux-edac@vger.kernel.org>; Thu, 23 Oct 2025 04:39:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIhijNBQVwafWxLA9Y1+vKUh4Z6ERuzcHb01g4mW2NfxnGFqQE6Wol1da8IwX6Rbi+tvYxKCDlQg04@vger.kernel.org
X-Received: by 2002:a05:6102:c8b:b0:5db:350f:2c6b with SMTP id
 ada2fe7eead31-5db350f2f90mr173817137.38.1761219546544; Thu, 23 Oct 2025
 04:39:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1760696560.git.geert+renesas@glider.be> <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury> <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
 <aPhbhQEWAel4aD9t@yury> <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
 <aPj9Tu75OFenm7U0@yury>
In-Reply-To: <aPj9Tu75OFenm7U0@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 13:38:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0dmJ_bEkKBZkzqXwM9m-Agwr_zMhMDXgdS+LSyoeG5w@mail.gmail.com>
X-Gm-Features: AWmQ_bkfy7WIJP3UTtd6EyoPnmrw_M6kCYJ9kC1xrPr1U7jSNAuuLhNrJ5p1ts4
Message-ID: <CAMuHMdX0dmJ_bEkKBZkzqXwM9m-Agwr_zMhMDXgdS+LSyoeG5w@mail.gmail.com>
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

On Wed, 22 Oct 2025 at 17:50, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 22, 2025 at 12:01:37PM +0200, Geert Uytterhoeven wrote:
> > On Wed, 22 Oct 2025 at 06:20, Yury Norov <yury.norov@gmail.com> wrote:
> > > On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> > > > On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > > > > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > > > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > > > > constants.  However, it is very common to prepare or extract bitfield
> > > > > > elements where the bitfield mask is not a compile-time constant.
> > > > > >
> > > > > > To avoid this limitation, the AT91 clock driver and several other
> > > > > > drivers already have their own non-const field_{prep,get}() macros.
> > > > > > Make them available for general use by consolidating them in
> > > > > > <linux/bitfield.h>, and improve them slightly:
> > > > > >   1. Avoid evaluating macro parameters more than once,
> > > > > >   2. Replace "ffs() - 1" by "__ffs()",
> > > > > >   3. Support 64-bit use on 32-bit architectures.
> > > > > >
> > > > > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > > > > macros, as people expressed the desire to keep stricter variants for
> > > > > > increased safety, or for performance critical paths.
> > > > > >
> > > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > Acked-by: Crt Mori <cmo@melexis.com>
> > > > > > ---
> > > > > > v4:
> > > > > >   - Add Acked-by,
> > > > > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > > > > >     power management debugfs helper APIs") in v6.17-rc1,
> > > > > >   - Convert more recently introduced upstream copies:
> > > > > >       - drivers/edac/ie31200_edac.c
> > > > > >       - drivers/iio/dac/ad3530r.c
> > > > >
> > > > > Can you split out the part that actually introduces the new API?
> > > >
> > > > Unfortunately not, as that would cause build warnings/failures due
> > > > to conflicting redefinitions.
> > > > That is a reason why I want to apply this patch ASAP: new copies show
> > > > up all the time.
> > >
> > > In a preparation patch, for each driver:
> > >
> > >  +#ifndef field_prep
> > >  #define field_prep() ...
> > >  +#endif
> > >
> > > Or simply
> > >
> > >  +#undef field_prep
> > >  #define field_prep() ...
> > >
> > > Then add the generic field_prep() in a separate patch. Then you can drop
> > > ifdefery in the drivers.
> > >
> > > Yeah, more patches, but the result is cleaner.
> >
> > And we need 3 kernel releases, as the addition of the macros to
> > the header file now has a hard dependency on adding the #undefs?
> > Unless I still apply all of them to an immutable branch, but then what
> > is the point?
>
> Not sure what do you mean. You can do it in a single series, and you
> don't need and should not split the series across releases. Consider
> my recent cpumask_next_wrap() rework as an example:
>
> https://lore.kernel.org/all/20250128164646.4009-1-yury.norov@gmail.com/
>
> 1. #1-4 switch kernel users to alternative functions;
> 2. #5 deprecates cpumask_next_wrap(), making sure it's a pure renaming,
>    i.e. no-op.
> 3. #6 introduces the new nice implementation. It's the core-only patch,
>    no drivers are touched.
> 4. #7-12 switch the rest of codebase from old version to new.
> 5. #13 drops deprecated old function.
>
> This is the most common scheme. In you case you can cut the corners.
>
> The goals here are:
>
>  - keep core patches free of non-core code;
>  - switch drivers to the new functionality one-by-one in sake of
>    bisectability.

OK, I'll make it so...

> > > > > > --- a/include/linux/bitfield.h
> > > > > > +++ b/include/linux/bitfield.h
> > > > > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > > > > >  #undef __MAKE_OP
> > > > > >  #undef ____MAKE_OP
> > > > > >
> > > > > > +/**
> > > > > > + * field_prep() - prepare a bitfield element
> > > > > > + * @mask: shifted mask defining the field's length and position
> > > > > > + * @val:  value to put in the field
> > > > > > + *
> > > > > > + * field_prep() masks and shifts up the value.  The result should be
> > > > > > + * combined with other fields of the bitfield using logical OR.
> > > > > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > > > > + */
> > > > > > +#define field_prep(mask, val)                                                \
> > > > > > +     ({                                                              \
> > > > > > +             __auto_type __mask = (mask);                            \
> > > > > > +             typeof(mask) __val = (val);                             \
> > > > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > > > > +             (__val << __shift) & __mask;    \
> > > > >
> > > > > __ffs(0) is undef. The corresponding comment in
> > > > > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > > > > against 0 first".
> > > >
> > > > An all zeroes mask is a bug in the code that calls field_{get,prep}().
> > >
> > > It's a bug in FIELD_GET() - for sure. Because it's enforced in
> > > __BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
> > > mention that in the comment.
> > >
> > > I'm not fully convinced that empty runtime mask should be a bug.
> >
> > Getting (and using) data from nowhere is a bug.

^^^ This is about field_get().

> > Storing data where there is no space to store is also a bug.

^^^ This is about field_prep().

> > I will add a comment.
> >
> > > Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
> > > soon as the pointers are valid. If you _think_ it's a bug - please
> > > enforce it.
> >
> > memcpy() with a fixed size of zero is probably a bug.
> > memcpy() with a variable size is usually used to copy "as much as is
> > needed", so zero is usually not a bug.

^^^ These 3 lines are about memcpy().

> 5 lines above you say: "Getting (and using) data from nowhere is a bug".
> Now you're saying: "so zero is usually not a bug". So, is it a bug or
> not?

> > > > > I think mask = 0 is a sign of error here. Can you add a code catching
> > > > > it at compile time, and maybe at runtime too? Something like:
> > > > >
> > > > >  #define __field_prep(mask, val)
> > > > >  ({
> > > > >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> > > > >         (val << __shift) & mask;
> > > > >  })
> > > > >
> > > > >  #define field_prep(mask, val)
> > > > >  ({
> > > > >         unsigned int __shift;
> > > > >         __auto_type __mask = (mask), __ret = 0;
> > > > >         typeof(mask) __val = (val);
> > > > >
> > > > >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> > > >
> > > > Futile, as code with a constant mask should use FIELD_PREP() instead.
> > >
> > > It's a weak argument. Sometimes compiler is smart enough to realize
> > > that something is a constant, while people won't. Sometimes code gets
> > > refactored. Sometimes people build complex expressions that should
> > > work both in run-time and compile time cases. Sometimes variables are
> > > compile- or run-time depending on config (nr_cpu_ids is an example).
> > >
> > > The field_prep() must handle const case just as good as capitalized
> > > version does.
> >
> > OK, I will add the (build-time) check.
>
> If mask is compile-time, you can wire field_prep() to FIELD_PREP(), so
> it will do the work for you.

OK, I will look into it.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


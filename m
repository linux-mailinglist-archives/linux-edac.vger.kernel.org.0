Return-Path: <linux-edac+bounces-5156-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2E7BFCF70
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B06613A9FF6
	for <lists+linux-edac@lfdr.de>; Wed, 22 Oct 2025 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE4F24C692;
	Wed, 22 Oct 2025 15:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDDu7gNP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0512459F7
	for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148252; cv=none; b=Qsqn0glsIa9WxDYes4Mn6x9rWCx+oTiPl1g8p2U4jPjN3hvJMJI5LJoiwL2B6JOoQP/aYRd705d6b5U/4rod8Zc58lF0LOx1jNu8W9RReXadTA1CQ4z4rOTTEKSO+nF6ebmhnu97vKZQUvkApdubgmvvVFAGabOWGyuPKOkW83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148252; c=relaxed/simple;
	bh=QB4SfuURmF0iWUdw/nwKqx87mibMXzZNnU/tV+VTflc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7xYq4Wnem/PHlySqtVnPe4zr9V2lsi08nVEcqIwDCosNQ+o0GhZ7gUfobOrgmUx+99VJNwy9MbEuFRJAmql2fs5wmOnaTcp0z9t8OBg4jqPHlTVO2VzoHG818vi7lsGDTwgXZDsSY9lFwirqf80PI17uOLOEiphKTno/DJz/SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDDu7gNP; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-890cc9b6bbbso1037708185a.3
        for <linux-edac@vger.kernel.org>; Wed, 22 Oct 2025 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761148249; x=1761753049; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M3oPL/TT2sCXS1NwLSM7rbWcVKVCBogVovmIALCF75E=;
        b=PDDu7gNP+RCUzIQmZOQJK1qv35WyTpVYbtLZLmFSfywQDTG5R3T5gN41I7crHWRj2K
         b5VQS09X5/96bxNUOMrO6FjixFoSqkFBkS3Ouv8k9MR6zr3GxbH/6moBzM3yEYPgD3jM
         L4Q0xRTW6vh4ZfEIMEGVsqsk014lbD46/iUfRaUYt0vvuJHUXILq7NRkrnlsZLYCYre9
         a2hXNyjBpCzoIJ+Nxhfai7xYyEZMrGzcM3kQZ/inOcx0EcPYqg+4Bi3mTFtogn8/Qqch
         d8TFrDD11/JDwYgCmLgalmJB+MNlNKUbqqs0EzUk83DeDRFZUW61uSqjNo3UsEcspc+o
         t+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761148249; x=1761753049;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3oPL/TT2sCXS1NwLSM7rbWcVKVCBogVovmIALCF75E=;
        b=DHN79EVSHkOSUR7uu/mWD/j6Ly+7bBddHfvZ5iFBV4O27OYdIyqxAinEMfAuVeaJek
         EepqvvPE/jLrarkfqXKpkRe8c2SVo3dcJbT65I3e2wqNQzo5CmMqz3+JzLslWZEgDp28
         w5RODhNzGr6yLQq8aE3FkGmx6yN1v2kgIERoIx1t6hC4RtmDF2W3StdXRARB8uKMAe+h
         7W00r+9lf8n/NBvlZFB2sdp5ZT8rln9R39lQXFRhnmFuZR67LZF3jukLXvkNRy1NYDe2
         0CvX92F3Y0Lof97apwjbKu+VqC5pqUxbusoTzpbG2LiN6lZUFrAMQrcwOSRfPn7Nd6lh
         3j3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj30T+0Jbt5FCt4bzgPwyle2wYMBdz9QyJG0Ywoc2zAXo35HZAyqPM+mHi+lhnusiN0ahlXajJ9H9V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pDGC56OSDF0v+UGFCFXsgrQkCqVMoH948U7g3Un37qlVEaeC
	Oro2G4OD7/4/EToSpjUxv7xT1Ee750ryLFjzaknT8XW4UoQpSWS6zVOA
X-Gm-Gg: ASbGnctMOZUWx19/imE0cmESf+kGBMhaiZpjqLkMa3UmTWCNvqEKebfVAGQ6cnHae9A
	ZvEaLcDXq1SHYrVZdKc4tcOkDpptccYo9R9zt6M0ybnf0gGVaL+yGe+cRNE1I81KPY/NwaX8i2z
	+C/QKb141qJFfVGY4W7UrS90+5mtMkQY+YGh/L6YXGuuPfNhGjujhFJoQ/0Bc5qZUR7ssjj0udY
	FlgNMULqJmKBaHImEbiWK8uSa3+2ZnG25X0aFkEyleTqSwondeyNO05hW51ImucoYhUTo7zSy+j
	l6sH4cmzwEUG8JFx11Z1ATjNGtEPHvtooZHTbnh+OX3mO9OLLFHhGVvq3trljuA2V65Rc4qmbW9
	pWSuGJpeezYkwHB/3soNjt/bXAERt2iKbeG1ErPat+i9Y5lzYytDKp7dSg4jwzfwgf5U0TOWr8O
	fsw4PYvd4=
X-Google-Smtp-Source: AGHT+IFhU1/qxPcwG4iditd/DSbX/hwAr8IdRWU46wkqo60rCt6GN/oHrv/6ROXraOwUylmwPpHHaA==
X-Received: by 2002:a05:620a:1984:b0:84f:f3bb:e464 with SMTP id af79cd13be357-8906fd1953cmr2828961185a.50.1761148248418;
        Wed, 22 Oct 2025 08:50:48 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cd098328sm1000034585a.17.2025.10.22.08.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 08:50:47 -0700 (PDT)
Date: Wed, 22 Oct 2025 11:50:46 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/4] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aPj9Tu75OFenm7U0@yury>
References: <cover.1760696560.git.geert+renesas@glider.be>
 <67c1998f144b3a21399672c8e4d58d3884ae2b3c.1760696560.git.geert+renesas@glider.be>
 <aPKQMdyMO-vrb30X@yury>
 <CAMuHMdXq7xubX4a6SZWcC1HX+_TsKeQigDVQrWvA=js5bhaUiQ@mail.gmail.com>
 <aPhbhQEWAel4aD9t@yury>
 <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUOX=ToDU_44fHrqKWUtee1LKpgisfTKOe4R33er9g+DA@mail.gmail.com>

On Wed, Oct 22, 2025 at 12:01:37PM +0200, Geert Uytterhoeven wrote:
> Hi Yury,
> 
> On Wed, 22 Oct 2025 at 06:20, Yury Norov <yury.norov@gmail.com> wrote:
> > On Mon, Oct 20, 2025 at 03:00:24PM +0200, Geert Uytterhoeven wrote:
> > > On Fri, 17 Oct 2025 at 20:51, Yury Norov <yury.norov@gmail.com> wrote:
> > > > On Fri, Oct 17, 2025 at 12:54:10PM +0200, Geert Uytterhoeven wrote:
> > > > > The existing FIELD_{GET,PREP}() macros are limited to compile-time
> > > > > constants.  However, it is very common to prepare or extract bitfield
> > > > > elements where the bitfield mask is not a compile-time constant.
> > > > >
> > > > > To avoid this limitation, the AT91 clock driver and several other
> > > > > drivers already have their own non-const field_{prep,get}() macros.
> > > > > Make them available for general use by consolidating them in
> > > > > <linux/bitfield.h>, and improve them slightly:
> > > > >   1. Avoid evaluating macro parameters more than once,
> > > > >   2. Replace "ffs() - 1" by "__ffs()",
> > > > >   3. Support 64-bit use on 32-bit architectures.
> > > > >
> > > > > This is deliberately not merged into the existing FIELD_{GET,PREP}()
> > > > > macros, as people expressed the desire to keep stricter variants for
> > > > > increased safety, or for performance critical paths.
> > > > >
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > > > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > Acked-by: Crt Mori <cmo@melexis.com>
> > > > > ---
> > > > > v4:
> > > > >   - Add Acked-by,
> > > > >   - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
> > > > >     power management debugfs helper APIs") in v6.17-rc1,
> > > > >   - Convert more recently introduced upstream copies:
> > > > >       - drivers/edac/ie31200_edac.c
> > > > >       - drivers/iio/dac/ad3530r.c
> > > >
> > > > Can you split out the part that actually introduces the new API?
> > >
> > > Unfortunately not, as that would cause build warnings/failures due
> > > to conflicting redefinitions.
> > > That is a reason why I want to apply this patch ASAP: new copies show
> > > up all the time.
> >
> > In a preparation patch, for each driver:
> >
> >  +#ifndef field_prep
> >  #define field_prep() ...
> >  +#endif
> >
> > Or simply
> >
> >  +#undef field_prep
> >  #define field_prep() ...
> >
> > Then add the generic field_prep() in a separate patch. Then you can drop
> > ifdefery in the drivers.
> >
> > Yeah, more patches, but the result is cleaner.
> 
> And we need 3 kernel releases, as the addition of the macros to
> the header file now has a hard dependency on adding the #undefs?
> Unless I still apply all of them to an immutable branch, but then what
> is the point?

Not sure what do you mean. You can do it in a single series, and you
don't need and should not split the series across releases. Consider
my recent cpumask_next_wrap() rework as an example:

https://lore.kernel.org/all/20250128164646.4009-1-yury.norov@gmail.com/

1. #1-4 switch kernel users to alternative functions;
2. #5 deprecates cpumask_next_wrap(), making sure it's a pure renaming,
   i.e. no-op.
3. #6 introduces the new nice implementation. It's the core-only patch,
   no drivers are touched.
4. #7-12 switch the rest of codebase from old version to new.
5. #13 drops deprecated old function.

This is the most common scheme. In you case you can cut the corners.

The goals here are:

 - keep core patches free of non-core code;
 - switch drivers to the new functionality one-by-one in sake of
   bisectability.
 
> > > > > --- a/include/linux/bitfield.h
> > > > > +++ b/include/linux/bitfield.h
> > > > > @@ -220,4 +220,40 @@ __MAKE_OP(64)
> > > > >  #undef __MAKE_OP
> > > > >  #undef ____MAKE_OP
> > > > >
> > > > > +/**
> > > > > + * field_prep() - prepare a bitfield element
> > > > > + * @mask: shifted mask defining the field's length and position
> > > > > + * @val:  value to put in the field
> > > > > + *
> > > > > + * field_prep() masks and shifts up the value.  The result should be
> > > > > + * combined with other fields of the bitfield using logical OR.
> > > > > + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> > > > > + */
> > > > > +#define field_prep(mask, val)                                                \
> > > > > +     ({                                                              \
> > > > > +             __auto_type __mask = (mask);                            \
> > > > > +             typeof(mask) __val = (val);                             \
> > > > > +             unsigned int __shift = sizeof(mask) <= 4 ?              \
> > > > > +                                    __ffs(__mask) : __ffs64(__mask); \
> > > > > +             (__val << __shift) & __mask;    \
> > > >
> > > > __ffs(0) is undef. The corresponding comment in
> > > > include/asm-generic/bitops/__ffs.h explicitly says: "code should check
> > > > against 0 first".
> > >
> > > An all zeroes mask is a bug in the code that calls field_{get,prep}().
> >
> > It's a bug in FIELD_GET() - for sure. Because it's enforced in
> > __BF_FIELD_CHECK(). field_get() doesn't enforce it, doesn't even
> > mention that in the comment.
> >
> > I'm not fully convinced that empty runtime mask should be a bug.
> 
> Getting (and using) data from nowhere is a bug.
> Storing data where there is no space to store is also a bug.
> 
> I will add a comment.
> 
> > Consider memcpy(dst, src, 0). This is a no-op, but not a bug as
> > soon as the pointers are valid. If you _think_ it's a bug - please
> > enforce it.
> 
> memcpy() with a fixed size of zero is probably a bug.
> memcpy() with a variable size is usually used to copy "as much as is
> needed", so zero is usually not a bug.

5 lines above you say: "Getting (and using) data from nowhere is a bug".
Now you're saying: "so zero is usually not a bug". So, is it a bug or
not?

Consider this example:
        
        unsigned a = field_get(mask, get_user(ptr));

Conceptually it's the same as per-bit copy_from_user().

The copy_from_user 
1. allows size == 0;
2. does not dereference pointers in that case, i.e. doesn't call
   get_user().

Can we make sure that field_get() provides the same guarantees?
 
> > > > I think mask = 0 is a sign of error here. Can you add a code catching
> > > > it at compile time, and maybe at runtime too? Something like:
> > > >
> > > >  #define __field_prep(mask, val)
> > > >  ({
> > > >         unsigned __shift = sizeof(mask) <= 4 ? __ffs(mask) : __ffs64(mask);
> > > >         (val << __shift) & mask;
> > > >  })
> > > >
> > > >  #define field_prep(mask, val)
> > > >  ({
> > > >         unsigned int __shift;
> > > >         __auto_type __mask = (mask), __ret = 0;
> > > >         typeof(mask) __val = (val);
> > > >
> > > >         BUILD_BUG_ON_ZERO(const_true(mask == 0));
> > >
> > > Futile, as code with a constant mask should use FIELD_PREP() instead.
> >
> > It's a weak argument. Sometimes compiler is smart enough to realize
> > that something is a constant, while people won't. Sometimes code gets
> > refactored. Sometimes people build complex expressions that should
> > work both in run-time and compile time cases. Sometimes variables are
> > compile- or run-time depending on config (nr_cpu_ids is an example).
> >
> > The field_prep() must handle const case just as good as capitalized
> > version does.
> 
> OK, I will add the (build-time) check.

If mask is compile-time, you can wire field_prep() to FIELD_PREP(), so
it will do the work for you.
 
Thanks,
Yury


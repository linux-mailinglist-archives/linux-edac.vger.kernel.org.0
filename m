Return-Path: <linux-edac+bounces-5254-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EED9AC1B6C6
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 15:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7A435C0FE2
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF862C1585;
	Wed, 29 Oct 2025 14:40:14 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C672C11F4
	for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748814; cv=none; b=E0yGQ2E7onAzXHM7VvUSVYWp6p07WfhZqoNxi2pXspTeDXE4RG6WlCpDA72iBiiEOiVz2rbcHgyZTAl5mSnHIy0nvw5ds3AgSdwcziqM9L1ymF82/SSJtEbw3i3xrYY1ZMOkbcwrfJK9zKz+XEux7sKwhzt2o/5akzPAsFu8aws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748814; c=relaxed/simple;
	bh=FbqavNtq8VJC+dwAXLJIaCG9l+pt4WVO7NOuPi3OYaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i95oNpSBXpvT2SnEIqiF2SgwZ8LVkbhAs2Fkw/NENIlRf16CRMhB+mfsiiW7Sf2ZA0zieCq6OC3K1gnKZ069WSjvqaOVxjqva5UWtYq978P6anQw2abntMasJUGdWpjZWhpjlj1RSycw7kyV3HIeSRDMJD4kY1zwkPWPWj0QnlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f30dac856so84966206d6.2
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748812; x=1762353612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNDkhDDabcFgtYSzLRibzijDMaquJ035sDb5A+sIiAE=;
        b=jo2H3m2tw44rQvJlKYBGuZTkEsqR4D+b3RxeNNiISKUissODwiHSt9U9DMk7PXDgVQ
         bYn4yKmnd73+sba9nWg1+PUn6B+H4nWuA7daFYC623wpPf9M9N1XX2jIY0y/zxLLZF/L
         xNGUnz+KiC+bvHhMMfC6xoDb5NjlI8OXgKiXAWejL5RpQ5pWlJTPeLDou6pZs6sSQkY2
         RFwDI3PTQVvC6tg4zOn6j2yjXZFc8evpq1xTkRJEX9Fay6u8OaG75cfBCeSj6uSDpv80
         wB/XycxrZYCjyszX5IKx0q0WKD0syZF+CcmgNHk0UNlT3kGwKN+7ntIdVlxV/D4RH4Vl
         uuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXKbuO21rX0ptXW7PzQ41gUFeo7gknxY+p/vU0r6uPKWmWa+2LC2cJYBmBgq63w8rh2WTcdbty3Igw@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmb7qiiVvhMUyCYURID7O4ttKJmtmNwds4cKdPMbwu6OMRz1n
	jB9+WkC5Z9KZq8D0aLtZxfhwfZcRRMFIfskBbnHNy/ijupFt8d97eWRlvfbui9Pb
X-Gm-Gg: ASbGnctTz+XbNgrC8rjnc+ccjiZZUeXv9pjpEqVMAv3nKMtCLRfm1uQWqxRAsE1Z4Ps
	l8xnH3YqJ32J9VwuvebgKpEupCmFi8Hqt1kn3K2ScWnYu7Dk2fGwnkPNU5g0NsQwQw+C5Q+zrCy
	yTzVBGVSQ2qFBBB5dsFlSQQVLnd+dQh86EoLrBZoBl9FFXwOvXPU8KFKSKBA/U9M7KRHAO2rx0k
	DFTdHIvxcYX37gJD2pdLr/c8kuT+c8lqcXMqFvUsJEogcEmax1cHelUoOy5EpLVnTogB/taTxHO
	KTKzYuooqhO+DEarsvCxDLojhKxKsHlSkvIkB+SyATyCdZFdVOXPq6zMP5gYK2geZJ4otmqZTcQ
	lCeIlCMKlvdWMUYogrWRQmtV0egZhbAM5ZYsSwcTEUFXlHU6IpibkZlT3X1fOgL4dAmFcnBGLCI
	baUaCjKeNWeS19abBWxJ5o04Lp1kLK5cq+mz5p8txreAgfIqUX+JEvD0bs
X-Google-Smtp-Source: AGHT+IF4ZPqTlRW6VH0jk4xaceqFvYXP2Ke9+K9bPmIN1Wr+/d9Hjk+8lv/43ZLfyk79ErdEb48bNA==
X-Received: by 2002:a05:6214:2a4d:b0:70d:6de2:1b2e with SMTP id 6a1803df08f44-88009c0804cmr41104386d6.58.1761748811965;
        Wed, 29 Oct 2025 07:40:11 -0700 (PDT)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com. [209.85.222.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87fc49b649dsm101126316d6.53.2025.10.29.07.40.11
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:40:11 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8a84ba42abbso162383485a.3
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:40:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVdx4W9JKnoiSrlCNy+vJYgXWDE0GyCv7i0l0h/fbUL2Buq1smzgKQuSD2pu/qUqIh+lI+L7iUHRH1g@vger.kernel.org
X-Received: by 2002:a05:6102:26d3:b0:5d6:156f:fedb with SMTP id
 ada2fe7eead31-5db90694687mr933346137.36.1761748440676; Wed, 29 Oct 2025
 07:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com> <aQIlB8KLhVuSqQvt@yury>
In-Reply-To: <aQIlB8KLhVuSqQvt@yury>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:33:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
X-Gm-Features: AWmQ_blqiXGJheNiHtKi_cJSwq0gfFP8sAonrx_tsjN_f5pUMr0aiWqvAOsiPck
Message-ID: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Yury Norov <yury.norov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
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
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Wed, 29 Oct 2025 at 15:30, Yury Norov <yury.norov@gmail.com> wrote:
> On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> > On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
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
> There's a couple nits from Andy, and also a clang W=3D1 warning to
> address. So I think, v6 is needed.

Indeed....

> But overlall, the series is OK, and I'd like to take it in bitmaps
> branch as it's more related to bits rather than a particular
> subsystem.

OK, fine for me (if I can still get an immutable branch ;-)

Note that as of today there are two more to fix in next:
commit d21b4338159ff7d7 ("mtd: rawnand: sunxi: introduce ecc_mode_mask
in sunxi_nfc_caps") in next-20251029
commit 6fc2619af1eb6f59 ("mtd: rawnand: sunxi: rework pattern found
registers") in next-20251029

Thanks!

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


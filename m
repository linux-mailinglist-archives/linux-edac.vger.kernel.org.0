Return-Path: <linux-edac+bounces-5290-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9B3C2AFB5
	for <lists+linux-edac@lfdr.de>; Mon, 03 Nov 2025 11:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2204D344C0E
	for <lists+linux-edac@lfdr.de>; Mon,  3 Nov 2025 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232142FD1C2;
	Mon,  3 Nov 2025 10:17:53 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856292F28F0
	for <linux-edac@vger.kernel.org>; Mon,  3 Nov 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165073; cv=none; b=VRh4CYaK9dsET14f8mPaFKXmfxtY8LlYmqDuNl4CcwVJl0XSAahUpgGPWg85VEmRvWlTewHMQ6Gva50iD5b3p/y9RKx8gY6TSaSQnaAJoZRg7N9m6kx5U/afn2o+rC+RqowUhet+9k7pUazFkIi2vT16ebkMPguXZiVTjevhjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165073; c=relaxed/simple;
	bh=mTHQRbPtXcLW9RC24UimP00dT4bpQ240D8TduWco7Ms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nNZFWZzJiNkvWacUrOjzfnT6BSPJybYfVagCahAn3hZSEWGTIeehvkaj0yHtEFbRZjlzPEr6P/B2/vy4U9qTUg7opWpvPAZ2IE4zW1mY+r302sIUbPpdyiO0iOIR9Jen8wSQwQx8kHDv6HkgfhthzI79f8g620qjhaBlotQQ1Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29524c38f4fso35379115ad.2
        for <linux-edac@vger.kernel.org>; Mon, 03 Nov 2025 02:17:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762165070; x=1762769870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WN9rH9/69UaI2zM1r1sL3pcOf4U1LH9TZ13cniByZO0=;
        b=YYIkTdh4OsUnhdwXmZmyKQn8b/AyGKFsuft0VdjP6AhbX4ZKivDy2KCnPOD5ShHHig
         mmPz1BpVCVdgBlCK1aggil1PMQiDYBTykSe6tH7QoxGRfEogmQOQrSabM9fmTiHwC/HO
         B/9eAxEj43tXsc4hpqIO8tdODzg/Wlvn3gApmg7HLpuXdFUyP7lb31F6CTrCXiAUv7cz
         hTtBwK10F7fsAgeBt5pL5EsykaW64OXXtK4m43wqHx6A4n5o8bOJAfpdqHipavdcI1d2
         pBfimBl2HInyUuxd+uCPtYjSG1Dv3Uudes6ioU3UIBsVl03WlNV6z5sJ0JTtzKYmmYlp
         2uOA==
X-Forwarded-Encrypted: i=1; AJvYcCVJTGRt4QgN2P8PenBP87QpjSmhnKo1vl4B0M4kCKKzcWOnO1cQWrKRY/MAeovCLo5sOByVrX/f1cNk@vger.kernel.org
X-Gm-Message-State: AOJu0YwxVekzpIBmzyHGsyICUb5lOibBlWgxzJr7F/pe8o8cwDhvXMW3
	rAdQg8OAJheGG/1ZPFZK1gaM1/iDdDDZJkK5di5Wq8z4yUnj6A3ePSJVVZ1x0TmO
X-Gm-Gg: ASbGncs8vOGPu+q+LjYybChrjlkr6OAaPRt+1kpqzLD5pe4d9zeat+13q/V7Z5l5Gj7
	iCtxnRGc9syKxi4Z9pzWotO6lIiNbYqiLBAqLHyHkprMFOrNPoqNQo5jEvICu6WAskT+kKVSFoA
	T0t6dflpZYCdc0Wok6kVdexjsx9f9zpyXNW0UYmwDX8nzbTJoqPP73Or7hTGwd98QoBhWSXd/Dp
	C+f6Jur2PSyeGJF4SqHJA2m4mCX3VaqZpRwc5UtbxjK7qs++QeYu1KHIuMHVzWeDYsPMUBhVUHR
	s8tbwIGVmluulb1UO99QUl3VBEMDM7GX35jF7ZO6UGz14cWbNv+PT7SOD8jtQlCOh/seFY1pDhJ
	n6uiK6A35rh5D2MkSnsFf8xU6EZucH5/nkr/pG0mSc5nM2UWr1dVflqbp2k/lQypnwgS3TcSUqC
	p57q1JcQkM9KBZgfPbp29tt8AoltCXHlwEYvwfWx3KQtWuxrmsAVob5bcF
X-Google-Smtp-Source: AGHT+IFmuLdtYMKJ/9O+JO2ssJKkVBHG7SY1Rgz/AgabNKICOZ6vuE9Q8CWBTfm57dQ+M9XGPPjhrQ==
X-Received: by 2002:a17:903:24f:b0:295:24c3:8b49 with SMTP id d9443c01a7336-29524c38fcdmr146670175ad.46.1762165070425;
        Mon, 03 Nov 2025 02:17:50 -0800 (PST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com. [209.85.215.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2959e4e598csm43721525ad.36.2025.11.03.02.17.50
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:17:50 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b98a619f020so1354434a12.2
        for <linux-edac@vger.kernel.org>; Mon, 03 Nov 2025 02:17:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3lG+TfRG4cruPjcn73y5biPZt1GGfwpj6bW+WvbPZ8C6X43WeaEFkto5NacN/kaZAI54urlv2iuGo@vger.kernel.org
X-Received: by 2002:a05:6102:418d:b0:5db:f031:84ce with SMTP id
 ada2fe7eead31-5dbf031902dmr85155137.29.1762164587067; Mon, 03 Nov 2025
 02:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei>
In-Reply-To: <20251102104326.0f1db96a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 3 Nov 2025 11:09:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmxzzzgoIljXMDy5wJmHF15bg4ZKICGjY8c2_gWom3ME9XAPzMw0ghLXn4
Message-ID: <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
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

Hi Jonathan,

On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 27 Oct 2025 19:41:44 +0100
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> So this is going to make a mess of merging your series given this is
> queued up for next merge window.
>
> I can pick this one up perhaps and we loop back to the replacement of
> these in a future patch?  Or perhaps go instead with a rename
> of these two which is probably nicer in the intermediate state than
> undefs.

Renaming would mean a lot of churn.
Just picking up the #undef patch should be simple and safe? The
removal of the underf and redef can be done in the next cycle.
Thanks!

> > --- a/drivers/iio/imu/smi330/smi330_core.c
> > +++ b/drivers/iio/imu/smi330/smi330_core.c
> > @@ -68,7 +68,9 @@
> >  #define SMI330_SOFT_RESET_DELAY 2000
> >
> >  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> > +#undef field_get
> >  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> > +#undef field_prep
> >  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> >
> >  #define SMI330_ACCEL_CHANNEL(_axis) {                                        \

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


Return-Path: <linux-edac+bounces-5423-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E820AC45876
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 10:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5E3263467FD
	for <lists+linux-edac@lfdr.de>; Mon, 10 Nov 2025 09:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FBA2FD668;
	Mon, 10 Nov 2025 09:07:41 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9515A85A
	for <linux-edac@vger.kernel.org>; Mon, 10 Nov 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765661; cv=none; b=YPU669HHU0YTxYZPUrRPKkfCF707JpI9x5D7ySTSZZY67zrVNzXkK3T4y8Os3zAKcuwLulDLqMOYrbBMPQ0DdDkVN+RbneYOsI+IkVmO2NqPjgMpuRS+LiZRrUOPMyHbos7QLzklJwVckbrWDbCMOiBbEmS/coF1bUqUCKsFHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765661; c=relaxed/simple;
	bh=JRmjklDdMnXYPa/YzcCMj4xR0iBgS1Ed7pmHd076aaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2UJgT7w7gc5mbrGGUX0pUR20cPJ1qS+6/9uyPHeE39XKOuLNonqBZzfKgK7seKNhf8l3S1KxGYCinDA/Dr8Qc2LSITcL8CrQQi5DnBYxYHpMpA5sbKu6eLSAbi1+Q048KOBcT1rTnnqJmz518R9FRnUHpJ7O3LRAcOsQojiz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f67ba775aso3303732b3a.3
        for <linux-edac@vger.kernel.org>; Mon, 10 Nov 2025 01:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765659; x=1763370459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zuaR1c68u39/qbD5w07qCJ9IxeheIz5/8CL8hB/l6OE=;
        b=QhFzYiP9Z0mRZav9cRnxOvA5YzDgvudqHl9OvRTUxwDKenUqT6oNDFIJrO8HdhCyFD
         sFaphXzRGLOYpFv63le4KACpJv85erwMoU23CZuLcceIfFNZ5nXYvXP+OVWGmEPdniKb
         ef4P0upz22rQk3L5OOangxz2ZlYOUH8g4Q6sdyn9gRhD0ajcf7z9hljbrko+quL4zCSR
         dGMCxF7I0a/EdYbn6btvXn81MWG67nGsmfDzSUrZv6HPGtC7jl0x3Sj5iQARZ7stmFkX
         OrMJLWowfyQMh459AkV54Q2+yAIw+2NhcpihxV/magMnp7lp+YfnzFmsT++GY1cq3GSb
         Q9wA==
X-Forwarded-Encrypted: i=1; AJvYcCV74ZFsUHoZJeUIN3h3u1KEul5UxTHjnWh0Fvk3BlaRaeV+M045qlH3Mc+XegN3PB6HB5k90zxtXt4X@vger.kernel.org
X-Gm-Message-State: AOJu0YxLRi3ZRQxQGg4kxWRICo7/9pGY473Cw0l3l5u3JbkRMWAZYrau
	96iGNQIIfzO+7qgRtnDh4jWEwYpjSYG/Avanjxxvvg8DgHP4FefjmECPuVgli8Ll
X-Gm-Gg: ASbGncu3RwmOGo38d+EILfD7hwr9ETKnPnTwR8jPYjV6p7y6G5RGZajnNeTRglrrfr2
	1dktr6x/KDGfy0le6VjhEyzuuvgPyVJK5cadsjiZK/OAnIxRB4+FIFLrviQqRBPnNb6IwuK//2T
	P/qAL77SVMkjBTxsHsEdYWEvyv538dO0uKhg0dMK70efFurzLhl3w+BgOWPzH8Zca3ZhTkBSg96
	USj+ZbEinoXQ2ZOFhGopd8qtiMf/5TT3euS+yhFmpUiKrWUnDPIo4HA0AltYTyhc8cVuuOQtyL7
	TLshaOcOxRMLlMG+A0ttGPRQHqXDmYs6j3whHHresnzOhD97tOZrWyfX3yxkkVNRcBZi9XkT8KG
	z0QGQflTVw2z2JIIl899VewMDzjacdxGGgj9GDB5dzT/V0mCbAcGS1+AK/19wd/pOdIEiXIBm9K
	WLg4VQ+ZBVFoNtrBdhw+dNPHCzi3jF/UKn/Qx6+HA8cZMOgg==
X-Google-Smtp-Source: AGHT+IE4pCKV1iGMmSeVZ9qFnp9eyFi55pZt5CNlxL8ivh3ikVokSURHq7FA+WMw+ZKVtG+DCfQ9hw==
X-Received: by 2002:a05:6a20:3d12:b0:2e8:1c23:5c2d with SMTP id adf61e73a8af0-353a3d54a61mr10279519637.50.1762765658904;
        Mon, 10 Nov 2025 01:07:38 -0800 (PST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com. [209.85.215.170])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f0d16483sm11730112a12.0.2025.11.10.01.07.38
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 01:07:38 -0800 (PST)
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2128779a12.3
        for <linux-edac@vger.kernel.org>; Mon, 10 Nov 2025 01:07:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRMlICCANWVIbv01zgRV/+4f5KLIEco1tRa3/l0hkNgtDl9CPJ/TuJIrRbkqmVtqCedaH5M07yCJ2p@vger.kernel.org
X-Received: by 2002:a05:6102:950:b0:5db:fb4c:3a89 with SMTP id
 ada2fe7eead31-5ddc471358fmr2304047137.19.1762765185596; Mon, 10 Nov 2025
 00:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
 <20251102104326.0f1db96a@jic23-huawei> <CAMuHMdUkm2hxSW1yeKn8kZkSrosr8V-QTrHKSMkY2CPJ8UH_BQ@mail.gmail.com>
 <20251109125956.106c9a1a@jic23-huawei>
In-Reply-To: <20251109125956.106c9a1a@jic23-huawei>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2025 09:59:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
X-Gm-Features: AWmQ_bmD7LCstBufqr7pTwqKUhf3WnheTdaFZy-l1C13xKAmQ3xomq2Nqy5MxZo
Message-ID: <CAMuHMdX8c1VkBuPDpJ5mpCcRH+zEX4F1bQKFf_V8N9ZZtCYqxA@mail.gmail.com>
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

On Sun, 9 Nov 2025 at 14:01, Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 3 Nov 2025 11:09:36 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 2 Nov 2025 at 11:43, Jonathan Cameron <jic23@kernel.org> wrote:
> > > On Mon, 27 Oct 2025 19:41:44 +0100
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > >
> > > > Prepare for the advent of globally available common field_get() and
> > > > field_prep() macros by undefining the symbols before defining local
> > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > when introducing the common macros later.
> > > >
> > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > So this is going to make a mess of merging your series given this is
> > > queued up for next merge window.
> > >
> > > I can pick this one up perhaps and we loop back to the replacement of
> > > these in a future patch?  Or perhaps go instead with a rename
> > > of these two which is probably nicer in the intermediate state than
> > > undefs.
> >
> > Renaming would mean a lot of churn.
> > Just picking up the #undef patch should be simple and safe? The
> > removal of the underf and redef can be done in the next cycle.
> > Thanks!
>
> Only 1 call of each of these in the driver, so churn is small either way.
>
> To avoid a bisection problem if your tree merges first I need to modify
> this stuff in the original patch or leave it for Linus to deal with as
> a merge conflict resolution which is mess I'd rather do without.

If you add the #undef, there won't be any bisection problem?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds


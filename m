Return-Path: <linux-edac+bounces-5253-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E6B2C1BC73
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECDE642CE2
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 14:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A21A2C234F;
	Wed, 29 Oct 2025 14:30:43 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2032641FB
	for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 14:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748243; cv=none; b=ukkB3a/GOGeOZdoPMAktoBCYvBoZ5LjVikdaidEqcpZ4nuN3kCcpq4fcRrbFvEQo3mpDjPrm4UlSfFhpVwOvHx15CegVCp56/dhk9c0lrCHCSysesTdgVYLKe85YBSt0EqW7lDXQi7MNdRzRO2DO/EGy3hA7VMnKNh7adYZwi+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748243; c=relaxed/simple;
	bh=RiCdWEkCDNsJiKATmU0RbHd3Kb5B/0yb//UgjVnVdPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4qo70hxVq/uhWb9/MxFXEKUWNxkzR8yUEHDA9PXvzP26hyAbMLUjM2QH9yjJa04PtuObFXQ4Wp70e9k2xauHpw/XoOBXYzb2PAjjjw+iTWhJV/5XKPDAJxOnOMmLvcwI4onOo7LQ/wLyVu9GyhtpK39qW7R1I/49+1u78xSkeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-8e352f6c277so1986493241.2
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748240; x=1762353040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UmTxX9Lp/E6iQMSfd9sSFodFiE1yd68ZDUJdx86zE5s=;
        b=C74W5A1bCAo86Ipb3HcOu3Ph2oCQ536UZweLArgjkvYcbFJAsJF/KYRA1EQQkULCx3
         3DaSPti/D5WSJCvbo51d0e8qx4KqFdycMotvxNpAI46EsxMOk7lBeoAFVNIrZSE+X/+/
         53Rcl5GgVNE7YomAgeCCEwhSGmPvu3+9PeOzlY5sWPk+5LQZWvit5vb09ycVBsY1GzNl
         aRlmdJBG7gf1yd9qZqj6Wgn4LgjjA80wJ3aKxXhPhPTqXeqbQVIPF16hPnYEgyCmSfHC
         sqEweSCMdtno0UCQ8cQLxb92E4cn2WcLBHIfO4TOjFa0Q1G6TC0nL8ma4uJkfJLNXjxA
         FUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZGmauyo9umedFFtGtaba4RxS9SybDx33H29FUnTl9AfbzR7UWx6RNRUR0kAyjtA0jV+3jLFEcxsiz@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lEqjasXO8sGb/Yf2z+PdfrVzTmnLcDXnpuAOTnu9DBkP2U8W
	XKwBcggkMad8dPEeVpbZcjf+twwCYcuqbmC6hSLxOWn4J79bIqAwXbLCCYmRCb8W
X-Gm-Gg: ASbGncuIAXTDjN1R9MRnIG2UYCoOXzsx7I7ge/mLEwJyRTZD8MD7VMY1HlsIdMElZjH
	ofdj4GRW9G8e6AW7aniZLO9tvA5h5VfeFUOeFiZkCtAUg0saGavBOGgIdqO8+P6j/mYddKWTqDd
	O/urrGvsD7YN0Qi4mzYaAaEht/gPqJrebPYGRdzAH14NBB/UsUtRxRegYuQ+4H8m5Nntp/Q9BFL
	a1K+7eA6GrDnyIp1YtLCv/VR1xOLiG4ggXsNdiA2YYrOktULxuEIN+eSGzPRYqyGjRjJdRVdRCa
	gEwCOq63hTitw+f5eO+e+xmznfQkhgkp2txV1u63Zoto0ho1TSCvTVQA9jD+hkwOSGUBFDhMTdC
	w0GAavPXsTJ8wIkUgHjamezpUedX/5oXl6mSZWBtUKc7299i40OQ30zSora6mQlL/vo6Hw+RJwU
	XnERBc6316V5KZm4XRvM/YTVJ9hKOkcwfrolXBfQkYDQ==
X-Google-Smtp-Source: AGHT+IH886PZYZcBxsJzDzYzCr7/mOr1s3gGXiupQ0VGRYxHAszHo0ADVFwIrI5O1gSQKM3OLdYB8Q==
X-Received: by 2002:a05:6102:598a:b0:5db:2301:aa03 with SMTP id ada2fe7eead31-5db9067821dmr1066316137.34.1761748240132;
        Wed, 29 Oct 2025 07:30:40 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c3f431e3sm5197520241.8.2025.10.29.07.30.39
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:30:39 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-932bbd6ba76so2473034241.0
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:30:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXTW2gYmXjhvb0zZxjsDzmi+CWrtphLWRQe97bL09nfA5IPjruYunQhmv0qZ8r23QXiF6RT+ivs8Wic@vger.kernel.org
X-Received: by 2002:a05:6102:3e95:b0:5db:38a1:213b with SMTP id
 ada2fe7eead31-5db90656011mr932905137.27.1761748238614; Wed, 29 Oct 2025
 07:30:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
In-Reply-To: <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:30:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
X-Gm-Features: AWmQ_blleyKJMjc4oETFxToQhJJ0bdzSdD1fdMmRWAHt71coVgn8wIHcAFgDdM8
Message-ID: <CAMuHMdWriu9eUHMSKcv7ojSqbquP3=z2oaquQZLx5nmN0EcGaA@mail.gmail.com>
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
To: Linus Walleij <linus.walleij@linaro.org>
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

Hi Linus,

On Wed, 29 Oct 2025 at 15:20, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:43=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Prepare for the advent of globally available common field_get() and
> > field_prep() macros by undefining the symbols before defining local
> > variants.  This prevents redefinition warnings from the C preprocessor
> > when introducing the common macros later.
> >
> > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Do you want me to just merge this patch to the pinctrl tree or do
> you have other plans?

My plan (cfr. cover letter) was to take it myself, as this is a hard
dependency for 11/23.
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


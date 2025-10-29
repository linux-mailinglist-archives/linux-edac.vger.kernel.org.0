Return-Path: <linux-edac+bounces-5255-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B88C1B823
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 16:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B0215C28E7
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD14F2C0278;
	Wed, 29 Oct 2025 14:42:36 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D712D5C95
	for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 14:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748956; cv=none; b=em1xPfW+YnDiedVPCmR2RThmsbD4tEnpcF1BoHPc4G/rQpftl087MvwutYofNmd6Ck4wsMmLdr99LyKzsjgkgkLt+r67il0qNAq/G7svCHG0D9m2R1YYvUvlOwL9qXLtTjBNoQ9IJkzJ+h40LHX0d7gTfiNgfN2wmx7aO/Ll+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748956; c=relaxed/simple;
	bh=QXFJ9Wye89l5k56IzhXHnCZ5vP4dVOGIaGxaTnibrdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nhrqq+8HJ0cDuV/S1ILqgJUzs6L2MG74v8MGjBEcFuEC3SabTBK8tN09V+AjBVzE+UHlq1XA1W5/fHiEEp2acXGdZvM6jsOnWauCezwTda5/Pr3QEe35i+UVjn71NH1QjsnE8tXQfQ6HWaRBUBNdDKhRcpKxU+cyzQ2pKuxDyLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-557d71a96f3so807570e0c.0
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761748954; x=1762353754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohi/8MFIs+pUNYTuSKDH5KUVpFMJO5wn0YyhdMa7QIc=;
        b=BJu96NAv99nU7jFmUV1+0RJEji7YYqy4TLfhWGcru09ynEMYeBmxzx1PrKauLkkSuk
         al3FRY7TyZ1/DwfNi3KW8XHU1/fXmYzRSQMnUdGpSEpMWBgfDzMkPzdJ0/qBIfND4KBr
         vKigSdUb4WocMeAMVn+MeuO22zc30pWq016u18Oy+BDoYfNz0kcYll4EoR/nCdXgB5de
         jNN8IKKfYaitpPzq0oJgoEr8bOO2bbwjJCfDTctBSOix7CSDcgphqdoZo0YkOY9MYcJL
         mZOIq4TFrXLMDr9Euny4+KqUHzjWuE8T+ThekMY9RsLUnye0KKGo/0TDsk7I4Ovo6A/9
         mZ/w==
X-Forwarded-Encrypted: i=1; AJvYcCWmJyw8IYJN8Cq7YMpjVhNhTZavl5Cmy7Q2Rseksb4F+8Qgfgj3/PpFG/3alOGt03df/lFmGisODLtp@vger.kernel.org
X-Gm-Message-State: AOJu0YxYq3JdDZWYF34mSmD7txAQuUO1bMvmf3JewHxwMH+dxP/fNj0S
	pvBFs5MnVt+ELW3mu7YTHJugG/PIhh39xnsFg8iOjyNYVL/50g8uMqKS+d1HtxfE
X-Gm-Gg: ASbGncs+NUzl3l52S+22v6MD4nDFcurdQ0uqhVXtC44/4KWxODh5qfwGeBPAnGragmh
	tfstwkuSS7s/A5E+7kFEGxeVOTbS1lVTXeeCiPebrSIXwDyd3im9F2e3mWlHmTPBsdrEWTIvib2
	WwMwwxwZ2zV8y2THxmQa+2L0qV3m7uKDGmUqf9L0ejIouvYsA5mtCHQVpuNiM84BEiQVdSvRxPW
	dGC60c320v0OOQP0nNhAemv3WvuzpNTePS7nRFWJuuF+OVoUC9AxypdChK6BpwxDpzozWQE1RVR
	90A3bo0Cl1G9vYmvoUTw5pltDMdO9pwLi0lVmajYjLMrQtJaRd0mrjQUgufDF5/PmkxBE8IPL/U
	Rb9nHQvsa3kkgIkYMGbpS0oLQ3MAmD6TKWRLLzQweQmel04zFS8djT0hENlDx0Un7jZft8FfDlB
	j1BCo8w+CcdsUt2xKDsfCzSCG3R8/DbF1QHbHv9+ZicRg2CTDOVRpgsLpUPX1UNUY=
X-Google-Smtp-Source: AGHT+IHk+msHqpYfl5favUuLH8of9PI86KGzDAmhUg7KOKdQJL2qP/OMvMYM/RmpefWpWmM0RgO45Q==
X-Received: by 2002:ac5:c54a:0:b0:558:1a94:364b with SMTP id 71dfb90a1353d-5581a943d52mr408706e0c.1.1761748953885;
        Wed, 29 Oct 2025 07:42:33 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb08fcfsm5434817e0c.9.2025.10.29.07.42.33
        for <linux-edac@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 07:42:33 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5db2dc4e42dso1157685137.1
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:42:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUlNfsL7lMKrTbLV8hTHnRvFYk+r2S+UTA1zwFj4Nc4wRaU/9Vc4qW6IYZJpyl058AjZP3wJB2Y0HMO@vger.kernel.org
X-Received: by 2002:a05:6102:2acd:b0:5db:9b88:1fec with SMTP id
 ada2fe7eead31-5db9b88219emr535412137.9.1761748503547; Wed, 29 Oct 2025
 07:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <ac3e718c5de6a23375055dd3c2e4ed6daf7542d5.1761588465.git.geert+renesas@glider.be>
 <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
In-Reply-To: <CACRpkdYMv+R-NJ5R4+UyhK1+DJia0z72kZgt45+0eubXMuGpEw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 15:34:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
X-Gm-Features: AWmQ_blZ8dUVr2aBwtWAAkAOaE93AtUSPNFDpslgvmXepFfW4tMWIOUWnRJkksY
Message-ID: <CAMuHMdUvLH-8yNRoqBdTB+mcmOUedwVGpJ_HGdq8sqgLNB4dvw@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] pinctrl: ma35: Convert to common
 field_{get,prep}() helpers
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

On Wed, 29 Oct 2025 at 15:21, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
> On Mon, Oct 27, 2025 at 7:44=E2=80=AFPM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>
> > Drop the driver-specific field_get() and field_prep() macros, in favor
> > of the globally available variants from <linux/bitfield.h>.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > v5:
> >   - Extracted from "bitfield: Add non-constant field_{prep,get}()
> >     helpers".
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> I guess this needs to go with the rest of the patches?

There is no hard requirement for that, but if 07/23 goes in, why not
include this one, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds


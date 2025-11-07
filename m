Return-Path: <linux-edac+bounces-5408-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A41C3EDA0
	for <lists+linux-edac@lfdr.de>; Fri, 07 Nov 2025 09:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F20188DBD4
	for <lists+linux-edac@lfdr.de>; Fri,  7 Nov 2025 08:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C394B30F921;
	Fri,  7 Nov 2025 08:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmyoA+YH"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2008030F92D
	for <linux-edac@vger.kernel.org>; Fri,  7 Nov 2025 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502437; cv=none; b=JHRSJYKo4Q8fLh8vmAbN0FUdzbzJeDzUqLZvDjHJm+oCrOZKqWdv5u/4Y1wM5c+GxIQR7yVYUk1VSvo37G0NKEWlFJW/mcM8uskQdRqsQ3EBmysZKWy3XAk2zWj6NXKQJ7DWjzW6MLoryU3ceWPR+U8v4orq16SWOeIzTnWFtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502437; c=relaxed/simple;
	bh=gTrtMTVdIq8o2Lv2gAG8UVNbAa67NI0LZcaPzCP9uxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8OmJGqF922PXGdRrxWpdQmzURDWfYS3364TQpiYN5VK5SOWkWKHuSiIkJQtRMA+AjTLKs6rnhm6YWTEnkean98O2vQksOdeHTfulKyzwcLmY9TdGu5YnmFb0B7jFD7/GaJ+Q8Hd3u3Is/rL4TCrTp+C7GuySGa1rUakVF4khGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmyoA+YH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso818334a12.3
        for <linux-edac@vger.kernel.org>; Fri, 07 Nov 2025 00:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502433; x=1763107233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4L8nwY5tA46qS9RhjMiBvwIJ3m3PvlUWeeZDUBNYNE=;
        b=AmyoA+YHQZgstGRmD8U6Uc5Qp3lHeC8gVhIBg5c7IDTiz9uxO1MKh5pvTLMYZ1uWXu
         ZOiCh/0sWFaopk+f5KfR3BcFOL9zYZNgwM+yWnrs/cvXnteu3aoXVLpBmW9Pfhsbf51W
         laGx54OYB+zhf/9On7oJS1XjUSQyqr2R4q7FPf5IKZPIZLj6jE2u+xaaRonDpdo8cYNo
         sT26cX0LyiU9BpU1+93/AVTPh27969l83AWVEOF9a/s1OW3QFogNfFxrcAkv9htYErpE
         eVO+m5sjBQ7LePaEsHPnv1juoEuTT3WWZG2NexOODGf77B/buQoApHYTaAQa3EaoqGXO
         dy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502433; x=1763107233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L4L8nwY5tA46qS9RhjMiBvwIJ3m3PvlUWeeZDUBNYNE=;
        b=oc8Sv6cbEC/vmmp3ffCneABC7HcoG8CAal0CBB0aLJhNerXGUD9nidaxjOyN7BMIrn
         j0iTVADK5ypkrLM5vtpG7iacaLdgg6LPUZVEDHMFOAZNztkxKRC9AJVLmASI/PrfEozv
         MvTWKlvcznC2i3iE1EFxX1m6A2aPuUFqEwRsVgUGUHz4fmCHmQrvPIk1aXKd4C+BFKkM
         CTkK8jhHK/2pZU5ynNjxGNNtUC22PdKBFNySnS4Q3C3ROPPPSG4Lm1gYqgL7Y/CD1UKB
         QRWAGThhvB6eagiIt1cX/fuQ5JqDti3ol1jaydPktR8BSxiFKTDXu+Vb2ByfFNq+Xuj/
         audg==
X-Forwarded-Encrypted: i=1; AJvYcCXtVf5YgJKC+Gs5C8vxDcYpkkxKS0Y4aN1qGWlhfs+I7VEJQ8fK57bYNS0MXg4ZgjkIBpEvrHNYj50i@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtfejxs5V1kFYJ5SUHcvX7t4L6u0axxactCwht/YhEhXYw148
	01+1G3nL4PYHBrK8GcdLL9EXIHFgfnQ5SxanvdECA16WM1Wg1iNOND5w4Yf0cXk+Z1W+HYekpJ5
	VqUrnPBIFTQdVN4Dku75WTc6XslpSIJs=
X-Gm-Gg: ASbGncuqhdxnTbPPg5dTHE1Gz6b/NT+fDCVb9nZGQrKm4LSGqD4raSfD/pQBwfjQVUL
	pp4d6YQWqIwDcFmPENebYgSzfySIU6pCO+QdiF+SMK/gLCpV2dKqhMRUs1hTSUaKp0EP++frXG4
	b4Fi0mjh2p4h6DdeUrS1CYpY5oV7EqlkTWEJP3etd5iGWFDtymYQPD+Xes6GcOuCUITG0Vr6tkY
	pB8xMszfrg0S56Cfh+q0dED3O/+J5hDXE73Ly1Cyw3Vc2V+Ttlta7lBNadvXA7pjzYQ9yQ2
X-Google-Smtp-Source: AGHT+IF1uok4S2/ZJxGVMG6j0RZBxmZiPcUtNqCXKtotlWPr6F8OAXOZaMRmuRE8uDgHau7bT5W5RrHY3dcLjEjQckY=
X-Received: by 2002:a17:907:3cd6:b0:b70:6f46:d401 with SMTP id
 a640c23a62f3a-b72c093317amr195124066b.11.1762502433125; Fri, 07 Nov 2025
 00:00:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com> <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
In-Reply-To: <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 7 Nov 2025 09:59:56 +0200
X-Gm-Features: AWmQ_bndsm6ikZxAsR6MbqZ_7CJczSuokLGcsZHpDoyZxbjksOeSkgDr0jWR8fA
Message-ID: <CAHp75VeMqvywS20603yDSo-C3KCu+i+8vvDNuz3h9e8Ma9BOCw@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Yury Norov <yury.norov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, 
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
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "qat-linux@intel.com" <qat-linux@intel.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 3:16=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, 6 Nov 2025 at 17:09, Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> > > > On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> > > > <andriy.shevchenko@intel.com> wrote:
> > > > > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrot=
e:
> > > > > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "u=
nsigned
> > > > > > (long) long" _mask types.  For constant masks, that condition i=
s usually
> > > > > > met, as GENMASK() yields an UL value.  The few places where the
> > > > > > constant mask is stored in an intermediate variable were fixed =
by
> > > > > > changing the variable type to u64 (see e.g. [1] and [2]).
> > > > > >
> > > > > > However, for non-constant masks, smaller unsigned types should =
be valid,
> > > > > > too, but currently lead to "result of comparison of constant
> > > > > > 18446744073709551615 with expression of type ... is always
> > > > > > false"-warnings with clang and W=3D1.
> > > > > >
> > > > > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > > > > __FIELD_{GET,PREP}().  The later lack the single problematic ch=
eck, but
> > > > > > are otherwise identical to FIELD_{GET,PREP}(), and are intended=
 to be
> > > > > > used in the fully non-const variants later.
> >
> > > > > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >        =
       \
> > > > > > +                      __bf_cast_unsigned(reg, ~0ull),         =
       \
> > > > > > +                      pfx "type of reg too small for mask")
> > > > >
> > > > > Perhaps we may convert this (and others?) to static_assert():s at=
 some point?
> > > >
> > > > Nick tried that before, without success:
> > > > https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=3Dof=
0y46+rVjnSgXJg@mail.gmail.com
> > >
> > > Ah, this is unfortunate.
> >
> > Of course, it might be an actual bug in the i915 driver...
> >
> > The extra checking in field_prep() in case the compiler can
> > determine that the mask is a constant already found a possible bug
> > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> >
> >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.=
rx_fltr);
> >
> > drivers/net/wireless/realtek/rtw89/reg.h:
> >
> >     #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
> >     #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)
> >
> > so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
> > this operation...
>
> The purpose of the statements is to update values excluding bits of
> B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, bu=
t
> the operation is correct because bit 0 is set, so __ffs(mask) returns 0 i=
n
> rtw89_write32_mask(). Then, operation looks like
>
>    orig =3D read(reg);
>    new =3D (orig & ~mask) | (data & mask);
>    write(new);
>
> Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, ho=
w
> can you find the problem? Please guide us. Thanks.

Isn't FIELD_MODIFY() what you want to use?

--=20
With Best Regards,
Andy Shevchenko


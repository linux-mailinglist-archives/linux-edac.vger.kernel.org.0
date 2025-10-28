Return-Path: <linux-edac+bounces-5236-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD986C1527F
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 15:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0584609AD
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4413370FE;
	Tue, 28 Oct 2025 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uIBa1ecY"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA93335085
	for <linux-edac@vger.kernel.org>; Tue, 28 Oct 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761661231; cv=none; b=OUwBJB8ET9NA6JdvQVGCImiN53bTyBMXnX/egC4DcWEs9cIbUcq++XmMBw8pcgZtjdYC4QMuP5RiiG+ELNq8kSWoDnVdqyATkcx50aFqQGGuplO1pfqPJxBBPR7h1h7YNTB1Gh/mwgBIF73rI8KxvGa6B9DOnVCWo/DUo6N9Gso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761661231; c=relaxed/simple;
	bh=pP8FTV47DQsaScTl4AKuec/C6HsHLvvn5JrdlNFvXF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYOTip4yiq69BQ0MDlUYEnry0zv2kBKD3EkyYfee0KrRa/6ARrVcxaEIYmN871sZqTxIJYscKLetGWJ7otVgKLQElGFdvnGrq6rO1BS9RbO9xCJiggRc+pBPQtLgCC8UwPtzoagWdngs9l7ueJJ+Cz6XGtg/DWExp9pAQ0jOgSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uIBa1ecY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-362e291924aso49443141fa.1
        for <linux-edac@vger.kernel.org>; Tue, 28 Oct 2025 07:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761661227; x=1762266027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=uIBa1ecYcS0SjQasgAEKQr/pVNdcH2s+vv+Ivq8X+TvJlZm3PK4XkoOKj+ySjsss6V
         0g8VjUJ/7QVvEAWpyHMqMetwZu3/zoN1N9yyXtB0KFxrE/rVPaA1Wla9t4UuOGIAw/wn
         tLvnxdxSdn4y9ZLZkoqvs3/uknC8cTF+ohyHp0eXubW+fJwQrXlNVOsgxyt8mMbBy66D
         1uC4SKbYh7kSu4m2DIPdoiKVO+xnGkWcrG1i+y3Uwm1SYSS1wzr0PjgOSFofFE0v8Jnx
         uh6w6swnMKwZGoMtYXUS13Dhkpdcfv4aAkZJJYWpnhecHmYQWvg4zllIFHM+xQPboquJ
         uIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761661227; x=1762266027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOmSiTMyA8cqAorOzkSzQ5xujNoDEMVqXsbHnkkNM1c=;
        b=R1IwsekbvgSyleSLvyQ4dYlUNnKCnGiKvtWoJC4tD4hsmEtHpCELX5HRDaFRFd4FDE
         2BNPf3oZfUhEG7eOLoeYqFRCf/Duejwt2Gj5CKRIQOtx6BsmluZPqAkh50mSrYDtM/9J
         VmA3UD5Lso4iXuJxRg8dfaGEw6/ofUhxL968JedJxQXDEz3DmlePGC+vxBJKZ9tSdlyz
         +BTJpQzC14+zUw1aILx3LzKLe6U4csYuxO+9bPqgWd/MdT0R3qxYsNE5OksnQIjaecL+
         nUcmwEnipTC9n7vP7TKkxHGk2qO2Tj9ZpETes4aYN5wy1g7fL2Jb6ykVlPEN2WRDRBIK
         v2Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWvrdwNAfAQPSCEtwUFqvt5TvM5rxpHQYgIiYSqqR/q+Ku68ELLQ2E7HuQTaM4Jz9sbznMVjP/3BlXP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb6mn+y9AVQWZ2PKoScKDSQa6KgvdEm/O6GQxXakavWFgyrK3z
	PwX92lEV6QkWUINqoIsrGTGKsCgv88lGNdouNkN8IC/bcJEHo/5d/UEnJe8JAUTiullf7pfDKpr
	8iyDdd5DkxM9TQHEgwZq5WfqR3L3hfSH0dHhBUw2kcg==
X-Gm-Gg: ASbGncv8yqhxxdN4KS0ZN4RCKop3aRapHe38zBwgWmEUpbx2Gg4Fxpvw3H3cQCPmT6p
	hQ/kKGASWUXAIJGn8LOJPnH2z84C+nyAjF96CvC18uxgknm/BQQ9yNt6gV1T1WfjcXjZbAOpBy8
	uwuWYkMVZZxoDcO1xDontfRBfWxeLC6Feobs0DjTkxz4qmTZLRKE0sHVahcBwzTSM5GRyqsS0T9
	7Lsrr3hZQ0MBwyLsiWsDIeJgIQ+ksM8zTZr4H8CKeqTBJ3e4rp+aTEf+/1JbnnH2JNjvZ6hRoFZ
	SqHsJuuUS1D+8byy1iZYe+X2BaQ=
X-Google-Smtp-Source: AGHT+IEa9/49xzFtkrl2WuFSbF2nGR0Ee3sa2JYGGK47IcVnnhS7gaKd3pqPtDHg3v3/2iaUnvbb9dKc2W6cTL8KA/s=
X-Received: by 2002:a05:651c:2354:10b0:351:62e3:95d6 with SMTP id
 38308e7fff4ca-3790773c607mr10303011fa.28.1761661226962; Tue, 28 Oct 2025
 07:20:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1761588465.git.geert+renesas@glider.be> <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
In-Reply-To: <76ac5587c5ff3aae3c23f7b41e2f3eacb32ebd21.1761588465.git.geert+renesas@glider.be>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 28 Oct 2025 15:20:13 +0100
X-Gm-Features: AWmQ_bkGEmC8OCwW4QksGegCfgNPPWl_EjVB0knvBjv-hfBoqYq6hENcwtWJ0QE
Message-ID: <CAMRc=MdcH-56_cJ7oDUhHRsJRnDqbss5ET-3yGrBffGmEK_ieQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/23] gpio: aspeed: #undef field_{get,prep}() before
 local definition
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
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

On Mon, Oct 27, 2025 at 7:42=E2=80=AFPM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> --
> v5:
>   - New.
> ---
>  drivers/gpio/gpio-aspeed.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-aspeed.c b/drivers/gpio/gpio-aspeed.c
> index 7953a9c4e36d7550..ef4ccaf74a5b379e 100644
> --- a/drivers/gpio/gpio-aspeed.c
> +++ b/drivers/gpio/gpio-aspeed.c
> @@ -32,7 +32,9 @@
>  #include "gpiolib.h"
>
>  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val)        (((_val) << (ffs(_mask) - 1)) & (=
_mask))
>
>  #define GPIO_G7_IRQ_STS_BASE 0x100
> --
> 2.43.0
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


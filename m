Return-Path: <linux-edac+bounces-5256-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA91C1BB73
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 16:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 156985C255B
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A9D341678;
	Wed, 29 Oct 2025 14:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAIsqD2Z"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CADF2E0402
	for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761749021; cv=none; b=FFjzjEFf7uEnhO5xrHvaixHkS0+bPiIIVNOHiiT090UNdbTCK9JdWee9NPWp3Y8sa9lnH2xJpt9cY1rF4/qPKWuhOv1NQ7jsVdzZbv0/0VQzLqTJ15W86YSax8uwa9XCuIX4VbFGGbq9WzLES0NcRtJx1QXZYvg2zWj3Amibbb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761749021; c=relaxed/simple;
	bh=Wgk3sH20qHeZBfqYYvcjCmo4mWJP4A+tn2y/6jju0pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfbIxgHQW9MTS9H62/gHLh+IJVYFKkBFTtgU4hcdGUs8PAlRCRc+oGsMOjLjZGipLjcEjKbpMqpSi77K7mXBgxNP85baozm4onlnbgxvQt8Ti+bZn0FJO03WH4Hf4mH0oppPkzxVBjHse66WSYGk9f1OKda0k/CAqqryyRKDgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAIsqD2Z; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88f239686f2so711589185a.0
        for <linux-edac@vger.kernel.org>; Wed, 29 Oct 2025 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761749018; x=1762353818; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YCEuo11ZBMvPKplSQXGviQNPwjkOhxFZqewnhvYiFAE=;
        b=TAIsqD2Zns/vh6XEVxrMyZ9XiuMEDvnnK9GumKlk7zWINRHoMaoOl52OOx0Lv3wX8E
         FjgJ1Sm+Ey5eB0PUO3wZTVtavS9oGJO4zX/CUrLLVqZ8sx8q3ZG1uLFEEbBv2ZdVYajt
         Dsx6B18zxGO3c2fhfoTsIh8TM1Cz97PLXclZQKnVjwOunoDH5Kn+aeHtJiKRTNrK3eoj
         cIPxW133XNU4KYCPbPC5CPEARUrEFJBY+QO9p5tF3RLTzbyE5eHRPa2N0WdMynNJgw0P
         zhvL6d3CV0BX+AxHb9gKsR2IAi8Cjq81a8HPF3uWXZ5j8dblvIysIgyQc/LTj9vaalmW
         bZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761749018; x=1762353818;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YCEuo11ZBMvPKplSQXGviQNPwjkOhxFZqewnhvYiFAE=;
        b=MYDvykIvXw+qkcBPpe3j3jUXB5TwlTCRvKcejf1Iq9s1BZmTU5w5/a/LZhOKW0z2zw
         5S2vvraRYuBdhlowTcuwndpjG0mvmfApv+SA0pWiiFD4WKjZ/gYGcyAJ45BPgczQYLsP
         AAdwOtcXVhRgVofILbdd5ANGg9Kit2y8Mgjga5yDuECwBuKRryTOoz/xnb5asfxJggEJ
         mQcmyEa6596TQbN6q30SOPQ95lc+8575xDtaelNULqEDCsYmuHLFonxsBZ+Bl+w694dV
         LKqCmDTlatcAU4e1RggYCiBpkqfhPAoyqQAnsqkbItmZpDrxSLQ3gX+Wbp94rdvWiYFi
         c8ew==
X-Forwarded-Encrypted: i=1; AJvYcCX9DUcsFCWrJcK8nH/Je9LN4av7wZ+0fD6wV7pT7kKmltFYMGut0psWW71qyARRxer458bWIPxlttrN@vger.kernel.org
X-Gm-Message-State: AOJu0YwJe5m6h6SlWPI30dJOGHWtCFHSBXuNYpePijd0/qk/fTw7MWjE
	jYrUjwQNbFQfpJdKWFqzxqTOxv03mGokNjfM6+9ulSAyHcTocrJnu4dL
X-Gm-Gg: ASbGncsT6YFNy+kx7g+Ziprt4GBqBKPM98iT/zJ12QaVVikcRQe86dHOk5/9lc+zQgH
	5axWvv5uJ1xczamkJWEmRSk6P/07SvtgcALVdTVCC6wLo3ASFB4yUDuDbBoiAhrQpxEEyRLRCNj
	oODz5vu8YzdXyQ3Pj4d6JtodasMHSNW9CDmSCiMtXDyomqPVmNKryLxRQ0LyaWIyhgwGMYBGKTX
	kmmpe6C0EJ2AMV8hy0aEMlhrCu00A9R/PVCUQzTSU3CPT4OUmBrZljWGkctyg41DlG3vEkmGHh8
	9OYwxseocVIpe8d6QTe2ElNTyMWsKdIxvP1Wlk8tidcuPfL4xQsnmRP24DQKcVZI2omhDf34c/d
	TCuU0V2wIGJdaJYfuSKAZOGy9bcCSgg6w4q35g1XMKw+74PwnMAatVDKHomHbX0scu21hRlD+
X-Google-Smtp-Source: AGHT+IHRIj9y57LgRm08PCQ5ag8nDTxAHjyPqcFEyJpmfMgUHtOJ1iinv/hiv9ZRE6XSrJXIT+Ycrw==
X-Received: by 2002:a05:620a:710c:b0:89f:5a59:bf30 with SMTP id af79cd13be357-8a8e58b5164mr388519285a.78.1761749017372;
        Wed, 29 Oct 2025 07:43:37 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8a8179460fasm337345285a.57.2025.10.29.07.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 07:43:36 -0700 (PDT)
Date: Wed, 29 Oct 2025 10:43:35 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/23] pinctrl: ma35: #undef field_{get,prep}() before
 local definition
Message-ID: <aQIoF_TPNq13Hc3O@yury>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <03a492c8af84a41e47b33c9a974559805d070d8d.1761588465.git.geert+renesas@glider.be>
 <CACRpkda6ykSZ0k9q4ChBW5NuPZvmjVjH2LPxyp3RB-=fJLBPFg@mail.gmail.com>
 <aQIlB8KLhVuSqQvt@yury>
 <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUTR2VnQ++j_ccUN3-GzKmSzS3H3QNyYqZNacfOBXD50Q@mail.gmail.com>

On Wed, Oct 29, 2025 at 03:33:49PM +0100, Geert Uytterhoeven wrote:
> Hi Yury,
> 
> On Wed, 29 Oct 2025 at 15:30, Yury Norov <yury.norov@gmail.com> wrote:
> > On Wed, Oct 29, 2025 at 03:19:45PM +0100, Linus Walleij wrote:
> > > On Mon, Oct 27, 2025 at 7:43 PM Geert Uytterhoeven
> > > <geert+renesas@glider.be> wrote:
> > > > Prepare for the advent of globally available common field_get() and
> > > > field_prep() macros by undefining the symbols before defining local
> > > > variants.  This prevents redefinition warnings from the C preprocessor
> > > > when introducing the common macros later.
> > > >
> > > > Suggested-by: Yury Norov <yury.norov@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Do you want me to just merge this patch to the pinctrl tree or do
> > > you have other plans?
> >
> > There's a couple nits from Andy, and also a clang W=1 warning to
> > address. So I think, v6 is needed.
> 
> Indeed....
> 
> > But overlall, the series is OK, and I'd like to take it in bitmaps
> > branch as it's more related to bits rather than a particular
> > subsystem.
> 
> OK, fine for me (if I can still get an immutable branch ;-)
> 
> Note that as of today there are two more to fix in next:
> commit d21b4338159ff7d7 ("mtd: rawnand: sunxi: introduce ecc_mode_mask
> in sunxi_nfc_caps") in next-20251029
> commit 6fc2619af1eb6f59 ("mtd: rawnand: sunxi: rework pattern found
> registers") in next-20251029

Oh, OK. Didn't actually want to undercut you. :) So, at your
discretion. Just let me know what you'd prefer.

Thanks,
Yury


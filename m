Return-Path: <linux-edac+bounces-5402-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCBBC3C517
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 17:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AA362455E
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 16:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E534CFDB;
	Thu,  6 Nov 2025 16:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cJuCbf93"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067753469EC;
	Thu,  6 Nov 2025 16:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445366; cv=none; b=NfAkmcP7FU5FS9ZiLuuzbk3Jl7Lw2YD02c+zZ3vjQXc7rzSvOwGLIsnHU0nhuMDoS1P2Ky4gHJ/s5JqSY1ufZyfHRKQ3/SkdSOzxSGbfNJniqpPhHktm3zQZQK9ubSUiGgFSuaEx29tdtBgzWdiTdMmwrm7sQszO6m2na/rS+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445366; c=relaxed/simple;
	bh=Vw8ubo+7N9WsgP5kvlylaSWSYsq/SxO6iOGciGtc5m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g963zTi7wNv0dsvkXuA17wVOLsriuzc50mH/VIFkObTwWTIaHxWQFd82d/hcYr+FM5ARiYgjJQeVCe186eRMkDDX5vnMcAhLIzq/XUkEwBHhO23Rix2qTwI5NHvLQYXhzw1+EuuOwiISfj2KpPiTQozT/F++wPDVUz3FS9uKb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cJuCbf93; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445365; x=1793981365;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vw8ubo+7N9WsgP5kvlylaSWSYsq/SxO6iOGciGtc5m0=;
  b=cJuCbf93XzhRO6MLgWls6fK2e0dQWmINGGuo1L6zXMCkMqSsa2R6F2Hb
   +1oeJFuP5C6Hjb8CpyPkeyXktTfKUamcqlp/KOXy7u/PDQG+vF7nwkkfY
   kQKRZ8HzaZt1PUWU2fnLBkRXIixYIK2pLsauJyZurg6Tuynv9E7Isb+6h
   lGrRzT+kVyzefMlZdVJzyQat8Z6+tL9lvxR+gZU7P8VlS7GDf/i0vS+9C
   ntVBo8yok3eJCSvSbmJYxcwYtwpPeVlsLmMxyb+a8Nh/teXTHCbB/KZbH
   MBHFdahqd6QX93sByEwm53kcYBe6gT2a3PBpHsgEhbTCRcnthJ7dfFv3Y
   g==;
X-CSE-ConnectionGUID: i8rJtjcMQ8y+SpADtNmtsw==
X-CSE-MsgGUID: TvtwaoYeTGSJOu7XGARm3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="81990234"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="81990234"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:09:23 -0800
X-CSE-ConnectionGUID: NMtAY4RTQwCRyv5pYJWnNw==
X-CSE-MsgGUID: 7q5zGf4ISXWoFKQH6Cd2fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192150660"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:09:11 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2Xq-00000006Bqk-1JoP;
	Thu, 06 Nov 2025 18:09:06 +0200
Date: Thu, 6 Nov 2025 18:09:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yury Norov <yury.norov@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
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
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org, qat-linux@intel.com,
	linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
Message-ID: <aQzIIqNnTY41giH_@smile.fi.intel.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 03:49:03PM +0100, Geert Uytterhoeven wrote:
> Hi Andy,
> 
> On Thu, 6 Nov 2025 at 15:44, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> > > The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> > > (long) long" _mask types.  For constant masks, that condition is usually
> > > met, as GENMASK() yields an UL value.  The few places where the
> > > constant mask is stored in an intermediate variable were fixed by
> > > changing the variable type to u64 (see e.g. [1] and [2]).
> > >
> > > However, for non-constant masks, smaller unsigned types should be valid,
> > > too, but currently lead to "result of comparison of constant
> > > 18446744073709551615 with expression of type ... is always
> > > false"-warnings with clang and W=1.
> > >
> > > Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> > > __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> > > are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> > > used in the fully non-const variants later.
> > >
> > > [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
> > >     HWM_FIELD_PREP()")
> > > [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
> > >     warnings from clang")
> >
> > Also can be made as
> >
> > Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> 
> Nooooh... torvalds might click on it, and complain ;-)

See my reply to Yury.

> > > +     BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >               \
> > > +                      __bf_cast_unsigned(reg, ~0ull),                \
> > > +                      pfx "type of reg too small for mask")
> >
> > Perhaps we may convert this (and others?) to static_assert():s at some point?
> 
> Nick tried that before, without success:
> https://lore.kernel.org/all/CAKwvOdm_prtk1UQNJQGidZm44Lk582S3p=of0y46+rVjnSgXJg@mail.gmail.com

Ah, this is unfortunate.

-- 
With Best Regards,
Andy Shevchenko




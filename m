Return-Path: <linux-edac+bounces-5401-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2748FC3C42A
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 17:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932861B212CD
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 16:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463AD3446A6;
	Thu,  6 Nov 2025 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlpSd2oO"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48646302CD0;
	Thu,  6 Nov 2025 16:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445333; cv=none; b=tgNmyL5bByQeZEKzBewrZ3d1+UIWzOV4OIdE1D7aNQpDLUKwyyty79gvYliH1RpOpYr/wfxjxUEAsd4vUihnRUaMqumhTFd2Ixjn8Q/d4Tp5oPVR9DkyvXkaIQWxqH3G3U3uHtFs0QFvOkkIm1geqaHp0ksPXRS78tbBunDdAm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445333; c=relaxed/simple;
	bh=BxSiubnDJFoi3hF0gZEV1dDowKtMOnRvt3PDCt/YgRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVDuktOEjau/zvPRHJUSf41hyi4OacpvccYWbIeDnk71P8DgsgBfuit369aDlGZI7MlVQ2FaVlzfniuxzrpyWbyAFPp/e+Bech877/sLvpzVyV14uVCgkEa7cqOv91WXvQxGxNp3rcxIrk3lDagrmYq490A0RBBo7FdGAVkcyNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlpSd2oO; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762445331; x=1793981331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BxSiubnDJFoi3hF0gZEV1dDowKtMOnRvt3PDCt/YgRc=;
  b=jlpSd2oOR5wZlMbTql+TSqjVWomKBBKMFkf1/VdgcqMXuz273YF6XP6X
   +hPmSHg9qpLxrHinF0rWesen27BrXf3Q/KirEanRteCqzFck4Wk/gny19
   sh2CkJ9tzG9UCuYUcXj3ael/zNDeKJe4eUJslJ4Qudtrf7J6PJzGx8SYI
   Fx/q/sKACbeesblHGGowKuUmu9z/wknoGpL8oDx1Bib1SRanJAAUVLfx7
   R81tD6r1n/xHs/oeQ86a+ovpfwSlt6PkWqHSJXDx8ajSIYOiy0u2hV1Q0
   jEDx68lju7PZcMkaZ4AvvqSpAX+mT/9MQf6pF3JW+oSZdgHOyRl+wSe6l
   w==;
X-CSE-ConnectionGUID: ejueZuzTRHOLyplIDnJ0GA==
X-CSE-MsgGUID: TSwY/vFASaOIYPLsG/HSyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="52154280"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="52154280"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:08:49 -0800
X-CSE-ConnectionGUID: csRhl/YrR3mh6V3vjCg1UA==
X-CSE-MsgGUID: aB5X0TIERP63avd4sWT1og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="187454619"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 08:08:39 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH2XJ-00000006BqD-4AI9;
	Thu, 06 Nov 2025 18:08:33 +0200
Date: Thu, 6 Nov 2025 18:08:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
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
Message-ID: <aQzIAd91tlR3o9hu@smile.fi.intel.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com>
 <aQzGY4AKiMQpuL0R@yury>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzGY4AKiMQpuL0R@yury>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 11:01:39AM -0500, Yury Norov wrote:
> On Thu, Nov 06, 2025 at 04:44:31PM +0200, Andy Shevchenko wrote:
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
> > 
> > Also can be made as
> > 
> > Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]
> > 
> > The positive effect that one may click that on Git Web.
> > Ideally, of course, would be an additional parses on Git Web kernel.org uses to
> > parse that standard "commit ...()" notation to add the respective HREF link.
> 
> Those flying over Atlantic or cruising cross Caribbean would disagree. :)

They won't. The purpose of these Links is described in the above commit message.
Even they read the commit message before clicking.

-- 
With Best Regards,
Andy Shevchenko




Return-Path: <linux-edac+bounces-5228-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BFC13BF5
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84AB33BD136
	for <lists+linux-edac@lfdr.de>; Tue, 28 Oct 2025 09:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F72FF171;
	Tue, 28 Oct 2025 09:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n9zCCMZw"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164D22FBE01;
	Tue, 28 Oct 2025 09:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642954; cv=none; b=JphqEp6s8gJ1imcrfcaJMbdGU9IpojAr6Zl9B0+SEzqlnrWKeUM1LwmiMo6taD3RfDv3uZnKaq+OOMAWZJjxRfK2gxliBs/loZj2IktkVPMiZFxNFGOnq34oJMRxey7REctgbXmy8B9uRdCWK9p3mykw7Tvdpzvvm3+lmlUrrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642954; c=relaxed/simple;
	bh=W+e7hOA/Qjutz+64AuQHJm7aMHFQ0pGvnRZi62DxLWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUSwDFt2dzmyySb2DknIwK0ua9T0c4DtaUGygjUrlkdvRq0TO7QoZvncRsUb5we5dsteMqoVLNnz+2XD66iAghI09m7ZgXHVgOpJr3DBq2Qmx/DkoOphxi4aYGAo7rzqQSRTL9xWHdouRWdv961gzIQLPKd2BwzTZXBBWhkuMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n9zCCMZw; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761642953; x=1793178953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W+e7hOA/Qjutz+64AuQHJm7aMHFQ0pGvnRZi62DxLWw=;
  b=n9zCCMZwpg7yYXyQJ5E/5p47j5fHaSQ647GdkYOOeFBZZSJnCcrIXnyy
   haMQSSmaLZC/6OLfz824/Iq5bCjKZdh342K8gOUGjoPuHB7aXIagn3DF5
   UpO73MarRvl2ojoBytnTqNygNL3S5SPRAI2/ZbcPa27tUHag+YeKlGkEv
   3k649awmHNtz8t0u1KCtUekGqxjkzFxy1BbHRrgeiPCmyHhBIzz6zivTf
   Wq162eQBu+homhgDJUTeCpuY+49B2pM4vOhV+m6ZDm3Udgb7tadRY4ItN
   3i/erWOQt3cOlglNmXJNBUUv9+AnfP/sQNHrMrYVrFlyKPKovPBMJZfz1
   Q==;
X-CSE-ConnectionGUID: KpoiZD8QRAqjDACwTVDHTg==
X-CSE-MsgGUID: Dy3LcW3aSDamFIjGD5X4Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74024500"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74024500"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:15:52 -0700
X-CSE-ConnectionGUID: HnXMTj+ZTTS4uXqyEjc08g==
X-CSE-MsgGUID: 6qzZimyUSheG9U+2/VGM3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="185624057"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.136])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 02:15:41 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDfnk-00000003GRk-3M7B;
	Tue, 28 Oct 2025 11:15:36 +0200
Date: Tue, 28 Oct 2025 11:15:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
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
	Yury Norov <yury.norov@gmail.com>,
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
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v5 11/23] bitfield: Add non-constant field_{prep,get}()
 helpers
Message-ID: <aQCJuADNYTzdbPQJ@smile.fi.intel.com>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <bf68a22ce5be93bb2ea0a0c53071433814401ff9.1761588465.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf68a22ce5be93bb2ea0a0c53071433814401ff9.1761588465.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 07:41:45PM +0100, Geert Uytterhoeven wrote:
> The existing FIELD_{GET,PREP}() macros are limited to compile-time
> constants.  However, it is very common to prepare or extract bitfield
> elements where the bitfield mask is not a compile-time constant.
> 
> To avoid this limitation, the AT91 clock driver and several other
> drivers already have their own non-const field_{prep,get}() macros.
> Make them available for general use by adding them to
> <linux/bitfield.h>, and improve them slightly:
>   1. Avoid evaluating macro parameters more than once,
>   2. Replace "ffs() - 1" by "__ffs()",
>   3. Support 64-bit use on 32-bit architectures,
>   4. Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
>      actually constant.
> 
> This is deliberately not merged into the existing FIELD_{GET,PREP}()
> macros, as people expressed the desire to keep stricter variants for
> increased safety, or for performance critical paths.

Some comments below, but FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
after addressing them.

...

> +#define __field_prep(mask, val)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __val = (val);				\
> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__val << __shift) & __mask;	\

Unaligned \

> +	})
> +
> +#define __field_get(mask, reg)						\
> +	({								\
> +		__auto_type __mask = (mask);				\
> +		typeof(mask) __reg =  (reg);				\
> +		unsigned int __shift = BITS_PER_TYPE(mask) <= 32 ?	\
> +				       __ffs(__mask) : __ffs64(__mask);	\
> +		(__reg & __mask) >> __shift;	\

Ditto.

> +	})

> +/**
> + * field_prep() - prepare a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @val:  value to put in the field
> + *
> + * field_prep() masks and shifts up the value.  The result should be
> + * combined with other fields of the bitfield using logical OR.
> + * Unlike FIELD_PREP(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_PREP() directly instead.

Shouldn't it have Return section as well?

> + */
> +#define field_prep(mask, val)						\
> +	(__builtin_constant_p(mask) ? FIELD_PREP(mask, val)		\
> +				    : __field_prep(mask, val))

Personally I would give it a single line (but it's up to you, folks).

> +
> +/**
> + * field_get() - extract a bitfield element
> + * @mask: shifted mask defining the field's length and position, must be
> + *        non-zero
> + * @reg:  value of entire bitfield
> + *
> + * field_get() extracts the field specified by @mask from the
> + * bitfield passed in as @reg by masking and shifting it down.
> + * Unlike FIELD_GET(), @mask is not limited to a compile-time constant.
> + * Typical usage patterns are a value stored in a table, or calculated by
> + * shifting a constant by a variable number of bits.
> + * If you want to ensure that @mask is a compile-time constant, please use
> + * FIELD_GET() directly instead.

Ditto.

> + */
> +#define field_get(mask, reg)						\
> +	(__builtin_constant_p(mask) ? FIELD_GET(mask, reg)		\
> +				    : __field_get(mask, reg))

As per above.

-- 
With Best Regards,
Andy Shevchenko




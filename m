Return-Path: <linux-edac+bounces-5394-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C58C3BDC9
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 15:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 351063BE35C
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 14:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7B13446AA;
	Thu,  6 Nov 2025 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fax+zxpM"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFD333452;
	Thu,  6 Nov 2025 14:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440290; cv=none; b=WjRiefYGf7V43Uxq7onSqAGGZQd8FUTLfzZpxVT5qL/h6EcPlJ+2dK0tDZQmrmbTLDfPJlDYpfZmAyrXXHCHtEVA4joCSdrQaE3VwlbZjXvOyl1TaacKru0Qqr4X0yXyz/7uwtq6kcWIfcAqqji7TPg6OpW5q8mtUEAURyfBdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440290; c=relaxed/simple;
	bh=CgKPrhlOB1S3JfrLDg6vTp5p6jX2SaUAEva586MhNWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBE25pI6piR2UgJDDxuJKFcFtd1u9io4eI4H2pP2NviygEYCl/MOJpaG1e1P+Qzr6LVP2VUDauQdA0T/iWDE3b1KTD4BOe4jeScDk7bzer3QfR5HhATiaau/yclOyb6cz0THp3i871qgs9dSFsH4vd32eZCIucpCjR1073sbrA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fax+zxpM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762440289; x=1793976289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CgKPrhlOB1S3JfrLDg6vTp5p6jX2SaUAEva586MhNWo=;
  b=fax+zxpMdBxZi35qiqTykfwB6NxjRR0GNIAr01NQb0RVM6mjAnSNDiCH
   vIa91xikfQjVpGD36bqnHrb+m0Zz3LAPg0IiENMJq01TrcXrorZstpwgF
   6ev/EQ6JHzEbB44agCHyyZbX3/T8Fi1PdZljmcibvU0bWLKalPJeFJaMr
   noF4o3RxCwDQbqtKbj1AIMaReTnn6Cdb6NGhUWj0I3au7eAJmLnCD3Rpv
   QK8o7vzY/fUxouq5OdaRzBXJuQQnoslS7UXfOxZO96NLsKhvPepPa3OZ4
   EecKtraIzDXm++jWkgA7liwsRrlVEty6aMQ7HHzhQWovKqDOeNKEhb5/J
   w==;
X-CSE-ConnectionGUID: X4URzY64S1CYg1oFnFmOFQ==
X-CSE-MsgGUID: ZU5VHBv8Sk2cO48/r3umPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64504252"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64504252"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:44:48 -0800
X-CSE-ConnectionGUID: kvm5eJDVRiSb47UCQQrdxA==
X-CSE-MsgGUID: 2tiTZfdERMmRL0zFQqehgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; 
   d="scan'208";a="192819498"
Received: from abityuts-desk.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.224])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 06:44:37 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vH1E0-00000006AO5-06YC;
	Thu, 06 Nov 2025 16:44:32 +0200
Date: Thu, 6 Nov 2025 16:44:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
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
Message-ID: <aQy0T2vUINze_6_q@smile.fi.intel.com>
References: <cover.1762435376.git.geert+renesas@glider.be>
 <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 06, 2025 at 02:34:00PM +0100, Geert Uytterhoeven wrote:
> The BUILD_BUG_ON_MSG() check against "~0ull" works only with "unsigned
> (long) long" _mask types.  For constant masks, that condition is usually
> met, as GENMASK() yields an UL value.  The few places where the
> constant mask is stored in an intermediate variable were fixed by
> changing the variable type to u64 (see e.g. [1] and [2]).
> 
> However, for non-constant masks, smaller unsigned types should be valid,
> too, but currently lead to "result of comparison of constant
> 18446744073709551615 with expression of type ... is always
> false"-warnings with clang and W=1.
> 
> Hence refactor the __BF_FIELD_CHECK() helper, and factor out
> __FIELD_{GET,PREP}().  The later lack the single problematic check, but
> are otherwise identical to FIELD_{GET,PREP}(), and are intended to be
> used in the fully non-const variants later.
> 
> [1] commit 5c667d5a5a3ec166 ("clk: sp7021: Adjust width of _m in
>     HWM_FIELD_PREP()")
> [2] commit cfd6fb45cfaf46fa ("crypto: ccree - avoid out-of-range
>     warnings from clang")


Also can be made as

Link: https://git.kernel.org/torvalds/c/5c667d5a5a3ec166 [1]

The positive effect that one may click that on Git Web.
Ideally, of course, would be an additional parses on Git Web kernel.org uses to
parse that standard "commit ...()" notation to add the respective HREF link.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

...

> +	BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >		\
> +			 __bf_cast_unsigned(reg, ~0ull),		\
> +			 pfx "type of reg too small for mask")

Perhaps we may convert this (and others?) to static_assert():s at some point?


-- 
With Best Regards,
Andy Shevchenko




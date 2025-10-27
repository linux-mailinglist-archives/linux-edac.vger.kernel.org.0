Return-Path: <linux-edac+bounces-5226-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FFFC11697
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 21:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29913A9312
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 20:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2DC3168E3;
	Mon, 27 Oct 2025 20:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D0FvDvo6"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3C73054FA;
	Mon, 27 Oct 2025 20:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597457; cv=none; b=nUMj47UFRN84F7LSYpJKZ+5h/03rxDtrnLczOeo60GDa14LI+nNVc7Ygi/FwceYxNaFELyvFqlJKhiNAGZgu4qHXwp/RYrtLAI1cqwRhHQGMkyYiZL0yR6cEyoktCfsqZbdRLE8S+UsxWrrEqEQ9aY1PJQKnnz8fTuVazmHKEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597457; c=relaxed/simple;
	bh=5m1IrsDTkf+F/nhzqJRjiWrZIfJDK8f7MvjheZ4CUKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CP/dmW+0WfJj5gL3EzZQNEGCMci9r4BvFTFa9PUQCi+rnzXaStbsVHZAH1xgaIDLUE88y44xzIbzmmrZkeS4J0Bhz7GmzGC1gjqFCMOZeSiKM4sHu9G+2iOFTBecMbrqKm8pZySH/FRab3/ipu2oxGIYDHNqf4vfwSvR/thYWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D0FvDvo6; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 199381A16C2;
	Mon, 27 Oct 2025 20:37:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D91106062C;
	Mon, 27 Oct 2025 20:37:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B6F94102F2494;
	Mon, 27 Oct 2025 21:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761597449; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ivu3nqaTqww2kM8ddgXsb86XR8Ecjso6qu9XWZHw9NQ=;
	b=D0FvDvo6wBdzyM4yGf/Mo92JGsnDp3FEhnzQXToKT1lTmRgmCAobeQwwgIerEldSavB9Wj
	8Fa1YqUSJN1a+KiX1LsgxoTiLAWFpjtTkZ/psXHq539twWXUsfVfZ1tOA47yFwLd40ImsE
	G9WDXQxl4673JnnqnSaS0aJnztT1jPuWGeK5RQylZ1VZl0DiiBjKRSdLHbVPGru9aMBn/L
	/NPFjf5YF1MLpjQf7UlDDcAIkfmZHS4oVHjAeodKNVAVJDdwuc8RjEgecO9ymeKN374J5m
	aI0g1qxMk56Vwb3LCXgHJanQvqdAAA00oe5CNpFNb2x5v0Y/CqIa0frpfHITdQ==
Date: Mon, 27 Oct 2025 21:36:40 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 01/23] clk: at91: pmc: #undef field_{get,prep}()
 before definition
Message-ID: <20251027203640291d726b@mail.local>
References: <cover.1761588465.git.geert+renesas@glider.be>
 <a26cfb39f4ac309ffbff339ffa5f54db12bd8c12.1761588465.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26cfb39f4ac309ffbff339ffa5f54db12bd8c12.1761588465.git.geert+renesas@glider.be>
X-Last-TLS-Session-Version: TLSv1.3

On 27/10/2025 19:41:35+0100, Geert Uytterhoeven wrote:
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> --
> v5:
>   - New.
> ---
>  drivers/clk/at91/pmc.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
> index 5daa32c4cf2540d7..78a87d31463e98b0 100644
> --- a/drivers/clk/at91/pmc.h
> +++ b/drivers/clk/at91/pmc.h
> @@ -117,7 +117,9 @@ struct at91_clk_pms {
>  	unsigned int parent;
>  };
>  
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  #define ndck(a, s) (a[s - 1].id + 1)
> -- 
> 2.43.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


Return-Path: <linux-edac+bounces-5417-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 51830C43EC4
	for <lists+linux-edac@lfdr.de>; Sun, 09 Nov 2025 14:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE719347453
	for <lists+linux-edac@lfdr.de>; Sun,  9 Nov 2025 13:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8844F2F9D9A;
	Sun,  9 Nov 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUq4YlSc"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4828717BA6;
	Sun,  9 Nov 2025 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695333; cv=none; b=MpKVJAgTETsc86WN8U2w9jMO+edx2w/eHwihIZeYdKxi0NKGE9TQwgUSP6lSpmgfaruYZj50f9tGanxab4qltwKA/gkooMmkbnTX9D7kfhu/C+7NQeGQheDOMOphS1TEjDUiDIgXrEu0/4xex9VBzxH0OnfB8tJ+22NqJlQR1r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695333; c=relaxed/simple;
	bh=75xVTH6rL41i5gNYi5D5wNYFSB4OID9FByUjwxNSe6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUtmBsdAhKlgKE3w2Ah9P0eF5eTqD03qFfjma16Q+q2MNVyQncG6qTAYhjejr3qM1ILAKOG0W+ME47/EOk/ABSA4O2xyzvLIAcBIYXfdQoqEsfuZ+GvPBQmLF/K7Kymp+7EAxcbvZUZ/kCVvVZn94w0aiWc0hmA9i25Myxq5Yqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUq4YlSc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73F0C19423;
	Sun,  9 Nov 2025 13:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695333;
	bh=75xVTH6rL41i5gNYi5D5wNYFSB4OID9FByUjwxNSe6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OUq4YlScR9Yr3lqdI8+Yp0fI/C5dkrRC8Cq+F3uyLXMiZuA7Hfzg0VIC4P2u9QNCf
	 C9AHZ2WTv5ZZUwgeHDjJ7ysaW4HPELl7S/VLwzmiEWmH9x7XuuSN+Ln99YomjKvbMq
	 i3MhKBHc5WBbb6gdQpeOjbaUu7qebuQ00zSVfr+hMjBXHDv4tF+JB3hNcGYAPVP0Bg
	 YBFDxk8I51LYyPl31nWk18LZDNHXhTQPG0l9XQKqXzTP5bnECbCZypFzgHezD1SqP0
	 VkIWa5JPPo0EKvKltofU/ebvRFI1V7map8EhrzGaM4iK3tb4gIY5z3XHz3ztCpG+JO
	 I0PjTLazIvM+Q==
Date: Sun, 9 Nov 2025 13:35:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, David Miller <davem@davemloft.net>, Linus
 Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun
 Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Johannes
 Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex
 Elder <elder@ieee.org>, David Laight <david.laight.linux@gmail.com>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Jason Baron
 <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck
 <tony.luck@intel.com>, Michael Hennerich <Michael.Hennerich@analog.com>,
 Kim Seer Paller <kimseer.paller@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Biju Das
 <biju.das.jz@bp.renesas.com>, Jianping Shen <Jianping.Shen@de.bosch.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Vignesh
 Raghavendra <vigneshr@ti.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 05/26] iio: dac: ad3530r: #undef field_prep() before
 local definition
Message-ID: <20251109133513.195e6baa@jic23-huawei>
In-Reply-To: <a2466d9201cb8c25504e25ac531a69ef8bd6e958.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<a2466d9201cb8c25504e25ac531a69ef8bd6e958.1762435376.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 14:33:53 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Prepare for the advent of a globally available common field_prep() macro
> by undefining the symbol before defining a local variant.  This prevents
> redefinition warnings from the C preprocessor when introducing the common
> macro later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> ---
> v6:
>   - No changes,
> 
> v5:
>   - New.
> ---
>  drivers/iio/dac/ad3530r.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
> index 6134613777b8e1d4..5684d11137f29948 100644
> --- a/drivers/iio/dac/ad3530r.c
> +++ b/drivers/iio/dac/ad3530r.c
> @@ -54,6 +54,7 @@
>  #define AD3531R_MAX_CHANNELS			4
>  
>  /* Non-constant mask variant of FIELD_PREP() */
> +#undef field_prep
>  #define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  enum ad3530r_mode {



Return-Path: <linux-edac+bounces-5279-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D57C28D6C
	for <lists+linux-edac@lfdr.de>; Sun, 02 Nov 2025 11:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DFD5B4E271F
	for <lists+linux-edac@lfdr.de>; Sun,  2 Nov 2025 10:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5189223D7D7;
	Sun,  2 Nov 2025 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YojVFjn8"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E62534D3BA;
	Sun,  2 Nov 2025 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080222; cv=none; b=sFzI8Z+HtEjM7X8/nqWKH+K4KW/D5eaCFMBBNnJJRJy4BQZSkoGjbePVurm1YsQvWvLG9zwXvb4A9bpC8iiIMM3x3xtpFzpLL4u65KXRG+k6SUZrPlOQIISM4GZW7EjqUMP/1nL4MwDqxh7Wby2FFLAkkIelHaRea+aiE2fRNQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080222; c=relaxed/simple;
	bh=4u8d6QQgjLsALEyZL0hM355ahA8pgo9Ke2RDvhyV/FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YcRFsyeTdzBB1FAc1+kdF1Xx7mYh/iBAnsBPke+spVFGtOJ+Gkruz8olYvwD2uH8e2GYs4NZsXIbo78AIOwtQQm3cNGb2fppvj45jwPpY1DtLjJZ7GOsFeR1Wb3QNs7xf/rWr5NNhNsUzTDJb6TmFsmLg1bCJQyC3cXcthsqb3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YojVFjn8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E047CC4CEF7;
	Sun,  2 Nov 2025 10:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762080221;
	bh=4u8d6QQgjLsALEyZL0hM355ahA8pgo9Ke2RDvhyV/FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YojVFjn8WsOc90BQ7IjaCvSpawTY/iFM2EPhYDD5dnGWRgy1V9yvL/MEqZ0TtAlR7
	 bOb/fXVYiil59qXvBq/U3REBPlb5nBkGwDqRIYMBz5I0KEBRnvT5ZEiaYzNyd6y9Zf
	 5IIUOWr69e6TstOOUFAcseA/Uh3WnpVn2+gfAVjCfVQRnOUA5ypJyOfrOHReuHp7Sg
	 WGYh/9kMA2mX62kCZYu70IxtgYDcwIcClH+HreNxArWG+BioiWd94cJCtOu6NOrbBI
	 1yerwBgfvmBsmLmV1VasI237/BiNNQOhrrQMTL8p3/eC2uQh+6fEkO+1LfX3YVL0KT
	 1QsxP0qktpdJg==
Date: Sun, 2 Nov 2025 10:43:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Miller
 <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun
 Hung <schung@nuvoton.com>, Yury Norov <yury.norov@gmail.com>, Rasmus
 Villemoes <linux@rasmusvillemoes.dk>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Johannes Berg <johannes@sipsolutions.net>,
 Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, David Laight
 <david.laight.linux@gmail.com>, Vincent Mailhol
 <mailhol.vincent@wanadoo.fr>, Jason Baron <jbaron@akamai.com>, Borislav
 Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Richard Genoud <richard.genoud@bootlin.com>, Cosmin Tanislav
 <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, Jianping
 Shen <Jianping.Shen@de.bosch.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org,
 qat-linux@intel.com, linux-gpio@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v5 10/23] iio: imu: smi330: #undef
 field_{get,prep}() before definition
Message-ID: <20251102104326.0f1db96a@jic23-huawei>
In-Reply-To: <97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
References: <cover.1761588465.git.geert+renesas@glider.be>
	<97549838f28a1bb7861cfb42ee687f832942b13a.1761588465.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 19:41:44 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

So this is going to make a mess of merging your series given this is
queued up for next merge window.

I can pick this one up perhaps and we loop back to the replacement of
these in a future patch?  Or perhaps go instead with a rename
of these two which is probably nicer in the intermediate state than
undefs.

> --
> v5:
>   - New.
> ---
>  drivers/iio/imu/smi330/smi330_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> index d9178725ade3da83..a79964fe68fadf47 100644
> --- a/drivers/iio/imu/smi330/smi330_core.c
> +++ b/drivers/iio/imu/smi330/smi330_core.c
> @@ -68,7 +68,9 @@
>  #define SMI330_SOFT_RESET_DELAY 2000
>  
>  /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> +#undef field_get
>  #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +#undef field_prep
>  #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
>  
>  #define SMI330_ACCEL_CHANNEL(_axis) {					\



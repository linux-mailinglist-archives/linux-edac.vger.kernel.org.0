Return-Path: <linux-edac+bounces-5416-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18183C43EA8
	for <lists+linux-edac@lfdr.de>; Sun, 09 Nov 2025 14:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA1BF3A56D3
	for <lists+linux-edac@lfdr.de>; Sun,  9 Nov 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C354E2F998A;
	Sun,  9 Nov 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQyQz3Xu"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF517BA6;
	Sun,  9 Nov 2025 13:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695295; cv=none; b=aG0u7k5Q79/Cygjzz31EqRbIW4bnQXPDkkmmQvrRySrN7iyxU0ixdm4YLhGADgo/S9sFft/JdkKIZEXeZa6h7JwnDv8YbZliLz7a/0rFDmYX1JUGeJjJwrsFlmVrGXum2/JgVbr45Ezy9SWHL3cV+udbg5KnMht4kb2ExsDJNt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695295; c=relaxed/simple;
	bh=RT2rRE/ELY9bGrDnosbnveAK4kjkneS/XTqVsxUylns=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tsm4n4Up7zw1iSUisWDASM00BWiB/1yzZQr4hcr6IUX+TgO6s6QixPHorSFPV9+S/Qu8vxoS2bQXmuln6C2iYnEAtn4BzbSuxcCBsZqHaMmkPXDmuXs1M+0zWvJCn/yjzdP4zu+UOPFZuyxUvD5Iu8UVxHu+JVSPTRuN4CKxvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQyQz3Xu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06534C19422;
	Sun,  9 Nov 2025 13:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695295;
	bh=RT2rRE/ELY9bGrDnosbnveAK4kjkneS/XTqVsxUylns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQyQz3Xu/4ch5jjTTPDSBjeBVRNEYduCHsh+EDx3P6FlYJVpOQX6pKco9OgMOx/in
	 F80rjoMsLS/7XLxYrF1FBo4MLkHRajQPKOTIZOaC/6fi4uIG17iRyOJ0/gCowNRs1d
	 ppYRn1q4Dml/h8MeJM8+xvbkn6hxSYS0Z2rnmdV3FUTzsqvHwhUI9R7XecGmL4AZ66
	 FwIhhM5L3YI62kDlehONx8TWE1Va+28/8EvO//yU3GevKDsQAA9ma5ZjkVGW1Wx847
	 0ivPCgE6pzDWEvB89x/gYKximcAcQCf/eOzmpaCr0FWO1PrXAbtfbX3KfScts9bAF9
	 YRGLPkFrZYHmA==
Date: Sun, 9 Nov 2025 13:34:39 +0000
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
Subject: Re: [PATCH -next v6 10/26] iio: imu: smi330: #undef
 field_{get,prep}() before definition
Message-ID: <20251109133439.3d841b5b@jic23-huawei>
In-Reply-To: <54c739d05673e512d091bf78e54cd00e3655d7d4.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<54c739d05673e512d091bf78e54cd00e3655d7d4.1762435376.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 14:33:58 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
> 
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
I tweaked the original driver to avoid the naming clash so this can be dropped
and we can replace with the new function next cycle.

Thanks,

Jonathan

> ---
> v6:
>   - No changes,
> 
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



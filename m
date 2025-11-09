Return-Path: <linux-edac+bounces-5419-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD3CC43EF7
	for <lists+linux-edac@lfdr.de>; Sun, 09 Nov 2025 14:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D4054E2C3F
	for <lists+linux-edac@lfdr.de>; Sun,  9 Nov 2025 13:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD252FABEE;
	Sun,  9 Nov 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRuJdceF"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED02F9C2A;
	Sun,  9 Nov 2025 13:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762695561; cv=none; b=jSiprsBlkmk8dIAyll7LjIQTVt/vqWfITlCXM1moeQp4q/DzI6cB6ydF3guQ5TkdQrNOzqBd9NJH5m67Ud7ky6Br5SYvC4bLQrFQN7tP/2ENa8zZ5v7/juVbVoN7TWgTzmG3a+zeHqWquAxYSrlwtld8U3Oz4HEfOgU0zI3SlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762695561; c=relaxed/simple;
	bh=TmS8CkFMzA8p257zgP8ajlZZj7NKktorZzJfGu8kADk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oxPMtn2895LE8umcn2gLyZtWIGE4By/VkBSj7G/Qib0Lpm/tqGoR+eXIf+b/oZL+6C5Ph5FZTBiPjuPOPCGD3j9ko1i+crZ8aDl33bV3sb+kALOzrm42kPXoqc629Du+fFoWfg22Tr+lwbHW9w2XETGQ5uafLDP8DIAWQRkPVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRuJdceF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3DF5C4CEF7;
	Sun,  9 Nov 2025 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762695561;
	bh=TmS8CkFMzA8p257zgP8ajlZZj7NKktorZzJfGu8kADk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eRuJdceFQsdR7lWVjZXcQ5eo2LTrpkwCjVnhqhWqMgsWHpPaOmCSWAruleR0rDa3c
	 zewmxH8r/ugX+Auz1z/GzwLYEmryJP7Yxt9ENJ0AKXlgrY5A6lsFG5/fgdl/WlQuI0
	 wm5J1acBHw4E/gK68u06+opel8VRhYcrJcvtOFcncyLFMAVSPe89x4T+DcAQy3aEQQ
	 oX85a3JCzSZAbUxwWvjBgSMTrD8mI2+wsSwQYY/Cvor7FYRe2eXlHmti2qvQabVS0/
	 o+scmlpg9ZtBwS6CeH2c/exLXcnhRK2SIJLAmWLQvpPhhKxsXEyIVR2Jv6uyzWZ37T
	 Qr+4vzbXZuRrg==
Date: Sun, 9 Nov 2025 13:39:04 +0000
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
Subject: Re: [PATCH -next v6 23/26] iio: imu: smi330: Convert to common
 field_{get,prep}() helpers
Message-ID: <20251109133904.5eff2558@jic23-huawei>
In-Reply-To: <a2275bd69f25d33f9fd3345409b2d8ae6285b9a7.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
	<a2275bd69f25d33f9fd3345409b2d8ae6285b9a7.1762435376.git.geert+renesas@glider.be>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 14:34:11 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

This will need a revist next cycle. I preferred not to have
the odd looking undef in the driver at introduction so prefixed with smi330_
instead.  Only one instance so it wasn't worth comments to make ti clear what was going on.

J


> ---
> v6:
>   - No changes,
> 
> v5:
>   - New.
> ---
>  drivers/iio/imu/smi330/smi330_core.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
> index a79964fe68fadf47..83e0dff5d973d046 100644
> --- a/drivers/iio/imu/smi330/smi330_core.c
> +++ b/drivers/iio/imu/smi330/smi330_core.c
> @@ -67,12 +67,6 @@
>  #define SMI330_CHIP_ID 0x42
>  #define SMI330_SOFT_RESET_DELAY 2000
>  
> -/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
> -#undef field_get
> -#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> -#undef field_prep
> -#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
> -
>  #define SMI330_ACCEL_CHANNEL(_axis) {					\
>  	.type = IIO_ACCEL,						\
>  	.modified = 1,							\



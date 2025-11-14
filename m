Return-Path: <linux-edac+bounces-5440-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008AC5B2C7
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 04:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 236934E9F4A
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 03:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A124503F;
	Fri, 14 Nov 2025 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbhDdqwF"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CC24A06A;
	Fri, 14 Nov 2025 03:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091378; cv=none; b=Egd14qJqddkmHtMZl5aB5PiHT92VwWR4apFEIOVRdXJ0xKQhAIoBE+E+6ufO9ASepn1H7UxCQMrg/5UoSI8Dr80yzO3oSVNSyYLpeUgrxqtnXAwvvXyhtjYevPbtjjTvjdE029U0ic2AT9EEbFRF6Chr7Yj8IB5cdVhwcJ4IcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091378; c=relaxed/simple;
	bh=e8ElaGLVs0ZXIidppeit0GTFsXLIst72ZPvNyqlcBeo=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=ZktPDBrtUs6u9MxTE1kbS+KKI9LGqxhNjtokGxCgA/2xMmmVg423vF9bvHNorT36moMmX2xQSYdNP0G1z0BGJW7akP0FF5j6j0a5vrQ/Nybp/Lm3+D9SiI5vkKdO+QOi6a5LN/3X7bOdVIzxEXgkq93lIh36ocndWg5nktfWUq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbhDdqwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7F8C4CEFB;
	Fri, 14 Nov 2025 03:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763091377;
	bh=e8ElaGLVs0ZXIidppeit0GTFsXLIst72ZPvNyqlcBeo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=tbhDdqwF9XpCDi3pVqiqNgIch0HShB/yYd1ka0AwVdC+bOXpqi8QpHOF36kKIQDVJ
	 W9Fqb9uCdu3OzhrvB6nxrkDvC5y+mwFz5hdwHJ+WHBwQYQ77fW08pkg0ZJN+u7Laci
	 4Gs0r7r7So3tmi+amca6/mtiiFqrqhzy18oCDsCnbcjWskVr1Eo25ospa9SvQpLxHh
	 eT6coU/VMg6E5hyQXinw7d/wUAJzwIiDh4PWpNPSlhfSr8SIfgaXMNCRAoCfAwYt6j
	 qWdzz0GBWHwq/kVFf5ibNFK1orM3M5OqEQCm+1rihFETO7eiKiH7GCz7yy3c5SrOCk
	 V8hA+zCsxIMSQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <939d8c6da1f468026b1bb201413ba08b1d0751fd.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be> <939d8c6da1f468026b1bb201413ba08b1d0751fd.1762435376.git.geert+renesas@glider.be>
Subject: Re: [PATCH v6 01/26] clk: at91: pmc: #undef field_{get,prep}() before definition
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Elder <elder@ieee.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Cosmin Tanislav <demonsingur@gmail.com>, Crt Mori <cmo@melexis.com>, David Laight <david.laight.linux@gmail.com>, David Lechner <dlechner@baylibre.com>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jacky Huang <ychuang3@nuvoton.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Jason Baron <jbaron@akamai.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, Joel Stanley <joel@jms.id.au>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Cameron <jic23@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen <l
 ars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Richard Genoud <richard.genoud@bootlin.com>, Richard Weinberger <richard@nod.at>, Shan-Chun Hung <schung@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Tony Luck <tony.luck@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>
Date: Thu, 13 Nov 2025 18:29:10 -0800
Message-ID: <176308735088.11952.13929313934390378381@localhost.localdomain>
User-Agent: alot/0.11

Quoting Geert Uytterhoeven (2025-11-06 05:33:49)
> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
>=20
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


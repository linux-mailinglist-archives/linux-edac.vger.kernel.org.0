Return-Path: <linux-edac+bounces-5438-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E02C5B2BE
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 04:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E713A4E819E
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA77526B098;
	Fri, 14 Nov 2025 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7nI17pR"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD21FE451;
	Fri, 14 Nov 2025 03:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091373; cv=none; b=XmezAF9S04I9aOLP3gy1mkIqo2AdvQjCBQWx/vjiolRtSoJpns55G7LaO7A2+fSv67fY9LXOgDO9n2dwG7P8dEbNYavJKBdLedKdI7loi7DtI2FHG48aPLVqS5QVokarzJLpx0Ow0YtceeMiEPyUcuoDr/QB3xs92JsQfOVfwq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091373; c=relaxed/simple;
	bh=XRBfI7gCdxMfJLaXkHGy03GrbCVok28+ep4vK2GpY1c=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=aYT8HWXq+gWkAUyEDBPV6vZx8DWSrFNuUUsOrRijUUqT2PeT05lzVTqPYeJEJv7wyHYXgstqunBuqWNq77e3UmsqqGW+YcQHGX5eMXokjQLWzmKuxr7vstqwQoyzMWcJDZT0z3M8v9IZsBE1NjDVXebY+eM2jw4huCOoFr0MRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7nI17pR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05FF0C19423;
	Fri, 14 Nov 2025 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763091373;
	bh=XRBfI7gCdxMfJLaXkHGy03GrbCVok28+ep4vK2GpY1c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=n7nI17pRMr1dpfHfU2p0leMeiTeGE8hGKpnT0L8rT84fp93GxrptMg6I85MhEEu6T
	 jyeqVOKpyqNzeKFNanO6fWFdZwxn6N3Wqf2owP5E/4c0JWPkfJYmjEvIloXNPX849E
	 gatEJlaoTBG+p9Azfktd/4kpOVjULM4CdfUK4xbcKwxEcG/DBSpTSBRssx6CQJk3Az
	 QySIcw+Uaeh/dF932gRgnoCwdYt7BV0K+D4VNI4432FRZdIhY2pHnK8ZR30izZsUbk
	 3Losz5abqvpVbFbdNjSRwRRKTMPBTkgKEh2ILGFEgutOUgGfL3HypQyjhc7D4CWY+9
	 knhAzy9slS43Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be> <7414c080bbacc3c5be00c0eec4f5cbca386acaf3.1762435376.git.geert+renesas@glider.be>
Subject: Re: [PATCH v6 14/26] clk: at91: Convert to common field_{get,prep}() helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Elder <elder@ieee.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Cosmin Tanislav <demonsingur@gmail.com>, Crt Mori <cmo@melexis.com>, David Laight <david.laight.linux@gmail.com>, David Lechner <dlechner@baylibre.com>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jacky Huang <ychuang3@nuvoton.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Jason Baron <jbaron@akamai.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, Joel Stanley <joel@jms.id.au>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Cameron <jic23@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen <l
 ars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Richard Genoud <richard.genoud@bootlin.com>, Richard Weinberger <richard@nod.at>, Shan-Chun Hung <schung@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Tony Luck <tony.luck@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>
Date: Thu, 13 Nov 2025 18:26:57 -0800
Message-ID: <176308721705.11952.11835271974430936980@localhost.localdomain>
User-Agent: alot/0.11

Quoting Geert Uytterhoeven (2025-11-06 05:34:02)
> Drop the driver-specific field_get() and field_prep() macros, in favor
> of the globally available variants from <linux/bitfield.h>.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>


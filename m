Return-Path: <linux-edac+bounces-5439-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 28703C5B294
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 04:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99C46355FB9
	for <lists+linux-edac@lfdr.de>; Fri, 14 Nov 2025 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C49726E711;
	Fri, 14 Nov 2025 03:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzOAb5rU"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E880826E179;
	Fri, 14 Nov 2025 03:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763091376; cv=none; b=plzguvMN7UR709C+n1sVAS2zb6Pjrutj1QKaQMUBS7peb0ESEMexaELOT6U8W56CEsFx8o1nAdjGsjuzR1XFtY8lDZ0UJLCDhAoOCVtIH9DbVMOnXvveAOI4+9MV34I2rDZLS73NuGqDNi3EQDGPWiYwquCqCyuhSQNKT5HL5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763091376; c=relaxed/simple;
	bh=To+6ZaYy+eiRsC0ioX7VEavjbMju6hQPTprPPzDVZjU=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=pUP0ezfMV/859SrOhnD79TkK2J/EqX4ebIRy94E1ROTixBj9S+AtpUKqWeL12xWV13Hwc/JHo86DmApV7qNZt4LNHTXQKmWO7UI6rjFpJAuQy+od7QR1Zeu3kypM6BIFVQU6oRP3WhO2GKE7bRrKI2XSH2rF8QE77OnnLCJvJXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzOAb5rU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE349C4CEF1;
	Fri, 14 Nov 2025 03:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763091375;
	bh=To+6ZaYy+eiRsC0ioX7VEavjbMju6hQPTprPPzDVZjU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=OzOAb5rU0m6IeVwvdPx8/jYfCbjGlii0+BThQKKDG6BaMR6U2pMUMxBvvOE03rVK2
	 H8IkOkt7SKe/Vis6y5odzcJLKGY282asdENvNKAZHHtw3Tc0FR42roTN1Pr3bz30N1
	 pKMJN4F68jmmCH4PhnUkdbpGQe9WTfMImZHBRel/01NsaVx7a4pgvLIJyDpq8FkEvS
	 F7gyMdAMGLzRi8Guo0ld5xVF96CEBKAFVs6HD0ZDejQ3hNlhg87beqX3qtJuwj084H
	 gw6LYZ6S5ehc61/nZhd+ctL++INzK/rCm61qHIGvofGModgN1ZnYfdYBu95yEs76I4
	 3MxQNOLx8Au1g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8014f3aaf8f55f41cb8799b682737882cd1c1112.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be> <8014f3aaf8f55f41cb8799b682737882cd1c1112.1762435376.git.geert+renesas@glider.be>
Subject: Re: [PATCH v6 25/26] clk: renesas: Use bitfield helpers
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, linux-crypto@vger.kernel.org, linux-edac@vger.kernel.org, qat-linux@intel.com, linux-gpio@vger.kernel.org, linux-aspeed@lists.ozlabs.org, linux-iio@vger.kernel.org, linux-sound@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
To: Alex Elder <elder@ieee.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Biju Das <biju.das.jz@bp.renesas.com>, Borislav Petkov <bp@alien8.de>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Cosmin Tanislav <demonsingur@gmail.com>, Crt Mori <cmo@melexis.com>, David Laight <david.laight.linux@gmail.com>, David Lechner <dlechner@baylibre.com>, David Miller <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jacky Huang <ychuang3@nuvoton.com>, Jakub Kicinski <kuba@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Jason Baron <jbaron@akamai.com>, Jianping Shen <Jianping.Shen@de.bosch.com>, Joel Stanley <joel@jms.id.au>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Cameron <jic23@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>, Lars-Peter Clausen <l
 ars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, Michael Hennerich <Michael.Hennerich@analog.com>, Michael Turquette <mturquette@baylibre.com>, Miquel Raynal <miquel.raynal@bootlin.com>, Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Richard Genoud <richard.genoud@bootlin.com>, Richard Weinberger <richard@nod.at>, Shan-Chun Hung <schung@nuvoton.com>, Takashi Iwai <tiwai@suse.com>, Tony Luck <tony.luck@intel.com>, Vignesh Raghavendra <vigneshr@ti.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Yury Norov <yury.norov@gmail.com>
Date: Thu, 13 Nov 2025 18:28:47 -0800
Message-ID: <176308732781.11952.18067279124978377191@localhost.localdomain>
User-Agent: alot/0.11

Quoting Geert Uytterhoeven (2025-11-06 05:34:13)
> Use the FIELD_{GET,PREP}() and field_{get,prep}() helpers for const
> respective non-const bitfields, instead of open-coding the same
> operations.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>


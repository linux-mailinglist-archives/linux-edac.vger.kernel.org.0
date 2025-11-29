Return-Path: <linux-edac+bounces-5540-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A24C93DB0
	for <lists+linux-edac@lfdr.de>; Sat, 29 Nov 2025 13:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E943A70F2
	for <lists+linux-edac@lfdr.de>; Sat, 29 Nov 2025 12:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB1267B15;
	Sat, 29 Nov 2025 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KpLK2to1"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40187404E;
	Sat, 29 Nov 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764420331; cv=none; b=OhjJbZfghTUyTes5tLfZ7TTDAZKTeL5kUF7xRWbjQXnXOCi0tBxuzti1toZ+u2uObmQ2gcTkPGSTTlTt9Nznox8PZ3x3Y4981phkXZ1FAqL9uJrZZhflqRzYpUa60CxbIoHMhw0bVw9Yqm+axc6VYAiYPEVdJ9qS6aBbPt5qwXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764420331; c=relaxed/simple;
	bh=oIQOa0YkbZJTLqBcRYp6XmCfelUPKTbYCF49ctlrf5U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NJfBApv8XaIJ7IhYurSVjc3Y1q07t2KkUnKJY4sttQH0lt5sVpz5w00QH8BDsMJOcJScjv1tuB/Z1DwLwmxNpx67F0j0hdSzW4oQk3km38CoFD93gX+KlYptDY/pTl20J9Mox5MnRewHlPEh6Sz6jFJA2ul75UPFRPBWxWS1ZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KpLK2to1; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 09F734E41971;
	Sat, 29 Nov 2025 12:45:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BBCF760706;
	Sat, 29 Nov 2025 12:45:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 109BA11910699;
	Sat, 29 Nov 2025 13:45:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1764420325; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TImXxPp3fH8t3WgGQuC2IHIt10tqIWX7TcyUqtyR31I=;
	b=KpLK2to1cF7NAB3dxoOLV/QWk7f3DOgDWnlCCQ/eWjBGe2OiLoz4MRPaxtNjJ5LhgTdO2x
	liQWrTjoV8SzbJ0IRNAWzjSTpxuBdKdZK+nMBBo+lz6eN4ScfF10Zi8hpoNB3oNhnhPAkB
	EBcOP1L5+m8y1BhDyM8QV2Sd1zOhoSjtmlz4x+NWF5bSJDvmY6HuADwinRYPvMGebmhy3r
	ecHZmVrqRYz0ygRRnstaU1i/ARfGhaUjItbgMb+f1cIphEqym8E4UMuA0rRIXKXq4K6uEQ
	20vrn9fsYJ9NCOmjJv1jyigd96ejKGwakw15qyOFOaK5wOwWkE03lUfTBtfXBQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Yury Norov <yury.norov@gmail.com>,  Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>,  Nicolas
 Ferre <nicolas.ferre@microchip.com>,  Alexandre Belloni
 <alexandre.belloni@bootlin.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Giovanni Cabiddu
 <giovanni.cabiddu@intel.com>,  Herbert Xu <herbert@gondor.apana.org.au>,
  David Miller <davem@davemloft.net>,  Linus Walleij
 <linus.walleij@linaro.org>,  Bartosz Golaszewski <brgl@bgdev.pl>,  Joel
 Stanley <joel@jms.id.au>,  Andrew Jeffery <andrew@codeconstruct.com.au>,
  Crt Mori <cmo@melexis.com>,  Jonathan Cameron <jic23@kernel.org>,
  Lars-Peter Clausen <lars@metafoo.de>,  Jacky Huang
 <ychuang3@nuvoton.com>,  Shan-Chun Hung <schung@nuvoton.com>,  Rasmus
 Villemoes <linux@rasmusvillemoes.dk>,  Jaroslav Kysela <perex@perex.cz>,
  Takashi Iwai <tiwai@suse.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  Jakub Kicinski <kuba@kernel.org>,  Alex
 Elder <elder@ieee.org>,  David Laight <david.laight.linux@gmail.com>,
  Vincent Mailhol <mailhol.vincent@wanadoo.fr>,  Jason Baron
 <jbaron@akamai.com>,  Borislav Petkov <bp@alien8.de>,  Tony Luck
 <tony.luck@intel.com>,  Michael Hennerich <Michael.Hennerich@analog.com>,
  Kim Seer Paller <kimseer.paller@analog.com>,  David Lechner
 <dlechner@baylibre.com>,  Nuno =?utf-8?Q?S=C3=A1?= <nuno.sa@analog.com>,
  Andy Shevchenko
 <andy@kernel.org>,  Richard Genoud <richard.genoud@bootlin.com>,  Cosmin
 Tanislav <demonsingur@gmail.com>,  Biju Das <biju.das.jz@bp.renesas.com>,
  Jianping Shen <Jianping.Shen@de.bosch.com>,  Nathan Chancellor
 <nathan@kernel.org>,  Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  linux-clk@vger.kernel.org,
  linux-arm-kernel@lists.infradead.org,  linux-renesas-soc@vger.kernel.org,
  linux-crypto@vger.kernel.org,  linux-edac@vger.kernel.org,
  qat-linux@intel.com,  linux-gpio@vger.kernel.org,
  linux-aspeed@lists.ozlabs.org,  linux-iio@vger.kernel.org,
  linux-sound@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v6 11/26] mtd: rawnand: sunxi: #undef
 field_{get,prep}() before local definition
In-Reply-To: <703d7eec56074148daed4ea45b637f8a83f15305.1762435376.git.geert+renesas@glider.be>
	(Geert Uytterhoeven's message of "Thu, 6 Nov 2025 14:33:59 +0100")
References: <cover.1762435376.git.geert+renesas@glider.be>
	<703d7eec56074148daed4ea45b637f8a83f15305.1762435376.git.geert+renesas@glider.be>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Sat, 29 Nov 2025 13:45:09 +0100
Message-ID: <87h5udm2i2.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 06/11/2025 at 14:33:59 +01, Geert Uytterhoeven <geert+renesas@glider.be>=
 wrote:

> Prepare for the advent of globally available common field_get() and
> field_prep() macros by undefining the symbols before defining local
> variants.  This prevents redefinition warnings from the C preprocessor
> when introducing the common macros later.
>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Finally applied to nand/next, will be part of the next merge window.

Thanks,
Miqu=C3=A8l


Return-Path: <linux-edac+bounces-5370-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4542C3B4AE
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 14:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9265D1A432F6
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 13:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10A3321B9;
	Thu,  6 Nov 2025 13:35:24 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF622D4E9;
	Thu,  6 Nov 2025 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436124; cv=none; b=izLE1jZuLD8omcOhAtQPFJZwCpJEM1/oB/5JmiA3V6ELuKU2SzVp5EuEBPwx3BuQ0BxzNN1PUL7yaQ8ioCI/75Ixe9UxnaDwivjokcZW4xt3PrRD6F25NI1XiP437vlMBcpw904FaaCw14sn1esxLRLMcl3joye4D8W2vp/NjdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436124; c=relaxed/simple;
	bh=nDP0lFBvNYEkrAQEUlWtlqBdBdUwZbGNoXfDDRPBZhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh4Jy6GiyQKAQ+rzdt10Aji+I5XM1kYONpd7zTkXEGxCLTra2NllHauY5wlqM+jVS2k3H4ANLqOZoy2+T3jGtRvGY+usOAH2+m/pATV+erXLzAtNDtJSKmi7v4WfCeJAg3+83o7lCrvq/gGZJ9qp71xxLursuXk6thIgnHq2saU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A4DC116D0;
	Thu,  6 Nov 2025 13:35:14 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yury Norov <yury.norov@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Miller <davem@davemloft.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Crt Mori <cmo@melexis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Alex Elder <elder@ieee.org>,
	David Laight <david.laight.linux@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Jason Baron <jbaron@akamai.com>,
	Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Cosmin Tanislav <demonsingur@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-edac@vger.kernel.org,
	qat-linux@intel.com,
	linux-gpio@vger.kernel.org,
	linux-aspeed@lists.ozlabs.org,
	linux-iio@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v6 05/26] iio: dac: ad3530r: #undef field_prep() before local definition
Date: Thu,  6 Nov 2025 14:33:53 +0100
Message-ID: <a2466d9201cb8c25504e25ac531a69ef8bd6e958.1762435376.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762435376.git.geert+renesas@glider.be>
References: <cover.1762435376.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the advent of a globally available common field_prep() macro
by undefining the symbol before defining a local variant.  This prevents
redefinition warnings from the C preprocessor when introducing the common
macro later.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - No changes,

v5:
  - New.
---
 drivers/iio/dac/ad3530r.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index 6134613777b8e1d4..5684d11137f29948 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -54,6 +54,7 @@
 #define AD3531R_MAX_CHANNELS			4
 
 /* Non-constant mask variant of FIELD_PREP() */
+#undef field_prep
 #define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
 
 enum ad3530r_mode {
-- 
2.43.0



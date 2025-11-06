Return-Path: <linux-edac+bounces-5371-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58022C3B4C0
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 14:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58F991A44EC5
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A71336ED8;
	Thu,  6 Nov 2025 13:35:34 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6D3321C7;
	Thu,  6 Nov 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436134; cv=none; b=G3ZkoyKfx1ZdKN1ixtwEZ/glDgChPmwmr//A2sQtqpuT9SY9/ndqViWuOkSnTwoMYnF6PEM8ElPwY+MGwnKjaE/idJJjVFW01lpdSzQyKpgi7flB4o/VBSXucE31Mjzmt2EHlMLgzpHiLLItKmHYt6YpoI7I874vK4PMPwog//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436134; c=relaxed/simple;
	bh=nyoHlA473M6VG5eO6lu/v0dCC77k1DZuDUpkBW3EzaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIjq+wKYU3Kc/sQ9tpum2VrvtERZkuhV82ID+FIi89M217n6ZO0XBQQ/4cns2Ps8uZGzK6siAgJOkcRuyoemTxZoTM//d2kEc0FxZlH/KZWGFp7CmY0kCuu7+xv0DxZfV4oYDzdw/bEnwOORswV9T4/1WnKRUMbF/4ODpGmxALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB744C4CEF7;
	Thu,  6 Nov 2025 13:35:24 +0000 (UTC)
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
Subject: [PATCH v6 06/26] iio: mlx90614: #undef field_{get,prep}() before local definition
Date: Thu,  6 Nov 2025 14:33:54 +0100
Message-ID: <6c773f03da99ccc081a33d2363879957ac96ce33.1762435376.git.geert+renesas@glider.be>
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

Prepare for the advent of globally available common field_get() and
field_prep() macros by undefining the symbols before defining local
variants.  This prevents redefinition warnings from the C preprocessor
when introducing the common macros later.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - No changes,

v5:
  - New.
---
 drivers/iio/temperature/mlx90614.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 8a44a00bfd5ece38..de5615fdb396aa3c 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -69,7 +69,9 @@
 #define MLX90614_CONST_FIR 0x7 /* Fixed value for FIR part of low pass filter */
 
 /* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
+#undef field_get
 #define field_get(_mask, _reg)	(((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val)	(((_val) << (ffs(_mask) - 1)) & (_mask))
 
 struct mlx_chip_info {
-- 
2.43.0



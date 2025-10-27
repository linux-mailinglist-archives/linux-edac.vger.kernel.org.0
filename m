Return-Path: <linux-edac+bounces-5222-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CAEC102F6
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 19:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4F4B4F9C79
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39932ED46;
	Mon, 27 Oct 2025 18:45:26 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93761317711;
	Mon, 27 Oct 2025 18:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590726; cv=none; b=ee965hpeYgoXv2StjzT9B2IgQGlYtRMqcKO/AwQSzgd0m8ufeD3IA7+BmF2nuQxTn1L7ML336JFOPjcVP56k75AvhFoGSCZIvNKBtkuszMxXvkhpBmai3aO4L2/cVMxztR4lMCWLxE+JHd75FswSlBuwL+tkH2l0pIQ69o3tT7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590726; c=relaxed/simple;
	bh=P7bX1PDZYqbzvyJxyuZ/d54zgR6Myun/JBHkpVMbSGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ood6pkgZrRkFVGbbLSVJicY8W9kaW6Sax2aqVCwUCjWssGwvhBuT/KgN7pcmyL+I+lAOc5WbsuxrEFfdTezUnwihn3joeMJV7Bif9qO35VYLNiqiaFd/btv53XCX7GY230L3XdMLdQGGf6CrEK9Pqar4bu6zPfZHNkHLOJlKUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0ACC4CEF1;
	Mon, 27 Oct 2025 18:45:17 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Michael Turquette <mturquette@baylibre.com>,
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
	Yury Norov <yury.norov@gmail.com>,
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
	Jianping Shen <Jianping.Shen@de.bosch.com>
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
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH -next v5 21/23] iio: imu: smi330: Convert to common field_{get,prep}() helpers
Date: Mon, 27 Oct 2025 19:41:55 +0100
Message-ID: <79c392bcd9c1127e9a7fa977780335795f0b99af.1761588465.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761588465.git.geert+renesas@glider.be>
References: <cover.1761588465.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the driver-specific field_get() and field_prep() macros, in favor
of the globally available variants from <linux/bitfield.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - New.
---
 drivers/iio/imu/smi330/smi330_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/imu/smi330/smi330_core.c b/drivers/iio/imu/smi330/smi330_core.c
index a79964fe68fadf47..83e0dff5d973d046 100644
--- a/drivers/iio/imu/smi330/smi330_core.c
+++ b/drivers/iio/imu/smi330/smi330_core.c
@@ -67,12 +67,6 @@
 #define SMI330_CHIP_ID 0x42
 #define SMI330_SOFT_RESET_DELAY 2000
 
-/* Non-constant mask variant of FIELD_GET() and FIELD_PREP() */
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-#undef field_prep
-#define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
-
 #define SMI330_ACCEL_CHANNEL(_axis) {					\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
-- 
2.43.0



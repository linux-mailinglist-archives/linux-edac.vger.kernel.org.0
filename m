Return-Path: <linux-edac+bounces-5390-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C10A5C3B6EB
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 14:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6F845504045
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 13:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA316335BB2;
	Thu,  6 Nov 2025 13:38:51 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820333168E5;
	Thu,  6 Nov 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436331; cv=none; b=J92WnLZC5ijXw3zWEoJba5YY9wggMONpnEQ3JqIPb3DdA8XQfZ10nEo80PlL9pYGgOpGAYZYfHjMUz+0PLim4Ph7ZQ3952EJqpkKu3JB365yQgD2L9al+rP35lB2R+YivHwF+jAkEnRAXVVDT3GOL+xTJ/kwxAgrufDyoZqBfeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436331; c=relaxed/simple;
	bh=XqGCl8KuYf3jtM8h5pr9hPO9eQg6QKXoRXzbBzQ+2so=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnNl69Pb/5EJEekso10f+vexGSHbb+Y5wCAuUP9Is71ffTaeW6VptcNQtT9KcyAD/Q/LBWquaYHNxR8Pm/3jXkOWQSvEig7O/zZnScIm9O5DOD7sFIXZ5NJew6EJwmYVv12yB/jrY/TCHf16N4W0uOx/eRhAYhWg+LwYu0TIc6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CEBC19421;
	Thu,  6 Nov 2025 13:38:41 +0000 (UTC)
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
Subject: [PATCH v6 25/26] clk: renesas: Use bitfield helpers
Date: Thu,  6 Nov 2025 14:34:13 +0100
Message-ID: <8014f3aaf8f55f41cb8799b682737882cd1c1112.1762435376.git.geert+renesas@glider.be>
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

Use the FIELD_{GET,PREP}() and field_{get,prep}() helpers for const
respective non-const bitfields, instead of open-coding the same
operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v6:
  - No changes,

v5:
  - No changes,

v4:
  - No changes,

v3:
  - No changes,

v2:
  - Rebase on top of commit 470e3f0d0b1529ab ("clk: renesas: rcar-gen4:
    Introduce R-Car Gen4 CPG driver").
---
 drivers/clk/renesas/clk-div6.c      |  6 +++---
 drivers/clk/renesas/rcar-gen3-cpg.c | 15 +++++----------
 drivers/clk/renesas/rcar-gen4-cpg.c |  9 +++------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/renesas/clk-div6.c b/drivers/clk/renesas/clk-div6.c
index 3abd6e5400aded6a..f7b827b5e9b2dd32 100644
--- a/drivers/clk/renesas/clk-div6.c
+++ b/drivers/clk/renesas/clk-div6.c
@@ -7,6 +7,7 @@
  * Contact: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
 #include <linux/io.h>
@@ -171,8 +172,7 @@ static u8 cpg_div6_clock_get_parent(struct clk_hw *hw)
 	if (clock->src_mask == 0)
 		return 0;
 
-	hw_index = (readl(clock->reg) & clock->src_mask) >>
-		   __ffs(clock->src_mask);
+	hw_index = field_get(clock->src_mask, readl(clock->reg));
 	for (i = 0; i < clk_hw_get_num_parents(hw); i++) {
 		if (clock->parents[i] == hw_index)
 			return i;
@@ -191,7 +191,7 @@ static int cpg_div6_clock_set_parent(struct clk_hw *hw, u8 index)
 	if (index >= clk_hw_get_num_parents(hw))
 		return -EINVAL;
 
-	src = clock->parents[index] << __ffs(clock->src_mask);
+	src = field_prep(clock->src_mask, clock->parents[index]);
 	writel((readl(clock->reg) & ~clock->src_mask) | src, clock->reg);
 	return 0;
 }
diff --git a/drivers/clk/renesas/rcar-gen3-cpg.c b/drivers/clk/renesas/rcar-gen3-cpg.c
index 10ae20489df9abd8..b954278ddd9d8aa8 100644
--- a/drivers/clk/renesas/rcar-gen3-cpg.c
+++ b/drivers/clk/renesas/rcar-gen3-cpg.c
@@ -54,10 +54,8 @@ static unsigned long cpg_pll_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct cpg_pll_clk *pll_clk = to_pll_clk(hw);
 	unsigned int mult;
-	u32 val;
 
-	val = readl(pll_clk->pllcr_reg) & CPG_PLLnCR_STC_MASK;
-	mult = (val >> __ffs(CPG_PLLnCR_STC_MASK)) + 1;
+	mult = FIELD_GET(CPG_PLLnCR_STC_MASK, readl(pll_clk->pllcr_reg)) + 1;
 
 	return parent_rate * mult * pll_clk->fixed_mult;
 }
@@ -94,7 +92,7 @@ static int cpg_pll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 
 	val = readl(pll_clk->pllcr_reg);
 	val &= ~CPG_PLLnCR_STC_MASK;
-	val |= (mult - 1) << __ffs(CPG_PLLnCR_STC_MASK);
+	val |= FIELD_PREP(CPG_PLLnCR_STC_MASK, mult - 1);
 	writel(val, pll_clk->pllcr_reg);
 
 	for (i = 1000; i; i--) {
@@ -176,11 +174,7 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 					   unsigned long parent_rate)
 {
 	struct cpg_z_clk *zclk = to_z_clk(hw);
-	unsigned int mult;
-	u32 val;
-
-	val = readl(zclk->reg) & zclk->mask;
-	mult = 32 - (val >> __ffs(zclk->mask));
+	unsigned int mult = 32 - field_get(zclk->mask, readl(zclk->reg));
 
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult,
 				     32 * zclk->fixed_div);
@@ -231,7 +225,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	cpg_reg_modify(zclk->reg, zclk->mask, (32 - mult) << __ffs(zclk->mask));
+	cpg_reg_modify(zclk->reg, zclk->mask,
+		       field_prep(zclk->mask, 32 - mult));
 
 	/*
 	 * Set KICK bit in FRQCRB to update hardware setting and wait for
diff --git a/drivers/clk/renesas/rcar-gen4-cpg.c b/drivers/clk/renesas/rcar-gen4-cpg.c
index fb9a876aaba5cbcd..db3a0b8ef2b936bb 100644
--- a/drivers/clk/renesas/rcar-gen4-cpg.c
+++ b/drivers/clk/renesas/rcar-gen4-cpg.c
@@ -279,11 +279,7 @@ static unsigned long cpg_z_clk_recalc_rate(struct clk_hw *hw,
 					   unsigned long parent_rate)
 {
 	struct cpg_z_clk *zclk = to_z_clk(hw);
-	unsigned int mult;
-	u32 val;
-
-	val = readl(zclk->reg) & zclk->mask;
-	mult = 32 - (val >> __ffs(zclk->mask));
+	unsigned int mult = 32 - field_get(zclk->mask, readl(zclk->reg));
 
 	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate * mult,
 				     32 * zclk->fixed_div);
@@ -334,7 +330,8 @@ static int cpg_z_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (readl(zclk->kick_reg) & CPG_FRQCRB_KICK)
 		return -EBUSY;
 
-	cpg_reg_modify(zclk->reg, zclk->mask, (32 - mult) << __ffs(zclk->mask));
+	cpg_reg_modify(zclk->reg, zclk->mask,
+		       field_prep(zclk->mask, 32 - mult));
 
 	/*
 	 * Set KICK bit in FRQCRB to update hardware setting and wait for
-- 
2.43.0



Return-Path: <linux-edac+bounces-5104-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC78BE83A8
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 13:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A29EA6E62C3
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 10:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27964328B44;
	Fri, 17 Oct 2025 10:54:47 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3C42D193B;
	Fri, 17 Oct 2025 10:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698486; cv=none; b=OCOclINaLAFDvL27K/VOJmldU629CYYr0O0QMzffIV5OqnwTywoC5SKOiwPsVeo5tQv6927NgYa3x0viH1EzAIposB6qMHjP4Lm0l/p8ouzl8EcQCSzTiyvQCuix1heclKF/t/rg+wVSy4tdE8ATHIxnA3mk/eO8It9xrQK1ZoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698486; c=relaxed/simple;
	bh=jhg0Kl+C/SFMuevm/DdOlKKUxSgsZOY5lKQgc5okIn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pafvfTHig1iL8r5XjIT8MMcLmlqyBBB9egRae8QFzilBfnPy6WL7DhPL+rdMvBjSM41skU54J5ZfhKkaGvzBou8hhoUZ9Nhhd3lgh1SY+qd98kWw6JlyMoVD24YAo6Su5IDd+NXZxwtia/sbCYVyQF3IYJrDvf5/k5V62k3k95k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA9FC4CEFE;
	Fri, 17 Oct 2025 10:54:37 +0000 (UTC)
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
Subject: [PATCH v4 1/4] bitfield: Drop underscores from macro parameters
Date: Fri, 17 Oct 2025 12:54:09 +0200
Message-ID: <792d176149bc4ffde2a7b78062388dc2466c23ca.1760696560.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760696560.git.geert+renesas@glider.be>
References: <cover.1760696560.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no need to prefix macro parameters with underscores.
Remove the underscores.

Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Update recently introduced FIELD_MODIFY() macro,

v3:
  - New.
---
 include/linux/bitfield.h | 106 +++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 5355f8f806a97974..7ff817bdae19b468 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -60,68 +60,68 @@
 
 #define __bf_cast_unsigned(type, x)	((__unsigned_scalar_typeof(type))(x))
 
-#define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)			\
+#define __BF_FIELD_CHECK(mask, reg, val, pfx)				\
 	({								\
-		BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),		\
-				 _pfx "mask is not constant");		\
-		BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");	\
-		BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?		\
-				 ~((_mask) >> __bf_shf(_mask)) &	\
-					(0 + (_val)) : 0,		\
-				 _pfx "value too large for the field"); \
-		BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >	\
-				 __bf_cast_unsigned(_reg, ~0ull),	\
-				 _pfx "type of reg too small for mask"); \
-		__BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +			\
-					      (1ULL << __bf_shf(_mask))); \
+		BUILD_BUG_ON_MSG(!__builtin_constant_p(mask),		\
+				 pfx "mask is not constant");		\
+		BUILD_BUG_ON_MSG((mask) == 0, pfx "mask is zero");	\
+		BUILD_BUG_ON_MSG(__builtin_constant_p(val) ?		\
+				 ~((mask) >> __bf_shf(mask)) &	\
+					(0 + (val)) : 0,		\
+				 pfx "value too large for the field"); \
+		BUILD_BUG_ON_MSG(__bf_cast_unsigned(mask, mask) >	\
+				 __bf_cast_unsigned(reg, ~0ull),	\
+				 pfx "type of reg too small for mask"); \
+		__BUILD_BUG_ON_NOT_POWER_OF_2((mask) +			\
+					      (1ULL << __bf_shf(mask))); \
 	})
 
 /**
  * FIELD_MAX() - produce the maximum value representable by a field
- * @_mask: shifted mask defining the field's length and position
+ * @mask: shifted mask defining the field's length and position
  *
  * FIELD_MAX() returns the maximum value that can be held in the field
- * specified by @_mask.
+ * specified by @mask.
  */
-#define FIELD_MAX(_mask)						\
+#define FIELD_MAX(mask)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
-		(typeof(_mask))((_mask) >> __bf_shf(_mask));		\
+		__BF_FIELD_CHECK(mask, 0ULL, 0ULL, "FIELD_MAX: ");	\
+		(typeof(mask))((mask) >> __bf_shf(mask));		\
 	})
 
 /**
  * FIELD_FIT() - check if value fits in the field
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to test against the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to test against the field
  *
- * Return: true if @_val can fit inside @_mask, false if @_val is too big.
+ * Return: true if @val can fit inside @mask, false if @val is too big.
  */
-#define FIELD_FIT(_mask, _val)						\
+#define FIELD_FIT(mask, val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
-		!((((typeof(_mask))_val) << __bf_shf(_mask)) & ~(_mask)); \
+		__BF_FIELD_CHECK(mask, 0ULL, 0ULL, "FIELD_FIT: ");	\
+		!((((typeof(mask))val) << __bf_shf(mask)) & ~(mask)); \
 	})
 
 /**
  * FIELD_PREP() - prepare a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP() masks and shifts up the value.  The result should
  * be combined with other fields of the bitfield using logical OR.
  */
-#define FIELD_PREP(_mask, _val)						\
+#define FIELD_PREP(mask, val)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");	\
-		((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);	\
+		__BF_FIELD_CHECK(mask, 0ULL, val, "FIELD_PREP: ");	\
+		((typeof(mask))(val) << __bf_shf(mask)) & (mask);	\
 	})
 
 #define __BF_CHECK_POW2(n)	BUILD_BUG_ON_ZERO(((n) & ((n) - 1)) != 0)
 
 /**
  * FIELD_PREP_CONST() - prepare a constant bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_val:  value to put in the field
+ * @mask: shifted mask defining the field's length and position
+ * @val:  value to put in the field
  *
  * FIELD_PREP_CONST() masks and shifts up the value.  The result should
  * be combined with other fields of the bitfield using logical OR.
@@ -130,47 +130,47 @@
  * be used in initializers. Error checking is less comfortable for this
  * version, and non-constant masks cannot be used.
  */
-#define FIELD_PREP_CONST(_mask, _val)					\
+#define FIELD_PREP_CONST(mask, val)					\
 	(								\
 		/* mask must be non-zero */				\
-		BUILD_BUG_ON_ZERO((_mask) == 0) +			\
+		BUILD_BUG_ON_ZERO((mask) == 0) +			\
 		/* check if value fits */				\
-		BUILD_BUG_ON_ZERO(~((_mask) >> __bf_shf(_mask)) & (_val)) + \
+		BUILD_BUG_ON_ZERO(~((mask) >> __bf_shf(mask)) & (val)) + \
 		/* check if mask is contiguous */			\
-		__BF_CHECK_POW2((_mask) + (1ULL << __bf_shf(_mask))) +	\
+		__BF_CHECK_POW2((mask) + (1ULL << __bf_shf(mask))) +	\
 		/* and create the value */				\
-		(((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask))	\
+		(((typeof(mask))(val) << __bf_shf(mask)) & (mask))	\
 	)
 
 /**
  * FIELD_GET() - extract a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_reg:  value of entire bitfield
+ * @mask: shifted mask defining the field's length and position
+ * @reg:  value of entire bitfield
  *
- * FIELD_GET() extracts the field specified by @_mask from the
- * bitfield passed in as @_reg by masking and shifting it down.
+ * FIELD_GET() extracts the field specified by @mask from the
+ * bitfield passed in as @reg by masking and shifting it down.
  */
-#define FIELD_GET(_mask, _reg)						\
+#define FIELD_GET(mask, reg)						\
 	({								\
-		__BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");	\
-		(typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask));	\
+		__BF_FIELD_CHECK(mask, reg, 0U, "FIELD_GET: ");	\
+		(typeof(mask))(((reg) & (mask)) >> __bf_shf(mask));	\
 	})
 
 /**
  * FIELD_MODIFY() - modify a bitfield element
- * @_mask: shifted mask defining the field's length and position
- * @_reg_p: pointer to the memory that should be updated
- * @_val: value to store in the bitfield
+ * @mask: shifted mask defining the field's length and position
+ * @reg_p: pointer to the memory that should be updated
+ * @val: value to store in the bitfield
  *
- * FIELD_MODIFY() modifies the set of bits in @_reg_p specified by @_mask,
- * by replacing them with the bitfield value passed in as @_val.
+ * FIELD_MODIFY() modifies the set of bits in @reg_p specified by @mask,
+ * by replacing them with the bitfield value passed in as @val.
  */
-#define FIELD_MODIFY(_mask, _reg_p, _val)						\
+#define FIELD_MODIFY(mask, reg_p, val)						\
 	({										\
-		typecheck_pointer(_reg_p);						\
-		__BF_FIELD_CHECK(_mask, *(_reg_p), _val, "FIELD_MODIFY: ");		\
-		*(_reg_p) &= ~(_mask);							\
-		*(_reg_p) |= (((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask));	\
+		typecheck_pointer(reg_p);						\
+		__BF_FIELD_CHECK(mask, *(reg_p), val, "FIELD_MODIFY: ");		\
+		*(reg_p) &= ~(mask);							\
+		*(reg_p) |= (((typeof(mask))(val) << __bf_shf(mask)) & (mask));	\
 	})
 
 extern void __compiletime_error("value doesn't fit into mask")
-- 
2.43.0



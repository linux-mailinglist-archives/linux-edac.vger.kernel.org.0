Return-Path: <linux-edac+bounces-5214-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B25B3C10251
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 19:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4F0E74FFB94
	for <lists+linux-edac@lfdr.de>; Mon, 27 Oct 2025 18:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D932ABC6;
	Mon, 27 Oct 2025 18:44:12 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E98031B82B;
	Mon, 27 Oct 2025 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590652; cv=none; b=XqRPTNNSHQm8zpgGCaCqNxh3FfEMVFVN0V1ldTW9glGrlrnZNv+eMrVUyP33bI5gglkK3+wNinSsrTf/8mc8+/P54lzGQY++IfPoNljVkrZQDcRsqJzmrGNdjtdyfc1sVjO7CkfpiGLibkU7g8aBu0MScLXsUwcBNM+5/Os9Ktw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590652; c=relaxed/simple;
	bh=PXVmPOn6yY5UfKE+4qxrNiI7L/NaK9gQJ/rTNzxB6Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4CqgxEeUfvOxWawi5d0bwTMRK6mkDCEEAK9s7zoADr5Ww9U8cVVNVlrsdkCWMS7QO/cHWhpCMtsZ3phymUFk79R6Mw/+iNGfD8ByMh9DwxdMTfcsib/C98nW6Je7x0keCXxwuMuxF46z7LREGb8eqM/sEZNar3fhsnRwHhWXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C14BC4CEF1;
	Mon, 27 Oct 2025 18:44:03 +0000 (UTC)
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
Subject: [PATCH v5 13/23] crypto: qat - convert to common field_get() helper
Date: Mon, 27 Oct 2025 19:41:47 +0100
Message-ID: <2556adf9d1dca0077d03785bef1f7592936c16c8.1761588465.git.geert+renesas@glider.be>
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

Drop the driver-specific field_get() macro, in favor of the globally
available variant from <linux/bitfield.h>.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v5:
  - Extracted from "bitfield: Add non-constant field_{prep,get}()
    helpers".
---
 drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
index 6186fafb4a7b0dab..4ccc94ed9493a64c 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_pm_dbgfs_utils.c
@@ -1,19 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2025 Intel Corporation */
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/sprintf.h>
 #include <linux/string_helpers.h>
 
 #include "adf_pm_dbgfs_utils.h"
 
-/*
- * This is needed because a variable is used to index the mask at
- * pm_scnprint_table(), making it not compile time constant, so the compile
- * asserts from FIELD_GET() or u32_get_bits() won't be fulfilled.
- */
-#undef field_get
-#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
-
 #define PM_INFO_MAX_KEY_LEN	21
 
 static int pm_scnprint_table(char *buff, const struct pm_status_row *table,
-- 
2.43.0



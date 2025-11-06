Return-Path: <linux-edac+bounces-5365-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0B4C3B43F
	for <lists+linux-edac@lfdr.de>; Thu, 06 Nov 2025 14:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94201A409A1
	for <lists+linux-edac@lfdr.de>; Thu,  6 Nov 2025 13:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F732C945;
	Thu,  6 Nov 2025 13:34:33 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6982475D0;
	Thu,  6 Nov 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762436073; cv=none; b=sAls7jx944iixsV0XyZphfM+v2BuzBOFVifutRNz9LLWs/zfHKVQ4ncCHx8kMXrp5NCw9o26Ce/b0gOEoHxX4Tbtl4rQY0vlJzaGfknKBogwrYm7ZAtm5om16m5kKX4i+GeMT1Ni9SnwIN9dma5tCvTvIbPT77riaRZqKF2OX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762436073; c=relaxed/simple;
	bh=vFi6JwsiqVBJ6NDjklmKzH3z7fjez3Z0YWaZVbFVPtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MGeU6x6Ygu1Wt24oka8IzcUckh6mZt59ZhXEJodyIIP/eC8nAIxP0Y5jhrY7cuorKoYDCPXUG0sjPIzYfZNM1JBbGR9NuURJdVPVtnIEl2dvL7HcJO4I7RuE7KywQhGXXl+FX4kOsb7puVrc37aCnl02F5rNZ2Ms5OIhUjydTM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EB8C116C6;
	Thu,  6 Nov 2025 13:34:21 +0000 (UTC)
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
Subject: [PATCH v6 00/26] Non-const bitfield helpers
Date: Thu,  6 Nov 2025 14:33:48 +0100
Message-ID: <cover.1762435376.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

<linux/bitfield.h> contains various helpers for accessing bitfields, as
typically used in hardware registers for memory-mapped I/O blocks.
These helpers ensure type safety, and deduce automatically shift values
from mask values, avoiding mistakes due to inconsistent shifts and
masks, and leading to a reduction in source code size.

The existing FIELD_{GET,PREP}() macros are limited to compile-time
constants.  However, it is very common to prepare or extract bitfield
elements where the bitfield mask is not a compile-time constant (e.g. it
comes from a table, or is created by shifting a compile-time constant).
To avoid this limitation, the AT91 clock driver introduced its own
field_{prep,get}() macros.  During the past four years, these have been
copied to multiple drivers, and more copies are on their way[1], leading
to the obvious review comment "please move this to <linux/bitfield.h>".

Hence this series
  1. Takes preparatory steps in drivers definining local
     field_{get,prep}() macros (patches 1-11),
  2. Introduces __FIELD_{PREP,GET}() helpers to avoid clang W=1 warnings
     (patch 12),
  3. Makes field_{prep,get}() available for general use (patch 13),
  4. Converts drivers with local variants to the common helpers (patches
     14-24),
  5. Converts a few Renesas drivers to the existing FIELD_{GET,PREP}()
     and the new field_{get,prep}() helpers (patches 25-26).

Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
macros instead (which currently do not work with non-constant masks
either, and the first attempt to change that generates much worse code),
or to store the low bit and width of the mask instead (which would
require changing all code that passes masks directly, and also generates
worse code).

Changes compared to v5[2]:
  - Add Acked-by, Reviewed-by,
  - Update sunxi rawnand driver in linux-next,
  - Align \,
  - Add Return sections to kerneldoc,
  - Document field_{get,prep} in top comment block,
  - New patch to add less-checking __FIELD_{GET,PREP}() helpers,
  - Use less-checking __FIELD_{GET,PREP}() to avoid build issues with
    clang and W=1.

Changes compared to v4[3]:
  - Add preparatory patches to #undef field_{get,prep}() in individual
    drivers before defining local variants,
  - Update new smi330 IIO IMU driver in linux-next,
  - Add Acked-by,
  - Document that mask must be non-zero,
  - Document typical usage pattern,
  - Recommend using FIELD_{PREP,GET}() directly to ensure compile-time
    constant masks,
  - Check BITS_PER_TYPE(mask) instead of sizeof(mask),
  - Wire field_{get,prep}() to FIELD_{GET,PREP}() when mask is
    constant, to improve type checking,
  - Extract conversion of individual drivers into separate patches.

Changes compared to v3[4]:
  - Update recently introduced FIELD_MODIFY() macro,
  - Add Acked-by,
  - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
    power management debugfs helper APIs") in v6.17-rc1,
  - Convert more recently introduced upstream copies:
      - drivers/edac/ie31200_edac.c
      - drivers/iio/dac/ad3530r.c

Changes compared to v2[5]:
  - New patch "[PATCH v3 1/4] bitfield: Drop underscores from macro
    parameters",
  - Add Acked-by,
  - Drop underscores from macro parameters,
  - Use __auto_type where possible,
  - Correctly cast reg to the mask type,
  - Introduces __val and __reg intermediates to simplify the actual
    operation,
  - Drop unneeded parentheses,
  - Clarify having both FIELD_{GET,PREP}() and field_{get,prep}(),

Changes compared to v1[6]:
  - Cast val resp. reg to the mask type,
  - Fix 64-bit use on 32-bit architectures,
  - Convert new upstream users:
      - drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
      - drivers/gpio/gpio-aspeed.c
      - drivers/iio/temperature/mlx90614.c
      - drivers/pinctrl/nuvoton/pinctrl-ma35.c
      - sound/usb/mixer_quirks.c
  - Convert new user queued in renesas-devel for v6.15:
      - drivers/soc/renesas/rz-sysc.c
  - Drop the last 14 RFC patches.
    They can be updated/resubmitted/applied later.

In the meantime, two more copies ended up in the IIO and MTD trees and
in linux-next (commit 89cba586b8b4cde0 ("iio: imu: smi330: Add driver"
in next-20251021 and later, commits 6fc2619af1eb6f59 ("mtd: rawnand:
sunxi: rework pattern found registers") and d21b4338159ff7d7 ("mtd:
rawnand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps") in
next-20251029 and later).  As these commits are not yet upstream, any
updates (patches 10, 11, 23 and 24) for these drivers cannot be applied
with the rest of this series yet.

Yury kindly offered to take the lionshare of this series through his
bitmap tree, thanks for that!
I am fine with that, if he would also provide an immutable branch + tag,
which I can merge into the Renesas tree before taking patches 25 and 26
myself.  Once that tag has been merged in subsystem trees or upstream, I
plan to update and resend actual conversions (see patches 4-17 in
v1[6]).

To avoid build issues in linux-next, the IIO resp. MTD maintainers
should:
  1. Apply patch 10 resp. 11 now, and
  2. Apply patch 23 resp. 24 later, either after
       a. merging the immutable branch/tag, or
       b. the new helpers in <linux/bitfield.h> are upstream,

Note that there is also a minor conflict with linux-next due to the
removal of an include file from drivers/gpio/gpio-aspeed.c.

Thanks!

[1] Work-in-progress new copies posted during the last few months (there
    may be more):
      - "[PATCH v2 3/3] gpio: gpio-ltc4283: Add support for the LTC4283 Swap Controller"
	https://lore.kernel.org/20250903-ltc4283-support-v2-3-6bce091510bf@analog.com
      - "[PATCH v7 15/24] media: i2c: add Maxim GMSL2/3 serializer and deserializer framework"
	https://lore.kernel.org/20250718152500.2656391-16-demonsingur@gmail.com
[2] "[PATCH v5 00/23] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1761588465.git.geert+renesas@glider.be
[3] "[PATCH v4 0/4] Non-const bitfield helpers"
    https://lore.kernel.org/cover.1760696560.git.geert+renesas@glider.be
[4] "[PATCH v3 0/4] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1739540679.git.geert+renesas@glider.be
[5] "[PATCH v2 0/3] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1738329458.git.geert+renesas@glider.be
[6] "[PATCH 00/17] Non-const bitfield helper conversions"
    https://lore.kernel.org/all/cover.1637592133.git.geert+renesas@glider.be

Geert Uytterhoeven (26):
  clk: at91: pmc: #undef field_{get,prep}() before definition
  crypto: qat - #undef field_get() before local definition
  EDAC/ie31200: #undef field_get() before local definition
  gpio: aspeed: #undef field_{get,prep}() before local definition
  iio: dac: ad3530r: #undef field_prep() before local definition
  iio: mlx90614: #undef field_{get,prep}() before local definition
  pinctrl: ma35: #undef field_{get,prep}() before local definition
  soc: renesas: rz-sysc: #undef field_get() before local definition
  ALSA: usb-audio: #undef field_{get,prep}() before local definition
  [-next] iio: imu: smi330: #undef field_{get,prep}() before definition
  [-next] mtd: rawnand: sunxi: #undef field_{get,prep}() before local
    definition
  bitfield: Add less-checking __FIELD_{GET,PREP}()
  bitfield: Add non-constant field_{prep,get}() helpers
  clk: at91: Convert to common field_{get,prep}() helpers
  crypto: qat - convert to common field_get() helper
  EDAC/ie31200: Convert to common field_get() helper
  gpio: aspeed: Convert to common field_{get,prep}() helpers
  iio: dac: Convert to common field_prep() helper
  iio: mlx90614: Convert to common field_{get,prep}() helpers
  pinctrl: ma35: Convert to common field_{get,prep}() helpers
  soc: renesas: rz-sysc: Convert to common field_get() helper
  ALSA: usb-audio: Convert to common field_{get,prep}() helpers
  [-next] iio: imu: smi330: Convert to common field_{get,prep}() helpers
  [-next] mtd: rawnand: sunxi: Convert to common field_{get,prep}()
    helpers
  clk: renesas: Use bitfield helpers
  soc: renesas: Use bitfield helpers

 drivers/clk/at91/clk-peripheral.c             |  1 +
 drivers/clk/at91/pmc.h                        |  3 -
 drivers/clk/renesas/clk-div6.c                |  6 +-
 drivers/clk/renesas/rcar-gen3-cpg.c           | 15 +--
 drivers/clk/renesas/rcar-gen4-cpg.c           |  9 +-
 .../intel/qat/qat_common/adf_pm_dbgfs_utils.c |  8 +-
 drivers/edac/ie31200_edac.c                   |  4 +-
 drivers/gpio/gpio-aspeed.c                    |  5 +-
 drivers/iio/dac/ad3530r.c                     |  3 -
 drivers/iio/imu/smi330/smi330_core.c          |  4 -
 drivers/iio/temperature/mlx90614.c            |  5 +-
 drivers/mtd/nand/raw/sunxi_nand.c             |  4 -
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        |  4 -
 drivers/soc/renesas/renesas-soc.c             |  4 +-
 drivers/soc/renesas/rz-sysc.c                 |  3 +-
 include/linux/bitfield.h                      | 95 +++++++++++++++++--
 sound/usb/mixer_quirks.c                      |  4 -
 17 files changed, 106 insertions(+), 71 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


Return-Path: <linux-edac+bounces-5103-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D83BE82D2
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 12:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A038C568622
	for <lists+linux-edac@lfdr.de>; Fri, 17 Oct 2025 10:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E84D326D42;
	Fri, 17 Oct 2025 10:54:38 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51BF3203AB;
	Fri, 17 Oct 2025 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760698477; cv=none; b=Hl9/kpjQK/YztkBhDJKj2Z3f1yrd1PhH3FuSPiQkeAbh8giWO34GwiI8tDYTD/5Fq/xPJGO+XH1QyYpTeTzJCli2E0wrRtS5lqyHJhl1+zf/qY6TamdrFJWTeN7vnDKKyd1YBdUpZZsxEzipNvqWwmSOfB3BSN6OVQ+oqSMCE38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760698477; c=relaxed/simple;
	bh=2iTRCBSgAgEc6VVwBZSn9Q6Vk0BEoRmGDB+2rvmH2AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=upXyHCRsWU2jI/eDAW4LwyndsLd5pxe3Dhfb0pEIxr4HyU2PT6QWooUVfAXVkP7IZMzhH/+qqeckBVaZZJ6devWTkgmtaKFbsHK3DqIhyOSY1FAqWSyzgMh5S9f1TzsLRQ4XrNG1ULXbD5jgOD35IELQ2piphL6AciojK1kjJqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4B6C4CEE7;
	Fri, 17 Oct 2025 10:54:28 +0000 (UTC)
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
Subject: [PATCH v4 0/4] Non-const bitfield helpers
Date: Fri, 17 Oct 2025 12:54:08 +0200
Message-ID: <cover.1760696560.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Hence this series makes field_{prep,get}() available for general use
(first two patches), and converts a few Renesas drivers to the existing
FIELD_{GET,PREP}() and the new field_{get,prep}() helpers (last two
patches).

Alternatives would be to use the typed {u*,be*,le*,...}_{get,encode}_bits()
macros instead (which currently do not work with non-constant masks
either, and the first attempt to change that generates much worse code),
or to store the low bit and width of the mask instead (which would
require changing all code that passes masks directly, and also generates
worse code).

Changes compared to v3[2]:
  - Update recently introduced FIELD_MODIFY() macro,
  - Add Acked-by,
  - Rebase on top of commit 7c68005a46108ffa ("crypto: qat - relocate
    power management debugfs helper APIs") in v6.17-rc1,
  - Convert more recently introduced upstream copies:
      - drivers/edac/ie31200_edac.c
      - drivers/iio/dac/ad3530r.c

Changes compared to v2[3]:
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

Changes compared to v1[4]:
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

I plan to take all four patches through the Renesas tree, and provide an
immutable branch + tag with the first two patches, so subsystem
maintainers that want to queue patches that depend on this can easily do
so.  Once that tag has been merged in subsystem trees or upstream, I
plan to update and resend actual conversions (see patches 4-17 in
v1[4]).

Thanks for your comments!

[1] Work-in-progress new copies posted during the last few months (there
    may be more):
      - "[PATCH 10/24] mtd: rawnand: sunxi: cosmetic: move ECC_PAT_FOUND register in SoC caps"
	https://lore.kernel.org/20251016142752.2627710-11-richard.genoud@bootlin.com
      - "[PATCH 12/24] mtd: rawnand: sunxi: cosmetic: move NFC_ECC_MODE offset in SoC caps"
	https://lore.kernel.org/20251016142752.2627710-13-richard.genoud@bootlin.com
      - "[PATCH v2 05/15] mtd: rawnand: sunxi: rework pattern found registers"
	https://lore.kernel.org/20251013152645.1119308-6-richard.genoud@bootlin.com
      - "[PATCH v2 07/15] mtd: rawnand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps"
	https://lore.kernel.org/20251013152645.1119308-8-richard.genoud@bootlin.com
      - "[PATCH v5 2/2] iio: imu: smi330: Add driver"
	https://lore.kernel.org/20251009153149.5162-3-Jianping.Shen@de.bosch.com
      - "[PATCH v3 2/8] pwm: rzg2l-gpt: Add info variable to struct rzg2l_gpt_chip"
	https://lore.kernel.org/20250923144524.191892-3-biju.das.jz@bp.renesas.com
      - "[PATCH v2 3/3] gpio: gpio-ltc4283: Add support for the LTC4283 Swap Controller"
	https://lore.kernel.org/20250903-ltc4283-support-v2-3-6bce091510bf@analog.com
      - "[PATCH v7 15/24] media: i2c: add Maxim GMSL2/3 serializer and deserializer framework"
	https://lore.kernel.org/20250718152500.2656391-16-demonsingur@gmail.com
[2] "[PATCH v3 0/4] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1739540679.git.geert+renesas@glider.be/
[3] "[PATCH v2 0/3] Non-const bitfield helpers"
    https://lore.kernel.org/all/cover.1738329458.git.geert+renesas@glider.be
[4] "[PATCH 00/17] Non-const bitfield helper conversions"
    https://lore.kernel.org/all/cover.1637592133.git.geert+renesas@glider.be

Geert Uytterhoeven (4):
  bitfield: Drop underscores from macro parameters
  bitfield: Add non-constant field_{prep,get}() helpers
  clk: renesas: Use bitfield helpers
  soc: renesas: Use bitfield helpers

 drivers/clk/at91/clk-peripheral.c             |   1 +
 drivers/clk/at91/pmc.h                        |   3 -
 drivers/clk/renesas/clk-div6.c                |   6 +-
 drivers/clk/renesas/rcar-gen3-cpg.c           |  15 +-
 drivers/clk/renesas/rcar-gen4-cpg.c           |   9 +-
 .../intel/qat/qat_common/adf_pm_dbgfs_utils.c |   8 +-
 drivers/edac/ie31200_edac.c                   |   4 +-
 drivers/gpio/gpio-aspeed.c                    |   5 +-
 drivers/iio/dac/ad3530r.c                     |   3 -
 drivers/iio/temperature/mlx90614.c            |   5 +-
 drivers/pinctrl/nuvoton/pinctrl-ma35.c        |   4 -
 drivers/soc/renesas/renesas-soc.c             |   4 +-
 drivers/soc/renesas/rz-sysc.c                 |   3 +-
 include/linux/bitfield.h                      | 142 +++++++++++-------
 sound/usb/mixer_quirks.c                      |   4 -
 15 files changed, 108 insertions(+), 108 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


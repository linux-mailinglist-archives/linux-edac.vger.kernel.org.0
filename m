Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C457A2D96F8
	for <lists+linux-edac@lfdr.de>; Mon, 14 Dec 2020 12:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgLNLFT (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Dec 2020 06:05:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:50050 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407542AbgLNLFO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Dec 2020 06:05:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 28B6BAC91;
        Mon, 14 Dec 2020 11:04:27 +0000 (UTC)
Date:   Mon, 14 Dec 2020 12:04:22 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 5.11
Message-ID: <20201214110422.GA26358@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the accumulated EDAC tree for 5.11. It was somewhat busier
than usual this cycle. Tag message has the details.

Thx.

---

The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.11

for you to fetch changes up to f84b799996e29ad3b37e83f7871e79023f29979d:

  Merge branches 'edac-spr', 'edac-igen6' and 'edac-misc' into edac-updates-for-v5.11 (2020-12-14 11:51:46 +0100)

----------------------------------------------------------------
- Add support for AST2400 and AST2600 hw to aspeed_edac (Troy Lee)

- Remove an orphaned mv64x60_edac driver. Good riddance. (Michael Ellerman)

- Add a new igen6 driver for Intel client SoCs with an integrated memory
controller and using in-band ECC (Qiuxu Zhuo and Tony Luck)

- The usual smattering of fixes and cleanups all over.

----------------------------------------------------------------
Borislav Petkov (3):
      EDAC: Do not issue useless debug statements in the polling routine
      EDAC/amd64: Fix PCI component registration
      Merge branches 'edac-spr', 'edac-igen6' and 'edac-misc' into edac-updates-for-v5.11

Mauro Carvalho Chehab (1):
      EDAC: Fix some kernel-doc markups

Michael Ellerman (1):
      EDAC/mv64x60: Remove orphan mv64x60 driver

Qiuxu Zhuo (6):
      EDAC: Add three new memory types
      EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC
      EDAC/igen6: Add debugfs interface for Intel client SoC EDAC driver
      EDAC/i10nm: Use readl() to access MMIO registers
      EDAC: Add DDR5 new memory type
      EDAC/i10nm: Add Intel Sapphire Rapids server support

Tom Rix (1):
      EDAC/amd64: Remove unneeded breaks

Tony Luck (2):
      MAINTAINERS: Clean up the F: entries for some EDAC drivers
      MAINTAINERS: Add entry for Intel IGEN6 EDAC driver

Troy Lee (3):
      dt-bindings: edac: aspeed-sdram-edac: Add ast2400/ast2600 support
      ARM: dts: aspeed: Add AST2600 EDAC into common devicetree
      EDAC/aspeed: Add support for AST2400 and AST2600

Zhang Xiaoxu (1):
      EDAC/synopsys: Return the correct value in mc_probe()

kernel test robot (1):
      EDAC/igen6: ecclog_llist can be static

 .../devicetree/bindings/edac/aspeed-sdram-edac.txt |   9 +-
 MAINTAINERS                                        |  11 +-
 arch/arm/boot/dts/aspeed-g6.dtsi                   |   6 +
 drivers/edac/Kconfig                               |  22 +-
 drivers/edac/Makefile                              |   2 +-
 drivers/edac/amd64_edac.c                          |  34 +-
 drivers/edac/amd76x_edac.c                         |   1 -
 drivers/edac/aspeed_edac.c                         |   7 +-
 drivers/edac/e752x_edac.c                          |   1 -
 drivers/edac/e7xxx_edac.c                          |   1 -
 drivers/edac/edac_device.h                         |  11 +-
 drivers/edac/edac_mc.c                             |   4 +
 drivers/edac/i10nm_base.c                          |  39 +-
 drivers/edac/i3000_edac.c                          |   1 -
 drivers/edac/i3200_edac.c                          |   1 -
 drivers/edac/i5000_edac.c                          |   2 +-
 drivers/edac/i5400_edac.c                          |   2 +-
 drivers/edac/i82443bxgx_edac.c                     |   1 -
 drivers/edac/i82860_edac.c                         |   1 -
 drivers/edac/i82875p_edac.c                        |   1 -
 drivers/edac/i82975x_edac.c                        |   1 -
 drivers/edac/ie31200_edac.c                        |   1 -
 drivers/edac/igen6_edac.c                          | 977 +++++++++++++++++++++
 drivers/edac/mv64x60_edac.c                        | 883 -------------------
 drivers/edac/mv64x60_edac.h                        | 114 ---
 drivers/edac/r82600_edac.c                         |   1 -
 drivers/edac/skx_base.c                            |   6 +-
 drivers/edac/skx_common.c                          |  23 +-
 drivers/edac/skx_common.h                          |  16 +-
 drivers/edac/synopsys_edac.c                       |   3 +-
 drivers/edac/x38_edac.c                            |   1 -
 include/linux/edac.h                               |  16 +-
 32 files changed, 1119 insertions(+), 1080 deletions(-)
 create mode 100644 drivers/edac/igen6_edac.c
 delete mode 100644 drivers/edac/mv64x60_edac.c
 delete mode 100644 drivers/edac/mv64x60_edac.h

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

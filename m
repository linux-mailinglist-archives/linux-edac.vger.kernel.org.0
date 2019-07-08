Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33407625EA
	for <lists+linux-edac@lfdr.de>; Mon,  8 Jul 2019 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbfGHQPw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 8 Jul 2019 12:15:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:23211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbfGHQPw (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 8 Jul 2019 12:15:52 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jul 2019 09:15:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,466,1557212400"; 
   d="scan'208";a="363849116"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2019 09:15:51 -0700
Date:   Mon, 8 Jul 2019 09:15:51 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: [GIT PULL] EDAC driver changes for v5.3
Message-ID: <20190708161550.GA23045@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/please-pull-for_5.3

for you to fetch changes up to d8655e7630dafa88bc37f101640e39c736399771:

  EDAC: Fix global-out-of-bounds write when setting edac_mc_poll_msec (2019-06-27 10:24:47 -0700)


All the bits that Boris had queued in his tree plus four patches
to add support for Intel Icelake Xeon and then fix a few corner
cases.

----------------------------------------------------------------
EDAC changes for v5.3

----------------------------------------------------------------
Colin Ian King (1):
      EDAC/sb_edac: Remove redundant update of tad_base

Eiichi Tsukata (1):
      EDAC: Fix global-out-of-bounds write when setting edac_mc_poll_msec

Greg KH (1):
      EDAC/sysfs: Drop device references properly

Greg Kroah-Hartman (1):
      EDAC: Make edac_debugfs_create_x*() return void

Marco Elver (2):
      EDAC/ie31200: Add Intel Coffee Lake CPU support
      EDAC/ie31200: Reformat PCI device table

Pan Bian (1):
      EDAC/sysfs: Fix memory leak when creating a csrow object

Qiuxu Zhuo (3):
      EDAC, i10nm: Add Intel additional Ice-Lake support
      EDAC, i10nm: Check ECC enabling status per channel
      EDAC, skx, i10nm: Fix source ID register offset

Thor Thayer (4):
      EDAC/altera: Add Stratix10 OCRAM ECC support
      arm64: dts: stratix10: Add OCRAM EDAC node
      EDAC/altera: Add Stratix10 SDMMC support
      arm64: dts: stratix10: Add SDMMC EDAC node

Yash Shah (1):
      EDAC/sifive: Add EDAC platform driver for SiFive SoCs

YueHaibing (1):
      EDAC/aspeed: Remove set but not used variable 'np'

 MAINTAINERS                                        |   6 ++
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   8 ++
 .../boot/dts/altera/socfpga_stratix10_socdk.dts    |  11 ++
 arch/riscv/Kconfig                                 |   1 +
 drivers/edac/Kconfig                               |   6 ++
 drivers/edac/Makefile                              |   1 +
 drivers/edac/altera_edac.c                         |  43 +++++++-
 drivers/edac/aspeed_edac.c                         |   4 -
 drivers/edac/debugfs.c                             |  12 +--
 drivers/edac/edac_mc_sysfs.c                       |  34 +++---
 drivers/edac/edac_module.h                         |  20 ++--
 drivers/edac/i10nm_base.c                          |  10 +-
 drivers/edac/ie31200_edac.c                        |  78 ++++++++------
 drivers/edac/sb_edac.c                             |   1 -
 drivers/edac/sifive_edac.c                         | 119 +++++++++++++++++++++
 drivers/edac/skx_base.c                            |   2 +-
 drivers/edac/skx_common.c                          |   4 +-
 drivers/edac/skx_common.h                          |   2 +-
 18 files changed, 284 insertions(+), 78 deletions(-)
 create mode 100644 drivers/edac/sifive_edac.c

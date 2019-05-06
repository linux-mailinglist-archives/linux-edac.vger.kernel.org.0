Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEEF21467C
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2019 10:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbfEFIhf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 May 2019 04:37:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725837AbfEFIhf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 May 2019 04:37:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22E41AEEC;
        Mon,  6 May 2019 08:37:34 +0000 (UTC)
Date:   Mon, 6 May 2019 10:37:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC pile for 5.2
Message-ID: <20190506083732.GB6094@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

here's the pile which accumulated this cycle in EDAC-land.

Please pull,
thx.

---
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_5.2

for you to fetch changes up to 8de9930a4618811edfaebc4981a9fafff2af9170:

  Revert "EDAC/amd64: Support more than two controllers for chip select handling" (2019-04-25 16:30:34 +0200)

----------------------------------------------------------------
* amd64_edac: Family 0x17, models 0x30-.. enablement (Yazen Ghannam)

* skx_*: Librarize it so that it can be shared between drivers (Qiuxu Zhuo)

* altera: Stratix10 improvements (Thor Thayer)

* The usual round of fixes, fixlets and cleanups

----------------------------------------------------------------
Borislav Petkov (1):
      Revert "EDAC/amd64: Support more than two controllers for chip select handling"

Qiuxu Zhuo (1):
      EDAC, skx, i10nm: Make skx_common.c a pure library

Thor Thayer (7):
      EDAC, altera: Fix S10 Double Bit Error Notification
      EDAC/altera: Do less intrusive error injection
      EDAC/altera: Initialize peripheral FIFOs in probe()
      EDAC/altera, firmware/intel: Add Stratix10 ECC DBE SMC call
      Documentation: dt: edac: Fix Stratix10 IRQ bindings
      Documentation: dt: edac: Add Stratix10 Peripheral bindings
      arm64: dts: stratix10: Use new Stratix10 EDAC bindings

Tony Luck (2):
      MAINTAINERS: Update entry for EDAC-SKYLAKE
      MAINTAINERS: Add entry for EDAC-I10NM

Yazen Ghannam (7):
      EDAC/amd64: Add Family 17h Model 30h PCI IDs
      EDAC/amd64: Use a macro for iterating over Unified Memory Controllers
      EDAC/amd64: Support more than two Unified Memory Controllers
      EDAC/amd64: Set maximum channel layer size depending on family
      EDAC/amd64: Recognize x16 symbol size
      EDAC/amd64: Support more than two controllers for chip select handling
      EDAC/amd64: Adjust printed chip select sizes when interleaved

 .../devicetree/bindings/edac/socfpga-eccmgr.txt    | 135 ++++++++++-
 MAINTAINERS                                        |   8 +-
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |  25 +-
 drivers/edac/altera_edac.c                         | 262 ++++++++++++---------
 drivers/edac/altera_edac.h                         |  69 +-----
 drivers/edac/amd64_edac.c                          | 135 ++++++++---
 drivers/edac/amd64_edac.h                          |  11 +-
 drivers/edac/i10nm_base.c                          |  52 +++-
 drivers/edac/skx_base.c                            |  50 +++-
 drivers/edac/skx_common.c                          |  57 +----
 drivers/edac/skx_common.h                          |   8 -
 include/linux/firmware/intel/stratix10-smc.h       |  19 ++
 12 files changed, 537 insertions(+), 294 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)

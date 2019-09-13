Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7010AB1910
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 09:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728404AbfIMHmj (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 03:42:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:41706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfIMHmj (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 03:42:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 908DFAF57;
        Fri, 13 Sep 2019 07:42:36 +0000 (UTC)
Date:   Fri, 13 Sep 2019 09:42:29 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC pile for 5.4
Message-ID: <20190913074229.GA20745@zn.tnic>
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

here's an early pull request from EDAC-land for the upcoming merge
window. The new thing this time around is that we have three maintainers
now and a new, old repo. New because it is new for the EDAC tree which
is hosted there from now on and old because it is Tony's and mine's old
RAS repo which we still use occasionally when the stuff isn't in tip.

Anyway, below are the gory details, please pull,
thx.

---
The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.4

for you to fetch changes up to 3e443eb353eda6f4b4796e07f2599683fa752f1d:

  EDAC/amd64: Add PCI device IDs for family 17h, model 70h (2019-09-07 07:29:27 +0200)

----------------------------------------------------------------
* EDAC tree has three maintainers and one new designated reviewer now,
so that the work can scale better.

* New driver for Mellanox' BlueField SoC DDR controller	(Shravan Kumar Ramani)

* AMD Rome support in amd64_edac (Yazen Ghannam and Isaac Vaughn)

* Misc fixes, cleanups and code improvements

----------------------------------------------------------------
Dan Carpenter (1):
      EDAC/altera: Use the proper type for the IRQ status bits

Isaac Vaughn (1):
      EDAC/amd64: Add PCI device IDs for family 17h, model 70h

Mauro Carvalho Chehab (1):
      MAINTAINERS: update EDAC entry to reflect current tree and maintainers

Robert Richter (6):
      EDAC/mc: Fix grain_bits calculation
      EDAC/mc: Cleanup _edac_mc_free() code
      EDAC: Prefer 'unsigned int' to bare use of 'unsigned'
      EDAC/mc_sysfs: Remove pointless gotos
      EDAC/mc_sysfs: Make debug messages consistent
      MAINTAINERS: Add Robert as a EDAC reviewer

Shravan Kumar Ramani (1):
      EDAC, mellanox: Add ECC support for BlueField DDR4

Stephen Douthit (1):
      EDAC, pnd2: Fix ioremap() size in dnv_rd_reg()

Thor Thayer (1):
      edac: altera: Move Stratix10 SDRAM ECC to peripheral

Yazen Ghannam (7):
      EDAC/amd64: Support more than two controllers for chip selects handling
      EDAC/amd64: Recognize DRAM device type ECC capability
      EDAC/amd64: Initialize DIMM info for systems with more than two channels
      EDAC/amd64: Find Chip Select memory size using Address Mask
      EDAC/amd64: Decode syndrome before translating address
      EDAC/amd64: Cache secondary Chip Select registers
      EDAC/amd64: Support asymmetric dual-rank DIMMs

 MAINTAINERS                   |  10 +-
 drivers/edac/Kconfig          |   7 +
 drivers/edac/Makefile         |   1 +
 drivers/edac/altera_edac.c    |  58 ++++++-
 drivers/edac/altera_edac.h    |  25 ++-
 drivers/edac/amd64_edac.c     | 371 ++++++++++++++++++++++++++++--------------
 drivers/edac/amd64_edac.h     |  15 +-
 drivers/edac/bluefield_edac.c | 356 ++++++++++++++++++++++++++++++++++++++++
 drivers/edac/edac_mc.c        |  53 +++---
 drivers/edac/edac_mc.h        |   6 +-
 drivers/edac/edac_mc_sysfs.c  |  92 +++++------
 drivers/edac/ghes_edac.c      |   2 +-
 drivers/edac/i5100_edac.c     |  16 +-
 drivers/edac/pnd2_edac.c      |   7 +-
 include/linux/edac.h          |  10 +-
 15 files changed, 803 insertions(+), 226 deletions(-)
 create mode 100644 drivers/edac/bluefield_edac.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE178108956
	for <lists+linux-edac@lfdr.de>; Mon, 25 Nov 2019 08:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725818AbfKYHla (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 25 Nov 2019 02:41:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:54482 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfKYHla (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 25 Nov 2019 02:41:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CE29AB1DC;
        Mon, 25 Nov 2019 07:41:27 +0000 (UTC)
Date:   Mon, 25 Nov 2019 08:41:18 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC queue for 5.5
Message-ID: <20191125074118.GA12432@zn.tnic>
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

a lot of changes this time around, tag message has the details. From
the next cycle onwards, we'll switch the EDAC tree to topic branches
(instead of a single edac-for-next branch) which should make the
changes handling more flexible, hopefully. We'll see.

Please pull, thanks.

The following changes since commit 1e72e673b9d102ff2e8333e74b3308d012ddf75b:

  EDAC/ghes: Fix Use after free in ghes_edac remove path (2019-10-17 11:27:05 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_for_5.5

for you to fetch changes up to 5781823fd0d39082bfe2bbc20408aaa85a6e06ad:

  EDAC/altera: Use the Altera System Manager driver (2019-11-22 10:18:29 +0100)

----------------------------------------------------------------
* Rework error logging functions to accept a count of errors parameter 	(Hanna Hawa)

* Part one of substantial EDAC core + ghes_edac driver cleanup		(Robert Richter)

* Print additional useful logging information in skx_*			(Tony Luck)

* Improve amd64_edac hw detection + cleanups				(Yazen Ghannam)

* Misc cleanups, fixes and code improvements

----------------------------------------------------------------
Borislav Petkov (2):
      Merge branch 'edac-urgent' into edac-for-next
      EDAC/amd64: Get rid of the ECC disabled long message

Hanna Hawa (1):
      EDAC/device: Rework error logging API

Markus Elfring (1):
      EDAC/aspeed: Use devm_platform_ioremap_resource() in aspeed_probe()

Mauro Carvalho Chehab (7):
      EDAC: i5100_edac: get rid of an unused var
      EDAC: i7300_edac: rename a kernel-doc var description
      EDAC: i7300_edac: fix a kernel-doc syntax
      EDAC: i5400_edac: print type at debug message
      EDAC: i5400_edac: get rid of some unused vars
      EDAC: sb_edac: get rid of unused vars
      EDAC: skx_common: get rid of unused type var

Meng Li (1):
      EDAC/altera: Use fast register IO for S10 IRQs

Robert Richter (14):
      EDAC/ghes: Fix locking and memory barrier issues
      EDAC: Replace EDAC_DIMM_PTR() macro with edac_get_dimm() function
      EDAC: Remove EDAC_DIMM_OFF() macro
      EDAC: Introduce an mci_for_each_dimm() iterator
      EDAC/mc: Do not BUG_ON() in edac_mc_alloc()
      EDAC/mc: Remove needless zero string termination
      EDAC/mc: Reduce indentation level in edac_mc_handle_error()
      EDAC: Remove misleading comment in struct edac_raw_error_desc
      EDAC/ghes: Use standard kernel macros for page calculations
      EDAC/ghes: Fix grain calculation
      EDAC/ghes: Remove intermediate buffer pvt->detail_location
      EDAC: Unify the mc_event tracepoint call
      EDAC/Documentation: Describe CPER module definition and DIMM ranks
      EDAC/ghes: Do not warn when incrementing refcount on 0

Thor Thayer (2):
      EDAC/altera: Cleanup the ECC Manager
      EDAC/altera: Use the Altera System Manager driver

Tony Luck (2):
      EDAC, skx_common: Refactor so that we initialize "dev" in result of adxl decode.
      EDAC, skx: Retrieve and print retry_rd_err_log registers

Yazen Ghannam (6):
      EDAC/amd64: Set grain per DIMM
      EDAC/amd64: Make struct amd64_family_type global
      EDAC/amd64: Gather hardware information early
      EDAC/amd64: Save max number of controllers to family type
      EDAC/amd64: Use cached data when checking for ECC
      EDAC/amd64: Check for memory before fully initializing an instance

 Documentation/admin-guide/ras.rst |  31 +++---
 drivers/edac/altera_edac.c        | 152 ++------------------------
 drivers/edac/amd64_edac.c         | 217 ++++++++++++++++++--------------------
 drivers/edac/amd64_edac.h         |   2 +
 drivers/edac/aspeed_edac.c        |   7 +-
 drivers/edac/edac_device.c        |  50 +++++----
 drivers/edac/edac_device.h        |  54 ++++++++--
 drivers/edac/edac_mc.c            | 138 ++++++++++++------------
 drivers/edac/edac_mc_sysfs.c      |  49 +++------
 drivers/edac/ghes_edac.c          | 128 +++++++++++++---------
 drivers/edac/i10nm_base.c         |   3 +-
 drivers/edac/i3200_edac.c         |   3 +-
 drivers/edac/i5000_edac.c         |   5 +-
 drivers/edac/i5100_edac.c         |  16 +--
 drivers/edac/i5400_edac.c         |  18 +---
 drivers/edac/i7300_edac.c         |   7 +-
 drivers/edac/i7core_edac.c        |   3 +-
 drivers/edac/ie31200_edac.c       |   7 +-
 drivers/edac/pnd2_edac.c          |   4 +-
 drivers/edac/sb_edac.c            |  23 ++--
 drivers/edac/skx_base.c           |  54 +++++++++-
 drivers/edac/skx_common.c         |  65 ++++++------
 drivers/edac/skx_common.h         |   4 +-
 drivers/edac/ti_edac.c            |   2 +-
 include/linux/edac.h              | 146 ++++++++++++-------------
 25 files changed, 555 insertions(+), 633 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

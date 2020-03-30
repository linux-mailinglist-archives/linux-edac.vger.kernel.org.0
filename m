Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E00D1197656
	for <lists+linux-edac@lfdr.de>; Mon, 30 Mar 2020 10:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbgC3ITv (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Mar 2020 04:19:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:41536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgC3ITv (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 30 Mar 2020 04:19:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9703DAAFD;
        Mon, 30 Mar 2020 08:19:48 +0000 (UTC)
Date:   Mon, 30 Mar 2020 10:19:48 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 5.7
Message-ID: <20200330081948.GC14624@zn.tnic>
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

please pull the pile we've managed to collect this time around.

Thx.

---
The following changes since commit 7111951b8d4973bda27ff663f2cf18b663d15b48:

  Linux 5.6 (2020-03-29 15:25:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.7

for you to fetch changes up to 41dac9a2ad4a3d5c96394a23dd53b7e6edcb80ba:

  Merge branches 'edac-mc-cleanup', 'edac-misc', 'edac-drivers' and 'edac-urgent' into edac-updates-for-5.7 (2020-03-30 10:07:58 +0200)

----------------------------------------------------------------
* A substantial edac_mc cleanup, sanitizing object freeing, streamlining
and simplifying code flow, and getting rid of a lot of needless complexity in
memory controller representation code, by Robert Richter.

* A new EDAC driver for the ARM DMC-520 memory controller, by Lei Wang, Shiping
Ji and others.

* The usual sprinkling of misc cleanups and fixes all over the subsystem.

----------------------------------------------------------------
Borislav Petkov (1):
      Merge branches 'edac-mc-cleanup', 'edac-misc', 'edac-drivers' and 'edac-urgent' into edac-updates-for-5.7

Lei Wang (2):
      dt-bindings: edac: Dmc-520.yaml
      EDAC: Add EDAC driver for DMC520

Prarit Bhargava (1):
      EDAC/mce_amd: Print !SMCA processor warning only once

Robert Richter (11):
      EDAC/mc: Change mci device removal to use put_device()
      EDAC/mc: Split edac_mc_alloc() into smaller functions
      EDAC/mc: Reorder functions edac_mc_alloc*()
      EDAC: Store error type in struct edac_raw_error_desc
      EDAC/mc: Determine mci pointer from the error descriptor
      EDAC/mc: Carve out error increment into a separate function
      EDAC/mc: Report "unknown memory" on too many DIMM labels found
      EDAC/mc: Remove enable_per_layer_report function argument
      EDAC/mc: Pass the error descriptor to error reporting functions
      EDAC/mc: Remove detail[] string and cleanup error string generation
      EDAC/mc: Remove per layer counters

Sherry Sun (1):
      EDAC/synopsys: Do not dump uninitialized pinf->col

Takashi Iwai (1):
      EDAC/armada_xp: Use scnprintf() for avoiding potential buffer overflow

 .../devicetree/bindings/edac/dmc-520.yaml          |  59 ++
 MAINTAINERS                                        |   6 +
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/armada_xp_edac.c                      |  26 +-
 drivers/edac/dmc520_edac.c                         | 656 +++++++++++++++++++++
 drivers/edac/edac_mc.c                             | 511 ++++++++--------
 drivers/edac/edac_mc.h                             |   6 +-
 drivers/edac/edac_mc_sysfs.c                       | 110 ++--
 drivers/edac/edac_module.h                         |   1 -
 drivers/edac/ghes_edac.c                           |  16 +-
 drivers/edac/mce_amd.c                             |   2 +-
 drivers/edac/synopsys_edac.c                       |  22 +-
 include/linux/edac.h                               |   9 +-
 14 files changed, 1054 insertions(+), 378 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/edac/dmc-520.yaml
 create mode 100644 drivers/edac/dmc520_edac.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

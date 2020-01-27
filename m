Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB21614A2DE
	for <lists+linux-edac@lfdr.de>; Mon, 27 Jan 2020 12:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgA0LSE (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Jan 2020 06:18:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:38440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgA0LSD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Jan 2020 06:18:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E36B6AAB8;
        Mon, 27 Jan 2020 11:18:01 +0000 (UTC)
Date:   Mon, 27 Jan 2020 12:17:55 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS pile for 5.6
Message-ID: <20200127111755.GC24228@zn.tnic>
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

please pull the below branch to receive the following RAS updates:

* Misc fixes to the MCA code all over the place, by Jan H. Schönherr.

* Initial support for AMD F19h and other cleanups to amd64_edac, by Yazen
Ghannam.

* Other small cleanups.

Thx.

---

The following changes since commit 7de7de7ca0ae0fc70515ee3154af33af75edae2c:

  Fix root mounting with no mount options (2019-12-16 08:42:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

for you to fetch changes up to 86e9f9d60eb5e0c5d99ddf6b79f4d308d6453bd0:

  EDAC/mce_amd: Make fam_ops static global (2020-01-16 21:52:48 +0100)

----------------------------------------------------------------
Arnd Bergmann (1):
      x86/mce/therm_throt: Mark throttle_active_work() as __maybe_unused

Borislav Petkov (1):
      EDAC/mce_amd: Make fam_ops static global

Jan H. Schönherr (5):
      x86/mce: Pass MCE message to mce_panic() on failed kernel recovery
      x86/mce: Remove mce_inject_log() in favor of mce_log()
      x86/mce: Take action on UCNA/Deferred errors again
      x86/mce: Fix mce=nobootlog
      x86/mce: Fix use of uninitialized MCE message string

Yazen Ghannam (5):
      x86/MCE/AMD, EDAC/mce_amd: Add new Load Store unit McaType
      EDAC/mce_amd: Always load on SMCA systems
      x86/amd_nb: Add Family 19h PCI IDs
      EDAC/amd64: Add family ops for Family 19h Models 00h-0Fh
      EDAC/amd64: Drop some family checks for newer systems

 arch/x86/include/asm/mce.h            |   3 +-
 arch/x86/kernel/amd_nb.c              |   3 +
 arch/x86/kernel/cpu/mce/amd.c         |   2 +
 arch/x86/kernel/cpu/mce/core.c        |  70 ++++++++++-------------
 arch/x86/kernel/cpu/mce/inject.c      |   2 +-
 arch/x86/kernel/cpu/mce/internal.h    |   2 -
 arch/x86/kernel/cpu/mce/therm_throt.c |   2 +-
 drivers/edac/amd64_edac.c             |  62 +++++++++++---------
 drivers/edac/amd64_edac.h             |   3 +
 drivers/edac/mce_amd.c                | 105 ++++++++++++++++++++--------------
 include/linux/pci_ids.h               |   1 +
 11 files changed, 141 insertions(+), 114 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

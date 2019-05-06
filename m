Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B73381491F
	for <lists+linux-edac@lfdr.de>; Mon,  6 May 2019 13:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbfEFLq7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 6 May 2019 07:46:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:40624 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfEFLq7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 6 May 2019 07:46:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EC0B1AEB3;
        Mon,  6 May 2019 11:46:57 +0000 (UTC)
Date:   Mon, 6 May 2019 13:46:51 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 5.2
Message-ID: <20190506114651.GG6094@zn.tnic>
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

please pull this branch

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

to receive the latest RAS updates:

- Support for varying MCA bank numbers per CPU: this is in preparation for
  future CPU enablement (Yazen Ghannam)

- MCA banks read race fix (Tony Luck)

- Facility to filter MCEs which should not be logged (Yazen Ghannam)

- The usual round of cleanups and fixes

Thx.

---
The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

for you to fetch changes up to 71a84402b93e5fbd8f817f40059c137e10171788:

  x86/MCE/AMD: Don't report L1 BTB MCA errors on some family 17h models (2019-04-23 18:16:07 +0200)

----------------------------------------------------------------
Borislav Petkov (1):
      x86/mce: Remove mce_report_event()

Tony Luck (2):
      MAINTAINERS: Fix file pattern for X86 MCE INFRASTRUCTURE
      x86/mce: Fix machine_check_poll() tests for error types

WANG Chao (1):
      RAS/CEC: Increment cec_entered under the mutex lock

Yazen Ghannam (4):
      x86/MCE: Group AMD function prototypes in <asm/mce.h>
      x86/mce: Handle varying MCA bank counts
      x86/MCE: Add an MCE-record filtering function
      x86/MCE/AMD: Don't report L1 BTB MCA errors on some family 17h models

YueHaibing (1):
      x86/mce: Fix debugfs_simple_attr.cocci warnings

 MAINTAINERS                        |   2 +-
 arch/x86/include/asm/mce.h         |  25 ++++-----
 arch/x86/kernel/cpu/mce/amd.c      |  52 ++++++++++++++-----
 arch/x86/kernel/cpu/mce/core.c     | 102 +++++++++++++++++++++----------------
 arch/x86/kernel/cpu/mce/genpool.c  |   3 ++
 arch/x86/kernel/cpu/mce/inject.c   |  14 ++---
 arch/x86/kernel/cpu/mce/internal.h |   9 ++++
 drivers/edac/mce_amd.c             |   4 +-
 drivers/ras/cec.c                  |   4 +-
 9 files changed, 132 insertions(+), 83 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Mary Higgins, Sri Rasiah, HRB 21284 (AG Nürnberg)

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50B3DB195A
	for <lists+linux-edac@lfdr.de>; Fri, 13 Sep 2019 10:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfIMIKr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 13 Sep 2019 04:10:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58902 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727834AbfIMIKr (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 13 Sep 2019 04:10:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAC18AFBC;
        Fri, 13 Sep 2019 08:10:45 +0000 (UTC)
Date:   Fri, 13 Sep 2019 10:10:39 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tony Luck <tony.luck@intel.com>, x86-ml <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 5.4
Message-ID: <20190913080937.GB20745@zn.tnic>
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

to receive the latest meager RAS updates for 5.4:

- Enable processing of action-optional MCEs which have the Overflow bit set
  (Tony	Luck)

- -Wmissing-prototypes warning fix and a build fix (Valdis Klētnieks)

Thx.

---
The following changes since commit e21a712a9685488f5ce80495b37b9fdbe96c230d:

  Linux 5.3-rc3 (2019-08-04 18:40:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-for-linus

for you to fetch changes up to b6ff24f7b5101101ff897dfdde3f37924e676bc2:

  RAS: Build debugfs.o only when enabled in Kconfig (2019-08-08 17:44:02 +0200)

----------------------------------------------------------------
Tony Luck (1):
      x86/mce: Don't check for the overflow bit on action optional machine checks

Valdis Kletnieks (2):
      RAS: Fix prototype warnings
      RAS: Build debugfs.o only when enabled in Kconfig

 arch/x86/kernel/cpu/mce/severity.c | 4 ++--
 drivers/ras/Makefile               | 3 ++-
 drivers/ras/cec.c                  | 1 +
 drivers/ras/debugfs.c              | 2 ++
 4 files changed, 7 insertions(+), 3 deletions(-)


-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 247165, AG München

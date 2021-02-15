Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6926131B64B
	for <lists+linux-edac@lfdr.de>; Mon, 15 Feb 2021 10:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBOJRi (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 15 Feb 2021 04:17:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:36784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhBOJRh (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 15 Feb 2021 04:17:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA2EDAD19;
        Mon, 15 Feb 2021 09:16:55 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:16:53 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v5.12
Message-ID: <20210215091653.GA23409@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the EDAC side of updates for v5.12.

Thx.

---

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.12

for you to fetch changes up to 6118b488933b0311e28420d4cd1ee06caf59682b:

  Merge branch 'edac-misc' into edac-updates-for-v5.12 (2021-02-15 10:06:58 +0100)

----------------------------------------------------------------
- A couple of fixes/improvements to amd64_edac:
 - merge debugging and error injection functionality into the main driver
 - tone down info/error output
 - do not attempt to load it on F15h client hw

- Misc fixes to other drivers

----------------------------------------------------------------
Borislav Petkov (6):
      EDAC/amd64: Do not load on family 0x15, model 0x13
      EDAC/amd64: Merge sysfs debugging attributes setup code
      EDAC/amd64: Merge error injection sysfs facilities
      EDAC/amd64: Limit error injection functionality to supported hw
      EDAC/amd64: Issue probing messages only on properly detected hardware
      Merge branch 'edac-misc' into edac-updates-for-v5.12

Menglong Dong (1):
      EDAC/xgene: Do not print a failure message to get an IRQ twice

Yazen Ghannam (1):
      EDAC/amd64: Tone down messages about missing PCI IDs

Zheng Yongjun (1):
      EDAC/ppc4xx: Convert comma to semicolon

 drivers/edac/Kconfig          |  15 +-
 drivers/edac/Makefile         |   7 +-
 drivers/edac/amd64_edac.c     | 332 +++++++++++++++++++++++++++++++++++++++---
 drivers/edac/amd64_edac.h     |  11 --
 drivers/edac/amd64_edac_dbg.c |  55 -------
 drivers/edac/amd64_edac_inj.c | 235 ------------------------------
 drivers/edac/ppc4xx_edac.c    |   2 +-
 drivers/edac/xgene_edac.c     |   2 +-
 8 files changed, 319 insertions(+), 340 deletions(-)
 delete mode 100644 drivers/edac/amd64_edac_dbg.c
 delete mode 100644 drivers/edac/amd64_edac_inj.c

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

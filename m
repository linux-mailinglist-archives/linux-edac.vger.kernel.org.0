Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA931EA159
	for <lists+linux-edac@lfdr.de>; Mon,  1 Jun 2020 11:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgFAJxZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Jun 2020 05:53:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:51006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAJxZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 1 Jun 2020 05:53:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E82CAC96;
        Mon,  1 Jun 2020 09:53:25 +0000 (UTC)
Date:   Mon, 1 Jun 2020 11:53:17 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC for 5.8
Message-ID: <20200601095317.GB30795@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the EDAC queue which accumulated this time around.

Thx.

---
The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_5.8

for you to fetch changes up to 2a02ca0428cfe68cce600111acb4c6f7d85cf71f:

  Merge branches 'edac-i10nm' and 'edac-misc' into edac-updates-for-5.8 (2020-06-01 11:39:15 +0200)

----------------------------------------------------------------
* Fix i10nm_edac loading on some Ice Lake and Tremont/Jacobsville
steppings due to the offset change of the bus number configuration
register, by Qiuxu Zhuo.

* The usual cleanups and fixes all over the place.

----------------------------------------------------------------
Borislav Petkov (1):
      Merge branches 'edac-i10nm' and 'edac-misc' into edac-updates-for-5.8

Christophe JAILLET (1):
      EDAC/armada_xp: Fix some log messages

Colin Ian King (1):
      EDAC/amd64: Remove redundant assignment to variable ret in hw_info_get()

Jason Yan (2):
      EDAC/xgene: Remove set but not used address local var
      EDAC/amd8131: Remove defined but not used bridge_str

Lukas Bulwahn (1):
      MAINTAINERS: Remove sifive_l2_cache.c from EDAC-SIFIVE pattern

Qiuxu Zhuo (3):
      EDAC, {skx,i10nm}: Make some configurations CPU model specific
      EDAC/i10nm: Update driver to support different bus number config register offsets
      EDAC/skx: Use the mcmtr register to retrieve close_pg/bank_xor_enable

Zou Wei (1):
      EDAC/thunderx: Make symbols static

 MAINTAINERS                   |  1 -
 drivers/edac/amd64_edac.c     |  2 +-
 drivers/edac/amd8131_edac.c   |  8 --------
 drivers/edac/armada_xp_edac.c | 14 +++++++-------
 drivers/edac/i10nm_base.c     | 29 ++++++++++++++++++++++++-----
 drivers/edac/skx_base.c       | 33 +++++++++++++++++++--------------
 drivers/edac/skx_common.c     | 17 ++++++++---------
 drivers/edac/skx_common.h     | 13 ++++++++++---
 drivers/edac/thunderx_edac.c  |  8 ++++----
 drivers/edac/xgene_edac.c     |  3 ---
 10 files changed, 73 insertions(+), 55 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

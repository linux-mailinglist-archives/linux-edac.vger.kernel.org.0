Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816453FB323
	for <lists+linux-edac@lfdr.de>; Mon, 30 Aug 2021 11:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbhH3Jb6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 30 Aug 2021 05:31:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:33944 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235652AbhH3Jb5 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 30 Aug 2021 05:31:57 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 8A18C20081;
        Mon, 30 Aug 2021 09:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630315863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fGw7X/4tGPPL8uwTZJfyYTN9c8KyFzMUk6wIEVD46Nw=;
        b=lQZrv6O6EGP93LA2Du9cv9NXkWbMP2hKQPyCACGBqnScQw/EOgl0oWZphak0yxuA/90uxA
        9OUtkpUURMHDr2tISrW7O+nI69ppWdlnEvoCASqXLR6ZbPbsqA7Ovy6LAePBu7+3+lxH0S
        FKZlYl0ZcU2obwHdWdxG4qPi00DoGFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630315863;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=fGw7X/4tGPPL8uwTZJfyYTN9c8KyFzMUk6wIEVD46Nw=;
        b=wk74GIDS/gN4iIYtq1CZkgWAhHRTQa9kUsUMNXoYHl0tvP48rY3VDMpYK3Y54OpLpDYAsh
        LjlKqeCbWaGU1mCA==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 794691365C;
        Mon, 30 Aug 2021 09:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id p/8hHVelLGHYNgAAGKfGzw
        (envelope-from <bp@suse.de>); Mon, 30 Aug 2021 09:31:03 +0000
Date:   Mon, 30 Aug 2021 11:31:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v5.15
Message-ID: <YSyldBbc4ngIMUhS@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

here's the usual boring EDAC pull request of stuff which managed to
trickle in for 5.15.

Please pull,
thx.

---

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.15

for you to fetch changes up to cf4e6d52f58399c777276172ec250502e19d5e63:

  EDAC/i10nm: Retrieve and print retry_rd_err_log registers (2021-08-23 10:35:36 -0700)

----------------------------------------------------------------
- Add new HBM2 (High Bandwidth Memory Gen 2) type and add support for it
to the Intel SKx drivers

- Print additional useful per-channel error information on i10nm, like on SKL

- Check whether the AMD decoder is loaded on a guest and if so, don't

- The usual round of fixes and cleanups

----------------------------------------------------------------
Dwaipayan Ray (1):
      EDAC/amd64: Use DEVICE_ATTR helper macros

Krzysztof Kozlowski (1):
      EDAC/altera: Skip defining unused structures for specific configs

Naveen Krishna Chatradhi (1):
      EDAC/mc: Add new HBM2 memory type

Qiuxu Zhuo (2):
      EDAC/skx_common: Set the memory type correctly for HBM memory
      EDAC/i10nm: Fix NVDIMM detection

Smita Koralahalli (1):
      EDAC/mce_amd: Do not load edac_mce_amd module on guests

Youquan Song (1):
      EDAC/i10nm: Retrieve and print retry_rd_err_log registers

 drivers/edac/altera_edac.c |  44 +++++++------
 drivers/edac/amd64_edac.c  |  21 +++----
 drivers/edac/edac_mc.c     |   1 +
 drivers/edac/i10nm_base.c  | 152 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/edac/mce_amd.c     |   3 +
 drivers/edac/skx_base.c    |   3 +-
 drivers/edac/skx_common.c  |   9 ++-
 drivers/edac/skx_common.h  |   7 ++-
 include/linux/edac.h       |   3 +
 9 files changed, 205 insertions(+), 38 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

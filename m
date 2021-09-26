Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB732418A7B
	for <lists+linux-edac@lfdr.de>; Sun, 26 Sep 2021 20:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhIZSYH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 26 Sep 2021 14:24:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51696 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhIZSYH (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 26 Sep 2021 14:24:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9C6CE21EE5;
        Sun, 26 Sep 2021 18:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1632680549; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8EjSpVVo/VrxM4pnh6TTso6DrAIAimhE0iGOe6MEwWo=;
        b=VzCKcbyfOLRvJDIKQRDxnmj4vU5CXAP1r25qmF+arsKu5xyzc/6PXi8DXmcHHG0gFn7/U/
        dGNU6iueRa4fKloedBbktsWMC/oKyQo5zVjIVpyrCELKDRZkKkzGqZQK7A6xnvzNxeCpXP
        MjyJbfKCzMCNtcUFyNE6mPsGsefAceg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1632680549;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8EjSpVVo/VrxM4pnh6TTso6DrAIAimhE0iGOe6MEwWo=;
        b=4zpkcCbtdQCcFSGfJie2tNUO3a03KRs61qpsGGK/zXMI5/0+8PwV95oyBCqVWwL1xevnlh
        9u/KHg/tV3M4cVBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83ADC13A1C;
        Sun, 26 Sep 2021 18:22:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gtzCH2W6UGHXTwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 26 Sep 2021 18:22:29 +0000
Date:   Sun, 26 Sep 2021 20:22:29 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fixes for v5.15-rc3
Message-ID: <YVC6ZS+Z3T0Ky87i@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull two EDAC fixes for v5.15-rc3.

Thx.

---
The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.15_rc3

for you to fetch changes up to 54607282fae6148641a08d81a6e0953b541249c7:

  EDAC/dmc520: Assign the proper type to dimm->edac_mode (2021-09-16 11:00:12 +0200)

----------------------------------------------------------------
Fix two EDAC drivers using the wrong value type for the DIMM mode.

----------------------------------------------------------------
Borislav Petkov (1):
      EDAC/dmc520: Assign the proper type to dimm->edac_mode

Sai Krishna Potthuri (1):
      EDAC/synopsys: Fix wrong value type assignment for edac_mode

 drivers/edac/dmc520_edac.c   | 2 +-
 drivers/edac/synopsys_edac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

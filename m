Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF3F4415DB
	for <lists+linux-edac@lfdr.de>; Mon,  1 Nov 2021 10:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhKAJLg (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 1 Nov 2021 05:11:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37390 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbhKAJLf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 1 Nov 2021 05:11:35 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6F2591FD6C;
        Mon,  1 Nov 2021 09:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1635757741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TxXL8ai+LaiG9ItDIIFOlbUzCDkbkCepe+Cl9UPOuk4=;
        b=nSlSK36iQ8qf9eOlCdco7NP6L9YqcfEOjh6wz11qBkW+KIBgRDxkXXhI2QOPD3yXiy9rkU
        q7mjjuHPkIlcFYZR/F1Bnrx4mG6FY/KCFcib+XD5SGXpQauLwfyE63czAR/7iBTSQRhVan
        KOGQAz4H4QeDIrK0FLZcQ1ZlQiYkUVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1635757741;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TxXL8ai+LaiG9ItDIIFOlbUzCDkbkCepe+Cl9UPOuk4=;
        b=Hrsiuy5jpuZB6wXanF0eZ75nPJjhYXAl3aYrPEeuFyOqZ749GQosTioCNOMVrONALSYjAu
        mty/YfdRnWMSJMAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 557CB13A6F;
        Mon,  1 Nov 2021 09:09:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5XBZFK2uf2E7MQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Nov 2021 09:09:01 +0000
Date:   Mon, 1 Nov 2021 10:08:57 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v5.16
Message-ID: <YX+uqd7WuvpfyfmD@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull a small pile of EDAC updates which the autumn wind blew my
way. :)

Thx.

---

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.16

for you to fetch changes up to 537bddd069c743759addf422d0b8f028ff0f8dbc:

  EDAC/sb_edac: Fix top-of-high-memory value for Broadwell/Haswell (2021-10-11 08:28:46 -0700)

----------------------------------------------------------------
- amd64_edac: Add support for three-rank interleaving mode which is
present on AMD zen2 servers

- The usual fixes and cleanups all over EDAC land

----------------------------------------------------------------
Cai Huoqing (1):
      EDAC/al_mc: Make use of the helper function devm_add_action_or_reset()

Eric Badger (2):
      EDAC/mc_sysfs: Print MC-scope sysfs counters unsigned
      EDAC/sb_edac: Fix top-of-high-memory value for Broadwell/Haswell

Len Baker (1):
      EDAC/mc: Replace strcpy(), sprintf() and snprintf() with strscpy() or scnprintf()

Tang Bin (1):
      EDAC/ti: Remove redundant error messages

Yazen Ghannam (1):
      EDAC/amd64: Handle three rank interleaving mode

 drivers/edac/al_mc_edac.c    | 12 ++++--------
 drivers/edac/amd64_edac.c    | 22 +++++++++++++++++++++-
 drivers/edac/edac_mc.c       | 42 ++++++++++++++++++------------------------
 drivers/edac/edac_mc_sysfs.c |  8 ++++----
 drivers/edac/sb_edac.c       |  2 +-
 drivers/edac/ti_edac.c       |  7 +------
 6 files changed, 49 insertions(+), 44 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg

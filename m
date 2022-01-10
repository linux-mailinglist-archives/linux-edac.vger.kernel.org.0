Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58B6A489548
	for <lists+linux-edac@lfdr.de>; Mon, 10 Jan 2022 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbiAJJfm (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 10 Jan 2022 04:35:42 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242952AbiAJJfk (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 10 Jan 2022 04:35:40 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 87CB01F398;
        Mon, 10 Jan 2022 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641807337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sizo3rC1sGmkVBeFS1L7qMfzgPXpZrS3YdS+cYJGvCI=;
        b=WXrQ3prBZpjmS980/GSIwfwUgLCg94tGn2x012O1oLBNKOVTJzEDwUK04LdLmMSt+CAYts
        mdakGnV5wHBYbz17gBLYfogWdpsECK9TtfV8dWiY++MKnDH4OJFmiHhAhpiI28XXSk3119
        atzJFFeGhuNnzAIPHHgdFBMSHPtbKeU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641807337;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=sizo3rC1sGmkVBeFS1L7qMfzgPXpZrS3YdS+cYJGvCI=;
        b=lY5iBfNZTuxtNpP08pSM+Pbxf+IFq6nWp7IDTbBDnD3LzR6HXdLKuB3P5l8A9FQNv961Ut
        vOPoLBfaOfRIIABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7131F13CAF;
        Mon, 10 Jan 2022 09:35:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C4k7Gun922EXMwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 10 Jan 2022 09:35:37 +0000
Date:   Mon, 10 Jan 2022 10:35:40 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v5.17
Message-ID: <Ydv97EG//cs7Xo99@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the collected pile of EDAC updates for v5.17.

Thx.

---

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.17_rc1

for you to fetch changes up to da0119a9123c73269657fc61f537223d6affef02:

  Merge branches 'edac-misc' and 'edac-amd64' into edac-updates-for-v5.17 (2022-01-10 10:07:00 +0100)

----------------------------------------------------------------
- Add support for version 3 of the Synopsys DDR controller to synopsys_edac

- Add support for DRR5 and new models 0x10-0x1f and 0x50-0x5f of AMD
  family 0x19 CPUs to amd64_edac

- The usual set of fixes and cleanups

----------------------------------------------------------------
Borislav Petkov (1):
      Merge branches 'edac-misc' and 'edac-amd64' into edac-updates-for-v5.17

Colin Ian King (1):
      EDAC/sb_edac: Remove redundant initialization of variable rc

Dinh Nguyen (4):
      EDAC/synopsys: Use the quirk for version instead of ddr version
      EDAC/synopsys: Add support for version 3 of the Synopsys EDAC DDR
      EDAC/synopsys: Enable the driver on Intel's N5X platform
      dt-bindings: memory: Add entry for version 3.80a

Jason Wang (1):
      RAS/CEC: Remove a repeated 'an' in a comment

Marc Bevand (1):
      EDAC/amd64: Add support for family 19h, models 50h-5fh

Randy Dunlap (1):
      EDAC/sifive: Fix non-kernel-doc comment

Yazen Ghannam (2):
      EDAC: Add RDDR5 and LRDDR5 memory types
      EDAC/amd64: Add support for AMD Family 19h Models 10h-1Fh and A0h-AFh

 .../memory-controllers/synopsys,ddrc-ecc.yaml      |  1 +
 drivers/edac/Kconfig                               |  2 +-
 drivers/edac/amd64_edac.c                          | 36 ++++++++++++++-
 drivers/edac/amd64_edac.h                          |  8 +++-
 drivers/edac/edac_mc.c                             |  2 +
 drivers/edac/sb_edac.c                             |  2 +-
 drivers/edac/sifive_edac.c                         |  2 +-
 drivers/edac/synopsys_edac.c                       | 52 ++++++++++++++++++----
 drivers/ras/cec.c                                  |  2 +-
 include/linux/edac.h                               |  6 +++
 10 files changed, 98 insertions(+), 15 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg

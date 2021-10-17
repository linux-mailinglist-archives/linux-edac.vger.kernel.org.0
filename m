Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4490B4307FD
	for <lists+linux-edac@lfdr.de>; Sun, 17 Oct 2021 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhJQKkR (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 17 Oct 2021 06:40:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44946 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbhJQKkQ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 17 Oct 2021 06:40:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B931B1FD63;
        Sun, 17 Oct 2021 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634467086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wL8xtjaYGEluhMiDXGEdJMCUjSyJvHUKLjf2FdHV0xs=;
        b=lr2L+pIdAWNYNqS/mYBU4U/NP3+j7GmqEn2FrDekd3qxpqK+J+IkcTdmZBW3A2ZhmVh3I9
        scFXOvwFWojLvYNPWo1eO5IwSNRvPXwMDRM4DdcKtzwoG3rdHIYiVRs1OqwAnQDecjfTGu
        m8jLBFdnObUahAPiwZP+RYUrT9suPIU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634467086;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=wL8xtjaYGEluhMiDXGEdJMCUjSyJvHUKLjf2FdHV0xs=;
        b=o9ltiLUJK0qq5x/vf9MgW0RX3Phy+hs0tFt3jvjDmXhgsDdHZt794h4GZ9s6RtCNE/TnBd
        zG92thXCbx+8RuCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9D06D1377A;
        Sun, 17 Oct 2021 10:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id is3lJQ79a2H9PQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 17 Oct 2021 10:38:06 +0000
Date:   Sun, 17 Oct 2021 12:38:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for v5.15-rc6
Message-ID: <YWv9Eb+ZYTtWfLSc@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull a single EDAC fix for 5.15.

Thx.

---

The following changes since commit 64570fbc14f8d7cb3fe3995f20e26bc25ce4b2cc:

  Linux 5.15-rc5 (2021-10-10 17:01:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.15_rc6

for you to fetch changes up to d9b7748ffc45250b4d7bcf22404383229bc495f5:

  EDAC/armada-xp: Fix output of uncorrectable error counter (2021-10-14 11:46:03 +0200)

----------------------------------------------------------------
- Log the "correct" uncorrectable error count in the armada_xp driver

----------------------------------------------------------------
Hans Potsch (1):
      EDAC/armada-xp: Fix output of uncorrectable error counter

 drivers/edac/armada_xp_edac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD524AAF17
	for <lists+linux-edac@lfdr.de>; Sun,  6 Feb 2022 12:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiBFLx6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 6 Feb 2022 06:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiBFLx6 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 6 Feb 2022 06:53:58 -0500
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 03:53:57 PST
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662EEC043182;
        Sun,  6 Feb 2022 03:53:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E50981F388;
        Sun,  6 Feb 2022 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644148097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oZ8Xjdv7kG8lFnid5+17QkbF2b+qiSsMNHXutjmdMEg=;
        b=tiUwKLqNr+bIivolGbXjhA3SSj5fUtJEk3SvW7u25jvrDHHQy6eppBiVQ2bDYwqlfAfoNn
        +haXTf7RP9uBRC8nteS9lr/dCeS0oMmuSfatIght2otsecrKEKWC5CsxopSrFK+IFIm2tA
        xKXcd6rTD0uFR2RP+37gcHCs0lOIWeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644148097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oZ8Xjdv7kG8lFnid5+17QkbF2b+qiSsMNHXutjmdMEg=;
        b=qihg8HdpLQQ5h7f+8TqvjbwKVVoD2NjiqqB5DN59UZwccj5UIM/hJ4fR82WAMJkZKIMXlj
        3viFNOKYe9WuMVAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDB1613A47;
        Sun,  6 Feb 2022 11:48:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ql//MIG1/2ELKgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 06 Feb 2022 11:48:17 +0000
Date:   Sun, 6 Feb 2022 12:48:10 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fixes for v5.17-rc3
Message-ID: <Yf+1ehVTFHkihPfd@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull two urgent EDAC fixes for 5.17.

Thx.

---

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.17_rc3

for you to fetch changes up to dfd0dfb9a7cc04acf93435b440dd34c2ca7b4424:

  EDAC/xgene: Fix deferred probing (2022-01-30 01:06:35 +0100)

----------------------------------------------------------------
- Fix altera and xgene EDAC drivers to propagate the correct error code
from platform_get_irq() so that deferred probing still works

----------------------------------------------------------------
Sergey Shtylyov (2):
      EDAC/altera: Fix deferred probing
      EDAC/xgene: Fix deferred probing

 drivers/edac/altera_edac.c | 2 +-
 drivers/edac/xgene_edac.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg

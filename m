Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1F585E4C
	for <lists+linux-edac@lfdr.de>; Sun, 31 Jul 2022 11:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGaJkb (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 31 Jul 2022 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaJka (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 31 Jul 2022 05:40:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4A4E0E5;
        Sun, 31 Jul 2022 02:40:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F29F938497;
        Sun, 31 Jul 2022 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659260426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HNOUpFYXc3QTc7PYzGt6rqrOHqypNorKziv3pX2Oxrs=;
        b=fuDDQwKPp6Twiw5oE2io+An54KE11Ci2xLqBmQri6f0RPWnH6aNXYK9HwtqCBZ+E4UQI20
        MrEKVZnp6AHifkKKUdMG59yFssXH2OfvCGjB6vIUE6+hxLbfoQpjRXZnUWSEdPrEvJEKck
        ZiIOCRg2QLhAec7CW7hsKo7WHUQFXFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659260427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HNOUpFYXc3QTc7PYzGt6rqrOHqypNorKziv3pX2Oxrs=;
        b=14oU+14n2q/+IpfeUUc8BjpN89+x0ht8ZQsrXWmMwu3n4d73ulFQ33PoEoWarqe02CgDHV
        yjA7Iv5w72g6etBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA3AD13416;
        Sun, 31 Jul 2022 09:40:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6g5BNQpO5mLjLQAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 31 Jul 2022 09:40:26 +0000
Date:   Sun, 31 Jul 2022 11:40:18 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fixes for 5.19
Message-ID: <YuZOAlAdsg9i1YLt@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull some last-minute EDAC fixes for 5.19.

Thx.

---

The following changes since commit ff6992735ade75aae3e35d16b17da1008d753d28:

  Linux 5.19-rc7 (2022-07-17 13:30:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.19

for you to fetch changes up to 5e2805d5379619c4a2e3ae4994e73b36439f4bad:

  EDAC/ghes: Set the DIMM label unconditionally (2022-07-27 10:42:52 +0200)

----------------------------------------------------------------
- Relax the condition under which the DIMM label in ghes_edac is set in
order to accomodate an HPE BIOS which sets only the device but not the
bank

- Two forgotten fixes to synopsys_edac when handling error interrupts

----------------------------------------------------------------
Sherry Sun (2):
      EDAC/synopsys: Use the correct register to disable the error interrupt on v3 hw
      EDAC/synopsys: Re-enable the error interrupts on v3 hw

Toshi Kani (1):
      EDAC/ghes: Set the DIMM label unconditionally

 drivers/edac/ghes_edac.c     | 11 ++++++++---
 drivers/edac/synopsys_edac.c | 44 +++++++++++++++++++++++++-------------------
 2 files changed, 33 insertions(+), 22 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)

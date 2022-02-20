Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D1C4BCE43
	for <lists+linux-edac@lfdr.de>; Sun, 20 Feb 2022 12:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiBTLui (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 20 Feb 2022 06:50:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiBTLuf (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 20 Feb 2022 06:50:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047FC4B87C;
        Sun, 20 Feb 2022 03:50:14 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3A0C421991;
        Sun, 20 Feb 2022 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645357813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/im0JN/3aSOtHyIEyKZQNZI+WTUe+HXYcr39tkRxEuA=;
        b=Yz22vOy5MOK2W9S4Ke7hKUGtQTCu/Ef7Jeec4+jUj7wxhwoi/LIrI4meQvHI4RnJTwwxNF
        P1N1Zq5ny+qSQp5uYdD9PesARoj5jDI9mo+14ltGKOdZJ9g2UkK/HLtoNoqIicsq1bnXox
        tRWOxkAoHxSZPko04rqc/l99+zx1Kdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645357813;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/im0JN/3aSOtHyIEyKZQNZI+WTUe+HXYcr39tkRxEuA=;
        b=p8T+v/ingDVNtGfAfzemg94ORYPlmALoNfKZ/nljPX0n0pm5DllWlKr63vRjXkCE44OccB
        5VgfJo4ekIs+vyAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2550D12FC5;
        Sun, 20 Feb 2022 11:50:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NPb+CPUqEmLTHgAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Feb 2022 11:50:13 +0000
Date:   Sun, 20 Feb 2022 12:50:15 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC fix for 5.17
Message-ID: <YhIq94B0MpYGrEm2@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull a fix for a long-standing, hard-to-catch issue in the EDAC
weird struct allocation code, for 5.17.

Thx.

---

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.17_rc5

for you to fetch changes up to f8efca92ae509c25e0a4bd5d0a86decea4f0c41e:

  EDAC: Fix calculation of returned address and next offset in edac_align_ptr() (2022-02-15 15:54:46 +0100)

----------------------------------------------------------------
- Fix a long-standing struct alignment bug in the EDAC struct allocation code

----------------------------------------------------------------
Eliav Farber (1):
      EDAC: Fix calculation of returned address and next offset in edac_align_ptr()

 drivers/edac/edac_mc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg

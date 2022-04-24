Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB4D50D0E9
	for <lists+linux-edac@lfdr.de>; Sun, 24 Apr 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiDXJu6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 24 Apr 2022 05:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238919AbiDXJuw (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 24 Apr 2022 05:50:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506344A2D;
        Sun, 24 Apr 2022 02:47:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 02D151F37C;
        Sun, 24 Apr 2022 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1650793669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nqSoL9Pk0zdOClICjXuOMtQ1MOqmdK1KptVJPWeMYMc=;
        b=0dlJkFC2fil9ZwQVFdwHoezOXxyrUZeHkKTTOuI3VFsCPMoFyxTYUtU52RIEMc87R+3QVJ
        3tzpaaTnxC6HRK8WLehSFE7RYvaLnOY3MQWp+P4r3e3TasRF26ulT+G7Ghti5sdy0iLj7B
        05m81qkHJyDOnLfeiIq704vR2bpIwrU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1650793669;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nqSoL9Pk0zdOClICjXuOMtQ1MOqmdK1KptVJPWeMYMc=;
        b=X60gPvvFsUL6AYTgmdoCTXDSnWaprfeART8oddsBq0LGW+hGwg+05xr4RdQP6LsAYdqRZp
        f8J7L3L5vMWhLQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E499213780;
        Sun, 24 Apr 2022 09:47:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cY5XN8QcZWLkJAAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 24 Apr 2022 09:47:48 +0000
Date:   Sun, 24 Apr 2022 11:47:44 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for 5.18
Message-ID: <YmUcwHD0QLywciqo@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull a single urgent fix for the synopsys EDAC driver.

Thx.

---

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v5.18_rc4

for you to fetch changes up to e2932d1f6f055b2af2114c7e64a26dc1b5593d0c:

  EDAC/synopsys: Read the error count from the correct register (2022-04-14 14:44:49 +0200)

----------------------------------------------------------------
- Read the reported error count from the proper register on synopsys_edac

----------------------------------------------------------------
Shubhrajyoti Datta (1):
      EDAC/synopsys: Read the error count from the correct register

 drivers/edac/synopsys_edac.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg

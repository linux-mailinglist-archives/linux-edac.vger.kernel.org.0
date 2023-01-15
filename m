Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5437A66B0AE
	for <lists+linux-edac@lfdr.de>; Sun, 15 Jan 2023 12:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjAOLfo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 15 Jan 2023 06:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjAOLfm (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 15 Jan 2023 06:35:42 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9962FF777;
        Sun, 15 Jan 2023 03:35:40 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB38C1EC04DA;
        Sun, 15 Jan 2023 12:35:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1673782538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=r7Z4sZZrZgvcOmaLX+z/jIVuq5xc+bsmOVIj8nr9DDs=;
        b=jVKt/qtDVKoJrmzNod80yaHgorlXI9xCF3szJb0Eum2k+HySagAnANQm2b3YOs9iQQyxS7
        DERZb+njcGI6t2ACdkFibhPbqhubwaljyUJNqiCfZILUQtSw/U7URKmUmAmUzqUJrXn+xk
        JmTVXkAZfz+CJ294+yRKCtSAKfRrP8g=
Date:   Sun, 15 Jan 2023 12:35:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.2-rc4
Message-ID: <Y8PlBfg2sdjP1OIb@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull two urgent EDAC fixes for 6.2.

Thx.

---

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.2_rc4

for you to fetch changes up to e7a293658c20a7945014570e1921bf7d25d68a36:

  EDAC/highbank: Fix memory leak in highbank_mc_probe() (2023-01-03 17:03:57 +0100)

----------------------------------------------------------------
- Fix the EDAC device's confusion in the polling setting units

- Fix a memory leak in highbank's probing function

----------------------------------------------------------------
Eliav Farber (1):
      EDAC/device: Fix period calculation in edac_device_reset_delay_period()

Miaoqian Lin (1):
      EDAC/highbank: Fix memory leak in highbank_mc_probe()

 drivers/edac/edac_device.c      | 17 ++++++++---------
 drivers/edac/edac_module.h      |  2 +-
 drivers/edac/highbank_mc_edac.c |  7 +++++--
 3 files changed, 14 insertions(+), 12 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

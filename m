Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29BD4676CA5
	for <lists+linux-edac@lfdr.de>; Sun, 22 Jan 2023 13:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjAVMFu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sun, 22 Jan 2023 07:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAVMFt (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sun, 22 Jan 2023 07:05:49 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29E12F1F;
        Sun, 22 Jan 2023 04:05:48 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7F72D1EC0441;
        Sun, 22 Jan 2023 13:05:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1674389147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=3GT10OL/sEundoEeBArodMMEai6Glq2twrTtoNCp6fA=;
        b=sTC86FD6hSv6LtqCZbh6JSA01C8L/vZL4b/cSsidsQet87U2dC+HOMtHrVVx8+JC4HMEoP
        zAHMmYJ3Ci2HRjtZQTGVPmecYYxzkBoi28tvJPsPqtvhlTCd1jDedayT1ppHAzQM4ngUcP
        lFwD6bVkp2zx0V38QZArbSVk3Nfsct4=
Date:   Sun, 22 Jan 2023 13:05:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent for v6.2-rc6
Message-ID: <Y80mm14dxcMzxrLW@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

pls pull two urgent EDAC fixes for 6.2.

Thx.

---

The following changes since commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4:

  Linux 6.2-rc4 (2023-01-15 09:22:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.2_rc6

for you to fetch changes up to 977c6ba624f24ae20cf0faee871257a39348d4a9:

  EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's pvt_info (2023-01-20 19:47:34 +0100)

----------------------------------------------------------------
- Respect user-supplied polling value in the EDAC device code

- Fix a use-after-free issue in qcom_edac

----------------------------------------------------------------
Manivannan Sadhasivam (2):
      EDAC/device: Respect any driver-supplied workqueue polling value
      EDAC/qcom: Do not pass llcc_driv_data as edac_device_ctl_info's pvt_info

 drivers/edac/edac_device.c | 15 +++++++--------
 drivers/edac/qcom_edac.c   |  5 ++---
 2 files changed, 9 insertions(+), 11 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

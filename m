Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A34364A3C0
	for <lists+linux-edac@lfdr.de>; Mon, 12 Dec 2022 15:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbiLLOwc (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 12 Dec 2022 09:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiLLOwb (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 12 Dec 2022 09:52:31 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BD313D04;
        Mon, 12 Dec 2022 06:52:29 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88DF61EC064D;
        Mon, 12 Dec 2022 15:52:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1670856748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=zfXUdHJ29N/jAo1dQw/z1PUYABKq+SOS5oOUr53H5HI=;
        b=mq9iEIObycZ9wU1KnjMMx6wmlqBaCWyP6v4pzDqgPqGYNATbDf9pdQNREMLoIKIjoybCjo
        3IOHw156imHFmZQEgU7+ZLDtSKYFye43Cj6HOOE25KVcBbe0yXNyGHgAVmAWC9fyySTRGO
        VBVWzlnRQpOT3Vh9cCdQd1wG2nJjRbI=
Date:   Mon, 12 Dec 2022 15:52:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.2
Message-ID: <Y5dAJyR9meVleZTm@zn.tnic>
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

please pull the pile of EDAC updates for 6.2.

Thx.

---

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_6.2

for you to fetch changes up to 3919430fe93bcfad5e34cdbb4d81cd17b3bbd27a:

  Merge branches 'edac-ghes' and 'edac-misc' into edac-updates-for-v6.2 (2022-12-12 15:40:03 +0100)

----------------------------------------------------------------
- Make ghes_edac a simple module like the rest of the EDAC drivers and
drop this forced built-in only configuration by disentangling it from
GHES. Work by Jia He.

- The usual small cleanups and improvements all over EDAC land

----------------------------------------------------------------
Ard Biesheuvel (1):
      apei/ghes: Use xchg_release() for updating new cache slot instead of cmpxchg()

Aristeu Rozanski (1):
      EDAC/i5000: Mark as BROKEN

Borislav Petkov (1):
      MAINTAINERS: Make Mauro EDAC reviewer

Borislav Petkov (AMD) (1):
      Merge branches 'edac-ghes' and 'edac-misc' into edac-updates-for-v6.2

Chen Zhang (1):
      EDAC/i5400: Fix typo in comment: vaious -> various

Jia He (6):
      efi/cper: Export several helpers for ghes_edac to use
      EDAC/ghes: Add a notifier for reporting memory errors
      EDAC/ghes: Prepare to make ghes_edac a proper module
      EDAC/ghes: Make ghes_edac a proper module
      EDAC: Check for GHES preference in the chipset-specific EDAC drivers
      EDAC/igen6: Return the correct error type when not the MC owner

Manivannan Sadhasivam (1):
      MAINTAINERS: Make Manivannan Sadhasivam the maintainer of qcom_edac

Yang Yingliang (1):
      EDAC/i10nm: fix refcount leak in pci_get_dev_wrapper()

Yazen Ghannam (1):
      EDAC/mc_sysfs: Increase legacy channel support to 12

 MAINTAINERS                    |   5 +-
 drivers/acpi/apei/ghes.c       | 126 +++++++++++++++++++++++++++++++----------
 drivers/edac/Kconfig           |   5 +-
 drivers/edac/amd64_edac.c      |   3 +
 drivers/edac/armada_xp_edac.c  |   3 +
 drivers/edac/edac_mc_sysfs.c   |  24 ++++++++
 drivers/edac/edac_module.h     |   1 +
 drivers/edac/ghes_edac.c       |  90 +++++++++++++++++------------
 drivers/edac/i10nm_base.c      |   6 +-
 drivers/edac/i5400_edac.c      |   3 +-
 drivers/edac/igen6_edac.c      |   5 +-
 drivers/edac/layerscape_edac.c |   3 +
 drivers/edac/pnd2_edac.c       |   3 +
 drivers/edac/sb_edac.c         |   3 +
 drivers/edac/skx_base.c        |   3 +
 drivers/edac/thunderx_edac.c   |   3 +
 drivers/edac/xgene_edac.c      |   3 +
 drivers/firmware/efi/cper.c    |   3 +
 include/acpi/ghes.h            |  34 +++--------
 19 files changed, 227 insertions(+), 99 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

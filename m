Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A8A6EC70F
	for <lists+linux-edac@lfdr.de>; Mon, 24 Apr 2023 09:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDXH2s (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Apr 2023 03:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDXH2r (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Apr 2023 03:28:47 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99EDE53;
        Mon, 24 Apr 2023 00:28:45 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C358F1EC0523;
        Mon, 24 Apr 2023 09:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1682321321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=bR93/6gZn9N+r1aZIz3dS9pvjK+zPuw9BOIOYUlC96g=;
        b=DndZiKJ/e26uLbCm1GlS9mnjxlohKETqUz9I3tkCaXwXAoWSDEs2q5uEayePAlmTAmiffc
        01UzspziUJ+Qc1K52TrUWRve+VVct8nm2c0QVd3nuGa66Ow+HV/MYZuHIMe4+Z+da2nXFR
        PwnBcrJP4LFKzYS4iUNVxpWHV7iWvig=
Date:   Mon, 24 Apr 2023 09:28:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.4
Message-ID: <20230424072836.GAZEYvpDGrV3bXx690@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the latest lineup of EDAC changes for v6.4.

For some stupid reason (juggling gazillion things at the same time,
probably) I have based the edac-amd64 branch *not* ontop of plain
v6.3-rc3 but there are a couple more of your merges ontop.

I.e., the actual base is v6.3-rc3-12-g17214b70a159, as it says below.

The branch is otherwise fine, those merges are unrelated, it has
passed testing and has been in linux-next for almost a month now.

I didn't want to rebase to have a clean base because that would've
altered commit IDs and that's a no-no.

So pls lemme know if there's something I need to do or whether that
looks ok this way.

Thanks and sorry.

---
The following changes since commit 17214b70a159c6547df9ae204a6275d983146f6b:

  Merge tag 'fsverity-for-linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux (2023-03-20 15:20:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.4

for you to fetch changes up to ce8ac91130b96f651cf6b5245668dfa4969c9c42:

  Merge branches 'edac-drivers', 'edac-amd64' and 'edac-misc' into edac-updates (2023-04-24 09:14:30 +0200)

----------------------------------------------------------------
- skx_edac: Fix overflow when decoding 32G DIMM ranks

- i10nm_edac: Add Sierra Forest support

- amd64_edac: Split driver code between legacy and SMCA systems. The
  final goal is adding support for more hw, like GPUs

- The usual minor cleanups and fixes

----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      EDAC: Sanitize MODULE_AUTHOR strings
      Merge branches 'edac-drivers', 'edac-amd64' and 'edac-misc' into edac-updates

Deepak R Varma (1):
      EDAC/altera: Remove redundant error logging

Jonathan Neuschäfer (1):
      EDAC/amd81[13]1: Remove trailing newline from MODULE_AUTHOR

Jongwoo Han (1):
      EDAC/i5100: Fix typo in comment

Muralidhara M K (11):
      EDAC/amd64: Merge struct amd64_family_type into struct amd64_pvt
      EDAC/amd64: Split prep_chip_selects() into dct/umc functions
      EDAC/amd64: Split read_base_mask() into dct/umc functions
      EDAC/amd64: Split determine_memory_type() into dct/umc functions
      EDAC/amd64: Split read_mc_regs() into dct/umc functions
      EDAC/amd64: Split ecc_enabled() into dct/umc functions
      EDAC/amd64: Split setup_mci_misc_attrs() into dct/umc functions
      EDAC/amd64: Split determine_edac_cap() into dct/umc functions
      EDAC/amd64: Split init_csrows() into dct/umc functions
      EDAC/amd64: Split dump_misc_regs() into dct/umc functions
      EDAC/amd64: Add get_err_info() to pvt->ops

Nick Alcock (1):
      EDAC/altera: Remove MODULE_LICENSE in non-module

Qiuxu Zhuo (2):
      EDAC/skx: Fix overflows on the DRAM row address mapping arrays
      EDAC/i10nm: Add Intel Sierra Forest server support

Yang Li (1):
      EDAC/amd64: Fix indentation in umc_determine_edac_cap()

Yazen Ghannam (6):
      EDAC/amd64: Rename debug_display_dimm_sizes()
      EDAC/amd64: Split get_csrow_nr_pages() into dct/umc functions
      EDAC/amd64: Drop dbam_to_cs() for Family 17h and later
      EDAC/amd64: Do not discover ECC symbol size for Family 17h and later
      EDAC/amd64: Rework hw_info_{get,put}
      EDAC/amd64: Rename f17h_determine_edac_ctl_cap()

 drivers/edac/altera_edac.c     |   10 +-
 drivers/edac/amd64_edac.c      | 1020 ++++++++++++++++++----------------------
 drivers/edac/amd64_edac.h      |   67 +--
 drivers/edac/amd8111_edac.c    |    2 +-
 drivers/edac/amd8131_edac.c    |    2 +-
 drivers/edac/e752x_edac.c      |    2 +-
 drivers/edac/e7xxx_edac.c      |    3 +-
 drivers/edac/i10nm_base.c      |    1 +
 drivers/edac/i5000_edac.c      |    7 +-
 drivers/edac/i5100_edac.c      |    5 +-
 drivers/edac/i82860_edac.c     |    3 +-
 drivers/edac/layerscape_edac.c |    3 +-
 drivers/edac/mpc85xx_edac.c    |    3 +-
 drivers/edac/r82600_edac.c     |    3 +-
 drivers/edac/skx_base.c        |    4 +-
 15 files changed, 490 insertions(+), 645 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

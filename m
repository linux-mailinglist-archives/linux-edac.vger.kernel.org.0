Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAE530CDB
	for <lists+linux-edac@lfdr.de>; Mon, 23 May 2022 12:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiEWJN0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 23 May 2022 05:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiEWJNZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 23 May 2022 05:13:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457A646B22;
        Mon, 23 May 2022 02:13:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F3E9C1F383;
        Mon, 23 May 2022 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653297203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Y2Ex2p3xYeIQtWgsuVl2u04XTMMjyKG5O//mXwBVns=;
        b=YWPX8eetsAikeLM0ncOHJ0+FdZSZUZf2v9Sv7nfATaoGWRjt2VjvcGGBlp9BGZsynta90g
        CCQiWSHnZBtMj0zvcy0JPcclzgSscJxRYIo4wQgEwY7HcNqNEREmEOu4lerZ7hXqhFkI4+
        F/RX5zPpyQHQzoyxAz3J53DMX3vk6Gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653297203;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0Y2Ex2p3xYeIQtWgsuVl2u04XTMMjyKG5O//mXwBVns=;
        b=9NoetH1vlQTaU/vRR5XqAWK/tcHPrYXhPRcY12zzJNy51B7vFaJTisS3dFRHGmR6vxMdDX
        ap5InnH7DH+1XhCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6FB1139F5;
        Mon, 23 May 2022 09:13:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vtlQODJQi2IlWwAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 09:13:22 +0000
Date:   Mon, 23 May 2022 11:13:18 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 5.19
Message-ID: <YotQLlwVatMzp6Ow@zn.tnic>
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

please pull a bunch of EDAC updates for 5.19.

Thx.

---

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v5.19_rc1

for you to fetch changes up to be80a1ca5119c5d31b6019d5e6dc6d9123bda959:

  Merge branches 'edac-misc' and 'edac-alloc-cleanup' into edac-updates-for-v5.19 (2022-05-23 10:19:30 +0200)

----------------------------------------------------------------
- Switch ghes_edac to use the CPER error reporting routines and simplify
the code considerably this way

- Rip out the silly edac_align_ptr() contraption which was computing the
size of the private structures of each driver and thus allowing for a
one-shot memory allocation. This was clearly unnecessary and confusing
so switch to simple and boring kmalloc* calls.

- Last but not least, the usual garden variety of fixes, cleanups and
improvements all over EDAC land

----------------------------------------------------------------
Borislav Petkov (7):
      EDAC/mc: Get rid of silly one-shot struct allocation in edac_mc_alloc()
      EDAC/pci: Get rid of the silly one-shot memory allocation in edac_pci_alloc_ctl_info()
      EDAC/device: Get rid of the silly one-shot memory allocation in edac_device_alloc_ctl_info()
      EDAC/device: Sanitize edac_device_alloc_ctl_info() definition
      EDAC/mc: Get rid of edac_align_ptr()
      EDAC: Use kcalloc()
      Merge branches 'edac-misc' and 'edac-alloc-cleanup' into edac-updates-for-v5.19

Christophe Leroy (1):
      powerpc/85xx: Remove fsl,85... bindings

Julia Lawall (1):
      EDAC/xgene: Fix typo processsors -> processors

Lv Ruyi (1):
      EDAC/armada_xp: Use devm_platform_ioremap_resource()

Sherry Sun (1):
      EDAC/synopsys: Add driver support for i.MX platforms

Shuai Xue (3):
      efi/cper: Add a cper_mem_err_status_str() to decode error description
      EDAC/ghes: Unify CPER memory error location reporting
      efi/cper: Reformat CPER memory error location to more readable

Shubhrajyoti Datta (1):
      EDAC/synopsys: Add a SPDX identifier

Tom Rix (1):
      EDAC/ghes: Change ghes_hw from global to static

Tyler Hicks (1):
      EDAC/dmc520: Don't print an error for each unconfigured interrupt line

YueHaibing (1):
      EDAC/i5100: Remove unused inline function i5100_nrecmema_dm_buf_id()

 .../bindings/memory-controllers/fsl/fsl,ddr.yaml   |   6 -
 .../devicetree/bindings/powerpc/fsl/l2cache.txt    |   6 -
 drivers/edac/Kconfig                               |   3 +-
 drivers/edac/armada_xp_edac.c                      |  18 +-
 drivers/edac/dmc520_edac.c                         |   2 +-
 drivers/edac/edac_device.c                         | 130 +++++--------
 drivers/edac/edac_device.h                         |  14 ++
 drivers/edac/edac_device_sysfs.c                   |   5 +-
 drivers/edac/edac_mc.c                             |  96 ++--------
 drivers/edac/edac_module.h                         |   2 -
 drivers/edac/edac_pci.c                            |  25 ++-
 drivers/edac/ghes_edac.c                           | 202 ++++-----------------
 drivers/edac/i5100_edac.c                          |   5 -
 drivers/edac/mpc85xx_edac.c                        |  14 --
 drivers/edac/synopsys_edac.c                       |  15 +-
 drivers/edac/xgene_edac.c                          |   2 +-
 drivers/firmware/efi/cper.c                        |  64 +++++--
 include/linux/cper.h                               |   3 +
 18 files changed, 184 insertions(+), 428 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)

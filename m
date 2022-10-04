Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE415F3DF6
	for <lists+linux-edac@lfdr.de>; Tue,  4 Oct 2022 10:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiJDIMy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 4 Oct 2022 04:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiJDIL7 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 4 Oct 2022 04:11:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D580710FCA;
        Tue,  4 Oct 2022 01:11:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 28AA71F8EF;
        Tue,  4 Oct 2022 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1664871097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S2SV4sBQ+XUgfItYvZCJqyJXYJEs+CPrHSsEm73LHoU=;
        b=eBtsR6fSKBXa1VAYDBSRZU3G2zMoNM5DXHOQk6gPuqqhMVQ9ZCuM+r6I2NyslvOO80GtwZ
        nIn/ff/JRI5eB8sr1pLXEgiZV2xc2xt9Z0c7CZZ1DzxzpRvPpxJ5I0Cn1Ri5+5w8WQcDWG
        rllWVd2XmhdH2xF/NW3OOLiQJlnVc9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1664871097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=S2SV4sBQ+XUgfItYvZCJqyJXYJEs+CPrHSsEm73LHoU=;
        b=Se9ABfbv+TJViWJBbE2SytqZJgM6Bsgd6F3B1bIDZTjcbHHTPzt1Q2KpdKtDEJMhRyqivv
        Dpkb0MykqEIjWuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D684139EF;
        Tue,  4 Oct 2022 08:11:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id D58nB7nqO2OtSAAAMHmgww
        (envelope-from <bp@suse.de>); Tue, 04 Oct 2022 08:11:37 +0000
Date:   Tue, 4 Oct 2022 10:11:32 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.1
Message-ID: <YzvqtD2dVN9YPI1K@zn.tnic>
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

please pull the accumulated EDAC pile for 6.1.

Thx.

---

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.1

for you to fetch changes up to c257795609e9c9f063c92a6c7ea2e798417700c4:

  Merge branches 'edac-drivers' and 'edac-misc' into edac-updates-for-v6.1 (2022-10-04 10:00:25 +0200)

----------------------------------------------------------------
- Add support for Skylake-S CPUs to ie31200_edac

- Improve error decoding speed of the Intel drivers by avoiding the ACPI facilities
  but doing decoding in the driver itself

- Other misc improvements to the Intel drivers

- The usual cleanups and fixlets all over EDAC land

----------------------------------------------------------------
Borislav Petkov (1):
      Merge branches 'edac-drivers' and 'edac-misc' into edac-updates-for-v6.1

Colin Ian King (1):
      EDAC/i7300: Correct the i7300_exit() function name in comment

Gaosheng Cui (1):
      EDAC: Remove obsolete declarations in edac_module.h

Josh Hant (1):
      EDAC/ie31200: Add Skylake-S support

Qiuxu Zhuo (5):
      EDAC/skx_common: Use driver decoder first
      EDAC/skx_common: Make output format similar
      EDAC/skx_common: Add ChipSelect ADXL component
      EDAC/i10nm: Retrieve and print retry_rd_err_log registers for HBM
      EDAC/i10nm: Print an extra register set of retry_rd_err_log

Serge Semin (2):
      EDAC/mc: Replace spaces with tabs in memtype flags definition
      EDAC/mc: Drop duplicated dimm->nr_pages debug printout

Uwe Kleine-König (1):
      EDAC/ppc_4xx: Reorder symbols to get rid of a few forward declarations

Youquan Song (2):
      EDAC/i10nm: Add driver decoder for Ice Lake and Tremont CPUs
      x86/sb_edac: Add row column translation for Broadwell

ran jianping (1):
      EDAC/wq: Remove unneeded flush_workqueue()

 arch/x86/include/asm/mce.h  |   1 +
 drivers/edac/edac_mc.c      |   1 -
 drivers/edac/edac_module.h  |   4 -
 drivers/edac/i10nm_base.c   | 287 ++++++++++++++++++++++++++++++++++++++++----
 drivers/edac/i7300_edac.c   |   2 +-
 drivers/edac/ie31200_edac.c |  28 +++--
 drivers/edac/ppc4xx_edac.c  |  23 ++--
 drivers/edac/sb_edac.c      | 148 +++++++++++++++++++++--
 drivers/edac/skx_base.c     |   9 +-
 drivers/edac/skx_common.c   |  26 ++--
 drivers/edac/skx_common.h   |  16 +++
 drivers/edac/wq.c           |   1 -
 include/linux/edac.h        |  30 ++---
 13 files changed, 486 insertions(+), 90 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)

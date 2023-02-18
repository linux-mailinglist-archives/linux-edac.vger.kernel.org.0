Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7372769BA8A
	for <lists+linux-edac@lfdr.de>; Sat, 18 Feb 2023 15:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBRO76 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 18 Feb 2023 09:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBRO76 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 18 Feb 2023 09:59:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7EB17143;
        Sat, 18 Feb 2023 06:59:56 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 926221EC0441;
        Sat, 18 Feb 2023 15:59:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676732394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=2C3jRRp9ayMNM+6Ergo2xeSP37WKJLkL8aS+1RjwZRM=;
        b=OM1wQ4RxJcXgpUGs27g9av768jb4hj0ppqkKdlk8RNXxBx1xG5R/wZMKKfE0R8lWZ5vRvx
        ZK9jNPboFcoKoEG7C4jR16G71iRbgKZDcgKmm+WdMWXoOscGOA6IjmUQX1F1QX0jmhq2h/
        YdadT/tQqtjJUgc94Coe1jaxJiYHMok=
Date:   Sat, 18 Feb 2023 15:59:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 6.3
Message-ID: <Y/Dn5bXwGxiDh8RI@zn.tnic>
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

please pull the pile of EDAC updates for 6.3. I'm sending a bit early
but I know you prefer that.

Thx.

---

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.3

for you to fetch changes up to 28980db94742f9f2fb0f68ea35f2171b38007bae:

  EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized clang false positive (2023-02-14 17:56:14 +0100)

----------------------------------------------------------------
- Add a driver for the RAS functionality on Xilinx's on chip memory
  controller

- Add support for decoding errors from the first and second level memory
  on SKL-based hardware

- Add support for the memory controllers in Intel Granite Rapids and
  Emerald Rapids machines

- First round of amd64_edac driver simplification and removal of
  unneeded functionality

- The usual cleanups and fixes

----------------------------------------------------------------
Manivannan Sadhasivam (1):
      EDAC/qcom: Add platform_device_id table for module autoloading

Qiuxu Zhuo (5):
      EDAC/skx_common: Enable EDAC support for the "near" memory
      EDAC/skx_common: Delete duplicated and unreachable code
      EDAC/i10nm: Add Intel Emerald Rapids server support
      EDAC/i10nm: Make more configurations CPU model specific
      EDAC/i10nm: Add Intel Granite Rapids server support

Sai Krishna Potthuri (1):
      EDAC/zynqmp: Add EDAC support for Xilinx ZynqMP OCM

Shubhrajyoti Datta (1):
      dt-bindings: edac: Add bindings for Xilinx ZynqMP OCM

Yazen Ghannam (6):
      EDAC/amd64: Don't set up EDAC PCI control on Family 17h+
      EDAC/amd64: Remove scrub rate control for Family 17h and later
      EDAC/amd64: Remove PCI Function 6
      EDAC/amd64: Remove PCI Function 0
      EDAC/amd64: Remove early_channel_count()
      EDAC/amd64: Shut up an -Werror,-Wsometimes-uninitialized clang false positive

Youquan Song (1):
      EDAC/i10nm: Add driver decoder for Sapphire Rapids server

 .../memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml   |  45 ++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   8 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/amd64_edac.c                          | 217 +---------
 drivers/edac/amd64_edac.h                          |  24 +-
 drivers/edac/i10nm_base.c                          | 459 ++++++++++++++++----
 drivers/edac/qcom_edac.c                           |   7 +
 drivers/edac/skx_common.c                          |  76 ++--
 drivers/edac/skx_common.h                          |  61 ++-
 drivers/edac/zynqmp_edac.c                         | 467 +++++++++++++++++++++
 11 files changed, 1013 insertions(+), 359 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,zynqmp-ocmc-1.0.yaml
 create mode 100644 drivers/edac/zynqmp_edac.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

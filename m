Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA8E73DE12
	for <lists+linux-edac@lfdr.de>; Mon, 26 Jun 2023 13:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjFZLs5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 26 Jun 2023 07:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFZLs4 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 26 Jun 2023 07:48:56 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E681AA;
        Mon, 26 Jun 2023 04:48:54 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BBA451EC01E0;
        Mon, 26 Jun 2023 13:48:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687780132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=bF/RKkVqs08gMd1k9tLXLy67+puaEetKPnBj+725Lec=;
        b=ahS0juFeZnkvOWE9h4SGm90h1JxIAvlvLG+QSwHiLxIAhFWc6EFk0Rs8QDi6FpHcv3XZsw
        gy5INs1Kr0jpurHf3lZI6G3CUybKFhbuh8dP3IfyOrnrPKTXtobNoXyl71Z/0ZaEcrKtfU
        fYtQhNIhaTWlF5RpbhtJj5fbyIWr2vo=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TuOGT6dOfjzs; Mon, 26 Jun 2023 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687780129; bh=bF/RKkVqs08gMd1k9tLXLy67+puaEetKPnBj+725Lec=;
        h=Date:From:To:Cc:Subject:From;
        b=efL4rvvIHTD76uLuyOCxG9h3+mL31Pr/69/F6NlOXgUeP9NCB+b8eebjRF5O3WWPR
         2s1XMeQoJrISYXaI0J1NYK5vxEzey1uxjtqu0IJPaCJc5VOy0iKSSIzdUPYAeeHfWG
         Um/1rhcs5M786v5IYoBI2upXwiCDsyNy8ot8RjUY4mLhcX3WsnamLyavnwd16wayQK
         qqs6Gs5TY069bVk7ypWV8H2NbKjWpLcxle4m8FDEw+sODzhFY5ZIMiJ+Tlmdsz1Lvr
         DYdQOgZozDllDtWjZ383cEbYLTcwvNxUBA5NkuEgpp7KNiIROrsqlL6D1IF81x5YUF
         NyxDPIfA1cNpuA5UhOmROLFiuvl5xd896e6VlOq3ND22zgkZk/k9TpIcm4kqfRfNrq
         Zevop8GeYLxs/GGuqp3c/cTpun2GPNIOhx3RP9JAM7ouYNjiG2fTaeoyQjIdrfRNkT
         CX9Z9DPyYLv1+G/ryGdglwhDhy8WBJW/FP7giTzkYsxk7kaJf85nze7EsQ4NItBrxG
         7gIaaGf+H29QoEkjqnVWB3pdT0p/l2QYIbxXN0ud/A1Bjp0QXh2DSlUbwVf67xQlTO
         mb+5IXcRBZ/gUU8JjlUM5ukD2mIi9mpW3dHLIEDiuavj4haD/hRHAgMnzTO7lJZKbY
         B4Hi82eQpu4xEqY66LdQxUco=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3AAC40E01E1;
        Mon, 26 Jun 2023 11:48:46 +0000 (UTC)
Date:   Mon, 26 Jun 2023 13:48:42 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 6.5
Message-ID: <20230626114842.GAZJl7GsleaEc2+cU1@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Linus,

please pull the accumulated EDAC updates for 6.5.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.5

for you to fetch changes up to 852667c317ae23f366cfaade3b9269b1943888dd:

  Merge ras/edac-drivers into for-next (2023-06-12 15:15:36 +0200)

----------------------------------------------------------------
- amd64_edac: Add support for Zen4 client hardware

- amd64_edac: Remove the version string as it is useless and actively
  confusing when looking at backported versions of the driver

- Add a driver for the Nuvoton NPCM memory controller

- A debugfs error checking cleanup

----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      Merge ras/edac-misc into for-next
      Merge ras/edac-drivers into for-next

Hristo Venev (1):
      EDAC/amd64: Add support for ECC on family 19h model 60h-7Fh

Marvin Lin (2):
      dt-bindings: memory-controllers: nuvoton: Add NPCM memory controller
      EDAC/npcm: Add NPCM memory controller driver

Yazen Ghannam (1):
      EDAC/amd64: Remove module version string

Yeqi Fu (1):
      EDAC/thunderx: Check debugfs file creation retval properly

 .../nuvoton,npcm-memory-controller.yaml            |  50 ++
 MAINTAINERS                                        |   8 +
 drivers/edac/Kconfig                               |  11 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/amd64_edac.c                          |  12 +-
 drivers/edac/amd64_edac.h                          |   1 -
 drivers/edac/npcm_edac.c                           | 543 +++++++++++++++++++++
 drivers/edac/thunderx_edac.c                       |   2 +-
 8 files changed, 623 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/nuvoton,npcm-memory-controller.yaml
 create mode 100644 drivers/edac/npcm_edac.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

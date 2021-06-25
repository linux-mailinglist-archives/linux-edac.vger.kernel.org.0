Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774803B4213
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 13:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFYLG7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Jun 2021 07:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhFYLGx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Jun 2021 07:06:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315C1C061574;
        Fri, 25 Jun 2021 04:04:31 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id yy20so6723654ejb.6;
        Fri, 25 Jun 2021 04:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=oMTJ/QkeVmFE4EFKrFNWUVeXA/smXrujx1nehRVMF44=;
        b=VUGuKRFUKSkdLoBalHfnYSj33Nqf+3byDGN4+vDZDEwwKqJfJhSZsJjTDn4E9Xpy1W
         uMhjPzRH9sCAtCrTdCZvkfjHGKrMuEaCMQrxl8Rir9Wby9WLUnBfHIFvoN2O0xksNf1w
         MHLrxY1Bkc29o3Q9SfAH/AgSX8WYj2ayfTXdwjYsvJYitattujYNNpo8qoHS3FI2dutR
         mUUbVOrjHwfkGICanaFXTSrhXaBtYnyLnkgsaMSS7oLeaf5l/I/0NGRkgdBmgfBj74YA
         0AV2YGzE1vXVtwpjgkqHvTLS9bzPbiXchPds8BRJToNMI38TIFlJtitPY7F9WNAOaOTH
         YDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oMTJ/QkeVmFE4EFKrFNWUVeXA/smXrujx1nehRVMF44=;
        b=GAdT043pGA0r1JKWvRhtzxTYKbDFG8bc1jfB2ZvcBQCpKU108nDGYMU2BbPT3zY0/m
         KLmT6ylklcVqGMSfND/w75yL+8Du5mAsKKQOSHtbMMM0swyTMZvNbJW5HYLGg1sGE6rj
         5xASCf5Ko1ddaP+LD33Kg0Ru0LxKzzyLji5Duz8cW0BDX6HumFxWFv++AHVjRGyYOJTT
         Kg155LKYlA5kpW7XWcmsaakOjn57gvD/hKwgQOLqKH7qyyMJyzXihQzjZKWLiDGlEfMs
         5EadUkSpwuTcPrcGI2TL6ZtvSD2z4HJi3blvSliNuxXCsLi7xewIx+jtNG5sXBU7HXbg
         xB3A==
X-Gm-Message-State: AOAM5303uPoXhVXCtdoDWJrK6pPUjttw2uzKhDRqamrSmfnaf1rUcgWJ
        IwCHgXCatYEz4Tq7ikEFmKs=
X-Google-Smtp-Source: ABdhPJxmTfE/ss/bnHF0xXzRsXUc2iIkWDwkPT7ifIa4hBcUSM7q7KCO96+UqjufJvNNPPKUY5GwSQ==
X-Received: by 2002:a17:906:dbdc:: with SMTP id yc28mr10245592ejb.444.1624619069705;
        Fri, 25 Jun 2021 04:04:29 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:3852:f400:9496:6480:6c8a:4419])
        by smtp.gmail.com with ESMTPSA id v28sm2659665ejk.84.2021.06.25.04.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:04:29 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 0/3] Remove dead linux-mips.org references
Date:   Fri, 25 Jun 2021 13:04:16 +0200
Message-Id: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear all,

on 2021-02-22, I reported that:

The domain lookup for linux-mips.org fails for quite some time now. Hence,
webpages, the patchwork instance and Ralf Baechle's email there is not
reachable anymore.

In the discussion of that patch series, Kurt Martin promised to get
linux-mips.org back online. Four months have now passed and the webpage is
still not back online. So, I suggest to remove these dead references.
Probably, we do not lose much if the linux-mips.org webpage never comes back.

The domain lookup for linux-mips.org fails for quite some time now. Hence,
webpages, the patchwork instance and Ralf Baechle's email there is not
reachable anymore.

Here is in more detail what I did to create this patch series:

First, I updated all sections in MAINTAINERS for references with linux-mips.org.
Then, I also quickly scanned through the whole git tree for linux-mips.org
references, and step-wise filtered out obvious copyright holder lines and
references to old email addresses.

  git ls-files | xargs grep "linux-mips.org" | \
    grep -v -i "Copyright" | grep -v -i "MODULE_AUTHOR" | grep -v -i "written" | \
    grep -v "Ralf" | grep -v "Maciej" | grep -v "Yoichi" | grep -v "Ladislav"

I removed dead references or replaced them with their living counterparts if
available. However, these two cases remain and somebody might want to have a look:

  1. case in ./arch/mips/include/asm/page.h:

<snip>
/*
 * RELOC_HIDE was originally added by 6007b903dfe5f1d13e0c711ac2894bdd4a61b1ad
 * (lmo) rsp. 8431fd094d625b94d364fe393076ccef88e6ce18 (kernel.org).  The
 * discussion can be found in
 * https://lore.kernel.org/lkml/a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com
 *
 * It is unclear if the misscompilations mentioned in
 * https://lore.kernel.org/lkml/1281303490-390-1-git-send-email-namhyung@gmail.com
 * also affect MIPS so we keep this one until GCC 3.x has been retired
 * before we can apply https://patchwork.linux-mips.org/patch/1541/
 */
</snip>

  Decision: Keep as is. Although GCC 3.x is long retired, it is unclear what
  https://patchwork.linux-mips.org/patch/1541/ is and if it has been already
  applied or not.
  Question: does anyone know how to identify this patch?


  2. case in ./drivers/parport/parport_ip32.c:

    linux-mips.org tree is referred to in an old To do item:

<snip>
 * To do:
 *
 *      Fully implement ECP mode.
 *      EPP and ECP mode need to be tested.  I currently do not own any
 *      peripheral supporting these extended mode, and cannot test them.
 *      If DMA mode works well, decide if support for PIO FIFO modes should be
 *      dropped.
 *      Use the io{read,write} family functions when they become available in
 *      the linux-mips.org tree.  Note: the MIPS specific functions readsb()
 *      and writesb() are to be translated by ioread8_rep() and iowrite8_rep()
 *      respectively.
</snip>

  Decision: Keep as is; anyone that wants to follow up on this will probably
  understand that the reference is outdated anyway.


Please comment on these clean-up patches on this administrative topic.

Patch set applies cleanly on next-20210624.


Changes since v1: https://lore.kernel.org/lkml/20210222161905.1153-1-lukas.bulwahn@gmail.com/
  Patches
    "arch: mips: update references to current linux-mips list"
    "MIPS: SGI-IP27: fix spelling in Copyright"
  has been already applied.

Lukas Bulwahn (3):
  MAINTAINERS: mark sections from Ralf Baechle orphan
  MAINTAINERS: remove linux-mips.org references
  arch: mips: remove dead references

 MAINTAINERS                   | 20 ++++++--------------
 arch/mips/Kconfig             |  8 +-------
 arch/mips/jazz/Kconfig        | 12 +++---------
 tools/include/nolibc/nolibc.h |  3 +--
 4 files changed, 11 insertions(+), 32 deletions(-)

-- 
2.17.1


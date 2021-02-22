Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 473A3321CAB
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 17:20:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbhBVQU3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 11:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbhBVQUZ (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 11:20:25 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B67C061574;
        Mon, 22 Feb 2021 08:19:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id w1so30212044ejf.11;
        Mon, 22 Feb 2021 08:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jrKMxz76VrtujF1xTtdvcqWh/FiUwzdqgqPn8MABZcQ=;
        b=tbCF6H7dNXWERfQSXS6cEb8eXbKZ4q0uTOEsLLhVC/ayjIosiu3ZdXWK3X6QJJpfTO
         oP5eo1+Ja+BAy5CLSQIdpeEA69xPIckoipNbGE8SiK6P9ZpgTlESyb+DsYXapjzbzVi0
         Psi4XvMUK6Zm8WwdD8/jVbGflL/RD3XZh2jY8FlNoDsxsfN/54xgI0mUW9Jm3jS8QJ6O
         DoC//YlzI54ErTJ6HEHWpVCiIJ4k+pDXx4DAdNf2ZMUHfPcGdaDisB6IjQaE3CYT4c29
         9pcqs6IicpJQvVRkY+tI7SsPqNeoXgRHZdsw+ET/Fa2YebRI82TOmwWxTDrXmNNsQLhB
         c0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jrKMxz76VrtujF1xTtdvcqWh/FiUwzdqgqPn8MABZcQ=;
        b=GnMH0O+GHTZhQQbrdaZ9Qwogg/ofAiFbr0R7xFh2wcj2nmUR4DS9TvbHIYhlSeBkXL
         eWNlhLxaXbvmEUpoNFQVdEFInCLwk7X2yvC4GuRtbPb7KuwXnEAgo/6OLbr4BMwO9wz5
         nLiYCYpy8JCmxgLHMYP+d5T454my+BdBe9JLKo6O3daXjDp9+vO2Hq0ZyMaRG5QPfq/X
         Am59DjR9GDXXwFnVW3zip4Nos4mnotm6nJ8Fs9GBwgn9hv83KSCdC9DG316YBDIr4FTr
         M7n96esAJ3IT/I5F4ytIxSYIwYTiBFKOmsK4t+uW6DGbJ/9C+IneciKaMOoPGs2H2Y4W
         k8VQ==
X-Gm-Message-State: AOAM531DfsZrQYGCnQcw49OmrE5n3WbYdVs4PiUjMJABOb+slC7/xpBI
        p20BrNmH0rSMrUlMViC0xFY=
X-Google-Smtp-Source: ABdhPJymsCglaF9UgI/Qnjwt/XNzwiLp23cWL9gxOA1KKbBrbEkowNuvAZGKz41lNo2Ny8QHbHP8RA==
X-Received: by 2002:a17:906:3850:: with SMTP id w16mr22079770ejc.286.1614010781593;
        Mon, 22 Feb 2021 08:19:41 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d6b:2000:6504:2c93:2a67:f7e2])
        by smtp.gmail.com with ESMTPSA id i7sm67876ejf.59.2021.02.22.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:19:40 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/5] Remove dead linux-mips.org references
Date:   Mon, 22 Feb 2021 17:19:00 +0100
Message-Id: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Dear all,

The domain lookup for linux-mips.org fails for quite some time now.
Hence, webpages, the patchwork instance and Ralf Baechle's email there is
not reachable anymore.

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

Patch set applies cleanly on next-20210222.

Thanks,

Lukas


Lukas Bulwahn (5):
  MAINTAINERS: mark sections from Ralf Baechle orphan
  MAINTAINERS: remove linux-mips.org references
  arch: mips: update references to current linux-mips list
  arch: mips: remove dead references
  MIPS: SGI-IP27: fix spelling in Copyright

 MAINTAINERS                     | 20 ++++++--------------
 arch/mips/Kconfig               |  8 +-------
 arch/mips/jazz/Kconfig          | 12 +++---------
 arch/mips/kernel/r4k-bugs64.c   |  2 +-
 arch/mips/lib/iomap-pci.c       |  2 +-
 arch/mips/sgi-ip27/ip27-timer.c |  4 ++--
 arch/mips/sgi-ip32/ip32-irq.c   |  2 +-
 tools/include/nolibc/nolibc.h   |  3 +--
 8 files changed, 16 insertions(+), 37 deletions(-)

-- 
2.17.1


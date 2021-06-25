Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 806CC3B4222
	for <lists+linux-edac@lfdr.de>; Fri, 25 Jun 2021 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFYLHD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 25 Jun 2021 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhFYLHA (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 25 Jun 2021 07:07:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B4C061574;
        Fri, 25 Jun 2021 04:04:39 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id he7so14424978ejc.13;
        Fri, 25 Jun 2021 04:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Cev1/kJRTJEP57IBoDUiQhmbUfhTf5In9xOSIwYWmq0=;
        b=o1IalEDk5B4n7IDiqeW+q/YfcIeXbWaJju5k4IFCaFuoZQMFVHt3BhwVm0aniMz5Uu
         nDpBFr7E9mVJhlLJgLHqC1SRbTovu5f9T4XQBUKOVSUOCtUSpVyqqCmDciBU/d/bhynV
         ZmBcdmAYyg52AQ8wgqjBH8bX/fhEiy+LdTXCWTpI1sYOZ1iP8OmVMnPjOtTdnNK6GZvM
         SP3Osh3zsTRVBALc6Dx94RYZz7IX6mLZNxqawnQNEaUzUuJpOSekNokYa8rKOkToRHZu
         Z+HL6etigqMDeBIx26ByDx3xfLe0m7EbVpkLw8oVYA2R8VSWmzJESvg8SFGtElzjC2HD
         kjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Cev1/kJRTJEP57IBoDUiQhmbUfhTf5In9xOSIwYWmq0=;
        b=t4FBnozGTWrPow7FWv9A+q5grsV7pPVVZOzS4qauSwYjW5pF3L0CytBnAgCtXvNB+H
         CceuzfK/03hBI5CBW0HjpzPCZbKzz6KuwAuEc8NgfFeVPl9oCkU633DCps+phz2X5oMX
         mvnUOHl3rb00lguavwWQFUnqH8ivjVBJ0xJ4jdKPtReMI4osuDOp8i8MG69qmTEsJ+o3
         yF4+irWiJb/760LT6ekU80Sww2C0LsCfeMVtzzbfXKgO1uEzFqTI9we4NHhjpMB+0yAI
         Y/8Yvq0ztOi0DGdKfMDV3QiraOGMSc2kR+vzlagXig9QRP66n2HNZr28hLUY8nPuPifs
         eGDA==
X-Gm-Message-State: AOAM530sTK6vhxQOVcOpT8ObKUm4mwyPwtb5npjQwPW+Q3R/brdKxpTj
        jA4V8UMWsA/ffpM9j8ITWIc=
X-Google-Smtp-Source: ABdhPJxJtc7RXWDHb3170KbvHync51Xd1cBiikKYJJiMRnjrRNNDwDSqV/S1EQM9Ud5bxQOSJp5XcA==
X-Received: by 2002:a17:906:744:: with SMTP id z4mr10351982ejb.347.1624619078111;
        Fri, 25 Jun 2021 04:04:38 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:3852:f400:9496:6480:6c8a:4419])
        by smtp.gmail.com with ESMTPSA id v28sm2659665ejk.84.2021.06.25.04.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 04:04:37 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2 3/3] arch: mips: remove dead references
Date:   Fri, 25 Jun 2021 13:04:19 +0200
Message-Id: <20210625110419.24503-4-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
References: <20210625110419.24503-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

The domain lookup for linux-mips.org fails for quite some time now.
Further, the two links:

  http://decstation.unix-ag.org/
  http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/

refer to old webpages or contain no further technical information.

Remove all those dead references.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/mips/Kconfig             |  8 +-------
 arch/mips/jazz/Kconfig        | 12 +++---------
 tools/include/nolibc/nolibc.h |  3 +--
 3 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index cee6087cd686..1bebf7fa2882 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -379,9 +379,7 @@ config MACH_DECSTATION
 	select SYS_SUPPORTS_1024HZ
 	select MIPS_L1_CACHE_SHIFT_4
 	help
-	  This enables support for DEC's MIPS based workstations.  For details
-	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
-	  DECstation porting pages on <http://decstation.unix-ag.org/>.
+	  This enables support for DEC's MIPS based workstations.
 
 	  If you have one of the following DECstation Models you definitely
 	  want to choose R4xx0 for the CPU Type:
@@ -3246,10 +3244,6 @@ config TC
 	  processors.  TURBOchannel programming specifications are available
 	  at:
 	  <ftp://ftp.hp.com/pub/alphaserver/archive/triadd/>
-	  and:
-	  <http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/>
-	  Linux driver support status is documented at:
-	  <http://www.linux-mips.org/wiki/DECstation>
 
 config MMU
 	bool
diff --git a/arch/mips/jazz/Kconfig b/arch/mips/jazz/Kconfig
index 42932ca98db9..162d11670c75 100644
--- a/arch/mips/jazz/Kconfig
+++ b/arch/mips/jazz/Kconfig
@@ -5,9 +5,7 @@ config ACER_PICA_61
 	select DMA_NONCOHERENT
 	help
 	  This is a machine with a R4400 133/150 MHz CPU. To compile a Linux
-	  kernel that runs on these, say Y here. For details about Linux on
-	  the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
-	  <http://www.linux-mips.org/>.
+	  kernel that runs on these, say Y here.
 
 config MIPS_MAGNUM_4000
 	bool "Support for MIPS Magnum 4000"
@@ -16,9 +14,7 @@ config MIPS_MAGNUM_4000
 	select SYS_SUPPORTS_BIG_ENDIAN
 	help
 	  This is a machine with a R4000 100 MHz CPU. To compile a Linux
-	  kernel that runs on these, say Y here. For details about Linux on
-	  the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
-	  <http://www.linux-mips.org/>.
+	  kernel that runs on these, say Y here.
 
 config OLIVETTI_M700
 	bool "Support for Olivetti M700-10"
@@ -26,6 +22,4 @@ config OLIVETTI_M700
 	select DMA_NONCOHERENT
 	help
 	  This is a machine with a R4000 100 MHz CPU. To compile a Linux
-	  kernel that runs on these, say Y here. For details about Linux on
-	  the MIPS architecture, check out the Linux/MIPS FAQ on the WWW at
-	  <http://www.linux-mips.org/>.
+	  kernel that runs on these, say Y here.
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 8b7a9830dd22..754e64c4a1d1 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1027,8 +1027,7 @@ struct sys_stat_struct {
  *   - arguments are in a0, a1, a2, a3, then the stack. The caller needs to
  *     leave some room in the stack for the callee to save a0..a3 if needed.
  *   - Many registers are clobbered, in fact only a0..a2 and s0..s8 are
- *     preserved. See: https://www.linux-mips.org/wiki/Syscall as well as
- *     scall32-o32.S in the kernel sources.
+ *     preserved. See: scall32-o32.S in the kernel sources.
  *   - the system call is performed by calling "syscall"
  *   - syscall return comes in v0, and register a3 needs to be checked to know
  *     if an error occured, in which case errno is in v0.
-- 
2.17.1


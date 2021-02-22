Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21776321CB7
	for <lists+linux-edac@lfdr.de>; Mon, 22 Feb 2021 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhBVQVL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 22 Feb 2021 11:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhBVQUx (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 22 Feb 2021 11:20:53 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C46C06178B;
        Mon, 22 Feb 2021 08:20:11 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id l12so22784766edt.3;
        Mon, 22 Feb 2021 08:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DgXlL6x8IfhNkYD6R6bR2QbGGSZXQTy+PSFjbRT7U3M=;
        b=gDQivG7bID32e/1IJ8bRg+bwJHKpg9clkyKdifX0+5PuZsqxb70qWUuw3jlzyDoC44
         vIkvdS7ZzTtHQXkWzgoUtEaADChPUTz/gv+dd01M5dCNBsHMCqhg6Av4viSY/dmJa8GH
         iRjYA/OuNgI4Fc0DNQ8lw4vzYgQEUeMGzJLhrjy6fgI3NdVQqsZbmT2p5TLxUI8yCT2X
         gwhswFmVZNRk/3ek8xhVKJtXVO/E/hMuMJfM5181Ouhe7fqAG1zYZZhiPoP3mi5GdO4B
         Hgu4fx66TQpWs6hcELGjYj60uoVJZy65Lb3zpZze03UmpVHW+5ve2olXB4cb3HtjSjEy
         A3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DgXlL6x8IfhNkYD6R6bR2QbGGSZXQTy+PSFjbRT7U3M=;
        b=cR1myXEnmYqB6HQ2OhXRtZbxHTXnQY3VAFk7R0ppJw4ivwSCDAoU7eYRgzmWEEDjRt
         +ynvO9t6LC4KeBzaY3AHInMcMa+Nti0BpaNIh+lyA3GnGZTjToMLjyyk5XfchmHYplSN
         fSorXnaqykOG94Y06MB0aMeahGfbU0zN/3y78DrBypjtxrJTiGkcZP7Kd5dcjpr2Txmv
         m3hUbAsZVclhmIAK9QK6iNka/cHUMc8ceGWdCuIDfUxA0vhF4qat07BZecmx2q7q8PEc
         bB7M0qxLVoozQvO9k1oEJMs/57ZppdubW1mytBzjww+cAJ8qcfI0ie98yQazt94EfGzj
         Mqkw==
X-Gm-Message-State: AOAM530pXejIDRDKh+nxWmnEnHzwaMLRl7z+mLHUf1I0aFY9YWVCtjw+
        WEqeo70BQQf+eGBR/8rdFPTE68Vg/JOQ5g==
X-Google-Smtp-Source: ABdhPJwp1V5UvRma9eJQKFaKCSvKO5Gr4rTBCtSC0Vc0HHzBGLofwgLPa0gZ5gasIv1Q7xjnxT/uDQ==
X-Received: by 2002:aa7:d9cb:: with SMTP id v11mr23101914eds.153.1614010810008;
        Mon, 22 Feb 2021 08:20:10 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d6b:2000:6504:2c93:2a67:f7e2])
        by smtp.gmail.com with ESMTPSA id i7sm67876ejf.59.2021.02.22.08.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:20:09 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        linux-edac@vger.kernel.org, linux-hams@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 4/5] arch: mips: remove dead references
Date:   Mon, 22 Feb 2021 17:19:04 +0100
Message-Id: <20210222161905.1153-5-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
References: <20210222161905.1153-1-lukas.bulwahn@gmail.com>
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
index d89efba3d8a4..8cb1e2be5999 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -375,9 +375,7 @@ config MACH_DECSTATION
 	select SYS_SUPPORTS_1024HZ
 	select MIPS_L1_CACHE_SHIFT_4
 	help
-	  This enables support for DEC's MIPS based workstations.  For details
-	  see the Linux/MIPS FAQ on <http://www.linux-mips.org/> and the
-	  DECstation porting pages on <http://decstation.unix-ag.org/>.
+	  This enables support for DEC's MIPS based workstations.
 
 	  If you have one of the following DECstation Models you definitely
 	  want to choose R4xx0 for the CPU Type:
@@ -3263,10 +3261,6 @@ config TC
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


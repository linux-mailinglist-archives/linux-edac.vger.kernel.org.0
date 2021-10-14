Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD542D141
	for <lists+linux-edac@lfdr.de>; Thu, 14 Oct 2021 05:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhJNDwx (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 13 Oct 2021 23:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhJNDww (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 13 Oct 2021 23:52:52 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC19C061570;
        Wed, 13 Oct 2021 20:50:48 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id d13-20020a17090ad3cd00b0019e746f7bd4so5990695pjw.0;
        Wed, 13 Oct 2021 20:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOQEzHsfDUG5a6fEo5SBK49peF0X2Nq6aI7qLYd8X1s=;
        b=IkEomEpHpKQPEE7loYIYYuvhS3BQiWVzFrNYvh+pSvPDaJAJ+71l0KSJWumzrXOTlA
         tCS0uuS9LBmTIQ+daINNeZSv4EHTDf+T1MHlEwg348Xh2ZqvFNCJyPkoqP5ifa9Ckb4X
         Yom6GMPJhrllAaJJmFejHZ0BMBiYLgzelrAVWPwjIypdk7dZFtFqBnJPuyrLr1QojKwa
         G+V1z1GuwFi4YWIckumlxY2yu5R+I+9MNLaDF8yw1qzZJWfTZRFnXwpjX2ezVBRXHV+v
         TFIHO2Q40oO9Q8/IA5ZIoQBPSEmYbNhcRy/FaCNVjqpXhMjEhs1farxVHl88xEch5viD
         XoGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOQEzHsfDUG5a6fEo5SBK49peF0X2Nq6aI7qLYd8X1s=;
        b=09IDk2RrZHfZhW/I2EhIXoKXryoK0o5psp/bBP4CNrLFxXcIXgkoKk24ZJpw2MbVlf
         sgmkl2SNRSPpIeR3DKt73J7McX73cZY+Mopn9GCIgqnULENz+BkVJVeswGDaYi6jg7Rp
         FF1tXYgQAo44s3TWBPJzPbEB8hxmnLXE9lIwunyQFK8bLDYXDv6AUwt54YcfArFx521o
         TSIY1tdvTPzXZJ2GPd1e1rB5LPoLtWXVOIvhYBzbd0Or4iMQpj2cemz62Kf77KMZV9QY
         62nJLA3EbMWSOiJFbStey6ekTLq58+7uaLHMXIckF2nqbNkcq/iKIS24bM6NqtZjXLvt
         1DyQ==
X-Gm-Message-State: AOAM531UBbmr8fbUhEjqjwDUbB9bc4YvydJ4rEGtJH7rEb5iYaGc8W12
        NkGmba3dymDA+Gm8z3Li121d3T4Fr0M=
X-Google-Smtp-Source: ABdhPJyxVEhew64A7ppizCIn5ZK/rSguIQAcFjepxeY4G/STab9m6701u8Qq0mKCNSipIFrOB+yXGA==
X-Received: by 2002:a17:90b:2349:: with SMTP id ms9mr3725137pjb.45.1634183448246;
        Wed, 13 Oct 2021 20:50:48 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id k17sm903722pfk.16.2021.10.13.20.50.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Oct 2021 20:50:47 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-edac@vger.kernel.org
Subject: [PATCH V3 38/49] x86/debug, mce: Use C entry code
Date:   Thu, 14 Oct 2021 11:50:15 +0800
Message-Id: <20211014035027.17681-3-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211014031413.14471-1-jiangshanlai@gmail.com>
References: <20211014031413.14471-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ETNRY to emit C entry function and use the function
directly in entry_64.S.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        | 10 +---------
 arch/x86/include/asm/idtentry.h  |  1 +
 arch/x86/kernel/cpu/mce/Makefile |  3 +++
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index c9ee58e8e6d1..7c994bcde1b0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -466,16 +466,8 @@ SYM_CODE_START(\asmsym)
 	testb	$3, CS(%rsp)
 	jnz	.Lfrom_usermode_switch_stack_\@
 
-	/* paranoid_entry returns GS information for paranoid_exit in EBX. */
-	call	paranoid_entry
-
-	UNWIND_HINT_REGS
-
 	movq	%rsp, %rdi		/* pt_regs pointer */
-
-	call	\cfunc
-
-	call	paranoid_exit
+	call	ist_\cfunc
 	jmp	restore_regs_and_return_to_kernel
 
 	/* Switch to the regular task stack and use the noist entry point */
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 0f615943a460..d0fd32288442 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -358,6 +358,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW
  */
 #define DEFINE_IDTENTRY_IST(func)					\
+	DEFINE_IDTENTRY_IST_ETNRY(func)					\
 	DEFINE_IDTENTRY_RAW(func)
 
 /**
diff --git a/arch/x86/kernel/cpu/mce/Makefile b/arch/x86/kernel/cpu/mce/Makefile
index 015856abdbb1..555963416ec3 100644
--- a/arch/x86/kernel/cpu/mce/Makefile
+++ b/arch/x86/kernel/cpu/mce/Makefile
@@ -1,4 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
+
+CFLAGS_core.o			+= -fno-stack-protector
+
 obj-y				=  core.o severity.o genpool.o
 
 obj-$(CONFIG_X86_ANCIENT_MCE)	+= winchip.o p5.o
-- 
2.19.1.6.gb485710b


Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1E444C0A3
	for <lists+linux-edac@lfdr.de>; Wed, 10 Nov 2021 13:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhKJMEW (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 10 Nov 2021 07:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbhKJMEU (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Wed, 10 Nov 2021 07:04:20 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869A6C06127A;
        Wed, 10 Nov 2021 04:01:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id np3so1393245pjb.4;
        Wed, 10 Nov 2021 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MG3oDqSdSJ3YhF/Dmz9CSJmHJG/ruxVp0F9FsSXI4ZU=;
        b=ohehGqmS1RVGGEAyVwgIkVfxsc5zvk0W5Qwn6aPxpl22CGhij0gQK3GbFjGIV1ISbR
         tUCGYm4RaUdHkMD+Ik4FuDBkSJLqOynk+DImR5vz2gAvWkb8cNdwAs910UcCo3T3wg6g
         z8B6WktLYMeiEPxS0I7hDdt6KFYHb6fjiIz9TwII7SSMb1iprckATC/Si3ApGaVJR26S
         BfeEYwpbQ2czEqzPVJyiWuACqrJTom//K1nuhNkJF0xC3dlerfUlF0vqOUZtphp/RNmW
         B5DPlBSXMjGr42hK0yFtWJBFXwB0lEjt0857LSJH96Uy1ArySXxvaU6bnbzGz4Tz1ROp
         ci2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MG3oDqSdSJ3YhF/Dmz9CSJmHJG/ruxVp0F9FsSXI4ZU=;
        b=zoTL9+g0wDRjzb/DMumUNE/sISvRWPi8vXhEQBKNB+P0DhClsFj4/v25qqAxsso4Jo
         qZLx1jQ1OBBKtBMwt+Epdh97UyTpL0ZjEXiPAY9txlT2f9hcHwqjQkh/zIPcPD/T6q9m
         vDPt9hD6GFBYdQNh0ZmOYEy4Sy5+sht0ejDB/MkDBZG41oWyqJRCXg1ECSpe3knMWNqJ
         gwDPn9vwGNtaizciONxHuY9k868ohDFe5B3QtlFu1hERdTOMT6LFC7YMKgPVjJBssd3q
         9dneZ2EVRoIBD+6vBUSMTnNLWU8CnXLtu+lvOKB8SP+9s6p5WKWUxbkQyP/f81wbFXZ1
         EDVg==
X-Gm-Message-State: AOAM531zMu8EA2oe6FCUwItUM9jX6/ti8yvv7K1yKqlp9MoBjTr4EBXn
        SFLhF07s/u3zv7g5OT9A5j5GmIDp7yc=
X-Google-Smtp-Source: ABdhPJyjY5vpVZBqikRsldfyn+Fk5fjCAo5Jl8+cgN/cupSDpkWRQmFrQUEm15iHx9rtya/NiWKyVg==
X-Received: by 2002:a17:90b:33d0:: with SMTP id lk16mr16358363pjb.20.1636545692959;
        Wed, 10 Nov 2021 04:01:32 -0800 (PST)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id d7sm23823077pfj.91.2021.11.10.04.01.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 04:01:32 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Juergen Gross <jgross@suse.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-edac@vger.kernel.org
Subject: [PATCH V5 39/50] x86/debug, mce: Use C entry code
Date:   Wed, 10 Nov 2021 19:57:25 +0800
Message-Id: <20211110115736.3776-40-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211110115736.3776-1-jiangshanlai@gmail.com>
References: <20211110115736.3776-1-jiangshanlai@gmail.com>
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
index b6bcf7fcad34..61e89fd5ad8a 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -465,16 +465,8 @@ SYM_CODE_START(\asmsym)
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


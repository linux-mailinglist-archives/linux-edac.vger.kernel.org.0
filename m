Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0AB45EB74
	for <lists+linux-edac@lfdr.de>; Fri, 26 Nov 2021 11:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377277AbhKZK31 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 26 Nov 2021 05:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376947AbhKZK1Z (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 26 Nov 2021 05:27:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BC5C061375;
        Fri, 26 Nov 2021 02:15:56 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u17so6378556plg.9;
        Fri, 26 Nov 2021 02:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v2b5IPHKA6jFRATzjbxNc3v/Tk2B7ZS0kG45l1odXAs=;
        b=HdO/AChZT8Q3d2p8RUelLTEhzvTKtCP14gID/d6Srw+u6SiMwNJmiUhlnQDJnDQibo
         wPPUfDlnvF+KNgJDQeN54Ad3Q+fJpoFv3mpzNiTrXgwJ4p4IEX6aE2aJPj6gL/ZbA22r
         /XobemIGzqIA3T9Qr7cKZ62TaDtmhAoI1X9ccnJURWSezEQyp/dZnihYqKDgw1haRx6V
         5HXAZhCcd7z3xpPvyTXjun0asNQV1p3dhRGVfrlltQEb+DyArXwMtVUBxfq7+R6Ybrxc
         Eg8oIjrIzty9MfqNJIugsi4lBWbVikccpxIDcbTy0y4mH889jGdGCe28p2yI20XDpXLi
         LKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v2b5IPHKA6jFRATzjbxNc3v/Tk2B7ZS0kG45l1odXAs=;
        b=EWr1k/rdDnl0bAAQMf6zHXoyRxEl6YMna8mG7o95Qaj3Etw14KLeypWAdG5FhwaUba
         K1I3h5zu5LG8ig1j5RwwGZM7qyvN8dHjXdQ6jLRtqNoQlWNSrqqpUXEv9UcLvTpyz8CA
         EtUS1a9UqXoY00XVHEdB+5Kjsmt86n9MG6xQDs4rACSQSMCjP/ISFb7lUoteo//DV62N
         isWD+NsqIjXWqUu0jMdiDgCNrEtWEWp7//uZyqnBSnlmVxfiz94/tKksl5FT+uMJSJc7
         VPl97hpLwS2v+mGmusax1ORMhHl/zavlHNpITdFxCAKXImmdyR5HPRguGNMHFytWIISq
         PPGQ==
X-Gm-Message-State: AOAM533lisJgWojv4OWbPb4aI/FvXY6WDawFXTWc8VSNMO+E+dCBHTgD
        hChcNri1rSvcal7nvrGg1jHqcQ1nLBs=
X-Google-Smtp-Source: ABdhPJyvYOYqfz6x5BB8zuhPfAn5EpATGAP+odljyXCrTDhBWJ8299Lt92C4aYysuC/6JtlV0v3niA==
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr14589143pjb.30.1637921756282;
        Fri, 26 Nov 2021 02:15:56 -0800 (PST)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id d2sm6282334pfu.203.2021.11.26.02.15.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Nov 2021 02:15:56 -0800 (PST)
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
        Joerg Roedel <jroedel@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH V6 38/49] x86/debug, mce: Use C entry code
Date:   Fri, 26 Nov 2021 18:11:58 +0800
Message-Id: <20211126101209.8613-39-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211126101209.8613-1-jiangshanlai@gmail.com>
References: <20211126101209.8613-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Use DEFINE_IDTENTRY_IST_ENTRY to emit C entry function in C files and
use the function directly in entry_64.S.

It also removes stack-protector from C files because the C entry code
can NOT use percpu register until GSBASE is properly switched.
And stack-protector depends on the percpu register to work.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S        | 10 +---------
 arch/x86/include/asm/idtentry.h  |  1 +
 arch/x86/kernel/Makefile         |  1 +
 arch/x86/kernel/cpu/mce/Makefile |  3 +++
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index bd5e005316a3..ac05cbf894f5 100644
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
index 7b17ffa43e10..f274e4e2ca17 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -358,6 +358,7 @@ __visible __entry_text void ist_##func(struct pt_regs *regs)		\
  * Maps to DEFINE_IDTENTRY_RAW
  */
 #define DEFINE_IDTENTRY_IST(func)					\
+	DEFINE_IDTENTRY_IST_ENTRY(func)					\
 	DEFINE_IDTENTRY_RAW(func)
 
 /**
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 2ff3e600f426..8ac45801ba8b 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -50,6 +50,7 @@ KCOV_INSTRUMENT		:= n
 
 CFLAGS_head$(BITS).o	+= -fno-stack-protector
 CFLAGS_cc_platform.o	+= -fno-stack-protector
+CFLAGS_traps.o		+= -fno-stack-protector
 
 CFLAGS_irq.o := -I $(srctree)/$(src)/../include/asm/trace
 
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


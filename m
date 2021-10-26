Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3254F43B459
	for <lists+linux-edac@lfdr.de>; Tue, 26 Oct 2021 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbhJZOi5 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 26 Oct 2021 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbhJZOip (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 26 Oct 2021 10:38:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610C5C061243;
        Tue, 26 Oct 2021 07:36:21 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id 187so14490596pfc.10;
        Tue, 26 Oct 2021 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOQEzHsfDUG5a6fEo5SBK49peF0X2Nq6aI7qLYd8X1s=;
        b=hJ5z+zQ5xDBPkJ121XuHys1HR2dUTr0YanjdBm7nC6tc9Qcjtpy6NfqSga8GEAJZpl
         4tfHBCP/9AJwrNfn43S9kP25bQAF2AHwRFV+83F4sxMBo7/5JiF6mIkd4lEiqaZ3XtU+
         n8THa0cL+N+0oKhJK+1/WG9RPJy/RvgJ/L4sAR+mTibgxI2faFIS10XP1duQXZO1hdps
         5K/V8hvoU9uXyuCWHvKoFXq1QASw1A5bwso9MtR90+fusD1rc7UDa0DSAqf3wVzg5j29
         HqC3kQo/9T/X6W/oyjligaHbIEKHNaXQkp4pxpcHG0DVJ7dONO6g0YwQ676qoYjz55aG
         78NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOQEzHsfDUG5a6fEo5SBK49peF0X2Nq6aI7qLYd8X1s=;
        b=y/hb1vorZWUobCeVYsa/9SlswE6ApCYaeCuQr52EmqyAw0muiPETmgsIMJ+6z4kSF1
         sGDuB+Fy/0SJgUjPvQQJsQA57Q/ou2sE5QFHREZuwowlc3MX9AF6RYdR17MXaKlb7Qtg
         kxRD/V+6hp3K9vkjm/Dl9Szkhgx4F2f7DimKueb6uclXL1J8iWEqqbavYMGeG1P9aGdT
         do0cZyOHSBGccvQMcs8D8oWNvKvezJCig2tVXR5IoWHKzzWp3dRa+BAT6QoYQBIi3gCN
         flKE8LGJ9tDs/3goyfMd9JsT7rg0zHrg4lG5GEnadduGZSgeOlNHpRMr2CijNOJRjuQH
         hvyg==
X-Gm-Message-State: AOAM531/gJipQSEfO7ZXPZLHi/Dbht5aFba8DREikpnH9kmGaaCxEyjT
        Obv6foONmHx0RQ7/t+/j0fWIgG3xePc=
X-Google-Smtp-Source: ABdhPJwS8rxj3OTHVCQMv/cMzqxnv3L3NeAmXSLSLD6FUzAvJ41FzowRDVMHxQSX3ai2r9XNzaLJqQ==
X-Received: by 2002:a63:69c4:: with SMTP id e187mr19225335pgc.379.1635258980759;
        Tue, 26 Oct 2021 07:36:20 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id z2sm20577230pfe.119.2021.10.26.07.36.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Oct 2021 07:36:20 -0700 (PDT)
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
Subject: [PATCH V4 39/50] x86/debug, mce: Use C entry code
Date:   Tue, 26 Oct 2021 22:34:25 +0800
Message-Id: <20211026143436.19071-14-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211026141420.17138-1-jiangshanlai@gmail.com>
References: <20211026141420.17138-1-jiangshanlai@gmail.com>
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


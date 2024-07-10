Return-Path: <linux-edac+bounces-1490-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66D492D206
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 14:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A7A1C2178C
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 12:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D381922D6;
	Wed, 10 Jul 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="akhC30il"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189018FDD4
	for <linux-edac@vger.kernel.org>; Wed, 10 Jul 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616098; cv=none; b=hPGO5KdzcsgDdeM8tlqY3JM+bam9Ai+VaH8ZjIvf+hfdWHoidYKbYRdH72knCUiIrv5WzurzsKIx4mnLMp4rzx+vf/u6jjgJlpYG5BEJDqoD0Ffi7EOVZSEpGMeNC5pKt44d6ZIgMr/IPZYMmMnDx44BSve1aYp+k+OQnUsodaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616098; c=relaxed/simple;
	bh=iyhDRd0tdD3nFuZ73bX3M9v+EM3Ik5VJ5bCjwFAAkyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AlYnYBOZYgqk+fMdrp2SDfGDBhyWgXe0luZ93u1ussoLjc+gDbWFU+aSZ4cDWsHwZE4cJyScxKHWtBUyJZiDKGhqNt++GescNPiyxa7AL5Xyx4ccJM+8ej3wvK1nUYYOB5BKBur+cN9CKRJZni9u5D8un8sv87i7lkZgh+Ckszw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=akhC30il; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720616096; x=1752152096;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iyhDRd0tdD3nFuZ73bX3M9v+EM3Ik5VJ5bCjwFAAkyo=;
  b=akhC30ilo1awpEzR8pWSg4cGxb/DH3pyKY4mIC9nuqIoWaX/3Yrxsgdi
   PgHbTAky17W1KKXYTpHMF9ve92jJX76tWRkUoUOXNucd/wr+Uyyp2sT5k
   ghvztRJuwMV7AvcdpL7/0DAhq+tPkqQEOzvM3y2VVGklGlZJufcUWQnLR
   zc7s+sFgzvEYlZvpR/RkwWu8zjzLrGNNND0rowg2D1OL0eC6HU5SHRgXY
   LVCW2HEAiEs3ui/csf7OCetpsWvMZX/4Y9hXDpBArHLEYKnUCqHi1R+IC
   ujyL1aqPDr3lv24IQKAaYXKN9WAJsIm6fNW883mINZdRljsFehizNWfM0
   A==;
X-CSE-ConnectionGUID: aEBRBTbWQce+2ADU5CXTuw==
X-CSE-MsgGUID: JaoH/IJBQbe4kKmZreiAkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28524541"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="28524541"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:54:53 -0700
X-CSE-ConnectionGUID: 01vYcPkIR/uzxG+dtqX1mw==
X-CSE-MsgGUID: wlldvR3CRUuaI1yhitbczA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48933750"
Received: from linuxbkc-devel.jf.intel.com ([10.54.39.76])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2024 05:54:53 -0700
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
Date: Wed, 10 Jul 2024 05:54:43 -0700
Message-ID: <20240710125445.564245-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Uncorrected memory errors for user pages are signaled to processes
using SIGBUS or, if the error happens in a syscall, an error retval
from the syscall.  The SIGBUS is documented in
Documentation/mm/hwpoison.rst#failure-recovery-modes

But there are corner cases where we cannot or don't want to return a
plain error from the syscall.  Subsequent commits covers two such cases:
execve and rseq.  Current code, in both places, will kill the task with a
SIGSEGV on error.  While not explicitly stated, it can be argued that it
should be a SIGBUS, for consistency and for the benefit of the userspace
signal handlers.  Even if the process cannot handle the signal, perhaps
the parent process can.  This was the case in the scenario that
motivated this patch.

In both cases, the architecture's exception handler (MCE handler on x86)
will queue a call to memory_failure.  This doesn't work because the
syscall-specific code sees the -EFAULT and terminates the task before
the queued work runs.

To fix this: 1. let pending work run in the error cases in both places.

And 2. on MCE, ensure memory_failure() is passed MF_ACTION_REQUIRED so
that the SIGBUS is queued.  Normally when the MCE is in a syscall,
a fixup of return IP and a call to kill_me_never() are what we want.
But in this case it's necessary to queue kill_me_maybe() which will set
MF_ACTION_REQUIRED which is checked by memory_failure().

To do this the syscall code will set current->kill_on_efault, a new
task_struct flag.  Check that flag in
arch/x86/kernel/cpu/mce/core.c:do_machine_check()

Note: the flag is not x86 specific even if only x86 handling is being
added here.  The definition could be guarded by #ifdef
CONFIG_MEMORY_FAILURE, but it would then need set/clear utilities.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
---
This is a v2 of
https://lore.kernel.org/linux-mm/20240501015340.3014724-1-andrew.zaborowski@intel.com/
In the v1 the existing flag current->in_execve was being reused instead
of adding a new one.  Kees Cook commented in
https://lore.kernel.org/linux-mm/202405010915.465AF19@keescook/ that
current->in_execve is going away.  Lacking a better idea and seeing
that execve() and rseq() would benefit from using a common mechanism, I
decided to add this new flag.

Perhaps with a better name current->kill_on_efault could replace
brpm->point_of_no_return to offset the pain of having this extra flag.
---
 arch/x86/kernel/cpu/mce/core.c | 18 +++++++++++++++++-
 include/linux/sched.h          |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ad0623b65..13f2ace3d 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1611,7 +1611,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 			if (p)
 				SetPageHWPoison(p);
 		}
-	} else {
+	} else if (!current->kill_on_efault) {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
 		 * which the kernel can recover: ex_has_fault_handler() has
@@ -1628,6 +1628,22 @@ noinstr void do_machine_check(struct pt_regs *regs)
 
 		if (m.kflags & MCE_IN_KERNEL_COPYIN)
 			queue_task_work(&m, msg, kill_me_never);
+	} else {
+		/*
+		 * Even with recovery code extra handling is required when
+		 * we're not returning to userspace after error (e.g. in
+		 * execve() beyond the point of no return) to ensure that
+		 * a SIGBUS is delivered.
+		 */
+		if (m.kflags & MCE_IN_KERNEL_RECOV) {
+			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
+				mce_panic("Failed kernel mode recovery", &m, msg);
+		}
+
+		if (!mce_usable_address(&m))
+			queue_task_work(&m, msg, kill_me_now);
+		else
+			queue_task_work(&m, msg, kill_me_maybe);
 	}
 
 out:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6e..0cde1ba11 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -975,6 +975,8 @@ struct task_struct {
 	/* delay due to memory thrashing */
 	unsigned                        in_thrashing:1;
 #endif
+	/* Kill task on user memory access error */
+	unsigned                        kill_on_efault:1;
 
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
-- 
2.43.0

-----------------------------------------------------------
 Intel Corporation Iberia S.A, Martinez Villergas, 49, Bloque V, Planta 1, Oficina 134, Martinez Villergas Business Park, 28027, Madrid, Spain

Este mensaje se dirige exclusivamente a su destinatario y puede 
contener informacion privilegiada o confidencial. Si no es vd. 
el destinatario indicado, queda notificado de que la lectura, 
utilizacion, divulgacion y,o copia sin autorizacion esta prohibida 
en virtud de la legislacion vigente. Si ha recibido este mensaje por 
error, le rogamos que nos lo communique inmediatamente por 
esta misma via y proceda a su destruccion.

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



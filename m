Return-Path: <linux-edac+bounces-1558-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB7493A32C
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jul 2024 16:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C863281B8E
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jul 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A46155A3C;
	Tue, 23 Jul 2024 14:48:06 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294913B599
	for <linux-edac@vger.kernel.org>; Tue, 23 Jul 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746086; cv=none; b=hJMKvHH3I1BCL9ShBhvmSC45dBEYE/6iwopqIg9UUXw9DsP24zByHXfVi9F9M0j2spy6ARSHIPizWuaSfYULq8kGLjozjueqb9chdMWjvjqKXNlewyi/jTTe8HOVw5AZKJ09kaduSrM7/VGeEw6tIIOyvioj28mWsGdn8jtMMJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746086; c=relaxed/simple;
	bh=v9F//cCHrsWiIACjJE7QfGw5+2aAJpxB/iR37PCf7pE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HwncVvweIqDQ5HOdfzkNe4cp3SzePh9RMCeKyIYrsH5JJUBpihcKbFHsUvQjei3TPAvap9kxPEgSxOaCbCj2Kd5fKagspBGw4BSoaM474kSSjh4okwOiZx79NadFNAzDTSf+jB6BDb+kEtjj35rvPCAcwaWhiBDR9MJiJeen+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52f01b8738dso2349677e87.1
        for <linux-edac@vger.kernel.org>; Tue, 23 Jul 2024 07:48:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746082; x=1722350882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiq/XSgm3wHfgQ0AwWBkVwnpN/AUkG0btoxuVvCcj1g=;
        b=iMbj9BDVJ7aqZZTbbEruO/afu0qzXxcs6atyr+9vjq3vNVQe91zeLNiyZB2Rt2kCv3
         3JDcigETqU7IWj44+Hc9ya/OKx6n2om490uXYzv3riQTnynu8XFcT6OFLLIytWAu0mOI
         CLUEZBQIfkHxN3+GFVu/SUKeY7AUrwPHdW+J8/sceK+4F1eRcRP2rpHrbXe3XvRtnPjK
         fEIftR47lL2T0QlF/lBfWWjHPD+Wb4NCElS6VAOXznWEGiu0ukDjGXAK4A+VRddWnSMH
         eEcCqClikBOj8B+BoLlyfcDvm7FAp/EKAzK+bL695q0HH8qQD6+8ymO0F5LDUrHSZsH7
         fPDw==
X-Gm-Message-State: AOJu0YxpHab88AXehqkcVbVwgu61LlIZF6PKJDOxpQtWI2lwzcuCdhKr
	JI2Z2WgBnHcuQW6/MKdBe/8JtfdWEbUHY8khvPdmWofVPBUwpGhs8LtxAVbjnfA=
X-Google-Smtp-Source: AGHT+IHCQf5Q3yQ7wuWmrukqnqvyvVU47RfROrNLyLGWiYU8odqK5t3MOgLCXUBBhnWdnvC2PwqZCw==
X-Received: by 2002:a05:6512:132a:b0:52c:825e:3b1c with SMTP id 2adb3069b0e04-52fc404b78fmr2191607e87.26.1721746081489;
        Tue, 23 Jul 2024 07:48:01 -0700 (PDT)
Received: from localhost.localdomain ([2a01:110f:4a11:8500:e7a:15ff:fe95:b9d8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d36f3sm7555071a12.91.2024.07.23.07.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:48:00 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on MCE
Date: Tue, 23 Jul 2024 16:47:50 +0200
Message-ID: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Resending through an SMTP server that won't add the company footer.

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



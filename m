Return-Path: <linux-edac+bounces-987-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD98B8413
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 03:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D048BB22685
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 01:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889EB3D71;
	Wed,  1 May 2024 01:54:25 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF85B53A9
	for <linux-edac@vger.kernel.org>; Wed,  1 May 2024 01:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714528465; cv=none; b=c4HclicxD638mc2ShNw+0tCsYYC5bA71ZWECRMSfpeeURGIH2OjGqGP+pmi93wnGzwaorsXuc8r3OEalbpEnBsl5h3tww8UR8xDjtoAu8fnO+vVccdhXLZBY9SwX+c1MWBwe8yoBH6rUZhT8q8hCRX1ZqHk0uRCG2WTdcab4SJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714528465; c=relaxed/simple;
	bh=C57SS3ZCxGbsth/enpLPQrXsGoafcJbbAhmTHWl3C7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jGeDNpHlLeVKlTpFG8SCkNMwrPnb0OTy7P3m4OuUyMaBdWlNM/MaiBNRkElAyWpxpfeof7mzeedcYiZJaPzZmALmwG0OSdbRpXt7h8glqA6JxCBjHPGH7/I6+VN5Mmw/xBpv+n7wGQl6u6t95ix4UFoYXUJ+GwJhQiXwQTPtJVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so49935195e9.1
        for <linux-edac@vger.kernel.org>; Tue, 30 Apr 2024 18:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714528461; x=1715133261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OLnjoLX8ymDEP1c+yitd+kAvKd73++0UdRqIJdMpHHw=;
        b=Uia+l2jkUPvsPRN+DBBYRpGf8LN1yDg6L90fG1lx9sXnyx+z6Nq6XSca5QVRUvuo9U
         VsARVsctOk5PoOXtIwhsjl99gH4vxVX8tfyf6cAiXpyJ35vg9d6SltPH1SdKsh7FpNt3
         V0vP27/xY2aHm+r9od0wnkrFvTSiCTvA88EgnJgOL5yl7IX0MGEPFmPXd8iUrH0bQXwB
         mSf88uwtsRGeMFrs06v4DXXrf69yehuquUG6vdGW3tpLBR7oF8f08q+MfHg4n7bUX5VT
         hONTClW0CexcX2tfZbT8alMCw5iEOCm84olb04I0GM4Dgue/rSQ1J73A0jiAo3T0Z+Xh
         qW8g==
X-Gm-Message-State: AOJu0Yx8I6+gXnA2kKThnnsupy1D/7lm5VYzNHQ0sbCSX090m+ITurzJ
	8mkILglje+7DJvO0kPXhhuSoiUxlEQSyH1avkmM74QiF5kAugJRS11t37Q==
X-Google-Smtp-Source: AGHT+IEXntGOgZLf7ytglEirZsNd7AK/UAILjedaAeYsBm0eeI1K+1c8k26dbXqqI5GfXbvxthikbQ==
X-Received: by 2002:a05:600c:1e05:b0:418:c1a3:8521 with SMTP id ay5-20020a05600c1e0500b00418c1a38521mr779421wmb.26.1714528461009;
        Tue, 30 Apr 2024 18:54:21 -0700 (PDT)
Received: from localhost.localdomain ([82.213.248.3])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b0041c130520fbsm618399wmo.46.2024.04.30.18.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 18:54:20 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH][RFC] exec: x86: Ensure SIGBUS delivered on MCE
Date: Wed,  1 May 2024 03:53:40 +0200
Message-Id: <20240501015340.3014724-1-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uncorrected memory errors are signaled to processes using SIGBUS or an
error retval from a syscall.  But there's a corner cases in execve where
a SIGSEGV will be delivered.  Specifically this will happen if the binary
loader triggers a memory error reading user pages.  The architecture's
handler (MCE handler on x86) may queue a call to memory_failure but that
won't run until the execve() returns.  The binary loader is called after
bprm->point_of_no_return is set meaning that any error is handled by
bprm_execve() with a SIGSEGV to the process.

To ensure it is terminated with a SIGBUS we 1. let pending work run in
the bprm_execve error case.

And 2. ensure memory_failure() is passed MF_ACTION_REQUIRED so that the
SIGBUS is queued.  Normally when the MCE is in a syscall, a fixup of
return IP and a call to kill_me_never are enough.  But in this case
it's necessary to queue kill_me_maybe() which will set
MF_ACTION_REQUIRED.

Reuse current->in_execve to make the decision.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c | 14 ++++++++++++++
 fs/exec.c                      | 12 +++++++++---
 include/linux/sched.h          |  2 +-
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 84d41be6d06b..11effdff942c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1593,6 +1593,20 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		else
 			queue_task_work(&m, msg, kill_me_maybe);
 
+	} else if (current->in_execve) {
+		/*
+		 * Cannot recover a task in execve() beyond point of no
+		 * return but stop further user memory accesses.
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
 	} else {
 		/*
 		 * Handle an MCE which has happened in kernel space but from
diff --git a/fs/exec.c b/fs/exec.c
index cf1df7f16e55..1bea9c252a11 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -67,6 +67,7 @@
 #include <linux/time_namespace.h>
 #include <linux/user_events.h>
 #include <linux/rseq.h>
+#include <linux/task_work.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1888,10 +1889,15 @@ static int bprm_execve(struct linux_binprm *bprm)
 	 * If past the point of no return ensure the code never
 	 * returns to the userspace process.  Use an existing fatal
 	 * signal if present otherwise terminate the process with
-	 * SIGSEGV.
+	 * SIGSEGV.  Run pending work before that in case it is
+	 * terminating the process with a different signal.
 	 */
-	if (bprm->point_of_no_return && !fatal_signal_pending(current))
-		force_fatal_sig(SIGSEGV);
+	if (bprm->point_of_no_return) {
+		task_work_run();
+
+		if (!fatal_signal_pending(current))
+			force_fatal_sig(SIGSEGV);
+	}
 
 	sched_mm_cid_after_execve(current);
 	current->fs->in_exec = 0;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3c2abbc587b4..8970a191d8fe 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -922,7 +922,7 @@ struct task_struct {
 	unsigned			sched_rt_mutex:1;
 #endif
 
-	/* Bit to tell TOMOYO we're in execve(): */
+	/* Bit to tell TOMOYO and x86 MCE code we're in execve(): */
 	unsigned			in_execve:1;
 	unsigned			in_iowait:1;
 #ifndef TIF_RESTORE_SIGMASK
-- 
2.39.3



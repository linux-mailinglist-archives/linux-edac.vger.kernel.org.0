Return-Path: <linux-edac+bounces-1560-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8758193A32E
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jul 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA77C1C22D21
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jul 2024 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9045115698D;
	Tue, 23 Jul 2024 14:48:08 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7E513B599
	for <linux-edac@vger.kernel.org>; Tue, 23 Jul 2024 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746088; cv=none; b=cqOZs+U9jL0UGB+yi3HrIXTm7Hhsb5f9AIYf6XbuvkxGuV/Glm2505zgsKwBEwweZy2sD2gHrbzdfrbEKKZXqWR4sb/GxmCSOwl3kaplVIkk/g2N4ZDvcdLZy3MjEbuQh8+wVrSrkXzjik2jW6G+VBMNygFenzVVJgp1QcUrUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746088; c=relaxed/simple;
	bh=rvuBcT+S1WYjQTAYZl7/VnTWCfy1hALqleSD1QEJ5pI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMr+u6tkjQiEU1/Snwyd1dPoQZ8LewDOhoca7uC7J7eBthevZTVmVT5QqZgsspxR2L8VbIvzNQqBZ7sW5V9+NH3aQ3qW49m2UZQGo3nZ0t8qw2WS1bb5/0FH4F6WeSn1xl7YVTE5YQE+fnmgb2EHSdrm5GNhaD/Z2O3K53xXjNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so4617530a12.2
        for <linux-edac@vger.kernel.org>; Tue, 23 Jul 2024 07:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746085; x=1722350885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dSTBvmiXsKIJg1nIDwcRbXdVetMzZpCGukJXuNM8Mg=;
        b=NEtRURR9fR+/dpNQq36rHZUaUwrzFvAWFkZwY+f/1re+NlQXcXokjCUSeqFHDc4pts
         Q6yvGiJtfCzWS+pMo4NNCv24/0TuJPXNYAkGjDEkTBGUkgJzFH1F1ZWrFH0vOE/RtUjI
         HPTmutWZmP0BEOMoxQn935oQIKCaaVEKJucLL5Zpi1r2KQGb1Bd1iV4cLTdIQx9s1zOh
         1Osa+9jgdETjwP1/B7iHrWEiHG7xrYBJDg3MEXzP2zL7RVv6PzM6olTMtckTJ0NR7okm
         c3Jm4boVjGhG9vNRSPF6NZHmiJaitKVK/8Sr3SiaQbKiJ+kRvb8JZLP6MXxmOh/JWVe8
         tcKA==
X-Gm-Message-State: AOJu0YzQcldQowxE5aCNNXmn5RRDyBqEBxvKC9NTsWP/T1bma1GMzucY
	sRT87GXe7+Mq3d6Au8BEyfo+wuhIJWVFVGWemogfsY5PsTTKLBqscWsdkzGJp4w=
X-Google-Smtp-Source: AGHT+IFsLZAKyynJoDJ+VTBxNc87Aq7bXNUhQFN3SUw3iTssqlxbS/Hb3ixCOgUjFnM2sQsZonSapg==
X-Received: by 2002:a05:6402:3584:b0:59c:31fd:266b with SMTP id 4fb4d7f45d1cf-5a3f08931a3mr9333027a12.28.1721746084919;
        Tue, 23 Jul 2024 07:48:04 -0700 (PDT)
Received: from localhost.localdomain ([2a01:110f:4a11:8500:e7a:15ff:fe95:b9d8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d36f3sm7555071a12.91.2024.07.23.07.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:48:04 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [RESEND][PATCH 3/3] rseq: Ensure SIGBUS delivered on memory failure
Date: Tue, 23 Jul 2024 16:47:52 +0200
Message-ID: <20240723144752.1478226-3-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
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

Once a user task sets t->rseq in the rseq() syscall, if the kernel
cannot access the memory pointed to by t->rseq->rseq_cs, that initial
rseq() and all future syscalls should return an error so understandably
the code just kills the task.

To ensure that SIGBUS is used set the new t->kill_on_efault flag and
run queued task work on rseq_get_rseq_cs() errors to give memory_failure
the chance to run.

Note: the rseq checks run inside resume_user_mode_work() so whenever
_TIF_NOTIFY_RESUME is set.  They do not run on every syscall exit so
I'm not concerned that these extra flag operations are in a hot path,
except with CONFIG_DEBUG_RSEQ.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
---
 kernel/rseq.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35fe..c5809cd13 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -13,6 +13,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 #include <linux/types.h>
+#include <linux/task_work.h>
 #include <asm/ptrace.h>
 
 #define CREATE_TRACE_POINTS
@@ -320,6 +321,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 	if (unlikely(t->flags & PF_EXITING))
 		return;
 
+	t->kill_on_efault = true;
+
 	/*
 	 * regs is NULL if and only if the caller is in a syscall path.  Skip
 	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
@@ -330,13 +333,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
 		if (unlikely(ret < 0))
 			goto error;
 	}
-	if (unlikely(rseq_update_cpu_node_id(t)))
-		goto error;
-	return;
+	if (likely(!rseq_update_cpu_node_id(t)))
+		goto out;
 
 error:
+	/* Allow task work to override signr */
+	task_work_run();
+
 	sig = ksig ? ksig->sig : 0;
 	force_sigsegv(sig);
+
+out:
+	t->kill_on_efault = false;
 }
 
 #ifdef CONFIG_DEBUG_RSEQ
@@ -353,8 +361,17 @@ void rseq_syscall(struct pt_regs *regs)
 
 	if (!t->rseq)
 		return;
-	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
+
+	t->kill_on_efault = true;
+
+	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs)) {
+		/* Allow task work to override signr */
+		task_work_run();
+
 		force_sig(SIGSEGV);
+	}
+
+	t->kill_on_efault = false;
 }
 
 #endif
-- 
2.43.0



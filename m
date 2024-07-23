Return-Path: <linux-edac+bounces-1559-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0EF93A32D
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jul 2024 16:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000F2281630
	for <lists+linux-edac@lfdr.de>; Tue, 23 Jul 2024 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769FD15698B;
	Tue, 23 Jul 2024 14:48:07 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C197F152DF5
	for <linux-edac@vger.kernel.org>; Tue, 23 Jul 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721746087; cv=none; b=q3YXneKUfsqEJ3aqXfFQs24cTu2Q44YPyENLQrXTViaQ3avQhUmU34Xmo3mn9KNrRjtMldOHGjNDxBFSg6UMUjQu0Bs+KZiCizvgZU0q+lLMRmnck2h43c7IhIkgytE2idg/a978I2iwbQ3NQfxelhjlUcVYYHUKNpzORIjwBQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721746087; c=relaxed/simple;
	bh=AYKn+OMraqctBUuRBW986AW2Ho9auOXsJCU3LHrJoZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bm2iHT4J+V3zLCwUN4Tl8cYlhxYZxg7u8iMad3GnAbaJaCEdb2Jt/Y+bq6QNGfXpvd0k8WH4dRxeUjdwfVXh/90HKnW2MKi0pxchlu872ocQq+aPAoqapy/R+9vpG+N5sxTqJBne/sloYh480e94ORG3T9DIzWYrDJCECrmFsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a3458bf858so4108898a12.1
        for <linux-edac@vger.kernel.org>; Tue, 23 Jul 2024 07:48:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721746084; x=1722350884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uk7q0YZEAexRwDC7TlJ8MY8yGZV+7BAd5qc9ovT0Rfs=;
        b=ojwenE7/GixuX/CKQdoQBvR2qflJ9imvICEyOCS221aAhVlt138nN+zC0LBS1QKl+2
         mHtjtQwd3OsX+l570N5vE9rNASIk2Qf6MyUUIyf6kZ8dtq9zkzAkBd2ZarmS/EKjaUCy
         XlsHWnPfInGJSQ6AkiYYXAyuNA41A08nd/B2KJUyHde5vZfgGXla3dM1X97Q89IM+bKO
         oMLrDNL3A+buJFMMkp5rphVPQS1s/FeHMqSoIBUE6q0yJS0vBLgS9l6LAFdr6DDC/GKc
         hXrUhTo3WWEhHH//NddQ5WlcM/YeR+lWrsaAGbH6kV8X1YiFUyVrsk5QS0Fa8EVx8GGi
         sYLg==
X-Gm-Message-State: AOJu0YwTdIgo1IPttLywq3zG9yervlv5OuOLXCEzH4AEJATnSTn9y6AO
	Z07pVTF4W/0Mnz0hSxp+DFo6Ca1LUl46vVcIH3ObiY5TM4xOfjC/z/jo4vlW0nU=
X-Google-Smtp-Source: AGHT+IFha2h6a6MvQHTcjWMHo++g83oEpo5lFlYgf69Px3ng8ztnl88jC5Ynwb7213r/pEK/4abM0g==
X-Received: by 2002:a50:9b4a:0:b0:5a3:b866:eae0 with SMTP id 4fb4d7f45d1cf-5aaa596d039mr76881a12.32.1721746083530;
        Tue, 23 Jul 2024 07:48:03 -0700 (PDT)
Received: from localhost.localdomain ([2a01:110f:4a11:8500:e7a:15ff:fe95:b9d8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d36f3sm7555071a12.91.2024.07.23.07.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 07:48:02 -0700 (PDT)
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [RESEND][PATCH 2/3] execve: Ensure SIGBUS delivered on memory failure
Date: Tue, 23 Jul 2024 16:47:51 +0200
Message-ID: <20240723144752.1478226-2-andrew.zaborowski@intel.com>
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

In execve() there is a point of no return
(bprm->point_of_no_return) after which the syscall... cannot return.
The binary loading happens after this point so if the loader triggers
a memory error reading user pages, and after control returns to
bprm_execve(), that function reacts by sending a SIGSEGV.

Set the new current->kill_on_efault flag and run pending task work to
ensure that a SIGBUS is queued in memory_failure()

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
---
 fs/exec.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 400731422..26c4efe1a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -68,6 +68,7 @@
 #include <linux/user_events.h>
 #include <linux/rseq.h>
 #include <linux/ksm.h>
+#include <linux/task_work.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1290,6 +1291,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 * Ensure all future errors are fatal.
 	 */
 	bprm->point_of_no_return = true;
+	me->kill_on_efault = true;
 
 	/*
 	 * Make this the only thread in the thread group.
@@ -1896,6 +1898,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 	/* execve succeeded */
 	current->fs->in_exec = 0;
 	current->in_execve = 0;
+	current->kill_on_efault = false;
 	rseq_execve(current);
 	user_events_execve(current);
 	acct_update_integrals(current);
@@ -1907,14 +1910,20 @@ static int bprm_execve(struct linux_binprm *bprm)
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
 	current->in_execve = 0;
+	current->kill_on_efault = false;
 
 	return retval;
 }
-- 
2.43.0



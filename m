Return-Path: <linux-edac+bounces-1488-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D33692D205
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 14:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98987B219BA
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 12:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08611922D0;
	Wed, 10 Jul 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRyYz6E6"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2E51922CC
	for <linux-edac@vger.kernel.org>; Wed, 10 Jul 2024 12:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616095; cv=none; b=n+8p8P3zgNdLQOEUhFSc5lg9m1mBjvJGStzAix+W0jJ8+w7KGqTKtLCpAIO5DT/G+0jzZ+xC2i7YbbYaQXRQ6LV0lSfV+Wr5uO7yxdeyMxKRqjB9FbKhqt/XPkNfADj897aY5BVfvsA+O1pUyBtYrhe0iSv2wH+sM0g0fp6WXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616095; c=relaxed/simple;
	bh=ldvJXcDEveNrv7pYd++eyjYMCnJZJLncc1CzEei4jnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDdf7nXvVPUHwVYdH9N4ekiQChvTaHzleJxVMpJCBfDUFNpkygqxZN4/TAEKGwTjWZ/Oc4ABNHR536HXfBGVrv+hkmPNtOj62qewcQh4ikdtSRUvNUT1u6qKM1FhmqO6ZeOTA75Prdc1jHjA7yjqF4CrsMjX2zj79CcHCiPhsjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRyYz6E6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720616093; x=1752152093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ldvJXcDEveNrv7pYd++eyjYMCnJZJLncc1CzEei4jnE=;
  b=ZRyYz6E6QBFmYZD0x/w+Fjjc1Wy3XrTY/AVcKZuVeVpEf/g76s1p8rsF
   9p/i0CyhYKjMhjGfze2wJrvDp+pbpulPPtav/NCQz5fZOwZk+i+qgRR9S
   iQC4IGCtbjrAhbTO4FEZLcb0jfg8NYL3pIjCD9hY3Ex0/aG9JeMYzVVgn
   3P7KbLfyvHCgcJEGBVaCvr07XSd/Sj5WOSYmwt4EuJ+y+CwHxnV5Vg16W
   FAONzEkNH17Ch1DEMY7jsf2EGrPrp0nldX1kqB+mj/IUmCVznSXrY2Dus
   +2VVgwyReF978TRDOkpCt0T1d0EbuIPfPAqMxGB6/SEGdidQP9BU0fjvd
   Q==;
X-CSE-ConnectionGUID: vJtMcjjLRiWYT3T30RvLeQ==
X-CSE-MsgGUID: bJDlYJ1qSFKh9Rydu/d3gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28524546"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="28524546"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:54:53 -0700
X-CSE-ConnectionGUID: bKN9OE+qQ3SkW/gouq2s7A==
X-CSE-MsgGUID: jCbw6dRQSN6VUnr6BXQ/7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48933753"
Received: from linuxbkc-devel.jf.intel.com ([10.54.39.76])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2024 05:54:53 -0700
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 2/3] execve: Ensure SIGBUS delivered on memory failure
Date: Wed, 10 Jul 2024 05:54:44 -0700
Message-ID: <20240710125445.564245-2-andrew.zaborowski@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240710125445.564245-1-andrew.zaborowski@intel.com>
References: <20240710125445.564245-1-andrew.zaborowski@intel.com>
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



Return-Path: <linux-edac+bounces-1489-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C3692D207
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 14:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6CEB23B93
	for <lists+linux-edac@lfdr.de>; Wed, 10 Jul 2024 12:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EEA1922DC;
	Wed, 10 Jul 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mrHrA1/y"
X-Original-To: linux-edac@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42A91922D6
	for <linux-edac@vger.kernel.org>; Wed, 10 Jul 2024 12:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616097; cv=none; b=BGXrETsCmcSAlOco/za/GREzNNGd4ggiGX3Lry5N52Y/XnKTaKChseJY0ODWG1KilP5LULoFfiMJlQ1e0CGGlKtj2bJ9/38z9YDFq26rbvSt9lfcQoI4PItrs69UYP4RcMvUR/I8hasH9yGcbnuDU0bMXN/mORHaWkge6L3WhiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616097; c=relaxed/simple;
	bh=levo3V0iVDZyYwUB/wYIjOFtlPIr2ObPqDMlD/U7i8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k2zMzijubA3wIqQH9+rbszG47AzrBDZgTXQo32T14Z7anpFLqnWlFrZ+UlvTuv1bTPRASMBES0aj9AsszCb7KVGnhzU1/HzLGFu0RPu9ucQhVAblSO6r7X3nN3kbxE0qQcRzJUDb7hryi9C6dAm7EQkB2P1resL65U2Vy+m8iWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mrHrA1/y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720616096; x=1752152096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=levo3V0iVDZyYwUB/wYIjOFtlPIr2ObPqDMlD/U7i8o=;
  b=mrHrA1/yMROTrQFteZqW/S0aRYrotYr93gEvg19IdDShXa2kk2AE2vBV
   Oct6fDTJQADVhN9itScoUw4gNCD20KH3kpdYYCNkor2lBbnqlmq5UfBdP
   gxLMb17AbMNETja3w/Ywa0UdpMNSzVTOM53RGaYreL45BCA0QrYhNg6ZP
   vKSDNfCCcrRexXwbJK4flnZIDB6xAepja3V7l1RshqfeKCINv8myoclEj
   sTNERw8S9+E/wLQVkn5+BeW7Y3shoXmzqIA5/r0CXSoXrHFkOrrUOG1jA
   Tr2L1kvB+GGnD+8T4ji+4LR0tRmLYgLu5zfokKPu1l58Cje7Oftt1yLiy
   g==;
X-CSE-ConnectionGUID: f10CYsJoQMi4FYVTQ9M72Q==
X-CSE-MsgGUID: SqmOEV9iTd6xUXvvO2h97Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="28524552"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="28524552"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 05:54:53 -0700
X-CSE-ConnectionGUID: kWCQGFtwQIC4X0UZy4pJig==
X-CSE-MsgGUID: YrdzZ66rQNWQSvEkW/hKNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48933756"
Received: from linuxbkc-devel.jf.intel.com ([10.54.39.76])
  by orviesa008.jf.intel.com with ESMTP; 10 Jul 2024 05:54:53 -0700
From: Andrew Zaborowski <andrew.zaborowski@intel.com>
To: linux-edac@vger.kernel.org,
	linux-mm@kvack.org
Cc: Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH 3/3] rseq: Ensure SIGBUS delivered on memory failure
Date: Wed, 10 Jul 2024 05:54:45 -0700
Message-ID: <20240710125445.564245-3-andrew.zaborowski@intel.com>
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



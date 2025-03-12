Return-Path: <linux-edac+bounces-3354-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF67A5DB8F
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 12:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28181177072
	for <lists+linux-edac@lfdr.de>; Wed, 12 Mar 2025 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856222417C8;
	Wed, 12 Mar 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="P1upmFou"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CE1241109;
	Wed, 12 Mar 2025 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778948; cv=none; b=GZ5ZX4J1WtA7iyM5jJWh2wPzOqaCClEtVM4lQpPui3O/gQr7kMtXJ5OvIuvwZUILM7gr3eQHdTyjVwATrdz0Gvx1McceQNCNNkmN2cRDvoJMYe+ilwng1krF38ppMB/Vt/eXBrpl/rsBS/vvdLNsc+FJ699AW9LCveuEkG6itxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778948; c=relaxed/simple;
	bh=Y/+cR4hSH3W8GnEHVfKTpi6KgYPJIsatZB1YI6j8hCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5uMtMrjA0ZtBSUo8ht4PqGOo8ymdqGF8PnRWTjZhm5iY8n1/AXR8kJZKQBgZR8PoyzNJSUttNopm1dpnJm2Ku1AoFkRL0JvFiJIX7hMwpPqdfwRJbXVVWuCzX6sVXEkk3VbLOkQB9l5306wBBon0GpDj8AAbv+t1bTkqKqvAVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=P1upmFou; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741778937; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bbkn64ghX0689OXQU9V6jOFRXnCMdCl48Q1ObBbcJ48=;
	b=P1upmFouRfxdLGsORVIZuJdLlx0UD09zTqyu3WGwJxTHeWFUWMN6/sOP4FQc2azr57PFriXc7C0M1q0frJJHHSK/CXAwvkcH4cPUK9DcqPKxG7SmLGc//CAeJ9APVdmcZ8NBUktjZwEQYDyVZnd6P8x6m8ytVqpcqnWkHoCmDoY=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WRCdv1J_1741778935 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Mar 2025 19:28:55 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: akpm@linux-foundation.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com
Cc: tony.luck@intel.com,
	bp@alien8.de,
	peterz@infradead.org,
	catalin.marinas@arm.com,
	yazen.ghannam@amd.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com,
	xueshuai@linux.alibaba.com
Subject: [PATCH v4 2/3] mm/hwpoison: Do not send SIGBUS to processes with recovered clean pages
Date: Wed, 12 Mar 2025 19:28:51 +0800
Message-ID: <20250312112852.82415-3-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250312112852.82415-1-xueshuai@linux.alibaba.com>
References: <20250312112852.82415-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an uncorrected memory error is consumed there is a race between the
CMCI from the memory controller reporting an uncorrected error with a UCNA
signature, and the core reporting and SRAR signature machine check when the
data is about to be consumed.

- Background: why *UN*corrected errors tied to *C*MCI in Intel platform [1]

Prior to Icelake memory controllers reported patrol scrub events that
detected a previously unseen uncorrected error in memory by signaling a
broadcast machine check with an SRAO (Software Recoverable Action Optional)
signature in the machine check bank. This was overkill because it's not an
urgent problem that no core is on the verge of consuming that bad data.
It's also found that multi SRAO UCE may cause nested MCE interrupts and
finally become an IERR.

Hence, Intel downgrades the machine check bank signature of patrol
scrub from SRAO to UCNA (Uncorrected, No Action required), and signal
changed to #CMCI. Just to add to the confusion, Linux does take an action
(in uc_decode_notifier()) to try to offline the page despite the UC*NA*
signature name.

- Background: why #CMCI and #MCE race when poison is consuming in Intel platform [1]

Having decided that CMCI/UCNA is the best action for patrol scrub errors,
the memory controller uses it for reads too. But the memory controller is
executing asynchronously from the core, and can't tell the difference
between a "real" read and a speculative read. So it will do CMCI/UCNA if an
error is found in any read.

Thus:

1) Core is clever and thinks address A is needed soon, issues a speculative read.
2) Core finds it is going to use address A soon after sending the read request
3) The CMCI from the memory controller is in a race with MCE from the core
   that will soon try to retire the load from address A.

Quite often (because speculation has got better) the CMCI from the memory
controller is delivered before the core is committed to the instruction
reading address A, so the interrupt is taken, and Linux offlines the page
(marking it as poison).

- Why user process is killed for instr case

Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported
"not recovered"") tries to fix noise message "Memory error not recovered"
and skips duplicate SIGBUSs due to the race. But it also introduced a bug
that kill_accessing_process() return -EHWPOISON for instr case, as result,
kill_me_maybe() send a SIGBUS to user process.

If the CMCI wins that race, the page is marked poisoned when
uc_decode_notifier() calls memory_failure(). For dirty pages,
memory_failure() invokes try_to_unmap() with the TTU_HWPOISON flag,
converting the PTE to a hwpoison entry. As a result,
kill_accessing_process():

- call walk_page_range() and return 1 regardless of whether
  try_to_unmap() succeeds or fails,
- call kill_proc() to make sure a SIGBUS is sent
- return -EHWPOISON to indicate that SIGBUS is already sent to the
  process and kill_me_maybe() doesn't have to send it again.

However, for clean pages, the TTU_HWPOISON flag is cleared, leaving the
PTE unchanged and not converted to a hwpoison entry. Conversely, for
clean pages where PTE entries are not marked as hwpoison,
kill_accessing_process() returns -EFAULT, causing kill_me_maybe() to
send a SIGBUS.

Console log looks like this:

    Memory failure: 0x827ca68: corrupted page was clean: dropped without side effects
    Memory failure: 0x827ca68: recovery action for clean LRU page: Recovered
    Memory failure: 0x827ca68: already hardware poisoned
    mce: Memory error not recovered

To fix it, return 0 for "corrupted page was clean", preventing an
unnecessary SIGBUS to user process.

[1] https://lore.kernel.org/lkml/20250217063335.22257-1-xueshuai@linux.alibaba.com/T/#mba94f1305b3009dd340ce4114d3221fe810d1871
Fixes: 046545a661af ("mm/hwpoison: fix error page recovered but reported "not recovered"")
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Acked-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: stable@vger.kernel.org
---
 mm/memory-failure.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 995a15eb67e2..b037952565be 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -881,12 +881,17 @@ static int kill_accessing_process(struct task_struct *p, unsigned long pfn,
 	mmap_read_lock(p->mm);
 	ret = walk_page_range(p->mm, 0, TASK_SIZE, &hwpoison_walk_ops,
 			      (void *)&priv);
+	/*
+	 * ret = 1 when CMCI wins, regardless of whether try_to_unmap()
+	 * succeeds or fails, then kill the process with SIGBUS.
+	 * ret = 0 when poison page is a clean page and it's dropped, no
+	 * SIGBUS is needed.
+	 */
 	if (ret == 1 && priv.tk.addr)
 		kill_proc(&priv.tk, pfn, flags);
-	else
-		ret = 0;
 	mmap_read_unlock(p->mm);
-	return ret > 0 ? -EHWPOISON : -EFAULT;
+
+	return ret > 0 ? -EHWPOISON : 0;
 }
 
 /*
-- 
2.39.3



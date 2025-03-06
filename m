Return-Path: <linux-edac+bounces-3279-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA4BA54054
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 03:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C8C53AA613
	for <lists+linux-edac@lfdr.de>; Thu,  6 Mar 2025 02:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991BB18DB1B;
	Thu,  6 Mar 2025 02:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vhs3PBnB"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D83BE46;
	Thu,  6 Mar 2025 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227047; cv=none; b=Sd0WByk+4HbcGLwa2KMHKP1hgH+mhwORUmdPXeDUzXYNDf2tdQTa2s5RWuNjlVkP89XDeeIfeiZvozQ+EBX1iHPeNjuMy+UPWI3XYypefYXYXT7C9pCIwAiCDT80BMvbmjwrij2/on0+w1GcxXlzf0TgV2cHvLRGLzXqftq/JoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227047; c=relaxed/simple;
	bh=3yMJ8P9wTbkUWAtz9zgLpcAboeOV/BTIf+RBM93fDoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfWJZeTHewBG0HZ/bWPlDrPSQlW0a9KqeJYJ0HWiEx/OhUnbt3YLVda1G1XV5st7B8s3ADF4qxk/Zc3BdPUVSLseEQB+5ggxfXN6TZcEkJsGHFxhtmCv4bfpIMMqFwyu8wUkbw+zRa1NZOywqdXTsR9jvtusnG8UxAscAMXp5fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vhs3PBnB; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741227035; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3+bJhmIkUvoe4RMZEuB10Don5RKd7uFs3amUjETLnyU=;
	b=vhs3PBnBlsBwUju3ahqL6lIbw1gQSgA62FHC8TxXuSEQ3gSdefTtXPOn+j1rRwldsPHelLiSJ98OWWDwdW1Bn8cNU+lSK0z4O6+gtV/OsT747W9gJv05p6M4//Y47CAeXnfeOPa3Pr1utYRBgLD+t+YBaib8Y2/26000NHUYvUg=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQmzy-4_1741227032 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 10:10:33 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: tony.luck@intel.com,
	bp@alien8.de,
	peterz@infradead.org,
	catalin.marinas@arm.com,
	yazen.ghannam@amd.com,
	akpm@linux-foundation.org,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	jpoimboe@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	baolin.wang@linux.alibaba.com,
	tianruidong@linux.alibaba.com
Subject: [PATCH v3 0/3] mm/hwpoison: Fix regressions in memory failure handling
Date: Thu,  6 Mar 2025 10:10:28 +0800
Message-ID: <20250306021031.5538-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

changes since v2:
- drop debug error message for non-fatal case per Borislav's strong objections
- rewrite cover letter by amending MCE and CMCI race background from Tony[1]
- rewrite commit log
- use is_copy_from_user() to determine copy-from-user context per Peter
- keep comments of in kill_me_maybe() per Catalin 
- add ack-by tag for patch 3 from Miaohe Lin
- Link: https://lore.kernel.org/lkml/20250217063335.22257-1-xueshuai@linux.alibaba.com/T/#m4d87f152a67e26f2aabb4cdf81e451a1e4c70094

changes singce v1:
- Patch 1: Fix cur_sev and sev type to `int` per Tony
- Patch 4: Fix return value to 0 for clean pages per Miaohe
- Patch 5: pick return value comments of memory-failure()

## 1. What am I trying to do:

This patch resolves two critical regressions related to memory failure
handling that have appeared in the upstream kernel since version 5.17, as
compared to 5.10 LTS.

    - copyin case: poison found in user page while kernel copying from user space
    - instr case: poison found while instruction fetching in user space

## 2. What is the expected outcome and why

- For copyin case:

Kernel can recover from poison found where kernel is doing get_user() or
copy_from_user() if those places get an error return and the kernel return
-EFAULT to the process instead of crashing. More specifily, MCE handler
checks the fixup handler type to decide whether an in kernel #MC can be
recovered.  When EX_TYPE_UACCESS is found, the PC jumps to recovery code
specified in _ASM_EXTABLE_FAULT() and return a -EFAULT to user space.

- For instr case:

If a poison found while instruction fetching in user space, full recovery is
possible. User process takes #PF, Linux allocates a new page and fills by
reading from storage.


## 3. What actually happens and why

- For copyin case: kernel panic since v5.17

Commit 4c132d1d844a ("x86/futex: Remove .fixup usage") introduced a new extable
fixup type, EX_TYPE_EFAULT_REG, and later patches updated the extable fixup
type for copy-from-user operations, changing it from EX_TYPE_UACCESS to
EX_TYPE_EFAULT_REG. It breaks previous EX_TYPE_UACCESS handling when posion
found in get_user() or copy_from_user().

- For instr case: user process is killed by a SIGBUS signal due to #CMCI and #MCE race

When an uncorrected memory error is consumed there is a race between the
CMCI from the memory controller reporting an uncorrected error with a UCNA
signature, and the core reporting and SRAR signature machine check when the
data is about to be consumed.

### Background: why *UN*corrected errors tied to *C*MCI in Intel platform [1]

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

### Background: why #CMCI and #MCE race when poison is consuming in Intel platform [1]

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


## Why user process is killed for instr case

Commit 046545a661af ("mm/hwpoison: fix error page recovered but reported
"not recovered"") tries to fix noise message "Memory error not recovered"
and skips duplicate SIGBUSs due to the race. But it also introduced a bug
that kill_accessing_process() return -EHWPOISON for instr case, as result,
kill_me_maybe() send a SIGBUS to user process.

# 4. The fix, in my opinion, should be:

- For copyin case:

The key point is whether the error context is in a read from user
memory. We do not care about the ex-type if we know its a MOV
reading from userspace.

is_copy_from_user() return true when both of the following two checks are
true:

    - the current instruction is copy
    - source address is user memory

If copy_user is true, we set

m->kflags |= MCE_IN_KERNEL_COPYIN | MCE_IN_KERNEL_RECOV;

Then do_machine_check() will try fixup_exception() first.

- For instr case: let kill_accessing_process() return 0 to prevent a SIGBUS.

- For patch 3:

The return value of memory_failure() is quite important while discussed
instr case regression with Tony and Miaohe for patch 4, so add comment
about the return value.

Shuai Xue (3):
  x86/mce: Use is_copy_from_user() to determine copy-from-user context
  mm/hwpoison: Do not send SIGBUS to processes with recovered clean
    pages
  mm: memory-failure: Enhance comments for return value of
    memory_failure()

 arch/x86/kernel/cpu/mce/severity.c | 11 +++++------
 mm/memory-failure.c                | 21 +++++++++++++++------
 2 files changed, 20 insertions(+), 12 deletions(-)

-- 
2.39.3



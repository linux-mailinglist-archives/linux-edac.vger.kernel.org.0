Return-Path: <linux-edac+bounces-2032-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A461E99C3C4
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C84A41C229D9
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CCF1553B7;
	Mon, 14 Oct 2024 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="buf5mhGD"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB481531C2;
	Mon, 14 Oct 2024 08:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895383; cv=none; b=ctFcGuOPSO8eB0oTWo/dtj07xeRMmyV+IiW6i1Dn3GQMYu4N47nG72bGsNexHdvVzcGf5Fdvz/v5Y+YQPr42n3r1GG79R4Os/FenavtYCp8EGZwQOW+SVjLc8zsMc3WtJa5XOgd6XnaLpP9cq31Wuq5ai4gSXnHvEnTRq4QGnz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895383; c=relaxed/simple;
	bh=WeSAkX1MvMDMWy4naKwnTCQr6X1J5oxQy0hl5dwz1A4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jM4dgE8T2IP1UgEkBdegHDWZi6RCqva1yG0lPGRbKOu0+x8u5u5B8/L5f+yBuCQMwqHLNuFKOofcoLIyoI4vVxzOOytvHFQ+oKcClQ40l3xndxRhCsO9ZWgaafHbOngEibQY/4dsDb86QVGlfnkpm9ER8AFPPlP+kOlF72lcLxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=buf5mhGD; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728895377; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gtVhAaEFtvj2lIX1mN+ixUOT+9B3L8M2ciNN0miyZ2k=;
	b=buf5mhGD8TTdQyYsZRebYpiRYrQQYim84Ke5jpeM+755WYX2EdTlahUnWREBbFMJAhTeeoDYdkoaAmOSA+O8aLSTMwmY0i3v3JUkM/U4S+1gPX2Tnq9KF4wf6PvqAd3yB6TmVKGAIScNWf0NBHRHRj/1Pa1layK1fFfvjRVM+VE=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WH3mwJg_1728895360 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:42:55 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	mingo@redhat.com,
	robin.murphy@arm.com,
	Jonathan.Cameron@Huawei.com,
	bp@alien8.de,
	rafael@kernel.org,
	wangkefeng.wang@huawei.com,
	tanxiaofei@huawei.com,
	mawupeng1@huawei.com,
	tony.luck@intel.com,
	linmiaohe@huawei.com,
	naoya.horiguchi@nec.com,
	james.morse@arm.com,
	tongtiangen@huawei.com,
	gregkh@linuxfoundation.org,
	will@kernel.org,
	jarkko@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-edac@vger.kernel.org,
	x86@kernel.org,
	xueshuai@linux.alibaba.com,
	justin.he@arm.com,
	ardb@kernel.org,
	ying.huang@intel.com,
	ashish.kalra@amd.com,
	baolin.wang@linux.alibaba.com,
	tglx@linutronix.de,
	dave.hansen@linux.intel.com,
	lenb@kernel.org,
	hpa@zytor.com,
	robert.moore@intel.com,
	lvying6@huawei.com,
	xiexiuqi@huawei.com,
	zhuo.song@linux.alibaba.com
Subject: [PATCH v14 0/3] ACPI: APEI: handle synchronous errors in task work
Date: Mon, 14 Oct 2024 16:42:37 +0800
Message-ID: <20241014084240.18614-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

## Changes Log

changes since v12:
- add reviewed-by tag from Jarkko
- rename task_work to ghes_task_work (per Jarkko)

changes since v12:
- tweak error message for force kill (per Jarkko)
- fix comments style (per Jarkko)
- fix commit log typo (per Jarko)

changes since v11:
- rebase to Linux 6.11-rc6
- fix grammer and typo in commit log (per Borislav)
- remove `sync_` perfix of `sync_task_work`  (per Borislav)
- comments flags and description of `task_work`  (per Borislav)

changes since v10:
- rebase to v6.8-rc2

changes since v9:
- split patch 2 to address exactly one issue in one patch (per Borislav)
- rewrite commit log according to template (per Borislav)
- pickup reviewed-by tag of patch 1 from James Morse
- alloc and free twcb through gen_pool_{alloc, free) (Per James)
- rewrite cover letter

changes since v8:
- remove the bug fix tag of patch 2 (per Jarkko Sakkinen)
- remove the declaration of memory_failure_queue_kick (per Naoya Horiguchi)
- rewrite the return value comments of memory_failure (per Naoya Horiguchi)

changes since v7:
- rebase to Linux v6.6-rc2 (no code changed)
- rewritten the cover letter to explain the motivation of this patchset

changes since v6:
- add more explicty error message suggested by Xiaofei
- pick up reviewed-by tag from Xiaofei
- pick up internal reviewed-by tag from Baolin

changes since v5 by addressing comments from Kefeng:
- document return value of memory_failure()
- drop redundant comments in call site of memory_failure() 
- make ghes_do_proc void and handle abnormal case within it
- pick up reviewed-by tag from Kefeng Wang 

changes since v4 by addressing comments from Xiaofei:
- do a force kill only for abnormal sync errors

changes since v3 by addressing comments from Xiaofei:
- do a force kill for abnormal memory failure error such as invalid PA,
unexpected severity, OOM, etc
- pcik up tested-by tag from Ma Wupeng

changes since v2 by addressing comments from Naoya:
- rename mce_task_work to sync_task_work
- drop ACPI_HEST_NOTIFY_MCE case in is_hest_sync_notify()
- add steps to reproduce this problem in cover letter

changes since v1:
- synchronous events by notify type
- Link: https://lore.kernel.org/lkml/20221206153354.92394-3-xueshuai@linux.alibaba.com/

## Cover Letter

There are two major types of uncorrected recoverable (UCR) errors :

- Synchronous error: The error is detected and raised at the point of the
  consumption in the execution flow, e.g. when a CPU tries to access
  a poisoned cache line. The CPU will take a synchronous error exception
  such as Synchronous External Abort (SEA) on Arm64 and Machine Check
  Exception (MCE) on X86. OS requires to take action (for example, offline
  failure page/kill failure thread) to recover this uncorrectable error.

- Asynchronous error: The error is detected out of processor execution
  context, e.g. when an error is detected by a background scrubber. Some data
  in the memory are corrupted. But the data have not been consumed. OS is
  optional to take action to recover this uncorrectable error.

Currently, both synchronous and asynchronous error use
memory_failure_queue() to schedule memory_failure() exectute in kworker
context. As a result, when a user-space process is accessing a poisoned
data, a data abort is taken and the memory_failure() is executed in the
kworker context:

  - will send wrong si_code by SIGBUS signal in early_kill mode, and
  - can not kill the user-space in some cases resulting a synchronous
    error infinite loop

Issue 1: send wrong si_code in early_kill mode

Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
could be used to determine whether a synchronous exception occurs on
ARM64 platform.  When a synchronous exception is detected, the kernel is
expected to terminate the current process which has accessed poisoned
page. This is done by sending a SIGBUS signal with an error code
BUS_MCEERR_AR, indicating an action-required machine check error on
read.

However, when kill_proc() is called to terminate the processes who have
the poisoned page mapped, it sends the incorrect SIGBUS error code
BUS_MCEERR_AO because the context in which it operates is not the one
where the error was triggered.

To reproduce this problem:

  # STEP1: enable early kill mode
  #sysctl -w vm.memory_failure_early_kill=1
  vm.memory_failure_early_kill = 1

  # STEP2: inject an UCE error and consume it to trigger a synchronous error
  #einj_mem_uc single
  0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
  injecting ...
  triggering ...
  signal 7 code 5 addr 0xffffb0d75000
  page not present
  Test passed

The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
error and it is not fact.

To fix it, queue memory_failure() as a task_work so that it runs in
the context of the process that is actually consuming the poisoned data.

After this patch set:

  # STEP1: enable early kill mode
  #sysctl -w vm.memory_failure_early_kill=1
  vm.memory_failure_early_kill = 1

  # STEP2: inject an UCE error and consume it to trigger a synchronous error
  #einj_mem_uc single
  0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
  injecting ...
  triggering ...
  signal 7 code 4 addr 0xffffb0d75000
  page not present
  Test passed

The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR
error as we expected.

Issue 2: a synchronous error infinite loop due to memory_failure() failed

If a user-space process, e.g. devmem, a poisoned page which has been set
HWPosion flag, kill_accessing_process() is called to send SIGBUS to the
current processs with error info. Because the memory_failure() is
executed in the kworker contex, it will just do nothing but return
EFAULT. So, devmem will access the posioned page and trigger an
excepction again, resulting in a synchronous error infinite loop. Such
loop may cause platform firmware to exceed some threshold and reboot
when Linux could have recovered from this error.

To reproduce this problem:

  # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
  #einj_mem_uc single
  0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
  injecting ...
  triggering ...
  signal 7 code 4 addr 0xffffb0d75000
  page not present
  Test passed

  # STEP 2: access the same page and it will trigger a synchronous error infinite loop
  devmem 0x4092d55b400

To fix it, if memory_failure() failed, perform a force kill to current process.

Issue 3: a synchronous error infinite loop due to no memory_failure() queued

No memory_failure() work is queued unless all bellow preconditions check passed:

- `if (!(mem_err->validation_bits & CPER_MEM_VALID_PA))` in ghes_handle_memory_failure()
- `if (flags == -1)` in ghes_handle_memory_failure()
- `if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))` in ghes_do_memory_failure()
- `if (!pfn_valid(pfn) && !arch_is_platform_page(physical_addr)) ` in ghes_do_memory_failure()

If the preconditions are not passed, the user-space process will trigger SEA again.
This loop can potentially exceed the platform firmware threshold or even
trigger a kernel hard lockup, leading to a system reboot.

To fix it, if no memory_failure() queued, perform a force kill to current process.

And the the memory errors triggered in kernel-mode[5], also relies on this
patchset to kill the failure thread.

Lv Ying and XiuQi from Huawei also proposed to address similar problem[2][4].
Acknowledge to discussion with them.

[1] Add ARMv8 RAS virtualization support in QEMU https://patchew.org/QEMU/20200512030609.19593-1-gengdongjiu@huawei.com/
[2] https://lore.kernel.org/lkml/20221205115111.131568-3-lvying6@huawei.com/
[3] https://lkml.kernel.org/r/20220914064935.7851-1-xueshuai@linux.alibaba.com
[4] https://lore.kernel.org/lkml/20221209095407.383211-1-lvying6@huawei.com/
[5] https://patchwork.kernel.org/project/linux-arm-kernel/cover/20240528085915.1955987-1-tongtiangen@huawei.com/
Shuai Xue (3):
  ACPI: APEI: send SIGBUS to current task if synchronous memory error
    not recovered
  mm: memory-failure: move return value documentation to function
    declaration
  ACPI: APEI: handle synchronous exceptions in task work

 arch/x86/kernel/cpu/mce/core.c |  7 ---
 drivers/acpi/apei/ghes.c       | 86 +++++++++++++++++++++-------------
 include/acpi/ghes.h            |  3 --
 include/linux/mm.h             |  1 -
 mm/memory-failure.c            | 22 +++------
 5 files changed, 60 insertions(+), 59 deletions(-)

-- 
2.39.3



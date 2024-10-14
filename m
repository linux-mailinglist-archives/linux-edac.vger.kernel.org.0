Return-Path: <linux-edac+bounces-2035-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2199C3CE
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFA531C22AA0
	for <lists+linux-edac@lfdr.de>; Mon, 14 Oct 2024 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F46B156F27;
	Mon, 14 Oct 2024 08:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KwoqZpgF"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD6515696E;
	Mon, 14 Oct 2024 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895396; cv=none; b=prHKogFdz/AYmv7W76t8ij3DZzcPVndMq9pKHEGcyBug/5VjtgTTW6K9U+sE4NdNAMS1OG881Vnrjr0kpA6jt/xaxoMb8lkogBHzMe+9f/TTRWml/+fRO2Rm7n7fglwaKVALR23Zdi6GWgjfz/UAbYSewONltpwbiZQX9xW5JZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895396; c=relaxed/simple;
	bh=xlRdIiopzWtLUMZpSKWqpXh7+CzzSQOp44zAhpKn0yU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SdpVGP1YURZrVm8+8tkiEb7SEguypqokoOwBoYj8jR5XvtkVWpTnwJpw9FkxOwtWg7Y9MQqbnz5WFm16ZZApTDi/OsEbZGgCVtzh9NfXYl5HzWLlUyIdrcRR87YYHfOxqkIod8WC46ByeTx2N8GBn7De6U4NvdHVMqoAxAmuUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KwoqZpgF; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728895385; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q1R5nbpoVj8s2ehcuoCBWYhXSfbwrsjFHMsqM9I9f1A=;
	b=KwoqZpgFew/vhZLA7+bhdxTVDLoTzWJxnmBU1BVZ/HTmNmYISeN1XQtnQE3/2TShxS4m7EYPYeZ0Us2lVToT+8r1stnBSV3mqQFAyv5VXuqTXfGBZS9QlpN8+qB7TS0MxFJ9FzC47L/j2rE0eM9KKb04LORbz98yVvTXYMNxkP4=
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WH3mwVk_1728895381 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Oct 2024 16:43:03 +0800
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
Subject: [PATCH v14 3/3] ACPI: APEI: handle synchronous exceptions in task work
Date: Mon, 14 Oct 2024 16:42:40 +0800
Message-ID: <20241014084240.18614-4-xueshuai@linux.alibaba.com>
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

The memory uncorrected error could be signaled by asynchronous interrupt
(specifically, SPI in arm64 platform), e.g. when an error is detected by
a background scrubber, or signaled by synchronous exception
(specifically, data abort excepction in arm64 platform), e.g. when a CPU
tries to access a poisoned cache line. Currently, both synchronous and
asynchronous error use memory_failure_queue() to schedule
memory_failure() exectute in kworker context.

As a result, when a user-space process is accessing a poisoned data, a
data abort is taken and the memory_failure() is executed in the kworker
context:

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

After this patch:

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

Issue 2: a synchronous error infinite loop

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

To fix above two issues, queue memory_failure() as a task_work so that it runs in
the context of the process that is actually consuming the poisoned data.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Tested-by: Ma Wupeng <mawupeng1@huawei.com>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/acpi/apei/ghes.c | 78 +++++++++++++++++++++++-----------------
 include/acpi/ghes.h      |  3 --
 include/linux/mm.h       |  1 -
 mm/memory-failure.c      | 13 -------
 4 files changed, 45 insertions(+), 50 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index f2ee28c44d7a..95e9520eb803 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -467,28 +467,42 @@ static void ghes_clear_estatus(struct ghes *ghes,
 }
 
 /*
- * Called as task_work before returning to user-space.
- * Ensure any queued work has been done before we return to the context that
- * triggered the notification.
+ * struct ghes_task_work - for synchronous RAS event
+ *
+ * @twork:                callback_head for task work
+ * @pfn:                  page frame number of corrupted page
+ * @flags:                work control flags
+ *
+ * Structure to pass task work to be handled before
+ * returning to user-space via task_work_add().
  */
-static void ghes_kick_task_work(struct callback_head *head)
+struct ghes_task_work {
+	struct callback_head twork;
+	u64 pfn;
+	int flags;
+};
+
+static void memory_failure_cb(struct callback_head *twork)
 {
-	struct acpi_hest_generic_status *estatus;
-	struct ghes_estatus_node *estatus_node;
-	u32 node_len;
+	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
+	unsigned long pfn = twcb->pfn;
+	int ret;
 
-	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
-	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
-		memory_failure_queue_kick(estatus_node->task_work_cpu);
+	ret = memory_failure(twcb->pfn, twcb->flags);
+	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
 
-	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
-	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
-	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
+	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
+		return;
+
+	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
+			pfn, current->comm, task_pid_nr(current));
+	force_sig(SIGBUS);
 }
 
 static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 {
 	unsigned long pfn;
+	struct ghes_task_work *twcb;
 
 	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
 		return false;
@@ -501,6 +515,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
 		return false;
 	}
 
+	if (flags == MF_ACTION_REQUIRED && current->mm) {
+		twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
+		if (!twcb)
+			return false;
+
+		twcb->pfn = pfn;
+		twcb->flags = flags;
+		init_task_work(&twcb->twork, memory_failure_cb);
+		task_work_add(current, &twcb->twork, TWA_RESUME);
+		return true;
+	}
+
 	memory_failure_queue(pfn, flags);
 	return true;
 }
@@ -745,7 +771,7 @@ int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, CXL);
 
-static bool ghes_do_proc(struct ghes *ghes,
+static void ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
 	int sev, sec_sev;
@@ -810,8 +836,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 			current->comm, task_pid_nr(current));
 		force_sig(SIGBUS);
 	}
-
-	return queued;
 }
 
 static void __ghes_print_estatus(const char *pfx,
@@ -1113,9 +1137,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 	struct ghes_estatus_node *estatus_node;
 	struct acpi_hest_generic *generic;
 	struct acpi_hest_generic_status *estatus;
-	bool task_work_pending;
 	u32 len, node_len;
-	int ret;
 
 	llnode = llist_del_all(&ghes_estatus_llist);
 	/*
@@ -1130,25 +1152,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
 		estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 		len = cper_estatus_len(estatus);
 		node_len = GHES_ESTATUS_NODE_LEN(len);
-		task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
+
+		ghes_do_proc(estatus_node->ghes, estatus);
+
 		if (!ghes_estatus_cached(estatus)) {
 			generic = estatus_node->generic;
 			if (ghes_print_estatus(NULL, generic, estatus))
 				ghes_estatus_cache_add(generic, estatus);
 		}
-
-		if (task_work_pending && current->mm) {
-			estatus_node->task_work.func = ghes_kick_task_work;
-			estatus_node->task_work_cpu = smp_processor_id();
-			ret = task_work_add(current, &estatus_node->task_work,
-					    TWA_RESUME);
-			if (ret)
-				estatus_node->task_work.func = NULL;
-		}
-
-		if (!estatus_node->task_work.func)
-			gen_pool_free(ghes_estatus_pool,
-				      (unsigned long)estatus_node, node_len);
+		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
+			      node_len);
 
 		llnode = next;
 	}
@@ -1209,7 +1222,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 
 	estatus_node->ghes = ghes;
 	estatus_node->generic = ghes->generic;
-	estatus_node->task_work.func = NULL;
 	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
 
 	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
index be1dd4c1a917..ebd21b05fe6e 100644
--- a/include/acpi/ghes.h
+++ b/include/acpi/ghes.h
@@ -35,9 +35,6 @@ struct ghes_estatus_node {
 	struct llist_node llnode;
 	struct acpi_hest_generic *generic;
 	struct ghes *ghes;
-
-	int task_work_cpu;
-	struct callback_head task_work;
 };
 
 struct ghes_estatus_cache {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ecf63d2b0582..a1286053dd29 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3923,7 +3923,6 @@ enum mf_flags {
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
-extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 1c5098f32d48..c86e10e5c839 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2496,19 +2496,6 @@ static void memory_failure_work_func(struct work_struct *work)
 	}
 }
 
-/*
- * Process memory_failure work queued on the specified CPU.
- * Used to avoid return-to-userspace racing with the memory_failure workqueue.
- */
-void memory_failure_queue_kick(int cpu)
-{
-	struct memory_failure_cpu *mf_cpu;
-
-	mf_cpu = &per_cpu(memory_failure_cpu, cpu);
-	cancel_work_sync(&mf_cpu->work);
-	memory_failure_work_func(&mf_cpu->work);
-}
-
 static int __init memory_failure_init(void)
 {
 	struct memory_failure_cpu *mf_cpu;
-- 
2.39.3



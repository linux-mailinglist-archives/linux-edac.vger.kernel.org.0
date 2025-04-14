Return-Path: <linux-edac+bounces-3532-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B406A88624
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 17:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF4A16C318
	for <lists+linux-edac@lfdr.de>; Mon, 14 Apr 2025 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BEF019AD8C;
	Mon, 14 Apr 2025 14:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ay3Wr2ul"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219342DFA4D;
	Mon, 14 Apr 2025 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744642614; cv=none; b=Is5kdTmh4TQcuOUZLj/Kd6HJorrUtwDkNLJzQwlBpypKEFdofXQ00e+OFTGBNqPAwyQ82TmkTRd+/yjYKmywIwuod2LwxvglFfPKDJDSDXu9divFi7qaHpcVMq4UIc091omRfBzd3Cd3DM5SxDC/vTIRkblxH4YpMQS/g6CxeTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744642614; c=relaxed/simple;
	bh=O10qzwnAcUI0KXKvAEFKDyoqTG6E+l2XprcvH0dLTRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dv/Mzp4suG6utUx+UCUzNp3uByMP+HqSkN8RxXwxNl/PqjsJ8NQhQXmmMMgcFv3WkZqmeJM5t4XLiFoMQoRQDm8CVVc7FDo2PwkWrdeX9SBA7XdOFaKAEV8Sx6NA24+hCVl9AK3WtTg01WXhdhrRop4PV/ycyUqXI8fmP0gW8i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ay3Wr2ul; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744642601; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=DzZcP5CV7v6idQsZi5FGH74THy20XJIoGZKmKPafRVU=;
	b=Ay3Wr2ulkwK6mS6FGpvcNnu8vCa4jN+DpPCIlTtTMO8FOMhgwkU93V+T9//CKnhXBbZcvSB/tkSoXWRyvDBJm1COit3UoBMHBI2XzA6CDMK/GzhFN8XsaKM9NhAUjn/jRdKbpr+XqxJuy7ldkdQPoMLG8m0S8DHDMp/i10TamUA=
Received: from 30.246.161.79(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WWqwZcK_1744642597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 14 Apr 2025 22:56:39 +0800
Message-ID: <af2537e4-9cbf-4c25-82b0-f3167c5b4c68@linux.alibaba.com>
Date: Mon, 14 Apr 2025 22:56:36 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v18 2/2] ACPI: APEI: handle synchronous exceptions
 in task work
To: Hanjun Guo <guohanjun@huawei.com>, catalin.marinas@arm.com,
 sudeep.holla@arm.com, lpieralisi@kernel.org, linux-acpi@vger.kernel.org,
 yazen.ghannam@amd.com, mark.rutland@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@Huawei.com, bp@alien8.de,
 rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, linux-edac@vger.kernel.org, x86@kernel.org,
 justin.he@arm.com, ardb@kernel.org, ying.huang@linux.alibaba.com,
 ashish.kalra@amd.com, baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20250404112050.42040-1-xueshuai@linux.alibaba.com>
 <20250404112050.42040-3-xueshuai@linux.alibaba.com>
 <fb399bd0-c2a2-574f-06fa-3cd0f309f7a5@huawei.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <fb399bd0-c2a2-574f-06fa-3cd0f309f7a5@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/14 22:48, Hanjun Guo 写道:
> On 2025/4/4 19:20, Shuai Xue wrote:
>> The memory uncorrected error could be signaled by asynchronous interrupt
>> (specifically, SPI in arm64 platform), e.g. when an error is detected by
>> a background scrubber, or signaled by synchronous exception
>> (specifically, data abort exception in arm64 platform), e.g. when a CPU
>> tries to access a poisoned cache line. Currently, both synchronous and
>> asynchronous error use memory_failure_queue() to schedule
>> memory_failure() to exectute in a kworker context.
>>
>> As a result, when a user-space process is accessing a poisoned data, a
>> data abort is taken and the memory_failure() is executed in the kworker
>> context, memory_failure():
>>
>>    - will send wrong si_code by SIGBUS signal in early_kill mode, and
>>    - can not kill the user-space in some cases resulting a synchronous
>>      error infinite loop
>>
>> Issue 1: send wrong si_code in early_kill mode
>>
>> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
>> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
>> could be used to determine whether a synchronous exception occurs on
>> ARM64 platform.  When a synchronous exception is detected, the kernel is
>> expected to terminate the current process which has accessed poisoned
>> page. This is done by sending a SIGBUS signal with an error code
>> BUS_MCEERR_AR, indicating an action-required machine check error on
>> read.
>>
>> However, when kill_proc() is called to terminate the processes who have
>> the poisoned page mapped, it sends the incorrect SIGBUS error code
>> BUS_MCEERR_AO because the context in which it operates is not the one
>> where the error was triggered.
>>
>> To reproduce this problem:
>>
>>    #sysctl -w vm.memory_failure_early_kill=1
>>    vm.memory_failure_early_kill = 1
>>
>>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 5 addr 0xffffb0d75000
>>    page not present
>>    Test passed
>>
>> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
>> error and it is not the fact.
>>
>> After this patch:
>>
>>    # STEP1: enable early kill mode
>>    #sysctl -w vm.memory_failure_early_kill=1
>>    vm.memory_failure_early_kill = 1
>>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 4 addr 0xffffb0d75000
>>    page not present
>>    Test passed
>>
>> The si_code (code 4) from einj_mem_uc indicates that it is a BUS_MCEERR_AR
>> error as we expected.
>>
>> Issue 2: a synchronous error infinite loop
>>
>> If a user-space process, e.g. devmem, accesses a poisoned page for which
>> the HWPoison flag is set, kill_accessing_process() is called to send
>> SIGBUS to current processs with error info. Because the memory_failure()
>> is executed in the kworker context, it will just do nothing but return
>> EFAULT. So, devmem will access the posioned page and trigger an
>> exception again, resulting in a synchronous error infinite loop. Such
>> exception loop may cause platform firmware to exceed some threshold and
>> reboot when Linux could have recovered from this error.
>>
>> To reproduce this problem:
>>
>>    # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 4 addr 0xffffb0d75000
>>    page not present
>>    Test passed
>>
>>    # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>>    devmem 0x4092d55b400
>>
>> To fix above two issues, queue memory_failure() as a task_work so that
>> it runs in the context of the process that is actually consuming the
>> poisoned data.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Jane Chu <jane.chu@oracle.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 79 +++++++++++++++++++++++-----------------
>>   include/acpi/ghes.h      |  3 --
>>   include/linux/mm.h       |  1 -
>>   mm/memory-failure.c      | 13 -------
>>   4 files changed, 45 insertions(+), 51 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 50e4d924aa8b..87cf4b373ebe 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -464,28 +464,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>           ghes_ack_error(ghes->generic_v2);
>>   }
>> -/*
>> - * Called as task_work before returning to user-space.
>> - * Ensure any queued work has been done before we return to the context that
>> - * triggered the notification.
>> +/**
>> + * struct ghes_task_work - for synchronous RAS event
>> + *
>> + * @twork:                callback_head for task work
>> + * @pfn:                  page frame number of corrupted page
>> + * @flags:                work control flags
>> + *
>> + * Structure to pass task work to be handled before
>> + * returning to user-space via task_work_add().
>>    */
>> -static void ghes_kick_task_work(struct callback_head *head)
>> +struct ghes_task_work {
>> +    struct callback_head twork;
>> +    u64 pfn;
>> +    int flags;
>> +};
>> +
>> +static void memory_failure_cb(struct callback_head *twork)
>>   {
>> -    struct acpi_hest_generic_status *estatus;
>> -    struct ghes_estatus_node *estatus_node;
>> -    u32 node_len;
>> +    struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
>> +    int ret;
>> -    estatus_node = container_of(head, struct ghes_estatus_node, task_work);
>> -    if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>> -        memory_failure_queue_kick(estatus_node->task_work_cpu);
>> +    ret = memory_failure(twcb->pfn, twcb->flags);
>> +    gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>> -    estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>> -    node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
>> -    gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>> +    if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
>> +        return;
>> +
>> +    pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
>> +            twcb->pfn, current->comm, task_pid_nr(current));
>> +    force_sig(SIGBUS);
>>   }
>>   static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>   {
>> +    struct ghes_task_work *twcb;
>>       unsigned long pfn;
>>       if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>> @@ -499,6 +512,18 @@ static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>           return false;
>>       }
>> +    if (flags == MF_ACTION_REQUIRED && current->mm) {
>> +        twcb = (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
>> +        if (!twcb)
>> +            return false;
>> +
>> +        twcb->pfn = pfn;
>> +        twcb->flags = flags;
>> +        init_task_work(&twcb->twork, memory_failure_cb);
>> +        task_work_add(current, &twcb->twork, TWA_RESUME);
>> +        return true;
>> +    }
>> +
>>       memory_failure_queue(pfn, flags);
>>       return true;
>>   }
>> @@ -743,7 +768,7 @@ int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, "CXL");
>> -static bool ghes_do_proc(struct ghes *ghes,
>> +static void ghes_do_proc(struct ghes *ghes,
>>                const struct acpi_hest_generic_status *estatus)
>>   {
>>       int sev, sec_sev;
>> @@ -809,8 +834,6 @@ static bool ghes_do_proc(struct ghes *ghes,
>>               current->comm, task_pid_nr(current));
>>           force_sig(SIGBUS);
>>       }
>> -
>> -    return queued;
>>   }
>>   static void __ghes_print_estatus(const char *pfx,
>> @@ -1114,9 +1137,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>       struct ghes_estatus_node *estatus_node;
>>       struct acpi_hest_generic *generic;
>>       struct acpi_hest_generic_status *estatus;
>> -    bool task_work_pending;
>>       u32 len, node_len;
>> -    int ret;
>>       llnode = llist_del_all(&ghes_estatus_llist);
>>       /*
>> @@ -1131,25 +1152,16 @@ static void ghes_proc_in_irq(struct irq_work *irq_work)
>>           estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>           len = cper_estatus_len(estatus);
>>           node_len = GHES_ESTATUS_NODE_LEN(len);
>> -        task_work_pending = ghes_do_proc(estatus_node->ghes, estatus);
>> +
>> +        ghes_do_proc(estatus_node->ghes, estatus);
>> +
>>           if (!ghes_estatus_cached(estatus)) {
>>               generic = estatus_node->generic;
>>               if (ghes_print_estatus(NULL, generic, estatus))
>>                   ghes_estatus_cache_add(generic, estatus);
>>           }
>> -
>> -        if (task_work_pending && current->mm) {
>> -            estatus_node->task_work.func = ghes_kick_task_work;
>> -            estatus_node->task_work_cpu = smp_processor_id();
>> -            ret = task_work_add(current, &estatus_node->task_work,
>> -                        TWA_RESUME);
>> -            if (ret)
>> -                estatus_node->task_work.func = NULL;
>> -        }
>> -
>> -        if (!estatus_node->task_work.func)
>> -            gen_pool_free(ghes_estatus_pool,
>> -                      (unsigned long)estatus_node, node_len);
>> +        gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
>> +                  node_len);
>>           llnode = next;
>>       }
>> @@ -1210,7 +1222,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
>>       estatus_node->ghes = ghes;
>>       estatus_node->generic = ghes->generic;
>> -    estatus_node->task_work.func = NULL;
>>       estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>>       if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
>> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
>> index be1dd4c1a917..ebd21b05fe6e 100644
>> --- a/include/acpi/ghes.h
>> +++ b/include/acpi/ghes.h
>> @@ -35,9 +35,6 @@ struct ghes_estatus_node {
>>       struct llist_node llnode;
>>       struct acpi_hest_generic *generic;
>>       struct ghes *ghes;
>> -
>> -    int task_work_cpu;
>> -    struct callback_head task_work;
>>   };
>>   struct ghes_estatus_cache {
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 8483e09aeb2c..327517bf2168 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3933,7 +3933,6 @@ enum mf_flags {
>>   int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>>                 unsigned long count, int mf_flags);
>>   extern int memory_failure(unsigned long pfn, int flags);
>> -extern void memory_failure_queue_kick(int cpu);
>>   extern int unpoison_memory(unsigned long pfn);
>>   extern atomic_long_t num_poisoned_pages __read_mostly;
>>   extern int soft_offline_page(unsigned long pfn, int flags);
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 327e02fdc029..ad07f673608d 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -2494,19 +2494,6 @@ static void memory_failure_work_func(struct work_struct *work)
>>       }
>>   }
>> -/*
>> - * Process memory_failure work queued on the specified CPU.
>> - * Used to avoid return-to-userspace racing with the memory_failure workqueue.
>> - */
>> -void memory_failure_queue_kick(int cpu)
>> -{
>> -    struct memory_failure_cpu *mf_cpu;
>> -
>> -    mf_cpu = &per_cpu(memory_failure_cpu, cpu);
>> -    cancel_work_sync(&mf_cpu->work);
>> -    memory_failure_work_func(&mf_cpu->work);
>> -}
>> -
>>   static int __init memory_failure_init(void)
>>   {
>>       struct memory_failure_cpu *mf_cpu;
> 
> Looks good to me,
> 
> Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Thanks
> Hanjun

Thanks.
Shuai



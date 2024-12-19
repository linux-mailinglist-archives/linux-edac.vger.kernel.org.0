Return-Path: <linux-edac+bounces-2745-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A691A9F7240
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2024 02:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3E11888CF5
	for <lists+linux-edac@lfdr.de>; Thu, 19 Dec 2024 01:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5995D86359;
	Thu, 19 Dec 2024 01:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aCRC4JkE"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350C4500E;
	Thu, 19 Dec 2024 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572651; cv=none; b=XV8vUDmO7HRa2FaEE1xIMKONah7K/zzmxFWVCVh6Qbn0UjmKbJAxxBmnjzWZDOtBOy8yiKZ8QUUV6/3JDMJYXjLyRHodtZ9/YlDbhDuzhSeLsePXtVLDv0ypCNuNroQKCPIZV6+zMBGbifS0uQJuMtdky7n1hjgDXoXRPfTu56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572651; c=relaxed/simple;
	bh=1hpsXkLcVMhZv7MpBmGJZ03DjaR5kIqPOIFze6W+RMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gzOpasUuYjxSE0drso9STkqNI7AvbFGPPCvaFf0Z0SjvLgCYZ49IszZVfioJlyqepC8JvFVCWir1t14FUMbiTs6t/42DdofdZPnSkyhe2Vn3+xwtTcKFdsrTyiIxOlr7Xc6v/NfQamJgpLTKw/l2/Pm/99Z3y7uJ0XUIt1wzarM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aCRC4JkE; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734572645; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LsMRam799y1BeBH01GzJpZAfi+0+C0lyLFmFJu0j0GQ=;
	b=aCRC4JkEajWHQwHxXoWPVfw1/MSoLSTfQEGaYaiFNigymQx1tIA1B+pfw1cUM9t9UZPd+VvapQ55GcRFnYH9JF0LMi0G2U9j3lqn/IMyo+q8yzM4FiGpjhfmA5AsANyWdSGeAsVA8uUFg9yWIz/h8DgSqo5jovpLqER/qalq738=
Received: from 30.246.161.240(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WLoNiHx_1734572640 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Dec 2024 09:44:02 +0800
Message-ID: <a9c2ea4d-7199-4d1c-8f10-57761b50d27f@linux.alibaba.com>
Date: Thu, 19 Dec 2024 09:43:59 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/3] ACPI: APEI: handle synchronous exceptions in task
 work
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@huawei.com, bp@alien8.de,
 rafael@kernel.org, linux-arm-kernel@lists.infradead.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org, jarkko@kernel.org, linux-acpi@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20241202030527.20586-1-xueshuai@linux.alibaba.com>
 <20241202030527.20586-4-xueshuai@linux.alibaba.com>
 <20241218165331.GF1155365@yaz-khff2.amd.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241218165331.GF1155365@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/19 00:53, Yazen Ghannam 写道:
> On Mon, Dec 02, 2024 at 11:05:27AM +0800, Shuai Xue wrote:
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
>>    - will send wrong si_code by SIGBUS signal in early_kill mode, and
>>    - can not kill the user-space in some cases resulting a synchronous
>>      error infinite loop
>>
>> Issue 1: send wrong si_code in early_kill mode
>>
>> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
>> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
>> could be used to determine whether a synchronous exception occurs on
>> ARM64 platform.  When a synchronous exception is detected, the kernel is
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
>>    #sysctl -w vm.memory_failure_early_kill=1
>>    vm.memory_failure_early_kill = 1
>>
>>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 5 addr 0xffffb0d75000
>>    page not present
>>    Test passed
>>
>> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
>> error and it is not the fact.
>>
>> After this patch:
>>
>>    # STEP1: enable early kill mode
>>    #sysctl -w vm.memory_failure_early_kill=1
>>    vm.memory_failure_early_kill = 1
>>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 4 addr 0xffffb0d75000
>>    page not present
>>    Test passed
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
>>    # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>>    #einj_mem_uc single
>>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>    injecting ...
>>    triggering ...
>>    signal 7 code 4 addr 0xffffb0d75000
>>    page not present
>>    Test passed
>>
>>    # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>>    devmem 0x4092d55b400
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
>> ---
>>   drivers/acpi/apei/ghes.c | 77 +++++++++++++++++++++++-----------------
>>   include/acpi/ghes.h      |  3 --
>>   include/linux/mm.h       |  1 -
>>   mm/memory-failure.c      | 13 -------
>>   4 files changed, 44 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 106486bdfefc..70f2ee3ad1a8 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -467,28 +467,41 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>   }
>>   
>>   /*
> 
> The "kernel-doc" format needs an opening "/**".
> 
>> - * Called as task_work before returning to user-space.
>> - * Ensure any queued work has been done before we return to the context that
>> - * triggered the notification.
>> + * struct ghes_task_work - for synchronous RAS event
>> + *
>> + * @twork:                callback_head for task work
>> + * @pfn:                  page frame number of corrupted page
>> + * @flags:                work control flags
>> + *
>> + * Structure to pass task work to be handled before
>> + * returning to user-space via task_work_add().
>>    */
>> -static void ghes_kick_task_work(struct callback_head *head)
>> +struct ghes_task_work {
>> +	struct callback_head twork;
>> +	u64 pfn;
>> +	int flags;
>> +};
>> +
>> +static void memory_failure_cb(struct callback_head *twork)
>>   {
>> -	struct acpi_hest_generic_status *estatus;
>> -	struct ghes_estatus_node *estatus_node;
>> -	u32 node_len;
>> +	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
>> +	int ret;
>>   
>> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
>> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
>> +	ret = memory_failure(twcb->pfn, twcb->flags);
>> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>>   
>> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
>> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
>> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
>> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
>> +		return;
>> +
>> +	pr_err("%#llx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
>> +			twcb->pfn, current->comm, task_pid_nr(current));
> 
> This is basically the same as the message in kill_proc(). Was there any
> consideration to have a shared function? Maybe this could be a future
> patch.

Yep, I'd like to refactor in a future.
> 
>> +	force_sig(SIGBUS);
>>   }
>>   
>>   static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>>   {
>>   	unsigned long pfn;
>> +	struct ghes_task_work *twcb;
> 
> Minor nit: A common preference I've seen is to order variable
> declarations from longest->shortest line length.

Will fix it if this patch set still misses the next merge window.

> 
> But overall, looks okay to me.
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> 
> Thanks,
> Yazen


Thanks for valuable comments.

Best Regards,
Shuai



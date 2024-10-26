Return-Path: <linux-edac+bounces-2310-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A389C9B1581
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 08:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B84B1F227B5
	for <lists+linux-edac@lfdr.de>; Sat, 26 Oct 2024 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143DE176AD8;
	Sat, 26 Oct 2024 06:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t8LIS3vP"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29429CE5;
	Sat, 26 Oct 2024 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729925224; cv=none; b=QG+IotQaab0LmzYVJK0KArTVD91627oNn2T8ncH4kbY49AhVSXwaRvLPkGVjg323buz/RoseD4e/CSB/pfbdlke4rkYrF/SOJrJn8OcVG8sLeGk/glo64FCXvPk1o2zjC2AJDMgXVGYsw4xO3XtgS+nYc0loH11CMgAGMIsekME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729925224; c=relaxed/simple;
	bh=9RN3xPCWK0Lk0NwGmuvZ6xvKv4nAC74l3VWLTq2+v7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTZUSnO6IyS0wAACaXM45UY0V+0DRbJquv1AkGK4gHaah3lgQZucTUAofeG6EJAq+SF5m2AgBXnTWTp8jgZOwnXJ3ZPQyuDtzRJvAKQO3glR6O8pHBKTAV7FvX3wA2nqq46kpNXuKxvxKLdVBgMkj+y+6dxHiY+5t0fzqQhUp4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t8LIS3vP; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729925212; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=642D6GzLlUCKe9SzYd8cvk/nLxL5J/aN2kycl56LWxQ=;
	b=t8LIS3vP2l2nE1sBKy4a5I/1tURadv+2kUyitWaRfS4SD2XkSgiN/S19zDiSsgsZChXUAoqFk8q1bb/RhoAk7HZfq5sUFRE9+Gdq4W6sN5Gde1ylxtmZzyCwc1gwNFF1ls75N7B3LllCrgw777eE+85FHhXbYFTE3PpHo7hNbIQ=
Received: from 30.246.160.81(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WHuUzmp_1729925207 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 26 Oct 2024 14:46:50 +0800
Message-ID: <ddb639c0-8966-4144-af20-0dd9b61d70a8@linux.alibaba.com>
Date: Sat, 26 Oct 2024 14:46:46 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/3] ACPI: APEI: handle synchronous exceptions in task
 work
To: Jarkko Sakkinen <jarkko@kernel.org>, mark.rutland@arm.com,
 catalin.marinas@arm.com, mingo@redhat.com, robin.murphy@arm.com,
 Jonathan.Cameron@Huawei.com, bp@alien8.de, rafael@kernel.org,
 wangkefeng.wang@huawei.com, tanxiaofei@huawei.com, mawupeng1@huawei.com,
 tony.luck@intel.com, linmiaohe@huawei.com, naoya.horiguchi@nec.com,
 james.morse@arm.com, tongtiangen@huawei.com, gregkh@linuxfoundation.org,
 will@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
 linux-edac@vger.kernel.org, x86@kernel.org, justin.he@arm.com,
 ardb@kernel.org, ying.huang@intel.com, ashish.kalra@amd.com,
 baolin.wang@linux.alibaba.com, tglx@linutronix.de,
 dave.hansen@linux.intel.com, lenb@kernel.org, hpa@zytor.com,
 robert.moore@intel.com, lvying6@huawei.com, xiexiuqi@huawei.com,
 zhuo.song@linux.alibaba.com
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20241014084240.18614-4-xueshuai@linux.alibaba.com>
 <05a8d26b-b023-426f-879c-7d33be4a6406@linux.alibaba.com>
 <D54YRGZ47LLS.2BGS3F7T80DF4@kernel.org>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <D54YRGZ47LLS.2BGS3F7T80DF4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/10/25 22:40, Jarkko Sakkinen 写道:
> On Tue Oct 22, 2024 at 4:11 AM EEST, Shuai Xue wrote:
>> Hi, Jarkko,
>>
>>
>> 在 2024/10/14 16:42, Shuai Xue 写道:
>>> The memory uncorrected error could be signaled by asynchronous interrupt
>>> (specifically, SPI in arm64 platform), e.g. when an error is detected by
>>> a background scrubber, or signaled by synchronous exception
>>> (specifically, data abort excepction in arm64 platform), e.g. when a CPU
>>> tries to access a poisoned cache line. Currently, both synchronous and
>>> asynchronous error use memory_failure_queue() to schedule
>>> memory_failure() exectute in kworker context.
>>>
>>> As a result, when a user-space process is accessing a poisoned data, a
>>> data abort is taken and the memory_failure() is executed in the kworker
>>> context:
>>>
>>>     - will send wrong si_code by SIGBUS signal in early_kill mode, and
>>>     - can not kill the user-space in some cases resulting a synchronous
>>>       error infinite loop
>>>
>>> Issue 1: send wrong si_code in early_kill mode
>>>
>>> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
>>> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
>>> could be used to determine whether a synchronous exception occurs on
>>> ARM64 platform.  When a synchronous exception is detected, the kernel is
>>> expected to terminate the current process which has accessed poisoned
>>> page. This is done by sending a SIGBUS signal with an error code
>>> BUS_MCEERR_AR, indicating an action-required machine check error on
>>> read.
>>>
>>> However, when kill_proc() is called to terminate the processes who have
>>> the poisoned page mapped, it sends the incorrect SIGBUS error code
>>> BUS_MCEERR_AO because the context in which it operates is not the one
>>> where the error was triggered.
>>>
>>> To reproduce this problem:
>>>
>>>     #sysctl -w vm.memory_failure_early_kill=1
>>>     vm.memory_failure_early_kill = 1
>>>
>>>     # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>>     #einj_mem_uc single
>>>     0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>>     injecting ...
>>>     triggering ...
>>>     signal 7 code 5 addr 0xffffb0d75000
>>>     page not present
>>>     Test passed
>>>
>>> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
>>> error and it is not fact.
>>>
>>> After this patch:
>>>
>>>     # STEP1: enable early kill mode
>>>     #sysctl -w vm.memory_failure_early_kill=1
>>>     vm.memory_failure_early_kill = 1
>>>     # STEP2: inject an UCE error and consume it to trigger a synchronous error
>>>     #einj_mem_uc single
>>>     0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>>     injecting ...
>>>     triggering ...
>>>     signal 7 code 4 addr 0xffffb0d75000
>>>     page not present
>>>     Test passed
>>>
>>> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR
>>> error as we expected.
>>>
>>> Issue 2: a synchronous error infinite loop
>>>
>>> If a user-space process, e.g. devmem, a poisoned page which has been set
>>> HWPosion flag, kill_accessing_process() is called to send SIGBUS to the
>>> current processs with error info. Because the memory_failure() is
>>> executed in the kworker contex, it will just do nothing but return
>>> EFAULT. So, devmem will access the posioned page and trigger an
>>> excepction again, resulting in a synchronous error infinite loop. Such
>>> loop may cause platform firmware to exceed some threshold and reboot
>>> when Linux could have recovered from this error.
>>>
>>> To reproduce this problem:
>>>
>>>     # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>>>     #einj_mem_uc single
>>>     0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>>>     injecting ...
>>>     triggering ...
>>>     signal 7 code 4 addr 0xffffb0d75000
>>>     page not present
>>>     Test passed
>>>
>>>     # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>>>     devmem 0x4092d55b400
>>>
>>> To fix above two issues, queue memory_failure() as a task_work so that it runs in
>>> the context of the process that is actually consuming the poisoned data.
>>>
>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
>>> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> ---
>>>    drivers/acpi/apei/ghes.c | 78 +++++++++++++++++++++++-----------------
>>>    include/acpi/ghes.h      |  3 --
>>>    include/linux/mm.h       |  1 -
>>>    mm/memory-failure.c      | 13 -------
>>>    4 files changed, 45 insertions(+), 50 deletions(-)
>>>
>>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>>> index f2ee28c44d7a..95e9520eb803 100644
>>> --- a/drivers/acpi/apei/ghes.c
>>> +++ b/drivers/acpi/apei/ghes.c
>>> @@ -467,28 +467,42 @@ static void ghes_clear_estatus(struct ghes *ghes,
>>>    }
>>>    
>>>    /*
>>> - * Called as task_work before returning to user-space.
>>> - * Ensure any queued work has been done before we return to the context that
>>> - * triggered the notification.
>>> + * struct ghes_task_work - for synchronous RAS event
>>> + *
>>> + * @twork:                callback_head for task work
>>> + * @pfn:                  page frame number of corrupted page
>>> + * @flags:                work control flags
>>> + *
>>> + * Structure to pass task work to be handled before
>>> + * returning to user-space via task_work_add().
>>>     */
>>
>>
>> Do you have any futer comments about this patch? Any comments are
>> welcomed. If not, are you happy to explictly give the reveiwed-by tag?
> 
> Sorry I've been busy switching to a new job.
> 
> I read this now through and both commit messages and the code changes
> look sane to me so I guess I don't have any problem with that:
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
>>
>> Best Regard,
>> Shuai
> 
> BR, Jarkko


Thank you.

BR. Shuai



Return-Path: <linux-edac+bounces-2176-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35919A9545
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 03:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A981B21DAE
	for <lists+linux-edac@lfdr.de>; Tue, 22 Oct 2024 01:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C60142AB3;
	Tue, 22 Oct 2024 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bC3gFGbM"
X-Original-To: linux-edac@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA7323D;
	Tue, 22 Oct 2024 01:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729559510; cv=none; b=YLWl7NsmvU3kaxdEcMoKHGkugwyXMG57DeTVmHapbPLrP4+nUpkMaIMwE0jvuoO6CSHElvOnTVU0YSGoQ8/0esQYSJFmNw2T0/E9LE1DyVPK1oPmvUa7TKCFNU8UqTx7LjQ0Pl1AmBfBkKHWv4EMkKI95Yvr9uGDi7MC3xR+AXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729559510; c=relaxed/simple;
	bh=dyaqIfWu5jk9N2YZ1V36RrpXXNxAHtG8g2KDweEv5es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1uUWDFZBsn394QeLStBJFWfVRJNhzts9VZ0MsoNOlkZrP/ZZlbkiiDqrwotVgmqRKm+iGR5zTxTT1h7BpgjRy/Voiq/LZ4fckmL9GCEk06m//o6ff+C26QqxVqP8GnXDM+Iz1eAepCb0d/rvKLYSu4s8utBGqedYRNr7YsXqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bC3gFGbM; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729559503; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Su0JCUUNtQowa7ZUF9W/JcsQXW+zdoUv4LGM6ZfbIrs=;
	b=bC3gFGbMrgwot0glVG484iR6MOclDdfrgbMLWEbjCCWYCe5XNus7ounxXcWYetdISXL4ROkPn5M9SuSvS6Ucsdry1OHSOKs/OAjfnLtf7V4zFanOmaPnwV1posy9CX1D9/EIUxmk0OZaD3mvEE8muqWwW4CcGheHsa9hRkmvbKo=
Received: from 30.246.160.103(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WHfusch_1729559498 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Oct 2024 09:11:40 +0800
Message-ID: <05a8d26b-b023-426f-879c-7d33be4a6406@linux.alibaba.com>
Date: Tue, 22 Oct 2024 09:11:37 +0800
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 3/3] ACPI: APEI: handle synchronous exceptions in task
 work
To: mark.rutland@arm.com, catalin.marinas@arm.com, mingo@redhat.com,
 robin.murphy@arm.com, Jonathan.Cameron@Huawei.com, bp@alien8.de,
 rafael@kernel.org, wangkefeng.wang@huawei.com, tanxiaofei@huawei.com,
 mawupeng1@huawei.com, tony.luck@intel.com, linmiaohe@huawei.com,
 naoya.horiguchi@nec.com, james.morse@arm.com, tongtiangen@huawei.com,
 gregkh@linuxfoundation.org, will@kernel.org, jarkko@kernel.org
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
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20241014084240.18614-4-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Jarkko,


在 2024/10/14 16:42, Shuai Xue 写道:
> The memory uncorrected error could be signaled by asynchronous interrupt
> (specifically, SPI in arm64 platform), e.g. when an error is detected by
> a background scrubber, or signaled by synchronous exception
> (specifically, data abort excepction in arm64 platform), e.g. when a CPU
> tries to access a poisoned cache line. Currently, both synchronous and
> asynchronous error use memory_failure_queue() to schedule
> memory_failure() exectute in kworker context.
> 
> As a result, when a user-space process is accessing a poisoned data, a
> data abort is taken and the memory_failure() is executed in the kworker
> context:
> 
>    - will send wrong si_code by SIGBUS signal in early_kill mode, and
>    - can not kill the user-space in some cases resulting a synchronous
>      error infinite loop
> 
> Issue 1: send wrong si_code in early_kill mode
> 
> Since commit a70297d22132 ("ACPI: APEI: set memory failure flags as
> MF_ACTION_REQUIRED on synchronous events")', the flag MF_ACTION_REQUIRED
> could be used to determine whether a synchronous exception occurs on
> ARM64 platform.  When a synchronous exception is detected, the kernel is
> expected to terminate the current process which has accessed poisoned
> page. This is done by sending a SIGBUS signal with an error code
> BUS_MCEERR_AR, indicating an action-required machine check error on
> read.
> 
> However, when kill_proc() is called to terminate the processes who have
> the poisoned page mapped, it sends the incorrect SIGBUS error code
> BUS_MCEERR_AO because the context in which it operates is not the one
> where the error was triggered.
> 
> To reproduce this problem:
> 
>    #sysctl -w vm.memory_failure_early_kill=1
>    vm.memory_failure_early_kill = 1
> 
>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>    #einj_mem_uc single
>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>    injecting ...
>    triggering ...
>    signal 7 code 5 addr 0xffffb0d75000
>    page not present
>    Test passed
> 
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
> error and it is not fact.
> 
> After this patch:
> 
>    # STEP1: enable early kill mode
>    #sysctl -w vm.memory_failure_early_kill=1
>    vm.memory_failure_early_kill = 1
>    # STEP2: inject an UCE error and consume it to trigger a synchronous error
>    #einj_mem_uc single
>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>    injecting ...
>    triggering ...
>    signal 7 code 4 addr 0xffffb0d75000
>    page not present
>    Test passed
> 
> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR
> error as we expected.
> 
> Issue 2: a synchronous error infinite loop
> 
> If a user-space process, e.g. devmem, a poisoned page which has been set
> HWPosion flag, kill_accessing_process() is called to send SIGBUS to the
> current processs with error info. Because the memory_failure() is
> executed in the kworker contex, it will just do nothing but return
> EFAULT. So, devmem will access the posioned page and trigger an
> excepction again, resulting in a synchronous error infinite loop. Such
> loop may cause platform firmware to exceed some threshold and reboot
> when Linux could have recovered from this error.
> 
> To reproduce this problem:
> 
>    # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>    #einj_mem_uc single
>    0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>    injecting ...
>    triggering ...
>    signal 7 code 4 addr 0xffffb0d75000
>    page not present
>    Test passed
> 
>    # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>    devmem 0x4092d55b400
> 
> To fix above two issues, queue memory_failure() as a task_work so that it runs in
> the context of the process that is actually consuming the poisoned data.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>   drivers/acpi/apei/ghes.c | 78 +++++++++++++++++++++++-----------------
>   include/acpi/ghes.h      |  3 --
>   include/linux/mm.h       |  1 -
>   mm/memory-failure.c      | 13 -------
>   4 files changed, 45 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f2ee28c44d7a..95e9520eb803 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -467,28 +467,42 @@ static void ghes_clear_estatus(struct ghes *ghes,
>   }
>   
>   /*
> - * Called as task_work before returning to user-space.
> - * Ensure any queued work has been done before we return to the context that
> - * triggered the notification.
> + * struct ghes_task_work - for synchronous RAS event
> + *
> + * @twork:                callback_head for task work
> + * @pfn:                  page frame number of corrupted page
> + * @flags:                work control flags
> + *
> + * Structure to pass task work to be handled before
> + * returning to user-space via task_work_add().
>    */


Do you have any futer comments about this patch? Any comments are
welcomed. If not, are you happy to explictly give the reveiwed-by tag?

Best Regard,
Shuai


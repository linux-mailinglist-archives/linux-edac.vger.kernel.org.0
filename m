Return-Path: <linux-edac+bounces-2124-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3B9A1F36
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 11:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EF2F1C266A5
	for <lists+linux-edac@lfdr.de>; Thu, 17 Oct 2024 09:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F691DB52A;
	Thu, 17 Oct 2024 09:56:32 +0000 (UTC)
X-Original-To: linux-edac@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3996C1D278C;
	Thu, 17 Oct 2024 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158992; cv=none; b=Z9jYVnpkXJXgZyVbPx5k7wkPhuWPnzlSqTbkcT0hGT//2co4T2WNZ+4wd3QSVYMbYWfk+p5DVoZpU3+PMCDXg3E8/jhOBeNKwbHR2rHfB77NjH++KRTnsfO3zTIk6W7GmEObmU7+V5HBl/AB70bFqLyd0HVC9/COZd2lJhr24aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158992; c=relaxed/simple;
	bh=/PdA42+y3fNXyRfrGg1mU5q7Aa5N9qOQfbidKdNLyhQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UN1BbLM1zK0NAKTG29S7fOgCkqY6Z5hZf/ZcQ68/PBaaCqtgisUgXhJdNYn3oRUt2FMG46RoXmDoRwKzWxm3MIBtiuq5/CAnHpZVnkQCwx/iO3Ltax+AcOKBXbScmjppA9ubnZTGciA6w48cSAwBSw8G3hrqvZ7slm5BKXSDOXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XTjmB1zcpz6J7Db;
	Thu, 17 Oct 2024 17:51:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A29B4140119;
	Thu, 17 Oct 2024 17:56:25 +0800 (CST)
Received: from localhost (10.126.174.164) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Oct
 2024 11:56:23 +0200
Date: Thu, 17 Oct 2024 10:56:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <mingo@redhat.com>,
	<robin.murphy@arm.com>, <bp@alien8.de>, <rafael@kernel.org>,
	<wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
	<mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
	<naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v14 3/3] ACPI: APEI: handle synchronous exceptions in
 task work
Message-ID: <20241017105621.00000c1e@Huawei.com>
In-Reply-To: <20241014084240.18614-4-xueshuai@linux.alibaba.com>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
	<20241014084240.18614-4-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 14 Oct 2024 16:42:40 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> The memory uncorrected error could be signaled by asynchronous interrupt
> (specifically, SPI in arm64 platform), e.g. when an error is detected by
> a background scrubber, or signaled by synchronous exception
> (specifically, data abort excepction in arm64 platform), e.g. when a CPU

exception

> tries to access a poisoned cache line. Currently, both synchronous and
> asynchronous error use memory_failure_queue() to schedule
> memory_failure() exectute in kworker context.
memory_failure() to execute in kworker context.

(spell check in general)
> 
> As a result, when a user-space process is accessing a poisoned data, a
> data abort is taken and the memory_failure() is executed in the kworker
> context:
context, memory_failure():
//No subject of the following two bullets otherwise.
> 
>   - will send wrong si_code by SIGBUS signal in early_kill mode, and
>   - can not kill the user-space in some cases resulting a synchronous
>     error infinite loop
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
>   #sysctl -w vm.memory_failure_early_kill=1
>   vm.memory_failure_early_kill = 1
> 
>   # STEP2: inject an UCE error and consume it to trigger a synchronous error
>   #einj_mem_uc single
>   0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 5 addr 0xffffb0d75000
>   page not present
>   Test passed
> 
> The si_code (code 5) from einj_mem_uc indicates that it is BUS_MCEERR_AO
> error and it is not fact.
> 
> After this patch:
> 
>   # STEP1: enable early kill mode
>   #sysctl -w vm.memory_failure_early_kill=1
>   vm.memory_failure_early_kill = 1
>   # STEP2: inject an UCE error and consume it to trigger a synchronous error
>   #einj_mem_uc single
>   0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 4 addr 0xffffb0d75000
>   page not present
>   Test passed
> 
> The si_code (code 4) from einj_mem_uc indicates that it is BUS_MCEERR_AR
> error as we expected.
> 
> Issue 2: a synchronous error infinite loop
> 
> If a user-space process, e.g. devmem, a poisoned page which has been set

devmem accesses a poisoned page for which the HWPoison flag is set

> HWPosion flag, kill_accessing_process() is called to send SIGBUS to the
> current processs with error info. Because the memory_failure() is
> executed in the kworker contex, it will just do nothing but return

context

> EFAULT. So, devmem will access the posioned page and trigger an
> excepction again, resulting in a synchronous error infinite loop. Such

exception

> loop may cause platform firmware to exceed some threshold and reboot
> when Linux could have recovered from this error.
> 
> To reproduce this problem:
> 
>   # STEP 1: inject an UCE error, and kernel will set HWPosion flag for related page
>   #einj_mem_uc single
>   0: single   vaddr = 0xffffb0d75400 paddr = 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 4 addr 0xffffb0d75000
>   page not present
>   Test passed
> 
>   # STEP 2: access the same page and it will trigger a synchronous error infinite loop
>   devmem 0x4092d55b400
> 
> To fix above two issues, queue memory_failure() as a task_work so that it runs in
> the context of the process that is actually consuming the poisoned data.
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
One other trivial comment inline.

Whilst this also looks fine to me, there are others who (hopefully)
understand these paths better than me.  With that said.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/acpi/apei/ghes.c | 78 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  3 --
>  include/linux/mm.h       |  1 -
>  mm/memory-failure.c      | 13 -------
>  4 files changed, 45 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f2ee28c44d7a..95e9520eb803 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -467,28 +467,42 @@ static void ghes_clear_estatus(struct ghes *ghes,
>  }
>  
>  /*
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
>   */
> -static void ghes_kick_task_work(struct callback_head *head)
> +struct ghes_task_work {
> +	struct callback_head twork;
> +	u64 pfn;
> +	int flags;
> +};
> +
> +static void memory_failure_cb(struct callback_head *twork)
>  {
> -	struct acpi_hest_generic_status *estatus;
> -	struct ghes_estatus_node *estatus_node;
> -	u32 node_len;
> +	struct ghes_task_work *twcb = container_of(twork, struct ghes_task_work, twork);
> +	unsigned long pfn = twcb->pfn;

This local variable is not used consistently.  I'd just
drop it in favor of always accessing via twcb->pfn

> +	int ret;
>  
> -	estatus_node = container_of(head, struct ghes_estatus_node, task_work);
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
> +	ret = memory_failure(twcb->pfn, twcb->flags);

> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
>  
> -	estatus = GHES_ESTATUS_FROM_NODE(estatus_node);
> -	node_len = GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len);
> +	if (!ret || ret == -EHWPOISON || ret == -EOPNOTSUPP)
> +		return;
> +
> +	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
> +			pfn, current->comm, task_pid_nr(current));
> +	force_sig(SIGBUS);
>  }



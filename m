Return-Path: <linux-edac+bounces-1905-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D559D97D4EB
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 13:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9525128337C
	for <lists+linux-edac@lfdr.de>; Fri, 20 Sep 2024 11:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98901442F4;
	Fri, 20 Sep 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uqXLf/kF"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415D13B59B;
	Fri, 20 Sep 2024 11:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726832660; cv=none; b=Q1IhA4SEwI40oILFr3I6L/80tNHgB1Dr1952wekbgJX3/ydIht2vdwGuVgIAfk17AQiNLo3420tKNz/QzHe1LF9Q7C4HhRzqqy+2HnGlc3uvUq9ccSI+xnXca9NRzu5eHFXM5X+K9nSuilyla6AxUBXSas/KhFU04O5K0y4hbS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726832660; c=relaxed/simple;
	bh=qP5aHhZ4nfs0X9Vr6kQJ38Ui+BjdmI5igsGwNHEb858=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FpnXR4ZTN4Tf32T4Efeq8u6aiEOM099wMet5R6gP1K5SaJEl6hCLngSRfyxlyBmEhbXTtCY4nqagjljnah63zEeiE0hKYakit8ykkXSzn27/nz0cN3T3iMbu0vhSVojdGJbUZEjrBSSi0dAIimBhoixMokrUcufckKTmxRzixTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uqXLf/kF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCFBC4CEC3;
	Fri, 20 Sep 2024 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726832660;
	bh=qP5aHhZ4nfs0X9Vr6kQJ38Ui+BjdmI5igsGwNHEb858=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=uqXLf/kFl1ZolzQ5qMOzzufmQF402Ru1QwZdJp1B6u4wGJR69WsEhsDP0t0mCFhzT
	 Sz9fWMHNzDNrn0pzUkTiyQTVKziXmvqAnD8lBHY8qTdke7+TrWE5vXu6O9AlShGH6q
	 n7KdcA8RbxpdegBYWXNOYOp0jclQe0CXib5MyvcBU7ZlTMHmCKLHWamZA/NBdZ/V+h
	 Dfohfp4E6ReZTcVL67bGaxIVirIatyk/uZbuI6b/De1ywOCH7o+54fn6C1yqpiRQKp
	 Ue62bxAXdAg8gWTCKppbw4YRTD46Jjo7qXqrCHrX0IKhgr9qYxvGO15058GLEWVu+c
	 evUBu1XpxaJNw==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Sep 2024 14:44:16 +0300
Message-Id: <D4B336WSZNHL.RTMEF39HYUEA@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v13 3/3] ACPI: APEI: handle synchronous exceptions in
 task work
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <mark.rutland@arm.com>,
 <catalin.marinas@arm.com>, <mingo@redhat.com>, <robin.murphy@arm.com>,
 <Jonathan.Cameron@Huawei.com>, <bp@alien8.de>, <rafael@kernel.org>,
 <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240920043027.21907-4-xueshuai@linux.alibaba.com>
In-Reply-To: <20240920043027.21907-4-xueshuai@linux.alibaba.com>

On Fri Sep 20, 2024 at 7:30 AM EEST, Shuai Xue wrote:
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
>   #sysctl -w vm.memory_failure_early_kill=3D1
>   vm.memory_failure_early_kill =3D 1
>
>   # STEP2: inject an UCE error and consume it to trigger a synchronous er=
ror
>   #einj_mem_uc single
>   0: single   vaddr =3D 0xffffb0d75400 paddr =3D 4092d55b400
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
>   #sysctl -w vm.memory_failure_early_kill=3D1
>   vm.memory_failure_early_kill =3D 1
>   # STEP2: inject an UCE error and consume it to trigger a synchronous er=
ror
>   #einj_mem_uc single
>   0: single   vaddr =3D 0xffffb0d75400 paddr =3D 4092d55b400
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
>   # STEP 1: inject an UCE error, and kernel will set HWPosion flag for re=
lated page
>   #einj_mem_uc single
>   0: single   vaddr =3D 0xffffb0d75400 paddr =3D 4092d55b400
>   injecting ...
>   triggering ...
>   signal 7 code 4 addr 0xffffb0d75000
>   page not present
>   Test passed
>
>   # STEP 2: access the same page and it will trigger a synchronous error =
infinite loop
>   devmem 0x4092d55b400
>
> To fix above two issues, queue memory_failure() as a task_work so that it=
 runs in
> the context of the process that is actually consuming the poisoned data.
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Tested-by: Ma Wupeng <mawupeng1@huawei.com>
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Xiaofei Tan <tanxiaofei@huawei.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  drivers/acpi/apei/ghes.c | 78 +++++++++++++++++++++++-----------------
>  include/acpi/ghes.h      |  3 --
>  include/linux/mm.h       |  1 -
>  mm/memory-failure.c      | 13 -------
>  4 files changed, 45 insertions(+), 50 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 93eb11482832..60d8044f14d1 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -467,28 +467,42 @@ static void ghes_clear_estatus(struct ghes *ghes,
>  }
> =20
>  /*
> - * Called as task_work before returning to user-space.
> - * Ensure any queued work has been done before we return to the context =
that
> - * triggered the notification.
> + * struct task_work - for synchronous RAS event
> + *
> + * @twork:                callback_head for task work
> + * @pfn:                  page frame number of corrupted page
> + * @flags:                work control flags
> + *
> + * Structure to pass task work to be handled before
> + * returning to user-space via task_work_add().
>   */
> -static void ghes_kick_task_work(struct callback_head *head)
> +struct task_work {
> +	struct callback_head twork;
> +	u64 pfn;
> +	int flags;
> +};

I'd rename this as ghes_task_work. It is too generic name IMHO, easily
confused with task_work.h definitions.

BR, Jarkko


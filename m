Return-Path: <linux-edac+bounces-1798-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8A796A3D2
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 18:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4BE1C24428
	for <lists+linux-edac@lfdr.de>; Tue,  3 Sep 2024 16:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578D8189F20;
	Tue,  3 Sep 2024 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRQkYDgV"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889C189533;
	Tue,  3 Sep 2024 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379881; cv=none; b=MBttoIUu99Oon8hQ8VcsweN0LbKBrU/wQFkIAR6VoK2LoEwv2SA0c1uMbfpBR4dkybzwrSczBAULx44AxKUTtzfFEQMG1zB1UE8fq/CmfbH1t1xP9I0IhcWE/r307jRauppRGWiJTjYFAyd2FLmYOJ4uf84XCboI8jjij7LEHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379881; c=relaxed/simple;
	bh=THL7/x1mxCQjeHgf9Z1afIiTqKiqdomoJs/oxr9ZHSk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HnDWauDze0HIkSAIcMuYfPLe+U9klr8v1WI29C/vvpEqP6lqc5PSJd4V+AfcF4tLRCfffRnfUQGevKzAcfAZf0fDAhYIMEoMpOuIN+Q5RSsTKYFSC2o4/RWwGLfy8gc2rMaVNLRWyX7L9ejPAxL9G2U8D7s9sE/4Pa2xPItDnR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRQkYDgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166DDC4CEC4;
	Tue,  3 Sep 2024 16:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725379880;
	bh=THL7/x1mxCQjeHgf9Z1afIiTqKiqdomoJs/oxr9ZHSk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sRQkYDgVPjZRMwh03glgbKlEIEb0fCPvVmEx1ARP8MG91ewgcqJBPr17D9i9gMSlu
	 5w7iuezwKG0WMef/9Vka5VFd/MzpypFFVLC3oFsE3WDOa6bv4zn1sD4d2pwNVUMeXo
	 gIKNn2uPcPeGzK8V3yo01hZBKEJdoD70pyN6v4Jx4+IVTpV/KGBO6cr72TfIZ7NsI4
	 h4XU942uP5Sly+9QvCnYuEq6y4qprGpBS/mKtqP4DToU9JchT3Wez+eGPQc1qlnVVM
	 iajs0d6nHdsvjxPp67n5OAVSHz21GHg0jZCoZCGU1Sy7rXVlZtPkKTiM4EZqnILUMW
	 plBnJjBXcx0Ow==
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Sep 2024 19:11:17 +0300
Message-Id: <D3WS4D64BTGD.217F1PPA4VQSF@kernel.org>
Cc: <linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
 <linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
 <ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
 <baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
 <dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
 <robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
 <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v12 3/3] ACPI: APEI: handle synchronous exceptions in
 task work
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Shuai Xue" <xueshuai@linux.alibaba.com>, <bp@alien8.de>,
 <rafael@kernel.org>, <wangkefeng.wang@huawei.com>, <tanxiaofei@huawei.com>,
 <mawupeng1@huawei.com>, <tony.luck@intel.com>, <linmiaohe@huawei.com>,
 <naoya.horiguchi@nec.com>, <james.morse@arm.com>, <tongtiangen@huawei.com>,
 <gregkh@linuxfoundation.org>, <will@kernel.org>
X-Mailer: aerc 0.18.2
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240902030034.67152-4-xueshuai@linux.alibaba.com>
In-Reply-To: <20240902030034.67152-4-xueshuai@linux.alibaba.com>

On Mon Sep 2, 2024 at 6:00 AM EEST, Shuai Xue wrote:
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
>   # STEP1: enable early kill mode
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
> To fix it, queue memory_failure() as a task_work so that it runs in
> the context of the process that is actually consuming the poisoned data.
>
> After this patch set:

s/patch set/patch/

>
>   # STEP1: enable early kill mode
>   #sysctl -w vm.memory_failure_early_kill=3D1
>   vm.memory_failure_early_kill =3D 1
>
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
> Issue 2: a synchronous error infinite loop due to memory_failure() failed
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
> To fix it, if memory_failure() failed, perform a force kill to current pr=
ocess.
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
> index b0b20ee533d9..b956e9ed020f 100644
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
> +
> +static void memory_failure_cb(struct callback_head *twork)
>  {
> -	struct acpi_hest_generic_status *estatus;
> -	struct ghes_estatus_node *estatus_node;
> -	u32 node_len;
> +	struct task_work *twcb =3D container_of(twork, struct task_work, twork)=
;
> +	unsigned long pfn =3D twcb->pfn;
> +	int ret;
> =20
> -	estatus_node =3D container_of(head, struct ghes_estatus_node, task_work=
);
> -	if (IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
> -		memory_failure_queue_kick(estatus_node->task_work_cpu);
> +	ret =3D memory_failure(twcb->pfn, twcb->flags);
> +	gen_pool_free(ghes_estatus_pool, (unsigned long)twcb, sizeof(*twcb));
> =20
> -	estatus =3D GHES_ESTATUS_FROM_NODE(estatus_node);
> -	node_len =3D GHES_ESTATUS_NODE_LEN(cper_estatus_len(estatus));
> -	gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node, node_len)=
;
> +	if (!ret || ret =3D=3D -EHWPOISON || ret =3D=3D -EOPNOTSUPP)
> +		return;
> +
> +	pr_err("%#lx: Sending SIGBUS to %s:%d due to hardware memory corruption=
\n",
> +			pfn, current->comm, task_pid_nr(current));
> +	force_sig(SIGBUS);
>  }
> =20
>  static bool ghes_do_memory_failure(u64 physical_addr, int flags)
>  {
>  	unsigned long pfn;
> +	struct task_work *twcb;
> =20
>  	if (!IS_ENABLED(CONFIG_ACPI_APEI_MEMORY_FAILURE))
>  		return false;
> @@ -501,6 +515,18 @@ static bool ghes_do_memory_failure(u64 physical_addr=
, int flags)
>  		return false;
>  	}
> =20
> +	if (flags =3D=3D MF_ACTION_REQUIRED && current->mm) {
> +		twcb =3D (void *)gen_pool_alloc(ghes_estatus_pool, sizeof(*twcb));
> +		if (!twcb)
> +			return false;
> +
> +		twcb->pfn =3D pfn;
> +		twcb->flags =3D flags;
> +		init_task_work(&twcb->twork, memory_failure_cb);
> +		task_work_add(current, &twcb->twork, TWA_RESUME);
> +		return true;
> +	}
> +
>  	memory_failure_queue(pfn, flags);
>  	return true;
>  }
> @@ -745,7 +771,7 @@ int cxl_cper_kfifo_get(struct cxl_cper_work_data *wd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cper_kfifo_get, CXL);
> =20
> -static bool ghes_do_proc(struct ghes *ghes,
> +static void ghes_do_proc(struct ghes *ghes,
>  			 const struct acpi_hest_generic_status *estatus)
>  {
>  	int sev, sec_sev;
> @@ -810,8 +836,6 @@ static bool ghes_do_proc(struct ghes *ghes,
>  			current->comm, task_pid_nr(current));
>  		force_sig(SIGBUS);
>  	}
> -
> -	return queued;
>  }
> =20
>  static void __ghes_print_estatus(const char *pfx,
> @@ -1113,9 +1137,7 @@ static void ghes_proc_in_irq(struct irq_work *irq_w=
ork)
>  	struct ghes_estatus_node *estatus_node;
>  	struct acpi_hest_generic *generic;
>  	struct acpi_hest_generic_status *estatus;
> -	bool task_work_pending;
>  	u32 len, node_len;
> -	int ret;
> =20
>  	llnode =3D llist_del_all(&ghes_estatus_llist);
>  	/*
> @@ -1130,25 +1152,16 @@ static void ghes_proc_in_irq(struct irq_work *irq=
_work)
>  		estatus =3D GHES_ESTATUS_FROM_NODE(estatus_node);
>  		len =3D cper_estatus_len(estatus);
>  		node_len =3D GHES_ESTATUS_NODE_LEN(len);
> -		task_work_pending =3D ghes_do_proc(estatus_node->ghes, estatus);
> +
> +		ghes_do_proc(estatus_node->ghes, estatus);
> +
>  		if (!ghes_estatus_cached(estatus)) {
>  			generic =3D estatus_node->generic;
>  			if (ghes_print_estatus(NULL, generic, estatus))
>  				ghes_estatus_cache_add(generic, estatus);
>  		}
> -
> -		if (task_work_pending && current->mm) {
> -			estatus_node->task_work.func =3D ghes_kick_task_work;
> -			estatus_node->task_work_cpu =3D smp_processor_id();
> -			ret =3D task_work_add(current, &estatus_node->task_work,
> -					    TWA_RESUME);
> -			if (ret)
> -				estatus_node->task_work.func =3D NULL;
> -		}
> -
> -		if (!estatus_node->task_work.func)
> -			gen_pool_free(ghes_estatus_pool,
> -				      (unsigned long)estatus_node, node_len);
> +		gen_pool_free(ghes_estatus_pool, (unsigned long)estatus_node,
> +			      node_len);
> =20
>  		llnode =3D next;
>  	}
> @@ -1209,7 +1222,6 @@ static int ghes_in_nmi_queue_one_entry(struct ghes =
*ghes,
> =20
>  	estatus_node->ghes =3D ghes;
>  	estatus_node->generic =3D ghes->generic;
> -	estatus_node->task_work.func =3D NULL;
>  	estatus =3D GHES_ESTATUS_FROM_NODE(estatus_node);
> =20
>  	if (__ghes_read_estatus(estatus, buf_paddr, fixmap_idx, len)) {
> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> index be1dd4c1a917..ebd21b05fe6e 100644
> --- a/include/acpi/ghes.h
> +++ b/include/acpi/ghes.h
> @@ -35,9 +35,6 @@ struct ghes_estatus_node {
>  	struct llist_node llnode;
>  	struct acpi_hest_generic *generic;
>  	struct ghes *ghes;
> -
> -	int task_work_cpu;
> -	struct callback_head task_work;
>  };
> =20
>  struct ghes_estatus_cache {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 6549d0979b28..f5f1d6a8a07d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3981,7 +3981,6 @@ enum mf_flags {
>  int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
>  		      unsigned long count, int mf_flags);
>  extern int memory_failure(unsigned long pfn, int flags);
> -extern void memory_failure_queue_kick(int cpu);
>  extern int unpoison_memory(unsigned long pfn);
>  extern atomic_long_t num_poisoned_pages __read_mostly;
>  extern int soft_offline_page(unsigned long pfn, int flags);
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index df26e2ff5e06..e369aae2da1f 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2486,19 +2486,6 @@ static void memory_failure_work_func(struct work_s=
truct *work)
>  	}
>  }
> =20
> -/*
> - * Process memory_failure work queued on the specified CPU.
> - * Used to avoid return-to-userspace racing with the memory_failure work=
queue.
> - */
> -void memory_failure_queue_kick(int cpu)
> -{
> -	struct memory_failure_cpu *mf_cpu;
> -
> -	mf_cpu =3D &per_cpu(memory_failure_cpu, cpu);
> -	cancel_work_sync(&mf_cpu->work);
> -	memory_failure_work_func(&mf_cpu->work);
> -}
> -
>  static int __init memory_failure_init(void)
>  {
>  	struct memory_failure_cpu *mf_cpu;


BR, Jarkko


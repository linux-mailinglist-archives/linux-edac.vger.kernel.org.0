Return-Path: <linux-edac+bounces-1619-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9009094886B
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 06:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA3A71C20D06
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 04:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F7C64A8F;
	Tue,  6 Aug 2024 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBsLc8CW"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78E5B663
	for <linux-edac@vger.kernel.org>; Tue,  6 Aug 2024 04:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919002; cv=none; b=beVTNIljx0BPFD/v0+OSYwMYAzLJXu/DEkLv+H/FjZXFo2KCg5gzYgh6hfRMrjf61vNQOtUd2gDRtdSNVf1d0I+Xcf2ehCBjE5yEp6Ua+I1FdioCKI5oxUtLygKiWLpiGLY7O/oLSj8sHBbbZk1NYcb5334kSlXsGFTLCYmbhsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919002; c=relaxed/simple;
	bh=AEC6gY1lKo7lrNwi6/dkJ8cvTL6jOqvIPqyEVQQrDUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cffEOaTkyeuRfZJn3fPIZQShVMQM/I7n7bDCYn5G+s75vYPfhJUEtBLqwaJa/6IkrOLJTWgWqqpZ5KtfNcIfFETKMjk8ecwZd6NKyoqUIhb6O7Y/2Bhtp1R5JWxvgfW733uykApuWC6X2WQLnXXCqXHep7eN5FyjU/7fp4+C4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBsLc8CW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731C8C32786;
	Tue,  6 Aug 2024 04:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722919001;
	bh=AEC6gY1lKo7lrNwi6/dkJ8cvTL6jOqvIPqyEVQQrDUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBsLc8CW+m0tUz3OdSq3ElblJGpvKJpg0Y976MuXFKdowsVtsZ0w9qRFiKTxHtcbf
	 XphFuYdd9VE5Svtg8qoWs9rq4AeVQ0W44dRNY4DrqgMol6icHhqGCbiL4o6C/8mQ3+
	 vcR2wj+laUp8DSotFyIGZ91cN4eq2PRgUR7uEEAYuQClFdFZu856IXhZh9Kvq9GrU7
	 BO1HBg+kRQnDihUO+cB7GTvQI0HQ/x5RfOYdEsWCZcVUmsdWbHubx03iITJcE5Xmz2
	 Vj7XqHrhdAPlsEwok/X6aGuNdtxwlXn1CuoctK8P+1x6m4kBcHmgaMWMb2VCx+ihu9
	 xX0HPxoh+w60A==
Date: Mon, 5 Aug 2024 21:36:40 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: linux-edac@vger.kernel.org, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org
Subject: Re: [RESEND][PATCH 1/3] x86: Add task_struct flag to force SIGBUS on
 MCE
Message-ID: <202408052135.342F9455@keescook>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723144752.1478226-1-andrew.zaborowski@intel.com>

On Tue, Jul 23, 2024 at 04:47:50PM +0200, Andrew Zaborowski wrote:
> Uncorrected memory errors for user pages are signaled to processes
> using SIGBUS or, if the error happens in a syscall, an error retval
> from the syscall.  The SIGBUS is documented in
> Documentation/mm/hwpoison.rst#failure-recovery-modes
> 
> But there are corner cases where we cannot or don't want to return a
> plain error from the syscall.  Subsequent commits covers two such cases:
> execve and rseq.  Current code, in both places, will kill the task with a
> SIGSEGV on error.  While not explicitly stated, it can be argued that it
> should be a SIGBUS, for consistency and for the benefit of the userspace
> signal handlers.  Even if the process cannot handle the signal, perhaps
> the parent process can.  This was the case in the scenario that
> motivated this patch.
> 
> In both cases, the architecture's exception handler (MCE handler on x86)
> will queue a call to memory_failure.  This doesn't work because the
> syscall-specific code sees the -EFAULT and terminates the task before
> the queued work runs.
> 
> To fix this: 1. let pending work run in the error cases in both places.
> 
> And 2. on MCE, ensure memory_failure() is passed MF_ACTION_REQUIRED so
> that the SIGBUS is queued.  Normally when the MCE is in a syscall,
> a fixup of return IP and a call to kill_me_never() are what we want.
> But in this case it's necessary to queue kill_me_maybe() which will set
> MF_ACTION_REQUIRED which is checked by memory_failure().
> 
> To do this the syscall code will set current->kill_on_efault, a new
> task_struct flag.  Check that flag in
> arch/x86/kernel/cpu/mce/core.c:do_machine_check()
> 
> Note: the flag is not x86 specific even if only x86 handling is being
> added here.  The definition could be guarded by #ifdef
> CONFIG_MEMORY_FAILURE, but it would then need set/clear utilities.
> 
> Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> ---
> Resending through an SMTP server that won't add the company footer.
> 
> This is a v2 of
> https://lore.kernel.org/linux-mm/20240501015340.3014724-1-andrew.zaborowski@intel.com/
> In the v1 the existing flag current->in_execve was being reused instead
> of adding a new one.  Kees Cook commented in
> https://lore.kernel.org/linux-mm/202405010915.465AF19@keescook/ that
> current->in_execve is going away.  Lacking a better idea and seeing
> that execve() and rseq() would benefit from using a common mechanism, I
> decided to add this new flag.
> 
> Perhaps with a better name current->kill_on_efault could replace
> brpm->point_of_no_return to offset the pain of having this extra flag.
> ---
>  arch/x86/kernel/cpu/mce/core.c | 18 +++++++++++++++++-

Since this touches arch/x86/, can an x86 maintainer review this? I can
carry this via the execve tree...

-Kees

>  include/linux/sched.h          |  2 ++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index ad0623b65..13f2ace3d 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1611,7 +1611,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  			if (p)
>  				SetPageHWPoison(p);
>  		}
> -	} else {
> +	} else if (!current->kill_on_efault) {
>  		/*
>  		 * Handle an MCE which has happened in kernel space but from
>  		 * which the kernel can recover: ex_has_fault_handler() has
> @@ -1628,6 +1628,22 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  
>  		if (m.kflags & MCE_IN_KERNEL_COPYIN)
>  			queue_task_work(&m, msg, kill_me_never);
> +	} else {
> +		/*
> +		 * Even with recovery code extra handling is required when
> +		 * we're not returning to userspace after error (e.g. in
> +		 * execve() beyond the point of no return) to ensure that
> +		 * a SIGBUS is delivered.
> +		 */
> +		if (m.kflags & MCE_IN_KERNEL_RECOV) {
> +			if (!fixup_exception(regs, X86_TRAP_MC, 0, 0))
> +				mce_panic("Failed kernel mode recovery", &m, msg);
> +		}
> +
> +		if (!mce_usable_address(&m))
> +			queue_task_work(&m, msg, kill_me_now);
> +		else
> +			queue_task_work(&m, msg, kill_me_maybe);
>  	}
>  
>  out:
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 61591ac6e..0cde1ba11 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -975,6 +975,8 @@ struct task_struct {
>  	/* delay due to memory thrashing */
>  	unsigned                        in_thrashing:1;
>  #endif
> +	/* Kill task on user memory access error */
> +	unsigned                        kill_on_efault:1;
>  
>  	unsigned long			atomic_flags; /* Flags requiring atomic access. */
>  
> -- 
> 2.43.0
> 

-- 
Kees Cook


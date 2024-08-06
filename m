Return-Path: <linux-edac+bounces-1620-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A2994886E
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 06:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E2AE280C16
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 04:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC276172769;
	Tue,  6 Aug 2024 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz3XIi2F"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7025B663
	for <linux-edac@vger.kernel.org>; Tue,  6 Aug 2024 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919069; cv=none; b=WKpGxQTE4paUEAAEpmza6K1bsul1h9t4Y+0gQwCZGa+Qi4KwkG9otmhTlULmJ3Bcymbjpyrxchkm6MJYpoMfRhIdZFViy1MYQ+DmIGIALqUdZir2nEty0ZyWwdD1R4JcvFyq20AT3G1Ay8TmUus17XZhrRHnoXQwx/AGAIXQ+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919069; c=relaxed/simple;
	bh=YpOpus8ftLD5mgDTpI/D5alidVClv/sUMv2NjE2OJaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfwQgqUOV2NoD9CXptfRUgM//UvYrNXb1s9EIus730nGPBkKzGnDWvmMxFA22hZ1PRrUI7+ftPHAq5Q4cELfx0qcpBNHRFCR4Rn7i6phWC8SSGi2EIkRXzSI9Qjp6anKgiK90G8o0C0H1yxDgkicCPrCasmkrARneNdJJ0uKY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz3XIi2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43167C32786;
	Tue,  6 Aug 2024 04:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722919069;
	bh=YpOpus8ftLD5mgDTpI/D5alidVClv/sUMv2NjE2OJaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wz3XIi2Fpjx9rs3oEP3S/dk0HrJAIHdF1SiIvFg6ACePhj721y0OZmVVqj/Ny0fYR
	 lZLsKYwyhsErJ2bwhP7GIs0MzZmdZfaN6KWk9SCDlhLuWiEAJfB2y55aGrlxVbGd2s
	 4Jw8xxxB4w9P6HvcwNZ9U4FgFClSOKBWadJ4I9j3UOf/Z1ndqUL7a1fFoURrgFZf/e
	 kSeGeU0ertdIm5kiMJLmsnb+Np+ZTyGlryDuyOpq6+e4bkNRIGd/xksm2J9AFu+cLa
	 xz3dEsiG+bCEuB2HZOEy9Y38pDhcJIBsYbmUEOz3YH0CSLfia5Kbcw6KKZHcwaU6Q5
	 TZKelmhettuUA==
Date: Mon, 5 Aug 2024 21:37:48 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: linux-edac@vger.kernel.org, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RESEND][PATCH 3/3] rseq: Ensure SIGBUS delivered on memory
 failure
Message-ID: <202408052136.119CD53B@keescook>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <20240723144752.1478226-3-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723144752.1478226-3-andrew.zaborowski@intel.com>

On Tue, Jul 23, 2024 at 04:47:52PM +0200, Andrew Zaborowski wrote:
> Uncorrected memory errors for user pages are signaled to processes
> using SIGBUS or, if the error happens in a syscall, an error retval
> from the syscall.  The SIGBUS is documented in
> Documentation/mm/hwpoison.rst#failure-recovery-modes
> 
> Once a user task sets t->rseq in the rseq() syscall, if the kernel
> cannot access the memory pointed to by t->rseq->rseq_cs, that initial
> rseq() and all future syscalls should return an error so understandably
> the code just kills the task.
> 
> To ensure that SIGBUS is used set the new t->kill_on_efault flag and
> run queued task work on rseq_get_rseq_cs() errors to give memory_failure
> the chance to run.
> 
> Note: the rseq checks run inside resume_user_mode_work() so whenever
> _TIF_NOTIFY_RESUME is set.  They do not run on every syscall exit so
> I'm not concerned that these extra flag operations are in a hot path,
> except with CONFIG_DEBUG_RSEQ.
> 
> Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> ---
>  kernel/rseq.c | 25 +++++++++++++++++++++----

Can an rseq maintainer please review this? I can carry it via the execve
tree with the related patches...

-Kees

>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/rseq.c b/kernel/rseq.c
> index 9de6e35fe..c5809cd13 100644
> --- a/kernel/rseq.c
> +++ b/kernel/rseq.c
> @@ -13,6 +13,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/rseq.h>
>  #include <linux/types.h>
> +#include <linux/task_work.h>
>  #include <asm/ptrace.h>
>  
>  #define CREATE_TRACE_POINTS
> @@ -320,6 +321,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  	if (unlikely(t->flags & PF_EXITING))
>  		return;
>  
> +	t->kill_on_efault = true;
> +
>  	/*
>  	 * regs is NULL if and only if the caller is in a syscall path.  Skip
>  	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> @@ -330,13 +333,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
>  		if (unlikely(ret < 0))
>  			goto error;
>  	}
> -	if (unlikely(rseq_update_cpu_node_id(t)))
> -		goto error;
> -	return;
> +	if (likely(!rseq_update_cpu_node_id(t)))
> +		goto out;
>  
>  error:
> +	/* Allow task work to override signr */
> +	task_work_run();
> +
>  	sig = ksig ? ksig->sig : 0;
>  	force_sigsegv(sig);
> +
> +out:
> +	t->kill_on_efault = false;
>  }
>  
>  #ifdef CONFIG_DEBUG_RSEQ
> @@ -353,8 +361,17 @@ void rseq_syscall(struct pt_regs *regs)
>  
>  	if (!t->rseq)
>  		return;
> -	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> +
> +	t->kill_on_efault = true;
> +
> +	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs)) {
> +		/* Allow task work to override signr */
> +		task_work_run();
> +
>  		force_sig(SIGSEGV);
> +	}
> +
> +	t->kill_on_efault = false;
>  }
>  
>  #endif
> -- 
> 2.43.0
> 

-- 
Kees Cook


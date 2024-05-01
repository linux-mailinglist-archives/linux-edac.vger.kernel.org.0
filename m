Return-Path: <linux-edac+bounces-989-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E860F8B8E18
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 18:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E52E282D18
	for <lists+linux-edac@lfdr.de>; Wed,  1 May 2024 16:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F6D134738;
	Wed,  1 May 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mpWibqXq"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74480133423
	for <linux-edac@vger.kernel.org>; Wed,  1 May 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580400; cv=none; b=s4HHIPVMbKBH4UJf90aur6OpZ0FgHJOinibEihDiRzxANLaUxA0LwSxpYt2eYld+Vm9Fnpa11Fd8G3643Tp8ptdU5spiMDhgUwoCsfnFsL1kHLJWrATjz9Vsc9sdJ7qTvnYfh1hLesCHxDMVJUhs7ZCxwTSx/lkbT/F2hiai/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580400; c=relaxed/simple;
	bh=KydANpyozt8SZCkZmDnabF4LufTaGOvNqYVN0EA2z/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFn/NnoLERZ2JOotTc9swGGG+chq3+nANYwHysE+7x6b5Zg1GI8TXbDc4tZZWZ6Iwo6PeIIQskAaFDXDkGhb2mAjnvvjrWaX0tX+QCigA9BnPh/cfMHGqy+0wmKY6w6f6oarX6lWMy+CPajQrmovuDT4WuMPnQSnxpTvPRBS71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=mpWibqXq; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a484f772e2so4669510a91.3
        for <linux-edac@vger.kernel.org>; Wed, 01 May 2024 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714580399; x=1715185199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLWObZ5roRvvXm2wJ4/mDw5Zfbke5H6gp1bKXRqe/6U=;
        b=mpWibqXqPAU/NLBWn+DWi+otpJD4dIxPOmPRyT/5kY7cFbZscYk4yOecB7mc/gijhg
         jLmRfdGj+M8K4pRVZr6HpFApy4tCFsacR6XT0aDLvUn6NP4VTwBZRNMBmp6Z08ahBhc/
         JIc95dU7W5MUgm97V9P3mZBKP8p+/+ea93UWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714580399; x=1715185199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLWObZ5roRvvXm2wJ4/mDw5Zfbke5H6gp1bKXRqe/6U=;
        b=onTX72sfdd6CfthWUHr/KOio1PTlYkB6ClRXH32gSPMP5Dc8FXvS8kkuO6az+nsF/A
         7Na1+b+frYbfEJinGzW6OceYchbX0LaJ+mpvOmqf0Qqf2Kh4sl85c371nndY4BbQ2PoX
         OoKrrw2Nlvi7M+Guj+p67ybBsk+R7vc4RzcuAoCByhNGxtbwxVA0LhgGa4cDOeVX9XEa
         2XvBmqNxI/g9QKlsONrJy3dgFwHQzTH/FEi59LzqrnnfNc/Kp+98WpZxW8jV/ItdQhxa
         qkSNWaDPPLNP+Qu5bMqvWEd7F2f+FSEnFB/1Y2bJshF2aMuhb8xOYUyRzLoSuBUbgfBU
         iq2Q==
X-Gm-Message-State: AOJu0Yy8A7iwbzgeodio9XY0wQ+jvPsYLIsQMah0CRDzpDCKcQxkkLY1
	mPNDXTC7RSS48plyjSwW6YHDO+st/di4naRYYcnPgmSxqBhMQENnz2hg+rMgyg==
X-Google-Smtp-Source: AGHT+IEHnYrLD6qYg1tPs21yTAG1nt/uGMqoBK+Ct7XcTlsInPqYvVnKh+a+qhzqWJH1d0IGV5dTNw==
X-Received: by 2002:a17:90b:3ece:b0:2b2:c406:7d8d with SMTP id rm14-20020a17090b3ece00b002b2c4067d8dmr2934938pjb.16.1714580398579;
        Wed, 01 May 2024 09:19:58 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 192-20020a6301c9000000b0060795a08227sm12291552pgb.37.2024.05.01.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 09:19:58 -0700 (PDT)
Date: Wed, 1 May 2024 09:19:57 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: linux-edac@vger.kernel.org, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH][RFC] exec: x86: Ensure SIGBUS delivered on MCE
Message-ID: <202405010915.465AF19@keescook>
References: <20240501015340.3014724-1-andrew.zaborowski@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501015340.3014724-1-andrew.zaborowski@intel.com>

On Wed, May 01, 2024 at 03:53:40AM +0200, Andrew Zaborowski wrote:
> Uncorrected memory errors are signaled to processes using SIGBUS or an
> error retval from a syscall.  But there's a corner cases in execve where
> a SIGSEGV will be delivered.  Specifically this will happen if the binary
> loader triggers a memory error reading user pages.  The architecture's
> handler (MCE handler on x86) may queue a call to memory_failure but that
> won't run until the execve() returns.  The binary loader is called after
> bprm->point_of_no_return is set meaning that any error is handled by
> bprm_execve() with a SIGSEGV to the process.

Why is it needed to have a distinction between SIGBUS and SIGSEGV in
this case?

> To ensure it is terminated with a SIGBUS we 1. let pending work run in
> the bprm_execve error case.
> 
> And 2. ensure memory_failure() is passed MF_ACTION_REQUIRED so that the
> SIGBUS is queued.  Normally when the MCE is in a syscall, a fixup of
> return IP and a call to kill_me_never are enough.  But in this case
> it's necessary to queue kill_me_maybe() which will set
> MF_ACTION_REQUIRED.
> 
> Reuse current->in_execve to make the decision.

We're actually in the process of trying to remove[1] this flag, so I'd
like to avoid adding new users of it. It sounds like it's desirable here
because a choice is needed about kill_me_never() vs kill_me_maybe()?

-Kees

[1] https://lore.kernel.org/lkml/8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp/

> 
> Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c | 14 ++++++++++++++
>  fs/exec.c                      | 12 +++++++++---
>  include/linux/sched.h          |  2 +-
>  3 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 84d41be6d06b..11effdff942c 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1593,6 +1593,20 @@ noinstr void do_machine_check(struct pt_regs *regs)
>  		else
>  			queue_task_work(&m, msg, kill_me_maybe);
>  
> +	} else if (current->in_execve) {
> +		/*
> +		 * Cannot recover a task in execve() beyond point of no
> +		 * return but stop further user memory accesses.
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
>  	} else {
>  		/*
>  		 * Handle an MCE which has happened in kernel space but from
> diff --git a/fs/exec.c b/fs/exec.c
> index cf1df7f16e55..1bea9c252a11 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -67,6 +67,7 @@
>  #include <linux/time_namespace.h>
>  #include <linux/user_events.h>
>  #include <linux/rseq.h>
> +#include <linux/task_work.h>
>  
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -1888,10 +1889,15 @@ static int bprm_execve(struct linux_binprm *bprm)
>  	 * If past the point of no return ensure the code never
>  	 * returns to the userspace process.  Use an existing fatal
>  	 * signal if present otherwise terminate the process with
> -	 * SIGSEGV.
> +	 * SIGSEGV.  Run pending work before that in case it is
> +	 * terminating the process with a different signal.
>  	 */
> -	if (bprm->point_of_no_return && !fatal_signal_pending(current))
> -		force_fatal_sig(SIGSEGV);
> +	if (bprm->point_of_no_return) {
> +		task_work_run();
> +
> +		if (!fatal_signal_pending(current))
> +			force_fatal_sig(SIGSEGV);
> +	}
>  
>  	sched_mm_cid_after_execve(current);
>  	current->fs->in_exec = 0;
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 3c2abbc587b4..8970a191d8fe 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -922,7 +922,7 @@ struct task_struct {
>  	unsigned			sched_rt_mutex:1;
>  #endif
>  
> -	/* Bit to tell TOMOYO we're in execve(): */
> +	/* Bit to tell TOMOYO and x86 MCE code we're in execve(): */
>  	unsigned			in_execve:1;
>  	unsigned			in_iowait:1;
>  #ifndef TIF_RESTORE_SIGMASK
> -- 
> 2.39.3
> 

-- 
Kees Cook


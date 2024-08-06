Return-Path: <linux-edac+bounces-1621-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4D0948A9A
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 09:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 071E8280C5B
	for <lists+linux-edac@lfdr.de>; Tue,  6 Aug 2024 07:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4DA161310;
	Tue,  6 Aug 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FUIzBhdM"
X-Original-To: linux-edac@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748A542AA0
	for <linux-edac@vger.kernel.org>; Tue,  6 Aug 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930723; cv=none; b=u6eiImhIj7Zpt8ndVK+SNF93896c9Jnp0zJ562HWjPbr3d4KsRAku/Pd+pzFhrgHPrFWpvANJ+rnSEsKWRnr8k76k2PoRs+885/vdrIpOF+UU784ui4b+rxZ1TGCwd2ANGcT2s++swumV/eJ9687pRy+BmBdZRlus0MIBEzmNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930723; c=relaxed/simple;
	bh=OUZoURzjjzzOIlHyLDNaPc2Hm4egpnW2xZVHS42c5Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8CL4WlOS+p0gLc8xwD0nCYhT6RdurbB+7ZRKwZVjEeTNC0iqhNygQc3WkVtyREmnDMKYPM29CXO69TmkvF92QjXbYmJSyzCzbfYMb3619N9mwQfIe+YhKvlee9XvVyQeWI3RLkrIbgfy4arg1OzN4cBBqQwVpTmC/1SkXZQrLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FUIzBhdM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mScFChza4Xuu9BVBPiQYDEHuyj8H5oe5eSPQdjI0NHE=; b=FUIzBhdMu+Kx6ooAgTBhhaHRXE
	c04XsK6uUJ9CSBZlv8QcLHnyqbOx1Goa5LcbQhm2CQI3COldGEhJjd5sOpkwvLcNByRRwnDCcVXU1
	oIA9DyepUyEUhQ28kNGlycN4C2nTe5837hIj7PpGJ4rdESvdYiSqfE4tETdisQgUlpmAe30VqhVVg
	vjU7HGq5Hjp/lpd0z1cjh20SxrdvmGfztZe9BOLGWGSqxV0V/AkQQ04nBir+NtBs26uRAU/gjA4kl
	Y2/BTMhX3H8q1vgbCW3WGRSmoEwIHoGxHkesCf1FHEJ5+d8URszlNmGcXnWrfh73shIlZ7A8hb6Lk
	tD/qoCcw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbEyx-00000005Oqq-2F2c;
	Tue, 06 Aug 2024 07:51:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8BDA930049D; Tue,  6 Aug 2024 09:51:46 +0200 (CEST)
Date: Tue, 6 Aug 2024 09:51:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Zaborowski <andrew.zaborowski@intel.com>,
	linux-edac@vger.kernel.org, linux-mm@kvack.org,
	Tony Luck <tony.luck@intel.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Borislav Petkov <bp@alien8.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, oleg@redhat.com
Subject: Re: [RESEND][PATCH 3/3] rseq: Ensure SIGBUS delivered on memory
 failure
Message-ID: <20240806075146.GQ39708@noisy.programming.kicks-ass.net>
References: <20240723144752.1478226-1-andrew.zaborowski@intel.com>
 <20240723144752.1478226-3-andrew.zaborowski@intel.com>
 <202408052136.119CD53B@keescook>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202408052136.119CD53B@keescook>

On Mon, Aug 05, 2024 at 09:37:48PM -0700, Kees Cook wrote:
> On Tue, Jul 23, 2024 at 04:47:52PM +0200, Andrew Zaborowski wrote:
> > Uncorrected memory errors for user pages are signaled to processes
> > using SIGBUS or, if the error happens in a syscall, an error retval
> > from the syscall.  The SIGBUS is documented in
> > Documentation/mm/hwpoison.rst#failure-recovery-modes
> > 
> > Once a user task sets t->rseq in the rseq() syscall, if the kernel
> > cannot access the memory pointed to by t->rseq->rseq_cs, that initial
> > rseq() and all future syscalls should return an error so understandably
> > the code just kills the task.
> > 
> > To ensure that SIGBUS is used set the new t->kill_on_efault flag and
> > run queued task work on rseq_get_rseq_cs() errors to give memory_failure
> > the chance to run.
> > 
> > Note: the rseq checks run inside resume_user_mode_work() so whenever
> > _TIF_NOTIFY_RESUME is set.  They do not run on every syscall exit so
> > I'm not concerned that these extra flag operations are in a hot path,
> > except with CONFIG_DEBUG_RSEQ.
> > 
> > Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
> > ---
> >  kernel/rseq.c | 25 +++++++++++++++++++++----
> 
> Can an rseq maintainer please review this? I can carry it via the execve
> tree with the related patches...

*sigh*,.. because get_maintainers just doesn't work or something?

Anyway, I'm confused by the signal code (as always), why isn't the
task_work_run() in get_signal() sufficient?

At some point we're going to run into trouble with sprinkling
task_work_run() around willy nilly :/

> 
> >  1 file changed, 21 insertions(+), 4 deletions(-)
> > 
> > diff --git a/kernel/rseq.c b/kernel/rseq.c
> > index 9de6e35fe..c5809cd13 100644
> > --- a/kernel/rseq.c
> > +++ b/kernel/rseq.c
> > @@ -13,6 +13,7 @@
> >  #include <linux/syscalls.h>
> >  #include <linux/rseq.h>
> >  #include <linux/types.h>
> > +#include <linux/task_work.h>
> >  #include <asm/ptrace.h>
> >  
> >  #define CREATE_TRACE_POINTS
> > @@ -320,6 +321,8 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >  	if (unlikely(t->flags & PF_EXITING))
> >  		return;
> >  
> > +	t->kill_on_efault = true;
> > +
> >  	/*
> >  	 * regs is NULL if and only if the caller is in a syscall path.  Skip
> >  	 * fixup and leave rseq_cs as is so that rseq_sycall() will detect and
> > @@ -330,13 +333,18 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
> >  		if (unlikely(ret < 0))
> >  			goto error;
> >  	}
> > -	if (unlikely(rseq_update_cpu_node_id(t)))
> > -		goto error;
> > -	return;
> > +	if (likely(!rseq_update_cpu_node_id(t)))
> > +		goto out;
> >  
> >  error:
> > +	/* Allow task work to override signr */
> > +	task_work_run();
> > +
> >  	sig = ksig ? ksig->sig : 0;
> >  	force_sigsegv(sig);
> > +
> > +out:
> > +	t->kill_on_efault = false;
> >  }
> >  
> >  #ifdef CONFIG_DEBUG_RSEQ
> > @@ -353,8 +361,17 @@ void rseq_syscall(struct pt_regs *regs)
> >  
> >  	if (!t->rseq)
> >  		return;
> > -	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
> > +
> > +	t->kill_on_efault = true;
> > +
> > +	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs)) {
> > +		/* Allow task work to override signr */
> > +		task_work_run();
> > +
> >  		force_sig(SIGSEGV);
> > +	}
> > +
> > +	t->kill_on_efault = false;
> >  }
> >  
> >  #endif
> > -- 
> > 2.43.0
> > 
> 
> -- 
> Kees Cook


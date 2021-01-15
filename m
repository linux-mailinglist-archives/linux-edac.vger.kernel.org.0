Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5D2F7F82
	for <lists+linux-edac@lfdr.de>; Fri, 15 Jan 2021 16:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbhAOP2l (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jan 2021 10:28:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40588 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729116AbhAOP2k (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 15 Jan 2021 10:28:40 -0500
Received: from zn.tnic (p200300ec2f0acf00d1d88af93a38b68f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:cf00:d1d8:8af9:3a38:b68f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0A1561EC0253;
        Fri, 15 Jan 2021 16:27:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610724479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/UHXUR5eCzgC6qnSSG+fMjiOWrrQoVMo0QLlYLKvhZE=;
        b=d6lM4sf9U/uQHSIdYXkxEV5PlzOzSSbhpO6qj6aUvv0deQ9rCuXdbjidHuIz2R4FjOaC4t
        IA7RW4YgzFjBVitmCxoIoWJIbNznTeAYt1vgf6epN1VF0WIXJ/XC6hJLw27vLCRUgdLLlt
        E1+aB2+4ySOWgIfTVgI/hR5fybk1tp0=
Date:   Fri, 15 Jan 2021 16:27:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210115152754.GC9138@zn.tnic>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115003817.23657-1-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Jan 14, 2021 at 04:38:17PM -0800, Tony Luck wrote:
> Recovery action when get_user() triggers a machine check uses the fixup
> path to make get_user() return -EFAULT.  Also queue_task_work() sets up
> so that kill_me_maybe() will be called on return to user mode to send a
> SIGBUS to the current process.
> 
> But there are places in the kernel where the code assumes that this
> EFAULT return was simply because of a page fault. The code takes some
> action to fix that, and then retries the access. This results in a second
> machine check.
> 
> While processing this second machine check queue_task_work() is called
> again. But since this uses the same callback_head structure that
> was used in the first call, the net result is an entry on the
> current->task_works list that points to itself. When task_work_run()
> is called it loops forever in this code:
> 
> 		do {
> 			next = work->next;
> 			work->func(work);
> 			work = next;
> 			cond_resched();
> 		} while (work);
> 
> Add a "mce_busy" counter so that task_work_add() is only called once
> per faulty page in this task.

Yeah, that sentence can be removed now too.

> Do not allow too many repeated machine checks, or machine checks to
> a different page from the first.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> V3: Thanks to extensive commentary from Andy & Boris
> 
> Throws out the changes to get_user() and subsequent changes to core
> code. Everything is now handled in the machine check code. Downside is
> that we can (and do) take multiple machine checks from a single poisoned
> page before generic kernel code finally gets the message that a page is
> really and truly gone (but all the failed get_user() calls still return
> the legacy -EFAULT code, so none of that code will ever mistakenly use
> a value from a bad page). But even on an old machine that does broadcast
> interrupts for each machine check things survive multiple cycles of my
> test injection into a futex operation.

Nice.

> 
> I picked "10" as the magic upper limit for how many times the machine
> check code will allow a fault from the same page before deciding to
> panic.  We can bike shed that value if you like.
> 
>  arch/x86/kernel/cpu/mce/core.c | 27 ++++++++++++++++++++-------
>  include/linux/sched.h          |  1 +
>  2 files changed, 21 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 13d3f1cbda17..25daf6517dc9 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -1246,6 +1246,7 @@ static void kill_me_maybe(struct callback_head *cb)
>  	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
>  	int flags = MF_ACTION_REQUIRED;
>  
> +	p->mce_count = 0;
>  	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
>  
>  	if (!p->mce_ripv)
> @@ -1266,12 +1267,24 @@ static void kill_me_maybe(struct callback_head *cb)
>  	}
>  }
>  
> -static void queue_task_work(struct mce *m, int kill_current_task)
> +static void queue_task_work(struct mce *m, char *msg, int kill_current_task)

So this function gets called in the user mode MCE case too:

	if ((m.cs & 3) == 3) {

		queue_task_work(&m, msg, kill_current_task);
	}

Do we want to panic for multiple MCEs to different addresses in user
mode?

I don't think so - that should go down the memory failure page
offlining path...

> -	current->mce_addr = m->addr;
> -	current->mce_kflags = m->kflags;
> -	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> -	current->mce_whole_page = whole_page(m);
> +	if (current->mce_count++ == 0) {
> +		current->mce_addr = m->addr;
> +		current->mce_kflags = m->kflags;
> +		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> +		current->mce_whole_page = whole_page(m);
> +	}
> +

	/* Magic number should be large enough */

> +	if (current->mce_count > 10)
> +		mce_panic("Too many machine checks while accessing user data", m, msg);
> +
> +	if (current->mce_count > 1 || (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> +		mce_panic("Machine checks to different user pages", m, msg);

Will this second part of the test expression, after the "||" ever hit?

You do above in the first branch:

	if (current->mce_count++ == 0) {

		...

		current->mce_addr = m->addr;

and ->mce_count becomes 1.

In that case that

	(current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT)

gets tested but that won't ever be true because ->mce_addr = ->addr
above.

And then, for other values of mce_count, mce_count > 1 will hit.

In any case, what are you trying to catch with this? Two get_user() to
different pages both catching MCEs?

> +
> +	/* Do not call task_work_add() more than once */
> +	if (current->mce_count > 1)
> +		return;

That won't happen either, AFAICT. It'll panic above.

Regardless, I like how this is all confined to the MCE code and there's
no need to touch stuff outside...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8920305D08
	for <lists+linux-edac@lfdr.de>; Wed, 27 Jan 2021 14:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbhA0NYk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 27 Jan 2021 08:24:40 -0500
Received: from mga07.intel.com ([134.134.136.100]:6567 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S313572AbhAZWg5 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 26 Jan 2021 17:36:57 -0500
IronPort-SDR: jJY6t0cBRoflIqhDjTtW2TTCEcNgL9tKCLL3pEkbjkuKDiLFULG8Z+OtNeuucxW0B8jPXpKZ6+
 pkb9z1buGk5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="244061126"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="244061126"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 14:36:07 -0800
IronPort-SDR: ntLRWFScXw4JrK88VX4h8u9fF93qP3ZixkZMrT4BFbEk0zfvh5qocUC/rsR5vLT73QIMLY+uIM
 Pbo/qvMjWrUA==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="472913413"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 14:36:06 -0800
Date:   Tue, 26 Jan 2021 14:36:05 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v5] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210126223605.GA14355@agluck-desk2.amr.corp.intel.com>
References: <20210115152754.GC9138@zn.tnic>
 <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
 <20210115205103.GA5920@agluck-desk2.amr.corp.intel.com>
 <20210115232346.GA7967@agluck-desk2.amr.corp.intel.com>
 <20210119105632.GF27433@zn.tnic>
 <20210119235759.GA9970@agluck-desk2.amr.corp.intel.com>
 <20210120121812.GF825@zn.tnic>
 <20210121210959.GA10304@agluck-desk2.amr.corp.intel.com>
 <20210125225509.GA7149@agluck-desk2.amr.corp.intel.com>
 <20210126110314.GC6514@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126110314.GC6514@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 26, 2021 at 12:03:14PM +0100, Borislav Petkov wrote:
> On Mon, Jan 25, 2021 at 02:55:09PM -0800, Luck, Tony wrote:
> > And now I've changed it back to non-atomic (but keeping the
> > slightly cleaner looking code style that I used for the atomic
> > version).  This one also works for thousands of injections and
> > recoveries.  Maybe take it now before it stops working again :-)
> 
> Hmm, so the only differences I see between your v4 and this are:
> 
> -@@ -1238,6 +1238,7 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
> +@@ -1238,6 +1238,9 @@ static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *fin
>   
>   static void kill_me_now(struct callback_head *ch)
>   {
> ++	struct task_struct *p = container_of(ch, struct task_struct, mce_kill_me);
> ++
>  +	p->mce_count = 0;
>   	force_sig(SIGBUS);
>   }
> 
> Could the container_of() macro have changed something?

That change was to fix my brown paper bag moment (does not
compile without a variable named "p" in scope to be used on
next line.)

> Because we don't know yet (right?) why would it fail? Would it read
> stale ->mce_count data? If so, then a barrier is missing somewhere.

I don't see how a barrier would make a differece. In the common case
all this code is executed on the same logical CPU. Return from the
do_machine_check() tries to return to user mode and finds that there
is some "task_work" to execute first.

In some cases Linux might context switch to something else. Perhaps
this task even gets picked up by another CPU to run the task work
queued functions.  But I imagine that the context switch should act
as a barrier ... shouldn't it?

> Or what is the failure exactly?

After a few cycles of the test injection to user mode, I saw an
overflow in the machine check bank. As if it hadn't been cleared
from the previous iteration ... but all the banks are cleared as
soon as we find that the machine check is recoverable. A while before
getting to the code I changed.

When the tests were failing, code was on top of v5.11-rc3. Latest
experiments moved to -rc5.  There's just a tracing fix from
PeterZ between rc3 and rc5 to mce/core.c:

737495361d44 ("x86/mce: Remove explicit/superfluous tracing")

which doesn't appear to be a candidate for the problems I saw.

> Because if I take it now without us knowing what the issue is, it will
> start failing somewhere - Murphy's our friend - and then we'll have to
> deal with breaking people's boxes. Not fun.

Fair point.

> The other difference is:
> 
> @@ -76,8 +71,10 @@ index 13d3f1cbda17..5460c146edb5 100644
>  -	current->mce_kflags = m->kflags;
>  -	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
>  -	current->mce_whole_page = whole_page(m);
> ++	int count = ++current->mce_count;
> ++
>  +	/* First call, save all the details */
> -+	if (current->mce_count++ == 0) {
> ++	if (count == 1) {
>  +		current->mce_addr = m->addr;
>  +		current->mce_kflags = m->kflags;
>  +		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> 
> Hmm, a local variable and a pre-increment. Can that have an effect somehow?

This is the bit that changed during my detour using atomic_t mce_count.
I added the local variable to capture value from atomic_inc_return(), then
used it later, instead of a bunch of atomic_read() calls.

I kept it this way because "if (count == 1)" is marginally easier to read
than "if (current->mce_count++ == 0)"

> > +	/* Ten is likley overkill. Don't expect more than two faults before task_work() */
> 
> Typo: likely.

Oops. Fixed.

-Tony

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A38E2F8598
	for <lists+linux-edac@lfdr.de>; Fri, 15 Jan 2021 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733067AbhAOTg3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 15 Jan 2021 14:36:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:5631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388322AbhAOTfU (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 15 Jan 2021 14:35:20 -0500
IronPort-SDR: ADoGxpc7mu6MAsV17pcupeYsBvzhr+9DVR9aJn2hKWKOmtDuY9Lf/mnyYpc24Yji41GmAog7fJ
 skjBGgXb4nhw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="158371998"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="158371998"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:34:39 -0800
IronPort-SDR: wWXQ7MO+mgxgE99JSEkjBJfSr0qsLFYjESrO72XEEJcZb7rLyXW4VnDC30+PB/kgls2RdnrfYx
 slPkiWM38T/w==
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="354414793"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 11:34:38 -0800
Date:   Fri, 15 Jan 2021 11:34:35 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210115193435.GA4663@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-1-tony.luck@intel.com>
 <20210115003817.23657-1-tony.luck@intel.com>
 <20210115152754.GC9138@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115152754.GC9138@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 15, 2021 at 04:27:54PM +0100, Borislav Petkov wrote:
> On Thu, Jan 14, 2021 at 04:38:17PM -0800, Tony Luck wrote:
> > Add a "mce_busy" counter so that task_work_add() is only called once
> > per faulty page in this task.
> 
> Yeah, that sentence can be removed now too.

I will update with new name "mce_count" and some details.

> > -static void queue_task_work(struct mce *m, int kill_current_task)
> > +static void queue_task_work(struct mce *m, char *msg, int kill_current_task)
> 
> So this function gets called in the user mode MCE case too:
> 
> 	if ((m.cs & 3) == 3) {
> 
> 		queue_task_work(&m, msg, kill_current_task);
> 	}
> 
> Do we want to panic for multiple MCEs to different addresses in user
> mode?

In the user mode case we should only bump mce_count to "1" and
before task_work() gets called. It shouldn't hurt to do the
same checks. Maybe it will catch something weird - like an NMI
handler on return from the machine check doing a get_user() that
hits another machine check during the return from this machine check.

AndyL has made me extra paranoid. :-)

> > -	current->mce_addr = m->addr;
> > -	current->mce_kflags = m->kflags;
> > -	current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> > -	current->mce_whole_page = whole_page(m);
> > +	if (current->mce_count++ == 0) {
> > +		current->mce_addr = m->addr;
> > +		current->mce_kflags = m->kflags;
> > +		current->mce_ripv = !!(m->mcgstatus & MCG_STATUS_RIPV);
> > +		current->mce_whole_page = whole_page(m);
> > +	}
> > +
> 
> 	/* Magic number should be large enough */
>
> > +	if (current->mce_count > 10)

Will add similar comment here ... and to other tests in this function
since it may not be obvious to me next year what I was thinking now :-)

> > +	if (current->mce_count > 10)
> > +		mce_panic("Too many machine checks while accessing user data", m, msg);
> > +
> > +	if (current->mce_count > 1 || (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> > +		mce_panic("Machine checks to different user pages", m, msg);
> 
> Will this second part of the test expression, after the "||" ever hit?

No :-( This code is wrong. Should be "&&" not "||". Then it makes more sense.
Will fix for v4.

> In any case, what are you trying to catch with this? Two get_user() to
> different pages both catching MCEs?

Yes. Trying to catch two accesses to different pages. Need to do this
because kill_me_maybe() is only going to offline one page.

I'm not expecting that this would ever hit.  It means that calling code
took a machine check on one page and get_user() said -EFAULT. The the
code decided to access a different page *and* that other page also triggered
a machine check.

> > +	/* Do not call task_work_add() more than once */
> > +	if (current->mce_count > 1)
> > +		return;
> 
> That won't happen either, AFAICT. It'll panic above.

With the s/||/&&/ above, we can get here.
> 
> Regardless, I like how this is all confined to the MCE code and there's
> no need to touch stuff outside...

Thanks for the review.

-Tony

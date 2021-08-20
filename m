Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6124F3F342A
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 20:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhHTTAY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 15:00:24 -0400
Received: from mga05.intel.com ([192.55.52.43]:25540 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHTTAY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 15:00:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="302414859"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="302414859"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:59:46 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="533086069"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:59:46 -0700
Date:   Fri, 20 Aug 2021 11:59:45 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR/m/8PCmCTbogey@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 07:31:43PM +0200, Borislav Petkov wrote:
> On Tue, Aug 17, 2021 at 05:29:40PM -0700, Tony Luck wrote:
> > +	/* Ten is likley overkill. Don't expect more than two faults before task_work() */
> 
> "likely"

Oops.

> 
> > +	if (count > 10)
> > +		mce_panic("Too many machine checks while accessing user data", m, msg);
> 
> Ok, aren't we too nasty here? Why should we panic the whole box even
> with 10 MCEs? It is still user memory...
> 
> IOW, why not:
> 
> 	if (count > 10)
> 		current->mce_kill_me.func = kill_me_now;
> 
> and when we return, that user process dies immediately.

It's the "when we return" part that is the problem here. Logical
trace looks like:

user-syscall:

	kernel does get_user() or copyin(), hits user poison address

		machine check
		sees that this was kernel get_user()/copyin() and
		uses extable to "return" to exception path

	still in kernel, see that get_user() or copyin() failed

	Kernel does another get_user() or copyin() (maybe the first
	was inside a pagefault_disable() region, and kernel is trying
	again to see if the error was a fixable page fault. But that
	wasn't the problem so ...

		machine check
		sees that this was kernel get_user()/copyin() and
		uses extable to "return" to exception path

	still in kernel ... but persistently thinks that just trying again
	might fix it.

		machine check
		sees that this was kernel get_user()/copyin() and
		uses extable to "return" to exception path

	still in kernel ... this time for sure! get_user()

		machine check
		sees that this was kernel get_user()/copyin() and
		uses extable to "return" to exception path

	still in kernel ... but you may see the pattern get_user()

		machine check
		sees that this was kernel get_user()/copyin() and
		uses extable to "return" to exception path

	I'm bored typing this, but the kernel may not ever give up

		machine check
		sees that this was kernel get_user()/copyin() and
		uses extable to "return" to exception path

I.e. the kernel doesn't ever get to call current->mce_kill_me.func()

I do have tests that show as many as 4 consecutive machine checks
before the kernel gives up trying and returns to the user to complete
recovery.

Maybe the message could be clearer?

	mce_panic("Too many consecutive machine checks in kernel while accessing user data", m, msg);

> 
> > +	/* Second or later call, make sure page address matches the one from first call */
> > +	if (count > 1 && (current->mce_addr >> PAGE_SHIFT) != (m->addr >> PAGE_SHIFT))
> > +		mce_panic("Machine checks to different user pages", m, msg);
> 
> Same question here.

Not quite the same answer ... but similar.  We could in theory handle
multiple different machine check addresses by turning the "mce_addr"
field in the task structure into an array and saving each address so
that when the kernel eventually gives up poking at poison and tries
to return to user kill_me_maybe() could loop through them and deal
with each poison page.

I don't think this can happen. Jue Wang suggested that multiple poisoned
pages passed to a single write(2) syscall might trigger this panic (and
because of a bug in my earlier version, he managed to trigger this
"different user pages" panic). But this fixed up version survives the
"Jue test".

-Tony

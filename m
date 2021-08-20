Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D033F352B
	for <lists+linux-edac@lfdr.de>; Fri, 20 Aug 2021 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhHTUY0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 20 Aug 2021 16:24:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:9174 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230266AbhHTUY0 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 20 Aug 2021 16:24:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="196418143"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="196418143"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 13:23:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="523834755"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 13:23:48 -0700
Date:   Fri, 20 Aug 2021 13:23:46 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jue Wang <juew@google.com>, Ding Hui <dinghui@sangfor.com.cn>,
        naoya.horiguchi@nec.com, osalvador@suse.de,
        Youquan Song <youquan.song@intel.com>, huangcun@sangfor.com.cn,
        x86@kernel.org, linux-edac@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210820202346.GA1623796@agluck-desk2.amr.corp.intel.com>
References: <20210706190620.1290391-1-tony.luck@intel.com>
 <20210818002942.1607544-1-tony.luck@intel.com>
 <20210818002942.1607544-2-tony.luck@intel.com>
 <YR/m/8PCmCTbogey@zn.tnic>
 <20210820185945.GA1623421@agluck-desk2.amr.corp.intel.com>
 <YSACMCEoU6FxjDNh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSACMCEoU6FxjDNh@zn.tnic>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Aug 20, 2021 at 09:27:44PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 11:59:45AM -0700, Luck, Tony wrote:
> > It's the "when we return" part that is the problem here. Logical
> > trace looks like:
> > 
> > user-syscall:
> > 
> > 	kernel does get_user() or copyin(), hits user poison address
> > 
> > 		machine check
> > 		sees that this was kernel get_user()/copyin() and
> > 		uses extable to "return" to exception path
> > 
> > 	still in kernel, see that get_user() or copyin() failed
> > 
> > 	Kernel does another get_user() or copyin() (maybe the first
> 
> I forgot all the details we were talking at the time but there's no way
> to tell the kernel to back off here, is it?
> 
> As in: there was an MCE while trying to access this user memory, you
> should not do get_user anymore. You did add that
> 
>          * Return zero to pretend that this copy succeeded. This
>          * is counter-intuitive, but needed to prevent the code
>          * in lib/iov_iter.c from retrying and running back into
> 
> which you're removing with the last patch so I'm confused.
> 
> IOW, the problem is that with repeated MCEs while the kernel is
> accessing that memory, it should be the kernel which should back off.
> And then we should kill that process too but apparently we don't even
> come to that.

My first foray into this just tried to fix the futex() case ... which is one
of the first copy is with pagefault_disable() set, then try again with it
clear.  My attempt there was to make get_user() return -EHWPOISON, and
change the futex code to give up immediatley when it saw that code.

AndyL (and maybe others) barfed all over that (and rightly so ... there
are thousands of get_user() and copyin() calls ... making sure all of them
did the right thing with a new error code would be a huge effort. Very
error prone (because testing all these paths is hard). New direction was
just deal with the fact that we might take more than one machine check
before the kernel is finished poking at the poison.

> 
> > Maybe the message could be clearer?
> > 
> > 	mce_panic("Too many consecutive machine checks in kernel while accessing user data", m, msg);
> 
> That's not my point - it is rather: this is a recoverable error because
> it is in user memory even if it is the kernel which tries to access it.
> And maybe we should not panic the whole box but try to cordon off the
> faulty memory only and poison it after having killed the process using
> it...

To recover we need to have some other place to jump to (besides the
normal extable error return ... which isn't working if we find ourselves
in this situation) when we hit a fault covered by an extable entry. And
also know how many machine checks is "normal" before taking the other path.

For futex(2) things resolve in two machine checks (one with
pagefault_disable() and then one without).  For write(2) I see up to
four machine cehcks (I didn't do a detailed track ... but I think it is
because copyin() does a retry to see if a failure in a many-bytes-at-atime
copy might be able to get a few more bytes by doing byte-at-a-time).

The logical spot for the alternate return would be to unwind the stack
back to the syscall entry point, and then force an error return from
there.  But that seems a perilous path ... what if some code between
syscall entry and the copyin() grabbed a mutex? We would also need to
know about that and release it as part of the recovery.

Another failed approach was to mark the page not present in the page
tables of the process accessing the poison. That would get us out of the
machine check loop.  But walking page tables and changing them while still
in machine check context can't be done in a safe way (the process may be
multi-threaded and other threads could still be running on other cores).

Bottom line is that I don't think this panic can actually happen unless
there is some buggy kernel code that retries get_user() or copyin()
indefinitely.

Probably the same for the two different addresses case ... though I'm
not 100% confident about that. There could be some ioctl() that peeks
at two parts of a passed in structure, and the user might pass in a
structure that spans across a page boundary with both pages poisoned.
But that would only hit if the driver code ignored the failure of the
first get_user() and blindly tried the second. So I'd count that as a
critically bad driver bug.

-Tony


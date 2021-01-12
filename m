Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA752F36D8
	for <lists+linux-edac@lfdr.de>; Tue, 12 Jan 2021 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbhALRRL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 12 Jan 2021 12:17:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:26129 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389992AbhALRRL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 12 Jan 2021 12:17:11 -0500
IronPort-SDR: wnZd2c5MTbR7FakyilgLnAnwk9hlZxNmT1j3YB+yDp5nBo5VnodFd//vHskndkjKqpYpDg0q2B
 2C0syTMrEJlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="196702364"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="196702364"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 09:16:30 -0800
IronPort-SDR: vpimsz8mu85mY/VhZ8BIsMQYhxifw2vOGImwkg53nHRI2ExwVgofbs4i2tC/j7jIwT1GpJtDWx
 vKAsEzaVeUUg==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="353104671"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 09:16:30 -0800
Date:   Tue, 12 Jan 2021 09:16:28 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/3] x86/mce: Avoid infinite loop for copy from user
 recovery
Message-ID: <20210112171628.GA15664@agluck-desk2.amr.corp.intel.com>
References: <20210111214452.1826-2-tony.luck@intel.com>
 <E1FCB534-9149-437A-971E-F93C009F99C3@amacapital.net>
 <20210111222057.GA2369@agluck-desk2.amr.corp.intel.com>
 <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALCETrVhRF0H+R1aiy-rdguL3A_9M35R3roVAgRGaEAMCJVW0Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Jan 12, 2021 at 09:00:14AM -0800, Andy Lutomirski wrote:
> > On Jan 11, 2021, at 2:21 PM, Luck, Tony <tony.luck@intel.com> wrote:
> >
> > ﻿On Mon, Jan 11, 2021 at 02:11:56PM -0800, Andy Lutomirski wrote:
> >>
> >>>> On Jan 11, 2021, at 1:45 PM, Tony Luck <tony.luck@intel.com> wrote:
> >>>
> >>> ﻿Recovery action when get_user() triggers a machine check uses the fixup
> >>> path to make get_user() return -EFAULT.  Also queue_task_work() sets up
> >>> so that kill_me_maybe() will be called on return to user mode to send a
> >>> SIGBUS to the current process.
> >>>
> >>> But there are places in the kernel where the code assumes that this
> >>> EFAULT return was simply because of a page fault. The code takes some
> >>> action to fix that, and then retries the access. This results in a second
> >>> machine check.
> >>>
> >>> While processing this second machine check queue_task_work() is called
> >>> again. But since this uses the same callback_head structure that
> >>> was used in the first call, the net result is an entry on the
> >>> current->task_works list that points to itself.
> >>
> >> Is this happening in pagefault_disable context or normal sleepable fault context?  If the latter, maybe we should reconsider finding a way for the machine check code to do its work inline instead of deferring it.
> >
> > The first machine check is in pagefault_disable() context.
> >
> > static int get_futex_value_locked(u32 *dest, u32 __user *from)
> > {
> >        int ret;
> >
> >        pagefault_disable();
> >        ret = __get_user(*dest, from);
> 
> I have very mixed feelings as to whether we should even try to recover
> from the first failure like this.  If we actually want to try to
> recover, perhaps we should instead arrange for the second MCE to
> recover successfully instead of panicking.

Well we obviously have to "recover" from the first machine check
in order to get to the second. Are you saying you don't like the
different return value from get_user()?

In my initial playing around with this I just had the second machine
check simply skip the task_work_add(). This worked for this case, but
only because there wasn't a third, fourth, etc. access to the poisoned
data. If the caller keeps peeking, then we'll keep taking more machine
checks - possibly forever.

Even if we do recover with just one extra machine check ... that's one
more than was necessary.

-Tony

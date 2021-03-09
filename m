Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A5E332F80
	for <lists+linux-edac@lfdr.de>; Tue,  9 Mar 2021 21:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCIUCn (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 9 Mar 2021 15:02:43 -0500
Received: from mga06.intel.com ([134.134.136.31]:54049 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229948AbhCIUCO (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 9 Mar 2021 15:02:14 -0500
IronPort-SDR: D1TZGDz4UaEKYUkDgfMlERaVHFp4Ses2/oPMp/J5IWrx8WfCrMI9R2QDX6d8o0rPsDVfWkWAXK
 teC7q9eGlMmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="249686756"
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="249686756"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 12:01:43 -0800
IronPort-SDR: NhNs0Xd7zkvM23qzhF1oGLCUwafaloRuA3rbX3Hvdd9GTXnU3hJ1JuGRgunl/FeD4sV2AqvV+U
 YGk2NIVElQCQ==
X-IronPort-AV: E=Sophos;i="5.81,236,1610438400"; 
   d="scan'208";a="409879533"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2021 12:01:43 -0800
Date:   Tue, 9 Mar 2021 12:01:40 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+j44CA55u05LmfKQ==?= 
        <naoya.horiguchi@nec.com>
Cc:     Aili Yao <yaoaili@kingsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>
Subject: Re: [PATCH v2] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210309200140.GA237657@agluck-desk2.amr.corp.intel.com>
References: <20210305093656.6c262b19@alex-virtual-machine>
 <20210305221143.GA220893@agluck-desk2.amr.corp.intel.com>
 <20210308064558.GA3617@hori.linux.bs1.fc.nec.co.jp>
 <3690ece2101d428fb9067fcd2a423ff8@intel.com>
 <20210308223839.GA21886@hori.linux.bs1.fc.nec.co.jp>
 <20210308225504.GA233893@agluck-desk2.amr.corp.intel.com>
 <20210309100421.3d09b6b1@alex-virtual-machine>
 <20210309060440.GA29668@hori.linux.bs1.fc.nec.co.jp>
 <20210309143534.6c1a8ec5@alex-virtual-machine>
 <20210309082824.GA1793@hori.linux.bs1.fc.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210309082824.GA1793@hori.linux.bs1.fc.nec.co.jp>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Mar 09, 2021 at 08:28:24AM +0000, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Tue, Mar 09, 2021 at 02:35:34PM +0800, Aili Yao wrote:
> > When the page is already poisoned, another memory_failure() call in the
> > same page now return 0, meaning OK. For nested memory mce handling, this
> > behavior may lead to mce looping, Example:
> > 
> > 1.When LCME is enabled, and there are two processes A && B running on
> > different core X && Y separately, which will access one same page, then
> > the page corrupted when process A access it, a MCE will be rasied to
> > core X and the error process is just underway.
> > 
> > 2.Then B access the page and trigger another MCE to core Y, it will also
> > do error process, it will see TestSetPageHWPoison be true, and 0 is
> > returned.
> > 
> > 3.The kill_me_maybe will check the return:
> > 
> > 1244 static void kill_me_maybe(struct callback_head *cb)
> > 1245 {
> > 
> > 1254         if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> > 1255             !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> > 1256                 set_mce_nospec(p->mce_addr >> PAGE_SHIFT,
> > p->mce_whole_page);
> > 1257                 sync_core();
> > 1258                 return;
> > 1259         }
> > 
> > 1267 }
> > 
> > 4. The error process for B will end, and may nothing happened if
> > kill-early is not set, The process B will re-excute instruction and get
> > into mce again and then loop happens. And also the set_mce_nospec()
> > here is not proper, may refer to commit fd0e786d9d09 ("x86/mm,
> > mm/hwpoison: Don't unconditionally unmap kernel 1:1 pages").
> > 
> > For other cases which care the return value of memory_failure() should
> > check why they want to process a memory error which have already been
> > processed. This behavior seems reasonable.
> 
> Other reviewers shared ideas about the returned value, but actually
> I'm not sure which the best one is (EBUSY is not that bad).
> What we need to fix the reported issue is to return non-zero value
> for "already poisoned" case (the value itself is not so important). 
> 
> Other callers of memory_failure() (mostly test programs) could see
> the change of return value, but they can already see EBUSY now and
> anyway they should check dmesg for more detail about why failed,
> so the impact of the change is not so big.
> 
> > 
> > Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
> 
> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>

I think that both this and my "add a mutex" patch are both
too simplistic for this complex problem :-(

When multiple CPUs race to call memory_failure() for the same
page we need the following results:

1) Poison page should be marked not-present in all tasks
	I think the mutex patch achieves this as long as
	memory_failure() doesn't hit an error[1].

2) All tasks that were executing an instruction that was accessing
   the poison location should see a SIGBUS with virtual address and
   BUS_MCEERR_AR signature in siginfo.
	Neither solution achieves this. The -EBUSY return ensures
	that there is a SIGBUS for the tasks that get the -EBUSY
	return, but no siginfo details.
	Just the mutex patch *might* have BUS_MCEERR_AO signature
	to the race losing tasks, but only if they have PF_MCE_EARLY
	set (so says the comment in kill_proc() ... but I don't
	see the code checking for that bit).

#2 seems hard to achieve ... there are inherent races that mean the
AO SIGBUS could have been queued to the task before it even hits
the poison.

Maybe should include a non-action:

3) A task should only see one SIGBUS per poison?
	Not sure if this is achievable either ... what if the task
	has the same page mapped multiple times?

-Tony

[1] still looking at why my futex injection test ends with a "reserved
kernel page still referenced by 1 users"

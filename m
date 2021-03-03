Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB432C666
	for <lists+linux-edac@lfdr.de>; Thu,  4 Mar 2021 02:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355463AbhCDA2p (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 3 Mar 2021 19:28:45 -0500
Received: from mail.kingsoft.com ([114.255.44.146]:46014 "EHLO
        mail.kingsoft.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236347AbhCCD6h (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 2 Mar 2021 22:58:37 -0500
X-AuditID: 0a580155-713ff700000550c6-c2-603f01d33099
Received: from mail.kingsoft.com (localhost [10.88.1.32])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-2-NODE-85) with SMTP id A6.9D.20678.3D10F306; Wed,  3 Mar 2021 11:26:11 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL2.kingsoft.cn
 (10.88.1.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 3 Mar 2021
 11:57:11 +0800
Date:   Wed, 3 Mar 2021 11:57:10 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     "Luck, Tony" <tony.luck@intel.com>
CC:     "HORIGUCHI =?UTF-8?B?TkFPWUE=?=(=?UTF-8?B?5aCA5Y+j44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "yangfeng1@kingsoft.com" <yangfeng1@kingsoft.com>,
        <yaoaili@kingsoft.com>
Subject: Re: [PATCH] mm,hwpoison: return -EBUSY when page already poisoned
Message-ID: <20210303115710.2e9f8e23@alex-virtual-machine>
In-Reply-To: <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
References: <20210224151619.67c29731@alex-virtual-machine>
        <20210224103105.GA16368@linux>
        <20210225114329.4e1a41c6@alex-virtual-machine>
        <20210225112818.GA10141@hori.linux.bs1.fc.nec.co.jp>
        <20210225113930.GA7227@localhost.localdomain>
        <20210225123806.GA15006@hori.linux.bs1.fc.nec.co.jp>
        <20210225181542.GA178925@agluck-desk2.amr.corp.intel.com>
        <20210226021907.GA27861@hori.linux.bs1.fc.nec.co.jp>
        <20210226105915.6cf7d2b8@alex-virtual-machine>
        <20210303033953.GA205389@agluck-desk2.amr.corp.intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL2.kingsoft.cn
 (10.88.1.32)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLIsWRmVeSWpSXmKPExsXCFcGooHuZ0T7B4P9GOYs569ewWXze8I/N
        4uv6X8wW0zaKW1w41cBkcXnXHDaLe2v+s1pcOrCAyeJi4wFGizPTiiw2b5rKbPHmwj0Wix8b
        HrM68Hp8b+1j8Vi85yWTx6ZVnWwemz5NYvd4d+4cu8eJGb9ZPF5c3cji8X7fVTaPzaerPT5v
        kvM40fKFNYA7issmJTUnsyy1SN8ugStj+Y7nTAVTZSvuNrQxNzD+Futi5OSQEDCR6JrdwNjF
        yMUhJDCdSeLut1fsEM5LRomO5qmsIFUsAioSK+aeZAKx2QRUJXbdmwUWFxFQk7i0+AEzSAOz
        wGxWiVOTzzKDJIQFvCS+3F/LCGLzClhJnNvwEMzmFHCT+LtoDhPEhi4WiduzH7GDJPgFxCR6
        r/xngrjJXqJtyyKoZkGJkzOfsIDYzAI6EidWHWOGsOUltr+dA2YLCShKHF7yix2iV0niSPcM
        Ngg7VmLZvFesExiFZyEZNQvJqFlIRi1gZF7FyFKcm260iRESg6E7GGc0fdQ7xMjEwXiIUYKD
        WUmEV/ylbYIQb0piZVVqUX58UWlOavEhRmkOFiVx3qlbTRKEBNITS1KzU1MLUotgskwcnFIN
        TPGhXNOne97Ymc+5+uocPYPt/5bU/JDJjlxxYuK3I46Z7sx/+aR3n+vafujpgtNGX1w+737k
        pSohyVRnc0PTeOucSwmWJQYJpc/m3jbOvNqkWKLBomd8OYz9e+fFwNRpBZp9ybOe65YttHNq
        uXM3rLSah2mSj8xZkVt3L9hOn76e0TTTtJftYEWfsWV/c0VDlNQR6eJVz04YTH6/5Hc8z+ba
        6SpzN8ge/uwwdZeeYuUF6wbmH3GpJ7OLru7OPM2w6dKU1RkTI3LelCp32ef7l3MFn343q2bb
        7vMzkh88nVS5Za+GzU7WCJad1Xn3KzNZ+C49Vt69njPpWKO92PEmIQHlg55Oeu8f9ztaVCjx
        KLEUZyQaajEXFScCABnB2towAwAA
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2 Mar 2021 19:39:53 -0800
"Luck, Tony" <tony.luck@intel.com> wrote:

> On Fri, Feb 26, 2021 at 10:59:15AM +0800, Aili Yao wrote:
> > Hi naoya, tony:  
> > > > 
> > > > Idea for what we should do next ... Now that x86 is calling memory_failure()
> > > > from user context ... maybe parallel calls for the same page should
> > > > be blocked until the first caller completes so we can:
> > > > a) know that pages are unmapped (if that happens)
> > > > b) all get the same success/fail status    
> > > 
> > > One memory_failure() call changes the target page's status and
> > > affects all mappings to all affected processes, so I think that
> > > (ideally) we don't have to block other threads (letting them
> > > early return seems fine).  Sometimes memory_failure() fails,
> > > but even in such case, PG_hwpoison is set on the page and other
> > > threads properly get SIGBUSs with this patch, so I think that
> > > we can avoid the worst scenario (like system stall by MCE loop).
> > >   
> > I agree with naoya's point, if we block for this issue, Does this change the result
> > that the process should be killed? Or is there something other still need to be considered?  
> 
> Ok ... no blocking ... I think someone in this thread suggested
> scanning the page tables to make sure the poisoned page had been
> unmapped.
> 
> There's a walk_page_range() function that does all the work for that.
> Just need to supply some callback routines that check whether a
> mapping includes the bad PFN and clear the PRESENT bit.
> 
> RFC patch below against v5.12-rc1
> 
> -Tony
> 
> From 8de23b7f1be00ad38e129690dfe0b1558fad5ff8 Mon Sep 17 00:00:00 2001
> From: Tony Luck <tony.luck@intel.com>
> Date: Tue, 2 Mar 2021 15:06:33 -0800
> Subject: [PATCH] x86/mce: Handle races between machine checks
> 
> When multiple CPUs hit the same poison memory there is a race. The
> first CPU into memory_failure() atomically marks the page as poison
> and continues processing to hunt down all the tasks that map this page
> so that the virtual addresses can be marked not-present and SIGBUS
> sent to the task that did the access.
> 
> Later CPUs get an early return from memory_failure() and may return
> to user mode and access the poison again.
> 
> Add a new argument to memory_failure() so that it can indicate when
> the race has been lost. Fix kill_me_maybe() to scan page tables in
> this case to unmap pages.

> +
>  static void kill_me_now(struct callback_head *ch)
>  {
>  	force_sig(SIGBUS);
> @@ -1257,15 +1304,19 @@ static void kill_me_maybe(struct callback_head *cb)
>  {
>  	struct task_struct *p = container_of(cb, struct task_struct, mce_kill_me);
>  	int flags = MF_ACTION_REQUIRED;
> +	int already = 0;
>  
>  	pr_err("Uncorrected hardware memory error in user-access at %llx", p->mce_addr);
>  
>  	if (!p->mce_ripv)
>  		flags |= MF_MUST_KILL;
>  
> -	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags) &&
> +	if (!memory_failure(p->mce_addr >> PAGE_SHIFT, flags, &already) &&
>  	    !(p->mce_kflags & MCE_IN_KERNEL_COPYIN)) {
> -		set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
> +		if (already)
> +			walk_page_range(current->mm, 0, TASK_SIZE_MAX, &walk, (void *)(p->mce_addr >> PAGE_SHIFT));
> +		else
> +			set_mce_nospec(p->mce_addr >> PAGE_SHIFT, p->mce_whole_page);
>  		sync_core();
>  		return;

>  	MF_MUST_KILL = 1 << 2,
>  	MF_SOFT_OFFLINE = 1 << 3,
>  };

I have one doubt here, when "walk_page_range(current->mm, 0, TASK_SIZE_MAX, &walk, (void *)(p->mce_addr >> PAGE_SHIFT));" is done,
so how is the process triggering this error returned if it have taken the wrong data?

-- 
Thanks!
Aili Yao

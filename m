Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638AB2EC661
	for <lists+linux-edac@lfdr.de>; Wed,  6 Jan 2021 23:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbhAFWuC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 17:50:02 -0500
Received: from mga17.intel.com ([192.55.52.151]:43373 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbhAFWuB (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 17:50:01 -0500
IronPort-SDR: UIHudLgTPNwYnjtRL95A7vb/FC4qa/N+AAnDFeDzKCReifCmBCLsiYvenQ48cZ9E//XtXuRnBx
 slCKrztlKWDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9856"; a="157129212"
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="157129212"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 14:49:20 -0800
IronPort-SDR: Yn0Ks9W4OkvWlWo4rxVSkW7mFS5zL8+rFMKZuPCdMl7WJRgizx2cQD/ry2JTl2/LLMilRxJq/t
 iiRVjpVSjvjA==
X-IronPort-AV: E=Sophos;i="5.79,328,1602572400"; 
   d="scan'208";a="361746863"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2021 14:49:19 -0800
Date:   Wed, 6 Jan 2021 14:49:18 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210106224918.GA7914@agluck-desk2.amr.corp.intel.com>
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
 <20210106191708.GB2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106191708.GB2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 06, 2021 at 11:17:08AM -0800, Paul E. McKenney wrote:
> On Wed, Jan 06, 2021 at 06:39:30PM +0000, Luck, Tony wrote:
> > > The "Timeout: Not all CPUs entered broadcast exception handler" message
> > > will appear from time to time given enough systems, but this message does
> > > not identify which CPUs failed to enter the broadcast exception handler.
> > > This information would be valuable if available, for example, in order to
> > > correlated with other hardware-oriented error messages.  This commit
> > > therefore maintains a cpumask_t of CPUs that have entered this handler,
> > > and prints out which ones failed to enter in the event of a timeout.
> > 
> > I tried doing this a while back, but found that in my test case where I forced
> > an error that would cause both threads from one core to be "missing", the
> > output was highly unpredictable. Some random number of extra CPUs were
> > reported as missing. After I added some extra breadcrumbs it became clear
> > that pretty much all the CPUs (except the missing pair) entered do_machine_check(),
> > but some got hung up at various points beyond the entry point. My only theory
> > was that they were trying to snoop caches from the dead core (or access some
> > other resource held by the dead core) and so they hung too.
> > 
> > Your code is much neater than mine ... and perhaps works in other cases, but
> > maybe the message needs to allow for the fact that some of the cores that
> > are reported missing may just be collateral damage from the initial problem.
> 
> Understood.  The system is probably not in the best shape if this code
> is ever executed, after all.  ;-)
> 
> So how about like this?
> 
> 	pr_info("%s: MCE holdout CPUs (may include false positives): %*pbl\n",

That looks fine.
> 
> Easy enough if so!
> 
> > If I get time in the next day or two, I'll run my old test against your code to
> > see what happens.

I got time today (plenty of meetings in which to run experiments in background).

This code:

-               if (mca_cfg.tolerant <= 1)
+               if (mca_cfg.tolerant <= 1) {
+                       if (!cpumask_andnot(&mce_missing_cpus, cpu_online_mask, &mce_present_cpus))
+                               pr_info("%s: MCE holdout CPUs: %*pbl\n",
+                                       __func__, cpumask_pr_args(&mce_missing_cpus));
                        mce_panic(msg, NULL, NULL);

didn't trigger ... so maybe that cpumask_andnot() didn't return the value you expected?

I added a:

+                       pr_info("%s: MCE present CPUs: %*pbl\n", __func__, cpumask_pr_args(&mce_present_cpus));

to check that the mask was being set correctly, and saw:

[  219.329767] mce: mce_timed_out: MCE present CPUs: 0-23,48-119,144-191

So the every core of socket 1 failed to show up for this test.

> For my own testing, is this still the right thing to use?
> 
> 	https://github.com/andikleen/mce-inject

That fakes up errors (by hooking into the mce_rdmsr() code to return arbitrary
user supplied values).  The plus side of this is that you can fake any error
signature without needing special h/w or f/w. The downside is that it is all fake
and you can't create situations where some CPUs don't show up in the machine
check handler.

-Tony

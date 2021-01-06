Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F532EC3C3
	for <lists+linux-edac@lfdr.de>; Wed,  6 Jan 2021 20:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAFTRt (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 6 Jan 2021 14:17:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:38640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbhAFTRt (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 6 Jan 2021 14:17:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50B2823123;
        Wed,  6 Jan 2021 19:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609960628;
        bh=yreYIyYCDlZPK1zmAnRhTF4c7ED3cMyCU7MTbH+WuMw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eMLo5Ikuj6X8rUzZoni6+xw6ImrnDk7Z6mSPANf6rSRDIPE4jQ0SqU5ZU3gby2a3D
         vdAbOt5PpW14FA1jns4Rq1mhZhKbtjdI64nhBKDHajY7AEfm41vycv66rlLOWRQ/dS
         ZJIHZx1+ltSXdrq4HmKBucGK8z7KjT6ymeokQAHSD8dc3wWtovo554/C/vegtt1qZR
         CbdeYM4G3K44qHaNQwjtjwdbingz4ZUAGh7/aZHtdWrZWe2w583LF1xH+Jx46m228z
         GdFEgBKf3TicB4B+YwEAWfqZzgwITkFRNESeBeHOFSGbcLDGVXGSGWkMtA9g6HBjQ4
         5RetBx7XZTNyA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0D8C135225DC; Wed,  6 Jan 2021 11:17:08 -0800 (PST)
Date:   Wed, 6 Jan 2021 11:17:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH RFC x86/mce] Make mce_timed_out() identify holdout CPUs
Message-ID: <20210106191708.GB2743@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20210106174102.GA23874@paulmck-ThinkPad-P72>
 <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3513b04e2bb543d2871ca8c152dcf5ae@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Jan 06, 2021 at 06:39:30PM +0000, Luck, Tony wrote:
> > The "Timeout: Not all CPUs entered broadcast exception handler" message
> > will appear from time to time given enough systems, but this message does
> > not identify which CPUs failed to enter the broadcast exception handler.
> > This information would be valuable if available, for example, in order to
> > correlated with other hardware-oriented error messages.  This commit
> > therefore maintains a cpumask_t of CPUs that have entered this handler,
> > and prints out which ones failed to enter in the event of a timeout.
> 
> I tried doing this a while back, but found that in my test case where I forced
> an error that would cause both threads from one core to be "missing", the
> output was highly unpredictable. Some random number of extra CPUs were
> reported as missing. After I added some extra breadcrumbs it became clear
> that pretty much all the CPUs (except the missing pair) entered do_machine_check(),
> but some got hung up at various points beyond the entry point. My only theory
> was that they were trying to snoop caches from the dead core (or access some
> other resource held by the dead core) and so they hung too.
> 
> Your code is much neater than mine ... and perhaps works in other cases, but
> maybe the message needs to allow for the fact that some of the cores that
> are reported missing may just be collateral damage from the initial problem.

Understood.  The system is probably not in the best shape if this code
is ever executed, after all.  ;-)

So how about like this?

	pr_info("%s: MCE holdout CPUs (may include false positives): %*pbl\n",

Easy enough if so!

> If I get time in the next day or two, I'll run my old test against your code to
> see what happens.

Thank you very much in advance!

For my own testing, is this still the right thing to use?

	https://github.com/andikleen/mce-inject

							Thanx, Paul

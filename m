Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A312D779C
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 15:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbfJONnJ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 09:43:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:31338 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbfJONnJ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 15 Oct 2019 09:43:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 06:43:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,300,1566889200"; 
   d="scan'208";a="194519177"
Received: from spandruv-mobl3.jf.intel.com ([10.254.34.58])
  by fmsmga008.fm.intel.com with ESMTP; 15 Oct 2019 06:43:08 -0700
Message-ID: <9d1ab837e757375374f2a45655dbe8aba42aeee5.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Date:   Tue, 15 Oct 2019 06:43:07 -0700
In-Reply-To: <20191015085257.GE2311@hirez.programming.kicks-ass.net>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
         <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
         <20191014213618.GK4715@zn.tnic>
         <20191014222735.GA25203@agluck-desk2.amr.corp.intel.com>
         <20191015085257.GE2311@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2019-10-15 at 10:52 +0200, Peter Zijlstra wrote:
> On Mon, Oct 14, 2019 at 03:27:35PM -0700, Luck, Tony wrote:
> > On Mon, Oct 14, 2019 at 11:36:18PM +0200, Borislav Petkov wrote:
> > > This description is already *begging* for this delay value to be
> > > automatically set by the kernel. Putting yet another knob in
> > > front of
> > > the user who doesn't have a clue most of the time shows one more
> > > time
> > > that we haven't done our job properly by asking her to know what
> > > we
> > > already do.
> > > 
> > > IOW, a simple history feedback mechanism which sets the timeout
> > > based on
> > > the last couple of values is much smarter. The thing would have a
> > > max
> > > value, of course, which, when exceeded should mean an anomaly,
> > > etc, but
> > > almost anything else is better than merely asking the user to
> > > make an
> > > educated guess.
> > 
> > You need a plausible start point for the "when to worry the user"
> > message.  Maybe that is your "max value"?
> > 
> > So if the system has a couple of excursions above temperature
> > lasting
> > 1 second and then 2 seconds ... would you like to see those ignored
> > (because they are below the initial max)? But now we have a couple
> > of data points pick some new value to be the threshold for
> > reporting?
> > 
> > What value should we pick (based on 1 sec, then 2 sec)?
> > 
> > I would be worried that it would self tune to the point where it
> > does report something that it really didn't need to (e.g. as a
> > result
> > of a few consecutive very short excursions).
> 
> I'm guessing Boris is thinking of a simple IIR like avg filter.
> 
> 	avg = avg + (sample-avg) / 4
> 
> And then only print when sample > 2*avg. If you initialize that with
> some appropriately large value, it should settle down into what it
> 'normal' for that particular piece of hardware.
I will take a shot with some IIR implementation.

> 
> Still, I'm boggled by the whole idea that hitting critical hard
> throttle
> is considered 'normal' at all.
As explained in my previous email, this is not so called TJMax, where
it will shutdown. If you keep this temperature for longer time, cooling
needs be adjusted.

> 
> > We also need to take into account the "typical sampling interval"
> > for user space thermal control software.
> 
> Why is control of critical thermal crud in userspace? That seems like
> a
> massive design fail.
The TjMax is taken care by the embedded firmware or kernel depending on
how OEM wants it to be controlled. User space is for mostly balancing
non CPU parts, which are not urgent. For example you run CPU at high
temperature for long duration, the skin will heat up, which takes much
longer time to cool than CPU itself.

Thanks,
Srinivas 




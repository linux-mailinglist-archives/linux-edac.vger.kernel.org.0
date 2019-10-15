Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE192D7197
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbfJOIxL (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 15 Oct 2019 04:53:11 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33898 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfJOIxL (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 15 Oct 2019 04:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rjzfeDkzQ8oFBeoh7Q4dFwyvzdrmkuKDk9XLQ2RCZI0=; b=jex/AY+8LPcFbFDopQFRs728j
        hbf53hXlnzhV5Tg5fBA1nC4sBisXRxJ26gVuLqpYyKHpHBUw4LedocCb8ui6WUgU01mWKnl7ugC8v
        8mxBJlXHxLFML1/EMzFyyX3aBEpWOCcgyeewa8Xd8R11gXokjH8zd8Wl33oPlhDXGd7hEp8MQJyVp
        bn/5+vldBedLJKPitHRSqe2GpZENcTZJdH4Q15qnbEUc6en55zoh+7huXS4HEU4jjxEPePxebk3Kd
        ZGxWxQMdeW2uJZRrxYwR2uG8Cjtr0DO+cGy60qFx6QxSW5dvhqFCJfy54c4iuQD9vmAdgW7fwz/09
        ZwChxmAMA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKIZg-0000hy-G3; Tue, 15 Oct 2019 08:53:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 42F553032F8;
        Tue, 15 Oct 2019 10:52:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9F35C28B550CD; Tue, 15 Oct 2019 10:52:57 +0200 (CEST)
Date:   Tue, 15 Oct 2019 10:52:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bberg@redhat.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191015085257.GE2311@hirez.programming.kicks-ass.net>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191014213618.GK4715@zn.tnic>
 <20191014222735.GA25203@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014222735.GA25203@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 03:27:35PM -0700, Luck, Tony wrote:
> On Mon, Oct 14, 2019 at 11:36:18PM +0200, Borislav Petkov wrote:
> > This description is already *begging* for this delay value to be
> > automatically set by the kernel. Putting yet another knob in front of
> > the user who doesn't have a clue most of the time shows one more time
> > that we haven't done our job properly by asking her to know what we
> > already do.
> > 
> > IOW, a simple history feedback mechanism which sets the timeout based on
> > the last couple of values is much smarter. The thing would have a max
> > value, of course, which, when exceeded should mean an anomaly, etc, but
> > almost anything else is better than merely asking the user to make an
> > educated guess.
> 
> You need a plausible start point for the "when to worry the user"
> message.  Maybe that is your "max value"?
> 
> So if the system has a couple of excursions above temperature lasting
> 1 second and then 2 seconds ... would you like to see those ignored
> (because they are below the initial max)? But now we have a couple
> of data points pick some new value to be the threshold for reporting?
> 
> What value should we pick (based on 1 sec, then 2 sec)?
> 
> I would be worried that it would self tune to the point where it
> does report something that it really didn't need to (e.g. as a result
> of a few consecutive very short excursions).

I'm guessing Boris is thinking of a simple IIR like avg filter.

	avg = avg + (sample-avg) / 4

And then only print when sample > 2*avg. If you initialize that with
some appropriately large value, it should settle down into what it
'normal' for that particular piece of hardware.

Still, I'm boggled by the whole idea that hitting critical hard throttle
is considered 'normal' at all.

> We also need to take into account the "typical sampling interval"
> for user space thermal control software.

Why is control of critical thermal crud in userspace? That seems like a
massive design fail.

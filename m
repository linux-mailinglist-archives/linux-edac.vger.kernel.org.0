Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABBDDCD3C
	for <lists+linux-edac@lfdr.de>; Fri, 18 Oct 2019 20:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405272AbfJRSC6 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 18 Oct 2019 14:02:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:44876 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727054AbfJRSC6 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 18 Oct 2019 14:02:58 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 11:02:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="190439301"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by orsmga008.jf.intel.com with ESMTP; 18 Oct 2019 11:02:57 -0700
Date:   Fri, 18 Oct 2019 11:02:57 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "bberg@redhat.com" <bberg@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ckellner@redhat.com" <ckellner@redhat.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191018180257.GA23835@agluck-desk2.amr.corp.intel.com>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191015084833.GD2311@hirez.programming.kicks-ass.net>
 <f481b4ab6dfebbc0637c843e5f1cd4ddfd4bd60b.camel@linux.intel.com>
 <20191016081405.GO2328@hirez.programming.kicks-ass.net>
 <20191016140001.GF1138@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F4A57D0@ORSMSX115.amr.corp.intel.com>
 <20191017214445.GG14441@zn.tnic>
 <c2ce4ef128aad84616b2dc21f6230ad4db12194b.camel@linux.intel.com>
 <20191018132309.GD17053@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018132309.GD17053@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 18, 2019 at 03:23:09PM +0200, Borislav Petkov wrote:
> On Fri, Oct 18, 2019 at 05:26:36AM -0700, Srinivas Pandruvada wrote:
> > Server/desktops generally rely on the embedded controller for FAN
> > control, which  kernel have no control. For them this warning helps to
> > either bring in additional cooling or fix existing cooling.
> 
> How exactly does this warning help? A detailed example please.
> 
> > If something needs to force throttle from kernel, then we should use
> > some offset from the max temperature (aka TJMax), instead of this
> > warning threshold. Then we can use idle injection or change duty cycle
> > of CPU clocks.
> 
> Yes, as I said, all this needs to be properly defined first. That is,
> *if* there's even need for reacting to thermal interrupts in the kernel.

Recap:

We are starting from a place where the kernel prints a message.

Patch already in flight to reduce the severity of the message
(since users are seeing it, and find it annoying/unhelpful that
it has such a high severity).

Srinivas has asserted that in many cases we can eliminate the
message. But wants to keep the message if it seems that there
is something really wrong.

---

So what should we do next?  I don't think there is much by way
of actions that the kernel should take.  While we could stop
scheduling processes, the h/w and f/w have better tools to
reduce frequency, inject idle cycles, speed up fans, etc.
If you do have ideas ... then please share.

So this thread is now about doing the proper definition of
what we actions Linux should take.

Proposal on the table is the algoritm embodied in Srinivas'
patch (which originated from Alan Cox).

I.e.
1) ignore short excursions above this threshold.
2) Print a message for persistent problems.
3) Keep a record of total time spent above threshold.

If that's a reasonable approach, the we just need to come
up with a way to define "short excursion" (which might be
platform dependent). If someone has a brilliant idea on
how to do that, we can use it. If not we #define a number.

If it isn't reasonable ... then propose something better.

-Tony

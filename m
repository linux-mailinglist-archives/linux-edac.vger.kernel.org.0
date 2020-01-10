Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE27137653
	for <lists+linux-edac@lfdr.de>; Fri, 10 Jan 2020 19:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgAJSpf (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Jan 2020 13:45:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:52956 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgAJSpf (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 Jan 2020 13:45:35 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 10:45:35 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="218148092"
Received: from agluck-desk2.amr.corp.intel.com ([10.3.52.68])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 10:45:34 -0800
Date:   Fri, 10 Jan 2020 10:45:33 -0800
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v2 1/6] x86/mce: Take action on UCNA/Deferred errors again
Message-ID: <20200110184533.GB20511@agluck-desk2.amr.corp.intel.com>
References: <20200103150722.20313-1-jschoenh@amazon.de>
 <20200103150722.20313-2-jschoenh@amazon.de>
 <20200110095004.GD19453@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200110095004.GD19453@zn.tnic>
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Jan 10, 2020 at 10:50:04AM +0100, Borislav Petkov wrote:
> On Fri, Jan 03, 2020 at 04:07:17PM +0100, Jan H. Schönherr wrote:
> > Commit fa92c5869426 ("x86, mce: Support memory error recovery for both
> > UCNA and Deferred error in machine_check_poll") added handling of UCNA
> > and Deferred errors by adding them to the ring for SRAO errors.
> > 
> > Later, commit fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action
> > Optional errors") switched storage from the SRAO ring to the unified
> > pool that is still in use today. In order to only act on the intended
> > errors, a filter for MCE_AO_SEVERITY is used -- effectively removing
> > handling of UCNA/Deferred errors again.
> > 
> > Extend the severity filter to include UCNA/Deferred errors again.
> > Also, generalize the naming of the notifier from SRAO to UC to capture
> > the extended scope.
> > 
> > Note, that this change may cause a message like the following to appear,
> > as the same address may be reported as SRAO and as UCNA:
> > 
> >  Memory failure: 0x5fe3284: already hardware poisoned
> > 
> > Technically, this is a return to previous behavior.
> > 
> > Fixes: fd4cf79fcc4b ("x86/mce: Remove the MCE ring for Action Optional errors")
> > Signed-off-by: Jan H. Schönherr <jschoenh@amazon.de>
> 
> Tony, ACK?

Acked-by: Tony Luck <tony.luck@intel.com>

> Also, do you want it in stable@ so that it gets backported?

That's a tricky question. We have changing behavior (UCNA pages offlined,
then a few kernel versions stopped doing this, now we are going to start
doing it again. But is it really a _BUG_ that needs backporting to stable?
I'm leaning towards "no it isn't". But could perhaps be convinced to change
my mind if somebody has a good reason for wanting it there.

Is there something to put in the tags to stop this being autoselected
for backport because it has a Fixes: tag?

> I'm wondering if in the memory_failure error() case, we should hand it
> down to the remaining notifiers.
> 
> Which also begs the question in light of this clumsy notifier counting:
> 
> How about we have the default notifier *unconditionally* print the MCE?
> I.e., if the error has reached it, it would print it. If not and some
> other notifier consumed it, it will get handled differently.
> 
> This way we won't need any special counting of notifiers and special
> reg/unreg of notifiers etc.
> 
> IOW, the logic would be:
> 
> If something consumes the error, then it doesn't get printed. Notifier
> does NOTIFY_STOP.
> 
> If nothing consumes it or something looks at it and decides that it
> should still get printed, then the last catch-all notifier callback does
> that.

I totally agree that counting notifiers is clumsy. Also less than
ideal is the concept that any notifier on the chain can declare:
  "I fixed it"
and prevent any other notifiers from even seeing it. Well the concept
is good, but it is overused.

I think we may do better with a field in the "struct mce" that is being
passed to each where notifiers can wiggle some bits (semantics to be
defined later) which can tell subsequent notifiers what sort of actions
have been taken.
E.g. the SRAO/UCNA notifier can say "I took this page offline"
the dev_mcelog one can say "I think I handed to a process that has /dev/mcelog open"
EDAC drivers can say "I decoded the address and printed something"
CEC can say: "I silently counted this corrected error", or "error exceeded
threshold and I took the page offline".

The default notifier can print to console if nobody set a bit to say
that the error had been somehow logged.

-Tony

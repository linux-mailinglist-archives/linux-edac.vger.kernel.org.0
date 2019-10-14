Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D79D6BAD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731870AbfJNW1h (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 18:27:37 -0400
Received: from mga03.intel.com ([134.134.136.65]:30428 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731861AbfJNW1g (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 18:27:36 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 15:27:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="208057753"
Received: from agluck-desk2.sc.intel.com (HELO agluck-desk2.amr.corp.intel.com) ([10.3.52.68])
  by fmsmga001.fm.intel.com with ESMTP; 14 Oct 2019 15:27:35 -0700
Date:   Mon, 14 Oct 2019 15:27:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        bberg@redhat.com, x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, hdegoede@redhat.com,
        ckellner@redhat.com
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
Message-ID: <20191014222735.GA25203@agluck-desk2.amr.corp.intel.com>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
 <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
 <20191014213618.GK4715@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014213618.GK4715@zn.tnic>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Oct 14, 2019 at 11:36:18PM +0200, Borislav Petkov wrote:
> This description is already *begging* for this delay value to be
> automatically set by the kernel. Putting yet another knob in front of
> the user who doesn't have a clue most of the time shows one more time
> that we haven't done our job properly by asking her to know what we
> already do.
> 
> IOW, a simple history feedback mechanism which sets the timeout based on
> the last couple of values is much smarter. The thing would have a max
> value, of course, which, when exceeded should mean an anomaly, etc, but
> almost anything else is better than merely asking the user to make an
> educated guess.

You need a plausible start point for the "when to worry the user"
message.  Maybe that is your "max value"?

So if the system has a couple of excursions above temperature lasting
1 second and then 2 seconds ... would you like to see those ignored
(because they are below the initial max)? But now we have a couple
of data points pick some new value to be the threshold for reporting?

What value should we pick (based on 1 sec, then 2 sec)?

I would be worried that it would self tune to the point where it
does report something that it really didn't need to (e.g. as a result
of a few consecutive very short excursions).

We also need to take into account the "typical sampling interval"
for user space thermal control software.

Srinivas: Maybe this needs to have some more detail on what user
solutions are being taken into account here.

> > Suggested-by: Alan Cox <alan@linux.intel.com>
> > Commit-comment-by: Tony Luck <tony.luck@intel.com>
>   ^^^^^^^^^^^^^^^^^^
> 
> What's that?

My fault ... during review process I pretty much re-wrote the
whole commit message to follow the form of:
	"What is the problem?"
	"How are we fixing it"
But I didn't want Srinivas to take the heat for any mistakes
that were my fault. "Co-developed-by" really didn't explain
what happened (since I didn't write any code, just made suggestions
on things that needed to be changed/improved).

-Tony

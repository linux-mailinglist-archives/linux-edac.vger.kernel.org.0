Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB26D6BBD
	for <lists+linux-edac@lfdr.de>; Tue, 15 Oct 2019 00:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfJNWll (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 14 Oct 2019 18:41:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:21239 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbfJNWll (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 14 Oct 2019 18:41:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Oct 2019 15:41:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,296,1566889200"; 
   d="scan'208";a="207353863"
Received: from spandruv-mobl3.jf.intel.com ([10.254.34.58])
  by orsmga002.jf.intel.com with ESMTP; 14 Oct 2019 15:41:39 -0700
Message-ID: <3055e340ebaba9f8fb587a11ce3f25cf33919ab3.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] x86, mce, therm_throt: Optimize logging of thermal
 throttle messages
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Date:   Mon, 14 Oct 2019 15:41:38 -0700
In-Reply-To: <20191014213618.GK4715@zn.tnic>
References: <2c2b65c23be3064504566c5f621c1f37bf7e7326.camel@redhat.com>
         <20191014212101.25719-1-srinivas.pandruvada@linux.intel.com>
         <20191014213618.GK4715@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 2019-10-14 at 23:36 +0200, Borislav Petkov wrote:
> On Mon, Oct 14, 2019 at 02:21:00PM -0700, Srinivas Pandruvada wrote:
> > Some modern systems have very tight thermal tolerances. Because of
> > this
> > they may cross thermal thresholds when running normal workloads
> > (even
> > during boot). The CPU hardware will react by limiting
> > power/frequency
> > and using duty cycles to bring the temperature back into normal
> > range.
> > 
> > Thus users may see a "critical" message about the "temperature
> > above
> > threshold" which is soon followed by "temperature/speed normal".
> > These
> > messages are rate limited, but still may repeat every few minutes.
> > 
> > The solution here is to set a timeout when the temperature first
> > exceeds
> > the threshold. If the CPU returns to normal before the timeout
> > fires,
> > we skip printing any messages. If we reach the timeout, then there
> > may be
> > a real thermal issue (e.g. inoperative or blocked fan) and we print
> > the
> > message (together with a count of how many thermal events have
> > occurred).
> > A rate control method is used to avoid printing repeatedly on these
> > broken
> > systems.
> > 
> > Some experimentation with fans enabled showed that temperature
> > returned
> > to normal on a laptop in ~4 seconds. With fans disabled it took
> > over 10
> > seconds. Default timeout is thus set to 8 seconds, but may be
> > changed
> > with kernel boot parameter: "x86_therm_warn_delay". This default
> > interval
> > is twice of typical sampling interval for cooling using running
> > average
> > power limit from user space thermal control softwares.
> > 
> > In addition a new sysfs attribute is added to show what is the
> > maximum
> > amount of time in miili-seconds the system was in throttled state.
> > This
> > will allow to change x86_therm_warn_delay, if required.
> 
> This description is already *begging* for this delay value to be
> automatically set by the kernel. Putting yet another knob in front of
> the user who doesn't have a clue most of the time shows one more time
> that we haven't done our job properly by asking her to know what we
> already do.
I experimented on the systems released from Sandy Bridge era. But
someone running on 10 years old system, this is a fallback mechanism.
Don't expect that users have to tune from the default but saying with
certainty is difficult. The source of this PROCHOT signal can be
anything on the board.
So some users who had issues in their systems can try with this patch.
We can get rid of this, till it becomes real issue.

> 
> IOW, a simple history feedback mechanism which sets the timeout based
> on
> the last couple of values is much smarter. The thing would have a max
> value, of course, which, when exceeded should mean an anomaly, etc,
> but
> almost anything else is better than merely asking the user to make an
> educated guess.
The temperature is function of load, time and heat dissipation capacity
of the system. I have to think more about this to come up with some
heuristics where we still warning users about real thermal issues.
Since value is not persistent, then next boot again will start from the
default.

> 
> > Suggested-by: Alan Cox <alan@linux.intel.com>
> > Commit-comment-by: Tony Luck <tony.luck@intel.com>
> 
>   ^^^^^^^^^^^^^^^^^^
> 
> What's that?
Tony suggested this to indicate that he rewrote the commit description
as he didn't like my description. Definitely checkpatch doesn't like
this.

Thanks,
Srinivas


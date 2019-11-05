Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF49F0715
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 21:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbfKEUgd (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 15:36:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:13316 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbfKEUgd (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 15:36:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 12:36:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="214020092"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga002.jf.intel.com with ESMTP; 05 Nov 2019 12:36:32 -0800
Message-ID: <810bfb95a42090ff64f86e4154e2bd2cfda29f27.camel@linux.intel.com>
Subject: Re: [RFC][PATCH] x86, mce, therm_throt: Optimize notifications of
 thermal throttle
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Date:   Tue, 05 Nov 2019 12:36:32 -0800
In-Reply-To: <20191105144411.GC28418@zn.tnic>
References: <20191025001924.10199-1-srinivas.pandruvada@linux.intel.com>
         <20191105144411.GC28418@zn.tnic>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, 2019-11-05 at 15:44 +0100, Borislav Petkov wrote:
> On Thu, Oct 24, 2019 at 05:19:24PM -0700, Srinivas Pandruvada wrote:

Thanks for the review.

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
> 
> rate-limited
OK

> 
> > A test run on a laptop with Intel 8th Gen i5 core for two hours
> > with a
> > workload resulted in 20K+ thermal interrupts per CPU for core level
> > and
> > another 20K+ interrupts at package level. The kernel logs were full
> > of
> > throttling messages.
> > 
> > Brief background, on why there are so many thermal interrupts in a
> > modern system:
> > From IvyBridge, there is another offset called TCC offset is
> > introduced.
> 
> That sentence needs fixing.
Will try.

> 
> > This adds an offset to the real PROCHOT temperature target. So
> > effectively
> > this interrupt is generated much before the PROCHOT. There will be
> > several
> > very short throttling by the processor using adaptive thermal
> > monitoring
> 
>   ^^^^^^^^^^^^^^^^^^^^^^
> 
> "There will be several very short throttling" reads funny.
Will try to remove "Fun" out of it.

> 
> > at this threshold, instead of more aggressive action close to
> > PROCHOT.
> > This offset is configured by OEMs and some tend to be more
> > conservative
> > than others. So logging such events just generates noise in the
> > logs.
> > 
> > The real value of these threshold interrupts, is to debug problems
> > with
> > the external cooling solutions and performance issues due to
> > excessive
> > throttling.
> > 
> > So the solution here:
> > - Show in the current thermal_throttle folder, the maximum time for
> > one
> > throttling event and total amount of time, the system was in
> > throttling
> > state.
> > - Don't log short excursions.
> > - Log only when, in spite of thermal throttling the temperature is
> > rising.
> > This is done by monitoring temperature trend using three point
> > moving
> > average. On the high threshold interrupt trigger a delayed
> > workqueue,
> > which monitors the threshold violation log bit, calculates moving
> > moving
> 
> What is the "threshold violation log bit" ? THERM_STATUS_PROCHOT_LOG
> ?
Yes, BIT 1 of therm
MSR_IA32_THERM_STATUS/MSR_IA32_PACKAGE_THERM_STATUS.

> 
> s/moving moving/moving/
> 
> Please read your commit message before sending to check whether it
> makes
> any sense. Commit messages are not write-only.
Noted.

> 
> > average and logs when temperature trend is raising. When the log
> > bit is
> > clear and temperature is below threshold temperature, it will print
> > "Normal" message. Once a high threshold event is logged, it rate
> > limits
> > number of log messages.
> > - Reduce the logging severity to warning.
> 
> I already took the reducing printk severity patch, you'd need to redo
> yours ontop of tip/master.
I will rebase and remove this from the description.

> > 

[...]

> 
> > +	int			rate_control_active;
> 
> That wants to be a bool judging by the context it is used in.
I can change to bool, just didn't use it
https://yarchive.net/comp/linux/bool.html

> 
> > +	int			level;
> > +	int			sample_index;
> > +	int			sample_count;
> > +	int			average;
> > +	int			baseline_temp;
> > +	u8			temp_samples[3];
> 
> All these new members (and old members) should be documented what
> they
> are. Like, what is "max_time_ms", for example? I can find out from
> the
> sysfs func names below but having comments explaining what those are
> is
> much better.
> 
> >  };
I will do that.

> >  

[...]

> > +
> > +static void therm_throt_clear_therm_status_log(int level)
> 
> That's a static function, called only once so prepending its name
> with
> the "therm_throt_" prefix is pointless and doesn't help readability.
> Having simply
> 
> 	clear_therm_status_log(state->level);
> 
> in the code is clearer and shorter. Ditto for the other helper
> functions.
OK.

> 
> > +{
> > +	u64 msr_val;
> > +	int msr;
> > +
> > +	msr = (level == CORE_LEVEL) ? MSR_IA32_THERM_STATUS :
> > +			MSR_IA32_PACKAGE_THERM_STATUS;
> 
> Make that a normal if-else statement for better readability:
> 
OK

> 	if (level == CORE_LEVEL)
> 		msr = MSR_IA32_THERM_STATUS;
> 	else
> 		msr = MSR_IA32_PACKAGE_THERM_STATUS;
> 
> > +	rdmsrl(msr, msr_val);
> 
> Is that rdmsrl() always going to succeed here or you need to handle a
> possible error it returns?
> 
It should not.
They are architectural MSRs and the fact that we are getting called
means that they are enabled by looking at CPUID bits. Also this MSR was
read before once in intel_thermal_interrupt(). 


> > +	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);
> 
> Same here.

> 
It shouldn't fail for local CPU write. But I can add error handling.


> > +}
> > +
> > +static void therm_throt_get_therm_status(int level, int *proc_hot,
> > int *temp)
> > +{
> > +	u64 msr_val;
> > +	int msr;
> > +
> > +	msr = (level == CORE_LEVEL) ? MSR_IA32_THERM_STATUS :
> > +			MSR_IA32_PACKAGE_THERM_STATUS;
> > +	rdmsrl(msr, msr_val);
> > +	*proc_hot = msr_val & THERM_STATUS_PROCHOT_LOG ? 1 : 0;
> > +	*temp = (msr_val >> 16) & 0x7F;
> 
> Same comments as for the therm_throt_clear_therm_status_log()
> function above.
> 
OK

> ...
> 
> > @@ -178,27 +292,23 @@ static void therm_throt_process(bool
> > new_event, int event, int level)
> >  	if (new_event)
> >  		state->count++;
> >  
> > -	if (time_before64(now, state->next_check) &&
> > -			state->count != state->last_count)
> > -		return;
> > +	if (event == THERMAL_THROTTLING_EVENT) {
> 
> Save an indentation level:
> 
OK

Thanks,
Srinivas

> 	if (event != THERMAL_THROTTLING_EVENT)
> 		return;
> 
> 	/* next statement starts here */
> 
> > +		if (new_event && !state->last_interrupt_time) {
> > +			int hot;
> >  
> > -	state->next_check = now + CHECK_INTERVAL;
> > -	state->last_count = state->count;
> > +			therm_throt_get_therm_status(state->level,
> > &hot, &state->baseline_temp);
> >  
> > -	/* if we just entered the thermal event */
> > -	if (new_event) {
> > -		if (event == THERMAL_THROTTLING_EVENT)
> > -			pr_crit("CPU%d: %s temperature above threshold,
> > cpu clock throttled (total events = %lu)\n",
> > -				this_cpu,
> > -				level == CORE_LEVEL ? "Core" :
> > "Package",
> > -				state->count);
> > -		return;
> > -	}
> > -	if (old_event) {
> > -		if (event == THERMAL_THROTTLING_EVENT)
> > -			pr_info("CPU%d: %s temperature/speed normal\n",
> > this_cpu,
> > -				level == CORE_LEVEL ? "Core" :
> > "Package");
> > -		return;
> > +			state->last_interrupt_time = now;
> > +			schedule_delayed_work_on(this_cpu, &state-
> > >therm_work, THERM_THROT_POLL_INTERVAL);
> > +		} else if (old_event && state->last_interrupt_time) {
> > +			unsigned long throttle_time;
> > +
> > +			throttle_time = jiffies_delta_to_msecs(now -
> > state->last_interrupt_time);
> > +			if (throttle_time > state->max_time_ms)
> > +				state->max_time_ms = throttle_time;
> > +			state->total_time_ms += throttle_time;
> > +			state->last_interrupt_time = 0;
> > +		}
> >  	}
> >  }
> >  
> 
> 


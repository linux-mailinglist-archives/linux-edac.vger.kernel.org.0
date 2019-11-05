Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C636F001C
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 15:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfKEOoS (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 09:44:18 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54114 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfKEOoR (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 09:44:17 -0500
Received: from zn.tnic (p200300EC2F0EF00014F02C62D0694FB9.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f000:14f0:2c62:d069:4fb9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 270BA1EC0CB8;
        Tue,  5 Nov 2019 15:44:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572965056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VpSAlt6edIjnE8MNxyOisqx7xUvh0XkQDCwZA8ai14Q=;
        b=XYg3pQo9Xa5JpDUVz7atImKu8+SJG06T51F+wF9XEhaEhNwgKV6dofGiGunzyB1V6goYL0
        XAGDwn/6uPUh8i4exG//WjDt/7PV7hc0/9aeOLfvSKahRNEuv6odqVL0RG/9s1xzMUmCKF
        lmeDYv6Ouk2moGKcS9lfEzOJ8K+d2Sk=
Date:   Tue, 5 Nov 2019 15:44:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, bberg@redhat.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, ckellner@redhat.com
Subject: Re: [RFC][PATCH] x86, mce, therm_throt: Optimize notifications of
 thermal throttle
Message-ID: <20191105144411.GC28418@zn.tnic>
References: <20191025001924.10199-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025001924.10199-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Thu, Oct 24, 2019 at 05:19:24PM -0700, Srinivas Pandruvada wrote:
> Some modern systems have very tight thermal tolerances. Because of this
> they may cross thermal thresholds when running normal workloads (even
> during boot). The CPU hardware will react by limiting power/frequency
> and using duty cycles to bring the temperature back into normal range.
> 
> Thus users may see a "critical" message about the "temperature above
> threshold" which is soon followed by "temperature/speed normal". These
> messages are rate limited, but still may repeat every few minutes.

rate-limited

> A test run on a laptop with Intel 8th Gen i5 core for two hours with a
> workload resulted in 20K+ thermal interrupts per CPU for core level and
> another 20K+ interrupts at package level. The kernel logs were full of
> throttling messages.
> 
> Brief background, on why there are so many thermal interrupts in a
> modern system:
> From IvyBridge, there is another offset called TCC offset is introduced.

That sentence needs fixing.

> This adds an offset to the real PROCHOT temperature target. So effectively
> this interrupt is generated much before the PROCHOT. There will be several
> very short throttling by the processor using adaptive thermal monitoring
  ^^^^^^^^^^^^^^^^^^^^^^

"There will be several very short throttling" reads funny.

> at this threshold, instead of more aggressive action close to PROCHOT.
> This offset is configured by OEMs and some tend to be more conservative
> than others. So logging such events just generates noise in the logs.
> 
> The real value of these threshold interrupts, is to debug problems with
> the external cooling solutions and performance issues due to excessive
> throttling.
> 
> So the solution here:
> - Show in the current thermal_throttle folder, the maximum time for one
> throttling event and total amount of time, the system was in throttling
> state.
> - Don't log short excursions.
> - Log only when, in spite of thermal throttling the temperature is rising.
> This is done by monitoring temperature trend using three point moving
> average. On the high threshold interrupt trigger a delayed workqueue,
> which monitors the threshold violation log bit, calculates moving moving

What is the "threshold violation log bit" ? THERM_STATUS_PROCHOT_LOG ?

s/moving moving/moving/

Please read your commit message before sending to check whether it makes
any sense. Commit messages are not write-only.

> average and logs when temperature trend is raising. When the log bit is
> clear and temperature is below threshold temperature, it will print
> "Normal" message. Once a high threshold event is logged, it rate limits
> number of log messages.
> - Reduce the logging severity to warning.

I already took the reducing printk severity patch, you'd need to redo
yours ontop of tip/master.

> With this patch, on the same test laptop, no warnings are printed in logs
> as the max time the processor could bring the temperature under control is
> only 280 ms.
> 
> This implementation is done with the inputs from Alan Cox and Tony Luck.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/mce/therm_throt.c | 193 +++++++++++++++++++++++---
>  1 file changed, 172 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/therm_throt.c b/arch/x86/kernel/cpu/mce/therm_throt.c
> index 6e2becf547c5..e06f8d475207 100644
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -47,8 +47,19 @@ struct _thermal_state {
>  	bool			new_event;
>  	int			event;
>  	u64			next_check;
> +	u64			last_interrupt_time;
> +	struct delayed_work	therm_work;
>  	unsigned long		count;
>  	unsigned long		last_count;
> +	unsigned long		max_time_ms;
> +	unsigned long		total_time_ms;
> +	int			rate_control_active;

That wants to be a bool judging by the context it is used in.

> +	int			level;
> +	int			sample_index;
> +	int			sample_count;
> +	int			average;
> +	int			baseline_temp;
> +	u8			temp_samples[3];

All these new members (and old members) should be documented what they
are. Like, what is "max_time_ms", for example? I can find out from the
sysfs func names below but having comments explaining what those are is
much better.

>  };
>  
>  struct thermal_state {
> @@ -121,8 +132,22 @@ define_therm_throt_device_one_ro(package_throttle_count);
>  define_therm_throt_device_show_func(package_power_limit, count);
>  define_therm_throt_device_one_ro(package_power_limit_count);
>  
> +define_therm_throt_device_show_func(core_throttle, max_time_ms);
> +define_therm_throt_device_one_ro(core_throttle_max_time_ms);
> +
> +define_therm_throt_device_show_func(package_throttle, max_time_ms);
> +define_therm_throt_device_one_ro(package_throttle_max_time_ms);
> +
> +define_therm_throt_device_show_func(core_throttle, total_time_ms);
> +define_therm_throt_device_one_ro(core_throttle_total_time_ms);
> +
> +define_therm_throt_device_show_func(package_throttle, total_time_ms);
> +define_therm_throt_device_one_ro(package_throttle_total_time_ms);
> +
>  static struct attribute *thermal_throttle_attrs[] = {
>  	&dev_attr_core_throttle_count.attr,
> +	&dev_attr_core_throttle_max_time_ms.attr,
> +	&dev_attr_core_throttle_total_time_ms.attr,
>  	NULL
>  };
>  
> @@ -135,6 +160,95 @@ static const struct attribute_group thermal_attr_group = {
>  #define CORE_LEVEL	0
>  #define PACKAGE_LEVEL	1
>  
> +#define THERM_THROT_POLL_INTERVAL	HZ
> +#define THERM_STATUS_PROCHOT_LOG	BIT(1)
> +
> +static void therm_throt_clear_therm_status_log(int level)

That's a static function, called only once so prepending its name with
the "therm_throt_" prefix is pointless and doesn't help readability.
Having simply

	clear_therm_status_log(state->level);

in the code is clearer and shorter. Ditto for the other helper functions.

> +{
> +	u64 msr_val;
> +	int msr;
> +
> +	msr = (level == CORE_LEVEL) ? MSR_IA32_THERM_STATUS :
> +			MSR_IA32_PACKAGE_THERM_STATUS;

Make that a normal if-else statement for better readability:

	if (level == CORE_LEVEL)
		msr = MSR_IA32_THERM_STATUS;
	else
		msr = MSR_IA32_PACKAGE_THERM_STATUS;

> +	rdmsrl(msr, msr_val);

Is that rdmsrl() always going to succeed here or you need to handle a
possible error it returns?

> +	wrmsrl(msr, msr_val & ~THERM_STATUS_PROCHOT_LOG);

Same here.

> +}
> +
> +static void therm_throt_get_therm_status(int level, int *proc_hot, int *temp)
> +{
> +	u64 msr_val;
> +	int msr;
> +
> +	msr = (level == CORE_LEVEL) ? MSR_IA32_THERM_STATUS :
> +			MSR_IA32_PACKAGE_THERM_STATUS;
> +	rdmsrl(msr, msr_val);
> +	*proc_hot = msr_val & THERM_STATUS_PROCHOT_LOG ? 1 : 0;
> +	*temp = (msr_val >> 16) & 0x7F;

Same comments as for the therm_throt_clear_therm_status_log() function above.

...

> @@ -178,27 +292,23 @@ static void therm_throt_process(bool new_event, int event, int level)
>  	if (new_event)
>  		state->count++;
>  
> -	if (time_before64(now, state->next_check) &&
> -			state->count != state->last_count)
> -		return;
> +	if (event == THERMAL_THROTTLING_EVENT) {

Save an indentation level:

	if (event != THERMAL_THROTTLING_EVENT)
		return;

	/* next statement starts here */

> +		if (new_event && !state->last_interrupt_time) {
> +			int hot;
>  
> -	state->next_check = now + CHECK_INTERVAL;
> -	state->last_count = state->count;
> +			therm_throt_get_therm_status(state->level, &hot, &state->baseline_temp);
>  
> -	/* if we just entered the thermal event */
> -	if (new_event) {
> -		if (event == THERMAL_THROTTLING_EVENT)
> -			pr_crit("CPU%d: %s temperature above threshold, cpu clock throttled (total events = %lu)\n",
> -				this_cpu,
> -				level == CORE_LEVEL ? "Core" : "Package",
> -				state->count);
> -		return;
> -	}
> -	if (old_event) {
> -		if (event == THERMAL_THROTTLING_EVENT)
> -			pr_info("CPU%d: %s temperature/speed normal\n", this_cpu,
> -				level == CORE_LEVEL ? "Core" : "Package");
> -		return;
> +			state->last_interrupt_time = now;
> +			schedule_delayed_work_on(this_cpu, &state->therm_work, THERM_THROT_POLL_INTERVAL);
> +		} else if (old_event && state->last_interrupt_time) {
> +			unsigned long throttle_time;
> +
> +			throttle_time = jiffies_delta_to_msecs(now - state->last_interrupt_time);
> +			if (throttle_time > state->max_time_ms)
> +				state->max_time_ms = throttle_time;
> +			state->total_time_ms += throttle_time;
> +			state->last_interrupt_time = 0;
> +		}
>  	}
>  }
>  

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

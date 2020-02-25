Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90C2016BDCD
	for <lists+linux-edac@lfdr.de>; Tue, 25 Feb 2020 10:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbgBYJqu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 25 Feb 2020 04:46:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:36307 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBYJqu (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 25 Feb 2020 04:46:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 01:46:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,483,1574150400"; 
   d="scan'208";a="317038412"
Received: from spandruv-mobl3.jf.intel.com ([10.254.107.199])
  by orsmga001.jf.intel.com with ESMTP; 25 Feb 2020 01:46:43 -0800
Message-ID: <9edd2470285db5cf38556d00cfc56215069b2d4c.camel@linux.intel.com>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where
 throttle_active_work() is called on behalf of an offline CPU
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Date:   Tue, 25 Feb 2020 01:46:43 -0800
In-Reply-To: <87lforn5xr.fsf@nanos.tec.linutronix.de>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
         <20200222175151.GD11284@zn.tnic>
         <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com>
         <20200224125525.GA29318@zn.tnic> <87y2ssm0sz.fsf@nanos.tec.linutronix.de>
         <87lforn5xr.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, 2020-02-24 at 20:25 +0100, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Which is wrong as well. Trying to "fix" it in the work queue
> > callback is
> > papering over the root cause.
> > 
> > Why is any work scheduled on an outgoing CPU after this CPU
> > executed
> > thermal_throttle_offline()?
> > 
> > When thermal_throttle_offline() is invoked the cpu bound work
> > queues are
> > still functional and thermal_throttle_offline() cancels outstanding
> > work.
> > 
> > So no, please fix the root cause not the symptom.
> 
> And if you look at thermal_throttle_online() then you'll notice that
> it
> is asymetric vs. thermal_throttle_offline().
> 
> Also you want to do cancel_delayed_work_sync() and not just
> cancel_delayed_work() because only the latter guarantees that the
> work
> is not enqueued anymore while the former does not take running or
> self
> requeueing work into account.
> 
> Something like the untested patch below.
I tested this patch.
After simulating 20 million thermal interrupts and online/offline test
for 12+ hours,  don't see the issue.

So this change fixed the issue.

I can send change on your behalf or you can add
Tested-by: Pandruvada, Srinivas <srinivas.pandruvada@linux.intel.com>

Thanks,
Srinivas

> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/kernel/cpu/mce/therm_throt.c
> +++ b/arch/x86/kernel/cpu/mce/therm_throt.c
> @@ -487,8 +487,12 @@ static int thermal_throttle_offline(unsi
>  	struct thermal_state *state = &per_cpu(thermal_state, cpu);
>  	struct device *dev = get_cpu_device(cpu);
>  
> -	cancel_delayed_work(&state->package_throttle.therm_work);
> -	cancel_delayed_work(&state->core_throttle.therm_work);
> +	/* Mask the thermal vector before draining evtl. pending work
> */
> +	l = apic_read(APIC_LVTTHMR);
> +	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
> +
> +	cancel_delayed_work_sync(&state->package_throttle.therm_work);
> +	cancel_delayed_work_sync(&state->core_throttle.therm_work);
>  
>  	state->package_throttle.rate_control_active = false;
>  	state->core_throttle.rate_control_active = false;


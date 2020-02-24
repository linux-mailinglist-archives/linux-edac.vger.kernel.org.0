Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFABA16B037
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 20:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgBXTZy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 14:25:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50991 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBXTZy (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Feb 2020 14:25:54 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6JMH-0003bs-3P; Mon, 24 Feb 2020 20:25:37 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 891F4104088; Mon, 24 Feb 2020 20:25:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where throttle_active_work() is called on behalf of an offline CPU
In-Reply-To: <87y2ssm0sz.fsf@nanos.tec.linutronix.de>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com> <20200222175151.GD11284@zn.tnic> <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com> <20200224125525.GA29318@zn.tnic> <87y2ssm0sz.fsf@nanos.tec.linutronix.de>
Date:   Mon, 24 Feb 2020 20:25:36 +0100
Message-ID: <87lforn5xr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> Which is wrong as well. Trying to "fix" it in the work queue callback is
> papering over the root cause.
>
> Why is any work scheduled on an outgoing CPU after this CPU executed
> thermal_throttle_offline()?
>
> When thermal_throttle_offline() is invoked the cpu bound work queues are
> still functional and thermal_throttle_offline() cancels outstanding
> work.
>
> So no, please fix the root cause not the symptom.

And if you look at thermal_throttle_online() then you'll notice that it
is asymetric vs. thermal_throttle_offline().

Also you want to do cancel_delayed_work_sync() and not just
cancel_delayed_work() because only the latter guarantees that the work
is not enqueued anymore while the former does not take running or self
requeueing work into account.

Something like the untested patch below.

Thanks,

        tglx
---
--- a/arch/x86/kernel/cpu/mce/therm_throt.c
+++ b/arch/x86/kernel/cpu/mce/therm_throt.c
@@ -487,8 +487,12 @@ static int thermal_throttle_offline(unsi
 	struct thermal_state *state = &per_cpu(thermal_state, cpu);
 	struct device *dev = get_cpu_device(cpu);
 
-	cancel_delayed_work(&state->package_throttle.therm_work);
-	cancel_delayed_work(&state->core_throttle.therm_work);
+	/* Mask the thermal vector before draining evtl. pending work */
+	l = apic_read(APIC_LVTTHMR);
+	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
+
+	cancel_delayed_work_sync(&state->package_throttle.therm_work);
+	cancel_delayed_work_sync(&state->core_throttle.therm_work);
 
 	state->package_throttle.rate_control_active = false;
 	state->core_throttle.rate_control_active = false;

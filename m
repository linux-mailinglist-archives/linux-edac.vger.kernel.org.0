Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B15BC169080
	for <lists+linux-edac@lfdr.de>; Sat, 22 Feb 2020 17:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgBVQxv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Sat, 22 Feb 2020 11:53:51 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:55608 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726198AbgBVQxv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 22 Feb 2020 11:53:51 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20315157-1500050 
        for multiple; Sat, 22 Feb 2020 16:53:32 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        bp@alien8.de, hpa@zytor.com, mingo@redhat.com, tglx@linutronix.de,
        tony.luck@intel.com
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <158239041049.15220.2836895127344585201@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where throttle_active_work() is
 called on behalf of an offline CPU
Date:   Sat, 22 Feb 2020 16:53:30 +0000
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Quoting Srinivas Pandruvada (2020-02-22 16:24:32)
> During cpu-hotplug test with CONFIG_PREEMPTION and CONFIG_DEBUG_PREEMPT
> enabled, Chris reported error:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: kworker/1:0/17
> caller is throttle_active_work+0x12/0x280
> 
> Here throttle_active_work() is a work queue callback scheduled with
> schedule_delayed_work_on(). This will not cause this error for the use
> of smp_processor_id() under normal conditions as there is a check for
> "current->nr_cpus_allowed == 1".
> But when the target CPU is offline the workqueue becomes unbound.
> Then the work queue callback can be scheduled on another CPU and the
> error is printed for the use of smp_processor_id() in preemptible context.
> 
> When the workqueue is not getting called on the target CPU, simply return.
> This is done by adding a cpu field in the _thermal_state struct and match
> the current CPU id.
> 
> Once workqueue is scheduled, prevent CPU offline. In this way, the log
> bits are checked and cleared on the correct CPU. Also use get_cpu() to
> get current CPU id and prevent preemption before we finish processing.
> 
> Fixes: f6656208f04e ("x86/mce/therm_throt: Optimize notifications of thermal throttle")
> Reported-by: Chris Wilson <chris@chris-wilson.co.uk>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

I've pushed the patch to our CI, but it's not a frequent occurrence, so
it may be some time before I can state a t-b with any confidence.
-Chris

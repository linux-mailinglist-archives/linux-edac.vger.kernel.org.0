Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F316AA9E
	for <lists+linux-edac@lfdr.de>; Mon, 24 Feb 2020 17:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbgBXQCC (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 24 Feb 2020 11:02:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50487 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgBXQCC (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 24 Feb 2020 11:02:02 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j6GB3-00070V-1W; Mon, 24 Feb 2020 17:01:49 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A1F5A10408E; Mon, 24 Feb 2020 17:01:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] x86/mce/therm_throt: Handle case where throttle_active_work() is called on behalf of an offline CPU
In-Reply-To: <20200224125525.GA29318@zn.tnic>
References: <20200222162432.497201-1-srinivas.pandruvada@linux.intel.com> <20200222175151.GD11284@zn.tnic> <40989625ca5496a986ca3e595957da83723777f4.camel@linux.intel.com> <20200224125525.GA29318@zn.tnic>
Date:   Mon, 24 Feb 2020 17:01:48 +0100
Message-ID: <87y2ssm0sz.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Sat, Feb 22, 2020 at 04:25:59PM -0800, Srinivas Pandruvada wrote:
>> If the condition is false, will it prevent offline CPU before executing
>> next statement and reschedule on another CPU? Although It will not
>> cause any error or crash but in rare circumstance may print premature
>> warning/normal message based on the current CPU's state.
>
> Why, offline CPU is offline CPU?
>
> Btw, I'm asking whether you can do the simpler thing *instead* of your
> patch. You basically don't run the workqueue callback on offlined CPUs:
>
> 	get_online_cpus();
>
> 	if (cpu_is_offline(smp_processor_id()))
> 		goto out;
>
> 	...
>
>
> out:
> 	put_online_cpus();

Which is wrong as well. Trying to "fix" it in the work queue callback is
papering over the root cause.

Why is any work scheduled on an outgoing CPU after this CPU executed
thermal_throttle_offline()?

When thermal_throttle_offline() is invoked the cpu bound work queues are
still functional and thermal_throttle_offline() cancels outstanding
work.

So no, please fix the root cause not the symptom.

Thanks,

        tglx




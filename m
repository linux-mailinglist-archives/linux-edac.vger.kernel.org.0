Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF41281955
	for <lists+linux-edac@lfdr.de>; Fri,  2 Oct 2020 19:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgJBRdZ (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 2 Oct 2020 13:33:25 -0400
Received: from foss.arm.com ([217.140.110.172]:42458 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBRdZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 2 Oct 2020 13:33:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41D581396;
        Fri,  2 Oct 2020 10:33:24 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7D453F6CF;
        Fri,  2 Oct 2020 10:33:22 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
 <20201002124352.GC17436@zn.tnic>
 <19a8cc62b11c49e9b584857a6a6664e5@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <59950d44-906b-684f-c876-e09c76e5f827@arm.com>
Date:   Fri, 2 Oct 2020 18:33:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <19a8cc62b11c49e9b584857a6a6664e5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shiju,

On 02/10/2020 16:38, Shiju Jose wrote:
>> -----Original Message-----
>> From: Borislav Petkov [mailto:bp@alien8.de]
>> Sent: 02 October 2020 13:44
>> To: Shiju Jose <shiju.jose@huawei.com>
>> Cc: linux-edac@vger.kernel.org; linux-acpi@vger.kernel.org; linux-
>> kernel@vger.kernel.org; tony.luck@intel.com; rjw@rjwysocki.net;
>> james.morse@arm.com; lenb@kernel.org; Linuxarm
>> <linuxarm@huawei.com>
>> Subject: Re: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
>> short time period
>>
>> On Fri, Oct 02, 2020 at 01:22:28PM +0100, Shiju Jose wrote:
>>> Open Questions based on the feedback from Boris, 1. ARM processor
>>> error types are cache/TLB/bus errors.
>>>    [Reference N2.4.4.1 ARM Processor Error Information UEFI Spec v2.8]
>>> Any of the above error types should not be consider for the error
>>> collection and CPU core isolation?

Boris' earlier example was that Bus errors have very little to do with the CPU. It may
just be that this CPU is handling the IRQs for a fault device, and thus receiving the
errors. irqbalance could change that anytime.

I'd prefer we just stick with the caches for now.


>>> 2.If disabling entire CPU core is not acceptable, please suggest
>>> method to disable L1 and L2 cache on ARM64 core?

This is not something linux can do. It may not be possible to do it all.


>> More open questions:
>>
>>> This requirement is the part of the early fault prediction by taking
>>> action when large number of corrected errors reported on a CPU core
>>> before it causing serious faults.
>>
>> And do you know of actual real-life examples where this is really the case? Do
>> you have any users who report a large error count on ARM CPUs, originating
>>from the caches and that something like that would really help?
>>
>> Because from my x86 CPUs limited experience, the cache arrays are mostly
>> fine and errors reported there are not something that happens very
>> frequently so we don't even need to collect and count those.
>>
>> So is this something which you need to have in order to check a box
>> somewhere that there is some functionality or is there an actual real-life use
>> case behind it which a customer has requested?

> We have not got a real-life example for this case. However rare errors
> like this can occur frequently sometimes at scale, which would cause
> more serious issues if not handled.

Don't you need to look across all your 'at scale' machines to know what normal looks like?

I can't see how a reasonable prediction can be made from just one machine's behaviour
since boot. These are corrected errors, nothing has gone wrong.


>> Open question from James with my reply to it:
>>
>> On Thu, Oct 01, 2020 at 06:16:03PM +0100, James Morse wrote:
>>> If the corrected-count is available somewhere, can't this policy be
>>> made in user-space?

> The error count is present in the struct cper_arm_err_info, the fields of
> this structure  are not reported to the user-space through trace events?

> Presently the fields of table struct cper_sec_proc_arm only are reported 
> to the user-space through trace-arm-event.
> Also there can be multiple cper_arm_err_info per cper_sec_proc_arm.
> Thus I think this need reporting through a new trace event?

I think it would be more useful to feed this into edac like ghes.c already does for memory
errors. These would end up as corrected errors counts on devices for L3 or whatever.

This saves fixing your user-space component to the arm specific CPER record format, or
even firmware-first, meaning its useful to the widest number of people.


> Also the logical index of a CPU which I think need to extract from the 'mpidr' field of
> struct cper_sec_proc_arm using platform dependent kernel function get_logical_index().    
> Thus cpu index also need to report to the user space.

I thought you were talking about caches. These structures have a 'level' for cache errors.

Certainly you need a way of knowing which cache it is, and from that number you should
also be able to work out which the CPUs it is attached to.

x86 already has a way of doing this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/x86/resctrl_ui.rst#n327

arm64 doesn't have anything equivalent, but my current proposal for MPAM is here:
https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/feb&id=ce3148bd39509ac8b12f5917f0f92ce014a5b22f

I was hoping the PPTT table would grow something we could use as an ID, but I've not seen
anything yet.


>> You mean rasdaemon goes and offlines CPUs when certain thresholds are
>> reached? Sure. It would be much more flexible too.

> I think adding the CPU error collection to the kernel
> has the following advantages,
>     1. The CPU error collection and isolation would not be active if the
>          rasdaemon stopped running or not running on a machine.

Having CPUs disappear when nothing has gone wrong is deeply surprising. This is going to
be very specific to a small number of people. I bet they want to calculate the threshold
cluster-wide.

Having this policy in user-space means you have the ability to do something much more
useful... e.g move your corrected-error-intolerant workload off the CPU that seems to be
affected.

(If someone who needs to solve this problem by offlining CPUs could chime in, that would
really help)


>     2. Receiving errors and isolating a CPU core from the user-space would
>         probably delayed more,  when large number of errors are reported.

These are corrected errors. Nothing has gone wrong.


>    3. Supporting the interface for configuration parameters and  error statistics etc
>         probably easy to implement in the kernel.

I disagree! Once its added as a kernel interface, we can't change it. Its much better for
these policy-specific algorithms and thresholds to live in user-space. The kernel can just
deal with the unchanging work of making the counter available.


>    4. The interface given for disabling a CPU is easy to use from the kernel level.

Its even easier for privileged user-space:
| echo 0 > /sys/devices/system/cpu/cpu0/online


Thanks,

James

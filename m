Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61B2313CC87
	for <lists+linux-edac@lfdr.de>; Wed, 15 Jan 2020 19:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgAOStH (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 15 Jan 2020 13:49:07 -0500
Received: from foss.arm.com ([217.140.110.172]:41302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728921AbgAOStH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 15 Jan 2020 13:49:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69A3A328;
        Wed, 15 Jan 2020 10:49:06 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD82A3F6C4;
        Wed, 15 Jan 2020 10:49:03 -0800 (PST)
Subject: Re: [PATCH 2/2] drivers: edac: Add EDAC support for Kryo CPU caches
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Borislav Petkov <bp@alien8.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>, tsoni@codeaurora.org,
        psodagud@codeaurora.org, baicar@os.amperecomputing.com
References: <cover.1575529553.git.saiprakash.ranjan@codeaurora.org>
 <0101016ed57a6559-46c6c649-db28-4945-a11c-7441b8e9ac5b-000000@us-west-2.amazonses.com>
 <20191230115030.GA30767@zn.tnic>
 <585db411bc542bf3f326627b7390e0ca@codeaurora.org>
From:   James Morse <james.morse@arm.com>
Message-ID: <04481690-028d-eb74-081d-aebb3ca9b037@arm.com>
Date:   Wed, 15 Jan 2020 18:49:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <585db411bc542bf3f326627b7390e0ca@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi guys,

(CC: +Tyler)

On 13/01/2020 05:44, Sai Prakash Ranjan wrote:
> On 2019-12-30 17:20, Borislav Petkov wrote:
>> On Thu, Dec 05, 2019 at 09:53:18AM +0000, Sai Prakash Ranjan wrote:
>>> Kryo{3,4}XX CPU cores implement RAS extensions to support
>>> Error Correcting Code(ECC). Currently all Kryo{3,4}XX CPU
>>> cores (gold/silver a.k.a big/LITTLE) support ECC via RAS.
>>
>> via RAS what? ARM64_RAS_EXTN?
>>
>> In any case, this needs James to look at and especially if there's some
>> ARM-generic functionality in there which should be shared, of course.

> Yes it is ARM64_RAS_EXTN and I have been hoping if James can provide the feedback,
> it has been some time now since I posted this out.

Sorry, I was out of the office for most of November/December, and I'm slowly catching up...


>>> +
>>> +config EDAC_QCOM_KRYO_POLL
>>> +    depends on EDAC_QCOM_KRYO
>>> +    bool "Poll on Kryo ECC registers"
>>> +    help
>>> +      This option chooses whether or not you want to poll on the Kryo ECC
>>> +      registers. When this is enabled, the polling rate can be set as a
>>> +      module parameter. By default, it will call the polling function every
>>> +      second.
>>
>> Why is this a separate option and why should people use that?
>>
>> Can the polling/irq be switched automatically?

> No it cannot be switched automatically. It is used in case some SoCs do not support an irq
> based mechanism for EDAC.
> But I am contradicting myself because I am telling that atleast one interrupt should be
> specified in bindings,
> so it is best if I drop this polling option for now.

For now, sure. But I think this will come back for systems with embarrassing amounts of
RAM that would rather scrub the errors than take a flood of IRQs. I'd like this to be
controllable from user-space.


>>> diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
>>> index d77200c9680b..29edcfa6ec0e 100644
>>> --- a/drivers/edac/Makefile
>>> +++ b/drivers/edac/Makefile
>>> @@ -85,5 +85,6 @@ obj-$(CONFIG_EDAC_SYNOPSYS)        += synopsys_edac.o
>>>  obj-$(CONFIG_EDAC_XGENE)        += xgene_edac.o
>>>  obj-$(CONFIG_EDAC_TI)            += ti_edac.o
>>>  obj-$(CONFIG_EDAC_QCOM)            += qcom_edac.o
>>> +obj-$(CONFIG_EDAC_QCOM_KRYO)        += qcom_kryo_edac.o
>>
>> What is the difference between this new driver and the qcom_edac one? Can
>> functionality be shared?

High-level story time:
Until the 'v8.2' revision of the 'v8' Arm-architecture (the 64bit one), arm didn't
describe how RAS should work. Partners implemented what they needed, and we ended up with
this collection of drivers because they were all different.

v8.2 fixed all this, the good news is once its done, we should never need another edac
driver. (at least, not for SoCs built for v8.2). The downside is there is quite a lot in
there, and we need to cover ACPI machines as well as DT.

> qcom_edac driver is for QCOM system cache(last level cache), it should be renamed to
> qcom_llcc_edac.c.
> This new driver is for QCOM Kryo CPU core caches(L1,L2,L3).
>
> Functionality cannot be shared as these two are different IP blocks and best kept separate.

The qcom_edac will be Qualcomm's pre-v8.2 support.
This series is about the v8.2 support which all looks totally different to Linux.


>>> + * ARM Cortex-A55, Cortex-A75, Cortex-A76 TRM Chapter B3.3
>>
>> Chapter? Where? URL?
>>
> 
> I chose this because these TRMs are openly available and if you search for these above
> terms like
> "Cortex-A76 TRM Chapter B3.3" in google, then the first search result will be the TRM pdf,
> otherwise
> I would have to specify the long URL for the pdf and we do not know how long that URL link
> will be active.

These are SoC/CPU specific. Using these we can't solve the whole problem.

The architecture all those should fit into is here:
https://static.docs.arm.com/ddi0587/cb/2019_07_05_DD_0587_C_b.pdf
(or https://developer.arm.com/docs/ and look for 'RAS')

... and the arm-arm.


>>> +static void dump_syndrome_reg(int error_type, int level,
>>> +                  u64 errxstatus, u64 errxmisc,
>>> +                  struct edac_device_ctl_info *edev_ctl)
>>> +{
>>> +    char msg[KRYO_EDAC_MSG_MAX];
>>> +    const char *error_msg;
>>> +    int cpu;
>>> +
>>> +    cpu = raw_smp_processor_id();
>>
>> Why raw_?
>>
> 
> Because we will be calling smp_processor_id in preemptible context and if we enable
> CONFIG_DEBUG_PREEMPT,
> we would get a nice backtrace.
> 
> [    3.747468] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
> [    3.755527] caller is qcom_kryo_edac_probe+0x138/0x2b8
> [    3.760819] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G S               
> 5.4.0-rc7-next-20191113-00009-g8666855d6a5b-dirty #107
> [    3.772323] Hardware name: Qualcomm Technologies, Inc. SM8150 MTP (DT)
> [    3.779030] Call trace:
> [    3.781556]  dump_backtrace+0x0/0x158
> [    3.785331]  show_stack+0x14/0x20
> [    3.788741]  dump_stack+0xb0/0xf4
> [    3.792164]  debug_smp_processor_id+0xd8/0xe0
> [    3.796639]  qcom_kryo_edac_probe+0x138/0x2b8
> [    3.801116]  platform_drv_probe+0x50/0xa8
> [    3.805236]  really_probe+0x108/0x360
> [    3.808999]  driver_probe_device+0x58/0x100
> [    3.813304]  device_driver_attach+0x6c/0x78
> [    3.817606]  __driver_attach+0xb0/0xf0
> [    3.821459]  bus_for_each_dev+0x68/0xc8
> [    3.825407]  driver_attach+0x20/0x28
> [    3.829083]  bus_add_driver+0x160/0x1f0
> [    3.833030]  driver_register+0x60/0x110
> [    3.836976]  __platform_driver_register+0x40/0x48
> [    3.841813]  qcom_kryo_edac_driver_init+0x18/0x20
> [    3.846645]  do_one_initcall+0x58/0x1a0
> [    3.850596]  kernel_init_freeable+0x19c/0x240
> [    3.855075]  kernel_init+0x10/0x108
> [    3.858665]  ret_from_fork+0x10/0x1c

and raw_ stops the backtrace? You are still preemptible. The problem still exists, you've
just suppressed the warning.

At any time in dump_syndrome_reg(), you could get an interrupt and another task gets
scheduled. Later your thread is started on another cpu... but not the one whose cpu number
you read from smp_processor_id(). Whatever you needed it for, might have the wrong value.


>>> +static int kryo_l1_l2_setup_irq(struct platform_device *pdev,
>>> +                struct edac_device_ctl_info *edev_ctl)
>>> +{
>>> +    int cpu, errirq, faultirq, ret;
>>> +
>>> +    edac_dev = devm_alloc_percpu(&pdev->dev, *edac_dev);
>>> +    if (!edac_dev)
>>> +        return -ENOMEM;
>>> +
>>> +    for_each_possible_cpu(cpu) {
>>> +        preempt_disable();
>>> +        per_cpu(edac_dev, cpu) = edev_ctl;
>>> +        preempt_enable();
>>> +    }
>>
>> That sillyness doesn't belong here, if at all.

> Sorry but I do not understand the sillyness here. Could you please explain?

preempt_disable() prevents another task being scheduled instead of you, avoiding the risk
that you get scheduled on another cpu. In this case it doesn't matter which cpu you are
running on as you aren't accessing _this_ cpu's edac_dev, you are accessing each one in a
loop.


Thanks,

James

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D86E44832
	for <lists+linux-edac@lfdr.de>; Thu, 13 Jun 2019 19:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393387AbfFMRFV (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 13 Jun 2019 13:05:21 -0400
Received: from foss.arm.com ([217.140.110.172]:47566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729463AbfFMRFT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 13 Jun 2019 13:05:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4346E3EF;
        Thu, 13 Jun 2019 10:05:18 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E835E3F694;
        Thu, 13 Jun 2019 10:05:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     "Hawa, Hanna" <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <3129ed19-0259-d227-0cff-e9f165ce5964@arm.com>
 <4514bfa2-68b2-2074-b817-2f5037650c4e@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <fdc3b458-96eb-1734-c294-2463f37f2244@arm.com>
Date:   Thu, 13 Jun 2019 18:05:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4514bfa2-68b2-2074-b817-2f5037650c4e@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hawa,

On 11/06/2019 20:56, Hawa, Hanna wrote:
> James Morse wrote:
>> Hawa, Hanna wrote:
>>> +    edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
>>
>> How do we know this was corrected?
>>
>> 6.4.8 "Error Correction Code" has "Double-bit ECC errors set the fatal bit." in a
>> paragraph talking about the L1 memory system.

> I'll check fatal field to check if it's uncorrected/corrected.


>>> +    edac_printk(KERN_CRIT, DRV_NAME, "CPU%d L1 %serror detected\n",
>>> +            cpu, (fatal) ? "Fatal " : "");
>>> +    edac_printk(KERN_CRIT, DRV_NAME, "RAMID=");
>>> +
>>> +    switch (ramid) {
>>> +    case ARM_CA57_L1_I_TAG_RAM:
>>> +        pr_cont("'L1-I Tag RAM' index=%d way=%d", index, way);
>>> +        break;
>>> +    case ARM_CA57_L1_I_DATA_RAM:
>>> +        pr_cont("'L1-I Data RAM' index=%d bank= %d", index, way);
>>> +        break;
>>
>> Is index/way information really useful? I can't replace way-3 on the system, nor can I
>> stop it being used. If its useless, I'd rather we don't bother parsing and printing it out.

> I'll remove the index/way information, and keep CPUMERRSR_EL1 value print (who want this
> information can parse the value and get the index/bank status)

Good idea, just print it raw.


>>> +    pr_cont(", repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)\n", repeat, other,
>>> +        val);
>>
>> 'other' here is another error, but we don't know the ramid.
>> 'repeat' is another error for the same ramid.
>>
>> Could we still feed this stuff into edac? This would make the counters accurate if the
>> polling frequency isn't quite fast enough.

> There is no API in EDAC to increase the counters, I can increase by accessing the
> ce_count/ue_count from edac_device_ctl_info/edac_device_instance structures if it's okay..

Ah, sorry, I was thinking of the edac_mc_handle_error(), which has an error_count parameter.

(I wouldn't go poking in the structures directly).


>>> +static void al_a57_edac_l2merrsr(void *arg)
>>> +{
>>
>>> +    edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
>>
>> How do we know this is corrected?

>> If looks like L2CTLR_EL1[20] might force fatal 1/0 to map to uncorrected/corrected. Is
>> this what you are depending on here?

> No - not on this. Reporting all the errors as corrected seems to be bad.
> 
> Can i be depends on fatal field?

That is described as "set to 1 on the first memory error that caused a Data Abort". I
assume this is one of the parity-error external-aborts.

If the repeat counter shows, say, 2, and fatal is set, you only know that at least one of
these errors caused an abort. But it could have been all three. The repeat counter only
matches against the RAMID and friends, otherwise the error is counted in 'other'.

I don't think there is a right thing to do here, (other than increase the scrubbing
frequency). As you can only feed one error into edac at a time then:

> if (fatal)
>     edac_device_handle_ue(edac_dev, 0, 0, "L2 Error");
> else
>     edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");

seems reasonable. You're reporting the most severe, and 'other/repeat' counter values just
go missing.


> How can L2CTLR_EL1[20] force fatal?

I don't think it can, on a second reading, it looks to be even more complicated than I
thought! That bit is described as disabling forwarding of uncorrected data, but it looks
like the uncorrected data never actually reaches the other end. (I'm unsure what 'flush'
means in this context.)
I was looking for reasons you could 'know' that any reported error was corrected. This was
just a bad suggestion!


>> (it would be good to have a list of integration-time and firmware dependencies this driver
>> has, for the next person who tries to enable it on their system and complains it doesn't
>> work for them)

> Where can i add such information?

The mailing list archive is good enough. I'll ask about any obvious dependency I spot from
the TRM, (e.g. that list at the top of my first reply). If you know of anything weird
please call it out.


>>> +    pr_cont(", cpuid/way=%d, repeat=%d, other=%d (L2MERRSR_EL1=0x%llx)\n",
>>> +        way, repeat, other, val);
>>
>> cpuid could be useful if you can map it back to the cpu number linux has.
>> If you can spot that cpu-7 is experiencing more errors than it should, you can leave it
>> offline.
>>
>> To do this you'd need to map each L2MERRSR_EL1's '0-3' range back to the CPUs they
>> actually are. The gic's 'ppi-partitions' does this with phandles, e.g.
>> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml. You could add a
>> similar shaped thing to the l2-cacheX node in the DT, (or in your edac node, but it is a
>> property of the cache integration).

> As in L1 prints, I'll remove non-relevant prints.

Fair enough.


>>> +    /*
>>> +     * Use get_online_cpus/put_online_cpus to prevent the online CPU map
>>> +     * changing while reads the L1/L2 error status
>>
>> For walking the list of offline cpus, this makes sense. But you schedule work without
>> waiting, it may get run after you drop the cpus_read_lock()...,

> Will update the smp_call_function_single() call function to wait.


>>> +    for_each_online_cpu(cpu) {
>>> +        /* Check L1 errors */
>>> +        smp_call_function_single(cpu, al_a57_edac_cpumerrsr, edac_dev,
>>> +                     0);
>>
>> As you aren't testing for big/little, wouldn't on_each_cpu() here be simpler?

> Could be simpler for L1, how can be implemented for L2?

You'd need bitmasks for each cluster to feed to smp_call_function_any().


>>> +        cluster = topology_physical_package_id(cpu);
>>
>> Hmm, I'm not sure cluster==package is guaranteed to be true forever.
>>
>> If you describe the L2MERRSR_EL1 cpu mapping in your DT you could use that. Otherwise
>> pulling out the DT using something like the arch code's parse_cluster().

> I rely on that it's alpine SoC specific driver.

... and that the topology code hasn't changed to really know what a package is:
https://lore.kernel.org/lkml/20190529211340.17087-2-atish.patra@wdc.com/T/#u

As what you really want to know is 'same L2?', and you're holding the cpu_read_lock(),
would struct cacheinfo's shared_cpu_map be a better fit?

This would be done by something like a cpu-mask of cache:shared_cpu_map's for the L2's
you've visited. It removes the dependency on package==L2, and insulates you from the
cpu-numbering not being exactly as you expect.


>>> +        if (cluster != last_cluster) {
>>> +            smp_call_function_single(cpu, al_a57_edac_l2merrsr,
>>> +                         edac_dev, 0);
>>> +            last_cluster = cluster;
>>> +        }
>>
>> Here you depend on the CPUs being listed in cluster-order in the DT. I'm fairly sure the
>> numbering is arbitrary: On my Juno 0,3,4,5 are the A53 cluster, and 1,2 are the A57
>> cluster.
>>
>> If 1,3,5 were cluster-a and 2,4,6 were cluster-b, you would end up calling
>> al_a57_edac_l2merrsr() for each cpu. As you don't wait, they could race.
>>
>> If you can get a cpu-mask for each cluster, smp_call_function_any() would to the
>> pick-one-online-cpu work for you.

> Again, I rely on that it's alpine SoC specific driver.
> How can I get cpu-mask for each cluster? from DT?

Its not cluster you want, its the L2. Cacheinfo has this for online CPUs, and you're
already holding the cpus_read_lock().


>>> +static int al_a57_edac_remove(struct platform_device *pdev)
>>> +{
>>> +    struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
>>> +
>>> +    edac_device_del_device(edac_dev->dev);
>>> +    edac_device_free_ctl_info(edac_dev);
>>
>> Your poll function schedule work on other CPUs and didn't wait, is it possible
>> al_a57_edac_l2merrsr() is still using this memory when you free it?

> This will be okay, after using wait in smp_call_function_single().

Yup.


Thanks,

James

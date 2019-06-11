Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF69B3D754
	for <lists+linux-edac@lfdr.de>; Tue, 11 Jun 2019 21:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405552AbfFKT4Q (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 11 Jun 2019 15:56:16 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:35777 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405842AbfFKT4P (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Tue, 11 Jun 2019 15:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1560282974; x=1591818974;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=R5br7IElddjnk4pkmv3FlnZbYzQWxT3uOzelLK46Guk=;
  b=cfQZF+GtcY6n+3y0esYrGj7BD/Bk8nSqKDW+kw64FOeSFqmT3astdTkR
   PLIg5dRZp0hkhrB29DoD4ysi9Qb7X4R8uZ5+K/79woBTqQ8aa0mlnHobK
   +KMnOZ7KpuZzfrgbnym4/ZDrrXKdQ1TUrer5MnvjZz7DoftMA4pS9ieEa
   w=;
X-IronPort-AV: E=Sophos;i="5.62,362,1554768000"; 
   d="scan'208";a="769918988"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 11 Jun 2019 19:56:13 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-37fd6b3d.us-east-1.amazon.com (Postfix) with ESMTPS id D0659282347;
        Tue, 11 Jun 2019 19:56:09 +0000 (UTC)
Received: from EX13D08UEE001.ant.amazon.com (10.43.62.126) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 11 Jun 2019 19:56:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D08UEE001.ant.amazon.com (10.43.62.126) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 11 Jun 2019 19:56:08 +0000
Received: from [10.95.67.243] (10.95.67.243) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server (TLS) id 15.0.1367.3 via Frontend
 Transport; Tue, 11 Jun 2019 19:56:04 +0000
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     James Morse <james.morse@arm.com>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <davem@davemloft.net>,
        <gregkh@linuxfoundation.org>, <nicolas.ferre@microchip.com>,
        <paulmck@linux.ibm.com>, <dwmw@amazon.co.uk>, <benh@amazon.com>,
        <ronenk@amazon.com>, <talel@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <linux-edac@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
 <3129ed19-0259-d227-0cff-e9f165ce5964@arm.com>
From:   "Hawa, Hanna" <hhhawa@amazon.com>
Message-ID: <4514bfa2-68b2-2074-b817-2f5037650c4e@amazon.com>
Date:   Tue, 11 Jun 2019 22:56:02 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <3129ed19-0259-d227-0cff-e9f165ce5964@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi James,

> 
> Allowing linux to access these implementation-defined registers has come up before:
> https://www.spinics.net/lists/kernel/msg2750349.html
> 
> It looks like you've navigated most of the issues. Accessing implementation-defined
> registers is frowned on, but this stuff can't be done generically until v8.2.
Sure, no planning to do this generally for all ARM a57/a72. I'm doing 
this specific for alpine SoCs.

> 
> This can't be done on 'all A57/A72' because some platforms may not have been integrated to
> have error-checking at L1/L2, (1.3 'Features' of [0] says the ECC protection for L1 data
> cache etc is optional). Even if they did, this stuff needs turning on in L2CTLR_EL1.
> These implementation-defined registers may be trapped by the hypervisor, I assume for your
> platform this is linux booted at EL2, so no hypervisor.
In Alpine-v2/Alpine-v3 Bit[21]-"ECC and parity enable" in L2CTRL_EL1 is 
enabled in the firmware.

> 
> 
>> +#define ARM_CA57_CPUMERRSR_INDEX_OFF		(0)
>> +#define ARM_CA57_CPUMERRSR_INDEX_MASK		(0x3FFFF)
> 
> (GENMASK() would make it quicker and easier to compare this with the datasheet)
Will be used in next patchset.

> 
> 
>> +#define  ARM_CA57_L2_INC_PLRU_RAM		0x18
> 
> A57 describes this one as 'PF RAM'...
will be updated.

> 
> 
> 
> Linux supports versions of binutils that choke on this syntax.
> See the sys_reg() definitions in arm64's asm/sysreg.h that define something you can feed
> to read_sysreg_s(). It would save having these wrapper functions.
> 
> commit 72c583951526 ("arm64: gicv3: Allow GICv3 compilation with older binutils") for the
> story.
Great, I'll use sys_reg(), read_sysreg_s(), and remove the wrapper 
functions.

> 
> 
> 
> | #define ARM_CA57_CPUMERRSR_VALID	BIT(31)
> | if (!(val & ARM_CA57_CPUMERRSR_VALID))
> 
> would be easier to read, the same goes for 'fatal' as its a single bit.
Will be fixed, here and in al_a57_edac_l2merrsr.

> 
> 
>> +	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
> 
> How do we know this was corrected?
> 
> 6.4.8 "Error Correction Code" has "Double-bit ECC errors set the fatal bit." in a
> paragraph talking about the L1 memory system.
I'll check fatal field to check if it's uncorrected/corrected.

> 
> "L2 Error" ? Copy and paste?
copy/paste mistake, will be fixed.

> 
> 
>> +	edac_printk(KERN_CRIT, DRV_NAME, "CPU%d L1 %serror detected\n",
>> +		    cpu, (fatal) ? "Fatal " : "");
>> +	edac_printk(KERN_CRIT, DRV_NAME, "RAMID=");
>> +
>> +	switch (ramid) {
>> +	case ARM_CA57_L1_I_TAG_RAM:
>> +		pr_cont("'L1-I Tag RAM' index=%d way=%d", index, way);
>> +		break;
>> +	case ARM_CA57_L1_I_DATA_RAM:
>> +		pr_cont("'L1-I Data RAM' index=%d bank= %d", index, way);
>> +		break;
> 
> Is index/way information really useful? I can't replace way-3 on the system, nor can I
> stop it being used. If its useless, I'd rather we don't bother parsing and printing it out.
I'll remove the index/way information, and keep CPUMERRSR_EL1 value 
print (who want this information can parse the value and get the 
index/bank status)

> 
> 
>> +	pr_cont(", repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)\n", repeat, other,
>> +		val);
> 
> 'other' here is another error, but we don't know the ramid.
> 'repeat' is another error for the same ramid.
> 
> Could we still feed this stuff into edac? This would make the counters accurate if the
> polling frequency isn't quite fast enough.
There is no API in EDAC to increase the counters, I can increase by 
accessing the ce_count/ue_count from 
edac_device_ctl_info/edac_device_instance structures if it's okay..

> 
> 
>> +static void al_a57_edac_l2merrsr(void *arg)
>> +{
> 
>> +	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");
> 
> How do we know this is corrected?
> 
> If looks like L2CTLR_EL1[20] might force fatal 1/0 to map to uncorrected/corrected. Is
> this what you are depending on here?
No - not on this. Reporting all the errors as corrected seems to be bad.

Can i be depends on fatal field?

if (fatal)
	edac_device_handle_ue(edac_dev, 0, 0, "L2 Error");
else
	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");

How can L2CTLR_EL1[20] force fatal?

> 
> (it would be good to have a list of integration-time and firmware dependencies this driver
> has, for the next person who tries to enable it on their system and complains it doesn't
> work for them)
Where can i add such information?

> 
> 
>> +	case ARM_CA57_L2_INC_PLRU_RAM:
>> +		pr_cont("'L2 Inclusion PLRU RAM'");
> 
> The A57 TRM describes this as "Inclusion PF RAM", and notes its only in r1p0 or later,
> (but doesn't say what it is). The A72 TRM describes the same encoding as "Inclusion PLRU
> RAM", which is something to do with its replacement policy. It has control bits that A57's
> version doesn't, so these are not the same thing.
> 
> Disambiguating A57/A72 here is a load of faff, 'L2 internal metadata' probably covers both
> cases, but unless these RAMs are replaceable or can be disabled, there isn't much point
> working out which one it was.
Will be fixed to 'L2 internal metadata'

> 
>> +	pr_cont(", cpuid/way=%d, repeat=%d, other=%d (L2MERRSR_EL1=0x%llx)\n",
>> +		way, repeat, other, val);
> 
> cpuid could be useful if you can map it back to the cpu number linux has.
> If you can spot that cpu-7 is experiencing more errors than it should, you can leave it
> offline.
> 
> To do this you'd need to map each L2MERRSR_EL1's '0-3' range back to the CPUs they
> actually are. The gic's 'ppi-partitions' does this with phandles, e.g.
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml. You could add a
> similar shaped thing to the l2-cacheX node in the DT, (or in your edac node, but it is a
> property of the cache integration).
As in L1 prints, I'll remove non-relevant prints.

> 
> 
>> +	/*
>> +	 * Use get_online_cpus/put_online_cpus to prevent the online CPU map
>> +	 * changing while reads the L1/L2 error status
> 
> For walking the list of offline cpus, this makes sense. But you schedule work without
> waiting, it may get run after you drop the cpus_read_lock()...,
Will update the smp_call_function_single() call function to wait.

> 
> 
>> +	get_online_cpus();
> 
> The comment above these helpers is:
> | /* Wrappers which go away once all code is converted */
> 
> cpus_read_lock()?
Will be updated.

> 
> 
>> +	for_each_online_cpu(cpu) {
>> +		/* Check L1 errors */
>> +		smp_call_function_single(cpu, al_a57_edac_cpumerrsr, edac_dev,
>> +					 0);
> 
> As you aren't testing for big/little, wouldn't on_each_cpu() here be simpler?
Could be simpler for L1, how can be implemented for L2?

> 
> As you don't wait, what stops al_a57_edac_cpumerrsr() feeding two errors into
> edac_device_handle_ce() at the same time? Do you need a spinlock in al_a57_edac_cpumerrsr()?
Will call smp_call_function_single() with wait.

> 
> 
>> +		cluster = topology_physical_package_id(cpu);
> 
> Hmm, I'm not sure cluster==package is guaranteed to be true forever.
> 
> If you describe the L2MERRSR_EL1 cpu mapping in your DT you could use that. Otherwise
> pulling out the DT using something like the arch code's parse_cluster().
I rely on that it's alpine SoC specific driver.

> 
> 
>> +		if (cluster != last_cluster) {
>> +			smp_call_function_single(cpu, al_a57_edac_l2merrsr,
>> +						 edac_dev, 0);
>> +			last_cluster = cluster;
>> +		}
> 
> Here you depend on the CPUs being listed in cluster-order in the DT. I'm fairly sure the
> numbering is arbitrary: On my Juno 0,3,4,5 are the A53 cluster, and 1,2 are the A57 cluster.
> 
> If 1,3,5 were cluster-a and 2,4,6 were cluster-b, you would end up calling
> al_a57_edac_l2merrsr() for each cpu. As you don't wait, they could race.
> 
> If you can get a cpu-mask for each cluster, smp_call_function_any() would to the
> pick-one-online-cpu work for you.
Again, I rely on that it's alpine SoC specific driver.
How can I get cpu-mask for each cluster? from DT?

> 
> 
>> +static int al_a57_edac_remove(struct platform_device *pdev)
>> +{
>> +	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
>> +
>> +	edac_device_del_device(edac_dev->dev);
>> +	edac_device_free_ctl_info(edac_dev);
> 
> Your poll function schedule work on other CPUs and didn't wait, is it possible
> al_a57_edac_l2merrsr() is still using this memory when you free it?
This will be okay, after using wait in smp_call_function_single().
> 
> 
>> +MODULE_LICENSE("GPL");
> 
> | MODULE_LICENSE("GPL v2");
> 
> To match the SPDX header?
Will be fixed.

Thanks for your detailed review.

Thanks,
Hanna
> 
> 
> 
> Thanks,
> 
> James
> 
> 
> [0]
> http://infocenter.arm.com/help/topic/com.arm.doc.ddi0488c/DDI0488C_cortex_a57_mpcore_r1p0_trm.pdf
> 

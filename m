Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C26736023
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2019 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfFEPQI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 5 Jun 2019 11:16:08 -0400
Received: from foss.arm.com ([217.140.101.70]:33682 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728046AbfFEPQH (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 5 Jun 2019 11:16:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E69BB374;
        Wed,  5 Jun 2019 08:16:06 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E1813F246;
        Wed,  5 Jun 2019 08:16:03 -0700 (PDT)
Subject: Re: [PATCH 2/2] edac: add support for Amazon's Annapurna Labs EDAC
To:     Hanna Hawa <hhhawa@amazon.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bp@alien8.de,
        mchehab@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, nicolas.ferre@microchip.com,
        paulmck@linux.ibm.com, dwmw@amazon.co.uk, benh@amazon.com,
        ronenk@amazon.com, talel@amazon.com, jonnyc@amazon.com,
        hanochu@amazon.com, linux-edac@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1559211329-13098-1-git-send-email-hhhawa@amazon.com>
 <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <3129ed19-0259-d227-0cff-e9f165ce5964@arm.com>
Date:   Wed, 5 Jun 2019 16:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559211329-13098-3-git-send-email-hhhawa@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Hana,

On 30/05/2019 11:15, Hanna Hawa wrote:
> Add support for error detection and correction for Amazon's Annapurna
> Labs SoCs for L1/L2 caches.
> 
> Amazon's Annapurna Labs SoCs based on ARM CA57 and CA72, the driver
> support both cortex based on compatible string.

> diff --git a/drivers/edac/amazon_al_ca57_edac.c b/drivers/edac/amazon_al_ca57_edac.c
> new file mode 100644
> index 0000000..08237c0
> --- /dev/null
> +++ b/drivers/edac/amazon_al_ca57_edac.c
> @@ -0,0 +1,283 @@
> +// SPDX-License-Identifier: GPL-2.0

> +/* Same bit assignments of CPUMERRSR_EL1 and L2MERRSR_EL1 in ARM CA57/CA72 */

Allowing linux to access these implementation-defined registers has come up before:
https://www.spinics.net/lists/kernel/msg2750349.html

It looks like you've navigated most of the issues. Accessing implementation-defined
registers is frowned on, but this stuff can't be done generically until v8.2.

This can't be done on 'all A57/A72' because some platforms may not have been integrated to
have error-checking at L1/L2, (1.3 'Features' of [0] says the ECC protection for L1 data
cache etc is optional). Even if they did, this stuff needs turning on in L2CTLR_EL1.
These implementation-defined registers may be trapped by the hypervisor, I assume for your
platform this is linux booted at EL2, so no hypervisor.


> +#define ARM_CA57_CPUMERRSR_INDEX_OFF		(0)
> +#define ARM_CA57_CPUMERRSR_INDEX_MASK		(0x3FFFF)

(GENMASK() would make it quicker and easier to compare this with the datasheet)


> +#define  ARM_CA57_L2_TAG_RAM			0x10
> +#define  ARM_CA57_L2_DATA_RAM			0x11
> +#define  ARM_CA57_L2_SNOOP_RAM			0x12
> +#define  ARM_CA57_L2_DIRTY_RAM			0x14

> +#define  ARM_CA57_L2_INC_PLRU_RAM		0x18

A57 describes this one as 'PF RAM'...


> +static inline u64 read_cpumerrsr_el1(void)
> +{
> +	u64 val;
> +
> +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (val));
> +
> +	return val;
> +}

Linux supports versions of binutils that choke on this syntax.
See the sys_reg() definitions in arm64's asm/sysreg.h that define something you can feed
to read_sysreg_s(). It would save having these wrapper functions.

commit 72c583951526 ("arm64: gicv3: Allow GICv3 compilation with older binutils") for the
story.


> +static void al_a57_edac_cpumerrsr(void *arg)
> +{
> +	struct edac_device_ctl_info *edac_dev =
> +		(struct edac_device_ctl_info *)arg;
> +	int cpu;
> +	u32 index, way, ramid, repeat, other, fatal;
> +	u64 val = read_cpumerrsr_el1();
> +
> +	/* Return if no valid error */
> +	if (!((val >> ARM_CA57_CPUMERRSR_VALID_OFF) &
> +	      ARM_CA57_CPUMERRSR_VALID_MASK))
> +		return;

| #define ARM_CA57_CPUMERRSR_VALID	BIT(31)
| if (!(val & ARM_CA57_CPUMERRSR_VALID))

would be easier to read, the same goes for 'fatal' as its a single bit.


> +	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");

How do we know this was corrected?

6.4.8 "Error Correction Code" has "Double-bit ECC errors set the fatal bit." in a
paragraph talking about the L1 memory system.

"L2 Error" ? Copy and paste?


> +	edac_printk(KERN_CRIT, DRV_NAME, "CPU%d L1 %serror detected\n",
> +		    cpu, (fatal) ? "Fatal " : "");
> +	edac_printk(KERN_CRIT, DRV_NAME, "RAMID=");
> +
> +	switch (ramid) {
> +	case ARM_CA57_L1_I_TAG_RAM:
> +		pr_cont("'L1-I Tag RAM' index=%d way=%d", index, way);
> +		break;
> +	case ARM_CA57_L1_I_DATA_RAM:
> +		pr_cont("'L1-I Data RAM' index=%d bank= %d", index, way);
> +		break;

Is index/way information really useful? I can't replace way-3 on the system, nor can I
stop it being used. If its useless, I'd rather we don't bother parsing and printing it out.


> +	pr_cont(", repeat=%d, other=%d (CPUMERRSR_EL1=0x%llx)\n", repeat, other,
> +		val);

'other' here is another error, but we don't know the ramid.
'repeat' is another error for the same ramid.

Could we still feed this stuff into edac? This would make the counters accurate if the
polling frequency isn't quite fast enough.


> +	write_cpumerrsr_el1(0);
> +}


> +static void al_a57_edac_l2merrsr(void *arg)
> +{

> +	edac_device_handle_ce(edac_dev, 0, 0, "L2 Error");

How do we know this is corrected?

If looks like L2CTLR_EL1[20] might force fatal 1/0 to map to uncorrected/corrected. Is
this what you are depending on here?

(it would be good to have a list of integration-time and firmware dependencies this driver
has, for the next person who tries to enable it on their system and complains it doesn't
work for them)


> +	edac_printk(KERN_CRIT, DRV_NAME, "CPU%d L2 %serror detected\n",
> +		    cpu, (fatal) ? "Fatal " : "");
> +	edac_printk(KERN_CRIT, DRV_NAME, "RAMID=");
> +
> +	switch (ramid) {
> +	case ARM_CA57_L2_TAG_RAM:
> +		pr_cont("'L2 Tag RAM'");
> +		break;
> +	case ARM_CA57_L2_DATA_RAM:
> +		pr_cont("'L2 Data RAM'");
> +		break;
> +	case ARM_CA57_L2_SNOOP_RAM:
> +		pr_cont("'L2 Snoop RAM'");
> +		break;
> +	case ARM_CA57_L2_DIRTY_RAM:
> +		pr_cont("'L2 Dirty RAM'");
> +		break;
> +	case ARM_CA57_L2_INC_PLRU_RAM:
> +		pr_cont("'L2 Inclusion PLRU RAM'");

The A57 TRM describes this as "Inclusion PF RAM", and notes its only in r1p0 or later,
(but doesn't say what it is). The A72 TRM describes the same encoding as "Inclusion PLRU
RAM", which is something to do with its replacement policy. It has control bits that A57's
version doesn't, so these are not the same thing.

Disambiguating A57/A72 here is a load of faff, 'L2 internal metadata' probably covers both
cases, but unless these RAMs are replaceable or can be disabled, there isn't much point
working out which one it was.


> +		break;
> +	default:
> +		pr_cont("'unknown'");
> +		break;
> +	}
> +
> +	pr_cont(", cpuid/way=%d, repeat=%d, other=%d (L2MERRSR_EL1=0x%llx)\n",
> +		way, repeat, other, val);

cpuid could be useful if you can map it back to the cpu number linux has.
If you can spot that cpu-7 is experiencing more errors than it should, you can leave it
offline.

To do this you'd need to map each L2MERRSR_EL1's '0-3' range back to the CPUs they
actually are. The gic's 'ppi-partitions' does this with phandles, e.g.
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml. You could add a
similar shaped thing to the l2-cacheX node in the DT, (or in your edac node, but it is a
property of the cache integration).


> +	write_l2merrsr_el1(0);
> +}
> +
> +static void al_a57_edac_check(struct edac_device_ctl_info *edac_dev)
> +{
> +	int cpu, cluster, last_cluster = -1;
> +
> +	/*
> +	 * Use get_online_cpus/put_online_cpus to prevent the online CPU map
> +	 * changing while reads the L1/L2 error status

For walking the list of offline cpus, this makes sense. But you schedule work without
waiting, it may get run after you drop the cpus_read_lock()...,


> +	 */

> +	get_online_cpus();

The comment above these helpers is:
| /* Wrappers which go away once all code is converted */

cpus_read_lock()?


> +	for_each_online_cpu(cpu) {
> +		/* Check L1 errors */
> +		smp_call_function_single(cpu, al_a57_edac_cpumerrsr, edac_dev,
> +					 0);

As you aren't testing for big/little, wouldn't on_each_cpu() here be simpler?

As you don't wait, what stops al_a57_edac_cpumerrsr() feeding two errors into
edac_device_handle_ce() at the same time? Do you need a spinlock in al_a57_edac_cpumerrsr()?


> +		cluster = topology_physical_package_id(cpu);

Hmm, I'm not sure cluster==package is guaranteed to be true forever.

If you describe the L2MERRSR_EL1 cpu mapping in your DT you could use that. Otherwise
pulling out the DT using something like the arch code's parse_cluster().


> +		/* Only single CPU will read the L2 error status */

> +		if (cluster != last_cluster) {
> +			smp_call_function_single(cpu, al_a57_edac_l2merrsr,
> +						 edac_dev, 0);
> +			last_cluster = cluster;
> +		}

Here you depend on the CPUs being listed in cluster-order in the DT. I'm fairly sure the
numbering is arbitrary: On my Juno 0,3,4,5 are the A53 cluster, and 1,2 are the A57 cluster.

If 1,3,5 were cluster-a and 2,4,6 were cluster-b, you would end up calling
al_a57_edac_l2merrsr() for each cpu. As you don't wait, they could race.

If you can get a cpu-mask for each cluster, smp_call_function_any() would to the
pick-one-online-cpu work for you.


> +	}
> +	put_online_cpus();
> +}

> +static int al_a57_edac_remove(struct platform_device *pdev)
> +{
> +	struct edac_device_ctl_info *edac_dev = platform_get_drvdata(pdev);
> +
> +	edac_device_del_device(edac_dev->dev);
> +	edac_device_free_ctl_info(edac_dev);

Your poll function schedule work on other CPUs and didn't wait, is it possible
al_a57_edac_l2merrsr() is still using this memory when you free it?


> +	return 0;
> +}


> +MODULE_LICENSE("GPL");

| MODULE_LICENSE("GPL v2");

To match the SPDX header?



Thanks,

James


[0]
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0488c/DDI0488C_cortex_a57_mpcore_r1p0_trm.pdf

Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7062A9E17
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 20:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgKFTeM (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 14:34:12 -0500
Received: from foss.arm.com ([217.140.110.172]:43996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgKFTeL (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Nov 2020 14:34:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC30D1474;
        Fri,  6 Nov 2020 11:34:10 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 538323F718;
        Fri,  6 Nov 2020 11:34:09 -0800 (PST)
Subject: Re: [PATCH 2/3] drivers/edac: Add L1 and L2 error detection for A53
 and A57
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Robert Richter <rrichter@marvell.com>,
        York Sun <york.sun@nxp.com>, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
References: <20201013125033.4749-1-s.hauer@pengutronix.de>
 <20201013125033.4749-3-s.hauer@pengutronix.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <6ea8a824-ba55-6c5b-993d-4c782e396f32@arm.com>
Date:   Fri, 6 Nov 2020 19:34:07 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201013125033.4749-3-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Sascha,

On 13/10/2020 13:50, Sascha Hauer wrote:
> The Cortex A53 and A57 cores have error detection capabilities for the
> L1/L2 Caches, this patch adds a driver for them.
> 
> Unfortunately there is no robust way to inject errors into the caches,
> so this driver doesn't contain any code to actually test it. It has
> been tested though with code taken from an older version of this driver
> found here: https://lkml.org/lkml/2018/3/14/1203.

> For reasons stated
> in this thread the error injection code is not suitable for mainline,
> so it is removed from the driver.


> diff --git a/drivers/edac/cortex_arm64_l1_l2.c b/drivers/edac/cortex_arm64_l1_l2.c
> new file mode 100644
> index 000000000000..fb8386eb40ac
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_l1_l2.c
> @@ -0,0 +1,208 @@

> +static void read_errors(void *data)
> +{
> +	struct edac_device_ctl_info *edac_ctl = data;
> +	int cpu = smp_processor_id();
> +	char msg[MESSAGE_SIZE];
> +	u64 cpumerr, l2merr;
> +
> +	/* cpumerrsr_el1 */
> +	asm volatile("mrs %0, s3_1_c15_c2_2" : "=r" (cpumerr));
> +	asm volatile("msr s3_1_c15_c2_2, %0" :: "r" (0));

I think you've seen earlier comments on using the sys_reg macros for this. There were
versions of binutils out there that choke on this.

[...]

> +}
> +
> +static void cortex_arm64_edac_check(struct edac_device_ctl_info *edac_ctl)
> +{
> +	struct arm64_pvt *pvt = edac_ctl->pvt_info;
> +	call_single_data_t *csd;
> +	int cpu;
> +
> +	get_online_cpus();
> +	for_each_cpu_and(cpu, cpu_online_mask, &pvt->compat_mask) {
> +		csd = per_cpu_ptr(pvt->csd_check, cpu);
> +		csd->func = read_errors;
> +		csd->info = edac_ctl;
> +		csd->flags = 0;

> +		/* Read CPU L1/L2 errors */
> +		smp_call_function_single_async(cpu, csd);
> +		/* Wait until flags cleared */
> +		smp_cond_load_acquire(&csd->flags, !VAL);

Hmm. We end up waiting for each CPU to schedule something else. I can't see any reason we
can't sleep here.

Can't we use smp_call_function_many() here? It already considers cpu_online_mask, you'd
just need to deal with read_errors() being called in parallel with itself.

(concurrent calls into edac are one problem, but two CPUs read/writing the same L2
register could lead to double counting)


> +	}
> +	put_online_cpus();
> +}


> +static int cortex_arm64_edac_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np, *dn = pdev->dev.of_node;
> +	struct edac_device_ctl_info *edac_ctl;
> +	struct device *dev = &pdev->dev;
> +	struct of_phandle_iterator it;
> +	struct arm64_pvt *pvt;
> +	int rc, cpu;
> +
> +	edac_ctl = edac_device_alloc_ctl_info(sizeof(*pvt), "cpu_cache",
> +					      1, "L", 2, 1, NULL, 0,
> +					      edac_device_alloc_index());

I used this series to test on Juno to poke the user-space interface:
This chokes on a big-little system as it can't register "cpu_cache" a second time.

I think we should try to make the topology look like the one in edac_device.h. This means
calling it 'cpu', and registering all of them up front.
On a big/little system the second probe() call would need to be careful.

I can have a go at this if you don't have a platform to hand.


(The 'L2-cache' thing in edac_device.h turns out to be impossible and the 'Lx' you've done
here is the most popular option. I'll post a patch to change the documentation to what
people are doing)


[...]

> +}


Thanks,

James


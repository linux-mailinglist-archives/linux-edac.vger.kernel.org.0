Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729442E8144
	for <lists+linux-edac@lfdr.de>; Thu, 31 Dec 2020 17:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgLaQox (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Thu, 31 Dec 2020 11:44:53 -0500
Received: from mail.skyhub.de ([5.9.137.197]:52198 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbgLaQow (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Thu, 31 Dec 2020 11:44:52 -0500
Received: from zn.tnic (p200300ec2f124d002bc781a5c0b200e2.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:4d00:2bc7:81a5:c0b2:e2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D0DA1EC0118;
        Thu, 31 Dec 2020 17:44:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1609433050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YYvhz9AnthRjVosI8l9DrVzEhZjCTviKSd1FjaNAGJQ=;
        b=OOzWsX8g/IqONmZjAXGcwhODJ43zWHlV3AFNioX7Xlyw1Unl1YlXtNyG1wQ/cdXZ/r5Wqt
        rBMyDHPHKNk3enqwRnyib26JSCgrljIB5rCxoG+JKyQZi4at/fByWqXqhuEm7bIeTIKV8Z
        rIjcirX1PrQ5Aj2eeceBG5laFL16eV0=
Date:   Thu, 31 Dec 2020 17:44:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        mchehab+huawei@kernel.org, tony.luck@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, rrichter@marvell.com, linuxarm@huawei.com,
        xuwei5@huawei.com, jonathan.cameron@huawei.com,
        john.garry@huawei.com, tanxiaofei@huawei.com,
        shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com
Subject: Re: [RFC PATCH 1/2] EDAC/ghes: Add EDAC device for the CPU caches
Message-ID: <20201231164409.GC4504@zn.tnic>
References: <20201208172959.1249-1-shiju.jose@huawei.com>
 <20201208172959.1249-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208172959.1249-2-shiju.jose@huawei.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Tue, Dec 08, 2020 at 05:29:58PM +0000, Shiju Jose wrote:
> The corrected error count on the CPU caches required
> reporting to the user-space for the predictive failure
> analysis. For this purpose, add an EDAC device and device
> blocks for the CPU caches found.
> The cache's corrected error count would be stored in the
> /sys/devices/system/edac/cpu/cpu*/cache*/ce_count.

This still doesn't begin to explain why the kernel needs this. I had
already asked whether errors in CPU caches are something which happen
often enough so that software should count them but nothing came. So pls
justify first why this wants to be added to the kernel.

> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 7a47680d6f07..c73eeab27ac9 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -74,6 +74,16 @@ config EDAC_GHES
>  
>  	  In doubt, say 'Y'.
>  
> +config EDAC_GHES_CPU_ERROR
> +	bool "EDAC device for reporting firmware-first BIOS detected CPU error count"

Why a separate Kconfig item?

> +	depends on EDAC_GHES
> +	help
> +	  EDAC device for the firmware-first BIOS detected CPU error count reported

Well this is not what it is doing - you're talking about cache errors.
"CPU errors" can be a lot more than just cache errors.

> +static void ghes_edac_create_cpu_device(struct device *dev)
> +{
> +	int cpu;
> +	struct cpu_cacheinfo *this_cpu_ci;
> +
> +	/*
> +	 * Find the maximum number of caches present in the CPU heirarchy
> +	 * among the online CPUs.
> +	 */
> +	for_each_online_cpu(cpu) {
> +		this_cpu_ci = get_cpu_cacheinfo(cpu);
> +		if (!this_cpu_ci)
> +			continue;
> +		if (max_number_of_caches < this_cpu_ci->num_leaves)
> +			max_number_of_caches = this_cpu_ci->num_leaves;

So this is counting the number of cache levels on the system? So you
want to count the errors per cache levels?

> +	}
> +	if (!max_number_of_caches)
> +		return;
> +
> +	/*
> +	 * EDAC device interface only supports creating the CPU cache hierarchy for alls
> +	 * the CPUs together. Thus need to allocate cpu_edac_block_list for the
> +	 * max_number_of_caches among all the CPUs irrespective of the number of caches
> +	 * per CPU might vary.
> +	 */

So this is lumping all the caches together into a single list? What for?
To untangle to the proper ones when the error gets reported?

Have you heard of percpu variables?

> @@ -624,6 +787,10 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	ghes_pvt = pvt;
>  	spin_unlock_irqrestore(&ghes_lock, flags);
>  
> +#if defined(CONFIG_EDAC_GHES_CPU_ERROR)
> +	ghes_edac_create_cpu_device(dev);
> +#endif
> +

Init stuff belongs into ghes_scan_system().

...

Ok, I've seen enough. "required reporting to the user-space for the
predictive failure analysis." is not even trying to explain *why* you're
doing this, what *actual* problem it is addressing and why should the
kernel get it.

And without a proper problem definition of what you're trying to solve,
this is not going anywhere.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

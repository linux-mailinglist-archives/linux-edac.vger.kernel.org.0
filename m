Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9415EFC00
	for <lists+linux-edac@lfdr.de>; Tue,  5 Nov 2019 12:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730798AbfKELFY (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 5 Nov 2019 06:05:24 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48468 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbfKELFY (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 5 Nov 2019 06:05:24 -0500
Received: from zn.tnic (p200300EC2F0EF00040535B901ABC1006.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:f000:4053:5b90:1abc:1006])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CDFAD1EC095C;
        Tue,  5 Nov 2019 12:05:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1572951918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DzLmbHnGnVNGSpU/+IxMmFssZJiIE/Z5fsxo5hTr6ZE=;
        b=emA+I4lrVnxwIM15AsbRqLJVAMDtGdYuahaYblX3S2hzSXT0/7RHnQ6qDUn+wKjRdj77of
        InZ27L4mDj7ZM/GDc66+Zxz1MY+rMzuwSX7IdAMKRpa7rrYzd3bCYmgWreKgNSerZe/ryw
        sarQ7C44E/9ElgEuHtukqj7D6CAuV6s=
Date:   Tue, 5 Nov 2019 12:05:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC, ghes: Fix locking and memory barrier issues
Message-ID: <20191105110511.GA28418@zn.tnic>
References: <20191025211226.2444-1-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191025211226.2444-1-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Oct 25, 2019 at 09:13:14PM +0000, Robert Richter wrote:
> The ghes registration and refcount is broken in several ways:
> 
>  * ghes_edac_register() returns with success for a 2nd instance even
>    if a first instance is still running.

How?

There's

        if (atomic_inc_return(&ghes_init) > 1)
                return 0;

there. How would a second instance bypass this?

>  * The refcount was increased even if a registration failed. This
>    leads to stale counters preventing the device from being released.

That I see - the return path should dec ghes_init.

>  * The ghes refcount may not be decremented properly on
>    unregistration. Always decrement the refcount once
>    ghes_edac_unregister() is called to keep the refcount sane.

Right.

>  * The ghes_pvt pointer is handed to the irq handler before
>    registration finished.
> 
>  * The mci structure could be freed while the irq handler is running.
> 
> Fix this by adding a mutex to ghes_edac_register(). This mutex
> serializes instances to register and unregister. The refcount is only
> increased if the registration succeeded. This makes sure the refcount
> is in a consistent state after registering or unregistering a device.
> Note: A spinlock cannot be used here as the code section may sleep.
> 
> The ghes_pvt is protected by ghes_lock now.

This better be documented in the driver with a comment above the
ghes_pvt thing.

I'm assuming the support for multiple instances is going ontop of this?
If so, ghes_pvt needs to be an array or so. Also, if you do that, I
think you should use mc_devices - see edac_mc_find() et al - instead of
growing a special one just for this driver.

> This ensures the pointer
> is not updated before registration was finished or while the irq
> handler is running. It is unset before unregistering the device
> including necessary (implicit) memory barriers making the changes
> visible to other cpus. Thus, the device can not be used anymore by an
> interrupt.
> 
> A refcount is needed. There can be multiple GHES structures being
> defined (see ACPI 6.3 specification, 18.3.2.7 Generic Hardware Error
> Source, "Some platforms may describe multiple Generic Hardware Error
> Source structures with different notification types, ...").
> 
> Another approach to use the mci's device refcount (get_device()) and
> have a release function does not work here. A release function will be
> called only for device_release() with the last put_device() call. The
> device must be deleted *before* that with device_del(). This is only
> possible by maintaining an own refcount.
> 
> Fixes: 0fe5f281f749 ("EDAC, ghes: Model a single, logical memory controller")
> Fixes: 1e72e673b9d1 ("EDAC/ghes: Fix Use after free in ghes_edac remove path")
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 78 ++++++++++++++++++++++++++++------------
>  1 file changed, 56 insertions(+), 22 deletions(-)

...

> @@ -457,10 +461,12 @@ static struct acpi_platform_list plat_list[] = {
>  int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  {
>  	bool fake = false;
> -	int rc, num_dimm = 0;
> +	int rc = 0, num_dimm = 0;
>  	struct mem_ctl_info *mci;
> +	struct ghes_edac_pvt *pvt;
>  	struct edac_mc_layer layers[1];
>  	struct ghes_edac_dimm_fill dimm_fill;
> +	unsigned long flags;
>  	int idx = -1;
>  
>  	if (IS_ENABLED(CONFIG_X86)) {
> @@ -472,11 +478,14 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  		idx = 0;
>  	}
>  
> +	/* finish another registration/unregistration instance first */
> +	mutex_lock(&ghes_reg_mutex);
> +
>  	/*
>  	 * We have only one logical memory controller to which all DIMMs belong.
>  	 */
> -	if (atomic_inc_return(&ghes_init) > 1)
> -		return 0;
> +	if (atomic_inc_not_zero(&ghes_init))

That should probably be called ghes_instances now to make it obvious
what it is.

Also, you can make it a normal variable now since it is being modified
under the mutex only.

> +		goto unlock;
>  
>  	/* Get the number of DIMMs */
>  	dmi_walk(ghes_edac_count_dimms, &num_dimm);
> @@ -494,12 +503,13 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
>  	if (!mci) {
>  		pr_info("Can't allocate memory for EDAC data\n");
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto unlock;
>  	}
>  
> -	ghes_pvt	= mci->pvt_info;
> -	ghes_pvt->ghes	= ghes;
> -	ghes_pvt->mci	= mci;
> +	pvt		= mci->pvt_info;
> +	pvt->ghes	= ghes;
> +	pvt->mci	= mci;
>  
>  	mci->pdev = dev;
>  	mci->mtype_cap = MEM_FLAG_EMPTY;
> @@ -541,23 +551,47 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  	if (rc < 0) {
>  		pr_info("Can't register at EDAC core\n");
>  		edac_mc_free(mci);
> -		return -ENODEV;
> +		rc = -ENODEV;

This needs to "goto unlock".

>  	}
> -	return 0;
> +
> +	spin_lock_irqsave(&ghes_lock, flags);
> +	ghes_pvt = pvt;
> +	spin_unlock_irqrestore(&ghes_lock, flags);
> +
> +	/* only increment on success */
> +	atomic_inc(&ghes_init);
> +
> +unlock:
> +	mutex_unlock(&ghes_reg_mutex);
> +
> +	return rc;
>  }

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

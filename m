Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD452864FC
	for <lists+linux-edac@lfdr.de>; Wed,  7 Oct 2020 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgJGQp0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 7 Oct 2020 12:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:46888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgJGQpT (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 7 Oct 2020 12:45:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 83FAB30E;
        Wed,  7 Oct 2020 09:45:18 -0700 (PDT)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F34DD3F66B;
        Wed,  7 Oct 2020 09:45:16 -0700 (PDT)
Subject: Re: [RFC PATCH 0/7] RAS/CEC: Extend CEC for errors count check on
 short time period
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20201002122235.1280-1-shiju.jose@huawei.com>
 <20201002124352.GC17436@zn.tnic>
 <19a8cc62b11c49e9b584857a6a6664e5@huawei.com>
 <59950d44-906b-684f-c876-e09c76e5f827@arm.com>
 <8d826b53a3fc453ba1c468aaf8eb2e75@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <7d15f48a-3380-6b43-04c7-7f9e67564519@arm.com>
Date:   Wed, 7 Oct 2020 17:45:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <8d826b53a3fc453ba1c468aaf8eb2e75@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shiju,

On 06/10/2020 17:13, Shiju Jose wrote:

[...]

> Please find following pseudo code we added for the kernel side to make sure
> we correctly understand your suggestions.
> 
> 1. Create edac device and edac device sysfs entries for the online CPU caches.
> /drivers/edac/edac_device.c
> struct edac_device_ctl_info  *edac_device_add_cache(unsigned int id, u8 level, u8 type) {

Eh? Ah, you are adding helpers for devices that are a cache. As far as I can see, edac
only cares about 'devices', I don't think this is needed unless there are multiple users,
or it makes a visible difference to user-space.

Otherwise this could just go into ghes_edac.c


How this looks to user-space probably needs discussing. We should avoid inventing anything
new. I'd expect user-space to see something like the structure described at the top of
edac_device.h... but I can't spot a driver using this.
(its a shame its not the other way up, to avoid duplicating shared caches)

Some archaeology may be needed!

(if there is some existing structure, I agree it should be wrapped up in helpers to ensure
its easiest to be the same. This may be what a edac_device_block is...)


>  }


> /drivers/base/cacheinfo.c
> int cache_create_edac_entries(u64 mpidr, u8 cache_level, u8 cache_type)
> { 
> 	...
> 	/* Get cacheinfo for each online cpus */
> 	for_each_online_cpu(i) {
> 		struct cpu_cacheinfo *cpu_ci = get_cpu_cacheinfo(i);

I agree the structure of the caches should come from cacheinfo, and you spotted it only
works for online CPUs!. This means there is an interaction with cpuhp here)


> 		if (!cpu_ci || !cpu_ci->id)

cpu->id?  0 is a valid id, there is an attribute flag to say this is valid.
This field exists in struct cacheinfo, not struct cpu_cacheinfo.


> 			continue;
>         		... 
> 		/*Add  the edac entry for the CPU cache */
> 		edev_cache = edac_device_add_cache(cpu_ci->id, cpu_ci ->level, cpu_ci ->type)
> 		if (!edev_cache)
> 			break;

This would break all other edac users.
The edac driver for the platform should take care of creating this stuff, not the core
cacheinfo code.

The edac driver for the platform may know that L2 doesn't report RAS errors, so there is
no point exposing it.

For firmware-first, we can't know this until an error shows up, so have to create
everything. This stuff should only be created/exported when ghes_edac.c is determined to
be this platforms edac driver. This code should live in ghes_edac.c.


> 		...
> 	}
> 	...	
> }

> unsigned int cache_get_cache_id(u64 proc_id, u8 cache_level, u8 cache_type)

See get_cpu_cacheinfo_id(int cpu, int level) in next. (something very similar to this
lived in arch/x86, bits of the MPAM tree that moved it got queued for next)


> { 
> 	unsigned int cache_id = 0;
> 	...
> 	/* Walk looking for matching cache node */   
> 	for_each_online_cpu(i) {

(there is an interaction with cpuhp here)


> 		struct cpu_cacheinfo *cpu_ci = get_cpu_cacheinfo(i);
> 		if (!cpu_ci || !cpu_ci->id)
> 			continue;


> 		id = CONV(proc_id);  /* need to check */

No idea what is going on here.

(Deriving an ID from the CPU_s_ that are attached to the cache is arm64 specific. This has
to work for x86 too.
The MPAM out-of-tree code does this as we don't have anything else. Feedback when it was
posted as RFC was that the id values should be compacted, I was hoping we would get
something like an id from the PPTT before needing this value as resctrl ABI for MPAM)


> 		if((id == cpu_ci->id) && (cache_level == cpu_ci->level) && (cache_type == cpu_ci->type))  {
> 			cache_id = cpu_ci->id;
> 			break;
> 		}
> 	}
> 	return cache_id;
> }


> 2. Store CPU CE count in the edac sysfs entry for the CPU cache.
> 
> drivers/edac/ghes_edac.c
> void ghes_edac_report_cpu_error(int cache_id, u8 cache_level, u8 cache_type , uint32 ce_count)
> {
> 	...
> 	/* Check edac entry for cache already present, if not add new entry */       

You can't create devices at runtime! The notification comes in irq context, and
edac_device_add_device() takes a mutex, and you need to allocate memory.

This could be deferred to process context - but I bet its a nuisance for user-space to now
know what counters are available until errors show up.


> 	edev_cache = find_edac_device_cache(cache_id, cache_level, cache_type);
> 	if (!edev_cache) {
> 		/*Add  the edac entry for the cache */
> 		edev_cache = edac_device_add_cache(cache_id, cache_level, cache_type);
> 		if (!edev_cache)
> 			return;
> 	}

Better would be to lookup the device based on the CPER. (It already looks up the DIMM
based on the CPER)


> 	/* Store the ce_count to /sys/devices/system/edac/ cpu/cpu<no>/L<N>cache/ce_count */
> 	edac_device_handle_ce_count(edev_cache, ce_count, ...)
> }
>  
> drivers/acpi/apei/ghes.c
> void ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata) {
>  	...
>  	if (sec_sev != GHES_SEV_CORRECTED)
>  		return;

(Xiaofei Tan is looking at supporting some other of these, so you need to interact with
that work too)


>  	mpidr = cper_sec_proc_arm->mpidr;    

You want an arch-specific call to convert this to the linux CPU number, and then use that
everywhere. This makes the code more re-usable, and less surprising to other readers.

arm64's get_logical_index() looks like it does what you want.


>  	for(i = 0; i < cper_sec_proc_arm->err_info_num; i++) {
>  		if(cper_sec_proc_info->type != CPER_ARM_CACHE_ERROR) 
>  			continue; 
>  		ce_count = cper_arm_err_info->multiple_error + 1;
> 		cache_type = cper_arm_err_info->type;
> 		cache_level = cper_arm_err_info->error_info<24: 22>;  

> 		cache_id = cache_get_cache_id(mpidr, cache_level, cache_type);

This needs to be architecture agnostic, it must take the cpu number.


>  		if (!cache_id)
>  			return;

0 is a valid id.


> 		ghes_edac_report_cpu_error(cache_id, cache_level, cache_type , ce_count);
> 	}
>               ...
> 	return;	
> }


Thanks,

James

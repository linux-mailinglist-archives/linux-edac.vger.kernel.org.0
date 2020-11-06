Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7388C2A9E11
	for <lists+linux-edac@lfdr.de>; Fri,  6 Nov 2020 20:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgKFTdy (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 6 Nov 2020 14:33:54 -0500
Received: from foss.arm.com ([217.140.110.172]:43964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgKFTdy (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 6 Nov 2020 14:33:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D93E01474;
        Fri,  6 Nov 2020 11:33:52 -0800 (PST)
Received: from [172.16.1.113] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 491453F718;
        Fri,  6 Nov 2020 11:33:51 -0800 (PST)
Subject: Re: [RFC PATCH 1/4] ACPI: PPTT: Fix for a high level cache node
 detected in the low level
To:     Shiju Jose <shiju.jose@huawei.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, tony.luck@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, rrichter@marvell.com
Cc:     linux-edac@vger.kernel.org, linux-acpi@vger.kernel.org,
        linuxarm@huawei.com, jonathan.cameron@huawei.com
References: <20201105174233.1146-1-shiju.jose@huawei.com>
 <20201105174233.1146-2-shiju.jose@huawei.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <495c17fa-98fe-c79b-5676-ab1f0b50afba@arm.com>
Date:   Fri, 6 Nov 2020 19:33:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201105174233.1146-2-shiju.jose@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Shiju, Jonathan,

On 05/11/2020 17:42, Shiju Jose wrote:
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> According to the following sections of the PPTT definition in the
> ACPI specification(V6.3), a high level cache node( For example L2 cache)
> could be represented simultaneously both in the private resource
> of a CPU node and via the next_level_of_cache pointer of a low level
> cache node.
> 1. Section 5.2.29.1 Processor hierarchy node structure (Type 0)
> "Each processor node includes a list of resources that are private
> to that node. Resources are described in other PPTT structures such as
> Type 1 cache structures. The processor node’s private resource list
> includes a reference to each of the structures that represent private
> resources to a given processor node. For example, an SoC level processor
> node might contain two references, one pointing to a Level 3 cache
> resource and another pointing to an ID structure."
> 
> 2. Section 5.2.29.2 Cache Type Structure - Type 1
>    Figure 5-26 Cache Type Structure - Type 1 Example

'fix' in the subject makes me twitch ... is there a user-space visible bug because of this?


> For the use case of creating EDAC device blocks for the CPU caches,
> we need to search for cache node types in all levels using
> acpi_find_cache_node(), as a platform independent solution to

I'm nervous to base the edac user-space view of caches on something other than what is
described in /sys/devices/system/cpu/cpu0/cache. These things have to match, otherwise
user-space can't work out which cpu's L2's it should add to get the value for the physical
cache.

Getting the data from somewhere else risks making this more complicated.

Using the PPTT means this won't work on "HPE Server"s that use ghes_edac too. I don't
think we should have any arm64 specific behaviour here.


> retrieve the cache info from the ACPI PPTT. The reason is that
> cacheinfo in the drivers/base/cacheinfo.c would not be populated
> in this stage.

Because both ghes_init() and cacheinfo_sysfs_init() are device_initcall()?

Couldn't we fix this by making ghes_init(), device_initcall_sync() (with a comment saying
what it depends on)


I agree this means dealing with cpuhp as the cacheinfo data is only available for online CPUs.


> In this case, we found acpi_find_cache_node()
> mistakenly detecting high level cache as low level cache, when
> the cache node is in the processor node’s private resource list.
> 
> To fix this issue add duplication check in the acpi_find_cache_level(),
> for a cache node found in the private resource of a CPU node
> with all the next level of caches present in the other cache nodes.

I'm not overly familiar with the PPTT, is it possible this issue is visible in
/sys/devices/system/cpu/cpu0/cache?


Thanks,

James


> diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> index 4ae93350b70d..de1dd605d3ad 100644
> --- a/drivers/acpi/pptt.c
> +++ b/drivers/acpi/pptt.c
> @@ -132,21 +132,80 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
>  	return local_level;
>  }
>  
> +/**
> + * acpi_pptt_walk_check_duplicate() - Find the cache resource to check,
> + * is a duplication in the next_level_of_cache pointer of other cache.
> + * @table_hdr: Pointer to the head of the PPTT table
> + * @res: cache resource in the PPTT we want to walk
> + * @res_check: cache resource in the PPTT we want to check for duplication.
> + *
> + * Given both PPTT resource, verify that they are cache nodes, then walk
> + * down each level of cache @res, and check for the duplication.
> + *
> + * Return: true if duplication found, false otherwise.
> + */
> +static bool acpi_pptt_walk_check_duplicate(struct acpi_table_header *table_hdr,
> +					   struct acpi_subtable_header *res,
> +					   struct acpi_subtable_header *res_check)
> +{
> +	struct acpi_pptt_cache *cache;
> +	struct acpi_pptt_cache *check;
> +
> +	if (res->type != ACPI_PPTT_TYPE_CACHE ||
> +	    res_check->type != ACPI_PPTT_TYPE_CACHE)
> +		return false;
> +
> +	cache = (struct acpi_pptt_cache *)res;
> +	check = (struct acpi_pptt_cache *)res_check;
> +	while (cache) {
> +		if (cache == check)
> +			return true;
> +		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
> +	}
> +
> +	return false;
> +}
> +
>  static struct acpi_pptt_cache *
>  acpi_find_cache_level(struct acpi_table_header *table_hdr,
>  		      struct acpi_pptt_processor *cpu_node,
>  		      unsigned int *starting_level, unsigned int level,
>  		      int type)
>  {
> -	struct acpi_subtable_header *res;
> +	struct acpi_subtable_header *res, *res2;
>  	unsigned int number_of_levels = *starting_level;
>  	int resource = 0;
> +	int resource2 = 0;
> +	bool duplicate = false;
>  	struct acpi_pptt_cache *ret = NULL;
>  	unsigned int local_level;
>  
>  	/* walk down from processor node */
>  	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
>  		resource++;
> +		/*
> +		 * PPTT definition in the ACPI specification allows a high level cache
> +		 * node would be represented simultaneously both in the private resource
> +		 * of a CPU node and via the next_level_of_cache pointer of another cache node,
> +		 * within the same CPU hierarchy. This resulting acpi_find_cache_level()
> +		 * mistakenly detects a higher level cache node in the low level as well.
> +		 *
> +		 * Check a cache node in the private resource of the CPU node for any
> +		 * duplication.
> +		 */
> +		resource2 = 0;
> +		duplicate = false;
> +		while ((res2 = acpi_get_pptt_resource(table_hdr, cpu_node, resource2))) {
> +			resource2++;
> +			if (res2 == res)
> +				continue;
> +			if (acpi_pptt_walk_check_duplicate(table_hdr, res2, res)) {
> +				duplicate = true;
> +				break;
> +			}
> +		}
> +		if (duplicate)
> +			continue;
>  
>  		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
>  						   res, &ret, level, type);
> 


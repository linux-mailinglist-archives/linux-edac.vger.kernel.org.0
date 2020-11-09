Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87E32AB834
	for <lists+linux-edac@lfdr.de>; Mon,  9 Nov 2020 13:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgKIM1v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-edac@lfdr.de>); Mon, 9 Nov 2020 07:27:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2076 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIM1u (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Mon, 9 Nov 2020 07:27:50 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CV9Fh71Y4z67JqS;
        Mon,  9 Nov 2020 20:26:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 9 Nov 2020 13:27:47 +0100
Received: from localhost (10.52.120.237) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 9 Nov 2020
 12:27:46 +0000
Date:   Mon, 9 Nov 2020 12:27:42 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     James Morse <james.morse@arm.com>
CC:     Shiju Jose <shiju.jose@huawei.com>, <linux-kernel@vger.kernel.org>,
        <bp@alien8.de>, <tony.luck@intel.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <rrichter@marvell.com>,
        <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [RFC PATCH 1/4] ACPI: PPTT: Fix for a high level cache node
 detected in the low level
Message-ID: <20201109122742.00005f0e@Huawei.com>
In-Reply-To: <495c17fa-98fe-c79b-5676-ab1f0b50afba@arm.com>
References: <20201105174233.1146-1-shiju.jose@huawei.com>
        <20201105174233.1146-2-shiju.jose@huawei.com>
        <495c17fa-98fe-c79b-5676-ab1f0b50afba@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.120.237]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, 6 Nov 2020 19:33:45 +0000
James Morse <james.morse@arm.com> wrote:

> Hi Shiju, Jonathan,
> 
> On 05/11/2020 17:42, Shiju Jose wrote:
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > 
> > According to the following sections of the PPTT definition in the
> > ACPI specification(V6.3), a high level cache node( For example L2 cache)
> > could be represented simultaneously both in the private resource
> > of a CPU node and via the next_level_of_cache pointer of a low level
> > cache node.
> > 1. Section 5.2.29.1 Processor hierarchy node structure (Type 0)
> > "Each processor node includes a list of resources that are private
> > to that node. Resources are described in other PPTT structures such as
> > Type 1 cache structures. The processor node’s private resource list
> > includes a reference to each of the structures that represent private
> > resources to a given processor node. For example, an SoC level processor
> > node might contain two references, one pointing to a Level 3 cache
> > resource and another pointing to an ID structure."
> > 
> > 2. Section 5.2.29.2 Cache Type Structure - Type 1
> >    Figure 5-26 Cache Type Structure - Type 1 Example  
> 
> 'fix' in the subject makes me twitch ... is there a user-space visible bug because of this?

Yes... But it is certainly plausible no one will ever hit it.  Previously we'd
identified how you would hit it but this morning I just hacked QEMU to present
the necessary cache topology to trigger it.

First requirement is you have 2 levels of cache pointed to directly by
the private_resources array for a given PPTT processor hierarchy node structure.
(note we have this part for our kunpeng920 firmwares)

The current cacheinfo / PPTT walk matches on type using the types from
CLIDR on a given CPU.  Note that we aren't doing the type based finding for
the later patches in this series, precisely because we want to build the topology
for offline CPUs.  I'll leave Shiju to address that separately.

So you need to have a cache topology that has the same type of cache
(either unified, or split) for the two levels at a particular point in the
CPU topology.  In my particular test I used CPU private split L1 and split L2
(so four caches at the level representing the CPU core).

That triggers warnings of:
"ACPI PPTT: Found duplicate cache level/type unable to determine uniqueness"
but then proceeds anyway.  The result of this is it uses the 'last' matching
entry as ordered in the private_resources array. 

So, to see any user visible results in ../cpu0/cache/indexX etc you need
to also have the private_resources ordered so that the higher level caches
come later in the array.

I have a PPTT now for a 2 CPU system that puts them in different orders for
CPU0 and CPU1.

CPU0 has them as l2i, l2d, l1i, l1d 
CPU1 has them as L1i, L1d, L2i, L2d

The result is that CPU0 works correctly except for the warning, whereas
for CPU1 it picks up the parameters of the L2 caches for both L1 and L2.

So how likely is this to happen in a real machine?  I'm not sure.
Would be unusual to see either unified l1 or split l2 on a machine with
a firmware using PPTT.  In theory we might get it further up the hierarchy
as well if we have L3 and L4 presented at the same level in 
processor hierarchy.

Perhaps we should just name the patch.  "Harden..." rather than "Fix..." ?

Note that you do need this if you are walking the cached topology
without using the CSRs to provide extra restrictions on what you are looking
for at a given level.

Thanks,

Jonathan

> 
> 
> > For the use case of creating EDAC device blocks for the CPU caches,
> > we need to search for cache node types in all levels using
> > acpi_find_cache_node(), as a platform independent solution to  
> 
> I'm nervous to base the edac user-space view of caches on something other than what is
> described in /sys/devices/system/cpu/cpu0/cache. These things have to match, otherwise
> user-space can't work out which cpu's L2's it should add to get the value for the physical
> cache.
> 
> Getting the data from somewhere else risks making this more complicated.
> 
> Using the PPTT means this won't work on "HPE Server"s that use ghes_edac too. I don't
> think we should have any arm64 specific behaviour here.
> 
> 
> > retrieve the cache info from the ACPI PPTT. The reason is that
> > cacheinfo in the drivers/base/cacheinfo.c would not be populated
> > in this stage.  
> 
> Because both ghes_init() and cacheinfo_sysfs_init() are device_initcall()?
> 
> Couldn't we fix this by making ghes_init(), device_initcall_sync() (with a comment saying
> what it depends on)
> 
> 
> I agree this means dealing with cpuhp as the cacheinfo data is only available for online CPUs.
> 
> 
> > In this case, we found acpi_find_cache_node()
> > mistakenly detecting high level cache as low level cache, when
> > the cache node is in the processor node’s private resource list.
> > 
> > To fix this issue add duplication check in the acpi_find_cache_level(),
> > for a cache node found in the private resource of a CPU node
> > with all the next level of caches present in the other cache nodes.  
> 
> I'm not overly familiar with the PPTT, is it possible this issue is visible in
> /sys/devices/system/cpu/cpu0/cache?
> 
> 
> Thanks,
> 
> James
> 
> 
> > diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
> > index 4ae93350b70d..de1dd605d3ad 100644
> > --- a/drivers/acpi/pptt.c
> > +++ b/drivers/acpi/pptt.c
> > @@ -132,21 +132,80 @@ static unsigned int acpi_pptt_walk_cache(struct acpi_table_header *table_hdr,
> >  	return local_level;
> >  }
> >  
> > +/**
> > + * acpi_pptt_walk_check_duplicate() - Find the cache resource to check,
> > + * is a duplication in the next_level_of_cache pointer of other cache.
> > + * @table_hdr: Pointer to the head of the PPTT table
> > + * @res: cache resource in the PPTT we want to walk
> > + * @res_check: cache resource in the PPTT we want to check for duplication.
> > + *
> > + * Given both PPTT resource, verify that they are cache nodes, then walk
> > + * down each level of cache @res, and check for the duplication.
> > + *
> > + * Return: true if duplication found, false otherwise.
> > + */
> > +static bool acpi_pptt_walk_check_duplicate(struct acpi_table_header *table_hdr,
> > +					   struct acpi_subtable_header *res,
> > +					   struct acpi_subtable_header *res_check)
> > +{
> > +	struct acpi_pptt_cache *cache;
> > +	struct acpi_pptt_cache *check;
> > +
> > +	if (res->type != ACPI_PPTT_TYPE_CACHE ||
> > +	    res_check->type != ACPI_PPTT_TYPE_CACHE)
> > +		return false;
> > +
> > +	cache = (struct acpi_pptt_cache *)res;
> > +	check = (struct acpi_pptt_cache *)res_check;
> > +	while (cache) {
> > +		if (cache == check)
> > +			return true;
> > +		cache = fetch_pptt_cache(table_hdr, cache->next_level_of_cache);
> > +	}
> > +
> > +	return false;
> > +}
> > +
> >  static struct acpi_pptt_cache *
> >  acpi_find_cache_level(struct acpi_table_header *table_hdr,
> >  		      struct acpi_pptt_processor *cpu_node,
> >  		      unsigned int *starting_level, unsigned int level,
> >  		      int type)
> >  {
> > -	struct acpi_subtable_header *res;
> > +	struct acpi_subtable_header *res, *res2;
> >  	unsigned int number_of_levels = *starting_level;
> >  	int resource = 0;
> > +	int resource2 = 0;
> > +	bool duplicate = false;
> >  	struct acpi_pptt_cache *ret = NULL;
> >  	unsigned int local_level;
> >  
> >  	/* walk down from processor node */
> >  	while ((res = acpi_get_pptt_resource(table_hdr, cpu_node, resource))) {
> >  		resource++;
> > +		/*
> > +		 * PPTT definition in the ACPI specification allows a high level cache
> > +		 * node would be represented simultaneously both in the private resource
> > +		 * of a CPU node and via the next_level_of_cache pointer of another cache node,
> > +		 * within the same CPU hierarchy. This resulting acpi_find_cache_level()
> > +		 * mistakenly detects a higher level cache node in the low level as well.
> > +		 *
> > +		 * Check a cache node in the private resource of the CPU node for any
> > +		 * duplication.
> > +		 */
> > +		resource2 = 0;
> > +		duplicate = false;
> > +		while ((res2 = acpi_get_pptt_resource(table_hdr, cpu_node, resource2))) {
> > +			resource2++;
> > +			if (res2 == res)
> > +				continue;
> > +			if (acpi_pptt_walk_check_duplicate(table_hdr, res2, res)) {
> > +				duplicate = true;
> > +				break;
> > +			}
> > +		}
> > +		if (duplicate)
> > +			continue;
> >  
> >  		local_level = acpi_pptt_walk_cache(table_hdr, *starting_level,
> >  						   res, &ret, level, type);
> >   
> 


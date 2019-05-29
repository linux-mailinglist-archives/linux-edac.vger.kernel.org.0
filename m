Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 326872E3E9
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 19:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfE2RvD (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 13:51:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:50288 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfE2RvD (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 13:51:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF5A2341;
        Wed, 29 May 2019 10:51:02 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB20E3F5AF;
        Wed, 29 May 2019 10:51:01 -0700 (PDT)
Subject: Re: [PATCH 14/21] EDAC, ghes: Extract numa node information for each
 dimm
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-15-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <42d1cb7f-de7a-31e8-eb89-8d0651a3501a@arm.com>
Date:   Wed, 29 May 2019 18:51:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084344.28562-15-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 29/05/2019 09:44, Robert Richter wrote:
> In a later patch we want to have one mc device per node. This patch
> extracts the numa node information for each dimm. This is done by
> collecting the physical address ranges from the DMI table (Memory
> Array Mapped Address - Type 19 of SMBIOS spec). The node information> for a physical address is already know to a numa aware system (e.g. by
> using the ACPI _PXM method or the ACPI SRAT table), so based on the PA
> we can assign the node id to the dimms.

I think you're letting the smbios information drive you here. We'd like to do as much as
possible without it, all its really good for is telling us the label on the PCB.

With this approach, you only get numa information by parsing more smbios, which we have to
try and validate, and fall back to some error path if it smells wrong. We end up needing
things like a 'fallback memory controller' in the case the firmware fault-time value is
missing, or nuts.

What bugs me is we already know the numa information from the address. We could expose
that without the smbios tables at all, and it would be useful to someone playing the
dimm-bisect game. Not making it depend on smbios means there is a good chance it can
become common with other edac drivers.

I don't think we need to know the dimm->node mapping up front. When we get an error,
pfn_to_nid() on the address tells us which node that memory is attached to. This should be
the only place nid information comes from, that way we don't need to check it. Trying to
correlate it with smbios tables is much more code. If the CPER comes with a DIMM handle,
we know the DIMM too.

So all we really need is to know at setup time is how many numa-nodes there are, and the
maximum DIMM per node if we don't want phantom-dimms. Type-17 already has a
Physical-Memory-Array-Handle, which points at Type-19... but we don't need to read it,
just count them and find the biggest.

If the type-19 information is missing from smbios, or not linked up properly, or the
values provided at fault-time don't overlap with the values in the table, or there is no
fault-time node information: you still get the numa-node information based on the address.

Using the minimum information should give us the least code, and the least exposure to
misdescribed tables.


> A fallback that disables numa is implemented in case the node
> information is inconsistent.

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 50f4ee36b755..083452a48b42 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -67,14 +67,34 @@ struct memdev_dmi_entry {
>  	u16 conf_mem_clk_speed;
>  } __attribute__((__packed__));
>  
> +/* Memory Array Mapped Address - Type 19 of SMBIOS spec */
> +struct memarr_dmi_entry {
> +	u8		type;
> +	u8		length;
> +	u16		handle;
> +	u32		start;
> +	u32		end;
> +	u16		phys_mem_array_handle;
> +	u8		partition_width;
> +	u64		ext_start;
> +	u64		ext_end;
> +} __attribute__((__packed__));

Any chance we could collect the structures from the smbios spec in a header file somewhere?

I'd prefer not to read this thing at all if we can help it.

>  struct ghes_dimm_info {
>  	struct dimm_info dimm_info;
>  	int		idx;
> +	int		numa_node;

(I thought nid was the preferred term)


> +	phys_addr_t	start;
> +	phys_addr_t	end;

I think start and end are deceptive as they overlap with other DIMMs on systems with
interleaving memory controllers. I'd prefer not to keep these values around.


> +	u16		phys_handle;
>  };
>  
>  struct ghes_mem_info {
> -	int num_dimm;
> +	int		num_dimm;
>  	struct ghes_dimm_info *dimms;
> +	int		num_nodes;

> +	int		num_per_node[MAX_NUMNODES];

Number of what?


> +	bool		enable_numa;

This is used locally in mem_info_setup(), but its not read from here by any of the later
patches in the series. Is it needed?

I don't like the idea that this is behaviour that is turned on/off. Its a property of the
system. I think it would be better if CONFIG_NUMA causes you to get multiple
memory-controllers created, but if its not actually a NUMA machine there would only be
one. This lets us test that code on not-really-numa systems.


>  };
>  
>  struct ghes_mem_info mem_info;
> @@ -97,10 +117,50 @@ static void ghes_dimm_info_init(void)
>  
>  	for_each_dimm(dimm) {
>  		dimm->idx	= idx;
> +		dimm->numa_node	= NUMA_NO_NODE;
>  		idx++;
>  	}
>  }
>  
> +static void ghes_edac_set_nid(const struct dmi_header *dh, void *arg)
> +{
> +	struct memarr_dmi_entry *entry = (struct memarr_dmi_entry *)dh;
> +	struct ghes_dimm_info *dimm;
> +	phys_addr_t start, end;
> +	int nid;
> +
> +	if (dh->type != DMI_ENTRY_MEM_ARRAY_MAPPED_ADDR)
> +		return;

> +	/* only support SMBIOS 2.7+ */
> +	if (entry->length < sizeof(*entry))
> +		return;

Lovely. I still hope we can get away without parsing this table.


> +	if (entry->start == 0xffffffff)
> +		start = entry->ext_start;
> +	else
> +		start = entry->start;
> +	if (entry->end == 0xffffffff)
> +		end = entry->ext_end;
> +	else
> +		end = entry->end;


> +	if (!pfn_valid(PHYS_PFN(start)))
> +		return;

Eh? Just because there is no struct page doesn't mean firmware won't report errors for it.
This is going to bite on arm64 if the 'start' page happens to have been reserved by
firmware, and thus doesn't have a struct page. Bottom-up allocation doesn't sound unlikely.


> +	nid = pfn_to_nid(PHYS_PFN(start));

... Ugh, because pfn_to_nid() goes via struct page.

You can make this robust by scanning start->end looking for a pfn_valid() you can pull the
nid out of. (no, I don't think its a good idea either!)

I'd like to see if we can get rid of the 'via address' part of this.


> +	if (nid < 0 || nid >= MAX_NUMNODES || !node_possible(nid))
> +		nid = NUMA_NO_NODE;

Can this happen? Does this indicate the firmware tables are wrong, or mm is about derail?


> +	for_each_dimm(dimm) {
> +		if (entry->phys_mem_array_handle == dimm->phys_handle) {
> +			dimm->numa_node	= nid;
> +			dimm->start	= start;
> +			dimm->end	= end;
> +		}
> +	}
> +}
> +
>  static int get_dimm_smbios_index(u16 handle)
>  {
>  	struct mem_ctl_info *mci = ghes_pvt->mci;
> @@ -213,8 +273,25 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  	}
>  }
>  
> +static void mem_info_disable_numa(void)
> +{
> +	struct ghes_dimm_info *dimm;
> +
> +	for_each_dimm(dimm) {
> +		if (dimm->numa_node != NUMA_NO_NODE)
> +			mem_info.num_per_node[dimm->numa_node] = 0;

> +		dimm->numa_node = 0;

NUMA_NO_NODE?

> +	}
> +
> +	mem_info.num_per_node[0] = mem_info.num_dimm;
> +	mem_info.num_nodes = 1;
> +	mem_info.enable_numa = false;
> +}
> +
>  static int mem_info_setup(void)
>  {
> +	struct ghes_dimm_info *dimm;
> +	bool enable_numa = true;
>  	int idx = 0;
>  
>  	memset(&mem_info, 0, sizeof(mem_info));
> @@ -231,6 +308,29 @@ static int mem_info_setup(void)
>  
>  	ghes_dimm_info_init();
>  	dmi_walk(ghes_edac_dmidecode, &idx);
> +	dmi_walk(ghes_edac_set_nid, NULL);
> +
> +	for_each_dimm(dimm) {
> +		if (dimm->numa_node == NUMA_NO_NODE) {
> +			enable_numa = false;
> +		} else {

> +			if (!mem_info.num_per_node[dimm->numa_node])
> +				mem_info.num_nodes++;

This is to try and hide empty nodes?


> +			mem_info.num_per_node[dimm->numa_node]++;

Could you do these two in your previous for_each_dimm() walk?


> +		}
> +
> +		edac_dbg(1, "DIMM%i: Found mem range [%pa-%pa] on node %d\n",
> +			dimm->idx, &dimm->start, &dimm->end, dimm->numa_node);
> +	}


> +	mem_info.enable_numa = enable_numa;
> +	if (enable_numa)
> +		return 0;
> +
> +	/* something went wrong, disable numa */
> +	if (num_possible_nodes() > 1)
> +		pr_warn("Can't get numa info, disabling numa\n");
> +	mem_info_disable_numa();

I'd like to find a way of doing this where we don't need this sort of thing!


Thanks,

James

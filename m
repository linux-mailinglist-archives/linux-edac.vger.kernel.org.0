Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD0E2E085
	for <lists+linux-edac@lfdr.de>; Wed, 29 May 2019 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbfE2PG7 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 29 May 2019 11:06:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfE2PG7 (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 29 May 2019 11:06:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7C37341;
        Wed, 29 May 2019 08:06:58 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 967EF3F5AF;
        Wed, 29 May 2019 08:06:57 -0700 (PDT)
Subject: Re: [PATCH 13/21] EDAC, ghes: Rework memory hierarchy detection
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190529084344.28562-1-rrichter@marvell.com>
 <20190529084344.28562-14-rrichter@marvell.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <068e31b4-43e8-c1ab-194e-f2b41c1534f9@arm.com>
Date:   Wed, 29 May 2019 16:06:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190529084344.28562-14-rrichter@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Hi Robert,

On 29/05/2019 09:44, Robert Richter wrote:
> In a later patch we want add more information about the memory
> hierarchy (NUMA topology, DIMM label information). Rework memory
> hierarchy detection to make the code extendable for this.
> 
> The general approach is roughly like:
> 
> 	mem_info_setup();
> 	for_each_node(nid) {
> 		mci = edac_mc_alloc(nid);
> 		mci_add_dimm_info(mci);
> 		edac_mc_add_mc(mci);
> 	};
> 
> This patch introduces mem_info_setup() and mci_add_dimm_info().
> 
> All data of the memory hierarchy is collected in a local struct
> ghes_mem_info.
> 
> Note: Per (NUMA) node registration will be implemented in a later
> patch.


> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index ea4d53043199..50f4ee36b755 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -67,17 +67,38 @@ struct memdev_dmi_entry {
>  	u16 conf_mem_clk_speed;
>  } __attribute__((__packed__));
>  
> -struct ghes_edac_dimm_fill {
> -	struct mem_ctl_info *mci;
> -	unsigned count;

> +struct ghes_dimm_info {
> +	struct dimm_info dimm_info;
> +	int		idx;
> +};

> +struct ghes_mem_info {
> +	int num_dimm;
> +	struct ghes_dimm_info *dimms;
>  };
>  
> +struct ghes_mem_info mem_info;

static?


> @@ -94,18 +115,17 @@ static int get_dimm_smbios_index(u16 handle)
>  
>  static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  {
> -	struct ghes_edac_dimm_fill *dimm_fill = arg;
> -	struct mem_ctl_info *mci = dimm_fill->mci;
> -
>  	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
> +		int *idx = arg;
>  		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
> -		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count,
> -						       0, 0);
> +		struct ghes_dimm_info *mi = &mem_info.dimms[*idx];
> +		struct dimm_info *dimm = &mi->dimm_info;
>  		u16 rdr_mask = BIT(7) | BIT(13);


> +		mi->phys_handle = entry->phys_mem_array_handle;

Where did this come from, and what is it for?

...

Should this be in a later patch? (did you bisect build this?)


>  		if (entry->size == 0xffff) {
> -			pr_info("Can't get DIMM%i size\n",
> -				dimm_fill->count);
> +			pr_info("Can't get DIMM%i size\n", mi->idx);
>  			dimm->nr_pages = MiB_TO_PAGES(32);/* Unknown */
>  		} else if (entry->size == 0x7fff) {
>  			dimm->nr_pages = MiB_TO_PAGES(entry->extended_size);


> +static int mem_info_setup(void)
> +{
> +	int idx = 0;
> +
> +	memset(&mem_info, 0, sizeof(mem_info));

Is this necessary? Isn't mem_info in the BSS, it will zero'd already.


> +	/* Get the number of DIMMs */
> +	dmi_walk(ghes_edac_count_dimms, NULL);
> +	if (!mem_info.num_dimm)
> +		return -EINVAL;

> +	mem_info.dimms = kcalloc(mem_info.num_dimm,
> +				sizeof(*mem_info.dimms), GFP_KERNEL);
> +	if (!mem_info.dimms)
> +		return -ENOMEM;

> +	ghes_dimm_info_init();

Could you move the kcalloc() into ghes_dimm_info_init()? This would save you having a
unnecessarily-different version in mem_info_setup_fake().


> +	dmi_walk(ghes_edac_dmidecode, &idx);
> +
> +	return 0;
> +}

> +static int mem_info_setup_fake(void)
> +{
> +	struct ghes_dimm_info *ghes_dimm;
> +	struct dimm_info *dimm;
> +
> +	memset(&mem_info, 0, sizeof(mem_info));

Is this necessary? Its only been touched by mem_info_setup(), and you get in here because
mem_info.num_dimm == 0...


> +	ghes_dimm = kzalloc(sizeof(*mem_info.dimms), GFP_KERNEL);
> +	if (!ghes_dimm)
> +		return -ENOMEM;

This is common with mem_info_setup(). If ghes_dimm_info_init() read mem_info.num_dimm and
did the rest, you'd avoid some duplication here.


> +	mem_info.num_dimm = 1;
> +	mem_info.dimms = ghes_dimm;
> +
> +	ghes_dimm_info_init();
> +
> +	dimm = &ghes_dimm->dimm_info;
> +	dimm->nr_pages = 1;
> +	dimm->grain = 128;
> +	dimm->mtype = MEM_UNKNOWN;
> +	dimm->dtype = DEV_UNKNOWN;
> +	dimm->edac_mode = EDAC_SECDED;
> +
> +	return 0;
> +}


> +static void mci_add_dimm_info(struct mem_ctl_info *mci)

(From the name I expected this to be in edac_mc.c)


> +{
> +	struct dimm_info *mci_dimm, *dmi_dimm;
> +	struct ghes_dimm_info *dimm;
> +	int index = 0;
> +
> +	for_each_dimm(dimm) {
> +		dmi_dimm = &dimm->dimm_info;
> +		mci_dimm = edac_get_dimm_by_index(mci, index);
> +
> +		index++;
> +		if (index > mci->tot_dimms)
> +			break;
> +
> +		mci_dimm->nr_pages	= dmi_dimm->nr_pages;
> +		mci_dimm->mtype		= dmi_dimm->mtype;
> +		mci_dimm->edac_mode	= dmi_dimm->edac_mode;
> +		mci_dimm->dtype		= dmi_dimm->dtype;
> +		mci_dimm->grain		= dmi_dimm->grain;
> +		mci_dimm->smbios_handle = dmi_dimm->smbios_handle;
>  	}

This isn't fun. I guess 'numa' is the reason for generating a shadow copy of all this, and
then having to copy it into edac. But surely that isn't a problem unique to ghes_edac.c?

Can't you add the nid, and any other properties to struct dimm_info? It already has
smbios_handle, which is hardly useful to other drivers!


> +	if (index != mci->tot_dimms)
> +		pr_warn("Unexpected number of DIMMs: %d (exp. %d)\n",
> +			index, mci->tot_dimms);
>  }


> @@ -472,22 +566,24 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)

>  	mci = edac_mc_alloc(0, ARRAY_SIZE(layers), layers, sizeof(struct ghes_edac_pvt));
>  	if (!mci) {
> -		pr_info("Can't allocate memory for EDAC data\n");
> +		pr_err("Can't allocate memory for EDAC data\n");

Leftover debug?

		kfree(mem_info.dimms); ?

>  		return -ENOMEM;
>  	}
>  
> @@ -513,26 +609,14 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)

> -	if (!fake) {
> -		dimm_fill.count = 0;
> -		dimm_fill.mci = mci;
> -		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
> -	} else {
> -		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
> -
> -		dimm->nr_pages = 1;
> -		dimm->grain = 128;
> -		dimm->mtype = MEM_UNKNOWN;
> -		dimm->dtype = DEV_UNKNOWN;
> -		dimm->edac_mode = EDAC_SECDED;
> -	}
> +	mci_add_dimm_info(mci);
>  
>  	rc = edac_mc_add_mc(mci);
>  	if (rc < 0) {
> -		pr_info("Can't register at EDAC core\n");
> +		pr_err("Can't register at EDAC core\n");

Leftover debug?

>  		edac_mc_free(mci);

		kfree(mem_info.dimms); ?

>  		return -ENODEV;
>  	}


Thanks!

James

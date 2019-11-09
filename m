Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C518F5DD4
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 08:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKIHlI (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 02:41:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbfKIHlI (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Nov 2019 02:41:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bdQlWrlqjmRIHKsy47Znkw12tAbgfMjq1rsPEJlO/jo=; b=m4TAQqjAevFARJVgeeQ2hh70H
        I/EsRyfqkm9bFK+tZSjAPg6YbJKGqpPmtLAnsI2KXx2IFlsE5fuOVCvWQhlCALeaGH47a5GwMLDM+
        W4V37cttIY/TO8P9YyjcdbSEKJKKBzcKDBZGeWVicM5vuF9yQPGb0GaEG7c0UrhcQI2HHLaCJ6x6p
        CGP/+69ilEP+Uvh7/HjUOSf5xkuGEKnhzLm3fOFvS4oxHpAgiZCGNrN5vEM7DWWr1cFPd7TqTYPBC
        q7gv57ONXlSTUEoCxkJiOxPSBQytLEDLF6GNBR5qI0j33D91JsgnvbP/TlIojje8v4y91XwBhTTz5
        mDEcMgplQ==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTLMh-0003TN-QD; Sat, 09 Nov 2019 07:41:00 +0000
Date:   Sat, 9 Nov 2019 08:40:56 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 14/20] EDAC, mc: Remove per layer counters
Message-ID: <20191109084056.35b4b8ab@kernel.org>
In-Reply-To: <20191106093239.25517-15-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
        <20191106093239.25517-15-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 6 Nov 2019 09:33:32 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
> turns out that only the leaves in the memory hierarchy are consumed
> (in sysfs), but not the intermediate layers, e.g.:
> 
>  count = dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
> 
> These unused counters only add complexity, remove them. The error
> counter values are directly stored in struct dimm_info now.

I guess this patch will cause troubles with some memory controllers.

The problem is that, depending on the memory type and how many bits
are wrong, it may not be technically possible to pinpoint an error
to a single DIMM.

I mean, the memory controller can be, for instance, grouping
DIMM1 and DIMM2. If there's just one bit errored, it is possible to
assign it to either DIMM1 or DIMM2, but if there are multiple bits
wrong, most ECC codes won't allow to pinpoint if the error ocurred
at DIMM1 or at DIMM2.

All we know is that the layer has an error.

So, assigning the error to the dimm struct seems plain wrong to me.

> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       | 106 ++++++++++++-----------------------
>  drivers/edac/edac_mc_sysfs.c |  20 +++----
>  drivers/edac/ghes_edac.c     |   5 +-
>  include/linux/edac.h         |   7 +--
>  4 files changed, 47 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index b6032f51338e..dfc17c565d8f 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -315,12 +315,11 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	struct csrow_info *csr;
>  	struct rank_info *chan;
>  	struct dimm_info *dimm;
> -	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
>  	unsigned int pos[EDAC_MAX_LAYERS];
> -	unsigned int idx, size, tot_dimms = 1, count = 1;
> -	unsigned int tot_csrows = 1, tot_channels = 1, tot_errcount = 0;
> +	unsigned int idx, size, tot_dimms = 1;
> +	unsigned int tot_csrows = 1, tot_channels = 1;
>  	void *pvt, *p, *ptr = NULL;
> -	int i, j, row, chn, n, len;
> +	int j, row, chn, n, len;
>  	bool per_rank = false;
>  
>  	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> @@ -346,19 +345,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	 * stringent as what the compiler would provide if we could simply
>  	 * hardcode everything into a single struct.
>  	 */
> -	mci = edac_align_ptr(&ptr, sizeof(*mci), 1);
> -	layer = edac_align_ptr(&ptr, sizeof(*layer), n_layers);
> -	for (i = 0; i < n_layers; i++) {
> -		count *= layers[i].size;
> -		edac_dbg(4, "errcount layer %d size %d\n", i, count);
> -		ce_per_layer[i] = edac_align_ptr(&ptr, sizeof(u32), count);
> -		ue_per_layer[i] = edac_align_ptr(&ptr, sizeof(u32), count);
> -		tot_errcount += 2 * count;
> -	}
> -
> -	edac_dbg(4, "allocating %d error counters\n", tot_errcount);
> -	pvt = edac_align_ptr(&ptr, sz_pvt, 1);
> -	size = ((unsigned long)pvt) + sz_pvt;
> +	mci	= edac_align_ptr(&ptr, sizeof(*mci), 1);
> +	layer	= edac_align_ptr(&ptr, sizeof(*layer), n_layers);
> +	pvt	= edac_align_ptr(&ptr, sz_pvt, 1);
> +	size	= ((unsigned long)pvt) + sz_pvt;
>  
>  	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)\n",
>  		 size,
> @@ -374,10 +364,6 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	 * rather than an imaginary chunk of memory located at address 0.
>  	 */
>  	layer = (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer));
> -	for (i = 0; i < n_layers; i++) {
> -		mci->ce_per_layer[i] = (u32 *)((char *)mci + ((unsigned long)ce_per_layer[i]));
> -		mci->ue_per_layer[i] = (u32 *)((char *)mci + ((unsigned long)ue_per_layer[i]));
> -	}
>  	pvt = sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
>  
>  	/* setup index and various internal pointers */
> @@ -908,53 +894,31 @@ const char *edac_layer_name[] = {
>  EXPORT_SYMBOL_GPL(edac_layer_name);
>  
>  static void edac_inc_ce_error(struct mem_ctl_info *mci,
> -			      bool enable_per_layer_report,
>  			      const int pos[EDAC_MAX_LAYERS],
>  			      const u16 count)
>  {
> -	int i, index = 0;
> +	struct dimm_info *dimm = edac_get_dimm(mci, pos[0], pos[1], pos[2]);
>  
>  	mci->ce_mc += count;
>  
> -	if (!enable_per_layer_report) {
> +	if (dimm)
> +		dimm->ce_count += count;
> +	else
>  		mci->ce_noinfo_count += count;
> -		return;
> -	}
> -
> -	for (i = 0; i < mci->n_layers; i++) {
> -		if (pos[i] < 0)
> -			break;
> -		index += pos[i];
> -		mci->ce_per_layer[i][index] += count;
> -
> -		if (i < mci->n_layers - 1)
> -			index *= mci->layers[i + 1].size;
> -	}
>  }
>  
>  static void edac_inc_ue_error(struct mem_ctl_info *mci,
> -				    bool enable_per_layer_report,
>  				    const int pos[EDAC_MAX_LAYERS],
>  				    const u16 count)
>  {
> -	int i, index = 0;
> +	struct dimm_info *dimm = edac_get_dimm(mci, pos[0], pos[1], pos[2]);
>  
>  	mci->ue_mc += count;
>  
> -	if (!enable_per_layer_report) {
> +	if (dimm)
> +		dimm->ue_count += count;
> +	else
>  		mci->ue_noinfo_count += count;
> -		return;
> -	}
> -
> -	for (i = 0; i < mci->n_layers; i++) {
> -		if (pos[i] < 0)
> -			break;
> -		index += pos[i];
> -		mci->ue_per_layer[i][index] += count;
> -
> -		if (i < mci->n_layers - 1)
> -			index *= mci->layers[i + 1].size;
> -	}
>  }
>  
>  static void edac_ce_error(struct mem_ctl_info *mci,
> @@ -965,7 +929,6 @@ static void edac_ce_error(struct mem_ctl_info *mci,
>  			  const char *label,
>  			  const char *detail,
>  			  const char *other_detail,
> -			  const bool enable_per_layer_report,
>  			  const unsigned long page_frame_number,
>  			  const unsigned long offset_in_page,
>  			  long grain)
> @@ -988,7 +951,7 @@ static void edac_ce_error(struct mem_ctl_info *mci,
>  				       error_count, msg, msg_aux, label,
>  				       location, detail);
>  	}
> -	edac_inc_ce_error(mci, enable_per_layer_report, pos, error_count);
> +	edac_inc_ce_error(mci, pos, error_count);
>  
>  	if (mci->scrub_mode == SCRUB_SW_SRC) {
>  		/*
> @@ -1018,8 +981,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  			  const char *location,
>  			  const char *label,
>  			  const char *detail,
> -			  const char *other_detail,
> -			  const bool enable_per_layer_report)
> +			  const char *other_detail)
>  {
>  	char *msg_aux = "";
>  
> @@ -1048,7 +1010,7 @@ static void edac_ue_error(struct mem_ctl_info *mci,
>  			      msg, msg_aux, label, location, detail);
>  	}
>  
> -	edac_inc_ue_error(mci, enable_per_layer_report, pos, error_count);
> +	edac_inc_ue_error(mci, pos, error_count);
>  }
>  
>  void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
> @@ -1079,16 +1041,16 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
>  			"page:0x%lx offset:0x%lx grain:%ld syndrome:0x%lx",
>  			e->page_frame_number, e->offset_in_page,
>  			e->grain, e->syndrome);
> -		edac_ce_error(mci, e->error_count, pos, e->msg, e->location, e->label,
> -			      detail, e->other_detail, e->enable_per_layer_report,
> +		edac_ce_error(mci, e->error_count, pos, e->msg, e->location,
> +			      e->label, detail, e->other_detail,
>  			      e->page_frame_number, e->offset_in_page, e->grain);
>  	} else {
>  		snprintf(detail, sizeof(detail),
>  			"page:0x%lx offset:0x%lx grain:%ld",
>  			e->page_frame_number, e->offset_in_page, e->grain);
>  
> -		edac_ue_error(mci, e->error_count, pos, e->msg, e->location, e->label,
> -			      detail, e->other_detail, e->enable_per_layer_report);
> +		edac_ue_error(mci, e->error_count, pos, e->msg, e->location,
> +			      e->label, detail, e->other_detail);
>  	}
>  
>  
> @@ -1113,6 +1075,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	int pos[EDAC_MAX_LAYERS] = { top_layer, mid_layer, low_layer };
>  	int i, n_labels = 0;
>  	struct edac_raw_error_desc *e = &mci->error_desc;
> +	bool any_memory = true;
>  
>  	edac_dbg(3, "MC%d\n", mci->mc_idx);
>  
> @@ -1130,9 +1093,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  
>  	/*
>  	 * Check if the event report is consistent and if the memory
> -	 * location is known. If it is known, enable_per_layer_report will be
> -	 * true, the DIMM(s) label info will be filled and the per-layer
> -	 * error counters will be incremented.
> +	 * location is known. If it is known, the DIMM(s) label info
> +	 * will be filled and the DIMM's error counters will be
> +	 * incremented.
>  	 */
>  	for (i = 0; i < mci->n_layers; i++) {
>  		if (pos[i] >= (int)mci->layers[i].size) {
> @@ -1150,7 +1113,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			pos[i] = -1;
>  		}
>  		if (pos[i] >= 0)
> -			e->enable_per_layer_report = true;
> +			any_memory = false;
>  	}
>  
>  	/*
> @@ -1180,16 +1143,17 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			e->grain = dimm->grain;
>  
>  		/*
> -		 * If the error is memory-controller wide, there's no need to
> -		 * seek for the affected DIMMs because the whole
> -		 * channel/memory controller/...  may be affected.
> -		 * Also, don't show errors for empty DIMM slots.
> +		 * If the error is memory-controller wide, there's no
> +		 * need to seek for the affected DIMMs because the
> +		 * whole channel/memory controller/... may be
> +		 * affected. Also, don't show errors for empty DIMM
> +		 * slots.
>  		 */
> -		if (!e->enable_per_layer_report || !dimm->nr_pages)
> +		if (any_memory || !dimm->nr_pages)
>  			continue;
>  
>  		if (n_labels >= EDAC_MAX_LABELS) {
> -			e->enable_per_layer_report = false;
> +			any_memory = true;
>  			break;
>  		}
>  		n_labels++;
> @@ -1218,7 +1182,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			chan = -2;
>  	}
>  
> -	if (!e->enable_per_layer_report) {
> +	if (any_memory) {
>  		strcpy(e->label, "any memory");
>  	} else {
>  		edac_dbg(4, "csrow/channel to increment: (%d,%d)\n", row, chan);
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 0367554e7437..8682df2f7f4f 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -556,10 +556,8 @@ static ssize_t dimmdev_ce_count_show(struct device *dev,
>  				      char *data)
>  {
>  	struct dimm_info *dimm = to_dimm(dev);
> -	u32 count;
>  
> -	count = dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
> -	return sprintf(data, "%u\n", count);
> +	return sprintf(data, "%u\n", dimm->ce_count);
>  }
>  
>  static ssize_t dimmdev_ue_count_show(struct device *dev,
> @@ -567,10 +565,8 @@ static ssize_t dimmdev_ue_count_show(struct device *dev,
>  				      char *data)
>  {
>  	struct dimm_info *dimm = to_dimm(dev);
> -	u32 count;
>  
> -	count = dimm->mci->ue_per_layer[dimm->mci->n_layers-1][dimm->idx];
> -	return sprintf(data, "%u\n", count);
> +	return sprintf(data, "%u\n", dimm->ue_count);
>  }
>  
>  /* dimm/rank attribute files */
> @@ -666,7 +662,9 @@ static ssize_t mci_reset_counters_store(struct device *dev,
>  					const char *data, size_t count)
>  {
>  	struct mem_ctl_info *mci = to_mci(dev);
> -	int cnt, row, chan, i;
> +	struct dimm_info *dimm;
> +	int row, chan;
> +
>  	mci->ue_mc = 0;
>  	mci->ce_mc = 0;
>  	mci->ue_noinfo_count = 0;
> @@ -682,11 +680,9 @@ static ssize_t mci_reset_counters_store(struct device *dev,
>  			ri->channels[chan]->ce_count = 0;
>  	}
>  
> -	cnt = 1;
> -	for (i = 0; i < mci->n_layers; i++) {
> -		cnt *= mci->layers[i].size;
> -		memset(mci->ce_per_layer[i], 0, cnt * sizeof(u32));
> -		memset(mci->ue_per_layer[i], 0, cnt * sizeof(u32));
> +	mci_for_each_dimm(mci, dimm) {
> +		dimm->ue_count = 0;
> +		dimm->ce_count = 0;
>  	}
>  
>  	mci->start_time = jiffies;
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 725b9c58c028..74017da1f72c 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -356,11 +356,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  				     mem_err->mem_dev_handle);
>  
>  		index = get_dimm_smbios_index(mci, mem_err->mem_dev_handle);
> -		if (index >= 0) {
> +		if (index >= 0)
>  			e->top_layer = index;
> -			e->enable_per_layer_report = true;
> -		}
> -
>  	}
>  	if (p > e->location)
>  		*(p - 1) = '\0';
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 67be279abd11..4d9673954856 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -383,6 +383,9 @@ struct dimm_info {
>  	unsigned int csrow, cschannel;	/* Points to the old API data */
>  
>  	u16 smbios_handle;              /* Handle for SMBIOS type 17 */
> +
> +	u32 ce_count;
> +	u32 ue_count;
>  };
>  
>  /**
> @@ -453,8 +456,6 @@ struct errcount_attribute_data {
>   * @location:			location of the error
>   * @label:			label of the affected DIMM(s)
>   * @other_detail:		other driver-specific detail about the error
> - * @enable_per_layer_report:	if false, the error affects all layers
> - *				(typically, a memory controller error)
>   */
>  struct edac_raw_error_desc {
>  	char location[LOCATION_SIZE];
> @@ -470,7 +471,6 @@ struct edac_raw_error_desc {
>  	unsigned long syndrome;
>  	const char *msg;
>  	const char *other_detail;
> -	bool enable_per_layer_report;
>  };
>  
>  /* MEMORY controller information structure
> @@ -560,7 +560,6 @@ struct mem_ctl_info {
>  	 */
>  	u32 ce_noinfo_count, ue_noinfo_count;
>  	u32 ue_mc, ce_mc;
> -	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
>  
>  	struct completion complete;
>  




Cheers,
Mauro

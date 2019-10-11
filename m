Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52214D3D94
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfJKKkl (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:40:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56192 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfJKKkl (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cDHpjKoFNktaD3Z6ufNt24HMJJnXiABdxwOQGHjfm9o=; b=fpZOFQacMPlkz/RkI4QXhrXNQ
        rLOXTE8OUjixc4s7MO/OeQEOHHaSnFMQVSwUCn0kPqlbykpTxCS9Y3JwMBZjfoYbkZ57PWLkO5HYC
        5REr9TvShRsF3rUM3/6p+wt1E7P8eiwzvIfvIMmLarM5YfOqu1OQ9nYHmcrcP954laMoGUg7hwH5t
        3dc8uPmF8gv6Y6cFkTDT6jDLP/CaT/wO2Ahs9p3G55kBHjUIsifUbiDcnsso3pOMW+3Ey8BzA3PZI
        iNChOh1RlSKwxJhbTqKC+EnuVKXiok5wYOhczehNVefBzS6SsfE+yJ5F7HDyUEtPMwKMIx2yHHJQX
        t5tblPLcw==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsLb-0006ta-B7; Fri, 11 Oct 2019 10:40:35 +0000
Date:   Fri, 11 Oct 2019 07:40:31 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/19] EDAC, mc: Remove per layer counters
Message-ID: <20191011074031.699396df@coco.lan>
In-Reply-To: <20191010202418.25098-7-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-7-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:16 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Looking at how mci->{ue,ce}_per_layer[EDAC_MAX_LAYERS] is used, it
> turns out that only the leaves in the memory hierarchy are consumed
> (in sysfs), but not the intermediate layers, e.g.:
> 
>  count = dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
> 
> These unused counters only add complexity, remove them. The error
> counter values are directly stored in struct dimm_info now.

Hmm... not sure if this patch is correct. I remember that there are some
border cases on some drivers (maybe the 3-layer drivers used together
with RDIMM memory controllers?) where some errors are not associated
to an specific dimm, but, instead, are related to a problem at the memory
bus.

Also, depending on how the memory controllers are organized[1], the ECC
logic groups memory on DIMM pairs. So, when an error occur, it may be
either at DIMM1 or DIMM2.

[1] On Intel, this happens with pre-Nehalem memory controllers.

Due to that, storing errors at the dimm struct sounds wrong, as the
error may affect multiple DIMMs or even the entire layer.

> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       | 104 ++++++++++++-----------------------
>  drivers/edac/edac_mc_sysfs.c |  20 +++----
>  drivers/edac/ghes_edac.c     |   5 +-
>  include/linux/edac.h         |   7 +--
>  4 files changed, 46 insertions(+), 90 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 45b02bb31964..c1e142643006 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -315,10 +315,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
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
>  	int i, j, row, chn, n, len;
>  	bool per_rank = false;
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
> @@ -1064,16 +1026,16 @@ void edac_raw_mc_handle_error(const enum hw_event_mc_err_type type,
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
> @@ -1099,6 +1061,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	int i, n_labels = 0;
>  	u8 grain_bits;
>  	struct edac_raw_error_desc *e = &mci->error_desc;
> +	bool any_memory = true;
>  
>  	edac_dbg(3, "MC%d\n", mci->mc_idx);
>  
> @@ -1116,9 +1079,9 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
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
> @@ -1136,7 +1099,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			pos[i] = -1;
>  		}
>  		if (pos[i] >= 0)
> -			e->enable_per_layer_report = true;
> +			any_memory = false;
>  	}
>  
>  	/*
> @@ -1166,16 +1129,17 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
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
> @@ -1205,7 +1169,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
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
> index 842080d7b33a..e0b90c6d7d63 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -347,11 +347,8 @@ void ghes_edac_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
>  				     mem_err->mem_dev_handle);
>  
>  		index = get_dimm_smbios_index(mem_err->mem_dev_handle);
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
> index 8beb6e834be9..8e72222e50b0 100644
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
>  	/*
> @@ -475,7 +476,6 @@ struct edac_raw_error_desc {
>  	unsigned long syndrome;
>  	const char *msg;
>  	const char *other_detail;
> -	bool enable_per_layer_report;
>  };
>  
>  /* MEMORY controller information structure
> @@ -565,7 +565,6 @@ struct mem_ctl_info {
>  	 */
>  	u32 ce_noinfo_count, ue_noinfo_count;
>  	u32 ue_mc, ce_mc;
> -	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
>  
>  	struct completion complete;
>  



Thanks,
Mauro

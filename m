Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFA0F5DC5
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 08:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbfKIHXu (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 02:23:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45886 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbfKIHXu (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Nov 2019 02:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GhoLGekYLQEefbdUePSHiGAxProGYMWgLbqjy8icDQI=; b=mfC7HLfP1KDkmTPQdDziLZbu4
        NK9HMORYo1MzG02DT2Z8eX1jKJtfoDrPk3VF6J1kkVld3bsHs/aH3J6w1vJo/XH1brKXbpD0sg7NI
        fOPmaqqUpUFVG1FjdEIVYtjP6NB7y4gH96kRq5XgDaoRJ3MlARJZwhJ1Si7oJzZ1guAMqQty/tNtd
        CqL0p3qqfgbDnhPui5F4bilxOdv+3eW31LnGGpfwn3hNBnfzzSofBakLzqc2BgoUXhCzLBP5mlDdd
        F/gVNjQnujd6e/9Z27n/omRYoyY27WSfOB5id/cX5+KqlcJB8fEbc+iLkn0R2CHtXZ3tqqUZuh0sN
        HELvFSPPQ==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTL5p-0004c4-Uz; Sat, 09 Nov 2019 07:23:37 +0000
Date:   Sat, 9 Nov 2019 08:23:29 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        Jason Baron <jbaron@akamai.com>, Tero Kristo <t-kristo@ti.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v2 01/20] EDAC: Replace EDAC_DIMM_PTR() macro with
 edac_get_dimm() function
Message-ID: <20191109082329.6aa0bb23@kernel.org>
In-Reply-To: <20191106093239.25517-2-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
        <20191106093239.25517-2-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 6 Nov 2019 09:33:02 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> The EDAC_DIMM_PTR() macro takes 3 arguments from struct mem_ctl_info.
> Clean up this interface to only pass the mci struct and replace this
> macro with the new function edac_get_dimm().
> 
> Also introduce the edac_get_dimm_by_index() function for later use.
> This allows it to get a dimm pointer only by a given index. This can
> be useful if the dimm's position within the layers of the memory
> controller or the exact size of the layers are unknown.
> 
> Small style changes made for some hunks after applying the semantic
> patch.
> 
> Semantic patch used:
> 
> @@ expression mci, a, b,c; @@
> 
> -EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, a, b, c)
> +edac_get_dimm(mci, a, b, c)
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/edac/ghes_edac.c    |  7 +--
>  drivers/edac/i10nm_base.c   |  3 +-
>  drivers/edac/i3200_edac.c   |  3 +-
>  drivers/edac/i5000_edac.c   |  5 +--
>  drivers/edac/i5100_edac.c   |  3 +-
>  drivers/edac/i5400_edac.c   |  3 +-
>  drivers/edac/i7300_edac.c   |  3 +-
>  drivers/edac/i7core_edac.c  |  3 +-
>  drivers/edac/ie31200_edac.c |  7 +--
>  drivers/edac/pnd2_edac.c    |  4 +-
>  drivers/edac/sb_edac.c      |  2 +-
>  drivers/edac/skx_base.c     |  3 +-
>  drivers/edac/ti_edac.c      |  2 +-
>  include/linux/edac.h        | 88 ++++++++++++++++++++++++-------------
>  14 files changed, 74 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 5da85ef7966d..d92cd99081d2 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -106,9 +106,7 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  
>  	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
>  		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
> -		struct dimm_info *dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -						       mci->n_layers,
> -						       dimm_fill->count, 0, 0);
> +		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count, 0, 0);
>  		u16 rdr_mask = BIT(7) | BIT(13);
>  
>  		if (entry->size == 0xffff) {
> @@ -543,8 +541,7 @@ int ghes_edac_register(struct ghes *ghes, struct device *dev)
>  		dimm_fill.mci = mci;
>  		dmi_walk(ghes_edac_dmidecode, &dimm_fill);
>  	} else {
> -		struct dimm_info *dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -						       mci->n_layers, 0, 0, 0);
> +		struct dimm_info *dimm = edac_get_dimm(mci, 0, 0, 0);
>  
>  		dimm->nr_pages = 1;
>  		dimm->grain = 128;
> diff --git a/drivers/edac/i10nm_base.c b/drivers/edac/i10nm_base.c
> index c370d5457e6b..059eccf0582b 100644
> --- a/drivers/edac/i10nm_base.c
> +++ b/drivers/edac/i10nm_base.c
> @@ -154,8 +154,7 @@ static int i10nm_get_dimm_config(struct mem_ctl_info *mci)
>  
>  		ndimms = 0;
>  		for (j = 0; j < I10NM_NUM_DIMMS; j++) {
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -					     mci->n_layers, i, j, 0);
> +			dimm = edac_get_dimm(mci, i, j, 0);
>  			mtr = I10NM_GET_DIMMMTR(imc, i, j);
>  			mcddrtcfg = I10NM_GET_MCDDRTCFG(imc, i, j);
>  			edac_dbg(1, "dimmmtr 0x%x mcddrtcfg 0x%x (mc%d ch%d dimm%d)\n",
> diff --git a/drivers/edac/i3200_edac.c b/drivers/edac/i3200_edac.c
> index 299b441647cd..432b375a4075 100644
> --- a/drivers/edac/i3200_edac.c
> +++ b/drivers/edac/i3200_edac.c
> @@ -392,8 +392,7 @@ static int i3200_probe1(struct pci_dev *pdev, int dev_idx)
>  		unsigned long nr_pages;
>  
>  		for (j = 0; j < nr_channels; j++) {
> -			struct dimm_info *dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -							       mci->n_layers, i, j, 0);
> +			struct dimm_info *dimm = edac_get_dimm(mci, i, j, 0);
>  
>  			nr_pages = drb_to_nr_pages(drbs, stacked, j, i);
>  			if (nr_pages == 0)
> diff --git a/drivers/edac/i5000_edac.c b/drivers/edac/i5000_edac.c
> index 078a7351bf05..1a6f69c859ab 100644
> --- a/drivers/edac/i5000_edac.c
> +++ b/drivers/edac/i5000_edac.c
> @@ -1275,9 +1275,8 @@ static int i5000_init_csrows(struct mem_ctl_info *mci)
>  			if (!MTR_DIMMS_PRESENT(mtr))
>  				continue;
>  
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
> -				       channel / MAX_BRANCHES,
> -				       channel % MAX_BRANCHES, slot);
> +			dimm = edac_get_dimm(mci, channel / MAX_BRANCHES,
> +					     channel % MAX_BRANCHES, slot);
>  
>  			csrow_megs = pvt->dimm_info[slot][channel].megabytes;
>  			dimm->grain = 8;
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index 12bebecb203b..134586753311 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -858,8 +858,7 @@ static void i5100_init_csrows(struct mem_ctl_info *mci)
>  		if (!npages)
>  			continue;
>  
> -		dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
> -			       chan, rank, 0);
> +		dimm = edac_get_dimm(mci, chan, rank, 0);
>  
>  		dimm->nr_pages = npages;
>  		dimm->grain = 32;
> diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
> index 8c86c6fd7da7..f131c05ade9f 100644
> --- a/drivers/edac/i5400_edac.c
> +++ b/drivers/edac/i5400_edac.c
> @@ -1187,8 +1187,7 @@ static int i5400_init_dimms(struct mem_ctl_info *mci)
>  			if (!MTR_DIMMS_PRESENT(mtr))
>  				continue;
>  
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
> -				       channel / 2, channel % 2, slot);
> +			dimm = edac_get_dimm(mci, channel / 2, channel % 2, slot);
>  
>  			size_mb =  pvt->dimm_info[slot][channel].megabytes;
>  
> diff --git a/drivers/edac/i7300_edac.c b/drivers/edac/i7300_edac.c
> index 447d357c7a67..2e9bbe56cde9 100644
> --- a/drivers/edac/i7300_edac.c
> +++ b/drivers/edac/i7300_edac.c
> @@ -794,8 +794,7 @@ static int i7300_init_csrows(struct mem_ctl_info *mci)
>  			for (ch = 0; ch < max_channel; ch++) {
>  				int channel = to_channel(ch, branch);
>  
> -				dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -					       mci->n_layers, branch, ch, slot);
> +				dimm = edac_get_dimm(mci, branch, ch, slot);
>  
>  				dinfo = &pvt->dimm_info[slot][channel];
>  
> diff --git a/drivers/edac/i7core_edac.c b/drivers/edac/i7core_edac.c
> index a71cca6eeb33..b3135b208f9a 100644
> --- a/drivers/edac/i7core_edac.c
> +++ b/drivers/edac/i7core_edac.c
> @@ -585,8 +585,7 @@ static int get_dimm_config(struct mem_ctl_info *mci)
>  			if (!DIMM_PRESENT(dimm_dod[j]))
>  				continue;
>  
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
> -				       i, j, 0);
> +			dimm = edac_get_dimm(mci, i, j, 0);
>  			banks = numbank(MC_DOD_NUMBANK(dimm_dod[j]));
>  			ranks = numrank(MC_DOD_NUMRANK(dimm_dod[j]));
>  			rows = numrow(MC_DOD_NUMROW(dimm_dod[j]));
> diff --git a/drivers/edac/ie31200_edac.c b/drivers/edac/ie31200_edac.c
> index d26300f9cb07..4f65073f230b 100644
> --- a/drivers/edac/ie31200_edac.c
> +++ b/drivers/edac/ie31200_edac.c
> @@ -490,9 +490,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
>  
>  			if (dimm_info[j][i].dual_rank) {
>  				nr_pages = nr_pages / 2;
> -				dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -						     mci->n_layers, (i * 2) + 1,
> -						     j, 0);
> +				dimm = edac_get_dimm(mci, (i * 2) + 1, j, 0);
>  				dimm->nr_pages = nr_pages;
>  				edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
>  				dimm->grain = 8; /* just a guess */
> @@ -503,8 +501,7 @@ static int ie31200_probe1(struct pci_dev *pdev, int dev_idx)
>  				dimm->dtype = DEV_UNKNOWN;
>  				dimm->edac_mode = EDAC_UNKNOWN;
>  			}
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -					     mci->n_layers, i * 2, j, 0);
> +			dimm = edac_get_dimm(mci, i * 2, j, 0);
>  			dimm->nr_pages = nr_pages;
>  			edac_dbg(0, "set nr pages: 0x%lx\n", nr_pages);
>  			dimm->grain = 8; /* same guess */
> diff --git a/drivers/edac/pnd2_edac.c b/drivers/edac/pnd2_edac.c
> index b1193be1ef1d..933f7722b893 100644
> --- a/drivers/edac/pnd2_edac.c
> +++ b/drivers/edac/pnd2_edac.c
> @@ -1231,7 +1231,7 @@ static void apl_get_dimm_config(struct mem_ctl_info *mci)
>  		if (!(chan_mask & BIT(i)))
>  			continue;
>  
> -		dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, 0, 0);
> +		dimm = edac_get_dimm(mci, i, 0, 0);
>  		if (!dimm) {
>  			edac_dbg(0, "No allocated DIMM for channel %d\n", i);
>  			continue;
> @@ -1311,7 +1311,7 @@ static void dnv_get_dimm_config(struct mem_ctl_info *mci)
>  			if (!ranks_of_dimm[j])
>  				continue;
>  
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, j, 0);
> +			dimm = edac_get_dimm(mci, i, j, 0);
>  			if (!dimm) {
>  				edac_dbg(0, "No allocated DIMM for channel %d DIMM %d\n", i, j);
>  				continue;
> diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
> index a2fd39d330d6..4957e8ee1879 100644
> --- a/drivers/edac/sb_edac.c
> +++ b/drivers/edac/sb_edac.c
> @@ -1621,7 +1621,7 @@ static int __populate_dimms(struct mem_ctl_info *mci,
>  		}
>  
>  		for (j = 0; j < max_dimms_per_channel; j++) {
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, i, j, 0);
> +			dimm = edac_get_dimm(mci, i, j, 0);
>  			if (pvt->info.type == KNIGHTS_LANDING) {
>  				pci_read_config_dword(pvt->knl.pci_channel[i],
>  					knl_mtr_reg, &mtr);
> diff --git a/drivers/edac/skx_base.c b/drivers/edac/skx_base.c
> index a8853e724d1f..83545b4facb7 100644
> --- a/drivers/edac/skx_base.c
> +++ b/drivers/edac/skx_base.c
> @@ -189,8 +189,7 @@ static int skx_get_dimm_config(struct mem_ctl_info *mci)
>  		pci_read_config_dword(imc->chan[i].cdev, 0x8C, &amap);
>  		pci_read_config_dword(imc->chan[i].cdev, 0x400, &mcddrtcfg);
>  		for (j = 0; j < SKX_NUM_DIMMS; j++) {
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -					     mci->n_layers, i, j, 0);
> +			dimm = edac_get_dimm(mci, i, j, 0);
>  			pci_read_config_dword(imc->chan[i].cdev,
>  					      0x80 + 4 * j, &mtr);
>  			if (IS_DIMM_PRESENT(mtr)) {
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 6ac26d1b929f..8be3e89a510e 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -135,7 +135,7 @@ static void ti_edac_setup_dimm(struct mem_ctl_info *mci, u32 type)
>  	u32 val;
>  	u32 memsize;
>  
> -	dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers, 0, 0, 0);
> +	dimm = edac_get_dimm(mci, 0, 0, 0);
>  
>  	val = ti_edac_readl(edac, EMIF_SDRAM_CONFIG);
>  
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index c19483b90079..696bfb684d92 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -403,37 +403,6 @@ struct edac_mc_layer {
>  	__i;								\
>  })
>  
> -/**
> - * EDAC_DIMM_PTR - Macro responsible to get a pointer inside a pointer array
> - *		   for the element given by [layer0,layer1,layer2] position
> - *
> - * @layers:	a struct edac_mc_layer array, describing how many elements
> - *		were allocated for each layer
> - * @var:	name of the var where we want to get the pointer
> - *		(like mci->dimms)
> - * @nlayers:	Number of layers at the @layers array
> - * @layer0:	layer0 position
> - * @layer1:	layer1 position. Unused if n_layers < 2
> - * @layer2:	layer2 position. Unused if n_layers < 3
> - *
> - * For 1 layer, this macro returns "var[layer0]";
> - *
> - * For 2 layers, this macro is similar to allocate a bi-dimensional array
> - * and to return "var[layer0][layer1]";
> - *
> - * For 3 layers, this macro is similar to allocate a tri-dimensional array
> - * and to return "var[layer0][layer1][layer2]";
> - */
> -#define EDAC_DIMM_PTR(layers, var, nlayers, layer0, layer1, layer2) ({	\
> -	typeof(*var) __p;						\
> -	int ___i = EDAC_DIMM_OFF(layers, nlayers, layer0, layer1, layer2);	\
> -	if (___i < 0)							\
> -		__p = NULL;						\
> -	else								\
> -		__p = (var)[___i];					\
> -	__p;								\
> -})
> -
>  struct dimm_info {
>  	struct device dev;
>  
> @@ -669,4 +638,61 @@ struct mem_ctl_info {
>  	bool fake_inject_ue;
>  	u16 fake_inject_count;
>  };
> +
> +/**
> + * edac_get_dimm_by_index - Get DIMM info from a memory controller
> + *                          given by an index
> + *
> + * @mci:	a struct mem_ctl_info
> + * @index:	index in the memory controller's DIMM array
> + *
> + * Returns a struct dimm_info* or NULL on failure.
> + */
> +static inline struct dimm_info *
> +edac_get_dimm_by_index(struct mem_ctl_info *mci, int index)
> +{
> +	if (index < 0 || index >= mci->tot_dimms)
> +		return NULL;
> +
> +	return mci->dimms[index];
> +}
> +
> +/**
> + * edac_get_dimm - Get DIMM info from a memory controller given by
> + *                 [layer0,layer1,layer2] position
> + *
> + * @mci:	a struct mem_ctl_info
> + * @layer0:	layer0 position
> + * @layer1:	layer1 position. Unused if n_layers < 2
> + * @layer2:	layer2 position. Unused if n_layers < 3
> + *
> + * For 1 layer, this function returns "dimms[layer0]";
> + *
> + * For 2 layers, this function is similar to allocate a bi-dimensional
> + * array and to return "dimms[layer0][layer1]";
> + *
> + * For 3 layers, this function is similar to allocate a tri-dimensional array
> + * and to return "dimms[layer0][layer1][layer2]";
> + */
> +static inline struct dimm_info *edac_get_dimm(struct mem_ctl_info *mci,
> +	int layer0, int layer1, int layer2)
> +{
> +	int index;
> +
> +	if (layer0 < 0
> +	    || (mci->n_layers > 1 && layer1 < 0)
> +	    || (mci->n_layers > 2 && layer2 < 0))
> +		return NULL;
> +
> +	index = layer0;
> +
> +	if (mci->n_layers > 1)
> +		index = index * mci->layers[1].size + layer1;
> +
> +	if (mci->n_layers > 2)
> +		index = index * mci->layers[2].size + layer2;
> +
> +	return edac_get_dimm_by_index(mci, index);
> +}
> +
>  #endif




Cheers,
Mauro

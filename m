Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84104D3DA1
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfJKKnw (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:43:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56400 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKKnv (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K5ERSZk8gSuRPFS86h8zzN8u9sVtC2cNRVgrBQVPbgk=; b=p/ZNMwlOjTtB0RtzM0DwtwE0O
        8Bkx57DSxOQSB6E9AJhpOfCOByWELpYlQ71oTWpyaFJmWIS8NJL7M3hm8O54NrOU0Q492KQfgcwSB
        QwiDkBzUXylfd6hh1IpWN5tyebh7Nu+Wx6VdxrF+g6Qq8O3KtH9ONYDdZr72aqQbuovu229O2nL8z
        AH5l+QhdF102tFjM4aBhMrp7xFvuUvL/1vdFzGd7MoXbTOTnfIeceSOA+swtqpQ4szD1gVgVxzAn1
        B2s0auQvET+hiM2aIe8YYsMz8fpexXOzoK4hEGfu+WlFaMnW4j1LJYDOpYm9ZPHEmPPLJZ+yASFhn
        OSpdtc5QA==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsOg-00076f-Tm; Fri, 11 Oct 2019 10:43:47 +0000
Date:   Fri, 11 Oct 2019 07:43:42 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/19] EDAC, mc: Split edac_mc_alloc() into smaller
 functions
Message-ID: <20191011074342.71e443a9@coco.lan>
In-Reply-To: <20191010202418.25098-9-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-9-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:20 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> edac_mc_alloc() is huge. Factor out code by moving it to the two new
> functions edac_mc_alloc_csrows() and edac_mc_alloc_dimms(). Do not
> move code yet for better review.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c | 104 +++++++++++++++++++++++++++--------------
>  1 file changed, 69 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index a893f793be8a..0db504cb3419 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -305,6 +305,9 @@ static void _edac_mc_free(struct mem_ctl_info *mci)
>  	kfree(mci);
>  }
>  
> +static int edac_mc_alloc_csrows(struct mem_ctl_info *mci);
> +static int edac_mc_alloc_dimms(struct mem_ctl_info *mci);
> +
>  struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  				   unsigned int n_layers,
>  				   struct edac_mc_layer *layers,
> @@ -312,14 +315,9 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  {
>  	struct mem_ctl_info *mci;
>  	struct edac_mc_layer *layer;
> -	struct csrow_info *csr;
> -	struct rank_info *chan;
> -	struct dimm_info *dimm;
> -	unsigned int pos[EDAC_MAX_LAYERS];
>  	unsigned int idx, size, tot_dimms = 1;
>  	unsigned int tot_csrows = 1, tot_channels = 1;
> -	void *pvt, *p, *ptr = NULL;
> -	int j, row, chn, n, len;
> +	void *pvt, *ptr = NULL;
>  	bool per_rank = false;
>  
>  	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> @@ -377,16 +375,43 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	mci->num_cschannel = tot_channels;
>  	mci->csbased = per_rank;
>  
> +	if (edac_mc_alloc_csrows(mci))
> +		goto error;
> +
> +	if (edac_mc_alloc_dimms(mci))
> +		goto error;
> +
> +	mci->op_state = OP_ALLOC;
> +
> +	return mci;
> +
> +error:
> +	_edac_mc_free(mci);
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(edac_mc_alloc);
> +
> +static int edac_mc_alloc_csrows(struct mem_ctl_info *mci)
> +{
> +	unsigned int tot_csrows = mci->nr_csrows;
> +	unsigned int tot_channels = mci->num_cschannel;
> +	unsigned int row, chn;
> +
>  	/*
>  	 * Alocate and fill the csrow/channels structs
>  	 */
>  	mci->csrows = kcalloc(tot_csrows, sizeof(*mci->csrows), GFP_KERNEL);
>  	if (!mci->csrows)
> -		goto error;
> +		return -ENOMEM;
> +
>  	for (row = 0; row < tot_csrows; row++) {
> +		struct csrow_info *csr;
> +
>  		csr = kzalloc(sizeof(**mci->csrows), GFP_KERNEL);
>  		if (!csr)
> -			goto error;
> +			return -ENOMEM;
> +
>  		mci->csrows[row] = csr;
>  		csr->csrow_idx = row;
>  		csr->mci = mci;
> @@ -394,34 +419,51 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  		csr->channels = kcalloc(tot_channels, sizeof(*csr->channels),
>  					GFP_KERNEL);
>  		if (!csr->channels)
> -			goto error;
> +			return -ENOMEM;
>  
>  		for (chn = 0; chn < tot_channels; chn++) {
> +			struct rank_info *chan;
> +
>  			chan = kzalloc(sizeof(**csr->channels), GFP_KERNEL);
>  			if (!chan)
> -				goto error;
> +				return -ENOMEM;
> +
>  			csr->channels[chn] = chan;
>  			chan->chan_idx = chn;
>  			chan->csrow = csr;
>  		}
>  	}
>  
> +	return 0;
> +}
> +
> +static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
> +{
> +	void *p;
> +	unsigned int pos[EDAC_MAX_LAYERS];
> +	unsigned int row, chn, idx;
> +	int layer;
> +
>  	/*
>  	 * Allocate and fill the dimm structs
>  	 */
> -	mci->dimms  = kcalloc(tot_dimms, sizeof(*mci->dimms), GFP_KERNEL);
> +	mci->dimms  = kcalloc(mci->tot_dimms, sizeof(*mci->dimms), GFP_KERNEL);
>  	if (!mci->dimms)
> -		goto error;
> +		return -ENOMEM;
>  
>  	memset(&pos, 0, sizeof(pos));
>  	row = 0;
>  	chn = 0;
> -	for (idx = 0; idx < tot_dimms; idx++) {
> +	for (idx = 0; idx < mci->tot_dimms; idx++) {
> +		struct dimm_info *dimm;
> +		struct rank_info *chan;
> +		int n, len;
> +
>  		chan = mci->csrows[row]->channels[chn];
>  
>  		dimm = kzalloc(sizeof(**mci->dimms), GFP_KERNEL);
>  		if (!dimm)
> -			goto error;
> +			return -ENOMEM;
>  		mci->dimms[idx] = dimm;
>  		dimm->mci = mci;
>  		dimm->idx = idx;
> @@ -431,16 +473,16 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  		 */
>  		len = sizeof(dimm->label);
>  		p = dimm->label;
> -		n = snprintf(p, len, "mc#%u", mc_num);
> +		n = snprintf(p, len, "mc#%u", mci->mc_idx);
>  		p += n;
>  		len -= n;
> -		for (j = 0; j < n_layers; j++) {
> +		for (layer = 0; layer < mci->n_layers; layer++) {
>  			n = snprintf(p, len, "%s#%u",
> -				     edac_layer_name[layers[j].type],
> -				     pos[j]);
> +				     edac_layer_name[mci->layers[layer].type],
> +				     pos[layer]);
>  			p += n;
>  			len -= n;
> -			dimm->location[j] = pos[j];
> +			dimm->location[layer] = pos[layer];
>  
>  			if (len <= 0)
>  				break;
> @@ -452,39 +494,31 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  		dimm->cschannel = chn;
>  
>  		/* Increment csrow location */
> -		if (layers[0].is_virt_csrow) {
> +		if (mci->layers[0].is_virt_csrow) {
>  			chn++;
> -			if (chn == tot_channels) {
> +			if (chn == mci->num_cschannel) {
>  				chn = 0;
>  				row++;
>  			}
>  		} else {
>  			row++;
> -			if (row == tot_csrows) {
> +			if (row == mci->nr_csrows) {
>  				row = 0;
>  				chn++;
>  			}
>  		}
>  
>  		/* Increment dimm location */
> -		for (j = n_layers - 1; j >= 0; j--) {
> -			pos[j]++;
> -			if (pos[j] < layers[j].size)
> +		for (layer = mci->n_layers - 1; layer >= 0; layer--) {
> +			pos[layer]++;
> +			if (pos[layer] < mci->layers[layer].size)
>  				break;
> -			pos[j] = 0;
> +			pos[layer] = 0;
>  		}
>  	}
>  
> -	mci->op_state = OP_ALLOC;
> -
> -	return mci;
> -
> -error:
> -	_edac_mc_free(mci);
> -
> -	return NULL;
> +	return 0;
>  }
> -EXPORT_SYMBOL_GPL(edac_mc_alloc);
>  
>  void edac_mc_free(struct mem_ctl_info *mci)
>  {



Thanks,
Mauro

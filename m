Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9299FD3DA5
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfJKKpr (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:45:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfJKKpr (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cDlPI06ahYBkq4LgKL96dzmsP4/GQC0UWXu1LSNAz7I=; b=jvHgwQuocSdFbPpI5BihLWOtE
        nZaO6Kusd6/6utc7eEQ8Js/Wl5F2zu8Hcu6T8ajWkkkXrFKX+7snX0Wcrpq5DPhHgYujGYuFooOLh
        LOA96G5UrKX6nmnM2a/R0XuN8qRusizHeb/pULTO35/lY4N8viBqivz2zfpAHyB8pzcLEfl9JW34D
        9inivAflQ5d0BRlw8CSa3+zmBQXaNEmoGuenZQ9HkhItjxf1Ocd1rhRv1iW80yv5jndig26mRzTc8
        xVZafOYFSjMwGVhyIASwl839WMR0kjCHvOIMYsX7NWjWxnIR9RHShGIhGr8plP3MQrd5F5WU3vcBZ
        0kh+Vlyyw==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIsQY-0000F0-81; Fri, 11 Oct 2019 10:45:42 +0000
Date:   Fri, 11 Oct 2019 07:45:38 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/19] EDAC, mc: Reorder functions edac_mc_alloc*()
Message-ID: <20191011074538.7ad8715c@coco.lan>
In-Reply-To: <20191010202418.25098-10-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-10-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:22 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Reorder the new created functions edac_mc_alloc_csrows() and
> edac_mc_alloc_dimms() and move them before edac_mc_alloc(). No further
> code changes.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c | 171 ++++++++++++++++++++---------------------
>  1 file changed, 84 insertions(+), 87 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 0db504cb3419..6d880cf4d599 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -305,93 +305,6 @@ static void _edac_mc_free(struct mem_ctl_info *mci)
>  	kfree(mci);
>  }
>  
> -static int edac_mc_alloc_csrows(struct mem_ctl_info *mci);
> -static int edac_mc_alloc_dimms(struct mem_ctl_info *mci);
> -
> -struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> -				   unsigned int n_layers,
> -				   struct edac_mc_layer *layers,
> -				   unsigned int sz_pvt)
> -{
> -	struct mem_ctl_info *mci;
> -	struct edac_mc_layer *layer;
> -	unsigned int idx, size, tot_dimms = 1;
> -	unsigned int tot_csrows = 1, tot_channels = 1;
> -	void *pvt, *ptr = NULL;
> -	bool per_rank = false;
> -
> -	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> -		return NULL;
> -
> -	/*
> -	 * Calculate the total amount of dimms and csrows/cschannels while
> -	 * in the old API emulation mode
> -	 */
> -	for (idx = 0; idx < n_layers; idx++) {
> -		tot_dimms *= layers[idx].size;
> -		if (layers[idx].is_virt_csrow)
> -			tot_csrows *= layers[idx].size;
> -		else
> -			tot_channels *= layers[idx].size;
> -
> -		if (layers[idx].type == EDAC_MC_LAYER_CHIP_SELECT)
> -			per_rank = true;
> -	}
> -
> -	/* Figure out the offsets of the various items from the start of an mc
> -	 * structure.  We want the alignment of each item to be at least as
> -	 * stringent as what the compiler would provide if we could simply
> -	 * hardcode everything into a single struct.
> -	 */
> -	mci	= edac_align_ptr(&ptr, sizeof(*mci), 1);
> -	layer	= edac_align_ptr(&ptr, sizeof(*layer), n_layers);
> -	pvt	= edac_align_ptr(&ptr, sz_pvt, 1);
> -	size	= ((unsigned long)pvt) + sz_pvt;
> -
> -	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)\n",
> -		 size,
> -		 tot_dimms,
> -		 per_rank ? "ranks" : "dimms",
> -		 tot_csrows * tot_channels);
> -
> -	mci = kzalloc(size, GFP_KERNEL);
> -	if (mci == NULL)
> -		return NULL;
> -
> -	/* Adjust pointers so they point within the memory we just allocated
> -	 * rather than an imaginary chunk of memory located at address 0.
> -	 */
> -	layer = (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer));
> -	pvt = sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
> -
> -	/* setup index and various internal pointers */
> -	mci->mc_idx = mc_num;
> -	mci->tot_dimms = tot_dimms;
> -	mci->pvt_info = pvt;
> -	mci->n_layers = n_layers;
> -	mci->layers = layer;
> -	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
> -	mci->nr_csrows = tot_csrows;
> -	mci->num_cschannel = tot_channels;
> -	mci->csbased = per_rank;
> -
> -	if (edac_mc_alloc_csrows(mci))
> -		goto error;
> -
> -	if (edac_mc_alloc_dimms(mci))
> -		goto error;
> -
> -	mci->op_state = OP_ALLOC;
> -
> -	return mci;
> -
> -error:
> -	_edac_mc_free(mci);
> -
> -	return NULL;
> -}
> -EXPORT_SYMBOL_GPL(edac_mc_alloc);
> -
>  static int edac_mc_alloc_csrows(struct mem_ctl_info *mci)
>  {
>  	unsigned int tot_csrows = mci->nr_csrows;
> @@ -520,6 +433,90 @@ static int edac_mc_alloc_dimms(struct mem_ctl_info *mci)
>  	return 0;
>  }
>  
> +struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
> +				   unsigned int n_layers,
> +				   struct edac_mc_layer *layers,
> +				   unsigned int sz_pvt)
> +{
> +	struct mem_ctl_info *mci;
> +	struct edac_mc_layer *layer;
> +	unsigned int idx, size, tot_dimms = 1;
> +	unsigned int tot_csrows = 1, tot_channels = 1;
> +	void *pvt, *ptr = NULL;
> +	bool per_rank = false;
> +
> +	if (WARN_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0))
> +		return NULL;
> +
> +	/*
> +	 * Calculate the total amount of dimms and csrows/cschannels while
> +	 * in the old API emulation mode
> +	 */
> +	for (idx = 0; idx < n_layers; idx++) {
> +		tot_dimms *= layers[idx].size;
> +		if (layers[idx].is_virt_csrow)
> +			tot_csrows *= layers[idx].size;
> +		else
> +			tot_channels *= layers[idx].size;
> +
> +		if (layers[idx].type == EDAC_MC_LAYER_CHIP_SELECT)
> +			per_rank = true;
> +	}
> +
> +	/* Figure out the offsets of the various items from the start of an mc
> +	 * structure.  We want the alignment of each item to be at least as
> +	 * stringent as what the compiler would provide if we could simply
> +	 * hardcode everything into a single struct.
> +	 */
> +	mci	= edac_align_ptr(&ptr, sizeof(*mci), 1);
> +	layer	= edac_align_ptr(&ptr, sizeof(*layer), n_layers);
> +	pvt	= edac_align_ptr(&ptr, sz_pvt, 1);
> +	size	= ((unsigned long)pvt) + sz_pvt;
> +
> +	edac_dbg(1, "allocating %u bytes for mci data (%d %s, %d csrows/channels)\n",
> +		 size,
> +		 tot_dimms,
> +		 per_rank ? "ranks" : "dimms",
> +		 tot_csrows * tot_channels);
> +
> +	mci = kzalloc(size, GFP_KERNEL);
> +	if (mci == NULL)
> +		return NULL;
> +
> +	/* Adjust pointers so they point within the memory we just allocated
> +	 * rather than an imaginary chunk of memory located at address 0.
> +	 */
> +	layer = (struct edac_mc_layer *)(((char *)mci) + ((unsigned long)layer));
> +	pvt = sz_pvt ? (((char *)mci) + ((unsigned long)pvt)) : NULL;
> +
> +	/* setup index and various internal pointers */
> +	mci->mc_idx = mc_num;
> +	mci->tot_dimms = tot_dimms;
> +	mci->pvt_info = pvt;
> +	mci->n_layers = n_layers;
> +	mci->layers = layer;
> +	memcpy(mci->layers, layers, sizeof(*layer) * n_layers);
> +	mci->nr_csrows = tot_csrows;
> +	mci->num_cschannel = tot_channels;
> +	mci->csbased = per_rank;
> +
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
>  void edac_mc_free(struct mem_ctl_info *mci)
>  {
>  	edac_dbg(1, "\n");



Thanks,
Mauro

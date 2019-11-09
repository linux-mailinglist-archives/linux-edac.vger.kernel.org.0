Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB96F5DC9
	for <lists+linux-edac@lfdr.de>; Sat,  9 Nov 2019 08:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbfKIH12 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Sat, 9 Nov 2019 02:27:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46090 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfKIH12 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Sat, 9 Nov 2019 02:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aueHdu/9TjVVN8cv7ymRLhEafKGZOG64H5l2yFzCQmk=; b=A7TxJWEkPf0WUXdm+gxz9v2gV
        zot+Y9SmVq7qcyYYpXoUtmbx1EoTFBqtxoL3Fy+rekDtOq0OgSXlFs3gzGBk5UEDLKPo2Q3Nwxdfl
        jzBNkDORwR2+RDJdk+n7AsBLxLYlyetRQiFwrANI8JqBf6u+a7jK+xZ4HV5N1dMPumS41lNfLknie
        O7k/r/2i1hap7XuK+chwYI8dnGpbPC4U4A+6gsT1zKKZakCbVYPEuaVNHIMj7SXxEFqfh7uLQaoIB
        dzwqSPdVS8Au9gYm7bwseNu3iDnvYWOBXEK0UbxEkF+9bqsJcjLtwHJuoH5s/r4dtObKSrcLRG/5k
        tpAF8qKmA==;
Received: from [80.156.29.194] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iTL9Y-000687-H2; Sat, 09 Nov 2019 07:27:24 +0000
Date:   Sat, 9 Nov 2019 08:27:21 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/20] EDAC: Remove EDAC_DIMM_OFF() macro
Message-ID: <20191109082721.73aeac08@kernel.org>
In-Reply-To: <20191106093239.25517-3-rrichter@marvell.com>
References: <20191106093239.25517-1-rrichter@marvell.com>
        <20191106093239.25517-3-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Wed, 6 Nov 2019 09:33:04 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> The EDAC_DIMM_OFF() macro takes 5 arguments to get the DIMM's index.
> This can be much simplified. Store the index in struct dimm_info to
> avoid its calculation and remove the EDAC_DIMM_OFF() macro. The index
> can be directly used.
> 
> Another advantage is that edac_mc_alloc() could be used even if the
> exact size of the layers is unknown. Only the number of DIMMs would be
> needed.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---
>  drivers/edac/edac_mc.c       | 14 ++++-------
>  drivers/edac/edac_mc_sysfs.c | 20 ++++------------
>  include/linux/edac.h         | 45 ++++--------------------------------
>  3 files changed, 13 insertions(+), 66 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index e6fd079783bd..72088d49b03b 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -314,10 +314,10 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	struct dimm_info *dimm;
>  	u32 *ce_per_layer[EDAC_MAX_LAYERS], *ue_per_layer[EDAC_MAX_LAYERS];
>  	unsigned int pos[EDAC_MAX_LAYERS];
> -	unsigned int size, tot_dimms = 1, count = 1;
> +	unsigned int idx, size, tot_dimms = 1, count = 1;
>  	unsigned int tot_csrows = 1, tot_channels = 1, tot_errcount = 0;
>  	void *pvt, *p, *ptr = NULL;
> -	int i, j, row, chn, n, len, off;
> +	int i, j, row, chn, n, len;
>  	bool per_rank = false;
>  
>  	BUG_ON(n_layers > EDAC_MAX_LAYERS || n_layers == 0);
> @@ -425,19 +425,15 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
>  	memset(&pos, 0, sizeof(pos));
>  	row = 0;
>  	chn = 0;
> -	for (i = 0; i < tot_dimms; i++) {
> +	for (idx = 0; idx < tot_dimms; idx++) {
>  		chan = mci->csrows[row]->channels[chn];
> -		off = EDAC_DIMM_OFF(layer, n_layers, pos[0], pos[1], pos[2]);
> -		if (off < 0 || off >= tot_dimms) {
> -			edac_mc_printk(mci, KERN_ERR, "EDAC core bug: EDAC_DIMM_OFF is trying to do an illegal data access\n");
> -			goto error;
> -		}
>  
>  		dimm = kzalloc(sizeof(**mci->dimms), GFP_KERNEL);
>  		if (!dimm)
>  			goto error;
> -		mci->dimms[off] = dimm;
> +		mci->dimms[idx] = dimm;
>  		dimm->mci = mci;
> +		dimm->idx = idx;
>  
>  		/*
>  		 * Copy DIMM location and initialize it.
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 32d016f1ecd1..91e4c8f155af 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -557,14 +557,8 @@ static ssize_t dimmdev_ce_count_show(struct device *dev,
>  {
>  	struct dimm_info *dimm = to_dimm(dev);
>  	u32 count;
> -	int off;
> -
> -	off = EDAC_DIMM_OFF(dimm->mci->layers,
> -			    dimm->mci->n_layers,
> -			    dimm->location[0],
> -			    dimm->location[1],
> -			    dimm->location[2]);
> -	count = dimm->mci->ce_per_layer[dimm->mci->n_layers-1][off];
> +
> +	count = dimm->mci->ce_per_layer[dimm->mci->n_layers-1][dimm->idx];
>  	return sprintf(data, "%u\n", count);
>  }
>  
> @@ -574,14 +568,8 @@ static ssize_t dimmdev_ue_count_show(struct device *dev,
>  {
>  	struct dimm_info *dimm = to_dimm(dev);
>  	u32 count;
> -	int off;
> -
> -	off = EDAC_DIMM_OFF(dimm->mci->layers,
> -			    dimm->mci->n_layers,
> -			    dimm->location[0],
> -			    dimm->location[1],
> -			    dimm->location[2]);
> -	count = dimm->mci->ue_per_layer[dimm->mci->n_layers-1][off];
> +
> +	count = dimm->mci->ue_per_layer[dimm->mci->n_layers-1][dimm->idx];
>  	return sprintf(data, "%u\n", count);
>  }
>  
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 696bfb684d92..79c5564ee314 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -362,47 +362,6 @@ struct edac_mc_layer {
>   */
>  #define EDAC_MAX_LAYERS		3
>  
> -/**
> - * EDAC_DIMM_OFF - Macro responsible to get a pointer offset inside a pointer
> - *		   array for the element given by [layer0,layer1,layer2]
> - *		   position
> - *
> - * @layers:	a struct edac_mc_layer array, describing how many elements
> - *		were allocated for each layer
> - * @nlayers:	Number of layers at the @layers array
> - * @layer0:	layer0 position
> - * @layer1:	layer1 position. Unused if n_layers < 2
> - * @layer2:	layer2 position. Unused if n_layers < 3
> - *
> - * For 1 layer, this macro returns "var[layer0] - var";
> - *
> - * For 2 layers, this macro is similar to allocate a bi-dimensional array
> - * and to return "var[layer0][layer1] - var";
> - *
> - * For 3 layers, this macro is similar to allocate a tri-dimensional array
> - * and to return "var[layer0][layer1][layer2] - var".
> - *
> - * A loop could be used here to make it more generic, but, as we only have
> - * 3 layers, this is a little faster.
> - *
> - * By design, layers can never be 0 or more than 3. If that ever happens,
> - * a NULL is returned, causing an OOPS during the memory allocation routine,
> - * with would point to the developer that he's doing something wrong.
> - */
> -#define EDAC_DIMM_OFF(layers, nlayers, layer0, layer1, layer2) ({		\
> -	int __i;							\
> -	if ((nlayers) == 1)						\
> -		__i = layer0;						\
> -	else if ((nlayers) == 2)					\
> -		__i = (layer1) + ((layers[1]).size * (layer0));		\
> -	else if ((nlayers) == 3)					\
> -		__i = (layer2) + ((layers[2]).size * ((layer1) +	\
> -			    ((layers[1]).size * (layer0))));		\
> -	else								\
> -		__i = -EINVAL;						\
> -	__i;								\
> -})
> -
>  struct dimm_info {
>  	struct device dev;
>  
> @@ -412,6 +371,7 @@ struct dimm_info {
>  	unsigned int location[EDAC_MAX_LAYERS];
>  
>  	struct mem_ctl_info *mci;	/* the parent */
> +	unsigned int idx;		/* index within the parent dimm array */
>  
>  	u32 grain;		/* granularity of reported error in bytes */
>  	enum dev_type dtype;	/* memory device type */
> @@ -654,6 +614,9 @@ edac_get_dimm_by_index(struct mem_ctl_info *mci, int index)
>  	if (index < 0 || index >= mci->tot_dimms)
>  		return NULL;
>  
> +	if (WARN_ON_ONCE(mci->dimms[index]->idx != index))
> +		return NULL;
> +
>  	return mci->dimms[index];
>  }
>  




Cheers,
Mauro

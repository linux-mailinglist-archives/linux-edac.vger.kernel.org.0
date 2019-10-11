Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637FED3D00
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfJKKJ3 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:09:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:53692 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKKJ3 (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KuHjBqIDXIId+wIdCJdZjj5YZ7JkcltaGZLMyUnKd+E=; b=A8ZAI2viBEegAJKBqQXrK0ew8
        AhdU5CZUamaCpTCLjBivu5UsVp572qyjlTuk8g+LVenQV7y1tXf7PuLYamxhPCw9G/M7inS2/gXex
        YLccpmmDAgyUdFd42HGZsIUe+sgYeTJs04L8WjF8uSvNowxdTrlHBxqzBL58u6S3lX2f/eLp+Xuwo
        JyErvffq7PCI4Mk/0n0V1B1w19EG8/ROHsUJzIYf9qdCKsKHXoV8oRYaKjnRfxq6DPiq4jb32hz++
        cWRCBcWPPrHyX+PiGHQWXt0nv79UPpcSRQQ9rWsEKW2yQEMEN/0G4jEzOI0UAPdgMzLkC9jAfXolC
        yr0MFkXJA==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIrr9-0007qw-89; Fri, 11 Oct 2019 10:09:07 +0000
Date:   Fri, 11 Oct 2019 07:09:03 -0300
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/19] EDAC: Remove EDAC_DIMM_OFF() macro
Message-ID: <20191011070903.546d865f@coco.lan>
In-Reply-To: <20191010202418.25098-3-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-3-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:07 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> The EDAC_DIMM_OFF() macro takes 5 arguments to get the DIMM's index.
> This can be much simplified now as the offset is already stored in
> struct dimm_info. Use it directly and completely remove the
> EDAC_DIMM_OFF() macro.

Ah, now I understand why you added the dimm idx field. One more reason
why to split it on a separate patch (or perhaps merge it here).

> 
> Another advantage is that edac_mc_alloc() could be used even if the
> exact size of the layers is unknown. Only the number of DIMMs would be
> needed.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       | 15 +++++--------
>  drivers/edac/edac_mc_sysfs.c | 20 ++++--------------
>  include/linux/edac.h         | 41 ------------------------------------
>  3 files changed, 9 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 3d45adb5957f..72088d49b03b 100644
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
> @@ -425,20 +425,15 @@ struct mem_ctl_info *edac_mc_alloc(unsigned int mc_num,
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
> -		dimm->idx = off;
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
> index 7f9804438589..79c5564ee314 100644
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



Thanks,
Mauro

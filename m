Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D78D3D17
	for <lists+linux-edac@lfdr.de>; Fri, 11 Oct 2019 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfJKKOo (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 11 Oct 2019 06:14:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58136 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfJKKOo (ORCPT
        <rfc822;linux-edac@vger.kernel.org>); Fri, 11 Oct 2019 06:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sYW2G59BLUYOgygOgznvvM9/G1KSWe/B6yIvdP1T0lY=; b=GM5n0Q07pLWYbJN1VsLl1aB4h
        d/cEnZ2AWalUULXQp6auzuM1KsO0WBHhdG8gqeA2uJKvGPXdeFu2sMuK6TVfmCTBoJBhYYL2asVoX
        Fabky0xNUIMwfHEIwacDhyi5oO+dBfThHJo+ZteqkAfPEc+QHs/sSQ+l6klS2hseHqwqfgjh3JDpD
        yJCEaSOhwQg3gNG1TsKpgfVv+pxWkaoSpHNpSYA/7X06mD946Hy9BHfVOw9O2oT1fxqxz5MbnO1eB
        fqV+XmLrKT9Ooj9OWfwtNEfnT2Zw5NL8Iul2/olgrqXZ9J7/isN0tYFSlJfTm7wfAi0mxWrUIFrlw
        G+q3HEaFw==;
Received: from 177.17.141.107.dynamic.adsl.gvt.net.br ([177.17.141.107] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iIrwY-0001iw-5x; Fri, 11 Oct 2019 10:14:42 +0000
Date:   Fri, 11 Oct 2019 07:14:37 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/19] EDAC: Introduce mci_for_each_dimm() iterator
Message-ID: <20191011071437.4712eaa4@coco.lan>
In-Reply-To: <20191010202418.25098-4-rrichter@marvell.com>
References: <20191010202418.25098-1-rrichter@marvell.com>
        <20191010202418.25098-4-rrichter@marvell.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

Em Thu, 10 Oct 2019 20:25:10 +0000
Robert Richter <rrichter@marvell.com> escreveu:

> Introduce the mci_for_each_dimm() iterator. It returns a pointer to a
> struct dimm_info. This makes the declaration and use of an index
> obsolete and avoids access to internal data of struct mci (direct
> array access etc).
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  drivers/edac/edac_mc.c       | 19 +++++++++++--------
>  drivers/edac/edac_mc_sysfs.c | 29 ++++++++++++-----------------
>  drivers/edac/ghes_edac.c     |  8 ++++----
>  drivers/edac/i5100_edac.c    | 13 +++++--------
>  include/linux/edac.h         |  7 +++++++
>  5 files changed, 39 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index 72088d49b03b..c5240bb4c6c0 100644
> --- a/drivers/edac/edac_mc.c
> +++ b/drivers/edac/edac_mc.c
> @@ -145,15 +145,18 @@ static void edac_mc_dump_channel(struct rank_info *chan)
>  	edac_dbg(4, "    channel->dimm = %p\n", chan->dimm);
>  }
>  
> -static void edac_mc_dump_dimm(struct dimm_info *dimm, int number)
> +static void edac_mc_dump_dimm(struct dimm_info *dimm)
>  {
>  	char location[80];
>  
> +	if (!dimm->nr_pages)
> +		return;
> +
>  	edac_dimm_info_location(dimm, location, sizeof(location));
>  
>  	edac_dbg(4, "%s%i: %smapped as virtual row %d, chan %d\n",
>  		 dimm->mci->csbased ? "rank" : "dimm",
> -		 number, location, dimm->csrow, dimm->cschannel);
> +		 dimm->idx, location, dimm->csrow, dimm->cschannel);
>  	edac_dbg(4, "  dimm = %p\n", dimm);
>  	edac_dbg(4, "  dimm->label = '%s'\n", dimm->label);
>  	edac_dbg(4, "  dimm->nr_pages = 0x%x\n", dimm->nr_pages);
> @@ -702,6 +705,7 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
>  int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  			       const struct attribute_group **groups)
>  {
> +	struct dimm_info *dimm;
>  	int ret = -EINVAL;
>  	edac_dbg(0, "\n");
>  
> @@ -726,9 +730,9 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  				if (csrow->channels[j]->dimm->nr_pages)
>  					edac_mc_dump_channel(csrow->channels[j]);
>  		}
> -		for (i = 0; i < mci->tot_dimms; i++)
> -			if (mci->dimms[i]->nr_pages)
> -				edac_mc_dump_dimm(mci->dimms[i], i);
> +
> +		mci_for_each_dimm(mci, dimm)
> +			edac_mc_dump_dimm(dimm);
>  	}
>  #endif
>  	mutex_lock(&mem_ctls_mutex);
> @@ -1086,6 +1090,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  			  const char *msg,
>  			  const char *other_detail)
>  {
> +	struct dimm_info *dimm;
>  	char *p;
>  	int row = -1, chan = -1;
>  	int pos[EDAC_MAX_LAYERS] = { top_layer, mid_layer, low_layer };
> @@ -1146,9 +1151,7 @@ void edac_mc_handle_error(const enum hw_event_mc_err_type type,
>  	p = e->label;
>  	*p = '\0';
>  
> -	for (i = 0; i < mci->tot_dimms; i++) {
> -		struct dimm_info *dimm = mci->dimms[i];
> -
> +	mci_for_each_dimm(mci, dimm) {
>  		if (top_layer >= 0 && top_layer != dimm->location[0])
>  			continue;
>  		if (mid_layer >= 0 && mid_layer != dimm->location[1])
> diff --git a/drivers/edac/edac_mc_sysfs.c b/drivers/edac/edac_mc_sysfs.c
> index 91e4c8f155af..0367554e7437 100644
> --- a/drivers/edac/edac_mc_sysfs.c
> +++ b/drivers/edac/edac_mc_sysfs.c
> @@ -621,8 +621,7 @@ static const struct device_type dimm_attr_type = {
>  
>  /* Create a DIMM object under specifed memory controller device */
>  static int edac_create_dimm_object(struct mem_ctl_info *mci,
> -				   struct dimm_info *dimm,
> -				   int index)
> +				   struct dimm_info *dimm)
>  {
>  	int err;
>  	dimm->mci = mci;
> @@ -632,9 +631,9 @@ static int edac_create_dimm_object(struct mem_ctl_info *mci,
>  
>  	dimm->dev.parent = &mci->dev;
>  	if (mci->csbased)
> -		dev_set_name(&dimm->dev, "rank%d", index);
> +		dev_set_name(&dimm->dev, "rank%d", dimm->idx);
>  	else
> -		dev_set_name(&dimm->dev, "dimm%d", index);
> +		dev_set_name(&dimm->dev, "dimm%d", dimm->idx);
>  	dev_set_drvdata(&dimm->dev, dimm);
>  	pm_runtime_forbid(&mci->dev);
>  
> @@ -916,7 +915,8 @@ static const struct device_type mci_attr_type = {
>  int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  				 const struct attribute_group **groups)
>  {
> -	int i, err;
> +	struct dimm_info *dimm;
> +	int err;
>  
>  	/* get the /sys/devices/system/edac subsys reference */
>  	mci->dev.type = &mci_attr_type;
> @@ -940,13 +940,12 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	/*
>  	 * Create the dimm/rank devices
>  	 */
> -	for (i = 0; i < mci->tot_dimms; i++) {
> -		struct dimm_info *dimm = mci->dimms[i];
> +	mci_for_each_dimm(mci, dimm) {
>  		/* Only expose populated DIMMs */
>  		if (!dimm->nr_pages)
>  			continue;
>  
> -		err = edac_create_dimm_object(mci, dimm, i);
> +		err = edac_create_dimm_object(mci, dimm);
>  		if (err)
>  			goto fail_unregister_dimm;
>  	}
> @@ -961,12 +960,9 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  	return 0;
>  
>  fail_unregister_dimm:
> -	for (i--; i >= 0; i--) {
> -		struct dimm_info *dimm = mci->dimms[i];
> -		if (!dimm->nr_pages)
> -			continue;
> -
> -		device_unregister(&dimm->dev);
> +	mci_for_each_dimm(mci, dimm) {
> +		if (device_is_registered(&dimm->dev))
> +			device_unregister(&dimm->dev);
>  	}
>  	device_unregister(&mci->dev);
>  
> @@ -978,7 +974,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>   */
>  void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  {
> -	int i;
> +	struct dimm_info *dimm;
>  
>  	edac_dbg(0, "\n");
>  
> @@ -989,8 +985,7 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  	edac_delete_csrow_objects(mci);
>  #endif
>  
> -	for (i = 0; i < mci->tot_dimms; i++) {
> -		struct dimm_info *dimm = mci->dimms[i];
> +	mci_for_each_dimm(mci, dimm) {
>  		if (dimm->nr_pages == 0)
>  			continue;
>  		edac_dbg(1, "unregistering device %s\n", dev_name(&dimm->dev));
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index fb31e80dfe94..842080d7b33a 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -82,11 +82,11 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
>  static int get_dimm_smbios_index(u16 handle)
>  {
>  	struct mem_ctl_info *mci = ghes_pvt->mci;
> -	int i;
> +	struct dimm_info *dimm;
>  
> -	for (i = 0; i < mci->tot_dimms; i++) {
> -		if (mci->dimms[i]->smbios_handle == handle)
> -			return i;
> +	mci_for_each_dimm(mci, dimm) {
> +		if (dimm->smbios_handle == handle)
> +			return dimm->idx;
>  	}
>  	return -1;
>  }
> diff --git a/drivers/edac/i5100_edac.c b/drivers/edac/i5100_edac.c
> index 134586753311..0ddc41e47a96 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -846,20 +846,17 @@ static void i5100_init_interleaving(struct pci_dev *pdev,
>  
>  static void i5100_init_csrows(struct mem_ctl_info *mci)
>  {
> -	int i;
>  	struct i5100_priv *priv = mci->pvt_info;
> +	struct dimm_info *dimm;
>  
> -	for (i = 0; i < mci->tot_dimms; i++) {
> -		struct dimm_info *dimm;
> -		const unsigned long npages = i5100_npages(mci, i);
> -		const unsigned int chan = i5100_csrow_to_chan(mci, i);
> -		const unsigned int rank = i5100_csrow_to_rank(mci, i);
> +	mci_for_each_dimm(mci, dimm) {
> +		const unsigned long npages = i5100_npages(mci, dimm->idx);
> +		const unsigned int chan = i5100_csrow_to_chan(mci, dimm->idx);
> +		const unsigned int rank = i5100_csrow_to_rank(mci, dimm->idx);
>  
>  		if (!npages)
>  			continue;
>  
> -		dimm = edac_get_dimm(mci, chan, rank, 0);
> -
>  		dimm->nr_pages = npages;
>  		dimm->grain = 32;
>  		dimm->dtype = (priv->mtr[chan][rank].width == 4) ?
> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 79c5564ee314..8beb6e834be9 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -599,6 +599,13 @@ struct mem_ctl_info {
>  	u16 fake_inject_count;
>  };
>  
> +#define mci_for_each_dimm(mci, dimm)				\
> +	for ((dimm) = (mci)->dimms[0];				\
> +	     (dimm);						\
> +	     (dimm) = (dimm)->idx + 1 < (mci)->tot_dimms	\
> +		     ? (mci)->dimms[(dimm)->idx + 1]		\
> +		     : NULL)
> +
>  /**
>   * edac_get_dimm_by_index - Get DIMM info from a memory controller
>   *                          given by an index



Thanks,
Mauro

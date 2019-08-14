Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4C8D710
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2019 17:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbfHNPRk (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Wed, 14 Aug 2019 11:17:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:37194 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfHNPRk (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Wed, 14 Aug 2019 11:17:40 -0400
Received: from zn.tnic (p200300EC2F0BD0000538F16F91702398.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:d000:538:f16f:9170:2398])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 073551EC0965;
        Wed, 14 Aug 2019 17:17:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565795859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=53NlseYGebs+2OSufJuR61D20hSXhseLKb9HPRoVlMI=;
        b=e6HiDfqHdiMF5/9+dJhf1LjzFb6KXIVoYSvY5GjAi/XQOQ96rQ57ZQBWIXEZYgvMNGs6Xp
        3WoirBM1R3J8tC+r6QShsr5uMtdJ6DHAXaBQHglAemdJD0UqiTa7uRr2ZXSmkneANxZRB9
        G8eZLpJZSelyE3jT3QnLlpTGZDJL+X8=
Date:   Wed, 14 Aug 2019 17:18:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 08/24] EDAC: Introduce mci_for_each_dimm() iterator
Message-ID: <20190814151824.GB1841@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-9-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-9-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Mon, Jun 24, 2019 at 03:09:11PM +0000, Robert Richter wrote:
> Make code more readable by introducing a mci_for_each_dimm() iterator.
> Now, we just get a pointer to a struct dimm_info. Direct array access
> using an index is no longer needed to iterate.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/edac_mc.c       | 18 ++++++++++--------
>  drivers/edac/edac_mc_sysfs.c | 34 +++++++++++++++-------------------
>  drivers/edac/ghes_edac.c     |  8 ++++----
>  drivers/edac/i5100_edac.c    | 11 +++++------
>  include/linux/edac.h         |  7 +++++++
>  5 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/edac/edac_mc.c b/drivers/edac/edac_mc.c
> index c44bc83e8502..27277ca46ab3 100644
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

What's that for?

>  	edac_dimm_info_location(dimm, location, sizeof(location));
>  
>  	edac_dbg(4, "%s%i: %smapped as virtual row %d, chan %d\n",
>  		 dimm->mci->csbased ? "rank" : "dimm",
> -		 number, location, dimm->csrow, dimm->cschannel);
> +		 dimm->idx, location, dimm->csrow, dimm->cschannel);
>  	edac_dbg(4, "  dimm = %p\n", dimm);
>  	edac_dbg(4, "  dimm->label = '%s'\n", dimm->label);
>  	edac_dbg(4, "  dimm->nr_pages = 0x%x\n", dimm->nr_pages);
> @@ -703,6 +706,7 @@ EXPORT_SYMBOL_GPL(edac_get_owner);
>  int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  			       const struct attribute_group **groups)
>  {
> +	struct dimm_info *dimm;
>  	int ret = -EINVAL;
>  	edac_dbg(0, "\n");
>  
> @@ -727,9 +731,8 @@ int edac_mc_add_mc_with_groups(struct mem_ctl_info *mci,
>  				if (csrow->channels[j]->dimm->nr_pages)
>  					edac_mc_dump_channel(csrow->channels[j]);
>  		}
> -		for (i = 0; i < mci->tot_dimms; i++)
> -			if (mci->dimms[i]->nr_pages)
> -				edac_mc_dump_dimm(mci->dimms[i], i);

<---- newline here.

> +		mci_for_each_dimm(mci, dimm)
> +			edac_mc_dump_dimm(dimm);
>  	}
>  #endif
>  	mutex_lock(&mem_ctls_mutex);

...

> @@ -950,9 +949,10 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>  			printk(KERN_CONT "\n");
>  		}
>  #endif
> -		err = edac_create_dimm_object(mci, dimm, i);
> +		err = edac_create_dimm_object(mci, dimm);
>  		if (err) {
> -			edac_dbg(1, "failure: create dimm %d obj\n", i);
> +			edac_dbg(1, "failure: create dimm %d obj\n",
> +				dimm->idx);
>  			goto fail_unregister_dimm;
>  		}
>  	}

Since you're touching this, pls do

s/dimm/DIMM/g

in the user-visible strings because it is an abbreviation.

> @@ -967,12 +967,9 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
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
> @@ -984,7 +981,7 @@ int edac_create_sysfs_mci_device(struct mem_ctl_info *mci,
>   */
>  void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  {
> -	int i;
> +	struct dimm_info *dimm;
>  
>  	edac_dbg(0, "\n");
>  
> @@ -995,8 +992,7 @@ void edac_remove_sysfs_mci_device(struct mem_ctl_info *mci)
>  	edac_delete_csrow_objects(mci);
>  #endif
>  
> -	for (i = 0; i < mci->tot_dimms; i++) {
> -		struct dimm_info *dimm = mci->dimms[i];
> +	mci_for_each_dimm(mci, dimm) {
>  		if (dimm->nr_pages == 0)
>  			continue;
>  		edac_dbg(0, "removing device %s\n", dev_name(&dimm->dev));
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 8050f9577fe6..72e75ea5526c 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -81,11 +81,11 @@ static void ghes_edac_count_dimms(const struct dmi_header *dh, void *arg)
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
> index 39ba7f2414ae..7ec42b26a716 100644
> --- a/drivers/edac/i5100_edac.c
> +++ b/drivers/edac/i5100_edac.c
> @@ -846,14 +846,13 @@ static void i5100_init_interleaving(struct pci_dev *pdev,
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
> -		const unsigned chan = i5100_csrow_to_chan(mci, i);
> -		const unsigned rank = i5100_csrow_to_rank(mci, i);
> +	mci_for_each_dimm(mci, dimm) {
> +		const unsigned long npages = i5100_npages(mci, dimm->idx);
> +		const unsigned chan = i5100_csrow_to_chan(mci, dimm->idx);
> +		const unsigned rank = i5100_csrow_to_rank(mci, dimm->idx);
>  
>  		if (!npages)
>  			continue;

This cannot be right: the code here under this does now:

	dimm = edac_get_dimm(mci, chan, rank, 0);

but dimm is already set. It used to get the DIMM using chan and rank but
now you're iterating over the already initialized pointers. So I think
you don't need the edac_get_dimm() anymore.

Also fix those up too, while at it pls:

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#235: FILE: drivers/edac/i5100_edac.c:854:
+               const unsigned chan = i5100_csrow_to_chan(mci, dimm->idx);

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#236: FILE: drivers/edac/i5100_edac.c:855:
+               const unsigned rank = i5100_csrow_to_rank(mci, dimm->idx);


> diff --git a/include/linux/edac.h b/include/linux/edac.h
> index 2ee9b8598ae0..20a04f48616c 100644
> --- a/include/linux/edac.h
> +++ b/include/linux/edac.h
> @@ -599,6 +599,13 @@ struct mem_ctl_info {
>  	u16 fake_inject_count;
>  };
>  
> +#define mci_for_each_dimm(mci, dimm)			\
> +	for ((dimm) = (mci)->dimms[0];			\
> +	     (dimm);					\
> +	     (dimm) = (dimm)->idx < (mci)->tot_dimms	\
> +		     ? (mci)->dimms[(dimm)->idx + 1]	\
> +		     : NULL)
> +
>  /**
>   * edac_get_dimm_by_index - Get DIMM info from a memory controller
>   *                          given by an index
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

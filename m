Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 218D48BC46
	for <lists+linux-edac@lfdr.de>; Tue, 13 Aug 2019 16:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbfHMO7D (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Tue, 13 Aug 2019 10:59:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54658 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729586AbfHMO7D (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Tue, 13 Aug 2019 10:59:03 -0400
Received: from zn.tnic (p200300EC2F0D2400E0D08C31C935E2D1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:2400:e0d0:8c31:c935:e2d1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98D691EC0554;
        Tue, 13 Aug 2019 16:59:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565708341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UJvUPa8TlyHMjA7KAjQ12fSS5RfewWjyVvXnmvubFlw=;
        b=MHc2fVjg/PJ1Q7bAVSzAvk9yRXJLRfvZO/eBs0lWZHVl7w1fsulVCudq3dV2EaQB7PmjYp
        fqOqjYGwkU6jm2HUWALOPoL622W1L9jswE5nYyeJwSg27EhPu2hPP6suzXN5ufAwmt1HoR
        wk82+GEXDp2TVVCc6CJ5geBQ+ihkqMI=
Date:   Tue, 13 Aug 2019 16:59:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Jason Baron <jbaron@akamai.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Tero Kristo <t-kristo@ti.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/24] EDAC: Kill EDAC_DIMM_PTR() macro
Message-ID: <20190813145947.GE16770@zn.tnic>
References: <20190624150758.6695-1-rrichter@marvell.com>
 <20190624150758.6695-7-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190624150758.6695-7-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org


> Subject: Re: [PATCH v2 06/24] EDAC: Kill EDAC_DIMM_PTR() macro

s/Kill/Replace ... with/

On Mon, Jun 24, 2019 at 03:09:06PM +0000, Robert Richter wrote:
> Get rid of this macro and instead use the new function
> edac_get_dimm(). Also introduce the edac_get_dimm_by_index() function
> for later use.

Some blurb about *why* you're doing this won't hurt here.

> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index bd3be25d0d3f..8050f9577fe6 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -97,9 +97,8 @@ static void ghes_edac_dmidecode(const struct dmi_header *dh, void *arg)
>  
>  	if (dh->type == DMI_ENTRY_MEM_DEVICE) {
>  		struct memdev_dmi_entry *entry = (struct memdev_dmi_entry *)dh;
> -		struct dimm_info *dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms,
> -						       mci->n_layers,
> -						       dimm_fill->count, 0, 0);
> +		struct dimm_info *dimm = edac_get_dimm(mci, dimm_fill->count,
> +						       0, 0);

You can let it stick out.

>  		u16 rdr_mask = BIT(7) | BIT(13);
>  
>  		if (entry->size == 0xffff) {

...

> diff --git a/drivers/edac/i5400_edac.c b/drivers/edac/i5400_edac.c
> index 6f8bcdb9256a..a50a8707337b 100644
> --- a/drivers/edac/i5400_edac.c
> +++ b/drivers/edac/i5400_edac.c
> @@ -1196,8 +1196,8 @@ static int i5400_init_dimms(struct mem_ctl_info *mci)
>  			if (!MTR_DIMMS_PRESENT(mtr))
>  				continue;
>  
> -			dimm = EDAC_DIMM_PTR(mci->layers, mci->dimms, mci->n_layers,
> -				       channel / 2, channel % 2, slot);
> +			dimm = edac_get_dimm(mci, channel / 2, channel % 2,
> +					     slot);

Also, let it stick out.

> @@ -669,4 +639,56 @@ struct mem_ctl_info {
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
> + * Returns a struct dimm_info*.

or NULL on failure.

> + */
> +static inline struct dimm_info *
> +edac_get_dimm_by_index(struct mem_ctl_info *mci, int index)
> +{
> +	if (index < 0 || index >= mci->tot_dimms)
> +		return NULL;
> +
> +	if (WARN_ON_ONCE(mci->dimms[index]->idx != index))
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
> + * For 1 layer, this macro returns "dimms[layer0]";

macro? Copy-paste I guess :)

Below too.

> + *
> + * For 2 layers, this macro is similar to allocate a bi-dimensional array
> + * and to return "dimms[layer0][layer1]";
> + *
> + * For 3 layers, this macro is similar to allocate a tri-dimensional array
> + * and to return "dimms[layer0][layer1][layer2]";
> + */
> +static inline struct dimm_info *
> +edac_get_dimm(struct mem_ctl_info *mci, int layer0, int layer1, int layer2)
> +{
> +	int index = layer0;
> +
> +	if (index >= 0 && mci->n_layers > 1)

Can layer0 be negative here to warrant that check?

> +		index = index * mci->layers[1].size + layer1;
> +	if (index >= 0 && mci->n_layers > 2)

Same here.

> +		index = index * mci->layers[2].size + layer2;
> +
> +	return edac_get_dimm_by_index(mci, index);
> +}
> +
>  #endif
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

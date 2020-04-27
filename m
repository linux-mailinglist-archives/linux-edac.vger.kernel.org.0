Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5AA1BAA2D
	for <lists+linux-edac@lfdr.de>; Mon, 27 Apr 2020 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbgD0QjF (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 27 Apr 2020 12:39:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59884 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgD0QjF (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 27 Apr 2020 12:39:05 -0400
Received: from zn.tnic (p200300EC2F05F000C0A7B2478B940873.dip0.t-ipconnect.de [IPv6:2003:ec:2f05:f000:c0a7:b247:8b94:873])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D1661EC0D28;
        Mon, 27 Apr 2020 18:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588005543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zrDEZKXqMddKHBeVW4B30r2AAyajrzYPXMCdoxhRD6s=;
        b=CfgpuXtdJKkIhXvCsOHwNYSxGvglB//MVGa6IJXxl1O7/aNWh36sMtCYwyflyURzJXfvk6
        iIDx6ja8ru8a6cvJoQ054606OKeVarUTn01wxXkDyzvDH5wNtNbmLSvlckBvC3AlpZ0XaS
        7rHTevc4E0IhivmLhWuG8xOQ9oIHNt4=
Date:   Mon, 27 Apr 2020 18:38:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>,
        Matthias Brugger <mbrugger@suse.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] EDAC/ghes: Carve out MC device handling into
 separate functions
Message-ID: <20200427163856.GG11036@zn.tnic>
References: <20200422115814.22205-1-rrichter@marvell.com>
 <20200422115814.22205-9-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422115814.22205-9-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Apr 22, 2020 at 01:58:12PM +0200, Robert Richter wrote:
> The functions are too long, carve out code that handles MC devices
> into the new functions ghes_mc_create(), ghes_mc_add_or_free() and
> ghes_mc_free(). Apart from better code readability the functions can
> be reused and the implementation of the error paths becomes easier.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 141 +++++++++++++++++++++++----------------
>  1 file changed, 83 insertions(+), 58 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 4eadc5b344c8..af0a769071f4 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -535,16 +535,88 @@ static struct acpi_platform_list plat_list[] = {
>  	{ } /* End */
>  };
>  
> -int ghes_edac_register(struct ghes *ghes, struct device *dev)
> +static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
> +					int num_dimm)

Align arguments on the opening brace. The other functions need that too.

>  {
> -	bool fake = false;
> -	int rc = 0, num_dimm = 0;
> +	struct edac_mc_layer layers[1];
>  	struct mem_ctl_info *mci;
>  	struct ghes_mci *pvt;
> -	struct edac_mc_layer layers[1];
> -	struct dimm_fill dimm_fill;
> +
> +	layers[0].type = EDAC_MC_LAYER_ALL_MEM;
> +	layers[0].size = num_dimm;
> +	layers[0].is_virt_csrow = true;
> +
> +	mci = edac_mc_alloc(mc_idx, ARRAY_SIZE(layers), layers, sizeof(*pvt));
> +	if (!mci)
> +		return NULL;
> +
> +	pvt		= mci->pvt_info;
> +	pvt->mci	= mci;
> +
> +	mci->pdev = dev;
> +	mci->mtype_cap = MEM_FLAG_EMPTY;
> +	mci->edac_ctl_cap = EDAC_FLAG_NONE;
> +	mci->edac_cap = EDAC_FLAG_NONE;
> +	mci->mod_name = "ghes_edac.c";
> +	mci->ctl_name = "ghes_edac";
> +	mci->dev_name = "ghes";
> +
> +	return mci;
> +}
> +
> +static int ghes_mc_add_or_free(struct mem_ctl_info *mci,
> +			struct list_head *dimm_list)

No, I think we talked about this already. This function should be
called:

	ghes_mc_add()

and should do one thing and one thing only in good old unix tradition:
add the MC.

> +{
>  	unsigned long flags;
> -	int idx = -1;
> +	int rc;
> +
> +	rc = edac_mc_add_mc(mci);
> +	if (rc < 0) {

> +		ghes_dimm_release(dimm_list);
> +		edac_mc_free(mci);
> +		return rc;

Those last three lines should be called by the *caller* of
ghes_mc_add(), when latter returns an error value.

> +	}
> +
> +	spin_lock_irqsave(&ghes_lock, flags);
> +	ghes_pvt = mci->pvt_info;
> +	list_splice_tail(dimm_list, &ghes_dimm_list);
> +	spin_unlock_irqrestore(&ghes_lock, flags);
> +
> +	return 0;
> +}
> +
> +static void ghes_mc_free(void)
> +{
> +	struct mem_ctl_info *mci;
> +	unsigned long flags;
> +	LIST_HEAD(dimm_list);
> +
> +	/*
> +	 * Wait for the irq handler being finished.
> +	 */
> +	spin_lock_irqsave(&ghes_lock, flags);
> +	mci = ghes_pvt ? ghes_pvt->mci : NULL;
> +	ghes_pvt = NULL;
> +	list_splice_init(&ghes_dimm_list, &dimm_list);
> +	spin_unlock_irqrestore(&ghes_lock, flags);
> +
> +	ghes_dimm_release(&dimm_list);
> +
> +	if (!mci)
> +		return;
> +
> +	mci = edac_mc_del_mc(mci->pdev);
> +	if (mci)
> +		edac_mc_free(mci);
> +}

This function needs to do only freeing of the mc. The list splicing and
dimm releasing needs to be done by its caller, before calling it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

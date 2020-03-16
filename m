Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8A51867EC
	for <lists+linux-edac@lfdr.de>; Mon, 16 Mar 2020 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730356AbgCPJb0 (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Mon, 16 Mar 2020 05:31:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34070 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730025AbgCPJbZ (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Mon, 16 Mar 2020 05:31:25 -0400
Received: from zn.tnic (p200300EC2F06AB0069F33882ABEAD541.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:ab00:69f3:3882:abea:d541])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 544771EC0CD0;
        Mon, 16 Mar 2020 10:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584351084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=e/ksiddUErz9dGVWE2UE8EQ9TOo//fHUKhGBIAL1Tuk=;
        b=Z3KhRTH7zoeWs62R9l7tErKfxlxS3sWy6e2hDrsDgxE0LhFp1a68YRUJEL8tVqWrG4AcPS
        xcgn7yOqdHyDH2ZMoojUmENGIZ623EQLdeWQzgmgu/Gz5Iw5PjHr3F5/mM6BtPDf4z1X5N
        MxeXJL9kOSOwawxGVW/XiH4ZiniC4BY=
Date:   Mon, 16 Mar 2020 10:31:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rrichter@marvell.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Aristeu Rozanski <aris@redhat.com>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] EDAC/ghes: Carve out MC device handling into
 separate functions
Message-ID: <20200316093134.GB26126@zn.tnic>
References: <20200306151318.17422-1-rrichter@marvell.com>
 <20200306151318.17422-7-rrichter@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306151318.17422-7-rrichter@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-edac-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Fri, Mar 06, 2020 at 04:13:13PM +0100, Robert Richter wrote:
> The functions are too long, carve out code that handles MC devices
> into the new functions ghes_mc_create(), ghes_mc_add_or_free() and
> ghes_mc_free(). Apart from better code readability the functions can
> be reused and the implementation of the error paths becomes easier.
> 
> Signed-off-by: Robert Richter <rrichter@marvell.com>
> ---
>  drivers/edac/ghes_edac.c | 133 +++++++++++++++++++++++----------------
>  1 file changed, 79 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/edac/ghes_edac.c b/drivers/edac/ghes_edac.c
> index 358519e8c2e9..5a4c9694bbff 100644
> --- a/drivers/edac/ghes_edac.c
> +++ b/drivers/edac/ghes_edac.c
> @@ -462,16 +462,81 @@ static struct acpi_platform_list plat_list[] = {
>  	{ } /* End */
>  };
>  
> -int ghes_edac_register(struct ghes *ghes, struct device *dev)
> +static struct mem_ctl_info *ghes_mc_create(struct device *dev, int mc_idx,
> +					int num_dimm)
>  {
> -	bool fake = false;
> -	int rc = 0, num_dimm = 0;
> +	struct edac_mc_layer layers[1];
>  	struct mem_ctl_info *mci;
>  	struct ghes_mci *pvt;
> -	struct edac_mc_layer layers[1];
> -	struct ghes_dimm_fill dimm_fill;
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
> +static int ghes_mc_add_or_free(struct mem_ctl_info *mci)

ghes_mc_add() is good enough. The fact that the function has error
handling doesn't need to be in the name.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

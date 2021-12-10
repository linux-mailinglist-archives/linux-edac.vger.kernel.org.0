Return-Path: <linux-edac-owner@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1464C4700DA
	for <lists+linux-edac@lfdr.de>; Fri, 10 Dec 2021 13:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhLJMpA (ORCPT <rfc822;lists+linux-edac@lfdr.de>);
        Fri, 10 Dec 2021 07:45:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:55274 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235838AbhLJMpA (ORCPT <rfc822;linux-edac@vger.kernel.org>);
        Fri, 10 Dec 2021 07:45:00 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 307351EC054F;
        Fri, 10 Dec 2021 13:41:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639140080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ay4t+Rta+j2Pv6WskGypmlIpnaxwRU3/Qx68CnUF9ek=;
        b=QqWIeVFT+KqogRru2TCdIdINaoSzHXqcmspWvlZG1lJOYD/JQLBakqJ4YISr8zjmLMvaTd
        /gnsF/ADfEkEGpRAjaixcmVPe3hQLD3g0V2UGj1C4nf0gi8I8RKnVVSpwXZwaoLYRVC/2C
        D72xRMVxN+I0T3x3ATDKGeOWK6ZJH6k=
Date:   Fri, 10 Dec 2021 13:41:26 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, tony.luck@intel.com, james.morse@arm.com,
        rric@kernel.org, Smita.KoralahalliChannabasappa@amd.com,
        william.roche@oracle.com
Subject: Re: [PATCH 4/4] EDAC/amd64: Add DDR5 support and related register
 changes
Message-ID: <YbNK9jV06al93XDN@zn.tnic>
References: <20211208174356.1997855-1-yazen.ghannam@amd.com>
 <20211208174356.1997855-5-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211208174356.1997855-5-yazen.ghannam@amd.com>
Precedence: bulk
List-ID: <linux-edac.vger.kernel.org>
X-Mailing-List: linux-edac@vger.kernel.org

On Wed, Dec 08, 2021 at 05:43:56PM +0000, Yazen Ghannam wrote:
> Future AMD systems will support DDR5.
> 
> Add support for changes in register addresses for these systems.
> 
> Introduce a "family flags" bitmask that can be used to indicate any
> special behavior needed on a per-family basis.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 61 +++++++++++++++++++++++++++++++++++----
>  drivers/edac/amd64_edac.h | 11 +++++++
>  2 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 1df763128483..e37a8e0cef7e 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -15,6 +15,36 @@ static struct msr __percpu *msrs;
>  
>  static struct amd64_family_type *fam_type;
>  
> +/* Family flag helpers */
> +static inline bool has_ddr5(void)
> +{
> +	return fam_type->flags.has_ddr5;

A flag about ddr5 *and* a function of the same name. Kinda too much,
don't ya think?

> @@ -1628,6 +1660,17 @@ static void determine_memory_type(struct amd64_pvt *pvt)
>  			dimm_cfg |= pvt->umc[i].dimm_cfg;
>  		}
>  
> +		/* Check if system supports DDR5 and has DDR5 DIMMs in use. */
> +		if (has_ddr5() && (umc_cfg & BIT(0))) {
> +			if (dimm_cfg & BIT(5))
> +				pvt->dram_type = MEM_LRDDR5;
> +			else if (dimm_cfg & BIT(4))
> +				pvt->dram_type = MEM_RDDR5;
> +			else
> +				pvt->dram_type = MEM_DDR5;
> +			return;
> +		}
> +
>  		if (dimm_cfg & BIT(5))
>  			pvt->dram_type = MEM_LRDDR4;
>  		else if (dimm_cfg & BIT(4))
> @@ -2174,8 +2217,13 @@ static int f17_addr_mask_to_cs_size(struct amd64_pvt *pvt, u8 umc,
>  	 * There is one mask per DIMM, and two Chip Selects per DIMM.
>  	 *	CS0 and CS1 -> DIMM0
>  	 *	CS2 and CS3 -> DIMM1
> +	 *
> +	 *	Systems with DDR5 support have one mask per Chip Select.
>  	 */
> -	dimm = csrow_nr >> 1;
> +	if (has_ddr5())
> +		dimm = csrow_nr;
> +	else
> +		dimm = csrow_nr >> 1;
>  
>  	/* Asymmetric dual-rank DIMM support. */
>  	if ((csrow_nr & 1) && (cs_mode & CS_ODD_SECONDARY))
> @@ -2937,6 +2985,7 @@ static struct amd64_family_type family_types[] = {
>  		.f0_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F0,
>  		.f6_id = PCI_DEVICE_ID_AMD_19H_M10H_DF_F6,
>  		.max_mcs = 12,
> +		.flags.has_ddr5 = 1,

So judging by the name, this means that model 0x10 has DDR5. But I think
you wanna say whether it supports DDR5 or not?

Or does M10 support DDR5 only?

But it doesn't look like it from the comment above:

	"Check if system supports DDR5 and has DDR5 DIMMs in use."

So why is this thing set statically only for this model instead of
detecting from the hw whether there are ddr5 or ddr5 DIMMs and what it
supports?

And then you can use the defines you just added in patch 1.

I'm confused.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

Return-Path: <linux-edac+bounces-260-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3DE8147A8
	for <lists+linux-edac@lfdr.de>; Fri, 15 Dec 2023 13:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572882822E2
	for <lists+linux-edac@lfdr.de>; Fri, 15 Dec 2023 12:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4278B288D5;
	Fri, 15 Dec 2023 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eiz9uhH5"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E459116429
	for <linux-edac@vger.kernel.org>; Fri, 15 Dec 2023 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3A36440E0140;
	Fri, 15 Dec 2023 12:06:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NRiM8LbWefOX; Fri, 15 Dec 2023 12:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1702641999; bh=EWHb36Z4uBKdZ3Q+uF5j8S+DD9GHzuQZWd3aYlP0loA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eiz9uhH5+CjuAKR55EANR7o3FD2VTzE5aEXQqw1vOHAsGonrfqidZGjhPC0IbU0LB
	 KMNEjmMuqFA8oIRCuBOk7X3vctDj0BN6FE2+DwvIJfvwDsSuTo04TWcxqEOC/rCb1s
	 vssTCe6AAzGd+OLUR/SRihGciwhQWUDWAiqKXjCGWoeQ5YGvPAN/3OWQ6DAf7HvGEF
	 XCoI+ytC5jBG3hpTB7xHOaZQIOp3H/w+GnvjVo5AfThA9Joe3fcxOJMFco98hRoJbg
	 esUXpH/vnJkFZ/jZN6FEjyD5J9btKhts5tf9mywgGqjUueXS/jE+kUQWtVlA7T5FjN
	 hLsG2mehAPXT0vKTZGVWHnevXeptDkQ4avO2WfArZyBEMrI/s+HqW1GSsUDNK0F4cm
	 u5kznWVux4+OyfXj3cgKk7lMKsECFuE3/cuA1tAIc4KiPs1zVHe0R05GCTIGM1+ana
	 wTfc5abNqHrzDdjrqjVsBhXLXUP1Ss2Z5c6qho51DTX9D6wruEwrx8ZoC+s1+0Wobn
	 O5sMvvZH4vKTFE+AcY9vJ46+kIhy4txtIFDwPbY0HcnFidq1Q9IQLPw0Dbx7nghpl0
	 qOdkIlpFBgqmdvQt/F8f5bXVq1eP9wDVXtk4X6q0KORkaaWIPyWI+EzXVo4fAsna/E
	 xVFkhE2BPeNwCIYVzRoBkRmg=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 491BC40E00CD;
	Fri, 15 Dec 2023 12:06:32 +0000 (UTC)
Date: Fri, 15 Dec 2023 13:06:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, shubhrajyoti.datta@gmail.com
Subject: Re: [PATCH v3] EDAC/versal: Fix the read of the num_csrows and
 num_chans
Message-ID: <20231215120623.GAZXxBP8t3+XRXOwU/@fat_crate.local>
References: <20231215053352.8740-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231215053352.8740-1-shubhrajyoti.datta@amd.com>

On Fri, Dec 15, 2023 at 11:03:52AM +0530, Shubhrajyoti Datta wrote:
> Fix the extraction of the num_csrows and num_chans.
> The extraction of the num_rows is wrong. Instead of extracting
> using the FIELD_GET it is calling FIELD_PREP.
> 
> The issue was masked as the default design has the rows as 0.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Closes: https://lore.kernel.org/all/60ca157e-6eff-d12c-9dc0-8aeab125edda@linux-m68k.org/
> Fixes: 6f15b178cd63 ("EDAC/versal: Add a Xilinx Versal memory controller driver")
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> ---
> 
> Changes in v3:
> Update the commit message
> 
> Changes in v2:
> Update the commit message
> 
>  drivers/edac/versal_edac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/edac/versal_edac.c b/drivers/edac/versal_edac.c
> index 87e20f39f999..f0d8702802a1 100644
> --- a/drivers/edac/versal_edac.c
> +++ b/drivers/edac/versal_edac.c
> @@ -1038,10 +1038,10 @@ static int mc_probe(struct platform_device *pdev)
>  	edac_mc_id = emif_get_id(pdev->dev.of_node);
>  
>  	regval = readl(ddrmc_baseaddr + XDDR_REG_CONFIG0_OFFSET);
> -	num_chans = FIELD_PREP(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
> +	num_chans = FIELD_GET(XDDR_REG_CONFIG0_NUM_CHANS_MASK, regval);
>  	num_chans++;
>  
> -	num_csrows = FIELD_PREP(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
> +	num_csrows = FIELD_GET(XDDR_REG_CONFIG0_NUM_RANKS_MASK, regval);
>  	num_csrows *= 2;
>  	if (!num_csrows)
>  		num_csrows = 1;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


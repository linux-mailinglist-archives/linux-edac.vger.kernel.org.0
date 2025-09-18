Return-Path: <linux-edac+bounces-4832-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF7EB849F3
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 14:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CC01C28574
	for <lists+linux-edac@lfdr.de>; Thu, 18 Sep 2025 12:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C84E3054F6;
	Thu, 18 Sep 2025 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QaiSHMUW"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835CD303CBE;
	Thu, 18 Sep 2025 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199257; cv=none; b=DTWKLJmai0CjYoThd+bft6TEstW37G+FQ8708H33hsBm72rEfeeIkbPbD+lUotYw/yrfTjQrnkeIZlhQ4lZFsvClV5GvQdDBUIJW/E+x1yu0AlBMo/BPlWFO0Z11ZhFJsG+uE3jsdv68fqxTfun6LICwtEp/d8SEofb5V1UcxR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199257; c=relaxed/simple;
	bh=R65TRM7Qpf4uO4bxhEDI0SdXyDRcLn7I8m3+/mg8EtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UcJAjs1O0lIoqhqzPjAarPRfWroBleDCjKccth8RteV2aC4/nqIui4InBwCqnP0uRFu6yFTD0Pmm3fOwOFM8ifmIFxGmTHvYHayIBtqD294iWZjBSL/M1KeObOZATfmPRmD3gGr1n8t9ADDw1mK9gtfv7owTNZRY+chxLzSQKss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QaiSHMUW; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DCE9E40E01D2;
	Thu, 18 Sep 2025 12:40:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YqDqIlJATrYw; Thu, 18 Sep 2025 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758199247; bh=wNQZdWsXPRH5e0mb1c+K9xiZ0IshDQBYs9BXE+Oukmg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QaiSHMUWZv5TksePDfobU9otexEnaSHYctWEs6F2zrDejnKexDRQCN/zxOBgLRZ5B
	 ASaBCXirJLoz++TN4GSnD1DjidjZ1cZhmCmrh/RULncyI4mb3MXD+Su2OZEerOa2a5
	 Hx4z6ChqLBFQDIuE24za9viifDor1E1LZSa+vdk9m/0+f05G93Lth318LTazoW+7/b
	 kCz1HS+wpLIHTaapsj0p9gxt89w9Hw/hvLI1cfhRT6m6QObtXRkQ9wurW9xf9ugbYZ
	 jI1Vrk3EaMvHGNbvJ6vdQGxiI+SMTq2leU3pCcDzj5LflDPkydQlFKSHy1/ghHoAiS
	 3NvBdR0Cq+VBYitGNNdBtIfmYQZRh9KsIsqn9AlsykWJKYbF7F0PPXLtRCRszREJRg
	 sU0i8ToT2Rgad+pzBO15m8v7FBM5Q+6fOMewRPMfyMV3VSjAaW+1TZRWYjO822St82
	 OPcFFwgYnPB4L7HKqlDrG8lKKI79NlWt0mSgBwOtSE65DTzzk3KzTOvemgZTorDvvi
	 0GwMUm7aVapA4SbT7GNQaXIe/pz5jtQ2ZxtjTBANh5Itc+H8D/g6FE3TIxzETbUKyf
	 jvuzpPeKwU9VXjzqjZ69jG6hFWQ72uBLYip1CxRz2eP1DgPnFQFre5B09TYCjN9f6B
	 JDOewOhjZ7CM+9HUhnM6J6SE=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 6145140E01BB;
	Thu, 18 Sep 2025 12:40:41 +0000 (UTC)
Date: Thu, 18 Sep 2025 14:40:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] EDAC/versalnet: Fix error code in probe()
Message-ID: <20250918124035.GDaMv9w16GzdFyZA3R@fat_crate.local>
References: <aMuta8vbLUaP_C-R@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aMuta8vbLUaP_C-R@stanley.mountain>

On Thu, Sep 18, 2025 at 09:57:47AM +0300, Dan Carpenter wrote:
> This code returns success if devm_kzalloc() fails.  Return -ENOMEM
> instead.
> 
> Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/edac/versalnet_edac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index 66714fffa591..7c5db8bf0595 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -888,8 +888,10 @@ static int mc_probe(struct platform_device *pdev)
>  	}
>  
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> +	if (!priv) {
> +		rc = -ENOMEM;
>  		goto err_alloc;
> +	}
>  
>  	amd_rpmsg_id_table[0].driver_data = (kernel_ulong_t)priv;
>  
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


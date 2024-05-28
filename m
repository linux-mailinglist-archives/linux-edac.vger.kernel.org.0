Return-Path: <linux-edac+bounces-1147-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D3D8D1E51
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D63FBB22384
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 14:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D6C16E861;
	Tue, 28 May 2024 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RW9bYQCG"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B4C6A8A3;
	Tue, 28 May 2024 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905879; cv=none; b=nhDcVEop5+UwN7O9gghDTuS//mrc9IYfZOMdYOjU/MIitnhYmjk0YwLBd4XMhPVLG3O6YPZex88pRTKCO3VB6Dph5/2AvIQyyq2ypEeEQjpWeRUIhhv36tMDomeasGCHnuAzXPU9pS6Q90n02isZFFGilt9dr4WqYWKxmrOMvZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905879; c=relaxed/simple;
	bh=Iox2EDln7HBj3b/gSLop1jVV31ag+ghsDlqUSLDSUtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dryUiqbApIV3x/SMWJLv/NBlNJVN7OQYPQ9dUlwQt9WWlAOCCr29+o6QbcTeCNCx9UpFXd+zmYhiHKURMdUU5JbzLk3+c+s1l/zFudWiIWDq16pf4hsI4ya6UHyM10GP7NmOxTMKXDsdSLxlEd2tcz0YmEYIskvEqDuXt9WwHDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RW9bYQCG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D1DDD40E0244;
	Tue, 28 May 2024 14:17:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id MZKy1R-kMzk1; Tue, 28 May 2024 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716905871; bh=DKjnDDIBN6O1ywAjUsxFEsKHA8yyvh3NmgpdAdDAjjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RW9bYQCGYqlYSFF24TVEzxOe6S3knLjI5zOxOYv9fhaY7aLUL1NlvbhsegL+ylPXU
	 pzSPWQJy1x9C28CInw8CXFkI6iGopPnED6qOhMKQbCjQHAqCW15ThWIP1abUhzFweY
	 ajOpcgddnR1mwQepWpDP/cS3vhoLuhW13nTs8auJO4txDX4mFnxHBXyeqv8IWCQTOU
	 cvRtjR3GA7WilMN6vrvbM9eB0u8UEqDZlXDt3zVVv6MkUc9h3Kh69ukfmNt4sv9pDi
	 orahRo5uZyGiL7fjhOKujXCjM/vlZJ2tcpMvssTnsJuCyhUxEEDOczvhmDDHwwae2/
	 5XB/xBpnp4Fblv8/DvwVuw/HPd12Zj9LETPFfjrFC00UYoL9sWm43VL8rKChN8IMNF
	 vzcFSw9ahr2quC4yycyAUOfIlA+LVt7f22usCfJADaAFkoXr3yv5ZvQNlsLiAvDKrU
	 73Uhrk36zF6ATi09iew0j0cv+JaTGsnjLC7KWbUyN/sOxBCOyjrYSo601Gt1ByOiYt
	 DZi/qcqedk/78BIZj2+JeqmUgsunz1C0v4+hUqmgKZoB3OL558yxB01GaAgIPZVbiV
	 HM2OSqxY25ELXsY1qRX2qFwS84UCTcBcZ7vfHp1oM0OsS0Vfra60ATC47DAotXsIax
	 Z3kNhBqfMBVRphPrWRUC/emA=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1620540E01E8;
	Tue, 28 May 2024 14:17:46 +0000 (UTC)
Date: Tue, 28 May 2024 16:17:40 +0200
From: Borislav Petkov <bp@alien8.de>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: Yazen.Ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS: Add missing newlines to pr_info
Message-ID: <20240528141740.GDZlXnhIzcMbsAHYVa@fat_crate.local>
References: <20240517215452.2020680-1-gomonovych@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240517215452.2020680-1-gomonovych@gmail.com>

On Fri, May 17, 2024 at 02:54:37PM -0700, Vasyl Gomonovych wrote:
> Fix RAS log statement by adding missing newline character
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
>  drivers/ras/amd/atl/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index 6dc4e06305f7..f9f760d780c4 100644
> --- a/drivers/ras/amd/atl/core.c
> +++ b/drivers/ras/amd/atl/core.c
> @@ -206,7 +206,7 @@ static int __init amd_atl_init(void)
>  	__module_get(THIS_MODULE);
>  	amd_atl_register_decoder(convert_umc_mca_addr_to_sys_addr);
>  
> -	pr_info("AMD Address Translation Library initialized");
> +	pr_info("AMD Address Translation Library initialized\n");
>  	return 0;
>  }
>  
> -- 

Both applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


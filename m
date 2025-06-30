Return-Path: <linux-edac+bounces-4281-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D60EAED3AE
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 07:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ACD3B144F
	for <lists+linux-edac@lfdr.de>; Mon, 30 Jun 2025 05:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D834719CC28;
	Mon, 30 Jun 2025 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrRVTqrQ"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AD2745C;
	Mon, 30 Jun 2025 05:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751260022; cv=none; b=SGZaK/2wu2x88hXPgWWncMEsxUipDnuBSzbmrZmh6auwajU8GIbrgkLduVSBTzUxefmn5+p+8+HQzhLqUN+77rEmVXqlocX7Y+PGI5T9VDSK/pzHQT0HlUKBctxVavkKfkU7/+EUONb6Trrl4X5iepP+CgOIbZ3fPQG9+R2KhOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751260022; c=relaxed/simple;
	bh=DGXltRkbg9KemiMxryS/esYXrIBegi2H8y9DdYmdKxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptekOgNFXF2BHta2xIhEF+C8HwrZ20ouBTOH1GClEVGCXxh2sgcalYO6UumEpjPwDxleqeC0NHVc/rprlkrV8mceCBLlLYLOYC1rYS2aCEiHWzpIydLCrDdmc8g2e/Tzh5M43G8svWa833LSBI/qu2eFPFjZYYbQcxrxOqwM1mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FrRVTqrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CB2C4CEE3;
	Mon, 30 Jun 2025 05:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751260022;
	bh=DGXltRkbg9KemiMxryS/esYXrIBegi2H8y9DdYmdKxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrRVTqrQDs14OZUErAk4/NbzR8SdbjA3VUZfVevYkwkPjWVUUPSWFobno2GsF/l/y
	 7U3hJQwRfoumdb9GYeCI9o1JK5NwEtshgjmBQsyXmbrSVpl3gvMahxniGrQxKhLHD6
	 BrCCSbuIKk3UfVryu+9KuPf0h6/prbfPxT3o+kEE=
Date: Mon, 30 Jun 2025 07:06:58 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marcelo Moreira <marcelomoreira1905@gmail.com>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	~lkcamp/patches@lists.sr.ht, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>, James Morse <james.morse@arm.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC/amd64: replace sprintf with sysfs_emit in show
 functions
Message-ID: <2025063001-marigold-renewed-6361@gregkh>
References: <20250629182448.265407-1-marcelomoreira1905@gmail.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250629182448.265407-1-marcelomoreira1905@gmail.com>

On Sun, Jun 29, 2025 at 03:24:48PM -0300, Marcelo Moreira wrote:
> Update all device attribute 'show' callbacks in the EDAC AMD64 driver to
> utilize sysfs_emit(). This change adheres to the recommendation outlined
> in Documentation/filesystems/sysfs.rst.
> 
> This modification aligns with current sysfs subsystem guidelines.
> 
> Signed-off-by: Marcelo Moreira <marcelomoreira1905@gmail.com>
> ---
>  drivers/edac/amd64_edac.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index b681c0663203..b6d211255ef0 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -552,7 +552,7 @@ static ssize_t reg##_show(struct device *dev,				\
>  	struct mem_ctl_info *mci = to_mci(dev);				\
>  	struct amd64_pvt *pvt = mci->pvt_info;				\
>  									\
> -	return sprintf(data, "0x%016llx\n", (u64)pvt->reg);		\
> +	return  sysfs_emit(data, "0x%016llx\n", (u64)pvt->reg);		\

Why the extra ' '?


>  }
>  
>  EDAC_DCT_ATTR_SHOW(dhar);
> @@ -571,7 +571,7 @@ static ssize_t dram_hole_show(struct device *dev, struct device_attribute *mattr
>  
>  	get_dram_hole_info(mci, &hole_base, &hole_offset, &hole_size);
>  
> -	return sprintf(data, "%llx %llx %llx\n", hole_base, hole_offset,
> +	return sysfs_emit(data, "%llx %llx %llx\n", hole_base, hole_offset,
>  						 hole_size);
>  }
>  
> @@ -602,7 +602,7 @@ static ssize_t inject_section_show(struct device *dev,
>  {
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct amd64_pvt *pvt = mci->pvt_info;
> -	return sprintf(buf, "0x%x\n", pvt->injection.section);
> +	return sysfs_emit(buf, "0x%x\n", pvt->injection.section);
>  }
>  
>  /*
> @@ -638,7 +638,7 @@ static ssize_t inject_word_show(struct device *dev,
>  {
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct amd64_pvt *pvt = mci->pvt_info;
> -	return sprintf(buf, "0x%x\n", pvt->injection.word);
> +	return sysfs_emit(buf, "0x%x\n", pvt->injection.word);
>  }
>  
>  /*
> @@ -675,7 +675,7 @@ static ssize_t inject_ecc_vector_show(struct device *dev,
>  {
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct amd64_pvt *pvt = mci->pvt_info;
> -	return sprintf(buf, "0x%x\n", pvt->injection.bit_map);
> +	return sysfs_emit(buf, "0x%x\n", pvt->injection.bit_map);

There's nothing wrong with these sprintf() lines, so no need to change
them, right?

I only recommend making this type of change when adding new sysfs files,
no need for churn on old files when it is not needed at all.

thanks,

greg k-h


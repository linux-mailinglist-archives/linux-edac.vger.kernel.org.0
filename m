Return-Path: <linux-edac+bounces-1564-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FF193B1A6
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 15:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D853281184
	for <lists+linux-edac@lfdr.de>; Wed, 24 Jul 2024 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DC2383A9;
	Wed, 24 Jul 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQoBhuq6"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D8B5C99;
	Wed, 24 Jul 2024 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721827886; cv=none; b=HN8ylyRmGUsEjbO3GT5MhaAr8bzDyp6emLXTBtnAy4ejGTmetSI1FTlIRQfkbqqLC0IEyQE8NV/tW0GM+zNpsd6HqQkW2g0N8AhUYF4zWd8lNsmduRHnTMHTa1xgyO+MAgxMUOULcZzKWyhZwBCYsz11va2BylkwWsuLlSpPnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721827886; c=relaxed/simple;
	bh=0HL4WVSHtRXn+vpGOcPrYw57HxjrdAloUVqOke83U7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJDmjTWSkL0RXQPgbhKWAljd5W0rIXuhZdufL02i2mzkxlLK1xrD/eKIpp1KlvI/NKbm0blad3NH62bPHPFzPApakrk4/VLoo6y3kAyEnxzIvE9MeEQpKjBO335U18iPXSOgx+UVLXLFep9qDWkxadH9rh84bfvXdCb9oc6MTb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQoBhuq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CEBC32782;
	Wed, 24 Jul 2024 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721827885;
	bh=0HL4WVSHtRXn+vpGOcPrYw57HxjrdAloUVqOke83U7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQoBhuq67hnF+ID50fkAl6Wax1FYuJNXFzM1ra6Ly7sthRTt4BE/+hN1jDlBJmc6N
	 EUBVkQ2dUZONs+WXgLp3PQcvRGdXuDa2vXVAFS7vm6Hr+MKmirn5aq9p9D8vxhczCU
	 6lUQNrdIhsrDkS++oOn/YkR0FM8ng7ud18xLuk8k=
Date: Wed, 24 Jul 2024 15:31:21 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: kristo@kernel.org, bp@alien8.de, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] EDAC/ti: Fix possible null pointer dereference
 in _emif_get_id()
Message-ID: <2024072407-census-mahogany-5831@gregkh>
References: <20240724071042.1493917-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724071042.1493917-1-make24@iscas.ac.cn>

On Wed, Jul 24, 2024 at 03:10:42PM +0800, Ma Ke wrote:
> In _emif_get_id(), of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - added Cc stable line.
> ---
>  drivers/edac/ti_edac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 29723c9592f7..db23887b2d81 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -207,6 +207,9 @@ static int _emif_get_id(struct device_node *node)
>  	int my_id = 0;
>  
>  	addrp = of_get_address(node, 0, NULL, NULL);
> +	if (!addrp)
> +		return -EINVAL;
> +

How was this found?

How was this tested?

thanks,

greg k-h


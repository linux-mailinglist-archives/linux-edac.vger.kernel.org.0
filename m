Return-Path: <linux-edac+bounces-1644-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCAC951497
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2024 08:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8DBB22C28
	for <lists+linux-edac@lfdr.de>; Wed, 14 Aug 2024 06:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D144D8BC;
	Wed, 14 Aug 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HQbC9k4R"
X-Original-To: linux-edac@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850611F94D;
	Wed, 14 Aug 2024 06:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723617170; cv=none; b=dujlOMVnHC26kx5uSH3bwQtxvS0fvXSZdEAnSHCQTdBalMlP/IMDYQnoPEY6UP2zNSE+te+WjZDDPPooAxin2u3seDcV8DQabFx+djpAqoiW7Znhof2YqauExLboFWdN1OYMwrZoOxF6ibFnc6trkbgWBRqlJjv+Ls+Y2K0fdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723617170; c=relaxed/simple;
	bh=m/8S8SGA3FdmSsBj7FumnNtqAYRVRnMckSzNeG4m0uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U50qVQgAhgTdlDtMDyhYqKuaD+Lq3g9aqFC9s88QkzDT/JpPcTK+BA7mdMkznO1PJsGRQVe5GwFOKuFKHxctvp3W9IQLq4fk6VkhLQyhw/7/rbjSB8V9X47K1HZdIGEEOXjOREi3sFcbm7v+Y8ddWyFY02diCOrCI2+e3nXHYDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HQbC9k4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E554C32786;
	Wed, 14 Aug 2024 06:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723617169;
	bh=m/8S8SGA3FdmSsBj7FumnNtqAYRVRnMckSzNeG4m0uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HQbC9k4RRobrZWoJXPxLnJVLlonH5Hujyhvy7p4k4XflKlE3KzoLXkIb4LCmroy0C
	 IbFM7fyabjAyJYxl/T7Xmjbizid9lF3a60uwpUwEPvCvFmYB9jyT6VbVWIUaDNY+gL
	 rIn2Evntw3J9azwzVdmU0+127oJp6nxvou1gtBp4=
Date: Wed, 14 Aug 2024 08:32:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] EDAC/igen6: Fix conversion of system address to
 physical memory address
Message-ID: <2024081442-pureness-salutary-35ec@gregkh>
References: <20240814061011.43545-1-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814061011.43545-1-qiuxu.zhuo@intel.com>

On Wed, Aug 14, 2024 at 02:10:11PM +0800, Qiuxu Zhuo wrote:
> The conversion of system address to physical memory address (as viewed by
> the memory controller) by igen6_edac is incorrect when the system address
> is above the TOM (Total amount Of populated physical Memory) for Elkhart
> Lake and Ice Lake (Neural Network Processor). Fix this conversion.
> 
> Fixes: 10590a9d4f23 ("EDAC/igen6: Add EDAC driver for Intel client SoCs using IBECC")
> Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
> ---
>  drivers/edac/igen6_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/igen6_edac.c b/drivers/edac/igen6_edac.c
> index 0fe75eed8973..189a2fc29e74 100644
> --- a/drivers/edac/igen6_edac.c
> +++ b/drivers/edac/igen6_edac.c
> @@ -316,7 +316,7 @@ static u64 ehl_err_addr_to_imc_addr(u64 eaddr, int mc)
>  	if (igen6_tom <= _4GB)
>  		return eaddr + igen6_tolud - _4GB;
>  
> -	if (eaddr < _4GB)
> +	if (eaddr >= igen6_tom)
>  		return eaddr + igen6_tolud - igen6_tom;
>  
>  	return eaddr;
> -- 
> 2.17.1
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>


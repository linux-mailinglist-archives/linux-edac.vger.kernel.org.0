Return-Path: <linux-edac+bounces-2426-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158249BB92B
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53739B229CC
	for <lists+linux-edac@lfdr.de>; Mon,  4 Nov 2024 15:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC081C2309;
	Mon,  4 Nov 2024 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="BWiGGxT/"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A6A1C1AA9;
	Mon,  4 Nov 2024 15:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734870; cv=none; b=TxXl1DbAui3jPn4jAl0M2IkNi6cKaAW2KznaKjfqaSXJfPBNbX4YfHoMlUiNPubrgLuJJyhmqQEzwPNnPgievvlzgHmzt3JMFrFZ9RS5rMusBqn2RFp0un0BSSuoOZgkgHf1gXaP49JwbjVtsZfEV6EPwgbTSm3TAyjwwdjTwv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734870; c=relaxed/simple;
	bh=9A9RPgKl5zoWOEsuIm2AVrgPHgnCGrU85x+yX9zGPvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxS+II90jFSfSu2tX+oLJ0jykDjGcPrJp8xdP3XhXHByTR9jRUiuW1DKZ+UajwqDCZrz4FB31aH7Et4b6Fqk3d+u6nTt0rfj3wtHCx+Dbr0nnXi1vaOwDTFGdqtFR/S0gBWnUmebg3uOLD52rDWwfncZ7OIDZQN6gl2+zD3Y+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BWiGGxT/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 121D040E0220;
	Mon,  4 Nov 2024 15:41:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xaUhZK2cZizC; Mon,  4 Nov 2024 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1730734859; bh=3bxlaaoG2vwG1kJdZZGy4iPVYzW/FnFS/OSWMOuDFsk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BWiGGxT/l0w00D+D2NbyGX8W/fZI2QGvl+M8aoY4wvrmiOBOdVF1pUEip3yrgTH7x
	 b+m4sS2o9rqo6zJkVPIyP4GdEsiE4dv2wtUZccaz0rc1pJrbAYdoxtxOeXMxWetQ/Z
	 Li9l//n1ma5UB+q3o0tpit/boFBeLV3of7pFcR49SRbvlb4iirBvbqAC7liAGCX6nX
	 eC7xdYaixhs/FVKGVple2B5H2Ja69wfPwaVFDNpRkikHXcOXQMK9GqZ7N6Ietyfl+Z
	 lzoT1+vuDj8oHsFROAIK42FVgQwQKZX1ZVIk0DqHNgDeNWtaRtCuutOkmtFVrQHAvY
	 Rhn1jV4xwahquPojxuQwHGiFt0NHJfrq7fYdWfa7XXpvp0W8LhrdUf0Eq20cj5CMJC
	 gMvtmIxfT9t+3LJ4M46bMWVlv6awOtW/+AMlMdEqsRB7+ARdohPk0iiCRTuI73XlBP
	 53jDxBnJY3lpEUutFPuvYheS4u/Tiwy+QOSDuqbIqpx5J+JhcggPXuoLwvRCYmq7i5
	 h6wIuy1VySf9mA/jVbfP8ZcGVgUL69/MkYhGgbWUwtfJmjk/4hi9SQL/cMrQtFqmvj
	 BlTuBMLdMTe1x5+nLBzOu3eDeCeag5/cCzxk/zno1xD1c1GkIIKjYvEk7UnhxSMSrl
	 II4c3knFA34pfj+6hvfflxjA=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 70AD740E0261;
	Mon,  4 Nov 2024 15:40:48 +0000 (UTC)
Date: Mon, 4 Nov 2024 16:40:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tero Kristo <tero.kristo@linux.intel.com>
Cc: Ma Ke <make24@iscas.ac.cn>, kristo@kernel.org, tony.luck@intel.com,
	james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
	akpm@linux-foundation.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5 RESEND] EDAC/ti: Fix possible null pointer dereference
 in _emif_get_id()
Message-ID: <20241104154043.GDZyjq-4Kt-IXTrf3y@fat_crate.local>
References: <20240824112643.2143250-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240824112643.2143250-1-make24@iscas.ac.cn>

Hi Tero,

ack/nak?

Is your MAINTAINERS entry for this driver still valid/current or should
I orphan it?

Thx.

On Sat, Aug 24, 2024 at 07:26:43PM +0800, Ma Ke wrote:
> In _emif_get_id(), of_get_address() may return NULL which is later
> dereferenced. Fix this bug by adding NULL check.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 86a18ee21e5e ("EDAC, ti: Add support for TI keystone and DRA7xx EDAC")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202408160935.A6QFliqt-lkp@intel.com/
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v5:
> - According to the developer's suggestion, added an inspection of function 
> of_translate_address(). However, kernel test robot reported a build 
> warning, so the inspection is removed here, reverting to the modification 
> solution of patch v3.
> Changes in v4:
> - added the check of of_translate_address() as suggestions.
> Changes in v3:
> - added the patch operations omitted in PATCH v2 RESEND compared to PATCH 
> v2. Sorry for my oversight.
> Changes in v2:
> - added Cc stable line.
> ---
>  drivers/edac/ti_edac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/edac/ti_edac.c b/drivers/edac/ti_edac.c
> index 29723c9592f7..6f3da8d99eab 100644
> --- a/drivers/edac/ti_edac.c
> +++ b/drivers/edac/ti_edac.c
> @@ -207,6 +207,9 @@ static int _emif_get_id(struct device_node *node)
>  	int my_id = 0;
>  
>  	addrp = of_get_address(node, 0, NULL, NULL);
> +	if (!addrp)
> +		return -EINVAL;
> +
>  	my_addr = (u32)of_translate_address(node, addrp);
>  
>  	for_each_matching_node(np, ti_edac_of_match) {
> @@ -214,6 +217,9 @@ static int _emif_get_id(struct device_node *node)
>  			continue;
>  
>  		addrp = of_get_address(np, 0, NULL, NULL);
> +		if (!addrp)
> +			return -EINVAL;
> +
>  		addr = (u32)of_translate_address(np, addrp);
>  
>  		edac_printk(KERN_INFO, EDAC_MOD_NAME,
> -- 
> 2.25.1
> 
> 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


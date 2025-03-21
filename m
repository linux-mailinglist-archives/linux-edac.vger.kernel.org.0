Return-Path: <linux-edac+bounces-3396-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EED4BA6C4E1
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 22:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ABD0189D146
	for <lists+linux-edac@lfdr.de>; Fri, 21 Mar 2025 21:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF9822FF5E;
	Fri, 21 Mar 2025 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="d7asg/ku"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E813C695;
	Fri, 21 Mar 2025 21:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591552; cv=none; b=MDmN6WPFFlN9LS2eseyd264S8FQZYX6fL8vf1aha2T3yK2y8ODSl9CQS0trXbw8ZHwsGKMb33KGLiEv12efworQfz0FjqAav7+ZcNFyfaeuqLpe53qYy2tDizl7Pr4XPbfSU5I284cpGp8DwSWoqk40PKjzpgogsyccIIhDkIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591552; c=relaxed/simple;
	bh=58tQpMXCYuz6c9zV2an78/FDzvG8eM9WGj+6XWAIb0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alk1GoKnJfEXTWsDSOCHi7ZPTH/OG2zLUPSGmtanP4iZIJths+2jZ0MA8LQRjZnsn5KnlYELzLmVZJZOtiCuRhFvCI4TFoH1obTOS8n2kcy41hk+OMUr0Q0blewt+/TUAdxQwnnTaudZ0GZdZeSIeQcF8ey4BcWCTNV6vhjh5sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=d7asg/ku; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 475F840E016E;
	Fri, 21 Mar 2025 21:12:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TwGYdiLDkuSp; Fri, 21 Mar 2025 21:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1742591541; bh=wvLaISEHPLV7rwcp5L2iCdCO3+xyzE13y0worTvwPkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d7asg/kua3G5KKNGxR4xyHGjyQ2P0mKj6yBjVIWjI/WtnZekikWC+driz6oWr5G4p
	 ScAWsqoqGlS0XicH2JPMOGsNbHlQVrQG9h6B4FfADHZoN2yppyVFuwAo5JXlYlRyTw
	 vVWZDz4Ej0puDKiL4LJy42bZ14OQMwNEoFFfXPgIjiEKpDfALDYbG1fuiRC50eKEE9
	 RCizBvfbfG3GXitVplc32pT+9Qbpnr737rXiGpD1aLK/28IEMoObv15r1/DsjCRM+H
	 U5SyiLFf+xqmciFM8Y7DvaNnG0keoRY0kIu86J/josUjwWgJ3nDSYHCi+xkwafk21f
	 t12j+uOvwCBEf+K1OYSvbGxukQs91eemiy9qDaJVNcpL1AG7kxOyKPUe6tlymBxddw
	 taaRxqEPk2j8vdAk99Uu8MMkLiySiNEw98k9llUvOSoDphNjqPvI3U/Ye3FNjNW6j/
	 GR/kTK/FN9tggenoubRiXiX1lsGqKLyy+rpgzqmfVCvHU1hU30UNvhFt5o21v1uVGt
	 5tTaVUmPt8SiorWhNwaK/0Wpl88cdBilCDeb/9p832lJmuvSE3S0ABIhhP0O1++vvE
	 MY97gkyTRsVy6Qk3JHJuCPf3nqOKmuc2v0ojwLo2PMB4+xe3VJhIR65M/WpMmly6Kz
	 vMVr98gjk7wE4bQlgSkESvRs=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5419C40E0215;
	Fri, 21 Mar 2025 21:12:09 +0000 (UTC)
Date: Fri, 21 Mar 2025 22:12:03 +0100
From: Borislav Petkov <bp@alien8.de>
To: Matthew Gerlach <matthew.gerlach@altera.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dinguyen@kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org
Subject: Re: [PATCH 2/4] EDAC, altera: update driver to reflect hw/yaml
Message-ID: <20250321211203.GEZ93WI8tLaTJTxHmF@fat_crate.local>
References: <20250320164622.6971-1-matthew.gerlach@altera.com>
 <20250320164622.6971-3-matthew.gerlach@altera.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250320164622.6971-3-matthew.gerlach@altera.com>

On Thu, Mar 20, 2025 at 09:46:20AM -0700, Matthew Gerlach wrote:
> The device tree subnodes, and hardware, for the eccmgr are
> the same for Arria10, Stratix10, and Agilex. Update driver
> to allow the subnodes to be allowed for "altr,socfpga-s10-ecc-manager".
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@altera.com>
> ---
>  drivers/edac/altera_edac.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
> index 3e971f902363..895a5beb700f 100644
> --- a/drivers/edac/altera_edac.c
> +++ b/drivers/edac/altera_edac.c
> @@ -1030,6 +1030,9 @@ static int __init __maybe_unused altr_init_a10_ecc_device_type(char *compat)
>  
>  	np = of_find_compatible_node(NULL, NULL,
>  				     "altr,socfpga-a10-ecc-manager");
> +	if (!np)
> +		np = of_find_compatible_node(NULL, NULL,
> +					     "altr,socfpga-s10-ecc-manager");

Please slap a comment above this here - one can see the difference between the
two calls only after staring at them for a couple of minutes and wonder
where's Waldo.

:-P

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


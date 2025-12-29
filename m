Return-Path: <linux-edac+bounces-5588-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B3CE7135
	for <lists+linux-edac@lfdr.de>; Mon, 29 Dec 2025 15:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B61B9300B689
	for <lists+linux-edac@lfdr.de>; Mon, 29 Dec 2025 14:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4594E3148AA;
	Mon, 29 Dec 2025 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UjR2Qpqn"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866B30E0D5;
	Mon, 29 Dec 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767019080; cv=none; b=bAMugYNhK46Fq30957jIJ8befoqhCt0j4kw/I/rzn1H6h4JwMivcd+9X2p+Z4FT9sDtZSoMz+lR0YD0rvv8r6VZyZmTQXjS73K0YB/3lkVM2/aa0SYG3QhIl7hMAef9vG4RKhuo+t+M9KnJpWbMuM8jyHRgb0oMFTitP6MaVygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767019080; c=relaxed/simple;
	bh=P8dqeVN1F8cBKosl/AWIdddYsdZ28EmKtF330R+pTQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjbvwU7r0kQcAnYn+/CbvafGvHu10n9usu4KgaBzzVFy2jN+aoiKrLeothg9UWpU8VuHsCpSBnoyZigeK8i3OXWuqkebKSR4Ar5/TMYnnQWGNNM/Ix2xNS78nq0fCFT3XEqoK9gT4gF87kPs/2Bk3zvkFXT14UxgU+uHDivyjWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UjR2Qpqn; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id B3D4440E00DA;
	Mon, 29 Dec 2025 14:37:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oC99z248IxH2; Mon, 29 Dec 2025 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1767019061; bh=p/1ASW9kMGd6h6Vas5tT7tLYwLzM9407ubXD5p72W14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UjR2QpqnY2TA8/6X1x4kNCHqiV1yxLDJnTN3ulOKFnh1bJqE+6/9IgbYLAxWz5fuI
	 Xta1urqpgcXh6r7QV5xU8ISozX6s8X6WPhz/vRLqRYGSvOgFGy/0NIGbZsN/7DIzTp
	 iOETuiG4yzxHPLXtnyyQW42hqA3ICad31cATbKk7mteShEuvowtnc5wr5DFlRBCKDH
	 NHtCPr57cVTagJ8AEqeK9w3toOH6MJr7GKwAguCBrwiEu7n78HGZZtnZVC3lOGOY2y
	 wRZwN9zV+VzzcNitLmSQti0UcXonEMN/JblWGEYi6f9kA/P1zAWyWIe9mcVSieJMwz
	 n3x408wpUHNIPHSWGXYkNnvf/H28IACz7eoqDjc3x9VFj4hFeDwH5+cVeA4mWDudWw
	 AZjU6AWYRIQIHPOiBPfHkfiK3Gr8MgDrFjlNym0RT7D79OZ+CL45vak/jHvnWhTazH
	 NEOarU7Nv77MMupf6X5ZSAw+QMhJvfDZAALUsN5KgTtqQFvBm60DgBvmwUPsKLCyVI
	 680s2+4zMxw2jOQeGytxrLz3bmMuCQl9IdqWjmmXwvE3L27tu+asO0mdZcypwB+AO1
	 Qk7VrrY5VmSPVn1dYksfqbYhz1sRO8XqaMaj7cDN/LYFhU2V0teWU0zDjhf7COPPie
	 QdB/qdCNFA+JdJSN8uHLLpFU=
Received: from zn.tnic (pd953023b.dip0.t-ipconnect.de [217.83.2.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3AF6F40E0176;
	Mon, 29 Dec 2025 14:37:36 +0000 (UTC)
Date: Mon, 29 Dec 2025 15:37:28 +0100
From: Borislav Petkov <bp@alien8.de>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: Yazen.Ghannam@amd.com, tony.luck@intel.com, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: Remove unneeded semicolon
Message-ID: <20251229143728.GAaVKSKGIAfgWfNDki@fat_crate.local>
References: <20240701072118.846277-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240701072118.846277-1-nichen@iscas.ac.cn>

On Mon, Jul 01, 2024 at 03:21:18PM +0800, Chen Ni wrote:
> Remove unneeded semicolon.
> This is detected by coccinelle.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/ras/amd/atl/denormalize.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ras/amd/atl/denormalize.c b/drivers/ras/amd/atl/denormalize.c
> index 1a525cfa983c..d45ce753e636 100644
> --- a/drivers/ras/amd/atl/denormalize.c
> +++ b/drivers/ras/amd/atl/denormalize.c
> @@ -683,7 +683,7 @@ static int denorm_addr_df4_np2(struct addr_ctx *ctx)
>  	default:
>  		atl_debug_on_bad_intlv_mode(ctx);
>  		return -EINVAL;
> -	};
> +	}
>  
>  	if (ctx->map.num_intlv_sockets == 1) {
>  		hash_pa8	= BIT_ULL(shift_value) & ctx->ret_addr;
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-edac+bounces-1146-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304BF8D1878
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 12:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9D31F21D98
	for <lists+linux-edac@lfdr.de>; Tue, 28 May 2024 10:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B02516ABC3;
	Tue, 28 May 2024 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Wcistosm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFE15E96;
	Tue, 28 May 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716891845; cv=none; b=YBfW2Zg84C89TYkMP+Ma4ZzcfKmJule0/ZBLoCJMCLJXlS2tPaVS7k5oXDfx11+/4Pcftri+Q9y8yyD9bCYVmVFqZx0wqukAGSQ1N717RN1NcROLypEPl7EFebxT7XU3OJJLBsoCzgR+Ghg0Esqkqc4VKQMJKA0mQPT88430yEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716891845; c=relaxed/simple;
	bh=N5h8NlpWPlNnVTdI85jDPN4rMJ5y0qhGDeKWtZCi5jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QVVqczYCmGlVUic/M9RtNZ1SgVdCVOodz9CWzOianSGL+4diLBM7lT2mRqgmJKg6DI9bpNe5FWAhfhy9onbbGLvD4nrwG7YjDcubSOtTmu64dIesgSesenEVZ85zGg59U3mdbxAYaT539WiMitf3ttIQu5DBW2ExAVmH6z8hK6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Wcistosm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 04AE040E01E8;
	Tue, 28 May 2024 10:24:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DPE8oRCBuQIA; Tue, 28 May 2024 10:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1716891837; bh=wJONX+6k5py0XVBsEvCzv/FrIOcoYUG/xN5mpZRNywY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wcistosm5oiiuwhVN6hGkmTB1QCusceK8bJI0zjG+6Y5/UTJmvs40N4CQn8kFHbUe
	 9ebKRU4N129Isx1ak4dO0q4jj9lxoomy9ODm50ltNO1yD9lzbTRUL9q3XnqO4Tp2Qy
	 ccbf/ZSF2hQ+iogA2fuyezvb09iyeYDfmnYkMF6l+dxoLsStNpaLNWBimwWG1ZzGXJ
	 flmN1yxfkrYTQ8uXaCT+zG1pp88Eors8h4JOqk8zNDIn7rj/9BukD7IDlAq673CYtr
	 G+uztpwjYLc+NnvBc7xIXQjsBBEf7U5efahD6xC2RjUkqs69+Htdaej5DeOY6NoRIn
	 rObIhUNdP2tbnon3l5XWTWouuwcXr19/MI6RmxiOA1flhGvV6f0UMjDSsa+Lrb9o5t
	 FJSP8bMdEsCQWMT8XcjEhqufhQvhzZcgS6l7tQLUpN6k7GZB+ygy+6B8PeRYY19aC2
	 mA8FdF1MV2Ey/nOe0TmOmYrUImuifTEaMOlS2AWGsGbvk4pKZ2l3EVA+rFsagFCSLA
	 a45rQ0uD480widsuEcrl953SH0a4S82r4czqFEkggkdtW/3bKhSH7A05eQmGw9bnOr
	 4r4cv9ItBEw6Gg63TdpXM0eIFYss+foXllRet1FD8xeUJ6BGtcx6rekgeYpf94I/zl
	 Z49eHksLMkNG1aQzg8togPS4=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AFF5440E0177;
	Tue, 28 May 2024 10:23:50 +0000 (UTC)
Date: Tue, 28 May 2024 12:23:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: John Allen <john.allen@amd.com>
Cc: linux-edac@vger.kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org, avadhut.naik@amd.com,
	muralidhara.mk@amd.com
Subject: Re: [PATCH v4 4/4] RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization
Message-ID: <20240528102344.GGZlWwsJzibnQfuNYW@fat_crate.local>
References: <20240506154605.71814-1-john.allen@amd.com>
 <20240506154605.71814-5-john.allen@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506154605.71814-5-john.allen@amd.com>

On Mon, May 06, 2024 at 03:46:05PM +0000, John Allen wrote:
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 13), denorm_ctx->current_spa) << 3;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 2;
> +		cs_id |= (hash_pa9 | (hash_pa12 << 1));
> +		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
> +		break;

Newlines after those "break"s pls.

> +	case DF4p5_NPS0_24CHAN_2K_HASH:
> +		cs_id = FIELD_GET(GENMASK_ULL(63, 14), denorm_ctx->current_spa) << 4;
> +		cs_id %= denorm_ctx->mod_value;
> +		cs_id <<= 2;
> +		cs_id |= (hash_pa12 | (hash_pa13 << 1));
> +		cs_id |= hash_pa8 << df_cfg.socket_id_shift;
> +		break;

...

> +static u64 normalize_addr_df4p5_np2(struct addr_ctx *ctx, struct df4p5_denorm_ctx *denorm_ctx,
> +				    u64 addr)
> +{
> +	u64 temp_addr_a = 0, temp_addr_b = 0;
> +
> +	switch (ctx->map.intlv_mode) {
> +	case DF4p5_NPS0_24CHAN_1K_HASH:
> +	case DF4p5_NPS1_12CHAN_1K_HASH:
> +	case DF4p5_NPS2_6CHAN_1K_HASH:
> +	case DF4p5_NPS4_3CHAN_1K_HASH:
> +	case DF4p5_NPS1_10CHAN_1K_HASH:
> +	case DF4p5_NPS2_5CHAN_1K_HASH:
> +		temp_addr_a = FIELD_GET(GENMASK_ULL(11, 10), addr) << 8;
> +		break;

Also linebreaks pls.

Please change this in all your patches.

> diff --git a/drivers/ras/amd/atl/internal.h b/drivers/ras/amd/atl/internal.h
> index 05b870fcb24e..946e36c053c5 100644
> --- a/drivers/ras/amd/atl/internal.h
> +++ b/drivers/ras/amd/atl/internal.h
> @@ -34,6 +34,8 @@
>  #define DF_DRAM_BASE_LIMIT_LSB		28
>  #define MI300_DRAM_LIMIT_LSB		20
>  
> +#define INVALID_SPA ~0ULL

No lazy definitions pls:

drivers/ras/amd/atl/internal.h:37:#define INVALID_SPA ~0ULL
drivers/ras/amd/fmpm.c:119:#define INVALID_SPA  ~0ULL

Unify them.

> +
>  enum df_revisions {
>  	UNKNOWN,
>  	DF2,
> @@ -90,6 +92,44 @@ enum intlv_modes {
>  	DF4p5_NPS1_10CHAN_2K_HASH	= 0x49,
>  };
>  
> +struct df4p5_denorm_ctx {
> +	/* perm_shift: Indicates the number of "lost" bits. This will be 1, 2, or 3. */

No need to repeat the variable name in the comment.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


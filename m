Return-Path: <linux-edac+bounces-354-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0958371A9
	for <lists+linux-edac@lfdr.de>; Mon, 22 Jan 2024 20:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B97A1F32135
	for <lists+linux-edac@lfdr.de>; Mon, 22 Jan 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4CB55C0A;
	Mon, 22 Jan 2024 18:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Vb4fvoUt"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BA40C13
	for <linux-edac@vger.kernel.org>; Mon, 22 Jan 2024 18:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948781; cv=none; b=OmBKNbu1xqXizuYY5fZfj1fjXnhj1DjK/hwuzm8L4F7oFcN96VknIGaSY73Pzn4uGTZ3FFtuHci+TWR5dpN69ob1wzZHwn+P1pkYuXm5FcIVbZe04/LNIxmokdMVi3EaqODXIGVCEnmDUr6caPVSkwi0lQX9gyu+ZvDuTxZXgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948781; c=relaxed/simple;
	bh=NmMh6g6NzITECLV3QkQUjMHowKyOxLoeU0TPC5INBqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWFtYpYiaIATUKEWr4VLf3wYeNi9LOESo1KEyq8zMATpoO5YM4eMIW6Qyu+GqcXOVrO7oKbTXnQFidc85/Ggf6BhR3xtWr0SLfxpFtzLHXM8RP6KED97JhhSYfmoOEESveZ6Fq8168on/9B0z7Ml7L6sTxGi2NY3YKS5KE79Alo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Vb4fvoUt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E36EE40E01B4;
	Mon, 22 Jan 2024 18:39:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id P9e1_InXHIuH; Mon, 22 Jan 2024 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1705948774; bh=3xsbD4E6T4xtoz/CFds0xx9KZ/vj71USi6iuWsmWcmc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vb4fvoUt3Ph91OiZdyqVKLVi1czbT8Q0PcmsUSqvbIsMQcLU/CC8BBNwBiHh7+eor
	 V18LqVdKOBCvvmluPt1DyFN13HuZIHkX3HyT554+J31fr3D0XClqgbaqS1SGqdMbNt
	 ukwr+QF97angequvwL+Xfb14x7m2Z68E9m0jZA+fQQrWXq3XPa49oULTmc8z6wMSm6
	 I6kdF6hXYI+p9oQyWm00wLokAfp/EOiH7t1UMgBeAYk4y4gNA0xaHlq8T9BVjdxrsl
	 dUJQgmDNnBtkJeiISzfk/8wgNMNgWOBkekv+GH0Go1xY7sInMdwvlwMAt43nhiMr3z
	 Dv0nUqr5f2AhDwdG2H5665LxMc5MIFKEWTB038L7G1NhnA/UlcK73X3FfeRuzjzdGD
	 WBUFQ+lCwI+Y1Y7pNRxCfqUBUWn9DLxfZy8byRYYROHbst1bMv2VpU31KVBPwRv/aL
	 O2k/e3jVDAC5nuYLHMk/XWEjui8u/scwaHuYgZ2X/+yQlqWgwwaNLxI6Ok+4qgOO6C
	 WiaU0F8g+3sLKuNbTrrc3Q0fsXjBoZzpjs1MO9T36bkdzY/+PmQktP+9+2CMSezUmh
	 kTnLmudV5lEsyBXaNLLCw2pp2W6pyjQf1X7jgwwzzG9jAdsAMOcN54kjPELBDCIA9/
	 I1vaR/5RSyKMmvp86j0UZpEU=
Received: from zn.tnic (pd953099d.dip0.t-ipconnect.de [217.83.9.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D46240E0177;
	Mon, 22 Jan 2024 18:39:25 +0000 (UTC)
Date: Mon, 22 Jan 2024 19:39:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Cc: linux-edac@vger.kernel.org, git@amd.com, sai.krishna.potthuri@amd.com,
	tony.luck@intel.com, james.morse@arm.com,
	shubhrajyoti.datta@gmail.com, mchehab@kernel.org, rric@kernel.org
Subject: Re: [PATCH v2] EDAC/versal: Make the bits in error injection
 configurable
Message-ID: <20240122183919.GSZa62V4Jepoc1oMcm@fat_crate.local>
References: <20240109102605.31600-1-shubhrajyoti.datta@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240109102605.31600-1-shubhrajyoti.datta@amd.com>

On Tue, Jan 09, 2024 at 03:56:05PM +0530, Shubhrajyoti Datta wrote:
> @@ -734,38 +738,43 @@ static void poison_setup(struct edac_priv *priv)
>  	writel(regval, priv->ddrmc_noc_baseaddr + XDDR_NOC_REG_ADEC15_OFFSET);
>  }
>  
> -static ssize_t xddr_inject_data_poison_store(struct mem_ctl_info *mci,
> -					     const char __user *data)
> +static int xddr_inject_data_ce_store(struct mem_ctl_info *mci, u8 ce_bitpos)
>  {
>  	struct edac_priv *priv = mci->pvt_info;
>  
>  	writel(0, priv->ddrmc_baseaddr + ECCW0_FLIP0_OFFSET);
>  	writel(0, priv->ddrmc_baseaddr + ECCW1_FLIP0_OFFSET);

Why do you need to write 0 if you're going to write the bit positions
below one way or the other?

>  
> -	if (strncmp(data, "CE", 2) == 0) {
> -		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
> +	if (ce_bitpos < ECCW0_FLIP0_BITS) {
> +		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
>  		       ECCW0_FLIP0_OFFSET);
> -		writel(ECC_CEPOISON_MASK, priv->ddrmc_baseaddr +
> +		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
>  		       ECCW1_FLIP0_OFFSET);
>  	} else {
> -		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
> -		       ECCW0_FLIP0_OFFSET);
> -		writel(ECC_UEPOISON_MASK, priv->ddrmc_baseaddr +
> -		       ECCW1_FLIP0_OFFSET);
> +		ce_bitpos = ce_bitpos - ECCW0_FLIP0_BITS;
> +		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
> +		       ECCW0_FLIP1_OFFSET);
> +		writel(BIT(ce_bitpos), priv->ddrmc_baseaddr +
> +		       ECCW1_FLIP1_OFFSET);
>  	}
>  
> -	/* Lock the PCSR registers */
> -	writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> -
>  	return 0;
>  }
>  
> -static ssize_t inject_data_poison_store(struct file *file, const char __user *data,
> -					size_t count, loff_t *ppos)
> +/*
> + * Correctable errors are injected on system Write transaction data by configuring
> + * address mask/match registers to select transactions to have errors,
> + * and by configuring bit flip registers to select how to corrupt write data
> + * (which bits are corrupted).
> + */

Last time I asked:

"Also, the injection algorithm needs to be explained in a comment here,
step by step, and not have people figure out what they need to do by
parsing inject_data_{ce,ue}_store() by foot."

Where is that "step by step" comment explaining the injection algorithm?

> +static ssize_t inject_data_ce_store(struct file *file, const char __user *data,
> +				    size_t count, loff_t *ppos)
>  {
>  	struct device *dev = file->private_data;
>  	struct mem_ctl_info *mci = to_mci(dev);
>  	struct edac_priv *priv = mci->pvt_info;
> +	u8 ce_bitpos;
> +	int ret;
>  
>  	/* Unlock the PCSR registers */
>  	writel(PCSR_UNLOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
> @@ -773,17 +782,101 @@ static ssize_t inject_data_poison_store(struct file *file, const char __user *da
>  
>  	poison_setup(priv);
>  
> +	ret = kstrtou8_from_user(data, count, 0, &ce_bitpos);
> +	if (ret)
> +		return ret;

And you just returned here with PCSR registers unlocked!

WTF?!

Below in inject_data_ue_store() too.

> +
> +	ret = xddr_inject_data_ce_store(mci, ce_bitpos);

That ret is unused.

> +
>  	/* Lock the PCSR registers */
>  	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);
> +	writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);

/me stares at these two lines and tries to see whether they're the
same...

Yes, they are.

You're doing the same thing twice.

I betcha that should be

        writel(1, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
        writel(1, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);

Actually, it should be

        writel(PCSR_LOCK_VAL, priv->ddrmc_baseaddr + XDDR_PCSR_OFFSET);
        writel(PCSR_LOCK_VA_, priv->ddrmc_noc_baseaddr + XDDR_PCSR_OFFSET);

instead of that magic "1".

Any chance you can pay more attention next time when preparing that
patch?

I'll stop here.

Please take your time, sit down and prepare this patch properly. Test it
properly and then, one day later review it yourself to make sure there
are no crap issues like the above. Only *then* you should send it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


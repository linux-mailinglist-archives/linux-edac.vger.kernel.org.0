Return-Path: <linux-edac+bounces-5029-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F3BD571D
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 19:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81D0E4E67DC
	for <lists+linux-edac@lfdr.de>; Mon, 13 Oct 2025 17:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C598E2C11CA;
	Mon, 13 Oct 2025 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OCpbmHRC"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148D12C0287;
	Mon, 13 Oct 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375086; cv=none; b=i7sS4kVWOjyKTPrH7PBff8nuOocFaDa49D+X1tvCmxXZSpYwlNM9zUync7ih4ctKDmP3JVRYo5CWgdfoeEnGA7yH5aPX8Xw1m4eKEC97JRIT8md0UC2FnjudoD7mfUlGsGkcFy2KmMBRMbWZmpqda8cKRR8wASEBU14jBgFz0RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375086; c=relaxed/simple;
	bh=b6/behIC0N9AYnyWJQO3b/gaZ6ZVWKaYugQpKexdV3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3zri5NHV96Sxuy4evXuEyMcxgqpUEIMk/YKlDm/N9XfILBPGHZd/qwsuVf96C9XQGlS3dX9uPzAZtCsL2nDOWLUMl4eF+Adaryt0ulAQrGjU7WXPbvQdDMxa3IpWBnoCcs9gaIt2GliOTZCtTz6gsuoVKILS+M5F3mj8U6Bllk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OCpbmHRC; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5C2B440E01AB;
	Mon, 13 Oct 2025 17:04:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id SI2MVTdOG49B; Mon, 13 Oct 2025 17:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760375075; bh=ONlzIiZek01uXKZ8RYgShEp2LZyBnZc0grZS16TouzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCpbmHRCP1v5Ov6JEJ/uky9mIEixLfJSZ8g4gWUuLyGS1xUhGe8cYQGOZJbubbfFU
	 ZNu77UkgDPt57JHBTRe5u0IOHnRa4tWsQ50y752dgn8+cUbF/CM8EFKIHWxUIEMSIZ
	 8ZIXI5IdWnbyAy+6Kv6VkmZKbU9w1VwJrLctY/kgrNaJkiLrrYq+9cjZ/+Jd9Z7ykq
	 ienyg3TFaYpliRR0CSxsC1uv937i/9u12x1zJBMDKaNOs9BG3cgVOCrhS7osdRAzWc
	 Sdx1QENj4HMMo+nZaCAQ7q0RX8Ot9+ibovlT+7mkRYkyBxxF+qddbWYZ2LgiCWNPxf
	 Zqt4AtliiWkETW03GRyXrd4Ipnl0bk22xIw+Dlh/baHEgDi/hOdA59zlCa0Ygina3L
	 nE8sbM/OBwzYwynTX7pUrxmYZbo4yuCGQHULu0ffo9kMhzwKGNgfjJc9HE2IFLdTAF
	 v11IB9SCCWYFQ2BccAnLMHllDA55kGhW+HNe92PiWpc7r2eL3ROl9GAyEbRxToQuaY
	 gVbtpvoeROk1F1hUlebQRVaHJb4weVbRAXjEGfsvwPBwZZcZLrx/3La3P4b2IPJF8H
	 ZAD/nWw/fO1855WzBMMN9xjEeZgnR9TvOfVlofa017wX+cGTPFEQ+iJh6KlR41kWHF
	 OruJuM8TttnHuibrqSb7Q8Wc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 37B6240E019B;
	Mon, 13 Oct 2025 17:04:29 +0000 (UTC)
Date: Mon, 13 Oct 2025 19:04:23 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Tony Luck <tony.luck@intel.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] EDAC/versalnet: Fix off by one in handle_error()
Message-ID: <20251013170423.GEaO0xF48HklVENi05@fat_crate.local>
References: <aNfX-qj_KpCrnCUy@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aNfX-qj_KpCrnCUy@stanley.mountain>

On Sat, Sep 27, 2025 at 03:26:34PM +0300, Dan Carpenter wrote:
> The priv->mci[] array has NUM_CONTROLLERS so this > comparison needs to
> be >= to prevent an out of bounds access.
> 
> Fixes: d5fe2fec6c40 ("EDAC: Add a driver for the AMD Versal NET DDR controller")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/edac/versalnet_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/versalnet_edac.c b/drivers/edac/versalnet_edac.c
> index 7c5db8bf0595..1ded4c3f0213 100644
> --- a/drivers/edac/versalnet_edac.c
> +++ b/drivers/edac/versalnet_edac.c
> @@ -433,7 +433,7 @@ static void handle_error(struct mc_priv  *priv, struct ecc_status *stat,
>  	phys_addr_t pfn;
>  	int err;
>  
> -	if (WARN_ON_ONCE(ctl_num > NUM_CONTROLLERS))
> +	if (WARN_ON_ONCE(ctl_num >= NUM_CONTROLLERS))
>  		return;
>  
>  	mci = priv->mci[ctl_num];
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


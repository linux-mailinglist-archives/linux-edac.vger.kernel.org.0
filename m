Return-Path: <linux-edac+bounces-5260-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FAC1C977
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B00E56419D
	for <lists+linux-edac@lfdr.de>; Wed, 29 Oct 2025 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3824D3376A3;
	Wed, 29 Oct 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="QrPntXzj"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA33B33B6FF;
	Wed, 29 Oct 2025 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761758679; cv=none; b=bEjW3XLO1z34mcrbfrhS5k14r+NPQnaN/Aeh7B0e0OjxrhU0aXwPUaBgauucIQUWR6Bkhe8ktjJAbjZYqbK2PNLygQMPaZZkvLcF8F3UqF26EYPJpcK//B1dJoihWhrLTai1r30nOeapch2PykKttLGscPpHPm6xgdu8w3RgH8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761758679; c=relaxed/simple;
	bh=ml62RTcwJQcVcY1YIw3Li/hjlYxo6TN7z08zfWL0XXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEt1niuvjIFRWhU7z91p0reaYcfwecjLY+OMDP9KMXWL9bmBLAIPtUAZmKj1mwexj88ufXcpMDRHq2KGAydBLqWXzmtyYvDlyP6bKTpb/pqUtUXUba2Mz7TVo1I/1T4MnIiC597f4Yl/LhqqgZTp1WUmvSzlg5aiIfPZnfNtA4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=QrPntXzj; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5EB2740E0225;
	Wed, 29 Oct 2025 17:24:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id p3IC36XRQCpI; Wed, 29 Oct 2025 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761758670; bh=a/+6LNiRu1DlYCHQd/RYBWALLkaVEWIO3d3etSvLgYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QrPntXzjRTTVHxS7EVupekXVKqNepWZ5vhJCncpsn7B2vl+j4RAyXTkWLYUDO/gnO
	 /rXbSjOeowWV8YKb/ayJmywKW/Ev/WqIgCy7EreT7B6ACtwvpz5QS0Dem7clTOaPut
	 8e7UaYak1OkEJtx8w1W1StEcvLhlCRUVIZ7y8qEeHjsnhYTXNDD+RPqBUvhP+fd6/s
	 qRb65LfMktisPFMuvP77WecxlPwurMopB717XROYSeRlYxBihkYcyBR79uaefesQoy
	 0sMpMz1yBSaP62Y8hUIn8cHaazgTwsCNRADdimstAUB28BWNeIclS3b0WNrqyO2KlC
	 BqQ25YSVk7vgtRfgelGcak57HHryJ++BvMsaB2pc2oBLv1GsJcKFkgO8lIlpJmQHl6
	 E379RiWelk/0CGJRoneb9Jm53yVgxsoGbriBw/Kv9AL1oZYyQQJZtAXi7MaTLdbYEZ
	 o0g4pfyv11IsQ3kjjUBIJ4fSH4oTtNkafclT0Q5YUgRNtQgtZ3JY97oPujE1VKeyJQ
	 VUaOBp8PelxWoKBrh6X7Z7ieIIF4NoI9OzXEzIxGulKgJyh1ILWCaQChWRPqFBY9WS
	 pqs1BYBEjoDYwDbq3Eq+sFxGtAlXBGAGuDNI3P89VZjp22cTK9OpXwQG8AjLZNMVR3
	 k27cgig6qmsnZq3ypKQwVTJ4=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 23D8B40E021A;
	Wed, 29 Oct 2025 17:24:25 +0000 (UTC)
Date: Wed, 29 Oct 2025 18:24:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Avadhut Naik <avadhut.naik@amd.com>,
	Greg KH <gregkh@linuxfoundation.org>
Cc: linux-edac@vger.kernel.org, yazen.ghannam@amd.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] EDAC/mc_sysfs: Begin deprecating legacy sysfs EDAC
 interface
Message-ID: <20251029172419.GGaQJNw4Pofl1x1mve@fat_crate.local>
References: <20251013173632.1449366-1-avadhut.naik@amd.com>
 <20251013173632.1449366-5-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013173632.1449366-5-avadhut.naik@amd.com>

+ Greg to tell us whether that would be a proper deprecation strategy.

On Mon, Oct 13, 2025 at 05:30:43PM +0000, Avadhut Naik wrote:
> The legacy sysfs EDAC interface has been made obsolete more than a decade
> ago through the introduction of a new per-DIMM interface.
> 
> The legacy interface however, hasn't been removed till date.
> 
> Begin deprecating it so that it can eventually be removed by v6.21.
> 
> Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
> ---
>  drivers/edac/Kconfig         |  2 +-
>  drivers/edac/edac_mc.h       |  5 +++++
>  drivers/edac/edac_mc_sysfs.c | 16 ++++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 39352b9b7a7e..fdfeba848114 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -25,7 +25,7 @@ if EDAC
>  
>  config EDAC_LEGACY_SYSFS
>  	bool "EDAC legacy sysfs"

Add "DEPRECATED: EDAC ..."

here.

> -	default y
> +	default n
>  	help
>  	  Enable the compatibility sysfs nodes.
>  	  Use 'Y' if your edac utilities aren't ported to work with the newer
> diff --git a/drivers/edac/edac_mc.h b/drivers/edac/edac_mc.h
> index 881b00eadf7a..78b49d6906fd 100644
> --- a/drivers/edac/edac_mc.h
> +++ b/drivers/edac/edac_mc.h
> @@ -95,6 +95,11 @@ do {									\
>  
>  #define to_mci(k) container_of(k, struct mem_ctl_info, dev)
>  
> +static inline void deprecate_interface(void)
> +{
> +	pr_warn_once("NOTICE: The legacy EDAC sysfs interface has been deprecated and will be removed by v6.21. Please switch to the new interface!\n");
> +}

You don't need to have a function which you replicate everywhere. Simply dump
this notice once...

edac_create_sysfs_mci_device:

	...

#ifdef CONFIG_EDAC_LEGACY_SYSFS

<--- here.

        err = edac_create_csrow_objects(mci);
        if (err < 0)
                goto fail;
#endif

So that it gets issued and hopefully someone sees it.

Then, I'd say around 6.19 we should make those functions return an error
unconditionally and then zap them in 6.21.

That is, if no one comes crawling out of the woodwork with a valid use case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


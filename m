Return-Path: <linux-edac+bounces-4712-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C86FB3ED00
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 19:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F6175971
	for <lists+linux-edac@lfdr.de>; Mon,  1 Sep 2025 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83CBA320A1A;
	Mon,  1 Sep 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ul8GqDOm"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B155D31B131;
	Mon,  1 Sep 2025 17:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756746488; cv=none; b=LRZq4ltICfdE1BVJ0nkI5TgtB0G2gwHOcz3Y4wPrml5G93BDZcYbJznu5BbgHgWw9Ht0L0wMn08Y1RPK4uRn/i+xjjeyV852NVR8pozBCRbEJOJgdrjwbCS7+yVjr/oh6W9qZ5PD4ZA+mFiZWFyDZNeXAkCKvyUUzI7XUn/mfB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756746488; c=relaxed/simple;
	bh=05Hdr82iF1YbIXKusbymYUz7cecOqRa7CtYfnzMwAoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hc1jQnVBxP3MJYrcR8AtGQVUvQbbayD/68AeQ2zZhWAX6BdXaIkUyoNENs9fjBDQDnTmXyvPF85tS/fBEKP42UPgkV0s6yvCaEkyY9kmT6W8qwNBP5FbYbGIYIS21jy7rWFcNJSu9zYV75BvREuMXgJRZl30/SRFvgWaFPt2lwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Ul8GqDOm; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3D0AE40E01AC;
	Mon,  1 Sep 2025 17:08:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2hKTeMwDrfZW; Mon,  1 Sep 2025 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756746480; bh=76b814HQAo2YQibVwpnqtCh1BEw+zBblQWabG+FEBkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ul8GqDOmQk2KMx4yZ1AR3byMLjTnDUVGW/cZ1lF3L6Lid/sdMpWN7BLFYuuTi1a3o
	 jA8lmg8xGHWVYhEmSwvdmhtsqt29lY7+PCMn7egm3odAVCGGX5UDC4OqrQAB3LrX6C
	 0rSCt+9KlyWHzxmrJ2eRGsnlT23gwUInlP7BsqxmivcdWyHiCxi07fnN9/EVUhbkHK
	 86rKoX1NUjhxSsJR6sIoV57JEmAlITzHCERbdLFXsx/WwulNcFUjl+rKLxqGVrZ75L
	 dAPSCGbUgKXJcziId+fshXDjFaD/7nwuoEQkQz7djdun2RVZI079TcUT+IJaE6dSZo
	 73+Il+EQB6DTn/x3tOIDMI1IUkVkVJ81VUy5Ki5bbvzuqt1LIrl5ic0owckhdLZplk
	 QOZ2Lo2R7IblW/nh+qhcY/UxlrsRELaZ7E7n5AolDqGPRNz1Cw3KYGr55WthOx6ZOJ
	 n+8kTgVArVknA96tWQvLw2eqpKVcZJfutHfS+/VqHEzggttpT+ZeTp/mE1NL0e7L+v
	 qbGvFGAnG/i6SvkiOSzC/D0LaRst4L3rGbFcEdWP9+xeQM39+YUp1OKqu3xTOrOz7v
	 6EfZZp6V7SAcRrewN2P0DH+sTAttSH2B6eVk1xr/pwPDwPcABaeXoWEr3faPUD+/ZE
	 EAkZJIKZTBVSOHXcGXBmEVyc=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E7EC940E01A3;
	Mon,  1 Sep 2025 17:07:49 +0000 (UTC)
Date: Mon, 1 Sep 2025 19:07:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 07/20] x86/mce: Reorder __mcheck_cpu_init_generic()
 call
Message-ID: <20250901170741.GCaLXS3bUdUPksnMs8@fat_crate.local>
References: <20250825-wip-mca-updates-v5-0-865768a2eef8@amd.com>
 <20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250825-wip-mca-updates-v5-7-865768a2eef8@amd.com>

On Mon, Aug 25, 2025 at 05:33:04PM +0000, Yazen Ghannam wrote:
> Move __mcheck_cpu_init_generic() after __mcheck_cpu_init_prepare_banks()
> so that MCA is enabled after the first MCA polling event.
> 
> This brings the MCA init flow closer to what is described in the x86 docs.
> 
> The AMD PPRs say
>   "The operating system must initialize the MCA_CONFIG registers prior
>   to initialization of the MCA_CTL registers.
> 
>   The MCA_CTL registers must be initialized prior to enabling the error
>   reporting banks in MCG_CTL".
> 
> However, the Intel SDM "Machine-Check Initialization Pseudocode" says
> MCG_CTL first then MCi_CTL.
> 
> But both agree that CR4.MCE should be set last.
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> ---
> 
> Notes:
>     Link:
>     https://lore.kernel.org/r/52a37afe-c41b-4f20-bbdc-bddc3ae26260@suse.com
>     
>     v4->v5:
>     * New in v5.
> 
>  arch/x86/kernel/cpu/mce/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 0326fbb83adc..9cbf9e8c8060 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -2272,9 +2272,9 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
>  
>  	mca_cfg.initialized = 1;
>  
> -	__mcheck_cpu_init_generic();
>  	__mcheck_cpu_init_vendor(c);
>  	__mcheck_cpu_init_prepare_banks();
> +	__mcheck_cpu_init_generic();

With that flow we have now:

	1. MCA_CTL
	2. CR4.MCE
	3. MCG_CTL

So this is nothing like in the commit message above and the MC*_CTL flow is
not what the SDM suggests and CR4.MCE is not last.

So what's the point even here?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


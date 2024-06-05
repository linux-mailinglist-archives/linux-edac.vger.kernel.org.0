Return-Path: <linux-edac+bounces-1185-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 891FC8FC820
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 11:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C68281898
	for <lists+linux-edac@lfdr.de>; Wed,  5 Jun 2024 09:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92705190079;
	Wed,  5 Jun 2024 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Q0X4M8qE"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2FA1946A2;
	Wed,  5 Jun 2024 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717580470; cv=none; b=NMGjPYH5sVFkpFEDjKOKTOkksszS+RigmeJxfK5tPM3SkwkRaPnk7WIjp6kHr/JD80oPuSju6km4EDMmKpvUP+1Dti7ypbQcGHbERASfLJ9enfPu0/VIog4H6tMoLmUOnBIv99z39THuVPuLIGpsdM+seP3he4L4UXIRQB7dN0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717580470; c=relaxed/simple;
	bh=3pFN4DdyhUddI2WsBSs6ZHdT32cRg56t+mxrmyj9eMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HYONezAPMoStjjRlaDFqHt8J6apYkUNsaHQzSv/NoawETktEAZR7Xf+4W41bhJ2g9zKO6786ps5ko9P3egXZMvKA2kWuoUPYS4vVosHor6BYlgxFJyiV9JphnAs2uO3ScspnxdShpsARiI9revNpvEFmVwJ9L6xhQu3fHI1FoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Q0X4M8qE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A714D40E0176;
	Wed,  5 Jun 2024 09:41:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id foKaUzSCcBWp; Wed,  5 Jun 2024 09:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717580458; bh=cM/V5hgwuNE0tUg8bDOJAW/Hl7YJwCejQy9zIz/wTmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q0X4M8qEQHd7QpxGSWH8nb/7KxuA7OusxSHmVkXe6Bge3+qNXTM5bBpdAnnpPWG/1
	 BXmiFJPvSPJ5E93OyyLPiY1O3UlMEcvPhYdQgTHIZ2RIVIssbiJXP/sosXDxSVCfgm
	 6cqI+n1Xcx6AasNpBXgqirg+vFm/HazTlG3sD+wNCeWEhra5nP73/F4IXKTEqgPbgD
	 qKmTg3zWWXYwr4/lPaMqySyhIznxUDXiSaTbsYs5aZdbq6hYwIrUokZJFz9Jyxqc8i
	 pIDiA8/1UGCy8cYwLHaCwrqmNHOHjLImdo2sKOxzGvGq1j/KkKeOwMP02uewx5scsU
	 Bmr0asMWXtXIi37EX0NdCczxqkINR5UYrOUiwqoCFuLRSHORKielzFj9UNIeSkKVZi
	 KM5p0uu4WW7NTnsOewG0p8lyJ1zbm71auQOynTMeEWbbMHlbjIOa5FeDNCduu1dIwd
	 HSKcKjgGB5tSsiRJDzgYTu5h7Dso1kYba5Xor+zowZpRcgPbjZ5lDTj0nUXzbSml7z
	 EYcxQxo1xNvvT0CnA8MP5s35Pt/qx02Sic7DXnqDd9jQQ4B0YKCkg4U7htOTj2ruJO
	 Kq1f+teJ0O/3xX9JUrm2dJS3BnIlRDXlWZRLH+lFJV7zykf1gyFZZL4I4dmtSNWzYv
	 vp6rTFhBWIHa+whkNMjETiWE=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6C8540E0184;
	Wed,  5 Jun 2024 09:40:52 +0000 (UTC)
Date: Wed, 5 Jun 2024 11:40:51 +0200
From: Borislav Petkov <bp@alien8.de>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RAS/AMD/ATL: add missing MODULE_DESCRIPTION() macro
Message-ID: <20240605094051.GDZmAyo1-j_uBri_YO@fat_crate.local>
References: <20240604-md-ras-amd-atl-v1-1-d4eb3cf3abe4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604-md-ras-amd-atl-v1-1-d4eb3cf3abe4@quicinc.com>

On Tue, Jun 04, 2024 at 07:21:59PM -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/ras/amd/atl/amd_atl.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/ras/amd/atl/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ras/amd/atl/core.c b/drivers/ras/amd/atl/core.c
> index 6dc4e06305f7..7be4982fdf19 100644
> --- a/drivers/ras/amd/atl/core.c
> +++ b/drivers/ras/amd/atl/core.c
> @@ -222,4 +222,5 @@ static void __exit amd_atl_exit(void)
>  module_init(amd_atl_init);
>  module_exit(amd_atl_exit);
>  
> +MODULE_DESCRIPTION("AMD Address Translation Library");
>  MODULE_LICENSE("GPL");
> 
> ---

Applied, thanks.

Btw, I'd suggest instead of sending those piecemeal-wise, one per
driver, just group them all by subsystem and whatnot so that each
maintainer can pick it up and this new thing modpost decided to complain
about, can be taken care of without noodling through each driver
one-by-one.

Better yet: do a coccinelle patch and convert the whole tree.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


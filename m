Return-Path: <linux-edac+bounces-1735-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0D96094F
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 13:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3C41C229FA
	for <lists+linux-edac@lfdr.de>; Tue, 27 Aug 2024 11:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0736B1A00F8;
	Tue, 27 Aug 2024 11:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IlVEJDit"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADFF158D9C;
	Tue, 27 Aug 2024 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759543; cv=none; b=eL9Dy/mvcrG/kJGjcjmVqPctmiLKIGsUBfokaNzkA3sImLpxH/BRCVL0que40qdRnWbeMj3YxhFfsT8XiybWYI30zJNwYz4OPJSLpspmmUajhIHs0de3HrJFG8JO1mLQenhlo0M78U2c1WEbZaeGl1qoevn5/gSz2ST8uyHo1Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759543; c=relaxed/simple;
	bh=J+qScYQFIhcO3sueINm5ThU7Ol4ugLxkpEe0/BhH8ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F33fiE6Xden7y01dvhS6NMsG+5Ryx8+ehiQOOOFXMrBEx/2LwiU/n94kNNNWsohb09QYSD1HtQIeuWsKyBiHeSHnD23fBfDzwIBzBeZbseFSNRyrAGZxveC2Hcjc3LWyrnBytDIaciYTgphzIayrd3i8OwHljTDiClm89PO7N3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IlVEJDit; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8FB5240E01C5;
	Tue, 27 Aug 2024 11:52:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v9mpIUU2S2BT; Tue, 27 Aug 2024 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1724759533; bh=LGaw2lZ3cyh+M3lg7t2gKWCCI7xSUNeCGodqRe631Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlVEJDitNaBky6qouSeM/VwXgaGgwp0RSsZrcTVVY8VLk5gGN+KUo4QAfqZNxlwT3
	 OoX56E68EaHCxifJAwObuqklp1p26eB1uLVof7luuNaQnijTfVp9yzvlCaBZfP+CJb
	 p+HWu3CvumB0aQOLDOdx/KX0NL4tWHLKuhXWHQCeA/IbSqGnTMENPRWVUzkXSoit5a
	 XR5eZZlhnotdlBNBQ9N0MHap3BUzxbpDFo7cbWNUpXZJb3CptoEUPTrx/ucGLYERO+
	 NlHti2RsJVMgfs/7M2EzmUtk9aKfApN0uu8yfONFPL54TSjojvFD7GvLsKWKbJerBb
	 KjxOvxiy1Tq8yejA4HdawSIULOI9nC1Kl1/n1KlZ80Wf4kLWlxwCfrEUpzShs7KyFf
	 1xjiA46uMwEsriKO8zBwH5UOWlDw5bmCE+nW7oN6p7v9cXtuj4wTL41Kibb/wpB1PL
	 ZLHrhJ04M2j/qryUkiUfpIH3liSCKe7daT+fS8X4tbcgaPRTrPx8LJ0CyxKGBbpdDN
	 H3d2P69smNqMg2aEGlmvBNqOG66cNgJwXtYixtpt1fjh0ydryBcRzHuisu3kOHjozD
	 4KPLTHll/M0kgKH8mmED5i4pOJLcGj0O0eWL5jrD9VQaid+aRijToT4UFj1c5LLrmS
	 6jc/teImaiyIbdwxhFi7W5ds=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A970D40E0169;
	Tue, 27 Aug 2024 11:52:02 +0000 (UTC)
Date: Tue, 27 Aug 2024 13:51:55 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ma Ke <make24@iscas.ac.cn>, Tero Kristo <tero.kristo@linux.intel.com>
Cc: kristo@kernel.org, tony.luck@intel.com, james.morse@arm.com,
	mchehab@kernel.org, rric@kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v5] EDAC/ti: Fix possible null pointer dereference in
 _emif_get_id()
Message-ID: <20240827115155.GAZs292_OMQUMgThya@fat_crate.local>
References: <20240816052021.378832-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240816052021.378832-1-make24@iscas.ac.cn>

+ the driver's maintainer.

On Fri, Aug 16, 2024 at 01:20:21PM +0800, Ma Ke wrote:
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

I'll drop Reported-by: kernel test robot <lkp@intel.com> since you've returned
to the previous v3 variant.

Leaving in the rest for reference.

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


Return-Path: <linux-edac+bounces-3238-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACEBA49958
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681483BD949
	for <lists+linux-edac@lfdr.de>; Fri, 28 Feb 2025 12:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4242E25E471;
	Fri, 28 Feb 2025 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LW8G5IiU"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DBB1C3BE3;
	Fri, 28 Feb 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740745867; cv=none; b=adlg7JVUDbpce6/XJ6kAd28uKAj1cxPtDBiV13ONtLXNcERJU5YZDyYr0O+3laERUv8HHSbclpxL9d7AON+iiTz4tWcVk1dz2nplXWaqbgzwGrg4KdZIJDIALFpWOnOvlr1HZ5wG0cZPCgNAJF8Mm/3HqVCQUBkOFqqtj376jz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740745867; c=relaxed/simple;
	bh=r2c2ds+im2KVngQ+wPBePTSasLJJBhMTPncvWUV1fvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuv/ohs/kppqhmumcjk4etYCKYZkQGg++8h+UMLHtMNw+Oq8miSBtixtpmjcruN1iMt18TX+6mDQ+Iwl1NIHvCVxBn5Ki9MC0Uifudf4K+MFaGzKB1vwhvt/1eIT25VLyzpK+f39GwqThDzmQgc91xwDPkkUEAex/eZpO9e6wXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LW8G5IiU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C328D40E01C5;
	Fri, 28 Feb 2025 12:30:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 3LAbmteOTNDI; Fri, 28 Feb 2025 12:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740745850; bh=Oaem8TWfePC1oa0JtmcAIlbj4yyiam0PCotHwgEjOKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LW8G5IiUSkJYaQw2wNtP26uDTtzrfV5igyicCoFkmJ5LarLC2leJ4TNs0zmI+TSft
	 c8G+ORtxW5u6cRi/qmgWSDaj0GVgkujqDf1gBgkntZS9NS88ZbpGGcSdCgyy7jRv6k
	 ZOqYlbVxfWAUh6SAh475dWXvUhKlSw4eoonkDROqzLVVRIb1Nac7UbyhQAL1D76uH+
	 cVgc2oI5qdbh9xjjySkf8GVB/iNYE/EoCY9Q2b31BaRdYHdxTKR6LGs8/Zk6Slj1Nc
	 4wmTz/bq1eh5CAsEEzM+7qzbEil8kcSGPhvoQeLEykx+nAOgtRf4V6DRgqdjBYm0Jc
	 6Ob9MhPzlJAO7+r0RPr/iNBooYRzpHQD55sCc9bQNZYCF+mgFQH+wiFA6Wr/MpI7oh
	 I94i+N96bT4yvIkzDJyq4z8yMBt7g7uroVoZcHRsq7LPMDIjwoATLMbYSNmcl5vSEz
	 iigxpnV/ySD5igSauBPINmAqfGxaEh8Ej9trr+wferwZaUP0/L6SZJryurtCzqFkaH
	 FeIZmnxpCArSb8zBsQW/Kgb8IXNk9Pke/icA2x7hAfkwda+pD5dZVXopbyb/zBBDie
	 Bq2B+d634bczIVoDxZD6IpqSKAHRNwYsEDF8Tndu0j009+k9QI8SPgn2x2mN3d9zJ4
	 jncH6JfrL57gAhyWfYa08pKU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E50040E015F;
	Fri, 28 Feb 2025 12:30:41 +0000 (UTC)
Date: Fri, 28 Feb 2025 13:30:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>, Tony Luck <tony.luck@intel.com>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: Simplify return statement in dct_ecc_enabled()
Message-ID: <20250228123035.GBZ8Gsa0Xkis4B-xsj@fat_crate.local>
References: <20250201130953.1377-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250201130953.1377-2-thorsten.blum@linux.dev>

On Sat, Feb 01, 2025 at 02:09:54PM +0100, Thorsten Blum wrote:
> Simplify the return statement to improve the code's readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/edac/amd64_edac.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 8414ceb43e4a..1f106b4fafdf 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -3355,10 +3355,7 @@ static bool dct_ecc_enabled(struct amd64_pvt *pvt)
>  
>  	edac_dbg(3, "Node %d: DRAM ECC %s.\n", nid, (ecc_en ? "enabled" : "disabled"));
>  
> -	if (!ecc_en || !nb_mce_en)
> -		return false;
> -	else
> -		return true;
> +	return ecc_en && nb_mce_en;
>  }
>  
>  static bool umc_ecc_enabled(struct amd64_pvt *pvt)
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


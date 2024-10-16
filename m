Return-Path: <linux-edac+bounces-2108-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDDB9A1015
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 18:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 687F61F22EE9
	for <lists+linux-edac@lfdr.de>; Wed, 16 Oct 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46198212624;
	Wed, 16 Oct 2024 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZykOCSMP"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7B210C1B;
	Wed, 16 Oct 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729097457; cv=none; b=Y0oXtvQ5S9cohVkIsmSaqE1ag4UeCLDKRUU8BeKdaXvhaYSLqolLGb5sMTD6EDz9Kh9w7znu2xz/f7HQdQjDdta4OzSmDZXHjVmBnX27sTLqBB9QAW6tSzHeL4rDhtDAHwlh66KtTZCwvSOYJoJ/yk5mgJW84j/J1+mvYzmGIv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729097457; c=relaxed/simple;
	bh=tfI7QpcNCKNiWH+e+1YOnRXTDGhlNLgQ4iq2eb1E3Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tToIjp52EnUGX/gW07sCLSU7RmxnlI7k80lrbJiBrjM03fxMuudGpEIKR7wxKww5uz2W/5SP0UJhtEd2/jiftt7zY7nogyZ26Hjy+N3X3jp5TqLbhA8G/OzsBDbNcBxX/YVWPenDY82yfgE6q26Bg+nA2EY0ArznVYhZfX5B3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZykOCSMP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1509340E021A;
	Wed, 16 Oct 2024 16:50:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DK232OyMbJtU; Wed, 16 Oct 2024 16:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729097441; bh=G5HYsSFD4XcBrQ45Eyvcw7tx2J3K+k8JgYOOEbztQmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZykOCSMP0jMhjyqyMuuUUUy7ANw40Cghp9SRkPx4cbqxT2yyS7vEOlglkg5CJwYhy
	 IbapMIBQkkQvsfIjILKxcuxmJA4OIxpOZ80FVJBpg1uz1yrtkWeqDDEJg+c3JXEodB
	 EiHn+oUHTVQKAFwoWBa55fGrv4KFJ2e5gKclEU1+Y3jLv+DpClO03LUqFkNS3uG9qY
	 BwjJlwkKZNra9gFsn0d80q5FEAy3cjyzIKNbVdz8uBEdnrKz2XCue4EO5NfQVIdSSH
	 H53j9FxkoOV5co2Ld1LRsh+JQfDlneD9pmpF865dzEtGXxX+Dhwpq8OgjX5VMQrcA4
	 Bc+y4H5p2X1cjwCdzkfG6UMCGooceXPWsAJ8/ohJwLOcL4njxV0zoN7veixV1kIfAY
	 tUpFD6V8GipFMmmOCr1PrAgfNU6FSzgbO7ppxeIrhP9zxBeFeGE09C29xhGQsaCFm6
	 jXFgVVvdCaLbqt2ajiHHrIH62vnq1dFkOUJb28FgKKcfPjqARUtB3VKR/R59TYTPgq
	 JhRBJ3J1TIpbbX0QuxkI+w879GL8l952DQd5hlfegFLmZy6k+RtBoXU/rJJMs+QdEJ
	 OCK5RZgf+phv08SI3qzgrKTr9yQJtDAE2zDEQrOkVO/fnPMKDCk2mCgOIEqDCuVqOV
	 RHNaHWNCOUDJb/cU8ruJqUow=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A3AC140E0263;
	Wed, 16 Oct 2024 16:50:33 +0000 (UTC)
Date: Wed, 16 Oct 2024 18:50:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Thompson <davthompson@nvidia.com>
Cc: tony.luck@intel.com, james.morse@arm.com, mchehab@kernel.org,
	rric@kernel.org, linux-edac@vger.kernel.org, shravankr@nvidia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 RESEND] EDAC/bluefield - fix potential integer overflow
Message-ID: <20241016165027.GTZw_u0wpcd48VwbMA@fat_crate.local>
References: <20240930151056.10158-1-davthompson@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240930151056.10158-1-davthompson@nvidia.com>

On Mon, Sep 30, 2024 at 11:10:56AM -0400, David Thompson wrote:
> The 64-bit argument for the "get DIMM info" SMC call consists of
> "mem_ctrl_idx" left-shifted 16 bits and OR-ed with DIMM index.
> With "mem_ctrl_idx" defined as 32-bits wide the left-shift operation
> truncates the upper 16 bits of information during the calculation
> of the SMC argument. The "mem_ctrl_idx" stack variable must be
> defined as 64-bits wide to prevent any potential integer overflow,
> i.e. loss of data from upper 16 bits.
> 
> Fixes: 82413e562ea6 ("EDAC, mellanox: Add ECC support for BlueField DDR4")
> Reviewed-by: Shravan Kumar Ramani <shravankr@nvidia.com>
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
>  drivers/edac/bluefield_edac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/bluefield_edac.c b/drivers/edac/bluefield_edac.c
> index 5b3164560648..0e539c107351 100644
> --- a/drivers/edac/bluefield_edac.c
> +++ b/drivers/edac/bluefield_edac.c
> @@ -180,7 +180,7 @@ static void bluefield_edac_check(struct mem_ctl_info *mci)
>  static void bluefield_edac_init_dimms(struct mem_ctl_info *mci)
>  {
>  	struct bluefield_edac_priv *priv = mci->pvt_info;
> -	int mem_ctrl_idx = mci->mc_idx;
> +	u64 mem_ctrl_idx = mci->mc_idx;
>  	struct dimm_info *dimm;
>  	u64 smc_info, smc_arg;
>  	int is_empty = 1, i;
> -- 

Is this something you're hitting in real workloads so that it needs to go to
stable or is it rather something caught through code review or so?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


Return-Path: <linux-edac+bounces-1172-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6528D8860
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 20:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4261C21CD7
	for <lists+linux-edac@lfdr.de>; Mon,  3 Jun 2024 18:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA4B136E1D;
	Mon,  3 Jun 2024 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="VEsXIV2u"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C57135A46;
	Mon,  3 Jun 2024 18:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717437866; cv=none; b=XAq1Snz04eZ3f8pT2Tah514+MflnoKAb1gHP2T2BCSMgwOSf9xs7WcFBU+8Lwf0Si6xepJawStHqnlS3tvTBG2igDJBiTlheVoY9kusXNSjJvqBS8rzWWb1yg4CnIomMCafqiuXGoxnPq9jz8lwwY0L75WBKJsOUkDY/8+iXiXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717437866; c=relaxed/simple;
	bh=iSLvysiHpIUDNB9sp98jI6aLd04HDr3RBKBhJUiy1Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlvVvwZcgETFF3HCGCulPxRnxO42b7tvkoFU32O9ojXVabBiuYng/W/A9O8tM818Ap3WelENzh49wwOS2IbNfEYKlUzqOJ+fzUj54iJ0mBJiIN06U9MuGl4OTi/guQqbOvOUg73SEDSucC7lKEd2YmZm21G8g+rqRUDA+5odE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=VEsXIV2u; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 23CF940E016A;
	Mon,  3 Jun 2024 18:04:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id II8VaZrWSY0M; Mon,  3 Jun 2024 18:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717437857; bh=1Wz3be5zoCCkseKFccounPGdkg1wa4c11aRuLRVcct8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VEsXIV2uc8AXhKfe1xqjW5vdvg+EuA8mkdYDyZVkWCsCIUmMZS5RQgB8s2SmMfXDk
	 3cVsJ4Uiq0eNZkAkkH6jkvd8sbm90VL2UOQRrB5KBiJilh1dXGmVat4TnHTv0HS0Zn
	 vJbbZtQaIKPjZ1LVrJznZm8jWxoUdDIFJulG8JpW/dqA7ryvlASHY8LL2j+ml5hdda
	 GLQDRIei/130IYh52YjOAc0NA1w7etpO+qVMjEJOKai89OSAZSCeVahE+9ushd2pCz
	 LgTOk4GErCw30HyoQWmOS/tErwxwhG3zxKKQBtO/ExveIjyquAMK5Y11If6AoTlOnQ
	 VJEhSzl4DUdLrlHx5XlWZQgc/RsvOYqr3XjHovPCV3PcPFEYM9nSsqHGOjRYqYt54u
	 WYqPEPQLo77VUeCgT4jb5uOLGB13gD7ryBEIKVJZMWRSZoe9ZVJ4G4lSzwXXEpzFBA
	 HNbdx8QdL5hUdYoJ8tJTdBnRbLNI4F+ttVTuX4NClR/rJj6SuX7pm0AIOSdZpztIWX
	 OHGVr0hFGPwob6Tgzhm9dXOlfETks/Iyq/osoezvv0lEaWouLp+AZPadB5cew3HVxJ
	 86ZYC2yy68oQF4yHtCJXRejfZuEZzUcsayBh/tkowJRTMvUlE/x6/7Zxn5hyXsKrvF
	 uMd04d1sUthvPkdkjza5OKjk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 239E340E00C9;
	Mon,  3 Jun 2024 18:04:10 +0000 (UTC)
Date: Mon, 3 Jun 2024 20:04:09 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, avadhut.naik@amd.com,
	john.allen@amd.com
Subject: Re: [PATCH 6/9] x86/mce: Unify AMD THR handler with MCA Polling
Message-ID: <20240603180409.GPZl4FmUZhYJHmcj2I@fat_crate.local>
References: <20240523155641.2805411-1-yazen.ghannam@amd.com>
 <20240523155641.2805411-7-yazen.ghannam@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523155641.2805411-7-yazen.ghannam@amd.com>

On Thu, May 23, 2024 at 10:56:38AM -0500, Yazen Ghannam wrote:
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 58b8efdcec0b..d6517b93c903 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -660,6 +660,12 @@ static noinstr void mce_read_aux(struct mce *m, int i)
>  	}
>  }
>  
> +static void reset_thr_limit(unsigned int bank)
> +{
> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> +		return amd_reset_thr_limit(bank);
> +}
> +
>  DEFINE_PER_CPU(unsigned, mce_poll_count);
>  
>  static bool ser_log_poll_error(struct mce *m)
> @@ -769,6 +775,8 @@ void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  			mce_log(&m);
>  
>  clear_it:
> +		reset_thr_limit(i);

	if (mca_cfg.thresholding)
		reset_thr_limit(i);

and then you don't have to do a vendor check but simply set
mca_cfg.thresholding on AMD after having defined it in the patch.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


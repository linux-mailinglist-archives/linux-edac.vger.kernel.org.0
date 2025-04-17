Return-Path: <linux-edac+bounces-3572-lists+linux-edac=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-edac@lfdr.de
Delivered-To: lists+linux-edac@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9ACA91BC0
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 14:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0A419E0FF5
	for <lists+linux-edac@lfdr.de>; Thu, 17 Apr 2025 12:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D460221C168;
	Thu, 17 Apr 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="YOs0mQPB"
X-Original-To: linux-edac@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A694B1DE883;
	Thu, 17 Apr 2025 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892215; cv=none; b=hI0T/kfDWmYQwbOPBbOCykYKox2Fg3jnwf2ssnOAan92olP1XVinBypK9Dy97l7hkz6XAKXXKkPZTZKfYtqlKyih9zkC7uZEsA/d6XLd3oOPnduvGkmBDYw2CMN64jJOMLD9ae5khEhqEqyu8wKS8lnPGqcCH7C51fPweTI0dGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892215; c=relaxed/simple;
	bh=BKpue1V0Sgd6BpeJVDYlO2s0+kyfQoXF6anpbOlkUbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6Tm4BGVThLRILcP0u04pxq3+Woxo/emzpQJOM0/UfbbBfgQfkG69C31Q4fuc1B44Wr9ZyxpXD9b0PLOWmML5WhfxjmnA0BRx27exKa0boksp1jUZF/4u8ojLe050CTbOWDPR5k+spS0o0ndEzGQkuTTIy6Dr7WXqt3xfdTkEIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=YOs0mQPB; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5141A40E0200;
	Thu, 17 Apr 2025 12:16:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pyyy_CUboGJK; Thu, 17 Apr 2025 12:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1744892204; bh=OkPJNLQNaBgHBD7+vM9R4BzDcQAcht9Q91uQ60sTI2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YOs0mQPB0rVfjTJ5Joae5B47WeFtzEcS7I7oH5zZ1gVo3rqAiKpNqCdVt/o6RWrx2
	 QEVb5hc2inNQsNlGOvGwhtJQE2ewH9q96w6N6aCfXAXBu9j21RLbWsxozsqa9jRyjZ
	 36uLxGsU1TLuDbNUQI5lcN0g4MJmQnMMYM/mFoQnVOsBJ3Q8omDbw9HDAXdwMChWtd
	 4kEAXHR6qU1k3mAl5L3Dr5CzEq6qFLFIyPuioAG4DJwSRycVh5dqoh8rYeD4PGbTIy
	 3GhecoeNm1JR7RQIK6At93E6olQzb7IeHCmKALSsynz2Ypjh/F3acIIvTVbMGAEjtE
	 tcCZffkLNf47Cygj1gRkiFzPL8vmi9vBe4lgXoiJlOnpM2dd69Vs7o4Qykqnt79J4m
	 tmPaDANsjUOrQ0CKUoelf8z5Z3QY1ztH/oopqhXB/d/BR0u6fu0jdhORTqJlVBHJiu
	 X7+gLF0TZ07P4MkrrqlUpM66NaEv/qI048SIQG3V89runhGMIjInzrauNOs2LZ8MIr
	 Led2bzRSKIA63JuQqM8wuSO+dhf/8WcACQefT5jk2Bs2CFqrvCgeyHnT+Q8SNEoJvs
	 yQ5sUewNZ+fbZJqEkVsDof9TFzBMnZOeOhvKhlylsMJF86Emibh18E6AkpTOqAZoYM
	 Sn5D0r5WyocbjnNfSIQ1sHyI=
Received: from zn.tnic (p579690ee.dip0.t-ipconnect.de [87.150.144.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7348840E01FF;
	Thu, 17 Apr 2025 12:16:37 +0000 (UTC)
Date: Thu, 17 Apr 2025 14:16:31 +0200
From: Borislav Petkov <bp@alien8.de>
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: x86@kernel.org, Tony Luck <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: Re: [PATCH v3 10/17] x86/mce: Separate global and per-CPU quirks
Message-ID: <20250417121631.GPaADxHwT-OrriCFU5@fat_crate.local>
References: <20250415-wip-mca-updates-v3-0-8ffd9eb4aa56@amd.com>
 <20250415-wip-mca-updates-v3-10-8ffd9eb4aa56@amd.com>
Precedence: bulk
X-Mailing-List: linux-edac@vger.kernel.org
List-Id: <linux-edac.vger.kernel.org>
List-Subscribe: <mailto:linux-edac+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-edac+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250415-wip-mca-updates-v3-10-8ffd9eb4aa56@amd.com>

On Tue, Apr 15, 2025 at 02:55:05PM +0000, Yazen Ghannam wrote:
>  /* cpu init entry point, called from mce.c with preempt off */
>  void mce_amd_feature_init(struct cpuinfo_x86 *c)
>  {
> @@ -656,6 +678,7 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
>  	u32 low = 0, high = 0, address = 0;
>  	int offset = -1;
>  
> +	amd_apply_quirks(c);

<---- newline here.

>  	mce_flags.amd_threshold	 = 1;
>  
>  	for (bank = 0; bank < this_cpu_read(mce_num_banks); ++bank) {

...

> @@ -2255,6 +2223,8 @@ void cpu_mca_init(struct cpuinfo_x86 *c)
>  
>  	if (cap & MCG_SER_P)
>  		mca_cfg.ser = 1;
> +
> +	__mcheck_cpu_apply_quirks(c);

Right, this is not a per-CPU init function anymore but a one-time thing and
called only here so put its contents here and whack it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

